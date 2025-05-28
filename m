Return-Path: <linux-pm+bounces-27770-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 43173AC74AA
	for <lists+linux-pm@lfdr.de>; Thu, 29 May 2025 01:51:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E4F8B1C01612
	for <lists+linux-pm@lfdr.de>; Wed, 28 May 2025 23:52:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCA5626B2A3;
	Wed, 28 May 2025 23:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="O+B0ylfO"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1F4D26A0F4
	for <linux-pm@vger.kernel.org>; Wed, 28 May 2025 23:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748476240; cv=none; b=dW+9MjcKLp7WeZIOifLsvQXYxcj2GNY4BNIcf+y+exMxojZ8BHUdlionDS7wMi9IlM3aYtnkm/qBWkj7etIKrOMx6pXUr730BFCLhd6c1kDn48mri9M+2Vd+jH4fd3nFlYTi1sYTh6/O0h/oX2+ts3/oxXP4eWDuTQRd7AjZqLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748476240; c=relaxed/simple;
	bh=zC7jbZCX/qB1HhZP51rSsNb52oIv58Egh8xVDfoYLCc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=aWyCxHcWD01h/g1zawtdutqhYQsRkaj/h031FKTEFVyMlvPK4nk8KBwwIrod9h9C+L83bGNA4hqteWiM5rgUzdARjaCgwg364Yy3wCSrWXJ5p5Mf0hv3pnBfsb02eIcI+Z8dVwRCLjHZOMSHnm+SZd9arztJ9LBND98eDkqFCTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=O+B0ylfO; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54SK1qYQ009136
	for <linux-pm@vger.kernel.org>; Wed, 28 May 2025 23:50:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=b0VRFLUpBld
	GD1wHnkigmW+lz5kQ7D0/OXNlhzoZW1k=; b=O+B0ylfO0mve6cUKkIukoDrR/+8
	jZDuPYXOsjsaWvSu8pCukawmX9UVzVV+eB6ltOuAnEUczvvZaiAaennYuKnZ8gQC
	cAh8JV3C7vRNhCaK5Wx+PcdumFmnFfJBWTWXw3kG/kMKkZvLxacbNBO/GupTEWCT
	QgJKW0vEynLg1zirwhT7eRZntosRzDuxWKIQvSTaf/xohH9m9HN5GRbcGYF5UYIO
	wPjPO2teFYdiEHVd4miOuDCUk3U3o9pjOdrcU2QxP1dBK3A5V28tyz+cNGawyPBa
	K5NNsrpxdxQkTF76lll0iyoNT79av3UuYpujklbhf3k4PX0XvvZ301g0e5A==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46x03mt2q5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 28 May 2025 23:50:37 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-23494a515e3so2735405ad.2
        for <linux-pm@vger.kernel.org>; Wed, 28 May 2025 16:50:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748476236; x=1749081036;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b0VRFLUpBldGD1wHnkigmW+lz5kQ7D0/OXNlhzoZW1k=;
        b=avxxOyRxnvsL0yjvuwl8bJpywOchDB03ZTFlu+C6yzlvIEuaSaRbCqdHl8ANlvop0f
         ezAPozfpY7avAtzsNmtMzyztHd+UXkjKv45yrS4XnPIcFVZN3kZQvXq3XdF2UgvAZn20
         6qbimTxhhJsoIb1IhfsCMNx3YTqLNrf/wOAMX/rPId3+QZXzm3MdpLvJ5LABEf4gYyCW
         iW8JDvnHssv4bHHdMJ5u5Q8Ar5D2HQ65DkdLm95CIYnQj2KzhyobvzNOjnmyIYBx/kpR
         P3l/b50zElh9ZMuBBkxDMdbLbLPIp/JGSiX0m/rI5t+jkZIr6rMQpmLsvGY0n0GBiYrs
         lGHQ==
X-Forwarded-Encrypted: i=1; AJvYcCXhFEMi2deB5fheL5H/r9odwuvhV/p7HzCvDKCkWFDX6GPZEoRYPSrpI5Hek1+SGr19MqmzzZhj2w==@vger.kernel.org
X-Gm-Message-State: AOJu0YxowCzTeILy2YGZ41agX0MP92zB/8PZx6np0G6G7X/0Ua1JOI5n
	pILc4kt2dcDZV1Y4lkAorwyp3lTVa7V0TNssgGZ97BXQBjBt7S5iDrFaRPFaYFIPA99fQ3NzQWV
	S0RQNAU/9sEDk+oMjTw/2cOEqnYseBf5DjsHY+AdN563B01BSJ+PmdiRwmtCr3Q==
X-Gm-Gg: ASbGncsWpk/ZyFxWucB2HqPYjS9f5xlCjZro+WcqPcVEqC7lyE7W2AQv6d9ym+zT38T
	u25QgPTXHmRhIxelrYHNL1Go6d+J9z8r549KRoEndoZXVHWrbJlc+O9ezYHlk4+o4WN1quQ315t
	eatM8poo/1nWsK85bWi8B/s5xc9fMRYy6dnzM9J9Ls9eVPO+UcSCIFVuDGTgFSmjpk6dS7ZUNvd
	SPf1KsivMypOm5L7golmNHn5FqPwHvHqMB4rpd1RspXYBbsYHBv+9r1Lq7rwRkWloOEvbb8ncvC
	I0dQh8kQZ/WKpD24iBdgviEkvJ2REvwhbGA4iV/FwedLlDibW1MQ/10YvKZX0LShAqCTDo2h+tQ
	=
X-Received: by 2002:a17:903:187:b0:231:cb8e:4734 with SMTP id d9443c01a7336-234d2a9bd00mr60161525ad.15.1748476236289;
        Wed, 28 May 2025 16:50:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGBBV6NWTELpquP8G5GxzaRqaL4Tm7RzQGb08ze/pgAmUrVvLgGNF6p/gvmqvRmr2kLYb4XzQ==
X-Received: by 2002:a17:903:187:b0:231:cb8e:4734 with SMTP id d9443c01a7336-234d2a9bd00mr60161255ad.15.1748476235863;
        Wed, 28 May 2025 16:50:35 -0700 (PDT)
Received: from hu-amelende-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23506cd3506sm1403445ad.156.2025.05.28.16.50.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 May 2025 16:50:35 -0700 (PDT)
From: Anjelique Melendez <anjelique.melendez@oss.qualcomm.com>
To: amitk@kernel.org, thara.gopinath@gmail.com, rafael@kernel.org,
        daniel.lezcano@linaro.org
Cc: rui.zhang@intel.com, lukasz.luba@arm.com, david.collins@oss.qualcomm.com,
        srinivas.kandagatla@linaro.org, stefan.schmidt@linaro.org,
        quic_tsoni@quicinc.com, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        dmitry.baryshkov@linaro.org, dmitry.baryshkov@oss.qualcomm.com
Subject: [PATCH v4 5/5] thermal: qcom-spmi-temp-alarm: add support for LITE PMIC peripherals
Date: Wed, 28 May 2025 16:50:26 -0700
Message-Id: <20250528235026.4171109-6-anjelique.melendez@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250528235026.4171109-1-anjelique.melendez@oss.qualcomm.com>
References: <20250528235026.4171109-1-anjelique.melendez@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: _emrrslG8gPyLm4agpq5WcWYrRisEu2w
X-Authority-Analysis: v=2.4 cv=FuAF/3rq c=1 sm=1 tr=0 ts=6837a14d cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=dt9VzEwgFbYA:10 a=EUspDBNiAAAA:8 a=rhdsTsYyw6L1dzp8dgcA:9
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-ORIG-GUID: _emrrslG8gPyLm4agpq5WcWYrRisEu2w
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTI4MDIwOSBTYWx0ZWRfX6b1UrEz51CQn
 CcaxSUglfNzxzk/nSPi158q4yctnGr7OIZnhjymCxK3BTgypcbcUl1z8UxxVBphEVbSOvRsUF+s
 wvYyQ4T9nQlCUWwXgRaO1a/V44BR18VwIELlgbNfC7zDbRnme8JyskI3RpdH45ELqFAiKLaT7IJ
 PzBJAGBTSwAGZ4jcyv7CB3PVovhh4+CxUfdqViL3P2aujlRVQuK77WztWX4pXLB+ag+SlTikt9H
 v2O1buwe7m+VipqFMS+UqbXfbROpwFOu6PGXfdn2CrafZvvsAk0iag7lI/0Mmo6S+mR4qDCS80g
 HH2+sku9hrTZJ6t+clLyPE4B1pnEY0jc8qfZ/FQFPPKHGLz4mbD8HaTx6gQqs64+NRkCfMHYx4z
 OmOm/vuslJHDYai0fYLP0iO+dW91YHOBlHCt7C6+MMKQJdAPtYbwq9bmIT11ppWstuZGlYon
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-28_11,2025-05-27_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 mlxlogscore=999 mlxscore=0 impostorscore=0
 bulkscore=0 spamscore=0 phishscore=0 priorityscore=1501 lowpriorityscore=0
 clxscore=1015 malwarescore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505160000
 definitions=main-2505280209

Add support for TEMP_ALARM LITE PMIC peripherals. This subtype
utilizes a pair of registers to configure a warning interrupt
threshold temperature and an automatic hardware shutdown
threshold temperature.

Signed-off-by: David Collins <david.collins@oss.qualcomm.com>
Signed-off-by: Anjelique Melendez <anjelique.melendez@oss.qualcomm.com>
---
 drivers/thermal/qcom/qcom-spmi-temp-alarm.c | 208 +++++++++++++++++++-
 1 file changed, 207 insertions(+), 1 deletion(-)

diff --git a/drivers/thermal/qcom/qcom-spmi-temp-alarm.c b/drivers/thermal/qcom/qcom-spmi-temp-alarm.c
index 29ec6445fc21..1dcbc4415db3 100644
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
@@ -378,6 +418,98 @@ static const struct thermal_zone_device_ops qpnp_tm_gen2_rev2_sensor_ops = {
 	.set_trip_temp = qpnp_tm_gen2_rev2_set_trip_temp,
 };
 
+static int qpnp_tm_lite_set_temp_thresh(struct qpnp_tm_chip *chip, int trip, int temp)
+{
+	int ret, temp_cfg, i;
+	const long *temp_map;
+	u16 addr;
+	u8 reg, thresh;
+
+	WARN_ON(!mutex_is_locked(&chip->lock));
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
@@ -456,6 +588,70 @@ static int qpnp_tm_gen2_rev2_setup(struct qpnp_tm_chip *chip)
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
@@ -484,6 +680,13 @@ static const struct spmi_temp_alarm_data spmi_temp_alarm_gen2_rev2_data = {
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
@@ -593,7 +796,8 @@ static int qpnp_tm_probe(struct platform_device *pdev)
 	}
 
 	if (type != QPNP_TM_TYPE || (subtype != QPNP_TM_SUBTYPE_GEN1
-				     && subtype != QPNP_TM_SUBTYPE_GEN2)) {
+				     && subtype != QPNP_TM_SUBTYPE_GEN2
+				     && subtype != QPNP_TM_SUBTYPE_LITE)) {
 		dev_err(&pdev->dev, "invalid type 0x%02x or subtype 0x%02x\n",
 			type, subtype);
 		return -ENODEV;
@@ -608,6 +812,8 @@ static int qpnp_tm_probe(struct platform_device *pdev)
 		chip->data = &spmi_temp_alarm_gen2_rev1_data;
 	else if (subtype == QPNP_TM_SUBTYPE_GEN2)
 		chip->data = &spmi_temp_alarm_gen2_data;
+	else if (subtype == QPNP_TM_SUBTYPE_LITE)
+		chip->data = &spmi_temp_alarm_lite_data;
 	else
 		return -ENODEV;
 
-- 
2.34.1


