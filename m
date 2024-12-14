Return-Path: <linux-pm+bounces-19240-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D69189F2138
	for <lists+linux-pm@lfdr.de>; Sat, 14 Dec 2024 23:26:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 32F0D1887961
	for <lists+linux-pm@lfdr.de>; Sat, 14 Dec 2024 22:26:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D62C1B3949;
	Sat, 14 Dec 2024 22:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Ufr9PJ6x"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABB3D19CC0A
	for <linux-pm@vger.kernel.org>; Sat, 14 Dec 2024 22:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734215163; cv=none; b=juLld+aS1tv1BhEwgVu1+51YcAKpQlQFrHUl/4ZfUidlKNObtL/A6+d/QpdxZRm7MPyJtjMcsX1djXZyaWc+BPaoPLb9xzEBW6MRQ+OAARBQLKsomk1immjOYHZ94iXIw0pdnFsqq3HoJNI4Hzt3yeTRCXHf87gh+E6PbmFo/Wk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734215163; c=relaxed/simple;
	bh=8gpA1dHw2n8NArQXqHK+4y2LvNdeJ3FMqOgEQItAtik=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qnLBdbyOfCK3bBdN62DrKbPwUdeKpF/eWJRNUPSjG4ThqlqGeMLMRaoxRSa79nTpg+Dduww3+qnZchHfR98s7hseu+REHfPbEN94alb+jfVQqunNDL4cFs9YoUZxqc8VhVWvN6kWdMr0pxJDF/UZqLp0bLudoqRv+mS/4vC8D8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Ufr9PJ6x; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BEMFNCJ003112
	for <linux-pm@vger.kernel.org>; Sat, 14 Dec 2024 22:26:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	4cYf+fIp6O0tYi333GxKT8sngxhGUwjhZfc52mhhGiU=; b=Ufr9PJ6xTKSHV3Sc
	Fqaqf8oDU04FYQDH6mv4oLKe0Ai9SZoFhkqZtdnfshmtjYRpnsN3xv8fgzz+1KJu
	Ts/0leJRSYtAJcPNGAvjE7O3c2x9pzCFkHh8PIm3e2zwG+e0hIuBAOf2kJA3lNBz
	+dRYm5bjMmDJPh3NUS5OgqX0cB9a2kHmMwJYRE+cmlHJUpI/7LvXepDf3sJX2RE0
	dF22vREdA9swUW5AFiK8j99Uhy2EdfBLdwd1J357UoQiI+vtpS7N9FUvmASvTLTB
	RtTKgnIaMy0aPHehUX2/EY87NJ09t1XsR7nfSISJ15r2SiV97yJYByk3PiCsC76s
	lj+xeA==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43h30x13j5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Sat, 14 Dec 2024 22:26:00 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4679ef4565aso6406241cf.2
        for <linux-pm@vger.kernel.org>; Sat, 14 Dec 2024 14:26:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734215159; x=1734819959;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4cYf+fIp6O0tYi333GxKT8sngxhGUwjhZfc52mhhGiU=;
        b=EMjnBjCFHUM2bN006V+cTvmfGGx1ZVhPC3hRUe6QYPfyDNI3fE1Lua0H63jSHn+Lf7
         3ryaRq5u6cxhbPYTT+keZRiWx+mIv/i7Co9WlhwENv2Nk6tPOo+raU9DrKGKT6rnd71n
         9b29bwiYEVZUTmAjDGgLrYdR27jAQD8mgLguGkWxCMtrpuhYf4rcK3ALRaEqma7gNA5X
         6AWrMiyConIY2fka1/iVQrqfbs4kKPBRBm9UaB137YSUTDCgwhqGLaY+iDTS1CG0J80O
         zwUjd7zOwgWH7xoLdh024b0Fouf7kUcvFaUe8jphuxRDcyRcrPMRxY9ND2OZqv7QPXcQ
         en1g==
X-Forwarded-Encrypted: i=1; AJvYcCUqSJQsWdrbTIXHFSoQTrkQD6/AZHvBENWzkCRhLmYasYyS/WjCmTI//46G4ZGt3Yy2+XhbLD4jjw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwHuFP73VZEz120/snDf5LflWoaaQ2bUD6iiW3UcUVks5qkg/9H
	PrlpYwqoSBmjcIB3GOgy8jrn/cvEusL8tdCO7bL6livfNO/kK+IDXFn10ugOHZwcHaOD38imzPN
	qWvuqJJoXoijDP4ttnZK2FVhxWM89xW25KH6w8ClyWSeMhApOQOsSqfE9UQ==
X-Gm-Gg: ASbGncvitkYuW3QVch0y4EzAdnPjy7ipmG/5NoEMDk/k+aCaqEsWtZ4NNOGBo6msZVi
	jMlgNXurFK/dFwOLdOD4Rz7J5Fxl4IjDpEdh6LMKAi1eJvpeuWtwYN+xbdiaFFZRS6KPVuh+e6m
	JhYt0iXdabOB19Na1ecKWzTbOTqmPriIKnRR9G2tDaf4GZgfrsmdSXmMCKiK1lUAaEOI50DKVSq
	2RIK/pAHiJQdhYtwVUG2DWoSa3q1TH8xU3x4AFRdNZmk6mieB4g1bGALAh7JKWYdxeAWiB1ujR6
	+L8MQD4gDxMngSeo6Uzpd8ZHli58wf16afE=
X-Received: by 2002:a05:622a:606:b0:460:9026:6861 with SMTP id d75a77b69052e-467a578e2cemr51181931cf.9.1734215159696;
        Sat, 14 Dec 2024 14:25:59 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHy3CQjGTQldVtLkouHU5cCLTpoXg+9TRQXEIp9dtfbaLJ0YpWV2irQdO65sKCWWIcHWP2RfQ==
X-Received: by 2002:a05:622a:606:b0:460:9026:6861 with SMTP id d75a77b69052e-467a578e2cemr51181841cf.9.1734215159274;
        Sat, 14 Dec 2024 14:25:59 -0800 (PST)
Received: from [192.168.65.90] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aab9638ac49sm139824566b.144.2024.12.14.14.25.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 14 Dec 2024 14:25:58 -0800 (PST)
Message-ID: <3fa6e136-b59f-47d2-9ebd-9040f422d25f@oss.qualcomm.com>
Date: Sat, 14 Dec 2024 23:25:55 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 6/8] arm64: dts: qcom: Add initial support for MSM8917
To: =?UTF-8?B?QmFybmFiw6FzIEN6w6ltw6Fu?= <barnabas.czeman@mainlining.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-pm@vger.kernel.org, iommu@lists.linux.dev,
        =?UTF-8?Q?Otto_Pfl=C3=BCger?= <otto.pflueger@abscue.de>
References: <20241211-msm8917-v8-0-197acc042036@mainlining.org>
 <20241211-msm8917-v8-6-197acc042036@mainlining.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20241211-msm8917-v8-6-197acc042036@mainlining.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: zpUfa7xZatLALIfH9Lro_WJvTX7eaZ87
X-Proofpoint-GUID: zpUfa7xZatLALIfH9Lro_WJvTX7eaZ87
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 spamscore=0
 malwarescore=0 phishscore=0 impostorscore=0 adultscore=0
 priorityscore=1501 bulkscore=0 clxscore=1015 lowpriorityscore=0 mlxscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412140185

On 11.12.2024 6:59 PM, Barnabás Czémán wrote:
> From: Otto Pflüger <otto.pflueger@abscue.de>
> 
> Add initial support for MSM8917 SoC.
> 
> Signed-off-by: Otto Pflüger <otto.pflueger@abscue.de>
> [reword commit, rebase, fix schema errors]
> Signed-off-by: Barnabás Czémán <barnabas.czeman@mainlining.org>
> ---


> +
> +		cpu0: cpu@100 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a53";
> +			reg = <0x100>;
> +			next-level-cache = <&l2_0>;
> +			enable-method = "psci";
> +			clocks = <&apcs>;
> +			operating-points-v2 = <&cpu_opp_table>;
> +			#cooling-cells = <2>;
> +			power-domains = <&cpu_pd0>;
> +			power-domain-names = "psci";
> +		};
> +
> +		l2_0: l2-cache {
> +			compatible = "cache";
> +			cache-level = <2>;
> +			cache-unified;
> +		};

By "under CPU node", I meant as a subnode ;)

See sm8650.dtsi for reference

[...]

> +
> +			sdc1_default: sdc1-default-state {
> +				clk-pins {
> +					pins = "sdc1_clk";
> +					bias-disable;
> +					drive-strength = <16>;
> +				};
> +				cmd-pins {

Please separate these subnodes with a newline

[...]
> +
> +		apps_iommu: iommu@1e20000 {
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +			#iommu-cells = <1>;
> +			compatible = "qcom,msm8917-iommu", "qcom,msm-iommu-v1";
> +			ranges = <0 0x01e20000 0x20000>;

'compatible' should come first

[...]

> +		intc: interrupt-controller@b000000 {
> +			compatible = "qcom,msm-qgic2";
> +			interrupt-controller;
> +			#interrupt-cells = <3>;
> +			reg = <0x0b000000 0x1000>,
> +			      <0x0b002000 0x1000>;
> +		};

and 'reg' just after it

Otherwise looking fairly good!

Konrad

