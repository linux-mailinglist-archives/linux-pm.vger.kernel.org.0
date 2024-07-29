Return-Path: <linux-pm+bounces-11610-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F47594019D
	for <lists+linux-pm@lfdr.de>; Tue, 30 Jul 2024 01:14:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA40D282EA9
	for <lists+linux-pm@lfdr.de>; Mon, 29 Jul 2024 23:14:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A48C218FDC1;
	Mon, 29 Jul 2024 23:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Kzlbxr4e"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6DD218FC69;
	Mon, 29 Jul 2024 23:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722294850; cv=none; b=g8BVXj1zlDHCKXd2Llv20+cLrg72r2AcEJTUJhFHX5U3P28tS9sKO4JxMItTUQWjGWk2X3/oA/tzE/FjvyKkeaSOi25TAFr7OTV3bARhsMfgir0/bKA/YGVUGnct/TdhRGD/8MUz3MBkLp372NrFZZy5c/lXhlUG3z0my4FYqjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722294850; c=relaxed/simple;
	bh=Mfl/sV2elv7ZOqxW9kta3kF3BbYvI6Ppwd21/ixsrWo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dkvI0+QC3gefEFT++zSIfzMVjMUkZB/p0dxkCS6dw1HUGBZ1dWS0V4V+lANLwUWRg5M+Cnblea0keBwCEJfxEiJgQHqEhJmMnh2xVmkLfcUtsE4ntsmJ0INgIeDq5q76iBo61wq/TKZU2wHlGxcHq0A3ASILbHoy3qs2i01cJz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Kzlbxr4e; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46TAKbc8025085;
	Mon, 29 Jul 2024 23:13:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	kWesF7FAalr/9LdJShzdkkxYXTgyb7tEHpMSFNhy1Ws=; b=Kzlbxr4eDnGBoFb2
	ziZkD0sflfwMpLzo5E3ySdGIr9bX5SsQLdv1TL+HvYmvccZTMLTVwCRYRdhPAwI9
	9sW5FE3V/MMV9mahaIT2qYfse3KTsynrabBofu5WIhdCaDFFICZv04Nrhd6pJVTF
	vx3jE/bNV/vJQCWANC929zbnnJNqWHnWtIE/BngCe/5GBkKhZnCftVBq8ybMY1oX
	OL32b8UmR9b71fV6U7J4q2kyyDqIaEaM095yCnnSuUkqNoUXao9rtj30am3+Ymse
	brIvidCIFXLyXnV4W5FADn1UbfgdOaT0hDnaDxf+NwbeAyyElhEO2IcDozrkQ+MX
	4729fQ==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 40mt2kndc7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 29 Jul 2024 23:13:44 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 46TNDhNc019003
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 29 Jul 2024 23:13:43 GMT
Received: from hu-amelende-lv.qualcomm.com (10.49.16.6) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Mon, 29 Jul 2024 16:13:43 -0700
From: Anjelique Melendez <quic_amelende@quicinc.com>
To: <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <amitk@kernel.org>, <thara.gopinath@gmail.com>, <andersson@kernel.org>
CC: <quic_collinsd@quicinc.com>, <rafael@kernel.org>,
        <daniel.lezcano@linaro.org>, <rui.zhang@intel.com>,
        <lukasz.luba@arm.com>, <linux-arm-msm@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        "Anjelique
 Melendez" <quic_amelende@quicinc.com>
Subject: [PATCH 4/5] thermal: qcom-spmi-temp-alarm: add support for GEN2 rev 2 PMIC peripherals
Date: Mon, 29 Jul 2024 16:12:58 -0700
Message-ID: <20240729231259.2122976-5-quic_amelende@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240729231259.2122976-1-quic_amelende@quicinc.com>
References: <20240729231259.2122976-1-quic_amelende@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: VSQdrgiQzr7hzrmKOC_Loe9AuBzdu74s
X-Proofpoint-GUID: VSQdrgiQzr7hzrmKOC_Loe9AuBzdu74s
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-29_20,2024-07-26_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxlogscore=999
 malwarescore=0 spamscore=0 adultscore=0 mlxscore=0 lowpriorityscore=0
 suspectscore=0 priorityscore=1501 impostorscore=0 bulkscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2407290159

Add support for TEMP_ALARM GEN2 PMIC peripherals with digital major
revision 2.  This revision utilizes individual temp DAC registers
to set the threshold temperature for over-temperature stages 1,
2, and 3 instead of a single register to specify a set of
thresholds.

Co-developed-by: David Collins <quic_collinsd@quicinc.com>
Signed-off-by: David Collins <quic_collinsd@quicinc.com>
Signed-off-by: Anjelique Melendez <quic_amelende@quicinc.com>
---
 drivers/thermal/qcom/qcom-spmi-temp-alarm.c | 195 ++++++++++++++++++--
 1 file changed, 184 insertions(+), 11 deletions(-)

diff --git a/drivers/thermal/qcom/qcom-spmi-temp-alarm.c b/drivers/thermal/qcom/qcom-spmi-temp-alarm.c
index de4a2d99f0d5..1f56acd8f637 100644
--- a/drivers/thermal/qcom/qcom-spmi-temp-alarm.c
+++ b/drivers/thermal/qcom/qcom-spmi-temp-alarm.c
@@ -24,6 +24,10 @@
 #define QPNP_TM_REG_STATUS		0x08
 #define QPNP_TM_REG_SHUTDOWN_CTRL1	0x40
 #define QPNP_TM_REG_ALARM_CTRL		0x46
+/* TEMP_DAC_* registers are only present for TEMP_GEN2 v2.0 */
+#define QPNP_TM_REG_TEMP_DAC_STG1	0x47
+#define QPNP_TM_REG_TEMP_DAC_STG2	0x48
+#define QPNP_TM_REG_TEMP_DAC_STG3	0x49
 
 #define QPNP_TM_TYPE			0x09
 #define QPNP_TM_SUBTYPE_GEN1		0x08
@@ -65,13 +69,42 @@ static const long temp_map_gen2_v1[THRESH_COUNT][STAGE_COUNT] = {
 
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
 
+struct qpnp_tm_chip;
+
+struct spmi_temp_alarm_data {
+	const struct thermal_zone_device_ops *ops;
+	bool				has_temp_dac;
+	int (*setup)(struct qpnp_tm_chip *chip);
+	int (*update_trip_temps)(struct qpnp_tm_chip *chip);
+};
+
 struct qpnp_tm_chip {
 	struct regmap			*map;
 	struct device			*dev;
 	struct thermal_zone_device	*tz_dev;
+	const struct spmi_temp_alarm_data *data;
 	unsigned int			subtype;
 	unsigned int			dig_revision;
 	long				temp;
@@ -85,6 +118,8 @@ struct qpnp_tm_chip {
 
 	struct iio_channel		*adc;
 	const long			(*temp_map)[THRESH_COUNT][STAGE_COUNT];
+
+	long				temp_dac_map[STAGE_COUNT];
 };
 
 /* This array maps from GEN2 alarm state to GEN1 alarm stage */
@@ -118,6 +153,13 @@ static int qpnp_tm_write(struct qpnp_tm_chip *chip, u16 addr, u8 data)
  */
 static long qpnp_tm_decode_temp(struct qpnp_tm_chip *chip, unsigned int stage)
 {
+	if (chip->data->has_temp_dac) {
+		if (stage == 0 || stage > STAGE_COUNT)
+			return 0;
+
+		return chip->temp_dac_map[stage - 1];
+	}
+
 	if (!chip->temp_map || chip->thresh >= THRESH_COUNT || stage == 0 ||
 	    stage > STAGE_COUNT)
 		return 0;
@@ -219,6 +261,34 @@ static int qpnp_tm_get_temp(struct thermal_zone_device *tz, int *temp)
 	return 0;
 }
 
+static int qpnp_tm_gen2_rev2_set_temp_thresh(struct qpnp_tm_chip *chip, int trip,
+				       int temp)
+{
+	int ret, temp_cfg;
+	u8 reg;
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
+	chip->temp_dac_map[trip] = temp_cfg;
+
+	return 0;
+}
+
 static int qpnp_tm_update_critical_trip_temp(struct qpnp_tm_chip *chip,
 					     int temp)
 {
@@ -286,6 +356,24 @@ static const struct thermal_zone_device_ops qpnp_tm_sensor_ops = {
 	.set_trip_temp = qpnp_tm_set_trip_temp,
 };
 
+static int qpnp_tm_gen2_rev2_set_trip_temp(struct thermal_zone_device *tz,
+					  int trip, int temp)
+{
+	struct qpnp_tm_chip *chip = tz->devdata;
+	int ret;
+
+	mutex_lock(&chip->lock);
+	ret = qpnp_tm_gen2_rev2_set_temp_thresh(chip, trip, temp);
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
@@ -313,6 +401,71 @@ static int qpnp_tm_get_critical_trip_temp(struct qpnp_tm_chip *chip)
 	return THERMAL_TEMP_INVALID;
 }
 
+/* Configure TEMP_DAC registers based on DT thermal_zone trips */
+static int qpnp_tm_gen2_rev2_update_trip_temps(struct qpnp_tm_chip *chip)
+{
+	struct thermal_trip trip = {0};
+	int ret, ntrips, i;
+
+	ntrips = thermal_zone_get_num_trips(chip->tz_dev);
+	/* Keep hardware defaults if no DT trips are defined. */
+	if (ntrips <= 0)
+		return 0;
+
+	for (i = 0; i < ntrips; i++) {
+		ret = thermal_zone_get_trip(chip->tz_dev, i, &trip);
+		if (ret < 0)
+			return ret;
+
+		ret = qpnp_tm_gen2_rev2_set_temp_thresh(chip, i, trip.temperature);
+		if (ret < 0)
+			return ret;
+	}
+
+	/* Verify that trips are strictly increasing. */
+	for (i = 1; i < STAGE_COUNT; i++) {
+		if (chip->temp_dac_map[i] <= chip->temp_dac_map[i - 1]) {
+			dev_err(chip->dev, "Threshold %d=%ld <= threshold %d=%ld\n",
+				i, chip->temp_dac_map[i], i - 1,
+				chip->temp_dac_map[i - 1]);
+			return -EINVAL;
+		}
+	}
+
+	return 0;
+}
+
+/* Read the hardware default TEMP_DAC stage threshold temperatures */
+static int qpnp_tm_gen2_rev2_init(struct qpnp_tm_chip *chip)
+{
+	int ret, i;
+	u8 reg = 0;
+
+	for (i = 0; i < STAGE_COUNT; i++) {
+		ret = qpnp_tm_read(chip, QPNP_TM_REG_TEMP_DAC_STG1 + i, &reg);
+		if (ret < 0)
+			return ret;
+
+		chip->temp_dac_map[i] = TEMP_DAC_REG_TO_TEMP(reg);
+	}
+
+	return 0;
+}
+
+static const struct spmi_temp_alarm_data spmi_temp_alarm_data = {
+	.ops = &qpnp_tm_sensor_ops,
+	.has_temp_dac = false,
+	.setup = NULL,
+	.update_trip_temps = NULL,
+};
+
+static const struct spmi_temp_alarm_data spmi_temp_alarm_gen2_rev2_data = {
+	.ops = &qpnp_tm_gen2_rev2_sensor_ops,
+	.has_temp_dac = true,
+	.setup = qpnp_tm_gen2_rev2_init,
+	.update_trip_temps = qpnp_tm_gen2_rev2_update_trip_temps,
+};
+
 /*
  * This function initializes the internal temp value based on only the
  * current thermal stage and threshold. Setup threshold control and
@@ -339,21 +492,27 @@ static int qpnp_tm_init(struct qpnp_tm_chip *chip)
 		goto out;
 	chip->stage = ret;
 
-	stage = chip->subtype == QPNP_TM_SUBTYPE_GEN1
+	stage = (chip->subtype == QPNP_TM_SUBTYPE_GEN1)
 		? chip->stage : alarm_state_map[chip->stage];
 
 	if (stage)
 		chip->temp = qpnp_tm_decode_temp(chip, stage);
 
-	mutex_unlock(&chip->lock);
+	if (chip->data->update_trip_temps) {
+		ret = chip->data->update_trip_temps(chip);
+		if (ret < 0)
+			goto out;
+	} else {
+		mutex_unlock(&chip->lock);
 
-	crit_temp = qpnp_tm_get_critical_trip_temp(chip);
+		crit_temp = qpnp_tm_get_critical_trip_temp(chip);
 
-	mutex_lock(&chip->lock);
+		mutex_lock(&chip->lock);
 
-	ret = qpnp_tm_update_critical_trip_temp(chip, crit_temp);
-	if (ret < 0)
-		goto out;
+		ret = qpnp_tm_update_critical_trip_temp(chip, crit_temp);
+		if (ret < 0)
+			goto out;
+	}
 
 	/* Enable the thermal alarm PMIC module in always-on mode. */
 	reg = ALARM_CTRL_FORCE_ENABLE;
@@ -380,6 +539,10 @@ static int qpnp_tm_probe(struct platform_device *pdev)
 	if (!chip)
 		return -ENOMEM;
 
+	chip->data = of_device_get_match_data(&pdev->dev);
+	if (!chip->data)
+		return -EINVAL;
+
 	dev_set_drvdata(&pdev->dev, chip);
 	chip->dev = &pdev->dev;
 
@@ -455,18 +618,21 @@ static int qpnp_tm_probe(struct platform_device *pdev)
 	}
 
 	chip->subtype = subtype;
-	if (subtype == QPNP_TM_SUBTYPE_GEN2 && dig_major >= 1)
+	if (subtype == QPNP_TM_SUBTYPE_GEN2 && dig_major == 1)
 		chip->temp_map = &temp_map_gen2_v1;
-	else
+	else if (subtype == QPNP_TM_SUBTYPE_GEN1)
 		chip->temp_map = &temp_map_gen1;
 
+	if (chip->data->setup)
+		chip->data->setup(chip);
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
@@ -488,7 +654,14 @@ static int qpnp_tm_probe(struct platform_device *pdev)
 }
 
 static const struct of_device_id qpnp_tm_match_table[] = {
-	{ .compatible = "qcom,spmi-temp-alarm" },
+	{
+		.compatible = "qcom,spmi-temp-alarm",
+		.data = &spmi_temp_alarm_data,
+	},
+	{
+		.compatible = "qcom,spmi-temp-alarm-gen2-rev2",
+		.data = &spmi_temp_alarm_gen2_rev2_data,
+	},
 	{ }
 };
 MODULE_DEVICE_TABLE(of, qpnp_tm_match_table);
-- 
2.34.1


