#!/usr/bin/python3

print("Converts a string to the {QUOTE} Field code")
st = input("String to convert: ")
v = map(lambda y: "%s"%ord(y),st)
print("{ QUOTE %s }"%' '.join(v))
