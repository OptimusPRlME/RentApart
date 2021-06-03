using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace RentApart.ViewModels
{
    public class UserIndexViewModel
    {

        public UserIndexViewModel()
        {
            Users = new List<UsersViewModel>();
        }

        public List<UsersViewModel> Users { get; set; }

        public class UsersViewModel
        {

            public int UserId { get; set; }

            [Display(Name = "Email")]
            public string Email { get; set; }

            [Display(Name = "Ime")]
            public string FirstName { get; set; }

            [Display(Name = "Prezime")]
            public string LastName { get; set; }

        }
    }
}