BEGIN {
    FS="[\\|\\[\\]]"
    attr=""
    weapons="no"
}

function printSkill(name, mod) {
    gsub(/^ +/, "", mod)
    gsub(/ +$/, "", mod)
    gsub(/^ +/, "", name)
    gsub(/ +$/, "", name)
    if (mod == "0") {
        mod = ""
    }
    name=tolower(name)
    printf "%-20s 1d20%s\n", name ":" , mod
}

# Attributes
/\| [A-Z]+ +\[[ 0-9]+]/ {
    attr=$2
    gsub(/^ +/, "", attr)
    attr=substr(attr,0,3)
    printSkill(attr, $5)
}

#  Initative
/Inspiration/ {
    printSkill("Initiative", $8)
}

#  Skills
/\[[X ]\] \[[+-][0-9]\]/ {
    skill=$2
    gsub(/^ +/, "", skill)
    gsub(/ +$/, "", skill)
    if ( skill == "Saving Throws") {
        skill = attr " " skill
    }
    printSkill(skill, $5)
}

# Weapons
/^\+-/ {
    weapons="no"
}
/\+-Weapon-/ {
    weapons="yes"
}
/^\| [A-Z].*\|.*\|.*\|/ {
    if (weapons=="yes") {
        gsub(/^ +/, "", $2)
        gsub(/ +$/, "", $2)
        gsub(/^ +/, "", $3)
        gsub(/ +$/, "", $3)
        gsub(/^ +/, "", $4)
        gsub(/ +$/, "", $4)
        printf "%-20s 1d20%s %s\n", tolower($2) ":", $3, $4
    }
}
