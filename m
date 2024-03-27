Return-Path: <linux-pm+bounces-5540-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AA2E88F0D6
	for <lists+linux-pm@lfdr.de>; Wed, 27 Mar 2024 22:24:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B3EA31F223C8
	for <lists+linux-pm@lfdr.de>; Wed, 27 Mar 2024 21:24:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DFD11534E5;
	Wed, 27 Mar 2024 21:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y6doAP29"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2912628366;
	Wed, 27 Mar 2024 21:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711574689; cv=none; b=IrPFdKWkyD3cEb+W2IbKcR72Mj/txzvRyld95tZl69xgrSB5BHfXjTgoaYZpY6dWmf+QcvhEzgqAdbzXHGE9rRuqbSXbBp6krMAaChxIfgx0OHj0eautEMOaU+W49h2w96nIhZPIP8tO7Aqk+kBwt7zz8hVf1ROCxyBHACH/+eM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711574689; c=relaxed/simple;
	bh=AT9KFGQQ9sqHmU0GvGUAx/lXcN4gMV2bNh15AQJ+3Ug=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YWKXFHCFtZKgbLepnaN18GX1KpRHN3bqyOiAmyzlhryj49eRjQRW4Y/MbYwktPx0t+isLa+BhNdWXrlUEExDfUQ1/mu6TZ1TWUUIQJ653C1PkF5SHWlnPQXVWUAQ4jSIzskPlM3Wh/Z31oWgHq6VPoPUHWXs+yEF0AjicErnq38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y6doAP29; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a4734ae95b3so35726166b.0;
        Wed, 27 Mar 2024 14:24:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711574686; x=1712179486; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1eawYx38ABDnE1SDp1aNunxt7lkWGLWWm8mQqMXuM70=;
        b=Y6doAP29YpColxQ09v01vFC8mEl0MuMKVDO1Zbjw6TZlsYLYPmL0V176g0BmXm3iv2
         CQ+2q+tYGWgIERXXKhCFvcHO6Ykv1H4l+08F0PVlo/E5b8o3svjBSG9wqk8tBWZ8gqwS
         /2nJRrIwkXK52/MCu4tSXnBPeN8UMAUFiiC1xB3WQ4odgv9TI6PBLCVXc1KseA3vPxwG
         4LnzcXiQ5atNT2qefZcJEDGFXeRhSym0qXsD29SS4YVqCRiz09kxh9boPdw1PvWb1bYc
         T+b1PgikErQRqYdGTnahk2mlyV92ITiAIsO3djtSBxeMV4AjLiJsI6Y91eLtADsYsZ3u
         NsWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711574686; x=1712179486;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1eawYx38ABDnE1SDp1aNunxt7lkWGLWWm8mQqMXuM70=;
        b=GKRa3X6SqBpVgXLMn6q3cWXXSZDsiO2Cz9xoq3zhwImyqzRAdWEKHQVWF4E+yzP2ef
         CNpTA4Jyb/2L4kjePlMoN9duyCDgCetkDC4azaSuelQFPXErQCw9hrRMu35XaiRcyLP/
         Rv0dFTqp4DdR8KsmmWvQ61xeP4TTYsEb/M+cWLbWG493IvLgkIbrck0ZIbBLYRgd4U37
         bOtf9KGvHPtVgFiqpCsxvxgB66ANXHCEDiiMZ1b1VA2Syg60E/L3eqyBWVythn6rEygO
         Bj7lssY8eCzVDOymIk1J3L6wPK743cA0RHilgN1e+ttU1+qk7MT1j75KVdYjdwrgIpTP
         BM5A==
X-Forwarded-Encrypted: i=1; AJvYcCUmm/G4DkysqRIQMzsOOv1s+Cwg8ISZ9L4h0NzBbi6b7VBDjykWx5m4wYZPzSlOJDVHo7RQC3g/zkWr8eYapt/VGn019KidEt9hRQ==
X-Gm-Message-State: AOJu0YxsAcJfVNIAoG+AJFv6FuXn50GWQwNeWq2u9OyhJyrBkYSlVgVB
	s747hn88JzLGBC6rE2Tg6WLtVnn1/dz+e2XgjKQdxULa2hOJp/LY
X-Google-Smtp-Source: AGHT+IGYmY0ghm0yr8Pe9NEizV2ZCw3A+KRCLXyoDjDLsubmZrEcjNQyYa+mH5D0o38fVg9fCSXMwQ==
X-Received: by 2002:a17:907:7255:b0:a46:be3d:1ed8 with SMTP id ds21-20020a170907725500b00a46be3d1ed8mr539387ejc.54.1711574686294;
        Wed, 27 Mar 2024 14:24:46 -0700 (PDT)
Received: from jernej-laptop.localnet (86-58-6-171.dynamic.telemach.net. [86.58.6.171])
        by smtp.gmail.com with ESMTPSA id i1-20020a170906a28100b00a4668970f74sm5913600ejz.108.2024.03.27.14.24.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Mar 2024 14:24:45 -0700 (PDT)
From: Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To: Yangtao Li <tiny.windzz@gmail.com>, Viresh Kumar <vireshk@kernel.org>,
 Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
 Samuel Holland <samuel@sholland.org>,
 "Rafael J . Wysocki" <rafael@kernel.org>,
 Andre Przywara <andre.przywara@arm.com>
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-sunxi@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 Brandon Cheo Fusi <fusibrandon13@gmail.com>,
 Martin Botka <martin.botka@somainline.org>,
 Martin Botka <martin.botka1@gmail.com>,
 Chris Morgan <macroalpha82@gmail.com>, Ryan Walklin <ryan@testtoast.com>
Subject: Re: [PATCH v3 7/8] arm64: dts: allwinner: h616: Add CPU OPPs table
Date: Wed, 27 Mar 2024 22:24:44 +0100
Message-ID: <114106220.nniJfEyVGO@jernej-laptop>
In-Reply-To: <20240326114743.712167-8-andre.przywara@arm.com>
References:
 <20240326114743.712167-1-andre.przywara@arm.com>
 <20240326114743.712167-8-andre.przywara@arm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"

Dne torek, 26. marec 2024 ob 12:47:42 CET je Andre Przywara napisal(a):
> From: Martin Botka <martin.botka@somainline.org>
> 
> Add an Operating Performance Points table for the CPU cores to enable
> Dynamic Voltage & Frequency Scaling (DVFS) on the H616.
> The values were taken from the BSP sources. The (newer) H700 chips we
> have seen seem to use a separate speed bin, its OPP values were taken
> from a live system and added to the mix.
> 
> Also add the needed cpu_speed_grade nvmem cell and the cooling cells
> properties, to enable passive cooling.
> 
> Signed-off-by: Martin Botka <martin.botka@somainline.org>
> [Andre: rework to minimise opp-microvolt properties]
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> ---
>  .../dts/allwinner/sun50i-h616-cpu-opp.dtsi    | 125 ++++++++++++++++++
>  .../arm64/boot/dts/allwinner/sun50i-h616.dtsi |   8 ++
>  2 files changed, 133 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/allwinner/sun50i-h616-cpu-opp.dtsi
> 
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h616-cpu-opp.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-h616-cpu-opp.dtsi
> new file mode 100644
> index 0000000000000..6073fdf672592
> --- /dev/null
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-h616-cpu-opp.dtsi
> @@ -0,0 +1,125 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +// Copyright (C) 2023 Martin Botka <martin@somainline.org>
> +
> +/ {
> +	cpu_opp_table: opp-table-cpu {
> +		compatible = "allwinner,sun50i-h616-operating-points";
> +		nvmem-cells = <&cpu_speed_grade>;
> +		opp-shared;
> +
> +		opp-480000000 {
> +			opp-hz = /bits/ 64 <480000000>;
> +			opp-microvolt = <900000>;

Ideally triplet of voltages should be specified, to support PMIC-less boards,
but that's unlikely to happen with these SoCs.

Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej

> +			clock-latency-ns = <244144>; /* 8 32k periods */
> +			opp-supported-hw = <0x3f>;
> +		};
> +
> +		opp-600000000 {
> +			opp-hz = /bits/ 64 <600000000>;
> +			opp-microvolt = <900000>;
> +			clock-latency-ns = <244144>; /* 8 32k periods */
> +			opp-supported-hw = <0x12>;
> +		};
> +
> +		opp-720000000 {
> +			opp-hz = /bits/ 64 <720000000>;
> +			opp-microvolt = <900000>;
> +			clock-latency-ns = <244144>; /* 8 32k periods */
> +			opp-supported-hw = <0x2d>;
> +		};
> +
> +		opp-792000000 {
> +			opp-hz = /bits/ 64 <792000000>;
> +			opp-microvolt-speed1 = <900000>;
> +			opp-microvolt-speed4 = <940000>;
> +			clock-latency-ns = <244144>; /* 8 32k periods */
> +			opp-supported-hw = <0x12>;
> +		};
> +
> +		opp-936000000 {
> +			opp-hz = /bits/ 64 <936000000>;
> +			opp-microvolt = <900000>;
> +			clock-latency-ns = <244144>; /* 8 32k periods */
> +			opp-supported-hw = <0x0d>;
> +		};
> +
> +		opp-1008000000 {
> +			opp-hz = /bits/ 64 <1008000000>;
> +			opp-microvolt-speed0 = <950000>;
> +			opp-microvolt-speed1 = <940000>;
> +			opp-microvolt-speed2 = <950000>;
> +			opp-microvolt-speed3 = <950000>;
> +			opp-microvolt-speed4 = <1020000>;
> +			clock-latency-ns = <244144>; /* 8 32k periods */
> +			opp-supported-hw = <0x1f>;
> +		};
> +
> +		opp-10320000 {
> +			opp-hz = /bits/ 64 <1032000000>;
> +			opp-microvolt = <900000>;
> +			clock-latency-ns = <244144>; /* 8 32k periods */
> +			opp-supported-hw = <0x20>;
> +		};
> +
> +		opp-1104000000 {
> +			opp-hz = /bits/ 64 <1104000000>;
> +			opp-microvolt-speed0 = <1000000>;
> +			opp-microvolt-speed2 = <1000000>;
> +			opp-microvolt-speed3 = <1000000>;
> +			opp-microvolt-speed5 = <950000>;
> +			clock-latency-ns = <244144>; /* 8 32k periods */
> +			opp-supported-hw = <0x2d>;
> +		};
> +
> +		opp-1200000000 {
> +			opp-hz = /bits/ 64 <1200000000>;
> +			opp-microvolt-speed0 = <1050000>;
> +			opp-microvolt-speed1 = <1020000>;
> +			opp-microvolt-speed2 = <1050000>;
> +			opp-microvolt-speed3 = <1050000>;
> +			opp-microvolt-speed4 = <1100000>;
> +			opp-microvolt-speed5 = <1020000>;
> +			clock-latency-ns = <244144>; /* 8 32k periods */
> +			opp-supported-hw = <0x3f>;
> +		};
> +
> +		opp-1320000000 {
> +			opp-hz = /bits/ 64 <1320000000>;
> +			opp-microvolt = <1100000>;
> +			clock-latency-ns = <244144>; /* 8 32k periods */
> +			opp-supported-hw = <0x1d>;
> +		};
> +
> +		opp-1416000000 {
> +			opp-hz = /bits/ 64 <1416000000>;
> +			opp-microvolt = <1100000>;
> +			clock-latency-ns = <244144>; /* 8 32k periods */
> +			opp-supported-hw = <0x2d>;
> +		};
> +
> +		opp-1512000000 {
> +			opp-hz = /bits/ 64 <1512000000>;
> +			opp-microvolt-speed1 = <1100000>;
> +			opp-microvolt-speed3 = <1100000>;
> +			opp-microvolt-speed5 = <1160000>;
> +			clock-latency-ns = <244144>; /* 8 32k periods */
> +			opp-supported-hw = <0x2a>;
> +		};
> +	};
> +};
> +
> +&cpu0 {
> +	operating-points-v2 = <&cpu_opp_table>;
> +};
> +
> +&cpu1 {
> +	operating-points-v2 = <&cpu_opp_table>;
> +};
> +
> +&cpu2 {
> +	operating-points-v2 = <&cpu_opp_table>;
> +};
> +
> +&cpu3 {
> +	operating-points-v2 = <&cpu_opp_table>;
> +};
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h616.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-h616.dtsi
> index b2e85e52d1a12..c0fa466fa9f07 100644
> --- a/arch/arm64/boot/dts/allwinner/sun50i-h616.dtsi
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-h616.dtsi
> @@ -26,6 +26,7 @@ cpu0: cpu@0 {
>  			reg = <0>;
>  			enable-method = "psci";
>  			clocks = <&ccu CLK_CPUX>;
> +			#cooling-cells = <2>;
>  		};
>  
>  		cpu1: cpu@1 {
> @@ -34,6 +35,7 @@ cpu1: cpu@1 {
>  			reg = <1>;
>  			enable-method = "psci";
>  			clocks = <&ccu CLK_CPUX>;
> +			#cooling-cells = <2>;
>  		};
>  
>  		cpu2: cpu@2 {
> @@ -42,6 +44,7 @@ cpu2: cpu@2 {
>  			reg = <2>;
>  			enable-method = "psci";
>  			clocks = <&ccu CLK_CPUX>;
> +			#cooling-cells = <2>;
>  		};
>  
>  		cpu3: cpu@3 {
> @@ -50,6 +53,7 @@ cpu3: cpu@3 {
>  			reg = <3>;
>  			enable-method = "psci";
>  			clocks = <&ccu CLK_CPUX>;
> +			#cooling-cells = <2>;
>  		};
>  	};
>  
> @@ -156,6 +160,10 @@ sid: efuse@3006000 {
>  			ths_calibration: thermal-sensor-calibration@14 {
>  				reg = <0x14 0x8>;
>  			};
> +
> +			cpu_speed_grade: cpu-speed-grade@0 {
> +				reg = <0x0 2>;
> +			};
>  		};
>  
>  		watchdog: watchdog@30090a0 {
> 





