Return-Path: <linux-pm+bounces-38660-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A11BC8770E
	for <lists+linux-pm@lfdr.de>; Wed, 26 Nov 2025 00:16:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 139753A112E
	for <lists+linux-pm@lfdr.de>; Tue, 25 Nov 2025 23:16:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D6C62EFDB4;
	Tue, 25 Nov 2025 23:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="il8HerLA";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="VmvpXEp8"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACD3322FDE6
	for <linux-pm@vger.kernel.org>; Tue, 25 Nov 2025 23:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764112609; cv=none; b=qhkGNfeFqrgGTiv7v3t7IAvkSI9oPpcdoVHehKUjBTPRDmhevrlQEYfae2wlzCa5zUPK+kfVmkzyqpsYLfOmoWkkX5QrjgmQ5zEM66zbmU1p2AO31fh91/7OaB1Xl3xG8OIyE5hiwnFn81zd9VBupp7k3OxKcZNqCbU2NhcbHuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764112609; c=relaxed/simple;
	bh=oUjqNTyOrT3EHiuqSjp80XkHCfo8q6zGxTvsTRH8p9c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JkxZ8A2qH/Z8jOFD6+h8GS5tlc5nAI6C/h6hS3s79cKwo/L/8UIGB6yO2ldSYSamLj4Yfbomj3c3NEnguouoKQcTLWhhrKGQ6I8XSF822WnKX05PpAStdTON760l7wspTpOdduDGmYhRrMh5mqyxAOXG8z7SPSHNbm1Xr6s+WoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=il8HerLA; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=VmvpXEp8; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5APISoPR2650901
	for <linux-pm@vger.kernel.org>; Tue, 25 Nov 2025 23:16:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=qzuPqlmp5yspaITbhEZIU/AV
	QzJ7g3JoIGiJ7SmJwX8=; b=il8HerLAlNbkBjZbCalCi8M7+cmdMlZ4FfjzrfDq
	oh6ruhBjztIM5EHvSNpV8XUMeyC+4Nmas77BerNqQZ//KBL4r1bCkEKUCb/LjfGM
	XxdRguL5Yjg6UlpT7p7zxUodSyoj7NKlzjKRbmsneSUDRD8qaN9MAu7CQQAkjM1w
	o8a+FqaUHBB/dYsB0Bpx6EQotTB+BmqRQlTD0NBPjaAkABNWZLRSm5JBqugQDRtV
	3zLiaFFWjL0t6iIuadFRkyifISfbSUgnapl4xkaGuoKP9I+1ELf2sMCu17BEOVFx
	3QMev4iGnqjD2byTDEgJiu5/q0jbwMXkOiqBtGR6Nj5aGw==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4anaabt4fw-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 25 Nov 2025 23:16:45 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-8b2e235d4d2so2227028885a.3
        for <linux-pm@vger.kernel.org>; Tue, 25 Nov 2025 15:16:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1764112605; x=1764717405; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qzuPqlmp5yspaITbhEZIU/AVQzJ7g3JoIGiJ7SmJwX8=;
        b=VmvpXEp8jIanqUBbYjdNRmPe5ULA38GIRjjzkid1hRplIHDt/HZLICaW+A/FXj56D+
         0O/6jmrM4C8H0hoFYNUNQxaeZeY3icPSN9fv71WwHldDFyBzZ8aTHJo+/WgQ+N87Jvei
         r2enMAhXh6OfwE6/mfqikxa6F+vMk3dSY47OebYtRTYL5XNk98gqpAWRzIwxKe42fIG4
         WA+75yXmfsJ56uLase4w8igPcqtWqdnLliBZpmjgWwfcfCVqzUOBL7oYSS4REAhb6mzO
         lKP0JX49brMKKSJsEo1wk3Xjp4sRkjbUSTxjKcKvfDmMBXMHAuNrKaYEzjVb2CZEXX1t
         7uNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764112605; x=1764717405;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qzuPqlmp5yspaITbhEZIU/AVQzJ7g3JoIGiJ7SmJwX8=;
        b=c1nbczv86DB63jzeTfsxa7XY2/pmBMTzxZS13lY5bOVYqJ4fgHs6gFOb+W+MXtOuH0
         xgEa5xTwrbYgfszZIMSdcJy7fntZGJLx7ugxBneEzPYB91fSzY7U0zc/1Ne0bkB9+fMh
         RorHqMK/aeuoAvPxUqRIWtNSTjCllfturUws7X968ibJB6it54SPuOagyGPQoSErxuWY
         vJq+/5AyMGh9lmE34Ydm3E8D9NO+B+j/fZV7pUc1PlUZO6FLRTwpk+0Pq3wQKTBadpUt
         ltst7XbEgV+ZXxDWk9XElcVp/k0J1XwFVzKMl1p1wPKmC+vdFI2iLNmXlnNBl82FmIpE
         kmhw==
X-Forwarded-Encrypted: i=1; AJvYcCXxl6OipZLcBa9tTR8GCLagJNJXGcCKAj/J/ocy3MVg5VYZMcZR1DJzcEA1fkCktiCp49XljrZZig==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyc7BOAQXusOYkrHy5V3lUPK0I3Ed6XkYXX4sB3qWlGboT0mDab
	wSRXRy1AO0BAjokgkH8HUXeok3fUCHyJdHMURjnyDu9g1BQrlUQvrKVQ/UdUjnPt763iqdK4g+l
	B6x2R8PuHbG1Tm32fCLBq66jd5ADshqtOnZHqfPTmJ004Kx8RnIxGBdEenYq6/g==
X-Gm-Gg: ASbGncsfUvcspgriH/thFi0nfdFFooRSM59NkwwKGsn5hDDCi2zR9w7oHZmdI9xV4XB
	x08uzKD7N1aCBr35lLkzMVwtn9Qu3iJzfCegfHRMjwoVpDNyp6Of+x4NCHjfBGi1t3GH5/gwQ33
	e69/2ugM7/C9cS937BK1gO+tajKZ4XH/01HnVi+Pt+um1DyBbX5cmbrOiawCwEDyUxRViG/Y/av
	D5D8OM4iFrFaOGeYwywMQAu0AMTqoPFhfl2/GufFGFr8cVadb4aPbqab3aw0ug9CAEOZzSw6Dh+
	dy8Xy4hUkBnDPIEvRiNyiV6yUyK7/2B8lnyJSrX8HsDljISw3c0R/+fkoxqWPwj/e94kLJEAyDL
	ClylHcmvK5IG+tVKprxvQtoA1r+NcDgam1nuehFMC6zB0nj4dTr8MGhABUmCE3bGcWkW71NV+T9
	BhF/jlCKhT+3bHqn7LlQS2c/A=
X-Received: by 2002:a05:620a:199c:b0:8ab:8037:509c with SMTP id af79cd13be357-8b33d2038edmr2346171685a.12.1764112604933;
        Tue, 25 Nov 2025 15:16:44 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG+HwF6A5aw688UzGyQxWA8SToj7LCNYJA0XBbuNKVFrDhxYDYP+yoHB0s5q49iY5XwzrZ1Qw==
X-Received: by 2002:a05:620a:199c:b0:8ab:8037:509c with SMTP id af79cd13be357-8b33d2038edmr2346166785a.12.1764112604488;
        Tue, 25 Nov 2025 15:16:44 -0800 (PST)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5969dbc5e07sm5457657e87.83.2025.11.25.15.16.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Nov 2025 15:16:42 -0800 (PST)
Date: Wed, 26 Nov 2025 01:16:36 +0200
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
Subject: Re: [PATCH RFC 3/8] arm64: dts: qcom: pmi8998: Add fuel gauge
Message-ID: <vddjrusyejecaewsienryiz2tqisuexlw5xjyhllyu2upnr7ho@ualj7rliu4iw>
References: <20251124-pmi8998_fuel_gauge-v1-0-dd3791f61478@ixit.cz>
 <20251124-pmi8998_fuel_gauge-v1-3-dd3791f61478@ixit.cz>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251124-pmi8998_fuel_gauge-v1-3-dd3791f61478@ixit.cz>
X-Authority-Analysis: v=2.4 cv=Vd36/Vp9 c=1 sm=1 tr=0 ts=692638dd cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=KKAkSRfTAAAA:8 a=RBDvnDhvgAiZZpE4MIUA:9 a=CjuIK1q_8ugA:10
 a=NFOGd7dJGGMPyQGDc5-O:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: GprHm7k0dkJT59NO8kPzdZxGJdqGSOtp
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTI1MDE5NCBTYWx0ZWRfX3G5JIeh1yfz5
 kBf6EOL45QRkR7cxnlAeW00gURU3DjbQdsqjiqgaXvyThcIk3nKztKEFzhbwn5ab3B9R3sxwioW
 7mARKtrPkgXX1zQVttNAaYoX+4qB5ykCAgNbZ9oLPk0HHUHWn2DHH1Sdm9HF5XvmSoRNARUJwSd
 lu3rqtcNcOGBDN8c5E3dc5ydY3MEFa6r+Cdg3PPNTcwkyMOAfKHQtVd3n5ljj7TR4yQ26JHKued
 tStcXknKzyMX4ULm05LN9gebyXp5aoqNS3sWTQBhou8KGVPlODXB08C3xiHcX8+glOwXW71i38q
 dc+OFevh8ZC03tyL2rGEAxXpz3/ewuRGeVSTCzJY578by8F8QWz7ZDQMwKp8VYGWWhj2rmoQKrz
 l6RgDWojYgE6Iyu7+ER/UXph/eA9nQ==
X-Proofpoint-GUID: GprHm7k0dkJT59NO8kPzdZxGJdqGSOtp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-25_02,2025-11-25_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 impostorscore=0 adultscore=0 phishscore=0
 suspectscore=0 malwarescore=0 priorityscore=1501 bulkscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2511250194

On Mon, Nov 24, 2025 at 10:53:36PM +0100, David Heidelberg via B4 Relay wrote:
> From: Casey Connolly <casey.connolly@linaro.org>
> 
> Introduce the fuel gauge node for pmi8998.
> 
> Signed-off-by: David Heidelberg <david@ixit.cz>

Again, missing author's SoB

> ---
>  arch/arm64/boot/dts/qcom/pmi8998.dtsi | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/pmi8998.dtsi b/arch/arm64/boot/dts/qcom/pmi8998.dtsi
> index cd3f0790fd420..ab3bc66502657 100644
> --- a/arch/arm64/boot/dts/qcom/pmi8998.dtsi
> +++ b/arch/arm64/boot/dts/qcom/pmi8998.dtsi
> @@ -44,6 +44,17 @@ pmi8998_rradc: adc@4500 {
>  			reg = <0x4500>;
>  			#io-channel-cells = <1>;
>  		};
> +
> +		pmi8998_fg: fuel-gauge@4000 {
> +			compatible = "qcom,pmi8998-fg";
> +			reg = <0x4000>;
> +
> +			interrupts = <0x2 0x40 0x3 IRQ_TYPE_EDGE_RISING>;
> +			interrupt-names = "soc-delta";
> +
> +			status = "disabled";
> +		};
> +
>  	};
>  
>  	pmi8998_lsid1: pmic@3 {
> 
> -- 
> 2.51.0
> 
> 

-- 
With best wishes
Dmitry

