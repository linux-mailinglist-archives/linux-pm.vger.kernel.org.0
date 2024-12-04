Return-Path: <linux-pm+bounces-18563-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8219E9E432F
	for <lists+linux-pm@lfdr.de>; Wed,  4 Dec 2024 19:19:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 325F728981E
	for <lists+linux-pm@lfdr.de>; Wed,  4 Dec 2024 18:19:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A2371A8F8E;
	Wed,  4 Dec 2024 18:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="HbZVa5qU"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37023183CC1;
	Wed,  4 Dec 2024 18:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733336334; cv=none; b=Lptoozt8OpTiE2svj//cGcmLGnrNahHYd5qhxu476/8nbyT5JD13FP/LWo8XcmXnA+4vC6jzQiRNo5AwxirMVH7g7PtU717E4YBDL3O8BCP0P9YTCA0ExgHPvbBG/gSGmbs3qiaYUohJKeLbvSxcbuSnE0m386ZOCW0VHXpZOoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733336334; c=relaxed/simple;
	bh=35O2qOEEDqk4rGLxxPrsZzMnhTaHUW28oZ0mxOBlfBw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=rDXQ8IYlJLowoeH4qnyw/JsdbfCMysg7eWSxn6ewRWzkyTTYVCT8cZvujA7OBHpRUYuLYiocQU3lG/xaUdYFGSohj0MGan63qVxj8aL4d/9UiNbj+7ofk/nG5Gl6BhK6fgWiLMVOnqi67EjDQ5nGbxS9hBhkghsxre3h9KGsDao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=HbZVa5qU; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B4FwgYw010257;
	Wed, 4 Dec 2024 18:18:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	QWatU+h2tMlWKUWIV6wKORAB9sEqTdJL5tW0x2dZ7AQ=; b=HbZVa5qU8kB2V9VA
	42Zci/QRMziiYa9sWODs9HumViuhvF0Nkx2+lkoGyhpx55AUIit+UKLRUZRWHO1Y
	Pn6I6br910kdcqjLVxyiYHWwDlnOfSHCy3+I36uPE1wvJT4pN08I+1ssPW5j7San
	kmjIhn8FTupKQzdp/we3kMi8Hy2secbKAogppbLc0P0C+ZqRRoFvJKI5SZ+tljCQ
	X+rPyquj04ytVSc4Drh/tEJ74ErB+6eAWHYFeDHt9DMdT34UJt9ocvmGt2NjJi1D
	ul9ntENae21jINdp0aXb4jp42YvZIzTWl6LEixaiym0LfMxlsVR+wdyNx/lw6EaI
	MO/2WQ==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 439v7yw8rx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 04 Dec 2024 18:18:37 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4B4IIZW2027888
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 4 Dec 2024 18:18:36 GMT
Received: from [10.216.22.114] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 4 Dec 2024
 10:18:29 -0800
Message-ID: <982686bb-0ddd-45a2-b620-564af4f01800@quicinc.com>
Date: Wed, 4 Dec 2024 23:48:27 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] dt-bindings: opp: Add v2-qcom-adreno vendor
 bindings
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Krzysztof Kozlowski
	<krzk@kernel.org>, Rob Herring <robh@kernel.org>
CC: Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        "Konrad
 Dybcio" <konradybcio@kernel.org>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie
	<airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Viresh Kumar
	<vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd
	<sboyd@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
        <freedreno@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, <devicetree@vger.kernel.org>
References: <20241021-gpu-acd-v2-0-9c25a62803bc@quicinc.com>
 <20241021-gpu-acd-v2-2-9c25a62803bc@quicinc.com>
 <mz4zpcr4tqh2w7vt75f4ofxjzfve54ozzgpdbi2jjzk5pdxbk7@t36tlt3mmprt>
 <d858dadb-4098-4c9f-b4f0-393dc988db5f@quicinc.com>
 <4426b4kybtac6rc4twa5pgm3hvlegofemvqjcrvh6ni7f5z2h6@5dnlv3hgywh5>
 <c5e868e1-2dae-466c-a6fc-ef0f247fa0ce@quicinc.com>
 <278e62e1-02a4-4e33-8592-fb4fafcedf7e@quicinc.com>
 <CAA8EJprgshjbNqNErOb06jqV__LmbWvocsK5eD8PQqL+FaLb1g@mail.gmail.com>
 <f67c72c3-7393-47b0-9b9c-1bfadce13110@quicinc.com>
 <CAA8EJppy+V9m-t_qPEJh2iTkC7tyDcf2y8wD9vYoHtFSp=HrkQ@mail.gmail.com>
Content-Language: en-US
From: Akhil P Oommen <quic_akhilpo@quicinc.com>
In-Reply-To: <CAA8EJppy+V9m-t_qPEJh2iTkC7tyDcf2y8wD9vYoHtFSp=HrkQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 5DXGYqj1RVnQ5CFSS6j-NbPDnBrSAzYb
X-Proofpoint-GUID: 5DXGYqj1RVnQ5CFSS6j-NbPDnBrSAzYb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxscore=0
 impostorscore=0 adultscore=0 priorityscore=1501 clxscore=1015
 lowpriorityscore=0 suspectscore=0 mlxlogscore=999 malwarescore=0
 bulkscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412040139

On 11/16/2024 1:17 AM, Dmitry Baryshkov wrote:
> On Fri, 15 Nov 2024 at 19:54, Akhil P Oommen <quic_akhilpo@quicinc.com> wrote:
>>
>> On 11/15/2024 3:54 AM, Dmitry Baryshkov wrote:
>>> Hello Akhil,
>>>
>>> On Thu, 14 Nov 2024 at 20:50, Akhil P Oommen <quic_akhilpo@quicinc.com> wrote:
>>>>
>>>> On 11/1/2024 9:54 PM, Akhil P Oommen wrote:
>>>>> On 10/25/2024 11:58 AM, Dmitry Baryshkov wrote:
>>>>>> On Thu, Oct 24, 2024 at 12:56:58AM +0530, Akhil P Oommen wrote:
>>>>>>> On 10/22/2024 11:19 AM, Krzysztof Kozlowski wrote:
>>>>>>>> On Mon, Oct 21, 2024 at 05:23:43PM +0530, Akhil P Oommen wrote:
>>>>>>>>> Add a new schema which extends opp-v2 to support a new vendor specific
>>>>>>>>> property required for Adreno GPUs found in Qualcomm's SoCs. The new
>>>>>>>>> property called "qcom,opp-acd-level" carries a u32 value recommended
>>>>>>>>> for each opp needs to be shared to GMU during runtime.
>>>>>>>>>
>>>>>>>>> Cc: Rob Clark <robdclark@gmail.com>
>>>>>>>>> Signed-off-by: Akhil P Oommen <quic_akhilpo@quicinc.com>
>>>>>>>>> ---
>>>>>>>>>  .../bindings/opp/opp-v2-qcom-adreno.yaml           | 96 ++++++++++++++++++++++
>>>>>>>>>  1 file changed, 96 insertions(+)
>>>>>>>>>
>>>>>>>>> diff --git a/Documentation/devicetree/bindings/opp/opp-v2-qcom-adreno.yaml b/Documentation/devicetree/bindings/opp/opp-v2-qcom-adreno.yaml
>>>>>>>>> new file mode 100644
>>>>>>>>> index 000000000000..6d50c0405ef8
>>>>>>>>> --- /dev/null
>>>>>>>>> +++ b/Documentation/devicetree/bindings/opp/opp-v2-qcom-adreno.yaml
>>>>>>>>> @@ -0,0 +1,96 @@
>>>>>>>>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>>>>>>>>> +%YAML 1.2
>>>>>>>>> +---
>>>>>>>>> +$id: http://devicetree.org/schemas/opp/opp-v2-qcom-adreno.yaml#
>>>>>>>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>>>>>>>> +
>>>>>>>>> +title: Qualcomm Adreno compatible OPP supply
>>>>>>>>> +
>>>>>>>>> +description:
>>>>>>>>> +  Adreno GPUs present in Qualcomm's Snapdragon chipsets uses an OPP specific
>>>>>>>>> +  ACD related information tailored for the specific chipset. This binding
>>>>>>>>> +  provides the information needed to describe such a hardware value.
>>>>>>>>> +
>>>>>>>>> +maintainers:
>>>>>>>>> +  - Rob Clark <robdclark@gmail.com>
>>>>>>>>> +
>>>>>>>>> +allOf:
>>>>>>>>> +  - $ref: opp-v2-base.yaml#
>>>>>>>>> +
>>>>>>>>> +properties:
>>>>>>>>> +  compatible:
>>>>>>>>> +    items:
>>>>>>>>> +      - const: operating-points-v2-adreno
>>>>>>>>> +      - const: operating-points-v2
>>>>>>>>> +
>>>>>>>>> +patternProperties:
>>>>>>>>> +  '^opp-?[0-9]+$':
>>>>>>>>
>>>>>>>> '-' should not be optional. opp1 is not expected name.
>>>>>>>
>>>>>>> Agree. Will change this to '^opp-[0-9]+$'
>>>>>>>
>>>>>>>>
>>>>>>>>> +    type: object
>>>>>>>>> +    additionalProperties: false
>>>>>>>>> +
>>>>>>>>> +    properties:
>>>>>>>>> +      opp-hz: true
>>>>>>>>> +
>>>>>>>>> +      opp-level: true
>>>>>>>>> +
>>>>>>>>> +      opp-peak-kBps: true
>>>>>>>>> +
>>>>>>>>> +      opp-supported-hw: true
>>>>>>>>> +
>>>>>>>>> +      qcom,opp-acd-level:
>>>>>>>>> +        description: |
>>>>>>>>> +          A positive value representing the ACD (Adaptive Clock Distribution,
>>>>>>>>> +          a fancy name for clk throttling during voltage droop) level associated
>>>>>>>>> +          with this OPP node. This value is shared to a co-processor inside GPU
>>>>>>>>> +          (called Graphics Management Unit a.k.a GMU) during wake up. It may not
>>>>>>>>> +          be present for some OPPs and GMU will disable ACD while transitioning
>>>>>>>>> +          to that OPP. This value encodes a voltage threshold and few other knobs
>>>>>>>>> +          which are identified by characterization of the SoC. So, it doesn't have
>>>>>>>>> +          any unit.
>>>>>>>>
>>>>>>>> Thanks for explanation and other updates. I am still not happy with this
>>>>>>>> property. I do not see reason why DT should encode magic values in a
>>>>>>>> quite generic piece of code. This creates poor ABI, difficult to
>>>>>>>> maintain or understand.
>>>>>>>>
>>>>>>>
>>>>>>> Configuring GPU ACD block with its respective value is a requirement for each OPP.
>>>>>>> So OPP node seems like the natural place for this data.
>>>>>>>
>>>>>>> If it helps to resolve your concerns, I can elaborate the documentation with
>>>>>>> details on the GMU HFI interface where this value should be passed on to the
>>>>>>> hardware. Also replace "few other knobs" with "Delay cycles & Calibration margin"
>>>>>>> in the above doc.
>>>>>>
>>>>>> Usually the preference for DT is to specify data in a sensible way
>>>>>> rather than just the values being programmed to the register. Is it
>>>>>> possible to implement this approach for ACD values?
>>>>
>>>> Krzysztof/Dmitry,
>>>>
>>>> BIT(0)-BIT(15) are static configurations which doesn't change between
>>>> OPPs. We can move it to driver.
>>>>
>>>> BIT(16)-BIT(31) indicates a threshold margin which triggers ACD. We can
>>>> keep this in the devicetree. And the driver can construct the final
>>>> value from both data and send it to GMU.
>>>>
>>>> If this is acceptable, I will send the v3 revision.
>>>
>>> Can the upper bitfield have a sensible representation in DT (like uV
>>> or something similar)?
>>
>> Closest approximation is quantized voltage steps. So, unit-less.
>> Converting it to the exact voltage requires identifying the pmic voltage
>> steps and other stuffs which are outside of my expertise.
>>
>> It is convenient if we can abstract it as an integer which correlates
>> with the voltage margin that should be maintained for each regulator corner.

Krzysztof,

Could you please confirm if this approach would be acceptable?

To reiterate, move the lower 16 bits which is same across OPPs to the
driver. Abstract the higher 16 bits as number of quantized voltage
margin when ACD mitigation gets triggered.

-Akhil.

> 
> I'd say, this is up to the DT maintainers then.
> 
>>
>> -Akhil.
>>
>>>
>>>>
>>>> -Akhil.
>>>>
>>>>>
>>>>> I am still checking about this. Will get back.
>>>>>
>>>>> -Akhil
>>>>>
>>>>>>
>>>>>>>
>>>>>>>>
>>>>>>
>>>>>
>>>>
>>>
>>>
>>
> 
> 


