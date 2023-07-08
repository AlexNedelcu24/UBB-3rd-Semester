
using ConsoleApp1.cons;
using ConsoleApp1.models;
using ConsoleApp1.repository;
using ConsoleApp1.service;

public class Program
{
    public static void Main(string[] args)
    {
        IRepository<string, Echipa> repository1 =
            new FileRepoEchipa("G:\\Anul 2\\MAP\\C#\\lab14\\lab14\\lab14\\ConsoleApp1\\data\\echipe.txt");
        IRepository<string, Elev> repository2 =
            new FileRepoElev("G:\\Anul 2\\MAP\\C#\\lab14\\lab14\\lab14\\ConsoleApp1\\data\\elevi.txt");
        IRepository<string, Jucator> repository3 =
            new FileRepoJucator("G:\\Anul 2\\MAP\\C#\\lab14\\lab14\\lab14\\ConsoleApp1\\data\\jucatori.txt");
        IRepository<string, JucatorActiv> repository4 =
            new FileRepoJucatorActiv("G:\\Anul 2\\MAP\\C#\\lab14\\lab14\\lab14\\ConsoleApp1\\data\\jucatoriactivi.txt");
        IRepository<string, Meci> repository5 =
            new FileRepoMeci("G:\\Anul 2\\MAP\\C#\\lab14\\lab14\\lab14\\ConsoleApp1\\data\\meciuri.txt");

        Service service = new Service(repository1, repository2, repository3, repository4, repository5);
        
       
        Consola consola = new Consola(service);

        consola.Start();
        
        
    }

        
}
