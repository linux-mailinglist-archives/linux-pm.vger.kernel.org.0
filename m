Return-Path: <linux-pm+bounces-23379-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A8845A4E2B8
	for <lists+linux-pm@lfdr.de>; Tue,  4 Mar 2025 16:17:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EBDCD19C1283
	for <lists+linux-pm@lfdr.de>; Tue,  4 Mar 2025 15:08:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E677827D79A;
	Tue,  4 Mar 2025 15:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="Ev0Dv9xg"
X-Original-To: linux-pm@vger.kernel.org
Received: from beeline1.cc.itu.edu.tr (beeline1.cc.itu.edu.tr [160.75.25.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1B9827D77E
	for <linux-pm@vger.kernel.org>; Tue,  4 Mar 2025 15:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=160.75.25.115
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741100557; cv=pass; b=tTfzUiEtbDa3YglwVsMXUgn6ADOHe8I+Wh8quWErtmWWTBrOkZDZZ3itVWbWLp4gN3LeT9UST5L7XwP0HKPatWLEO9VDUy2l4wPnYzDRpKsn+DnUU3JpmH0Zelzp9pwd8EgHDUET6vE2nCYsbf9UsPIjZ3qmPoFDgVIKzv67/tI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741100557; c=relaxed/simple;
	bh=Str9/Z4T7boxdmYNKfUCQAYMERdj9MmqoKnoOftbpzQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Qgu4mgaLpLRgy0sY5hqw78Jdr56uT9aAy0mQAYkF67a51IuKNd6yv/9JbU/mNfZU8qZKGuM6jkwqtPrNF1F3np6CIftgVQHkMkvGs8Hd3UrylxM3gn6q0+K9HYYJ4Q0v/ZluJUSo+86gImhAA6PO98THKCgX9h8ryGYsUeqqWAI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=none smtp.mailfrom=cc.itu.edu.tr; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=Ev0Dv9xg; arc=none smtp.client-ip=209.85.208.42; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; arc=pass smtp.client-ip=160.75.25.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=cc.itu.edu.tr
Received: from lesvatest1.cc.itu.edu.tr (lesvatest1.cc.itu.edu.tr [10.146.128.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by beeline1.cc.itu.edu.tr (Postfix) with ESMTPS id 371C740D570D
	for <linux-pm@vger.kernel.org>; Tue,  4 Mar 2025 18:02:34 +0300 (+03)
X-Envelope-From: <root@cc.itu.edu.tr>
Authentication-Results: lesvatest1.cc.itu.edu.tr;
	dkim=pass (2048-bit key, unprotected) header.d=tuxon.dev header.i=@tuxon.dev header.a=rsa-sha256 header.s=google header.b=Ev0Dv9xg
Received: from lesva1.cc.itu.edu.tr (unknown [160.75.70.79])
	by lesvatest1.cc.itu.edu.tr (Postfix) with ESMTP id 4Z6f522YRLzFy84
	for <linux-pm@vger.kernel.org>; Tue,  4 Mar 2025 18:00:54 +0300 (+03)
Received: by le1 (Postfix, from userid 0)
	id D4F684272A; Tue,  4 Mar 2025 18:00:48 +0300 (+03)
Authentication-Results: lesva1.cc.itu.edu.tr;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=Ev0Dv9xg
X-Envelope-From: <linux-kernel+bounces-541157-bozkiru=itu.edu.tr@vger.kernel.org>
Authentication-Results: lesva2.cc.itu.edu.tr;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=Ev0Dv9xg
Received: from fgw1.itu.edu.tr (fgw1.itu.edu.tr [160.75.25.103])
	by le2 (Postfix) with ESMTP id 487EA42322
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 11:29:36 +0300 (+03)
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by fgw1.itu.edu.tr (Postfix) with SMTP id 25DC43064C16
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 11:29:36 +0300 (+03)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E031F1892C33
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 08:29:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB7E71EFF8D;
	Mon,  3 Mar 2025 08:28:48 +0000 (UTC)
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E072F1EF0AB
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 08:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740990525; cv=none; b=h2yucTcDoMzjoUGXChJe20MjkpB6+quwHqOb7sRzqEslg6tYQOPB0lLpDkutmRMuP5s2r+fOXmqGRE1Lrv1/iwNdUZMFl3zW0wMNtYksjxYuwKY6X3k3GKsXZKMw9AS4YY9OJ+caQGBGooLRM14n4Jo+oESRVgKOGxI2iXCvzEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740990525; c=relaxed/simple;
	bh=Str9/Z4T7boxdmYNKfUCQAYMERdj9MmqoKnoOftbpzQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CkCbEnaJRF2pcz7bf/lu2Rb0Aah7wsjSHQt/MkjiydOAOscv3av/AWqz+gnzAzQDEzx9hEEeEJdGXTfsVNFuo9l7CmwyPXOr5vYPtzVF7Nlk15AoP6zy48yz/umRGg30YMX02mV6NIZmShvy3Tz8qlpqa8p6d/LWMMwBo9g1km4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=Ev0Dv9xg; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5e53b3fa7daso1571059a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 03 Mar 2025 00:28:42 -0800 (PST)
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
        b=M7Lm0+oFRfMa2JBq6soRCbiZ/veWfNjVZ2U8SEDsvUtl1TbmATFVSsvnqye50BHY96
         Lm/KvwnCbDZ2n13e8B5DWBs0nkDtzorXgDYUjH82mV3G3zLhoDbM6KqODGLz4R1VEhUs
         dwWKkurtayuFzwMbLye1a9UKd8+pHQeDNXRsqNeEJx6mBJo2VEYv9t4skgOTmEIb2nj8
         9W2SX4WbepEGP41CUYSIsiLJWFjyTBXq7O7FoMCmMLW3/jly7wsz0YcK5SbRqX9YHC8K
         wvSEfMHq//66oxyqa/GLHjWu2PAcc99y/spVJ9Im3eqIXFC0v/AKr4/wECl/CZte8EAf
         mUSQ==
X-Forwarded-Encrypted: i=1; AJvYcCX4JVsq6yyBMX92PwAZBI3Q0yqNHUz13FnhV7kAVn8MK0ZXG0qgPsyysvT3BeREbLjyjy7zXAyHMmdIewk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzhH18cQUsKmwIfohxzp66LTvkio7TAfD2XHbNuxH4uHHFzrpjI
	wNQoAWWXmvH+ehgTCP+bOFnpZiPAt8hIk9n0gvqeSkEVmUSQv+VhAfTbEYAJEYQ=
X-Gm-Gg: ASbGncuKSRrkaPRDvPe7uyK7dzxIrXYexl/y3DPQOyE2nr9DKZobV+wlqzAA8ztxYef
	RmGwEyngsSFoq4mJS301C8JwvlLMWnm+JLPfJ3y9iyq3f6YCBRPB8NMnPKDPyS+SMcQeVbtKn98
	dwv4gz09Js9rTrIwRbVLOVVePqJ+Rbh7J9wV9/eWrIdcOSAkDis34R+Qz1trBom5MqeXHkWpj2z
	VxuChK/bIxOmxURmmxdEhv52rUmeXb13IjAkdTl9ZT+Nm5qPCLVChlBSJYbd3q+l5EbOQAwDyc3
	x9QZokVs83/OJLeBiXOm5Q/YN4IStXKUKbLr6QDsoafR1EBCnSdDhw==
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
X-ITU-Libra-ESVA-Information: Please contact Istanbul Teknik Universitesi for more information
X-ITU-Libra-ESVA-ID: 4Z6f522YRLzFy84
X-ITU-Libra-ESVA: No virus found
X-ITU-Libra-ESVA-From: root@cc.itu.edu.tr
X-ITU-Libra-ESVA-Watermark: 1741705260.55239@+sI8cX5fGFF/YrjkaitRtg
X-ITU-MailScanner-SpamCheck: not spam

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



