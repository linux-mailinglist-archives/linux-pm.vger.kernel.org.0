Return-Path: <linux-pm+bounces-11612-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EE659401A5
	for <lists+linux-pm@lfdr.de>; Tue, 30 Jul 2024 01:15:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DDAEF282CB0
	for <lists+linux-pm@lfdr.de>; Mon, 29 Jul 2024 23:15:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B49DA18EFF4;
	Mon, 29 Jul 2024 23:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="EqRaABvK"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7B5319048F;
	Mon, 29 Jul 2024 23:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722294860; cv=none; b=ZeG0fgTct2isnDnUCpmXp7qsa6k/fRltu5uMlpWn1TrPOWl4en4bgokteBH7VAvDckarragR/VjrYx7x2N/ca9Eute4+5N1NbrNti7IaTh/KUV02xHdnNfjFsSnRM2iryt7IHK8jYsIVqC0dctxyQRzHDQDkTUU1JVJ3eg0ovMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722294860; c=relaxed/simple;
	bh=SoQFq2rFKsdwH/zOFSzVmOkp81UNE9WUZDwAKLBAc1E=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=W9t30qyRSXNEwF2tkb5EHPmSSiU5v/+BYhpeOt+qQDrSItlJQ5uWyySwAv8P/ZOvTiA4UG2POJGqsoa64r2QHAlYUWFQNBMEYpGmEokG0+hV2gt2biqeEpoaMozY3mX+dgtGotyLp01FU+dlRnxsNkhELyejaQgANwZkr43t7rU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=EqRaABvK; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46TMlaNP012347;
	Mon, 29 Jul 2024 23:13:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	5limLs/776z0AEdK9qGU8mlmWroYiqV1O3QhWPK4/YI=; b=EqRaABvKCM4jRR/H
	Pza0f6LJmqiKamXf58McQxdcz+XcMUY8QfFbp+ombxF+kbmnf3FkFIy962TYXwOS
	Gy1d+ovYOjCHKG81UpijuW+NPVPK8S+ubzztO/Pvc0oznLiM66ljo6ah+msQFG7B
	BIGnhNjxmapx1XBXW1T54Z4yv2zZlSL4S8BYtgCxsJu4HUV2Dm2Ti8322xQQJ4AF
	q+QNe9LZrIDNyz8GSWYmj4Pf7H6lRdQT2jGF05FBPI2PyEukn3GoN3+CRn1kgvXW
	+jqNGHhB9M7BRXQCTDOIM9eJTm/OP/xvkp4XLAxlYCTsYl7jUbjqHrlw0Xom16M8
	A8IDSA==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 40mr7gnnmw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 29 Jul 2024 23:13:45 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 46TNDiTt004012
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 29 Jul 2024 23:13:44 GMT
Received: from hu-amelende-lv.qualcomm.com (10.49.16.6) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Mon, 29 Jul 2024 16:13:44 -0700
From: Anjelique Melendez <quic_amelende@quicinc.com>
To: <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <amitk@kernel.org>, <thara.gopinath@gmail.com>, <andersson@kernel.org>
CC: <quic_collinsd@quicinc.com>, <rafael@kernel.org>,
        <daniel.lezcano@linaro.org>, <rui.zhang@intel.com>,
        <lukasz.luba@arm.com>, <linux-arm-msm@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        "Anjelique
 Melendez" <quic_amelende@quicinc.com>
Subject: [PATCH 5/5] thermal: qcom-spmi-temp-alarm: add support for LITE PMIC peripherals
Date: Mon, 29 Jul 2024 16:12:59 -0700
Message-ID: <20240729231259.2122976-6-quic_amelende@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240729231259.2122976-1-quic_amelende@quicinc.com>
References: <20240729231259.2122976-1-quic_amelende@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 2MWzISC04lUvu3Ajixu4AeQAnfVx-SEM
X-Proofpoint-GUID: 2MWzISC04lUvu3Ajixu4AeQAnfVx-SEM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-29_20,2024-07-26_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 bulkscore=0
 impostorscore=0 adultscore=0 mlxscore=0 lowpriorityscore=0 malwarescore=0
 spamscore=0 clxscore=1015 priorityscore=1501 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2407110000
 definitions=main-2407290159

Add support for TEMP_ALARM LITE PMIC peripherals.  This subtype
utilizes a pair of registers to configure a warning interrupt
threshold temperature and an automatic hardware shutdown
threshold temperature.

Co-developed-by: David Collins <quic_collinsd@quicinc.com>
Signed-off-by: David Collins <quic_collinsd@quicinc.com>
Signed-off-by: Anjelique Melendez <quic_amelende@quicinc.com>
---
 drivers/thermal/qcom/qcom-spmi-temp-alarm.c | 208 +++++++++++++++++++-
 1 file changed, 202 insertions(+), 6 deletions(-)

diff --git a/drivers/thermal/qcom/qcom-spmi-temp-alarm.c b/drivers/thermal/qcom/qcom-spmi-temp-alarm.c
index 1f56acd8f637..e50ce66ec096 100644
--- a/drivers/thermal/qcom/qcom-spmi-temp-alarm.c
+++ b/drivers/thermal/qcom/qcom-spmi-temp-alarm.c
@@ -4,6 +4,7 @@
  * Copyright (c) 2024, Qualcomm Innovation Center, Inc. All rights reserved.
  */
 
+#include <linux/bitfield.h>
 #include <linux/bitops.h>
 #include <linux/delay.h>
 #include <linux/err.h>
@@ -22,21 +23,28 @@
 #define QPNP_TM_REG_TYPE		0x04
 #define QPNP_TM_REG_SUBTYPE		0x05
 #define QPNP_TM_REG_STATUS		0x08
+#define QPNP_TM_REG_IRQ_STATUS		0x10
 #define QPNP_TM_REG_SHUTDOWN_CTRL1	0x40
 #define QPNP_TM_REG_ALARM_CTRL		0x46
 /* TEMP_DAC_* registers are only present for TEMP_GEN2 v2.0 */
 #define QPNP_TM_REG_TEMP_DAC_STG1	0x47
 #define QPNP_TM_REG_TEMP_DAC_STG2	0x48
 #define QPNP_TM_REG_TEMP_DAC_STG3	0x49
+#define QPNP_TM_REG_LITE_TEMP_CFG1	0x50
+#define QPNP_TM_REG_LITE_TEMP_CFG2	0x51
 
 #define QPNP_TM_TYPE			0x09
 #define QPNP_TM_SUBTYPE_GEN1		0x08
 #define QPNP_TM_SUBTYPE_GEN2		0x09
+#define QPNP_TM_SUBTYPE_LITE		0xC0
 
 #define STATUS_GEN1_STAGE_MASK		GENMASK(1, 0)
 #define STATUS_GEN2_STATE_MASK		GENMASK(6, 4)
 #define STATUS_GEN2_STATE_SHIFT		4
 
+/* IRQ status only needed for TEMP_ALARM_LITE */
+#define IRQ_STATUS_MASK			BIT(0)
+
 #define SHUTDOWN_CTRL1_OVERRIDE_S2	BIT(6)
 #define SHUTDOWN_CTRL1_THRESHOLD_MASK	GENMASK(1, 0)
 
@@ -44,6 +52,8 @@
 
 #define ALARM_CTRL_FORCE_ENABLE		BIT(7)
 
+#define LITE_TEMP_CFG_THRESHOLD_MASK	GENMASK(3, 2)
+
 #define THRESH_COUNT			4
 #define STAGE_COUNT			3
 
@@ -88,6 +98,19 @@ static const long temp_dac_max[STAGE_COUNT] = {
 	119375, 159375, 159375
 };
 
+/*
+ * TEMP_ALARM_LITE has two stages: warning and shutdown with independently
+ * configured threshold temperatures.
+ */
+
+static const long temp_map_lite_warning[THRESH_COUNT] = {
+	115000, 125000, 135000, 145000
+};
+
+static const long temp_map_lite_shutdown[THRESH_COUNT] = {
+	135000, 145000, 160000, 175000
+};
+
 /* Temperature in Milli Celsius reported during stage 0 if no ADC is present */
 #define DEFAULT_TEMP			37000
 
@@ -171,19 +194,26 @@ static long qpnp_tm_decode_temp(struct qpnp_tm_chip *chip, unsigned int stage)
  * qpnp_tm_get_temp_stage() - return over-temperature stage
  * @chip:		Pointer to the qpnp_tm chip
  *
- * Return: stage (GEN1) or state (GEN2) on success, or errno on failure.
+ * Return: stage (GEN1), state (GEN2), or alarm interrupt state (LITE) on
+ *	   success; or errno on failure.
  */
 static int qpnp_tm_get_temp_stage(struct qpnp_tm_chip *chip)
 {
 	int ret;
+	u16 addr = QPNP_TM_REG_STATUS;
 	u8 reg = 0;
 
-	ret = qpnp_tm_read(chip, QPNP_TM_REG_STATUS, &reg);
+	if (chip->subtype == QPNP_TM_SUBTYPE_LITE)
+		addr = QPNP_TM_REG_IRQ_STATUS;
+
+	ret = qpnp_tm_read(chip, addr, &reg);
 	if (ret < 0)
 		return ret;
 
 	if (chip->subtype == QPNP_TM_SUBTYPE_GEN1)
 		ret = reg & STATUS_GEN1_STAGE_MASK;
+	else if (chip->subtype == QPNP_TM_SUBTYPE_LITE)
+		ret = reg & IRQ_STATUS_MASK;
 	else
 		ret = (reg & STATUS_GEN2_STATE_MASK) >> STATUS_GEN2_STATE_SHIFT;
 
@@ -206,7 +236,8 @@ static int qpnp_tm_update_temp_no_adc(struct qpnp_tm_chip *chip)
 		return ret;
 	stage = ret;
 
-	if (chip->subtype == QPNP_TM_SUBTYPE_GEN1) {
+	if (chip->subtype == QPNP_TM_SUBTYPE_GEN1
+	    || chip->subtype == QPNP_TM_SUBTYPE_LITE) {
 		stage_new = stage;
 		stage_old = chip->stage;
 	} else {
@@ -289,6 +320,78 @@ static int qpnp_tm_gen2_rev2_set_temp_thresh(struct qpnp_tm_chip *chip, int trip
 	return 0;
 }
 
+static int qpnp_tm_lite_set_temp_thresh(struct qpnp_tm_chip *chip, int trip,
+				       int temp)
+{
+	int ret, temp_cfg, i;
+	const long *temp_map;
+	u16 addr;
+	u8 reg, thresh;
+
+	if (trip < 0 || trip >= STAGE_COUNT) {
+		dev_err(chip->dev, "invalid TEMP_LITE trip = %d\n", trip);
+		return -EINVAL;
+	}
+
+	switch (trip) {
+	case 0:
+		temp_map = temp_map_lite_warning;
+		addr = QPNP_TM_REG_LITE_TEMP_CFG1;
+		break;
+	case 1:
+		/*
+		 * The second trip point is purely in software to facilitate
+		 * a controlled shutdown after the warning threshold is crossed
+		 * but before the automatic hardware shutdown threshold is
+		 * crossed.
+		 */
+		return 0;
+	case 2:
+		temp_map = temp_map_lite_shutdown;
+		addr = QPNP_TM_REG_LITE_TEMP_CFG2;
+		break;
+	default:
+		return 0;
+	}
+
+	if (temp < temp_map[THRESH_MIN] || temp > temp_map[THRESH_MAX]) {
+		dev_err(chip->dev, "invalid TEMP_LITE temp = %d\n", temp);
+		return -EINVAL;
+	}
+
+	thresh = 0;
+	temp_cfg = temp_map[thresh];
+	for (i = THRESH_MAX; i >= THRESH_MIN; i--) {
+		if (temp >= temp_map[i]) {
+			thresh = i;
+			temp_cfg = temp_map[i];
+			break;
+		}
+	}
+
+	if (temp_cfg == chip->temp_dac_map[trip])
+		return 0;
+
+	ret = qpnp_tm_read(chip, addr, &reg);
+	if (ret < 0) {
+		dev_err(chip->dev, "LITE_TEMP_CFG read failed, ret=%d\n", ret);
+		return ret;
+	}
+
+	reg &= ~LITE_TEMP_CFG_THRESHOLD_MASK;
+	reg |= FIELD_PREP(LITE_TEMP_CFG_THRESHOLD_MASK, thresh);
+
+	ret = qpnp_tm_write(chip, addr, reg);
+	if (ret < 0) {
+		dev_err(chip->dev, "LITE_TEMP_CFG write failed, ret=%d\n", ret);
+		return ret;
+	}
+
+	chip->temp_dac_map[trip] = temp_cfg;
+
+	return 0;
+}
+
 static int qpnp_tm_update_critical_trip_temp(struct qpnp_tm_chip *chip,
 					     int temp)
 {
@@ -374,6 +477,24 @@ static const struct thermal_zone_device_ops qpnp_tm_gen2_rev2_sensor_ops = {
 	.set_trip_temp = qpnp_tm_gen2_rev2_set_trip_temp,
 };
 
+static int qpnp_tm_lite_set_trip_temp(struct thermal_zone_device *tz,
+					   int trip, int temp)
+{
+	struct qpnp_tm_chip *chip = tz->devdata;
+	int ret;
+
+	mutex_lock(&chip->lock);
+	ret = qpnp_tm_lite_set_temp_thresh(chip, trip, temp);
+	mutex_unlock(&chip->lock);
+
+	return ret;
+}
+
+static const struct thermal_zone_device_ops qpnp_tm_lite_sensor_ops = {
+	.get_temp = qpnp_tm_get_temp,
+	.set_trip_temp = qpnp_tm_lite_set_trip_temp,
+};
+
 static irqreturn_t qpnp_tm_isr(int irq, void *data)
 {
 	struct qpnp_tm_chip *chip = data;
@@ -452,6 +573,68 @@ static int qpnp_tm_gen2_rev2_init(struct qpnp_tm_chip *chip)
 	return 0;
 }
 
+/* Configure TEMP_LITE registers based on DT thermal_zone trips */
+static int qpnp_tm_lite_update_trip_temps(struct qpnp_tm_chip *chip)
+{
+	struct thermal_trip trip = {0};
+	int ret, ntrips, i;
+
+	ntrips = thermal_zone_get_num_trips(chip->tz_dev);
+	/* Keep hardware defaults if no DT trips are defined. */
+	if (ntrips <= 0)
+		return 0;
+
+	for (i = 0; i < ntrips; i++) {
+		ret = thermal_zone_get_trip(chip->tz_dev, i, &trip);
+		if (ret < 0)
+			return ret;
+
+		ret = qpnp_tm_lite_set_temp_thresh(chip, i, trip.temperature);
+		if (ret < 0)
+			return ret;
+	}
+
+	/* Verify that trips are strictly increasing. */
+	if (chip->temp_dac_map[2] <= chip->temp_dac_map[0]) {
+		dev_err(chip->dev, "Threshold 2=%ld <= threshold 0=%ld\n",
+			chip->temp_dac_map[2], chip->temp_dac_map[0]);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+/* Read the hardware default TEMP_LITE stage threshold temperatures */
+static int qpnp_tm_lite_init(struct qpnp_tm_chip *chip)
+{
+	int ret, thresh;
+	u8 reg = 0;
+
+	/*
+	 * Store the warning trip temp in temp_dac_map[0] and the shutdown trip
+	 * temp in temp_dac_map[2].  The second trip point is purely in software
+	 * to facilitate a controlled shutdown after the warning threshold is
+	 * crossed but before the automatic hardware shutdown threshold is
+	 * crossed.  Thus, there is no register to read for the second trip
+	 * point.
+	 */
+	ret = qpnp_tm_read(chip, QPNP_TM_REG_LITE_TEMP_CFG1, &reg);
+	if (ret < 0)
+		return ret;
+
+	thresh = FIELD_GET(LITE_TEMP_CFG_THRESHOLD_MASK, reg);
+	chip->temp_dac_map[0] = temp_map_lite_warning[thresh];
+
+	ret = qpnp_tm_read(chip, QPNP_TM_REG_LITE_TEMP_CFG2, &reg);
+	if (ret < 0)
+		return ret;
+
+	thresh = FIELD_GET(LITE_TEMP_CFG_THRESHOLD_MASK, reg);
+	chip->temp_dac_map[2] = temp_map_lite_shutdown[thresh];
+
+	return 0;
+}
+
 static const struct spmi_temp_alarm_data spmi_temp_alarm_data = {
 	.ops = &qpnp_tm_sensor_ops,
 	.has_temp_dac = false,
@@ -466,6 +649,13 @@ static const struct spmi_temp_alarm_data spmi_temp_alarm_gen2_rev2_data = {
 	.update_trip_temps = qpnp_tm_gen2_rev2_update_trip_temps,
 };
 
+static const struct spmi_temp_alarm_data spmi_temp_alarm_lite_data = {
+	.ops = &qpnp_tm_lite_sensor_ops,
+	.has_temp_dac = true,
+	.setup = qpnp_tm_lite_init,
+	.update_trip_temps = qpnp_tm_lite_update_trip_temps,
+};
+
 /*
  * This function initializes the internal temp value based on only the
  * current thermal stage and threshold. Setup threshold control and
@@ -492,8 +682,9 @@ static int qpnp_tm_init(struct qpnp_tm_chip *chip)
 		goto out;
 	chip->stage = ret;
 
-	stage = (chip->subtype == QPNP_TM_SUBTYPE_GEN1)
-		? chip->stage : alarm_state_map[chip->stage];
+	stage = (chip->subtype == QPNP_TM_SUBTYPE_GEN1
+		 || chip->subtype == QPNP_TM_SUBTYPE_LITE)
+			? chip->stage : alarm_state_map[chip->stage];
 
 	if (stage)
 		chip->temp = qpnp_tm_decode_temp(chip, stage);
@@ -611,7 +802,8 @@ static int qpnp_tm_probe(struct platform_device *pdev)
 	}
 
 	if (type != QPNP_TM_TYPE || (subtype != QPNP_TM_SUBTYPE_GEN1
-				     && subtype != QPNP_TM_SUBTYPE_GEN2)) {
+				     && subtype != QPNP_TM_SUBTYPE_GEN2
+				     && subtype != QPNP_TM_SUBTYPE_LITE)) {
 		dev_err(&pdev->dev, "invalid type 0x%02x or subtype 0x%02x\n",
 			type, subtype);
 		return -ENODEV;
@@ -662,6 +854,10 @@ static const struct of_device_id qpnp_tm_match_table[] = {
 		.compatible = "qcom,spmi-temp-alarm-gen2-rev2",
 		.data = &spmi_temp_alarm_gen2_rev2_data,
 	},
+	{
+		.compatible = "qcom,spmi-temp-alarm-lite",
+		.data = &spmi_temp_alarm_lite_data,
+	},
 	{ }
 };
 MODULE_DEVICE_TABLE(of, qpnp_tm_match_table);
-- 
2.34.1


