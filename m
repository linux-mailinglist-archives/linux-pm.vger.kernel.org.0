Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A31F6D1A8E
	for <lists+linux-pm@lfdr.de>; Wed,  9 Oct 2019 23:06:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731593AbfJIVGh (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 9 Oct 2019 17:06:37 -0400
Received: from muru.com ([72.249.23.125]:36522 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729908AbfJIVGh (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 9 Oct 2019 17:06:37 -0400
Received: from hillo.muru.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTP id CCA358162;
        Wed,  9 Oct 2019 21:07:08 +0000 (UTC)
From:   Tony Lindgren <tony@atomide.com>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     linux-pm@vger.kernel.org, linux-omap@vger.kernel.org,
        Merlijn Wajer <merlijn@wizzup.org>, Pavel Machek <pavel@ucw.cz>
Subject: [PATCH 5/5] power: supply: cpcap-battery: Add basic coulomb counter calibrate support
Date:   Wed,  9 Oct 2019 14:06:21 -0700
Message-Id: <20191009210621.10522-6-tony@atomide.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191009210621.10522-1-tony@atomide.com>
References: <20191009210621.10522-1-tony@atomide.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This patch adds support for the coulomb counter calibration on init. We do
this by polling for now, and only add partial calibration done interrupt
support.

Then later on when we know for sure we have the calibration done interrupt
available in the device tree, we can switch to using the calibration done
interrupt.

Cc: Merlijn Wajer <merlijn@wizzup.org>
Cc: Pavel Machek <pavel@ucw.cz>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/power/supply/cpcap-battery.c | 96 +++++++++++++++++++++++++---
 1 file changed, 88 insertions(+), 8 deletions(-)

diff --git a/drivers/power/supply/cpcap-battery.c b/drivers/power/supply/cpcap-battery.c
--- a/drivers/power/supply/cpcap-battery.c
+++ b/drivers/power/supply/cpcap-battery.c
@@ -50,6 +50,26 @@
 #define CPCAP_REG_BPEOL_BIT_BATTDETEN	BIT(1)	/* Enable battery detect */
 #define CPCAP_REG_BPEOL_BIT_EOLSEL	BIT(0)	/* BPDET = 0, EOL = 1 */
 
+/*
+ * Register bit defines for CPCAP_REG_CCC1. These seem similar to the twl6030
+ * coulomb counter registers rather than the mc13892 registers. Both twl6030
+ * and mc13892 set bits 2 and 1 to reset and clear registers. But mc13892
+ * sets bit 0 to start the coulomb counter while twl6030 sets bit 0 to stop
+ * the coulomb counter like cpcap does. So for now, we use the twl6030 style
+ * naming for the registers.
+ */
+#define CPCAP_REG_CCC1_ACTIVE_MODE1	BIT(4)	/* Update rate */
+#define CPCAP_REG_CCC1_ACTIVE_MODE0	BIT(3)	/* Update rate */
+#define CPCAP_REG_CCC1_AUTOCLEAR	BIT(2)	/* Resets sample registers */
+#define CPCAP_REG_CCC1_CAL_EN		BIT(1)	/* Clears after write in 1s */
+#define CPCAP_REG_CCC1_PAUSE		BIT(0)	/* Stop counters, allow write */
+#define CPCAP_REG_CCC1_RESET_MASK	(CPCAP_REG_CCC1_AUTOCLEAR | \
+					 CPCAP_REG_CCC1_CAL_EN)
+
+#define CPCAP_REG_CCCC2_RATE1		BIT(5)
+#define CPCAP_REG_CCCC2_RATE0		BIT(4)
+#define CPCAP_REG_CCCC2_ENABLE		BIT(3)
+
 #define CPCAP_BATTERY_CC_SAMPLE_PERIOD_MS	250
 
 enum {
@@ -62,6 +82,7 @@ enum {
 
 enum cpcap_battery_irq_action {
 	CPCAP_BATTERY_IRQ_ACTION_NONE,
+	CPCAP_BATTERY_IRQ_ACTION_CC_CAL_DONE,
 	CPCAP_BATTERY_IRQ_ACTION_BATTERY_LOW,
 	CPCAP_BATTERY_IRQ_ACTION_POWEROFF,
 };
@@ -74,7 +95,6 @@ struct cpcap_interrupt_desc {
 };
 
 struct cpcap_battery_config {
-	int ccm;
 	int cd_factor;
 	struct power_supply_info info;
 	struct power_supply_battery_info bat;
@@ -609,6 +629,9 @@ static irqreturn_t cpcap_battery_irq_thread(int irq, void *data)
 	latest = cpcap_battery_latest(ddata);
 
 	switch (d->action) {
+	case CPCAP_BATTERY_IRQ_ACTION_CC_CAL_DONE:
+		dev_info(ddata->dev, "Coulomb counter calibration done\n");
+		break;
 	case CPCAP_BATTERY_IRQ_ACTION_BATTERY_LOW:
 		if (latest->current_ua >= 0)
 			dev_warn(ddata->dev, "Battery low at %imV!\n",
@@ -661,7 +684,9 @@ static int cpcap_battery_init_irq(struct platform_device *pdev,
 	d->name = name;
 	d->irq = irq;
 
-	if (!strncmp(name, "lowbph", 6))
+	if (!strncmp(name, "cccal", 5))
+		d->action = CPCAP_BATTERY_IRQ_ACTION_CC_CAL_DONE;
+	else if (!strncmp(name, "lowbph", 6))
 		d->action = CPCAP_BATTERY_IRQ_ACTION_BATTERY_LOW;
 	else if (!strncmp(name, "lowbpl", 6))
 		d->action = CPCAP_BATTERY_IRQ_ACTION_POWEROFF;
@@ -687,6 +712,9 @@ static int cpcap_battery_init_interrupts(struct platform_device *pdev,
 			return error;
 	}
 
+	/* Enable calibration interrupt if already available in dts */
+	cpcap_battery_init_irq(pdev, ddata, "cccal");
+
 	/* Enable low battery interrupts for 3.3V high and 3.1V low */
 	error = regmap_update_bits(ddata->reg, CPCAP_REG_BPEOL,
 				   0xffff,
@@ -728,6 +756,60 @@ static int cpcap_battery_init_iio(struct cpcap_battery_ddata *ddata)
 	return error;
 }
 
+/* Calibrate coulomb counter */
+static int cpcap_battery_calibrate(struct cpcap_battery_ddata *ddata)
+{
+	int error, ccc1, value;
+	unsigned long timeout;
+
+	error = regmap_read(ddata->reg, CPCAP_REG_CCC1, &ccc1);
+	if (error)
+		return error;
+
+	timeout = jiffies + msecs_to_jiffies(6000);
+
+	/* Start calibration */
+	error = regmap_update_bits(ddata->reg, CPCAP_REG_CCC1,
+				   0xffff,
+				   CPCAP_REG_CCC1_CAL_EN);
+	if (error)
+		goto restore;
+
+	while (time_before(jiffies, timeout)) {
+		error = regmap_read(ddata->reg, CPCAP_REG_CCC1, &value);
+		if (error)
+			goto restore;
+
+		if (!(value & CPCAP_REG_CCC1_CAL_EN))
+			break;
+
+		error = regmap_read(ddata->reg, CPCAP_REG_CCM, &value);
+		if (error)
+			goto restore;
+
+		msleep(300);
+	}
+
+	/* Read calibration offset from CCM */
+	error = regmap_read(ddata->reg, CPCAP_REG_CCM, &value);
+	if (error)
+		goto restore;
+
+	dev_info(ddata->dev, "calibration done: 0x%04x\n", value);
+
+restore:
+	if (error)
+		dev_err(ddata->dev, "%s: error %i\n", __func__, error);
+
+	error = regmap_update_bits(ddata->reg, CPCAP_REG_CCC1,
+				   0xffff, ccc1);
+	if (error)
+		dev_err(ddata->dev, "%s: restore error %i\n",
+			__func__, error);
+
+	return error;
+}
+
 /*
  * Based on the values from Motorola mapphone Linux kernel. In the
  * the Motorola mapphone Linux kernel tree the value for pm_cd_factor
@@ -739,7 +821,6 @@ static int cpcap_battery_init_iio(struct cpcap_battery_ddata *ddata)
  * at 3078000. The device will die around 2743000.
  */
 static const struct cpcap_battery_config cpcap_battery_default_data = {
-	.ccm = 0x3ff,
 	.cd_factor = 0x3cc,
 	.info.technology = POWER_SUPPLY_TECHNOLOGY_LION,
 	.info.voltage_max_design = 4351000,
@@ -808,11 +889,6 @@ static int cpcap_battery_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, ddata);
 
-	error = regmap_update_bits(ddata->reg, CPCAP_REG_CCM,
-				   0xffff, ddata->config.ccm);
-	if (error)
-		return error;
-
 	error = cpcap_battery_init_interrupts(pdev, ddata);
 	if (error)
 		return error;
@@ -846,6 +922,10 @@ static int cpcap_battery_probe(struct platform_device *pdev)
 
 	atomic_set(&ddata->active, 1);
 
+	error = cpcap_battery_calibrate(ddata);
+	if (error)
+		return error;
+
 	return 0;
 }
 
-- 
2.23.0
