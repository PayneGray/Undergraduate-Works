class Railfence:
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
	
	def set_table(self):
		for row in range(self.key):
			self.table.append([])
			for column in range(self.length):
				self.table[row].append(" ")
	def fill_table(self):
		row = 0
		for column in range(self.length):
			if self.to_encrypt:
				self.table[row][column]=self.text[column]
			else:
				self.table[row][column]="*"
			if row == 0:
				inc = True
			elif row == self.key-1:
				inc = False
			if inc:
				row+=1
			elif inc==False:
				row-=1	
	def print_table(self):
		for row in self.table:
			print row
			
	def encrypt(self):
		print "We are going to encrypt the plaintext \""+self.text+"\" with key "+str(self.key)+"."
		row = 0
		inc = True
		ciphertext = ""
		self.fill_table()

		for row in self.table:
			for element in row:
				if element != ' ':
					ciphertext += element
		
		print "The ciphertext is " + ciphertext+"."

	def decrypt(self):
		print "We are going to decrypt the ciphertext \""+self.text+"\" with key "+str(self.key)+"."
		row = 0
		inc = True
		

		self.fill_table()
		print "The plaintext is "+self.plaintext()+"."

	def plaintext(self):
		row=0
		count = 0
		plaintext = ""
		inc = True
		# Replace * with text
		for i in range(self.key):
			for column in range(len(self.table[i])):
				if self.table[i][column]=="*":
					self.table[i][column]= self.text[count]
					count+=1
		# Gather text
		for i in range(self.length):
			plaintext +=self.table[row][i]
			if row == 0:
				inc = True
			elif row == self.key-1:
				inc = False
			if inc:
				row+=1
			elif inc==False:
				row-=1	
		return plaintext



encrypt = Railfence(3,"security" ,True)

decrypt = Railfence(3,"srpcsondaniasbdshttcsdwdipacduysdhhoeuiyasadaefeuetgietynoraaduligwtrsrceacsfnothtaasetnnnoescrtpscradotewrctsrrtsonrteninieideiuatkoedeiaanwyk",False)


for i in encrypt.table:
	print i