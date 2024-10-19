Return-Path: <linux-pm+bounces-16003-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 549CD9A4C05
	for <lists+linux-pm@lfdr.de>; Sat, 19 Oct 2024 10:30:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C17FC1F21123
	for <lists+linux-pm@lfdr.de>; Sat, 19 Oct 2024 08:30:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09DFD1DED6D;
	Sat, 19 Oct 2024 08:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="ORUMewL+"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E31E51DE3B8;
	Sat, 19 Oct 2024 08:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729326622; cv=none; b=oCLCl3WHjXMETuRLDf2iI0edE7eoo6u+dTkHogb1B/2CJKvw9hfNolsaOrQrUHqQt5/Iv6aYfMsxk+sXjDN3tuhH0X9F7tL9D9UVinIxLQqFKjtXEQaXz28LOS6B4p/CNbgH3E2GE1+cXVNNiAUa2aKTRTE53hnCT9y4AnQ2Xds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729326622; c=relaxed/simple;
	bh=wTzKEK+zguBgJkUF22dXSocOn+at58n7Xma9AE7SZIc=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I3Yj/6eCfa+FSqCYNM1162DRkVHrjcIlNZrTf6P1CszjzBGCmfpj0aQDq4R5JwD5fJyjBfXIi68Fencb2STqFZzRNM20YyICCV3h9KTke4qFCfU4deb/5mgGmZ9vdT4j/sv0Apv7JIIgx7Wx6z0nFy5AB/9bQnMuQxk43OkO+0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=ORUMewL+; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49J805p3030117;
	Sat, 19 Oct 2024 08:29:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=emllR5JbPryq2TscDbpDv5cW
	SwVM0+1pn14ciuws77o=; b=ORUMewL+t29qNQUByzmn/UrHs2WSjgY3CzAo/A8B
	ES+WXGn7JXLm1rS2HrpdzDm2cRlCW4ku18nZ9+GpT5D6VCggPuX4aH3PT7SMTDbf
	8lbPSUDot1yhi3XONHNXv8R1+aq4sx+0cHdEwts8JNvYhy6hI6dK0Y9Xszmysl/6
	IxH2KMJgqqwJZJZt4X/VR7qAvTiPnlZZltc6zKEMGN96nhtUoEuPjnFwRgAz7qKD
	krzzVgCgpjwysFyBWlqBIBxY9fXF4Sv0+Ttxzec+bpJC1xRI3k95xBaZiC6XNZaP
	Rx4KyUCuw0uSTy51gabOqhj2L7aMIF5FWQ9CZz1hRe81sA==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42c6sj87r9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 19 Oct 2024 08:29:56 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 49J8TtIm015223
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 19 Oct 2024 08:29:55 GMT
Received: from hu-akhilpo-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Sat, 19 Oct 2024 01:29:48 -0700
Date: Sat, 19 Oct 2024 13:59:44 +0530
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
Subject: Re: [PATCH RFC 3/3] arm64: dts: qcom: x1e80100: Add ACD levels for
 GPU
Message-ID: <20241019082944.w2xnks54i34vj4qx@hu-akhilpo-hyd.qualcomm.com>
References: <20241012-gpu-acd-v1-0-1e5e91aa95b6@quicinc.com>
 <20241012-gpu-acd-v1-3-1e5e91aa95b6@quicinc.com>
 <5axuqj4hetfkgg2f53ph4um24b7xfyumktreglxqyzfsdhy25e@deucq7vqxq5l>
 <20241015193540.mcpp2dvkmikruncj@hu-akhilpo-hyd.qualcomm.com>
 <921d3a39-d95c-4156-b376-44e8dc6a6467@kernel.org>
 <20241017061217.mmq27egyg5cdlubb@hu-akhilpo-hyd.qualcomm.com>
 <9ac861ae-b0b1-4f7a-a002-7d2048132ef3@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <9ac861ae-b0b1-4f7a-a002-7d2048132ef3@kernel.org>
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: gCOussZQS0CKV-Lk2cyLze9bBgMj7q8d
X-Proofpoint-ORIG-GUID: gCOussZQS0CKV-Lk2cyLze9bBgMj7q8d
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 adultscore=0
 bulkscore=0 phishscore=0 mlxlogscore=289 clxscore=1015 priorityscore=1501
 lowpriorityscore=0 malwarescore=0 suspectscore=0 spamscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2409260000
 definitions=main-2410190059

On Thu, Oct 17, 2024 at 09:05:50AM +0200, Krzysztof Kozlowski wrote:
> On 17/10/2024 08:12, Akhil P Oommen wrote:
> > On Wed, Oct 16, 2024 at 09:50:04AM +0200, Krzysztof Kozlowski wrote:
> >> On 15/10/2024 21:35, Akhil P Oommen wrote:
> >>> On Mon, Oct 14, 2024 at 09:40:13AM +0200, Krzysztof Kozlowski wrote:
> >>>> On Sat, Oct 12, 2024 at 01:59:30AM +0530, Akhil P Oommen wrote:
> >>>>> Update GPU node to include acd level values.
> >>>>>
> >>>>> Signed-off-by: Akhil P Oommen <quic_akhilpo@quicinc.com>
> >>>>> ---
> >>>>>  arch/arm64/boot/dts/qcom/x1e80100.dtsi | 11 ++++++++++-
> >>>>>  1 file changed, 10 insertions(+), 1 deletion(-)
> >>>>>
> >>>>> diff --git a/arch/arm64/boot/dts/qcom/x1e80100.dtsi b/arch/arm64/boot/dts/qcom/x1e80100.dtsi
> >>>>> index a36076e3c56b..e6c500480eb1 100644
> >>>>> --- a/arch/arm64/boot/dts/qcom/x1e80100.dtsi
> >>>>> +++ b/arch/arm64/boot/dts/qcom/x1e80100.dtsi
> >>>>> @@ -3323,60 +3323,69 @@ zap-shader {
> >>>>>  			};
> >>>>>  
> >>>>>  			gpu_opp_table: opp-table {
> >>>>> -				compatible = "operating-points-v2";
> >>>>> +				compatible = "operating-points-v2-adreno";
> >>>>
> >>>> This nicely breaks all existing users of this DTS. Sorry, no. We are way
> >>>> past initial bringup/development. One year past.
> > 
> > How do I identify when devicetree is considered stable? An arbitrary
> > time period doesn't sound like a good idea. Is there a general consensus
> > on this?
> > 
> > X1E chipset is still considered under development at least till the end of this
> > year, right?
> 
> Stable could be when people already get their consumer/final product
> with it. I got some weeks ago Lenovo T14s laptop and since yesterday
> working fine with Ubuntu:
> https://discourse.ubuntu.com/t/ubuntu-24-10-concept-snapdragon-x-elite/48800
> 
> All chipsets are under development, even old SM8450, but we avoid
> breaking it while doing that.
> 
I still have questions about the practicality especially in IoT/Auto chipsets,
but I will try to get it clarified when I face them.

I will go ahead and send out the v2 series addressing the suggestions.

-Akhil.

> 
> 
> Best regards,
> Krzysztof
> 

