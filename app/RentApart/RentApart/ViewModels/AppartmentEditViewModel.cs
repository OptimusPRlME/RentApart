using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace RentApart.ViewModels
{
    public class AppartmentEditViewModel : AppartmentIndexViewModel.AppartmentViewModel
    {
        public int UserId { get; set; }
    }
}