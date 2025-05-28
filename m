Return-Path: <linux-pm+bounces-27769-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10FBCAC74A8
	for <lists+linux-pm@lfdr.de>; Thu, 29 May 2025 01:51:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C67D24A5384
	for <lists+linux-pm@lfdr.de>; Wed, 28 May 2025 23:51:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA6A3267B87;
	Wed, 28 May 2025 23:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="JB7ChYUE"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06E7026A096
	for <linux-pm@vger.kernel.org>; Wed, 28 May 2025 23:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748476239; cv=none; b=T9atY3MMp3k7ndv39d/4woqGrc+vgHJwOAaENe17CO/9nTZZqr7hMO7Qr8fw0bYM3SiXRKmN8aJl4GK3xlO9V1D3yiueAguolJhmYYGSnTl37emYMtOYgN5rWTpn1K4Tuen34dwQhKbDQkclkY1CTQ84QbFApy7g0lsZs4qs1Tc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748476239; c=relaxed/simple;
	bh=8v1ySg90qhs2Ci8euvekTcww2bNrJTupV5iQQzU4mZQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DhusDt7J6anV5/H7YclQejZcQrnn7icytm54LFxW+zXbQaUlON3gEmr64iPyGkk8GwTvecgUwGCGv42IaftR0MmF8zaoH5I568CJnYSozL7lAaSwmMQLCclKrfCu4VAAFT2xOigOEB/zWDTC2D6CMW/+ViBCY5zaj/bhG84NcLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=JB7ChYUE; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54SGp2EV030608
	for <linux-pm@vger.kernel.org>; Wed, 28 May 2025 23:50:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=y0RVDEtXb+Z
	rYxOoACHkU/Phrk6vZh40R6HRQfHaDh8=; b=JB7ChYUEFyIPpPsAgc4AiVcV989
	n+HIZ7nzwVHo3QbG7I8bqDtgtq1ZGwLqS0hn4EoYt34daIXjVPcanR32HT/P9AvI
	J4GGe5z/uJSnytpUbXFAf1vPXLOJdAwu+wzW3YJmnenzlJDglMY3DC+UGbWkSCUQ
	4H9iQFq2n17g6h94qbBThsdHTxf32QQZnlaXSx10oVAkLGGkUsuWW9s3Q50jNueT
	yAgg++vUsmOABf/cIoKekeoEioLcQpHMu49MncrlQCxkGUaniC1E6/yYb4u/lvDO
	pL1AvQfs/EpxRLIogPI/Q1FLPCOHuw1mGnsSNHLkipt5V+yBX+HeRp5p9EA==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46u3fqc1e2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 28 May 2025 23:50:36 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2347012f864so13315945ad.1
        for <linux-pm@vger.kernel.org>; Wed, 28 May 2025 16:50:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748476235; x=1749081035;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y0RVDEtXb+ZrYxOoACHkU/Phrk6vZh40R6HRQfHaDh8=;
        b=aIwR6DlZjBtmXeUv5yjjRUiqpZyAZ/U0tUbkThFoU+3zr9OFnx2dOo+HJ/c77yzmfe
         umFOCPPOg+xU6ZtA2wV4J1kHS5ojmdaKR13+yWRu0lJ99ZxN82vm6GqbnHjZCZLOGNlW
         rw1LW2y4B4R036xhYzEAY3kpSOViB4E3UB1L9+Imsu0bwEd57Qpy6v5fZfBDcigttyll
         JLS3DMiKaPHtLcFPj3V8myzD4TreoTl+FafZDYTr8g4aBczBfmDYz/AIG92ACeLS8706
         aYPSV0J5LRHP3Jc7dX58dHiMs4Y0y1BCEpC9QDrHV655WZCetAhJRyFWGDOOhvVz0toh
         4sKA==
X-Forwarded-Encrypted: i=1; AJvYcCUdmsE+F4HY7TTTnZR3uBf92tD9cqt64AVwzmBJ/FL1f21GaXsKZ7S1cos2nigTqDmNaio6j9fdqA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzo5/koVgb7+DbtEI59xwRtmcUeo0qLFKBP+m8eRrYE0HJnKlsT
	bhIz9YplH36KTJQjU9ywrJEGewHEHPflSQatAYVjStCTenYG43//aGFslyvEGJKQPArxQi03CR6
	D4uVlj7g7SaOCFq6ONbGAt/gVQmEnaP4Uq+FFxZWv6qWlQxPt6Xx/NsL9ZQst8g==
X-Gm-Gg: ASbGncsO0Ks4JLMSxW/LAebWO3B4yLjc6/KOfYIfcDHM3oDmGYUBgHZwKogISZH5F8B
	LXzR8nU3GFjevfrRMB4OtAGNNzhzMzDsc9RQif4mlaoG66B9ZpK/vPg/qllJWeI9cqYK+0Tmhv6
	Q/zI3ZzNTn8ltVv2BSURP6PnchWcwjxj0loTvBTBbUuqy6VcyU11Hp0F2P/zL00s16MPuhXMtZO
	pduOJroZ9fymSP9yTWltGgWFz20X6cjL4wdxRbdIqe1XqyPYUjTSsOWlNvPxLslAYksOUy5/VZn
	e6X0euoMIOyQ/BKp4cTiiAMK5ntpkVDkXUWLp92Gm31gGBLp75RArRV/Mbpa96El337eiX/FFU8
	=
X-Received: by 2002:a17:902:dac2:b0:215:ba2b:cd55 with SMTP id d9443c01a7336-234f679b0d0mr20128045ad.2.1748476234935;
        Wed, 28 May 2025 16:50:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHVGGwbaP+bXYuE+VhpU8ZZGwIMgpkGumJEEhl9hEC2czJXopxUpdBvYdh5gDPywonZvYc0dQ==
X-Received: by 2002:a17:902:dac2:b0:215:ba2b:cd55 with SMTP id d9443c01a7336-234f679b0d0mr20127745ad.2.1748476234523;
        Wed, 28 May 2025 16:50:34 -0700 (PDT)
Received: from hu-amelende-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23506cd3506sm1403445ad.156.2025.05.28.16.50.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 May 2025 16:50:33 -0700 (PDT)
From: Anjelique Melendez <anjelique.melendez@oss.qualcomm.com>
To: amitk@kernel.org, thara.gopinath@gmail.com, rafael@kernel.org,
        daniel.lezcano@linaro.org
Cc: rui.zhang@intel.com, lukasz.luba@arm.com, david.collins@oss.qualcomm.com,
        srinivas.kandagatla@linaro.org, stefan.schmidt@linaro.org,
        quic_tsoni@quicinc.com, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        dmitry.baryshkov@linaro.org, dmitry.baryshkov@oss.qualcomm.com
Subject: [PATCH v4 4/5] thermal: qcom-spmi-temp-alarm: add support for GEN2 rev 2 PMIC peripherals
Date: Wed, 28 May 2025 16:50:25 -0700
Message-Id: <20250528235026.4171109-5-anjelique.melendez@oss.qualcomm.com>
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
X-Proofpoint-GUID: HUGrLNFCcPURR7GxQlDNzE2Su_L7OEpA
X-Proofpoint-ORIG-GUID: HUGrLNFCcPURR7GxQlDNzE2Su_L7OEpA
X-Authority-Analysis: v=2.4 cv=X8FSKHTe c=1 sm=1 tr=0 ts=6837a14c cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=dt9VzEwgFbYA:10 a=EUspDBNiAAAA:8 a=4OMqYXV_ruVW7JoEK48A:9
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTI4MDIxMCBTYWx0ZWRfX4vZDqfXfGLWZ
 9TtX2AVexQ0zwE79x3aV+Ro+CBHhlpOgUxbyKzW4u9vGWK37gizkE5PZAH78or06Dm2JfT3CFtM
 ViLafBWLMx6o+KLOsEBYMTTJZ9f5EIU3T/gFI7EQ4Rlmfwul1lAi0VUFJf1IKik+l9ErmFYinbG
 ScPEpuZMGm1VMMFkesyhRG25nfsvcGUy+B3Ez9kr473dvwa7bvn0lPOT1aCGJhyFq7opDWA5PG8
 hPFY1MDd/nxvKJTjiixk7YfS0X/OmK+1thSPHJTNviV3gp7SNfoqxvZ2IdU8tpn783iAwiAHstQ
 bgFaLrVhE08mT/68qhe09792zUzZjdiE4LaYLAOz/7O2IliPH1eKNeNWCIb3sAm002mRuWAv8QU
 dPLY5kRflgS/tHtsCGCgOvzmHkjcEz3mUva2YP77+qyY0HyYfwaNktCmdWaMlxU6sdLsfgXk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-28_11,2025-05-27_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 phishscore=0 bulkscore=0 mlxlogscore=999
 mlxscore=0 clxscore=1015 priorityscore=1501 spamscore=0 adultscore=0
 malwarescore=0 lowpriorityscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505160000 definitions=main-2505280210

Add support for TEMP_ALARM GEN2 PMIC peripherals with digital major
revision 2.  This revision utilizes individual temp DAC registers
to set the threshold temperature for over-temperature stages 1 (warning),
2 (system shutdown), and 3 (emergency shutdown) instead of a single
register to specify a set of thresholds.

Signed-off-by: David Collins <david.collins@oss.qualcomm.com>
Signed-off-by: Anjelique Melendez <anjelique.melendez@oss.qualcomm.com>
---
 drivers/thermal/qcom/qcom-spmi-temp-alarm.c | 140 ++++++++++++++++++++
 1 file changed, 140 insertions(+)

diff --git a/drivers/thermal/qcom/qcom-spmi-temp-alarm.c b/drivers/thermal/qcom/qcom-spmi-temp-alarm.c
index 59a25f02a278..29ec6445fc21 100644
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
@@ -65,6 +70,25 @@ static const long temp_map_gen2_v1[THRESH_COUNT][STAGE_COUNT] = {
 
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
 
@@ -73,6 +97,7 @@ struct qpnp_tm_chip;
 struct spmi_temp_alarm_data {
 	const struct thermal_zone_device_ops *ops;
 	const long (*temp_map)[THRESH_COUNT][STAGE_COUNT];
+	int (*setup)(struct qpnp_tm_chip *chip);
 	int (*get_temp_stage)(struct qpnp_tm_chip *chip);
 	int (*configure_trip_temps)(struct qpnp_tm_chip *chip);
 };
@@ -87,6 +112,7 @@ struct qpnp_tm_chip {
 	unsigned int			thresh;
 	unsigned int			stage;
 	unsigned int			base;
+	unsigned int			ntrips;
 	/* protects .thresh, .stage and chip registers */
 	struct mutex			lock;
 	bool				initialized;
@@ -304,6 +330,54 @@ static const struct thermal_zone_device_ops qpnp_tm_sensor_ops = {
 	.set_trip_temp = qpnp_tm_set_trip_temp,
 };
 
+static int qpnp_tm_gen2_rev2_set_temp_thresh(struct qpnp_tm_chip *chip, int trip, int temp)
+{
+	int ret, temp_cfg;
+	u8 reg;
+
+	WARN_ON(!mutex_is_locked(&chip->lock));
+
+	if (trip < 0 || trip >= STAGE_COUNT) {
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
@@ -328,6 +402,60 @@ static int qpnp_tm_configure_trip_temp(struct qpnp_tm_chip *chip)
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
+static int qpnp_tm_gen2_rev2_setup(struct qpnp_tm_chip *chip)
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
@@ -349,6 +477,13 @@ static const struct spmi_temp_alarm_data spmi_temp_alarm_gen2_rev1_data = {
 	.get_temp_stage = qpnp_tm_gen2_get_temp_stage,
 };
 
+static const struct spmi_temp_alarm_data spmi_temp_alarm_gen2_rev2_data = {
+	.ops = &qpnp_tm_gen2_rev2_sensor_ops,
+	.setup = qpnp_tm_gen2_rev2_setup,
+	.configure_trip_temps = qpnp_tm_gen2_rev2_configure_trip_temps,
+	.get_temp_stage = qpnp_tm_gen2_get_temp_stage,
+};
+
 /*
  * This function initializes the internal temp value based on only the
  * current thermal stage and threshold. Setup threshold control and
@@ -467,6 +602,8 @@ static int qpnp_tm_probe(struct platform_device *pdev)
 	chip->subtype = subtype;
 	if (subtype == QPNP_TM_SUBTYPE_GEN1)
 		chip->data = &spmi_temp_alarm_data;
+	else if (subtype == QPNP_TM_SUBTYPE_GEN2 && dig_major >= 2)
+		chip->data = &spmi_temp_alarm_gen2_rev2_data;
 	else if (subtype == QPNP_TM_SUBTYPE_GEN2 && dig_major >= 1)
 		chip->data = &spmi_temp_alarm_gen2_rev1_data;
 	else if (subtype == QPNP_TM_SUBTYPE_GEN2)
@@ -491,6 +628,9 @@ static int qpnp_tm_probe(struct platform_device *pdev)
 		}
 	}
 
+	if (chip->data->setup)
+		chip->data->setup(chip);
+
 	/*
 	 * Register the sensor before initializing the hardware to be able to
 	 * read the trip points. get_temp() returns the default temperature
-- 
2.34.1


