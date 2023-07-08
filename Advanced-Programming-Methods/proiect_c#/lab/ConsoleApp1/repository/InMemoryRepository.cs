using ConsoleApp1.models;

namespace ConsoleApp1.repository;

public class InMemoryRepository<ID, E> : IRepository<ID, E> where E : Entitate<ID>
{
    protected IDictionary<ID, E> Entitati = new Dictionary<ID, E>();

    public InMemoryRepository()
    {

    }

    public E Get(ID id)
    {
        return Entitati[id];
    }

    public E Save(E e)
    {
        if (Entitati.ContainsKey(e.Id))
        {
            return e;
        }

        Entitati.Add(e.Id, e);
        return e;
    }

    public IEnumerable<E> GetAll()
    {
        return Entitati.Values.ToList<E>();
    }
    /*private List<T> _entities = new List<T>();

    public void Add(T entity)
    {
        _entities.Add(entity);
    }

    public void Remove(T entity)
    {
        _entities.Remove(entity);
    }

    public IEnumerable<T> GetAll()
    {
        return _entities;
    }

    public IEnumerable<T> GetByTeam(string teamName)
    {
        if (typeof(T) == typeof(Jucator))
        {
            return (IEnumerable<T>)_entities.OfType<Jucator>().Where(x => x.Echipa.Nume == teamName);
        }
        else if (typeof(T) == typeof(Meci))
        {
            return (IEnumerable<T>)_entities.OfType<Meci>().Where(x => x.Echipa1.Nume == teamName || x.Echipa2.Nume == teamName);
        }
        else
        {
            return Enumerable.Empty<T>();
        }
    }

    public IEnumerable<T> GetActivePlayersByTeam(string teamName, int matchId)
    {
        if (typeof(T) == typeof(FileRepoJucatorActiv))
        {
            var players = _entities.OfType<Jucator>().Where(x => x.Echipa.Nume == teamName);
            var activePlayers = _entities.OfType<FileRepoJucatorActiv>().Where(x => x.IdMeci == matchId && players.Any(p => p.Id == x.IdJucator.ToString()));
            return activePlayers.OfType<T>();
        }
        else
        {
            return Enumerable.Empty<T>();
        }
    }



    public IEnumerable<T> GetMatchesByDateRange(DateTime startDate, DateTime endDate)
    {
        if (typeof(T) == typeof(Meci))
        {
            return (IEnumerable<T>)_entities.OfType<Meci>().Where(x => x.Data >= startDate && x.Data <= endDate);
        }
        else
        {
            return Enumerable.Empty<T>();
        }
    }

    public Tuple<int, int> GetScoreByMatch(Echipa echipa1, Echipa echipa2, DateTime data)
    {
        var match = _entities.OfType<Meci>().FirstOrDefault(x => x.Echipa1 == echipa1 && x.Echipa2 == echipa2 && x.Data == data);
        if (match != null)
        {
            var players1 = _entities.OfType<Jucator>().Where(x => x.Echipa == match.Echipa1);
            var players2 = _entities.OfType<Jucator>().Where(x => x.Echipa == match.Echipa2);
            var team1Score = _entities.OfType<FileRepoJucatorActiv>().Where(x => players1.Any(p => p.Id == x.IdJucator.ToString())).Sum(x => x.NrPuncteInscrise);
            var team2Score = _entities.OfType<FileRepoJucatorActiv>().Where(x =>players2.Any(p => p.Id == x.IdJucator.ToString())).Sum(x => x.NrPuncteInscrise);
            return new Tuple<int, int>(team1Score, team2Score);
        }
        else
        {
            return new Tuple<int, int>(-1, -1);
        }
    }*/


}