Return-Path: <linux-pm+bounces-15688-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B4F8B99F75F
	for <lists+linux-pm@lfdr.de>; Tue, 15 Oct 2024 21:36:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6AD471F23E39
	for <lists+linux-pm@lfdr.de>; Tue, 15 Oct 2024 19:36:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B39911B6CFA;
	Tue, 15 Oct 2024 19:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="eWpDT7c/"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C5AE1F80C3;
	Tue, 15 Oct 2024 19:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729020967; cv=none; b=eCrmNsUb/Jv6QHTItQQcwLbaqnlzAm/VhSK+7BwSCmQ3wxz7SPdHvbC4kCn1nLwkE8XZBojAmoLZw2Jf7PyrB5+Xo7oRT9VXXwABXDI41Rzx3zKx8urtEF/ZSZfcFvJA1cpD2AUHXpTTfhMPU4ntz5E3cZylritpkucqwOxz1yE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729020967; c=relaxed/simple;
	bh=g2H/HLLJvLijRrTMMo32aQjvkBfXGOWW35faWTSXGQo=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mjdd8QW5bGXjgcwQh9NdAXhOyc6+9NL3xGH33Czpf41mmm/myflEQoJ1o5vhF93d5G/iQuIVAY+9FKX54G7LBH76UF0aZBs+0Qan8fZPD1JVq5EeGR1+y0+po5QThodE4Ws6uw47ww2MaFnP4RC9rjI3sJRTUFPnGrNy8y9vpGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=eWpDT7c/; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49FJG98i003922;
	Tue, 15 Oct 2024 19:35:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=BzxR5MapksOFSxWMTr/4z/kV
	829dI/XWKgMoMwEKyjY=; b=eWpDT7c/SlyPwJHOAqJcDfikZCzoh5F5d+Xb1pv5
	szDZhmyXcp8VpsqnBz2yxCtjP/5MHTb8JUnXXZvFDpMu+NH0VATxNvk/xwqa/qCE
	G9YC4dptQ1FU8Vf+k+NP3knmiy36nLWJ33DJkDLdUG2RGwZSbqXtePKQRG+hBrpL
	yi69GbQA2VqhffTwsCibJu2EY8tH4BhmXNo0zD1T7CUzy9TEGbVv17f+rLhmAi1A
	1iPB/gzzLaQkSVUE38yZOE7nTjJiDVG0EoaAmA7zSzfzYlIWJMNfWs7SjmBlto20
	xkZ7vmTcFRGBnahQFixTTROVEDYucemVFRCz5sULuDfWHg==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 429xdb81gn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 15 Oct 2024 19:35:51 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 49FJZo9b012051
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 15 Oct 2024 19:35:50 GMT
Received: from hu-akhilpo-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 15 Oct 2024 12:35:44 -0700
Date: Wed, 16 Oct 2024 01:05:40 +0530
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
Message-ID: <20241015193540.mcpp2dvkmikruncj@hu-akhilpo-hyd.qualcomm.com>
References: <20241012-gpu-acd-v1-0-1e5e91aa95b6@quicinc.com>
 <20241012-gpu-acd-v1-3-1e5e91aa95b6@quicinc.com>
 <5axuqj4hetfkgg2f53ph4um24b7xfyumktreglxqyzfsdhy25e@deucq7vqxq5l>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <5axuqj4hetfkgg2f53ph4um24b7xfyumktreglxqyzfsdhy25e@deucq7vqxq5l>
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: Aa7T5W5Dx2WnVo5UT2UtkY0dOfJqeYDz
X-Proofpoint-GUID: Aa7T5W5Dx2WnVo5UT2UtkY0dOfJqeYDz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 priorityscore=1501 lowpriorityscore=0 mlxlogscore=932 impostorscore=0
 phishscore=0 clxscore=1015 adultscore=0 mlxscore=0 malwarescore=0
 bulkscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410150131

On Mon, Oct 14, 2024 at 09:40:13AM +0200, Krzysztof Kozlowski wrote:
> On Sat, Oct 12, 2024 at 01:59:30AM +0530, Akhil P Oommen wrote:
> > Update GPU node to include acd level values.
> > 
> > Signed-off-by: Akhil P Oommen <quic_akhilpo@quicinc.com>
> > ---
> >  arch/arm64/boot/dts/qcom/x1e80100.dtsi | 11 ++++++++++-
> >  1 file changed, 10 insertions(+), 1 deletion(-)
> > 
> > diff --git a/arch/arm64/boot/dts/qcom/x1e80100.dtsi b/arch/arm64/boot/dts/qcom/x1e80100.dtsi
> > index a36076e3c56b..e6c500480eb1 100644
> > --- a/arch/arm64/boot/dts/qcom/x1e80100.dtsi
> > +++ b/arch/arm64/boot/dts/qcom/x1e80100.dtsi
> > @@ -3323,60 +3323,69 @@ zap-shader {
> >  			};
> >  
> >  			gpu_opp_table: opp-table {
> > -				compatible = "operating-points-v2";
> > +				compatible = "operating-points-v2-adreno";
> 
> This nicely breaks all existing users of this DTS. Sorry, no. We are way
> past initial bringup/development. One year past.

It is not obvious to me how it breaks backward compatibility. Could you
please elaborate a bit? I am aware that drivers should be backward
compatible with DT, but not the other way. Are we talking about kernels other
than Linux?

Also, does including "operating-points-v2" too here help?

-Akhil.

> 
> Best regards,
> Krzysztof
> 

