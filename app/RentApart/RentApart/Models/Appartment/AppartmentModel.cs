using System;
using System.ComponentModel.DataAnnotations.Schema;
using System.Data.Entity;
using System.Linq;

namespace RentApart.Models.Appartment
{
    public partial class AppartmentModel : DbContext
    {
        public AppartmentModel()
            : base("name=RentApart")
        {
        }

        public virtual DbSet<address> address { get; set; }
        public virtual DbSet<addressNumber> addressNumber { get; set; }
        public virtual DbSet<apartment> apartment { get; set; }
        public virtual DbSet<country> country { get; set; }
        public virtual DbSet<district> district { get; set; }
        public virtual DbSet<location> location { get; set; }
        public virtual DbSet<municipality> municipality { get; set; }
        public virtual DbSet<options> options { get; set; }
        public virtual DbSet<pictures> pictures { get; set; }
        public virtual DbSet<region> region { get; set; }
        public virtual DbSet<user> user { get; set; }

        protected override void OnModelCreating(DbModelBuilder modelBuilder)
        {
            modelBuilder.Entity<addressNumber>()
                .Property(e => e.lat)
                .HasPrecision(8, 6);

            modelBuilder.Entity<addressNumber>()
                .Property(e => e.lng)
                .HasPrecision(9, 6);

            modelBuilder.Entity<apartment>()
                .Property(e => e.Price)
                .HasPrecision(10, 0);

            modelBuilder.Entity<apartment>()
                .Property(e => e.DistanceFromCenter)
                .HasPrecision(10, 0);

            modelBuilder.Entity<apartment>()
                .Property(e => e.Deposit)
                .HasPrecision(10, 0);

            modelBuilder.Entity<apartment>()
                .HasMany(e => e.options)
                .WithMany(e => e.apartment)
                .Map(m => m.ToTable("apartmentOptions").MapLeftKey("ApartmentId").MapRightKey("OptionId"));

            modelBuilder.Entity<apartment>()
                .HasMany(e => e.pictures)
                .WithMany(e => e.apartment)
                .Map(m => m.ToTable("apartmentPictures").MapLeftKey("ApartmentId").MapRightKey("PictureId"));
        }
    }
}
