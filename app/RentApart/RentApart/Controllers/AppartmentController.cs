using Microsoft.AspNet.Identity;
using RentApart.Models.Appartment;
using RentApart.ViewModels;
using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.Mvc;

namespace RentApart.Controllers
{
    public class AppartmentController : Controller
    {
        // GET: Appartment
        public ActionResult Index()
        {
            AppartmentIndexViewModel model = new AppartmentIndexViewModel();

            var user = User.Identity.GetUserId();
            using (AppartmentModel db = new AppartmentModel())
            {
                model.UserId = db.user.FirstOrDefault(x => x.UserId == user).Id;
                model.Appartments = getAppartments(db, model.UserId);
                
            }
            return View(model);
        }

        private List<AppartmentIndexViewModel.AppartmentViewModel> getAppartments(AppartmentModel db, int userId)
        {

            var appartments = db.apartment.Where(x => x.UserId == userId && x.Deleted == false).Select(x => new
            {
                AppartmentId = x.Id,
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
                Pictures = x.pictures.Select(y => y.picture)
            }).AsEnumerable()
                 .Select(x => new AppartmentIndexViewModel.AppartmentViewModel
                 {

                     AppartmentId = x.AppartmentId,
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
                     Pictures = x.Pictures.Select(y => Convert.ToBase64String(y)).ToList(),
                 })
                 .ToList();

            return appartments;
        }



        public ActionResult ShowDeleted()
        {
            AppartmentIndexViewModel model = new AppartmentIndexViewModel();

            var user = User.Identity.GetUserId();
            using (AppartmentModel db = new AppartmentModel())
            {
                model.UserId = db.user.FirstOrDefault(x => x.UserId == user).Id;
                model.Appartments = db.apartment.Where(x => x.UserId == model.UserId && x.Deleted == true).Select(x => new AppartmentIndexViewModel.AppartmentViewModel
                {
                    AppartmentId = x.Id,
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
                }).ToList();
            }
            return View(model);
        }


        //// GET: Appartment/Details/5
        //public ActionResult Details(int id)
        //{
        //    return View();
        //}

        // GET: Appartment/Create
        public ActionResult Create()
        {
            return View();
        }


        // POST: Appartment/Create
        [HttpPost]
        public ActionResult Create(AppartmentIndexViewModel.AppartmentViewModel model)
        {
            try
            {
                // TODO: Add insert logic here

                var user = User.Identity.GetUserId();
                using (AppartmentModel db = new AppartmentModel())
                {
                    int userId = db.user.FirstOrDefault(x => x.UserId == user).Id;
                    //int addNum = db.user.FirstOrDefault(x => x.AddressNumberId == AddressNumberId).Id;

                    string addNum = model.Number;// db.addressNumber.FirstOrDefault(x => (x.address.location.Location1 == model.Location || x.address.location.LocationCyr == model.Location) && x.address.Address1 == model.Address && (x.Number == model.Number || x.NumberCyr == model.Number))?.Id;

                    apartment _apartment = new apartment
                    {
                        Description = model.Description,
                        UserId = userId,
                        AddressNumberId = addNum,
                        Rooms = model.Rooms,
                        Floor = model.Floor,
                        Price = model.Price,
                        NumberOfFloors = model.NumberOfFloors,
                        YearOfConstruction = model.YearOfConstruction,
                        Renovated = model.Renovated,
                        Heating = model.Heating,
                        Deposit = model.Deposit,
                        MaximumNumberOfTenants = model.MaximumNumberOfTenants,
                        type = model.type,
                        Area = model.Area,
                        Status = model.Status,
                        Furnishing = model.Furnishing,
                        NumberOfBathrooms = model.NumberOfBathrooms,
                        NumberOfBedrooms = model.NumberOfBedrooms,
                        DistanceFromCenter = model.DistanceFromCenter,
                        MinimumLeaseLength = model.MinimumLeaseLength,
                        PaymentDue = model.PaymentDue,
                        Available = model.Available,
                        
                        
                    };
                    db.apartment.Add(_apartment);
                    db.SaveChanges();
                }

                ViewBag.Location = new SelectList(db.location, "Id", "Location1", model.Location);
                return RedirectToAction("Index");
            }
            catch
            {
                return View();
            }
        }

        public ActionResult Edit(int? id)
        {
            var user = User.Identity.GetUserId();
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            int userId = db.user.FirstOrDefault(x => x.UserId == user).Id;
            var apartment = getAppartments(db, userId).FirstOrDefault(x => x.AppartmentId == id);
            if (apartment == null)
            {
                return HttpNotFound();
            }
            AppartmentEditViewModel model = new AppartmentEditViewModel
            {
                UserId = userId,
                AppartmentId = apartment.AppartmentId,
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

            };
            return View(model);
        }

        // POST: Appartment/Edit/5        
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit(AppartmentEditViewModel model)
        {
            if (ModelState.IsValid)
            {
                using (AppartmentModel db = new AppartmentModel())
                {

                var user = User.Identity.GetUserId();
                int userId = db.user.FirstOrDefault(x => x.UserId == user).Id;
                if (userId == model.UserId)
                {
                    string addNum = db.addressNumber.FirstOrDefault(x => (x.address.location.Location1 == model.Location || x.address.location.LocationCyr == model.Location) && x.address.Address1 == model.Address && (x.Number == model.Number || x.NumberCyr == model.Number))?.Id;

                apartment _apartment = db.apartment.Find(model.AppartmentId);
                 _apartment.type = model.type;
                _apartment.AddressNumberId = addNum;
                _apartment.Description = model.Description;
                _apartment.Rooms = model.Rooms;
                _apartment.Floor = model.Floor;
                _apartment.Price = model.Price;
                _apartment.NumberOfFloors = model.NumberOfFloors;
                _apartment.YearOfConstruction = model.YearOfConstruction;
                _apartment.Renovated = model.Renovated;
                _apartment.Heating = model.Heating;
                _apartment.Deposit = model.Deposit;
                _apartment.MaximumNumberOfTenants = model.MaximumNumberOfTenants;
                _apartment.Area = model.Area;
                _apartment.Status = model.Status;
                _apartment.Furnishing = model.Furnishing;
                _apartment.NumberOfBathrooms = model.NumberOfBathrooms;
                _apartment.NumberOfBedrooms = model.NumberOfBedrooms;
                _apartment.DistanceFromCenter = model.DistanceFromCenter;
                _apartment.MinimumLeaseLength = model.MinimumLeaseLength;
                _apartment.PaymentDue = model.PaymentDue;
                _apartment.Available = model.Available;



                db.Entry(_apartment).State = EntityState.Modified;
                db.SaveChanges();
                return RedirectToAction("Index");

                    }
                }
            }
            return View(model);
        }










        // GET: Appartment/Edit/5
        //public ActionResult Edit(int? id)
        //{
        //    if (id == null)
        //    {
        //        return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
        //    }
        //    apartment apartment = db.apartment.Find(id);
        //    if (apartment == null)
        //    {
        //        return HttpNotFound();
        //    }
        //    ViewBag.AddressNumberId = new SelectList(db.addressNumber, "Id", "Number", apartment.AddressNumberId);
        //    ViewBag.UserId = new SelectList(db.user, "Id", "email", apartment.UserId);
        //    return View(apartment);
        //}

        //// POST: Appartment/Edit/5        
        //[HttpPost]
        //[ValidateAntiForgeryToken]
        //public ActionResult Edit([Bind(Include = "Id,type,Rooms,Area,Floor,Description,Price,Status,NumberOfFloors,YearOfConstruction,Furnishing,NumberOfBedrooms,NumberOfBathrooms,DistanceFromCenter,Renovated,Heating,Deposit,MinimumLeaseLength,PaymentDue,Available,MaximumNumberOfTenants,AddressNumberId,UserId,Deleted")] apartment apartment)
        //{
        //    if (ModelState.IsValid)
        //    {
        //        db.Entry(apartment).State = EntityState.Modified;
        //        db.SaveChanges();
        //        return RedirectToAction("Index");
        //    }
        //    ViewBag.AddressNumberId = new SelectList(db.addressNumber, "Id", "Number", apartment.AddressNumberId);
        //    ViewBag.UserId = new SelectList(db.user, "Id", "email", apartment.UserId);
        //    return View(apartment);
        //}

        //GET: Appartment/Delete/5
        public ActionResult Delete(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            apartment apartment = db.apartment.Find(id);
            if (apartment == null)
            {
                return HttpNotFound();
            }
            return View(apartment);
        }

        //[HttpGet]
        //public ActionResult Delete(string Id)
        //{
        //    db.pictures.Remove(db.pictures.Find(Id));
        //    db.SaveChanges();
        //    return View("Index", db.pictures.ToList());
        //}

        //public ActionResult DeletePicture(int? id)
        //{
        //    if (id == null)
        //    {
        //        return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
        //    }
        //    pictures pictures = db.pictures.Find(id);
        //         if (pictures == null)
        //    {
        //        return HttpNotFound();
        //    }
        //    return View(pictures);
        //}

        //[HttpPost, ActionName("Delete")]
        //[ValidateAntiForgeryToken]
        //public ActionResult DeletePictureConfirmed([Bind(Include = "Id,picture,extension,base6")] pictures pictures)
        //{
        //    if (ModelState.IsValid)
        //    {
        //        db.Entry(pictures).State = EntityState.Modified;
        //        db.SaveChanges();
        //        return RedirectToAction("Index");
        //    }
        //    return View(pictures);
        //}

        //[HttpPost, ActionName("Delete")]
        //[ValidateAntiForgeryToken]
        //public ActionResult DeleteConfirmed(int id)
        //{
        //    apartment apartment = db.apartment.Find(id);
        //    db.apartment.Remove(apartment);
        //    db.SaveChanges();
        //    return RedirectToAction("Index");
        //}

        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteConfirmed([Bind(Include = "Id,type,Rooms,Area,Floor,Description,Price,Status,NumberOfFloors,YearOfConstruction,Furnishing,NumberOfBedrooms,NumberOfBathrooms,DistanceFromCenter,Renovated,Heating,Deposit,MinimumLeaseLength,PaymentDue,Available,MaximumNumberOfTenants,AddressNumberId,UserId,Deleted")] apartment apartment)
        {
            if (ModelState.IsValid)
            {
                db.Entry(apartment).State = EntityState.Modified;
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            return View(apartment);
        }

        public ActionResult Activate(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            apartment apartment = db.apartment.Find(id);
            if (apartment == null)
            {
                return HttpNotFound();
            }
            return View(apartment);
        }

        [HttpPost, ActionName("Activate")]
        [ValidateAntiForgeryToken]
        public ActionResult ActivateConfirmed([Bind(Include = "Id,type,Rooms,Area,Floor,Description,Price,Status,NumberOfFloors,YearOfConstruction,Furnishing,NumberOfBedrooms,NumberOfBathrooms,DistanceFromCenter,Renovated,Heating,Deposit,MinimumLeaseLength,PaymentDue,Available,MaximumNumberOfTenants,AddressNumberId,UserId,Deleted")] apartment apartment)
        {
            if (ModelState.IsValid)
            {
                db.Entry(apartment).State = EntityState.Modified;
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            return View(apartment);
        }






        private AppartmentModel db = new AppartmentModel();
        [HttpPost]
        public ActionResult AddPicture(HttpPostedFileBase file, int appartmentId)
        {
            if (file != null)
            {
                string ImageName = System.IO.Path.GetFileName(file.FileName);
                byte[] uploadedFile = new byte[file.InputStream.Length];
                file.InputStream.Read(uploadedFile, 0, uploadedFile.Length);

                pictures item = new pictures();
                item.picture = uploadedFile;
                //newRecord.Picture = Convert.FromBase64String(file);
               // db.Entry(item).State = EntityState.Modified;
                var appartment = db.apartment.Find(appartmentId);
                appartment.pictures.Add(item);
                db.SaveChanges();

            }
            //Display records
            return RedirectToAction("Edit", new { id = appartmentId });
        }


        public ActionResult GetCities(string grad)
        {
            AppartmentModel db = new AppartmentModel();
            return Json(db.location.Where(x => x.Location1.StartsWith(grad)).Select(x => new
            {
                LocationId = x.Id,
                City = x.Location1,
                Mun = x.municipality.Municipality1
            }).OrderBy(x => x.LocationId).ToList(), JsonRequestBehavior.AllowGet);
        }

        public ActionResult GetAddress(string adresa, string cityId)
        {
            AppartmentModel db = new AppartmentModel();
            return Json(db.address.Where(x => x.Address1.StartsWith(adresa) && x.LocationId == cityId).Select(x => new
            {
                AddressId = x.Id,
                Address1 = x.Address1
            }).OrderBy(x => x.AddressId).ToList(), JsonRequestBehavior.AllowGet);
        }

        public ActionResult GetNumber(string broj, string addressId)
        {
            AppartmentModel db = new AppartmentModel();
            return Json(db.addressNumber.Where(x => x.Number.StartsWith(broj) && x.AddressId == addressId).Select(x => new
            {
                NumberId = x.Id,
                Number = x.Number
            }).OrderBy(x => x.NumberId).ToList(), JsonRequestBehavior.AllowGet);
        }






        //public ActionResult Display()
        //{
        //    return View("FileUpload");
        //}
    }
}
