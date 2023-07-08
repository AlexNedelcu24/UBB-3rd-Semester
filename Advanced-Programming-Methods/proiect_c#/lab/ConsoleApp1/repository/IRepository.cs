using ConsoleApp1.models;
namespace ConsoleApp1.repository;

public interface IRepository<ID, E> where E : Entitate<ID>
{
    E Save(E e);

    public E Get(ID id);

    IEnumerable<E> GetAll();

    /* void Add(T entity);
     void Remove(T entity);
     IEnumerable<T> GetAll();
     IEnumerable<T> GetByTeam(string teamName);
     IEnumerable<T> GetActivePlayersByTeam(string teamName, int matchId);
     IEnumerable<T> GetMatchesByDateRange(DateTime startDate, DateTime endDate);
     Tuple<int, int> GetScoreByMatch(Echipa echipa1, Echipa echipa2, DateTime data);*/
}

