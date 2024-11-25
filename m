Return-Path: <linux-pm+bounces-18016-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 064FD9D7AE6
	for <lists+linux-pm@lfdr.de>; Mon, 25 Nov 2024 06:08:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BBE15281FC4
	for <lists+linux-pm@lfdr.de>; Mon, 25 Nov 2024 05:08:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F406F1531DC;
	Mon, 25 Nov 2024 05:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="HM2kGpMc"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2278014F9D9;
	Mon, 25 Nov 2024 05:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732511304; cv=none; b=aIqZFwdnN8aj4MIUKWyJ/EAE0bkKhPMwp56CBeN6k/NFSosEVXObodNV6ORZq48QSMZbdzBzK9nNJ43l9ooHYtndntsvRMnMIlAprXi7cPufZFMm4tmihwn3jzYn5AOqO/GK/qQUvWaho3+wBr55IvT3rFWwRdQceHt5cwiMOwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732511304; c=relaxed/simple;
	bh=f7ZO31bml7UmbTDWrDyhlhgBd8y9Q4XYoJjjo8lhP+8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jxfv7XRzBR0/dgn8LeAK/xW21aow9oMp2dYzR+tMf/cTyfgOuwBOIumyIG1zU62PmupqaFy7dxA2fcPVMP1yhcsgfaye6dB6Pokophq0epfJuvt2UiWYPiHjFX5B2CFnWIu7lVddbxTf0Dp2gimjV6oTvDe3Q0yUqo9UV1Rcq0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=HM2kGpMc; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AOMaXOq021290;
	Mon, 25 Nov 2024 05:08:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	cKNwfftnrb+XITN+CMwEFX8m2I1ToBKvQgKF60Duc90=; b=HM2kGpMcbZhea7lh
	sGsm8Gx+NN3Hq+bzOxxmOiDei+PHHE/ZGxaRqVyU0Q35AWnaVzQ1zmZRFwLovKGl
	cbA8MZwZnjlw+BEwPZjaNveXQf63eudCufu8xfSsCoAADldPII8Db2jN7WT5Kjeu
	VhP04N0fCUJbUp+lxK5I1m5wah/DRpiX5t/KpolDDlj76M7lUfFs2q83L0SR4GYO
	r/oRNlKMq+mwcO+PVctCjvFB2iekny97xvyXJecaWe7VMeP1irWDLrH/nJZlXfRg
	tZlmU/XgsS2nd/LVjH82LJ0WumYR1T6oMxXkXlhdGE7RetwTVJgj312ypPVHnB8B
	ABr6vg==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4337tjbb2r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 25 Nov 2024 05:08:13 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4AP58CfD004747
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 25 Nov 2024 05:08:12 GMT
Received: from hu-mmanikan-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Sun, 24 Nov 2024 21:08:07 -0800
From: Manikanta Mylavarapu <quic_mmanikan@quicinc.com>
To: <srinivas.kandagatla@linaro.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <amitk@kernel.org>, <thara.gopinath@gmail.com>,
        <rafael@kernel.org>, <daniel.lezcano@linaro.org>,
        <rui.zhang@intel.com>, <lukasz.luba@arm.com>, <andersson@kernel.org>,
        <konradybcio@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-pm@vger.kernel.org>
CC: <quic_srichara@quicinc.com>, <quic_varada@quicinc.com>
Subject: [PATCH v9 3/7] thermal/drivers/tsens: Add TSENS enable and calibration support for V2
Date: Mon, 25 Nov 2024 10:37:24 +0530
Message-ID: <20241125050728.3699241-4-quic_mmanikan@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241125050728.3699241-1-quic_mmanikan@quicinc.com>
References: <20241125050728.3699241-1-quic_mmanikan@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: hU_53BWO4M_vjmYIQC4EHzqi7smE4LBi
X-Proofpoint-ORIG-GUID: hU_53BWO4M_vjmYIQC4EHzqi7smE4LBi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 clxscore=1015
 impostorscore=0 priorityscore=1501 suspectscore=0 phishscore=0 spamscore=0
 bulkscore=0 mlxlogscore=999 adultscore=0 mlxscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2409260000
 definitions=main-2411250041

From: Praveenkumar I <quic_ipkumar@quicinc.com>

SoCs without RPM need to enable sensors and calibrate them from the kernel.
The IPQ5332 and IPQ5424 use the tsens v2.3.3 IP and do not have RPM.
Therefore, add a new calibration function for V2, as the tsens.c calib
function only supports V1. Also add new feature_config, ops and data for
IPQ5332, IPQ5424.

Although the TSENS IP supports 16 sensors, not all are used. The hw_id
is used to enable the relevant sensors.

Signed-off-by: Praveenkumar I <quic_ipkumar@quicinc.com>
Signed-off-by: Manikanta Mylavarapu <quic_mmanikan@quicinc.com>
---
Changes in V9:
	- Update variable declaration order in tsens_v2_calibrate_sensor()
	- Replace tab with space during the 'val' computation in the
	  tsens_v2_calibrate_sensor()
	- Update 'RSEULT_FORMAT_TEMP' to 'RESULT_FORMAT_TEMP'

 drivers/thermal/qcom/tsens-v2.c | 178 ++++++++++++++++++++++++++++++++
 drivers/thermal/qcom/tsens.c    |   8 +-
 drivers/thermal/qcom/tsens.h    |   4 +-
 3 files changed, 188 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/qcom/tsens-v2.c b/drivers/thermal/qcom/tsens-v2.c
index 0cb7301eca6e..836155fa9ab2 100644
--- a/drivers/thermal/qcom/tsens-v2.c
+++ b/drivers/thermal/qcom/tsens-v2.c
@@ -4,13 +4,32 @@
  * Copyright (c) 2018, Linaro Limited
  */
 
+#include <linux/bitfield.h>
 #include <linux/bitops.h>
 #include <linux/regmap.h>
+#include <linux/nvmem-consumer.h>
 #include "tsens.h"
 
 /* ----- SROT ------ */
 #define SROT_HW_VER_OFF	0x0000
 #define SROT_CTRL_OFF		0x0004
+#define SROT_MEASURE_PERIOD	0x0008
+#define SROT_Sn_CONVERSION	0x0060
+#define V2_SHIFT_DEFAULT	0x0003
+#define V2_SLOPE_DEFAULT	0x0cd0
+#define V2_CZERO_DEFAULT	0x016a
+#define ONE_PT_SLOPE		0x0cd0
+#define TWO_PT_SHIFTED_GAIN	921600
+#define ONE_PT_CZERO_CONST	94
+#define SW_RST_DEASSERT		0x0
+#define SW_RST_ASSERT		0x1
+#define MEASURE_PERIOD_2mSEC	0x1
+#define RESULT_FORMAT_TEMP	0x1
+#define TSENS_ENABLE		0x1
+#define SENSOR_CONVERSION(n)	(((n) * 4) + SROT_Sn_CONVERSION)
+#define CONVERSION_SHIFT_MASK	GENMASK(24, 23)
+#define CONVERSION_SLOPE_MASK	GENMASK(22, 10)
+#define CONVERSION_CZERO_MASK	GENMASK(9, 0)
 
 /* ----- TM ------ */
 #define TM_INT_EN_OFF			0x0004
@@ -50,6 +69,17 @@ static struct tsens_features ipq8074_feat = {
 	.trip_max_temp	= 204000,
 };
 
+static struct tsens_features ipq5332_feat = {
+	.ver_major	= VER_2_X_NO_RPM,
+	.crit_int	= 1,
+	.combo_int	= 1,
+	.adc		= 0,
+	.srot_split	= 1,
+	.max_sensors	= 16,
+	.trip_min_temp	= 0,
+	.trip_max_temp	= 204000,
+};
+
 static const struct reg_field tsens_v2_regfields[MAX_REGFIELDS] = {
 	/* ----- SROT ------ */
 	/* VERSION */
@@ -59,6 +89,10 @@ static const struct reg_field tsens_v2_regfields[MAX_REGFIELDS] = {
 	/* CTRL_OFF */
 	[TSENS_EN]     = REG_FIELD(SROT_CTRL_OFF,    0,  0),
 	[TSENS_SW_RST] = REG_FIELD(SROT_CTRL_OFF,    1,  1),
+	[SENSOR_EN]    = REG_FIELD(SROT_CTRL_OFF,    3,  18),
+	[CODE_OR_TEMP] = REG_FIELD(SROT_CTRL_OFF,    21, 21),
+
+	[MAIN_MEASURE_PERIOD] = REG_FIELD(SROT_MEASURE_PERIOD, 0, 7),
 
 	/* ----- TM ------ */
 	/* INTERRUPT ENABLE */
@@ -104,6 +138,128 @@ static const struct reg_field tsens_v2_regfields[MAX_REGFIELDS] = {
 	[TRDY] = REG_FIELD(TM_TRDY_OFF, 0, 0),
 };
 
+static int tsens_v2_calibrate_sensor(struct device *dev, struct tsens_sensor *sensor,
+				     struct regmap *map,  u32 mode, u32 base0, u32 base1)
+{
+	u32	shift = V2_SHIFT_DEFAULT;
+	u32	slope = V2_SLOPE_DEFAULT;
+	u32	czero = V2_CZERO_DEFAULT;
+	char	name[20];
+	u32	val;
+	int	ret;
+
+	/* Read offset value */
+	ret = snprintf(name, sizeof(name), "tsens_sens%d_off", sensor->hw_id);
+	if (ret < 0)
+		return ret;
+
+	ret = nvmem_cell_read_variable_le_u32(dev, name, &sensor->offset);
+	if (ret)
+		return ret;
+
+	/* Based on calib mode, program SHIFT, SLOPE and CZERO */
+	switch (mode) {
+	case TWO_PT_CALIB:
+		slope = (TWO_PT_SHIFTED_GAIN / (base1 - base0));
+
+		czero = (base0 + sensor->offset - ((base1 - base0) / 3));
+
+		break;
+	case ONE_PT_CALIB2:
+		czero = base0 + sensor->offset - ONE_PT_CZERO_CONST;
+
+		slope = ONE_PT_SLOPE;
+
+		break;
+	default:
+		dev_dbg(dev, "calibrationless mode\n");
+	}
+
+	val = FIELD_PREP(CONVERSION_SHIFT_MASK, shift) |
+	      FIELD_PREP(CONVERSION_SLOPE_MASK, slope) |
+	      FIELD_PREP(CONVERSION_CZERO_MASK, czero);
+
+	regmap_write(map, SENSOR_CONVERSION(sensor->hw_id), val);
+
+	return 0;
+}
+
+static int tsens_v2_calibration(struct tsens_priv *priv)
+{
+	struct device *dev = priv->dev;
+	u32 mode, base0, base1;
+	int i, ret;
+
+	if (priv->num_sensors > MAX_SENSORS)
+		return -EINVAL;
+
+	ret = nvmem_cell_read_variable_le_u32(priv->dev, "mode", &mode);
+	if (ret == -ENOENT)
+		dev_warn(priv->dev, "Calibration data not present in DT\n");
+	if (ret < 0)
+		return ret;
+
+	dev_dbg(priv->dev, "calibration mode is %d\n", mode);
+
+	ret = nvmem_cell_read_variable_le_u32(priv->dev, "base0", &base0);
+	if (ret < 0)
+		return ret;
+
+	ret = nvmem_cell_read_variable_le_u32(priv->dev, "base1", &base1);
+	if (ret < 0)
+		return ret;
+
+	/* Calibrate each sensor */
+	for (i = 0; i < priv->num_sensors; i++) {
+		ret = tsens_v2_calibrate_sensor(dev, &priv->sensor[i], priv->srot_map,
+						mode, base0, base1);
+		if (ret < 0)
+			return ret;
+	}
+
+	return 0;
+}
+
+static int __init init_tsens_v2_no_rpm(struct tsens_priv *priv)
+{
+	struct device *dev = priv->dev;
+	int i, ret;
+	u32 val = 0;
+
+	ret = init_common(priv);
+	if (ret < 0)
+		return ret;
+
+	priv->rf[CODE_OR_TEMP] = devm_regmap_field_alloc(dev, priv->srot_map,
+							 priv->fields[CODE_OR_TEMP]);
+	if (IS_ERR(priv->rf[CODE_OR_TEMP]))
+		return PTR_ERR(priv->rf[CODE_OR_TEMP]);
+
+	priv->rf[MAIN_MEASURE_PERIOD] = devm_regmap_field_alloc(dev, priv->srot_map,
+								priv->fields[MAIN_MEASURE_PERIOD]);
+	if (IS_ERR(priv->rf[MAIN_MEASURE_PERIOD]))
+		return PTR_ERR(priv->rf[MAIN_MEASURE_PERIOD]);
+
+	regmap_field_write(priv->rf[TSENS_SW_RST], SW_RST_ASSERT);
+
+	regmap_field_write(priv->rf[MAIN_MEASURE_PERIOD], MEASURE_PERIOD_2mSEC);
+
+	/* Enable available sensors */
+	for (i = 0; i < priv->num_sensors; i++)
+		val |= 1 << priv->sensor[i].hw_id;
+
+	regmap_field_write(priv->rf[SENSOR_EN], val);
+
+	/* Select temperature format, unit is deci-Celsius */
+	regmap_field_write(priv->rf[CODE_OR_TEMP], RESULT_FORMAT_TEMP);
+
+	regmap_field_write(priv->rf[TSENS_SW_RST], SW_RST_DEASSERT);
+
+	regmap_field_write(priv->rf[TSENS_EN], TSENS_ENABLE);
+
+	return 0;
+}
+
 static const struct tsens_ops ops_generic_v2 = {
 	.init		= init_common,
 	.get_temp	= get_temp_tsens_valid,
@@ -122,6 +278,28 @@ struct tsens_plat_data data_ipq8074 = {
 	.fields	= tsens_v2_regfields,
 };
 
+static const struct tsens_ops ops_ipq5332 = {
+	.init		= init_tsens_v2_no_rpm,
+	.get_temp	= get_temp_tsens_valid,
+	.calibrate	= tsens_v2_calibration,
+};
+
+struct tsens_plat_data data_ipq5332 = {
+	.num_sensors	= 5,
+	.ops		= &ops_ipq5332,
+	.hw_ids		= (unsigned int []){11, 12, 13, 14, 15},
+	.feat		= &ipq5332_feat,
+	.fields		= tsens_v2_regfields,
+};
+
+struct tsens_plat_data data_ipq5424 = {
+	.num_sensors	= 7,
+	.ops		= &ops_ipq5332,
+	.hw_ids		= (unsigned int []){9, 10, 11, 12, 13, 14, 15},
+	.feat		= &ipq5332_feat,
+	.fields		= tsens_v2_regfields,
+};
+
 /* Kept around for backward compatibility with old msm8996.dtsi */
 struct tsens_plat_data data_8996 = {
 	.num_sensors	= 13,
diff --git a/drivers/thermal/qcom/tsens.c b/drivers/thermal/qcom/tsens.c
index 3aa3736181aa..1f5d4de017d9 100644
--- a/drivers/thermal/qcom/tsens.c
+++ b/drivers/thermal/qcom/tsens.c
@@ -975,7 +975,7 @@ int __init init_common(struct tsens_priv *priv)
 	ret = regmap_field_read(priv->rf[TSENS_EN], &enabled);
 	if (ret)
 		goto err_put_device;
-	if (!enabled) {
+	if (!enabled && (tsens_version(priv) != VER_2_X_NO_RPM)) {
 		dev_err(dev, "%s: device not enabled\n", __func__);
 		ret = -ENODEV;
 		goto err_put_device;
@@ -1102,6 +1102,12 @@ static SIMPLE_DEV_PM_OPS(tsens_pm_ops, tsens_suspend, tsens_resume);
 
 static const struct of_device_id tsens_table[] = {
 	{
+		.compatible = "qcom,ipq5332-tsens",
+		.data = &data_ipq5332,
+	}, {
+		.compatible = "qcom,ipq5424-tsens",
+		.data = &data_ipq5424,
+	}, {
 		.compatible = "qcom,ipq8064-tsens",
 		.data = &data_8960,
 	}, {
diff --git a/drivers/thermal/qcom/tsens.h b/drivers/thermal/qcom/tsens.h
index 7b36a0318fa6..dcc3100cd449 100644
--- a/drivers/thermal/qcom/tsens.h
+++ b/drivers/thermal/qcom/tsens.h
@@ -35,6 +35,7 @@ enum tsens_ver {
 	VER_0_1,
 	VER_1_X,
 	VER_2_X,
+	VER_2_X_NO_RPM,
 };
 
 enum tsens_irq_type {
@@ -168,6 +169,7 @@ enum regfield_ids {
 	TSENS_SW_RST,
 	SENSOR_EN,
 	CODE_OR_TEMP,
+	MAIN_MEASURE_PERIOD,
 
 	/* ----- TM ------ */
 	/* TRDY */
@@ -650,6 +652,6 @@ extern struct tsens_plat_data data_8226, data_8909, data_8916, data_8939, data_8
 extern struct tsens_plat_data data_tsens_v1, data_8937, data_8976, data_8956;
 
 /* TSENS v2 targets */
-extern struct tsens_plat_data data_8996, data_ipq8074, data_tsens_v2;
+extern struct tsens_plat_data data_8996, data_ipq8074, data_ipq5332, data_ipq5424, data_tsens_v2;
 
 #endif /* __QCOM_TSENS_H__ */
-- 
2.34.1


