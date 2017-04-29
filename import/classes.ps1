class Mode {
    $type
    $name
    $accidentals
    $chords
    $mood
    Mode ($name){
        $this.name = $name
        $this.accidentals = switch ($name) {
            "Lydian"        {"---#---"}
            "Ionian"        {"-------"}
            "Mixolydian"    {"------b"}
            "Dorian"        {"--b----b"}
            "Aeolian"       {"--b---b-b"}
            "Phrygian"      {"-b-b---b-b"}
            "Lydian"        {"-b-b--b-b-b"}
        }
        $this.type = switch -regex ($name) {
            "Lydian|Ionian|Mixolydian" {"Major"}
        }
        $this.chords = switch ($name) {
            "Lydian"        {@("i","II","iii","iv*","V","vi","vii")}
            "Ionian"        {@("I","ii","iii","IV","V","vi","vii*")}
            "Mixolydian"    {@("i","II","iii","iv*","V","vi","vii")}
            "Lydian"        {@("i","II","iii","iv*","V","vi","vii")}
            "Lydian"        {@("i","II","iii","iv*","V","vi","vii")}
            "Lydian"        {@("i","II","iii","iv*","V","vi","vii")}
            "Lydian"        {@("i","II","iii","iv*","V","vi","vii")}
        }
        $this.mood = switch ($name) {
            "Lydian"        {"Ethereal"}
            "Ionian"        {"Happy"}
            "Mixolydian"    {"Peaceful"}
            "Dorian"        {"Serious"}
            "Aeolian"       {"Sad"}
            "Phrygian"      {"Exotic"}
            "Lydian"        {"Unsettling"}
        }
    }
    [void] GetScale ($scale) {
        'return $scale with accidentals
        using 
            if (mode sharps){if (b){remove b} else {add #}}
            if (mode flats){if (#){remove #} else {add b}}'
    }
}

class Progression {
	[array]$chords
	
	[void] RecordMidi () {
		'convert $chords'
	}
}

class ChordMap {
    $chord_1
    $chord_2
    $chord_3
    $chord_4
    $chord_5
    $chord_6
    $chord_7
    $mood
    $mode
}

class Scale {
    [ValidateSet(
        "A#","B#", "C#", "D#", "E#", "F#", "G#", "A","B", "C", "D",
        "E", "F", "G", "Ab","Bb", "Cb", "Db", "Eb", "Fb", "Gb"
    )]$root_key

    [ValidateSet("Major","Minor","Dim")]$scale_type   
}