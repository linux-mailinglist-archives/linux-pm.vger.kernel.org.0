Return-Path: <linux-pm+bounces-31062-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D8A6B0A7EA
	for <lists+linux-pm@lfdr.de>; Fri, 18 Jul 2025 17:52:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C10961896269
	for <lists+linux-pm@lfdr.de>; Fri, 18 Jul 2025 15:52:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 001D02E5B0C;
	Fri, 18 Jul 2025 15:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="hvjsz9KN"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B0122E54DD;
	Fri, 18 Jul 2025 15:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752853919; cv=none; b=HJSTGyaA7+GHmY0Vxwu0Yvcvl5LGNMMsWKTU193z/QaxAMEJAqcwamGCQnDpH77/hG2f3xzN5hAWX+dhEecYFt6/bs0bPqe5/YwWxAPA3A1CU2dj6YHOaaAA9iBgltU+6t+/t0v3nsfNFTC//6HSy8YXXKQa1swC5EnfoUqyIH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752853919; c=relaxed/simple;
	bh=ZmLI6Lb1LvfHG6SCEsSJziJG2r4OiqLyWXnZcvnsj28=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=W0OmovBniFlw7NmjORxyTaw9B+ATjT+xDtGQaPyUOp1FoB65MoFsHY10RLnSpqnw23evcqBD3VW/zvhJcySzIVXRtSrUnFxVD1NhLbZZdOqiwp4HeLt4a7JMPDYvBrfzyuLQbS1DlJ/gdDDv64yIWvN4SGdzefVfxiRlCr1P8lU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=hvjsz9KN; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56I82XQK008788;
	Fri, 18 Jul 2025 15:51:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	2MwpE18oEWe1TtY+7fRTUbZYuWq3/eUiaszGmutvhXc=; b=hvjsz9KNImQc69k6
	B57Q7A/nEjvt48CWpwZOfm0hPQ6V41r5vWikejleKnXpg7quK0qRrugRZYX7t/VT
	YipSPxQb8X3wzXbw1Z2RMLqqeIq1r0+7D6WvUVKcLmxrz1zH/qL7FwV7g+Wbb6lL
	RyA+iYmOUet4bnUj2j86ChPl5sV7FRN1mvFoMHgmwuLSFFsmiVDQk7YfMWvx/QxM
	3qdcM0dUOiOFMxHlhRgfrDQ75jpD/HUvA10d5oNPrhmpxtFb0u2cj3+qdNC8VVCv
	1z/RLHC73W+V+TxpyKchtkyuAB7cL4Foe+76fhBCO++r/KNvgR4sGvkDEfpfixX+
	Oh0m8w==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47ufxbc5tc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 18 Jul 2025 15:51:44 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 56IFphaO006119
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 18 Jul 2025 15:51:43 GMT
Received: from [10.253.76.178] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Fri, 18 Jul
 2025 08:51:36 -0700
Message-ID: <830f3989-d1ac-4b7c-8888-397452fe0abe@quicinc.com>
Date: Fri, 18 Jul 2025 23:51:34 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 05/10] dt-bindings: clock: ipq9574: Rename NSS CC
 source clocks to drop rate
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Rob Herring
	<robh@kernel.org>
CC: Georgi Djakov <djakov@kernel.org>,
        Krzysztof Kozlowski
	<krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson
	<andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        "Stephen
 Boyd" <sboyd@kernel.org>,
        Anusha Rao <quic_anusha@quicinc.com>,
        Konrad Dybcio
	<konradybcio@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        "Richard
 Cochran" <richardcochran@gmail.com>,
        Catalin Marinas
	<catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <netdev@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <quic_kkumarcs@quicinc.com>, <quic_linchen@quicinc.com>,
        <quic_leiwei@quicinc.com>, <quic_pavir@quicinc.com>,
        <quic_suruchia@quicinc.com>
References: <20250710-qcom_ipq5424_nsscc-v3-0-f149dc461212@quicinc.com>
 <20250710-qcom_ipq5424_nsscc-v3-5-f149dc461212@quicinc.com>
 <20250710225412.GA25762-robh@kernel.org>
 <93082ccd-40d2-4a6b-a526-c118c1730a45@oss.qualcomm.com>
 <2f37c7e7-b07b-47c7-904b-5756c4cf5887@quicinc.com>
 <a383041e-7b70-4ffd-ae15-2412b2f83770@oss.qualcomm.com>
Content-Language: en-US
From: Luo Jie <quic_luoj@quicinc.com>
In-Reply-To: <a383041e-7b70-4ffd-ae15-2412b2f83770@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: swRjQQ_PQW7tkbAY8VLMWgv-9_THV1oX
X-Proofpoint-ORIG-GUID: swRjQQ_PQW7tkbAY8VLMWgv-9_THV1oX
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE4MDEyMyBTYWx0ZWRfX0rs5m2C5d6kq
 iOCt6fzRXoqLcO+VZqKrhn2T/n1JPvh4kMObWVCir6flsG/WvmGHPln2rTlPSXVuOyF3ZNR/vLK
 1ttQGcOS9Rqp3T1GHWxOvLKIuBDylXWTI4ncoRtx4LDI360HJfLrE4ojeSKSj87AREHUW0nsMzN
 a1omT0z7UCJSmgVJtCX+N0KF03kHaRsTIzh9F0XWokoN1Sjt66NUf1dVyjdg/jwhTgiqH7P1mKS
 cULx+yur6mxu0VcaqFU/RqQAnYnVGWxGWjCZ+flHvRE9pYmFex3mibflqi/bnou4zQ1bSdulCac
 r3qnCNZZckY4F1mLL32IuuVswoNuCwO2is3/Hccc1wlFtt5o0KDcuxV+qlSQn0Npxwi8fPO0Yvy
 prHagNyramkTOU7PfvfJjv33Eb9E77R2ZeuAImyTIGm0jJzEDoxhsq+rG+1BrBmP6FncA+5R
X-Authority-Analysis: v=2.4 cv=Xc2JzJ55 c=1 sm=1 tr=0 ts=687a6d90 cx=c_pps
 a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=VwQbUJbxAAAA:8
 a=an1i8R5mwEVpawc4EucA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-18_03,2025-07-17_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 mlxscore=0 priorityscore=1501 adultscore=0 mlxlogscore=999
 phishscore=0 suspectscore=0 spamscore=0 lowpriorityscore=0 impostorscore=0
 clxscore=1015 malwarescore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507180123



On 7/18/2025 5:28 PM, Konrad Dybcio wrote:
> On 7/18/25 11:12 AM, Luo Jie wrote:
>>
>>
>> On 7/11/2025 8:15 PM, Konrad Dybcio wrote:
>>> On 7/11/25 12:54 AM, Rob Herring wrote:
>>>> On Thu, Jul 10, 2025 at 08:28:13PM +0800, Luo Jie wrote:
>>>>> Drop the clock rate suffix from the NSS Clock Controller clock names for
>>>>> PPE and NSS clocks. A generic name allows for easier extension of support
>>>>> to additional SoCs that utilize same hardware design.
>>>>
>>>> This is an ABI change. You must state that here and provide a reason the
>>>> change is okay (assuming it is). Otherwise, you are stuck with the name
>>>> even if not optimal.
>>>
>>> The reason here seems to be simplifying the YAML.. which is not a good
>>> reason really..
>>>
>>> I would instead suggest keeping the clocks list as-is for ipq9574 (this
>>> existing case), whereas improving it for any new additions
>>>
>>> Konrad
>>
>> Thanks Rob and Konrad for the comments.
>>
>> "nss_1200" and "nss" refer to the same clock pin on different SoC.
>> As per Krzystof's previous comment on V2, including the frequency
>> as a suffix in the clock name is not required, since only the
>> frequencies vary across different IPQ SoCs, while the source clock
>> pins for 'PPE' and 'NSS' clocks are the same. Hence this ABI change
>> was deemed necessary.
>>
>> By removing the frequency suffix, the device tree bindings becomes
>> more flexible and easier to extend for supporting new hardware
>> variants in the future.
>>
>> Impact due to this ABI change: The NSS clock controller node is only
>> enabled for the IPQ9574 DTS. In this patch series, the corresponding
>> DTS changes for IPQ9574 are also included to align with this ABI
>> change.
> 
> The point of an ABI is to keep exposing the same interface without
> any change requirements, i.e. if a customer ships the DT from
> torvalds/master in firmware and is not willing to update it, they
> can no longer update the kernel without a workaround.
> 
>> Please let me know if further clarification or adjustments are needed.
> 
> What we're asking for is that you don't alter the name on the
> existing platform, but use a no-suffix version for the ones you
> introduce going forward
> 
> i.e. (pseudo-YAML)
> 
> if:
>    properties:
>      compatible:
>        - const: qcom,ipq9574-nsscc
> then:
>    properties:
>      clock-names:
>        items:
>          - clockname_1200
> else:
>    properties:
>      clock-names:
>        items:
>          - clockname # no suffix
> 
> Konrad

We had adopted this proposal in version 2 previously, but as noted in
the discussion linked below, Krzysztof had suggested to avoid using the
clock rate in the clock names when defining the constraints for them.
However I do agree that we should keep the interface for IPQ9574
unchanged and instead use a generic clock name to support the newer
SoCs.

https://lore.kernel.org/all/20250701-optimistic-esoteric-swallow-d93fc6@krzk-bin/

Request Krzysztof to provide his comments as well, on whether we can
follow your suggested approach to avoid breaking ABI for IPQ9574.


