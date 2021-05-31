using RentApart.Models.Appartment;
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
            AppartmentModel db = new AppartmentModel();
            return Json(db.location.Where(x => x.Location1.StartsWith(grad)).Select(x => new
            {
                LocationId = x.Id,
                City = x.Location1
            }).OrderBy(x => x.LocationId).ToList(), JsonRequestBehavior.AllowGet);
        }

        public ActionResult GetApartments()
        {
            AppartmentModel db = new AppartmentModel();
            return Json(db.apartment.Select(x => new
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

        public ActionResult GetFilter(decimal min, decimal max, int room, int minA, int maxA, string furn )
        {
            AppartmentModel db = new AppartmentModel();

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

        public ActionResult Details(int Id)
        {
            AppartmentModel db = new AppartmentModel();
            var ap = db.apartment.Find(Id);
            return PartialView("Details", ap);
        }

    }
}
