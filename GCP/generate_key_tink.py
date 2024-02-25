import io
import base64
import json

from tink import KeysetHandle 
from tink import JsonKeysetWriter, JsonKeysetReader
from tink import aead, cleartext_keyset_handle

aead.register()

# key_template = aead.aead_key_templates.AES256_GCM

# # Generate a new keyset using the key template
# keyset_handle = KeysetHandle.generate_new(key_template)

# string_out = io.StringIO()
# writer = JsonKeysetWriter(string_out)
# cleartext_keyset_handle.write(writer, keyset_handle)

# serialized_keyset = string_out.getvalue();
# print(serialized_keyset)

reader = JsonKeysetReader('GiDbbzvI6OSDZMTvs2yGNm5AG3i0jX1/WIKyzO9Vv3Rn5A==')
keyset_handle1 = cleartext_keyset_handle.read(reader)

plaintext = b'The quick brown fox jumps over the lazy dog'
aead_primitive = keyset_handle1.primitive(aead.Aead)
tink_ciphertext = aead_primitive.encrypt(plaintext, b'practice')
print(tink_ciphertext)

# plain_text = aead_primitive.decrypt(tink_ciphertext,b'practice')
# print(plain_text)

# jval = json.dumps(serialized_keyset)

# print(base64.b64encode(jval.encode('utf-8')))


