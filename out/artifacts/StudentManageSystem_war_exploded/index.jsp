<%--
  Created by IntelliJ IDEA.
  User: 妹控
  Date: 18/11/7
  Time: 9:14
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>$Title$</title>
    <script type="text/javascript" src="js/jquery.min.js"></script>
    <script type="text/javascript" src="js/jquery.easyui.min.js"></script>
    <script type="text/javascript" src="js/easyui-lang-zh_CN.js"></script>
    <link type="text/css" rel="stylesheet" href="themes/icon.css"/>
    <link type="text/css" rel="stylesheet" href="themes/default/easyui.css"/>
    <script type="text/javascript">
        $(function () {

            $("#updateDialog").dialog({
                title: '修改',
                width: 400,
                closed: true,
                modal: true
            }); $("#addDialog").dialog({
                title: '添加',
                width: 400,
                closed: true,
                modal: true
            });


            //table标签
            $('#dg').datagrid({
                url: 'selectAll.do',
                columns: [[
                    {field: 'id', title: '编号', width: 70},
                    {field: 'name', title: '姓名', width: 200},
                    {field: 'age', title: '年龄', width: 70},
                    {
                        field: 'gender', title: '性别', width: 70,
                        formatter: function (value, row, index) {
                            if (value == "0") {
                                return "女";
                            } else {
                                return "男";
                            }
                        }
                    },
                    {field: 'cz', title: '操作', width: 90}
                ]],

                onDblClickRow: function (index, row) {
                    //alert(row.id)
                    $("#updateName").val(row.name);
                    $("#updateId").val(row.id);
                    $("#updateAge").val(row.age);
                    if (row.gender == "1") {
                        $("#updateGenderMan").prop("checked", "checked");
                    } else {
                        $("#updateGenderWoman").prop("checked", "checked");
                    }
                    $("#updateDialog").dialog("open");
                },

                pagination: true,
                width: 510,
                iconCls: 'icon-search',
                toolbar: '#tb'

            });

        })

        //form提交表单
        function doUpdate() {
            $('#updateForm').form('submit', {
                url: "update.do",
                onSubmit: function () {
                    var isOK = $(this).form("validate");
                    //  alert(isOK);
                    return isOK;
                },
                success: function (data) {
                    if (data == "true") {

                        $("#updateDialog").dialog("close");
                        $('#dg').datagrid("reload");
                    } else {
                        $.messager.alert('提示', '修改失败！', 'warning');
                    }

                }
            });
        }//form提交表单
        function doAdd() {
            $('#addForm').form('submit', {
                url: "add.do",
                onSubmit: function () {
                    var isOK = $(this).form("validate");
                    //  alert(isOK);
                    return isOK;
                },
                success: function (data) {
                    if (data == "true") {

                        $("#addDialog").dialog("close");
                        $('#dg').datagrid("reload");
                    } else {
                        $.messager.alert('提示', '添加失败！', 'warning');
                    }

                }
            });
        }

        //搜索
        function search() {
            var name = $("#searchName").val();
            //  alert(name);
            $('#dg').datagrid("load", {"name": name});
        }

        function remove() {
            var selections = $('#dg').datagrid("getSelections");
            if (selections.length == 0) {
                $.messager.alert('提示', '请选中至少一条数据！', 'warning');
            } else {
                $.messager.confirm('确认对话框', '您确定删除吗？', function (r) {
                    if (r) {
                        var ids = new Array(selections.length);
                        for (var i = 0; i < selections.length; i++) {
                            ids[i] = selections[i].id;
                        }
                        $.ajax({
                            url: "multiDelete.do",
                            type: "post",
                            data: {"ids": ids},
                            traditional: true,
                            success: function (data) {
                                if (data) {
                                    $('#dg').datagrid("reload");
                                } else {
                                    $.messager.alert('提示', '删除失败！', 'warning');
                                }
                            }
                        })
                    }

                });
            }
        }

        function add() {
            $("#addDialog").dialog("open");
        }
    </script>
</head>
<body>
<div id="tb" style="height: 28px">
    <a id="searchBtn" href="javascript:search()" class="easyui-linkbutton"
       data-options="iconCls:'icon-search'" style="float: right;margin-left: 10px">搜索</a>
    <input id="searchName" name="name" style="float: right;margin-top: 3px"/>
    <a href="javascript:remove()" class="easyui-linkbutton"
       data-options="iconCls:'icon-remove',plain:true" style="float: left"></a>
    <a href="javascript:add()" class="easyui-linkbutton"
       data-options="iconCls:'icon-add',plain:true" style="float: left"></a>

</div>
<table id="dg"></table>

<div id="updateDialog">
    <form style="width: 200px;margin: 30px auto;" method="post" id="updateForm">
        <input type="hidden" name="id" id="updateId"/>
        <label for="updateName">姓 名:</label><input id="updateName" name="name" class="easyui-validatebox"
                                                   data-options="required:true"/><br/><br/>
        <label for="updateAge">年 龄:</label><input id="updateAge" name="age" class="easyui-validatebox"
                                                  data-options="required:true"/><br/><br/>
        <label for="updateAge">性 别:</label><input id="updateGenderMan" name="gender" type="radio" value="1"/><label for="updateGenderMan">男</label>
        <input id="updateGenderWoman" name="gender" type="radio" value="0"/><label for="updateGenderWoman">女</label><br/><br/>
        <a class="easyui-linkbutton" style="margin-left: 50px" href="javascript:doUpdate()">修改</a><br/>
    </form>
</div>
<div id="addDialog">
    <form style="width: 200px;margin: 30px auto;" method="post" id="addForm">
        <label for="updateName">姓 名:</label><input id="addName" name="name" class="easyui-validatebox"
                                                   data-options="required:true"/><br/><br/>
        <label for="updateAge">年 龄:</label><input id="addAge" name="age" class="easyui-validatebox"
                                                  data-options="required:true"/><br/><br/>
        <label for="updateAge">性 别:</label><input id="addGenderMan" name="gender" type="radio" value="1"/><label
            for="updateGenderMan">男</label>
        <input id="addGenderWoman" name="gender" type="radio" value="0"/><label
            for="updateGenderWoman">女</label><br/><br/>
        <a class="easyui-linkbutton" style="margin-left: 50px" href="javascript:doAdd()">添加</a><br/>
    </form>
</div>
</body>
</html>
