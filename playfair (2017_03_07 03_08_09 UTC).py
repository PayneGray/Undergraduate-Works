class Playfair:
	def __init__(self,key,text,to_encrypt):
		self.key = key
		self.text = list(text)
		self.to_encrypt = to_encrypt
		self.table = self.prep_table()
		if self.to_encrypt:
			self.prep_plaintext()
			self.encrypt()
		else:
			self.decrypt()

	def convert(self,letter1,letter2):
		pos1 = self.pos(letter1)
		pos2 = self.pos(letter2)
		if pos1[0]==pos2[0]:
			# the letters are in the same row
			# shift to the right
			if pos1[1]==4:
				pos1[1]=0
				pos2[1]+=1
			elif pos2[1]==4:
				pos2[1]=0
				pos1[1]+=1
			else:
				pos1[1]+=1
				pos2[1]+=1
			return self.table[pos1[0]][pos1[1]]+self.table[pos2[0]][pos2[1]]
		elif pos1[1]==pos2[1]:
			#the letters are in the same column
			#shift down
			if pos1[0]==4:
				pos1[0]=0
				pos2[0]+=1
			elif pos2[0]==4:
				pos2[0]=0
				pos1[0]+=1
			else:
				pos1[0]+=1
				pos2[0]+=1
			return self.table[pos1[0]][pos1[1]]+self.table[pos2[0]][pos2[1]]
		else:
			return self.table[pos1[0]][pos2[1]]+self.table[pos2[0]][pos1[1]]

	def revert(self,letter1,letter2):
		pos1 = self.pos(letter1)
		pos2 = self.pos(letter2)
		if pos1[0]==pos2[0]:
			# the letters are in the same row
			# shift to the left
			if pos1[1]==0:
				pos1[1]=4
				pos2[1]-=1
			elif pos2[1]==0:
				pos2[1]=4
				pos1[1]-=1
			else:
				pos1[1]-=1
				pos2[1]-=1
			return self.table[pos1[0]][pos1[1]]+self.table[pos2[0]][pos2[1]]
		elif pos1[1]==pos2[1]:
			#the letters are in the same column
			#shift down
			if pos1[0]==0:
				pos1[0]=4
				pos2[0]-=1
			elif pos2[0]==0:
				pos2[0]=4
				pos1[0]-=1
			else:
				pos1[0]-=1
				pos2[0]-=1
			return self.table[pos1[0]][pos1[1]]+self.table[pos2[0]][pos2[1]]

		else:
			return self.table[pos1[0]][pos2[1]]+self.table[pos2[0]][pos1[1]]

	def decrypt(self):
		plaintext = []
		for i in range(0,len(self.text)-1,2):
			plaintext.append(self.revert(self.text[i],self.text[i+1]))
		print ''.join(plaintext)
	def encrypt(self):
		ciphertext = []
		for i in range(0,len(self.text)-1,2):
			ciphertext.append(self.convert(self.text[i],self.text[i+1]))
		print ''.join(ciphertext)

	def prep_plaintext(self):
		for i in range(0,len(self.text)-1):
			if self.text[i]==self.text[i+1]:
				self.text.insert(i+1,'x')
			if self.text[i]=='j':
				self.text[i]='i'
		if len(self.text)%2 !=0:
			self.text.append('z')

	def pos(self,letter):
		x = [x for x in  self.prep_table() if letter in x][0]
		return [self.prep_table().index(x),x.index(letter)]
	def prep_cipher(self):
		combine = self.key+"abcdefghijklmnoprstuvwxyz"
		return  "".join(sorted(set(combine),key=combine.index))
	def prep_table(self):
		table = [[],[],[],[],[]]
		for i in range(5):
			table[i]= self.prep_cipher()[i*5:i*5+5]
		self.table = table
		return table

playfair = Playfair("helloworld","hidethegold",True)
print playfair.text
for i in playfair.table:
	print i
print "LF GE MW DN WO CV"