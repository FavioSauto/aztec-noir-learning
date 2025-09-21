const { UltraHonkBackend } = require('@aztec/bb.js');
const { Noir } = require('@noir-lang/noir_js');

const main = require('./circuits/main/target/main.json');

const { writeFileSync } = require('fs');

async function generateAndVerifyProof() {
  const noir = new Noir(main);
  const provingBackend = new UltraHonkBackend(main.bytecode);

  // define inputs
  const input = { x: 1, y: 2 };

  // generate witness
  const { witness } = await noir.execute(input);
  
  // write proof and public inputs to file
  const proof = await provingBackend.generateProof(witness);

  const proofHex = '0x' + Array.from(proof.proof).map(byte => byte.toString(16).padStart(2, '0')).join('');

  const publicInputsHex = proof.publicInputs.map(input => {
    if (typeof input === 'string' && input.startsWith('0x')) {
      return input;
    } else { 
      return '0x' + Buffer.from(input).toString('hex');
    }
  });

  const proofData = {
    proof: proofHex,
    publicInputs: publicInputsHex
  };

  writeFileSync('proof.json', JSON.stringify(proofData, null, 2));
  console.log('Proof saved to proof.json as hex string');

  // verify proof
  const verified = await provingBackend.verifyProof(proof);

  console.log("Proof verified: ", verified);
  
}

generateAndVerifyProof().catch(console.error);