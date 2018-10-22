package order_test

import (
	"fmt"
	"log"
	"math/rand"
	"testing"
	"time"

	"github.com/go-redis/redis"
	. "github.com/onsi/ginkgo"
)

var _ = Describe("Order", func() {

})

var (
	testClient    *redis.Client
	maxCount      = 100000
	orderListName = "BITOETH_ACTION_QUEUE"
	batchAmount   = 50
)

func init() {
	testClient = redis.NewClient(&redis.Options{
		Addr:         ":6379",
		DialTimeout:  10 * time.Second,
		ReadTimeout:  30 * time.Second,
		WriteTimeout: 30 * time.Second,
		PoolSize:     10,
		PoolTimeout:  30 * time.Second,
		// PoolTimeout: -1,
	})
	testClient.FlushDB()
}

func TestRpush(t *testing.T) {
	rpush(testClient)
	log.Println(testClient.LLen(orderListName))
}

func rpush(client *redis.Client) {
	log.Println("rpush")

	r := rand.New(rand.NewSource(time.Now().UnixNano()))

	for i := 0; i < maxCount; i++ {
		isBuy := r.Intn(2)
		price := r.Int63n(1000000000) + 1
		amount := r.Int63n(100) + 1

		order := fmt.Sprintf("%d|3939889|[%d,0,%d,%d]", 9527+i, isBuy, price, amount)
		client.RPush(orderListName, order)
	}
}

func TestPipelineRPush(t *testing.T) {
	pipelineRpush(testClient)
	log.Println(testClient.LLen(orderListName))
}

func pipelineRpush(client *redis.Client) {
	log.Println("pipelineRpush")

	pipeliner := client.Pipeline()

	r := rand.New(rand.NewSource(time.Now().UnixNano()))

	for i := 1; i <= maxCount; i++ {
		isBuy := r.Intn(2)
		price := r.Int63n(1000000000) + 1
		amount := r.Int63n(100) + 1

		order := fmt.Sprintf("%d|3939889|[%d,0,%d,%d]", 9527+i, isBuy, price, amount)

		pipeliner.RPush(orderListName, order)

		if i%batchAmount == 0 {
			if _, err := pipeliner.Exec(); err != nil {
				panic(err)
			}
		}

	}
}

func TestPipelinedRPush(t *testing.T) {
	pipelinedRpush(testClient)
	log.Println(testClient.LLen(orderListName))
}

func pipelinedRpush(client *redis.Client) {
	log.Println("pipelinedRpush")

	r := rand.New(rand.NewSource(time.Now().UnixNano()))

	x := 0
	for i := 1; i <= maxCount/batchAmount; i++ {
		_, err := client.Pipelined(func(pipeliner redis.Pipeliner) error {

			for j := 0; j < batchAmount; j++ {
				isBuy := r.Intn(2)
				price := r.Int63n(1000000000) + 1
				amount := r.Int63n(100) + 1
				// log.Println(i)
				x++
				order := fmt.Sprintf("%d|3939889|[%d,0,%d,%d]", 9527+x, isBuy, price, amount)
				pipeliner.RPush(orderListName, order)
			}
			return nil
		}) //pipelined

		if err != nil {
			panic(err)
		}

	}
	// log.Println(x)
}

func TestPipelineLPop(t *testing.T) {
	pipelineRpush(testClient)

	log.Println(testClient.LLen(orderListName))

	pipelineLPop(testClient)

	log.Println(testClient.LLen(orderListName))

}

//LPOP pipeline
func pipelineLPop(client *redis.Client) {
	log.Println("pipelineLPop")

	pipeliner := client.Pipeline()
	var err error

	for i := 1; i <= maxCount; i++ {

		pipeliner.LPop(orderListName)

		if i%batchAmount == 0 {
			if _, err = pipeliner.Exec(); err != nil {
				panic(err)
			}
		}
	}

}

func TestPipelineLPopLoop(t *testing.T) {
	pipelineRpush(testClient)
	log.Println(testClient.LLen(orderListName))
	pipelineLPopLoop(testClient)
	log.Println(testClient.LLen(orderListName))
}

//BLPOP pipeline Loop
func pipelineLPopLoop(client *redis.Client) {

	log.Println("pipelineBLPopLoop")

	pipeliner := client.Pipeline()
	var err error
	var orders []redis.Cmder

	for {

		for j := 0; j < batchAmount; j++ {
			pipeliner.LPop(orderListName)
		}

		if orders, err = pipeliner.Exec(); err != nil {
			// panic(err)
			log.Println(err)
			time.Sleep(3 * time.Second)
		}

		log.Println(orders)
	}

}

func TestPipelineBLPop(t *testing.T) {
	pipelineRpush(testClient)
	log.Println(testClient.LLen(orderListName))
	pipelineBLPop(testClient)
	log.Println(testClient.LLen(orderListName))
}

//BLPOP pipeline
func pipelineBLPop(client *redis.Client) {
	log.Println("pipelineBLPop")

	pipeliner := client.Pipeline()
	var err error
	// var orders []redis.Cmder

	for i := 1; i <= maxCount; i++ {

		pipeliner.BLPop(0, orderListName)

		if i%batchAmount == 0 {
			if _, err = pipeliner.Exec(); err != nil {
				panic(err)
			}
		}
	}

	// log.Println(orders)
}

func TestPipelineBLPopLoop(t *testing.T) {
	pipelineRpush(testClient)
	log.Println(testClient.LLen(orderListName))
	pipelineBLPopLoop(testClient)
	log.Println(testClient.LLen(orderListName))
}

//BLPOP pipeline Loop
func pipelineBLPopLoop(client *redis.Client) {

	log.Println("pipelineBLPopLoop")

	pipeliner := client.Pipeline()
	var err error
	var orders []redis.Cmder

	for {

		for j := 0; j < batchAmount; j++ {
			pipeliner.BLPop(0, orderListName)
		}

		if orders, err = pipeliner.Exec(); err != nil {
			// panic(err)
			log.Println(err)
		}

		log.Println(orders)
	}

}

// TODO: test cluster
