﻿<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage<TortolasProject.Models.tbFactura>" %>



<asp:Content ID="facturaTitleContent" ContentPlaceHolderID="TitleContent" runat="server">
    <% Response.Write("Factura"); %>   
</asp:Content>

<asp:Content ID="facturaCssContent" ContentPlaceHolderID="CssContent" runat="server">
    <link href="../../Content/Facturas/factura.css" rel="stylesheet" type="text/css" /> 
    <link href="../../Content/Facturas/facturasNav.css" rel="stylesheet" type="text/css" /> 
</asp:Content>

<asp:Content ID="facturaScriptContent" ContentPlaceHolderID="ScriptContent" runat="server">
    <script src="<%: Url.Content("~/Scripts/jsactions/Facturas/facturas.js") %>" type="text/javascript"></script>
</asp:Content>


<asp:Content ID="facturaMainContent" ContentPlaceHolderID="MainContent" runat="server">
<% String estado = Model.vista; %>
<input type="hidden" id='estadoPage' value='<% Response.Write(estado); %>' />
<input type="hidden" id='idFactura' value='<% Response.Write(Model.idFactura); %>' />
    <div id='facturaContainer' >
        <div id='facturaHeader'>            
            <div id='volverButton' class='k-button'></div>
            <div id='poliButton' class='k-button'></div>
            <div id='eliminarButton' class='k-button'></div>
            <div id='pdfButton'><%: Html.ActionLink("Descargar en PDF", "generarFacturaPDF", "Facturas", new { id = Model.idFactura.ToString() }, new { @class = "k-button" })%></div>
            <div id='relacionesButton' class='k-button'>Añadir relación</div>
        </div>
        <div id='facturaDetalles'>            
            <div id='relacionesFacturaContainer'>
                <div id='relacionesExistentesDiv'>
                        <div id='relacionDiv'><% if( !estado.Equals("nueva") && Model.idRelacion != null ){ Response.Write(Model.RelacionName); } %></div>
                        <div id='quitarRelacionButton'> x </div>
                </div>
          

            
                <!-- Ventana de relaciones  -->
                <div id='relacionesWindow'>
                    <div id='relacionesTab'>
                        <ul>
                            <li class="k-state-active">Usuarios</li>
                            <li>Eventos</li>
                            <li>Cursillos</li>
                            <li>Pedidos globales</li>
                            <li>Pedidos usuario</li>
                            <li>Empresas</li>
                            <li>Proveedores</li>
                            <li>Contratos</li>
                        </ul>
                        <div id='usuariosFacturaDiv'>
                            <div id='usuariosFacturaGrid'></div>                        
                        </div>
                        <div id='eventosFacturaDiv'>
                            <div id='eventosFacturaGrid'></div>
                        </div>
                        <div id='cursillosFacturaDiv'>
                            <div id='cursillosFacturaGrid'></div>
                        </div>
                        <div id='pedidosGlobalesDiv'>
                            <div id='pedidosGlobalesGrid'></div>
                        </div>
                        <div id='pedidosUsuarioDiv'>
                            <div id='pedidosUsuarioGrid'></div>
                        </div>
                        <div id='empresasDiv'>
                            <div id='empresasGrid'></div>
                        </div>
                        <div id='proveedoresDiv'>
                            <div id='proveedoresGrid'></div>
                        </div>
                        <div id='contratosDiv'>
                            <div id='contratosGrid'></div>
                        </div>
                    </div>  
                    <div id='windowSelectButton' class='k-button'>+ Añadir</div>              
                </div>  
                <!--                        -->

            </div>
            <div id='facturaForm'>
                    <div id='fechaFacturaDiv'>
                        Fecha
                        <div id='fechaFacturaLabel'><%
                        if (estado.Equals("detalles") || estado.Equals("editar"))
                           { 
                               Response.Write(Model.Fecha.ToShortDateString());
                           }               
                         %>
                         </div>   
                        <div id='fechaFacturaContainer'>
                            <input id='fechaFacturaInput' name='fecha' required validationMessage='Introduzca fecha' /><span class="k-invalid-msg" data-for="fecha"></span>
                        </div>
                    </div>

                    <div id='conceptoFacturaDiv'>
                        Concepto  
                        <div id='conceptoFacturaLabel'><% 
                            if (Model.vista.Equals("detalles"))
                           { 
                              Response.Write(Model.Concepto);
                           }
                         %></div><%
                           if( Model.vista.Equals("editar"))
                           {
                               %>
                                    <input type='text' id='conceptoFactura' name='concepto' class='k-input' value='<% Response.Write(Model.Concepto); %>' required validationMessage='Introduzca concepto' /><span class="k-invalid-msg" data-for="concepto"></span>
                               <%
                           }
                           else
                           {
                                %>
                                    <input type='text' id='conceptoFactura' name='concepto' class='k-input' required validationMessage='Introduzca concepto' /><span class="k-invalid-msg" data-for="concepto"></span>
                                <%
                           }
                        %>
                        </div>

                    <div id='estadoFacturaDiv'>
                        Estado factura
                        <div id='estadoFacturaLabel'></div>
                        <div id='estadoFacturaDropDownListContainer'>
                            <input id='estadoFacturaDropDownList' />
                        </div>
                    </div>
                </div>
            </div>
        
            <div id='facturaLineasFacturaGrid'></div>
        

            <div id='totalFacturaDiv'>
                <table class='k-widget'>
                    <tr>
                        <td class='k-header'><div id='baseImponibleLabel'>Base imponible</div></td>
                        <td><div id='baseImponibleNumero'><% if (!Model.vista.Equals("nueva")) Response.Write(Model.BaseImponible); else Response.Write("0 €"); %></div></td>
                    </tr>
                    <tr>
                        <td class='k-header'><div id='ivaLabel'>IVA</div></td>
                        <td><div id='ivaNumero'>18%</div></td>
                    </tr>
                    <tr>
                        <td class='k-header'><div id='totalFacturaLabel'>Total</div></td>
                        <td><div id='totalFacturaNumero'><% if (!Model.vista.Equals("nueva")) Response.Write(Model.Total); else Response.Write("0 €"); %></div></td>
                    </tr>
                </table>
            </div>
            <div id='facturaBottom'>
                <div id='descartarFacturaButton' class='k-button'>Descartar</div>
                <div id='guardarFacturaButton' class='k-button'>Guardar</div>
                <div class='status' class='k-invalid-msg'></div>
            </div>
        
        
            <div id='lineaFacturaWindow'>
                <div id='statusLinea' class='k-invalid-msg'></div>
                <div id='lineaFacturaForm'>
                    <div id='conceptoLineaDiv'>
                        <div id='conceptoLineaLabel'>Concepto</div>
                        <div id='conceptoContainer'>
                            <input id='conceptoLinea' type='text' class='k-input' required validationMessage='Introduzca concepto,'/><span class="k-invalid-msg" data-for="conceptoLinea"></span>
                            <div id='quitarArticulo'>X</div>
                        </div>                
                    </div>
                    <div id='articulosDiv'>                                
                                        <div id='articulosGrid'></div>
                                        <div id='agregarArticuloConcepto' class='k-button'>Agregar</div>
                    </div>
                    <div id='tablaNuevaLineaFactura' class='k-grid k-widget'>
                        <table>                    
                                <tr class='k-grid-header'>
                                    <th>Unidades</th>
                                    <th>Precio unitario</th>
                                    <th>Total</th>  
                                </tr>
                                <tr>
                                    <td class='k-grid-content'><input id='unidadesLinea' min='0' required validationMessage='Introduzca unidades.'/><span class="k-invalid-msg" data-for="unidadesLinea"></span></td>
                                    <td class='k-grid-content'><input id='precioLinea' required  validationMessage='Introduzca precio.'/><span class="k-invalid-msg" data-for="precioLinea"></span></td>
                                    <td class='k-grid-content'><div id='totalLinea'></div></td>
                                </tr>  
                                               
                        </table>
                    </div>
                    <div id = 'lineaFacturaWindowBottom'>
                        <div id='descartarLinea' class='k-button'>Descartar</div>
                        <div id='agregarLinea' class='k-button'>Añadir</div>
                    </div>
                </div>
            </div>
        </div>

</asp:Content>