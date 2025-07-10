Return-Path: <linux-pm+bounces-30644-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99983B00EFC
	for <lists+linux-pm@lfdr.de>; Fri, 11 Jul 2025 00:47:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E3C4F3AA59F
	for <lists+linux-pm@lfdr.de>; Thu, 10 Jul 2025 22:46:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C5CE2D1F4A;
	Thu, 10 Jul 2025 22:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="gmTp5H4p"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AA972C032E
	for <linux-pm@vger.kernel.org>; Thu, 10 Jul 2025 22:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752187568; cv=none; b=pkZ/vyMaw5jgg/6Tv3Re2D6K426kCFFPEwVzP72UchkWlwiZHz4CAe70Z8fSuFojFLK1BssY5OAYQspzRYuMB6RqvpJPw3sKWkYrhEeStvqGt4JCnR0AIVPb8kr04CvEFk15mdJZARkEnyr9/eKLVTni/CF/XH3KddLYVzWt06o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752187568; c=relaxed/simple;
	bh=1I6+4fLFYxIRchnimpbcx/xAezT0weK9I3m33+3twO8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Wz1BP3KKs9jFJfm9l1sRJl2vwycQPaHifc0/o6BPjJ9sHNwvhddL3hzPOk+dyJHGc7ECtKcB2IF8glbmlMrVpdTIik7kXVhoC8kPhTn9QrEDNqTULfdgGSYasPlGVDd7nSgyIaSbcIZ7Qy9r81yvQTygRpA1P7r/S4dwQGJv/CM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=gmTp5H4p; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56AJRCiQ027424
	for <linux-pm@vger.kernel.org>; Thu, 10 Jul 2025 22:46:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=qTV57CQ8ymJ
	mYXnc5Iu4DmQhuHr9c68sQy8sTbtSQKA=; b=gmTp5H4pyJl2bQGN0MmDSdMwfn3
	yX7cXfISaAD49TwkCNf+Q+1wd+/j+OpmwWykqo10Fv3CncvoT09CanLZ0XhGMgRO
	Fg2Ya3CZIJwdD94lJkzFd/viSjUyQb+Xe0eNoDqyUfgyvCBQGOSatWXK8x0IPm51
	qSB1Y6LYpdgfxS2f7aWY5wO7gbQtmmTkr3Qlq9WcYUQp88o70NNmDoNIkFPFnGAF
	WvbCy/rckNCsAsI9den2DW9CXWqg8G/l9PLnbKv7B/YTDrrPBYGLf1cQiMvnz2+c
	UNxonW/1TMo66gKNsePCIGBQp52EaeS1Z06pkGKMD6t5/hy2tGwrWdgItsA==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47t83u2vwg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 10 Jul 2025 22:46:05 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2355651d204so14547425ad.2
        for <linux-pm@vger.kernel.org>; Thu, 10 Jul 2025 15:46:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752187564; x=1752792364;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qTV57CQ8ymJmYXnc5Iu4DmQhuHr9c68sQy8sTbtSQKA=;
        b=IGpFB271mog2anKbWJKfi5ZRahvj5afgpGzkx0eky+7jxZUr/cqhFzstkED4gjHzis
         CLVgnlaUTqT/9wUndsXcPVW3uxCszBaDzqGao231zZ2b8KGUN7C0b9AEoGnZzymLVzRF
         +AFtVFxT9gkSn+ZEdZTlnAAwL4+I/wi2ImkZoGfpyx9Ept4k0Omunic0uNZDJaBBv1a9
         3+i+xOnxfJbIurpK27OOwfEX71Ilz43Bs8fqfRzpPJ9UofR0AQ8YbDw/IplQnCT07Ul7
         KLlRubQg3nPDu7gMGvpyVfaEYUc/M1+PgGleObUYWexbDnd+cWTEIUWQTZ/C7MZewUV2
         zveg==
X-Forwarded-Encrypted: i=1; AJvYcCUZx2izuoBG187ezCByC9cmwpoMKBORJL6eCb/Iv2ZjoCBIeotp77XYgkN9CjJGin8o2MrYjb/h+A==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7Ejm/8bVO3/99c83VQtvPutrrV/2W0erAfp2LOBUqyEXaH/OV
	Pzy/lGMsiCttZ7aSoNlCamOdtWfbSFA6s571cCjqkFm9hifyPOw7K4tm3tCiC+kDPNiW1CbmGEP
	bELbNU31Bdp4IZmM2GaDXgSWa3bl7S7m1difiSIV2B4WEscs4nnm+vG5KigX3Xg==
X-Gm-Gg: ASbGnctvuxzlvkbhVSt0qAVgXbF1XyNA+qAuJfKA2A1mfmAQVhnSNz/r99a0Jy9V+vJ
	fgoaLMrzov9DuRXqREELhzPQACHfrmG1oVW1Q1LbeHShU5dcLjONkt5Px28KsqPCpsIJS6BrT27
	Ro7AnI/emEtQcxvcwq5DjjV1hm9XDqBjTayU+qVN2z396TiPmhQpqo89Gck18A3gk54z89XzDoH
	zlvcgcHDzQ8xBCNzTQgleDMM5AfiB5ptCNDdZ3r6yZAuVA7/u1m9VOmMxL/KILks+P2QNTGgr/M
	XfBezCWjyTMH/9TAO5n2/5HZQrSrqZGNqqbunyfHe1JcMPbUpG1IY/Lvyewf21KLj3yQyu9CBl2
	z5EoGZ9rOTqOORHGwJh3uVUtG0ZU=
X-Received: by 2002:a17:903:98c:b0:22e:421b:49b1 with SMTP id d9443c01a7336-23dede94a67mr12179125ad.48.1752187564131;
        Thu, 10 Jul 2025 15:46:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGkdL3WJ6xRqtGtImhgF2AwOwFBRgfjiJyMt52F5VPsKm3YbKQk5xFMvR1NzIW+jCLp+JXxFQ==
X-Received: by 2002:a17:903:98c:b0:22e:421b:49b1 with SMTP id d9443c01a7336-23dede94a67mr12178805ad.48.1752187563716;
        Thu, 10 Jul 2025 15:46:03 -0700 (PDT)
Received: from hu-amelende-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23de4341d51sm30479615ad.189.2025.07.10.15.46.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jul 2025 15:46:03 -0700 (PDT)
From: Anjelique Melendez <anjelique.melendez@oss.qualcomm.com>
To: amitk@kernel.org, thara.gopinath@gmail.com, rafael@kernel.org,
        daniel.lezcano@linaro.org
Cc: rui.zhang@intel.com, lukasz.luba@arm.com, david.collins@oss.qualcomm.com,
        stefan.schmidt@linaro.org, quic_tsoni@quicinc.com,
        konrad.dybcio@oss.qualcomm.com, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        dmitry.baryshkov@linaro.org, dmitry.baryshkov@oss.qualcomm.com
Subject: [PATCH v6 5/5] thermal: qcom-spmi-temp-alarm: add support for LITE PMIC peripherals
Date: Thu, 10 Jul 2025 15:45:55 -0700
Message-Id: <20250710224555.3047790-6-anjelique.melendez@oss.qualcomm.com>
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
X-Proofpoint-ORIG-GUID: AgPVWHvLJQPfGlJWmTWbs55EyEz0XxVS
X-Authority-Analysis: v=2.4 cv=OotPyz/t c=1 sm=1 tr=0 ts=687042ad cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=mWY56GqtIC0XaCpv56YA:9
 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzEwMDE5MSBTYWx0ZWRfX5rTxDOqA9VNd
 kzwdqUU+A6uwF+UGJdq6hsvupu3OmAg2mq8de3Saav9BAJ+L5qe5oWU0hsgWJDyAZqACCwh9duy
 HLfwYbF+6qfM9iJ/Nuu7u3VIuGnfPHpVcuQpEprHtUd9Ljh7hosvvwhwXB25E5/Bw9yciLVizM5
 I1i/BBcxVZNnuOW9Z/UKOdAeqZVRxtK/a7bABCXPrLgxOO6sLIZD6BU+rXzyP6hr0TBFLTVolEl
 t+R6qD3vvRTPT20T7cVXiafhqGLKsdWMqnMww3p3GypCcu2zmgK40UdNQZnwkIKCUTfDQdqN2WJ
 U0N0asYgmLMe5WbL/5McRamdM42EtvRSm9UfTMUi1P5+9DLziWnhi4p1zJv2rlbv0ckgayOYa9v
 EMbUfI+20uqgZj984PWvw1BEyeD4Lw1/IGXWbTdEHWJhQadE18DTnLI8Sg5bUU8U7gsnc2FG
X-Proofpoint-GUID: AgPVWHvLJQPfGlJWmTWbs55EyEz0XxVS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-10_05,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 mlxscore=0 adultscore=0 spamscore=0
 malwarescore=0 mlxlogscore=999 clxscore=1015 suspectscore=0 bulkscore=0
 lowpriorityscore=0 phishscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507100191

Add support for TEMP_ALARM LITE PMIC peripherals. This subtype
utilizes a pair of registers to configure a warning interrupt
threshold temperature and an automatic hardware shutdown
threshold temperature.

Co-developed-by: David Collins <david.collins@oss.qualcomm.com>
Signed-off-by: David Collins <david.collins@oss.qualcomm.com>
Signed-off-by: Anjelique Melendez <anjelique.melendez@oss.qualcomm.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/thermal/qcom/qcom-spmi-temp-alarm.c | 208 +++++++++++++++++++-
 1 file changed, 207 insertions(+), 1 deletion(-)

diff --git a/drivers/thermal/qcom/qcom-spmi-temp-alarm.c b/drivers/thermal/qcom/qcom-spmi-temp-alarm.c
index 9fbfd192017d..f39ca0ddd17b 100644
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
 #define SHUTDOWN_CTRL1_OVERRIDE_STAGE2	BIT(6)
 #define SHUTDOWN_CTRL1_THRESHOLD_MASK	GENMASK(1, 0)
 
@@ -45,6 +52,8 @@
 
 #define ALARM_CTRL_FORCE_ENABLE		BIT(7)
 
+#define LITE_TEMP_CFG_THRESHOLD_MASK	GENMASK(3, 2)
+
 #define THRESH_COUNT			4
 #define STAGE_COUNT			3
 
@@ -95,6 +104,19 @@ static const long temp_dac_max[STAGE_COUNT] = {
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
 
@@ -202,6 +224,24 @@ static int qpnp_tm_gen2_get_temp_stage(struct qpnp_tm_chip *chip)
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
+	return FIELD_GET(IRQ_STATUS_MASK, reg);
+}
+
 /*
  * This function updates the internal temp value based on the
  * current thermal stage and threshold as well as the previous stage
@@ -383,6 +423,98 @@ static const struct thermal_zone_device_ops qpnp_tm_gen2_rev2_sensor_ops = {
 	.set_trip_temp = qpnp_tm_gen2_rev2_set_trip_temp,
 };
 
+static int qpnp_tm_lite_set_temp_thresh(struct qpnp_tm_chip *chip, unsigned int trip, int temp)
+{
+	int ret, temp_cfg, i;
+	const long *temp_map;
+	u8 reg, thresh;
+	u16 addr;
+
+	WARN_ON(!mutex_is_locked(&chip->lock));
+
+	if (trip >= STAGE_COUNT) {
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
@@ -478,6 +610,70 @@ static int qpnp_tm_gen2_rev2_sync_thresholds(struct qpnp_tm_chip *chip)
 	return 0;
 }
 
+/* Configure TEMP_LITE registers based on DT thermal_zone trips */
+static int qpnp_tm_lite_configure_trip_temps_cb(struct thermal_trip *trip, void *data)
+{
+	struct qpnp_tm_chip *chip = data;
+	int ret;
+
+	mutex_lock(&chip->lock);
+	trip->priv = THERMAL_INT_TO_TRIP_PRIV(chip->ntrips);
+	ret = qpnp_tm_lite_set_temp_thresh(chip, chip->ntrips, trip->temperature);
+	chip->ntrips++;
+	mutex_unlock(&chip->lock);
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
+static int qpnp_tm_lite_sync_thresholds(struct qpnp_tm_chip *chip)
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
@@ -509,6 +705,13 @@ static const struct spmi_temp_alarm_data spmi_temp_alarm_gen2_rev2_data = {
 	.get_temp_stage = qpnp_tm_gen2_get_temp_stage,
 };
 
+static const struct spmi_temp_alarm_data spmi_temp_alarm_lite_data = {
+	.ops = &qpnp_tm_lite_sensor_ops,
+	.sync_thresholds = qpnp_tm_lite_sync_thresholds,
+	.configure_trip_temps = qpnp_tm_lite_configure_trip_temps,
+	.get_temp_stage = qpnp_tm_lite_get_temp_stage,
+};
+
 /*
  * This function initializes the internal temp value based on only the
  * current thermal stage and threshold.
@@ -614,7 +817,8 @@ static int qpnp_tm_probe(struct platform_device *pdev)
 				     "could not read dig_minor\n");
 
 	if (type != QPNP_TM_TYPE || (subtype != QPNP_TM_SUBTYPE_GEN1
-				     && subtype != QPNP_TM_SUBTYPE_GEN2)) {
+				     && subtype != QPNP_TM_SUBTYPE_GEN2
+				     && subtype != QPNP_TM_SUBTYPE_LITE)) {
 		dev_err(&pdev->dev, "invalid type 0x%02x or subtype 0x%02x\n",
 			type, subtype);
 		return -ENODEV;
@@ -629,6 +833,8 @@ static int qpnp_tm_probe(struct platform_device *pdev)
 		chip->data = &spmi_temp_alarm_gen2_rev1_data;
 	else if (subtype == QPNP_TM_SUBTYPE_GEN2 && dig_major >= 2)
 		chip->data = &spmi_temp_alarm_gen2_rev2_data;
+	else if (subtype == QPNP_TM_SUBTYPE_LITE)
+		chip->data = &spmi_temp_alarm_lite_data;
 	else
 		return -ENODEV;
 
-- 
2.34.1


