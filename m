Return-Path: <linux-pm+bounces-23454-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AD063A4F12D
	for <lists+linux-pm@lfdr.de>; Wed,  5 Mar 2025 00:06:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CBCAA172E4D
	for <lists+linux-pm@lfdr.de>; Tue,  4 Mar 2025 23:06:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E608C27CB0A;
	Tue,  4 Mar 2025 23:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="UqWqfCRa"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AA6B27C84F
	for <linux-pm@vger.kernel.org>; Tue,  4 Mar 2025 23:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741129517; cv=none; b=dI4bR8Rr5qc7SG88eT3VQVs3ATC5njhD4/vY1zAUN4uy+lbbjyFN/jSFfbMlZubQcuRlE4A0rMHJgfys0eiXXOlU8d8en/XaBzUABe/yA9nvTw4lZIklr0ewqESTk/hoCpC3aPoqnh9IXqZejBn93uF0pYsUTIN6AXhFGhf3GLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741129517; c=relaxed/simple;
	bh=H7KSE1RYrshvUFGJnP3ejIrBqUM1jbXJhYU6mYIyRu8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dJx2UaEX0FMpBu+YlHEIBkpDczOykMptY6N8m3IDpPNhwyVjlq8B7K1HzMzQmzdVv3Gk78d5axT98H2Ndxiv1U6d9Llm8BROedJrtBNIB+irkGAiEwrZJr3uKmYQrceHqtP7RSGVWQSAeho69dsSzBOrBmdBoomfXRn0HDllCBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=UqWqfCRa; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 524Bk9wl013632
	for <linux-pm@vger.kernel.org>; Tue, 4 Mar 2025 23:05:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=uSqnCviNEbU
	NoXfwtDyicmV9Arq/nNUqt1uGmYnbL+A=; b=UqWqfCRalyxPB1/8oAWBfWMVH/e
	sFISc56goDzhVGb1OcoXOzPEh55JqyvcDaGUprW4ASumxmvo2G71Ut/JvdIDb7vj
	7RFKTCHGLa8aaHNrFdGyfnuSWQNYS0Yra3dpsbsnbayKMkWoWdNEWRd6AWhZwtzy
	G9csNuqwpedMKY00Y5ghB7FAl17Eho1f7FWNRI7e8B7oOdsTIgfsI4G1XoL628wT
	Xm1yZiIYP0e4N0RdlZ+J5yOaBrNnwVN6vRLrm5z2x8nKwY0/2ELTbfGIGJ71la4Q
	vCW60tdl+xw4eU5RXE8pRAFAeVfjl89Udes0+/Yosvq6K64+A/dbE9MAb7g==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 455p6vbcxt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 04 Mar 2025 23:05:13 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-2ff4b130bb2so152186a91.0
        for <linux-pm@vger.kernel.org>; Tue, 04 Mar 2025 15:05:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741129512; x=1741734312;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uSqnCviNEbUNoXfwtDyicmV9Arq/nNUqt1uGmYnbL+A=;
        b=xOHg9BXbzVkhmUJ+hSPS9rLVKbSuji9U0iHuE7Ct9CmPCqpqkAKgIlGms/LRa4J1r1
         frOPnHxNFrvcwdW+JGHb43Szhxis26vRt3uiFHb9hHDh0QvuDFytn4J/aaJsph3UrE+U
         81a2NIjNJSbqoFkBezk0VlSY8FfEQkKniE/aJM7h5ZEFI2TSZAdQyH+EDIX+GUzb6CCB
         DFEzhPu7EWHg8zMkEgfwYHXQlivtPgk1+/G7d9Ornp8vYwXNaG6onj6bcRBUGDwengp7
         iKeObcxBobHcXpvS/6MUWNKScEFLpoooxMl7uPZBzIxVLM2bozuGrpBFwidRyBZtETtR
         BE0g==
X-Forwarded-Encrypted: i=1; AJvYcCVl/Kq0Z0kgdKm8AY6gKO+pQcV4j1n9uyhG4lvRdWbbYldRZi6UiYkDCwU5qB9afr22lAkxLXY4GA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2wWDUAqbaT8zFo25cXzU1paoFKqK73YVLZa0xvIIpqwoOYAXf
	Y17XsvO1OwNFDdQNRdiGTF4z7sazH+gUIp0NCGqkihiHzlHX5lYLHMH0SsU7SKQqGueVbjhP7+s
	t+PyCvZm+484kh/vmbkixt7Uda+nU4cuSRTcafyfwN8e+LnamFVASif+AuQ==
X-Gm-Gg: ASbGncukLApanQnIWaQE9C1d3CV+z36vlpvcBUQhGVBd1KMcJOtyTjUxJfiuB5dFI9b
	tqOOn8+NaaMuKmfVl1uftkV44UZ0/BWc7Sbo6bey6/gTFdnOmqFb7EEUtRmxJ2Lqf87aWA2Erwk
	iN5eOOjHc5uZIvL6jfGCMexFs3dmwUWLdaNlBQL0at3dl8R7ho0s4g2gXFCWsKxQ6/rcZXIPQ+9
	fuD+7LxTOUHZsgc8/cbd+hpjT0mwG10EuxvCd7cZdR5Hx7lW2AEhv7IBgM5VZSz8tJ39gwAuKHR
	A/5dvjxsVZnuBGzExJpyjEKWFgVQap0OtuweolXr9rt33f9MkIsgMoe+rMsKczo378SvvH/uX57
	5me4=
X-Received: by 2002:a05:6a20:1582:b0:1f3:1d13:969f with SMTP id adf61e73a8af0-1f3494632fcmr1698643637.9.1741129512186;
        Tue, 04 Mar 2025 15:05:12 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE29dGVni57iqiYJXK50rIEzOLiq1im/AohVYkzzeKXwALS2G3RbdVYMf54EhRPh3LwABQATQ==
X-Received: by 2002:a05:6a20:1582:b0:1f3:1d13:969f with SMTP id adf61e73a8af0-1f3494632fcmr1698579637.9.1741129511702;
        Tue, 04 Mar 2025 15:05:11 -0800 (PST)
Received: from hu-amelende-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7349fe6cfd9sm11492793b3a.76.2025.03.04.15.05.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 15:05:10 -0800 (PST)
From: Anjelique Melendez <anjelique.melendez@oss.qualcomm.com>
To: amitk@kernel.org, thara.gopinath@gmail.com, rafael@kernel.org,
        daniel.lezcano@linaro.org
Cc: rui.zhang@intel.com, lukasz.luba@arm.com, david.collins@oss.qualcomm.com,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, dmitry.baryshkov@linaro.org
Subject: [PATCH v3 5/5] thermal: qcom-spmi-temp-alarm: add support for LITE PMIC peripherals
Date: Tue,  4 Mar 2025 15:05:02 -0800
Message-Id: <20250304230502.1470523-6-anjelique.melendez@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250304230502.1470523-1-anjelique.melendez@oss.qualcomm.com>
References: <20250304230502.1470523-1-anjelique.melendez@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: WDvcd3wtHlho8p_yobwactSYdkzujtsD
X-Authority-Analysis: v=2.4 cv=bPnsIO+Z c=1 sm=1 tr=0 ts=67c78729 cx=c_pps a=RP+M6JBNLl+fLTcSJhASfg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17 a=Vs1iUdzkB0EA:10 a=EUspDBNiAAAA:8 a=47G9NL9pyX4x7Wg37RYA:9 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-GUID: WDvcd3wtHlho8p_yobwactSYdkzujtsD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-04_09,2025-03-04_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 suspectscore=0
 impostorscore=0 lowpriorityscore=0 priorityscore=1501 adultscore=0
 spamscore=0 mlxscore=0 clxscore=1015 bulkscore=0 mlxlogscore=999
 phishscore=0 classifier=spam authscore=0 adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2503040184

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
index efd2b6534127..2547a69dbd07 100644
--- a/drivers/thermal/qcom/qcom-spmi-temp-alarm.c
+++ b/drivers/thermal/qcom/qcom-spmi-temp-alarm.c
@@ -23,6 +23,7 @@
 #define QPNP_TM_REG_TYPE		0x04
 #define QPNP_TM_REG_SUBTYPE		0x05
 #define QPNP_TM_REG_STATUS		0x08
+#define QPNP_TM_REG_IRQ_STATUS		0x10
 #define QPNP_TM_REG_SHUTDOWN_CTRL1	0x40
 #define QPNP_TM_REG_ALARM_CTRL		0x46
 
@@ -30,14 +31,20 @@
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
 
@@ -45,6 +52,8 @@
 
 #define ALARM_CTRL_FORCE_ENABLE		BIT(7)
 
+#define LITE_TEMP_CFG_THRESHOLD_MASK	GENMASK(3, 2)
+
 #define THRESH_COUNT			4
 #define STAGE_COUNT			3
 
@@ -89,6 +98,19 @@ static const long temp_dac_max[STAGE_COUNT] = {
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
 
@@ -198,6 +220,24 @@ static int qpnp_tm_gen2_get_temp_stage(struct qpnp_tm_chip *chip)
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
@@ -377,6 +417,96 @@ static const struct thermal_zone_device_ops qpnp_tm_gen2_rev2_sensor_ops = {
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
@@ -453,6 +583,68 @@ static int qpnp_tm_gen2_rev2_setup(struct qpnp_tm_chip *chip)
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
+static int qpnp_tm_lite_setup(struct qpnp_tm_chip *chip)
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
@@ -481,6 +673,13 @@ static const struct spmi_temp_alarm_data spmi_temp_alarm_gen2_rev2_data = {
 	.get_temp_stage = qpnp_tm_gen2_get_temp_stage,
 };
 
+static const struct spmi_temp_alarm_data spmi_temp_alarm_lite_data = {
+	.ops = &qpnp_tm_lite_sensor_ops,
+	.setup = qpnp_tm_lite_setup,
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


