# /poster/blockchain-poster - Floflis' blockchain-writer-suite

This Bash script is designed to send custom HEX messages to a given Ethereum address using the Ethereum Go tool "ethereal".

## Usage

```bash
./script.sh <msg_file-path> <eth_address> --network <evm_network>
```

- `<msg_file-path>`: Path to the .txt file containing the HEX message.
- `<eth_address>`: Ethereum address to send the HEX message to.
- `<evm_network>`: the name of the EVM network/blockchain to use (currently available: `polygon` and `polygonzkevm`)

## Prerequisites

- Ethereum Go tool "ethereal" must be installed.
- Local Ethereum wallet must be unlocked.

## Steps

1. Read the HEX contents of the file.
2. Send the HEX contents to the specified ETH address using ethereal.
3. Unlock the local wallet and sign to send the message.

## Example

```bash
./script.sh message.txt 0x1234567890...abcdef --network polygonzkevm
```

This will send the HEX contents of `message.txt` to Ethereum address `0x1234567890...abcdef` on the Polygon zkEVM L2 network.

