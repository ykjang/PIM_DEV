package com.isec.pim.common.controller;

import com.google.gson.Gson;
import java.security.MessageDigest;
import java.util.HashMap;
import java.util.Map;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.ui.Model;
import org.springframework.web.servlet.ModelAndView;

public class JsonController
{

    private static final Logger logger = LoggerFactory.getLogger(JsonController.class);


    /*public ModelAndView updateActUser(String user_id, String act_yn)
    {
        logger.info((new StringBuilder("[user_id]")).append(user_id).toString());
        logger.info((new StringBuilder("[activate]")).append(act_yn).toString());
        Map params = new HashMap();
        params.put("user_id", user_id);
        params.put("act_yn", act_yn);
        boolean isSucc = userInfoServcie.updateActUser(params) > 0;
        ModelAndView modelAndView = new ModelAndView("jsonView");
        modelAndView.addObject("UPDATE_YN", Boolean.valueOf(isSucc));
        return modelAndView;
    }

    public ModelAndView loginProc(String jsonStr, HttpServletRequest request)
    {
        logger.info((new StringBuilder("[str]")).append(jsonStr).toString());
        logger.info((new StringBuilder("[ip]")).append(request.getRemoteHost()).toString());
        UserInfo paramObj = (UserInfo)(new Gson()).fromJson(jsonStr, com/mailplants/admin/users/domain/UserInfo);
        String inputPwd = paramObj.getPwd();
        UserInfo resultObj = commonService.selLoginInfo(paramObj.getId());
        String resultCode = "";
        if(resultObj == null)
        {
            resultCode = "R01";
        } else
        {
            try
            {
                MessageDigest md = MessageDigest.getInstance("MD5");
                String inputEndcodingPwd = BASE64.encode(md.digest(inputPwd.getBytes()));
                logger.info((new StringBuilder("[inputPwd]")).append(inputEndcodingPwd).toString());
                logger.info((new StringBuilder("[Pwd]")).append(resultObj.getPwd()).toString());
                if(inputEndcodingPwd.equals(resultObj.getPwd()))
                {
                    Map paramMap = new HashMap();
                    paramMap.put("user_id", resultObj.getId());
                    paramMap.put("ip", request.getRemoteHost());
                    int rCnt = commonService.insLoginHistory(paramMap);
                    if(rCnt == 0)
                    {
                        resultCode = "R99";
                    } else
                    {
                        resultCode = "R00";
                        resultObj.getLoginHistory().setIp_address(request.getRemoteHost());
                        HttpSession session = request.getSession();
                        session.setMaxInactiveInterval(60000);
                        session.setAttribute("USERINFO", resultObj);
                    }
                } else
                {
                    resultCode = "R02";
                }
            }
            catch(Exception e)
            {
                e.printStackTrace();
                resultCode = "R99";
            }
        }
        ModelAndView modelAndView = new ModelAndView("jsonView");
        modelAndView.addObject("RESULT", resultCode);
        return modelAndView;
    }

    public ModelAndView userStatusList(int page, int rows, String sidx, String sord, HashMap srch_params, Model model)
    {
        logger.info((new StringBuilder("[page] ")).append(page).toString());
        logger.info((new StringBuilder("[rows] ")).append(rows).toString());
        logger.info((new StringBuilder("[sidx] ")).append(sidx).toString());
        logger.info((new StringBuilder("[sord] ")).append(sord).toString());
        logger.info((new StringBuilder("[search_type] ")).append((String)srch_params.get("search_type")).toString());
        logger.info((new StringBuilder("[search_word] ")).append((String)srch_params.get("search_word")).toString());
        int records = userInfoServcie.selectUserInfoListCount(srch_params);
        int firstPage = ((page - 1) / 10) * 10 + 1;
        int total = records % rows != 0 ? records / rows + 1 : records / rows;
        int start = rows * page - rows;
        logger.info((new StringBuilder("[records] ")).append(records).toString());
        logger.info((new StringBuilder("[firstPage] ")).append(firstPage).toString());
        logger.info((new StringBuilder("[total] ")).append(total).toString());
        srch_params.put("start", (new StringBuilder(String.valueOf(start))).toString());
        srch_params.put("limit", (new StringBuilder(String.valueOf(rows))).toString());
        srch_params.put("sidx", sidx);
        srch_params.put("sord", sord);
        java.util.List list = userInfoServcie.selectUserInfoList(srch_params);
        ModelAndView modelAndView = new ModelAndView("jsonView");
        modelAndView.addObject("page", Integer.valueOf(page));
        modelAndView.addObject("total", Integer.valueOf(total));
        modelAndView.addObject("records", Integer.valueOf(records));
        modelAndView.addObject("userList", list);
        return modelAndView;
    }

    public ModelAndView userDetailInfo(String user_id, Model model)
    {
        logger.info((new StringBuilder("[user_id]")).append(user_id).toString());
        UserInfo userInfo = userInfoServcie.selectUserDetailInfot(user_id);
        String pay_type = "F";
        String remain = "";
        if("P".equals(userInfo.getSend_type()))
        {
            pay_type = "P";
            remain = String.valueOf(userInfo.getRemain_cnt());
        } else
        {
            pay_type = "M";
            remain = userInfo.getRemain_date();
        }
        ModelAndView modelAndView = new ModelAndView("jsonView");
        modelAndView.addObject("userInfo", userInfo);
        modelAndView.addObject("pay_type", pay_type);
        modelAndView.addObject("remain", remain);
        return modelAndView;
    }

    public ModelAndView visitInfoList(int page, int rows, String sidx, String sord, HashMap srch_params, Model model)
    {
        logger.info((new StringBuilder("[page] ")).append(page).toString());
        logger.info((new StringBuilder("[rows] ")).append(rows).toString());
        logger.info((new StringBuilder("[sidx] ")).append(sidx).toString());
        logger.info((new StringBuilder("[sord] ")).append(sord).toString());
        logger.info((new StringBuilder("[from_date] ")).append((String)srch_params.get("from_date")).toString());
        logger.info((new StringBuilder("[to_date] ")).append((String)srch_params.get("to_date")).toString());
        int records = userInfoServcie.selectUserInfoListCount(srch_params);
        int firstPage = ((page - 1) / 10) * 10 + 1;
        int total = records % rows != 0 ? records / rows + 1 : records / rows;
        int start = rows * page - rows;
        logger.info((new StringBuilder("[records] ")).append(records).toString());
        logger.info((new StringBuilder("[firstPage] ")).append(firstPage).toString());
        logger.info((new StringBuilder("[total] ")).append(total).toString());
        srch_params.put("start", (new StringBuilder(String.valueOf(start))).toString());
        srch_params.put("limit", (new StringBuilder(String.valueOf(rows))).toString());
        srch_params.put("sidx", sidx);
        srch_params.put("sord", sord);
        java.util.List list = userInfoServcie.selectUserInfoList(srch_params);
        ModelAndView modelAndView = new ModelAndView("jsonView");
        modelAndView.addObject("page", Integer.valueOf(page));
        modelAndView.addObject("total", Integer.valueOf(total));
        modelAndView.addObject("records", Integer.valueOf(records));
        modelAndView.addObject("userList", list);
        return modelAndView;
    }*/

}
