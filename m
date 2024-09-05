Return-Path: <linux-pm+bounces-13649-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4330A96CE00
	for <lists+linux-pm@lfdr.de>; Thu,  5 Sep 2024 06:31:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 76A37B226AB
	for <lists+linux-pm@lfdr.de>; Thu,  5 Sep 2024 04:31:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78D611494DB;
	Thu,  5 Sep 2024 04:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Up5Ehn6C"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3D6220E6;
	Thu,  5 Sep 2024 04:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725510678; cv=none; b=BN/6dhpvq2Mx9rtTo6uY3dg3+seAR7IpDJeCW9+9g4KtueQotG5IjM3ApTNFsEQ9mHi8UH6S++Ezv4EVU1uUCj8KuDUmAWTriLUDX0+kKEBAX3ArIqHX07L1jfuP6P/vVtldeGWHKey5/WP4f7HEK/2a5yOaLiU5qjGX7On1Res=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725510678; c=relaxed/simple;
	bh=bN9Fq1ft45JvfI5jIyNzkE4a7BGFF7N2Lx4btHWmg2Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=r9UtAffdpWHccMbwJP2xRkeRWyYZMY5zulFpMvE1KlDP5tYT5E6it43Ewt0Z4LSMjOfNF4vz11kVGJ/2UbzxDrZQ5+o972exG9btkARFILmV2eB6/4e3eWOpnL4ikDl/VTHVcdDjSayfBL2GwG6ICSKBXl6UHmTIJc3hAXlqw8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Up5Ehn6C; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4851hpMJ005471;
	Thu, 5 Sep 2024 04:31:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	5/xCQVHD57yk2LrnCzuJn9xrmDwsidUddYV1q7OkqOY=; b=Up5Ehn6Cl4NrSk5t
	FGGhR2RSo3MMq1pjbFuPP7GUtmWjzlCw83DRDhCXtKUrlUYshSPMwfrHFPyT3t9r
	rfrw4YauBWGF99KZIN77wxFqHOb118UO4tHdXn+hqEfAo4WPW2tC/fSvwpHyrCLt
	/uaNirUSLVtGuKcaFcd6n7AWusk/Bhjov5oderzQNJF4a9eotPvj4UTGvQQeaaKV
	c7P4DI9DG0kNeaoxaJMOixCphs9uE9zmjk7tZUOKIcgwf/tkkkdjvsNMpVbhhOM9
	KSbja1+HAaMvGKaaFwkI678fpWmHKuWblBP6PdJNwHCGsTpYexcx85rF/TmPPGp6
	BrK5Pw==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 41epwe26fy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 05 Sep 2024 04:31:01 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4854V0P0032515
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 5 Sep 2024 04:31:00 GMT
Received: from [10.233.21.53] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 4 Sep 2024
 21:30:57 -0700
Message-ID: <a0f3176d-9b2a-4fb9-9a7b-f8e778e3b427@quicinc.com>
Date: Thu, 5 Sep 2024 12:30:54 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/19] remoteproc: qcom: pas: Add QCS8300 remoteproc
 support
To: Krzysztof Kozlowski <krzk@kernel.org>,
        Bjorn Andersson
	<andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        "Rob
 Herring" <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        "Conor
 Dooley" <conor+dt@kernel.org>,
        Bartosz Golaszewski
	<bartosz.golaszewski@linaro.org>
CC: <linux-arm-msm@vger.kernel.org>, <linux-remoteproc@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        Xin Liu
	<quic_liuxin@quicinc.com>
References: <20240904-qcs8300_initial_dtsi-v1-0-d0ea9afdc007@quicinc.com>
 <20240904-qcs8300_initial_dtsi-v1-2-d0ea9afdc007@quicinc.com>
 <ecd95f82-ea98-4279-ad01-dc73d361180a@kernel.org>
Content-Language: en-US
From: Jingyi Wang <quic_jingyw@quicinc.com>
In-Reply-To: <ecd95f82-ea98-4279-ad01-dc73d361180a@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: NS3d9gifhVEWGS-r9NoqxWGMZ2sJt8Q7
X-Proofpoint-GUID: NS3d9gifhVEWGS-r9NoqxWGMZ2sJt8Q7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-05_03,2024-09-04_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 bulkscore=0
 spamscore=0 mlxscore=0 phishscore=0 mlxlogscore=999 lowpriorityscore=0
 suspectscore=0 adultscore=0 impostorscore=0 malwarescore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2409050030



On 9/4/2024 5:36 PM, Krzysztof Kozlowski wrote:
> On 04/09/2024 10:33, Jingyi Wang wrote:
>> Add support for PIL loading on ADSP, CDSP and GPDSP on QCS8300
>> platform.
>>
>> Co-developed-by: Xin Liu <quic_liuxin@quicinc.com>
>> Signed-off-by: Xin Liu <quic_liuxin@quicinc.com>
>> Signed-off-by: Jingyi Wang <quic_jingyw@quicinc.com>
>> ---
>>  drivers/remoteproc/qcom_q6v5_pas.c | 3 +++
>>  1 file changed, 3 insertions(+)
>>
>> diff --git a/drivers/remoteproc/qcom_q6v5_pas.c b/drivers/remoteproc/qcom_q6v5_pas.c
>> index ef82835e98a4..f92ccd4921b7 100644
>> --- a/drivers/remoteproc/qcom_q6v5_pas.c
>> +++ b/drivers/remoteproc/qcom_q6v5_pas.c
>> @@ -1416,6 +1416,9 @@ static const struct of_device_id adsp_of_match[] = {
>>  	{ .compatible = "qcom,qcs404-adsp-pas", .data = &adsp_resource_init },
>>  	{ .compatible = "qcom,qcs404-cdsp-pas", .data = &cdsp_resource_init },
>>  	{ .compatible = "qcom,qcs404-wcss-pas", .data = &wcss_resource_init },
>> +	{ .compatible = "qcom,qcs8300-adsp-pas", .data = &sa8775p_adsp_resource},
>> +	{ .compatible = "qcom,qcs8300-cdsp-pas", .data = &sa8775p_cdsp0_resource},
>> +	{ .compatible = "qcom,qcs8300-gpdsp-pas", .data = &sa8775p_gpdsp0_resource},
> 
> What's the point of this? You have entire commit msg to explain such
> weird duplication. Otherwise sorry, don't duplicate unnecessarily.
> Devices are compatible, aren't they?
> 
> Best regards,
> Krzysztof
> 
> 
I will drop this, could you please help us to understand what is the correct way to
deal such situation, do we need to update the yaml and add qcs8300 bindings or just
reference to sa8775p bindings in the device tree?

Thanks,
Jingyi

