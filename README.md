# Slonig - Backend

Backend of the Slonig App. Slonig is an open-source, free-to-use web platform that helps teachers encourage more student interaction during lessons. You can find more information about the project and a list of other components of the app at https://github.com/slonigiraf/slonig

## Getting Started

Depending on your operating system and Rust version, there might be additional packages required to compile this template.
Check the [Install](https://docs.substrate.io/install/) instructions for your platform for the most common dependencies.

### Build

Use the following command to build the backend without launching it:

```sh
cargo build --release
```

### Development Chain

The following command starts a single-node development chain that doesn't persist state:

```sh
./target/release/node-template --dev
```

To purge the development chain's state, run the following command:

```sh
./target/release/node-template purge-chain --dev
```

To start the development chain with detailed logging, run the following command:

```sh
RUST_BACKTRACE=1 ./target/release/node-template -ldebug --dev
```

Development chains:

- Maintain state in a `tmp` folder while the node is running.
- Use the **Alice** and account as default validator authorities.
- Are preconfigured with a genesis state (`/node/src/chain_spec.rs`) that includes several prefunded development accounts.


To persist chain state between runs, specify a base path by running a command similar to the following:

```sh
// Create a folder to use as the db base path
$ mkdir my-chain-state

// Use of that folder to store the chain state
$ ./target/release/node-template --dev --base-path ./my-chain-state/

// Check the folder structure created inside the base path after running the chain
$ ls ./my-chain-state
chains
$ ls ./my-chain-state/chains/
dev
$ ls ./my-chain-state/chains/dev
db keystore network
```

### Connect with Slonig Frontend

After you start the node template locally, you can interact with it using the hosted version of the [Slonig](https://app.slonig.org/apps/#/explorer?rpc=ws://localhost:9944) front-end by connecting to the local node endpoint.

### Docker

Example docker-compose.yml
```
version: '3'

services:
  ws-parachain-1:
    image: slonig-dev
    container_name: slonig-dev
    user: "1000:1000"
    restart: unless-stopped
    volumes:
      - slonig-dev:/data
    ports:
      - 30333:30333 # p2p port
      - 9933:9933 # rpc port
      - 9944:9944 # ws port
    environment:
      - VIRTUAL_HOST=some.org
      - VIRTUAL_PORT=9944
      - LETSENCRYPT_HOST=some.org
      - LETSENCRYPT_EMAIL=some@gmail.com
    expose:
      - 9944
    command: [
      "/usr/bin/node-template",
      "--dev",
      "--base-path", "/data",
      "--name", "ws-parachain-1",
      "--rpc-external",
      "--rpc-cors", "all"
    ]

volumes:
  slonig-dev: {}

networks:
  default:
    external:
      name: nginx-proxy
```