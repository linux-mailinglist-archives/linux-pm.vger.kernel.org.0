Return-Path: <linux-pm+bounces-26940-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58E46AB14BE
	for <lists+linux-pm@lfdr.de>; Fri,  9 May 2025 15:20:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F099A20ED5
	for <lists+linux-pm@lfdr.de>; Fri,  9 May 2025 13:18:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DEEF2918D0;
	Fri,  9 May 2025 13:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rosenzweig.io header.i=@rosenzweig.io header.b="fHb0Bf2F"
X-Original-To: linux-pm@vger.kernel.org
Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 820B92918C3;
	Fri,  9 May 2025 13:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746796407; cv=none; b=TvMWLV+/Wwijk//DU092Qy/oKWVJGYzU07uGP4t6GC+vqqtJI/9vxtSVFqeDWGTlXDxYhdSWH7xdb50GXQfsnkACucs2N5L2wzHhy/818uo3xRCz8+FyAV0TgkQdhjhmJavepqO47s/OngxAk9Tv4yLVpOhFzCkkw+VucNCFPNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746796407; c=relaxed/simple;
	bh=nHcaS03T71iRXYf/Lf72eeVSXvyIQhWOCmpm1gIiLNY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Lp4WLTfVCPXogZ8lbfZ9t2Njxt+nCHgxDBcWWom3c0z48lc4dIk0fxoVRt2YFQrkQrfCXxam87DWW5OeUgaSIC+jTAGVI0gfPY+hluueKQUz9PKiJDQfrxYAw3Pr2HZj6amJWqvZ7WHBmKTfO2EmuekP2NsBfw/TrNLGvTa1OsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rosenzweig.io; spf=pass smtp.mailfrom=rosenzweig.io; dkim=pass (2048-bit key) header.d=rosenzweig.io header.i=@rosenzweig.io header.b=fHb0Bf2F; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rosenzweig.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rosenzweig.io
Date: Fri, 9 May 2025 09:13:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rosenzweig.io;
	s=key1; t=1746796403;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eHz2N90cxTQPl/n3ayGPjZiGdp6MpqFE6UdMTbgIZ0k=;
	b=fHb0Bf2Fxn4XphXkw53yBQp5fKOoN8qXoC6co+TQnzQiXmREqHmMNMdXDJhiK9feEPkzCD
	xNWNbVEx3i8gLAOOhU7AUKiMCpTPr5Xto7wkjd/etBl7peOIMinzO1dixZ7S9VJQaQxG7a
	Qpi/uuYD73+Y+chNpJBTUMP32ykNHh8dd/cCqe8a5iOSeZxb+zvJMpFESvDXxX8wJHiCvQ
	ESOT/Bs/K8+OnNz+02TwSK8SeaQxJfa8B9YkLFbrs2gskzUHOWn7Qrt90SrHDOLMaSKvz3
	7vwXPIyawxCHxf7tco0+el4wfQjHSeNB5mDYOgB09LKMMIoi2wOuvrA25zlJwQ==
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
Subject: Re: [PATCH v4 8/9] arm64: dts: apple: t8112: Add SMC node
Message-ID: <aB3_Znc0dsDuByVJ@blossom>
References: <20250503-smc-6-15-v4-0-500b9b6546fc@svenpeter.dev>
 <20250503-smc-6-15-v4-8-500b9b6546fc@svenpeter.dev>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250503-smc-6-15-v4-8-500b9b6546fc@svenpeter.dev>
X-Migadu-Flow: FLOW_OUT

Reviewed-by: Alyssa Rosenzweig <alyssa@rosenzweig.io>

Le Sat , May 03, 2025 at 10:06:55AM +0000, Sven Peter via B4 Relay a écrit :
> From: Hector Martin <marcan@marcan.st>
> 
> Signed-off-by: Hector Martin <marcan@marcan.st>
> Signed-off-by: Sven Peter <sven@svenpeter.dev>
> ---
>  arch/arm64/boot/dts/apple/t8112.dtsi | 35 +++++++++++++++++++++++++++++++++++
>  1 file changed, 35 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/apple/t8112.dtsi b/arch/arm64/boot/dts/apple/t8112.dtsi
> index e95711d8337f6cea898e88a3d564caf2c4f94404..861cf2f684a067d73f79d8f01447bc375136793d 100644
> --- a/arch/arm64/boot/dts/apple/t8112.dtsi
> +++ b/arch/arm64/boot/dts/apple/t8112.dtsi
> @@ -839,6 +839,41 @@ rtc_offset: rtc-offset@f900 {
>  			};
>  		};
>  
> +		smc: smc@23e400000 {
> +			compatible = "apple,t8112-smc", "apple,smc";
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
> +			compatible = "apple,t8112-asc-mailbox", "apple,asc-mailbox-v4";
> +			reg = <0x2 0x3e408000 0x0 0x4000>;
> +			interrupt-parent = <&aic>;
> +			interrupts = <AIC_IRQ 499 IRQ_TYPE_LEVEL_HIGH>,
> +				<AIC_IRQ 500 IRQ_TYPE_LEVEL_HIGH>,
> +				<AIC_IRQ 501 IRQ_TYPE_LEVEL_HIGH>,
> +				<AIC_IRQ 502 IRQ_TYPE_LEVEL_HIGH>;
> +			interrupt-names = "send-empty", "send-not-empty",
> +				"recv-empty", "recv-not-empty";
> +			#mbox-cells = <0>;
> +		};
> +
>  		pinctrl_smc: pinctrl@23e820000 {
>  			compatible = "apple,t8112-pinctrl", "apple,pinctrl";
>  			reg = <0x2 0x3e820000 0x0 0x4000>;
> 
> -- 
> 2.34.1
> 
> 

