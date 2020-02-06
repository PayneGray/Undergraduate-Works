plaintext = list("securitypasscardsareoftenusedtogainentryintoareasandbuildingswithrestrictedaccessfindoutwhatdataiskeptonanencodedsecuritypasscardandhowtheywork")



def split_by_len(text, chunksize):
    return [text[i:(i+chunksize)] for i in range(0,len(text)-chunksize+1,5)]

string = ""
table= split_by_len(plaintext,5)
for i in table:
	string += i[0]
print string
string = ""
table= split_by_len(plaintext,5)
for i in table:
	string += i[1]
print string
string = ""
table= split_by_len(plaintext,5)
for i in table:
	string += i[2]
print string
string = ""
table= split_by_len(plaintext,5)
for i in table:
	string += i[3]
print string
string = ""
table= split_by_len(plaintext,5)
for i in table:
	string += i[4]
print string
print ""
string = ""
table= split_by_len(plaintext,5)
for i in table:
	string += i[2]
print string
string = ""
table= split_by_len(plaintext,5)
for i in table:
	string += i[4]
print string
string = ""
table= split_by_len(plaintext,5)
for i in table:
	string += i[3]
print string
string = ""
table= split_by_len(plaintext,5)
for i in table:
	string += i[0]
print string
string = ""
table= split_by_len(plaintext,5)
for i in table:
	string += i[1]
print string