using ConsoleApp1.models;
using ConsoleApp1.repository;
namespace ConsoleApp1.service;

public class Service
{
    private IRepository<string, Echipa> echipaRepository;
    private IRepository<string, Elev> elevRepository;
    private IRepository<string ,Jucator> jucatorRepository;
    private IRepository<string, JucatorActiv> jucatorActivRepository;
    private IRepository<string, Meci> meciRepository;

    public Service(IRepository<string, Echipa> echipaRepository, IRepository<string, Elev> elevRepository, IRepository<string,Jucator> jucatorRepository, IRepository<string,JucatorActiv> jucatorActivRepository, IRepository<string,Meci> meciRepository)
    {
        this.echipaRepository = echipaRepository;
        this.elevRepository = elevRepository;
        this.jucatorRepository = jucatorRepository;
        this.jucatorActivRepository = jucatorActivRepository;
        this.meciRepository = meciRepository;
    }

    public List<Echipa> all()
    {
        return (List<Echipa>)echipaRepository.GetAll();
    }

    public List<Jucator> GetJucatoriiEchipei(string idEchipa)
    {
        Echipa echipa= echipaRepository.Get(idEchipa);
        return jucatorRepository.GetAll().Where(j => j.NumeEchipa == echipa.Nume).ToList();
    }

    public List<JucatorActiv> GetJucatoriiActiviEchipei(string idEchipa, string idMeci)
    {
        //Echipa echipa = echipaRepository.Get(idEchipa);
        //Jucator jucator = jucatorRepository.GetAll().Where(j => j.NumeEchipa == echipa.Nume);

        List<Jucator> jucatori = this.GetJucatoriiEchipei(idEchipa);
        return jucatorActivRepository.GetAll().Where(ja => jucatori.Contains(jucatorRepository.Get(ja.IdJucator)) && ja.IdMeci == idMeci).ToList();
    }

    public List<Meci> GetMeciurilePerioada(DateTime dataStart, DateTime dataEnd)
    {
        return meciRepository.GetAll().Where(m => m.Data >= dataStart && m.Data <= dataEnd).ToList();
    }

    public Tuple<string, int, int> GetScorMeci(string idMeci)
    {
        var meci = meciRepository.Get(idMeci);
        var echipa1 = echipaRepository.Get(meci.IDEchipa1);
        var echipa2 = echipaRepository.Get(meci.IDEchipa2);

        List<Jucator> jucatori1 = this.GetJucatoriiEchipei(echipa1.Id);
        List<Jucator> jucatori2 = this.GetJucatoriiEchipei(echipa2.Id);

        var puncteEchipa1 = jucatorActivRepository.GetAll().Where(ja => ja.IdMeci == idMeci && jucatori1.Contains(jucatorRepository.Get(ja.IdJucator))).Sum(ja => ja.NrPuncteInscrise);
        var puncteEchipa2 = jucatorActivRepository.GetAll().Where(ja => ja.IdMeci == idMeci && jucatori2.Contains(jucatorRepository.Get(ja.IdJucator))).Sum(ja => ja.NrPuncteInscrise);
        return Tuple.Create(echipa1.Nume + " - " + echipa2.Nume, puncteEchipa1, puncteEchipa2);
    }
}