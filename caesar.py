class Caesar():
	'Caesar Cipher class'

	def __init__(self, key, text, to_encrypt):
		self.key = key
		self.text = list(text)
		self.to_encrypt = to_encrypt

		if self.to_encrypt:
			self.encrypt()
		else:
			self.decrypt()

	def encrypt(self):
		ciphertext = ''
		for symbol in self.text:
			if symbol.isalpha():
				newChar = ord(symbol)
				newChar += self.key

				if symbol.isupper():
					if newChar > ord('Z'):
						newChar -= 26
				elif symbol.islower():
					if newChar > ord('z'):
						newChar -= 26

				ciphertext += chr(newChar)
		print(ciphertext)

	def decrypt(self):
		plaintext = ''
		for symbol in self.text:
			if symbol.isalpha():
				newChar = ord(symbol)
				newChar -= self.key
	
				if symbol.isupper():
					if newChar < ord('A'):
						newChar += 26
				elif symbol.islower():
					if newChar < ord('a'):
						newChar += 26
				
				plaintext += chr(newChar)
		print(plaintext)

Caesar(3, 'meetmeafterthetogaparty', True)
Caesar(3, 'phhwphdiwhuwkhwrjdsduwb', False)
						
			
