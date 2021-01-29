using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ClaimApp.Excel
{
    public class VariableClass : IEquatable<VariableClass>
    {
        public bool Equals(VariableClass other)
        {
            if (other == null) return false;
            return true;
        }
        public string Insurance { get; set; }
        public string InsuredName { get; set; }
        public string Workshop { get; set; }
        public string PolicyNo { get; set; }
        public string DateofLoss { get; set; }
        public string PlatNo { get; set; }
        public string VehicleType { get; set; }
        public string ChassisNo { get; set; }
        public string EngineNo { get; set; }
        public string TanggalMasukBengkel { get; set; }
        public string TanggalSPK { get; set; }
        public string RepairerEstimate { get; set; }
        public string AmountApproved { get; set; }
        public string TanggalSelesaiPerbaikan { get; set; }
        public string StatusPerbaikan { get; set; }
        public string ClaimDemage { get; set; }
    }
}