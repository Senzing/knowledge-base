# aws-ecs tuning


## File to SQS

### SQS ingestion using stream-producer json-to-sqs

- Rate = messages queued per second

| Rate | producer threads | mem_limit | cpu_limit | internal queue |
|-----:|-----------------:|----------:|----------:|---------------:|
|  170 |                4 |       4GB |       512 |             50 |
|  280 |                8 |       8GB |      1024 |             50 |
|  375 |                8 |      16GB |      2048 |             50 |
|  380 |               16 |      16GB |      2048 |             50 |
|  385 |               16 |      30GB |      4096 |             50 |
|  385 |               30 |      30GB |      4096 |             50 |


### SQS ingestion using stream-producer json-to-sqs-batch

| Rate | producer threads | mem_limit | cpu_limit | internal queue |
|-----:|-----------------:|----------:|----------:|---------------:|
| 1700 |               16 |      16GB |      2048 |            200 |

## SQS to Senzing engine using stream-loader

- Rate = messages inserted per second

| Rate | loader threads | mem_limit | MemoryUtilization | cpu_limit | CPUUtilization | DB capacity | DB CPU |
|-----:|---------------:|----------:|------------------:|----------:|---------------:|------------:|-------:|
|   20 |              4 |      16GB |               16% |      2048 |            23% |           8 |    25% |

## References

### AWS Console

1. [cloudwatch](https://console.aws.amazon.com/cloudwatch/home)
    1. [log groups](https://console.aws.amazon.com/cloudwatch/home?#logsV2:log-groups)
1. [ecs](https://console.aws.amazon.com/ecs/home)
1. [rds](https://console.aws.amazon.com/rds/home?#databases:)

### AWS documentation

1. [Monitoring Amazon ECS](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/ecs_monitoring.html)
1. [Invalid CPU or memory value specified](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/task-cpu-memory-error.html)