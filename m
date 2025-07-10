Return-Path: <linux-pm+bounces-30642-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13C5AB00EF4
	for <lists+linux-pm@lfdr.de>; Fri, 11 Jul 2025 00:46:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D1FD5C3974
	for <lists+linux-pm@lfdr.de>; Thu, 10 Jul 2025 22:46:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B726D2C3246;
	Thu, 10 Jul 2025 22:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ARYWwwME"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8C8B2C032E
	for <linux-pm@vger.kernel.org>; Thu, 10 Jul 2025 22:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752187565; cv=none; b=C91WIo9qyoMUdx5DZcwGIStHkxsya7TqdHGRkxG2iQFi4oknlUruC0qr1BNtLrSBdbVCL8uUD8THDP3fqvBOK0NHQSRtjm7XMprTWxSNddVqUSrumBDGzkQLYbxKz+xcnN1X/C+apjxzVBMSph7SmDml/YYLNuFu97MiS61r3yQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752187565; c=relaxed/simple;
	bh=lPBv04A+toV8WZOdRHfbvwf4kD8BRLqfW18tqoQF3iY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DkN/xEbOUfWfoFvvT2sSzsVzpzhs9UO6plVezueFU4XBJfZu3nysUHA72+rMLMseLbkZ7kFvfx7jEIAQvwI9q1bgK13OOjrsCVEDd6RUIkda6M4Y+BhzJutmWN16WUgn5FULtI2P/uTJHOiVtaZlsR8cbmUx34Jcm7TG3SIQG4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ARYWwwME; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56AJR0pa027433
	for <linux-pm@vger.kernel.org>; Thu, 10 Jul 2025 22:46:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=DB4i8v/AasE
	lbiDrSbyFxUSNsJIeniLxoLg5G/ldTFo=; b=ARYWwwMEGdc57S9AnI05VQtDY3m
	2jkEke/lAjRH0szbS7lZYyzskCnS8rN1zW6Pz4P/BHGwxnuS7ieUYS/n0iw4Gl08
	/T0F+hjh3OzhQTJQ+RV+CXi7/zkreIkRyE3AfKfCY8vuqeJfGhhVCRUGx7RtBaV7
	xmdc/JgKJmf1AwIYMndcJaWhHGaZL0D0uVgUSQe9he2uoCyJwm30LC+mPS2BBVsu
	BYVdYN6WG483/D4G1XpsfwZOdPbbNtGVD7hYjwTxtGNOE+65d57QB/syYeIiuVak
	LsSzWIRNLc5wv/x2Lu1r/xk0qX9cMU/KQHFjqh6tyBYznr5eUJeo+6Y54LQ==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47smap6kkk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 10 Jul 2025 22:46:02 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2365ab89b52so12403165ad.2
        for <linux-pm@vger.kernel.org>; Thu, 10 Jul 2025 15:46:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752187561; x=1752792361;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DB4i8v/AasElbiDrSbyFxUSNsJIeniLxoLg5G/ldTFo=;
        b=ak+yGwUq56WKNb6+5B92z9VGXNM/q/cH3UQpqUewxK4fHtf86YIAzU1MYWI4+8uvKn
         2wV0uh8/ZhyeDZqoAMN0d3pAGbcJTmtbOqDrKmUcQXayLyouKtaFBWMya+rIbGnIL8mO
         eL7CofZ3BJOBO06Hvnwp8qXBaTf9qVsRmul09UCAbsXrlCAleBskUn7fileGe0FgVgYo
         /0pMJepF8bEsDwbwd2VpIKdMZ2rUku7UFjQytrVjboPQMC3gSyKEl4lLXVqkHS9sYFDK
         brKmP06QKH03/sVs6J5t3Q6DU1RZ5bU0b0ebcDYdT0Mft/tCfnuM1pXVqoK52coU5DxI
         DlNQ==
X-Forwarded-Encrypted: i=1; AJvYcCWHQz+0si+Tgob/1A61az1FglC1AKz0iq2DmFCOKV87MKZ7ztA+wOEIAgBTzcK/YIeNnibm/LbJTQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwC5wsKu/EQ3KTaAHoBmZKKPf9swIV0lOCDkPzEsLb5V7PwzSim
	X3jribfwApBcJlYEgag+ZLvLZjJ3KCSta4C9qpc2bZhJqO3DaqsjJctR+7EBjMAwSoibptL8tne
	PnlPFX7dNNJModMAxmbIScSV+edeRWZc8G0VbhmD/WHHTGdla+ukWR6rn/YPE3Q==
X-Gm-Gg: ASbGncvGweZmUBB56K76igTYnntxh1kuQNf9A4fLRKksLVo/U3S5yqeRqh/mjOjzQCn
	HueRLl9we7fNYukRG7FRWiA8OPO0fW0RtMkQy4NmmjLd9QYfH8lUEJT+BfqUpXcwln6zwLG3sjW
	xSXpfdCyNoGHFqiIAn9ahFjbxLgQPEsSnjCrIs+FTXMe2FyOsY3gvaU0PPjXFBFj6ySRszeIlgu
	DOTAJiTgseME2tYgmGjbgOu+CmmL6EtGRZH4fuIwjSswyyW9oCQfXwelfR9XW8CgSILBpPD2Nvr
	KTe3ndRsJGQaS2yFronzVkNDmi2DlQiXCLD6nMbsSUucktq+TZlAnqdZOBcBNX5HFcSuOjQdq8A
	YyzT6Mqw9Bwznp1+ovxpisaAB3Ew=
X-Received: by 2002:a17:902:d586:b0:234:909b:3da9 with SMTP id d9443c01a7336-23dede860e5mr13179505ad.27.1752187561321;
        Thu, 10 Jul 2025 15:46:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFWGsHHH3QEMr3onM8+s+jPWCUGCCRaJbbIUFVY5SnFyVHssHV5KFq/OmOLdd94659u73tp7w==
X-Received: by 2002:a17:902:d586:b0:234:909b:3da9 with SMTP id d9443c01a7336-23dede860e5mr13179315ad.27.1752187560911;
        Thu, 10 Jul 2025 15:46:00 -0700 (PDT)
Received: from hu-amelende-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23de4341d51sm30479615ad.189.2025.07.10.15.45.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jul 2025 15:46:00 -0700 (PDT)
From: Anjelique Melendez <anjelique.melendez@oss.qualcomm.com>
To: amitk@kernel.org, thara.gopinath@gmail.com, rafael@kernel.org,
        daniel.lezcano@linaro.org
Cc: rui.zhang@intel.com, lukasz.luba@arm.com, david.collins@oss.qualcomm.com,
        stefan.schmidt@linaro.org, quic_tsoni@quicinc.com,
        konrad.dybcio@oss.qualcomm.com, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        dmitry.baryshkov@linaro.org, dmitry.baryshkov@oss.qualcomm.com
Subject: [PATCH v6 3/5] thermal: qcom-spmi-temp-alarm: Prepare to support additional Temp Alarm subtypes
Date: Thu, 10 Jul 2025 15:45:53 -0700
Message-Id: <20250710224555.3047790-4-anjelique.melendez@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250710224555.3047790-1-anjelique.melendez@oss.qualcomm.com>
References: <20250710224555.3047790-1-anjelique.melendez@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=Ar7u3P9P c=1 sm=1 tr=0 ts=687042aa cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=EDJ0a-WMmjN7NLPDzUkA:9
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-ORIG-GUID: QVRjjQ2NaYc4uqywUzAzfm4w5bQq7Qde
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzEwMDE5MSBTYWx0ZWRfXylZxZYFSrrpI
 fHkFqju6QsfpMUAEnszvUWYP9Z3LtwgrrN8qrf4o695dKMZwjJ0XV160iXRSsxJhDakDe+J9tIv
 xFoteE1qoFY3B5rPyZnqvLlFUCKzbVlUspGkJqoVyHoSTTZnBab+R5Q523doqvu9xqZw+SYLZXa
 Iffe/54qeR0GhXpRoUQWjVmWDSmC/YZpk9pOd4zSQXf42FmaR76zu9cvZOC/esNtOHjGoSwZ+WY
 zgI8r9X5K1fvhmPDpMG3ziUWodrU+nXrYS3XLauUwXRtpGlaQ7TtasCFBckC0sPQcnQ3R/na+Ax
 B9RnuF/vgq556MlmLHefkzqSMQvsqQ06fuGAtvwRTvLs5O4OjohXqR/05PJwj2XdoJIz9c40x+s
 pPwC0J0oynFBeSk2ZeXAVQDcG8nnDrXAW9ACORUcA5ztFNMRWrGPeasgZSpm0sj985ejU6Zk
X-Proofpoint-GUID: QVRjjQ2NaYc4uqywUzAzfm4w5bQq7Qde
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-10_05,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 malwarescore=0 bulkscore=0 lowpriorityscore=0 spamscore=0
 impostorscore=0 suspectscore=0 mlxlogscore=999 clxscore=1015 adultscore=0
 phishscore=0 priorityscore=1501 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507100191

In preparation to support newer temp alarm subtypes, add the "ops",
"sync_thresholds" and "configure_trip_temps" references to
spmi_temp_alarm_data. This will allow for each Temp Alarm subtype to define
its own thermal_zone_device_ops and properly initialize and configure
thermal trip temperature.

Signed-off-by: Anjelique Melendez <anjelique.melendez@oss.qualcomm.com>
Acked-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
---
 drivers/thermal/qcom/qcom-spmi-temp-alarm.c | 92 ++++++++++++++-------
 1 file changed, 64 insertions(+), 28 deletions(-)

diff --git a/drivers/thermal/qcom/qcom-spmi-temp-alarm.c b/drivers/thermal/qcom/qcom-spmi-temp-alarm.c
index 607838162c7d..c8e4db585d2b 100644
--- a/drivers/thermal/qcom/qcom-spmi-temp-alarm.c
+++ b/drivers/thermal/qcom/qcom-spmi-temp-alarm.c
@@ -77,8 +77,11 @@ static const long temp_map_gen2_v1[THRESH_COUNT][STAGE_COUNT] = {
 struct qpnp_tm_chip;
 
 struct spmi_temp_alarm_data {
+	const struct thermal_zone_device_ops *ops;
 	const long (*temp_map)[THRESH_COUNT][STAGE_COUNT];
+	int (*sync_thresholds)(struct qpnp_tm_chip *chip);
 	int (*get_temp_stage)(struct qpnp_tm_chip *chip);
+	int (*configure_trip_temps)(struct qpnp_tm_chip *chip);
 };
 
 struct qpnp_tm_chip {
@@ -316,64 +319,95 @@ static irqreturn_t qpnp_tm_isr(int irq, void *data)
 	return IRQ_HANDLED;
 }
 
+/* Read the hardware default stage threshold temperatures */
+static int qpnp_tm_sync_thresholds(struct qpnp_tm_chip *chip)
+{
+	u8 reg, threshold;
+	int ret;
+
+	ret = qpnp_tm_read(chip, QPNP_TM_REG_SHUTDOWN_CTRL1, &reg);
+	if (ret < 0)
+		return ret;
+
+	threshold = reg & SHUTDOWN_CTRL1_THRESHOLD_MASK;
+	memcpy(chip->temp_thresh_map, chip->data->temp_map[threshold],
+		sizeof(chip->temp_thresh_map));
+
+	return ret;
+}
+
+static int qpnp_tm_configure_trip_temp(struct qpnp_tm_chip *chip)
+{
+	int crit_temp, ret;
+
+	ret = thermal_zone_get_crit_temp(chip->tz_dev, &crit_temp);
+	if (ret)
+		crit_temp = THERMAL_TEMP_INVALID;
+
+	mutex_lock(&chip->lock);
+	ret = qpnp_tm_update_critical_trip_temp(chip, crit_temp);
+	mutex_unlock(&chip->lock);
+
+	return ret;
+}
+
 static const struct spmi_temp_alarm_data spmi_temp_alarm_data = {
+	.ops = &qpnp_tm_sensor_ops,
 	.temp_map = &temp_map_gen1,
+	.sync_thresholds = qpnp_tm_sync_thresholds,
+	.configure_trip_temps = qpnp_tm_configure_trip_temp,
 	.get_temp_stage = qpnp_tm_gen1_get_temp_stage,
 };
 
 static const struct spmi_temp_alarm_data spmi_temp_alarm_gen2_data = {
+	.ops = &qpnp_tm_sensor_ops,
 	.temp_map = &temp_map_gen1,
+	.sync_thresholds = qpnp_tm_sync_thresholds,
+	.configure_trip_temps = qpnp_tm_configure_trip_temp,
 	.get_temp_stage = qpnp_tm_gen2_get_temp_stage,
 };
 
 static const struct spmi_temp_alarm_data spmi_temp_alarm_gen2_rev1_data = {
+	.ops = &qpnp_tm_sensor_ops,
 	.temp_map = &temp_map_gen2_v1,
+	.sync_thresholds = qpnp_tm_sync_thresholds,
+	.configure_trip_temps = qpnp_tm_configure_trip_temp,
 	.get_temp_stage = qpnp_tm_gen2_get_temp_stage,
 };
 
 /*
  * This function initializes the internal temp value based on only the
- * current thermal stage and threshold. Setup threshold control and
- * disable shutdown override.
+ * current thermal stage and threshold.
  */
-static int qpnp_tm_init(struct qpnp_tm_chip *chip)
+static int qpnp_tm_threshold_init(struct qpnp_tm_chip *chip)
 {
-	int crit_temp;
-	u8 threshold;
 	int ret;
-	u8 reg;
 
-	mutex_lock(&chip->lock);
-
-	ret = qpnp_tm_read(chip, QPNP_TM_REG_SHUTDOWN_CTRL1, &reg);
+	ret = chip->data->sync_thresholds(chip);
 	if (ret < 0)
-		goto out;
-
-	threshold = reg & SHUTDOWN_CTRL1_THRESHOLD_MASK;
-	memcpy(chip->temp_thresh_map, chip->data->temp_map[threshold],
-		sizeof(chip->temp_thresh_map));
-
-	chip->temp = DEFAULT_TEMP;
+		return ret;
 
 	ret = chip->data->get_temp_stage(chip);
 	if (ret < 0)
-		goto out;
+		return ret;
 	chip->stage = ret;
+	chip->temp = DEFAULT_TEMP;
 
 	if (chip->stage)
 		chip->temp = qpnp_tm_decode_temp(chip, chip->stage);
 
-	mutex_unlock(&chip->lock);
-
-	ret = thermal_zone_get_crit_temp(chip->tz_dev, &crit_temp);
-	if (ret)
-		crit_temp = THERMAL_TEMP_INVALID;
+	return ret;
+}
 
-	mutex_lock(&chip->lock);
+/* This function initializes threshold control and disables shutdown override. */
+static int qpnp_tm_init(struct qpnp_tm_chip *chip)
+{
+	int ret;
+	u8 reg;
 
-	ret = qpnp_tm_update_critical_trip_temp(chip, crit_temp);
+	ret = chip->data->configure_trip_temps(chip);
 	if (ret < 0)
-		goto out;
+		return ret;
 
 	/* Enable the thermal alarm PMIC module in always-on mode. */
 	reg = ALARM_CTRL_FORCE_ENABLE;
@@ -381,8 +415,6 @@ static int qpnp_tm_init(struct qpnp_tm_chip *chip)
 
 	chip->initialized = true;
 
-out:
-	mutex_unlock(&chip->lock);
 	return ret;
 }
 
@@ -481,13 +513,17 @@ static int qpnp_tm_probe(struct platform_device *pdev)
 		}
 	}
 
+	ret = qpnp_tm_threshold_init(chip);
+	if (ret < 0)
+		return dev_err_probe(&pdev->dev, ret, "threshold init failed\n");
+
 	/*
 	 * Register the sensor before initializing the hardware to be able to
 	 * read the trip points. get_temp() returns the default temperature
 	 * before the hardware initialization is completed.
 	 */
 	chip->tz_dev = devm_thermal_of_zone_register(
-		&pdev->dev, 0, chip, &qpnp_tm_sensor_ops);
+		&pdev->dev, 0, chip, chip->data->ops);
 	if (IS_ERR(chip->tz_dev))
 		return dev_err_probe(&pdev->dev, PTR_ERR(chip->tz_dev),
 				     "failed to register sensor\n");
-- 
2.34.1


