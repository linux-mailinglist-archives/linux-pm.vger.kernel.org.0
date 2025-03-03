Return-Path: <linux-pm+bounces-23260-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B77E8A4B94E
	for <lists+linux-pm@lfdr.de>; Mon,  3 Mar 2025 09:29:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F41D188BC2B
	for <lists+linux-pm@lfdr.de>; Mon,  3 Mar 2025 08:29:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 705111EF393;
	Mon,  3 Mar 2025 08:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="Ev0Dv9xg"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE03A1EF09A
	for <linux-pm@vger.kernel.org>; Mon,  3 Mar 2025 08:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740990526; cv=none; b=q+nOGt4IqZLJVbbpGbZKAQryrYMDu9Tkl9exFXCVmWt8XsGhfs39ACziXp1c4/rAi9PHRJT1bXEFb31ly4n/eQlj8WE47zWTGqTDzrGc0587h7okDb8slmpSUiJqJb45gzFlDW8qOwOD0IVHuYZoLCYwh1OH69Fj6VvjQRAtc3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740990526; c=relaxed/simple;
	bh=Str9/Z4T7boxdmYNKfUCQAYMERdj9MmqoKnoOftbpzQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DqaHPieYurZp/8CowIAo4A0/ND41iS/+Rg2jO7M50l3wyvBFn8KhUE7pRlBR+PjN32j/R8gtqfEVrtvyTX9ez3fbqY6Y89UNKgR54ZDb+To1mLZ3698gynM2EfxTo/EbzBxH2z3JFptwYoeDyTfxrsUPJTMM0+M77ZZFoEWO3Sk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=Ev0Dv9xg; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5e53b3fa7daso1571060a12.2
        for <linux-pm@vger.kernel.org>; Mon, 03 Mar 2025 00:28:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1740990521; x=1741595321; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GH41p+03OT08ssRRmEqg+Cy0Qf0zi6uiF2rijzbkmOc=;
        b=Ev0Dv9xgqBw7wW32FiSRZEU4FnONDvAlKj2KFKPd0crVicIZbCB6JN3ZMVexMZX9cJ
         ULTqrQXBVSyv8FtYXsbFlL2B4Rqdbjdx+JE1/5D0/ZkEkMJdpBaTyRrp4zG/aHCazaVc
         4J/2QPge4kYNQUbyql8ewpJwvHe//wvgdBPuABXFAuAgVSr5yspF+kvXLb3LosRi3Z7p
         gpTjcrBCXHwQKQX3lrVeubWvfR8bXrc18GhaDOUcHKRFL8QYDCcKAhdYDZSMI1pjvXRS
         ON8pFYCEuw+LuKH7zuGde2Uu248vEs5xEobLxXHX97l5qS+C1fpuwIUNt9mJyzMqPnd2
         ECFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740990521; x=1741595321;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GH41p+03OT08ssRRmEqg+Cy0Qf0zi6uiF2rijzbkmOc=;
        b=HPd3cdRren33o3kQXYxwV4lpMyxNPsJhtaeA4QBxrwOC/IY/6onOb1/sPIEXwgLCwK
         b4dZHNBvU7mGlm+vSFQrCkzQA9LJFSC+9TFPZAunpeKPgclruVxQgFzBLoTPjESJjXHd
         v3TRYGjrjKqhRLsiZ89h/3OzPY0MqHlOZGn6RF4r8KaoLksAQSBFXNEgtfsAYzIjPHHh
         xxZo42lWXbRHG/YOQavTx0JJ0prDLZW1mESGoCD6hfisc53/pW+d9DQ+izg6ezmnG8cQ
         qxg+GFq8wqddWavOQBMyQlExm/Cc1Bxnua1+vcPPoBBBLZrTuGyGgW46Y8fl7PuQXDZB
         O/xg==
X-Forwarded-Encrypted: i=1; AJvYcCXVrp0qx6szBt67ERJUjsGYnMkMbAqYN/kHOO1L8w3vfsA3sstyAOskvachvMwfJJP8bqD7ndQYhg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyVU03h40yqjT6hTNGKfEMpbtFEkPYX4ARitAS63wVRwgiDVDsU
	eq0PHUyFy2H16IZ9Qb9vVbIhrFUThkzwwbNhDmkWe2M4fXVlPQEvExAD0F74E+o=
X-Gm-Gg: ASbGncudTHYOl8Y6x103aP8eSrLjpotfuXGqha+Q/gTqM2XTlftImXzIYPAQk4suucI
	KqgqJ2huF9LpozgdOFRJmfMGWV6gLNFyusvMN8RY2H/+qOZxsOJSiZUJJauXfTmDmLkNKoteNQ/
	eqtwIR6NGZg2txtxOqT4A1ZJ6mrFXl3yujpJeJIwkcI1A5AkTG283uSQX3HyG5jNNphn+tr2GfV
	qwYa4FfvKbq8DAu5+Ndp4mxvR7a1P/KGkG0PJEQrKxfUUiD+bsN2IsStjiDRctYzIM9aSLmVAN5
	P5SGlXuzGl4axomF47O6KHzYxRmXIAW5uzjvJTC4zIfifdbAht0C+w==
X-Google-Smtp-Source: AGHT+IFLKelVEVi00flzE2lHP3gHCMr7kj+GRjh+qndXBWCgYVC+cKiDJx3z7MTtqx+Mlq9hmZIcoQ==
X-Received: by 2002:a05:6402:34c2:b0:5e0:8937:6ef2 with SMTP id 4fb4d7f45d1cf-5e4d6af1104mr11411025a12.8.1740990519662;
        Mon, 03 Mar 2025 00:28:39 -0800 (PST)
Received: from [192.168.50.4] ([82.78.167.138])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e4c3bb632esm6491336a12.36.2025.03.03.00.28.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Mar 2025 00:28:39 -0800 (PST)
Message-ID: <3bdac1bc-b84f-43b0-86be-b9d9b18be25f@tuxon.dev>
Date: Mon, 3 Mar 2025 10:28:36 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 14/21] ARM: dts: microchip: sama7d65: Add SRAM and DRAM
 components support
To: Ryan.Wanner@microchip.com, lee@kernel.org, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, sre@kernel.org,
 nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
 p.zabel@pengutronix.de
Cc: linux@armlinux.org.uk, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rtc@vger.kernel.org
References: <cover.1740671156.git.Ryan.Wanner@microchip.com>
 <ab4002faa1b672023ffc97bf91755720508c275e.1740671156.git.Ryan.Wanner@microchip.com>
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
Content-Language: en-US
In-Reply-To: <ab4002faa1b672023ffc97bf91755720508c275e.1740671156.git.Ryan.Wanner@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi, Ryan,

On 27.02.2025 17:52, Ryan.Wanner@microchip.com wrote:
> From: Ryan Wanner <Ryan.Wanner@microchip.com>
> 
> Add SRAM, secumod, UDDRC, and DDR3phy to enable support for low power modes.
> 
> Signed-off-by: Ryan Wanner <Ryan.Wanner@microchip.com>
> ---
>  arch/arm/boot/dts/microchip/sama7d65.dtsi | 35 +++++++++++++++++++++++
>  1 file changed, 35 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/microchip/sama7d65.dtsi b/arch/arm/boot/dts/microchip/sama7d65.dtsi
> index 92a5347e35b5..c10cc3558efd 100644
> --- a/arch/arm/boot/dts/microchip/sama7d65.dtsi
> +++ b/arch/arm/boot/dts/microchip/sama7d65.dtsi
> @@ -47,12 +47,37 @@ slow_xtal: clock-slowxtal {
>  		};
>  	};
>  
> +	ns_sram: sram@100000 {
> +		compatible = "mmio-sram";
> +		reg = <0x100000 0x20000>;
> +		ranges;
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +	};
> +
>  	soc {
>  		compatible = "simple-bus";
>  		ranges;
>  		#address-cells = <1>;
>  		#size-cells = <1>;
>  
> +		securam: sram@e0000800 {
> +			compatible = "microchip,sama7d65-securam", "atmel,sama5d2-securam", "mmio-sram";
> +			reg = <0xe0000800 0x4000>;
> +			ranges = <0 0xe0000800 0x4000>;
> +			clocks = <&pmc PMC_TYPE_PERIPHERAL 17>;
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +			no-memory-wc;
> +		};
> +
> +		secumod: secumod@e0004000 {
> +			compatible = "microchip,sama7d65-secumod", "atmel,sama5d2-secumod", "syscon";

microchip,sama7d65-secumod is undocumented. I'll postpone this until a
documentation a patch will be posted.

> +			reg = <0xe0004000 0x4000>;
> +			gpio-controller;
> +			#gpio-cells = <2>;
> +		};
> +
>  		pioa: pinctrl@e0014000 {
>  			compatible = "microchip,sama7d65-pinctrl", "microchip,sama7g5-pinctrl";
>  			reg = <0xe0014000 0x800>;
> @@ -190,6 +215,16 @@ i2c10: i2c@600 {
>  			};
>  		};
>  
> +		uddrc: uddrc@e3800000 {
> +			compatible = "microchip,sama7d65-uddrc", "microchip,sama7g5-uddrc";
> +			reg = <0xe3800000 0x4000>;
> +		};
> +
> +		ddr3phy: ddr3phy@e3804000 {
> +			compatible = "microchip,sama7d65-ddr3phy", "microchip,sama7g5-ddr3phy";
> +			reg = <0xe3804000 0x1000>;
> +		};
> +
>  		gic: interrupt-controller@e8c11000 {
>  			compatible = "arm,cortex-a7-gic";
>  			reg = <0xe8c11000 0x1000>,


