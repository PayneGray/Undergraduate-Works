class Vigenere:
	def __init__(self,key,text,to_encrypt):
		self.key = key
		self.text = text
		self.length = len(self.text)
		self.table = []
		self.to_encrypt = to_encrypt
		self.set_table()
		if self.to_encrypt:
			self.encrypt()
		else:
			self.decrypt()
	def prep_key(self):
		count = 0
		prep_key = ""
		for i in range(len(self.text)):
			prep_key +=self.key[count]
			if count==len(self.key)-1:
				count=0
			else:
				count+=1
		return prep_key
	def encrypt(self):
		print "We are going to encrypt the plaintext \""+self.text+"\" with key "+self.key+"."
		plaintext = ""
		for i in range(self.length):
			plaintext+=self.table[i+1][self.table[0].index(self.text[i])]
		print plaintext
	def decrypt(self):
		print "We are going to decrypt the ciphertext \""+self.text+"\" with key "+self.key+"."
		ciphertext = ""
		for i in range(self.length):
			position = self.table[i+1].index(self.text[i])
			ciphertext += self.table[0][position]
		print ciphertext
	def set_table(self):
		alphabet = list("abcdefghijklmnopqrstuvwxyz")
		self.table.append(alphabet)
		for letter in self.prep_key():
			pos =  alphabet.index(letter)
			self.table.append(alphabet[pos:]+alphabet[:pos])
vigenere = Vigenere("vigenere","thisismyplaintext",True)
vigenere2 = Vigenere("vigenere","opowvwdcktgmaxvbo",False)
print vigenere.prep_key()
playfair =Vigenere("thesnowlaythickonthe steps and the snowflakes driven by the wind looked black in the headlights of the cars".replace(" ", ""),("SIDKHKDM AF HCRKIABIE SHIMC KD LFEAILA".lower()).replace(" ", ""),False)
