Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 869B096EDC
	for <lists+linux-pm@lfdr.de>; Wed, 21 Aug 2019 03:27:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727003AbfHUB1Q (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 20 Aug 2019 21:27:16 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:40638 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726924AbfHUB04 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 20 Aug 2019 21:26:56 -0400
Received: by mail-pg1-f194.google.com with SMTP id w10so320294pgj.7;
        Tue, 20 Aug 2019 18:26:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3PEozNEjIcBsUnGgaGokry4KnsPMMmX11Jfq2zToHko=;
        b=itZKABTMvEtmsdTfx0PBzmZNbA3MgE/AmhU3K21umyLXu+6NfYW+AI+re2dWTpgoCl
         ISaF5+vYcYWxRRI9DDQPJJ5uEue+sBbP8CbJqklHzUw5AXywbGP5SHuAkG+K2ZKSJOQy
         gBhpy5uH8L9LFG8D8W2UDGBwybrX7+jBHqg/NX0XH/R6SWH2RutYhCrKwAIpt1tI+QTp
         Mq39mMzPx5lToFeqxEO1edZMGPGebLFjfEvfcpRF5evznGKKa8v4iixn6oW3tPdma77B
         Isk2G47sd2cJ+HoeXbYzoj6nC4Cw5KRhIASZicUoAdrcx4mNjrm3i+bvJeEXEmy+HdJP
         eFnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3PEozNEjIcBsUnGgaGokry4KnsPMMmX11Jfq2zToHko=;
        b=AJ9PgW/5+Zzc0pDA3mbv3U9zRWkner5GWHBUmwiFFzLLEGiKsjl/KagFja47WGbTTN
         N9V6W7uN/xcqGIWnkwats110opecApN411d9YJbY5+S2ya9z0jYuC+U12J+aWD/rHRbT
         W1fP2k/xhzp1drkvsnyGOinFsGdhJTqPPK6bZeq9g8XCFyWFxW2/QhkorxpmGCw5aygR
         /24qO3N9Gu29PdtpRbfckDFpo1fuTCHg0GKKzEuKEESOrbcFbKAjoox79C1358GPM91n
         leOm1NHOzQqaSzb15CjcqQLL2NczKFyjFT1YAUziS2vNrJdnnkSCcsC99kSLwhz7JNea
         kVGw==
X-Gm-Message-State: APjAAAXwKzaQaZS9QKHjI1tAh7mHLEzfv97fYe/qW2muud1Z+/ikWdOY
        XcxKrdjVoVW/MPhYv/1+Fi3uNAT46S8=
X-Google-Smtp-Source: APXvYqyoNqGvgc2LvQQ5ZKUtt1fxvcGkvfXWLM0lvAYM0DVnMrlJl6xv+hwts0w3qk8FQG9Z18qJtw==
X-Received: by 2002:a62:cd45:: with SMTP id o66mr33661298pfg.112.1566350815183;
        Tue, 20 Aug 2019 18:26:55 -0700 (PDT)
Received: from localhost.lan (c-67-185-54-80.hsd1.wa.comcast.net. [67.185.54.80])
        by smtp.gmail.com with ESMTPSA id bt18sm1162700pjb.1.2019.08.20.18.26.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2019 18:26:54 -0700 (PDT)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     linux-pm@vger.kernel.org
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Lucas Stach <l.stach@pengutronix.de>,
        Chris Healy <cphealy@gmail.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Angus Ainslie <angus@akkea.ca>, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org
Subject: [RESEND PATCH v6 08/12] thermal: qoriq: Convert driver to use regmap API
Date:   Tue, 20 Aug 2019 18:26:08 -0700
Message-Id: <20190821012612.7823-9-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190821012612.7823-1-andrew.smirnov@gmail.com>
References: <20190821012612.7823-1-andrew.smirnov@gmail.com>
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
 drivers/thermal/qoriq_thermal.c | 159 +++++++++++++++-----------------
 1 file changed, 74 insertions(+), 85 deletions(-)

diff --git a/drivers/thermal/qoriq_thermal.c b/drivers/thermal/qoriq_thermal.c
index 80fe9adcc313..08167ebe6060 100644
--- a/drivers/thermal/qoriq_thermal.c
+++ b/drivers/thermal/qoriq_thermal.c
@@ -8,6 +8,7 @@
 #include <linux/io.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
+#include <linux/regmap.h>
 #include <linux/thermal.h>
 
 #include "thermal_core.h"
@@ -17,48 +18,27 @@
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
@@ -67,8 +47,7 @@ struct qoriq_sensor {
 };
 
 struct qoriq_tmu_data {
-	struct qoriq_tmu_regs __iomem *regs;
-	bool little_endian;
+	struct regmap *regmap;
 	struct qoriq_sensor	sensor[SITES_MAX];
 };
 
@@ -77,29 +56,13 @@ static struct qoriq_tmu_data *qoriq_sensor_to_data(struct qoriq_sensor *s)
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
@@ -135,7 +98,8 @@ static int qoriq_tmu_register_tmu_zone(struct device *dev,
 
 	/* Enable monitoring */
 	if (sites != 0)
-		tmu_write(qdata, sites | TMR_ME | TMR_ALPF, &qdata->regs->tmr);
+		regmap_write(qdata->regmap, REGS_TMR,
+			     sites | TMR_ME | TMR_ALPF);
 
 	return 0;
 }
@@ -154,10 +118,8 @@ static int qoriq_tmu_calibration(struct device *dev,
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
@@ -167,9 +129,9 @@ static int qoriq_tmu_calibration(struct device *dev,
 
 	for (i = 0; i < len; i += 8, calibration += 2) {
 		val = of_read_number(calibration, 1);
-		tmu_write(data, val, &data->regs->ttcfgr);
+		regmap_write(data->regmap, REGS_TTCFGR, val);
 		val = of_read_number(calibration + 1, 1);
-		tmu_write(data, val, &data->regs->tscfgr);
+		regmap_write(data->regmap, REGS_TSCFGR, val);
 	}
 
 	return 0;
@@ -178,15 +140,32 @@ static int qoriq_tmu_calibration(struct device *dev,
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
@@ -194,26 +173,44 @@ static int qoriq_tmu_probe(struct platform_device *pdev)
 	struct device_node *np = pdev->dev.of_node;
 	struct device *dev = &pdev->dev;
 	struct resource *io;
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
 	io = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	if (!io) {
 		dev_err(dev, "Failed to get memory region\n");
 		return -ENODEV;
 	}
 
-	data->regs = devm_ioremap(dev, io->start, resource_size(io));
-	if (!data->regs) {
+	base = devm_ioremap(dev, io->start, resource_size(io));
+	if (!base) {
 		dev_err(dev, "Failed to get memory region\n");
 		return -ENODEV;
 	}
 
+	data->regmap = devm_regmap_init_mmio(dev, base, &regmap_config);
+	if (IS_ERR(data->regmap)) {
+		ret = PTR_ERR(data->regmap);
+		dev_err(dev, "Failed to init regmap (%d)\n", ret);
+		return ret;
+	}
+
 	qoriq_tmu_init_device(data);	/* TMU initialization */
 
 	ret = qoriq_tmu_calibration(dev, data);	/* TMU calibration */
@@ -236,7 +233,7 @@ static int qoriq_tmu_remove(struct platform_device *pdev)
 	struct qoriq_tmu_data *data = platform_get_drvdata(pdev);
 
 	/* Disable monitoring */
-	tmu_write(data, TMR_DISABLE, &data->regs->tmr);
+	regmap_write(data->regmap, REGS_TMR, TMR_DISABLE);
 
 	platform_set_drvdata(pdev, NULL);
 
@@ -244,30 +241,22 @@ static int qoriq_tmu_remove(struct platform_device *pdev)
 }
 
 #ifdef CONFIG_PM_SLEEP
-static int qoriq_tmu_suspend(struct device *dev)
+
+static int qoriq_tmu_suspend_resume(struct device *dev, unsigned int val)
 {
-	u32 tmr;
 	struct qoriq_tmu_data *data = dev_get_drvdata(dev);
 
-	/* Disable monitoring */
-	tmr = tmu_read(data, &data->regs->tmr);
-	tmr &= ~TMR_ME;
-	tmu_write(data, tmr, &data->regs->tmr);
+	return regmap_update_bits(data->regmap, REGS_TMR, TMR_ME, val);
+}
 
-	return 0;
+static int qoriq_tmu_suspend(struct device *dev)
+{
+	return qoriq_tmu_suspend_resume(dev, 0);
 }
 
 static int qoriq_tmu_resume(struct device *dev)
 {
-	u32 tmr;
-	struct qoriq_tmu_data *data = dev_get_drvdata(dev);
-
-	/* Enable monitoring */
-	tmr = tmu_read(data, &data->regs->tmr);
-	tmr |= TMR_ME;
-	tmu_write(data, tmr, &data->regs->tmr);
-
-	return 0;
+	return qoriq_tmu_suspend_resume(dev, TMR_ME);
 }
 #endif
 
-- 
2.21.0

