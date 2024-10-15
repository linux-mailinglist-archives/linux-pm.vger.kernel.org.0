Return-Path: <linux-pm+bounces-15685-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E088E99F6E9
	for <lists+linux-pm@lfdr.de>; Tue, 15 Oct 2024 21:15:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EF2B6B220F9
	for <lists+linux-pm@lfdr.de>; Tue, 15 Oct 2024 19:15:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D40F1B6CEB;
	Tue, 15 Oct 2024 19:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="f+jLyJa8"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FC481F80A0;
	Tue, 15 Oct 2024 19:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729019622; cv=none; b=CmQYjtXHRez+86RCW7N4kESYeBJBHQ00dvg6q0gneXi2rAqrwkbXeVJmk3q4hjipaKHpM5r2jAF/4OgoeFLEe1pHYgC2Zu96S+lg/HZ4RPpjMU0VZ/ppV4Mzmsn9W2Ez9dtivg2yxdMhEecUzdLNb/lZQEzSq+4eI6nTrzzOv6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729019622; c=relaxed/simple;
	bh=xumNtb7C7mtEyLdCIebhKcQvqQVpU91HwAdgSoU5SFg=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u1hxN6ILg54/ZS01+2HnBAaxfN2KpiyzBBq9y8Fd0qTG5tTXiYQsgE43rSteb3QRrw/zWZHYvxCn5hljm2Smyk1KG9Z9L0JoCTFn7FxyIMNIJhkrpX5FFSB5bU84cQlz6HlhN9hRILWiNVWnIST9o7h+Fu+oc1E5SSTWpPluvc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=f+jLyJa8; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49FEQU9B025208;
	Tue, 15 Oct 2024 19:13:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=ik0gyWn5BEG8mn8v3k8sw3jr
	s9Jk2xLSBAZEX7XSHWo=; b=f+jLyJa8LFG7TFdZyLD2tT74HX8BsRoP4g6LA+G6
	aI27pCvm3oNMRJMyJ+QqqTHoFi0PsOjMFmAeU3oc+9yqWBoekM1ycvOU65shHMsx
	+3D2GjJ7vnZcnO+Rsmd+51Sp5i6n3YDXBNyCEoopomQpmjr/bYPIhddV7cyZeTqo
	RJcNrXUI1HuXycQei2jTNKIskyPnfy8WWnc/BPQDOBRXylKbfP8dj/2KQvQQ8qSL
	lZY2muhTEZv+mljTMlb1YA0jpqpEERPtfR1+/YvS6TzsHXqPrt9ZuuDNt9Db3g/T
	VlJKLfMPv1SXaJl/35HYkbsYfdh0GIprLZ+ueoAp55xc1Q==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 429t5kgwqy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 15 Oct 2024 19:13:25 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 49FJDPZu016257
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 15 Oct 2024 19:13:25 GMT
Received: from hu-akhilpo-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 15 Oct 2024 12:13:18 -0700
Date: Wed, 16 Oct 2024 00:43:14 +0530
From: Akhil P Oommen <quic_akhilpo@quicinc.com>
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
Subject: Re: [PATCH RFC 2/3] dt-bindings: opp: Add v2-qcom-adreno vendor
 bindings
Message-ID: <20241015191314.pbz5v5u65gbpjheg@hu-akhilpo-hyd.qualcomm.com>
References: <20241012-gpu-acd-v1-0-1e5e91aa95b6@quicinc.com>
 <20241012-gpu-acd-v1-2-1e5e91aa95b6@quicinc.com>
 <he6cfrofgmdw2se4mcok25c54sboovevmlli42xh6ttnqiogat@ja6el35jyd65>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <he6cfrofgmdw2se4mcok25c54sboovevmlli42xh6ttnqiogat@ja6el35jyd65>
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: kzf1aToNo35dp4gEiEjK2dVFZQxIlwgJ
X-Proofpoint-GUID: kzf1aToNo35dp4gEiEjK2dVFZQxIlwgJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 impostorscore=0
 bulkscore=0 mlxscore=0 spamscore=0 lowpriorityscore=0 priorityscore=1501
 malwarescore=0 phishscore=0 clxscore=1015 suspectscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2409260000
 definitions=main-2410150129

On Mon, Oct 14, 2024 at 09:39:01AM +0200, Krzysztof Kozlowski wrote:
> On Sat, Oct 12, 2024 at 01:59:29AM +0530, Akhil P Oommen wrote:
> > Add a new schema which extends opp-v2 to support a new vendor specific
> > property required for Adreno GPUs found in Qualcomm's SoCs. The new
> > property called "qcom,opp-acd-level" carries a u32 value recommended
> > for each opp needs to be shared to GMU during runtime.
> > 
> > Signed-off-by: Akhil P Oommen <quic_akhilpo@quicinc.com>
> > ---
> >  .../bindings/opp/opp-v2-qcom-adreno.yaml           | 84 ++++++++++++++++++++++
> >  1 file changed, 84 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/opp/opp-v2-qcom-adreno.yaml b/Documentation/devicetree/bindings/opp/opp-v2-qcom-adreno.yaml
> > new file mode 100644
> > index 000000000000..9fb828e9da86
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/opp/opp-v2-qcom-adreno.yaml
> > @@ -0,0 +1,84 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/opp/opp-v2-qcom-adreno.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Qualcomm Adreno compatible OPP supply
> > +
> > +description:
> > +  Adreno GPUs present in Qualcomm's Snapdragon chipsets uses an OPP specific
> > +  ACD related information tailored for the specific chipset. This binding
> > +  provides the information needed to describe such a hardware value.
> > +
> > +maintainers:
> > +  - Rob Clark <robdclark@gmail.com>
> > +
> > +allOf:
> > +  - $ref: opp-v2-base.yaml#
> > +
> > +properties:
> > +  compatible:
> > +    const: operating-points-v2-adreno
> > +
> > +patternProperties:
> > +  '^opp-?[0-9]+$':
> > +    type: object
> > +    additionalProperties: false
> > +
> > +    properties:
> > +      opp-hz: true
> > +
> > +      opp-level: true
> > +
> > +      opp-peak-kBps: true
> > +
> > +      opp-supported-hw: true
> > +
> > +      qcom,opp-acd-level:
> > +        description: |
> > +          A positive value representing the acd level associated with this
> 
> What is acd?

Adaptive Clock Distribution, a fancy name for clock throttling during voltage
droop. I will update the description to capture this.

> 
> > +          OPP node. This value is shared to GMU during GPU wake up. It may
> 
> What is GMU?

A co-processor which does power management for Adreno GPU.

> 
> > +          not be present for some OPPs and GMU will disable ACD while
> 
> acd or ACD?

should be uppercase everywhere in description.

> 
> > +          transitioning to that OPP.
> > +        $ref: /schemas/types.yaml#/definitions/uint32
> > +
> > +    required:
> > +      - opp-hz
> > +      - opp-level
> > +
> > +required:
> > +  - compatible
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +
> 
> Drop blank line
> 
> > +    #include <dt-bindings/power/qcom-rpmpd.h>
> > +
> > +    gpu_opp_table: opp-table {
> > +        compatible = "operating-points-v2-adreno";
> > +
> > +        opp-550000000 {
> > +                opp-hz = /bits/ 64 <550000000>;
> > +                opp-level = <RPMH_REGULATOR_LEVEL_SVS>;
> > +                opp-peak-kBps = <6074219>;
> > +                qcom,opp-acd-level = <0xc0285ffd>;
> > +        };
> > +
> > +        opp-390000000 {
> > +                opp-hz = /bits/ 64 <390000000>;
> > +                opp-level = <RPMH_REGULATOR_LEVEL_LOW_SVS>;
> > +                opp-peak-kBps = <3000000>;
> > +                qcom,opp-acd-level = <0xc0285ffd>;
> 
> That's the same value used everywhere. What's the point? Just encode it
> in the driver.

I will update this to keep a different value. In a real implmentation,
these values may vary between OPPs. For eg:, please check the DT patch
in this series:

https://patchwork.freedesktop.org/patch/619413/

-Akhil

> 
> > +        };
> > +
> > +        opp-300000000 {
> > +                opp-hz = /bits/ 64 <300000000>;
> > +                opp-level = <RPMH_REGULATOR_LEVEL_LOW_SVS_D1>;
> > +                opp-peak-kBps = <2136719>;
> > +                /* Intentionally left out qcom,opp-acd-level property here */
> > +        };
> > +
> 
> Stray blank line
> 
> > +    };
> > 
> > -- 
> > 2.45.2
> > 

