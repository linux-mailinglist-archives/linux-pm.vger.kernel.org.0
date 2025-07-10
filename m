Return-Path: <linux-pm+bounces-30641-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11362B00EF2
	for <lists+linux-pm@lfdr.de>; Fri, 11 Jul 2025 00:46:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 52C435C3456
	for <lists+linux-pm@lfdr.de>; Thu, 10 Jul 2025 22:46:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DA5E2C08C8;
	Thu, 10 Jul 2025 22:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="dGiiBLMy"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E4932BEC31
	for <linux-pm@vger.kernel.org>; Thu, 10 Jul 2025 22:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752187564; cv=none; b=Jnqo3fTQpEUoZLfip4pKD1Pu6Fa6xOpsdE9qrFpetEUIVOPZ6reF0tlMlrt+z9WNi+8GaRILVnRbIkz3OxnBQvfqmBpaERyNjbjqesm3KNYjmn02AKEnUl52kjGP8TwWhSTXamtfay4U7SUJdZvfK3qv9C0FqK8MJDptaeL2tq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752187564; c=relaxed/simple;
	bh=+Eoq5QK+Z4TcLAmXwts6HQBk6+27HKQ9YgXVeCWlpr0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=L3rANeY3Z+oNUSFNz+bbh1+QYAfRXxFWtAIxjaiqpGzs8MRBVZyhmgMjPDADvhKm6eJ0imDfTJ0QL74YCXYo22HVbje+JCQKdvcWKpREoJsSv7h2ZyyicMUgQSSRsdqs0B0YBss0iO/gPIchXQc+qyX4eSB/NOUB0ah561ui3+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=dGiiBLMy; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56AJRml2024828
	for <linux-pm@vger.kernel.org>; Thu, 10 Jul 2025 22:46:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=ZP+qUw1MC4b
	uspzImbL7NoA9rFA4HkK9harDxg/RzyE=; b=dGiiBLMysYQEf75s1YHzUlBcoZ0
	Ahx9uSNit08dpuYoGtX2B5fTHUpH5mdGScGfIkYP9VFfzndIEWvfPofJvXDIX/3U
	2ezlkr0j+DFpIoeyhZYmmmc5ZPxpxInjq3ClEamHGIj2dcd8CscY6OXO4NVn+SAH
	KH+htdXSUQ6PEdUVm8C1tWBw8a0zRcVpUFqbC2ZYgeE4eqV0ZjipcskfDDhcZ9DZ
	vL7gxMBO004FWSai4Mr/58TXQATtWCVixI125hKaBZe+asWhswJAi2ikEz4d44g4
	5bnpen+sO93p3STozS0QRfJsddHcviCloXzNaPsRZB2TRyvH+lvJUpJab/w==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47smafpge8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 10 Jul 2025 22:46:01 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2349fe994a9so12957875ad.1
        for <linux-pm@vger.kernel.org>; Thu, 10 Jul 2025 15:46:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752187560; x=1752792360;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZP+qUw1MC4buspzImbL7NoA9rFA4HkK9harDxg/RzyE=;
        b=s7LGa6kpMgIqJiK+CCt+mEypoNKZ7C1iMscZPmaQRfcJB6OI+BY7Tja4S7It5zlwsU
         JchqXa4G9XdVVwKTiFCP0r11zFoGDR7alhDKKuxSqle6u19cNaQyskXVswvBGyBGFkvg
         WfFbGHBsRN6MYAb8kPYVOjyjkhuGbhRC0UARVuCiUIBZf3CcSUY2nxzh/VsenddiPJC4
         I2lE5REzvXnYpNkum1DbeqB0tuFauvHKadBP0429nG3t2SqR6GohIb+5Nqp+WkY+JOH3
         ACdfjHVgkYO67z3cgABgfKemcI5MYNNLUVDzylXiI3np4DwMxZ6ys4VQlI28Nes+zTh3
         OsIg==
X-Forwarded-Encrypted: i=1; AJvYcCX2VfNVK0bP8C2psw2AhirhXOs3DQ7Qu7P0vxqbx3qhfchoC/ogDWgUvfia/5po1gWY8wpoKasxtw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzpWsiDYMysYSf0PXhVyeE8Nq+i0N/RkJ6rBHgU0zhLlXq0CfYi
	mo2YXu71t/m47aOQAqWeIaVBeYmwnn7/rYS1PGRLZDaWUPYf9os188u6yW+AfrTTnygLZ16OHq4
	Pn6xKznSslyAv6ASvAefa/934NQD+ePFyt88P5JJbn8B/nfaIcGV8qCaojbCmjA==
X-Gm-Gg: ASbGncsHkKvuc2VGynQiTn9a8fkFHBzCnHRn5+gWGko9YMhG8588DgDMZmRnxxjSVl7
	RCqEaWvZBNVpGwzR3H5uwoQw94JtJsiLl020ibOp+iw+S+/z21ohpquXP+xNmjVchO8Mcs2a1ic
	8rXAaD0lUMl0WHQLXuPPUrXk/XThkn9+EGz3PFkk0ic53SCTvRKLfzkAb2HpRJr7wXxTIRD3fyZ
	6MftKDFYNKUE6SnB+rPCtVgZtC782+NrSzOSkEbciIWN7qlo87RXmTMIcGNgCAkus+W3ET+efLs
	LPkA6uiGR7h1Vlng4+87CYTMIWnx8aHR4XJW0c5vPFK/iEj+a9hxmXuQWIipNGw5he49S6EJ2mH
	OxaXzdCRwNwKeKi1BYrbVY+ICF2w=
X-Received: by 2002:a17:903:1a0b:b0:23d:ed96:e2b6 with SMTP id d9443c01a7336-23dee2a09c6mr11931765ad.44.1752187559960;
        Thu, 10 Jul 2025 15:45:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHkENv3EZgXL2V0Tg8YXKutWmikxrgBnK5ws65xd+qPdGWLFXphAye7Sp98D4bIpTFjAkWfGg==
X-Received: by 2002:a17:903:1a0b:b0:23d:ed96:e2b6 with SMTP id d9443c01a7336-23dee2a09c6mr11931395ad.44.1752187559492;
        Thu, 10 Jul 2025 15:45:59 -0700 (PDT)
Received: from hu-amelende-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23de4341d51sm30479615ad.189.2025.07.10.15.45.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jul 2025 15:45:58 -0700 (PDT)
From: Anjelique Melendez <anjelique.melendez@oss.qualcomm.com>
To: amitk@kernel.org, thara.gopinath@gmail.com, rafael@kernel.org,
        daniel.lezcano@linaro.org
Cc: rui.zhang@intel.com, lukasz.luba@arm.com, david.collins@oss.qualcomm.com,
        stefan.schmidt@linaro.org, quic_tsoni@quicinc.com,
        konrad.dybcio@oss.qualcomm.com, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        dmitry.baryshkov@linaro.org, dmitry.baryshkov@oss.qualcomm.com
Subject: [PATCH v6 2/5] thermal: qcom-spmi-temp-alarm: Add temp alarm data struct based on HW subtype
Date: Thu, 10 Jul 2025 15:45:52 -0700
Message-Id: <20250710224555.3047790-3-anjelique.melendez@oss.qualcomm.com>
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
X-Authority-Analysis: v=2.4 cv=ZJ/XmW7b c=1 sm=1 tr=0 ts=687042a9 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=3gcoFgraK96GEOzUlygA:9
 a=GvdueXVYPmCkWapjIL-Q:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: FcSoyggZeryyyeGAzevj_QWEFnqupBn-
X-Proofpoint-GUID: FcSoyggZeryyyeGAzevj_QWEFnqupBn-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzEwMDE5MSBTYWx0ZWRfXwYTLq602JPa8
 keCrC30QnXXT/CYbcOoyfufMFjYFaTqzyfPg68z2EDDslibT8SAHSoKw7iNR8gTIMOe2WeVMxSG
 wjGA++7iuxC1afgWhEDXXrnjUOGFYkrxLSPDfkp2akiIj3+CFVRlDtZDN3EmC/FxV3ibHls0hQx
 9iXOb8ucxgENMcSs3l+TforKyswHEIMGvVDCn5qa1r8XbXI+yR/pQofckYepAQ6PuGozNBeB48P
 x19nuSP0YNPlaD9gSVh+0rG91oD5SiKbNW97NwBOrXg8wjOoKx9JwpVXFgjVEHMB1Kig/cVaQ13
 aVMb9+u4kvriROrdqcZ1IRK1kX3Vj0j47LLLonFEQyQUqTn3t1w8uJF4T6hnX7QEX7VATvEOF89
 l5JUAmcS1qGeEHuruiuL5uOLZNtT7FjmH8qeUDonlz/ttnY/pJfgABvnWyJ9Q0yKRa6M2I4f
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-10_05,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=999 impostorscore=0 spamscore=0 adultscore=0 clxscore=1015
 bulkscore=0 phishscore=0 priorityscore=1501 mlxscore=0 lowpriorityscore=0
 suspectscore=0 malwarescore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507100191

Currently multiple if/else statements are used in functions to decipher
between SPMI temp alarm Gen 1, Gen 2 and Gen 2 Rev 1 functionality. Instead
refactor the driver so that SPMI temp alarm chips will have reference to a
spmi_temp_alarm_data struct which defines data and function callbacks
based on the HW subtype.

Signed-off-by: Anjelique Melendez <anjelique.melendez@oss.qualcomm.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/thermal/qcom/qcom-spmi-temp-alarm.c | 135 +++++++++++++-------
 1 file changed, 88 insertions(+), 47 deletions(-)

diff --git a/drivers/thermal/qcom/qcom-spmi-temp-alarm.c b/drivers/thermal/qcom/qcom-spmi-temp-alarm.c
index 4b91cc13ce34..607838162c7d 100644
--- a/drivers/thermal/qcom/qcom-spmi-temp-alarm.c
+++ b/drivers/thermal/qcom/qcom-spmi-temp-alarm.c
@@ -4,6 +4,7 @@
  * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
  */
 
+#include <linux/bitfield.h>
 #include <linux/bitops.h>
 #include <linux/delay.h>
 #include <linux/err.h>
@@ -31,7 +32,6 @@
 
 #define STATUS_GEN1_STAGE_MASK		GENMASK(1, 0)
 #define STATUS_GEN2_STATE_MASK		GENMASK(6, 4)
-#define STATUS_GEN2_STATE_SHIFT		4
 
 #define SHUTDOWN_CTRL1_OVERRIDE_STAGE2	BIT(6)
 #define SHUTDOWN_CTRL1_THRESHOLD_MASK	GENMASK(1, 0)
@@ -43,6 +43,12 @@
 #define THRESH_COUNT			4
 #define STAGE_COUNT			3
 
+enum overtemp_stage {
+	STAGE1 = 0,
+	STAGE2,
+	STAGE3,
+};
+
 /* Over-temperature trip point values in mC */
 static const long temp_map_gen1[THRESH_COUNT][STAGE_COUNT] = {
 	{ 105000, 125000, 145000 },
@@ -68,22 +74,29 @@ static const long temp_map_gen2_v1[THRESH_COUNT][STAGE_COUNT] = {
 /* Temperature in Milli Celsius reported during stage 0 if no ADC is present */
 #define DEFAULT_TEMP			37000
 
+struct qpnp_tm_chip;
+
+struct spmi_temp_alarm_data {
+	const long (*temp_map)[THRESH_COUNT][STAGE_COUNT];
+	int (*get_temp_stage)(struct qpnp_tm_chip *chip);
+};
+
 struct qpnp_tm_chip {
 	struct regmap			*map;
 	struct device			*dev;
 	struct thermal_zone_device	*tz_dev;
+	const struct spmi_temp_alarm_data *data;
 	unsigned int			subtype;
 	long				temp;
-	unsigned int			thresh;
 	unsigned int			stage;
 	unsigned int			base;
 	/* protects .thresh, .stage and chip registers */
 	struct mutex			lock;
 	bool				initialized;
 	bool				require_stage2_shutdown;
+	long				temp_thresh_map[STAGE_COUNT];
 
 	struct iio_channel		*adc;
-	const long			(*temp_map)[THRESH_COUNT][STAGE_COUNT];
 };
 
 /* This array maps from GEN2 alarm state to GEN1 alarm stage */
@@ -117,34 +130,48 @@ static int qpnp_tm_write(struct qpnp_tm_chip *chip, u16 addr, u8 data)
  */
 static long qpnp_tm_decode_temp(struct qpnp_tm_chip *chip, unsigned int stage)
 {
-	if (!chip->temp_map || chip->thresh >= THRESH_COUNT || stage == 0 ||
-	    stage > STAGE_COUNT)
+	if (stage == 0 || stage > STAGE_COUNT)
 		return 0;
 
-	return (*chip->temp_map)[chip->thresh][stage - 1];
+	return chip->temp_thresh_map[stage - 1];
 }
 
 /**
- * qpnp_tm_get_temp_stage() - return over-temperature stage
+ * qpnp_tm_gen1_get_temp_stage() - return over-temperature stage
  * @chip:		Pointer to the qpnp_tm chip
  *
- * Return: stage (GEN1) or state (GEN2) on success, or errno on failure.
+ * Return: stage on success, or errno on failure.
  */
-static int qpnp_tm_get_temp_stage(struct qpnp_tm_chip *chip)
+static int qpnp_tm_gen1_get_temp_stage(struct qpnp_tm_chip *chip)
 {
 	int ret;
-	u8 reg = 0;
+	u8 reg;
 
 	ret = qpnp_tm_read(chip, QPNP_TM_REG_STATUS, &reg);
 	if (ret < 0)
 		return ret;
 
-	if (chip->subtype == QPNP_TM_SUBTYPE_GEN1)
-		ret = reg & STATUS_GEN1_STAGE_MASK;
-	else
-		ret = (reg & STATUS_GEN2_STATE_MASK) >> STATUS_GEN2_STATE_SHIFT;
+	return FIELD_GET(STATUS_GEN1_STAGE_MASK, reg);
+}
 
-	return ret;
+/**
+ * qpnp_tm_gen2_get_temp_stage() - return over-temperature stage
+ * @chip:		Pointer to the qpnp_tm chip
+ *
+ * Return: stage on success, or errno on failure.
+ */
+static int qpnp_tm_gen2_get_temp_stage(struct qpnp_tm_chip *chip)
+{
+	int ret;
+	u8 reg;
+
+	ret = qpnp_tm_read(chip, QPNP_TM_REG_STATUS, &reg);
+	if (ret < 0)
+		return ret;
+
+	ret = FIELD_GET(STATUS_GEN2_STATE_MASK, reg);
+
+	return alarm_state_map[ret];
 }
 
 /*
@@ -153,23 +180,16 @@ static int qpnp_tm_get_temp_stage(struct qpnp_tm_chip *chip)
  */
 static int qpnp_tm_update_temp_no_adc(struct qpnp_tm_chip *chip)
 {
-	unsigned int stage, stage_new, stage_old;
+	unsigned int stage_new, stage_old;
 	int ret;
 
 	WARN_ON(!mutex_is_locked(&chip->lock));
 
-	ret = qpnp_tm_get_temp_stage(chip);
+	ret = chip->data->get_temp_stage(chip);
 	if (ret < 0)
 		return ret;
-	stage = ret;
-
-	if (chip->subtype == QPNP_TM_SUBTYPE_GEN1) {
-		stage_new = stage;
-		stage_old = chip->stage;
-	} else {
-		stage_new = alarm_state_map[stage];
-		stage_old = alarm_state_map[chip->stage];
-	}
+	stage_new = ret;
+	stage_old = chip->stage;
 
 	if (stage_new > stage_old) {
 		/* increasing stage, use lower bound */
@@ -181,7 +201,7 @@ static int qpnp_tm_update_temp_no_adc(struct qpnp_tm_chip *chip)
 				- TEMP_STAGE_HYSTERESIS;
 	}
 
-	chip->stage = stage;
+	chip->stage = stage_new;
 
 	return 0;
 }
@@ -221,10 +241,10 @@ static int qpnp_tm_get_temp(struct thermal_zone_device *tz, int *temp)
 static int qpnp_tm_update_critical_trip_temp(struct qpnp_tm_chip *chip,
 					     int temp)
 {
-	long stage2_threshold_min = (*chip->temp_map)[THRESH_MIN][1];
-	long stage2_threshold_max = (*chip->temp_map)[THRESH_MAX][1];
+	long stage2_threshold_min = (*chip->data->temp_map)[THRESH_MIN][STAGE2];
+	long stage2_threshold_max = (*chip->data->temp_map)[THRESH_MAX][STAGE2];
 	bool disable_stage2_shutdown = false;
-	u8 reg;
+	u8 reg, threshold;
 
 	WARN_ON(!mutex_is_locked(&chip->lock));
 
@@ -236,17 +256,17 @@ static int qpnp_tm_update_critical_trip_temp(struct qpnp_tm_chip *chip,
 
 	if (temp == THERMAL_TEMP_INVALID ||
 	    temp < stage2_threshold_min) {
-		chip->thresh = THRESH_MIN;
+		threshold = THRESH_MIN;
 		goto skip;
 	}
 
 	if (temp <= stage2_threshold_max) {
-		chip->thresh = THRESH_MAX -
+		threshold = THRESH_MAX -
 			((stage2_threshold_max - temp) /
 			 TEMP_THRESH_STEP);
 		disable_stage2_shutdown = true;
 	} else {
-		chip->thresh = THRESH_MAX;
+		threshold = THRESH_MAX;
 
 		if (chip->adc)
 			disable_stage2_shutdown = true;
@@ -257,7 +277,9 @@ static int qpnp_tm_update_critical_trip_temp(struct qpnp_tm_chip *chip,
 	}
 
 skip:
-	reg |= chip->thresh;
+	memcpy(chip->temp_thresh_map, chip->data->temp_map[threshold],
+		sizeof(chip->temp_thresh_map));
+	reg |= threshold;
 	if (disable_stage2_shutdown && !chip->require_stage2_shutdown)
 		reg |= SHUTDOWN_CTRL1_OVERRIDE_STAGE2;
 
@@ -294,6 +316,21 @@ static irqreturn_t qpnp_tm_isr(int irq, void *data)
 	return IRQ_HANDLED;
 }
 
+static const struct spmi_temp_alarm_data spmi_temp_alarm_data = {
+	.temp_map = &temp_map_gen1,
+	.get_temp_stage = qpnp_tm_gen1_get_temp_stage,
+};
+
+static const struct spmi_temp_alarm_data spmi_temp_alarm_gen2_data = {
+	.temp_map = &temp_map_gen1,
+	.get_temp_stage = qpnp_tm_gen2_get_temp_stage,
+};
+
+static const struct spmi_temp_alarm_data spmi_temp_alarm_gen2_rev1_data = {
+	.temp_map = &temp_map_gen2_v1,
+	.get_temp_stage = qpnp_tm_gen2_get_temp_stage,
+};
+
 /*
  * This function initializes the internal temp value based on only the
  * current thermal stage and threshold. Setup threshold control and
@@ -301,10 +338,10 @@ static irqreturn_t qpnp_tm_isr(int irq, void *data)
  */
 static int qpnp_tm_init(struct qpnp_tm_chip *chip)
 {
-	unsigned int stage;
-	int ret;
-	u8 reg = 0;
 	int crit_temp;
+	u8 threshold;
+	int ret;
+	u8 reg;
 
 	mutex_lock(&chip->lock);
 
@@ -312,19 +349,19 @@ static int qpnp_tm_init(struct qpnp_tm_chip *chip)
 	if (ret < 0)
 		goto out;
 
-	chip->thresh = reg & SHUTDOWN_CTRL1_THRESHOLD_MASK;
+	threshold = reg & SHUTDOWN_CTRL1_THRESHOLD_MASK;
+	memcpy(chip->temp_thresh_map, chip->data->temp_map[threshold],
+		sizeof(chip->temp_thresh_map));
+
 	chip->temp = DEFAULT_TEMP;
 
-	ret = qpnp_tm_get_temp_stage(chip);
+	ret = chip->data->get_temp_stage(chip);
 	if (ret < 0)
 		goto out;
 	chip->stage = ret;
 
-	stage = chip->subtype == QPNP_TM_SUBTYPE_GEN1
-		? chip->stage : alarm_state_map[chip->stage];
-
-	if (stage)
-		chip->temp = qpnp_tm_decode_temp(chip, stage);
+	if (chip->stage)
+		chip->temp = qpnp_tm_decode_temp(chip, chip->stage);
 
 	mutex_unlock(&chip->lock);
 
@@ -418,10 +455,14 @@ static int qpnp_tm_probe(struct platform_device *pdev)
 	}
 
 	chip->subtype = subtype;
-	if (subtype == QPNP_TM_SUBTYPE_GEN2 && dig_major >= 1)
-		chip->temp_map = &temp_map_gen2_v1;
+	if (subtype == QPNP_TM_SUBTYPE_GEN1)
+		chip->data = &spmi_temp_alarm_data;
+	else if (subtype == QPNP_TM_SUBTYPE_GEN2 && dig_major == 0)
+		chip->data = &spmi_temp_alarm_gen2_data;
+	else if (subtype == QPNP_TM_SUBTYPE_GEN2 && dig_major >= 1)
+		chip->data = &spmi_temp_alarm_gen2_rev1_data;
 	else
-		chip->temp_map = &temp_map_gen1;
+		return -ENODEV;
 
 	if (chip->subtype == QPNP_TM_SUBTYPE_GEN2) {
 		dig_revision = (dig_major << 8) | dig_minor;
-- 
2.34.1


