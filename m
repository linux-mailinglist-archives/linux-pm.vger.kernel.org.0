Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7DEB210A5FE
	for <lists+linux-pm@lfdr.de>; Tue, 26 Nov 2019 22:28:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726148AbfKZV2v (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 26 Nov 2019 16:28:51 -0500
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:57805 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726101AbfKZV2v (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 26 Nov 2019 16:28:51 -0500
X-Originating-IP: 90.65.92.102
Received: from localhost (lfbn-1-1723-102.w90-65.abo.wanadoo.fr [90.65.92.102])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id 1B17E60002;
        Tue, 26 Nov 2019 21:28:41 +0000 (UTC)
Date:   Tue, 26 Nov 2019 22:28:41 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Claudiu Beznea <claudiu.beznea@microchip.com>
Cc:     linux@armlinux.org.uk, nicolas.ferre@microchip.com,
        ludovic.desroches@microchip.com, sre@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH v2 02/17] ARM: at91: pm: move SAM9X60's PM under its own
 SoC config flag
Message-ID: <20191126212841.GR299836@piout.net>
References: <1574773941-20649-1-git-send-email-claudiu.beznea@microchip.com>
 <1574773941-20649-3-git-send-email-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1574773941-20649-3-git-send-email-claudiu.beznea@microchip.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 26/11/2019 15:12:06+0200, Claudiu Beznea wrote:
> Move SAM9X60's PM part under SoC config flag. This allows the building
> of SAM9X60 platform withouth depending on CONFIG_SOC_AT91SAM9 flag,
> allowing us to select only necessary config flags for SAM9X60.
> 

I'm really wondering, how much space does that really save?

The net benefit seems to be very small...

> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
> ---
>  arch/arm/mach-at91/Makefile   |  1 +
>  arch/arm/mach-at91/at91sam9.c | 18 ------------------
>  arch/arm/mach-at91/pm.c       |  2 +-
>  arch/arm/mach-at91/sam9x60.c  | 34 ++++++++++++++++++++++++++++++++++
>  4 files changed, 36 insertions(+), 19 deletions(-)
>  create mode 100644 arch/arm/mach-at91/sam9x60.c
> 
> diff --git a/arch/arm/mach-at91/Makefile b/arch/arm/mach-at91/Makefile
> index de64301dcff2..f565490f1b70 100644
> --- a/arch/arm/mach-at91/Makefile
> +++ b/arch/arm/mach-at91/Makefile
> @@ -6,6 +6,7 @@
>  # CPU-specific support
>  obj-$(CONFIG_SOC_AT91RM9200)	+= at91rm9200.o
>  obj-$(CONFIG_SOC_AT91SAM9)	+= at91sam9.o
> +obj-$(CONFIG_SOC_SAM9X60)	+= sam9x60.o
>  obj-$(CONFIG_SOC_SAMA5)		+= sama5.o
>  obj-$(CONFIG_SOC_SAMV7)		+= samv7.o
>  
> diff --git a/arch/arm/mach-at91/at91sam9.c b/arch/arm/mach-at91/at91sam9.c
> index bf629c90c758..7e572189a5eb 100644
> --- a/arch/arm/mach-at91/at91sam9.c
> +++ b/arch/arm/mach-at91/at91sam9.c
> @@ -31,21 +31,3 @@ DT_MACHINE_START(at91sam_dt, "Atmel AT91SAM9")
>  	.init_machine	= at91sam9_init,
>  	.dt_compat	= at91_dt_board_compat,
>  MACHINE_END
> -
> -static void __init sam9x60_init(void)
> -{
> -	of_platform_default_populate(NULL, NULL, NULL);
> -
> -	sam9x60_pm_init();
> -}
> -
> -static const char *const sam9x60_dt_board_compat[] __initconst = {
> -	"microchip,sam9x60",
> -	NULL
> -};
> -
> -DT_MACHINE_START(sam9x60_dt, "Microchip SAM9X60")
> -	/* Maintainer: Microchip */
> -	.init_machine	= sam9x60_init,
> -	.dt_compat	= sam9x60_dt_board_compat,
> -MACHINE_END
> diff --git a/arch/arm/mach-at91/pm.c b/arch/arm/mach-at91/pm.c
> index d5af6aedc02c..56a6a49b19e2 100644
> --- a/arch/arm/mach-at91/pm.c
> +++ b/arch/arm/mach-at91/pm.c
> @@ -805,7 +805,7 @@ void __init at91rm9200_pm_init(void)
>  
>  void __init sam9x60_pm_init(void)
>  {
> -	if (!IS_ENABLED(CONFIG_SOC_AT91SAM9))
> +	if (!IS_ENABLED(CONFIG_SOC_SAM9X60))
>  		return;
>  
>  	at91_pm_modes_init();
> diff --git a/arch/arm/mach-at91/sam9x60.c b/arch/arm/mach-at91/sam9x60.c
> new file mode 100644
> index 000000000000..d8c739d25458
> --- /dev/null
> +++ b/arch/arm/mach-at91/sam9x60.c
> @@ -0,0 +1,34 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Setup code for SAM9X60.
> + *
> + * Copyright (C) 2019 Microchip Technology Inc. and its subsidiaries
> + *
> + * Author: Claudiu Beznea <claudiu.beznea@microchip.com>
> + */
> +
> +#include <linux/of.h>
> +#include <linux/of_platform.h>
> +
> +#include <asm/mach/arch.h>
> +#include <asm/system_misc.h>
> +
> +#include "generic.h"
> +
> +static void __init sam9x60_init(void)
> +{
> +	of_platform_default_populate(NULL, NULL, NULL);
> +
> +	sam9x60_pm_init();
> +}
> +
> +static const char *const sam9x60_dt_board_compat[] __initconst = {
> +	"microchip,sam9x60",
> +	NULL
> +};
> +
> +DT_MACHINE_START(sam9x60_dt, "Microchip SAM9X60")
> +	/* Maintainer: Microchip */
> +	.init_machine	= sam9x60_init,
> +	.dt_compat	= sam9x60_dt_board_compat,
> +MACHINE_END
> -- 
> 2.7.4
> 

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
