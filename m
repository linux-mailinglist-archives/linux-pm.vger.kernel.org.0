Return-Path: <linux-pm+bounces-37333-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 465A7C2EF4A
	for <lists+linux-pm@lfdr.de>; Tue, 04 Nov 2025 03:21:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 25C24420469
	for <lists+linux-pm@lfdr.de>; Tue,  4 Nov 2025 02:20:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8574E23EAB4;
	Tue,  4 Nov 2025 02:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="o2D4Ognc";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="A1IfgGBX"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12A9B239E88
	for <linux-pm@vger.kernel.org>; Tue,  4 Nov 2025 02:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762222840; cv=none; b=qguFDEsARnlIoaP9L7XiO/GLK8yqD4Z1ffSG/rYs7ojAVOoEtdenI2lHulICHw0nOXLu+dlwHso5WdzNhK4Sq4Tpi5H6QH/4N3hOuBEq3MOrGlRTw5+jw0oDKxitmmEsRCf76OgZwg+lqm9j+6elrJfQ5afXIfZ4aLA10FgPl30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762222840; c=relaxed/simple;
	bh=ZRHc12eMCiH3WZmqYEuImQ2rsYDOuFv+OK5STVVSVNE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JNVD5lQqRGPF41cPzxslxbhXTU3tWNB6MVQZMxuTcAXnOaxWDUc7mbiIRhlCZihaP6F2B/4KQUzSnZZ08vbV1tv8UDSMqA2YqJ/kMD0eT4xRxFYIG9rBYXPg73PIpzFNbTfHX6lxoHvIm1eZP1oUHELRvRadpmwzKbt0LfOIDR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=o2D4Ognc; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=A1IfgGBX; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A3H3GCG3595521
	for <linux-pm@vger.kernel.org>; Tue, 4 Nov 2025 02:20:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=Smv4w59hwrUUsoCZ4mHIORjS
	htFGNZtEAs7OQXRjdlo=; b=o2D4OgncJ2olf0YzZLd52pbXlgbAXhMRZORbf7Ea
	5pjzrR6Ms8M6416OTi2UQslIlyyAjJkxK+1pKNSZmYQ/nMU3RZjxmnG06vu0fzMO
	AwTVxyL7vIPqG0BBTMmltXpaoLLf3hBu8Nv34hXpJiwv2lHstkLyWN2AibzMGZeC
	Muc+KRMENfipE2IC5hQR//MhC2OdW/2Jn+L0AtRSNIgUczq6/bCo55YBj1l+XBEM
	jKmbJrwmODqI42Sc+qfQlrxZ+qNs8Cv2XQbWlkJMcPlFWJovvjlhlyOTjhdBFrm8
	B634GSiTWeLNREDoFJHItCchJyjDZiewB74P7rAyTWj0Nw==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a70exhb4a-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 04 Nov 2025 02:20:38 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-88f1dad9992so1955946785a.1
        for <linux-pm@vger.kernel.org>; Mon, 03 Nov 2025 18:20:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762222837; x=1762827637; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Smv4w59hwrUUsoCZ4mHIORjShtFGNZtEAs7OQXRjdlo=;
        b=A1IfgGBXYL4q9BBPchsJgoUGljGcWCdiXAWCrdXCh1oEN2rOJCE37a1L4m5bbF6lYF
         5OZ6brIK+qf6vdsuzVg/kJEaEuOTK98a9DAytK3+9nAmIc1vBjHqT+rDzxTsle6vE4RN
         i5wcbl7xlUIkZggodtBOICc0elV5xqmtccWcZrXDX37iPFgaQEZId9FoQ+4No6WGBYga
         I5u0rpRp6K0Zty5zLmGnF+atqfXbGTynvzCWuhcnHqcfOZn8+GgfQN/IcMf9et2hIO01
         7jrAi+sNiLu+cqiP0IwNZpctFO4ZBlBsZfZ9Y8SOUX3rkLHLBB8/dy0CCuNMmpzQZr73
         TkkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762222837; x=1762827637;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Smv4w59hwrUUsoCZ4mHIORjShtFGNZtEAs7OQXRjdlo=;
        b=mtAAcXcSkHYltKItaGDH2IxmOSzux3Lj2xr0yZzbXHnJIRMq30zBeGAf0XTglKF1Rf
         Z+ndux9mru9znb20C5LFQJRH2qngIpYW34F+Pv25iQIDmw7+bB7fNo8ClbPNMLIYdczl
         gKQsJriCecK8n6MbiKOGurIeIb+09MLdIt2nMow7xYPoPh8Rh7HqtSbY/LfD/Pqzlep/
         p/06kWrsrQEKR8izcuiyXotqnchS66WOHQtXrHGk4r5UyTWlWsMDuR/2GcmC9ieFfuNA
         wKExg57cdA3HuquUMN1OzCh8JjsgQgNQr11SojoekceeraNwqFW1xcPu//lUQB80JI1O
         EbRQ==
X-Forwarded-Encrypted: i=1; AJvYcCVlOjOIR+d22VJ8GPA8UwwhSCmg3wqiHPWojKESlnPD8k30uMGliGBf6U2K06YSOsQS258lIbFtAQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyw3Khq6bq2NRz6xfBDz+/NEvoMoT/CxIcFhfp+gJGRFeIZtedF
	yN4JLfjva4pYq20BseLnvMt6L0tsRuAUFoO6q9QgVhAdIzHAZUS3DtPU4RDf+5hHslHLQITAZjP
	nBi4C7Uan3mTD6dlkZGeAv3wa74lHOk/YsZ/qRtR7WNHeIVWKnP8Yx0H4l+Xbkw==
X-Gm-Gg: ASbGnctIFmX9+ibGDzg7Z5RimTrz9Y9EPeHTnqO8/j3mx1uheZgnk6W/tMDgo/pGUos
	fJW1Uj8FbzogKTQBpKpFt/PU5AtZzfENWEmP7cR6GP1LdfjSDu+4Uqs7wDNguikcaAfoat5zP6y
	kxZxX08aJwySbCskWasfH+pNfjrVMB7B9MTRe0UCa9pIl/IqjXbgvhMRb+r642kSHI3heUdUWZu
	snsJqvvUDjQb9VVVL2gP3+D2mAOgHB8ef4P5YMg905An87l5UoeQndkFKxBmYRUhjDgRQ3ILjuw
	QgzxKlFcexgnrsICIU4NO0yplbWl2yrRjTnOklrtP+r3m2RA0d6CABbEPhStBJOAiMM5wv6WV3g
	XPM3oKXfjQVdDhKwrSYbnTHE8n7uTk/sv0cButtU49gXOfQv/FNAHGY2xp/LOC4lYJeXgWjq+vg
	6oIOw0CiIXhJMV
X-Received: by 2002:a05:620a:4450:b0:85e:5fef:86fa with SMTP id af79cd13be357-8ab99498ba0mr1865073085a.28.1762222836814;
        Mon, 03 Nov 2025 18:20:36 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGSh0oJyfXp/I4QiiOo9v+UZZ5w0epuOXbMS/ogXjwqb82itu/slRbk7NRccoWK4dymtR9Efg==
X-Received: by 2002:a05:620a:4450:b0:85e:5fef:86fa with SMTP id af79cd13be357-8ab99498ba0mr1865068585a.28.1762222835992;
        Mon, 03 Nov 2025 18:20:35 -0800 (PST)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-594343b79bcsm356023e87.47.2025.11.03.18.20.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Nov 2025 18:20:34 -0800 (PST)
Date: Tue, 4 Nov 2025 04:20:32 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Loic Poulain <loic.poulain@oss.qualcomm.com>
Cc: andersson@kernel.org, konradybcio@kernel.org, robh@kernel.org,
        krzk+dt@kernel.org, conor+dt@kernel.org, sre@kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH 5/5] arm64: dts: qcom: qrb2210-rb1: Add support for EDL
 reboot
Message-ID: <z3uy3kx6qx7tcca3psfocrlkrrtumlqyzivrstyxfhbp6lkxti@eeolpv64365x>
References: <20251103182006.1158383-1-loic.poulain@oss.qualcomm.com>
 <20251103182006.1158383-6-loic.poulain@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251103182006.1158383-6-loic.poulain@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=APHuRV3Y c=1 sm=1 tr=0 ts=690962f6 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=EJiAk-FnVJfypVwXgQoA:9 a=CjuIK1q_8ugA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-GUID: _mQ8r5qNqady2QyOhfNYuhq5Y3bQ-aDF
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA0MDAxNyBTYWx0ZWRfX/+kOcpTLAByZ
 yex6aJ225fsIcsA17Vbth7T1rCLgAwOXthj4NBqAuUdH0QRMxkLzuDnV150WYgcJuDdv3lyD4qt
 jiRlDwTY/Bc72Ocg/LtoxpdxrWF6ZYvzMXViZGKfIqiGxQC+/Kh+i/W4EtJUwz1SCQ2NmsKwX1X
 DlYy8BjLyU6yygtgCkwBMIA9/AhlX6HSZxdCfEVSVwAEiG2Z+vZ0OpKiPkP4izqRGHnbGYJXhwt
 MCS01eXjSlSloO9QeZvCOYs4p9zIaLzH34KimJR1L5elUJesgEnujtfe/pmKRXqE5F7BvsFABhg
 jSNaHmoyriyrBIv15IWC6lmN6Pd4kTZNL5BbKzXfVBKim2SNfVQJEAXPsjlzsVddJBFnEWoWmHM
 ZMN2OHsyird6D1MSUTdwRrKwz0+nog==
X-Proofpoint-ORIG-GUID: _mQ8r5qNqady2QyOhfNYuhq5Y3bQ-aDF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-03_06,2025-11-03_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 impostorscore=0 priorityscore=1501 phishscore=0
 suspectscore=0 adultscore=0 bulkscore=0 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511040017

On Mon, Nov 03, 2025 at 07:20:06PM +0100, Loic Poulain wrote:
> EDL reboot mode can be configured via qcom-scm, enabling the platform
> to enter Emergency Download Mode for recovery purposes. Additionally,
> we enable PMIC-driven warm reset as the RB1 platform's PSCI interface
> lacks support for warm reset.
> 
> Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
> ---
>  arch/arm64/boot/dts/qcom/pm4125.dtsi     | 2 +-
>  arch/arm64/boot/dts/qcom/qrb2210-rb1.dts | 9 +++++++++
>  2 files changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/pm4125.dtsi b/arch/arm64/boot/dts/qcom/pm4125.dtsi
> index cf8c822e80ce..5d84a3250481 100644
> --- a/arch/arm64/boot/dts/qcom/pm4125.dtsi
> +++ b/arch/arm64/boot/dts/qcom/pm4125.dtsi
> @@ -15,7 +15,7 @@ pmic@0 {
>  		#address-cells = <1>;
>  		#size-cells = <0>;
>  
> -		pon@800 {
> +		pon: pon@800 {
>  			compatible = "qcom,pm8916-pon";
>  			reg = <0x800>;
>  
> diff --git a/arch/arm64/boot/dts/qcom/qrb2210-rb1.dts b/arch/arm64/boot/dts/qcom/qrb2210-rb1.dts
> index b2e0fc5501c1..70c6c929bbd3 100644
> --- a/arch/arm64/boot/dts/qcom/qrb2210-rb1.dts
> +++ b/arch/arm64/boot/dts/qcom/qrb2210-rb1.dts
> @@ -322,6 +322,10 @@ &pm4125_vbus {
>  	status = "okay";
>  };
>  
> +&pon {
> +	qcom,warm-reset;
> +};
> +
>  &qupv3_id_0 {
>  	status = "okay";
>  };
> @@ -510,6 +514,11 @@ pm4125_l22: l22 {
>  	};
>  };
>  
> +&scm {
> +	qcom,dload-mode = <&tcsr_regs 0x13000>;
> +	mode-edl = <0x1>;

Why are these a part of the board DT file rather than the SoC DT? I'd
assume that at least dload-mode is generic to all devices.

> +};
> +
>  &sdhc_1 {
>  	vmmc-supply = <&pm4125_l20>;
>  	vqmmc-supply = <&pm4125_l14>;
> -- 
> 2.34.1
> 

-- 
With best wishes
Dmitry

