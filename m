Return-Path: <linux-pm+bounces-17318-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F10129C3DA9
	for <lists+linux-pm@lfdr.de>; Mon, 11 Nov 2024 12:45:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C3EE1F2428C
	for <lists+linux-pm@lfdr.de>; Mon, 11 Nov 2024 11:45:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52059189BB4;
	Mon, 11 Nov 2024 11:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="m//7VbKV"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 622D018990D;
	Mon, 11 Nov 2024 11:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731325488; cv=none; b=FEEGu9AxoI20Vx1cghuTchimHqYlW8UL0vFBg7QNbHHSdl/5po59o87Dc8pLZrsDr+oiSP0b8uHIgPObCLnBdzj7jDFTy7ggXv39SXVtq/shCyjhBsAsFvC8Gn1GIC2gmY0QRRLOopcDgg3ykxULdZcM9ng+7cq5qpQz1GQ2Bi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731325488; c=relaxed/simple;
	bh=Rhej/lpztwWzOmacoWk1FMzPVVXs+E+sfhO+vraQMto=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=t1Yyj3+AM1Jm8vcp5IAkFeRZTc+mhWMSeKiPz9l59beAvzJeBh26lp8x0D0gKJeLiCBV1D6QgTYAlRRoZPPjSo3qZJs0DcLrNp7kpCB9KP1udbzY6YwQ2LQC8IK3M78/jKajL7yYLpoFBvKrGFbKBDZ6z7ul9exndx4r9WF1qhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=m//7VbKV; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AAMtmST010319;
	Mon, 11 Nov 2024 11:44:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	35Kq6UjEobmTy+XxoDoy4c7Z6Kl1wibH+RL9wBYN0Xw=; b=m//7VbKVO7NK8yny
	0O2+ZQcH8Ok+ZyPEd+0bw0WWpJj/GpWH26xaFVno4N+U9ERDZN5poFHJXeDrKAqE
	Xy8vmIwR698p011wY7uzuOP3VqmHYo8nytLU/K1XhpcOP0qQ537G95N7PKbF7JdO
	MUWf4Lt1mBIdXDPCWOhpAB98+mDnq9MDfVY3dUOWoIxwVUCFDt5zM76t7MeQaDSj
	2fC1L6ZaY0hlPxkyc3WkicGTnOjJql34WGs55T146egRee5fC5spXwzSu/Ax4KHw
	RYC0HJT88eysSl2ZzSJuoKsbOLSFVx8BidufedeLXpbqPdhU+iGKwYLr6oXMQb0k
	dZgy3A==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42sxr5v5g8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 11 Nov 2024 11:44:37 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4ABBiaGg005695
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 11 Nov 2024 11:44:36 GMT
Received: from [10.152.195.140] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 11 Nov
 2024 03:44:30 -0800
Message-ID: <07ec014e-4113-4cca-b731-e080489f01c6@quicinc.com>
Date: Mon, 11 Nov 2024 17:14:27 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 3/7] thermal/drivers/tsens: Add TSENS enable and
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
References: <20241107140550.3260859-1-quic_mmanikan@quicinc.com>
 <20241107140550.3260859-4-quic_mmanikan@quicinc.com>
 <z24xwwdtd6rytktxtuagiwbiukwd5tvfhotbbydizwsjtlnaob@q3ujwf2eiwds>
Content-Language: en-US
From: Manikanta Mylavarapu <quic_mmanikan@quicinc.com>
In-Reply-To: <z24xwwdtd6rytktxtuagiwbiukwd5tvfhotbbydizwsjtlnaob@q3ujwf2eiwds>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: XZo3bOFa70FdGRz50gkrfAHzWOWzCeIs
X-Proofpoint-GUID: XZo3bOFa70FdGRz50gkrfAHzWOWzCeIs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 phishscore=0
 mlxscore=0 malwarescore=0 priorityscore=1501 spamscore=0
 lowpriorityscore=0 impostorscore=0 suspectscore=0 adultscore=0
 mlxlogscore=999 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2409260000 definitions=main-2411110098



On 11/9/2024 5:53 AM, Dmitry Baryshkov wrote:
> On Thu, Nov 07, 2024 at 07:35:46PM +0530, Manikanta Mylavarapu wrote:
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
>> Changes in V7:
>> 	- Move val calculation out of switch-case and assign default
>> 	  values to shift, slope and czero and then change them under
>> 	  switch-case in tsens_v2_calibrate_sensor().
>>
>>  drivers/thermal/qcom/tsens-v2.c | 176 ++++++++++++++++++++++++++++++++
>>  drivers/thermal/qcom/tsens.c    |   8 +-
>>  drivers/thermal/qcom/tsens.h    |   4 +-
>>  3 files changed, 186 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/thermal/qcom/tsens-v2.c b/drivers/thermal/qcom/tsens-v2.c
>> index 0cb7301eca6e..6d2783577139 100644
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
>> @@ -59,6 +89,10 @@ static const struct reg_field tsens_v2_regfields[MAX_REGFIELDS] = {
>>  	/* CTRL_OFF */
>>  	[TSENS_EN]     = REG_FIELD(SROT_CTRL_OFF,    0,  0),
>>  	[TSENS_SW_RST] = REG_FIELD(SROT_CTRL_OFF,    1,  1),
>> +	[SENSOR_EN]    = REG_FIELD(SROT_CTRL_OFF,    3,  18),
>> +	[CODE_OR_TEMP] = REG_FIELD(SROT_CTRL_OFF,    21, 21),
>> +
>> +	[MAIN_MEASURE_PERIOD] = REG_FIELD(SROT_MEASURE_PERIOD, 0, 7),
>>  
>>  	/* ----- TM ------ */
>>  	/* INTERRUPT ENABLE */
>> @@ -104,6 +138,126 @@ static const struct reg_field tsens_v2_regfields[MAX_REGFIELDS] = {
>>  	[TRDY] = REG_FIELD(TM_TRDY_OFF, 0, 0),
>>  };
>>  
>> +static int tsens_v2_calibrate_sensor(struct device *dev, struct tsens_sensor *sensor,
>> +				     struct regmap *map,  u32 mode, u32 base0, u32 base1)
>> +{
>> +	u32 shift = V2_SHIFT_DEFAULT;
>> +	u32 slope = V2_SLOPE_DEFAULT, czero = V2_CZERO_DEFAULT, val;
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
>> +		fallthrough;
>> +	case ONE_PT_CALIB2:
>> +		czero = base0 + sensor->offset - ONE_PT_CZERO_CONST;
> 
> THis will override czero calculation from TWO_PT_CALIB case.
> 

I will replace 'fallthrough' with 'break' to avoid override.

Thanks & Regards,
Manikanta.

