Return-Path: <linux-pm+bounces-9722-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74AA491194A
	for <lists+linux-pm@lfdr.de>; Fri, 21 Jun 2024 06:21:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 97E901C2156A
	for <lists+linux-pm@lfdr.de>; Fri, 21 Jun 2024 04:21:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C95A6126F1A;
	Fri, 21 Jun 2024 04:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="G2l+QFV3"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2732882D7F;
	Fri, 21 Jun 2024 04:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718943675; cv=none; b=YFpdq3XjOzOl+lV+1dos32N7VIV69OZ9IMNAQhGcliXX8UxJ5Lsh3A2dyfSTNVSBj+OODAgGB0CbmZutC/OJBmzcRNhCo7TlpMTygeGA2FxMhzx440LhUYQ8jgz/MFfv/gyi8wSfDEN/LsQUwvIgJwj3Q8nGrf4LEoVwtvNtwTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718943675; c=relaxed/simple;
	bh=zF8TicuZO0BZHKSV1kqiWeNwOO5RZ32D+d92PXfxUo4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=RL9AzIn80jeIOizo7p5uPyM56QrSON2BMvgOELOgRAoQz2utvCVAdwa/ycbcxwGLAzUmOvaLx8wgWbdDCeaEyqIO0td1so73NVkyThOCJqLY+6CO49Sx9NDRoWjbyQng7ujfhCJvc3p/Xdc+oYJw/PaeEN/FeXathp7425Ewx24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=G2l+QFV3; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45KHFpqd018165;
	Fri, 21 Jun 2024 04:21:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	6TPOm6I+QKWSWACRLrK/n5fcUX3w4K7lhw0KTM4oJfI=; b=G2l+QFV3KVSpWOS9
	DyGN33iUZkzkwMAMSfU1cTN5ueJuSEpBX2sV68XacUCuJOet618IifP3AWwsS3rN
	AQfXqCLnCGmt9mpuIATAB8K6Te7VatSmWD+pEjQhDU5F/eJtEVWbdn9pm/VAuaqM
	S0U9mPeC44PK9s4PzyTY5y/3Wi/h+3hGbNE8DNNPONiVpk6zZ6fZj6fQpgn8+lHf
	7KRUMBxaZ+4es6+pam6AlJAMwsu1o2nMtW1bA9Xi71RGquDf69jdw4GXiXGwlDGX
	cClNsPFrjASdk0LZcvqSf3XQP/ehzZCJ8/sGBz90jGganAthz9q8HuRL3rvPHWYU
	JXn2tg==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3yvrp19ash-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Jun 2024 04:21:08 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 45L4L7eo018830
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Jun 2024 04:21:07 GMT
Received: from [10.217.216.152] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 20 Jun
 2024 21:21:03 -0700
Message-ID: <9b6d03f4-d853-47ce-90dd-f085a893f639@quicinc.com>
Date: Fri, 21 Jun 2024 09:50:58 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] pmdomain: qcom: rpmhpd: Skip retention level for Power
 Domains
To: Konrad Dybcio <konrad.dybcio@linaro.org>,
        Bjorn Andersson
	<andersson@kernel.org>,
        Andy Gross <agross@kernel.org>, Ulf Hansson
	<ulf.hansson@linaro.org>
CC: <linux-arm-msm@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <quic_jkona@quicinc.com>, <quic_imrashai@quicinc.com>
References: <20240531114148.8550-1-quic_tdas@quicinc.com>
 <99967eee-da39-4a35-b80f-a78fe3c10733@linaro.org>
 <76f0e79c-b100-4b61-b861-17b324e1e4f7@quicinc.com>
 <e1ab08cb-4373-416b-9e04-b6ee5c03d112@linaro.org>
Content-Language: en-US
From: Taniya Das <quic_tdas@quicinc.com>
In-Reply-To: <e1ab08cb-4373-416b-9e04-b6ee5c03d112@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: XADHCR6XAwP7Ch702gjyVTfCkprcMuPu
X-Proofpoint-ORIG-GUID: XADHCR6XAwP7Ch702gjyVTfCkprcMuPu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-20_12,2024-06-20_04,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 lowpriorityscore=0 malwarescore=0 mlxscore=0 phishscore=0 mlxlogscore=999
 bulkscore=0 spamscore=0 clxscore=1015 impostorscore=0 priorityscore=1501
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2406210029



On 6/18/2024 6:47 PM, Konrad Dybcio wrote:
> 
> 
> On 6/10/24 11:42, Taniya Das wrote:
>>
>>
>> On 6/4/2024 5:46 PM, Konrad Dybcio wrote:
>>>
>>>
>>> On 5/31/24 13:41, Taniya Das wrote:
>>>> In the cases where the power domain connected to logics is allowed to
>>>> transition from a level(L)-->power collapse(0)-->retention(1) or
>>>> vice versa retention(1)-->power collapse(0)-->level(L)  will cause the
>>>> logic to lose the configurations. The ARC does not support retention
>>>> to collapse transition on MxC rails.
>>>
>>> This is not very legible. Are you saying that:
>>>
>>> a) transitioning to/from LEVEL_RETENTION causes the resource to be 
>>> powered
>>> off internally for some short time and lose state
>>>
>>
>> If there is a logic connected to MxC and the vote on that logic(MXC) 
>> from a subsystem is initially to LEVEL_RETENTION and then to power 
>> collapse [0], then the PLL connected to MxC will loose the contents. 
>> This the transition I am referring here.
> 
> Okay, is there *always* some logic connected to MxC?
> 

 From the clock controller PoV PLLs logic (majorly Multimedia clock 
controller PLLs) would be connected to MxC.
There can be logics from the other subsystems (other than APSS) 
connected to MxC.

>>
>>> or
>>>
>>> b) the linux implementation of rpmhpd handling causes that transition to
>>> include a power collapse step that makes it lose the state
>>
>> No, this is not the case of SW implementation, it is more from the HW 
>> ARC implementation.
>>>
>>> ?
>>>
>>>>
>>>> The targets from SM8450 onwards the PLL logics of clock controllers are
>>>> connected to MxC rails and the recommended configurations are carried
>>>> out during the clock controller probes. The MxC transition as mentioned
>>>> above should be skipped to ensure the PLL settings are intact across
>>>> clock controller power on & off.
>>>
>>> So is this a workaround for clock controller drivers specifically, or 
>>> should
>>> MXC never enter retention, and only poweroff? (the latter sounds like 
>>> it makes
>>> more sense given MXC's purpose)
>>>
>>
>> This is avoid MxC to not enter retention to OFF state.
> 
> I'm still not sure I understand. Is this to prevent MxC being switched off
> while Linux is voting for LEVEL_RETENTION, as RPMh sees no other user and
> decides it's okay to cut the power?
> 

It is to prevent Linux from voting for LEVEL_RETENTION and then voting 
for an OFF state or vice versa. By avoiding this transition we ensure 
that the PLL configurations are not lost.

Other users(subsystems) also avoid voting for RETENTION.

>>
>>>>
>>>> On older generation of targets which supports only Mx the logic is 
>>>> never
>>>> collapsed and it is parked always at RETENTION, thus this issue is 
>>>> never
>>>> observed on those targets.
>>>
>>> "On older targets that do not split MX into MXA and MXC..."
>>
>> Yes, but that is only Mx :).
> 
> My point is about the wording.. There is no such thing as "supporting Mx".
> 

Sure, I can update the commit text in the next patch.

> Konrad

-- 
Thanks & Regards,
Taniya Das.

