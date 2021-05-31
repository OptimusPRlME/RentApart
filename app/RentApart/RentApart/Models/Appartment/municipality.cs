namespace RentApart.Models.Appartment
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("municipality")]
    public partial class municipality
    {
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors")]
        public municipality()
        {
            location = new HashSet<location>();
        }

        [DatabaseGenerated(DatabaseGeneratedOption.None)]
        public int Id { get; set; }

        [Column("Municipality")]
        [StringLength(50)]
        public string Municipality1 { get; set; }

        [StringLength(50)]
        public string MunicipalityCyr { get; set; }

        public int? DistrictId { get; set; }

        public virtual district district { get; set; }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<location> location { get; set; }
    }
}
