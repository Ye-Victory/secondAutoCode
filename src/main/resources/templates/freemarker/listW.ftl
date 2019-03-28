<?xml version="1.0" encoding="utf-8"?>

<div xmlns="http://www.w3.org/1999/xhtml" xid="window" class="window" component="$UI/system/components/justep/window/window"
     design="device:pc">
    <div component="$UI/system/components/justep/model/model" xid="model" style="height:auto;top:61px;left:633px;"
         onLoad="modelLoad">
        <!-- grid数据组件 -->
        <div component="$UI/system/components/justep/data/data" autoLoad="true"
             xid="${entity?uncap_first}Data" idColumn="${entity?uncap_first}Id" confirmRefresh="false">
        <#list dataTabledefAll as field>
                <column label="${field.name}" name="${field.code}" type="${field.filed_type}" xid="${field.code}"/>
        </#list>
        </div>
        <!-- 查询数据组件 -->
        <div component="$UI/system/components/justep/data/data" autoLoad="true"
             xid="queryData" idColumn="queryId">
            <#list dataTabledef as field>
                    <column label="${field.name}" name="${field.code}" type="${field.filed_type}" xid="${field.code}"/>
            </#list>
        </div>
    </div>
    <div component="$UI/system/components/justep/panel/panel" class="x-panel x-full x-midea"
         xid="${entity?uncap_first}Panel">
        <!-- 要查询的字段 -->
        <div class="x-panel-top" xid="top1" height="170">
            <a component="$UI/system/components/justep/button/button" class="btn btn-link btn-show"
               label="隐藏" xid="toggleBtn" icon="icon-arrow-up-b" onClick="showClick">
                <span xid="span1">隐藏w</span>
                <i xid="i1" class="icon-arrow-up-b"/>
            </a>
            <div xid="showTop" class="show-top">
                <div component="$UI/system/components/justep/row/row" class="x-row"
                     xid="row1">
                    <div class="x-col x-col-10" xid="col1">
                        <label xid="label1" class="pull-right"><![CDATA[单据号]]></label>
                    </div>
                    <div class="x-col x-col-20" xid="col2">
                        <input component="$UI/system/components/justep/input/input" class="form-control input-sm"
                               xid="input1" placeHolder="请输入单据号" bind-ref="$model.queryData.ref(&quot;queryId&quot;)"/>
                    </div>
                    <div class="x-col x-col-10" xid="col3">
                        <label xid="label2" class="pull-right"><![CDATA[标题]]></label>
                    </div>
                    <div class="x-col x-col-20" xid="col13">
                        <input component="$UI/system/components/justep/input/input" class="form-control input-sm"
                               xid="input2" placeHolder="请输入标题" bind-ref="$model.queryData.ref(&quot;title&quot;)"/>
                    </div>
                    <div class="x-col x-col-10" xid="col14">
                        <label xid="label3" class="pull-right"><![CDATA[供应商]]></label>
                    </div>
                    <div class="x-col x-col-20" xid="col15">
                        <input component="$UI/system/components/justep/input/input" class="form-control input-sm"
                               xid="vendorCompanyName" placeHolder="请输入编码或名称"/>
                    </div>
                </div>
                <div component="$UI/system/components/justep/row/row" class="x-row"
                     xid="row2">
                    <div class="x-col x-col-10" xid="col4">
                        <label xid="label4" class="pull-right"><![CDATA[创建日期]]></label>
                    </div>
                    <div class="x-col x-col-20" xid="col5">
                        <input component="$UI/system/components/justep/input/input" class="form-control input-sm"
                               xid="input4" placeHolder="请选择创建日期" dataType="Date" bind-ref="$model.queryData.ref(&quot;creationDate&quot;)"/>
                    </div>
                    <div class="x-col x-col-10" xid="col6">
                        <label xid="label5" class="pull-right"><![CDATA[创建人]]></label>
                    </div>
                    <div class="x-col x-col-20" xid="col16">
                        <input component="$UI/system/components/justep/input/input" class="form-control input-sm"
                               xid="input5" placeHolder="请输入创建人" bind-ref="$model.queryData.ref(&quot;createdBy&quot;)"/>
                    </div>
                    <div class="x-col x-col-10" xid="col17">
                        <label xid="label6" class="pull-right"><![CDATA[状态]]></label>
                    </div>
                    <div class="x-col x-col-20" xid="col18">
                        <select component="$UI/system/components/justep/select/select" bind-optionsCaption="请选择..."
                                class="form-control input-sm" xid="select3" bind-options="dictData" bind-optionsValue="itemValue" bind-optionsLabel="itemName"/>
                    </div>
                </div>
                <div component="$UI/system/components/justep/row/row" class="x-row"
                     xid="row4">
                    <div class="x-col x-col-50" xid="col10">
                        <a component="$UI/system/components/justep/button/button" class="btn btn-default btn-sm pull-right"
                           label="查询" xid="queryButton" style="width:80px;" onClick="queryClick">
                            <i xid="i2"/>
                            <span xid="span2">查询</span>
                        </a>
                    </div>
                    <div class="x-col" xid="col11">
                        <a component="$UI/system/components/justep/button/button" class="btn btn-default btn-sm"
                           label="清除" xid="clearButton" style="width:80px;" onClick="clearBtnClick">
                            <i xid="i3"/>
                            <span xid="span3">清除</span>
                        </a>
                    </div>
                </div>
            </div>
            <hr xid="hr1"/>
            <div xid="hideTop" class="hide-top">
                <div component="$UI/system/components/justep/row/row" class="x-row"
                     xid="row5">
                    <div class="x-col" xid="col20">
                        <a component="$UI/system/components/justep/button/button" class="btn btn-default btn-sm"
                           label="新增" xid="addButton" style="width:80px;" onClick="addBtnClick">
                            <i xid="i4"/>
                            <span xid="span4">新增</span>
                        </a>
                    </div>
                </div>
            </div>
        </div>
        <!--显示数据grid-->
        <div class="x-panel-content" xid="content1">
            <div component="$UI/system/components/justep/grid/grid" hiddenCaptionbar="true"
                 altRows="true" class="x-grid-title-center" xid="${entity?uncap_first}Grid" multiselect="true"
                 width="100%" height="100%" data="${entity?uncap_first}Data" onRowClick="${entity?uncap_first}GridRowClick"
                 onCellRender="${entity?uncap_first}GridCellRender">
                <columns xid="columns1">
                    <#list dataTabledef as field>
                        <#if field.code != "isShow" && field.code != "isDeleted" && field.code != "createUserId" && field.code != "updateUserId">
                            <column label="${field.name}" name="${field.code}" type="${field.filed_type}" xid="${field.code}"/>
                        </#if>
                    </#list>
                </columns>
            </div>
        </div>
        <!-- 分页显示信息 -->
        <div class="x-panel-bottom" xid="bottom1">
            <div component="$UI/system/components/justep/pagerBar/pagerBar" class="x-pagerbar container-fluid"
                 xid="pagerBar" data="${entity?uncap_first}Data">
                <div class="row" xid="div1">
                    <div class="col-sm-3" xid="div2">
                        <div class="x-pagerbar-length" xid="div3">
                            <label component="$UI/system/components/justep/pagerLimitSelect/pagerLimitSelect"
                                   class="x-pagerlimitselect" xid="pagerLimitSelect1">
                                <span xid="span9">显示</span>
                                <select component="$UI/system/components/justep/select/select"
                                        class="form-control input-sm" xid="pageSelect" onChange="pageSelectChange">
                                    <option value="10" xid="default2">10</option>
                                    <option value="20" xid="default3">20</option>
                                    <option value="50" xid="default4">50</option>
                                    <option value="100" xid="default5">100</option>
                                </select>
                                <span xid="span10">条</span>
                            </label>
                        </div>
                    </div>
                    <div class="col-sm-3" xid="div4">
                        <div class="x-pagerbar-info" xid="div5">当前显示0条，共0条</div>
                    </div>
                    <div class="col-sm-6" xid="div6">
                        <div class="x-pagerbar-pagination" xid="div7">
                            <ul class="pagination" component="$UI/system/components/bootstrap/pagination/pagination"
                                xid="pagination" data="${entity?uncap_first}Data" bind-click="paginationClick">
                                <li class="prev" xid="li1">
                                    <a href="#" xid="a1">
                                        <span aria-hidden="true" xid="span11">«</span>
                                        <span class="sr-only" xid="span12">Previous</span>
                                    </a>
                                </li>
                                <li class="next" xid="li2">
                                    <a href="#" xid="a2">
                                        <span aria-hidden="true" xid="span13">»</span>
                                        <span class="sr-only" xid="span14">Next</span>
                                    </a>
                                </li>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
