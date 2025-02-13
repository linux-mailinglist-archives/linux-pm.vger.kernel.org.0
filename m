Return-Path: <linux-pm+bounces-22039-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8596A35017
	for <lists+linux-pm@lfdr.de>; Thu, 13 Feb 2025 22:04:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 242CE7A4380
	for <lists+linux-pm@lfdr.de>; Thu, 13 Feb 2025 21:03:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FFE8269881;
	Thu, 13 Feb 2025 21:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="YEr3JE7G"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 886A1266B65
	for <linux-pm@vger.kernel.org>; Thu, 13 Feb 2025 21:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739480653; cv=none; b=fadexnzXUpu+huzE6a0Fk8l9mZpC+N2fm2D7CC9h7iL9zXR8uTYn0JlHybfUxqP6avr6dHpvYVR79hns2+JnNa6n5CtEwVT3ME2JJJMJgh9aTaTtXDh9kRwUb80fejEd+H9Kp+vj6uJrwtvStqIzWv/jhPmYIdzPw8bqbmKNiGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739480653; c=relaxed/simple;
	bh=DecLmToxwMQkR8jL+PSo4Tt2J4g+s8DpyxCx4NCWX3Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Q455DefnI4uwLbyzeUUPouim3nMAJ03U5JJXSjCnfMPdv3hXn3eN5jCqBwJX2IfeTQpVfiU8P08uCTXL0kEZEo9e4I1GRYAK4iZDblW9AWmgpdssOzYck8bbKrR9nyclv1E88TsZiuNcCm+KJXZ7D7Ndg9vRbqMFYPCFsIUZ3NM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=YEr3JE7G; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51DHocxA007881
	for <linux-pm@vger.kernel.org>; Thu, 13 Feb 2025 21:04:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=ix8czGogiPA
	veGuEM67krjF1GRJMfjhSqgWNw496tqY=; b=YEr3JE7G9y/Y7Zz5CTVFPkpHNeK
	Qtc4KiE/qjV5PKhd4OQI4CyQGyE7uwirlox2h+qXlqo6VBePpL6/9EFtgr5dmm2H
	6KhqwGi2oKVysP1b/CoSdoEd9zSqjmecSS9YBvaROpEHKZj6EyPVTeLXvI+A6CTe
	kah6wuFFTMlMHid7v/pa9K4z3OZbZvi9UPVInpy1D7oBt28GATgJYgf2DvgOSfpC
	AgHKgu1RTHgISYtLI2egx3IZlCsY86V29Yc1KmBOZIjIMwhqq32VqhByFoTLvl4B
	w51k2PTJJZaR0DCYSi3SPMn8EixTygtsD2FV4r26fT0fOfcY2otmWjXzsbQ==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44rr1qw8sa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 13 Feb 2025 21:04:10 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-21f7671a821so26600345ad.1
        for <linux-pm@vger.kernel.org>; Thu, 13 Feb 2025 13:04:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739480650; x=1740085450;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ix8czGogiPAveGuEM67krjF1GRJMfjhSqgWNw496tqY=;
        b=sUh0sSL99uPLINUEv7BYaWresKyLIdCGTTm8M1nmJeNtXPqwTZ7NV7yE7f9EJGVQm7
         AZ0RQ8B4TIs3qGcsj/dRPrhBeQhfJVZBvCU/2ulaXpDtGOf61O6eP53bEZQ9l2LO99+p
         HASYuzDDUvxJKelln9QT5wELzZPnP+5O7vErtytGnQtQNTTn2JwSLZE+DV3ZtEmAC4h9
         mAHmRU0JNk2V8iJl4sNddKDi162dweXez0aKbuD+WsJ8C5GChEeRX32w6t5vplfX4eGO
         hfEx0E6hWGJe/NoBkqH5k34dMn7sdO3RU0lbSAiPndzWI9VweoRkj6mgF547S2QkzxBI
         xX2Q==
X-Forwarded-Encrypted: i=1; AJvYcCUjCRB4han9cp9HMqUwRwwjar5pmKVhOho8m2A0S+6cOXZmBoOqsRebzzOr5Lk8ouHCE1zDdfraeA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwdFNYgIesRndYLoPA9ON1HKTC2SdjZb7kWTB3k3+7qoyJVwHk3
	joERII5sehw9jh4p3mCTEpT3maI/HMyOAY86bKyNMkerR1wY6dQh+exifod/3rgA2FkBVRbQO48
	mhud89WMs6EQ2vU1KnBq8OCueVfXAchjfCVI8URmuqqYK3opRdGj2rrWioA==
X-Gm-Gg: ASbGncu9aU8ifLVoD5+KM8hm9M1VX7E5tqJvG7SajhwAPE3fYyGZ23XyHqGdrcQDjid
	HB3LLHeCZu9RLBcl6lpssfGY3b92OvEkeOgvxoYGoXdG9lnIOPtaKu8+D9XYFqyg9M+jz2UgDJn
	NGQead4k0rHWV2jvcWrcv2xe1+SZtDP/mJkCh3yy1EqU/jWRUp3ojrPH1S65rFHjAndFlKGAvju
	dOz3vDA2u37M2vjgs8i4JiXgz6eFW6bwcoYCZC26vRa0BWiEBBMavpTiYQtCQo56fjCGM5RSHmb
	eLz7ZI+Nr2lrPapkqzVPndkMJIDiAVyrLkMAyXksKeU4yC97k4jn6u4PMHPDT1nFnZji
X-Received: by 2002:a17:903:290:b0:216:7ee9:220b with SMTP id d9443c01a7336-220d1eee443mr87217735ad.22.1739480649776;
        Thu, 13 Feb 2025 13:04:09 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGxiHWh5/198xxh/vHKG28dp2GWtimkNHpX9GPLIowPDihT48qdQifh6lQ3aKFPzNiGhGDi6g==
X-Received: by 2002:a17:903:290:b0:216:7ee9:220b with SMTP id d9443c01a7336-220d1eee443mr87217315ad.22.1739480649332;
        Thu, 13 Feb 2025 13:04:09 -0800 (PST)
Received: from hu-amelende-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220dacfc769sm14339375ad.201.2025.02.13.13.04.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2025 13:04:09 -0800 (PST)
From: Anjelique Melendez <anjelique.melendez@oss.qualcomm.com>
To: amitk@kernel.org, thara.gopinath@gmail.com, rafael@kernel.org,
        daniel.lezcano@linaro.org
Cc: rui.zhang@intel.com, lukasz.luba@arm.com, david.collins@oss.qualcomm.com,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] thermal: qcom-spmi-temp-alarm: add support for LITE PMIC peripherals
Date: Thu, 13 Feb 2025 13:04:03 -0800
Message-Id: <20250213210403.3396392-5-anjelique.melendez@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250213210403.3396392-1-anjelique.melendez@oss.qualcomm.com>
References: <20250213210403.3396392-1-anjelique.melendez@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 0K6PF2JXnUJvQWgfNVXV8jb7nuaJHm_x
X-Proofpoint-ORIG-GUID: 0K6PF2JXnUJvQWgfNVXV8jb7nuaJHm_x
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-13_08,2025-02-13_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 adultscore=0
 mlxscore=0 impostorscore=0 spamscore=0 bulkscore=0 malwarescore=0
 lowpriorityscore=0 mlxlogscore=999 priorityscore=1501 suspectscore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2501170000 definitions=main-2502130148

Add support for TEMP_ALARM LITE PMIC peripherals. This subtype
utilizes a pair of registers to configure a warning interrupt
threshold temperature and an automatic hardware shutdown
threshold temperature.

Signed-off-by: David Collins <david.collins@oss.qualcomm.com>
Signed-off-by: Anjelique Melendez <anjelique.melendez@oss.qualcomm.com>
---
 drivers/thermal/qcom/qcom-spmi-temp-alarm.c | 204 +++++++++++++++++++-
 1 file changed, 203 insertions(+), 1 deletion(-)

diff --git a/drivers/thermal/qcom/qcom-spmi-temp-alarm.c b/drivers/thermal/qcom/qcom-spmi-temp-alarm.c
index a10f368f2039..081db1a85b8a 100644
--- a/drivers/thermal/qcom/qcom-spmi-temp-alarm.c
+++ b/drivers/thermal/qcom/qcom-spmi-temp-alarm.c
@@ -22,6 +22,7 @@
 #define QPNP_TM_REG_TYPE		0x04
 #define QPNP_TM_REG_SUBTYPE		0x05
 #define QPNP_TM_REG_STATUS		0x08
+#define QPNP_TM_REG_IRQ_STATUS		0x10
 #define QPNP_TM_REG_SHUTDOWN_CTRL1	0x40
 #define QPNP_TM_REG_ALARM_CTRL		0x46
 
@@ -29,14 +30,20 @@
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
 
+/* IRQ status only needed for TEMP_ALARM_LITE */
+#define IRQ_STATUS_MASK			BIT(0)
+
 #define SHUTDOWN_CTRL1_OVERRIDE_S2	BIT(6)
 #define SHUTDOWN_CTRL1_THRESHOLD_MASK	GENMASK(1, 0)
 
@@ -44,6 +51,8 @@
 
 #define ALARM_CTRL_FORCE_ENABLE		BIT(7)
 
+#define LITE_TEMP_CFG_THRESHOLD_MASK	GENMASK(3, 2)
+
 #define THRESH_COUNT			4
 #define STAGE_COUNT			3
 
@@ -88,6 +97,19 @@ static const long temp_dac_max[STAGE_COUNT] = {
 	119375, 159375, 159375
 };
 
+/*
+ * TEMP_ALARM_LITE has two stages: warning and shutdown with independently
+ * configured threshold temperatures.
+ */
+
+static const long temp_lite_warning_map[THRESH_COUNT] = {
+	115000, 125000, 135000, 145000
+};
+
+static const long temp_lite_shutdown_map[THRESH_COUNT] = {
+	135000, 145000, 160000, 175000
+};
+
 /* Temperature in Milli Celsius reported during stage 0 if no ADC is present */
 #define DEFAULT_TEMP			37000
 
@@ -197,6 +219,24 @@ static int qpnp_tm_gen2_get_temp_stage(struct qpnp_tm_chip *chip)
 	return alarm_state_map[ret];
 }
 
+/**
+ * qpnp_tm_lite_get_temp_stage() - return over-temperature stage
+ * @chip:		Pointer to the qpnp_tm chip
+ *
+ * Return: alarm interrupt state on success, or errno on failure.
+ */
+static int qpnp_tm_lite_get_temp_stage(struct qpnp_tm_chip *chip)
+{
+	u8 reg = 0;
+	int ret;
+
+	ret = qpnp_tm_read(chip, QPNP_TM_REG_IRQ_STATUS, &reg);
+	if (ret < 0)
+		return ret;
+
+	return reg & IRQ_STATUS_MASK;
+}
+
 /*
  * This function updates the internal temp value based on the
  * current thermal stage and threshold as well as the previous stage
@@ -376,6 +416,96 @@ static const struct thermal_zone_device_ops qpnp_tm_gen2_rev2_sensor_ops = {
 	.set_trip_temp = qpnp_tm_gen2_rev2_set_trip_temp,
 };
 
+static int qpnp_tm_lite_set_temp_thresh(struct qpnp_tm_chip *chip, int trip, int temp)
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
+		temp_map = temp_lite_warning_map;
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
+		temp_map = temp_lite_shutdown_map;
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
+	if (temp_cfg == chip->temp_thresh_map[trip])
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
+	chip->temp_thresh_map[trip] = temp_cfg;
+
+	return 0;
+}
+
+static int qpnp_tm_lite_set_trip_temp(struct thermal_zone_device *tz,
+				      const struct thermal_trip *trip, int temp)
+{
+	unsigned int trip_index = THERMAL_TRIP_PRIV_TO_INT(trip->priv);
+	struct qpnp_tm_chip *chip = thermal_zone_device_priv(tz);
+	int ret;
+
+	mutex_lock(&chip->lock);
+	ret = qpnp_tm_lite_set_temp_thresh(chip, trip_index, temp);
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
@@ -452,6 +582,68 @@ static int qpnp_tm_gen2_rev2_init(struct qpnp_tm_chip *chip)
 	return 0;
 }
 
+/* Configure TEMP_LITE registers based on DT thermal_zone trips */
+static int qpnp_tm_lite_configure_trip_temps_cb(struct thermal_trip *trip, void *data)
+{
+	struct qpnp_tm_chip *chip = data;
+	int ret;
+
+	trip->priv = THERMAL_INT_TO_TRIP_PRIV(chip->ntrips);
+	ret = qpnp_tm_lite_set_temp_thresh(chip, chip->ntrips, trip->temperature);
+	chip->ntrips++;
+
+	return ret;
+}
+
+static int qpnp_tm_lite_configure_trip_temps(struct qpnp_tm_chip *chip)
+{
+	int ret;
+
+	ret = thermal_zone_for_each_trip(chip->tz_dev, qpnp_tm_lite_configure_trip_temps_cb, chip);
+	if (ret < 0)
+		return ret;
+
+	/* Verify that trips are strictly increasing. */
+	if (chip->temp_thresh_map[2] <= chip->temp_thresh_map[0]) {
+		dev_err(chip->dev, "Threshold 2=%ld <= threshold 0=%ld\n",
+			chip->temp_thresh_map[2], chip->temp_thresh_map[0]);
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
+	 * Store the warning trip temp in temp_thresh_map[0] and the shutdown trip
+	 * temp in temp_thresh_map[2].  The second trip point is purely in software
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
+	chip->temp_thresh_map[0] = temp_lite_warning_map[thresh];
+
+	ret = qpnp_tm_read(chip, QPNP_TM_REG_LITE_TEMP_CFG2, &reg);
+	if (ret < 0)
+		return ret;
+
+	thresh = FIELD_GET(LITE_TEMP_CFG_THRESHOLD_MASK, reg);
+	chip->temp_thresh_map[2] = temp_lite_shutdown_map[thresh];
+
+	return 0;
+}
+
 static const struct spmi_temp_alarm_data spmi_temp_alarm_data = {
 	.ops = &qpnp_tm_sensor_ops,
 	.temp_map = &temp_map_gen1,
@@ -480,6 +672,13 @@ static const struct spmi_temp_alarm_data spmi_temp_alarm_gen2_rev2_data = {
 	.get_temp_stage = qpnp_tm_gen2_get_temp_stage,
 };
 
+static const struct spmi_temp_alarm_data spmi_temp_alarm_lite_data = {
+	.ops = &qpnp_tm_lite_sensor_ops,
+	.setup = qpnp_tm_lite_init,
+	.configure_trip_temps = qpnp_tm_lite_configure_trip_temps,
+	.get_temp_stage = qpnp_tm_lite_get_temp_stage,
+};
+
 /*
  * This function initializes the internal temp value based on only the
  * current thermal stage and threshold. Setup threshold control and
@@ -605,7 +804,8 @@ static int qpnp_tm_probe(struct platform_device *pdev)
 	}
 
 	if (type != QPNP_TM_TYPE || (subtype != QPNP_TM_SUBTYPE_GEN1
-				     && subtype != QPNP_TM_SUBTYPE_GEN2)) {
+				     && subtype != QPNP_TM_SUBTYPE_GEN2
+				     && subtype != QPNP_TM_SUBTYPE_LITE)) {
 		dev_err(&pdev->dev, "invalid type 0x%02x or subtype 0x%02x\n",
 			type, subtype);
 		return -ENODEV;
@@ -621,6 +821,8 @@ static int qpnp_tm_probe(struct platform_device *pdev)
 		chip->data = &spmi_temp_alarm_gen2_rev1_data;
 	else if (subtype == QPNP_TM_SUBTYPE_GEN2)
 		chip->data = &spmi_temp_alarm_gen2_data;
+	else if (subtype == QPNP_TM_SUBTYPE_LITE)
+		chip->data = &spmi_temp_alarm_lite_data;
 	else
 		return -ENODEV;
 
-- 
2.34.1


