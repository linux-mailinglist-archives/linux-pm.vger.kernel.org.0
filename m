Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B686E7084E8
	for <lists+linux-pm@lfdr.de>; Thu, 18 May 2023 17:32:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230153AbjERPct (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 18 May 2023 11:32:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229799AbjERPcs (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 18 May 2023 11:32:48 -0400
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3873A135
        for <linux-pm@vger.kernel.org>; Thu, 18 May 2023 08:32:47 -0700 (PDT)
Received: by mail-ot1-x333.google.com with SMTP id 46e09a7af769-6ab0967093dso1636117a34.3
        for <linux-pm@vger.kernel.org>; Thu, 18 May 2023 08:32:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684423966; x=1687015966;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=eFEwq5FqTjT/kHqfLd8ktCOHieMapv7GlO22GAjWstk=;
        b=he/56StPB7Ros1llIoD/dBze/gr2Vqrew1gSeCqPR4tCLV4atWV4rnchYXTKhaczIZ
         LNnnpcycnvvZ+NZbNFckf3BqrenRKEXze4YkbCiDvXRcXxM3Dl2EqUPcIWr+ldXwP9QM
         Hp6eWqyuRKEgH1QX0CxLycKUYiqHQAO0meljKG00LX61htbQHqbbfo7bG343VYigSHJ8
         k1cFl3beF75FU8te0i7hTpyTMHeZ9zb/KEcYE0ypz6xPgzw9jy9NwRLz31If+uxNzWGK
         R6Y8Vfm8ySgACPisT2D7wPtQXV+nfXULvRpY+haw34LcigxrJCS04B02WTKTEksewqDR
         kHcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684423966; x=1687015966;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eFEwq5FqTjT/kHqfLd8ktCOHieMapv7GlO22GAjWstk=;
        b=OlJ6gtWvRMPAKr+o1aBgavZen67+lTmxPKfc+560QK6HsdnHeATk14MmuLi4kq68LM
         yumFnaigFdQJlpfdpPvXnsqKOg27NwTAJ1iSC2zAWkDGfHBzW8+tlODd1bQLdNlxMjtK
         WHT4lMbplsZVpmpP+NcKmtf+WCO+SDJqc6P5JMiYHayMTeBfR3t88NSmAmu3Q4yr1zqB
         QGayk0pE9w3k/DZ3WtbeKF6Yu4ixeLwqX/uqOvXQSvlkRgsio116XVamxx1NW4VOTNfs
         VPuZ3NU1CEBwI4I2G+07ehzgM139JTmtIa+hlOoM1kqXiH83oTzDZ/9mjTJwoFl2KwRg
         JOLA==
X-Gm-Message-State: AC+VfDzdEYJ0Gp84mts2mCH5PSIxMmVUlLQWyDN2/yLAYNizqa10iM4k
        B5IXokqNN1QcbR3FLmRAbwLV1aaoznJpow==
X-Google-Smtp-Source: ACHHUZ6ub7LOBmfekWa0/sgv5Uag1ibi059jYBF5ELHguNc80JtyxB7rdg9RNIQrUHR8UvC852EVnw==
X-Received: by 2002:a05:6870:1802:b0:196:2f14:b1c9 with SMTP id t2-20020a056870180200b001962f14b1c9mr1118716oaf.7.1684423966353;
        Thu, 18 May 2023 08:32:46 -0700 (PDT)
Received: from localhost.localdomain ([75.28.21.198])
        by smtp.gmail.com with ESMTPSA id c8-20020a9d6848000000b006a5e22458e9sm742758oto.80.2023.05.18.08.32.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 May 2023 08:32:46 -0700 (PDT)
From:   Chris Morgan <macroalpha82@gmail.com>
To:     linux-pm@vger.kernel.org
Cc:     linqiheng@huawei.com, macromorgan@hotmail.com, sre@kernel.org,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: [PATCH] power: supply: Fix additional refcount leak in rk817_charger_probe
Date:   Thu, 18 May 2023 10:32:30 -0500
Message-Id: <20230518153230.1584962-1-macroalpha82@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Chris Morgan <macromorgan@hotmail.com>

Dan Carpenter reports that the Smatch static checker warning has found
that there is another refcount leak in the probe function. While
of_node_put() was added in one of the return paths, it should in
fact be added for ALL return paths that return an error.

Fixes: 54c03bfd094f ("power: supply: Fix refcount leak in rk817_charger_probe")
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Closes: https://lore.kernel.org/linux-pm/dc0bb0f8-212d-4be7-be69-becd2a3f9a80@kili.mountain/
Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
---
 drivers/power/supply/rk817_charger.c | 76 ++++++++++++++++++----------
 1 file changed, 48 insertions(+), 28 deletions(-)

diff --git a/drivers/power/supply/rk817_charger.c b/drivers/power/supply/rk817_charger.c
index 1a2143641e66..bd4f530910a5 100644
--- a/drivers/power/supply/rk817_charger.c
+++ b/drivers/power/supply/rk817_charger.c
@@ -1063,8 +1063,8 @@ static int rk817_charger_probe(struct platform_device *pdev)
 
 	charger = devm_kzalloc(&pdev->dev, sizeof(*charger), GFP_KERNEL);
 	if (!charger) {
-		of_node_put(node);
-		return -ENOMEM;
+		ret = -ENOMEM;
+		goto out_node_put;
 	}
 
 	charger->rk808 = rk808;
@@ -1085,8 +1085,9 @@ static int rk817_charger_probe(struct platform_device *pdev)
 	ret = of_property_read_u32(node, "rockchip,resistor-sense-micro-ohms",
 				   &of_value);
 	if (ret < 0) {
-		return dev_err_probe(dev, ret,
-				     "Error reading sample resistor value\n");
+		dev_err_probe(dev, ret,
+			      "Error reading sample resistor value\n");
+		goto out_node_put;
 	}
 	/*
 	 * Store as a 1 or a 2, since all we really use the value for is as a
@@ -1102,8 +1103,9 @@ static int rk817_charger_probe(struct platform_device *pdev)
 				   "rockchip,sleep-enter-current-microamp",
 				   &of_value);
 	if (ret < 0) {
-		return dev_err_probe(dev, ret,
-				     "Error reading sleep enter cur value\n");
+		dev_err_probe(dev, ret,
+			      "Error reading sleep enter cur value\n");
+		goto out_node_put;
 	}
 	charger->sleep_enter_current_ua = of_value;
 
@@ -1112,29 +1114,35 @@ static int rk817_charger_probe(struct platform_device *pdev)
 				   "rockchip,sleep-filter-current-microamp",
 				   &of_value);
 	if (ret < 0) {
-		return dev_err_probe(dev, ret,
-				     "Error reading sleep filter cur value\n");
+		dev_err_probe(dev, ret,
+			      "Error reading sleep filter cur value\n");
+		goto out_node_put;
 	}
 
 	charger->sleep_filter_current_ua = of_value;
 
 	charger->bat_ps = devm_power_supply_register(&pdev->dev,
 						     &rk817_bat_desc, &pscfg);
-	if (IS_ERR(charger->bat_ps))
-		return dev_err_probe(dev, -EINVAL,
-				     "Battery failed to probe\n");
+	if (IS_ERR(charger->bat_ps)) {
+		dev_err_probe(dev, -EINVAL,
+			      "Battery failed to probe\n");
+		goto out_node_put;
+	}
 
 	charger->chg_ps = devm_power_supply_register(&pdev->dev,
 						     &rk817_chg_desc, &pscfg);
-	if (IS_ERR(charger->chg_ps))
-		return dev_err_probe(dev, -EINVAL,
-				     "Charger failed to probe\n");
+	if (IS_ERR(charger->chg_ps)) {
+		dev_err_probe(dev, -EINVAL,
+			      "Charger failed to probe\n");
+		goto out_node_put;
+	}
 
 	ret = power_supply_get_battery_info(charger->bat_ps,
 					    &bat_info);
 	if (ret) {
-		return dev_err_probe(dev, ret,
-				     "Unable to get battery info: %d\n", ret);
+		dev_err_probe(dev, ret,
+			      "Unable to get battery info: %d\n", ret);
+		goto out_node_put;
 	}
 
 	if ((bat_info->charge_full_design_uah <= 0) ||
@@ -1143,8 +1151,10 @@ static int rk817_charger_probe(struct platform_device *pdev)
 	    (bat_info->constant_charge_voltage_max_uv <= 0) ||
 	    (bat_info->constant_charge_current_max_ua <= 0) ||
 	    (bat_info->charge_term_current_ua <= 0)) {
-		return dev_err_probe(dev, -EINVAL,
-				     "Required bat info missing or invalid\n");
+		ret = -EINVAL;
+		dev_err_probe(dev, ret,
+			      "Required bat info missing or invalid\n");
+		goto out_node_put;
 	}
 
 	charger->bat_charge_full_design_uah = bat_info->charge_full_design_uah;
@@ -1157,25 +1167,30 @@ static int rk817_charger_probe(struct platform_device *pdev)
 	 */
 	ret = rk817_battery_init(charger, bat_info);
 	if (ret)
-		return ret;
+		goto out_node_put;
 
 	power_supply_put_battery_info(charger->bat_ps, bat_info);
 
 	plugin_irq = platform_get_irq(pdev, 0);
-	if (plugin_irq < 0)
-		return plugin_irq;
+	if (plugin_irq < 0) {
+		ret = plugin_irq;
+		goto out_node_put;
+	}
 
 	plugout_irq = platform_get_irq(pdev, 1);
-	if (plugout_irq < 0)
-		return plugout_irq;
+	if (plugout_irq < 0) {
+		ret = plugout_irq;
+		goto out_node_put;
+	}
 
 	ret = devm_request_threaded_irq(charger->dev, plugin_irq, NULL,
 					rk817_plug_in_isr,
 					IRQF_TRIGGER_RISING | IRQF_ONESHOT,
 					"rk817_plug_in", charger);
 	if (ret) {
-		return dev_err_probe(&pdev->dev, ret,
-				      "plug_in_irq request failed!\n");
+		dev_err_probe(&pdev->dev, ret,
+			      "plug_in_irq request failed!\n");
+		goto out_node_put;
 	}
 
 	ret = devm_request_threaded_irq(charger->dev, plugout_irq, NULL,
@@ -1183,19 +1198,24 @@ static int rk817_charger_probe(struct platform_device *pdev)
 					IRQF_TRIGGER_RISING | IRQF_ONESHOT,
 					"rk817_plug_out", charger);
 	if (ret) {
-		return dev_err_probe(&pdev->dev, ret,
-				     "plug_out_irq request failed!\n");
+		dev_err_probe(&pdev->dev, ret,
+			      "plug_out_irq request failed!\n");
+		goto out_node_put;
 	}
 
 	ret = devm_delayed_work_autocancel(&pdev->dev, &charger->work,
 					   rk817_charging_monitor);
 	if (ret)
-		return ret;
+		goto out_node_put;
 
 	/* Force the first update immediately. */
 	mod_delayed_work(system_wq, &charger->work, 0);
 
 	return 0;
+
+out_node_put:
+	of_node_put(node);
+	return ret;
 }
 
 
-- 
2.34.1

