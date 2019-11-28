Here we have the Matlab's functions we used for genreating the data, for more information please see the documantation within the code:

In order to generate more data run the main function.
Make sure to add a folder for reading and exporting data with the right name.

The Data is generated in the followng manner:
first we decide of the problem dimension. 
N1 - the number of links in expert's arm (we use N1=5)
N2 - the number of links in learner's arm (we use N2=3)

Then we generate the length of the agents links:
1. lx - N1 size vector. the expert's arm links length, generated at random
2. ly - N2 size vector. the lerner's arm links length, generated at random with the constrain that the total length of the two agents is equall.
3. given integer N and two vectors of arms length lx,ly we generate N samples with GenerateData function:
	1. X - Expert's states, are generated at random
	2. Y - Learner's states, are generated with the custom made function: f sets y to be such angles that the arm of the learner will end exactly where the arm of the experts ends. and ontop minimize the total distance between the two configurations. (see cost for better understandin)
