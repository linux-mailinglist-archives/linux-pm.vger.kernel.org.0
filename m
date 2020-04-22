Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DA641B427D
	for <lists+linux-pm@lfdr.de>; Wed, 22 Apr 2020 13:02:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727897AbgDVLBp (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 22 Apr 2020 07:01:45 -0400
Received: from foss.arm.com ([217.140.110.172]:47584 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726742AbgDVLBo (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 22 Apr 2020 07:01:44 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B267231B;
        Wed, 22 Apr 2020 04:01:43 -0700 (PDT)
Received: from e110455-lin.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 905FE3F6CF;
        Wed, 22 Apr 2020 04:01:43 -0700 (PDT)
Received: by e110455-lin.cambridge.arm.com (Postfix, from userid 1000)
        id 35482682F3D; Wed, 22 Apr 2020 12:01:42 +0100 (BST)
Date:   Wed, 22 Apr 2020 12:01:42 +0100
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
        linux-pm@vger.kernel.org,
        Michael Turquette <mturquette@baylibre.com>
Subject: Re: [PATCH 08/17] clk: vexpress-osc: Support building as a module
Message-ID: <20200422110142.GT364558@e110455-lin.cambridge.arm.com>
References: <20200419170810.5738-1-robh@kernel.org>
 <20200419170810.5738-9-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200419170810.5738-9-robh@kernel.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sun, Apr 19, 2020 at 12:08:01PM -0500, Rob Herring wrote:
> Enable building the vexpress-osc clock driver as a module.
> 
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Liviu Dudau <liviu.dudau@arm.com>
> Cc: Sudeep Holla <sudeep.holla@arm.com>
> Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Cc: Michael Turquette <mturquette@baylibre.com>
> Cc: Stephen Boyd <sboyd@kernel.org>
> Cc: linux-clk@vger.kernel.org
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  drivers/clk/versatile/Kconfig            |  4 ++--
>  drivers/clk/versatile/clk-vexpress-osc.c | 10 ++++------
>  2 files changed, 6 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/clk/versatile/Kconfig b/drivers/clk/versatile/Kconfig
> index 5bdd5c98990b..9de2396dcf9b 100644
> --- a/drivers/clk/versatile/Kconfig
> +++ b/drivers/clk/versatile/Kconfig
> @@ -15,8 +15,8 @@ config CLK_SP810
>  	  of the ARM SP810 System Controller cell.
>  
>  config CLK_VEXPRESS_OSC
> -	bool "Clock driver for Versatile Express OSC clock generators"
> -	depends on VEXPRESS_CONFIG || COMPILE_TEST
> +	tristate "Clock driver for Versatile Express OSC clock generators"
> +	depends on VEXPRESS_CONFIG

Looks good to me with the exception of COMPILE_TEST appearing in patch 5 and
disappearing here. Which one should be the one to survive?

Best regards,
Liviu

>  	default y if ARCH_VEXPRESS
>  	---help---
>  	  Simple regmap-based driver driving clock generators on Versatile
> diff --git a/drivers/clk/versatile/clk-vexpress-osc.c b/drivers/clk/versatile/clk-vexpress-osc.c
> index 5bb1d5a714d0..b2b32fa2d7c3 100644
> --- a/drivers/clk/versatile/clk-vexpress-osc.c
> +++ b/drivers/clk/versatile/clk-vexpress-osc.c
> @@ -7,6 +7,7 @@
>  #include <linux/clkdev.h>
>  #include <linux/clk-provider.h>
>  #include <linux/err.h>
> +#include <linux/module.h>
>  #include <linux/of.h>
>  #include <linux/platform_device.h>
>  #include <linux/slab.h>
> @@ -108,6 +109,7 @@ static const struct of_device_id vexpress_osc_of_match[] = {
>  	{ .compatible = "arm,vexpress-osc", },
>  	{}
>  };
> +MODULE_DEVICE_TABLE(of, vexpress_osc_of_match);
>  
>  static struct platform_driver vexpress_osc_driver = {
>  	.driver	= {
> @@ -116,9 +118,5 @@ static struct platform_driver vexpress_osc_driver = {
>  	},
>  	.probe = vexpress_osc_probe,
>  };
> -
> -static int __init vexpress_osc_init(void)
> -{
> -	return platform_driver_register(&vexpress_osc_driver);
> -}
> -core_initcall(vexpress_osc_init);
> +module_platform_driver(vexpress_osc_driver);
> +MODULE_LICENSE("GPL v2");
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
