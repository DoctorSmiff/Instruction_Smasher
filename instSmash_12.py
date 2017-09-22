'''
Author: Mammad
Date: Third week of Ordibehesht-1395
Tool Description: Instruction Smasher
Change and tune ARM assembly instructions as you see fit.
The first version will handle the POP instruction. 
Further development will handle all instructions.
The project should be ported to Github. 
We're using Python 2.7.11 on Win32.
Keep it simple, keep it stupid.
Version 12.0-Beta testing

Added command line arguments. 

'''
import string
import os.path
import sys



def read_file(file, newFile):
 
	print "entered to part_1, read_file\n"						#DEBUG

	openedFile       = open(file, "r")
	outputFile    	 = open(newFile, "w+")
	

	for line in openedFile:
		if any(inst in line for inst in INSTRUCTIONS):
				print line, "  ", type(line)						#DEBUG 
				
				lineContents = bracketsSplit(line)
				
				print "reentering to part_1, read_file\n"	   		#DEBUG
				print lineContents, "  ", type(lineContents)		#DEBUG
				
				instOperands = commaSplit(lineContents)		
				
				print "reentering to part_1, read_file\n"	   		#DEBUG
				#print instOperands, "  ", type(instOperands), len(instOperands), type(instOperands[1]), instOperands[0], instOperands[1]	#DEBUG 	
				
				instReplace(instOperands, outputFile, line.split()[0])
		else:
			outputFile.write(line)	
		
	openedFile.close()		
	outputFile.close()

			
def bracketsSplit(line):
	print "entered2 bracketSplit\n"						#DEBUG
	
	contents = line[line.find("{")+1:line.find("}")]
	#contents = line.split('{')
	#print type(contents)      					#DEBUG
	#print contents								#DEBUG
	return contents
	
	
def commaSplit(line):
	print "entered3 CommaSplit\n"						#DEBUG
	contents = line.split(",")
	print type (contents)
	return contents

			
"""
++--: Placing code based on the list index is 
	  problematic. Replace this. 
"""
def instReplace(instOperands, newFile, inst):
	print "entered4 instRplace\n"						#DEBUG
	
	#Writing to the file. 
	#PATTERN = inst + "      " + "{" + instOperands[0] + "}"
	for i in range(len(instOperands)):
		newFile.write(inst  + "      " + "{" + instOperands[i] + "}")
		newFile.write("\n")
		#newFile.write(inst + "      " + "{" + instOperands[1] + "}")
	

			
if __name__ == "__main__":
	global INSTRUCTIONS
	
	"""++--. The INSTRUCTION variable's type
	   needs to change. It should be a list. 	
	   It's contents should be the instructions
	   that we want to change. 
	"""
	INSTRUCTIONS = ['POP', 'PUSH']			#The INSTRUCTIONS to change	++Should use a command line option
	
	if len(sys.argv) == 2:
		if os.path.exists(sys.argv[1]):
			file_to_process = sys.argv[1]
			new_file		= "new_" + file_to_process
			print "Start of story \n"				#DEBUG
	
			read_file(file_to_process, new_file)
	
			print "End of story"
		else:
			print "\nThe file does not exist\n"
	else:
		print "\n The number of command line inputs is not corret. \n"
		print " The correct format for running the program via command line: \"instSmash.py fileName\" "
		#sys.exit()
	
	#NEW_FILE 		= 'new_inst.txt'		#The new file created after processing the original one
	
		