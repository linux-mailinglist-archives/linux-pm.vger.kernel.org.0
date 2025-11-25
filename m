Return-Path: <linux-pm+bounces-38666-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B113C87841
	for <lists+linux-pm@lfdr.de>; Wed, 26 Nov 2025 00:50:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F51D3B6ADD
	for <lists+linux-pm@lfdr.de>; Tue, 25 Nov 2025 23:50:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A8B62F2607;
	Tue, 25 Nov 2025 23:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="BFZqkUJ+";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="BpRzVpGP"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBB4F2EC081
	for <linux-pm@vger.kernel.org>; Tue, 25 Nov 2025 23:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764114623; cv=none; b=Py4EdP7jlejR18ur1Y1Z+LORPMlxJ52G54kds/R+3G+xVqpDK6v6+ioRoaCZJtSOSn3yABA3sycyZ32LgjxTFbhRz6OqnxqzJHCrVi6YzLhF3t7hwq0umvqzUjoie6Ot57kRnKeSxsUtIfI7kJRRrxvfSttqlo01CZlX+ul4OIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764114623; c=relaxed/simple;
	bh=4mItPOhvM4H9szT6+05D7vYa4vALVB2DafudfhRro4g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oZ2yISVR/GZNUy6qqE5G2HX69lRPsOYsIqa9+LqDciw5z11FCjwbDRTU1rdEcnAHIffpZikWHrf4PF6EjUGd5j8pUQ2mBG8Jvh0tzj8AsDxKyQi6md89aSFdIP/RiEs9GydSK9hNEamQ2uI6qNBtVazJ9CeaeooYSfVSjskg074=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=BFZqkUJ+; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=BpRzVpGP; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5APHKobZ2650414
	for <linux-pm@vger.kernel.org>; Tue, 25 Nov 2025 23:50:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=xq1RuV073OvDcWKqZ2e+3llv
	d9UwltD4sYrYTmCV9XY=; b=BFZqkUJ+XSm5ZbUtoE/g4owbq6IGAx2etl/C2Hf4
	dNsT0IvhjeV5ZUxrzqxAnWgZB2upx7GYAm3Ac3iACm9kCnjk+UaVvhtq0bOWwapM
	SqwW2zkcl9wRN7oT92+7n/NSOg/AzhHBz3zkcGRYuAvPoSxmqsEpUFZcP18lhYAw
	18zOZXnmLWZQjs5tvpUI5NbvWyFS9M2u99CFy/NKGQxMb21JlYYcrveGcOsUh1gX
	HakiReXr7kCls/BxHHRVZj9N0JCxhxkDM2Uxlxjx43iY9vMzZW9BHQr1pbKAtY/n
	fRu4CmRrfatAA3r5KNBn/9/6kWd9yzS4tDPAwT9e2Byi4A==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4anaabt6cu-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 25 Nov 2025 23:50:20 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-88041f9e686so168860196d6.1
        for <linux-pm@vger.kernel.org>; Tue, 25 Nov 2025 15:50:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1764114619; x=1764719419; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xq1RuV073OvDcWKqZ2e+3llvd9UwltD4sYrYTmCV9XY=;
        b=BpRzVpGP+jCWupwTbswmmItrjN+sHHOpC3VKcrJXRUzjmPViBK5hQX/+QVQwNdeARD
         +AWkoIU5IkZTMfuqHxI3hMyOIJcUcFv59iA/6Uk8NP/0b/Gt2kUzsnZ7rT/MLaTtLuTj
         AaOvUbsJQGEV2qxgsnc0rDzTtg5hc1FAmr1B0odKwdPwpgq1bcUM9sxBNavdqzjtxbFX
         FU4QoUVLEHCSynzOywvVlsGPjsaFzfI9Di7KPEb4hA0JfE4SoOMM79c9x1CI6KagCLoh
         +V0lbN4GQwo0KZEFUCtRaHdIRMgV8EMe+h1HTa2PKX2k7lCVNqMhOekOv00IJY2MtI1r
         oeAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764114619; x=1764719419;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xq1RuV073OvDcWKqZ2e+3llvd9UwltD4sYrYTmCV9XY=;
        b=mivwkWw8OEJcF9/FUKouqElVZQnuB8XhMbR3jrlMnvxEzGpAAgA/x6Sfm4oxkosD1q
         h5+TXDMEsSKv/CoFgknRqNkHmARlT55lm8DfhaJrYVzN+VJ44PdnNFQM45h5QAeWimXD
         Ze+d0GEH3RMxjxkCVXU9LVJI3WdqKs3uk1Ele40wF+OxW1Rk2+k9myUuNeW4R1FNWvSm
         UBMEiJdgsqYbDkZaovGS6tZdHTUVzee9UcyvlLyAK15hLMhsaZWPsbZGB75fZBE2OxrR
         XzuBaaNGisV8raPOJQPa92eaYfXpJYqWWoiVcOXbGd1P7uRcPcO+5JVyekGve6IJ2c6j
         59mA==
X-Forwarded-Encrypted: i=1; AJvYcCW5mh7TwObfJoFLOtDtHJyiWLke2L+41d8jioljqS33Q3doEQfiDu/ZcXnP16v96KLlHAO+9ABZEQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YycjLBG9+3bflIpGC6PHp0HR2BOtzUrVjrqQcOknFb6QuyI4VSH
	Vz7NwYYea6yvEd2NtL70Cl7WuVxBheES8SvKf8nMV47tfgQdu8hBCOXypv/uR7JXYA/G/bofWe2
	Tg5JuPycabSUYg1CLXUR29uZO2ZMwEtrh1w6EWWIo2qN2mnajnh52NouKmOIt+Q==
X-Gm-Gg: ASbGnctP+LbrB8L4F3k9Mrupi7mqpoHY+0p6cI90ZCFRfDc7QuBDaG/gAERATyWO8qz
	g8JAKoj5y7OttKb9nkvV4K+z+J4tuAL2Z8HdPqzNvgk8SU/c2T6TrwOOnySqZxYgpS0WWmJ5oxk
	3rqiofLnWkYN5Yjg8wAQAdqyRYwaQGG5f0Q/veFMTu+1sJqjrMBfDa8kBs1sZmNLqbQtp546RGX
	RHyGSwYRy7GvYrF7Y0xvbpdnf+d+iYQqEY+mJMXmMJ1RGnwZRuZrsc5GS7Ry+27tMsIXB6U0tbf
	huIPOktCLKx6RKdCRsr1Fe3uly8HqKkIl8xOq8W9UsVVoaK2k3/vFtoxFdMeJnduTZu6sFmDXgu
	IIcxByDFo6SNQjUB6l1HhQgY0nYrp5UKV7r+Ln4vDzYFLLwCcVNxWrLVoaS6g3zSOEg0sQFtJAn
	rZYKXfMD0OGL7jeNEg9cRidvc=
X-Received: by 2002:a05:620a:3911:b0:8b1:ac18:acce with SMTP id af79cd13be357-8b4ebd6fb56mr668259985a.28.1764114619491;
        Tue, 25 Nov 2025 15:50:19 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEIdqta4ZvsH5V0RHO1Jej7JHnAWnhFeOtY9yU8aPhrA+ex3IXH9w7nl/oofzNRmRf+uY/Agg==
X-Received: by 2002:a05:620a:3911:b0:8b1:ac18:acce with SMTP id af79cd13be357-8b4ebd6fb56mr668255985a.28.1764114619045;
        Tue, 25 Nov 2025 15:50:19 -0800 (PST)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-37cc6bc8a70sm36770271fa.42.2025.11.25.15.50.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Nov 2025 15:50:17 -0800 (PST)
Date: Wed, 26 Nov 2025 01:50:14 +0200
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
Subject: Re: [PATCH RFC 7/8] arm64: dts: qcom: sdm660-xiaomi-lavender: Enable
 support for battery
Message-ID: <mwe73kw36g7yrvehou7vel3x5jb4bkbydhp5pxssgxbuiazhoi@63aml5s3luwg>
References: <20251124-pmi8998_fuel_gauge-v1-0-dd3791f61478@ixit.cz>
 <20251124-pmi8998_fuel_gauge-v1-7-dd3791f61478@ixit.cz>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251124-pmi8998_fuel_gauge-v1-7-dd3791f61478@ixit.cz>
X-Authority-Analysis: v=2.4 cv=Vd36/Vp9 c=1 sm=1 tr=0 ts=692640bd cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Gbw9aFdXAAAA:8 a=EUspDBNiAAAA:8 a=nFx4E8QWO6DfJFsFCysA:9 a=CjuIK1q_8ugA:10
 a=iYH6xdkBrDN1Jqds4HTS:22 a=9vIz8raoGPyDa4jBFAYH:22
X-Proofpoint-ORIG-GUID: 5Q_2wrGaKn13l588rMlHJV2_y8pEtFnz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTI1MDE5OSBTYWx0ZWRfX0CAZss+Vp+n/
 naj/KOpv+1bF1eziWXjiGWPvi8kGJ6DKPKsHFCQpyk2I/rNuK1sxLl9j40DQHHygcjpmzShI53f
 lb5Wqx2ocJZTbWep1O/IfdDMIHPTSmdiSjPq/NTGgon2EibC/Sjq7U6PAmFbSsXLK2e0ygYXhEv
 ZoXnytHGZXYvxJpU2iiOecXNFUXolqpUyG7QtcofnQSnbcIW1ye+SgfsytrswoSrysuqOI/Z28U
 TOpvm8YJZcnJCCDvzoxiS9H3OL2q0bk/rB0AcckJczLANXEfIsaFyN5XqSIabd1KwETELqEKBSP
 pPITJ5xiJDH+J3QtUQXhxjSmnJG7Xp2laxryVo8nbo0PPJEiba9iHuf80HXnghvS2arqbVMghiM
 FjQYq527k8SRT5bFALnenXeAz30Wbg==
X-Proofpoint-GUID: 5Q_2wrGaKn13l588rMlHJV2_y8pEtFnz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-25_02,2025-11-25_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 impostorscore=0 adultscore=0 phishscore=0
 suspectscore=0 malwarescore=0 priorityscore=1501 bulkscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2511250199

On Mon, Nov 24, 2025 at 10:53:40PM +0100, David Heidelberg via B4 Relay wrote:
> From: Alexey Minnekhanov <alexeymin@postmarketos.org>
> 
> Add support for battery, fuelgauge and charger.
> 
> Signed-off-by: Alexey Minnekhanov <alexeymin@postmarketos.org>
> Signed-off-by: David Heidelberg <david@ixit.cz>
> ---
>  .../arm64/boot/dts/qcom/sdm660-xiaomi-lavender.dts | 25 ++++++++++++++++++++++
>  1 file changed, 25 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sdm660-xiaomi-lavender.dts b/arch/arm64/boot/dts/qcom/sdm660-xiaomi-lavender.dts
> index a9926ad6c6f9f..cb89b88d887d1 100644
> --- a/arch/arm64/boot/dts/qcom/sdm660-xiaomi-lavender.dts
> +++ b/arch/arm64/boot/dts/qcom/sdm660-xiaomi-lavender.dts
> @@ -38,6 +38,14 @@ framebuffer0: framebuffer@9d400000 {
>  		};
>  	};
>  
> +	battery: battery {
> +		compatible = "simple-battery";
> +
> +		charge-full-design-microamp-hours = <4000000>;
> +		voltage-min-design-microvolt = <3400000>;
> +		voltage-max-design-microvolt = <4400000>;
> +	};
> +
>  	vph_pwr: vph-pwr-regulator {
>  		compatible = "regulator-fixed";
>  		regulator-name = "vph_pwr";
> @@ -93,6 +101,23 @@ &blsp1_uart2 {
>  	status = "okay";
>  };
>  
> +&pm660_charger {
> +	monitored-battery = <&battery>;
> +
> +	status = "okay";
> +};
> +
> +&pm660_fg {
> +	monitored-battery = <&battery>;
> +	power-supplies = <&pm660_charger>;
> +
> +	status = "okay";
> +};
> +
> +&pm660_rradc {
> +	status = "okay";
> +};

Could you please also add a patch moving &pm660l_wled to a correct
place?


Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


> +
>  &pon_pwrkey {
>  	status = "okay";
>  };
> 
> -- 
> 2.51.0
> 
> 

-- 
With best wishes
Dmitry

