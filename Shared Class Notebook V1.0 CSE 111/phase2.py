import sqlite3
from sqlite3 import Error


def openConnection(_dbFile):
    print("++++++++++++++++++++++++++++++++++")
    print("Open database: ", _dbFile)

    conn = None
    try:
        conn = sqlite3.connect(_dbFile)
        print("success")
    except Error as e:
        print(e)

    print("++++++++++++++++++++++++++++++++++")

    return conn


def closeConnection(_conn, _dbFile):
    print("++++++++++++++++++++++++++++++++++")
    print("Close database: ", _dbFile)

    try:
        _conn.close()
        print("success")
    except Error as e:
        print(e)

    print("++++++++++++++++++++++++++++++++++")
    
    
def login(_conn):
    while True:
        user = input("Enter your name: ")
        password = input("Enter your password: ")
        with sqlite3.connect("scnDatabase.sqlite") as data:
            cursor = data.cursor()
        finding = ("Select * from account where a_name = ? and a_pass = ?")
        cursor.execute(finding, [(user), (password)])
        res = cursor.fetchall()
        
        if res:
            for i in res:
                print("Hello " + i[0])
                print("Login successful")
                dist = ("select a_type from account where a_ID = ?")
                cursor.execute(dist, [(i[3])])
                fol = cursor.fetchall()
                if i[3] == "prof":
                    cla = ("select * from professor where p_name = ?")
                    cursor.execute(cla, [(user)])
                    fol = cursor.fetchall()
                    for j in fol:
                        profAccess(_conn, user, j[2], i[3])
                if i[3] == "stu":
                    cla = ("select * from account where a_name = ?")
                    cursor.execute(cla, [(user)])
                    fol = cursor.fetchall()
                    for j in fol:
                        classList(_conn, user, j[2], i[3])   
                    
            return("exit")
        else:
            print("User or password is incorrect")
            again = input("Would you like logging in again? (y/n): ")
            if again.lower() == "n":
                print("exited")
                break   


def classList(_conn, user, ID, typ):
    with sqlite3.connect("scnDatabase.sqlite") as data:
        cursor = data.cursor()
    you = ("select cla_name, cla_cID from classCatalog, classRoster where cl_name = ? and cl_cID = cla_cID")
    cursor.execute(you, [user])
    okay = cursor.fetchall()
    for i in okay:
        cName = i[0]
        cID = i[1]
        l = '{:}{:}{:}'.format(cName, "|", cID)
        print(l)
    
    choose = input("Please Select a Class (type classID): ")
    for i in okay:
        cId = i[1]
        if choose == cId and typ == "stu":
            stuAccess(_conn, user, ID, cId)


def stuAccess(_conn, user, p_ID, c_ID):
    with sqlite3.connect("scnDatabase.sqlite") as data:
        cursor = data.cursor()
    while user:
        print(" ")
        print("1. Show class roster")
        print("2. Check Registration requests")
        print("3. Class Notes")
        print("4. Change class view")
        print("5. Logout")
        choice = input("What would you like to do? ")
        print(" ")
        
        if choice == "1":
            print("success")
            cla = ("select cl_name from classRoster where cl_cId = ?")
            cursor.execute(cla, [c_ID])
            okay = cursor.fetchall()
            
            for i in okay: 
                clas = i[0]
                l = '{:<10}'.format(clas)
                print(l)
            
        
        if choice == "2":
            print("Success")
            cla = ("select cl_name from classRoster where p_name = ? and p_ID = ?")
            cursor.execute(cla, [user, p_ID])
            okay = cursor.fetchall()
            for i in okay:
                print("Looking at class roster for: " + i[0])
                print("\n")
                ros = ("select cl_name, cl_ID from classRoster, classCatalog where cla_Name = ? and cla_cID = cl_cID ")
                cursor.execute(ros, [i[0]])
                ter = cursor.fetchall()
                l = '{:<10}{:}{:>15}'.format("NAME", "|", "STUDENT ID")
                print(l)
                print("----------------------------")
                for i in ter:
                    name = i[0]
                    ID = i[1]
                    l = '{:<10}{:}{:>10}'.format(name, "|", ID)
                    print(l)
        
        if choice == "3":
            print("success")
            
        if choice == "4":
            print("success")
            ote = ("select * from notePages where n_cID = (Select cl_cID from classRoster where cl_ID = ?)")
            cursor.execute(ote, [p_ID])
            note = cursor.fetchall()
            l = '{:15}{:}{:}{:8}{:}{:}{:}{:}{:}'.format("DocName", "|", "ClassID", "|", "Time of Last", "|", "User Edit", "|", "Content")
            print(l)
            for i in note:
                name = i[0]
                time = i[1]
                cID = i[2]
                content = i[3]
                uID = i[4]
                l = '{:15}{:6}{:}{:}{:}{:}{:9}{:}{:}'.format(name, "|", cID, "|", time, "|", uID, "|", content)
                print(l)
        
        if choice == "5":
            print("success")
            los = ("select * from rosterToCatalog")
            cursor.execute(los)
            note = cursor.fetchall()
            l = '{:15}{:}{:12}{:}{:12}'.format("Class Name", "|", "Class ID", "|", "Professor Name")
            print(l)
            print("---------------------------------")
            for i in note:
                pName = i[0]
                cName = i[1]
                cID = i[2]
                l = '{:<15}{:}{:<12}{:}{:}'.format(cName, "|", cID, "|", pName)
                print(l)
        if choice == "6":
            login(_conn)
  
     
def profAccess(_conn, user, p_ID, typ):
    with sqlite3.connect("scnDatabase.sqlite") as data:
        cursor = data.cursor()
    while user:
        print("1. What classes do I teach?")
        print("2. Show class roster")
        print("3. Check Registration requests")
        print("4. View Class Notes")
        print("5. View class catalog")
        print("6. Logout")
        choice = input("What would you like to do? ")

        if choice == "1":
            print("success")
            cla = ("select p_class from professor where p_name = ? and p_ID = ?")
            cursor.execute(cla, [user, p_ID])
            okay = cursor.fetchall()
            for i in okay: 
                print("You are teaching: " + i[0])
                print("\n")
        
        if choice == "2":
            print("Success")
            cla = ("select p_class from professor where p_name = ? and p_ID = ?")
            cursor.execute(cla, [user, p_ID])
            okay = cursor.fetchall()
            for i in okay:
                print("Looking at class roster for: " + i[0])
                print("\n")
                ros = ("select cl_name, cl_ID from classRoster, classCatalog where cla_Name = ? and cla_cID = cl_cID ")
                cursor.execute(ros, [i[0]])
                ter = cursor.fetchall()
                l = '{:<10}{:}{:>15}'.format("NAME", "|", "STUDENT ID")
                print(l)
                print("----------------------------")
                for i in ter:
                    name = i[0]
                    ID = i[1]
                    l = '{:<10}{:}{:>10}'.format(name, "|", ID)
                    print(l)
        
        if choice == "3":
            print("success")
            
        if choice == "4":
            print("success")
            ote = ("select * from notePages where n_cID = (Select cl_cID from classRoster where cl_ID = ?)")
            cursor.execute(ote, [p_ID])
            note = cursor.fetchall()
            l = '{:15}{:}{:}{:8}{:}{:}{:}{:}{:}'.format("DocName", "|", "ClassID", "|", "Time of Last", "|", "User Edit", "|", "Content")
            print(l)
            for i in note:
                name = i[0]
                time = i[1]
                cID = i[2]
                content = i[3]
                uID = i[4]
                l = '{:15}{:6}{:}{:}{:}{:}{:9}{:}{:}'.format(name, "|", cID, "|", time, "|", uID, "|", content)
                print(l)
        
        if choice == "5":
            print("success")
            los = ("select * from rosterToCatalog")
            cursor.execute(los)
            note = cursor.fetchall()
            l = '{:15}{:}{:12}{:}{:12}'.format("Class Name", "|", "Class ID", "|", "Professor Name")
            print(l)
            print("---------------------------------")
            for i in note:
                pName = i[0]
                cName = i[1]
                cID = i[2]
                l = '{:<15}{:}{:<12}{:}{:}'.format(cName, "|", cID, "|", pName)
                print(l)
        if choice == "6":
            login(_conn)
            
def main():
    database = r"scnDatabase.sqlite"

    # create a database connection
    conn = openConnection(database)
    with conn:
        login(conn)

    closeConnection(conn, database)


if __name__ == "__main__":
    main()
