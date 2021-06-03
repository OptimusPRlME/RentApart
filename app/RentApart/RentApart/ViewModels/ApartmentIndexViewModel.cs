using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace RentApart.ViewModels
{
    public class ApartmentIndexViewModel
    {
        public ApartmentIndexViewModel()
        {
            Apartments = new List<ApartmentViewModel>();
        }
        public int UserId { get; set; }

        public List<ApartmentViewModel> Apartments { get; set; }

        public class ApartmentViewModel
        {
            public ApartmentViewModel()
            {
                Pictures = new List<string>();
            }

            public int ApartmentId { get; set; }

            [Display(Name = "Vrsta nekretnine")]

            public string type { get; set; }

            [Display(Name = "Grad")]
            [Required(ErrorMessage = "Molimo unesite grad")]
            public string Location { get; set; }

            [Display(Name = "Adresa")]
            [Required(ErrorMessage = "Molimo unesite adresu")]
            public string Address { get; set; }

            [Display(Name = "Broj")]
            [Required(ErrorMessage = "Molimo unesite broj")]
            public string Number { get; set; }

            [Display(Name = "Opis")]
            public string Description { get; set; }

            [Display(Name = "Broj Soba")]
            [Required(ErrorMessage = "Molimo unesite broj soba")]
            public int? Rooms { get; set; }

            [Display(Name = "Sprat")]
            public int? Floor { get; set; }

            [Display(Name = "Cena")]
            [Required(ErrorMessage = "Molimo unesite cenu")]
            public decimal? Price { get; set; }

            [Display(Name = "Broj spratova u zgradi")]
            public int? NumberOfFloors { get; set; }

            [Display(Name = "Godina izgradnje")]
            public int? YearOfConstruction { get; set; }

            [Display(Name = "Renoviran stan")]
            public bool? Renovated { get; set; }

            [Display(Name = "Grejanje")]
            public string Heating { get; set; }

            [Display(Name = "Visina depozita")]
            public decimal? Deposit { get; set; }

            [Display(Name = "Maksimalan broj stanara")]
            public int? MaximumNumberOfTenants { get; set; }

            [Display(Name = "Nameštenost")]
            [Required(ErrorMessage = "Molimo unesite nameštenost")]
            public string Furnishing { get; set; }

            [Display(Name = "Kvadratura prostora")]
            [Required(ErrorMessage = "Molimo unesite kvadraturu")]
            public int? Area { get; set; }

            [Display(Name = "Status")]
            public string Status { get; set; }

            [Display(Name = "Broj spavaćih soba")]
            public int? NumberOfBedrooms { get; set; }

            [Display(Name = "Broj toaleta")]
            public int? NumberOfBathrooms { get; set; }

            [Display(Name = "Udaljenost od centra (u metrima)")]
            public decimal? DistanceFromCenter { get; set; }

            [Display(Name = "Minimalno trajanje najma")]
            public int? MinimumLeaseLength { get; set; }

            [Display(Name = "Krajnji rok za plaćanje")]
            [DisplayFormat(ApplyFormatInEditMode = true, DataFormatString = "{0:dd/MM/yyyy}")]
            public string PaymentDue { get; set; }

            [Display(Name = "Dostupno")]
            public string Available { get; set; }

            [Display(Name = "E-mail")]
            public string Email { get; set; }

            [Display(Name = "Aktivan oglas")]
            public bool? Deleted { get; set; }

            public List<string> Pictures { get; set; }

            public string AddressNumberId { get; set; }

        }

    }
}