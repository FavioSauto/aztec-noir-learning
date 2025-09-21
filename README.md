# Aztec Noir Learning

This is a repo where I will be learning Noir and following different Aztec's tutorials and workshops.

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

## Video: "NoirHack 2025 - Official Kickoff & Intro to Noir"

Video: [NoirHack 2025 - Official Kickoff & Intro to Noir](https://www.youtube.com/watch?v=mxf7OWu5CQc&list=PLabpoAlaCBY3Hu-QuvSa4WXvM6H94sQ_I&index=6)

### Notes

A Zero Knowledge proof is a cryptographic proof about a fact that does not reveal any info about said fact.

An interactive proof is when a verifier asks questions/challenges two or more times to the prover about the proof until it's convinced that the prover actually knows the fact.

A non-interactive proof is when a verifier can bundle all of the questions/challenges into one and send it to the prover, the prover cna then answer at any time, and this allows anyone to verify, not only the Verifier. This is a Succinct Non-interactive ARgument of Knowledge (SNARK).

There are loads of types of SNARKs, groth16, honk, ultrahonk, ultraflunk, or plonk are types of SNARK *proving* systems. Each type of SNARK has different properties and optimizations, and there are different reasons we might want to use one over the other.

The cool thing about Noir is that we can use all of these different SNARKs to generate proofs.

Noir compiles to ACIR (Abstract Circuit Intermediate Representation). It is then fed to the ACVM (Abstract Circuit Virtual Machine). The ACVM "translates" this ACIR into whatever proving system is specified. Barretenberg is default ultrahonk. We can use different proving systems with Barretenberg, but for this video we will use ultrahonk.

The "Field" type in Noir is the default field for whatever proving system we are using. The way we work with "Field"s is pretty much with unsigned integers.

When we execute a Noir circuit, we are assigning the variables to it. And that is the witness. If we have the following code.

```
fn main(x: Field, y: pub Field) {
    assert(x != y);
}
```

And then we execut that circuit we are assigning the values to the "x" and "y" variables. The object of the assigned variables is the witness. So something like this would be the witness of the code above: "{ x: 1, y: 2 }". Once we have the witness and the circuit, we can prove it. And then we can send the proof to the verifier to verify it.

#### Personal Notes

Based on a chat with AI, I went deeper into what is Barretenberg and what is ultrahonk.

Based on the AI response: "Barretenberg is a highly optimized, low-level SNARK proving system backend developed by Aztec. It is the computational engine responsible for generating and verifying zero-knowledge proofs (specifically, SNARKs, often plonky2-like constructions) that are integral to Aztec's privacy model and the execution of Noir circuits."

"UltraHonk is the next-generation proving scheme that Aztec is building, and it is a significant evolution beyond UltraPlonk. It combines several recent breakthroughs in zero-knowledge cryptography into a single, cohesive system."

As of my understanding, Barretenberg is like a javascript engine, ultrahonk is like a javascript standard (ecmascript), noir is javascript, and nargo is the runtime environment for noir.

| Frontend Development | ZK (Aztec/Noir) Concept | Role |
| -------- | ------- | ------- |
| *ECMAScript (The Standard)* | *UltraHonk (The Scheme)* | The formal blueprint or specification. |
| *V8 Engine (The implementation)* | *Barretenberg (The backend)* | The high-performance C++ engine that runs the spec. |
| *JavaScript/TypeScript (The Language)* | *Noir (The Language)* | The high-level language developers write their logic in. |
| *Browser (The runtime environment)* | *The Aztec Node or `nargo` (The toolchain/SDK)* | The complete environment that bundles the language compiler and the engine to provide a full developer toolkit. |

## Glossary

- ZK: Zero-Knowledge
- ZK-SNARK: Zero-Knowledge Succinct Non-interactive ARgument of Knowledge
- ZK Rollup: Zero-Knowledge Rollup
- L1: Layer 1
- L2: Layer 2
- Prover: The party that generates the proof
- Verifier: The party that verifies the proof
- Proof: The mathematical proof that the prover sends to the verifier
- Verification Key: The verification key that the prover sends to the verifier
- Witness: The information that the prover sends to the verifier

## Commands

### nargo

```
nargo check # Creates a "Prover.toml" file where the witness data is stored. For the template is a Prover.toml file with x="" and y="".

nargo execute [witness_name] # This generates the witness and the compiled circuit. "main.json" is the compiled circuit and the [witness_name].gz is the witness that is a binary file. The compiled circuit is the thing that we're going to be passing to different things to prove  and verify.

bb prove -b [compiled_circuit] -w [witness_name] -v [verification_key] -o [output_file (generally ./target)] # This generates the proof.

bb write_vk -b [compiled_circuit] -o [output_file (generally ./target)] # This generates the verification key. This is what we're going to use that to verify the proof generated.

bb verify -p [proof_direction] -vk [verification_key] # This verifies the proof.
```
