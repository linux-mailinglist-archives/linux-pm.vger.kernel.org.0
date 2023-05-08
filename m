Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A44FA6FB667
	for <lists+linux-pm@lfdr.de>; Mon,  8 May 2023 20:47:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232429AbjEHSrC (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 8 May 2023 14:47:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbjEHSrB (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 8 May 2023 14:47:01 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10olkn2013.outbound.protection.outlook.com [40.92.40.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 620F659F7
        for <linux-pm@vger.kernel.org>; Mon,  8 May 2023 11:46:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xk7MCguC6MZ93RKtJTvvARClslJumjKojLOBxdwFg8cyf+9sV69jT5rmyiT+Pnc1xmg/cRoCQ5jlkq6lBuQtvHD4TmoHCV2dWIfSckb6T7u1tsbtrXr4CKHRC8dJCOQl43yiYA5p4Pp5kMC2RVfKsnGGLuUy7eXLURR/HbfcxJhXEpzgl8Mk1fhZMlhJTIwVUSGFHN+mekUhulVo9PF/6vKiP159X3in4aNRJGAiksm/8PZpjvJ2UAYSIOxOl7qlt5Qr45sW6PV4M/QgFsJ7UtEMn7DbEXGZLq2rgmQ2+imN07XmlU0PSVgn481IXTdwnR6fGIqwmND1w2lZ4zewQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xPZwkBAG4gyb1jECRYfbZzvv26gWXsN+3KlOfpyyj/I=;
 b=WKMAvYPUnF6DkvDM1MJjvpFnES1VZV7gJ1kiooNNJLAlG36UjJzUvx8zWtLmZtNXlpISOyJvHLUNvfJb3u1CfTM/PH0xvrCrYzX6dVKHwCJ6m12xI7jsQiVpLwjA7yTKz68rul+rcJHSc9Uol9pCQblw3wVppVzoPyCj+2rg0MsGyQKP9J02VBnCU2dWtr05cL6eYOwFUmElSr6cyx/k+qHug7KZ/ML90xqEfpq6nHbiUkOfDu78EZ3Ez17jJ3DmZWarRsKpp/CvmbQzgFifKfWyJEnFyouoVgZCBqKlztTNBJ78M96Uwd7lZILG0FXharbhaCVKvlvMejP9K7gxMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xPZwkBAG4gyb1jECRYfbZzvv26gWXsN+3KlOfpyyj/I=;
 b=rO3LETKUC1tig8qapr+1wbFEGbjoJIO/XjMGUWO5ywZamFBx9svScSV/qwjhcXjJwmIWQMD4Edd77SabwM0RkRPEeWk8w79lwQgYFskX94Lyv+Gbi3RNcxDLAvCt2e6zmH7RkufmjxKkEf8ZR/lsem9Q0b545PMDnCZHFlpBIj8bz008IJ0MtDfPGPlxsWwg665MSiZHnUpj6TaruuXxti4rDhOoufAHULuvUMFYpaTlzaRU3/Nq8y/Q3mYJ/hYrVFaauxPWf5rI81CE860RuMyyn0+pDpvXhda1dOGkUYzaq6Y2NU0XyimbJ9qSVAOoNVdErWP1sRq6izV169tq8Q==
Received: from SN6PR06MB5342.namprd06.prod.outlook.com (2603:10b6:805:f9::31)
 by DM6PR06MB3914.namprd06.prod.outlook.com (2603:10b6:5:8b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.32; Mon, 8 May
 2023 18:46:57 +0000
Received: from SN6PR06MB5342.namprd06.prod.outlook.com
 ([fe80::c4b8:5076:f9e6:114a]) by SN6PR06MB5342.namprd06.prod.outlook.com
 ([fe80::c4b8:5076:f9e6:114a%6]) with mapi id 15.20.6363.032; Mon, 8 May 2023
 18:46:57 +0000
Date:   Mon, 8 May 2023 13:46:53 -0500
From:   Chris Morgan <macromorgan@hotmail.com>
To:     Dan Carpenter <dan.carpenter@linaro.org>
Cc:     linux-pm@vger.kernel.org
Subject: Re: [bug report] power: supply: Add charger driver for Rockchip RK817
Message-ID: <SN6PR06MB534254918F9D84F996BFD2ACA5719@SN6PR06MB5342.namprd06.prod.outlook.com>
References: <dc0bb0f8-212d-4be7-be69-becd2a3f9a80@kili.mountain>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dc0bb0f8-212d-4be7-be69-becd2a3f9a80@kili.mountain>
X-TMN:  [YJJa+PGDTlCwxWAPZUIaLp23oOTmTEBX]
X-ClientProxiedBy: DS7PR03CA0351.namprd03.prod.outlook.com
 (2603:10b6:8:55::16) To SN6PR06MB5342.namprd06.prod.outlook.com
 (2603:10b6:805:f9::31)
X-Microsoft-Original-Message-ID: <ZFlDnb/jjQRT0+e6@wintermute.localhost.fail>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR06MB5342:EE_|DM6PR06MB3914:EE_
X-MS-Office365-Filtering-Correlation-Id: bc0b9c04-973e-4166-1f9b-08db4ff4997d
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7QNO/w3Xqoe956Chgk/YL1q0QiIj8dZ6HoDGjQGtSL88X9+0ePhrlwQgdIyTlkSXsLVQYJo8p5QeX1HbJj1byNt0+Fvx/jHFtA9W+GQmt5oZN8z8jP4XFc5pp3IETrafJlkyisoiGPQwo3uazJxp3LwnfUBoNqkAImWQStWYhChWGwSMWmnUzD538YdT7zBYmroTgWGtyW8D8wrhZbGtCQSmYddBzjBPkG2KW396ZVNU9zFVtyDPuJsCf2jKZOV62GYd/Al0GpiSFMeRpAQ2BHm/BbWi+DR2vkGcmN4id1pCIhURq2ng/vy7vgk5mgN8ZkUpv79HJ6XVOmEq5SB5RJ7nKPE3nQqbNjEXxBV3o5AnunR6doWQtZ6RPV9Xc7ncbl7oJHF6EguW241QkUFmemw3oq1FO62no0A2td8c6fc/DvUGqfqCZRQENcM5wMqtvMfvdCRLmTBsM5umTZAN9LyyJltGfyHxiyY0pnDwnLgvAFmjJEKdbW0YgorAsp4fXldiDcKWG9sNsUoxmjN/tWECuXyQFSiPjgTUgidgwDmSm9/P3P9US6DRTCvn3gGYXYTmZuOLsAci5oUdK5NDJLxdBP5NzFePM0bvbw6Dfncg7bQ7p3ehS7zQ+ejT0uAw
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3PUC5eW8Eh/Z8qF5gPovbtV4en6d9bOeFRXpkl5d0yZsjhJM8rtTocoUNAdd?=
 =?us-ascii?Q?y7yAxblkdwksFRL+nAuUKQ1OSQlvsdq16swSEyddQPXHxT2hnV+pz6hi5CAZ?=
 =?us-ascii?Q?VbN+TRZ5HsFjq/ceF0ByBy5QSR+C8kNdz6wsZ6SS8Nwf/5at9i7+IRl4O57A?=
 =?us-ascii?Q?ERaH2H5gWlVDC/bUZ/NclMkRI6JhsnCfdGgAjBSkF/qv4Ahun0si50y/J6GB?=
 =?us-ascii?Q?wUnEYI15rS0ex0Cj0+MCVRd+dEo8m7teOE2IeLNDqvMWvkWjUCAAR63uaE3u?=
 =?us-ascii?Q?rQOVGJZzZciPF9+nvp1jN9EaT06ysJdCEjG2htm+cbAw4tzw66oFLUpy45fz?=
 =?us-ascii?Q?sAS9xil6svo1Utfaegul8x74yhE7QZlKbOrKK/BDtI2O7xpcU/qeB4MqQ/z8?=
 =?us-ascii?Q?8CPWY/AvXwtBwLDRLC6NG8iDII85dGiTTgK6xQdOZPMcTmyc+qmJmEzslAES?=
 =?us-ascii?Q?fuPFvpXk9QIv7qIxZ++XMYOG3lRok6AiG5R7bbLx1DqaB3m+LxQIOVacqKs/?=
 =?us-ascii?Q?du0OqDzBUC2Iu7AaT0VUcDhnjjcC7yboYLkKY6ddEl4d6lbj9LPlgzodPPTu?=
 =?us-ascii?Q?yEkYJc1USk6xpvH+4LiUztArUoherx+19/j74e49Q+LOb6cUcbxmpm/2jgDi?=
 =?us-ascii?Q?LdXovaucbuOHpInL74Qq25lNXbqADImDm2DwZKIeSx5x04nZLmFGQfjjw+9a?=
 =?us-ascii?Q?CR65vBA0pwltsoalPjCYBmlKR3i7ges+d0cDiAPtP8kPUn7OtgvrPe9+AITv?=
 =?us-ascii?Q?OylkyOJPSHC55/EKM+z7hWnUBm+yM9gk8dpOKG/dsqgirM/UO5K4Zwkit1m4?=
 =?us-ascii?Q?xWIU4Cv/BFN5k4DFa7webOQadxXrmrc1asWYOZCrFdmjsnha0/Cfn/5RQe8F?=
 =?us-ascii?Q?MCsGOuNZKm0XGNGdVaqKTA4X6LT8nqg0tRpWjBusAVnomoVBv39+s/eBLM5i?=
 =?us-ascii?Q?Us01O8YT+5X7fdq4S6KpeyyKFguNw5nOIYbvRm06k0543E5oydGspFbslgUK?=
 =?us-ascii?Q?7KEyLIEnSFvizD/2zvEUrvko1n8T5Y+bR3lPvkqHgNPYQavBxR0HOKhAd/zg?=
 =?us-ascii?Q?0TewbGuWnh8aeNl6YTmloXRGlGn2jkTgX19JJ7lWRLfmxPvu5mlhhg+ZUf+M?=
 =?us-ascii?Q?nmrzFLzhS+m8aE80qsZAr9Prt/E7v9fQKeeSIrsmsq1FHJ2UK07ik7afkSz5?=
 =?us-ascii?Q?5zIFOtGXOnPAz+9/HHsyy0jIOmu23+HHLIViwg=3D=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-89723.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: bc0b9c04-973e-4166-1f9b-08db4ff4997d
X-MS-Exchange-CrossTenant-AuthSource: SN6PR06MB5342.namprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2023 18:46:57.6419
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR06MB3914
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, May 04, 2023 at 01:58:31PM +0300, Dan Carpenter wrote:
> Hello Chris Morgan,
> 
> The patch 11cb8da0189b: "power: supply: Add charger driver for
> Rockchip RK817" from Aug 26, 2022, leads to the following Smatch
> static checker warning:
> 
> drivers/power/supply/rk817_charger.c:1198 rk817_charger_probe()
> warn: inconsistent refcounting 'node->kobj.kref.refcount.refs.counter':
>   inc on: 1088,1105,1115,1124,1130,1136,1146,1160,1166,1170,1177,1186,1193
>   dec on: 1067
> 
> drivers/power/supply/rk817_charger.c
>     1048 static int rk817_charger_probe(struct platform_device *pdev)
>     1049 {
>     1050         struct rk808 *rk808 = dev_get_drvdata(pdev->dev.parent);
>     1051         struct rk817_charger *charger;
>     1052         struct device_node *node;
>     1053         struct power_supply_battery_info *bat_info;
>     1054         struct device *dev = &pdev->dev;
>     1055         struct power_supply_config pscfg = {};
>     1056         int plugin_irq, plugout_irq;
>     1057         int of_value;
>     1058         int ret;
>     1059 
>     1060         node = of_get_child_by_name(dev->parent->of_node, "charger");
>     1061         if (!node)
>     1062                 return -ENODEV;
>     1063 
>     1064         charger = devm_kzalloc(&pdev->dev, sizeof(*charger), GFP_KERNEL);
>     1065         if (!charger) {
>     1066                 of_node_put(node);
> 
> This error path calls of_node_put() but probably they all should.

Thank you for pointing this out. So I should probably just add a "goto"
that puts the node at the end, and direct every error to this? Just
want to confirm.

> 
>     1067                 return -ENOMEM;
>     1068         }
>     1069 
>     1070         charger->rk808 = rk808;
>     1071 
>     1072         charger->dev = &pdev->dev;
>     1073         platform_set_drvdata(pdev, charger);
>     1074 
>     1075         rk817_bat_calib_vol(charger);
>     1076 
>     1077         pscfg.drv_data = charger;
>     1078         pscfg.of_node = node;
>     1079 
>     1080         /*
>     1081          * Get sample resistor value. Note only values of 10000 or 20000
>     1082          * microohms are allowed. Schematic for my test implementation (an
>     1083          * Odroid Go Advance) shows a 10 milliohm resistor for reference.
>     1084          */
>     1085         ret = of_property_read_u32(node, "rockchip,resistor-sense-micro-ohms",
>     1086                                    &of_value);
>     1087         if (ret < 0) {
>     1088                 return dev_err_probe(dev, ret,
>     1089                                      "Error reading sample resistor value\n");
>     1090         }
>     1091         /*
>     1092          * Store as a 1 or a 2, since all we really use the value for is as a
>     1093          * divisor in some calculations.
>     1094          */
>     1095         charger->res_div = (of_value == 20000) ? 2 : 1;
>     1096 
>     1097         /*
>     1098          * Get sleep enter current value. Not sure what this value is for
>     1099          * other than to help calibrate the relax threshold.
>     1100          */
>     1101         ret = of_property_read_u32(node,
>     1102                                    "rockchip,sleep-enter-current-microamp",
>     1103                                    &of_value);
>     1104         if (ret < 0) {
>     1105                 return dev_err_probe(dev, ret,
>     1106                                      "Error reading sleep enter cur value\n");
>     1107         }
>     1108         charger->sleep_enter_current_ua = of_value;
>     1109 
>     1110         /* Get sleep filter current value */
>     1111         ret = of_property_read_u32(node,
>     1112                                    "rockchip,sleep-filter-current-microamp",
>     1113                                    &of_value);
>     1114         if (ret < 0) {
>     1115                 return dev_err_probe(dev, ret,
>     1116                                      "Error reading sleep filter cur value\n");
>     1117         }
>     1118 
>     1119         charger->sleep_filter_current_ua = of_value;
>     1120 
>     1121         charger->bat_ps = devm_power_supply_register(&pdev->dev,
>     1122                                                      &rk817_bat_desc, &pscfg);
>     1123         if (IS_ERR(charger->bat_ps))
>     1124                 return dev_err_probe(dev, -EINVAL,
>     1125                                      "Battery failed to probe\n");
>     1126 
>     1127         charger->chg_ps = devm_power_supply_register(&pdev->dev,
>     1128                                                      &rk817_chg_desc, &pscfg);
>     1129         if (IS_ERR(charger->chg_ps))
>     1130                 return dev_err_probe(dev, -EINVAL,
>     1131                                      "Charger failed to probe\n");
>     1132 
>     1133         ret = power_supply_get_battery_info(charger->bat_ps,
>     1134                                             &bat_info);
>     1135         if (ret) {
>     1136                 return dev_err_probe(dev, ret,
>     1137                                      "Unable to get battery info: %d\n", ret);
>     1138         }
>     1139 
>     1140         if ((bat_info->charge_full_design_uah <= 0) ||
>     1141             (bat_info->voltage_min_design_uv <= 0) ||
>     1142             (bat_info->voltage_max_design_uv <= 0) ||
>     1143             (bat_info->constant_charge_voltage_max_uv <= 0) ||
>     1144             (bat_info->constant_charge_current_max_ua <= 0) ||
>     1145             (bat_info->charge_term_current_ua <= 0)) {
>     1146                 return dev_err_probe(dev, -EINVAL,
>     1147                                      "Required bat info missing or invalid\n");
>     1148         }
>     1149 
>     1150         charger->bat_charge_full_design_uah = bat_info->charge_full_design_uah;
>     1151         charger->bat_voltage_min_design_uv = bat_info->voltage_min_design_uv;
>     1152         charger->bat_voltage_max_design_uv = bat_info->voltage_max_design_uv;
>     1153 
>     1154         /*
>     1155          * Has to run after power_supply_get_battery_info as it depends on some
>     1156          * values discovered from that routine.
>     1157          */
>     1158         ret = rk817_battery_init(charger, bat_info);
>     1159         if (ret)
>     1160                 return ret;
>     1161 
>     1162         power_supply_put_battery_info(charger->bat_ps, bat_info);
>     1163 
>     1164         plugin_irq = platform_get_irq(pdev, 0);
>     1165         if (plugin_irq < 0)
>     1166                 return plugin_irq;
>     1167 
>     1168         plugout_irq = platform_get_irq(pdev, 1);
>     1169         if (plugout_irq < 0)
>     1170                 return plugout_irq;
>     1171 
>     1172         ret = devm_request_threaded_irq(charger->dev, plugin_irq, NULL,
>     1173                                         rk817_plug_in_isr,
>     1174                                         IRQF_TRIGGER_RISING | IRQF_ONESHOT,
>     1175                                         "rk817_plug_in", charger);
>     1176         if (ret) {
>     1177                 return dev_err_probe(&pdev->dev, ret,
>     1178                                       "plug_in_irq request failed!\n");
>     1179         }
>     1180 
>     1181         ret = devm_request_threaded_irq(charger->dev, plugout_irq, NULL,
>     1182                                         rk817_plug_out_isr,
>     1183                                         IRQF_TRIGGER_RISING | IRQF_ONESHOT,
>     1184                                         "rk817_plug_out", charger);
>     1185         if (ret) {
>     1186                 return dev_err_probe(&pdev->dev, ret,
>     1187                                      "plug_out_irq request failed!\n");
>     1188         }
>     1189 
>     1190         ret = devm_delayed_work_autocancel(&pdev->dev, &charger->work,
>     1191                                            rk817_charging_monitor);
>     1192         if (ret)
>     1193                 return ret;
>     1194 
>     1195         /* Force the first update immediately. */
>     1196         mod_delayed_work(system_wq, &charger->work, 0);
>     1197 
> --> 1198         return 0;
>     1199 }
> 
> regards,
> dan carpenter
