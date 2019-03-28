package ${corePackageName}.controller;

import com.midea.common.util.CmhaExportTools;
import ${corePackageName}.service.${entity}Service;
import com.midea.common.util.ImportExcelUtil;
import com.midea.mdp.core.util.ContextUtils;
import com.midea.mdp.extend.comm.constant.ConstantValue;
import com.midea.mdp.extend.comm.util.FileUtil;
import com.midea.mdp.extend.comm.util.JsonUtil;
import com.midea.mdp.extend.web.BaseController;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
*
* <pre>
 * ${tableComment}
 * </pre>
*
* @author ${author}
* @version 1.00.00
*
*          <pre>
 * 修改记录
 *    修改后版本:     修改人：  修改日期:     修改内容:
 * </pre>
*/

@Component
@Controller("${controllerCorePackageName}_${entity}Controller")
@RequestMapping("/${moduleWFileName}/${entity?uncap_first}")
public class ${entity}Controller extends BaseController {
    /*
     * 按条件查询分页列表
     */
    @RequestMapping(value = "queryListByParam.ac", method = {RequestMethod.POST, RequestMethod.GET})
    public ModelAndView queryListByParam(String jsonData<#if (isTitleSearch=="true")>,String filter</#if>, Integer pageSize, Integer pageNo, HttpServletRequest request, HttpServletResponse response) throws Exception {
        ${entity}Service demoOrderSingleService = (${entity}Service) ContextUtils.getBeanConsumer(${entity}Service.class);
        String rst = demoOrderSingleService.queryListByParam(jsonData<#if (isTitleSearch=="true")>,filter</#if>, pageNo, pageSize);
        this.writeToStreamForJsonPStringJustep(request.getParameter(ConstantValue.CALL_BACK), response, rst);
        return null;
    }

    /*
     * 创建或者更新数据记录
     */
    @RequestMapping(value = "saveOrUpdate.ac", method = {RequestMethod.POST, RequestMethod.GET})
    public ModelAndView saveOrUpdate(String jsonData, HttpServletRequest request, HttpServletResponse response) throws Exception {
        ${entity}Service demoOrderSingleService = (${entity}Service) ContextUtils.getBeanConsumer(${entity}Service.class);
        Map<String, Object> rst = demoOrderSingleService.saveOrUpdate(jsonData);
        this.writeToStreamForJsonPObjectJustep(request.getParameter(ConstantValue.CALL_BACK), response, rst);
        return null;
    }

    /*
     * 根据主键id获取数据对象数据
     */
    @RequestMapping(value = "getById.ac", method = {RequestMethod.POST, RequestMethod.GET})
    public ModelAndView getById(String jsonData, HttpServletRequest request, HttpServletResponse response) throws Exception {
        ${entity}Service demoOrderSingleService = (${entity}Service) ContextUtils.getBeanConsumer(${entity}Service.class);
        String str = demoOrderSingleService.getById(jsonData);
        this.writeToStreamForJsonPStringJustep(request.getParameter(ConstantValue.CALL_BACK), response, str);
        return null;
    }

    /*
     * 根据主键id物理删除对象数据
     */
    @RequestMapping(value = "delete.ac", method = {RequestMethod.POST, RequestMethod.GET})
    public ModelAndView delete(String jsonData, HttpServletRequest request, HttpServletResponse response) throws Exception {
        ${entity}Service demoOrderSingleService = (${entity}Service) ContextUtils.getBeanConsumer(${entity}Service.class);
        Map<String, Object> rst = demoOrderSingleService.delete(jsonData);
        this.writeToStreamForJsonPObjectJustep(request.getParameter(ConstantValue.CALL_BACK), response, rst);
        return null;
    }

    /**
     * 导入数据
     *
     * @param request
     * @param response
     * @throws Exception
     */
    @RequestMapping(value = "import${entity}.ac", method = {RequestMethod.POST, RequestMethod.GET})
    public void import${entity}(HttpServletRequest request, HttpServletResponse response) throws Exception {
        ${entity}Service demoOrderSingleService = (${entity}Service) ContextUtils.getBeanConsumer(${entity}Service.class);
        Map<String, Object> errorResultMap = new HashMap<String, Object>();
        try {
            List<MultipartFile> listMultipartFile = this.praseFiles(request, response, null);
            String resp = "";
            if (null == listMultipartFile || 0 == listMultipartFile.size()) {
                resp = "{\"error\":\"nofile\"}";
            } else {
                if (listMultipartFile != null && listMultipartFile.size() > 0) {
                    Map<String, Object> fileData = FileUtil.getFileMapData(listMultipartFile.get(0));
                    resp = demoOrderSingleService.import${entity}(fileData);
                }
            }
            this.writeToStreamForJsonPStringJustep(request.getParameter(ConstantValue.CALL_BACK), response, resp);
        } catch (Exception e) {
            errorResultMap.put("resultCode", "fail");
            errorResultMap.put("resultMessage", "导入失败:" + e.getMessage());
            this.writeToStreamForJsonPStringJustep(request.getParameter(ConstantValue.CALL_BACK), response, JsonUtil.entityToJsonStr(errorResultMap));
        }
    }

    /**
     * 勾选导出数据
     *
     * @param ids
     * @param request
     * @param response
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "export${entity}.ac", method = {RequestMethod.POST, RequestMethod.GET})
    public ModelAndView export${entity}(String ids, HttpServletRequest request, HttpServletResponse response) throws Exception {
        // 1 获取要导出的数据
        ${entity}Service demoOrderSingleService = (${entity}Service) ContextUtils.getBeanConsumer(${entity}Service.class);
        List<Map<String, Object>> rst = demoOrderSingleService.export${entity}(ids);
        // 2 获取导出模板
        Workbook workbook = CmhaExportTools.getExportTools().getWorkbook("cmha/demo", "Demo Export Head.xlsx");
        // 3 获取模板第一个sheet，并将数据load进sheet
        ExportDetails(rst, workbook, 1);
        // 4 导出数据，下载到本地浏览器
        ImportExcelUtil.exportXls(workbook, "Export ${entity}", response);
        return null;
    }

    /**
     * 数据load进sheet
     *
     * @param details
     * @param workbook
     * @param startRowIndex
     */
    private void ExportDetails(List<Map<String, Object>> details, Workbook workbook, int startRowIndex) {
        Sheet sheet = workbook.getSheetAt(0);
        for (Map<String, Object> rowMap : details) {
            Row currentRow = sheet.getRow(startRowIndex++);
            if (currentRow == null) {
                currentRow = sheet.createRow(startRowIndex - 1);
            }
            CmhaExportTools.getExportTools().loadDataToExcel(currentRow, rowMap);
        }
    }
}
