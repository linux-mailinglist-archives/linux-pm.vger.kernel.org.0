Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D2875139068
	for <lists+linux-pm@lfdr.de>; Mon, 13 Jan 2020 12:51:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726277AbgAMLvO (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 13 Jan 2020 06:51:14 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:58142 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726127AbgAMLvO (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 13 Jan 2020 06:51:14 -0500
Received: from 79.184.255.90.ipv4.supernova.orange.pl (79.184.255.90) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.320)
 id e837cbaf30ffdffb; Mon, 13 Jan 2020 12:51:12 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Krzysztof Kozlowski <krzk@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org
Subject: Re: [PATCH] cpuidle: arm: Enable compile testing for some of drivers
Date:   Mon, 13 Jan 2020 12:51:12 +0100
Message-ID: <112783298.KOQPr5xTch@kreacher>
In-Reply-To: <20191229180912.17100-2-krzk@kernel.org>
References: <20191229180912.17100-1-krzk@kernel.org> <20191229180912.17100-2-krzk@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sunday, December 29, 2019 7:09:12 PM CET Krzysztof Kozlowski wrote:
> Some of cpuidle drivers for ARMv7 can be compile tested on this
> architecture because they do not depend on mach-specific bits.  Enable
> compile testing for big.LITTLE, Kirkwood, Zynq, AT91, Exynos and mvebu
> cpuidle drivers.
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>  drivers/cpuidle/Kconfig.arm | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/cpuidle/Kconfig.arm b/drivers/cpuidle/Kconfig.arm
> index a224d33dda7f..62272ecfa771 100644
> --- a/drivers/cpuidle/Kconfig.arm
> +++ b/drivers/cpuidle/Kconfig.arm
> @@ -25,7 +25,7 @@ config ARM_PSCI_CPUIDLE
>  
>  config ARM_BIG_LITTLE_CPUIDLE
>  	bool "Support for ARM big.LITTLE processors"
> -	depends on ARCH_VEXPRESS_TC2_PM || ARCH_EXYNOS
> +	depends on ARCH_VEXPRESS_TC2_PM || ARCH_EXYNOS || COMPILE_TEST
>  	depends on MCPM && !ARM64
>  	select ARM_CPU_SUSPEND
>  	select CPU_IDLE_MULTIPLE_DRIVERS
> @@ -51,13 +51,13 @@ config ARM_HIGHBANK_CPUIDLE
>  
>  config ARM_KIRKWOOD_CPUIDLE
>  	bool "CPU Idle Driver for Marvell Kirkwood SoCs"
> -	depends on MACH_KIRKWOOD && !ARM64
> +	depends on (MACH_KIRKWOOD || COMPILE_TEST) && !ARM64
>  	help
>  	  This adds the CPU Idle driver for Marvell Kirkwood SoCs.
>  
>  config ARM_ZYNQ_CPUIDLE
>  	bool "CPU Idle Driver for Xilinx Zynq processors"
> -	depends on ARCH_ZYNQ && !ARM64
> +	depends on (ARCH_ZYNQ || COMPILE_TEST) && !ARM64
>  	help
>  	  Select this to enable cpuidle on Xilinx Zynq processors.
>  
> @@ -70,19 +70,19 @@ config ARM_U8500_CPUIDLE
>  config ARM_AT91_CPUIDLE
>  	bool "Cpu Idle Driver for the AT91 processors"
>  	default y
> -	depends on ARCH_AT91 && !ARM64
> +	depends on (ARCH_AT91 || COMPILE_TEST) && !ARM64
>  	help
>  	  Select this to enable cpuidle for AT91 processors.
>  
>  config ARM_EXYNOS_CPUIDLE
>  	bool "Cpu Idle Driver for the Exynos processors"
> -	depends on ARCH_EXYNOS && !ARM64
> +	depends on (ARCH_EXYNOS || COMPILE_TEST) && !ARM64
>  	select ARCH_NEEDS_CPU_IDLE_COUPLED if SMP
>  	help
>  	  Select this to enable cpuidle for Exynos processors.
>  
>  config ARM_MVEBU_V7_CPUIDLE
>  	bool "CPU Idle Driver for mvebu v7 family processors"
> -	depends on ARCH_MVEBU && !ARM64
> +	depends on (ARCH_MVEBU || COMPILE_TEST) && !ARM64
>  	help
>  	  Select this to enable cpuidle on Armada 370, 38x and XP processors.
> 

Daniel, any concerns regarding this one?



