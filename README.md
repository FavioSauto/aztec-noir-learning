# Aztec Noir Learning

This is a repo where I will be learning Noir and following different Aztec's tutorials and workshops.

### Glossary

- ZK: Zero-Knowledge
- ZK-SNARK: Zero-Knowledge Succinct Non-interactive ARgument of Knowledge
- ZK Rollup: Zero-Knowledge Rollup
- L1: Layer 1
- L2: Layer 2
- Prover: The party that generates the proof
- Verifier: The party that verifies the proof
- Proof: The proof that the prover sends to the verifier
- Verification Key: The verification key that the prover sends to the verifier
- Witness: The information that the prover sends to the verifier

## Video: "Build Your First ZK App with Noir"

Video: [Build Your First ZK App with Noir](https://www.youtube.com/watch?v=06INZUM5Ca8&list=PLabpoAlaCBY3Hu-QuvSa4WXvM6H94sQ_I&index=1)

### Notes

ZK Enables one person (the prover) to prove a verifier that they know/have some information that the verifier can verify without the prover having to reveal the information. The prover proves by sending a proof that the verifier can verify.

#### zkSNARK

zkSNARK is a zero-knowledge scheme that means zero-knowledge Succinct Non-interactive ARgument of Knowledge. Usually zkSNARKs are used just for the second propery which is the succinctness. But it can also be used more specifically about the other properties it enables like privacy and non-interactive. Meaning that there is no extensive back and forth and everything can just be passed in one message.

##### Example

Alice wants to prove something to Bob. How does it work?

Alice sends the raw information to a "Proving Backend" that generates a proof that se knows and has the information. The proving backend will generate during the setup a verification key and a proof. This verification key can live onchain so it can be stored in a smart contract on L1 and that's what we see with verifier contracts. Then Alice or the proving backend can send the verification key and the proof to the Bob or to the verifier contract. Then Bob or the verifier contract can use the verification key to verify the proof. All without knowledge of the raw information.

On a more personal note, I don't like calling it a "proving backend" because of two reasons: It's just one mechanism/function that is doing the proof generation, backend for me feels like it's assigning extra functionalities to it. Second reason is that it's not proving per se, but it's generating a proof of the prover's knowledge.

There are many tpyes of "proving backends" like plunk or others.

On this video we will create a verifier contract that I will continuously use to check if my proofs are correct.

#### ZK For Scaling

When we talk about ZK for scaling we talk about having all the transactions (that are the witness/the information the prover has) and all the information that's coming in and the L2 will take all of this transactions, and in this case they are the prover that are rolling all of this transactions up (gathering them all together, executing them, and combining their state changes into a single, compact unit) creating a proof and sending it to the verifier contract on the L1 to actually verify this information this just takes advantage of the succinctness aspect it's really just trying to use L1 for settlement and speed and use the L2 to help scale transactions without having them all be on L1. If the proof is valid, the L1 network implicitly trusts that all the transactions bundled within that proof were validly executed on the L2.

#### ZK For Privacy

When we talk about ZK for privacy we have to move the prover to the user, the user has to become the prover and provide proof related to the raw information/witness and all the proofs are going to be generated offchain and those are going to be sent to the L2 to be executed making the L2 the verifier for a time and then the L2 is going to become the prover again and bundle all of those up and send them to the L1.

Now, we might be asking, if the proofs are being generated offchain we can still see how everything happens on the L2, like all the wallets are public all the transactions are public, and that's why we have something like Aztec Network that it's being built, where we can have oofchain proofs but we can also have private wallets, private transactions and all of that is still bundled up in the same way as a zk rollup and sent to the L1 to be settled.

#### Noir: The Universal Language of Zero-Knowledge

Noir allows us to create proofs offchain on the client side and integrate them into our applications. It's the universal language of zk, and it makes it easier for us developers. It allows us to use logic instead of having to write all these crazy circuits under the hood. It's Rustlike syntax, it's open-source, and it's flexible. There's very little vendor lock-in because we can swap out any proving backend that we choose.

##### Nargo

Inspired by Cargo, Nargo is the Noir package manager. It has some tooling for executing the Noir circuits.

##### BB = Barretenberg

Barretenberg is the proving backend that Noir uses. This is what we could actually swap by some other backend as long as it understands the intermediate language between the two called ACR.