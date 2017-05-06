class Mode {
    $type
    $name
    $accidentals
    $voice
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
            "Locrian"        {"-b-b--b-b-b"}
        }
        $this.type = switch -regex ($name) {
            "Lydian|Ionian|Mixolydian"  {"Major"}
            "Dorian|Aeolian|Phrygian"   {"Minor"}
            "Locrian"                   {"Dim"}
        }
        $this.voice = switch ($name) {
            "Ionian"        {@("I","ii","iii","IV","V","vi","vii*")}
            "Dorian"        {@("i","ii","III","IV","v","vi*","VII")}
            "Phrygian"      {@("i","II","III","iv","v*","VI","vii")}
            "Lydian"        {@("I","II","iii","iv*","V","vi","vii")}
            "Mixolydian"    {@("I","ii","iii*","IV","v","vi","VII")}
            "Aeolian"       {@("i","ii*","III","iv","v","VI","VII")}
            "Locrian"       {@("i*","II","iii","iv","V","VI","vii")}
        }
        $this.mood = switch ($name) {
            "Lydian"        {"Ethereal"}
            "Ionian"        {"Happy"}
            "Mixolydian"    {"Peaceful"}
            "Dorian"        {"Serious"}
            "Aeolian"       {"Sad"}
            "Phrygian"      {"Exotic"}
            "Locrian"       {"Unsettling"}
        }
    }
    [array] GetScale ($input_scale) {
        $count = 0
        $output_scale = Get-KeyScale -root_key $input_scale.notes[0] -scale_type $input_scale.type
        foreach ($accident in $this.accidentals.split("-")){
            $each_note = $input_scale.notes[$count]
            if ($accident -match "#|b"){
                if ($accident -eq "#"){
                    if ($each_note -match "^\wb$"){
                        $output_scale.notes[$count] = $each_note.substring(0,1)
                    }
                    else {
                         $output_scale.notes[$count] = "$each_note$accident" 
                    }
                }
                if ($accident -eq "b"){
                    if ($each_note -match "^\w#$"){
                        $output_scale.notes[$count] = $each_note.substring(0,1)
                    }
                    else {
                         $output_scale.notes[$count] = "$each_note$accident" 
                    }
                }
            }
            $count++
        }
        return $output_scale
    }
}

class Progression {
	[array]$chords
    [string]$numerals

    Progression () {
        $this.chords = @()
    }
    [void] Add ($InputChord) {
        $this.chords += $InputChord
        $this.numerals = ($this.chords.split('-') | where {$_ -match "i|v"}) -join ("-")
    }
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
    $type
    $index
}

class KeyScale {
    $notes
    $type
    $offset
}