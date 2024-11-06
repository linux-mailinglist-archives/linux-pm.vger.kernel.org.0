Return-Path: <linux-pm+bounces-17043-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ED5069BDB63
	for <lists+linux-pm@lfdr.de>; Wed,  6 Nov 2024 02:45:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98B3B284826
	for <lists+linux-pm@lfdr.de>; Wed,  6 Nov 2024 01:45:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D28B0157E9F;
	Wed,  6 Nov 2024 01:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="JuOMeicq"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 128F733F3;
	Wed,  6 Nov 2024 01:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730857549; cv=none; b=NXF6BQaIW7OoI7RuZGftFxynVmqV6n11BSDZTr4apaIyBlXxmcAKYUNOO4fPmFRXZI/6EXhn2tx1WftM5b4IzL7c7ZlHX1YG3j4NUIO+Hb++J21ta28+4oKMQMJKmjpAfNRKfitH0YdoK3WhqQF0ItZJj+Q3CJiBOy9ZsyosXzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730857549; c=relaxed/simple;
	bh=7KPkQH9Kl2MyqR+ranMRwoJmktaWsZKAeGEDxtAWyu0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=TGa5hl8mFWcvSFstjedy3jETUCQbP4l/wac1pcpV4FprlL+HktmO05HJpt2XStefSUWIL96KDvDWn8VsPGap7xSAte8t+/IT8iMpp9gh5e9YRJCGhAqRCGOf+wAMEP45aZnpB3ggOVzxmecMU793ta98n+E+jF4AuCzkR/4fFVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=JuOMeicq; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A5KIMJG004966;
	Wed, 6 Nov 2024 01:44:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Z5Jv3Ed7XXZHWZLDW8oApx97KGEiepVHnuihRZtI6kc=; b=JuOMeicqNpZNNLSM
	OwHF7tOGhhAwjHpPAZoHNm0IxF/4bzXD/afmF+nlPSD/E8vPG301kkhygiE3KonO
	Qc5TyF76Lj+EopSwZxDv2uy3th4kiWSFai2BsYuY49if8wYGX1JYCOLJqclBNq6m
	yJEi0YW76p/qHDDKukczulbOC8Lg/Qs+2jo1lsbk3JjlXq7b1Mf6tmZCaVS+leZ/
	lijzurCdo4NKH0r9X12rUKgZ6zp+94bCVMyPmFI2HkEXbdGUuKpVZjrRXGRz2h0C
	K4A921tIlp9MvUuvtPINsHOC1GSnVyyU9614RwxfKQovlKCWmXlmzsuDjewJfDPq
	qo7cww==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42ndc71hyv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 Nov 2024 01:44:38 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4A61ibAW017863
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 6 Nov 2024 01:44:37 GMT
Received: from [10.216.20.210] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 5 Nov 2024
 17:44:30 -0800
Message-ID: <43404449-1830-4651-a85a-54404b1d35bc@quicinc.com>
Date: Wed, 6 Nov 2024 07:14:27 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 1/3] drm/msm/adreno: Add support for ACD
To: <neil.armstrong@linaro.org>, Rob Clark <robdclark@gmail.com>,
        Sean Paul
	<sean@poorly.run>, Konrad Dybcio <konradybcio@kernel.org>,
        Abhinav Kumar
	<quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie
	<airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Viresh Kumar
	<vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd
	<sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski
	<krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson
	<andersson@kernel.org>
CC: <linux-arm-msm@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
        <freedreno@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, <devicetree@vger.kernel.org>
References: <20241012-gpu-acd-v1-0-1e5e91aa95b6@quicinc.com>
 <20241012-gpu-acd-v1-1-1e5e91aa95b6@quicinc.com>
 <4aeec9f1-720b-400c-9582-d02847db2ac7@linaro.org>
Content-Language: en-US
From: Akhil P Oommen <quic_akhilpo@quicinc.com>
In-Reply-To: <4aeec9f1-720b-400c-9582-d02847db2ac7@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: Na1zWvxix9JPntdFw7-EW3kC17gUUl4y
X-Proofpoint-GUID: Na1zWvxix9JPntdFw7-EW3kC17gUUl4y
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 lowpriorityscore=0 mlxlogscore=999 adultscore=0 clxscore=1015 mlxscore=0
 phishscore=0 impostorscore=0 suspectscore=0 malwarescore=0 bulkscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411060012

On 11/4/2024 9:14 PM, neil.armstrong@linaro.org wrote:
> On 11/10/2024 22:29, Akhil P Oommen wrote:
>> ACD a.k.a Adaptive Clock Distribution is a feature which helps to reduce
>> the power consumption. In some chipsets, it is also a requirement to
>> support higher GPU frequencies. This patch adds support for GPU ACD by
>> sending necessary data to GMU and AOSS. The feature support for the
>> chipset is detected based on devicetree data.
>>
>> Signed-off-by: Akhil P Oommen <quic_akhilpo@quicinc.com>
>> ---
>>   drivers/gpu/drm/msm/adreno/a6xx_gmu.c | 81 +++++++++++++++++++++++++
>> +++-------
>>   drivers/gpu/drm/msm/adreno/a6xx_gmu.h |  1 +
>>   drivers/gpu/drm/msm/adreno/a6xx_hfi.c | 36 ++++++++++++++++
>>   drivers/gpu/drm/msm/adreno/a6xx_hfi.h | 21 +++++++++
>>   4 files changed, 124 insertions(+), 15 deletions(-)
>>
> 
> <snip>
> 
>> +
>> +static int a6xx_hfi_enable_acd(struct a6xx_gmu *gmu)
>> +{
>> +    struct a6xx_hfi_acd_table *acd_table = &gmu->acd_table;
>> +    struct a6xx_hfi_msg_feature_ctrl msg = {
>> +        .feature = HFI_FEATURE_ACD,
>> +        .enable = 1,
>> +        .data = 0,
>> +    };
>> +    int ret;
>> +
>> +    if (!acd_table->enable_by_level)
>> +        return 0;
>> +
>> +    /* Enable ACD feature at GMU */
>> +    ret = a6xx_hfi_send_msg(gmu, HFI_H2F_FEATURE_CTRL, &msg,
>> sizeof(msg), NULL, 0);
>> +    if (ret) {
>> +        DRM_DEV_ERROR(gmu->dev, "Unable to enable ACD (%d)\n", ret);
>> +        return ret;
>> +    }
>> +
>> +    /* Send ACD table to GMU */
>> +    ret = a6xx_hfi_send_msg(gmu, HFI_H2F_MSG_ACD, &msg, sizeof(msg),
>> NULL, 0);
> 
> This looks wrong, in this exact code, you never use the acd_table...
> perhaps it should be acd_table here

Whoops! Weirdly gmu didn't explode when I tested.

Thanks for your keen eye.

-Akhil.

> 
>> +    if (ret) {
>> +        DRM_DEV_ERROR(gmu->dev, "Unable to ACD table (%d)\n", ret);
>> +        return ret;
>> +    }
>> +
>> +    return 0;
>> +}
>> +
>>   static int a6xx_hfi_send_test(struct a6xx_gmu *gmu)
>>   {
>>       struct a6xx_hfi_msg_test msg = { 0 };
>> @@ -756,6 +788,10 @@ int a6xx_hfi_start(struct a6xx_gmu *gmu, int
>> boot_state)
>>       if (ret)
>>           return ret;
>>   +    ret = a6xx_hfi_enable_acd(gmu);
>> +    if (ret)
>> +        return ret;
>> +
>>       ret = a6xx_hfi_send_core_fw_start(gmu);
>>       if (ret)
>>           return ret;
>> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_hfi.h b/drivers/gpu/drm/
>> msm/adreno/a6xx_hfi.h
>> index 528110169398..51864c8ad0e6 100644
>> --- a/drivers/gpu/drm/msm/adreno/a6xx_hfi.h
>> +++ b/drivers/gpu/drm/msm/adreno/a6xx_hfi.h
>> @@ -151,12 +151,33 @@ struct a6xx_hfi_msg_test {
>>       u32 header;
>>   };
>>   +#define HFI_H2F_MSG_ACD 7
>> +#define MAX_ACD_STRIDE 2
>> +
>> +struct a6xx_hfi_acd_table {
>> +    u32 header;
>> +    u32 version;
>> +    u32 enable_by_level;
>> +    u32 stride;
>> +    u32 num_levels;
>> +    u32 data[16 * MAX_ACD_STRIDE];
>> +};
>> +
>>   #define HFI_H2F_MSG_START 10
>>     struct a6xx_hfi_msg_start {
>>       u32 header;
>>   };
>>   +#define HFI_H2F_FEATURE_CTRL 11
>> +
>> +struct a6xx_hfi_msg_feature_ctrl {
>> +    u32 header;
>> +    u32 feature;
>> +    u32 enable;
>> +    u32 data;
>> +};
>> +
>>   #define HFI_H2F_MSG_CORE_FW_START 14
>>     struct a6xx_hfi_msg_core_fw_start {
>>
> 
> Thanks,
> Neil


