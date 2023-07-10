Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8706A74D3AF
	for <lists+linux-pm@lfdr.de>; Mon, 10 Jul 2023 12:38:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233386AbjGJKij (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 10 Jul 2023 06:38:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231919AbjGJKic (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 10 Jul 2023 06:38:32 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F45FF1;
        Mon, 10 Jul 2023 03:38:24 -0700 (PDT)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36A8iCUq000759;
        Mon, 10 Jul 2023 10:38:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=oyvSZCnrjiwfW283ewhhiGsaeUGlLsIHbf5b37AONNs=;
 b=HYgo3g9wZGh+HxdPlAQ6Ob68wO2XdLaJehYgKoVWjUTpnYYZzUDz7BR6fmk0KkCJ/9nw
 gMP/fro51otCMkzLKMkVqlgdqr5aNqaiEhW3ZTDiZuQDESuWYzByD6lp3KQGP2ef8kEw
 9d6AVmFPIMONaHm/tMh+5i4JcIhCm68MDyhewGj35A5GHtEOUuWLMR54XyHvIDJgFjXe
 NSuCmRK9XP7RaxrFBLMSjncjVrsJLZxWCcaOVP767Y+27PPwqla9iU4IBsQPgMqq4skb
 fcNzPNspzKlA7ZGZfE5sNm/SHW4Auid+l0AVh+yI+85Y1DeiCqoHOahfvah3tykj28me 2w== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rpyw1ua4d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 10 Jul 2023 10:38:18 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36AAc5qc013356
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 10 Jul 2023 10:38:05 GMT
Received: from hu-ipkumar-blr.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Mon, 10 Jul 2023 03:38:01 -0700
From:   Praveenkumar I <quic_ipkumar@quicinc.com>
To:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <amitk@kernel.org>,
        <thara.gopinath@gmail.com>, <rafael@kernel.org>,
        <daniel.lezcano@linaro.org>, <rui.zhang@intel.com>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <quic_varada@quicinc.com>
Subject: [PATCH 2/6] thermal/drivers/tsens: Add TSENS enable and calibration support for V2
Date:   Mon, 10 Jul 2023 16:07:31 +0530
Message-ID: <20230710103735.1375847-3-quic_ipkumar@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230710103735.1375847-1-quic_ipkumar@quicinc.com>
References: <20230710103735.1375847-1-quic_ipkumar@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 79QeMqjAxdI8INhqjXsabpLLg1tiLdt4
X-Proofpoint-ORIG-GUID: 79QeMqjAxdI8INhqjXsabpLLg1tiLdt4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-10_08,2023-07-06_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 priorityscore=1501 clxscore=1015 lowpriorityscore=0 adultscore=0
 phishscore=0 mlxlogscore=999 bulkscore=0 malwarescore=0 impostorscore=0
 mlxscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2307100096
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

SoCs without RPM have to enable sensors and calibrate from the kernel.
Though TSENS IP supports 16 sensors, not all are used. So added
sensors_to_en in tsens data help enable the relevant sensors.

Added new calibration function for V2 as the tsens.c calib function
only supports V1.

Signed-off-by: Praveenkumar I <quic_ipkumar@quicinc.com>
---
 drivers/thermal/qcom/tsens-v2.c | 116 ++++++++++++++++++++++++++++++++
 drivers/thermal/qcom/tsens.c    |  37 +++++++++-
 drivers/thermal/qcom/tsens.h    |  56 +++++++++++++++
 3 files changed, 208 insertions(+), 1 deletion(-)

diff --git a/drivers/thermal/qcom/tsens-v2.c b/drivers/thermal/qcom/tsens-v2.c
index 29a61d2d6ca3..db48b1d95348 100644
--- a/drivers/thermal/qcom/tsens-v2.c
+++ b/drivers/thermal/qcom/tsens-v2.c
@@ -6,11 +6,20 @@
 
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
 
 /* ----- TM ------ */
 #define TM_INT_EN_OFF			0x0004
@@ -59,6 +68,16 @@ static const struct reg_field tsens_v2_regfields[MAX_REGFIELDS] = {
 	/* CTRL_OFF */
 	[TSENS_EN]     = REG_FIELD(SROT_CTRL_OFF,    0,  0),
 	[TSENS_SW_RST] = REG_FIELD(SROT_CTRL_OFF,    1,  1),
+	[SENSOR_EN]    = REG_FIELD(SROT_CTRL_OFF,    3,  18),
+	[CODE_OR_TEMP] = REG_FIELD(SROT_CTRL_OFF,    21, 21),
+
+	/* MAIN_MEASURE_PERIOD */
+	[MAIN_MEASURE_PERIOD] = REG_FIELD(SROT_MEASURE_PERIOD, 0, 7),
+
+	/* Sn Conversion */
+	REG_FIELD_FOR_EACH_SENSOR16(SHIFT, SROT_Sn_CONVERSION, 23, 24),
+	REG_FIELD_FOR_EACH_SENSOR16(SLOPE, SROT_Sn_CONVERSION, 10, 22),
+	REG_FIELD_FOR_EACH_SENSOR16(CZERO, SROT_Sn_CONVERSION, 0, 9),
 
 	/* ----- TM ------ */
 	/* INTERRUPT ENABLE */
@@ -104,6 +123,103 @@ static const struct reg_field tsens_v2_regfields[MAX_REGFIELDS] = {
 	[TRDY] = REG_FIELD(TM_TRDY_OFF, 0, 0),
 };
 
+static int tsens_v2_calibration(struct tsens_priv *priv)
+{
+	struct device *dev = priv->dev;
+	u32 mode, base0, base1;
+	u32 slope, czero;
+	char name[15];
+	int i, j, ret;
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
+	/* Read offset values and allocate SHIFT, SLOPE & CZERO regmap for enabled sensors */
+	for (i = 0; i < priv->num_sensors; i++) {
+		if (!(priv->sensors_to_en & (0x1 << i)))
+			continue;
+
+		ret = snprintf(name, sizeof(name), "s%d_offset", priv->sensor[i].hw_id);
+		if (ret < 0)
+			return ret;
+
+		ret = nvmem_cell_read_variable_le_u32(priv->dev, name, &priv->sensor[i].offset);
+		if (ret)
+			return ret;
+
+		for (j = SHIFT_0; j <= CZERO_0; j++) {
+			int idx = (i * 3) + j;
+
+			priv->rf[idx] = devm_regmap_field_alloc(dev, priv->srot_map,
+								priv->fields[idx]);
+			if (IS_ERR(priv->rf[idx]))
+				return PTR_ERR(priv->rf[idx]);
+		}
+	}
+
+	/* Based on calib mode, program SHIFT, SLOPE and CZERO for enabled sensors */
+	switch (mode) {
+	case TWO_PT_CALIB:
+		slope = (TWO_PT_SHIFTED_GAIN / (base1 - base0));
+
+		for (i = 0; i < priv->num_sensors; i++) {
+			if (!(priv->sensors_to_en & (0x1 << i)))
+				continue;
+
+			int idx = i * 3;
+
+			czero = (base0 + priv->sensor[i].offset - ((base1 - base0) / 3));
+			regmap_field_write(priv->rf[SHIFT_0 + idx], V2_SHIFT_DEFAULT);
+			regmap_field_write(priv->rf[SLOPE_0 + idx], slope);
+			regmap_field_write(priv->rf[CZERO_0 + idx], czero);
+		}
+		fallthrough;
+	case ONE_PT_CALIB2:
+		for (i = 0; i < priv->num_sensors; i++) {
+			if (!(priv->sensors_to_en & (0x1 << i)))
+				continue;
+
+			int idx = i * 3;
+
+			czero = base0 + priv->sensor[i].offset - ONE_PT_CZERO_CONST;
+			regmap_field_write(priv->rf[SHIFT_0 + idx], V2_SHIFT_DEFAULT);
+			regmap_field_write(priv->rf[SLOPE_0 + idx], ONE_PT_SLOPE);
+			regmap_field_write(priv->rf[CZERO_0 + idx], czero);
+		}
+		break;
+	default:
+		dev_dbg(priv->dev, "calibrationless mode\n");
+		for (i = 0; i < priv->num_sensors; i++) {
+			if (!(priv->sensors_to_en & (0x1 << i)))
+				continue;
+
+			int idx = i * 3;
+
+			regmap_field_write(priv->rf[SHIFT_0 + idx], V2_SHIFT_DEFAULT);
+			regmap_field_write(priv->rf[SLOPE_0 + idx], V2_SLOPE_DEFAULT);
+			regmap_field_write(priv->rf[CZERO_0 + idx], V2_CZERO_DEFAULT);
+		}
+	}
+
+	return 0;
+}
+
 static const struct tsens_ops ops_generic_v2 = {
 	.init		= init_common,
 	.get_temp	= get_temp_tsens_valid,
diff --git a/drivers/thermal/qcom/tsens.c b/drivers/thermal/qcom/tsens.c
index 98c356acfe98..169690355dad 100644
--- a/drivers/thermal/qcom/tsens.c
+++ b/drivers/thermal/qcom/tsens.c
@@ -974,7 +974,7 @@ int __init init_common(struct tsens_priv *priv)
 	ret = regmap_field_read(priv->rf[TSENS_EN], &enabled);
 	if (ret)
 		goto err_put_device;
-	if (!enabled) {
+	if (!enabled && !priv->sensors_to_en) {
 		dev_err(dev, "%s: device not enabled\n", __func__);
 		ret = -ENODEV;
 		goto err_put_device;
@@ -1006,6 +1006,40 @@ int __init init_common(struct tsens_priv *priv)
 		goto err_put_device;
 	}
 
+	/* Do TSENS initialization if required */
+	if (priv->sensors_to_en) {
+		priv->rf[CODE_OR_TEMP] = devm_regmap_field_alloc(dev, priv->srot_map,
+								 priv->fields[CODE_OR_TEMP]);
+		if (IS_ERR(priv->rf[CODE_OR_TEMP])) {
+			ret = PTR_ERR(priv->rf[CODE_OR_TEMP]);
+			goto err_put_device;
+		}
+
+		priv->rf[MAIN_MEASURE_PERIOD] =
+			devm_regmap_field_alloc(dev, priv->srot_map,
+						priv->fields[MAIN_MEASURE_PERIOD]);
+		if (IS_ERR(priv->rf[MAIN_MEASURE_PERIOD])) {
+			ret = PTR_ERR(priv->rf[MAIN_MEASURE_PERIOD]);
+			goto err_put_device;
+		}
+
+		regmap_field_write(priv->rf[TSENS_SW_RST], 0x1);
+
+		/* Update measure period to 2ms */
+		regmap_field_write(priv->rf[MAIN_MEASURE_PERIOD], 0x1);
+
+		/* Enable available sensors */
+		regmap_field_write(priv->rf[SENSOR_EN], priv->sensors_to_en);
+
+		/* Real temperature format */
+		regmap_field_write(priv->rf[CODE_OR_TEMP], 0x1);
+
+		regmap_field_write(priv->rf[TSENS_SW_RST], 0x0);
+
+		/* Enable TSENS */
+		regmap_field_write(priv->rf[TSENS_EN], 0x1);
+	}
+
 	/* This loop might need changes if enum regfield_ids is reordered */
 	for (j = LAST_TEMP_0; j <= UP_THRESH_15; j += 16) {
 		for (i = 0; i < priv->feat->max_sensors; i++) {
@@ -1282,6 +1316,7 @@ static int tsens_probe(struct platform_device *pdev)
 
 	priv->dev = dev;
 	priv->num_sensors = num_sensors;
+	priv->sensors_to_en = data->sensors_to_en;
 	priv->ops = data->ops;
 	for (i = 0;  i < priv->num_sensors; i++) {
 		if (data->hw_ids)
diff --git a/drivers/thermal/qcom/tsens.h b/drivers/thermal/qcom/tsens.h
index 2805de1c6827..f8897bc8944e 100644
--- a/drivers/thermal/qcom/tsens.h
+++ b/drivers/thermal/qcom/tsens.h
@@ -168,6 +168,58 @@ enum regfield_ids {
 	TSENS_SW_RST,
 	SENSOR_EN,
 	CODE_OR_TEMP,
+	/* MEASURE_PERIOD */
+	MAIN_MEASURE_PERIOD,
+
+	/* Sn_CONVERSION */
+	SHIFT_0,
+	SLOPE_0,
+	CZERO_0,
+	SHIFT_1,
+	SLOPE_1,
+	CZERO_1,
+	SHIFT_2,
+	SLOPE_2,
+	CZERO_2,
+	SHIFT_3,
+	SLOPE_3,
+	CZERO_3,
+	SHIFT_4,
+	SLOPE_4,
+	CZERO_4,
+	SHIFT_5,
+	SLOPE_5,
+	CZERO_5,
+	SHIFT_6,
+	SLOPE_6,
+	CZERO_6,
+	SHIFT_7,
+	SLOPE_7,
+	CZERO_7,
+	SHIFT_8,
+	SLOPE_8,
+	CZERO_8,
+	SHIFT_9,
+	SLOPE_9,
+	CZERO_9,
+	SHIFT_10,
+	SLOPE_10,
+	CZERO_10,
+	SHIFT_11,
+	SLOPE_11,
+	CZERO_11,
+	SHIFT_12,
+	SLOPE_12,
+	CZERO_12,
+	SHIFT_13,
+	SLOPE_13,
+	CZERO_13,
+	SHIFT_14,
+	SLOPE_14,
+	CZERO_14,
+	SHIFT_15,
+	SLOPE_15,
+	CZERO_15,
 
 	/* ----- TM ------ */
 	/* TRDY */
@@ -524,6 +576,7 @@ struct tsens_features {
 /**
  * struct tsens_plat_data - tsens compile-time platform data
  * @num_sensors: Number of sensors supported by platform
+ * @sensors_to_en: Sensors to be enabled. Each bit represent a sensor
  * @ops: operations the tsens instance supports
  * @hw_ids: Subset of sensors ids supported by platform, if not the first n
  * @feat: features of the IP
@@ -531,6 +584,7 @@ struct tsens_features {
  */
 struct tsens_plat_data {
 	const u32		num_sensors;
+	const u16		sensors_to_en;
 	const struct tsens_ops	*ops;
 	unsigned int		*hw_ids;
 	struct tsens_features	*feat;
@@ -551,6 +605,7 @@ struct tsens_context {
  * struct tsens_priv - private data for each instance of the tsens IP
  * @dev: pointer to struct device
  * @num_sensors: number of sensors enabled on this device
+ * @sensors_to_en: sensors to be enabled. Each bit represents a sensor
  * @tm_map: pointer to TM register address space
  * @srot_map: pointer to SROT register address space
  * @tm_offset: deal with old device trees that don't address TM and SROT
@@ -569,6 +624,7 @@ struct tsens_context {
 struct tsens_priv {
 	struct device			*dev;
 	u32				num_sensors;
+	u16				sensors_to_en;
 	struct regmap			*tm_map;
 	struct regmap			*srot_map;
 	u32				tm_offset;
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

