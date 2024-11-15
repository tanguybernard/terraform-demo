## Hyperledger



### Tuto

https://medium.com/zeeve/how-to-create-a-permissioned-blockchain-with-hyperledger-besu-564f75bfc3d9



## Install


mkdir IBFT-Network
cd IBFT-Network
mkdir -p node1/data node2/data node3/data node4/data


vi ibftConfigFile.json


    {
        "genesis": {
        "config": {
        "chainId": 1337,
        "berlinBlock": 0,
        "ibft2": {
        "blockperiodseconds": 2,
        "epochlength": 30000,
        "requesttimeoutseconds": 4
        }
        },
        "nonce": "0x0",
        "timestamp": "0x58ee40ba",
        "gasLimit": "0x47b760",
        "difficulty": "0x1",
        "mixHash": "0x63746963616c2062797a616e74696e65206661756c7420746f6c6572616e6365",
        "coinbase": "0x0000000000000000000000000000000000000000",
        "alloc": {
        "fe3b557e8fb62b89f4916b721be55ceb828dbd73": {
        "privateKey": "8f2a55949038a9610f50fb23b5883af3b4ecb3c3bb792cbcefbd1542c692be63",
        "comment": "private key and this comment are ignored.  In a real chain, the private key should NOT be stored",
        "balance": "0xad78ebc5ac6200000"
        },
        "627306090abaB3A6e1400e9345bC60c78a8BEf57": {
        "privateKey": "c87509a1c067bbde78beb793e6fa76530b6382a4c0241e5e4a9ec0a0f44dc0d3",
        "comment": "private key and this comment are ignored.  In a real chain, the private key should NOT be stored",
        "balance": "90000000000000000000000"
        },
        "f17f52151EbEF6C7334FAD080c5704D77216b732": {
        "privateKey": "ae6ae8e5ccbfb04590405997ee2d52d2b330726137b875053c36d94e974d162f",
        "comment": "private key and this comment are ignored.  In a real chain, the private key should NOT be stored",
        "balance": "90000000000000000000000"
        }
        }
        },
        "blockchain": {
        "nodes": {
        "generate": true,
        "count": 4
        }
        }
    }

Generate node keys and a genesis file

    besu operator generate-blockchain-config --config-file=ibftConfigFile.json --to=networkFiles --private-key-file-name=key


Copy genesis

    cp networkFiles/genesis.json ../IBFT-Network/


Cp node Key

    cp -a networkFiles/keys/<0x firstKey>/. node1/data/
    cp -a networkFiles/keys/<0x 2Key>/. node2/data/
    cp -a networkFiles/keys/<0x 3Key>/. node3/data/
    cp -a networkFiles/keys/<0x 4Key>/. node4/data

Start First Node

    cd node1
    besu --data-path=data --genesis-file=../genesis.json --rpc-http-enabled --rpc-http-api=ETH,NET,IBFT --host-allowlist="*" --rpc-http-cors-origins="all"


Copy enode node 1
enode://f26fb150ea360e2fe2d484d4a2f473d9c74f9f1a03238f68db32d7885ed946bb18319fcff22a4e43485266968586543a1d2803482be2fd1bceacce839a306652@127.0.0.1:30303

Node address 0x4b6f90c71e124a5ca1863f964f0f0b98a0ffd74a

Node 2 :

    besu --data-path=data --genesis-file=../genesis.json --bootnodes=enode://f26fb150ea360e2fe2d484d4a2f473d9c74f9f1a03238f68db32d7885ed946bb18319fcff22a4e43485266968586543a1d2803482be2fd1bceacce839a306652@127.0.0.1:30303 --p2p-port=30304 --rpc-http-enabled --rpc-http-api=ETH,NET,IBFT --host-allowlist="*" --rpc-http-cors-origins="all" --rpc-http-port=8546

Node3

    besu --data-path=data --genesis-file=../genesis.json --bootnodes=<Node-1 Enode URL> --p2p-port=30305 --rpc-http-enabled --rpc-http-api=ETH,NET,IBFT --host-allowlist="*" --rpc-http-cors-origins="all" --rpc-http-port=8547

besu --data-path=data --genesis-file=../genesis.json --bootnodes=enode://f26fb150ea360e2fe2d484d4a2f473d9c74f9f1a03238f68db32d7885ed946bb18319fcff22a4e43485266968586543a1d2803482be2fd1bceacce839a306652@127.0.0.1:30303 --p2p-port=30305 --rpc-http-enabled --rpc-http-api=ETH,NET,IBFT --host-allowlist="*" --rpc-http-cors-origins="all" --rpc-http-port=8547


Node4


besu --data-path=data --genesis-file=../genesis.json --bootnodes=enode://f26fb150ea360e2fe2d484d4a2f473d9c74f9f1a03238f68db32d7885ed946bb18319fcff22a4e43485266968586543a1d2803482be2fd1bceacce839a306652@127.0.0.1:30303 --p2p-port=30306 --rpc-http-enabled --rpc-http-api=ETH,NET,IBFT --host-allowlist="*" --rpc-http-cors-origins="all" --rpc-http-port=8548


Confirm Four Validators


curl -X POST --data '{"jsonrpc":"2.0","method":"ibft_getValidatorsByBlockNumber","params":["latest"], "id":1}' http://localhost:8545



Add a fifth node

mkdir -p node5/data

cd node5

besu --data-path=data --genesis-file=../genesis.json --bootnodes=enode://f26fb150ea360e2fe2d484d4a2f473d9c74f9f1a03238f68db32d7885ed946bb18319fcff22a4e43485266968586543a1d2803482be2fd1bceacce839a306652@127.0.0.1:30303 --p2p-port=30307 --rpc-http-enabled --rpc-http-api=ETH,NET,IBFT --host-allowlist="*" --rpc-http-cors-origins="all" --rpc-http-port=8549


Copy address Node5 (found on logs)


    2024-11-15 21:39:14.121+01:00 | main | INFO  | DefaultP2PNetwork | Node address 0xf413356a9ca1879913c4b6849fb53651ba1f357f

Or with command

    cd node5
    besu --data-path=data public-key export-address


Propose adding new validator


    curl -X POST --data '{"jsonrpc":"2.0","method":"ibft_proposeValidatorVote","params":["0xf413356a9ca1879913c4b6849fb53651ba1f357f", true], "id":1}' http://127.0.0.1:8545


Repeat with node 2 and 3


    curl -X POST --data '{"jsonrpc":"2.0","method":"ibft_proposeValidatorVote","params":["0xf413356a9ca1879913c4b6849fb53651ba1f357f", true], "id":1}' http://127.0.0.1:8546
    ...


Verify new validator

    curl -X POST --data '{"jsonrpc":"2.0","method":"ibft_getValidatorsByBlockNumber","params":["latest"], "id":1}' http://127.0.0.1:8545


The list of validators contains 5 addresses now.


Remove validators  (same with false as second params)


    curl -X POST --data '{"jsonrpc":"2.0","method":"ibft_proposeValidatorVote","params":["0xf413356a9ca1879913c4b6849fb53651ba1f357f", false], "id":1}' http://127.0.0.1:8545
    curl -X POST --data '{"jsonrpc":"2.0","method":"ibft_proposeValidatorVote","params":["0xf413356a9ca1879913c4b6849fb53651ba1f357f", false], "id":1}' http://127.0.0.1:8546
    curl -X POST --data '{"jsonrpc":"2.0","method":"ibft_proposeValidatorVote","params":["0xf413356a9ca1879913c4b6849fb53651ba1f357f", false], "id":1}' http://127.0.0.1:8547








Pour vérifier les soldes d'un compte

    curl -X POST http://127.0.0.1:8545 \
    -H "Content-Type: application/json" \
    -d '{
    "jsonrpc": "2.0",
    "method": "eth_getBalance",
    "params": ["0xf17f52151EbEF6C7334FAD080c5704D77216b732", "latest"],
    "id": 1
    }'




## Metamask

### 1. Add Network

- Name : local test
- RPC URL: http://localhost:8545/
- ChainID: 1337
- Currency: ETH


### 2. Import account

1. Add account or hardware wallet
2. import account
3. Enter test account private key (from genesis.json) (add "0x" before)
4. Another account to execute a transaction from account1 to account2
5. Send, Confirm


source: https://raihanhd.medium.com/hyperledger-besu-developer-quickstart-4-create-a-transaction-using-metamask-cf81b2760918

### Cmd


Obtenir des informations sur une transaction dans Besu

    curl -X POST --data '{"jsonrpc":"2.0","method":"eth_getTransactionByHash","params":["0x0e4dea8ead6eafdb9ed960339d3cc959eb3cd4cce0392c2afe372ecfa5b1b0a6"],"id":1}' http://localhost:8545