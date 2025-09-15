use dep::poseidon::poseidon2::Poseidon2::hash;

/** 
 * Field: It's not really a big integer, but Field can be treated as a big integer.
 * pub: Public field (All the fields are private by default)
 * password: Field
 * password_hash: pub Field
 */
fn main(password: [Field; 3], password_hash: pub Field) {
    assert(hash(password, 3) == password_hash);
}

// 0x23864adb160dddf590f1d3303683ebcb914f828e2635f6e85a32f0a1aecd3dd8

// Notes on this:
// We can send the verification key in a smart contract and then send the proof to the smart contract to the smart contract and it will verify the proof.
// This is possible because the technology is zk SNARK (Succint Non-interactive ARgument of Knowledge).