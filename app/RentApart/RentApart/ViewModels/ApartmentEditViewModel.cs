using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace RentApart.ViewModels
{
    public class ApartmentEditViewModel : ApartmentIndexViewModel.ApartmentViewModel
    {
        public int UserId { get; set; }
        public string Email { get; set; }
    }
}