import re
identifier_pattern = r'^[a-zA-Z][a-zA-Z0-9_-]*$'
number_pattern = r'[-+]?\d+$'
types = r'int|float|unsigned char|char'
square_braces = r'\[[-+]?\d+\]$'

def tokens(string):
    string += ' '
    splitters = {' ', ',', ';', '[', ']', '{', '}'}
    buf = ''
    result = ''
    array = ['int', 'char', 'float', 'unsigned char']
    for i in range(len(string)):
        check = False
        if string[i] not in splitters and string[i+1::i+5]:
            buf += string[i]
        else:
            if string[i] == ';':
                check = True
            if (buf == "unsigned"):
                buf += ' '
                continue
            if buf:
                if re.match(types, buf):
                    result += '@@'
                    result += "I "
                    print('KEYWORD: ', buf)
                elif buf == "struct":
                    result += '@@'
                    result += "S "
                    print('KEYWORD: ', buf)
                elif re.match(number_pattern, buf):
                    result += 'N'
                    print('NUMBER: ', buf)
                elif re.match(identifier_pattern, buf):
                    if re.match(types, buf):
                        print("ERROR")
                        return
                    result += 'V'
                    print('IDENTIFIER: ', buf)
            if (string[i]) != ' ':
                result += string[i]    
            buf = ''
    return result

def check_string(token):
    global answer
    if (len(token) > 0):
        if token[0:2] == '@@' and token[-1] == ';':
            check_string(token[2:])
        elif len(token) > 4 and token[0:4] == "S V{":
            i = 1
            while i < len(token) and token[-i] != '}':
                i += 1
            if token[-i] != '}':
                return
            while token[-i] == 'V' and token[-i-1] == ',':
                i += 2
            check_string(token[4:(len(token) - i)])
        elif token[0:7] == 'I V[N];':
            check_string(token[7:])
            answer = True

print('Input strings or \'end\'')
string = input()
while string != 'end':
    token_string = tokens(string)
    print('String of tokens is:', tokens(string))
    answer = False
    check_string(token_string)
    if answer == True:
        print('Correct')
    else:
        print('Wrong')
    string = input()
