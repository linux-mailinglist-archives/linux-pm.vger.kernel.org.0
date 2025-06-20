Return-Path: <linux-pm+bounces-29114-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9D5AAE104F
	for <lists+linux-pm@lfdr.de>; Fri, 20 Jun 2025 02:19:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F15D3BE817
	for <lists+linux-pm@lfdr.de>; Fri, 20 Jun 2025 00:19:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C48CEEBD;
	Fri, 20 Jun 2025 00:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="lzxIa6uw"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AF9979DA
	for <linux-pm@vger.kernel.org>; Fri, 20 Jun 2025 00:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750378766; cv=none; b=uWL7SaixZgRJCDfY7MitbLZQDwk3LOmj1A1+1pH77C8laZ7Kf5bLefbQzs/bcBZI6caQNKtNUA5mjc+/RVMynkzVe1F9lJETBrvdyoBPH4eDLKBFTdx31qRLgdfr21c0kL6X1znCyh19zEi9s4emv2u2vws1W/A+A0Z3WI4jhk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750378766; c=relaxed/simple;
	bh=YP4k9QschG0AjS2rMA7NHJ0jJlIdIYsNCh9n+pPxaKs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uRmCEpv/Oe5Yfk8TkpMFXpcTnvVs4cwt1XcSnXCFI3GaO4WiZFuJY4qvT4cYdgmtwnbSCyvhc678jqcC+q3bwTPOAdvTKbAg6TrEqfH0kXfg/Xi5LIWwsZWFcs2oBp+In71BDOkxmgqWkSPsFHOFapDtqwNvBKJ10eH7A0uGedI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=lzxIa6uw; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55JCi8B9008215
	for <linux-pm@vger.kernel.org>; Fri, 20 Jun 2025 00:19:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=2gXCAwb/YH9
	N04uJhkwajLdTXMd2G9XaQqnRPyOCURk=; b=lzxIa6uwG73N3MlZyUxdWjESkGx
	KXIscMUZKjYj3s7O7gAWEV9LFIVYjeisipIgoo+ElEaEHP17MgOMT1VFsqerugFO
	LKaMqTlCuLQHwp5RBKUtg+7/LzVCwUjB4yxyN0fWmv7qQ8EO6DXTUDo1sxDGAND+
	4xtlWWy9E+OY4/LarId4g+CV2C+Wp3/YB1OOb0y+bG76scOClvtFBaAmP0RTxoaH
	PxD6eHCGDfyy4MRGrNSANvKvQtNS7fn17WtP07ezLRJD5R/QKcbNcDx3VShRT+da
	qFN8WloZZuRRa3aLPye4b89rnb3IfAFkp+uDXWQk7rJWq6UM50ucn25Qkpg==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4792ca9nta-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 20 Jun 2025 00:19:24 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-b31bc3128fcso1709036a12.0
        for <linux-pm@vger.kernel.org>; Thu, 19 Jun 2025 17:19:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750378763; x=1750983563;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2gXCAwb/YH9N04uJhkwajLdTXMd2G9XaQqnRPyOCURk=;
        b=FA+jNdvxEjQmmbDu+cMhcokR9jfZYhD0VUwzjNBYNu+Z5ySq2Fa5UxIovAJdtKJq64
         okKDQvy2w7lIO8shDo0N3dkWuJ/g4e53pVqusH0NqnD3GWlLwbjeVuR55RmWYNZowowa
         j8RYNA/CCVG34uIcP3gay4aKkPwVzMYVo62Rz9uscPnSPG9j74RGEcGIQS8E603wXOY4
         T9OV6vVo8JXc8HHG9LU/aKUqyCCrfU86jcZG/sUk5p1i06UYUCG8457OSqDWAYHokudT
         uupLIRYvPv7koI6wpsAwL5eoTJPULHCSCXMjPOsR0aFiLpNy/+Ray72Hr4TznU0tCyZx
         kmJg==
X-Forwarded-Encrypted: i=1; AJvYcCWg+zOdfnOujOR4xMgdy5XPX4yoliraiF7NKR1Ag5w/M/D2/zPfUJ56i8J2wqLehVcjCn65+HHrDA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxC6IEVRCRl/0A2Tm42JutMtbiLBt5Dnm9Q/3O9aOS1WIWmmXZ4
	BBNJxjgAUOXLx7gJddy2t8MrEeT3fbiLMci03bF6EPUqHHn+93sbAUo3mqPeibcD97r8C38ciCe
	B8OBfqahd2qSH09QDYitth3vKGPMpc777M7pgxJ9k7+kgN2DkYUcFTg1jChd8iQ==
X-Gm-Gg: ASbGnct1xnpbXH9JuixBUTLtxXEE/lCZsAkx4zBMqL67aF7rzC0h3x3EexYF3Y6v8M4
	JBnIEsBmLgqlA9Qb4pRLvgPn+Hrp6Z6L86ojdTql+PNzrXgf/GJpmJIRaqW7qOx1qbYiCNS246E
	S0Qa038c0q1yJFQHZoQ09qqfXWMPJ3SqebAFf36wnZIwM7vtgMByl06tXGjAgwI3/tbfUAqyI2I
	LYb3m4XCSLOtPz7lXSqTwLSCvsr/SB7e4MR/wGJb6XRhBXIBeW0NlKmLImkaMG1hUz5WwOjlpiv
	lHY7nccqPeBZf+64kdwcTvq0uK34KUEh44GmFQV9c16ILysWt9viutD5hEyvELgh2CvvzqWOe+Y
	u4N1DvP7T9Q==
X-Received: by 2002:a05:6a20:6f8d:b0:21f:512c:ba2c with SMTP id adf61e73a8af0-22026f35f0dmr1174294637.34.1750378763220;
        Thu, 19 Jun 2025 17:19:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGhcMCv+o+5Af3IzwCYcGH5yNr+p4GBtvgpFrkdY1m3e6sMiRrCofUScRf5wTP2PrOb3Zjm7w==
X-Received: by 2002:a05:6a20:6f8d:b0:21f:512c:ba2c with SMTP id adf61e73a8af0-22026f35f0dmr1174252637.34.1750378762767;
        Thu, 19 Jun 2025 17:19:22 -0700 (PDT)
Received: from hu-amelende-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b31f1258932sm410011a12.64.2025.06.19.17.19.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jun 2025 17:19:22 -0700 (PDT)
From: Anjelique Melendez <anjelique.melendez@oss.qualcomm.com>
To: amitk@kernel.org, thara.gopinath@gmail.com, rafael@kernel.org,
        daniel.lezcano@linaro.org
Cc: rui.zhang@intel.com, lukasz.luba@arm.com, david.collins@oss.qualcomm.com,
        stefan.schmidt@linaro.org, quic_tsoni@quicinc.com,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, dmitry.baryshkov@linaro.org,
        dmitry.baryshkov@oss.qualcomm.com
Subject: [PATCH v5 2/5] thermal: qcom-spmi-temp-alarm: Add temp alarm data struct based on HW subtype
Date: Thu, 19 Jun 2025 17:19:15 -0700
Message-Id: <20250620001918.4090853-3-anjelique.melendez@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250620001918.4090853-1-anjelique.melendez@oss.qualcomm.com>
References: <20250620001918.4090853-1-anjelique.melendez@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: x2KazS8YVksRsbK1W4TB91MfHhy5Dile
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjIwMDAwMCBTYWx0ZWRfX01H3xr9T9hNG
 Sa0YXF4m00crD01GPsMDuwAiIqnT1K/DdTIC0fTINXZkhE3IMN7Qto66waEIHXSxUdJf4rRUeMv
 Rlkw3a4EgUOrUFPHSTnxyqNRDM+YcX7OLJee2HElPiOMoq+eO4DSGtgno4J0dMBMDpm8z49dclm
 8JzlggfZUm2hieUednm+nXp19EPwEkykb2JerJhY/WMpdoDbS/1NRxmbkoUtQRIQjO+ebMagLn6
 pJi0r2NmL0hRrjRFvaacV1Dd/FgkKADMjxxSlGkkTI1/KEm22/pMFkKM9ObwxA5IF8xUvmeZsaN
 n/QJTXt5+LHQ/JckoWAwrgY2dzc6Rfo07DXF/bpFgbhDpk1UkfWTam8dxZ3ioJsLMYfEtqh6qPI
 lO3ErQeWhPKAv8jTfh2IEk2yoWZ9D5FSWd6YuGEWH2O5X8b2tW2s+NeV5POA5IbSMQ530Cj3
X-Proofpoint-ORIG-GUID: x2KazS8YVksRsbK1W4TB91MfHhy5Dile
X-Authority-Analysis: v=2.4 cv=etffzppX c=1 sm=1 tr=0 ts=6854a90c cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=6IFa9wvqVegA:10 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=P94jSCoFVATTS2qIwVMA:9
 a=_Vgx9l1VpLgwpw_dHYaR:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-19_08,2025-06-18_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 adultscore=0 spamscore=0 malwarescore=0
 priorityscore=1501 suspectscore=0 phishscore=0 mlxlogscore=999
 lowpriorityscore=0 bulkscore=0 mlxscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2506200000

Currently multiple if/else statements are used in functions to decipher
between SPMI temp alarm Gen 1, Gen 2 and Gen 2 Rev 1 functionality. Instead
refactor the driver so that SPMI temp alarm chips will have reference to a
spmi_temp_alarm_data struct which defines data and function callbacks
based on the HW subtype.

Signed-off-by: Anjelique Melendez <anjelique.melendez@oss.qualcomm.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/thermal/qcom/qcom-spmi-temp-alarm.c | 127 +++++++++++++-------
 1 file changed, 81 insertions(+), 46 deletions(-)

diff --git a/drivers/thermal/qcom/qcom-spmi-temp-alarm.c b/drivers/thermal/qcom/qcom-spmi-temp-alarm.c
index 47248a843591..fdabde39a7e5 100644
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
 
 #define SHUTDOWN_CTRL1_OVERRIDE_S2	BIT(6)
 #define SHUTDOWN_CTRL1_THRESHOLD_MASK	GENMASK(1, 0)
@@ -68,22 +68,29 @@ static const long temp_map_gen2_v1[THRESH_COUNT][STAGE_COUNT] = {
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
 	bool				require_s2_shutdown;
+	long				temp_thresh_map[STAGE_COUNT];
 
 	struct iio_channel		*adc;
-	const long			(*temp_map)[THRESH_COUNT][STAGE_COUNT];
 };
 
 /* This array maps from GEN2 alarm state to GEN1 alarm stage */
@@ -117,20 +124,19 @@ static int qpnp_tm_write(struct qpnp_tm_chip *chip, u16 addr, u8 data)
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
 	u8 reg = 0;
@@ -139,12 +145,27 @@ static int qpnp_tm_get_temp_stage(struct qpnp_tm_chip *chip)
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
+	u8 reg = 0;
+	int ret;
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
@@ -153,23 +174,16 @@ static int qpnp_tm_get_temp_stage(struct qpnp_tm_chip *chip)
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
@@ -181,7 +195,7 @@ static int qpnp_tm_update_temp_no_adc(struct qpnp_tm_chip *chip)
 				- TEMP_STAGE_HYSTERESIS;
 	}
 
-	chip->stage = stage;
+	chip->stage = stage_new;
 
 	return 0;
 }
@@ -221,10 +235,10 @@ static int qpnp_tm_get_temp(struct thermal_zone_device *tz, int *temp)
 static int qpnp_tm_update_critical_trip_temp(struct qpnp_tm_chip *chip,
 					     int temp)
 {
-	long stage2_threshold_min = (*chip->temp_map)[THRESH_MIN][1];
-	long stage2_threshold_max = (*chip->temp_map)[THRESH_MAX][1];
+	long stage2_threshold_min = (*chip->data->temp_map)[THRESH_MIN][1];
+	long stage2_threshold_max = (*chip->data->temp_map)[THRESH_MAX][1];
 	bool disable_s2_shutdown = false;
-	u8 reg;
+	u8 reg, threshold;
 
 	WARN_ON(!mutex_is_locked(&chip->lock));
 
@@ -236,17 +250,17 @@ static int qpnp_tm_update_critical_trip_temp(struct qpnp_tm_chip *chip,
 
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
 		disable_s2_shutdown = true;
 	} else {
-		chip->thresh = THRESH_MAX;
+		threshold = THRESH_MAX;
 
 		if (chip->adc)
 			disable_s2_shutdown = true;
@@ -257,7 +271,9 @@ static int qpnp_tm_update_critical_trip_temp(struct qpnp_tm_chip *chip,
 	}
 
 skip:
-	reg |= chip->thresh;
+	memcpy(chip->temp_thresh_map, chip->data->temp_map[threshold],
+		sizeof(chip->temp_thresh_map));
+	reg |= threshold;
 	if (disable_s2_shutdown && !chip->require_s2_shutdown)
 		reg |= SHUTDOWN_CTRL1_OVERRIDE_S2;
 
@@ -294,6 +310,21 @@ static irqreturn_t qpnp_tm_isr(int irq, void *data)
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
@@ -301,10 +332,10 @@ static irqreturn_t qpnp_tm_isr(int irq, void *data)
  */
 static int qpnp_tm_init(struct qpnp_tm_chip *chip)
 {
-	unsigned int stage;
-	int ret;
-	u8 reg = 0;
 	int crit_temp;
+	u8 threshold;
+	u8 reg = 0;
+	int ret;
 
 	mutex_lock(&chip->lock);
 
@@ -312,19 +343,19 @@ static int qpnp_tm_init(struct qpnp_tm_chip *chip)
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
 
@@ -419,10 +450,14 @@ static int qpnp_tm_probe(struct platform_device *pdev)
 	}
 
 	chip->subtype = subtype;
-	if (subtype == QPNP_TM_SUBTYPE_GEN2 && dig_major >= 1)
-		chip->temp_map = &temp_map_gen2_v1;
+	if (subtype == QPNP_TM_SUBTYPE_GEN1)
+		chip->data = &spmi_temp_alarm_data;
+	else if (subtype == QPNP_TM_SUBTYPE_GEN2 && dig_major >= 1)
+		chip->data = &spmi_temp_alarm_gen2_rev1_data;
+	else if (subtype == QPNP_TM_SUBTYPE_GEN2)
+		chip->data = &spmi_temp_alarm_gen2_data;
 	else
-		chip->temp_map = &temp_map_gen1;
+		return -ENODEV;
 
 	if (chip->subtype == QPNP_TM_SUBTYPE_GEN2) {
 		dig_revision = (dig_major << 8) | dig_minor;
-- 
2.34.1


