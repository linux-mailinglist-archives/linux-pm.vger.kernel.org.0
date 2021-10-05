Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9AD184231E8
	for <lists+linux-pm@lfdr.de>; Tue,  5 Oct 2021 22:26:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235949AbhJEU21 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 5 Oct 2021 16:28:27 -0400
Received: from sibelius.xs4all.nl ([83.163.83.176]:51040 "EHLO
        sibelius.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231181AbhJEU20 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 5 Oct 2021 16:28:26 -0400
Received: from localhost (bloch.sibelius.xs4all.nl [local])
        by bloch.sibelius.xs4all.nl (OpenSMTPD) with ESMTPA id 2090d571;
        Tue, 5 Oct 2021 22:26:33 +0200 (CEST)
Date:   Tue, 5 Oct 2021 22:26:33 +0200 (CEST)
From:   Mark Kettenis <mark.kettenis@xs4all.nl>
To:     Hector Martin <marcan@marcan.st>
Cc:     linux-arm-kernel@lists.infradead.org, marcan@marcan.st,
        maz@kernel.org, robh+dt@kernel.org, arnd@kernel.org,
        linus.walleij@linaro.org, alyssa@rosenzweig.io, krzk@kernel.org,
        gregkh@linuxfoundation.org, p.zabel@pengutronix.de,
        rafael@kernel.org, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org, linux-serial@vger.kernel.org
In-Reply-To: <20211005155923.173399-8-marcan@marcan.st> (message from Hector
        Martin on Wed, 6 Oct 2021 00:59:23 +0900)
Subject: Re: [PATCH 7/7] arm64: dts: apple: t8103: Add UART2
References: <20211005155923.173399-1-marcan@marcan.st> <20211005155923.173399-8-marcan@marcan.st>
Message-ID: <d3ca3c3c6aa1f54e@bloch.sibelius.xs4all.nl>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

> From: Hector Martin <marcan@marcan.st>
> Date: Wed,  6 Oct 2021 00:59:23 +0900
> 
> This UART is connected to the debug port of the WLAN module. It is
> mostly useless, but makes for a good test case for runtime-pm without
> having to unbind the console from the main system UART.
> 
> Signed-off-by: Hector Martin <marcan@marcan.st>
> ---
>  arch/arm64/boot/dts/apple/t8103-j274.dts |  5 +++++
>  arch/arm64/boot/dts/apple/t8103.dtsi     | 12 ++++++++++++
>  2 files changed, 17 insertions(+)

Doesn't break U-Boot or OpenBSD.

Reviewed-by: Mark Kettenis <kettenis@openbsd.org>


> diff --git a/arch/arm64/boot/dts/apple/t8103-j274.dts b/arch/arm64/boot/dts/apple/t8103-j274.dts
> index e0f6775b9878..16c5eb7f53b1 100644
> --- a/arch/arm64/boot/dts/apple/t8103-j274.dts
> +++ b/arch/arm64/boot/dts/apple/t8103-j274.dts
> @@ -17,6 +17,7 @@ / {
>  
>  	aliases {
>  		serial0 = &serial0;
> +		serial2 = &serial2;
>  	};
>  
>  	chosen {
> @@ -43,3 +44,7 @@ memory@800000000 {
>  &serial0 {
>  	status = "okay";
>  };
> +
> +&serial2 {
> +	status = "okay";
> +};
> diff --git a/arch/arm64/boot/dts/apple/t8103.dtsi b/arch/arm64/boot/dts/apple/t8103.dtsi
> index 63056ddc7ef7..844ed7bd0451 100644
> --- a/arch/arm64/boot/dts/apple/t8103.dtsi
> +++ b/arch/arm64/boot/dts/apple/t8103.dtsi
> @@ -126,6 +126,18 @@ serial0: serial@235200000 {
>  			status = "disabled";
>  		};
>  
> +		serial2: serial@235208000 {
> +			compatible = "apple,s5l-uart";
> +			reg = <0x2 0x35208000 0x0 0x1000>;
> +			reg-io-width = <4>;
> +			interrupt-parent = <&aic>;
> +			interrupts = <AIC_IRQ 607 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&clkref>, <&clkref>;
> +			clock-names = "uart", "clk_uart_baud0";
> +			power-domains = <&ps_uart2>;
> +			status = "disabled";
> +		};
> +
>  		aic: interrupt-controller@23b100000 {
>  			compatible = "apple,t8103-aic", "apple,aic";
>  			#interrupt-cells = <3>;
> -- 
> 2.33.0
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
