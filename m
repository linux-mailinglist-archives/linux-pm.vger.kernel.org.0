Return-Path: <linux-pm+bounces-18165-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 277DA9DAB46
	for <lists+linux-pm@lfdr.de>; Wed, 27 Nov 2024 17:01:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DAE1728207A
	for <lists+linux-pm@lfdr.de>; Wed, 27 Nov 2024 16:01:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABAC3200134;
	Wed, 27 Nov 2024 16:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="kOSiKHkY"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E09B02CCC0;
	Wed, 27 Nov 2024 16:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732723274; cv=none; b=Y1Ewrm9Er7HJPhd4/OYA0eNkztUE5LQdqI8VBL2l7A5QbD2buTXhPLiYXwYN2zHa1yttu1TDYYbpj4VJe89xYpLc1eB1We8abfFZmV7zbkKwrsZ2n5KoY7dbNf3rjbh+Z1WmBEoXGd8Vy0r+HW4gMytXxtr6QpPRA9PVhpM5dfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732723274; c=relaxed/simple;
	bh=mzqhqXq2rpiM1kM9Ypt0pz716ETb7A1ydnt6gHTukp8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=lLBrZPEiFDp8X8dwgrgDeJVyDcdw9etHsKkFiJEIS97V+3rxmGpzlaVxlaX+KF/VkdDwPueczBCo7t1p4mulwTmshEmRqt/tOiyeHb+PM9vcrlk14lcQF6MPNvR75QnyPBBCbUa41Lue6PuJH2maVhuHBFIslmOv4RCPmXCretc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=kOSiKHkY; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AR97lJC005652;
	Wed, 27 Nov 2024 16:00:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	+Va95SJMT38If297mk1nUgJ1EjnxSRyhbUmPr7v/p8U=; b=kOSiKHkYI3AlYU2d
	cUDj8ezOXu85m9ti6XLzlLQPoWA2yNQiX7UeXfVbCeJmXpJIfEEo+Ofzg5a09tpa
	ODUowrXRRRVGOBJYRzoWPY8m+VQCCJEduOM/xyxPt7aYW/dAZ7zx8vDRoyqlWPIt
	MdZfSDM/5ar0ySEllrHSFovzb+fNLUwUTG7898kClBZZbT5BVqHPWvFp3/SvHZ1G
	SzRnvk1Jp9Y0YPYFx4BdnTNmNvvSyWpgFepgCR14s1/k+PrI6TsKetwB0m8t64Vu
	CCbiZr685J2fgm8fx6lbeOp274DkT1r4CeyRm3BcLATLymDdTvPaAYBHAaTiLsMn
	LVKM/Q==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 435cmqve3w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 27 Nov 2024 16:00:53 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4ARG0quS001593
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 27 Nov 2024 16:00:52 GMT
Received: from [10.206.104.82] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 27 Nov
 2024 08:00:45 -0800
Message-ID: <fe8f40aa-b9c7-4a85-9cb6-63df81190fab@quicinc.com>
Date: Wed, 27 Nov 2024 21:30:42 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 04/11] drm/msm: adreno: add GMU_BW_VOTE feature flag
To: <neil.armstrong@linaro.org>
CC: Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        "Stephen
 Boyd" <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Rob Clark
	<robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        Konrad Dybcio
	<konradybcio@kernel.org>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        "Dmitry
 Baryshkov" <dmitry.baryshkov@linaro.org>,
        Marijn Suijten
	<marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, "Simona
 Vetter" <simona@ffwll.ch>,
        Bjorn Andersson <andersson@kernel.org>, Rob
 Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor
 Dooley <conor+dt@kernel.org>,
        Connor Abbott <cwabbott0@gmail.com>, <linux-pm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <dri-devel@lists.freedesktop.org>, <freedreno@lists.freedesktop.org>,
        <devicetree@vger.kernel.org>
References: <20241119-topic-sm8x50-gpu-bw-vote-v2-0-4deb87be2498@linaro.org>
 <20241119-topic-sm8x50-gpu-bw-vote-v2-4-4deb87be2498@linaro.org>
 <20241123194316.yqvovktcptfep4dr@hu-akhilpo-hyd.qualcomm.com>
 <a936a9fc-6632-4f44-94d1-db304218b5a5@linaro.org>
Content-Language: en-US
From: Akhil P Oommen <quic_akhilpo@quicinc.com>
In-Reply-To: <a936a9fc-6632-4f44-94d1-db304218b5a5@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 1opIfsb-O5dhOZNYdhDvNnOQtwCCasRe
X-Proofpoint-ORIG-GUID: 1opIfsb-O5dhOZNYdhDvNnOQtwCCasRe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 spamscore=0
 lowpriorityscore=0 mlxscore=0 phishscore=0 malwarescore=0 mlxlogscore=999
 impostorscore=0 bulkscore=0 adultscore=0 suspectscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2409260000
 definitions=main-2411270127

On 11/25/2024 1:46 PM, Neil Armstrong wrote:
> On 23/11/2024 20:43, Akhil P Oommen wrote:
>> On Tue, Nov 19, 2024 at 06:56:39PM +0100, Neil Armstrong wrote:
>>> The Adreno GMU Management Unit (GNU) can also scale the DDR Bandwidth
>>> along the Frequency and Power Domain level, but by default we leave the
>>> OPP core vote for the interconnect ddr path.
>>>
>>> While scaling via the interconnect path was sufficient, newer GPUs
>>> like the A750 requires specific vote paremeters and bandwidth to
>>> achieve full functionality.
>>>
>>> While the feature will require some data in a6xx_info, it's safer
>>> to only enable tested platforms with this flag first.
>>>
>>> Add a new feature enabling DDR Bandwidth vote via GMU.
>>>
>>> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
>>> ---
>>>   drivers/gpu/drm/msm/adreno/adreno_gpu.h | 1 +
>>>   1 file changed, 1 insertion(+)
>>>
>>> diff --git a/drivers/gpu/drm/msm/adreno/adreno_gpu.h b/drivers/gpu/
>>> drm/msm/adreno/adreno_gpu.h
>>> index
>>> 4702d4cfca3b58fb3cbb25cb6805f1c19be2ebcb..394b96eb6c83354ae008b15b562bedb96cd391dd 100644
>>> --- a/drivers/gpu/drm/msm/adreno/adreno_gpu.h
>>> +++ b/drivers/gpu/drm/msm/adreno/adreno_gpu.h
>>> @@ -58,6 +58,7 @@ enum adreno_family {
>>>   #define ADRENO_FEAT_HAS_HW_APRIV        BIT(0)
>>>   #define ADRENO_FEAT_HAS_CACHED_COHERENT        BIT(1)
>>>   #define ADRENO_FEAT_PREEMPTION            BIT(2)
>>> +#define ADRENO_FEAT_GMU_BW_VOTE            BIT(3)
>>
>> Do we really need a feature flag for this? We have to carry this for
>> every
>> GPU going forward. IB voting is supported on all GMUs from A6xx GEN2 and
>> newer. So we can just check that along with whether the bw table is
>> dynamically generated or not.
> 
> It depends on the bw table _and_ the a6xx_info.gmu table, I don't want to
> check both in all parts on the driver.
> 
Thats fine then.

-Akhil.

> Neil
> 
>>
>> -Akhil
>>
>>>     /* Helper for formating the chip_id in the way that userspace
>>> tools like
>>>    * crashdec expect.
>>>
>>> -- 
>>> 2.34.1
>>>
> 
> 


