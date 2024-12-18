Return-Path: <linux-pm+bounces-19423-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E2459F64BE
	for <lists+linux-pm@lfdr.de>; Wed, 18 Dec 2024 12:22:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 94E0616C50A
	for <lists+linux-pm@lfdr.de>; Wed, 18 Dec 2024 11:22:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8C7E19D891;
	Wed, 18 Dec 2024 11:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="iVau2Vu4"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64A751F931;
	Wed, 18 Dec 2024 11:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734520958; cv=none; b=nD8NRY9lw6t0ZC4ZnXM9G1bLTwSN2iemG2GENclkk4UWMIRwzAqHW7T2UFQ307Emx8jelAZ0m9KhrLKEaiSoJXO70lqHALSRyv50xYhd+147zleIcfB3HEskKlCAeBKPIGW2wWP2SPR646+myiwvelmLUdm4L4jOY9YsxT5fLtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734520958; c=relaxed/simple;
	bh=mqnGlYDccPIss1dc76o+YdtHwPH5AUCHFb+BZz94EI8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=RBj1Hbz4LKNCdJ2/qtiBgDpwQBe00L+8EyhLiuE3x+a0LRm6zexii39A1RhmBfa70LwANAXyCJF0KlpN/t+EWjkDL0ynaypYNu8JFNgvxteLNLjrTocp5OvzMxqno1yz7DrhNLZ2yBDhFVbjdBzDSuJY84eTsEQe3KLOMlqxguo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=iVau2Vu4; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BI8YbD8012839;
	Wed, 18 Dec 2024 11:22:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	faR4MJOYl+co5UvqPys37TlEOCbTVnKCgt1gDHCoTpQ=; b=iVau2Vu46QFJ2Xis
	+QbogErtWOA92Z0raFRDhiHTY6pFzk8Lj1AgFFiEvsEz24TN9Rp730mxM3Jlziwl
	YE9n5I1/Qlydc0yQPP4qN1SvcQbIsKTpgQYXLOHB9c5SSeXTb7Jk7P/42IVy/Tg+
	Y2v1sTj4azWTZe9XsRkFcL+SNkXENK/LGxbqtl8U0SjxsSmMXJ/6nCTssHLVG5PH
	G0cH87NsvO0ADvA9JM4MRqud1a+2c2hy2srDyUYis9amKhLPkcTsj87nRb9Gg7z7
	qkabTFuQad8Jq8pqTgz1GzX6vswS6YKgOlrjJ8jKNapj4ak7kclxvjRCWsHJhBqa
	qpuX9g==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43ku0p0e36-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 18 Dec 2024 11:22:29 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4BIBMSF9028696
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 18 Dec 2024 11:22:28 GMT
Received: from [10.152.195.140] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 18 Dec
 2024 03:22:22 -0800
Message-ID: <96db4471-0dfe-4969-a916-405105a663ae@quicinc.com>
Date: Wed, 18 Dec 2024 16:52:19 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 3/7] thermal/drivers/tsens: Add TSENS enable and
 calibration support for V2
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
CC: <quic_srichara@quicinc.com>, <quic_varada@quicinc.com>,
        <srinivas.kandagatla@linaro.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>, <amitk@kernel.org>,
        <thara.gopinath@gmail.com>, <rafael@kernel.org>,
        <daniel.lezcano@linaro.org>, <rui.zhang@intel.com>,
        <lukasz.luba@arm.com>, <andersson@kernel.org>,
        <konradybcio@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-pm@vger.kernel.org>
References: <20241125050728.3699241-1-quic_mmanikan@quicinc.com>
 <20241125050728.3699241-4-quic_mmanikan@quicinc.com>
 <f7f8f087-f3bb-4dbc-b95d-6a6edd6bf64c@wanadoo.fr>
Content-Language: en-US
From: Manikanta Mylavarapu <quic_mmanikan@quicinc.com>
In-Reply-To: <f7f8f087-f3bb-4dbc-b95d-6a6edd6bf64c@wanadoo.fr>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 2a4ucRb0vJ6CtipC5Qo_yVMXSZwU4iWT
X-Proofpoint-GUID: 2a4ucRb0vJ6CtipC5Qo_yVMXSZwU4iWT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 malwarescore=0
 suspectscore=0 clxscore=1011 lowpriorityscore=0 adultscore=0 mlxscore=0
 priorityscore=1501 mlxlogscore=999 spamscore=0 bulkscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2411120000
 definitions=main-2412180092



On 12/14/2024 12:32 AM, Christophe JAILLET wrote:
> Le 25/11/2024 à 06:07, Manikanta Mylavarapu a écrit :
>> From: Praveenkumar I <quic_ipkumar-jfJNa2p1gH1BDgjK7y7TUQ@public.gmane.org>
>>
>> SoCs without RPM need to enable sensors and calibrate them from the kernel.
>> The IPQ5332 and IPQ5424 use the tsens v2.3.3 IP and do not have RPM.
>> Therefore, add a new calibration function for V2, as the tsens.c calib
>> function only supports V1. Also add new feature_config, ops and data for
>> IPQ5332, IPQ5424.
>>
>> Although the TSENS IP supports 16 sensors, not all are used. The hw_id
>> is used to enable the relevant sensors.
> 
> ...
> 
>> diff --git a/drivers/thermal/qcom/tsens-v2.c b/drivers/thermal/qcom/tsens-v2.c
>> index 0cb7301eca6e..836155fa9ab2 100644
>> --- a/drivers/thermal/qcom/tsens-v2.c
>> +++ b/drivers/thermal/qcom/tsens-v2.c
>> @@ -4,13 +4,32 @@
>>    * Copyright (c) 2018, Linaro Limited
>>    */
>>   +#include <linux/bitfield.h>
>>   #include <linux/bitops.h>
>>   #include <linux/regmap.h>
>> +#include <linux/nvmem-consumer.h>
> 
> If moved one line above, alphabetical order would be kept.
> 

Sure, i will update in the next version.

>>   #include "tsens.h"
>>     /* ----- SROT ------ */
>>   #define SROT_HW_VER_OFF    0x0000
> 
> ...
> 
>> +static const struct tsens_ops ops_ipq5332 = {
>> +    .init        = init_tsens_v2_no_rpm,
>> +    .get_temp    = get_temp_tsens_valid,
>> +    .calibrate    = tsens_v2_calibration,
>> +};
>> +
>> +struct tsens_plat_data data_ipq5332 = {
> 
> This could easily be made as const.
> 

Sure, i will update in the next version.

>> +    .num_sensors    = 5,
>> +    .ops        = &ops_ipq5332,
>> +    .hw_ids        = (unsigned int []){11, 12, 13, 14, 15},
>> +    .feat        = &ipq5332_feat,
>> +    .fields        = tsens_v2_regfields,
>> +};
>> +
>> +struct tsens_plat_data data_ipq5424 = {
> 
> This could easily be made as const.
> 

Sure, i will update in the next version.

Thanks & Regards,
Manikanta.

>> +    .num_sensors    = 7,
>> +    .ops        = &ops_ipq5332,
>> +    .hw_ids        = (unsigned int []){9, 10, 11, 12, 13, 14, 15},
>> +    .feat        = &ipq5332_feat,
>> +    .fields        = tsens_v2_regfields,
>> +};
> 
> ...
> 
> CJ


