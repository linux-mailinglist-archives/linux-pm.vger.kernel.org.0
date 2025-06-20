Return-Path: <linux-pm+bounces-29116-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51CDAAE1058
	for <lists+linux-pm@lfdr.de>; Fri, 20 Jun 2025 02:20:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C1B454A1669
	for <lists+linux-pm@lfdr.de>; Fri, 20 Jun 2025 00:20:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AC2B79C0;
	Fri, 20 Jun 2025 00:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="B1x418cz"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEB7A224D7
	for <linux-pm@vger.kernel.org>; Fri, 20 Jun 2025 00:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750378771; cv=none; b=E0WjiMpXl7XtyMDP6DGm3x4zhBk1GkSeYyVsf1ZqW5FwB1XLyuDo7KTndPn+fxkxkWUSuwVpf9bjrr+DVfzWVJOA5e3qnSoikJGw0WJIQjJBeHO05xUo3/s+j80LvmWR1HXlv2nvp9574wsOcFk/lIWk/kUNDoNi6b2+cl8OZSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750378771; c=relaxed/simple;
	bh=pzdo6tQoIHPimPo2tPRlSVpfJ/45dsevy0rACzrOEKU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RWiTC3y61W+iSzA3tRS2E5wdPVQi6AUk82rTSVVHZ3lay3R1HVMQZHLWOzehEiK+BPDdjrTW8Oij+3e04QNOEUECfS5fUlEq5RqB3Jcz16UyfMu/YsZaF1m+UkzTFXRAaPIcLms04VguJJ14nSEh1k6K0WmscxwiRPDOLtp7ucQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=B1x418cz; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55JFfGnc003184
	for <linux-pm@vger.kernel.org>; Fri, 20 Jun 2025 00:19:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=Z6SbEMNz1or
	fQ/MzmtK0pbCD/N4EvDE2FmiULlhYxsU=; b=B1x418czm8QQhQhrghBaqg2T9H2
	SkOZO4KVDHyif8ZHNzRcjfjsufffYhC/sBG5XFmPKHCGbhFFSa0/ePxUVhhFAWP2
	l3Sto44tRX13qcllE/2Xs4RRCZ1Uv5v7ludq3gx4GW6RjQ/F2268SIW+Zy5vUSxL
	5y66Phwsb09kmuzIzTtHBgKzlJCW2wZF9PNgkzO7wKsvOlZru7xhKivg2CEGX6QP
	0O1dR/KtmKQdWnsdMLKU1ktQ1bfddducRzjr5/zHDuf740zdRbrD6zuhpB5fRRQr
	v/G+q3MV0Rmuv6lL2n3RggN5u/4uR96IjSJhWWz5Kr2LVFSVnXrALPVgRwQ==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47ag23dg4w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 20 Jun 2025 00:19:27 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-b3183193374so766623a12.1
        for <linux-pm@vger.kernel.org>; Thu, 19 Jun 2025 17:19:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750378766; x=1750983566;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z6SbEMNz1orfQ/MzmtK0pbCD/N4EvDE2FmiULlhYxsU=;
        b=CsAms7QhDERU+0bx9dKETDVgYR5xddvAJZVqy4U0jp/i6aApJpB+janYOVm2JCtQ3N
         mK+DcuscmEDelXEENPyOI2I/GjfiVeyPO5d3StH1QeGf8AosN7sXSJkpudhggVafyTC9
         cgbCMi+jOQAvLTqoF3xUJZOuAsAkiyCM1mYNCol3+6TswXtt1T1OWsdCB9xTaq7tWuJD
         tWNrd7BN0/9rmd61sF3pko/oSLVFNDit0om0BcBH2Na+z6SmQE5tdwbBjsv62i6OITUy
         dpwEe04cZyXHDucZO6BAxmlWrDSdD5rv9vdBiRzDZkhljV2/a6htT9om4+i+JoNVbeHJ
         CELA==
X-Forwarded-Encrypted: i=1; AJvYcCUtOgv5QFhoLZwK9AzsWVOD3uwq1KGwHROlYwAEYHGt0mbmODI1LDkdToBrk28c7ZeMYDgYUYu3aQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzvh52sI2GV1tLmXBB+un15sAJAZDTbFNsaJUZkNh0z9OYVRqBX
	HNYXcGHmsBubzNMqub2Ty5NZL57LkSWvx500SynrrUeqZThuZJ8pN2XXb0IX0LYntr5HEjmR7KJ
	dvH3UGII0pCdY3PhWy4i7hozrGbgLM+vLgiNKZE8y+xhY/K1UYgJfsCCX6cSHPQ==
X-Gm-Gg: ASbGncvMenBhchiryVpm5AA/kJzcnsYP9UNvXwTE6OKZpNlP3Ji33JwDwnT2HdA6V60
	BY1mLaqB6aFlTBDI1rJ1Q897oVdNt8SOi2leGzgKHhesxd0YcOCbeMaOBMX8nc/8dfWB70xSPjr
	yym9jNLZMcVLEE2QhpdASlvEPKzUytYIPRv7p7eiHudv+dFdrt0r6otCZRKHvSCK2bT2lWwlv+L
	OLsxVnPMT8Pe64sLKG2COr7ZM8fAwRg/8NvDdx+B1x3Gj+g0SG/GGNIfbcpmu00e9GbWKxwVdVi
	i3gmTj64v6kD6vCQPrsxPtu6+hNek5v1dPfIvr7LzLbYMwn/E61E/TnQ6jgRXWc3QBqF972JkDu
	iJOX9baW4PA==
X-Received: by 2002:a05:6a21:7a82:b0:21f:ff2d:aa03 with SMTP id adf61e73a8af0-22026ef77a8mr1040002637.33.1750378766229;
        Thu, 19 Jun 2025 17:19:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFfUUVjcJunIMPoNK0f+0az63DmOL1dGnN+uT5q0XzPCZjt5cp5a+9gyAuS+rD66equPP0egg==
X-Received: by 2002:a05:6a21:7a82:b0:21f:ff2d:aa03 with SMTP id adf61e73a8af0-22026ef77a8mr1039970637.33.1750378765779;
        Thu, 19 Jun 2025 17:19:25 -0700 (PDT)
Received: from hu-amelende-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b31f1258932sm410011a12.64.2025.06.19.17.19.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jun 2025 17:19:25 -0700 (PDT)
From: Anjelique Melendez <anjelique.melendez@oss.qualcomm.com>
To: amitk@kernel.org, thara.gopinath@gmail.com, rafael@kernel.org,
        daniel.lezcano@linaro.org
Cc: rui.zhang@intel.com, lukasz.luba@arm.com, david.collins@oss.qualcomm.com,
        stefan.schmidt@linaro.org, quic_tsoni@quicinc.com,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, dmitry.baryshkov@linaro.org,
        dmitry.baryshkov@oss.qualcomm.com
Subject: [PATCH v5 4/5] thermal: qcom-spmi-temp-alarm: add support for GEN2 rev 2 PMIC peripherals
Date: Thu, 19 Jun 2025 17:19:17 -0700
Message-Id: <20250620001918.4090853-5-anjelique.melendez@oss.qualcomm.com>
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
X-Proofpoint-ORIG-GUID: 3i65krlPYdbt9G10aKNs1gfgsTP0rYKQ
X-Authority-Analysis: v=2.4 cv=edY9f6EH c=1 sm=1 tr=0 ts=6854a90f cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=6IFa9wvqVegA:10 a=EUspDBNiAAAA:8 a=N9IR0GguogMVy2wE49AA:9
 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjIwMDAwMCBTYWx0ZWRfX/gSlP82FsJEF
 BF4fyjzDT107rCcwzjqbY+/QIjs8J24O7P3EeZmk0ew+gbvJXmpD1pNIF54AKr/NSrYs0ZzYLGK
 fiGEyi8eqplnd2J79gX3CnCL0InEinfglTjf0uzNwPnBHf+i0eQT+ip2YYS2Cxo0OUsSN1WfO6Z
 UZx28WYwwHUvtLQVEcKnZFMllipgGco8XBN1Ep3A3xVeeyrUbmndnaJ6IohQFNRlyFkHWIOLDtx
 wL+at6ZGNGd7d2nr496rFe3gP46S3itse/Wa6qFFCcU11ZQn7NhX7OOXbWFYxZKYCVyj1aDttUT
 GEbVklCdFThK3QnAj+RGhJ7M8ucMa3faAx+uJd0op40yMRvVojxALZapfG5d4y0W6SgXSwe+u+J
 Jtdq5T67ZFMWazxKfIEkk79vp0Vw9DtQ3/myZe0s0WUToqj4sx4Od9usUnakjPVFNdZvLxpA
X-Proofpoint-GUID: 3i65krlPYdbt9G10aKNs1gfgsTP0rYKQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-19_08,2025-06-18_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 suspectscore=0 spamscore=0 bulkscore=0
 impostorscore=0 mlxscore=0 clxscore=1015 mlxlogscore=999 malwarescore=0
 phishscore=0 adultscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506200000

Add support for TEMP_ALARM GEN2 PMIC peripherals with digital major
revision 2.  This revision utilizes individual temp DAC registers
to set the threshold temperature for over-temperature stages 1 (warning),
2 (system shutdown), and 3 (emergency shutdown) instead of a single
register to specify a set of thresholds.

Signed-off-by: David Collins <david.collins@oss.qualcomm.com>
Signed-off-by: Anjelique Melendez <anjelique.melendez@oss.qualcomm.com>
---
 drivers/thermal/qcom/qcom-spmi-temp-alarm.c | 136 ++++++++++++++++++++
 1 file changed, 136 insertions(+)

diff --git a/drivers/thermal/qcom/qcom-spmi-temp-alarm.c b/drivers/thermal/qcom/qcom-spmi-temp-alarm.c
index 5991067d3484..0e0b0a8b2367 100644
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
 
@@ -87,6 +111,7 @@ struct qpnp_tm_chip {
 	long				temp;
 	unsigned int			stage;
 	unsigned int			base;
+	unsigned int			ntrips;
 	/* protects .thresh, .stage and chip registers */
 	struct mutex			lock;
 	bool				initialized;
@@ -304,6 +329,54 @@ static const struct thermal_zone_device_ops qpnp_tm_sensor_ops = {
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
@@ -345,6 +418,60 @@ static int qpnp_tm_configure_trip_temp(struct qpnp_tm_chip *chip)
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
@@ -369,6 +496,13 @@ static const struct spmi_temp_alarm_data spmi_temp_alarm_gen2_rev1_data = {
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
  * This function intializes the internal temp value based on only the
  * current thermal stage and threshold.
@@ -486,6 +620,8 @@ static int qpnp_tm_probe(struct platform_device *pdev)
 	chip->subtype = subtype;
 	if (subtype == QPNP_TM_SUBTYPE_GEN1)
 		chip->data = &spmi_temp_alarm_data;
+	else if (subtype == QPNP_TM_SUBTYPE_GEN2 && dig_major >= 2)
+		chip->data = &spmi_temp_alarm_gen2_rev2_data;
 	else if (subtype == QPNP_TM_SUBTYPE_GEN2 && dig_major >= 1)
 		chip->data = &spmi_temp_alarm_gen2_rev1_data;
 	else if (subtype == QPNP_TM_SUBTYPE_GEN2)
-- 
2.34.1


