namespace RentApart.Models.Appartment
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("apartment")]
    public partial class apartment
    {
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors")]
        public apartment()
        {
            options = new HashSet<options>();
            pictures = new HashSet<pictures>();
        }

        public int Id { get; set; }

        [StringLength(50)]
        [Display(Name = "Vrsta nekretnine")]
        public string type { get; set; }

        [Display(Name = "Broj Soba")]
        public int? Rooms { get; set; }

        [Display(Name = "Kvadratura prostora")]
        public int? Area { get; set; }

        [Display(Name = "Sprat")]
        public int? Floor { get; set; }

        [Display(Name = "Opis")]
        public string Description { get; set; }

        [Display(Name = "Cena")]
        public decimal? Price { get; set; }

        [StringLength(50)]
        public string Status { get; set; }

        [Display(Name = "Broj spratova u zgradi")]
        public int? NumberOfFloors { get; set; }

        [Display(Name = "Godina izgradnje")]
        public int? YearOfConstruction { get; set; }

        [StringLength(50)]
        [Display(Name = "Namestaj")]
        public string Furnishing { get; set; }

        [Display(Name = "Broj spavacih soba")]
        public int? NumberOfBedrooms { get; set; }

        [Display(Name = "Broj toaleta")]
        public int? NumberOfBathrooms { get; set; }

        [Display(Name = "Udaljenost od centra")]
        public decimal? DistanceFromCenter { get; set; }

        [Display(Name = "Renovirano")]
        public bool? Renovated { get; set; }

        [StringLength(50)]
        [Display(Name = "Grejanje")]
        public string Heating { get; set; }

        [Display(Name = "Depozit")]
        public decimal? Deposit { get; set; }

        [Display(Name = "Minimalno trajanje najma")]
        public int? MinimumLeaseLength { get; set; }

        [StringLength(50)]
        [Display(Name = "Krajnji rok za placanje")]
        public string PaymentDue { get; set; }

        [StringLength(50)]
        [Display(Name = "Dostupno")]
        public string Available { get; set; }

        [Display(Name = "Maksimalan broj stanara")]
        public int? MaximumNumberOfTenants { get; set; }

        [StringLength(50)]
        public string AddressNumberId { get; set; }

        public int? UserId { get; set; }

        [Display(Name = "Aktivan oglas")]
        public bool Deleted { get; set; }

        public virtual addressNumber addressNumber { get; set; }

        public virtual user user { get; set; }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<options> options { get; set; }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<pictures> pictures { get; set; }

    }
}
