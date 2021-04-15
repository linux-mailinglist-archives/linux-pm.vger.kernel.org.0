Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4F8A3608D1
	for <lists+linux-pm@lfdr.de>; Thu, 15 Apr 2021 14:04:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232821AbhDOME0 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 15 Apr 2021 08:04:26 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:59462 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232789AbhDOMEZ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 15 Apr 2021 08:04:25 -0400
Date:   Thu, 15 Apr 2021 12:04:00 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1618488241;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+GwUiz3PJl6cbuQ/RvduN2q1Rsep60YCq6eCVGDejFk=;
        b=YVgLGDYVA5XLUNI5sY6GMNe43CoJeep9ywMLNpguRhwId1WUOiLq8WZC4Sk2c0sKQaf2kG
        r6JfhVtGElLTURbk8Z2ao4rwXRqlmIogP79+JgsTBx2PasnsMjb3+oQlPuy6Ck0tRJYqsh
        cBGzLwYtAZS6OaNFnoHOZOxWKpyNzbPp2pwNLwJIw/WpFL+gEDfA0//Y4L1Rojb/I9RaP4
        fG1ELuccgFlSJXqZDcrgdCVMg6hGt1sSdLSGqW39U0JlCXK3ju6QRku/SAoz0l489CuQpV
        Snm93Ry85OXKo10KvgQ7+P0/5bOAqlqQwjw4HMAJVQTxp+WO13w1M+LI8WMqIQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1618488241;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+GwUiz3PJl6cbuQ/RvduN2q1Rsep60YCq6eCVGDejFk=;
        b=dLqBjuQQR957r8j4BZ7tb99BT8y6VzlqAkfUDBu74c8DGWPrVxPrbH6XhrnrpN7++lT39w
        mUQQ2YMh/aFfVDDA==
From:   "thermal-bot for David Collins" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-pm@vger.kernel.org
To:     linux-pm@vger.kernel.org
Subject: [thermal: thermal/next] thermal/drivers/qcom-spmi-temp-alarm: Add
 support for GEN2 rev 1 PMIC peripherals
Cc:     David Collins <collinsd@codeaurora.org>,
        Guru Das Srinagesh <gurus@codeaurora.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        rui.zhang@intel.com, amitk@kernel.org
In-Reply-To: =?utf-8?q?=3C69c90a004b3f5b7ae282f5ec5ca2920a48f23e02=2E15960?=
 =?utf-8?q?40416=2Egit=2Egurus=40codeaurora=2Eorg=3E?=
References: =?utf-8?q?=3C69c90a004b3f5b7ae282f5ec5ca2920a48f23e02=2E159604?=
 =?utf-8?q?0416=2Egit=2Egurus=40codeaurora=2Eorg=3E?=
MIME-Version: 1.0
Message-ID: <161848824092.29796.7032682425536549376.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The following commit has been merged into the thermal/next branch of thermal:

Commit-ID:     aa92b3310c55b21153ca1514719ff8d5dfe74bd7
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git//aa92b3310c55b21153ca1514719ff8d5dfe74bd7
Author:        David Collins <collinsd@codeaurora.org>
AuthorDate:    Wed, 29 Jul 2020 09:52:52 -07:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Thu, 15 Apr 2021 13:21:42 +02:00

thermal/drivers/qcom-spmi-temp-alarm: Add support for GEN2 rev 1 PMIC peripherals

Add support for TEMP_ALARM GEN2 PMIC peripherals with digital
major revision 1.  This revision utilizes a different temperature
threshold mapping than earlier revisions.

Signed-off-by: David Collins <collinsd@codeaurora.org>
Signed-off-by: Guru Das Srinagesh <gurus@codeaurora.org>
Reviewed-by: Stephen Boyd <sboyd@kernel.org>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/69c90a004b3f5b7ae282f5ec5ca2920a48f23e02.1596040416.git.gurus@codeaurora.org
---
 drivers/thermal/qcom/qcom-spmi-temp-alarm.c | 91 +++++++++++++-------
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
