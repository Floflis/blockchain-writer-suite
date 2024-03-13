# Blockchain Poster

This Bash script (blockchain-poster.sh) is designed to send custom HEX messages to a given Ethereum address using the Ethereum Go tool "ethereal".

## Usage

```bash
./blockchain-poster.sh <file_path> <eth_address>
```

- `<file_path>`: Path to the .txt file containing the HEX message.
- `<eth_address>`: Ethereum address to send the HEX message to.

## Prerequisites

- Ethereum Go tool "ethereal" must be installed.
- Local Ethereum wallet must be unlocked.

## Steps

1. Read the HEX contents of the file.
2. Send the HEX contents to the specified ETH address using ethereal.
3. Unlock the local wallet and sign to send the message.

## Example

```bash
./blockchain-poster.sh message.txt 0x1234567890abcdef
```

This will send the HEX contents of `message.txt` to Ethereum address `0x1234567890abcdef`.

