package main

import (
	"bufio"
	"fmt"
	"os"
	"strconv"
)

func readInput(f *os.File) []int {
	var entries []int

	r := bufio.NewReader(f)
	for line, err := r.ReadString('\n'); err == nil; line, err = r.ReadString('\n') {
		entry, err := strconv.Atoi(line[:len(line)-1]) // remove the newline
		if err != nil {
			_, _ = fmt.Fprintf(os.Stderr, "Failed to convert %s to integer\n", line)
		} else {
			entries = append(entries, entry)
		}
	}
	return entries
}

func part1(entries []int) {
	for i, e1 := range entries {
		for i2, e2 := range entries[i:] {
			if i == i2 {
				continue
			}

			if e1+e2 == 2020 {
				fmt.Printf("part 1 answer is %d\n", e1*e2)
			}
		}
	}
}

func part2(entries []int) {
	for i, e1 := range entries {
		for i2, e2 := range entries[i:] {
			for _, e3 := range entries[i2:] {
				if e1+e2+e3 == 2020 {
					fmt.Printf("part 2 answer is %d\n", e1*e2*e3)
				}
			}
		}
	}
}

func main() {
	f, err := os.Open("../inputs/advent1.txt")
	if err != nil {
		panic(err)
	}

	entries := readInput(f)
	part1(entries)
	part2(entries)
}
