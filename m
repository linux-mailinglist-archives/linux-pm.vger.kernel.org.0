Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 79FF3E1859
	for <lists+linux-pm@lfdr.de>; Wed, 23 Oct 2019 12:54:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391132AbfJWKyv (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 23 Oct 2019 06:54:51 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:43601 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391130AbfJWKyv (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 23 Oct 2019 06:54:51 -0400
Received: by mail-ed1-f65.google.com with SMTP id q24so9414761edr.10;
        Wed, 23 Oct 2019 03:54:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=r6ms4pDA2Io4CTjl1wUKKAATbv5RRZz2tIcEDGLgepo=;
        b=pKd6AAzmwQNVDkNuU1W1XtMuzsfcD7jfek5faWv2EyAlF0oAhwUqW/nozV6fF+zeYe
         eFxQeC4FdVFBIWC+47TqlYk7KO9eEwyfwyPeJcNIp3fPMwnaL9ZZ9M0oKT3CLnJo6B/y
         XQKMGvvMH7ReapAq73sY80qNH8XIElp9OeJ7XgFb1/pjVy4vY1247Sxeh+cZoKt43aED
         tCGGqDJD6RrlbPHo72o0redUg6e4+ofAMedk+WhaNE7TjOrdaOBiWP+tnjSgeU8gY49m
         rwLwxSZPU947u0XpIZyk5KqCE2b8xAvbijyr2FeOjSgG1LCxMJDnI5MgX4lcK4GFdVDk
         j5qg==
X-Gm-Message-State: APjAAAVfN+ATq0qjzJ9OFWO8bioGP/gEdDgOgl034OLTCJMw/YmDEJ3Z
        cYUhao7PXSIny5JUzMblLGM=
X-Google-Smtp-Source: APXvYqwyEdHY2cawxAEl8qxuJDNsa+N3qjsKSsNQUSXfNNSO0jGbBOf9XkdEZb3aiOgqobmijN4vpQ==
X-Received: by 2002:aa7:c48c:: with SMTP id m12mr2761987edq.152.1571828086544;
        Wed, 23 Oct 2019 03:54:46 -0700 (PDT)
Received: from pi3 ([194.230.155.217])
        by smtp.googlemail.com with ESMTPSA id x4sm748023eds.87.2019.10.23.03.54.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2019 03:54:45 -0700 (PDT)
Date:   Wed, 23 Oct 2019 12:54:43 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Kukjin Kim <kgene@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linus.walleij@linaro.org,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Pankaj Dubey <pankaj.dubey@samsung.com>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH 07/36] ARM: exynos: use private samsung_cpu_id copy
Message-ID: <20191023105443.GE10630@pi3>
References: <20191010202802.1132272-1-arnd@arndb.de>
 <20191010203043.1241612-1-arnd@arndb.de>
 <20191010203043.1241612-7-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191010203043.1241612-7-arnd@arndb.de>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Oct 10, 2019 at 10:29:51PM +0200, Arnd Bergmann wrote:
> The only part of plat-samsung that is shared with arch-exynos
> is the CPU identification code.
> 
> Having a separate exynos_cpu_id variable makes the two completely
> independent and is actually a bit less code in total.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  arch/arm/mach-exynos/common.h                |  6 +++---
>  arch/arm/mach-exynos/exynos.c                | 19 +++++++++++++++----
>  arch/arm/mach-exynos/include/mach/map.h      | 18 ------------------
>  arch/arm/mach-exynos/platsmp.c               |  4 +---
>  arch/arm/mach-exynos/pm.c                    |  8 ++++----
>  arch/arm/plat-samsung/cpu.c                  | 17 -----------------
>  arch/arm/plat-samsung/include/plat/cpu.h     |  2 --
>  arch/arm/plat-samsung/include/plat/map-s5p.h |  2 --
>  8 files changed, 23 insertions(+), 53 deletions(-)
>  delete mode 100644 arch/arm/mach-exynos/include/mach/map.h
> 
> diff --git a/arch/arm/mach-exynos/common.h b/arch/arm/mach-exynos/common.h
> index 56411bb63d45..adf7db9c0885 100644
> --- a/arch/arm/mach-exynos/common.h
> +++ b/arch/arm/mach-exynos/common.h
> @@ -24,12 +24,12 @@
>  #define EXYNOS5800_SOC_ID	0xE5422000
>  #define EXYNOS5_SOC_MASK	0xFFFFF000
>  
> -extern unsigned long samsung_cpu_id;
> +extern unsigned long exynos_cpu_id;
>  
>  #define IS_SAMSUNG_CPU(name, id, mask)		\
>  static inline int is_samsung_##name(void)	\
>  {						\
> -	return ((samsung_cpu_id & mask) == (id & mask));	\
> +	return ((exynos_cpu_id & mask) == (id & mask));	\
>  }
>  
>  IS_SAMSUNG_CPU(exynos3250, EXYNOS3250_SOC_ID, EXYNOS3_SOC_MASK)
> @@ -147,7 +147,7 @@ extern struct cpuidle_exynos_data cpuidle_coupled_exynos_data;
>  
>  extern void exynos_set_delayed_reset_assertion(bool enable);
>  
> -extern unsigned int samsung_rev(void);
> +extern unsigned int exynos_rev(void);
>  extern void exynos_core_restart(u32 core_id);
>  extern int exynos_set_boot_addr(u32 core_id, unsigned long boot_addr);
>  extern int exynos_get_boot_addr(u32 core_id, unsigned long *boot_addr);
> diff --git a/arch/arm/mach-exynos/exynos.c b/arch/arm/mach-exynos/exynos.c
> index 9aa483366ebc..da9300d655c6 100644
> --- a/arch/arm/mach-exynos/exynos.c
> +++ b/arch/arm/mach-exynos/exynos.c
> @@ -19,11 +19,10 @@
>  #include <asm/mach/arch.h>
>  #include <asm/mach/map.h>
>  
> -#include <mach/map.h>
> -#include <plat/cpu.h>
> -
>  #include "common.h"
>  
> +#define S5P_VA_CHIPID	((void __iomem __force *)0xF8000000)

How about keeping the S3C_VA and S3C_ADDR_BASE macros/defines and using
them? They still appear in arch/arm/include/debug/exynos.S so they could
be integrated into one header, unless you plan to remove it in further
patches.

> +
>  static struct platform_device exynos_cpuidle = {
>  	.name              = "exynos_cpuidle",
>  #ifdef CONFIG_ARM_EXYNOS_CPUIDLE
> @@ -36,6 +35,14 @@ void __iomem *sysram_base_addr __ro_after_init;
>  phys_addr_t sysram_base_phys __ro_after_init;
>  void __iomem *sysram_ns_base_addr __ro_after_init;
>  
> +unsigned long exynos_cpu_id;
> +static unsigned int exynos_cpu_rev;
> +
> +unsigned int exynos_rev(void)
> +{
> +	return exynos_cpu_rev;
> +}
> +
>  void __init exynos_sysram_init(void)
>  {
>  	struct device_node *node;
> @@ -86,7 +93,11 @@ static void __init exynos_init_io(void)
>  	of_scan_flat_dt(exynos_fdt_map_chipid, NULL);
>  
>  	/* detect cpu id and rev. */
> -	s5p_init_cpu(S5P_VA_CHIPID);
> +	exynos_cpu_id = readl_relaxed(S5P_VA_CHIPID);
> +	exynos_cpu_rev = exynos_cpu_id & 0xFF;
> +
> +	pr_info("Samsung CPU ID: 0x%08lx\n", exynos_cpu_id);
> +
>  }
>  
>  /*
> diff --git a/arch/arm/mach-exynos/include/mach/map.h b/arch/arm/mach-exynos/include/mach/map.h
> deleted file mode 100644
> index 22ebe3654633..000000000000
> --- a/arch/arm/mach-exynos/include/mach/map.h
> +++ /dev/null
> @@ -1,18 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0 */
> -/*
> - * Copyright (c) 2010-2011 Samsung Electronics Co., Ltd.
> - *		http://www.samsung.com/
> - *
> - * EXYNOS - Memory map definitions
> - */
> -
> -#ifndef __ASM_ARCH_MAP_H
> -#define __ASM_ARCH_MAP_H __FILE__
> -
> -#include <plat/map-base.h>
> -
> -#include <plat/map-s5p.h>
> -
> -#define EXYNOS_PA_CHIPID		0x10000000
> -
> -#endif /* __ASM_ARCH_MAP_H */
> diff --git a/arch/arm/mach-exynos/platsmp.c b/arch/arm/mach-exynos/platsmp.c
> index 0cbbae8bf1f8..d7fedbb2eefe 100644
> --- a/arch/arm/mach-exynos/platsmp.c
> +++ b/arch/arm/mach-exynos/platsmp.c
> @@ -22,8 +22,6 @@
>  #include <asm/smp_scu.h>
>  #include <asm/firmware.h>
>  
> -#include <mach/map.h>
> -
>  #include "common.h"
>  
>  extern void exynos4_secondary_startup(void);
> @@ -188,7 +186,7 @@ void exynos_scu_enable(void)
>  
>  static void __iomem *cpu_boot_reg_base(void)
>  {
> -	if (soc_is_exynos4210() && samsung_rev() == EXYNOS4210_REV_1_1)
> +	if (soc_is_exynos4210() && exynos_rev() == EXYNOS4210_REV_1_1)
>  		return pmu_base_addr + S5P_INFORM5;
>  	return sysram_base_addr;
>  }
> diff --git a/arch/arm/mach-exynos/pm.c b/arch/arm/mach-exynos/pm.c
> index 48e7fb38613e..624585641a9c 100644
> --- a/arch/arm/mach-exynos/pm.c
> +++ b/arch/arm/mach-exynos/pm.c
> @@ -26,18 +26,18 @@
>  
>  static inline void __iomem *exynos_boot_vector_addr(void)
>  {
> -	if (samsung_rev() == EXYNOS4210_REV_1_1)
> +	if (exynos_rev() == EXYNOS4210_REV_1_1)
>  		return pmu_base_addr + S5P_INFORM7;
> -	else if (samsung_rev() == EXYNOS4210_REV_1_0)
> +	else if (exynos_rev() == EXYNOS4210_REV_1_0)
>  		return sysram_base_addr + 0x24;
>  	return pmu_base_addr + S5P_INFORM0;
>  }
>  
>  static inline void __iomem *exynos_boot_vector_flag(void)
>  {
> -	if (samsung_rev() == EXYNOS4210_REV_1_1)
> +	if (exynos_rev() == EXYNOS4210_REV_1_1)
>  		return pmu_base_addr + S5P_INFORM6;
> -	else if (samsung_rev() == EXYNOS4210_REV_1_0)
> +	else if (exynos_rev() == EXYNOS4210_REV_1_0)
>  		return sysram_base_addr + 0x20;
>  	return pmu_base_addr + S5P_INFORM1;
>  }
> diff --git a/arch/arm/plat-samsung/cpu.c b/arch/arm/plat-samsung/cpu.c
> index e1ba88ba31d8..8acba21bbf4b 100644
> --- a/arch/arm/plat-samsung/cpu.c
> +++ b/arch/arm/plat-samsung/cpu.c
> @@ -14,13 +14,6 @@
>  #include <plat/cpu.h>
>  
>  unsigned long samsung_cpu_id;
> -static unsigned int samsung_cpu_rev;
> -
> -unsigned int samsung_rev(void)
> -{
> -	return samsung_cpu_rev;
> -}
> -EXPORT_SYMBOL(samsung_rev);
>  
>  void __init s3c64xx_init_cpu(void)
>  {
> @@ -34,15 +27,5 @@ void __init s3c64xx_init_cpu(void)
>  		samsung_cpu_id = readl_relaxed(S3C_VA_SYS + 0xA1C);
>  	}
>  
> -	samsung_cpu_rev = 0;
> -
> -	pr_info("Samsung CPU ID: 0x%08lx\n", samsung_cpu_id);
> -}
> -
> -void __init s5p_init_cpu(const void __iomem *cpuid_addr)
> -{
> -	samsung_cpu_id = readl_relaxed(cpuid_addr);
> -	samsung_cpu_rev = samsung_cpu_id & 0xFF;
> -
>  	pr_info("Samsung CPU ID: 0x%08lx\n", samsung_cpu_id);
>  }
> diff --git a/arch/arm/plat-samsung/include/plat/cpu.h b/arch/arm/plat-samsung/include/plat/cpu.h
> index fadcddbea064..02d7f991d5a3 100644
> --- a/arch/arm/plat-samsung/include/plat/cpu.h
> +++ b/arch/arm/plat-samsung/include/plat/cpu.h
> @@ -111,8 +111,6 @@ extern void s3c24xx_init_io(struct map_desc *mach_desc, int size);
>  extern void s3c64xx_init_cpu(void);
>  extern void s5p_init_cpu(const void __iomem *cpuid_addr);

You can remove it as well.

Best regards,
Krzysztof

>  
> -extern unsigned int samsung_rev(void);
> -
>  extern void s3c24xx_init_uarts(struct s3c2410_uartcfg *cfg, int no);
>  
>  extern void s3c24xx_init_clocks(int xtal);
> diff --git a/arch/arm/plat-samsung/include/plat/map-s5p.h b/arch/arm/plat-samsung/include/plat/map-s5p.h
> index d69a0ca09fb5..3812085f8761 100644
> --- a/arch/arm/plat-samsung/include/plat/map-s5p.h
> +++ b/arch/arm/plat-samsung/include/plat/map-s5p.h
> @@ -9,8 +9,6 @@
>  #ifndef __ASM_PLAT_MAP_S5P_H
>  #define __ASM_PLAT_MAP_S5P_H __FILE__
>  
> -#define S5P_VA_CHIPID		S3C_ADDR(0x02000000)
> -
>  #define VA_VIC(x)		(S3C_VA_IRQ + ((x) * 0x10000))
>  #define VA_VIC0			VA_VIC(0)
>  #define VA_VIC1			VA_VIC(1)
> -- 
> 2.20.0
> 
