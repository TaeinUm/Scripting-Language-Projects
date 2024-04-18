"""
CSE 337 / HW1
Name: Taein Um
Net ID: TUM
Student ID: 112348159
"""


# Problem 1
def is_chaotic(s):
    s = s.lower()  # Make it lower case
    d = {}         # Initialize a dictionary
    tmp = {'a'}    # Initialize a set

    for i in s:    # Fill up the dictionary accordingly
        if i in d:
            d[i] += 1
        else:
            d[i] = 1

    for i in d:        # Add all the values in d to s
        tmp.add(d[i])

    if len(tmp) == len(d) + 1:  # Check whether it is chaotic or not
        return 'TOHRU'
    else:
        return 'ELMA'


# Problem 2
def is_balanced(s):
    o = {'(': 0, '{': 1, '[': 2}  # Opening
    c = {')': 0, '}': 1, ']': 2}  # Closing

    if len(s) % 2 == 0:                          # Find out whether the length of the string is even
        for i in range(len(s)//2):
            if s[i] in o:                        # Checks whether it is an opening bracket
                if o[s[i]] == c[s[len(s)-1-i]]:  # Match whether it is balanced
                    continue
                else:
                    return False
            else:
                return False
    else:
        return False

    return True


# Problem 3
def winning_function(l, f1, f2):
    count_f1 = 0  # Count the number of True from f1
    count_f2 = 0  # Count the number of True from f2

    for i in l:
        if f1(i):
            count_f1 += 1  # Count up to f1
        if f2(i):
            count_f2 += 1  # Count up to f2

    if count_f1 > count_f2:
        return f1.__name__
    elif count_f1 < count_f2:
        return f2.__name__
    else:
        return 'TIE'


# Problem 4
class FS_Item:
    def __init__(self, name):
        self.name = name


class Folder(FS_Item):
    def __init__(self, name):
        super().__init__(name)
        self.items = []

    def add_item(self, item):
        self.items.append(item)


class File(FS_Item):
    def __init__(self, name, size):
        super().__init__(name)
        self.size = size


def load_fs(ls_output):
    root = None
    current = None
    folder_stack = []

    with open(ls_output, 'r') as file:
        for line in file:
            if line.endswith(':\n'):  # Directory
                folder_name = line[:-2] if line.startswith('./') else line[:-1]
                if root is None:
                    root = Folder(folder_name)
                    current = root
                else:
                    # Create a new folder and add it to the current folder
                    new_folder = Folder(folder_name.split('/')[-1])  # Get the last part of the path
                    current.add_item(new_folder)
                    folder_stack.append(current)  # Push the current folder to the stack
                    current = new_folder  # Update the current folder

            elif 'total' in line:
                continue  # Skip the 'total' lines

            elif line.strip():  # File or subdirectory
                parts = line.split()
                if len(parts) > 1 and parts[0][0] != 'd':  # It's a file
                    file_name = parts[-1]
                    file_size = int(parts[-5])  # Assuming size is always at this fixed position
                    current.add_item(File(file_name, file_size))

            else:  # Empty line, go up one level
                if folder_stack:
                    current = folder_stack.pop()  # Pop the last folder from the stack

    return root


# Problem 5
def decode(ct):
    plaintext = ""    # Initialize variables
    sum_previous = 0  # Sum of ordinal values of all previously decrypted letters

    for i, char in enumerate(ct):
        if char.isalpha():
            # Convert the cipher character back to its original ordinal value
            if i == 0:
                # Special case for the first letter
                original_ord = (ord(char) - ord('a') - 59) % 26
                plaintext += chr(ord(char))                # Append the decrypted character to the plaintext
            else:
                # General case for subsequent letters
                original_ord = (ord(char) - ord('a') - sum_previous) % 26
                plaintext += chr(original_ord + ord('a'))  # Append the decrypted character to the plaintext

            sum_previous += original_ord + ord('a')        # Update the cumulative sum

        else:
            plaintext += char  # Append non-alphabetic characters

    return plaintext
