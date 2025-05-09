Return-Path: <linux-pm+bounces-26942-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DF69FAB14D7
	for <lists+linux-pm@lfdr.de>; Fri,  9 May 2025 15:21:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 419B21797C5
	for <lists+linux-pm@lfdr.de>; Fri,  9 May 2025 13:19:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A945293457;
	Fri,  9 May 2025 13:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rosenzweig.io header.i=@rosenzweig.io header.b="KUr0/5jt"
X-Original-To: linux-pm@vger.kernel.org
Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3CA7292927
	for <linux-pm@vger.kernel.org>; Fri,  9 May 2025 13:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746796467; cv=none; b=KC0amiFrwX7ypxBxI5s8UxU3p/6BQchdgbCL1Y3TYv09y6OO4rC0/jc0NQ4e3jcS+Vs1DAoNWDFD0eoYFflFWhANXUzXagno8ZwDFEMJos2gQtr8vI554eLJx7933BrGuhgxtr/hikmrcSQ5UahyKuhe8lgBu/+sEqkcRaV0egY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746796467; c=relaxed/simple;
	bh=9RnZ968TcDZnmqkj1ovGuHA82/+SYZzxreZCpC+Nq5M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sx+BD3SOrxCPSf862X36aiLsWJwodEZrHwa6YlpKoHbF/HWT5RaFl3wQNWEEWJluFimTqmYiwiLooeTRH11Qai10pWP7huZZbntEuQBCKxv/uUOfO2uM8iUxxG9BuOOC+G7SI7+jNHcSL7+3aTOBxEDFDMW1BI+hCslAEcO87jM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rosenzweig.io; spf=pass smtp.mailfrom=rosenzweig.io; dkim=pass (2048-bit key) header.d=rosenzweig.io header.i=@rosenzweig.io header.b=KUr0/5jt; arc=none smtp.client-ip=95.215.58.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rosenzweig.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rosenzweig.io
Date: Fri, 9 May 2025 09:14:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rosenzweig.io;
	s=key1; t=1746796462;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GkV6XoLaeT2EUCE/NRO86y22RkBlw2IGYotCv1aLQSo=;
	b=KUr0/5jtENQERP52yAYyt9IK2gGgnJxdgoNRDysr1hpd6oIGJJhYkytCXszxuyRDLU9w/t
	fAoT37A+wgjIrLevT7LK0GEoaLSfqnXpAqhsgv09PqVZDeHv62PMWj5DpP5UzawuYvSF+k
	k3YwLakl1UFfkfRE06C178u6bNqoOqO30f0bMfjuFsMge8aMMPPRTrRXa6V2YHVmDni+9d
	kW2h7BSKu5Q6bn2kqNMWFVeMcTOdMjJlOjcWLTMPW6tuiim8B7MaNGSdCD/YKecmfKfiIo
	O61gWmXP7cI87kYTgSHKKB/KLPP17doJLxC90VzzWihh3dylx2QDVR4YsitG+w==
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Alyssa Rosenzweig <alyssa@rosenzweig.io>
To: sven@svenpeter.dev
Cc: Janne Grunau <j@jannau.net>, Neal Gompa <neal@gompa.dev>,
	Hector Martin <marcan@marcan.st>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Sebastian Reichel <sre@kernel.org>, Lee Jones <lee@kernel.org>,
	Marc Zyngier <maz@kernel.org>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v4 7/9] arm64: dts: apple: t8103: Add SMC node
Message-ID: <aB3_nYoHofJ7wD8L@blossom>
References: <20250503-smc-6-15-v4-0-500b9b6546fc@svenpeter.dev>
 <20250503-smc-6-15-v4-7-500b9b6546fc@svenpeter.dev>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250503-smc-6-15-v4-7-500b9b6546fc@svenpeter.dev>
X-Migadu-Flow: FLOW_OUT

Reviewed-by: Alyssa Rosenzweig <alyssa@rosenzweig.io>

Le Sat , May 03, 2025 at 10:06:54AM +0000, Sven Peter via B4 Relay a écrit :
> From: Hector Martin <marcan@marcan.st>
> 
> Signed-off-by: Hector Martin <marcan@marcan.st>
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> Reviewed-by: Sven Peter <sven@svenpeter.dev>
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> Signed-off-by: Sven Peter <sven@svenpeter.dev>
> ---
>  arch/arm64/boot/dts/apple/t8103.dtsi | 35 +++++++++++++++++++++++++++++++++++
>  1 file changed, 35 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/apple/t8103.dtsi b/arch/arm64/boot/dts/apple/t8103.dtsi
> index 20faf0c0d80927b2e18dd966a61b5507b322c72f..58270e7d79b07ee98340f140972a6f0d14c86dcb 100644
> --- a/arch/arm64/boot/dts/apple/t8103.dtsi
> +++ b/arch/arm64/boot/dts/apple/t8103.dtsi
> @@ -836,6 +836,41 @@ wdt: watchdog@23d2b0000 {
>  			interrupts = <AIC_IRQ 338 IRQ_TYPE_LEVEL_HIGH>;
>  		};
>  
> +		smc: smc@23e400000 {
> +			compatible = "apple,t8103-smc", "apple,smc";
> +			reg = <0x2 0x3e400000 0x0 0x4000>,
> +				<0x2 0x3fe00000 0x0 0x100000>;
> +			reg-names = "smc", "sram";
> +			mboxes = <&smc_mbox>;
> +
> +			smc_gpio: gpio {
> +				compatible = "apple,smc-gpio";
> +				gpio-controller;
> +				#gpio-cells = <2>;
> +			};
> +
> +			smc_reboot: reboot {
> +				compatible = "apple,smc-reboot";
> +				nvmem-cells = <&shutdown_flag>, <&boot_stage>,
> +					<&boot_error_count>, <&panic_count>, <&pm_setting>;
> +				nvmem-cell-names = "shutdown_flag", "boot_stage",
> +					"boot_error_count", "panic_count", "pm_setting";
> +			};
> +		};
> +
> +		smc_mbox: mbox@23e408000 {
> +			compatible = "apple,t8103-asc-mailbox", "apple,asc-mailbox-v4";
> +			reg = <0x2 0x3e408000 0x0 0x4000>;
> +			interrupt-parent = <&aic>;
> +			interrupts = <AIC_IRQ 400 IRQ_TYPE_LEVEL_HIGH>,
> +				<AIC_IRQ 401 IRQ_TYPE_LEVEL_HIGH>,
> +				<AIC_IRQ 402 IRQ_TYPE_LEVEL_HIGH>,
> +				<AIC_IRQ 403 IRQ_TYPE_LEVEL_HIGH>;
> +			interrupt-names = "send-empty", "send-not-empty",
> +				"recv-empty", "recv-not-empty";
> +			#mbox-cells = <0>;
> +		};
> +
>  		pinctrl_smc: pinctrl@23e820000 {
>  			compatible = "apple,t8103-pinctrl", "apple,pinctrl";
>  			reg = <0x2 0x3e820000 0x0 0x4000>;
> 
> -- 
> 2.34.1
> 
> 

