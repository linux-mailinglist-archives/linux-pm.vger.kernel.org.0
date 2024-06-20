Return-Path: <linux-pm+bounces-9682-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F8FE910999
	for <lists+linux-pm@lfdr.de>; Thu, 20 Jun 2024 17:16:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BD4C1B22E22
	for <lists+linux-pm@lfdr.de>; Thu, 20 Jun 2024 15:16:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6BE71AF6B7;
	Thu, 20 Jun 2024 15:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YZVch/qq"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AD2D1AF6B5
	for <linux-pm@vger.kernel.org>; Thu, 20 Jun 2024 15:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718896585; cv=none; b=p2K9rjNElsZrzppYCilEdCp7w2GStDPneZU6fXA2h6x7sv3VsQFZwvWnz6JMBoJUIkrb9bda7c6U8ITB7XTnT5KRjVkYJ9Gd96Zj5mzP8pzH6gjZ8v8m4Dgysfu80wdLTx3hoY6cEI3aUzCZuCd5/D2mzZ4LVt8nAPhLEk0njBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718896585; c=relaxed/simple;
	bh=KRHMtLJrF+j4+GXIMITBdynXNl/Y+VeIHS0AQJgTEBg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qXfuvbQoYwnDC9FhNPxQvDG9t4wLJNXvth0L6LYSiXz+hGl4HUBpeZngmP9hxNqaBL6tuaFi/i5J48GPiMWP5Zqofu0+4sxnhCQXBmnOvP977ks2YkvWyd9zAWZgZ9k+59KYl4pemAitH3MT1s6aimJAoRgywYrR5i5+7kPHO78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=YZVch/qq; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-52c9034860dso1254581e87.2
        for <linux-pm@vger.kernel.org>; Thu, 20 Jun 2024 08:16:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718896581; x=1719501381; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QczbahY8mobXaJEZMcLZwiI4MMRcFJ224ASCceiqP1s=;
        b=YZVch/qqT1lDZTTh3NblhKkT6lUEOQURhalXQmJ4aNnCXVNiw3gVV8SXMISm47aB5H
         KHBSI57HwqQ07cE+DhM7LxqlgL5ZNkBLx6aVp0AJdWePSyWS5ZhEd78j54SxL2BN9Egg
         1kZUP2+AqpFMs/62JukK/22NPaK+Kg5eUx/Yy2qPxxXDhGp/epJ8Wk8xYt/Vb3fMNSIU
         mxW6d+c+Vn9C0j/gCR5vAMQVQ+lEQK9HDkfvWt4lptN7SKeptMxjFyseTmoVq5Quh7un
         wE3jDKE74i4xdixOL8EkmpZntXAETteivm1fy2GwBqYKv0u6npJRFeJUXeSaChYiJRzu
         OFwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718896581; x=1719501381;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QczbahY8mobXaJEZMcLZwiI4MMRcFJ224ASCceiqP1s=;
        b=Xdp2tmuMCm1h7OiucJNAuyFulaN+aL0N4f/PsQ3jOTS7LVe9TZNYuuFMAjbvjuePSB
         0xpTsAYe7C5Vf3EfnQGLQGh+rBhZ88VZMtZTwUdRBQvvz6p++O72Jzf7eEgceS4WuBsB
         n9w35jnGaFV0rOX3dkZtUSlg6iNNnxkIbF93LgIRy30tX4R23a1TCUu3U5EncjLnjTvi
         Wynk3isG2Saufv03J8RG43mPc3dhpO1D3MA4rljOXLnM+LFvJkxKROg+0yOrNDWwoSuJ
         N5H87iCR6dfEIYlZNP+pEX11GEErNtiIrXKFPzlA72GRqIgg4Ky8esQDLpL5fLe3tJy4
         G6pA==
X-Forwarded-Encrypted: i=1; AJvYcCWRiPTA49iaS5Ab8JWWc5cVNaU7C7wBGvdutv2pa2zVgSVvtR5G0/akMpQ5umZnEblLuacoZ7Y4NhrmL6qEJYqJjZ/AoC6JuEA=
X-Gm-Message-State: AOJu0YxLKoFDqiexQnLNxL7KLbODhXQq/5w2s1LBMV+tWTOQCeJr3PDV
	qSXtSBojntDwpvSOrhvgTeRf3son23MgQNiTtCTiwqtWfj+lbYIR4rhXdqWJPsU=
X-Google-Smtp-Source: AGHT+IGscRI/bwMTqNox27PJIvo6iwRNWan3tUIVDnHv6SnwjilhAds1ngg2KWSBnVtn2aaKj0qiOw==
X-Received: by 2002:a05:6512:39cd:b0:52b:7a44:e17b with SMTP id 2adb3069b0e04-52ccaa2a8eemr5144165e87.13.1718896580684;
        Thu, 20 Jun 2024 08:16:20 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyybrhy-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52ca288e6dfsm2101164e87.307.2024.06.20.08.16.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jun 2024 08:16:20 -0700 (PDT)
Date: Thu, 20 Jun 2024 18:16:18 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Varadarajan Narayanan <quic_varada@quicinc.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	angelogioacchino.delregno@collabora.com, andersson@kernel.org, konrad.dybcio@linaro.org, 
	mturquette@baylibre.com, sboyd@kernel.org, ulf.hansson@linaro.org, quic_sibis@quicinc.com, 
	quic_rjendra@quicinc.com, luca@z3ntu.xyz, abel.vesa@linaro.org, quic_rohiagar@quicinc.com, 
	danila@jiaxyga.com, otto.pflueger@abscue.de, linux-arm-msm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, 
	linux-pm@vger.kernel.org
Subject: Re: [PATCH v1 7/7] dts: arm64: qcom: ipq9574: Enable CPR
Message-ID: <x3jznckxbnqz6lxbqpdgmevw7dppsuqiqs56vugeyxhbcmw2m4@fyk6mzrtg5b7>
References: <20240620081427.2860066-1-quic_varada@quicinc.com>
 <20240620081427.2860066-8-quic_varada@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240620081427.2860066-8-quic_varada@quicinc.com>

On Thu, Jun 20, 2024 at 01:44:27PM GMT, Varadarajan Narayanan wrote:
> Add CPR, RPMPD, OPP table nodes as applicable to IPQ9574 to
> enable CPR functionality on IPQ9574.

Please document your CPU opp table changes in the commit message. You
have added 792 MHz, dropped 1200 MHz. At least we need to know what's
going on.

> 
> Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
> ---
>  arch/arm64/boot/dts/qcom/ipq9574.dtsi | 269 ++++++++++++++++++++++++--
>  1 file changed, 252 insertions(+), 17 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/ipq9574.dtsi b/arch/arm64/boot/dts/qcom/ipq9574.dtsi
> index 04ba09a9156c..439ee5accc47 100644
> --- a/arch/arm64/boot/dts/qcom/ipq9574.dtsi
> +++ b/arch/arm64/boot/dts/qcom/ipq9574.dtsi
> @@ -11,6 +11,7 @@
>  #include <dt-bindings/interrupt-controller/arm-gic.h>
>  #include <dt-bindings/reset/qcom,ipq9574-gcc.h>
>  #include <dt-bindings/thermal/thermal.h>
> +#include <dt-bindings/power/qcom-rpmpd.h>
>  
>  / {
>  	interrupt-parent = <&intc>;
> @@ -42,8 +43,9 @@ CPU0: cpu@0 {
>  			clocks = <&apcs_glb APCS_ALIAS0_CORE_CLK>;
>  			clock-names = "cpu";
>  			operating-points-v2 = <&cpu_opp_table>;
> -			cpu-supply = <&ipq9574_s1>;
>  			#cooling-cells = <2>;
> +			power-domains = <&apc_cprh 0>;
> +			power-domain-names = "perf";
>  		};
>  
>  		CPU1: cpu@1 {
> @@ -55,8 +57,9 @@ CPU1: cpu@1 {
>  			clocks = <&apcs_glb APCS_ALIAS0_CORE_CLK>;
>  			clock-names = "cpu";
>  			operating-points-v2 = <&cpu_opp_table>;
> -			cpu-supply = <&ipq9574_s1>;
>  			#cooling-cells = <2>;
> +			power-domains = <&apc_cprh 0>;
> +			power-domain-names = "perf";
>  		};
>  
>  		CPU2: cpu@2 {
> @@ -68,8 +71,9 @@ CPU2: cpu@2 {
>  			clocks = <&apcs_glb APCS_ALIAS0_CORE_CLK>;
>  			clock-names = "cpu";
>  			operating-points-v2 = <&cpu_opp_table>;
> -			cpu-supply = <&ipq9574_s1>;
>  			#cooling-cells = <2>;
> +			power-domains = <&apc_cprh 0>;
> +			power-domain-names = "perf";
>  		};
>  
>  		CPU3: cpu@3 {
> @@ -81,8 +85,9 @@ CPU3: cpu@3 {
>  			clocks = <&apcs_glb APCS_ALIAS0_CORE_CLK>;
>  			clock-names = "cpu";
>  			operating-points-v2 = <&cpu_opp_table>;
> -			cpu-supply = <&ipq9574_s1>;
>  			#cooling-cells = <2>;
> +			power-domains = <&apc_cprh 0>;
> +			power-domain-names = "perf";
>  		};
>  
>  		L2_0: l2-cache {
> @@ -105,58 +110,111 @@ memory@40000000 {
>  		reg = <0x0 0x40000000 0x0 0x0>;
>  	};
>  
> +	cprh_opp_table: opp-table-cprh {
> +		compatible = "operating-points-v2-qcom-level";
> +
> +		cprh_opp0: opp-0 {
> +			opp-level = <1>;
> +			qcom,opp-fuse-level = <1>;
> +			qcom,opp-cloop-vadj = <0>;
> +			qcom,opp-oloop-vadj = <0>;
> +		};
> +
> +		cprh_opp1: opp-1 {
> +			opp-level = <2>;
> +			qcom,opp-fuse-level = <1>;
> +			qcom,opp-cloop-vadj = <0>;
> +			qcom,opp-oloop-vadj = <0>;
> +		};
> +
> +		cprh_opp2: opp-2 {
> +			opp-level = <3>;
> +			qcom,opp-fuse-level = <1>;
> +			qcom,opp-cloop-vadj = <0>;
> +			qcom,opp-oloop-vadj = <0>;
> +		};
> +
> +		cprh_opp3: opp-3 {
> +			opp-level = <4>;
> +			qcom,opp-fuse-level = <2>;
> +			qcom,opp-cloop-vadj = <0>;
> +			qcom,opp-oloop-vadj = <0>;
> +		};
> +
> +		cprh_opp4: opp-4 {
> +			opp-level = <5>;
> +			qcom,opp-fuse-level = <2>;
> +			qcom,opp-cloop-vadj = <0>;
> +			qcom,opp-oloop-vadj = <0>;
> +		};
> +
> +		cprh_opp5: opp-5 {
> +			opp-level = <6>;
> +			qcom,opp-fuse-level = <3>;
> +			qcom,opp-cloop-vadj = <0>;
> +			qcom,opp-oloop-vadj = <0>;
> +		};
> +
> +		cprh_opp6: opp-6 {
> +			opp-level = <7>;
> +			qcom,opp-fuse-level = <4>;
> +			qcom,opp-cloop-vadj = <0>;
> +			qcom,opp-oloop-vadj = <0>;
> +		};
> +	};
> +
>  	cpu_opp_table: opp-table-cpu {
>  		compatible = "operating-points-v2-kryo-cpu";
>  		opp-shared;
>  		nvmem-cells = <&cpu_speed_bin>;
>  
> +		opp-792000000 {
> +			opp-hz = /bits/ 64 <792000000>;
> +			opp-supported-hw = <0x0>;
> +			clock-latency-ns = <200000>;
> +			required-opps = <&cprh_opp0>;
> +		};
> +
>  		opp-936000000 {
>  			opp-hz = /bits/ 64 <936000000>;
> -			opp-microvolt = <725000>;
>  			opp-supported-hw = <0xf>;
>  			clock-latency-ns = <200000>;
> +			required-opps = <&cprh_opp1>;
>  		};
>  
>  		opp-1104000000 {
>  			opp-hz = /bits/ 64 <1104000000>;
> -			opp-microvolt = <787500>;
> -			opp-supported-hw = <0xf>;
> -			clock-latency-ns = <200000>;
> -		};
> -
> -		opp-1200000000 {
> -			opp-hz = /bits/ 64 <1200000000>;
> -			opp-microvolt = <862500>;
>  			opp-supported-hw = <0xf>;
>  			clock-latency-ns = <200000>;
> +			required-opps = <&cprh_opp2>;
>  		};
>  
>  		opp-1416000000 {
>  			opp-hz = /bits/ 64 <1416000000>;
> -			opp-microvolt = <862500>;
>  			opp-supported-hw = <0x7>;
>  			clock-latency-ns = <200000>;
> +			required-opps = <&cprh_opp3>;
>  		};
>  
>  		opp-1488000000 {
>  			opp-hz = /bits/ 64 <1488000000>;
> -			opp-microvolt = <925000>;
>  			opp-supported-hw = <0x7>;
>  			clock-latency-ns = <200000>;
> +			required-opps = <&cprh_opp4>;
>  		};
>  
>  		opp-1800000000 {
>  			opp-hz = /bits/ 64 <1800000000>;
> -			opp-microvolt = <987500>;
>  			opp-supported-hw = <0x5>;
>  			clock-latency-ns = <200000>;
> +			required-opps = <&cprh_opp5>;
>  		};
>  
>  		opp-2208000000 {
>  			opp-hz = /bits/ 64 <2208000000>;
> -			opp-microvolt = <1062500>;
>  			opp-supported-hw = <0x1>;
>  			clock-latency-ns = <200000>;
> +			required-opps = <&cprh_opp6>;
>  		};
>  	};
>  
> @@ -182,6 +240,40 @@ glink-edge {
>  			rpm_requests: rpm-requests {
>  				compatible = "qcom,rpm-ipq9574";
>  				qcom,glink-channels = "rpm_requests";
> +
> +				rpmpd: power-controller {
> +					compatible = "qcom,ipq9574-rpmpd";
> +					#power-domain-cells = <1>;
> +					operating-points-v2 = <&rpmpd_opp_table>;
> +
> +					rpmpd_opp_table: opp-table {
> +						compatible = "operating-points-v2";
> +
> +						rpmpd_opp_svs: opp1 {

Where are these nodes going to be used?

> +							opp-level = <RPM_SMD_LEVEL_SVS>;
> +						};
> +
> +						rpmpd_opp_svs_plus: opp2 {
> +							opp-level = <RPM_SMD_LEVEL_SVS_PLUS>;
> +						};
> +
> +						rpmpd_opp_nom: opp3 {
> +							opp-level = <RPM_SMD_LEVEL_NOM>;
> +						};
> +
> +						rpmpd_opp_nom_plus: opp4 {
> +							opp-level = <RPM_SMD_LEVEL_NOM_PLUS>;
> +						};
> +
> +						rpmpd_opp_turbo: opp5 {
> +							opp-level = <RPM_SMD_LEVEL_TURBO>;
> +						};
> +
> +						rpmpd_opp_turbo_high: opp6 {
> +							opp-level = <RPM_SMD_LEVEL_TURBO_HIGH>;
> +						};
> +					};
> +				};
>  			};
>  		};
>  	};
> @@ -252,6 +344,95 @@ cpu_speed_bin: cpu-speed-bin@15 {
>  				reg = <0x15 0x2>;
>  				bits = <7 2>;
>  			};
> +
> +			cpr_efuse_speedbin: speedbin@5 {
> +				reg = <0x5 0x8>;
> +				bits = <0 3>;
> +			};
> +
> +			cpr_fuse_revision: cpr-fusing-rev@7 {
> +				reg = <0x7 0x8>;
> +				bits = <1 5>;
> +			};
> +
> +			/* CPR Ring Oscillator: Power Cluster */
> +			cpr_ro_sel0_pwrcl: rosel0-pwrcl@358 {	/* ROSEL_SVS */
> +				reg = <0x358 0x1>;
> +				bits = <4 4>;
> +			};
> +
> +			cpr_ro_sel1_pwrcl: rosel1-pwrcl@358 {	/* ROSEL_NOM */
> +				reg = <0x358 0x1>;
> +				bits = <0 4>;
> +			};
> +
> +			cpr_ro_sel2_pwrcl: rosel2-pwrcl@350 {	/* ROSEL_TUR */
> +				reg = <0x350 0x1>;
> +				bits = <4 4>;
> +			};
> +
> +			cpr_ro_sel3_pwrcl: rosel3-pwrcl@350 {	/* ROSEL_STUR */
> +				reg = <0x350 0x1>;
> +				bits = <0 4>;
> +			};
> +
> +			/* CPR Init Voltage: Power Cluster */
> +			cpr_init_voltage0_pwrcl: ivolt0-pwrcl@343 {	/* VOLT_SVS */
> +				reg = <0x343 0x1>;
> +				bits = <0 6>;
> +			};
> +
> +			cpr_init_voltage1_pwrcl: ivolt1-pwrcl@342 {	/* VOLT_NOM */
> +				reg = <0x342 0x1>;
> +				bits = <2 6>;
> +			};
> +
> +			cpr_init_voltage2_pwrcl: ivolt2-pwrcl@341 {	/* VOLT_TUR */
> +				reg = <0x341 0x2>;
> +				bits = <4 6>;
> +			};
> +
> +			cpr_init_voltage3_pwrcl: ivolt3-pwrcl@340 {	/* VOLT_STUR */
> +				reg = <0x340 0x2>;
> +				bits = <6 6>;
> +			};
> +
> +			/* CPR Target Quotients: Power Cluster */
> +			cpr_quot0_pwrcl: quot0-pwrcl@354 {	/* QUOT_VMIN_SVS */
> +				reg = <0x354 0x2>;
> +				bits = <0 12>;
> +			};
> +
> +			cpr_quot1_pwrcl: quot1-pwrcl@352 {	/* QUOT_VMIN_NOM */
> +				reg = <0x352 0x2>;
> +				bits = <4 12>;
> +			};
> +
> +			cpr_quot2_pwrcl: quot2-pwrcl@351 {	/* QUOT_VMIN_TUR */
> +				reg = <0x351 0x2>;
> +				bits = <0 12>;
> +			};
> +
> +			cpr_quot3_pwrcl: quot3-pwrcl@355 {	/* QUOT_VMIN_STUR */
> +				reg = <0x355 0x2>;
> +				bits = <4 12>;
> +			};
> +
> +			/* CPR Quotient Offsets: Power Cluster */
> +			cpr_quot_offset1_pwrcl: qoff1-pwrcl@34e {	/* QUOT_OFFSET_NOM_SVS */
> +				reg = <0x34e 0x1>;
> +				bits = <0 8>;
> +			};
> +
> +			cpr_quot_offset2_pwrcl: qoff2-pwrcl@34d {	/* QUOT_OFFSET_TUR_NOM */
> +				reg = <0x34d 0x1>;
> +				bits = <0 8>;
> +			};
> +
> +			cpr_quot_offset3_pwrcl: qoff0-pwrcl@34c {	/* QUOT_OFFSET_STUR_TUR */
> +				reg = <0x34c 0x1>;
> +				bits = <0 8>;
> +			};
>  		};
>  
>  		cryptobam: dma-controller@704000 {
> @@ -639,6 +820,60 @@ usb_0_dwc3: usb@8a00000 {
>  			};
>  		};
>  
> +		apc_cprh: power-controller@b018000 {
> +			compatible = "qcom,ipq9574-cprh", "qcom,cprh";
> +			reg = <0x0b018000 0x4000>,
> +			      <0x00048000 0x4000>;
> +
> +			clocks = <&gcc GCC_RBCPR_CLK>;
> +
> +			interrupts = <GIC_SPI 15 IRQ_TYPE_EDGE_RISING>;
> +			vdd-supply = <&ipq9574_s1>;
> +
> +			/* Set the CPR clock here, it needs to match XO */
> +			assigned-clocks = <&gcc GCC_RBCPR_CLK>;
> +			assigned-clock-rates = <24000000>;
> +
> +			operating-points-v2 = <&cprh_opp_table>;
> +			power-domains = <&rpmpd IPQ9574_VDDAPC>;
> +			#power-domain-cells = <1>;
> +
> +			nvmem-cells = <&cpr_efuse_speedbin>,
> +				      <&cpr_fuse_revision>,
> +				      <&cpr_quot0_pwrcl>,
> +				      <&cpr_quot1_pwrcl>,
> +				      <&cpr_quot2_pwrcl>,
> +				      <&cpr_quot3_pwrcl>,
> +				      <&cpr_quot_offset1_pwrcl>,
> +				      <&cpr_quot_offset2_pwrcl>,
> +				      <&cpr_quot_offset3_pwrcl>,
> +				      <&cpr_init_voltage0_pwrcl>,
> +				      <&cpr_init_voltage1_pwrcl>,
> +				      <&cpr_init_voltage2_pwrcl>,
> +				      <&cpr_init_voltage3_pwrcl>,
> +				      <&cpr_ro_sel0_pwrcl>,
> +				      <&cpr_ro_sel1_pwrcl>,
> +				      <&cpr_ro_sel2_pwrcl>,
> +				      <&cpr_ro_sel3_pwrcl>;
> +			nvmem-cell-names = "cpr_speed_bin",
> +					   "cpr_fuse_revision",
> +					   "cpr0_quotient1",
> +					   "cpr0_quotient2",
> +					   "cpr0_quotient3",
> +					   "cpr0_quotient4",
> +					   "cpr0_quotient_offset2",
> +					   "cpr0_quotient_offset3",
> +					   "cpr0_quotient_offset4",
> +					   "cpr0_init_voltage1",
> +					   "cpr0_init_voltage2",
> +					   "cpr0_init_voltage3",
> +					   "cpr0_init_voltage4",
> +					   "cpr0_ring_osc1",
> +					   "cpr0_ring_osc2",
> +					   "cpr0_ring_osc3",
> +					   "cpr0_ring_osc4";
> +		};
> +
>  		intc: interrupt-controller@b000000 {
>  			compatible = "qcom,msm-qgic2";
>  			reg = <0x0b000000 0x1000>,  /* GICD */
> -- 
> 2.34.1
> 

-- 
With best wishes
Dmitry

