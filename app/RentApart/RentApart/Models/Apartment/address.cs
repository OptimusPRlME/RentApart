namespace RentApart.Models.Apartment
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("address")]
    public partial class address
    {
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors")]
        public address()
        {
            addressNumber = new HashSet<addressNumber>();
        }

        [StringLength(50)]
        public string Id { get; set; }

        [Column("Address")]
        [Display(Name = "Adresa")]
        [StringLength(150)]
        public string Address1 { get; set; }

        [StringLength(150)]
        public string AddressCyr { get; set; }

        [StringLength(50)]
        public string LocationId { get; set; }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<addressNumber> addressNumber { get; set; }

        public virtual location location { get; set; }
    }
}
