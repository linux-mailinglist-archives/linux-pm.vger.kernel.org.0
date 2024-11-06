Return-Path: <linux-pm+bounces-17047-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7369A9BDEA9
	for <lists+linux-pm@lfdr.de>; Wed,  6 Nov 2024 07:16:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 34A582850B2
	for <lists+linux-pm@lfdr.de>; Wed,  6 Nov 2024 06:16:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20492191494;
	Wed,  6 Nov 2024 06:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="irfMXbzR"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2922836C;
	Wed,  6 Nov 2024 06:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730873807; cv=none; b=rJPmp+9wL+T4uprq3y2LNyYx1I1P7zIcbRZgAh7JQyjnSjRruw+6/MSGYI3vRYKySEIakXY4BJPUQNegurEGf3xm52MWqeYnShhj/JljEtGinOgZ1NvBcDUMBr1TyYPyIloCwyoRgqLQl8cuMVmP9GprOpl/quSJmQ9/ESea2Fg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730873807; c=relaxed/simple;
	bh=szxHd5Lbm3ojv6EflWEcoBcCaEuO4o+gF/aRWAzWMAs=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=hU9UkB6Jlka+rcr5c6VENtM1xVyQwXQkb9zqMqMkVhAamfcAERKJLkNyd5QxiSVILqqQ3Req4AlDSoxlpr5pD5Kf7noiA/3d+hDa4oNKQFDHzrb2xAg6bFuRduTT3sOPyzVxp3MADjaP1nnrhYwab6fNN/vOvAPSsyPdWUBTzY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=irfMXbzR; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A5Kl00X015605;
	Wed, 6 Nov 2024 06:16:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	yuO0XalV9QUXdXUhVyAm8lbIN9wiBbZcS5k93ps4rUM=; b=irfMXbzRwwYiTPkN
	DQv8crlrX/5L5lNksPm4fZEjTbzUPiUtk6/p40+m5qT4duEZvyGdqk2p90S6u7fU
	gZKxIZU/HOKkXtRXCUmJlgdHJcQitldM9R2ysey66VQwgGn9zWr9Yo6yRzzm1uHT
	OQzUXOyvt96GKah6eC6Dhx1zYPQv7AGYujgJebRRRgIosJ98TtiJkRxF4DF0TCKc
	wze9GFmoUuL4DX0HZ7rwr95nmjbrjSKPw7s9REiagy9xacZ04X7MAt4IOSOXj2/m
	1vmbYCjcFIe48AoBeMpwW1221OrYXxNsY5LrYY13/L/gTPyXJm5VIjCXid8O/DwE
	qRESrw==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42q5n8mkb7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 Nov 2024 06:16:35 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4A66GYd7012082
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 6 Nov 2024 06:16:34 GMT
Received: from [10.152.195.140] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 5 Nov 2024
 22:16:29 -0800
Message-ID: <441eb5ca-dfae-4f35-8026-61b70c23c4c0@quicinc.com>
Date: Wed, 6 Nov 2024 11:46:26 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 3/7] thermal/drivers/tsens: Add TSENS enable and
 calibration support for V2
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
CC: <srinivas.kandagatla@linaro.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <amitk@kernel.org>, <thara.gopinath@gmail.com>,
        <rafael@kernel.org>, <daniel.lezcano@linaro.org>,
        <rui.zhang@intel.com>, <lukasz.luba@arm.com>, <andersson@kernel.org>,
        <konradybcio@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, <quic_srichara@quicinc.com>,
        <quic_varada@quicinc.com>
References: <20241104124413.2012794-1-quic_mmanikan@quicinc.com>
 <20241104124413.2012794-4-quic_mmanikan@quicinc.com>
 <ni4y5yf5uymum4rinlr35tnko6bgxscmchw236h2c7dxxojxci@upzwx4xvh2st>
Content-Language: en-US
From: Manikanta Mylavarapu <quic_mmanikan@quicinc.com>
In-Reply-To: <ni4y5yf5uymum4rinlr35tnko6bgxscmchw236h2c7dxxojxci@upzwx4xvh2st>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: bwK2qpZnQs9kgm-lnuiXTSur15QRmsmk
X-Proofpoint-ORIG-GUID: bwK2qpZnQs9kgm-lnuiXTSur15QRmsmk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 impostorscore=0
 suspectscore=0 lowpriorityscore=0 mlxlogscore=999 mlxscore=0
 priorityscore=1501 bulkscore=0 adultscore=0 malwarescore=0 phishscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411060049



On 11/5/2024 1:12 AM, Dmitry Baryshkov wrote:
> On Mon, Nov 04, 2024 at 06:14:09PM +0530, Manikanta Mylavarapu wrote:
>> From: Praveenkumar I <quic_ipkumar@quicinc.com>
>>
>> SoCs without RPM need to enable sensors and calibrate them from the kernel.
>> The IPQ5332 and IPQ5424 use the tsens v2.3.3 IP and do not have RPM.
>> Therefore, add a new calibration function for V2, as the tsens.c calib
>> function only supports V1. Also add new feature_config, ops and data for
>> IPQ5332, IPQ5424.
>>
>> Although the TSENS IP supports 16 sensors, not all are used. The hw_id
>> is used to enable the relevant sensors.
>>
>> Signed-off-by: Praveenkumar I <quic_ipkumar@quicinc.com>
>> Signed-off-by: Manikanta Mylavarapu <quic_mmanikan@quicinc.com>
>> ---
>> Changes in V6:
>> 	- Add IPQ5424 support
>> 	- Patch #1 and Patch #5 from V5 have been merged and
>> 	  incorporated into Patch #3 in V6 to resolve below
>> 	  compilation warnings.
>> drivers/thermal/qcom/tsens-v2.c:216:19: warning: ‘init_tsens_v2_no_rpm’
>> defined but not used [-Wunused-function]
>>  static int __init init_tsens_v2_no_rpm(struct tsens_priv *priv)
>> drivers/thermal/qcom/tsens-v2.c:180:12: warning: ‘tsens_v2_calibration’
>> defined but not used [-Wunused-function]
>>  static int tsens_v2_calibration(struct tsens_priv *priv)
>>
>>  drivers/thermal/qcom/tsens-v2.c | 182 ++++++++++++++++++++++++++++++++
>>  drivers/thermal/qcom/tsens.c    |   8 +-
>>  drivers/thermal/qcom/tsens.h    |   4 +-
>>  3 files changed, 192 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/thermal/qcom/tsens-v2.c b/drivers/thermal/qcom/tsens-v2.c
>> index 0cb7301eca6e..90b6915607ea 100644
>> --- a/drivers/thermal/qcom/tsens-v2.c
>> +++ b/drivers/thermal/qcom/tsens-v2.c
>> @@ -4,13 +4,32 @@
>>   * Copyright (c) 2018, Linaro Limited
>>   */
>>  
>> +#include <linux/bitfield.h>
>>  #include <linux/bitops.h>
>>  #include <linux/regmap.h>
>> +#include <linux/nvmem-consumer.h>
>>  #include "tsens.h"
>>  
>>  /* ----- SROT ------ */
>>  #define SROT_HW_VER_OFF	0x0000
>>  #define SROT_CTRL_OFF		0x0004
>> +#define SROT_MEASURE_PERIOD	0x0008
>> +#define SROT_Sn_CONVERSION	0x0060
>> +#define V2_SHIFT_DEFAULT	0x0003
>> +#define V2_SLOPE_DEFAULT	0x0cd0
>> +#define V2_CZERO_DEFAULT	0x016a
>> +#define ONE_PT_SLOPE		0x0cd0
>> +#define TWO_PT_SHIFTED_GAIN	921600
>> +#define ONE_PT_CZERO_CONST	94
>> +#define SW_RST_DEASSERT		0x0
>> +#define SW_RST_ASSERT		0x1
>> +#define MEASURE_PERIOD_2mSEC	0x1
>> +#define RSEULT_FORMAT_TEMP	0x1
>> +#define TSENS_ENABLE		0x1
>> +#define SENSOR_CONVERSION(n)	(((n) * 4) + SROT_Sn_CONVERSION)
>> +#define CONVERSION_SHIFT_MASK	GENMASK(24, 23)
>> +#define CONVERSION_SLOPE_MASK	GENMASK(22, 10)
>> +#define CONVERSION_CZERO_MASK	GENMASK(9, 0)
>>  
>>  /* ----- TM ------ */
>>  #define TM_INT_EN_OFF			0x0004
>> @@ -50,6 +69,17 @@ static struct tsens_features ipq8074_feat = {
>>  	.trip_max_temp	= 204000,
>>  };
>>  
>> +static struct tsens_features ipq5332_feat = {
>> +	.ver_major	= VER_2_X_NO_RPM,
>> +	.crit_int	= 1,
>> +	.combo_int	= 1,
>> +	.adc		= 0,
>> +	.srot_split	= 1,
>> +	.max_sensors	= 16,
>> +	.trip_min_temp	= 0,
>> +	.trip_max_temp	= 204000,
>> +};
>> +
>>  static const struct reg_field tsens_v2_regfields[MAX_REGFIELDS] = {
>>  	/* ----- SROT ------ */
>>  	/* VERSION */
>> @@ -59,6 +89,11 @@ static const struct reg_field tsens_v2_regfields[MAX_REGFIELDS] = {
>>  	/* CTRL_OFF */
>>  	[TSENS_EN]     = REG_FIELD(SROT_CTRL_OFF,    0,  0),
>>  	[TSENS_SW_RST] = REG_FIELD(SROT_CTRL_OFF,    1,  1),
>> +	[SENSOR_EN]    = REG_FIELD(SROT_CTRL_OFF,    3,  18),
>> +	[CODE_OR_TEMP] = REG_FIELD(SROT_CTRL_OFF,    21, 21),
>> +
>> +	/* MAIN_MEASURE_PERIOD */
>> +	[MAIN_MEASURE_PERIOD] = REG_FIELD(SROT_MEASURE_PERIOD, 0, 7),
>>  
>>  	/* ----- TM ------ */
>>  	/* INTERRUPT ENABLE */
>> @@ -104,6 +139,131 @@ static const struct reg_field tsens_v2_regfields[MAX_REGFIELDS] = {
>>  	[TRDY] = REG_FIELD(TM_TRDY_OFF, 0, 0),
>>  };
>>  
>> +static int tsens_v2_calibrate_sensor(struct device *dev, struct tsens_sensor *sensor,
>> +				     struct regmap *map,  u32 mode, u32 base0, u32 base1)
>> +{
>> +	u32 slope, czero, val;
>> +	char name[8];
>> +	int ret;
>> +
>> +	/* Read offset value */
>> +	ret = snprintf(name, sizeof(name), "s%d", sensor->hw_id);
>> +	if (ret < 0)
>> +		return ret;
>> +
>> +	ret = nvmem_cell_read_variable_le_u32(dev, name, &sensor->offset);
>> +	if (ret)
>> +		return ret;
>> +
>> +	/* Based on calib mode, program SHIFT, SLOPE and CZERO */
>> +	switch (mode) {
>> +	case TWO_PT_CALIB:
>> +		slope = (TWO_PT_SHIFTED_GAIN / (base1 - base0));
>> +
>> +		czero = (base0 + sensor->offset - ((base1 - base0) / 3));
>> +
>> +		val = FIELD_PREP(CONVERSION_SHIFT_MASK, V2_SHIFT_DEFAULT) |
>> +		      FIELD_PREP(CONVERSION_SLOPE_MASK, slope) |
>> +		      FIELD_PREP(CONVERSION_CZERO_MASK, czero);
>> +
>> +		fallthrough;
>> +	case ONE_PT_CALIB2:
>> +		czero = base0 + sensor->offset - ONE_PT_CZERO_CONST;
>> +
>> +		val = FIELD_PREP(CONVERSION_SHIFT_MASK, V2_SHIFT_DEFAULT) |
>> +		      FIELD_PREP(CONVERSION_SLOPE_MASK, ONE_PT_SLOPE) |
>> +		      FIELD_PREP(CONVERSION_CZERO_MASK, czero);
>> +
>> +		break;
>> +	default:
>> +		dev_dbg(dev, "calibrationless mode\n");
>> +
>> +		val = FIELD_PREP(CONVERSION_SHIFT_MASK, V2_SHIFT_DEFAULT) |
>> +		      FIELD_PREP(CONVERSION_SLOPE_MASK, V2_SLOPE_DEFAULT) |
>> +		      FIELD_PREP(CONVERSION_CZERO_MASK, V2_CZERO_DEFAULT);
> 
> Move val calculation out of switch-case, assign default values to shift,
> slope and czero and then change them under switch-case.
> 

Sure. I will update.

>> +	}
>> +
>> +	regmap_write(map, SENSOR_CONVERSION(sensor->hw_id), val);
>> +
>> +	return 0;
>> +}
>> +
>> +static int tsens_v2_calibration(struct tsens_priv *priv)
>> +{
>> +	struct device *dev = priv->dev;
>> +	u32 mode, base0, base1;
>> +	int i, ret;
>> +
>> +	if (priv->num_sensors > MAX_SENSORS)
>> +		return -EINVAL;
>> +
>> +	ret = nvmem_cell_read_variable_le_u32(priv->dev, "mode", &mode);
>> +	if (ret == -ENOENT)
>> +		dev_warn(priv->dev, "Calibration data not present in DT\n");
>> +	if (ret < 0)
>> +		return ret;
>> +
>> +	dev_dbg(priv->dev, "calibration mode is %d\n", mode);
>> +
>> +	ret = nvmem_cell_read_variable_le_u32(priv->dev, "base0", &base0);
>> +	if (ret < 0)
>> +		return ret;
>> +
>> +	ret = nvmem_cell_read_variable_le_u32(priv->dev, "base1", &base1);
> 
> Is this actually base0 / base1 or rather base1 / base2 as used by the
> tsens v0.1 / v1 ?
> 

As per qualcomm internal register guide, these registers are named as base0 and base1.

Thanks & Regards,
Manikanta.

>> +	if (ret < 0)
>> +		return ret;
>> +
>> +	/* Calibrate each sensor */
>> +	for (i = 0; i < priv->num_sensors; i++) {
>> +		ret = tsens_v2_calibrate_sensor(dev, &priv->sensor[i], priv->srot_map,
>> +						mode, base0, base1);
>> +		if (ret < 0)
>> +			return ret;
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +static int __init init_tsens_v2_no_rpm(struct tsens_priv *priv)
>> +{
>> +	struct device *dev = priv->dev;
>> +	int i, ret;
>> +	u32 val = 0;
>> +
>> +	ret = init_common(priv);
>> +	if (ret < 0)
>> +		return ret;
>> +
>> +	priv->rf[CODE_OR_TEMP] = devm_regmap_field_alloc(dev, priv->srot_map,
>> +							 priv->fields[CODE_OR_TEMP]);
>> +	if (IS_ERR(priv->rf[CODE_OR_TEMP]))
>> +		return PTR_ERR(priv->rf[CODE_OR_TEMP]);
>> +
>> +	priv->rf[MAIN_MEASURE_PERIOD] = devm_regmap_field_alloc(dev, priv->srot_map,
>> +								priv->fields[MAIN_MEASURE_PERIOD]);
>> +	if (IS_ERR(priv->rf[MAIN_MEASURE_PERIOD]))
>> +		return PTR_ERR(priv->rf[MAIN_MEASURE_PERIOD]);
>> +
>> +	regmap_field_write(priv->rf[TSENS_SW_RST], SW_RST_ASSERT);
>> +
>> +	regmap_field_write(priv->rf[MAIN_MEASURE_PERIOD], MEASURE_PERIOD_2mSEC);
>> +
>> +	/* Enable available sensors */
>> +	for (i = 0; i < priv->num_sensors; i++)
>> +		val |= 1 << priv->sensor[i].hw_id;
>> +
>> +	regmap_field_write(priv->rf[SENSOR_EN], val);
>> +
>> +	/* Select temperature format, unit is deci-Celsius */
>> +	regmap_field_write(priv->rf[CODE_OR_TEMP], RSEULT_FORMAT_TEMP);
>> +
>> +	regmap_field_write(priv->rf[TSENS_SW_RST], SW_RST_DEASSERT);
>> +
>> +	regmap_field_write(priv->rf[TSENS_EN], TSENS_ENABLE);
>> +
>> +	return 0;
>> +}
>> +
>>  static const struct tsens_ops ops_generic_v2 = {
>>  	.init		= init_common,
>>  	.get_temp	= get_temp_tsens_valid,
>> @@ -122,6 +282,28 @@ struct tsens_plat_data data_ipq8074 = {
>>  	.fields	= tsens_v2_regfields,
>>  };
>>  
>> +static const struct tsens_ops ops_ipq5332 = {
>> +	.init		= init_tsens_v2_no_rpm,
>> +	.get_temp	= get_temp_tsens_valid,
>> +	.calibrate	= tsens_v2_calibration,
>> +};
>> +
>> +struct tsens_plat_data data_ipq5332 = {
>> +	.num_sensors	= 5,
>> +	.ops		= &ops_ipq5332,
>> +	.hw_ids		= (unsigned int []){11, 12, 13, 14, 15},
>> +	.feat		= &ipq5332_feat,
>> +	.fields		= tsens_v2_regfields,
>> +};
>> +
>> +struct tsens_plat_data data_ipq5424 = {
>> +	.num_sensors	= 7,
>> +	.ops		= &ops_ipq5332,
>> +	.hw_ids		= (unsigned int []){9, 10, 11, 12, 13, 14, 15},
>> +	.feat		= &ipq5332_feat,
>> +	.fields		= tsens_v2_regfields,
>> +};
>> +
>>  /* Kept around for backward compatibility with old msm8996.dtsi */
>>  struct tsens_plat_data data_8996 = {
>>  	.num_sensors	= 13,
>> diff --git a/drivers/thermal/qcom/tsens.c b/drivers/thermal/qcom/tsens.c
>> index 0b4421bf4785..c5409225756f 100644
>> --- a/drivers/thermal/qcom/tsens.c
>> +++ b/drivers/thermal/qcom/tsens.c
>> @@ -975,7 +975,7 @@ int __init init_common(struct tsens_priv *priv)
>>  	ret = regmap_field_read(priv->rf[TSENS_EN], &enabled);
>>  	if (ret)
>>  		goto err_put_device;
>> -	if (!enabled) {
>> +	if (!enabled && (tsens_version(priv) != VER_2_X_NO_RPM)) {
>>  		dev_err(dev, "%s: device not enabled\n", __func__);
>>  		ret = -ENODEV;
>>  		goto err_put_device;
>> @@ -1102,6 +1102,12 @@ static SIMPLE_DEV_PM_OPS(tsens_pm_ops, tsens_suspend, tsens_resume);
>>  
>>  static const struct of_device_id tsens_table[] = {
>>  	{
>> +		.compatible = "qcom,ipq5332-tsens",
>> +		.data = &data_ipq5332,
>> +	}, {
>> +		.compatible = "qcom,ipq5424-tsens",
>> +		.data = &data_ipq5424,
>> +	}, {
>>  		.compatible = "qcom,ipq8064-tsens",
>>  		.data = &data_8960,
>>  	}, {
>> diff --git a/drivers/thermal/qcom/tsens.h b/drivers/thermal/qcom/tsens.h
>> index cab39de045b1..ac5358e48f74 100644
>> --- a/drivers/thermal/qcom/tsens.h
>> +++ b/drivers/thermal/qcom/tsens.h
>> @@ -35,6 +35,7 @@ enum tsens_ver {
>>  	VER_0_1,
>>  	VER_1_X,
>>  	VER_2_X,
>> +	VER_2_X_NO_RPM,
>>  };
>>  
>>  enum tsens_irq_type {
>> @@ -168,6 +169,7 @@ enum regfield_ids {
>>  	TSENS_SW_RST,
>>  	SENSOR_EN,
>>  	CODE_OR_TEMP,
>> +	MAIN_MEASURE_PERIOD,
>>  
>>  	/* ----- TM ------ */
>>  	/* TRDY */
>> @@ -650,6 +652,6 @@ extern struct tsens_plat_data data_8226, data_8909, data_8916, data_8939, data_8
>>  extern struct tsens_plat_data data_tsens_v1, data_8976, data_8956;
>>  
>>  /* TSENS v2 targets */
>> -extern struct tsens_plat_data data_8996, data_ipq8074, data_tsens_v2;
>> +extern struct tsens_plat_data data_8996, data_ipq8074, data_ipq5332, data_ipq5424, data_tsens_v2;
>>  
>>  #endif /* __QCOM_TSENS_H__ */
>> -- 
>> 2.34.1
>>
> 


