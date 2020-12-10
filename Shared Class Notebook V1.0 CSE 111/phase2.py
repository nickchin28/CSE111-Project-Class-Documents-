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
                print("Exited")
                exit()


def classList(_conn, user, ID, typ):
    with sqlite3.connect("scnDatabase.sqlite") as data:
        cursor = data.cursor()
    
    you = ("select cla_name, cla_cID from classCatalog, classRoster where cl_name = ? and cl_cID = cla_cID")
    cursor.execute(you, [user])
    okay = cursor.fetchall()
    claID = []
    l = '{:20}{:}{:5}'.format("Class Name", "|", "Class ID#")
    print(l)
    for i in okay:
        cName = i[0]
        cID = i[1]
        l = '{:20}{:}{:5}'.format(cName, "|", cID)
        claID.append(cID)
        print(l)
    
    print(claID)
    choose = int(input("Please Select a Class (type classID): "))
    for i in range(len(claID)):
        if choose == claID[i]:
            if(typ == 'stu'):
                stuAccess(_conn, user, ID, claID[i])
            if(typ == 'prof'):
                requests(_conn, user, claID[i], ID)


def classNotes(_conn, user, s_ID, c_ID):
    with sqlite3.connect("scnDatabase.sqlite") as data:
        cursor = data.cursor()
    while user:
        print(" ")
        print("1. Add Notes")
        print("2. Edit Notes")
        print("3. View specific notes")
        print("4. Exit from notes")
        choice = input("What would you like to do? ")
        print(" ")
        
        if choice == "1":
            name = input("Name of new of document: ")
            content = input("Start writing something: ")
            image = input("Would you like to include an image (y/n): ")
            sql = """INSERT into notepages (n_docName,n_timeStamp, n_cID, n_content, n_nID)
                    VALUES (?, dateTime(), ?, ?, ABS(RANDOM()) % (99 - 1) + 1 );"""
            cursor.execute(sql, [name, c_ID, content])
            print("success")
            if image == ("y" or "Y"):
                iname = input("Please input image name:")
                icontent = input("Please input image content: ")
                sql = """INSERT into images (i_docName,i_timeStamp, i_cID i_content, i_nID)
                    VALUES (?, dateTime(), ?, ?, ABS(RANDOM()) % (99 - 1) + 1 );"""
                cursor.execute(sql, [iname, c_ID, icontent])
                print("success")
            
        if choice == "2":
            neditID = input("Which note would you like to edit: ")
            name = input("Change name of document: ")
            content = input("Start writing something new: ")
            sql = """UPDATE notepages 
                    SET n_content = ?, 
                    n_timeStamp = dateTime(),
                    n_docName = ?
                    WHERE n_nID = ?;"""
            cursor.execute(sql, [content, name, neditID])

        if choice == "3":
            nID = input("Input the note ID: ")
            sql = """SELECT n_docName, n_timeStamp, n_content , n_cID, n_nID
                        FROM notePages
                        WHERE n_nID = ? ;"""
            cursor.execute(sql, [nID])
            row = cursor.fetchall
            header = '{:>10} {:<40} {:>10} {:>10} {:>10}'.format("DocName", "|", "TimeStamp", "|", "ClassID", "|", "Content", "|", "Note ID")
            print(header)

            for row in rows:
                data = '\n{:>10} {:<40} {:>10} {:>10} {:>10}'.format(row[0], row[1], row[2], row[3], row[4])
                print(data)

        if choice == "4":     
            print("sucess")
            stuAccess(_conn, user, s_ID, c_ID)
            
                                  
def stuAccess(_conn, user, s_ID, c_ID):
    with sqlite3.connect("scnDatabase.sqlite") as data:
        cursor = data.cursor()
    while user:
        
        wel = ("select cla_name from classCatalog where cla_cID = ?")
        cursor.execute(wel, [c_ID])
        okay = cursor.fetchall()
        print(" ")
        for i in okay:
            print("Welcome to: " + i[0])
            
        print("1. Show class roster")
        print("2. Class Notes")
        print("3. Change class view")
        print("4. Logout")
        choice = input("What would you like to do? ")
        print(" ")
        
        if choice == "1":
            print(" ")
            cla = ("select a_name, a_type from classRoster, account where a_ID = cl_ID AND cl_cID = ? group by a_type")
            cursor.execute(cla, [c_ID])
            okay = cursor.fetchall()
            l = '{:<10}{:}{:}'.format("Name", "|", "Type")
            print(l)
            print("----------------------------")
            for i in okay: 
                clas = i[0]
                typ = i[1]
                l = '{:<10}{:}{:}'.format(clas, "|", typ)
                print(l)
                   
        if choice == "2":
            print(" ")
            classNotes(_conn, user, s_ID, c_ID)
            
        if choice == "3":
            print("success")
            acctyp = ("select a_type from account where a_name = ? and a_ID = ?")
            cursor.execute(acctyp, [user, s_ID])
            ty = cursor.fetchall()
            
            for i in ty:
                typ = i[0]
                classList(_conn, user, s_ID, typ)
            
        if choice == "4":
            login(_conn)


def requests(_conn, user, c_ID, ID):
    with sqlite3.connect("scnDatabase.sqlite") as data:
        cursor = data.cursor()
    
    io = "select cla_name from classCatalog where cla_cID = ?"
    cursor.execute(io, [c_ID])
    okay = cursor.fetchall()
    cla = []
    
    for i in okay:
        name = i[0]
        cla.append(name)
        
    while user:
        print("Looking at tickets for: " + cla[0])
        print("1. View adding requests")
        print("2. View withdraw requests")
        print("3. Approve/Decline requests")
        print("4. Exit from requests")
        choice = input("Choose an option: ")
        
        if choice == "1":
            print(" ")
            add = ("select t_Name, t_ID, t_cID, t_Action from ticket where t_pName = ? and t_cID = ? and t_Action like 'ADD' ")
            cursor.execute(add, [user, c_ID])
            okay = cursor.fetchall()
            l = '{:<15}{:}{:>15}{:}{:>15}{:}{:}'.format("Student Name", "|", "Student ID", "|", "Class ID", "|", "Action")
            print(l)
            for i in okay:
                sName = i[0]
                sID = i[1]
                cID = i[2]
                action = i[3]
                l = '{:<15}{:}{:>15}{:}{:>15}{:}{:}'.format(sName, "|", sID, "|", cID, "|", action)
                print(l)
            print(" ")

        if choice == 2:
            print(" ")
            dele = ("select t_Name, t_ID, t_cID, t_Action from ticket where t_pName = ? and t_cID = ? and t_Action like 'Delete' ")
            cursor.execute(dele, [user, c_ID])
            okay = cursor.fetchall()
            print("Requests for: ")
            for i in okay:
                sName = i[0]
                sID = i[1]
                cID = i[2]
                action = i[3]
                l = '{:<10}{:}{:>15}{:}{:>15}{:}{:}'.format(sName, "|", sID, "|", cID, "|", action)
                print(l)
            print(" ")

        if choice == "3":
            add = ("select t_Name, t_ID, t_cID, t_Action from ticket where t_pName = ? and t_cID = ? ")
            cursor.execute(add, [user, c_ID])
            okay = cursor.fetchall()
            l = '{:<15}{:}{:>15}{:}{:>15}{:}{:}'.format("Student Name", "|", "Student ID", "|", "Class ID", "|", "Action")
            print(l)
            for i in okay:
                sName = i[0]
                sID = i[1]
                cID = i[2]
                action = i[3]
                l = '{:<15}{:}{:>15}{:}{:>15}{:}{:}'.format(sName, "|", sID, "|", cID, "|", action)
                print(l)
            judgement(_conn, okay)
            print(" ")
        
        if choice == "4":
            print(" ")
            typ = "prof"
            profAccess(_conn, user, ID, typ) 
 
        
def judgement(_conn, okay):
    
    cur = _conn.cursor()
    print("1. Approve")
    print("2. Deny")
    choice = input("Approve or Deny: ")
    
    if choice == "1" or choice == "Approve":       
        ID = int(input("Student ID of Ticket: "))
        for i in okay:
            sName = i[0]
            sID = i[1]
            cID = i[2]

            sql = "insert into classRoster(cl_name, cl_ID, cl_cID) values (?, ?, ?)"
            ls = "delete from ticket where t_ID = ? and t_cID = ?"
            sl = "delete from request where r_ID = ? and r_cID = ?"
            cur.execute(sql, [sName, ID, cID])
            cur.execute(ls, [ID, cID])
            cur.execute(sl, [ID, cID])
            print("success")
    
    if choice == "2" or choice == "Delete":      
        ID = input("Student ID of Ticket: ")
        for i in okay:
            sName = i[0]
            sID = i[1]
            cID = i[2]
            
            ls = "delete from ticket where t_ID = ? and t_cID = ?"
            sl = "delete from request where r_ID = ? and r_cID = ?"
            cursor.execute(ls, [sID, cID])
            cursor.execute(sl, [sID, cID])
            print("success")
    
def profAccess(_conn, user, p_ID, typ):
    with sqlite3.connect("scnDatabase.sqlite") as data:
        cursor = data.cursor()
        
    while user:
        print("1. What classes do I teach?")
        print("2. Show all your class rosters")
        print("3. Check Registration requests")
        print("4. View Class Notes")
        print("5. View class catalog")
        print("6. Logout")
        choice = input("What would you like to do? ")

        if choice == "1":
            print(" ")
            cla = ("select p_class from professor where p_name = ? and p_ID = ?")
            cursor.execute(cla, [user, p_ID])
            okay = cursor.fetchall()
            print("You are teaching: ")
            for i in okay:
                print(i[0])
    
            print(" ")
        
        if choice == "2":
            print(" ")
            cla = ("select p_class from professor where p_name = ? and p_ID = ?")
            cursor.execute(cla, [user, p_ID])
            okay = cursor.fetchall()
            for i in okay:
                
                ros = ("select cla_name, cl_name, cl_ID, a_type from classRoster, classCatalog,account where cla_Name = ? and cla_cID = cl_cID and cl_ID = a_ID")
                cursor.execute(ros, [i[0]])
                ter = cursor.fetchall()
                l = '{:<10}{:}{:>15}{:}{:>15}{:}{:>15}'.format("Class", "|", "NAME", "|", "USER ID", "|", "TYPE")
                print(l)
                print("----------------------------------------------------------")
                for i in ter:
                    cla = i[0]
                    name = i[1]
                    ID = i[2]
                    ty = i[3]
                    l = '{:<10}{:}{:>15}{:}{:>15}{:}{:>15}'.format(cla, "|", name, "|", ID, "|", ty)
                    print(l)
                print("")
        
        if choice == "3":
            print(" ")
            classList(_conn, user, p_ID, typ)
            
            
        if choice == "4":
            print(" ")
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
            print(" ")
            los = ("select * from rosterToCatalog group by rtc_cID")
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
        judgement(conn)

    closeConnection(conn, database)


if __name__ == "__main__":
    main()



