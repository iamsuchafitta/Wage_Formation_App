using ConsoleApp1.Domain;
using ConsoleApp1.Repositories;
using Microsoft.Data.Sqlite;
using System;
using System.Collections.Generic;
using System.IO;

namespace ConsoleApp1.RepositoriesImplementations
{
    public class UsersRepository : IUsersRepository<User>
    {
        public UsersRepository()
        {
            if (File.Exists("myDatabase.db"))
                return;

            using var connection = new SqliteConnection("Data Source=myDatabase.db");

            connection.Open();

            var createTableSql = @"
                CREATE TABLE IF NOT EXISTS users (
                    id integer primary key autoincrement,
                    name varchar(20) NOT NULL,
                    age integer NOT NULL
                );";

            using var createCommand = new SqliteCommand(createTableSql, connection);

            createCommand.ExecuteNonQuery();

            var insertSql = @"INSERT INTO users (name, age) VALUES
                ('Иванов', 20),
                ('Петров', 15),
                ('Сидоров', 45),
                ('Петренко', 34),
                ('Петраевский', 77),                
                ('Николаев', 10)";

            using var insertCommand = new SqliteCommand(insertSql, connection);

            insertCommand.ExecuteNonQuery();
        }

        public User Add(User newUser)
        {
            using var connection = new SqliteConnection("Data Source=myDatabase.db");

            connection.Open();

            var insertUsersSql = $"INSERT INTO users (name, age) VALUES ($name, $age);";

            using var insertCommand = new SqliteCommand(insertUsersSql, connection);

            insertCommand.Parameters.AddWithValue("$name", newUser.Name);
            insertCommand.Parameters.AddWithValue("$age", newUser.Age);

            insertCommand.ExecuteNonQuery();

            return newUser; // !!!!
        }

        public void Delete(User existingUser) => throw new System.NotImplementedException();
        public User[] GetAll()
        {
            try
            {
                using var connection = new SqliteConnection("Data Source=myDatabase.db");

                connection.Open();

                var selectUsersSql = $"SELECT * FROM users;";

                using var selectCommand = new SqliteCommand(selectUsersSql, connection);

                //selectCommand.Parameters.AddWithValue("$name_pattern", pattern);

                using var reader = selectCommand.ExecuteReader();

                var users = new List<User>();

                while (reader.Read())
                {
                    var userId = reader.GetInt32(0);
                    var userName = reader.GetString(1);
                    var userAge = reader.GetInt32(2);

                    users.Add(new User(userId, userName, userAge));

                    //Console.WriteLine($"User: id: {userId}, name: {userName}, age: {userAge}");
                }

                return users.ToArray();
            }
            catch (SqliteException ex)
            {
                Console.WriteLine($"Проблема с базой данных: {ex.ToString()}");

                return new User[] { };
            }
            catch (Exception ex)
            {
                Console.WriteLine(ex.ToString());

                return new User[] { };
            }
        }
        public User GetById(int Id) => throw new System.NotImplementedException();
        public User Update(User existingUser) => throw new System.NotImplementedException();
    }
}
