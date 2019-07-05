Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 99DF860064
	for <lists+linux-pm@lfdr.de>; Fri,  5 Jul 2019 07:05:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727271AbfGEFFn (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 5 Jul 2019 01:05:43 -0400
Received: from inva020.nxp.com ([92.121.34.13]:58262 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726824AbfGEFFl (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 5 Jul 2019 01:05:41 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 604BB1A0E89;
        Fri,  5 Jul 2019 07:05:39 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 459BC1A006E;
        Fri,  5 Jul 2019 07:05:27 +0200 (CEST)
Received: from titan.ap.freescale.net (TITAN.ap.freescale.net [10.192.208.233])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id E7391402DF;
        Fri,  5 Jul 2019 13:05:13 +0800 (SGT)
From:   Anson.Huang@nxp.com
To:     rui.zhang@intel.com, edubezval@gmail.com,
        daniel.lezcano@linaro.org, robh+dt@kernel.org,
        mark.rutland@arm.com, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, mturquette@baylibre.com,
        sboyd@kernel.org, l.stach@pengutronix.de, abel.vesa@nxp.com,
        andrew.smirnov@gmail.com, angus@akkea.ca, ccaione@baylibre.com,
        agx@sigxcpu.org, leonard.crestez@nxp.com, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org
Cc:     Linux-imx@nxp.com
Subject: [PATCH 4/6] thermal: qoriq: Add clock operations
Date:   Fri,  5 Jul 2019 12:56:10 +0800
Message-Id: <20190705045612.27665-4-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20190705045612.27665-1-Anson.Huang@nxp.com>
References: <20190705045612.27665-1-Anson.Huang@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Anson Huang <Anson.Huang@nxp.com>

Some platforms like i.MX8MQ has clock control for this module,
need to add clock operations to make sure the driver is working
properly.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 drivers/thermal/qoriq_thermal.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/thermal/qoriq_thermal.c b/drivers/thermal/qoriq_thermal.c
index 2b2f79b..0813c1b 100644
--- a/drivers/thermal/qoriq_thermal.c
+++ b/drivers/thermal/qoriq_thermal.c
@@ -2,6 +2,7 @@
 //
 // Copyright 2016 Freescale Semiconductor, Inc.
 
+#include <linux/clk.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
 #include <linux/err.h>
@@ -72,6 +73,7 @@ struct qoriq_sensor {
 
 struct qoriq_tmu_data {
 	struct qoriq_tmu_regs __iomem *regs;
+	struct clk *clk;
 	bool little_endian;
 	struct qoriq_sensor	*sensor[SITES_MAX];
 };
@@ -208,6 +210,19 @@ static int qoriq_tmu_probe(struct platform_device *pdev)
 		return PTR_ERR(data->regs);
 	}
 
+	data->clk = devm_clk_get(&pdev->dev, NULL);
+	if (IS_ERR(data->clk)) {
+		if (PTR_ERR(data->clk) == -EPROBE_DEFER)
+			return -EPROBE_DEFER;
+		data->clk = NULL;
+	}
+
+	ret = clk_prepare_enable(data->clk);
+	if (ret) {
+		dev_err(&pdev->dev, "Failed to enable clock\n");
+		return ret;
+	}
+
 	qoriq_tmu_init_device(data);	/* TMU initialization */
 
 	ret = qoriq_tmu_calibration(pdev);	/* TMU calibration */
@@ -235,6 +250,8 @@ static int qoriq_tmu_remove(struct platform_device *pdev)
 	/* Disable monitoring */
 	tmu_write(data, TMR_DISABLE, &data->regs->tmr);
 
+	clk_disable_unprepare(data->clk);
+
 	platform_set_drvdata(pdev, NULL);
 
 	return 0;
@@ -250,14 +267,21 @@ static int __maybe_unused qoriq_tmu_suspend(struct device *dev)
 	tmr &= ~TMR_ME;
 	tmu_write(data, tmr, &data->regs->tmr);
 
+	clk_disable_unprepare(data->clk);
+
 	return 0;
 }
 
 static int __maybe_unused qoriq_tmu_resume(struct device *dev)
 {
 	u32 tmr;
+	int ret;
 	struct qoriq_tmu_data *data = dev_get_drvdata(dev);
 
+	ret = clk_prepare_enable(data->clk);
+	if (ret)
+		return ret;
+
 	/* Enable monitoring */
 	tmr = tmu_read(data, &data->regs->tmr);
 	tmr |= TMR_ME;
-- 
2.7.4

