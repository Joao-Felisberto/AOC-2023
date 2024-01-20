use regex::Regex;
use std::collections::HashMap;
use std::fs::File;
use std::io::{self, BufRead, Error};
use std::path::Path;

pub type GameScores = HashMap<u32, (u32, u32, u32)>;

pub fn part_1(fname: &str, max_red: isize, max_green: isize, max_blue: isize) -> Result<isize, Error>{
    // TODO: do this the right way
    let game_regex: Regex = Regex::new(r".*?(;|$)").unwrap();
    let turn_regex: Regex = Regex::new(r"(?<number>[0-9]+) (?<color>\w+)").unwrap();
    let max_balls = max_red + max_green + max_blue;

    if let Ok(lines) = read_lines(fname) {
        let mut turn_sum = 0;
        let mut i = 0;
        'ln_loop: for ln in lines {
            i += 1;
            // let Ok(ln) = ln else { return };
            let ln = ln?;
            // println!("---------");
            // println!("{}", &ln);
            let mut max: HashMap<&str, isize> = [("red", 0), ("green", 0), ("blue", 0)]
                .into_iter()
                .collect();
            for game in game_regex.find_iter(&ln) {
                // println!("[TURN]: {}", game.as_str());
                // for ocurrence in turn_regex.captures_iter(game.as_str()) {
                //     println!("{}: {}", &ocurrence["color"], &ocurrence["number"]);
                // }
                let turn: HashMap<String, isize> = turn_regex
                    .captures_iter(game.as_str())
                    .map(|ocurrence| {
                        (
                            ocurrence["color"].to_string(),
                            ocurrence["number"].parse().unwrap(), // Assume well formed input
                        )
                    })
                    .collect();

                if turn.values().sum::<isize>() > max_balls {
                    continue 'ln_loop;
                }

                for k in ["red", "green", "blue"] {
                    if let Some(&v) = turn.get(k) {
                        if max[k] < v {
                            max.insert(k, v);
                        }
                    }
                }
            }
            if max["red"] > max_red || max["green"] > max_green || max["blue"] > max_blue {
                continue 'ln_loop;
            }
            turn_sum += i;
        }

        Ok(turn_sum)
    } else {
        Ok(-1) // FIX THIS TERROR
    }
}

// The output is wrapped in a Result to allow matching on errors
// Returns an Iterator to the Reader of the lines of the file.
fn read_lines<P>(filename: P) -> io::Result<io::Lines<io::BufReader<File>>>
where
    P: AsRef<Path>,
{
    let f = File::open(filename)?;
    Ok(io::BufReader::new(f).lines())
}
