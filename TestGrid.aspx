<%@ Page Title="Members Details" Language="C#" MasterPageFile="~/ASP Pages/MasterPage.master" AutoEventWireup="true" EnableEventValidation="false" CodeFile="TestGrid.aspx.cs" Inherits="ASP_Pages_TestGrid" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    </asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cphSearch" Runat="Server">       
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div class="jtable-main-container">
        <table>
            <tr>
                <td class="navbar-text">Search: &nbsp;&nbsp;
                    <asp:TextBox ID="txtSearch" runat="server" Font-Names="Verdana" OnTextChanged="txtSearch_TextChanged" Font-Size="11px" ForeColor="Blue"></asp:TextBox>
                </td>
                <td>

                </td>
                <td>
                    <asp:Label ID="lblStatus" runat="server" CssClass="control-label" Text="" Font-Names="Verdana" Font-Size="11px" ForeColor="Red"></asp:Label>
                </td>              
            </tr>
        </table>
    </div> 
    <div oncontextmenu="return false">
        <div id="showDiv" onmousedown="HideMenu('contextMenu');" onmouseup="HideMenu('contextMenu');" oncontextmenu="ShowMenu('contextMenu',event);"
            class="detailItem">
            <asp:UpdatePanel ID="UpdatePanel2" runat="server">
                <ContentTemplate>
                    <div>
                        <asp:GridView ID="GridView1" runat="server" AllowPaging="True" AutoGenerateColumns="False" Font-Names="Tahoma" Font-Size="11px"
                            BackColor="White" BorderColor="#3366CC" BorderStyle="None" BorderWidth="1px" CellPadding="4" EmptyDataText="No Record Found."
                            DataKeyNames="MBID" DataSourceID="SqlDataSource1" OnSelectedIndexChanged="GridView1_SelectedIndexChanged" OnRowDataBound="GridView1_RowDataBound" AllowSorting="True">
                            <Columns>
                                <asp:TemplateField HeaderText="Member ID" SortExpression="MBID">
                                    <ItemStyle HorizontalAlign="Center" />
                                    <ItemTemplate>
                                        <asp:Label ID="lblMBID" runat="server" Text='<%# HighlightText (Eval("MBID").ToString()) %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Company Name" SortExpression="MBCompanyName">
                                    <ItemStyle HorizontalAlign="Center" />
                                    <ItemTemplate>
                                        <asp:Label ID="lblMBCompanyName" runat="server" Text='<%# HighlightText (Eval("MBCompanyName").ToString()) %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:BoundField DataField="MBContactName" HeaderText="Contact Name" SortExpression="MBContactName" />
                                <asp:BoundField DataField="MBContactAddress1" HeaderText="Contact Address" SortExpression="MBContactAddress1" />
                                <asp:BoundField DataField="MBContactCity" HeaderText="Contact City" SortExpression="MBContactCity" />
                                <asp:BoundField DataField="MBContactCountry" HeaderText="Country" SortExpression="MBContactCountry" />
                                <asp:BoundField DataField="MBContactPostCode" HeaderText="Postal Code" SortExpression="MBContactPostCode" />
                                <asp:BoundField DataField="MBContactPhone" HeaderText="Contact Phone" SortExpression="MBContactPhone" />
                                <asp:TemplateField HeaderText="Email Address" SortExpression="MBContactEmailAdmin">
                                    <ItemStyle HorizontalAlign="Center" />
                                    <ItemTemplate>
                                        <asp:Label ID="lblMBContactEmailAdmin" runat="server" Text='<%#HighlightText (Eval("MBContactEmailAdmin").ToString()) %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Institution" SortExpression="Institutions">
                                    <ItemStyle HorizontalAlign="Center" />
                                    <ItemTemplate>
                                        <asp:Label ID="lblMInstitutions" runat="server" Text='<%#HighlightText (Eval("MInstitutions").ToString()) %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                            <FooterStyle BackColor="#99CCCC" ForeColor="#003399" />
                            <HeaderStyle BackColor="#003399" Font-Bold="True" ForeColor="#CCCCFF" />
                            <PagerStyle BackColor="#99CCCC" ForeColor="#003399" HorizontalAlign="Left" />
                            <RowStyle BackColor="White" ForeColor="#003399" />
                            <SelectedRowStyle BackColor="#009999" Font-Bold="True" ForeColor="#CCFF99" />
                            <SortedAscendingCellStyle BackColor="#EDF6F6" />
                            <SortedAscendingHeaderStyle BackColor="#0D4AC4" />
                            <SortedDescendingCellStyle BackColor="#D6DFDF" />
                            <SortedDescendingHeaderStyle BackColor="#002876" />
                        </asp:GridView>
                        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:conn %>" SelectCommand="AllMembers"
                            FilterExpression="MBID like '%{0}%' or MBCompanyName like '%{1}%' or MInstitutions like '%{2}%' or MBContactEmailAdmin like '%{3}%'" SelectCommandType="StoredProcedure">
                            <FilterParameters>
                                <asp:ControlParameter Name="MBID" ControlID="txtSearch" PropertyName="Text" />
                                <asp:ControlParameter Name="MBCompanyName" ControlID="txtSearch" PropertyName="Text" />
                                <asp:ControlParameter Name="MInstitutions" ControlID="txtSearch" PropertyName="Text" />
                                <asp:ControlParameter Name="MInstitutions" ControlID="txtSearch" PropertyName="Text" />
                                <asp:ControlParameter Name="MBContactEmailAdmin" ControlID="txtSearch" PropertyName="Text" />
                                
                            </FilterParameters>
                        </asp:SqlDataSource>
                    </div>
                </ContentTemplate>
            </asp:UpdatePanel>
        </div>
    </div>   
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <Triggers>
            <asp:AsyncPostBackTrigger ControlID="txtSearch" EventName="TextChanged" />             
        </Triggers>
    </asp:UpdatePanel>
    <div>
        <asp:LinkButton ID="lnkUpdate" runat="server" OnClick="lnkUpdate_Click" Text='<%# Eval("MBID") %>' Style="display: none" />
        <asp:LinkButton ID="lnkInsert" runat="server" OnClick="lnkInsert_Click" Text='<%# Eval("MBID") %>' Style="display: none" />
        <asp:HiddenField ID="fldProductID" runat="server" />
    </div>

    <%-- context menu --%>
    <div style="display:none;"   id="contextMenu" class="ContextMenuPanel">
        <table style="border:0; padding:1px; border-spacing:0; border:thin solid lightblue; cursor: default; width:130px; background-color:lightblue;">
            <tr>
                <td >
                <div  class="ContextItem" onclick="fnUpdate();">Update Member Details</div>
                </td>
            </tr>
            <tr>
                <td >
                    <div  class="ContextItem" onclick="fnInsert();">Add New Member</div>
                </td>
            </tr>
        </table>
        </div>

    <%-- Define JavaScript functions to show and hide our Context menu--%>
    <script lang="javascript" type="text/javascript">

        function ShowMenu(control, e) {
            var posx = e.clientX + window.pageXOffset + 'px'; //Left Position of Mouse Pointer
            var posy = e.clientY + window.pageYOffset + 'px'; //Top Position of Mouse Pointer
            document.getElementById(control).style.position = 'absolute';
            document.getElementById(control).style.display = 'inline';
            document.getElementById(control).style.left = posx;
            document.getElementById(control).style.top = posy;
        }
        function HideMenu(control) {

            document.getElementById(control).style.display = 'none';
        }
        //hide when left mouse is clicked
        $(document).unbind('click', function (e) {
            $("div#contextMenu").hide();
        });
</script>

    <script type="text/javascript">
        var rowid = 0;
        var rowid = 0;
        var rowid = 0;

        function fnUpdate() {
            var lnkView = document.getElementById('<%=lnkUpdate.ClientID %>');
            var hiddenField = document.getElementById('<%=fldProductID.ClientID %>');
            hiddenField.value = rowid;
            lnkView.click();
        }

        function fnInsert() {
            var lnkNoRextract = document.getElementById('<%=lnkInsert.ClientID %>');
            var hiddenField = document.getElementById('<%=fldProductID.ClientID %>');
            hiddenField.value = rowid;
            lnkNoRextract.click();
        }
    </script>
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="copyright" Runat="Server">
</asp:Content>

