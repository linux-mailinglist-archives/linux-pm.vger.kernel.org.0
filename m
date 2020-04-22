Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D80321B40AD
	for <lists+linux-pm@lfdr.de>; Wed, 22 Apr 2020 12:47:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728348AbgDVKrO (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 22 Apr 2020 06:47:14 -0400
Received: from foss.arm.com ([217.140.110.172]:45988 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729035AbgDVKP7 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 22 Apr 2020 06:15:59 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D734C31B;
        Wed, 22 Apr 2020 03:15:56 -0700 (PDT)
Received: from e110455-lin.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 990B93F68F;
        Wed, 22 Apr 2020 03:15:56 -0700 (PDT)
Received: by e110455-lin.cambridge.arm.com (Postfix, from userid 1000)
        id 46D24682F3E; Wed, 22 Apr 2020 11:15:55 +0100 (BST)
Date:   Wed, 22 Apr 2020 11:15:55 +0100
From:   Liviu Dudau <liviu.dudau@arm.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Lee Jones <lee.jones@linaro.org>,
        Sebastian Reichel <sre@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>, Will Deacon <will@kernel.org>,
        Kevin Brodsky <Kevin.Brodsky@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH 01/17] ARM: vexpress: Move vexpress_flags_set() into arch
 code
Message-ID: <20200422101555.GP364558@e110455-lin.cambridge.arm.com>
References: <20200419170810.5738-1-robh@kernel.org>
 <20200419170810.5738-2-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200419170810.5738-2-robh@kernel.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sun, Apr 19, 2020 at 12:07:54PM -0500, Rob Herring wrote:
> vexpress_flags_set() is only used by the platform SMP related code and
> has nothing to do with the vexpress-sysreg MFD driver other than both
> access the same h/w block. It's also only needed for 32-bit systems and
> must be built-in for them. Let's move vexpress_flags_set() closer to
> where it is being used. This will allow for vexpress-sysreg to be built
> as a module.
> 
> Cc: Liviu Dudau <liviu.dudau@arm.com>

Acked-by: Liviu Dudau <liviu.dudau@arm.com>

Unfortunately I did not had the forethought to leave my Versatile Express board
plugged in before our office lockdown, so I will not have a chance to test the
series.

Best regards,
Liviu

> Cc: Sudeep Holla <sudeep.holla@arm.com>
> Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Lee Jones <lee.jones@linaro.org>
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  arch/arm/mach-vexpress/Kconfig |  1 -
>  arch/arm/mach-vexpress/core.h  |  1 +
>  arch/arm/mach-vexpress/dcscb.c |  1 +
>  arch/arm/mach-vexpress/v2m.c   | 23 +++++++++++++++++++++++
>  drivers/mfd/vexpress-sysreg.c  | 19 -------------------
>  include/linux/vexpress.h       |  4 ----
>  6 files changed, 25 insertions(+), 24 deletions(-)
> 
> diff --git a/arch/arm/mach-vexpress/Kconfig b/arch/arm/mach-vexpress/Kconfig
> index 726a68085c3b..18951cd20d9d 100644
> --- a/arch/arm/mach-vexpress/Kconfig
> +++ b/arch/arm/mach-vexpress/Kconfig
> @@ -22,7 +22,6 @@ menuconfig ARCH_VEXPRESS
>  	select REGULATOR_FIXED_VOLTAGE if REGULATOR
>  	select VEXPRESS_CONFIG
>  	select VEXPRESS_SYSCFG
> -	select MFD_VEXPRESS_SYSREG
>  	help
>  	  This option enables support for systems using Cortex processor based
>  	  ARM core and logic (FPGA) tiles on the Versatile Express motherboard,
> diff --git a/arch/arm/mach-vexpress/core.h b/arch/arm/mach-vexpress/core.h
> index f4a7519084f1..bda78675c55d 100644
> --- a/arch/arm/mach-vexpress/core.h
> +++ b/arch/arm/mach-vexpress/core.h
> @@ -1,3 +1,4 @@
>  bool vexpress_smp_init_ops(void);
> +void vexpress_flags_set(u32 data);
>  
>  extern const struct smp_operations vexpress_smp_dt_ops;
> diff --git a/arch/arm/mach-vexpress/dcscb.c b/arch/arm/mach-vexpress/dcscb.c
> index 46a903c88c6a..a0554d7d04f7 100644
> --- a/arch/arm/mach-vexpress/dcscb.c
> +++ b/arch/arm/mach-vexpress/dcscb.c
> @@ -20,6 +20,7 @@
>  #include <asm/cputype.h>
>  #include <asm/cp15.h>
>  
> +#include "core.h"
>  
>  #define RST_HOLD0	0x0
>  #define RST_HOLD1	0x4
> diff --git a/arch/arm/mach-vexpress/v2m.c b/arch/arm/mach-vexpress/v2m.c
> index 95886b3bb9dd..ffe7c7a85ae9 100644
> --- a/arch/arm/mach-vexpress/v2m.c
> +++ b/arch/arm/mach-vexpress/v2m.c
> @@ -1,8 +1,31 @@
>  // SPDX-License-Identifier: GPL-2.0
> +#include <linux/of.h>
> +#include <linux/of_address.h>
>  #include <asm/mach/arch.h>
>  
>  #include "core.h"
>  
> +#define SYS_FLAGSSET		0x030
> +#define SYS_FLAGSCLR		0x034
> +
> +void vexpress_flags_set(u32 data)
> +{
> +	static void __iomem *base;
> +
> +	if (!base) {
> +		struct device_node *node = of_find_compatible_node(NULL, NULL,
> +				"arm,vexpress-sysreg");
> +
> +		base = of_iomap(node, 0);
> +	}
> +
> +	if (WARN_ON(!base))
> +		return;
> +
> +	writel(~0, base + SYS_FLAGSCLR);
> +	writel(data, base + SYS_FLAGSSET);
> +}
> +
>  static const char * const v2m_dt_match[] __initconst = {
>  	"arm,vexpress",
>  	NULL,
> diff --git a/drivers/mfd/vexpress-sysreg.c b/drivers/mfd/vexpress-sysreg.c
> index c68ff56dbdb1..0b9cc67706c7 100644
> --- a/drivers/mfd/vexpress-sysreg.c
> +++ b/drivers/mfd/vexpress-sysreg.c
> @@ -8,7 +8,6 @@
>  #include <linux/err.h>
>  #include <linux/io.h>
>  #include <linux/mfd/core.h>
> -#include <linux/of_address.h>
>  #include <linux/of_platform.h>
>  #include <linux/platform_data/syscon.h>
>  #include <linux/platform_device.h>
> @@ -42,24 +41,6 @@
>  
>  #define SYS_MISC_MASTERSITE	(1 << 14)
>  
> -void vexpress_flags_set(u32 data)
> -{
> -	static void __iomem *base;
> -
> -	if (!base) {
> -		struct device_node *node = of_find_compatible_node(NULL, NULL,
> -				"arm,vexpress-sysreg");
> -
> -		base = of_iomap(node, 0);
> -	}
> -
> -	if (WARN_ON(!base))
> -		return;
> -
> -	writel(~0, base + SYS_FLAGSCLR);
> -	writel(data, base + SYS_FLAGSSET);
> -}
> -
>  /* The sysreg block is just a random collection of various functions... */
>  
>  static struct syscon_platform_data vexpress_sysreg_sys_id_pdata = {
> diff --git a/include/linux/vexpress.h b/include/linux/vexpress.h
> index 0e130b5077a5..2ec7992b054c 100644
> --- a/include/linux/vexpress.h
> +++ b/include/linux/vexpress.h
> @@ -40,8 +40,4 @@ struct device *vexpress_config_bridge_register(struct device *parent,
>  
>  struct regmap *devm_regmap_init_vexpress_config(struct device *dev);
>  
> -/* Platform control */
> -
> -void vexpress_flags_set(u32 data);
> -
>  #endif
> -- 
> 2.20.1
> 

-- 
====================
| I would like to |
| fix the world,  |
| but they're not |
| giving me the   |
 \ source code!  /
  ---------------
    ¯\_(ツ)_/¯
