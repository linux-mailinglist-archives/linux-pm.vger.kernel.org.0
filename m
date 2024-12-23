Return-Path: <linux-pm+bounces-19724-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F5399FB616
	for <lists+linux-pm@lfdr.de>; Mon, 23 Dec 2024 22:32:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AEE38163ECA
	for <lists+linux-pm@lfdr.de>; Mon, 23 Dec 2024 21:32:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89B581B0F1B;
	Mon, 23 Dec 2024 21:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="dVZRRLCJ"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A360138F82;
	Mon, 23 Dec 2024 21:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734989537; cv=none; b=DfMNe6Kf0LXTD7W+nX4/Q2AfZ+cUsIMVQRtZMfJE2amIb63ArvhptCgfADIitQcYNRGmgsIMxUcotTLRasBf3kC/o1i4zaAr49GGbSu6vdHxIeVWD+uT+d3Zef8lQr6iqqvEm/XeEsEb/wsID1JycLivYzHdk0krq/W3YOz82SQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734989537; c=relaxed/simple;
	bh=5dM4cwKmyqkQKIYfrOAF6YX4sJ7zg2b8M/uaLOHp9IY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ZPTPNne6zDv9vCiHoPV/k2hTz1NYnUf9OX0MK9hWiC4vImND3f5STQR+opC99ZmECCKcMrD+qYC/AFVnyDqIQPbCqFJdu8Ywg8D4szEVElR7bLeaZkqhvSP0gNPzThhB4797HEyGfr2NyeprlO9quWVH8oR/S0sbRe3IDl8b8+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=dVZRRLCJ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BNGstx6021638;
	Mon, 23 Dec 2024 21:32:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	WyLitNd8/tcTwCmNNpcKxCV5OtiO8konOiyjEuvvhf4=; b=dVZRRLCJVdO5FSrN
	g4B0/9z2Okuu9FiuN4WHlfpANGlftfzsfbd8UjRmT5bVCat3oFvoxs+vRlQ8lQaN
	jPhgIc3cbWUW6job2wA7vtTn+BoH/B6kRpBR2SL9KiPuF9Kj/CV6bL8x+krmfTYI
	aRgPL6xa+7289FOb/tLYyya7V9vv9eRUK+q7VzcIE1zE+yjI/UzB9ude3UUwj3dJ
	C0+gdbJW7olsAzIYMZIaR9JMmLxM7plLHWw9WHB2pigo/eLHH2Pe3vEXK7I+BnAd
	/fY5cOTmHQ0oqcfjDoURHseFyIw2K0OXD7jitgKCrFI9KwK/XQ07VaVxdXHwMIsl
	wJlwCQ==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43qbskgqh7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 23 Dec 2024 21:32:03 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4BNLW2uk007421
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 23 Dec 2024 21:32:02 GMT
Received: from [10.216.35.172] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 23 Dec
 2024 13:31:54 -0800
Message-ID: <f1cf95be-af6c-45d9-8e26-2b978327260f@quicinc.com>
Date: Tue, 24 Dec 2024 03:01:51 +0530
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
        Konrad Dybcio
	<konrad.dybcio@oss.qualcomm.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        "Rob
 Herring" <robh@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>
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
	<conor+dt@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <dri-devel@lists.freedesktop.org>, <freedreno@lists.freedesktop.org>,
        <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <devicetree@vger.kernel.org>
References: <mz4zpcr4tqh2w7vt75f4ofxjzfve54ozzgpdbi2jjzk5pdxbk7@t36tlt3mmprt>
 <d858dadb-4098-4c9f-b4f0-393dc988db5f@quicinc.com>
 <4426b4kybtac6rc4twa5pgm3hvlegofemvqjcrvh6ni7f5z2h6@5dnlv3hgywh5>
 <c5e868e1-2dae-466c-a6fc-ef0f247fa0ce@quicinc.com>
 <278e62e1-02a4-4e33-8592-fb4fafcedf7e@quicinc.com>
 <CAA8EJprgshjbNqNErOb06jqV__LmbWvocsK5eD8PQqL+FaLb1g@mail.gmail.com>
 <f67c72c3-7393-47b0-9b9c-1bfadce13110@quicinc.com>
 <CAA8EJppy+V9m-t_qPEJh2iTkC7tyDcf2y8wD9vYoHtFSp=HrkQ@mail.gmail.com>
 <982686bb-0ddd-45a2-b620-564af4f01800@quicinc.com>
 <16e1145c-6ef4-4274-a8f9-966f0edef9fe@oss.qualcomm.com>
 <rzhm6lkryxfqepgejpgmu4mr2z5qlzcvuptmmxhhndafc4kwlo@uw6eiw4cqlmd>
Content-Language: en-US
From: Akhil P Oommen <quic_akhilpo@quicinc.com>
In-Reply-To: <rzhm6lkryxfqepgejpgmu4mr2z5qlzcvuptmmxhhndafc4kwlo@uw6eiw4cqlmd>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: xTIjoKbMsnWqweVOPrd6WnsZlvaUv1A-
X-Proofpoint-ORIG-GUID: xTIjoKbMsnWqweVOPrd6WnsZlvaUv1A-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 priorityscore=1501 spamscore=0 adultscore=0 clxscore=1015 suspectscore=0
 impostorscore=0 malwarescore=0 mlxscore=0 phishscore=0 bulkscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412230190

On 12/23/2024 5:24 PM, Dmitry Baryshkov wrote:
> On Mon, Dec 23, 2024 at 12:31:27PM +0100, Konrad Dybcio wrote:
>> On 4.12.2024 7:18 PM, Akhil P Oommen wrote:
>>> On 11/16/2024 1:17 AM, Dmitry Baryshkov wrote:
>>>> On Fri, 15 Nov 2024 at 19:54, Akhil P Oommen <quic_akhilpo@quicinc.com> wrote:
>>>>>
>>>>> On 11/15/2024 3:54 AM, Dmitry Baryshkov wrote:
>>>>>> Hello Akhil,
>>>>>>
>>>>>> On Thu, 14 Nov 2024 at 20:50, Akhil P Oommen <quic_akhilpo@quicinc.com> wrote:
>>>>>>>
>>>>>>> On 11/1/2024 9:54 PM, Akhil P Oommen wrote:
>>>>>>>> On 10/25/2024 11:58 AM, Dmitry Baryshkov wrote:
>>>>>>>>> On Thu, Oct 24, 2024 at 12:56:58AM +0530, Akhil P Oommen wrote:
>>>>>>>>>> On 10/22/2024 11:19 AM, Krzysztof Kozlowski wrote:
>>>>>>>>>>> On Mon, Oct 21, 2024 at 05:23:43PM +0530, Akhil P Oommen wrote:
>>>>>>>>>>>> Add a new schema which extends opp-v2 to support a new vendor specific
>>>>>>>>>>>> property required for Adreno GPUs found in Qualcomm's SoCs. The new
>>>>>>>>>>>> property called "qcom,opp-acd-level" carries a u32 value recommended
>>>>>>>>>>>> for each opp needs to be shared to GMU during runtime.
>>>>>>>>>>>>
>>>>>>>>>>>> Cc: Rob Clark <robdclark@gmail.com>
>>>>>>>>>>>> Signed-off-by: Akhil P Oommen <quic_akhilpo@quicinc.com>
>>>>>>>>>>>> ---
>>>>>>>>>>>>  .../bindings/opp/opp-v2-qcom-adreno.yaml           | 96 ++++++++++++++++++++++
>>>>>>>>>>>>  1 file changed, 96 insertions(+)
>>>>>>>>>>>>
>>>>>>>>>>>> diff --git a/Documentation/devicetree/bindings/opp/opp-v2-qcom-adreno.yaml b/Documentation/devicetree/bindings/opp/opp-v2-qcom-adreno.yaml
>>>>>>>>>>>> new file mode 100644
>>>>>>>>>>>> index 000000000000..6d50c0405ef8
>>>>>>>>>>>> --- /dev/null
>>>>>>>>>>>> +++ b/Documentation/devicetree/bindings/opp/opp-v2-qcom-adreno.yaml
>>>>>>>>>>>> @@ -0,0 +1,96 @@
>>>>>>>>>>>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>>>>>>>>>>>> +%YAML 1.2
>>>>>>>>>>>> +---
>>>>>>>>>>>> +$id: http://devicetree.org/schemas/opp/opp-v2-qcom-adreno.yaml#
>>>>>>>>>>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>>>>>>>>>>> +
>>>>>>>>>>>> +title: Qualcomm Adreno compatible OPP supply
>>>>>>>>>>>> +
>>>>>>>>>>>> +description:
>>>>>>>>>>>> +  Adreno GPUs present in Qualcomm's Snapdragon chipsets uses an OPP specific
>>>>>>>>>>>> +  ACD related information tailored for the specific chipset. This binding
>>>>>>>>>>>> +  provides the information needed to describe such a hardware value.
>>>>>>>>>>>> +
>>>>>>>>>>>> +maintainers:
>>>>>>>>>>>> +  - Rob Clark <robdclark@gmail.com>
>>>>>>>>>>>> +
>>>>>>>>>>>> +allOf:
>>>>>>>>>>>> +  - $ref: opp-v2-base.yaml#
>>>>>>>>>>>> +
>>>>>>>>>>>> +properties:
>>>>>>>>>>>> +  compatible:
>>>>>>>>>>>> +    items:
>>>>>>>>>>>> +      - const: operating-points-v2-adreno
>>>>>>>>>>>> +      - const: operating-points-v2
>>>>>>>>>>>> +
>>>>>>>>>>>> +patternProperties:
>>>>>>>>>>>> +  '^opp-?[0-9]+$':
>>>>>>>>>>>
>>>>>>>>>>> '-' should not be optional. opp1 is not expected name.
>>>>>>>>>>
>>>>>>>>>> Agree. Will change this to '^opp-[0-9]+$'
>>>>>>>>>>
>>>>>>>>>>>
>>>>>>>>>>>> +    type: object
>>>>>>>>>>>> +    additionalProperties: false
>>>>>>>>>>>> +
>>>>>>>>>>>> +    properties:
>>>>>>>>>>>> +      opp-hz: true
>>>>>>>>>>>> +
>>>>>>>>>>>> +      opp-level: true
>>>>>>>>>>>> +
>>>>>>>>>>>> +      opp-peak-kBps: true
>>>>>>>>>>>> +
>>>>>>>>>>>> +      opp-supported-hw: true
>>>>>>>>>>>> +
>>>>>>>>>>>> +      qcom,opp-acd-level:
>>>>>>>>>>>> +        description: |
>>>>>>>>>>>> +          A positive value representing the ACD (Adaptive Clock Distribution,
>>>>>>>>>>>> +          a fancy name for clk throttling during voltage droop) level associated
>>>>>>>>>>>> +          with this OPP node. This value is shared to a co-processor inside GPU
>>>>>>>>>>>> +          (called Graphics Management Unit a.k.a GMU) during wake up. It may not
>>>>>>>>>>>> +          be present for some OPPs and GMU will disable ACD while transitioning
>>>>>>>>>>>> +          to that OPP. This value encodes a voltage threshold and few other knobs
>>>>>>>>>>>> +          which are identified by characterization of the SoC. So, it doesn't have
>>>>>>>>>>>> +          any unit.
>>>>>>>>>>>
>>>>>>>>>>> Thanks for explanation and other updates. I am still not happy with this
>>>>>>>>>>> property. I do not see reason why DT should encode magic values in a
>>>>>>>>>>> quite generic piece of code. This creates poor ABI, difficult to
>>>>>>>>>>> maintain or understand.
>>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>> Configuring GPU ACD block with its respective value is a requirement for each OPP.
>>>>>>>>>> So OPP node seems like the natural place for this data.
>>>>>>>>>>
>>>>>>>>>> If it helps to resolve your concerns, I can elaborate the documentation with
>>>>>>>>>> details on the GMU HFI interface where this value should be passed on to the
>>>>>>>>>> hardware. Also replace "few other knobs" with "Delay cycles & Calibration margin"
>>>>>>>>>> in the above doc.
>>>>>>>>>
>>>>>>>>> Usually the preference for DT is to specify data in a sensible way
>>>>>>>>> rather than just the values being programmed to the register. Is it
>>>>>>>>> possible to implement this approach for ACD values?
>>>>>>>
>>>>>>> Krzysztof/Dmitry,
>>>>>>>
>>>>>>> BIT(0)-BIT(15) are static configurations which doesn't change between
>>>>>>> OPPs. We can move it to driver.
>>>>>>>
>>>>>>> BIT(16)-BIT(31) indicates a threshold margin which triggers ACD. We can
>>>>>>> keep this in the devicetree. And the driver can construct the final
>>>>>>> value from both data and send it to GMU.
>>>>>>>
>>>>>>> If this is acceptable, I will send the v3 revision.
>>>>>>
>>>>>> Can the upper bitfield have a sensible representation in DT (like uV
>>>>>> or something similar)?
>>>>>
>>>>> Closest approximation is quantized voltage steps. So, unit-less.
>>>>> Converting it to the exact voltage requires identifying the pmic voltage
>>>>> steps and other stuffs which are outside of my expertise.
>>>>>
>>>>> It is convenient if we can abstract it as an integer which correlates
>>>>> with the voltage margin that should be maintained for each regulator corner.
>>>
>>> Krzysztof,
>>>
>>> Could you please confirm if this approach would be acceptable?
>>>
>>> To reiterate, move the lower 16 bits which is same across OPPs to the
>>> driver. Abstract the higher 16 bits as number of quantized voltage
>>> margin when ACD mitigation gets triggered.
>>
>> I know I'm not Krzysztof, but given this is ultimately a magic value
>> passed to the firmware, I'm a bit lukewarm on decomposing it and would
>> rather see the entire 32b passed in a property, so that if a future
>> target needs a different constant in the lower word, we don't have to
>> pull our hair out again, trying to add more spaghetti logic to account
>> for that.
> 
> Also obviously being non-Krzysztof, if we don't have a semantic value
> for the upper half I'm fine with having the magic value as a single
> instance instead of spreading it between two places.

If there is a general consensus, I will send out another revision with
some minor updates.

-Akhil.

> 


