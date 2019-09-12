Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0FC47B068C
	for <lists+linux-pm@lfdr.de>; Thu, 12 Sep 2019 03:35:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728298AbfILBfA (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 11 Sep 2019 21:35:00 -0400
Received: from mail-pg1-f182.google.com ([209.85.215.182]:44714 "EHLO
        mail-pg1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726157AbfILBfA (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 11 Sep 2019 21:35:00 -0400
Received: by mail-pg1-f182.google.com with SMTP id i18so12469731pgl.11;
        Wed, 11 Sep 2019 18:34:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=A/iLWd49EumACfVrmrrNo36J3HAn0AfKJ4UQXuVqJXM=;
        b=TIWO9z1y48vLwJpsX+rJbGXXfT4hzT2292VzfZbWi2vbZDLolbOyHjKjkuinH+HoxO
         bznMWm8iAYC37DcArpOLu0y6UDbikxF7qs9zmoQs9Ejpc31c6jPZgCT3WNzEJOrQNe3s
         kNovhfjwxTwtEzqi9H3WpuDgaLK/ddOMCIZt43HVxRmIwNm/QcxOEaNoCKInjqiQp5ue
         Ujd8f7clWRKKldqd7WFSeA3H+yA+sb2gn78KdOSZkQv7VuM1/NpNjDeYfd8XXlByd1fU
         OTTriwXgWFigTa1Rig13ZIFS9dWjpwSBJVE+IEACywVHQK4xrGkwLs0qSxK6/DcKBWGt
         6nqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=A/iLWd49EumACfVrmrrNo36J3HAn0AfKJ4UQXuVqJXM=;
        b=Qlagy7nTnrNVf91YxvPO8mCIZPpfsSkU1HxRxgeT4Ccpu0hFWB8toSHyk5pxJxWWko
         GmDu66Jg7K4cZwtw0RmXip7gQLH5ZoimU9XNS7WPxBJSrtHtMtpZQrH3a59W7hPAOZOE
         Qen8qcoTGdrF+SEge0hDKc7sKg3IEB6n3mU5+nQ0A3KhzrSmA10+fmYnQdyTahKOUGgO
         qc0VzqKR16npPiOrGwC6nvV5uXQi70P7qSx3jGGF+V1j62oxhhznIjeGFx/7qe0Lbu+e
         J1igs+ufACa/z5mArlZv7nSVR2lvTysAZny8geN2nsgr9yv3EZRCGtSCcPgnzaGuRJOG
         OBLw==
X-Gm-Message-State: APjAAAXQgLeZCcPx2CzzuyJJxGPxDI838PJB/m6VViyw61FCZsqd86Do
        GtKrJBqg8W4atpgPLx4eCAg=
X-Google-Smtp-Source: APXvYqw6Pj6eCE4mHLNalGicIkhmdRBoJUzlNRXsXEtbhV8YvHCMMo90N2zpwgkMKMKJTBTklmh3og==
X-Received: by 2002:a63:e20a:: with SMTP id q10mr34990935pgh.24.1568252099203;
        Wed, 11 Sep 2019 18:34:59 -0700 (PDT)
Received: from localhost.lan (c-67-185-54-80.hsd1.wa.comcast.net. [67.185.54.80])
        by smtp.gmail.com with ESMTPSA id b126sm35248236pfa.177.2019.09.11.18.34.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Sep 2019 18:34:58 -0700 (PDT)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     Zhang Rui <rui.zhang@intel.com>
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Lucas Stach <l.stach@pengutronix.de>,
        Chris Healy <cphealy@gmail.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Angus Ainslie <angus@akkea.ca>, linux-imx@nxp.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v7 08/12] thermal: qoriq: Convert driver to use regmap API
Date:   Wed, 11 Sep 2019 18:34:43 -0700
Message-Id: <20190912013447.2977-2-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190912013447.2977-1-andrew.smirnov@gmail.com>
References: <20190912012920.29601-1-andrew.smirnov@gmail.com>
 <20190912013447.2977-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Convert driver to use regmap API, drop custom LE/BE IO helpers and
simplify bit manipulation using regmap_update_bits(). This also allows
us to convert some register initialization to use loops and adds
convenient debug access to TMU registers via debugfs.

Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
Reviewed-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Tested-by: Lucas Stach <l.stach@pengutronix.de>
Cc: Chris Healy <cphealy@gmail.com>
Cc: Lucas Stach <l.stach@pengutronix.de>
Cc: Eduardo Valentin <edubezval@gmail.com>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Angus Ainslie (Purism) <angus@akkea.ca>
Cc: linux-imx@nxp.com
Cc: linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 drivers/thermal/qoriq_thermal.c | 153 +++++++++++++++-----------------
 1 file changed, 72 insertions(+), 81 deletions(-)

diff --git a/drivers/thermal/qoriq_thermal.c b/drivers/thermal/qoriq_thermal.c
index 8a28a4433d44..32bf5ed57f5c 100644
--- a/drivers/thermal/qoriq_thermal.c
+++ b/drivers/thermal/qoriq_thermal.c
@@ -9,6 +9,7 @@
 #include <linux/io.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
+#include <linux/regmap.h>
 #include <linux/thermal.h>
 
 #include "thermal_core.h"
@@ -18,48 +19,27 @@
 /*
  * QorIQ TMU Registers
  */
-struct qoriq_tmu_site_regs {
-	u32 tritsr;		/* Immediate Temperature Site Register */
-	u32 tratsr;		/* Average Temperature Site Register */
-	u8 res0[0x8];
-};
 
-struct qoriq_tmu_regs {
-	u32 tmr;		/* Mode Register */
+#define REGS_TMR	0x000	/* Mode Register */
 #define TMR_DISABLE	0x0
 #define TMR_ME		0x80000000
 #define TMR_ALPF	0x0c000000
-	u32 tsr;		/* Status Register */
-	u32 tmtmir;		/* Temperature measurement interval Register */
+
+#define REGS_TMTMIR	0x008	/* Temperature measurement interval Register */
 #define TMTMIR_DEFAULT	0x0000000f
-	u8 res0[0x14];
-	u32 tier;		/* Interrupt Enable Register */
+
+#define REGS_TIER	0x020	/* Interrupt Enable Register */
 #define TIER_DISABLE	0x0
-	u32 tidr;		/* Interrupt Detect Register */
-	u32 tiscr;		/* Interrupt Site Capture Register */
-	u32 ticscr;		/* Interrupt Critical Site Capture Register */
-	u8 res1[0x10];
-	u32 tmhtcrh;		/* High Temperature Capture Register */
-	u32 tmhtcrl;		/* Low Temperature Capture Register */
-	u8 res2[0x8];
-	u32 tmhtitr;		/* High Temperature Immediate Threshold */
-	u32 tmhtatr;		/* High Temperature Average Threshold */
-	u32 tmhtactr;	/* High Temperature Average Crit Threshold */
-	u8 res3[0x24];
-	u32 ttcfgr;		/* Temperature Configuration Register */
-	u32 tscfgr;		/* Sensor Configuration Register */
-	u8 res4[0x78];
-	struct qoriq_tmu_site_regs site[SITES_MAX];
-	u8 res5[0x9f8];
-	u32 ipbrr0;		/* IP Block Revision Register 0 */
-	u32 ipbrr1;		/* IP Block Revision Register 1 */
-	u8 res6[0x310];
-	u32 ttr0cr;		/* Temperature Range 0 Control Register */
-	u32 ttr1cr;		/* Temperature Range 1 Control Register */
-	u32 ttr2cr;		/* Temperature Range 2 Control Register */
-	u32 ttr3cr;		/* Temperature Range 3 Control Register */
-};
 
+#define REGS_TTCFGR	0x080	/* Temperature Configuration Register */
+#define REGS_TSCFGR	0x084	/* Sensor Configuration Register */
+
+#define REGS_TRITSR(n)	(0x100 + 16 * (n)) /* Immediate Temperature
+					    * Site Register
+					    */
+#define REGS_TTRnCR(n)	(0xf10 + 4 * (n)) /* Temperature Range n
+					   * Control Register
+					   */
 /*
  * Thermal zone data
  */
@@ -68,9 +48,8 @@ struct qoriq_sensor {
 };
 
 struct qoriq_tmu_data {
-	struct qoriq_tmu_regs __iomem *regs;
+	struct regmap *regmap;
 	struct clk *clk;
-	bool little_endian;
 	struct qoriq_sensor	sensor[SITES_MAX];
 };
 
@@ -79,29 +58,13 @@ static struct qoriq_tmu_data *qoriq_sensor_to_data(struct qoriq_sensor *s)
 	return container_of(s, struct qoriq_tmu_data, sensor[s->id]);
 }
 
-static void tmu_write(struct qoriq_tmu_data *p, u32 val, void __iomem *addr)
-{
-	if (p->little_endian)
-		iowrite32(val, addr);
-	else
-		iowrite32be(val, addr);
-}
-
-static u32 tmu_read(struct qoriq_tmu_data *p, void __iomem *addr)
-{
-	if (p->little_endian)
-		return ioread32(addr);
-	else
-		return ioread32be(addr);
-}
-
 static int tmu_get_temp(void *p, int *temp)
 {
 	struct qoriq_sensor *qsensor = p;
 	struct qoriq_tmu_data *qdata = qoriq_sensor_to_data(qsensor);
 	u32 val;
 
-	val = tmu_read(qdata, &qdata->regs->site[qsensor->id].tritsr);
+	regmap_read(qdata->regmap, REGS_TRITSR(qsensor->id), &val);
 	*temp = (val & 0xff) * 1000;
 
 	return 0;
@@ -139,7 +102,8 @@ static int qoriq_tmu_register_tmu_zone(struct device *dev,
 
 	/* Enable monitoring */
 	if (sites != 0)
-		tmu_write(qdata, sites | TMR_ME | TMR_ALPF, &qdata->regs->tmr);
+		regmap_write(qdata->regmap, REGS_TMR,
+			     sites | TMR_ME | TMR_ALPF);
 
 	return 0;
 }
@@ -158,10 +122,8 @@ static int qoriq_tmu_calibration(struct device *dev,
 	}
 
 	/* Init temperature range registers */
-	tmu_write(data, range[0], &data->regs->ttr0cr);
-	tmu_write(data, range[1], &data->regs->ttr1cr);
-	tmu_write(data, range[2], &data->regs->ttr2cr);
-	tmu_write(data, range[3], &data->regs->ttr3cr);
+	for (i = 0; i < ARRAY_SIZE(range); i++)
+		regmap_write(data->regmap, REGS_TTRnCR(i), range[i]);
 
 	calibration = of_get_property(np, "fsl,tmu-calibration", &len);
 	if (calibration == NULL || len % 8) {
@@ -171,9 +133,9 @@ static int qoriq_tmu_calibration(struct device *dev,
 
 	for (i = 0; i < len; i += 8, calibration += 2) {
 		val = of_read_number(calibration, 1);
-		tmu_write(data, val, &data->regs->ttcfgr);
+		regmap_write(data->regmap, REGS_TTCFGR, val);
 		val = of_read_number(calibration + 1, 1);
-		tmu_write(data, val, &data->regs->tscfgr);
+		regmap_write(data->regmap, REGS_TSCFGR, val);
 	}
 
 	return 0;
@@ -182,33 +144,68 @@ static int qoriq_tmu_calibration(struct device *dev,
 static void qoriq_tmu_init_device(struct qoriq_tmu_data *data)
 {
 	/* Disable interrupt, using polling instead */
-	tmu_write(data, TIER_DISABLE, &data->regs->tier);
+	regmap_write(data->regmap, REGS_TIER, TIER_DISABLE);
 
 	/* Set update_interval */
-	tmu_write(data, TMTMIR_DEFAULT, &data->regs->tmtmir);
+	regmap_write(data->regmap, REGS_TMTMIR, TMTMIR_DEFAULT);
 
 	/* Disable monitoring */
-	tmu_write(data, TMR_DISABLE, &data->regs->tmr);
+	regmap_write(data->regmap, REGS_TMR, TMR_DISABLE);
 }
 
+static const struct regmap_range qoriq_yes_ranges[] = {
+	regmap_reg_range(REGS_TMR, REGS_TSCFGR),
+	regmap_reg_range(REGS_TTRnCR(0), REGS_TTRnCR(3)),
+	/* Read only registers below */
+	regmap_reg_range(REGS_TRITSR(0), REGS_TRITSR(15)),
+};
+
+static const struct regmap_access_table qoriq_wr_table = {
+	.yes_ranges	= qoriq_yes_ranges,
+	.n_yes_ranges	= ARRAY_SIZE(qoriq_yes_ranges) - 1,
+};
+
+static const struct regmap_access_table qoriq_rd_table = {
+	.yes_ranges	= qoriq_yes_ranges,
+	.n_yes_ranges	= ARRAY_SIZE(qoriq_yes_ranges),
+};
+
 static int qoriq_tmu_probe(struct platform_device *pdev)
 {
 	int ret;
 	struct qoriq_tmu_data *data;
 	struct device_node *np = pdev->dev.of_node;
 	struct device *dev = &pdev->dev;
+	const bool little_endian = of_property_read_bool(np, "little-endian");
+	const enum regmap_endian format_endian =
+		little_endian ? REGMAP_ENDIAN_LITTLE : REGMAP_ENDIAN_BIG;
+	const struct regmap_config regmap_config = {
+		.reg_bits		= 32,
+		.val_bits		= 32,
+		.reg_stride		= 4,
+		.rd_table		= &qoriq_rd_table,
+		.wr_table		= &qoriq_wr_table,
+		.val_format_endian	= format_endian,
+		.max_register		= SZ_4K,
+	};
+	void __iomem *base;
 
 	data = devm_kzalloc(dev, sizeof(struct qoriq_tmu_data),
 			    GFP_KERNEL);
 	if (!data)
 		return -ENOMEM;
 
-	data->little_endian = of_property_read_bool(np, "little-endian");
-
-	data->regs = devm_platform_ioremap_resource(pdev, 0);
-	if (IS_ERR(data->regs)) {
+	base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(base)) {
 		dev_err(dev, "Failed to get memory region\n");
-		return PTR_ERR(data->regs);
+		return PTR_ERR(base);
+	}
+
+	data->regmap = devm_regmap_init_mmio(dev, base, &regmap_config);
+	ret = PTR_ERR_OR_ZERO(data->regmap);
+	if (ret) {
+		dev_err(dev, "Failed to init regmap (%d)\n", ret);
+		return ret;
 	}
 
 	data->clk = devm_clk_get_optional(dev, NULL);
@@ -249,7 +246,7 @@ static int qoriq_tmu_remove(struct platform_device *pdev)
 	struct qoriq_tmu_data *data = platform_get_drvdata(pdev);
 
 	/* Disable monitoring */
-	tmu_write(data, TMR_DISABLE, &data->regs->tmr);
+	regmap_write(data->regmap, REGS_TMR, TMR_DISABLE);
 
 	clk_disable_unprepare(data->clk);
 
@@ -258,13 +255,12 @@ static int qoriq_tmu_remove(struct platform_device *pdev)
 
 static int __maybe_unused qoriq_tmu_suspend(struct device *dev)
 {
-	u32 tmr;
 	struct qoriq_tmu_data *data = dev_get_drvdata(dev);
+	int ret;
 
-	/* Disable monitoring */
-	tmr = tmu_read(data, &data->regs->tmr);
-	tmr &= ~TMR_ME;
-	tmu_write(data, tmr, &data->regs->tmr);
+	ret = regmap_update_bits(data->regmap, REGS_TMR, TMR_ME, 0);
+	if (ret)
+		return ret;
 
 	clk_disable_unprepare(data->clk);
 
@@ -273,7 +269,6 @@ static int __maybe_unused qoriq_tmu_suspend(struct device *dev)
 
 static int __maybe_unused qoriq_tmu_resume(struct device *dev)
 {
-	u32 tmr;
 	int ret;
 	struct qoriq_tmu_data *data = dev_get_drvdata(dev);
 
@@ -282,11 +277,7 @@ static int __maybe_unused qoriq_tmu_resume(struct device *dev)
 		return ret;
 
 	/* Enable monitoring */
-	tmr = tmu_read(data, &data->regs->tmr);
-	tmr |= TMR_ME;
-	tmu_write(data, tmr, &data->regs->tmr);
-
-	return 0;
+	return regmap_update_bits(data->regmap, REGS_TMR, TMR_ME, TMR_ME);
 }
 
 static SIMPLE_DEV_PM_OPS(qoriq_tmu_pm_ops,
-- 
2.21.0

