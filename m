Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AFD42322F3
	for <lists+linux-pm@lfdr.de>; Wed, 29 Jul 2020 18:53:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727006AbgG2Qw6 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 29 Jul 2020 12:52:58 -0400
Received: from alexa-out-sd-01.qualcomm.com ([199.106.114.38]:40377 "EHLO
        alexa-out-sd-01.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726341AbgG2Qwz (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 29 Jul 2020 12:52:55 -0400
Received: from unknown (HELO ironmsg01-sd.qualcomm.com) ([10.53.140.141])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 29 Jul 2020 09:52:54 -0700
Received: from gurus-linux.qualcomm.com ([10.46.162.81])
  by ironmsg01-sd.qualcomm.com with ESMTP; 29 Jul 2020 09:52:54 -0700
Received: by gurus-linux.qualcomm.com (Postfix, from userid 383780)
        id 9BEDF16C0; Wed, 29 Jul 2020 09:52:54 -0700 (PDT)
From:   Guru Das Srinagesh <gurus@codeaurora.org>
To:     Amit Kucheria <amit.kucheria@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>, linux-pm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Cc:     Subbaraman Narayanamurthy <subbaram@codeaurora.org>,
        David Collins <collinsd@codeaurora.org>,
        linux-kernel@vger.kernel.org,
        Guru Das Srinagesh <gurus@codeaurora.org>
Subject: [PATCH v2 2/2] thermal: qcom-spmi-temp-alarm: add support for GEN2 rev 1 PMIC peripherals
Date:   Wed, 29 Jul 2020 09:52:52 -0700
Message-Id: <69c90a004b3f5b7ae282f5ec5ca2920a48f23e02.1596040416.git.gurus@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <944856eb819081268fab783236a916257de120e4.1596040416.git.gurus@codeaurora.org>
References: <944856eb819081268fab783236a916257de120e4.1596040416.git.gurus@codeaurora.org>
In-Reply-To: <944856eb819081268fab783236a916257de120e4.1596040416.git.gurus@codeaurora.org>
References: <944856eb819081268fab783236a916257de120e4.1596040416.git.gurus@codeaurora.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: David Collins <collinsd@codeaurora.org>

Add support for TEMP_ALARM GEN2 PMIC peripherals with digital
major revision 1.  This revision utilizes a different temperature
threshold mapping than earlier revisions.

Signed-off-by: David Collins <collinsd@codeaurora.org>
Signed-off-by: Guru Das Srinagesh <gurus@codeaurora.org>
---
Changes from v1:
- Added space padding for the arrays, moved "||" to previous line

 drivers/thermal/qcom/qcom-spmi-temp-alarm.c | 91 +++++++++++++++++++----------
 1 file changed, 61 insertions(+), 30 deletions(-)

diff --git a/drivers/thermal/qcom/qcom-spmi-temp-alarm.c b/drivers/thermal/qcom/qcom-spmi-temp-alarm.c
index 6dc879f..7419e19 100644
--- a/drivers/thermal/qcom/qcom-spmi-temp-alarm.c
+++ b/drivers/thermal/qcom/qcom-spmi-temp-alarm.c
@@ -17,6 +17,7 @@
 
 #include "../thermal_core.h"
 
+#define QPNP_TM_REG_DIG_MAJOR		0x01
 #define QPNP_TM_REG_TYPE		0x04
 #define QPNP_TM_REG_SUBTYPE		0x05
 #define QPNP_TM_REG_STATUS		0x08
@@ -38,26 +39,30 @@
 
 #define ALARM_CTRL_FORCE_ENABLE		BIT(7)
 
-/*
- * Trip point values based on threshold control
- * 0 = {105 C, 125 C, 145 C}
- * 1 = {110 C, 130 C, 150 C}
- * 2 = {115 C, 135 C, 155 C}
- * 3 = {120 C, 140 C, 160 C}
-*/
-#define TEMP_STAGE_STEP			20000	/* Stage step: 20.000 C */
-#define TEMP_STAGE_HYSTERESIS		2000
+#define THRESH_COUNT			4
+#define STAGE_COUNT			3
+
+/* Over-temperature trip point values in mC */
+static const long temp_map_gen1[THRESH_COUNT][STAGE_COUNT] = {
+	{ 105000, 125000, 145000 },
+	{ 110000, 130000, 150000 },
+	{ 115000, 135000, 155000 },
+	{ 120000, 140000, 160000 },
+};
+
+static const long temp_map_gen2_v1[THRESH_COUNT][STAGE_COUNT] = {
+	{  90000, 110000, 140000 },
+	{  95000, 115000, 145000 },
+	{ 100000, 120000, 150000 },
+	{ 105000, 125000, 155000 },
+};
 
-#define TEMP_THRESH_MIN			105000	/* Threshold Min: 105 C */
-#define TEMP_THRESH_STEP		5000	/* Threshold step: 5 C */
+#define TEMP_THRESH_STEP		5000 /* Threshold step: 5 C */
 
 #define THRESH_MIN			0
 #define THRESH_MAX			3
 
-/* Stage 2 Threshold Min: 125 C */
-#define STAGE2_THRESHOLD_MIN		125000
-/* Stage 2 Threshold Max: 140 C */
-#define STAGE2_THRESHOLD_MAX		140000
+#define TEMP_STAGE_HYSTERESIS		2000
 
 /* Temperature in Milli Celsius reported during stage 0 if no ADC is present */
 #define DEFAULT_TEMP			37000
@@ -77,6 +82,7 @@ struct qpnp_tm_chip {
 	bool				initialized;
 
 	struct iio_channel		*adc;
+	const long			(*temp_map)[THRESH_COUNT][STAGE_COUNT];
 };
 
 /* This array maps from GEN2 alarm state to GEN1 alarm stage */
@@ -101,6 +107,23 @@ static int qpnp_tm_write(struct qpnp_tm_chip *chip, u16 addr, u8 data)
 }
 
 /**
+ * qpnp_tm_decode_temp() - return temperature in mC corresponding to the
+ *		specified over-temperature stage
+ * @chip:		Pointer to the qpnp_tm chip
+ * @stage:		Over-temperature stage
+ *
+ * Return: temperature in mC
+ */
+static long qpnp_tm_decode_temp(struct qpnp_tm_chip *chip, unsigned int stage)
+{
+	if (!chip->temp_map || chip->thresh >= THRESH_COUNT || stage == 0 ||
+	    stage > STAGE_COUNT)
+		return 0;
+
+	return (*chip->temp_map)[chip->thresh][stage - 1];
+}
+
+/**
  * qpnp_tm_get_temp_stage() - return over-temperature stage
  * @chip:		Pointer to the qpnp_tm chip
  *
@@ -149,14 +172,12 @@ static int qpnp_tm_update_temp_no_adc(struct qpnp_tm_chip *chip)
 
 	if (stage_new > stage_old) {
 		/* increasing stage, use lower bound */
-		chip->temp = (stage_new - 1) * TEMP_STAGE_STEP +
-			     chip->thresh * TEMP_THRESH_STEP +
-			     TEMP_STAGE_HYSTERESIS + TEMP_THRESH_MIN;
+		chip->temp = qpnp_tm_decode_temp(chip, stage_new)
+				+ TEMP_STAGE_HYSTERESIS;
 	} else if (stage_new < stage_old) {
 		/* decreasing stage, use upper bound */
-		chip->temp = stage_new * TEMP_STAGE_STEP +
-			     chip->thresh * TEMP_THRESH_STEP -
-			     TEMP_STAGE_HYSTERESIS + TEMP_THRESH_MIN;
+		chip->temp = qpnp_tm_decode_temp(chip, stage_new + 1)
+				- TEMP_STAGE_HYSTERESIS;
 	}
 
 	chip->stage = stage;
@@ -199,26 +220,28 @@ static int qpnp_tm_get_temp(void *data, int *temp)
 static int qpnp_tm_update_critical_trip_temp(struct qpnp_tm_chip *chip,
 					     int temp)
 {
-	u8 reg;
+	long stage2_threshold_min = (*chip->temp_map)[THRESH_MIN][1];
+	long stage2_threshold_max = (*chip->temp_map)[THRESH_MAX][1];
 	bool disable_s2_shutdown = false;
+	u8 reg;
 
 	WARN_ON(!mutex_is_locked(&chip->lock));
 
 	/*
 	 * Default: S2 and S3 shutdown enabled, thresholds at
-	 * 105C/125C/145C, monitoring at 25Hz
+	 * lowest threshold set, monitoring at 25Hz
 	 */
 	reg = SHUTDOWN_CTRL1_RATE_25HZ;
 
 	if (temp == THERMAL_TEMP_INVALID ||
-	    temp < STAGE2_THRESHOLD_MIN) {
+	    temp < stage2_threshold_min) {
 		chip->thresh = THRESH_MIN;
 		goto skip;
 	}
 
-	if (temp <= STAGE2_THRESHOLD_MAX) {
+	if (temp <= stage2_threshold_max) {
 		chip->thresh = THRESH_MAX -
-			((STAGE2_THRESHOLD_MAX - temp) /
+			((stage2_threshold_max - temp) /
 			 TEMP_THRESH_STEP);
 		disable_s2_shutdown = true;
 	} else {
@@ -326,9 +349,7 @@ static int qpnp_tm_init(struct qpnp_tm_chip *chip)
 		? chip->stage : alarm_state_map[chip->stage];
 
 	if (stage)
-		chip->temp = chip->thresh * TEMP_THRESH_STEP +
-			     (stage - 1) * TEMP_STAGE_STEP +
-			     TEMP_THRESH_MIN;
+		chip->temp = qpnp_tm_decode_temp(chip, stage);
 
 	crit_temp = qpnp_tm_get_critical_trip_temp(chip);
 	ret = qpnp_tm_update_critical_trip_temp(chip, crit_temp);
@@ -350,7 +371,7 @@ static int qpnp_tm_probe(struct platform_device *pdev)
 {
 	struct qpnp_tm_chip *chip;
 	struct device_node *node;
-	u8 type, subtype;
+	u8 type, subtype, dig_major;
 	u32 res;
 	int ret, irq;
 
@@ -400,6 +421,12 @@ static int qpnp_tm_probe(struct platform_device *pdev)
 		return ret;
 	}
 
+	ret = qpnp_tm_read(chip, QPNP_TM_REG_DIG_MAJOR, &dig_major);
+	if (ret < 0) {
+		dev_err(&pdev->dev, "could not read dig_major\n");
+		return ret;
+	}
+
 	if (type != QPNP_TM_TYPE || (subtype != QPNP_TM_SUBTYPE_GEN1
 				     && subtype != QPNP_TM_SUBTYPE_GEN2)) {
 		dev_err(&pdev->dev, "invalid type 0x%02x or subtype 0x%02x\n",
@@ -408,6 +435,10 @@ static int qpnp_tm_probe(struct platform_device *pdev)
 	}
 
 	chip->subtype = subtype;
+	if (subtype == QPNP_TM_SUBTYPE_GEN2 && dig_major >= 1)
+		chip->temp_map = &temp_map_gen2_v1;
+	else
+		chip->temp_map = &temp_map_gen1;
 
 	/*
 	 * Register the sensor before initializing the hardware to be able to
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

