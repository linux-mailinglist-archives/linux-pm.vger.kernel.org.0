Return-Path: <linux-pm+bounces-16322-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A18D9AD4C8
	for <lists+linux-pm@lfdr.de>; Wed, 23 Oct 2024 21:27:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B1031C2083F
	for <lists+linux-pm@lfdr.de>; Wed, 23 Oct 2024 19:27:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B3091D89E3;
	Wed, 23 Oct 2024 19:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="F3DKtvKD"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 872D01AD3F6;
	Wed, 23 Oct 2024 19:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729711643; cv=none; b=kGcEhU1qNWEXqXl9xOIG5bxcJ/CBySCaMR4dQqmFwe2oBLSIjyCNUspNhnIAlebfmmsfrQ/WJS9Tit0FGONYSnmLkuBixytLpPP1G6xQl7cLBA53TcgFCvtUspLF9RaeaJBx3d+zPwqWndXYbYzdNKZMu5i/v/RZHIGr9xCY2+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729711643; c=relaxed/simple;
	bh=IqtiVFYWsES8xg3HHkSQZ/U5gu+TdGMCabRbRggQhFk=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=in9kBvVR2OXjgaVIIb36cUNxYC+ufKKEc/tdBkjrIBmo/pITHDB0YOvdwupmQyBT2AKvqywnroD+4GIn2ixkwAymMbvijdI7INFmm93s+F0np5IK5gnJyL4LAfxk0XjRopE2IBjvgm6NCfYpVZ8oTLmf2ow5XrCscfuNbwHl2WU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=F3DKtvKD; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49N9sMo0018092;
	Wed, 23 Oct 2024 19:27:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	hbHEZ3g8fq7hQtiuP2HIxsItu1akAG8bAAbZChe0ops=; b=F3DKtvKDXJMiM59G
	qXmN8NYJmda6LAMo2Qzl0ALxNkxC6n8r8HAXQPx9LbeS8P66B7+1RLpdUcuCNxUr
	LwDAOnfYuwLaPT9gwX3wY+EBeIpp22dGDwAH4zg/MkIS8FrVD53rjs6sNXVz7b96
	AXTjXuBLz/uzX3Pum6kVRiUaBoZsfogTgrUyIyOeNJefnqSerKJ1zGNc8Q1RFKBx
	73QaR0aqcJrX2tmGkrS5Cpb+urQtnYLxWI0Wms5TDi3rIZGRXUqsNVBKiJ1oU+z4
	Cmc875avfrm31cYTAiNiWtnA/kGsuB9qBpoQ03+C0qbEZC/ceVTvsCla/uytqu5u
	R9eh3g==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42em3wb9re-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 23 Oct 2024 19:27:09 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 49NJR7iA027983
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 23 Oct 2024 19:27:07 GMT
Received: from [10.216.22.63] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 23 Oct
 2024 12:27:01 -0700
Message-ID: <d858dadb-4098-4c9f-b4f0-393dc988db5f@quicinc.com>
Date: Thu, 24 Oct 2024 00:56:58 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] dt-bindings: opp: Add v2-qcom-adreno vendor
 bindings
To: Krzysztof Kozlowski <krzk@kernel.org>
CC: Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        "Konrad
 Dybcio" <konradybcio@kernel.org>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Marijn Suijten
	<marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, "Simona
 Vetter" <simona@ffwll.ch>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon
	<nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
        <freedreno@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, <devicetree@vger.kernel.org>
References: <20241021-gpu-acd-v2-0-9c25a62803bc@quicinc.com>
 <20241021-gpu-acd-v2-2-9c25a62803bc@quicinc.com>
 <mz4zpcr4tqh2w7vt75f4ofxjzfve54ozzgpdbi2jjzk5pdxbk7@t36tlt3mmprt>
Content-Language: en-US
From: Akhil P Oommen <quic_akhilpo@quicinc.com>
In-Reply-To: <mz4zpcr4tqh2w7vt75f4ofxjzfve54ozzgpdbi2jjzk5pdxbk7@t36tlt3mmprt>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: sygsDimvIhAM-eyZUnFnjmWrKR5d0XeP
X-Proofpoint-ORIG-GUID: sygsDimvIhAM-eyZUnFnjmWrKR5d0XeP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 malwarescore=0
 mlxscore=0 lowpriorityscore=0 phishscore=0 impostorscore=0 clxscore=1015
 priorityscore=1501 mlxlogscore=999 suspectscore=0 bulkscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2409260000
 definitions=main-2410230125

On 10/22/2024 11:19 AM, Krzysztof Kozlowski wrote:
> On Mon, Oct 21, 2024 at 05:23:43PM +0530, Akhil P Oommen wrote:
>> Add a new schema which extends opp-v2 to support a new vendor specific
>> property required for Adreno GPUs found in Qualcomm's SoCs. The new
>> property called "qcom,opp-acd-level" carries a u32 value recommended
>> for each opp needs to be shared to GMU during runtime.
>>
>> Cc: Rob Clark <robdclark@gmail.com>
>> Signed-off-by: Akhil P Oommen <quic_akhilpo@quicinc.com>
>> ---
>>  .../bindings/opp/opp-v2-qcom-adreno.yaml           | 96 ++++++++++++++++++++++
>>  1 file changed, 96 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/opp/opp-v2-qcom-adreno.yaml b/Documentation/devicetree/bindings/opp/opp-v2-qcom-adreno.yaml
>> new file mode 100644
>> index 000000000000..6d50c0405ef8
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/opp/opp-v2-qcom-adreno.yaml
>> @@ -0,0 +1,96 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/opp/opp-v2-qcom-adreno.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Qualcomm Adreno compatible OPP supply
>> +
>> +description:
>> +  Adreno GPUs present in Qualcomm's Snapdragon chipsets uses an OPP specific
>> +  ACD related information tailored for the specific chipset. This binding
>> +  provides the information needed to describe such a hardware value.
>> +
>> +maintainers:
>> +  - Rob Clark <robdclark@gmail.com>
>> +
>> +allOf:
>> +  - $ref: opp-v2-base.yaml#
>> +
>> +properties:
>> +  compatible:
>> +    items:
>> +      - const: operating-points-v2-adreno
>> +      - const: operating-points-v2
>> +
>> +patternProperties:
>> +  '^opp-?[0-9]+$':
> 
> '-' should not be optional. opp1 is not expected name.

Agree. Will change this to '^opp-[0-9]+$'

> 
>> +    type: object
>> +    additionalProperties: false
>> +
>> +    properties:
>> +      opp-hz: true
>> +
>> +      opp-level: true
>> +
>> +      opp-peak-kBps: true
>> +
>> +      opp-supported-hw: true
>> +
>> +      qcom,opp-acd-level:
>> +        description: |
>> +          A positive value representing the ACD (Adaptive Clock Distribution,
>> +          a fancy name for clk throttling during voltage droop) level associated
>> +          with this OPP node. This value is shared to a co-processor inside GPU
>> +          (called Graphics Management Unit a.k.a GMU) during wake up. It may not
>> +          be present for some OPPs and GMU will disable ACD while transitioning
>> +          to that OPP. This value encodes a voltage threshold and few other knobs
>> +          which are identified by characterization of the SoC. So, it doesn't have
>> +          any unit.
> 
> Thanks for explanation and other updates. I am still not happy with this
> property. I do not see reason why DT should encode magic values in a
> quite generic piece of code. This creates poor ABI, difficult to
> maintain or understand.
> 

Configuring GPU ACD block with its respective value is a requirement for each OPP.
So OPP node seems like the natural place for this data.

If it helps to resolve your concerns, I can elaborate the documentation with
details on the GMU HFI interface where this value should be passed on to the
hardware. Also replace "few other knobs" with "Delay cycles & Calibration margin"
in the above doc.
 
> 
>> +        $ref: /schemas/types.yaml#/definitions/uint32
>> +
>> +    required:
>> +      - opp-hz
>> +      - opp-level
>> +
>> +required:
>> +  - compatible
>> +
>> +additionalProperties: false
>> +
>> +examples:
>> +  - |
>> +    #include <dt-bindings/power/qcom-rpmpd.h>
>> +
>> +    gpu_opp_table: opp-table {
>> +        compatible = "operating-points-v2-adreno", "operating-points-v2";
>> +
>> +        opp-687000000 {
>> +                opp-hz = /bits/ 64 <687000000>;
> 
> Messed indentation.

It seems my text editor got confused here. Will fix.

Thanks,
-Akhil

> 
> Best regards,
> Krzysztof
> 
> 


