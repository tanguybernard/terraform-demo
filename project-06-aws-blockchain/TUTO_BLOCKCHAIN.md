


https://chiheb-nexus.github.io/ethereumpoa/

https://hackernoon.com/create-a-private-ethereum-blockchain-with-proof-of-authority-consensus-mechanism-a-how-to-guide-x71y34pi


1. Init dossier

mkdir test_poa # Créer un nouveau dossier
$> cd test_poa
$> mkdir node1 node2



2. Creer compte


    geth --datadir node1/ account new
    geth --datadir node2/ account new


3. save passwords

       echo -n "node1 password" > node1/password
       echo -n "node2 password" > node2/password

4. Init noeud avec le genesis en remplacant les address

Utiliser le genesis.json :


Note : Ajouter plus de gas au depart.

    {
    "config": {
    "chainId": 9999,
    "homesteadBlock": 1,
    "eip150Block": 2,
    "eip150Hash": "0x0000000000000000000000000000000000000000000000000000000000000000",
    "eip155Block": 3,
    "eip158Block": 3,
    "byzantiumBlock": 4,
    "clique": {
    "period": 3,
    "epoch": 30000
    },
    "terminalTotalDifficultyPassed": true
    },
    "nonce": "0x0",
    "timestamp": "0x5b0d504f",
    "extraData": "0x00000000000000000000000000000000000000000000000000000000000000002d299ed001270f8c2f02abdda2bda4e5b4cca348bbb6abec9f9b6d0e7d3ff18bcb68ce6ac931478f0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
    "gasLimit": "0x47b760",
    "difficulty": "0x1",
    "mixHash": "0x0000000000000000000000000000000000000000000000000000000000000000",
    "coinbase": "0x0000000000000000000000000000000000000000",
    "alloc": {
    "0x96D0933ef112b1D4820dC172177aD94d879FdbFF": {
    "balance": "500000000000000000000000"
    },
    "0x13F7342a41f2B0463dee1D3011a481F208f5dD68": {
    "balance": "250000000000000000000000"
    }
    },
    "number": "0x0",
    "gasUsed": "0x0",
    "parentHash": "0x0000000000000000000000000000000000000000000000000000000000000000"
    }


Command:

    geth --datadir node1/ init genesis.json
    geth --datadir node2/ init genesis.json


5. créons un boot.key

       bootnode -genkey boot.key

6. Execution du boot

       bootnode -nodekey boot.key -verbosity 9 -addr :30310

7. Et dans une autre terminale, exécutons le noeud n°1:


    geth --datadir node1/ --syncmode 'full' --port 30311 --http --http.addr 'localhost' --http.port 8501 --http.api 'personal,eth,web3,txpool,miner' --bootnodes 'enode://4a778acb1d2db932d65e73b9c17dd6c479a1972e12f171b62074b3a38d7d40906fc2e26bce4f19a0e6f4edba820f2373d2fb669f056f6b83f18644674a5179fe@127.0.0.1:0?discport=30310' --networkid 9999 --unlock '0x96D0933ef112b1D4820dC172177aD94d879FdbFF' --password node1/password --mine --allow-insecure-unlock


8. noeud 2

Oui mais pas IPC :



    geth --datadir node2/ --syncmode 'full' --networkid 9999  --http --http.port 8502 --http.addr 'localhost' --authrpc.port 8552 --unlock "0x13F7342a41f2B0463dee1D3011a481F208f5dD68" --password node2/password --mine --allow-insecure-unlock --port 30304 --bootnodes "enode://4a778acb1d2db932d65e73b9c17dd6c479a1972e12f171b62074b3a38d7d40906fc2e26bce4f19a0e6f4edba820f2373d2fb669f056f6b83f18644674a5179fe@127.0.0.1:0?discport=30310" --ipcdisable


Test 2 Ok avec IPC

    geth --datadir node2/ --syncmode 'full' --port 30312 --http --http.addr 'localhost' --http.port 8502 --http.api 'personal,eth,web3,txpool,miner' --bootnodes 'enode://4a778acb1d2db932d65e73b9c17dd6c479a1972e12f171b62074b3a38d7d40906fc2e26bce4f19a0e6f4edba820f2373d2fb669f056f6b83f18644674a5179fe@127.0.0.1:0?discport=30310' --networkid 9999 --unlock '0x13F7342a41f2B0463dee1D3011a481F208f5dD68' --password node2/password --mine --allow-insecure-unlock --authrpc.port 8552



Ne pas oublier de changer les bootnodes



9. Attacher la console js

la :

    geth attach node1/geth.ipc 

ou 

    geth attach 'http://localhost:8501'