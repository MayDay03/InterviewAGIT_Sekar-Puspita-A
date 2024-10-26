<%@ Page Title="Perencanaan Produksi" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ProductionPlan.aspx.cs" Inherits="DailyProduction_TesAGIT_SekarPuspita.ProductionPlan" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <h3>Perencanaan Produksi Mobil</h3>

    <!-- Input Section -->
    <div class="card input-section" style="padding: 20px; margin-top: 20px;">
        <h4>Input Rencana Produksi</h4>
        <br />
        <div class="input-row" style="display: flex; gap: 15px; align-items: center; flex-wrap: wrap;">
            <div style="display: flex; flex-direction: column; align-items: center;">
                <label>Senin:</label>
                <input type="number" cssclass="form-control" id="txtMonday" min="0" runat="server" style="width: 65px;" />
            </div>
            <div style="display: flex; flex-direction: column; align-items: center;">
                <label>Selasa:</label>
                <input type="number" cssclass="form-control" id="txtTuesday" min="0" runat="server" style="width: 65px;" />
            </div>
            <div style="display: flex; flex-direction: column; align-items: center;">
                <label>Rabu:</label>
                <input type="number" cssclass="form-control" id="txtWednesday" min="0" runat="server" style="width: 65px;" />
            </div>
            <div style="display: flex; flex-direction: column; align-items: center;">
                <label>Kamis:</label>
                <input type="number" cssclass="form-control" id="txtThursday" min="0" runat="server" style="width: 65px;" />
            </div>
            <div style="display: flex; flex-direction: column; align-items: center;">
                <label>Jumat:</label>
                <input type="number" cssclass="form-control" id="txtFriday" min="0" runat="server" style="width: 65px;" />
            </div>
            <div style="display: flex; flex-direction: column; align-items: center;">
                <label>Sabtu:</label>
                <input type="number" cssclass="form-control" id="txtSaturday" min="0" runat="server" style="width: 60px;" />
            </div>
            <div style="display: flex; flex-direction: column; align-items: center;">
                <label>Minggu:</label>
                <input type="number" cssclass="form-control" id="txtSunday" min="0" runat="server" style="width: 60px;" />
            </div>
        </div>
        <asp:Button CssClass="btn btn-primary mt-3" ID="btnSave" runat="server" Text="Simpan" OnClick="btnSave_Click" Style="margin-top: 15px;" />
    </div>

    <!-- Table Section -->
    <div class="result-section" style="display: flex; justify-content: space-between; margin-top: 20px;">
        <div class="card" style="flex: 1; padding: 20px; margin-right: 10px;">
            <div class="card-header">
                <strong class="card-title">Rencana Asep</strong>
            </div>
            <div class="card-body">
                <asp:GridView ID="gvOriginalPlan" runat="server" AutoGenerateColumns="false" CssClass="table table-striped" HeaderStyle-CssClass="thead-dark">
                    <Columns>
                        <asp:TemplateField HeaderText="Rencana">
                            <ItemTemplate>
                              Rencana  <%# Container.DataItemIndex + 1%>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:BoundField DataField="Monday" HeaderText="Senin" />
                        <asp:BoundField DataField="Tuesday" HeaderText="Selasa" />
                        <asp:BoundField DataField="Wednesday" HeaderText="Rabu" />
                        <asp:BoundField DataField="Thursday" HeaderText="Kamis" />
                        <asp:BoundField DataField="Friday" HeaderText="Jumat" />
                        <asp:BoundField DataField="Saturday" HeaderText="Sabtu" />
                        <asp:BoundField DataField="Sunday" HeaderText="Minggu" />
                    </Columns>
                </asp:GridView>
            </div>
        </div>
    </div>

    <div class="result-section" style="display: flex; justify-content: space-between; margin-top: 20px;">
        <div class="card" style="flex: 1; padding: 20px; margin-right: 10px;">
            <div class="card-header">
                <strong class="card-title">Rencana Disesuaikan</strong>
            </div>
            <div class="card-body">
                <asp:GridView ID="gvAdjustedPlan" runat="server" AutoGenerateColumns="false" CssClass="table table-striped" HeaderStyle-CssClass="thead-dark">
                    <Columns>
                        <asp:TemplateField HeaderText="No.">
                            <ItemTemplate>
                              Rencana  <%# Container.DataItemIndex + 1%>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:BoundField DataField="CorrectedMonday" HeaderText="Senin" />
                        <asp:BoundField DataField="CorrectedTuesday" HeaderText="Selasa" />
                        <asp:BoundField DataField="CorrectedWednesday" HeaderText="Rabu" />
                        <asp:BoundField DataField="CorrectedThursday" HeaderText="Kamis" />
                        <asp:BoundField DataField="CorrectedFriday" HeaderText="Jumat" />
                        <asp:BoundField DataField="CorrectedSaturday" HeaderText="Sabtu" />
                        <asp:BoundField DataField="CorrectedSunday" HeaderText="Minggu" />
                    </Columns>
                </asp:GridView>
            </div>
        </div>
    </div>
</asp:Content>
