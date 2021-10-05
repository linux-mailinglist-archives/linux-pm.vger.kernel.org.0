Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 668974231A4
	for <lists+linux-pm@lfdr.de>; Tue,  5 Oct 2021 22:22:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232574AbhJEUY0 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 5 Oct 2021 16:24:26 -0400
Received: from sibelius.xs4all.nl ([83.163.83.176]:59519 "EHLO
        sibelius.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230019AbhJEUY0 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 5 Oct 2021 16:24:26 -0400
Received: from localhost (bloch.sibelius.xs4all.nl [local])
        by bloch.sibelius.xs4all.nl (OpenSMTPD) with ESMTPA id f24e3937;
        Tue, 5 Oct 2021 22:22:32 +0200 (CEST)
Date:   Tue, 5 Oct 2021 22:22:32 +0200 (CEST)
From:   Mark Kettenis <mark.kettenis@xs4all.nl>
To:     Hector Martin <marcan@marcan.st>
Cc:     linux-arm-kernel@lists.infradead.org, marcan@marcan.st,
        maz@kernel.org, robh+dt@kernel.org, arnd@kernel.org,
        linus.walleij@linaro.org, alyssa@rosenzweig.io, krzk@kernel.org,
        gregkh@linuxfoundation.org, p.zabel@pengutronix.de,
        rafael@kernel.org, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org, linux-serial@vger.kernel.org
In-Reply-To: <20211005155923.173399-5-marcan@marcan.st> (message from Hector
        Martin on Wed, 6 Oct 2021 00:59:20 +0900)
Subject: Re: [PATCH 4/7] arm64: dts: apple: t8103: Rename clk24 to clkref
References: <20211005155923.173399-1-marcan@marcan.st> <20211005155923.173399-5-marcan@marcan.st>
Message-ID: <d3ca3c03afb34abe@bloch.sibelius.xs4all.nl>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

> From: Hector Martin <marcan@marcan.st>
> Date: Wed,  6 Oct 2021 00:59:20 +0900
> Content-Type: text/plain; charset="us-ascii"
> 
> We now know that this frequency comes from the external reference
> oscillator and is used for various SoC blocks, and isn't just a random
> 24MHz clock, so let's call it something more appropriate.
> 
> Signed-off-by: Hector Martin <marcan@marcan.st>
> ---
>  arch/arm64/boot/dts/apple/t8103.dtsi | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

Reviewed-by: Mark Kettenis <kettenis@openbsd.org>

> diff --git a/arch/arm64/boot/dts/apple/t8103.dtsi b/arch/arm64/boot/dts/apple/t8103.dtsi
> index a1e22a2ea2e5..9f60f9e48ea0 100644
> --- a/arch/arm64/boot/dts/apple/t8103.dtsi
> +++ b/arch/arm64/boot/dts/apple/t8103.dtsi
> @@ -95,11 +95,11 @@ timer {
>  			     <AIC_FIQ AIC_TMR_HV_VIRT IRQ_TYPE_LEVEL_HIGH>;
>  	};
>  
> -	clk24: clock-24m {
> +	clkref: clock-ref {
>  		compatible = "fixed-clock";
>  		#clock-cells = <0>;
>  		clock-frequency = <24000000>;
> -		clock-output-names = "clk24";
> +		clock-output-names = "clkref";
>  	};
>  
>  	soc {
> @@ -120,7 +120,7 @@ serial0: serial@235200000 {
>  			 * TODO: figure out the clocking properly, there may
>  			 * be a third selectable clock.
>  			 */
> -			clocks = <&clk24>, <&clk24>;
> +			clocks = <&clkref>, <&clkref>;
>  			clock-names = "uart", "clk_uart_baud0";
>  			status = "disabled";
>  		};
> -- 
> 2.33.0
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
