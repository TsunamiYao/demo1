title 'LIPSET.SPS: Lipset-Example from Brown (1980, pp. 183ff.)'.
*********************************************************************.
* This SPSS-Syntaxfile demonstrates how data files generated with /  .
* used by the program PQMethod can be taken over to SPSS (cf.        .
* PQMethod example data files lipset.dat und lipset.sta).            .
* In this syntax example data and statements are incorporated within .
* the syntax file itself.  This cut&paste approach is the recommended.
* method, though SPSS' builtin text data import assistant can be used.
* also.                                                              .
*                                                                    .
* SOURCE: Brown, S.R. (1980). Political subjectivity: Applications   .
* of Q methodology in political science. New Haven: Yale Univ. Press .
*--------------------------------------------------------------------.
* Tested with SPSS 19, Peter.Schmolck@web.de, 23-Nov-2011            .
* The QMethod Page: http://schmolck.org/qmethod                      .
*********************************************************************.
DATA LIST
     / sort 1-8 (a) Item01 to item33 11-76.
begin data
US1       -1 0-2 0-2 1 0-1 0-1 1 1 2 3-1-4-3-3-1-4 3 2 3 1 1 0 4 2 2-3-2-2 4
US2       -1 0-1-3 2 3 1 1-4 0 2-1 4-1 1-3 0-2-2 0 3-2 1 0 2 1 2 3-1-4-2-3 4
US3        2-2-2 4-1 0-4-3 1-4-3 3 3 2 0-3 2-1 1 0 1-2 0 2-2 3 1-1 0-1-1 4 1
US4        3 1-3-1-1 3-3-2 0-4-1 0 3-2-3-4-1 2 4-2 4 1 1-2 0 1-1 2 0 2 1 2 0
JP5       -4-1 3-1 1 1 4 2-4 4 2 0-1 3 0 2 0-2-2 0-1 2 1-3-3-3 3 0 1-2 1-2-1
CA6        1-3 0 3 3 4-2 0-2-2 1-1 1 0-4 3-1 0 1-1-2-3-1-4 2 2 0 4-1 2 1 2-3
UK7        2 0-2 1 0 1-1-3 0-1 1-1 1 2-4 4 3 2 0 2-2-1-3-4 3-2 0 4-3 1-1 3-2
US8       -2 2 0-3-4 4 0-1-1-1 1-1 1-1 4 0 0 1-3 1 2 2 3 3-3 1-4 3 0-2-2-2 2
FR9        3 1 0 1-4-3 2 2-2 0 0-2 1 4-1-2 2-1 2 1 3-3-3-2 1 0-1-4 0-1 3-1 4
end data.
Flip newnames=sort.
Save outfile='%temp%/scratch.sav'.
 DATA LIST
     / values 1 item 2-60(A) .
value labels values 1 'American' 2 'British'.
begin data
1We accept improvements in status and power of lower class
1All men expected to try to improve selves
2Success in life by a previously deprived person is resented
1Men can expect fair treatment according to merit
1Lower-class not revolutionary
1Political goals relatively moderate, even conservative
2Those born to high place in society should retain it
2Person with wealth deserves place in high society
1We try to eliminate privileged classes
2We accept aristocratic-type titles and other honors
2The government has its secrets, this is generally accepted
1Emphasis on publicity in political matters: no secrets
1Encouraged to think of ourselves as competing for success
2Social status equated with manner of speech
1We take law into our own hands, mob action and vigilantes
2Close ties to Mother Country, as Britain still is for many
1We prefer companionship and helping hand
1Some disdain for acquiring wealth for its own sake
1High value placed on protecting and promoting underdog
2We like the idea of a welfare state
1We value the race for success
1Corrupt means of achieving success are accepted
2One law for the rich, another for the poor
1Lack of respect for the police, and law enforcement
2Trust in police has sunk deeply into our national character
1Worth of a man is judged by what he is, not by education
2Deep respect for the rich, the educated, the social elite
2We are tolerant of popular opinion, don't like extremes
2Poor on earth will enjoy higher status in after-life
2Respect for civil liberties and minority rights
2Virtue tends to be its own reward
2Position of depressed classes must be raised
1Emphasis is on getting ahead
end data.

match files
    file='%temp%/scratch.sav'
    /file=*.
FACTOR
  /VARIABLES us1 to fr9  /MISSING LISTWISE
  /PRINT cor INITIAL EXTRACTION ROTATION FSCORE
  /CRITERIA FACTORS(3) ITERATE(25)
  /EXTRACTION PC
  /CRITERIA ITERATE(25)
  /ROTATION VARIMAX
  /PLOT EIGEN ROTATION (1 2)(1 3)(2 3)
  /SAVE REG(ALL F) .

RENAME variables (F1=B)( F2=C)( F3 = A).
formats A B C (F5.2).
set width=132 length=60.

cor us1 to fr9 with a b c /statistics des.
list A B C item /format=num.

T-TEST
  GROUPS=values(1 2)
  /MISSING=LISTWISE
  /VARIABLES=A B C
  /CRITERIA=CIN(.95) .
