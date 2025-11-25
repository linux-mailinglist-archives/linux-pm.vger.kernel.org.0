Return-Path: <linux-pm+bounces-38661-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 16894C8771E
	for <lists+linux-pm@lfdr.de>; Wed, 26 Nov 2025 00:17:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 8DA413546D1
	for <lists+linux-pm@lfdr.de>; Tue, 25 Nov 2025 23:17:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81C222EDD52;
	Tue, 25 Nov 2025 23:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="JtmwZoE6";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="MdwQmYE7"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A12842C327E
	for <linux-pm@vger.kernel.org>; Tue, 25 Nov 2025 23:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764112665; cv=none; b=Qkfz44CfM1vAE6WZRCksnkPx8sRIK0RHvT1RSY/1QEvXDT4vog8FCyXv2QuT+PIFDCAiE40VLozZmnmL9YG39lajbjhgIIbDBR06AdWm1eB5aCI5qzyjyPZrJZurcdN9uQuU3ugMJCzB8ARXvADRq6qFGdqvaSYmGKSL30afCgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764112665; c=relaxed/simple;
	bh=VDfTV9mVlqel2Jl8z4qwJgsngWN3cDqLjSDdxwI9guk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wt+n0NYV14Ea1ONSlPQAZQoyUNuSAEs+H+Qqwf0QrRgWFZrHBRxkB2c9sHHkKCFajkObhVwPpSmr5pxdYuIDYpAYU1/UIFlVg6aIdGs8Ur7tFMgUQyYQsXZTWoyjlIBwzpJPwcKYBQHCv0KsPQ6O9JpYG5TyHELvugrd2S0Iywg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=JtmwZoE6; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=MdwQmYE7; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5API1K032651045
	for <linux-pm@vger.kernel.org>; Tue, 25 Nov 2025 23:17:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=ZJG/NiRgpzwQ2de39BRzH5Av
	KoSMIYV8Nj7NUhsj2IM=; b=JtmwZoE6d5C4hcg7sz/PV64ymF114dUHFCX0FrUr
	JHfQSC6AzXInXRwu32HCuRP0rRqyIgL9NHaO3lEkThXo3zLsh9d+ZPTaKCdJlI93
	c0Q/Fq7UMUMuC/z0UWLGuS19p0tgB7BoKDhQ5P7ZHKBl+AanVHnzT2qopBnxtaJq
	kIPYgz5V8M3AcnRGpSZrnvzFnjwbYbArpkuq5NcnwHxQ9b5BnaUMho7+m/u0QkpW
	6RznyEDO4g9VMeVshbph5KCryxqtP1hKkLKev0XVbQgRq3qrFGQrnqpXfa3J9j9u
	+puVmWBm+RZ3bs0v0wbvo3LYNnxNQxgh0AKOsaznUoXsbQ==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4anaabt4hm-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 25 Nov 2025 23:17:41 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-89ee646359cso1610809085a.1
        for <linux-pm@vger.kernel.org>; Tue, 25 Nov 2025 15:17:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1764112661; x=1764717461; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZJG/NiRgpzwQ2de39BRzH5AvKoSMIYV8Nj7NUhsj2IM=;
        b=MdwQmYE7ByT1TCvnDkbSkFRvfS3UW/NnAeQS1IqLYqe9M0xYK11F0RI4ug4sCf25u+
         N8KoUABa+9VHzR2xhuZHbB23yMEX05dc+8pNv5uKYiGFfbnIwGBtmtxj6nwJANr4tku3
         WT/Fl8cesORJ04xCIdB6zPUqzkpJ1NtJe4Mi11lmer9FXTJWbfpKEA2aNtmJqVXFpvO9
         jpqwxGVjdYyv765vaynGMzd1g014zmyzAevG1/P8Xjfg6ysXG/52FfpnM2fhLsZQK+Y4
         5AmiITFFR0p525vh1Z+aJ/m0pwfGn4y7heTnEynSE6D6g+a8G/SBL9FyW7BjgYxPIwNI
         oxRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764112661; x=1764717461;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZJG/NiRgpzwQ2de39BRzH5AvKoSMIYV8Nj7NUhsj2IM=;
        b=GHtAe5GbI2rJbKMnEi0EE0ePjT4tnSY3rJLNg8Yt3agzAYXLxpX1QTvynSjzZIIG+2
         OR9WbwFXlaFt+teuC/8yvM+nyhAa1heS9pWh/5VvyHbXtor4g0eQuUnga8lRbz/A9OKU
         vRzC1SbIpgRJqcWgLnf0yh5xMDiPxkRok18uAzjQwvVvw/xInTxUt6fd3akBDJ3DXTex
         opqZJai92mM/heoMJHEC43AN7ZU9SwiJbKkvOiztc7Ku0VenOpZ22nvAiSDbfUQVYVSq
         UEvi6dwRUbiG3Ota+Da4pIkvSV1vome2i7jVijm+8zkxSHcbKMFgVRabSZEZaBwC8oa8
         UZ9A==
X-Forwarded-Encrypted: i=1; AJvYcCUB+BeWQh4bwBkfbzDjwsrg9CTFCNoO5MsQgbCeqqwQ6xxwh5+/QEFi08KE67q6EG6Zw2GE5+Myvw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyzc/wK/4z/RQc/VWaVSBVjLH9VTocUwaix94TA9mk1eBO0DSYO
	phAuPzKRiOufw7JGiXmusI3WmwM9e8iu0h6zf78dIB9NViJnMFrH07vkgcbanlUJM5JmeLp8Qjs
	xEgsVsLw7JOW9euJ2Hf4/eFJY2NYPDhx2pbvg/6scYBFwf+Vt34A9yQ7FyKJlKw==
X-Gm-Gg: ASbGncvHuu8eqOphdioX5wzIlnlmQsYiOxssyHgdpz92bT2IfgmYsXYRp4mYNqutSEe
	lXEglPfHLXAyUPr4DCjqyhIUmSdiQZu3s2+IcDlhmixvI7UGdxSc4/Nbh3GBx7qmANyha67MVwa
	QYFRU0A/c2K2wt2cYGqpHghbtHcZJxdmXuQ29JKibKO4cU+58uGXcmnRCVF5pmaAtQH+at9wiTF
	Ul+07e6uPr4JrZA/5iBLk37Ucx0JgTsXU3nyRf2NGiXCXuY0Vufe57UTBP2P7+1Bk5zYYNMx6Cn
	sd3xUdHRekZkjDIi5Z6dko2jUtVk0Zwn5acTSWT9yimvJIJ1vTF8ohATpI1Rsmon4g4hs0REIeo
	pLRKzxQwNNFO3JDTxkUwuH+XKyosnEHF7fAI8uD5Qk/vqFYPeWQlSVAnXBQ3CASWfuDyD9Yoh7C
	w3+tJvIjEsoPsD/K5eXFBVpLw=
X-Received: by 2002:a05:620a:2907:b0:857:890f:7fab with SMTP id af79cd13be357-8b4ebdce57dmr585242485a.85.1764112660909;
        Tue, 25 Nov 2025 15:17:40 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFEASLoNe1Ymtvsojx+MAbOgMVURUVbmfT9dl4AeK5xsAaEViYLhvW3H/OERaypIXSVZ5j11w==
X-Received: by 2002:a05:620a:2907:b0:857:890f:7fab with SMTP id af79cd13be357-8b4ebdce57dmr585239185a.85.1764112660465;
        Tue, 25 Nov 2025 15:17:40 -0800 (PST)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-37cc6b59d3esm35879241fa.14.2025.11.25.15.17.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Nov 2025 15:17:39 -0800 (PST)
Date: Wed, 26 Nov 2025 01:17:38 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: david@ixit.cz
Cc: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Casey Connolly <casey.connolly@linaro.org>,
        Casey Connolly <casey@connolly.tech>,
        Joel Selvaraj <foss@joelselvaraj.com>,
        Yassine Oudjana <y.oudjana@protonmail.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Alexander Martinz <amartinz@shiftphones.com>,
        =?utf-8?B?QmFybmFiw6FzIEN6w6ltw6Fu?= <barnabas.czeman@mainlining.org>,
        Richard Acayan <mailingradian@gmail.com>,
        Alexey Minnekhanov <alexeymin@postmarketos.org>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        phone-devel@vger.kernel.org
Subject: Re: [PATCH RFC 4/8] arm64: dts: qcom: pm660: Add fuel gauge
Message-ID: <z2n27amgfsnyw4ytavim3cnthqtzhtu7rjp4kbnyd3n3r6ts45@qotrzrgbkrml>
References: <20251124-pmi8998_fuel_gauge-v1-0-dd3791f61478@ixit.cz>
 <20251124-pmi8998_fuel_gauge-v1-4-dd3791f61478@ixit.cz>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251124-pmi8998_fuel_gauge-v1-4-dd3791f61478@ixit.cz>
X-Authority-Analysis: v=2.4 cv=Vd36/Vp9 c=1 sm=1 tr=0 ts=69263915 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=pGLkceISAAAA:8 a=NvILeP0D0bf023pIXisA:9 a=CjuIK1q_8ugA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-ORIG-GUID: XMxeXt5jyN6vEKjJQVp2VO8jtOH7Aedu
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTI1MDE5NCBTYWx0ZWRfX3n2IcTM3EWeN
 oExBxtMxxMPNzIdnpuvMMztfAiI/ZEkKcw5JHHfKiv8ERpAsEuxRTNop0yRVP/8Tur6lpXuz+fp
 Iop5JaByqaKdh+iODFczVzAyJczg6aX07cgl9Jv+T5QmZq90YMmCWMYiTKns1qGiR+m4L6IkhiN
 pi3462WfhnEYnB0fTMlSof+V337xOLQZX3G+NMYGBMxtwLCYLjTdjVkc9EmKj2K4zfTpxPGHmLB
 cQsMnNX+NbkMM99muBhzbEnvUFGEOy2LUg0VkxTVkoJPTL2v/xSdHkQcTflYg3KXEt3EgBJP5G6
 JX/j0Qro4vxy9b46HqT9ohJcH6IBjEQgUDTPNa/rVlxF8xEYPyQLPHuWGBzRti+FUQrgt29iC/a
 5V6VLxSEdUicirqV04ZW5Xsm8iJW6g==
X-Proofpoint-GUID: XMxeXt5jyN6vEKjJQVp2VO8jtOH7Aedu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-25_02,2025-11-25_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 impostorscore=0 adultscore=0 phishscore=0
 suspectscore=0 malwarescore=0 priorityscore=1501 bulkscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2511250194

On Mon, Nov 24, 2025 at 10:53:37PM +0100, David Heidelberg via B4 Relay wrote:
> From: Richard Acayan <mailingradian@gmail.com>
> 
> The PM660 has the same fuel gauge as PMI8998. Add support for
> PM660 battery monitoring.
> 
> Signed-off-by: Richard Acayan <mailingradian@gmail.com>
> Signed-off-by: David Heidelberg <david@ixit.cz>
> ---
>  arch/arm64/boot/dts/qcom/pm660.dtsi | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/pm660.dtsi b/arch/arm64/boot/dts/qcom/pm660.dtsi
> index 156b2ddff0dcb..ce53f5ddc4bdf 100644
> --- a/arch/arm64/boot/dts/qcom/pm660.dtsi
> +++ b/arch/arm64/boot/dts/qcom/pm660.dtsi
> @@ -197,6 +197,16 @@ channel@85 {
>  			};
>  		};
>  
> +		pm660_fg: fuel-gauge@4000 {
> +			compatible = "qcom,pmi8998-fg";

Please add PMIC-specific compatible, use pmi8998 as a fallback.

> +			reg = <0x4000>;
> +
> +			interrupts = <0x0 0x40 0x3 IRQ_TYPE_EDGE_RISING>;
> +			interrupt-names = "soc-delta";
> +
> +			status = "disabled";
> +		};
> +
>  		pm660_rradc: adc@4500 {
>  			compatible = "qcom,pm660-rradc";
>  			reg = <0x4500>;
> 
> -- 
> 2.51.0
> 
> 

-- 
With best wishes
Dmitry

