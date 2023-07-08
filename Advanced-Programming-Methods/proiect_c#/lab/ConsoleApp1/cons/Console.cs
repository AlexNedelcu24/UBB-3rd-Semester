using ConsoleApp1.models;
using ConsoleApp1.service;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.Intrinsics.Arm;
using System.Text;
using System.Threading.Tasks;

namespace ConsoleApp1.cons;
public class Consola
 {
    private Service service;

    
    public Consola(Service service)
    {
        this.service = service;
    }

    public void Start()
    {
        while (true)
        {
            //Console.WriteLine(service.all()[1]);
            Console.WriteLine(" ");
            Console.WriteLine(" ");
            Console.WriteLine("Alege o optiune: ");
            Console.WriteLine("1. Afiseaza jucatorii unei echipe date");
            Console.WriteLine("2. Afiseaza jucatorii activi ai unei echipe de la un anumit meci");
            Console.WriteLine("3. Afiseaza toate meciurile dintr-o anumita perioada calendaristica");
            Console.WriteLine("4. Afiseaza scorul de la un anumit meci");

            int option = int.Parse(Console.ReadLine());
            switch (option)
            {
                case 1:
                    Console.WriteLine("Introduceti ID-ul echipei: ");
                    string idEchipa = Console.ReadLine();
                    Console.WriteLine("Jucatorii echipei " + idEchipa + " sunt: ");
                    foreach (Jucator jucator in service.GetJucatoriiEchipei(idEchipa))
                    {
                        Console.WriteLine(jucator);
                    }
                    break;
                case 2:
                    Console.WriteLine("Introduceti ID-ul echipei: ");
                    idEchipa = Console.ReadLine();
                    Console.WriteLine("Introduceti ID-ul meciului: ");
                    string idMeci = Console.ReadLine();
                    Console.WriteLine("Jucatorii activi ai echipei " + idEchipa + " la meciul " + idMeci + " sunt: ");
                    foreach (JucatorActiv jucatorActiv in service.GetJucatoriiActiviEchipei(idEchipa, idMeci))
                    {
                        Console.WriteLine(jucatorActiv);
                    }
                    break;
                case 3:
                    Console.WriteLine("Introduceti data de inceput (dd/mm/yyyy): ");
                    DateTime dataInceput = DateTime.Parse(Console.ReadLine());
                    Console.WriteLine("Introduceti data de sfarsit (dd/mm/yyyy): ");
                    DateTime dataSfarsit = DateTime.Parse(Console.ReadLine());
                    Console.WriteLine("Meciurile din perioada " + dataInceput + " - " + dataSfarsit + " sunt: ");
                    foreach (Meci meci in service.GetMeciurilePerioada(dataInceput, dataSfarsit))
                    {
                        Console.WriteLine(meci);
                    }
                    break;
                case 4:
                    Console.WriteLine("Introduceti ID-ul meciului: ");
                    idMeci = Console.ReadLine();
                    Console.WriteLine("Scorul meciului " + idMeci + " este: " + service.GetScorMeci(idMeci));
break;
                default:
                    Console.WriteLine("Optiune invalida");
                    break;
            }
        }
    }
}
    
 
                        
   
