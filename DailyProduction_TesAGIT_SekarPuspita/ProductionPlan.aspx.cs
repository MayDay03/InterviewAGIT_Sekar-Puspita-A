using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.Configuration;

namespace DailyProduction_TesAGIT_SekarPuspita
{
    public partial class ProductionPlan : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadPlans();
            }
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            
            int[] plan = {
                int.Parse(txtMonday.Value),
                int.Parse(txtTuesday.Value),
                int.Parse(txtWednesday.Value),
                int.Parse(txtThursday.Value),
                int.Parse(txtFriday.Value),
                int.Parse(txtSaturday.Value),
                int.Parse(txtSunday.Value)
            };

           
            int[] adjustedPlan = AdjustProductionPlan(plan);

          
            SavePlanToDatabase(plan, adjustedPlan);

          
            LoadPlans();

           
            txtMonday.Value = "";
            txtTuesday.Value = "";
            txtWednesday.Value = "";
            txtThursday.Value = "";
            txtFriday.Value = "";
            txtSaturday.Value = "";
            txtSunday.Value = "";
        }

        private int[] AdjustProductionPlan(int[] plan)
        {
            int total = 0;
            int count = 0;

           
            foreach (var p in plan)
            {
                if (p > 0)
                {
                    total += p;
                    count++;
                }
            }

            int avg = total / (count > 6 ? 6 : count); 
            int remainder = total % (count > 6 ? 6 : count);
            int[] adjustedPlan = new int[plan.Length];

           
            if (plan[0] > 0) // Senin
            {
                adjustedPlan[0] = avg + (remainder > 0 ? 1 : 0);
                remainder--;
            }

            if (plan[3] > 0) 
            {
                adjustedPlan[3] = avg + (remainder > 0 ? 1 : 0);
                remainder--;
            }

            for (int i = 1; i < 6; i++)
            {
                if (i == 3) 
                    continue;

                if (plan[i] > 0)
                {
                    adjustedPlan[i] = avg + (remainder > 0 ? 1 : 0);
                    remainder--;
                }
            }

            if (remainder > 0 && plan[6] > 0)
            {
                adjustedPlan[6] = remainder;
            }

            return adjustedPlan;
        }



        private void SavePlanToDatabase(int[] originalPlan, int[] adjustedPlan)
        {
            string connString = WebConfigurationManager.ConnectionStrings["ProductionDB"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connString))
            {
                conn.Open();
                string sql = "INSERT INTO ProductionPlan (Monday, Tuesday, Wednesday, Thursday, Friday, Saturday, Sunday, CorrectedMonday, CorrectedTuesday, CorrectedWednesday, CorrectedThursday, CorrectedFriday, CorrectedSaturday, CorrectedSunday) " +
                             "VALUES (@Monday, @Tuesday, @Wednesday, @Thursday, @Friday, @Saturday, @Sunday, @CorrectedMonday, @CorrectedTuesday, @CorrectedWednesday, @CorrectedThursday, @CorrectedFriday, @CorrectedSaturday, @CorrectedSunday)";
                using (SqlCommand cmd = new SqlCommand(sql, conn))
                {
                    cmd.Parameters.AddWithValue("@Monday", originalPlan[0]);
                    cmd.Parameters.AddWithValue("@Tuesday", originalPlan[1]);
                    cmd.Parameters.AddWithValue("@Wednesday", originalPlan[2]);
                    cmd.Parameters.AddWithValue("@Thursday", originalPlan[3]);
                    cmd.Parameters.AddWithValue("@Friday", originalPlan[4]);
                    cmd.Parameters.AddWithValue("@Saturday", originalPlan[5]);
                    cmd.Parameters.AddWithValue("@Sunday", originalPlan[6]);
                    cmd.Parameters.AddWithValue("@CorrectedMonday", adjustedPlan[0]);
                    cmd.Parameters.AddWithValue("@CorrectedTuesday", adjustedPlan[1]);
                    cmd.Parameters.AddWithValue("@CorrectedWednesday", adjustedPlan[2]);
                    cmd.Parameters.AddWithValue("@CorrectedThursday", adjustedPlan[3]);
                    cmd.Parameters.AddWithValue("@CorrectedFriday", adjustedPlan[4]);
                    cmd.Parameters.AddWithValue("@CorrectedSaturday", adjustedPlan[5]);
                    cmd.Parameters.AddWithValue("@CorrectedSunday", adjustedPlan[6]);

                    cmd.ExecuteNonQuery();
                }
            }
        }

        private void LoadPlans()
        {
            string connString = WebConfigurationManager.ConnectionStrings["ProductionDB"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connString))
            {
                conn.Open();
                SqlDataAdapter da = new SqlDataAdapter("SELECT * FROM ProductionPlan", conn);
                DataTable dt = new DataTable();
                da.Fill(dt);

                gvOriginalPlan.DataSource = dt;
                gvOriginalPlan.DataBind();

                gvAdjustedPlan.DataSource = dt;
                gvAdjustedPlan.DataBind();
            }
        }
    }
}
