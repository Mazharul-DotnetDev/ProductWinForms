using CrystalDecisions.CrystalReports.Engine;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using WindowsFormsApp2.DAL;

namespace WindowsFormsApp2
{
    public partial class ProductForm : Form
    {
        ProductRepository repository  = new ProductRepository();
        public ProductForm()
        {
            InitializeComponent();
        }

        private void ProductForm_Load(object sender, EventArgs e)
        {
            DataLoad();
        }

        private void DataLoad()
        {
            gridProducts.DataSource = repository.GetProducts() ;
        }

        private void btnList_Click(object sender, EventArgs e)
        {
            ReportViewerForm reportViewer = new ReportViewerForm();


           ReportDocument reportDocument = new ReportDocument();


            reportDocument.Load(Application.StartupPath + "\\MyReports\\ProductListReport.rpt");

            if(reportDocument.IsLoaded)
            reportDocument.SetDataSource(repository.GetProducts());


            reportViewer.crystalReportViewer.ReportSource = reportDocument;



            reportViewer.ShowDialog(this);
        }

        private void btnInfo_Click(object sender, EventArgs e)
        {
            try
            {
                if (gridProducts.SelectedRows.Count == 0)
                {
                    MessageBox.Show("Select any row from list");
                    return;
                }
                var productId = gridProducts.SelectedRows[0].Cells[0].Value;


                if (productId is null) return;






                ReportViewerForm reportViewer = new ReportViewerForm();


                ReportDocument reportDocument = new ReportDocument();


                reportDocument.Load(Application.StartupPath + "\\MyReports\\ProductDetailsReport.rpt");

                if (reportDocument.IsLoaded)
                    reportDocument.SetDataSource(repository.GetProductsById((int)productId));


                reportViewer.crystalReportViewer.ReportSource = reportDocument;



                reportViewer.ShowDialog(this);






            }
            catch (Exception ex)
            {

                MessageBox.Show(ex.Message);
            }






        }
    }
}
