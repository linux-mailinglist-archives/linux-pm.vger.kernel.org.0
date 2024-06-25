Return-Path: <linux-pm+bounces-9930-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CAE9E915F39
	for <lists+linux-pm@lfdr.de>; Tue, 25 Jun 2024 09:01:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B8841F23A33
	for <lists+linux-pm@lfdr.de>; Tue, 25 Jun 2024 07:01:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A446B14659B;
	Tue, 25 Jun 2024 07:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="csmc6Pyn"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF127146595;
	Tue, 25 Jun 2024 07:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719298914; cv=none; b=AqONTYVlsEU+jA6zL9s4zEKrLpXnNNDd4lHnHYx/pn4QAcuA8/zeJ04pIgFzQf6RmhwI9Bcl2hJvP01QlInC7JL+RnJhshk9YNCTA3+pE23Lw7zk9FpEb9piPE3WQpJHwdPVQ3mrk/P7ajPkFLX1+HvKRJOSBFZwKxs/pNTo/t4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719298914; c=relaxed/simple;
	bh=5MLzzDi5Q9FaJLoUReTOr7nbEQlLpk8cNTp0kv6oISU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=PtR1DtOo143AQ2eWOBkNIUqT3PpirlV73bMatRbnRts46qIeznhlVUqA8VuwDPIDi59Ol6pF7zQo0ad/sFsJku02KFZ5gKIk8uf3+kKgGyVj0yfJkH/M9QBokmKqnRn4OEIAHN0IgFGDbt0iwawlookDQFuzhJR4uiGlhiQXwBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=csmc6Pyn; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45P44M30023858;
	Tue, 25 Jun 2024 09:01:28 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	swPpw1QOcNX9w/XaFnBy25Y/Ds/3wOvbOXxqoDBW0Fo=; b=csmc6Pynvmeimvnd
	B6wYwX6ETR/ZGO6a1IdcJCgdMYweEFXq7TCYg/tysmTJWmdvArpQq/YofnzFF/g1
	9quA53U2quQ7GugqmF/gxJf60PTCUNpI3M0Lz6vBlES72LK+LhzhjaKDEO6sqvsn
	PJphCufTiMTt8Ff3x89ey177O18GxmQnTRL61ra6Tm2b7f2bL3/Z6tgV91+Yfl0H
	9qXDeDIgC+K/nvgu8kxITOUaXPBnD0PGoMpTQJOuTVp4davFclR4bM6u6x+f1i/N
	d+8eeIJxcZ4EoG9i9J8ZQ2M22AVbKvPoa19bRw/wLMWmLso6vQbRTzYTXk500xcf
	hAz5rQ==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3ywm1gafpw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 25 Jun 2024 09:01:28 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 9566240045;
	Tue, 25 Jun 2024 09:01:23 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 58BE1211941;
	Tue, 25 Jun 2024 09:00:26 +0200 (CEST)
Received: from [10.48.87.62] (10.48.87.62) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 25 Jun
 2024 09:00:25 +0200
Message-ID: <0d15dd5c-c03e-4a54-a151-c109836f1b4c@foss.st.com>
Date: Tue, 25 Jun 2024 09:00:24 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] ARM: dts: sti: add thermal-zones support on stih418
To: Raphael Gallais-Pou <rgallaispou@gmail.com>,
        "Rafael J. Wysocki"
	<rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Zhang Rui
	<rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
        Maxime Coquelin
	<mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
CC: <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>
References: <20240518-thermal-v1-0-7dfca3ed454b@gmail.com>
 <20240518-thermal-v1-3-7dfca3ed454b@gmail.com>
Content-Language: en-US
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <20240518-thermal-v1-3-7dfca3ed454b@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: EQNCAS1NODE3.st.com (10.75.129.80) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-25_03,2024-06-24_01,2024-05-17_01



On 5/18/24 14:12, Raphael Gallais-Pou wrote:
> Add a 'thermal-zones' node for stih418.
> 
> A thermal-zone needs three components:
>   - thermal sensors, described in an earlier commit[1]
>   - cooling devices, specified for each CPU
>   - a thermal zone, describing the overall behavior.
> 
> The thermal zone needs references to both CPUs and thermal sensors,
> which phandle are also added. The thermal management will then be
> achieved on CPUs using the cpufreq framework.
> 
> [1] https://lore.kernel.org/lkml/20240320-thermal-v3-2-700296694c4a@gmail.com/
> 
> Signed-off-by: Raphael Gallais-Pou <rgallaispou@gmail.com>
> ---
>  arch/arm/boot/dts/st/stih407-family.dtsi |  6 +++--
>  arch/arm/boot/dts/st/stih418.dtsi        | 41 +++++++++++++++++++++++++++++---
>  2 files changed, 42 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/st/stih407-family.dtsi b/arch/arm/boot/dts/st/stih407-family.dtsi
> index 29302e74aa1d..35a55aef7f4b 100644
> --- a/arch/arm/boot/dts/st/stih407-family.dtsi
> +++ b/arch/arm/boot/dts/st/stih407-family.dtsi
> @@ -33,7 +33,7 @@ delta_reserved: rproc@44000000 {
>  	cpus {
>  		#address-cells = <1>;
>  		#size-cells = <0>;
> -		cpu@0 {
> +		cpu0: cpu@0 {
>  			device_type = "cpu";
>  			compatible = "arm,cortex-a9";
>  			reg = <0>;
> @@ -52,8 +52,9 @@ cpu@0 {
>  			clock-latency = <100000>;
>  			cpu0-supply = <&pwm_regulator>;
>  			st,syscfg = <&syscfg_core 0x8e0>;
> +			#cooling-cells = <2>;
>  		};
> -		cpu@1 {
> +		cpu1: cpu@1 {
>  			device_type = "cpu";
>  			compatible = "arm,cortex-a9";
>  			reg = <1>;
> @@ -66,6 +67,7 @@ cpu@1 {
>  					    1200000 0
>  					    800000  0
>  					    500000  0>;
> +			#cooling-cells = <2>;
>  		};
>  	};
>  
> diff --git a/arch/arm/boot/dts/st/stih418.dtsi b/arch/arm/boot/dts/st/stih418.dtsi
> index b35b9b7a7ccc..6622ffa8ecfa 100644
> --- a/arch/arm/boot/dts/st/stih418.dtsi
> +++ b/arch/arm/boot/dts/st/stih418.dtsi
> @@ -6,23 +6,26 @@
>  #include "stih418-clock.dtsi"
>  #include "stih407-family.dtsi"
>  #include "stih410-pinctrl.dtsi"
> +#include <dt-bindings/thermal/thermal.h>
>  / {
>  	cpus {
>  		#address-cells = <1>;
>  		#size-cells = <0>;
> -		cpu@2 {
> +		cpu2: cpu@2 {
>  			device_type = "cpu";
>  			compatible = "arm,cortex-a9";
>  			reg = <2>;
>  			/* u-boot puts hpen in SBC dmem at 0xa4 offset */
>  			cpu-release-addr = <0x94100A4>;
> +			#cooling-cells = <2>;
>  		};
> -		cpu@3 {
> +		cpu3: cpu@3 {
>  			device_type = "cpu";
>  			compatible = "arm,cortex-a9";
>  			reg = <3>;
>  			/* u-boot puts hpen in SBC dmem at 0xa4 offset */
>  			cpu-release-addr = <0x94100A4>;
> +			#cooling-cells = <2>;
>  		};
>  	};
>  
> @@ -44,6 +47,38 @@ usb2_picophy2: phy3 {
>  		reset-names = "global", "port";
>  	};
>  
> +	thermal-zones {
> +		cpu_thermal: cpu-thermal {
> +			polling-delay-passive = <250>;  /* 250ms */
> +			polling-delay = <1000>;         /* 1000ms */
> +
> +			thermal-sensors = <&thermal>;
> +
> +			trips {
> +				cpu_crit: cpu-crit {
> +					temperature = <95000>;  /* 95C */
> +					hysteresis = <2000>;
> +					type = "critical";
> +				};
> +				cpu_alert: cpu-alert {
> +					temperature = <85000>;  /* 85C */
> +					hysteresis = <2000>;
> +					type = "passive";
> +				};
> +			};
> +
> +			cooling-maps {
> +				map {
> +					trip = <&cpu_alert>;
> +					cooling-device = <&cpu0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +							 <&cpu1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +							 <&cpu2 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +							 <&cpu3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
> +				};
> +			};
> +		};
> +	};
> +
>  	soc {
>  		rng11: rng@8a8a000 {
>  			status = "disabled";
> @@ -107,7 +142,7 @@ mmc0: sdhci@9060000 {
>  			assigned-clock-rates = <200000000>;
>  		};
>  
> -		thermal@91a0000 {
> +		thermal: thermal@91a0000 {
>  			compatible = "st,stih407-thermal";
>  			reg = <0x91a0000 0x28>;
>  			clock-names = "thermal";
> 

Hi Raphael

Reviewed-by: Patrice Chotard <patrice.chotard@foss.st.com>

Thanks
Patrice

