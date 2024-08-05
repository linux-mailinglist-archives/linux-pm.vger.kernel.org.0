Return-Path: <linux-pm+bounces-11903-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DF06947322
	for <lists+linux-pm@lfdr.de>; Mon,  5 Aug 2024 03:47:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F85F1F213C3
	for <lists+linux-pm@lfdr.de>; Mon,  5 Aug 2024 01:47:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64AC52D058;
	Mon,  5 Aug 2024 01:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="HtgFENTc"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 880A53C0D;
	Mon,  5 Aug 2024 01:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722822437; cv=none; b=rYsMparhcC4tuTYzMYOQ1DyEITnbZzdIhYLoUkFK8Cbm9issedVssQ80RJWGGZ05LwenzMxlFk0qsLAxI0Kg5IMeD6q2gS+jZy+rVU8VWIvukpE4jKV3itCzFFPJ7lSiG/Nxm0JVQTA6JHLOAqG+sUpOQOMZnsqHFOsFP8zIDu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722822437; c=relaxed/simple;
	bh=0aE5QFV/70fF80Ssj9SM1HSGsExdjEmyZ+2ITjo5sK8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=NNu7PiR0Kxs0iih/R3q/eX1LQoZl7MOGc4whnaRh8lDTPt3+DR9brCLHg2WQqE1ujYuZFTdrMKuLvVtM1+qgJZ5042FuW3VlffoiCvMHAM2maxsbu/7Yu74KJVdaPGPVC4Jq2YSjmd2NlcPG2nA5YT3tbNJJIpTtsXQxEAhtTWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=HtgFENTc; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 474NTDvr019702;
	Mon, 5 Aug 2024 01:46:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	/7wSTRpSF2Elnm6YhKK3UHNYY4yz250NxKUWtwt149k=; b=HtgFENTcTMIwh40R
	ibGO/oBxXtGIlIADY919hb5w805YboJZkAIPzwvVQ43yGGv2dmB2m9+F3/po36fP
	O80OgBIlLzPgk5EufThU8Zrg2ntKOcokPWsHZRhS/1nBQoVk/29ArObkPsx/GYj1
	lY7M0vt5YbnjSat80p5CcVogduExFZr3x9tW+wFeE/DaD8MFHzwetti0HwW53anr
	p+hadlVPIHZPi9bIYwKNpbLXuBvtUvu0hOtz46T7Q6WAbLb5iibks9wwAZXOezpQ
	KKwwg3aUNSwJk3JMUkHxNaYQICY0y4ciw1WraZ88COiv/2tqiT4YpZS7nZ7AiUUB
	OGKYhw==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 40sbgrtjs2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 05 Aug 2024 01:46:54 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 4751krHR021433
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 5 Aug 2024 01:46:53 GMT
Received: from [10.239.132.204] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Sun, 4 Aug 2024
 18:46:47 -0700
Message-ID: <ef34cf5b-37b5-4450-a05d-fdbbb1ca2567@quicinc.com>
Date: Mon, 5 Aug 2024 09:46:38 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/3] dt-bindings: interconnect: Add Qualcomm SM4450
To: Krzysztof Kozlowski <krzk@kernel.org>, Georgi Djakov <djakov@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Catalin Marinas
	<catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
CC: <kernel@quicinc.com>, <linux-arm-msm@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
References: <20240801-sm4450_interconnect-v3-0-8e364d0faa99@quicinc.com>
 <20240801-sm4450_interconnect-v3-1-8e364d0faa99@quicinc.com>
 <20f5fa43-280d-4fde-a36f-c66b1f474f7e@kernel.org>
From: Tengfei Fan <quic_tengfan@quicinc.com>
In-Reply-To: <20f5fa43-280d-4fde-a36f-c66b1f474f7e@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: KxpGsuxELf4Lcv7sBg4LhUqli6iK_kK1
X-Proofpoint-GUID: KxpGsuxELf4Lcv7sBg4LhUqli6iK_kK1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-04_14,2024-08-02_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 impostorscore=0 malwarescore=0 suspectscore=0 phishscore=0 mlxscore=0
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 adultscore=0 spamscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2408050011



On 8/2/2024 3:22 PM, Krzysztof Kozlowski wrote:
> On 01/08/2024 10:54, Tengfei Fan wrote:
>> The Qualcomm SM4450 SoC has several bus fabrics that could be controlled
>> and tuned dynamically according to the bandwidth demand.
>>
>> Signed-off-by: Tengfei Fan <quic_tengfan@quicinc.com>
>> ---
>>   .../bindings/interconnect/qcom,sm4450-rpmh.yaml    | 133 +++++++++++++++++
>>   include/dt-bindings/interconnect/qcom,sm4450.h     | 163 +++++++++++++++++++++
>>   2 files changed, 296 insertions(+)
>>
> 
> If there were no changes, why skipping my tag?
> 
> <form letter>
> This is a friendly reminder during the review process.
> 
> It looks like you received a tag and forgot to add it.
> 
> If you do not know the process, here is a short explanation:
> Please add Acked-by/Reviewed-by/Tested-by tags when posting new
> versions, under or above your Signed-off-by tag. Tag is "received", when
> provided in a message replied to you on the mailing list. Tools like b4
> can help here. However, there's no need to repost patches *only* to add
> the tags. The upstream maintainer will do that for tags received on the
> version they apply.
> 
> https://elixir.bootlin.com/linux/v6.5-rc3/source/Documentation/process/submitting-patches.rst#L577
> 
> If a tag was not added on purpose, please state why and what changed.
> </form letter>
> 
> Best regards,
> Krzysztof
> 

The V3 patch series is based on the V2 patch series. Your tage also was 
not added to the V2 binding patch because some modifications were made 
to the binding patch and dt_binding_check was redone, and not comments 
were received about your tag, so your tag was not added in the V3 patch 
series either.

I will add your tag to the next version binding patch.

-- 
Thx and BRs,
Tengfei Fan

