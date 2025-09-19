// Everything that is inside the "main" function is going to be involved in a circuit. That can get quite expensive when I'm writing a lot of code inside the circuit.
fn main(num: u64) -> pub u64 {
    // Safety: We are using an unconstrained function to calculate the square root. Be careful using in prod.
    let square: u64 = unsafe{ sqrt(num) };

    assert(square * square == num);

    square
}

// This won't be constrained, so there's no proof generated here. This is quite unsafe. We need to be careful when using unconstrained functions. When we call unconstrained functions Noir is going to give us a warning and won't allow us to do it unless we mark it as unsafe.
unconstrained fn sqrt(num: u64) -> u64 {
    let mut approx: u64 = num;
    let mut better_approx: u64 = (approx + 1) / 2;

    for _ in 0..10 {
        approx = better_approx;

        better_approx = (approx + num / approx) / 2;
    }

    better_approx
}

#[test]
fn test_main() {
    let number_to_square_root: u64 = 144;

    let square_root: u64 = main(number_to_square_root);

    println(square_root);

    assert(square_root == 12);
}