using Microsoft.Owin;
using Owin;

[assembly: OwinStartupAttribute(typeof(RentApart.Startup))]
namespace RentApart
{
    public partial class Startup
    {
        public void Configuration(IAppBuilder app)
        {
            ConfigureAuth(app);

        }
    }
}
