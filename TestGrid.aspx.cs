using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.Web.Services;
using System.Configuration;
using System.Text.RegularExpressions;

public partial class ASP_Pages_TestGrid : System.Web.UI.Page
{
    private string SearchString = "";
    string MBID;
    protected void Page_Load(object sender, EventArgs e)
    {
        txtSearch.Focus();
        txtSearch.Attributes.Add("onkeyUp", string.Format("javascript:__doPostBack('{0}','')", this.txtSearch.ClientID));
        //txtSearch.Attributes.Add("onkeyup", "setTimeout('__doPostBack(\'" + txtSearch.ClientID.Replace("_", "$") + "\',\'\')', 0);");
        if (!IsPostBack)
        {
            GridView1.DataBind();
        }
    }

    public string HighlightText(string InputTxt)
    {
        string Search_Str = txtSearch.Text.ToString();
        // Setup the regular expression and add the Or operator.
        Regex RegExp = new Regex(Search_Str.Replace(" ", "|").Trim(), RegexOptions.IgnoreCase);
        // Highlight keywords by calling the 
        //delegate each time a keyword is found.
        return RegExp.Replace(InputTxt, new MatchEvaluator(ReplaceKeyWords));
        // Set the RegExp to null.
        RegExp = null;
    }

    public string ReplaceKeyWords(Match m)
    {
        return "<span class=highlight>" + m.Value + "</span>";
        //return "" + m.Value + "";
    }

    protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            e.Row.Attributes["onclick"] = Page.ClientScript.GetPostBackClientHyperlink(GridView1, "Select$" + e.Row.RowIndex);
            e.Row.ToolTip = "Click to select this row.";
            e.Row.Style["cursor"] = "pointer";
        }
    }
    protected void GridView1_SelectedIndexChanged(object sender, EventArgs e)
    {
        foreach (GridViewRow row in GridView1.Rows)
        {
            try
            {
                if (row.RowIndex == GridView1.SelectedIndex)
                {
                    row.BackColor = ColorTranslator.FromHtml("#ea5b0c");
                    row.ForeColor = ColorTranslator.FromHtml("White");
                    row.Font.Bold = false;
                    row.ToolTip = string.Empty;
                }
                else
                {
                    row.BackColor = ColorTranslator.FromHtml("#fcfcfc");
                    row.ForeColor = ColorTranslator.FromHtml("Navy");
                    row.ToolTip = "Click to select this row.";
                }
                if (row.Cells[2].Text == "MBID")
                {
                    lblStatus.Text = "You cannot selected: " + row.Cells[2].Text + ".";
                }
            }
            catch (Exception ex)
            {
                lblStatus.Visible = true;
                lblStatus.Text = "An error occured: " + ex.Message;
            }
        }
    }
    protected void GridView1_SelectedIndexChanging(object sender, GridViewSelectEventArgs e)
    {
        foreach (GridViewRow row in GridView1.Rows)
        {
            if (row.RowIndex == GridView1.SelectedIndex)
            {
                //lblStatus.Text = "You have selected: " + row.Cells[2].Text + ".";
            }
        }
    }
    protected void txtSearch_TextChanged(object sender, EventArgs e)
    {
        SearchString = txtSearch.Text;
    }
    protected void lnkUpdate_Click(object sender, EventArgs e)
    {
        MBID = GridView1.DataKeys[GridView1.SelectedIndex].Values["MBID"].ToString();

        string Location = ResolveUrl("~/Admin/EditMemberDetails.aspx") + "?MBID=" + MBID;
       Server.Transfer(Location);
    }
    protected void lnkInsert_Click(object sender, EventArgs e)
    {
        MBID = GridView1.DataKeys[GridView1.SelectedIndex].Values["MBID"].ToString();

        string Location = ResolveUrl("~/Admin/AddMember.aspx") + "?MBID=" + MBID;
        Server.Transfer(Location);
    }
}
           
