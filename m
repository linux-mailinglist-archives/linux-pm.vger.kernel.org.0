Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CE936F695D
	for <lists+linux-pm@lfdr.de>; Thu,  4 May 2023 12:59:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229577AbjEDK7A (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 4 May 2023 06:59:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229904AbjEDK6n (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 4 May 2023 06:58:43 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70F1DA3
        for <linux-pm@vger.kernel.org>; Thu,  4 May 2023 03:58:41 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id ffacd0b85a97d-2fe3fb8e25fso205964f8f.0
        for <linux-pm@vger.kernel.org>; Thu, 04 May 2023 03:58:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683197920; x=1685789920;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IuleNFTk0sbWeS1WJVZqMuA9ZPPhqhay4vuSVMWV+Rc=;
        b=P7KbKtAZqWxL3u+SFWzivRs7tH57iny+o2l59KZvqlwT07bMWKklpKe0skxq4YmSDs
         NBar5sfevzRThTd+Ugh/kG1/6WcrUJuypeR6PBOnoguBKYfqCQq07vxjxHDJo8GycfGO
         Fr7yHoDvKpmhZsXZx3FbdYSXw43KHehavdmADe8jThnbjb5u8ZAYfDOrbzC+wvHWkybY
         ny59qPAvsAQ8+hIkP2K07lfGp/usbQWwlA1VxuvxzVaxfqQ7mETchieGntL2wJ9uNznQ
         ECcFi6hBu5kyQW2r/lFiyM7JKsJ2glQW3S/8gEbT+qvhlHZFzCOlnkyN0wuHziHecDBU
         6wEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683197920; x=1685789920;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IuleNFTk0sbWeS1WJVZqMuA9ZPPhqhay4vuSVMWV+Rc=;
        b=MBUCjJ2YfzsXtStjZgH4KcRNB3VAv0ZzBm8GU8Zhjoqs1EuoDnrk5u8Ngn9XxPPt7M
         twgcCKvRvvfU+Kup1DSdZH5ra+S6bIav0EKn7Vjz+BvRMXIrQ4sTTJLGRtNfddPNSAmi
         vZIkwUpXbzqz5cQ2I4/V4LPZ+zd1/FiVMoQq4/zkH0zcswX8arA0ZGl3uEKqUA+UQisB
         iqQ63LKZvuiVlAGFFk1U9rJ14BXhr6oOeXqPLFsgYnadZuClWCb4Aw9B2QD9UoWPPt3A
         aej/CiA6l+QgpQIR7i7D98j9CgWyh6Ky1CI4itL/rD7PlW3pTWGNnrrzMKxvsY+0rEQL
         6BpQ==
X-Gm-Message-State: AC+VfDyh5eFvr/VK94tX20/D6DsOxCMit5cHuhPJPImW1z1z7bhJB+uW
        /PCX13k18UAdom1Ix3PQ0WMgiQ==
X-Google-Smtp-Source: ACHHUZ5K1yprHH0g/xMGXmGGRkNXsRUnXDDFysOhgtMTFbizpbLJRakmqlSR0P+wqpMtm9MoCYqx1g==
X-Received: by 2002:adf:dec5:0:b0:306:2b64:fd1b with SMTP id i5-20020adfdec5000000b003062b64fd1bmr2147883wrn.52.1683197919870;
        Thu, 04 May 2023 03:58:39 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id o10-20020a5d684a000000b003063176ef0dsm9474849wrw.97.2023.05.04.03.58.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 May 2023 03:58:38 -0700 (PDT)
Date:   Thu, 4 May 2023 13:58:31 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     macromorgan@hotmail.com
Cc:     linux-pm@vger.kernel.org
Subject: [bug report] power: supply: Add charger driver for Rockchip RK817
Message-ID: <dc0bb0f8-212d-4be7-be69-becd2a3f9a80@kili.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hello Chris Morgan,

The patch 11cb8da0189b: "power: supply: Add charger driver for
Rockchip RK817" from Aug 26, 2022, leads to the following Smatch
static checker warning:

drivers/power/supply/rk817_charger.c:1198 rk817_charger_probe()
warn: inconsistent refcounting 'node->kobj.kref.refcount.refs.counter':
  inc on: 1088,1105,1115,1124,1130,1136,1146,1160,1166,1170,1177,1186,1193
  dec on: 1067

drivers/power/supply/rk817_charger.c
    1048 static int rk817_charger_probe(struct platform_device *pdev)
    1049 {
    1050         struct rk808 *rk808 = dev_get_drvdata(pdev->dev.parent);
    1051         struct rk817_charger *charger;
    1052         struct device_node *node;
    1053         struct power_supply_battery_info *bat_info;
    1054         struct device *dev = &pdev->dev;
    1055         struct power_supply_config pscfg = {};
    1056         int plugin_irq, plugout_irq;
    1057         int of_value;
    1058         int ret;
    1059 
    1060         node = of_get_child_by_name(dev->parent->of_node, "charger");
    1061         if (!node)
    1062                 return -ENODEV;
    1063 
    1064         charger = devm_kzalloc(&pdev->dev, sizeof(*charger), GFP_KERNEL);
    1065         if (!charger) {
    1066                 of_node_put(node);

This error path calls of_node_put() but probably they all should.

    1067                 return -ENOMEM;
    1068         }
    1069 
    1070         charger->rk808 = rk808;
    1071 
    1072         charger->dev = &pdev->dev;
    1073         platform_set_drvdata(pdev, charger);
    1074 
    1075         rk817_bat_calib_vol(charger);
    1076 
    1077         pscfg.drv_data = charger;
    1078         pscfg.of_node = node;
    1079 
    1080         /*
    1081          * Get sample resistor value. Note only values of 10000 or 20000
    1082          * microohms are allowed. Schematic for my test implementation (an
    1083          * Odroid Go Advance) shows a 10 milliohm resistor for reference.
    1084          */
    1085         ret = of_property_read_u32(node, "rockchip,resistor-sense-micro-ohms",
    1086                                    &of_value);
    1087         if (ret < 0) {
    1088                 return dev_err_probe(dev, ret,
    1089                                      "Error reading sample resistor value\n");
    1090         }
    1091         /*
    1092          * Store as a 1 or a 2, since all we really use the value for is as a
    1093          * divisor in some calculations.
    1094          */
    1095         charger->res_div = (of_value == 20000) ? 2 : 1;
    1096 
    1097         /*
    1098          * Get sleep enter current value. Not sure what this value is for
    1099          * other than to help calibrate the relax threshold.
    1100          */
    1101         ret = of_property_read_u32(node,
    1102                                    "rockchip,sleep-enter-current-microamp",
    1103                                    &of_value);
    1104         if (ret < 0) {
    1105                 return dev_err_probe(dev, ret,
    1106                                      "Error reading sleep enter cur value\n");
    1107         }
    1108         charger->sleep_enter_current_ua = of_value;
    1109 
    1110         /* Get sleep filter current value */
    1111         ret = of_property_read_u32(node,
    1112                                    "rockchip,sleep-filter-current-microamp",
    1113                                    &of_value);
    1114         if (ret < 0) {
    1115                 return dev_err_probe(dev, ret,
    1116                                      "Error reading sleep filter cur value\n");
    1117         }
    1118 
    1119         charger->sleep_filter_current_ua = of_value;
    1120 
    1121         charger->bat_ps = devm_power_supply_register(&pdev->dev,
    1122                                                      &rk817_bat_desc, &pscfg);
    1123         if (IS_ERR(charger->bat_ps))
    1124                 return dev_err_probe(dev, -EINVAL,
    1125                                      "Battery failed to probe\n");
    1126 
    1127         charger->chg_ps = devm_power_supply_register(&pdev->dev,
    1128                                                      &rk817_chg_desc, &pscfg);
    1129         if (IS_ERR(charger->chg_ps))
    1130                 return dev_err_probe(dev, -EINVAL,
    1131                                      "Charger failed to probe\n");
    1132 
    1133         ret = power_supply_get_battery_info(charger->bat_ps,
    1134                                             &bat_info);
    1135         if (ret) {
    1136                 return dev_err_probe(dev, ret,
    1137                                      "Unable to get battery info: %d\n", ret);
    1138         }
    1139 
    1140         if ((bat_info->charge_full_design_uah <= 0) ||
    1141             (bat_info->voltage_min_design_uv <= 0) ||
    1142             (bat_info->voltage_max_design_uv <= 0) ||
    1143             (bat_info->constant_charge_voltage_max_uv <= 0) ||
    1144             (bat_info->constant_charge_current_max_ua <= 0) ||
    1145             (bat_info->charge_term_current_ua <= 0)) {
    1146                 return dev_err_probe(dev, -EINVAL,
    1147                                      "Required bat info missing or invalid\n");
    1148         }
    1149 
    1150         charger->bat_charge_full_design_uah = bat_info->charge_full_design_uah;
    1151         charger->bat_voltage_min_design_uv = bat_info->voltage_min_design_uv;
    1152         charger->bat_voltage_max_design_uv = bat_info->voltage_max_design_uv;
    1153 
    1154         /*
    1155          * Has to run after power_supply_get_battery_info as it depends on some
    1156          * values discovered from that routine.
    1157          */
    1158         ret = rk817_battery_init(charger, bat_info);
    1159         if (ret)
    1160                 return ret;
    1161 
    1162         power_supply_put_battery_info(charger->bat_ps, bat_info);
    1163 
    1164         plugin_irq = platform_get_irq(pdev, 0);
    1165         if (plugin_irq < 0)
    1166                 return plugin_irq;
    1167 
    1168         plugout_irq = platform_get_irq(pdev, 1);
    1169         if (plugout_irq < 0)
    1170                 return plugout_irq;
    1171 
    1172         ret = devm_request_threaded_irq(charger->dev, plugin_irq, NULL,
    1173                                         rk817_plug_in_isr,
    1174                                         IRQF_TRIGGER_RISING | IRQF_ONESHOT,
    1175                                         "rk817_plug_in", charger);
    1176         if (ret) {
    1177                 return dev_err_probe(&pdev->dev, ret,
    1178                                       "plug_in_irq request failed!\n");
    1179         }
    1180 
    1181         ret = devm_request_threaded_irq(charger->dev, plugout_irq, NULL,
    1182                                         rk817_plug_out_isr,
    1183                                         IRQF_TRIGGER_RISING | IRQF_ONESHOT,
    1184                                         "rk817_plug_out", charger);
    1185         if (ret) {
    1186                 return dev_err_probe(&pdev->dev, ret,
    1187                                      "plug_out_irq request failed!\n");
    1188         }
    1189 
    1190         ret = devm_delayed_work_autocancel(&pdev->dev, &charger->work,
    1191                                            rk817_charging_monitor);
    1192         if (ret)
    1193                 return ret;
    1194 
    1195         /* Force the first update immediately. */
    1196         mod_delayed_work(system_wq, &charger->work, 0);
    1197 
--> 1198         return 0;
    1199 }

regards,
dan carpenter
