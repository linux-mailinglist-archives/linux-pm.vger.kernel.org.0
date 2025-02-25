Return-Path: <linux-pm+bounces-22915-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D7632A44B43
	for <lists+linux-pm@lfdr.de>; Tue, 25 Feb 2025 20:25:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A3075189D527
	for <lists+linux-pm@lfdr.de>; Tue, 25 Feb 2025 19:25:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D9A220CCCD;
	Tue, 25 Feb 2025 19:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="U0QdUQWf"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB602204F9B
	for <linux-pm@vger.kernel.org>; Tue, 25 Feb 2025 19:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740511480; cv=none; b=UzOamoVIYN4HfdcMDgcRnOy7uKiy5//TCGsPwSGosBMBND6p7Jm2F7VUcvO6wlgUFJhrXF1uZckMCTG02ANmwAYzLTAECmIIns/hmivArGfwMtRPBAubaGGuA/wQr47dcYgrnJw85XyoupocIR5CDcpkJUsvSnTFFmj+rBHvWgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740511480; c=relaxed/simple;
	bh=CR26jXTg2/X5J+j12gYsUxJf8s0aAmGvG88dOmqgQl0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oCs43EOxCeJG+zWiS/C4+IK7zskxt7LqEDBn3176RXlK4K8eWJXLkPUoLa10M6uJasf1jNdO78dZKifP7t4HtVKAMA9ubv40z9Wda2iZfb98hu+dcYrx9aB8OYhcNI2F7QdBp7Wt3yz6xsjm6SvT1Bdiyp6jyY2xDG/+xuDKbb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=U0QdUQWf; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51PH2aZI009089
	for <linux-pm@vger.kernel.org>; Tue, 25 Feb 2025 19:24:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=vFrC2AeMOYq
	9cU1JXQAYhFEPeJ5b7DK4aDTWJYKIxLY=; b=U0QdUQWfFbsHpFN8/7ydq4xAskW
	9MVxmA3KLxyuNeab/W8Vp3AQyNwWIA7RHezhUXGH/5dWWSK/qOM0t4+hru7/iACB
	uS/o7R+dE077+T8jSRJeikGyFu80vbUHX8DeIalznoWrG0vWjcaGFF6hSjU5Dwk4
	BACIx5OseeCSfkLe/iS6mJL52uWu2ZpxIGabp4XAuhp4bNxZjBqL1+nvGULOs3v2
	L3z1z9WvqfvWcQFmlU6KDpwr6Z8cgg16nFJmJlt7HQDdOU6WdKxGsS27Ih8mZQcd
	7vNA3pt5G+t7dX3YK3TIozAC4OYsbCYn5/CtYbBquhwzxlWhVbiAOfvv0yQ==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44y6y6syq7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 25 Feb 2025 19:24:36 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-22112e86501so119626695ad.0
        for <linux-pm@vger.kernel.org>; Tue, 25 Feb 2025 11:24:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740511475; x=1741116275;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vFrC2AeMOYq9cU1JXQAYhFEPeJ5b7DK4aDTWJYKIxLY=;
        b=cQL5rKvgEADDa3MV+oA86kUTiGbOW/dLTshHrNpctj0GErChujBBtEeFucae/PZOm8
         9zdmi+Rb5vUbjFAIdpXdL7oPZgQMipmJQjji5n0pkeeZZiWOlkAvTdZjRxmtNv910Qfs
         WTup8lWwb8sJn9zC9FGCC4F/R69f6EkKbD4nUKac1z6gSKUCIxctwh1nBTQjTfo4xlhe
         iniwqpErQt2xtwZxM4Owp/J87GPxWW8LmXMUWnuzcbE1WdKD3BTWLS4RsD0BrCuVzrEC
         5xMTeA3GJU+UyPA6i6PT+Mq6118T9elwisI9RpAYUuzjkY+Zfa0Bbld8+kbbiU6dkqoq
         V2tw==
X-Forwarded-Encrypted: i=1; AJvYcCU9viVi+mVH+hvAWqwV9YiSs6reBHJ1/Tov9QQSzjaLrQ94VqtQgBJ7gE9XpD/YF+C8/ry+ljpNrg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7pAQjm7TMddncLk3rKMz8zrZtvuylS2OwEPytmtQAERxV3qj7
	zEqS2ObBKHxQzPCJkic/iJ6bEiaA0eVLV5DbklunzuftDQqgJy6QNqmx+zK/09ibrbHbxhEHsUl
	JXSQZY2I2XHNUjnTTJS69SbFjeNRvcn/7YCw86hCXln0oQjGnwZKT0TVdaQ==
X-Gm-Gg: ASbGncuNx9ja0BphXpjWNZQR0C/IVu7XiqkSwwOyfdlKKqwW2DUN4iW+9w31xXWco4Z
	/Ds/4+3r7ne/gzVypRVGqOE5AmmVIv7VMdBPdZS1aezgBVYR59La5odz9m0nT3nalHJmT/5fAFh
	lKNDaieu6fBt86Vudct6Sq+YoE2x8ZlWFcnvlWqkUH3Vfg9Vtm8dowcc5enp99dji99CoP2aFyZ
	slYJLd5U+Hco52GfCvwc4LUpExrsGyr4eKD8bfRTxOpI52uWTU+Srbo5PnKoMgG32Gl7B4FnB8U
	k1rK5ZuVV6M244oEk2HWaaSSPrI64FWyVQ+n++mdyfI+hi68SHkmhEEQpV2u/zKDozRiKJsxT3R
	2rWI=
X-Received: by 2002:a17:903:22c4:b0:215:a05d:fb05 with SMTP id d9443c01a7336-221a00156b6mr299296135ad.32.1740511475172;
        Tue, 25 Feb 2025 11:24:35 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG8iHBDY/jv0KrOzt8rpTFt9wvVgHtIsIFt2xbZ/ZpLcLWlAYAuql65fnBU01kMxzRemdjsEQ==
X-Received: by 2002:a17:903:22c4:b0:215:a05d:fb05 with SMTP id d9443c01a7336-221a00156b6mr299295765ad.32.1740511474838;
        Tue, 25 Feb 2025 11:24:34 -0800 (PST)
Received: from hu-amelende-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2230a095865sm17915365ad.145.2025.02.25.11.24.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 11:24:34 -0800 (PST)
From: Anjelique Melendez <anjelique.melendez@oss.qualcomm.com>
To: amitk@kernel.org, thara.gopinath@gmail.com, rafael@kernel.org,
        daniel.lezcano@linaro.org
Cc: rui.zhang@intel.com, lukasz.luba@arm.com, david.collins@oss.qualcomm.com,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/5] thermal: qcom-spmi-temp-alarm: Prepare to support additional Temp Alarm subtypes
Date: Tue, 25 Feb 2025 11:24:27 -0800
Message-Id: <20250225192429.2328092-4-anjelique.melendez@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250225192429.2328092-1-anjelique.melendez@oss.qualcomm.com>
References: <20250225192429.2328092-1-anjelique.melendez@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: B7DGyfMwZKDjWHAf45Up8ZcrLQq8ad4f
X-Proofpoint-GUID: B7DGyfMwZKDjWHAf45Up8ZcrLQq8ad4f
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-25_06,2025-02-25_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 spamscore=0
 malwarescore=0 phishscore=0 adultscore=0 lowpriorityscore=0
 mlxlogscore=999 impostorscore=0 priorityscore=1501 bulkscore=0 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2502250120

In preparation to support newer temp alarm subtypes, add the "ops" and
"configure_trip_temps" references to spmi_temp_alarm_data. This will
allow for each Temp Alarm subtype to define its own
thermal_zone_device_ops and properly configure thermal trip temperature.

Signed-off-by: Anjelique Melendez <anjelique.melendez@oss.qualcomm.com>
---
 drivers/thermal/qcom/qcom-spmi-temp-alarm.c | 38 ++++++++++++++-------
 1 file changed, 26 insertions(+), 12 deletions(-)

diff --git a/drivers/thermal/qcom/qcom-spmi-temp-alarm.c b/drivers/thermal/qcom/qcom-spmi-temp-alarm.c
index 64f5db214ed2..fbfe633441ba 100644
--- a/drivers/thermal/qcom/qcom-spmi-temp-alarm.c
+++ b/drivers/thermal/qcom/qcom-spmi-temp-alarm.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
  * Copyright (c) 2011-2015, 2017, 2020, The Linux Foundation. All rights reserved.
- * Copyright (c) 2024, Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) 2024-2025, Qualcomm Innovation Center, Inc. All rights reserved.
  */
 
 #include <linux/bitfield.h>
@@ -71,8 +71,10 @@ static const long temp_map_gen2_v1[THRESH_COUNT][STAGE_COUNT] = {
 struct qpnp_tm_chip;
 
 struct spmi_temp_alarm_data {
+	const struct thermal_zone_device_ops *ops;
 	const long (*temp_map)[THRESH_COUNT][STAGE_COUNT];
 	int (*get_temp_stage)(struct qpnp_tm_chip *chip);
+	int (*configure_trip_temps)(struct qpnp_tm_chip *chip);
 };
 
 struct qpnp_tm_chip {
@@ -312,18 +314,39 @@ static irqreturn_t qpnp_tm_isr(int irq, void *data)
 	return IRQ_HANDLED;
 }
 
+static int qpnp_tm_configure_trip_temp(struct qpnp_tm_chip *chip)
+{
+	int crit_temp, ret;
+
+	mutex_unlock(&chip->lock);
+
+	ret = thermal_zone_get_crit_temp(chip->tz_dev, &crit_temp);
+	if (ret)
+		crit_temp = THERMAL_TEMP_INVALID;
+
+	mutex_lock(&chip->lock);
+
+	return qpnp_tm_update_critical_trip_temp(chip, crit_temp);
+}
+
 static const struct spmi_temp_alarm_data spmi_temp_alarm_data = {
+	.ops = &qpnp_tm_sensor_ops,
 	.temp_map = &temp_map_gen1,
+	.configure_trip_temps = qpnp_tm_configure_trip_temp,
 	.get_temp_stage = qpnp_tm_get_temp_stage,
 };
 
 static const struct spmi_temp_alarm_data spmi_temp_alarm_gen2_data = {
+	.ops = &qpnp_tm_sensor_ops,
 	.temp_map = &temp_map_gen1,
+	.configure_trip_temps = qpnp_tm_configure_trip_temp,
 	.get_temp_stage = qpnp_tm_gen2_get_temp_stage,
 };
 
 static const struct spmi_temp_alarm_data spmi_temp_alarm_gen2_rev1_data = {
+	.ops = &qpnp_tm_sensor_ops,
 	.temp_map = &temp_map_gen2_v1,
+	.configure_trip_temps = qpnp_tm_configure_trip_temp,
 	.get_temp_stage = qpnp_tm_gen2_get_temp_stage,
 };
 
@@ -336,7 +359,6 @@ static int qpnp_tm_init(struct qpnp_tm_chip *chip)
 {
 	int ret;
 	u8 reg = 0;
-	int crit_temp;
 
 	mutex_lock(&chip->lock);
 
@@ -355,15 +377,7 @@ static int qpnp_tm_init(struct qpnp_tm_chip *chip)
 	if (chip->stage)
 		chip->temp = qpnp_tm_decode_temp(chip, chip->stage);
 
-	mutex_unlock(&chip->lock);
-
-	ret = thermal_zone_get_crit_temp(chip->tz_dev, &crit_temp);
-	if (ret)
-		crit_temp = THERMAL_TEMP_INVALID;
-
-	mutex_lock(&chip->lock);
-
-	ret = qpnp_tm_update_critical_trip_temp(chip, crit_temp);
+	ret = chip->data->configure_trip_temps(chip);
 	if (ret < 0)
 		goto out;
 
@@ -483,7 +497,7 @@ static int qpnp_tm_probe(struct platform_device *pdev)
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


