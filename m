Return-Path: <linux-pm+bounces-30643-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 660A7B00EF7
	for <lists+linux-pm@lfdr.de>; Fri, 11 Jul 2025 00:46:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF9FC17C4CC
	for <lists+linux-pm@lfdr.de>; Thu, 10 Jul 2025 22:46:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75E3B2D0283;
	Thu, 10 Jul 2025 22:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="YrAC/bR3"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80E072C1583
	for <linux-pm@vger.kernel.org>; Thu, 10 Jul 2025 22:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752187566; cv=none; b=dA0J+Oq7j77qK4YAs1CC2vHubqLYJi/U40vJ1/t8MiK+NJWGfyWvK6+xhALpv9AmqfHYAJUEHGeVbyMHYJ2CcIjM/YkKSKLoG85K3Cghl5VFoAQXOS6GqmN2XZadKcpC4MpcC3Q2Ey+kHuvKAeMGSqbZlCAOaFqgAn0Nno8cHEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752187566; c=relaxed/simple;
	bh=LTrWIBmHuSPigCg/BnSdxHQ/CMxK6ECk7MJSl7YiYcQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QNf6f0sGax3cg4mDomNHvjbQScFOD4DGmstu6bF09NFVgndRWnf8jVqtgafKjkvSVZymavWu62m/yhh4B9hZNJF3JJQB7n5UZImOqbw/m4ZYewoub+A2GtwirN/xKUEmtMznW0n8ufGW7GhFE2m/xraURKZ/FQq8heO/Sxt1OYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=YrAC/bR3; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56AJQrgM032472
	for <linux-pm@vger.kernel.org>; Thu, 10 Jul 2025 22:46:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=4BowjyUNDu5
	UOuLJtzw9IisX6hUip4xF24PhAzp2Jeg=; b=YrAC/bR3AveJv27MHtzyVWE+WpP
	g22Isi6oVltMh1S6Nb45dFol8LjGva7pVlSHKRuOug5hXPPOwT091/SANgI+54R+
	htIyLb8RAph+r1PInMHaXA7F5rB1w6D1AfBGWWrZ8FLLYh6Cn8KnC7QO7JHe8NoL
	e5StvCziDdv5ZfgtWvulISik3wHT0EBAQe5ie2JCB19uQkS9jhG75triXg7AhWLG
	SddPO7Od7dPpqvNHRijdGadX6IKWLUS2aMSgIiTNcetow3Rviqae1Vvb00oSlYMl
	UAoV1SPTxS4c0UByt82ciCmLqjfY+NxoyNj6dAk2HpHtoZSi+lO872p8UDw==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47r9b17hvt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 10 Jul 2025 22:46:03 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-b2c36d3f884so1153094a12.2
        for <linux-pm@vger.kernel.org>; Thu, 10 Jul 2025 15:46:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752187563; x=1752792363;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4BowjyUNDu5UOuLJtzw9IisX6hUip4xF24PhAzp2Jeg=;
        b=Fi1U0SXwmxXrTrVGK2by23p4aPwPuYOAOxf3VnzDYw5RYmiKqBSn5OFWFl72UCJ/5l
         V85S9SBnUhNb3uo2hWDYjRLtpeKOeAGGtfJvhNY6krPccuNx3OCC4S8syHiIcwN24sap
         YPBat6ZKrGyrfe9WIIaBe/jfGqgOaUEhoiqLdKnS/JHGkd7THXAHY3OJegBX8e2YoZpw
         ayVhZTdOIBRcLEVI3sHUHUIKs2NJRk2t3XZ72Hzgk6VyqXL5gZZSk7C1u3MdC9is7PbY
         H83hckGYSYgUOqkYzRG7e7DIc6hLuZJBMlWuQqhki2Po5+BrfFvyg4JJprgECN8dd5sK
         U1sQ==
X-Forwarded-Encrypted: i=1; AJvYcCXaFWYdrz+c6x9T6uFzJ0zlH53d9Kl5xHf5s7rjg5dgxcN3KydVKU0rPqo3Z7ggyiDgiQ2NVJBcIA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyVvKYdd2eR6qyf1trqOCFAVqTj3BAr7RjT5zPf9hbBYD2ERnj8
	nlsja30MDqh9aLsysEzemI6aTkvKwNRU7suLuEGyVHIei7Mmp0fsqlRK4WUIjY9jSZNa97K88rR
	MXvRSrmzrv8vm9C3Tx8bV9B2uIb9Z8Uh8Fi1PQ7XgzhdEjgKQ4ONF7ON91Caq/Q==
X-Gm-Gg: ASbGnctUbMN3P7qhR7c9wnEU/Xthcmvgn/65lqBPwDOM2Uhh3+Y2VU9ztVM3QRFE7nj
	+3lnld38aLFv8IEBAptAqOt71HjDkoUpJ41HO+m0E/tzsO1dEzT2CA5PuMxM5T7K0/g6BQmGiTk
	ufp1JanJyAbnb8YcOX2Ls0TvK29PtcVNV1SMxeAeSWVNlzcjwFe2+kuNcMQ7GIajZe2RDAMEwOL
	uUWIBjWKkHGF2C5O7+bLw3JGx1BhUEqSqV4vE/31AmLXdXgVNFM3As9qQyX/ZacSTFeKC2qMdsM
	ssC+CtMz0yPkBDNCU6JPfUmeoL6rBynUH9SjOzSKqNJ8xVJRLKhi0Gb4TgO8MuRR1ovr87zNsX0
	CIz0Vuct1y9/GY4q/ejN/80/KhtU=
X-Received: by 2002:a17:903:944:b0:237:f7f8:7453 with SMTP id d9443c01a7336-23dee0dff73mr13953155ad.51.1752187562676;
        Thu, 10 Jul 2025 15:46:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEsToXwVRifnNntKFg0y25mkyPcXWWREZRxNC6sUDzHSHUhCziAj4udao5hth8gDYMUngSZyw==
X-Received: by 2002:a17:903:944:b0:237:f7f8:7453 with SMTP id d9443c01a7336-23dee0dff73mr13952835ad.51.1752187562271;
        Thu, 10 Jul 2025 15:46:02 -0700 (PDT)
Received: from hu-amelende-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23de4341d51sm30479615ad.189.2025.07.10.15.46.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jul 2025 15:46:01 -0700 (PDT)
From: Anjelique Melendez <anjelique.melendez@oss.qualcomm.com>
To: amitk@kernel.org, thara.gopinath@gmail.com, rafael@kernel.org,
        daniel.lezcano@linaro.org
Cc: rui.zhang@intel.com, lukasz.luba@arm.com, david.collins@oss.qualcomm.com,
        stefan.schmidt@linaro.org, quic_tsoni@quicinc.com,
        konrad.dybcio@oss.qualcomm.com, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        dmitry.baryshkov@linaro.org, dmitry.baryshkov@oss.qualcomm.com
Subject: [PATCH v6 4/5] thermal: qcom-spmi-temp-alarm: add support for GEN2 rev 2 PMIC peripherals
Date: Thu, 10 Jul 2025 15:45:54 -0700
Message-Id: <20250710224555.3047790-5-anjelique.melendez@oss.qualcomm.com>
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
X-Authority-Analysis: v=2.4 cv=dYuA3WXe c=1 sm=1 tr=0 ts=687042ab cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=N9IR0GguogMVy2wE49AA:9
 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzEwMDE5MSBTYWx0ZWRfXzKx+6YEXoMdr
 aWeMHIPe2fKDzrdkzQj+RtEDPIGkEYDhqtJthyW9qT4nt+Kje20HF2eNAZVvOnA2zSnUjlBvEcl
 L2KcAlwEwHiZBAMZNVG+p1ypU3FktR/FF7jYzTntX5KKGEyHlC9wiw2RDyCn5cDzcjZD8Abcd+C
 qoEFXoiPn6VPO13gJPS35R/EnnG0TUWdEWla20Ny2Xu4YHjlXjaEADzhrqlT9OzqVhIGHyV7HzC
 Q2a9cjImHRbcZmd4qcdSeu+QjXc+9PtqNn8BoTCd0tZFlb6Qry/HNRY9BwmjV9OcjOSStYM9bOf
 8zoVAfozDS6m0zhD4vaN3lA54jU5J4jokras3s+8Y0gff27mjd45tf43ifqHoCiswI+nYnLTQ7R
 SxwnO30ALiTVmPQQiQkRWMGcEtwIhl8mZv9xmUKXnK70fnsEaU7XqjsyvYS69YYtrCk4JWBO
X-Proofpoint-GUID: VXbGnOiGP2ucNBU8XQmHCd_0Kz-Qp8Re
X-Proofpoint-ORIG-GUID: VXbGnOiGP2ucNBU8XQmHCd_0Kz-Qp8Re
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-10_05,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 suspectscore=0 clxscore=1015 impostorscore=0 lowpriorityscore=0
 priorityscore=1501 spamscore=0 adultscore=0 mlxlogscore=999 malwarescore=0
 mlxscore=0 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507100191

Add support for TEMP_ALARM GEN2 PMIC peripherals with digital major
revision 2.  This revision utilizes individual temp DAC registers
to set the threshold temperature for over-temperature stages 1 (warning),
2 (system shutdown), and 3 (emergency shutdown) instead of a single
register to specify a set of thresholds.

Co-developed-by: David Collins <david.collins@oss.qualcomm.com>
Signed-off-by: David Collins <david.collins@oss.qualcomm.com>
Signed-off-by: Anjelique Melendez <anjelique.melendez@oss.qualcomm.com>
---
 drivers/thermal/qcom/qcom-spmi-temp-alarm.c | 138 +++++++++++++++++++-
 1 file changed, 137 insertions(+), 1 deletion(-)

diff --git a/drivers/thermal/qcom/qcom-spmi-temp-alarm.c b/drivers/thermal/qcom/qcom-spmi-temp-alarm.c
index c8e4db585d2b..9fbfd192017d 100644
--- a/drivers/thermal/qcom/qcom-spmi-temp-alarm.c
+++ b/drivers/thermal/qcom/qcom-spmi-temp-alarm.c
@@ -26,6 +26,11 @@
 #define QPNP_TM_REG_SHUTDOWN_CTRL1	0x40
 #define QPNP_TM_REG_ALARM_CTRL		0x46
 
+/* TEMP_DAC_STGx registers are only present for TEMP_GEN2 v2.0 */
+#define QPNP_TM_REG_TEMP_DAC_STG1	0x47
+#define QPNP_TM_REG_TEMP_DAC_STG2	0x48
+#define QPNP_TM_REG_TEMP_DAC_STG3	0x49
+
 #define QPNP_TM_TYPE			0x09
 #define QPNP_TM_SUBTYPE_GEN1		0x08
 #define QPNP_TM_SUBTYPE_GEN2		0x09
@@ -71,6 +76,25 @@ static const long temp_map_gen2_v1[THRESH_COUNT][STAGE_COUNT] = {
 
 #define TEMP_STAGE_HYSTERESIS		2000
 
+/*
+ * For TEMP_GEN2 v2.0, TEMP_DAC_STG1/2/3 registers are used to set the threshold
+ * for each stage independently.
+ * TEMP_DAC_STG* = 0 --> 80 C
+ * Each 8 step increase in TEMP_DAC_STG* value corresponds to 5 C (5000 mC).
+ */
+#define TEMP_DAC_MIN			80000
+#define TEMP_DAC_SCALE_NUM		8
+#define TEMP_DAC_SCALE_DEN		5000
+
+#define TEMP_DAC_TEMP_TO_REG(temp) \
+	(((temp) - TEMP_DAC_MIN) * TEMP_DAC_SCALE_NUM / TEMP_DAC_SCALE_DEN)
+#define TEMP_DAC_REG_TO_TEMP(reg) \
+	(TEMP_DAC_MIN + (reg) * TEMP_DAC_SCALE_DEN / TEMP_DAC_SCALE_NUM)
+
+static const long temp_dac_max[STAGE_COUNT] = {
+	119375, 159375, 159375
+};
+
 /* Temperature in Milli Celsius reported during stage 0 if no ADC is present */
 #define DEFAULT_TEMP			37000
 
@@ -93,6 +117,7 @@ struct qpnp_tm_chip {
 	long				temp;
 	unsigned int			stage;
 	unsigned int			base;
+	unsigned int			ntrips;
 	/* protects .thresh, .stage and chip registers */
 	struct mutex			lock;
 	bool				initialized;
@@ -310,6 +335,54 @@ static const struct thermal_zone_device_ops qpnp_tm_sensor_ops = {
 	.set_trip_temp = qpnp_tm_set_trip_temp,
 };
 
+static int qpnp_tm_gen2_rev2_set_temp_thresh(struct qpnp_tm_chip *chip, unsigned int trip, int temp)
+{
+	int ret, temp_cfg;
+	u8 reg;
+
+	WARN_ON(!mutex_is_locked(&chip->lock));
+
+	if (trip >= STAGE_COUNT) {
+		dev_err(chip->dev, "invalid TEMP_DAC trip = %d\n", trip);
+		return -EINVAL;
+	} else if (temp < TEMP_DAC_MIN || temp > temp_dac_max[trip]) {
+		dev_err(chip->dev, "invalid TEMP_DAC temp = %d\n", temp);
+		return -EINVAL;
+	}
+
+	reg = TEMP_DAC_TEMP_TO_REG(temp);
+	temp_cfg = TEMP_DAC_REG_TO_TEMP(reg);
+
+	ret = qpnp_tm_write(chip, QPNP_TM_REG_TEMP_DAC_STG1 + trip, reg);
+	if (ret < 0) {
+		dev_err(chip->dev, "TEMP_DAC_STG write failed, ret=%d\n", ret);
+		return ret;
+	}
+
+	chip->temp_thresh_map[trip] = temp_cfg;
+
+	return 0;
+}
+
+static int qpnp_tm_gen2_rev2_set_trip_temp(struct thermal_zone_device *tz,
+					   const struct thermal_trip *trip, int temp)
+{
+	unsigned int trip_index = THERMAL_TRIP_PRIV_TO_INT(trip->priv);
+	struct qpnp_tm_chip *chip = thermal_zone_device_priv(tz);
+	int ret;
+
+	mutex_lock(&chip->lock);
+	ret = qpnp_tm_gen2_rev2_set_temp_thresh(chip, trip_index, temp);
+	mutex_unlock(&chip->lock);
+
+	return ret;
+}
+
+static const struct thermal_zone_device_ops qpnp_tm_gen2_rev2_sensor_ops = {
+	.get_temp = qpnp_tm_get_temp,
+	.set_trip_temp = qpnp_tm_gen2_rev2_set_trip_temp,
+};
+
 static irqreturn_t qpnp_tm_isr(int irq, void *data)
 {
 	struct qpnp_tm_chip *chip = data;
@@ -351,6 +424,60 @@ static int qpnp_tm_configure_trip_temp(struct qpnp_tm_chip *chip)
 	return ret;
 }
 
+/* Configure TEMP_DAC registers based on DT thermal_zone trips */
+static int qpnp_tm_gen2_rev2_configure_trip_temps_cb(struct thermal_trip *trip, void *data)
+{
+	struct qpnp_tm_chip *chip = data;
+	int ret;
+
+	mutex_lock(&chip->lock);
+	trip->priv = THERMAL_INT_TO_TRIP_PRIV(chip->ntrips);
+	ret = qpnp_tm_gen2_rev2_set_temp_thresh(chip, chip->ntrips, trip->temperature);
+	chip->ntrips++;
+	mutex_unlock(&chip->lock);
+
+	return ret;
+}
+
+static int qpnp_tm_gen2_rev2_configure_trip_temps(struct qpnp_tm_chip *chip)
+{
+	int ret, i;
+
+	ret = thermal_zone_for_each_trip(chip->tz_dev,
+					 qpnp_tm_gen2_rev2_configure_trip_temps_cb, chip);
+	if (ret < 0)
+		return ret;
+
+	/* Verify that trips are strictly increasing. */
+	for (i = 1; i < STAGE_COUNT; i++) {
+		if (chip->temp_thresh_map[i] <= chip->temp_thresh_map[i - 1]) {
+			dev_err(chip->dev, "Threshold %d=%ld <= threshold %d=%ld\n",
+				i, chip->temp_thresh_map[i], i - 1,
+				chip->temp_thresh_map[i - 1]);
+			return -EINVAL;
+		}
+	}
+
+	return 0;
+}
+
+/* Read the hardware default TEMP_DAC stage threshold temperatures */
+static int qpnp_tm_gen2_rev2_sync_thresholds(struct qpnp_tm_chip *chip)
+{
+	int ret, i;
+	u8 reg = 0;
+
+	for (i = 0; i < STAGE_COUNT; i++) {
+		ret = qpnp_tm_read(chip, QPNP_TM_REG_TEMP_DAC_STG1 + i, &reg);
+		if (ret < 0)
+			return ret;
+
+		chip->temp_thresh_map[i] = TEMP_DAC_REG_TO_TEMP(reg);
+	}
+
+	return 0;
+}
+
 static const struct spmi_temp_alarm_data spmi_temp_alarm_data = {
 	.ops = &qpnp_tm_sensor_ops,
 	.temp_map = &temp_map_gen1,
@@ -375,6 +502,13 @@ static const struct spmi_temp_alarm_data spmi_temp_alarm_gen2_rev1_data = {
 	.get_temp_stage = qpnp_tm_gen2_get_temp_stage,
 };
 
+static const struct spmi_temp_alarm_data spmi_temp_alarm_gen2_rev2_data = {
+	.ops = &qpnp_tm_gen2_rev2_sensor_ops,
+	.sync_thresholds = qpnp_tm_gen2_rev2_sync_thresholds,
+	.configure_trip_temps = qpnp_tm_gen2_rev2_configure_trip_temps,
+	.get_temp_stage = qpnp_tm_gen2_get_temp_stage,
+};
+
 /*
  * This function initializes the internal temp value based on only the
  * current thermal stage and threshold.
@@ -491,8 +625,10 @@ static int qpnp_tm_probe(struct platform_device *pdev)
 		chip->data = &spmi_temp_alarm_data;
 	else if (subtype == QPNP_TM_SUBTYPE_GEN2 && dig_major == 0)
 		chip->data = &spmi_temp_alarm_gen2_data;
-	else if (subtype == QPNP_TM_SUBTYPE_GEN2 && dig_major >= 1)
+	else if (subtype == QPNP_TM_SUBTYPE_GEN2 && dig_major == 1)
 		chip->data = &spmi_temp_alarm_gen2_rev1_data;
+	else if (subtype == QPNP_TM_SUBTYPE_GEN2 && dig_major >= 2)
+		chip->data = &spmi_temp_alarm_gen2_rev2_data;
 	else
 		return -ENODEV;
 
-- 
2.34.1


