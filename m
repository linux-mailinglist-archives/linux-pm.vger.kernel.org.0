Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1B418118DF4
	for <lists+linux-pm@lfdr.de>; Tue, 10 Dec 2019 17:42:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727695AbfLJQmX (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 10 Dec 2019 11:42:23 -0500
Received: from mail-pj1-f65.google.com ([209.85.216.65]:38074 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727793AbfLJQmW (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 10 Dec 2019 11:42:22 -0500
Received: by mail-pj1-f65.google.com with SMTP id l4so7622478pjt.5;
        Tue, 10 Dec 2019 08:42:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=q9bf2Um2I03H1aR/t3yvhuhmSHJaNa/0Zn+VgWwhcjA=;
        b=clu6UwUAvGq2ztqNbmDKHQ4at62Rhn22aKVuDU/CgAoQnI4dnAgLMsu3W6yXng7QK7
         a2trSxKbXemF3G0k+WqQ832tcNIebUiJqNTwXoVJRlvopJnSGg8YYu6TwdALEWsf+oaR
         DRJ1Ax6pAdI+qA/aqKbtRkyMarmeY1rxTQ074Vhi4neZJgNp4q56wiZAPnNXAeakafFy
         3Rbb8gZNAsRWNw0v9j9lmJs1nOInJHcG2iQU57Trqtp8EsCZT7vfb3VGOe4QBttWBPTo
         pU4MclX/SMFgxUIqGTWtBPcmjAjSYgHn27qoUIZHJlJ9nBd5Zg9XJ143ihszZalcNxAx
         +xMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=q9bf2Um2I03H1aR/t3yvhuhmSHJaNa/0Zn+VgWwhcjA=;
        b=ll8TYSrpzA6aQvU3j3/xW3Cw2Pe/dvUBaCLCX2GxRAv49Qj6XtXzI+cf5LqV633lBE
         jt2apwOtYtq4/hiTgdhdXfEM/xDladb3c5t5nKbmiXzHIdVF746xmQR+H7FJEnZKW+02
         kmbyX/pBUENEg7Z06moACyl89Ozfi5SUy9ZXyh+huL8FrhIdnmlLPEPYycY+FNaxgjpB
         CgZVmDDSgA4VAKn5S/bUI4wf99wvtwTeUjw++DGxMbPOf3l91iNpADcp0Uyc0zqcY/Qz
         PNLKoXby7HHS8vbxPHY6L8NiJsABQ3CzEHWU/PcvGSQ3PS7dUM5OIRUlE+s0AR1ZeROi
         arzA==
X-Gm-Message-State: APjAAAUurM8g8xAzpfRN8g8T9reskD0ldkD3sYufJJ4y522wJ3O7dSFN
        ryY/pckmbs9CycbxWjWE35Y=
X-Google-Smtp-Source: APXvYqxcjD/0UpITqG0KPZRfHP5YG4Gkz9fH6MNjHVuVho4XW0Vt34CnDNxE6L/YLK1svws/3k1TAQ==
X-Received: by 2002:a17:90a:8c1:: with SMTP id 1mr6679827pjn.12.1575996141541;
        Tue, 10 Dec 2019 08:42:21 -0800 (PST)
Received: from localhost.localdomain (c-67-165-113-11.hsd1.wa.comcast.net. [67.165.113.11])
        by smtp.gmail.com with ESMTPSA id j38sm4034634pgj.27.2019.12.10.08.42.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2019 08:42:20 -0800 (PST)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Yuantian Tang <andy.tang@nxp.com>,
        Anson Huang <Anson.Huang@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Chris Healy <cphealy@gmail.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Angus Ainslie <angus@akkea.ca>, linux-imx@nxp.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v8 08/12] thermal: qoriq: Convert driver to use regmap API
Date:   Tue, 10 Dec 2019 08:41:49 -0800
Message-Id: <20191210164153.10463-9-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191210164153.10463-1-andrew.smirnov@gmail.com>
References: <20191210164153.10463-1-andrew.smirnov@gmail.com>
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

Yuantian, Anson:

I don't have access to Layerscape HW that has v2 register layout, so
if you could give this patch a try and verify that I got the
'qoriq_yes_ranges' right, I'd really appreciate it.

Thanks,
Andrey Smirnov

 drivers/thermal/qoriq_thermal.c | 228 ++++++++++++++------------------
 1 file changed, 98 insertions(+), 130 deletions(-)

diff --git a/drivers/thermal/qoriq_thermal.c b/drivers/thermal/qoriq_thermal.c
index 11749c673b3b..6227c940b9b0 100644
--- a/drivers/thermal/qoriq_thermal.c
+++ b/drivers/thermal/qoriq_thermal.c
@@ -9,6 +9,7 @@
 #include <linux/io.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
+#include <linux/regmap.h>
 #include <linux/thermal.h>
 
 #include "thermal_core.h"
@@ -24,85 +25,35 @@
 #define TMU_VER1		0x1
 #define TMU_VER2		0x2
 
-/*
- * QorIQ TMU Registers
- */
-struct qoriq_tmu_site_regs {
-	u32 tritsr;		/* Immediate Temperature Site Register */
-	u32 tratsr;		/* Average Temperature Site Register */
-	u8 res0[0x8];
-};
+#define REGS_TMR	0x000	/* Mode Register */
+#define TMR_DISABLE	0x0
+#define TMR_ME		0x80000000
+#define TMR_ALPF	0x0c000000
 
-struct qoriq_tmu_regs_v1 {
-	u32 tmr;		/* Mode Register */
-	u32 tsr;		/* Status Register */
-	u32 tmtmir;		/* Temperature measurement interval Register */
-	u8 res0[0x14];
-	u32 tier;		/* Interrupt Enable Register */
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
-	u32 ttrcr[4];		/* Temperature Range Control Register */
-};
+#define REGS_TMTMIR	0x008	/* Temperature measurement interval Register */
+#define TMTMIR_DEFAULT	0x0000000f
 
-struct qoriq_tmu_regs_v2 {
-	u32 tmr;		/* Mode Register */
-	u32 tsr;		/* Status Register */
-	u32 tmsr;		/* monitor site register */
-	u32 tmtmir;		/* Temperature measurement interval Register */
-	u8 res0[0x10];
-	u32 tier;		/* Interrupt Enable Register */
-	u32 tidr;		/* Interrupt Detect Register */
-	u8 res1[0x8];
-	u32 tiiscr;		/* interrupt immediate site capture register */
-	u32 tiascr;		/* interrupt average site capture register */
-	u32 ticscr;		/* Interrupt Critical Site Capture Register */
-	u32 res2;
-	u32 tmhtcr;		/* monitor high temperature capture register */
-	u32 tmltcr;		/* monitor low temperature capture register */
-	u32 tmrtrcr;	/* monitor rising temperature rate capture register */
-	u32 tmftrcr;	/* monitor falling temperature rate capture register */
-	u32 tmhtitr;	/* High Temperature Immediate Threshold */
-	u32 tmhtatr;	/* High Temperature Average Threshold */
-	u32 tmhtactr;	/* High Temperature Average Crit Threshold */
-	u32 res3;
-	u32 tmltitr;	/* monitor low temperature immediate threshold */
-	u32 tmltatr;	/* monitor low temperature average threshold register */
-	u32 tmltactr;	/* monitor low temperature average critical threshold */
-	u32 res4;
-	u32 tmrtrctr;	/* monitor rising temperature rate critical threshold */
-	u32 tmftrctr;	/* monitor falling temperature rate critical threshold*/
-	u8 res5[0x8];
-	u32 ttcfgr;	/* Temperature Configuration Register */
-	u32 tscfgr;	/* Sensor Configuration Register */
-	u8 res6[0x78];
-	struct qoriq_tmu_site_regs site[SITES_MAX];
-	u8 res7[0x9f8];
-	u32 ipbrr0;		/* IP Block Revision Register 0 */
-	u32 ipbrr1;		/* IP Block Revision Register 1 */
-	u8 res8[0x300];
-	u32 teumr0;
-	u32 teumr1;
-	u32 teumr2;
-	u32 res9;
-	u32 ttrcr[4];	/* Temperature Range Control Register */
-};
+#define REGS_V2_TMSR	0x008	/* monitor site register */
+
+#define REGS_V2_TMTMIR	0x00c	/* Temperature measurement interval Register */
+
+#define REGS_TIER	0x020	/* Interrupt Enable Register */
+#define TIER_DISABLE	0x0
+
+
+#define REGS_TTCFGR	0x080	/* Temperature Configuration Register */
+#define REGS_TSCFGR	0x084	/* Sensor Configuration Register */
+
+#define REGS_TRITSR(n)	(0x100 + 16 * (n)) /* Immediate Temperature
+					    * Site Register
+					    */
+#define REGS_TTRnCR(n)	(0xf10 + 4 * (n)) /* Temperature Range n
+					   * Control Register
+					   */
+#define REGS_IPBRR(n)		(0xbf8 + 4 * (n)) /* IP Block Revision
+						   * Register n
+						   */
+#define REGS_V2_TEUMR(n)	(0xf00 + 4 * (n))
 
 /*
  * Thermal zone data
@@ -113,10 +64,8 @@ struct qoriq_sensor {
 
 struct qoriq_tmu_data {
 	int ver;
-	struct qoriq_tmu_regs_v1 __iomem *regs;
-	struct qoriq_tmu_regs_v2 __iomem *regs_v2;
+	struct regmap *regmap;
 	struct clk *clk;
-	bool little_endian;
 	struct qoriq_sensor	sensor[SITES_MAX];
 };
 
@@ -125,29 +74,13 @@ static struct qoriq_tmu_data *qoriq_sensor_to_data(struct qoriq_sensor *s)
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
@@ -189,12 +122,12 @@ static int qoriq_tmu_register_tmu_zone(struct device *dev,
 	/* Enable monitoring */
 	if (sites != 0) {
 		if (qdata->ver == TMU_VER1) {
-			tmu_write(qdata, sites | TMR_ME | TMR_ALPF,
-					&qdata->regs->tmr);
+			regmap_write(qdata->regmap, REGS_TMR,
+				     sites | TMR_ME | TMR_ALPF);
 		} else {
-			tmu_write(qdata, sites, &qdata->regs_v2->tmsr);
-			tmu_write(qdata, TMR_ME | TMR_ALPF_V2,
-					&qdata->regs_v2->tmr);
+			regmap_write(qdata->regmap, REGS_V2_TMSR, sites);
+			regmap_write(qdata->regmap, REGS_TMR,
+				     TMR_ME | TMR_ALPF_V2);
 		}
 	}
 
@@ -223,7 +156,7 @@ static int qoriq_tmu_calibration(struct device *dev,
 
 	/* Init temperature range registers */
 	for (i = 0; i < len; i++)
-		tmu_write(data, range[i], &data->regs->ttrcr[i]);
+		regmap_write(data->regmap, REGS_TTRnCR(i), range[i]);
 
 	calibration = of_get_property(np, "fsl,tmu-calibration", &len);
 	if (calibration == NULL || len % 8) {
@@ -233,9 +166,9 @@ static int qoriq_tmu_calibration(struct device *dev,
 
 	for (i = 0; i < len; i += 8, calibration += 2) {
 		val = of_read_number(calibration, 1);
-		tmu_write(data, val, &data->regs->ttcfgr);
+		regmap_write(data->regmap, REGS_TTCFGR, val);
 		val = of_read_number(calibration + 1, 1);
-		tmu_write(data, val, &data->regs->tscfgr);
+		regmap_write(data->regmap, REGS_TSCFGR, val);
 	}
 
 	return 0;
@@ -244,20 +177,40 @@ static int qoriq_tmu_calibration(struct device *dev,
 static void qoriq_tmu_init_device(struct qoriq_tmu_data *data)
 {
 	/* Disable interrupt, using polling instead */
-	tmu_write(data, TIER_DISABLE, &data->regs->tier);
+	regmap_write(data->regmap, REGS_TIER, TIER_DISABLE);
 
 	/* Set update_interval */
+
 	if (data->ver == TMU_VER1) {
-		tmu_write(data, TMTMIR_DEFAULT, &data->regs->tmtmir);
+		regmap_write(data->regmap, REGS_TMTMIR, TMTMIR_DEFAULT);
 	} else {
-		tmu_write(data, TMTMIR_DEFAULT, &data->regs_v2->tmtmir);
-		tmu_write(data, TEUMR0_V2, &data->regs_v2->teumr0);
+		regmap_write(data->regmap, REGS_V2_TMTMIR, TMTMIR_DEFAULT);
+		regmap_write(data->regmap, REGS_V2_TEUMR(0), TEUMR0_V2);
 	}
 
 	/* Disable monitoring */
-	tmu_write(data, TMR_DISABLE, &data->regs->tmr);
+	regmap_write(data->regmap, REGS_TMR, TMR_DISABLE);
 }
 
+static const struct regmap_range qoriq_yes_ranges[] = {
+	regmap_reg_range(REGS_TMR, REGS_TSCFGR),
+	regmap_reg_range(REGS_TTRnCR(0), REGS_TTRnCR(3)),
+	regmap_reg_range(REGS_V2_TEUMR(0), REGS_V2_TEUMR(2)),
+	regmap_reg_range(REGS_IPBRR(0), REGS_IPBRR(1)),
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
@@ -265,18 +218,37 @@ static int qoriq_tmu_probe(struct platform_device *pdev)
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
+	ret = PTR_ERR_OR_ZERO(base);
+	if (ret) {
 		dev_err(dev, "Failed to get memory region\n");
-		return PTR_ERR(data->regs);
+		return ret;
+	}
+
+	data->regmap = devm_regmap_init_mmio(dev, base, &regmap_config);
+	ret = PTR_ERR_OR_ZERO(data->regmap);
+	if (ret) {
+		dev_err(dev, "Failed to init regmap (%d)\n", ret);
+		return ret;
 	}
 
 	data->clk = devm_clk_get_optional(dev, NULL);
@@ -290,10 +262,12 @@ static int qoriq_tmu_probe(struct platform_device *pdev)
 	}
 
 	/* version register offset at: 0xbf8 on both v1 and v2 */
-	ver = tmu_read(data, &data->regs->ipbrr0);
+	ret = regmap_read(data->regmap, REGS_IPBRR(0), &ver);
+	if (ret) {
+		dev_err(&pdev->dev, "Failed to read IP block version\n");
+		return ret;
+	}
 	data->ver = (ver >> 8) & 0xff;
-	if (data->ver == TMU_VER2)
-		data->regs_v2 = (void __iomem *)data->regs;
 
 	qoriq_tmu_init_device(data);	/* TMU initialization */
 
@@ -323,7 +297,7 @@ static int qoriq_tmu_remove(struct platform_device *pdev)
 	struct qoriq_tmu_data *data = platform_get_drvdata(pdev);
 
 	/* Disable monitoring */
-	tmu_write(data, TMR_DISABLE, &data->regs->tmr);
+	regmap_write(data->regmap, REGS_TMR, TMR_DISABLE);
 
 	clk_disable_unprepare(data->clk);
 
@@ -332,13 +306,12 @@ static int qoriq_tmu_remove(struct platform_device *pdev)
 
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
 
@@ -347,7 +320,6 @@ static int __maybe_unused qoriq_tmu_suspend(struct device *dev)
 
 static int __maybe_unused qoriq_tmu_resume(struct device *dev)
 {
-	u32 tmr;
 	int ret;
 	struct qoriq_tmu_data *data = dev_get_drvdata(dev);
 
@@ -356,11 +328,7 @@ static int __maybe_unused qoriq_tmu_resume(struct device *dev)
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

