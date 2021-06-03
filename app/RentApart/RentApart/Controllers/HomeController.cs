using RentApart.Models.Apartment;
using RentApart.ViewModels;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace RentApart.Controllers
{
    public class HomeController : Controller
    {
        public ActionResult Index()
        {
            return View();
        }

        public ActionResult GetCities(string grad)
        {
            ApartmentModel db = new ApartmentModel();
            return Json(db.location.Where(x => x.Location1.StartsWith(grad)).Select(x => new
            {
                LocationId = x.Id,
                City = x.Location1
            }).OrderBy(x => x.LocationId).ToList(), JsonRequestBehavior.AllowGet);
        }

        public ActionResult GetApartments()
        {
            ApartmentModel db = new ApartmentModel();
            return Json(db.apartment.Where(x => x.Deleted == false).Select(x => new
            {
                ApartmentId = x.Id,
                AddressNumber = x.addressNumber.Number,
                Address = x.addressNumber.address.Address1,
                Lat = x.addressNumber.lat,
                Lng = x.addressNumber.lng,
                City = x.addressNumber.address.location.Location1,
                x.Price,
                x.Area,
                x.Rooms
            }).ToList(), JsonRequestBehavior.AllowGet);
        }

        public ActionResult GetFilter(decimal min, decimal max, int room, int minA, int maxA, string furn)
        {
            ApartmentModel db = new ApartmentModel();

            if (room == 0 && furn != "SVE")
            {
                return Json(db.apartment.Where(x => x.Price >= min && x.Price <= max && x.Area >= minA && x.Area <= maxA && x.Furnishing == furn).Select(x => new
                {
                    ApartmentId = x.Id,
                    AddressNumber = x.addressNumber.Number,
                    Address = x.addressNumber.address.Address1,
                    Lat = x.addressNumber.lat,
                    Lng = x.addressNumber.lng,
                    City = x.addressNumber.address.location.Location1,
                    x.Price,
                    x.Area,
                    x.Rooms,
                    x.Furnishing
                }).ToList(), JsonRequestBehavior.AllowGet);
            }
            else if (room > 0 && furn == "SVE")
            {
                return Json(db.apartment.Where(x => x.Price >= min && x.Price <= max && x.Area >= minA && x.Area <= maxA && x.Rooms == room).Select(x => new
                {
                    ApartmentId = x.Id,
                    AddressNumber = x.addressNumber.Number,
                    Address = x.addressNumber.address.Address1,
                    Lat = x.addressNumber.lat,
                    Lng = x.addressNumber.lng,
                    City = x.addressNumber.address.location.Location1,
                    x.Price,
                    x.Area,
                    x.Rooms,
                    x.Furnishing
                }).ToList(), JsonRequestBehavior.AllowGet);
            }
            else if (room == 0 && furn == "SVE")
            {
                return Json(db.apartment.Where(x => x.Price >= min && x.Price <= max && x.Area >= minA && x.Area <= maxA).Select(x => new
                {
                    ApartmentId = x.Id,
                    AddressNumber = x.addressNumber.Number,
                    Address = x.addressNumber.address.Address1,
                    Lat = x.addressNumber.lat,
                    Lng = x.addressNumber.lng,
                    City = x.addressNumber.address.location.Location1,
                    x.Price,
                    x.Area,
                    x.Rooms,
                    x.Furnishing
                }).ToList(), JsonRequestBehavior.AllowGet);
            }
            else
            {
                return Json(db.apartment.Where(x => x.Price >= min && x.Price <= max && x.Area >= minA && x.Area <= maxA && x.Rooms == room && x.Furnishing == furn).Select(x => new
                {
                    ApartmentId = x.Id,
                    AddressNumber = x.addressNumber.Number,
                    Address = x.addressNumber.address.Address1,
                    Lat = x.addressNumber.lat,
                    Lng = x.addressNumber.lng,
                    City = x.addressNumber.address.location.Location1,
                    x.Price,
                    x.Area,
                    x.Rooms,
                    x.Furnishing
                }).ToList(), JsonRequestBehavior.AllowGet);
            }
        }

        private List<ApartmentIndexViewModel.ApartmentViewModel> getApartments(ApartmentModel db)
        {

            var Apartments = db.apartment.Where(x => x.Deleted == false).Select(x => new
            {
                ApartmentId = x.Id,
                AddressNumber = x.addressNumber.address.Address1 + " " + x.addressNumber.Number,
                Address = x.addressNumber.address.Address1,// + " " + x.addressNumber.Number,  
                Number = x.addressNumber.Number,
                Description = x.Description,
                Rooms = x.Rooms,
                Floor = x.Floor,
                Location = x.addressNumber.address.location.Location1,
                type = x.type,
                Area = x.Area,
                Price = x.Price,
                Status = x.Status,
                NumberOfFloors = x.NumberOfFloors,
                YearOfConstruction = x.YearOfConstruction,
                Furnishing = x.Furnishing,
                NumberOfBathrooms = x.NumberOfBathrooms,
                NumberOfBedrooms = x.NumberOfBedrooms,
                DistanceFromCenter = x.DistanceFromCenter,
                Renovated = x.Renovated,
                Heating = x.Heating,
                Deposit = x.Deposit,
                MinimumLeaseLength = x.MinimumLeaseLength,
                PaymentDue = x.PaymentDue,
                Available = x.Available,
                MaximumNumberOfTenants = x.MaximumNumberOfTenants,
                Deleted = x.Deleted,
                Email = x.user.email,
                Pictures = x.pictures.Select(y => y.picture)
            }).AsEnumerable()
                 .Select(x => new ApartmentIndexViewModel.ApartmentViewModel
                 {

                     ApartmentId = x.ApartmentId,
                     Address = x.Address,
                     Number = x.Number,
                     Description = x.Description,
                     Rooms = x.Rooms,
                     Floor = x.Floor,
                     Location = x.Location,
                     type = x.type,
                     Area = x.Area,
                     Price = x.Price,
                     Status = x.Status,
                     NumberOfFloors = x.NumberOfFloors,
                     YearOfConstruction = x.YearOfConstruction,
                     Furnishing = x.Furnishing,
                     NumberOfBathrooms = x.NumberOfBathrooms,
                     NumberOfBedrooms = x.NumberOfBedrooms,
                     DistanceFromCenter = x.DistanceFromCenter,
                     Renovated = x.Renovated,
                     Heating = x.Heating,
                     Deposit = x.Deposit,
                     MinimumLeaseLength = x.MinimumLeaseLength,
                     PaymentDue = x.PaymentDue,
                     Available = x.Available,
                     MaximumNumberOfTenants = x.MaximumNumberOfTenants,
                     Deleted = x.Deleted,
                     Email = x.Email,
                     Pictures = x.Pictures.Select(y => Convert.ToBase64String(y)).ToList(),
                 })
                 .ToList();

            return Apartments;
        }


        public ActionResult Details(int Id)
        {

            ApartmentModel db = new ApartmentModel();

            var apartment = getApartments(db).FirstOrDefault(x => x.ApartmentId == Id);
            if (apartment == null)
            {
                return HttpNotFound();
            }
            ApartmentEditViewModel model = new ApartmentEditViewModel
            {
                ApartmentId = apartment.ApartmentId,
                type = apartment.type,
                Location = apartment.Location,
                Address = apartment.Address,
                Number = apartment.Number,
                Description = apartment.Description,
                Rooms = apartment.Rooms,
                Floor = apartment.Floor,
                Price = apartment.Price,
                NumberOfFloors = apartment.NumberOfFloors,
                YearOfConstruction = apartment.YearOfConstruction,
                Renovated = apartment.Renovated,
                Heating = apartment.Heating,
                Deposit = apartment.Deposit,
                MaximumNumberOfTenants = apartment.MaximumNumberOfTenants,
                Area = apartment.Area,
                Status = apartment.Status,
                Furnishing = apartment.Furnishing,
                NumberOfBathrooms = apartment.NumberOfBathrooms,
                NumberOfBedrooms = apartment.NumberOfBedrooms,
                DistanceFromCenter = apartment.DistanceFromCenter,
                MinimumLeaseLength = apartment.MinimumLeaseLength,
                PaymentDue = apartment.PaymentDue,
                Available = apartment.Available,
                Pictures = apartment.Pictures,
                Email = apartment.Email
            };
            return PartialView("Details", model);



        }

    }
}
