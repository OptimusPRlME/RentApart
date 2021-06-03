namespace RentApart.Models.Apartment
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("location")]
    public partial class location
    {
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors")]
        public location()
        {
            address = new HashSet<address>();
        }

        [StringLength(50)]
        public string Id { get; set; }

        [Column("Location")]
        [StringLength(50)]
        [Display(Name = "Grad")]
        public string Location1 { get; set; }

        [StringLength(50)]
        public string LocationCyr { get; set; }

        public int? MunicipalityId { get; set; }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<address> address { get; set; }

        public virtual municipality municipality { get; set; }
    }
}
