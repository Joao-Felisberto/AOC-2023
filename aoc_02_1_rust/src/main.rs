use aoc_02_1_rust::part_1;
use std::env;

fn main() {
    let args: Vec<String> = env::args().collect();

    if args.len() == 0 {
        println!("Please provide file name.");
    }

    let Ok(sum) = part_1(&args[1], 12, 13, 14) else {
        println!("ERROR!");
        return;
    };
    println!("{sum}");
}
