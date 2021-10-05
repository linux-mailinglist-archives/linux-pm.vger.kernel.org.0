Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A2C44231D7
	for <lists+linux-pm@lfdr.de>; Tue,  5 Oct 2021 22:25:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235949AbhJEU1S (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 5 Oct 2021 16:27:18 -0400
Received: from sibelius.xs4all.nl ([83.163.83.176]:58948 "EHLO
        sibelius.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235545AbhJEU1S (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 5 Oct 2021 16:27:18 -0400
Received: from localhost (bloch.sibelius.xs4all.nl [local])
        by bloch.sibelius.xs4all.nl (OpenSMTPD) with ESMTPA id 37e863b1;
        Tue, 5 Oct 2021 22:25:24 +0200 (CEST)
Date:   Tue, 5 Oct 2021 22:25:24 +0200 (CEST)
From:   Mark Kettenis <mark.kettenis@xs4all.nl>
To:     Hector Martin <marcan@marcan.st>
Cc:     linux-arm-kernel@lists.infradead.org, marcan@marcan.st,
        maz@kernel.org, robh+dt@kernel.org, arnd@kernel.org,
        linus.walleij@linaro.org, alyssa@rosenzweig.io, krzk@kernel.org,
        gregkh@linuxfoundation.org, p.zabel@pengutronix.de,
        rafael@kernel.org, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org, linux-serial@vger.kernel.org
In-Reply-To: <20211005155923.173399-6-marcan@marcan.st> (message from Hector
        Martin on Wed, 6 Oct 2021 00:59:21 +0900)
Subject: Re: [PATCH 5/7] arm64: dts: apple: t8103: Add the UART PMGR tree
References: <20211005155923.173399-1-marcan@marcan.st> <20211005155923.173399-6-marcan@marcan.st>
Message-ID: <d3ca3c225d101c67@bloch.sibelius.xs4all.nl>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

> From: Hector Martin <marcan@marcan.st>
> Date: Wed,  6 Oct 2021 00:59:21 +0900
> Content-Type: text/plain; charset="us-ascii"
> 
> Note that the UART driver does not currently support runtime-pm, so this
> effectively always keeps the UART0 device on. However, this does clockgate
> all the other UARTs, as those are not currently instantiated.
> 
> Signed-off-by: Hector Martin <marcan@marcan.st>
> ---
>  arch/arm64/boot/dts/apple/t8103.dtsi | 116 +++++++++++++++++++++++++++
>  1 file changed, 116 insertions(+)

Reviewed-by: Mark Kettenis <kettenis@openbsd.org>

> diff --git a/arch/arm64/boot/dts/apple/t8103.dtsi b/arch/arm64/boot/dts/apple/t8103.dtsi
> index 9f60f9e48ea0..63056ddc7ef7 100644
> --- a/arch/arm64/boot/dts/apple/t8103.dtsi
> +++ b/arch/arm64/boot/dts/apple/t8103.dtsi
> @@ -122,6 +122,7 @@ serial0: serial@235200000 {
>  			 */
>  			clocks = <&clkref>, <&clkref>;
>  			clock-names = "uart", "clk_uart_baud0";
> +			power-domains = <&ps_uart0>;
>  			status = "disabled";
>  		};
>  
> @@ -131,5 +132,120 @@ aic: interrupt-controller@23b100000 {
>  			interrupt-controller;
>  			reg = <0x2 0x3b100000 0x0 0x8000>;
>  		};
> +
> +		pmgr: power-management@23b700000 {
> +			compatible = "apple,t8103-pmgr", "apple,pmgr", "syscon", "simple-mfd";
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +
> +			reg = <0x2 0x3b700000 0x0 0x14000>;
> +
> +			ps_sio_busif: power-controller@1c0 {
> +				compatible = "apple,t8103-pmgr-pwrstate", "apple,pmgr-pwrstate";
> +				reg = <0x1c0>;
> +				#power-domain-cells = <0>;
> +				#reset-cells = <0>;
> +				apple,domain-name = "sio_busif";
> +			};
> +
> +			ps_sio: power-controller@1c8 {
> +				compatible = "apple,t8103-pmgr-pwrstate", "apple,pmgr-pwrstate";
> +				reg = <0x1c8>;
> +				#power-domain-cells = <0>;
> +				#reset-cells = <0>;
> +				apple,domain-name = "sio";
> +				power-domains = <&ps_sio_busif>;
> +			};
> +
> +			ps_uart_p: power-controller@220 {
> +				compatible = "apple,t8103-pmgr-pwrstate", "apple,pmgr-pwrstate";
> +				reg = <0x220>;
> +				#power-domain-cells = <0>;
> +				#reset-cells = <0>;
> +				apple,domain-name = "uart_p";
> +				power-domains = <&ps_sio>;
> +			};
> +
> +			ps_uart0: power-controller@270 {
> +				compatible = "apple,t8103-pmgr-pwrstate", "apple,pmgr-pwrstate";
> +				reg = <0x270>;
> +				#power-domain-cells = <0>;
> +				#reset-cells = <0>;
> +				apple,domain-name = "uart0";
> +				power-domains = <&ps_uart_p>;
> +			};
> +
> +			ps_uart1: power-controller@278 {
> +				compatible = "apple,t8103-pmgr-pwrstate", "apple,pmgr-pwrstate";
> +				reg = <0x278>;
> +				#power-domain-cells = <0>;
> +				#reset-cells = <0>;
> +				apple,domain-name = "uart1";
> +				power-domains = <&ps_uart_p>;
> +			};
> +
> +			ps_uart2: power-controller@280 {
> +				compatible = "apple,t8103-pmgr-pwrstate", "apple,pmgr-pwrstate";
> +				reg = <0x280>;
> +				#power-domain-cells = <0>;
> +				#reset-cells = <0>;
> +				apple,domain-name = "uart2";
> +				power-domains = <&ps_uart_p>;
> +			};
> +
> +			ps_uart3: power-controller@288 {
> +				compatible = "apple,t8103-pmgr-pwrstate", "apple,pmgr-pwrstate";
> +				reg = <0x288>;
> +				#power-domain-cells = <0>;
> +				#reset-cells = <0>;
> +				apple,domain-name = "uart3";
> +				power-domains = <&ps_uart_p>;
> +			};
> +
> +			ps_uart4: power-controller@290 {
> +				compatible = "apple,t8103-pmgr-pwrstate", "apple,pmgr-pwrstate";
> +				reg = <0x290>;
> +				#power-domain-cells = <0>;
> +				#reset-cells = <0>;
> +				apple,domain-name = "uart4";
> +				power-domains = <&ps_uart_p>;
> +			};
> +
> +			ps_uart5: power-controller@298 {
> +				compatible = "apple,t8103-pmgr-pwrstate", "apple,pmgr-pwrstate";
> +				reg = <0x298>;
> +				#power-domain-cells = <0>;
> +				#reset-cells = <0>;
> +				apple,domain-name = "uart5";
> +				power-domains = <&ps_uart_p>;
> +			};
> +
> +			ps_uart6: power-controller@2a0 {
> +				compatible = "apple,t8103-pmgr-pwrstate", "apple,pmgr-pwrstate";
> +				reg = <0x2a0>;
> +				#power-domain-cells = <0>;
> +				#reset-cells = <0>;
> +				apple,domain-name = "uart6";
> +				power-domains = <&ps_uart_p>;
> +			};
> +
> +			ps_uart7: power-controller@2a8 {
> +				compatible = "apple,t8103-pmgr-pwrstate", "apple,pmgr-pwrstate";
> +				reg = <0x2a8>;
> +				#power-domain-cells = <0>;
> +				#reset-cells = <0>;
> +				apple,domain-name = "uart7";
> +				power-domains = <&ps_uart_p>;
> +			};
> +
> +			ps_uart8: power-controller@2b0 {
> +				compatible = "apple,t8103-pmgr-pwrstate", "apple,pmgr-pwrstate";
> +				reg = <0x2b0>;
> +				#power-domain-cells = <0>;
> +				#reset-cells = <0>;
> +				apple,domain-name = "uart8";
> +				power-domains = <&ps_uart_p>;
> +			};
> +		};
>  	};
>  };
> -- 
> 2.33.0
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
