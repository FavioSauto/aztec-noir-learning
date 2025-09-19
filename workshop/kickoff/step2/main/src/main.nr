// passphrase in hex (needed for Field): 0x69206c696b65206e6163686f73
// calculated passphrase hash: 0x033787e40b56554b03a980f03a55fbd5baf81cf563a228928b1598d34629bfd5

// test command: nargo test --show-output

use dep::std;

struct Person {
    name: str<5>,
    age: u8
}

global minimumAge: u8 = 16;

fn main(member: Person, passphrase: Field, passphraseHash: pub Field) {
    assert(member.age >= minimumAge);

    let calculatedPassphrase = std::hash::pedersen_hash(([passphrase, 0]));

    assert(calculatedPassphrase == passphraseHash);
}

#[test]
fn get_passphhrase_hash() {
    let passphrase: Field = 0x69206c696b65206e6163686f73;

    let calculatedPassphraseHash: Field = std::hash::pedersen_hash([passphrase, 0]);

    println(calculatedPassphraseHash);
}

#[test]
fn test_main(){
    let passphrase: Field = 0x69206c696b65206e6163686f73;
    let passphraseHash: Field = 0x033787e40b56554b03a980f03a55fbd5baf81cf563a228928b1598d34629bfd5;
    
    let favio = Person { name: "Favio", age: 26 };
    
    main(favio, passphrase, passphraseHash);
}