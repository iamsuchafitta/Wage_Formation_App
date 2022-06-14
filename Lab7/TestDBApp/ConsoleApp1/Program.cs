using ConsoleApp1.Domain;
using ConsoleApp1.Repositories;
using ConsoleApp1.RepositoriesImplementations;
using System;

namespace ConsoleApp1
{
    class Program
    {
        static void Main(string[] args)
        {
            var usersRepository = new UsersRepository();

            var users = usersRepository.GetAll();

            ShowUsers(users);

            var newUser = CreateUser();

            usersRepository.Add(newUser);

            var updatedUsers = usersRepository.GetAll();

            ShowUsers(updatedUsers);
        }

        static void ShowUsers(User[] users)
        {
            foreach (var user in users)
            {
                Console.WriteLine(user);
            }
        }

        static User CreateUser()
        {
            Console.WriteLine("Введите имя пользователя:");

            var newUserName = Console.ReadLine();

            Console.WriteLine("Введите возраст пользователя:");

            var newUserAge = int.Parse(Console.ReadLine());

            return new User(newUserName, newUserAge);
        }
    }
}
