namespace RentApart.Models.Apartment
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("addressNumber")]
    public partial class addressNumber
    {
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors")]
        public addressNumber()
        {
            apartment = new HashSet<apartment>();
        }

        [StringLength(50)]
        public string Id { get; set; }

        [StringLength(10)]
        [Display(Name = "Broj")]
        public string Number { get; set; }

        [StringLength(10)]
        public string NumberCyr { get; set; }

        [StringLength(50)]
        public string PlotNumberFull { get; set; }

        [StringLength(50)]
        public string PlotNumber { get; set; }

        [StringLength(5)]
        public string PlotSubNumber { get; set; }

        public DbGeography geo { get; set; }

        public decimal? lat { get; set; }

        public decimal? lng { get; set; }

        [StringLength(50)]
        public string AddressId { get; set; }

        public virtual address address { get; set; }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<apartment> apartment { get; set; }
    }
}
