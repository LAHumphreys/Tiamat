BEGIN {
    FS="D|d|\+|-"
    RS=" "
    srand()
}

function roll(numDice, dieSides, mod) {
    total = mod
    for (i = 0; i < numDice; i = i +1) {
        dieRoll=int((rand() * dieSides) + 1)
        total = total + dieRoll
        if ( i == 0 ) {
            printf "%dd%-2d%s: %d", numDice, dieSides, (mod > 0 ? "+" : "") mod, dieRoll
        } else {
            printf ", %d", dieRoll
        }
    }
    printf " (total: %d)\n", total
}

/[0-9]+[dD][0-9]+\+[0-9]/ {
    mod = 0 + $3
    roll($1, $2, mod)
    next
}
/[0-9]+d[0-9]+-[0-9]/ {
    mod = 0 - $3
    roll($1, $2, mod)
    next
}

/[0-9]+d[0-9]+/ {
    roll($1, $2)
}

/^[0-9]+$/ {
    roll(1, $1)
}
