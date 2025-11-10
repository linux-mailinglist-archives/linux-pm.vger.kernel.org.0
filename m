Return-Path: <linux-pm+bounces-37728-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 42C6EC46977
	for <lists+linux-pm@lfdr.de>; Mon, 10 Nov 2025 13:28:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 9854234466B
	for <lists+linux-pm@lfdr.de>; Mon, 10 Nov 2025 12:28:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBFF630C37A;
	Mon, 10 Nov 2025 12:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="MvnMhZxl";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ctfAxeNS"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D02D3093D8
	for <linux-pm@vger.kernel.org>; Mon, 10 Nov 2025 12:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762777721; cv=none; b=m8E0o3oIx4KVLNWF1uxELLN4yqDbS4Y1Sk8U3DD3hGbU3FsfT+64Dmyy2hYvaa7LAVNXT8Xu3AHovg57oLon3rxf7pTT7U1DAst0CPF6eyNMPs2Uzihx+slrBnOaN/V1di1x47Y10PuzgxCj4T9PWBaOJvd13Vq4qfuhkMOlEc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762777721; c=relaxed/simple;
	bh=wvQv8x5QLsGOu8cOE9WdXI12O/iTMNRil3FtOPEraWY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QxEbyPbkU8FBoCwzDWFeD6VukvVmh39uK0RGRoC5ZMtcUneMu9C+avm+tWWFVfaV1TJYwjIfIqY5byPgmIGdqunIerl3i4/D273Okkcp3xdluKXgiHQ/oJahBdqNv7oFR44IHa7Tdjxi2/IZ5/WAf8JkXLX6VpLZQvFfWGKcPZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=MvnMhZxl; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ctfAxeNS; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AA8s8AH1743936
	for <linux-pm@vger.kernel.org>; Mon, 10 Nov 2025 12:28:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=xvC5tylk1sHK0qkeaSY7kYE/
	Js6EfOGyj+3jgzqwPC8=; b=MvnMhZxl/iW4KuAs8Wm7Gw8jAuvAb8KfulrNlYNg
	EScblnQuteuG8Mra9hOdYcdbij+rPGyoUgdeWje1mgROtnvIS8haMsfs/IIOeofj
	3OtdieslBjRPqjtWo14eD8P6TMFhdWtbNd/dqoIpNzkRnBr1c0T+vOkK6oYuP/go
	hxUzbPEAKu5DoWc9l3WEkYoqAPjHidipz7IWNAhEQU2KvIZQhzJ5JWYI2YvSJyfM
	lmDYkHh8oOr0OiDS6ELrzOlRLKgpMxWtrVCGG4InRuCseYx8Tx/rdNxl0TkeFHg3
	M3whPPYegtzsIw8C6LYu+p865PVPDaqjGAQv7bu/Ht0B9w==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a9xvjcpk1-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 10 Nov 2025 12:28:38 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-297b35951b7so52194905ad.3
        for <linux-pm@vger.kernel.org>; Mon, 10 Nov 2025 04:28:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762777718; x=1763382518; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xvC5tylk1sHK0qkeaSY7kYE/Js6EfOGyj+3jgzqwPC8=;
        b=ctfAxeNSfmkiP4URySTKfJJn5s4+45vFK6O3wA6TDYuyycuXZQtinC3e4TaCS/IKkn
         E9wh7B4+bddFgD/rxn7rRVKBQnav7X55FFUlXvZAQ2fN5njdTb1l2lOs4EmkAnbhYXYr
         qsu5bccrlUh+SxPuDalHPI2LPBxDcbzxr8iaesOwqnmuP/MAiXSAcYulLXvSUd7NZ9p+
         +A7v0YV9oHcLR4GmjgytQG8qA8QqjyRtzNjmSNe1WK1WZeii9uwjm7fpsr1jgnaDmPqx
         iChXXnXfH/YF+oe5LQQzlvNYbNg70BClomzUz3WRX33DQKfJLvlrrq5DOLBbxZjxfWHA
         NTSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762777718; x=1763382518;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xvC5tylk1sHK0qkeaSY7kYE/Js6EfOGyj+3jgzqwPC8=;
        b=rTzbDBv2z+cx4Sn0zzfryafxoszsZJYOKMrY1IAWRABknyM1ZwdFumFVGUdQzwsv1p
         P3JQX0ko2+yA+LlDIExZIyv1cjlmkltJQ8Xln5RW160i92u3gg7u9qqlgg1uQvpmj5w9
         GLd+S1OlXzFqiRcHFfILQN8tK1r42ifToOgoku0cTmOhAg0DPHx4EjW61cORR6hK/BXl
         V5WO5bWFHTJ4NI5wlzHLe9mY/RO9x6A69JK1rITPLeWjD1c+oFDEgGwKRgBY/VHUJ6ZL
         MVtIZJa2wvozlzmCCLdJm8KYWOL03YewkyHzxeWiEULCYdihiHvmDT9EmiS64x6FwOrF
         HmDg==
X-Forwarded-Encrypted: i=1; AJvYcCXieBgCHqMhItozR6hQt+JKbsz2cZ518XjBGeynggxROAqo4AN3ZYkOYC33YHIHFDnGT29JmqRyUQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzZml9oE3y7EJl44RkfT8c23P1yB9xPm9s+XgrFo5q/t/pgcZ6l
	GGdChJnifYqR0y0/SV/a4Zom0S5JUndqoNj+xb2WBNsYhoEdydL4+UfOiuoOcv87cK//kygfh2k
	5aj5jbjl/AAASephTs3Pll9s7VaTasxR/cIE2BJCvokFVT6tc4DCjP6UT5+iqjg==
X-Gm-Gg: ASbGncsyxO44yjVampmpeSZVPhMr+p2yTAoNS/ggweFN2pyUlPt8RJYRuPxdmAhOmBY
	b8k6j/G8gc3XS4O5KAx9CicZ41xKXbK9H5B067R4nlCLCpPL5NwnRkS2e7E/eGJH0mmcO1gxDN/
	wDQJbbznWzTosgXbk2cRqWP4cLTa/COQOkU0bvr87wBQltXrShRxJd1bxMAFTZwzX637J0jbXH3
	wJGrYU6plwx5ES6o3gBzSN1vEC8lnyZZTm0PCjPEgBVHF9Wtm2pxjyvblTUGhYELM48h5seqjvD
	uv8BoxDBGzvmj5c0Hj/WB5muRCQhEUOqqy8ybXla8Yq99qX9oQZ9MvynKKSDonaFybXyBjBPAX4
	T5Ok8r1s9c6KQBMVWTZvVmimqPA==
X-Received: by 2002:a17:903:2c03:b0:296:5ea8:ed7c with SMTP id d9443c01a7336-297e562e81emr111981595ad.17.1762777717530;
        Mon, 10 Nov 2025 04:28:37 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGwNP3fxkUJGLqN8FHuaSG3OfyFaMMBHENbvYTPgP0pEg/sV6ty2vZFcY/LvfBaaJEc8EM4Tg==
X-Received: by 2002:a17:903:2c03:b0:296:5ea8:ed7c with SMTP id d9443c01a7336-297e562e81emr111980905ad.17.1762777716858;
        Mon, 10 Nov 2025 04:28:36 -0800 (PST)
Received: from hu-mojha-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29651c93cebsm144992255ad.90.2025.11.10.04.28.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Nov 2025 04:28:36 -0800 (PST)
Date: Mon, 10 Nov 2025 17:58:24 +0530
From: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
To: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Souvik Chakravarty <Souvik.Chakravarty@arm.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Andy Yan <andy.yan@rock-chips.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Konrad Dybcio <konradybcio@kernel.org>,
        cros-qcom-dts-watchers@chromium.org, Vinod Koul <vkoul@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Moritz Fischer <moritz.fischer@ettus.com>,
        John Stultz <john.stultz@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Andre Draszik <andre.draszik@linaro.org>,
        Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org,
        Elliot Berman <quic_eberman@quicinc.com>,
        Xin Liu <xin.liu@oss.qualcomm.com>,
        Srinivas Kandagatla <srini@kernel.org>,
        Elliot Berman <elliot.berman@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: Re: [PATCH v17 09/12] arm64: dts: qcom: qcs6490-rb3gen2: Add PSCI
 SYSTEM_RESET2 types
Message-ID: <20251110122824.5je5jfoanivl6xrh@hu-mojha-hyd.qualcomm.com>
References: <20251109-arm-psci-system_reset2-vendor-reboots-v17-0-46e085bca4cc@oss.qualcomm.com>
 <20251109-arm-psci-system_reset2-vendor-reboots-v17-9-46e085bca4cc@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251109-arm-psci-system_reset2-vendor-reboots-v17-9-46e085bca4cc@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=QuxTHFyd c=1 sm=1 tr=0 ts=6911da76 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=kj9zAlcOel0A:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=vzLQbmpfVAQOsT_rZiMA:9
 a=CjuIK1q_8ugA:10 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-ORIG-GUID: utE7zQOFwWd2OjMiz6kvBquHB2-6OryE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEwMDEwOSBTYWx0ZWRfX662N3zyF87Hp
 gb62lLqD//AXSnVPbvZ0o6qa6PO6Yx/qM4WAEGr0w6GH0FgBiugl/AKAD1jHWNWgGGsWG84pLv0
 vUbfs7Dqw/4RHasCRMP8ZUOApeoyyraEGXOIkS+G9wnNmLwMP0CYlrEjejEOxS+1lVT0Mv0IAb5
 BZi7gzIpvzqvQmuVQlwT2kQisLvTuBOlYdtGVnaYDVzfWsg88ICmcRP07LFqnvz7Cx6wnSjWSjH
 S7LrfGIw1imZ1/gJiBE/ZPRWoWVGlufOaL/UjwrdXJInfTAzH/mc+qezqz7fvH+Fm/pjBWWx1Bv
 8omGUXEmFtaBpAbsnbOlkb3x5PmH3rq7yJux9xXViQmd8+jmCPdYDKvnGFDIxCO3OG+ylkLYQkF
 o5+Ctoux93Y3kbmJHv09dbidxZznLw==
X-Proofpoint-GUID: utE7zQOFwWd2OjMiz6kvBquHB2-6OryE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-10_05,2025-11-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 priorityscore=1501 adultscore=0 phishscore=0
 spamscore=0 impostorscore=0 malwarescore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511100109

On Sun, Nov 09, 2025 at 08:07:22PM +0530, Shivendra Pratap wrote:
> From: Elliot Berman <elliot.berman@oss.qualcomm.com>
> 
> Add support for SYSTEM_RESET2 vendor-specific resets in
> qcs6490-rb3gen2 as reboot-modes.  Describe the resets:
> "bootloader" will cause device to reboot and stop in the
> bootloader's fastboot mode. "edl" will cause device to reboot
> into "emergency download mode", which permits loading images via
> the Firehose protocol.
> 
> Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> Signed-off-by: Elliot Berman <elliot.berman@oss.qualcomm.com>
> Signed-off-by: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
> ---
>  arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts b/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
> index 721a26d49ccaeb1429e2cc1c3a5c8d9517da3be6..cebdedd5d614b9efb6dfbee91dd67f3c3e322a38 100644
> --- a/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
> +++ b/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
> @@ -935,6 +935,13 @@ &pon_resin {
>  	status = "okay";
>  };
>  
> +&psci {
> +	reboot-mode {
> +		mode-bootloader = <0x10001 0x2>;
> +		mode-edl = <0 0x1>;
> +	};
> +};
> +

Make sense for this as it leverages sc7280 and adding it there would not
have made sense.

Acked-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>

>  &qup_uart7_cts {
>  	/*
>  	 * Configure a bias-bus-hold on CTS to lower power
> 
> -- 
> 2.34.1
> 

-- 
-Mukesh Ojha

