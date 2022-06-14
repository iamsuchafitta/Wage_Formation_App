using ConsoleApp1.Domain;

namespace ConsoleApp1.Repositories
{
    public interface IUsersRepository<T>
    {
        T[] GetAll();

        T GetById(int Id);

        T Add(T newUser);

        T Update(T existingUser);

        void Delete(T existingUser);
    }
}
