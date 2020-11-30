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
                print("Hello " + i[1])
                print("Login successful")
                dist = ("select a_type from account where a_ID = ?")
                cursor.execute(dist, [(i[3])])
                fol = cursor.fetchall()
                if i[3] == "prof":
                    cla = ("select * from professor where p_name = ?")
                    cursor.execute(cla, [(user)])
                    fol = cursor.fetchall()
                    for j in fol:
                        profAccess(_conn, user , j[2])
                    
                    
            return("exit")
        else:
            print("User or password is incorrect")
            again = input("Would you like logging in again? (y/n): ")
            if again.lower() == "n":
                print("exited")
                break   


def profAccess(_conn, user, p_ID):
    with sqlite3.connect("scnDatabase.sqlite") as data:
        cursor = data.cursor()
    while user:
        print("1. What classes do I teach?")
        print("2. Show class roster")
        print("3. Check Registration requests")
        print("4. View Class Notes")
        print("4. View class catalog")
        print("5. Logout")
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
    


def main():
    database = r"scnDatabase.sqlite"

    # create a database connection
    conn = openConnection(database)
    with conn:
        login(conn)

    closeConnection(conn, database)


if __name__ == "__main__":
    main()
