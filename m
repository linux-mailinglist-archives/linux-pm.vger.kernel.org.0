Return-Path: <linux-pm+bounces-29518-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 384B2AE86B2
	for <lists+linux-pm@lfdr.de>; Wed, 25 Jun 2025 16:39:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9B2747B0647
	for <lists+linux-pm@lfdr.de>; Wed, 25 Jun 2025 14:37:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E7F52690ED;
	Wed, 25 Jun 2025 14:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ky4Ffp+Y"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 003002686A0
	for <linux-pm@vger.kernel.org>; Wed, 25 Jun 2025 14:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750862330; cv=none; b=m5H3az2tcXFQNugmccT27W5nT/yHm5WYqiSeqbZAWCbCqN9+Tr0KSLruYYQZxVWfgSbb9CfwjcmcofVF/MZcI3eFFimjS2TuVj30M2iWfmYQcIOWTFUASBwrTeldXur+o3lt1YXobEDo+37/a08TQ2mcVHlsyAk2qhSOTiQQCp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750862330; c=relaxed/simple;
	bh=gUCK5ZPtvm6MgHUIDv1wxFAc1ecbFd2rMDQC/jqlAuk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iA4UAB3clrlcJatSBWwcUkCWFN9+/88pSyJ5fd6cVwsPtSAq2kqzxLGEHHV3V3r+x2SAIhn5h8XeO3thRt8O+Ix8eEE/x0mgo/wzrQ+DGHoIOTyrlpkJw+7WCr1FHby9uJyw9sk6rWG3mwb9J8Nlv1XglZKqntu2gm/27VZQKiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ky4Ffp+Y; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55PCu4Jj015282
	for <linux-pm@vger.kernel.org>; Wed, 25 Jun 2025 14:38:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	vyp603+DXROKlY8+1tRFEeF1aiIPfGdpzbAJfdYnfMY=; b=ky4Ffp+Y8DWJ5sga
	ATB71pj5U7o5cN3QB6T16JQmjj9MVT+way4qI2/Jnj/Bq/MVAyK1OeaP0n9T1lsG
	nYFZroUkLr3jSm4w2xC4/5tpDKeth0qamfd4HVCm671aUtqZ9txeItoWat8IPjuZ
	2zXLys17vwfBwPHHcAxyy+fdYMxni94WDpwmBRkWcFyZY/4sNf4iug5HnkGDE9io
	G/WnjXSB8FAkJYqH7drWISk5RktaYC0S4QOykHl/T0tPfdjGsqLoKtjtAGZpCasv
	HrhG2PqWoVhlMDa1QH2fv2l1Hn8eYWKj3OveQhgK2IDivLOiIsbTg9NNaMwKxGqJ
	WuP4LA==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47evc5savx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 25 Jun 2025 14:38:47 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4a5a9791fa9so20799571cf.1
        for <linux-pm@vger.kernel.org>; Wed, 25 Jun 2025 07:38:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750862327; x=1751467127;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vyp603+DXROKlY8+1tRFEeF1aiIPfGdpzbAJfdYnfMY=;
        b=lTuaULfQbgeW19zgLNQ2H98Uioi3bj2KI6Cr7yGWnJffsj8g/rrhUnyZlEzWUW1lPz
         65zyMoY7aE/y9d6IyP5ILFX9ozKVMS+/LlHQ78Xiulse7pnx87JclLdXdWm+koHZaVTU
         iIcXwDtGDpKUoU3ozhVQfwbaIYdwrxxZk6NxQVEqB2dxYmhRAA+soIwzRcGFVLDJSRhy
         m62rQZRkPXranuaUhcnLVoHJ1fxUeMJrzPtS9iks040Lw7n4QqZ91xHaEYk6Uiioi9g3
         +vQwXumDBvEbFY+NxA520MXh84m47tnBEKtC040BLkDRhyirE+EqGMV/TLeTIe9OGshE
         CJuA==
X-Forwarded-Encrypted: i=1; AJvYcCXUT7TwGafLH3hJxBMzGCXPuTiL71c4ZJe5OE3kxD+Rt+rHmap0TM/NK4+CoEMjdGnfzWLpO+zdHA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwjFtlZse+4L5aqqF/ara8QaIgPEhGCJnMBM4l9ZqyiLMYC9Wgm
	d5Aj5kWsUQcbeQh/ezkpkcn6UJiLzyrly2M1hAziPC/1MCxiB/iYHZBbTVV27zc+uMoafqgq1nu
	1EWOMvRiFtcaPEWcloHTsS72iODpWKGANYlZtNcPIDozdaMdZu2mrafuYesuZZQ==
X-Gm-Gg: ASbGncvOIf0Wwd5sN1jivy63Z49N/yxx+miZ2Jr156xpT4H6IjKVyU4svzX25Exax8i
	ugmfRCt0We838dnCp7VH3BTq79spS+iE9c4tp8EaBHAb+cH6qKCAqS/AhoP4CwOgCSs4mdDPzbf
	4xmBRASYP3VN72Mt1FGJHGMqht0Xi+XZJbU2k6Kl9UMF7MhBWfwQhnhgrcEw6joaLaQo6W1A1xf
	3hTMaGA3ReOrB+cFLJYcq6C+naFrrtlm6OfKZMgzOwHLxXW4NZbjkFRtOYrdBMVukCpmbpQV961
	43MrPubIcJChl+3efJnjNB7BIkDOMrH++bFtZbmlAeYozUKX6Dyx9kSV0yzsbrpVFMiS+YYgvj2
	7SiU=
X-Received: by 2002:a05:620a:4713:b0:7d3:cec3:3ff with SMTP id af79cd13be357-7d4295fddb1mr179161385a.0.1750862326368;
        Wed, 25 Jun 2025 07:38:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEHsbOpyUO4OQKuHvZNG56/kH2wg/UDN88jgkkkppU/y2V4JJtDrErgvtJkUii1DRKOsax2AQ==
X-Received: by 2002:a05:620a:4713:b0:7d3:cec3:3ff with SMTP id af79cd13be357-7d4295fddb1mr179159185a.0.1750862325910;
        Wed, 25 Jun 2025 07:38:45 -0700 (PDT)
Received: from [192.168.143.225] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae053ee4cdcsm1076068666b.56.2025.06.25.07.38.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Jun 2025 07:38:44 -0700 (PDT)
Message-ID: <4200b3b8-5669-4d5a-a509-d23f921b0449@oss.qualcomm.com>
Date: Wed, 25 Jun 2025 16:38:39 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 14/14] arm64: dts: qcom: Add The Fairphone (Gen. 6)
To: Luca Weiss <luca.weiss@fairphone.com>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>, Vinod Koul <vkoul@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Robert Marko <robimarko@gmail.com>,
        Das Srinagesh <quic_gurus@quicinc.com>,
        Thomas Gleixner
 <tglx@linutronix.de>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-crypto@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-mmc@vger.kernel.org
References: <20250625-sm7635-fp6-initial-v1-0-d9cd322eac1b@fairphone.com>
 <20250625-sm7635-fp6-initial-v1-14-d9cd322eac1b@fairphone.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250625-sm7635-fp6-initial-v1-14-d9cd322eac1b@fairphone.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: UYOoWPR7D8iS1b-ydhKYBXKrqTyqMKLt
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjI1MDEwNiBTYWx0ZWRfX9mjEO8WxhES4
 Ma5IhUb+01CXeWeXU+qpGlutX/VxfHfLducok5rAWvp3YI5Kf7KHG+Bwgi05EncggQi1AyEObBr
 KGzJpXj05PNWWMtkkD49q94puUVbuJl+molwFNZZV5OaWXn65s9p/pCUG9q4ocFeI7EbyFedHIK
 2YumCJV9GQcZcSPaVwz1qHQaR8RBs2ZWSc8VaOCZJXWDw98n4+jzqmnpxg9lUdkiIZDe9E6Z+Qu
 6dtb/BW8GLPCiZ/p8mRUSXAeBKqwTYTZ+Mo81Pij/LzDjYa1zSP2CKfLqhzKBzKA8U8CG4jGeL9
 GbP9f5m9WqTjqtR/waPdNgqlIJQrcPqP1/cZ5KT+o6kXba3cwbAvJEy8nMMUrqw1mDrvkjB3tqr
 2YVEY+00SykW3nikiNSDHKjDiOk3LO/rtCi7hYm0Ez9v6WMxquk9O1sfEFgo0EIoTeFlejW9
X-Authority-Analysis: v=2.4 cv=caHSrmDM c=1 sm=1 tr=0 ts=685c09f8 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=VwQbUJbxAAAA:8 a=gOtRruwUTqeMBgDD9hEA:9
 a=QEXdDO2ut3YA:10 a=5XHQ0vS7sDUA:10 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-ORIG-GUID: UYOoWPR7D8iS1b-ydhKYBXKrqTyqMKLt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-25_04,2025-06-25_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 mlxlogscore=999 suspectscore=0 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 adultscore=0 mlxscore=0 spamscore=0
 malwarescore=0 phishscore=0 clxscore=1015 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2506250106

On 6/25/25 11:23 AM, Luca Weiss wrote:
> Add a devicetree for The Fairphone (Gen. 6) smartphone, which is based
> on the SM7635 SoC.

[...]

> +	/* Dummy panel for simple-framebuffer dimension info */
> +	panel: panel {
> +		compatible = "boe,bj631jhm-t71-d900";
> +		width-mm = <65>;
> +		height-mm = <146>;
> +	};

I haven't ran through all the prerequisite-xx-id, but have
you submitted a binding for this?

[...]

> +	reserved-memory {
> +		/*
> +		 * ABL is powering down display and controller if this node is
> +		 * not named exactly "splash_region".
> +		 */
> +		splash_region@e3940000 {
> +			reg = <0x0 0xe3940000 0x0 0x2b00000>;
> +			no-map;
> +		};
> +	};

:/ maybe we can convince ABL not to do it..

[...]

> +		vreg_l12b: ldo12 {
> +			regulator-name = "vreg_l12b";
> +			/*
> +			 * Skip voltage voting for UFS VCC.
> +			 */

Why so?

[...]

> +&gpi_dma0 {
> +	status = "okay";
> +};
> +
> +&gpi_dma1 {
> +	status = "okay";
> +};

These can be enabled in SoC DTSI.. it's possible that the secure 
configuration forbids access to one, but these are generally made
per-platform

[...]

> +&pm8550vs_d {
> +	status = "disabled";
> +};
> +
> +&pm8550vs_e {
> +	status = "disabled";
> +};
> +
> +&pm8550vs_g {
> +	status = "disabled";
> +};

Hm... perhaps we should disable these by deafult

[...]

> +&pmr735b_gpios {
> +	pm8008_reset_n_default: pm8008-reset-n-default-state {
> +		pins = "gpio3";
> +		function = PMIC_GPIO_FUNC_NORMAL;
> +		bias-pull-down;
> +	};
> +
> +	s1j_enable_default: s1j-enable-default-state {
> +		pins = "gpio1";
> +		function = PMIC_GPIO_FUNC_NORMAL;
> +		power-source = <0>;
> +		bias-disable;
> +		output-low;
> +	};

ordering by pin ID makes more sense, here and in tlmm

(and is actually written down)
https://docs.kernel.org/devicetree/bindings/dts-coding-style.html#order-of-nodes

[...]

> +&pon_resin {
> +	linux,code = <KEY_VOLUMEDOWN>;
> +	status = "okay";

\n before status consistently, please

[...]

> +&tlmm {
> +	/*
> +	 * 8-11: Fingerprint SPI
> +	 * 13: NC
> +	 * 63-64: WLAN UART
> +	 */
> +	gpio-reserved-ranges = <8 4>, <13 1>, <63 2>;

Please match the style in x1-crd.dtsi

[...]

> +&usb_1 {
> +	dr_mode = "otg";
> +
> +	/* USB 2.0 only */

Because there's no usb3phy description yet, or due to hw design?

Konrad


