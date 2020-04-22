Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01A251B43E8
	for <lists+linux-pm@lfdr.de>; Wed, 22 Apr 2020 14:04:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726835AbgDVMEj (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 22 Apr 2020 08:04:39 -0400
Received: from foss.arm.com ([217.140.110.172]:48552 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726539AbgDVMEj (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 22 Apr 2020 08:04:39 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8B20331B;
        Wed, 22 Apr 2020 05:04:38 -0700 (PDT)
Received: from e110455-lin.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 606A53F6CF;
        Wed, 22 Apr 2020 05:04:38 -0700 (PDT)
Received: by e110455-lin.cambridge.arm.com (Postfix, from userid 1000)
        id 048DD682F37; Wed, 22 Apr 2020 13:04:37 +0100 (BST)
Date:   Wed, 22 Apr 2020 13:04:36 +0100
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
Subject: Re: [PATCH 16/17] bus: vexpress-config: Support building as module
Message-ID: <20200422120436.GA364558@e110455-lin.cambridge.arm.com>
References: <20200419170810.5738-1-robh@kernel.org>
 <20200419170810.5738-17-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200419170810.5738-17-robh@kernel.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sun, Apr 19, 2020 at 12:08:09PM -0500, Rob Herring wrote:
> Enable building vexpress-config driver as a module.
> 
> Cc: Liviu Dudau <liviu.dudau@arm.com>

Acked-by: Liviu Dudau <liviu.dudau@arm.com>

> Cc: Sudeep Holla <sudeep.holla@arm.com>
> Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  drivers/bus/Kconfig           |  2 +-
>  drivers/bus/vexpress-config.c | 10 ++++------
>  2 files changed, 5 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/bus/Kconfig b/drivers/bus/Kconfig
> index 6d4e4497b59b..c16268c53831 100644
> --- a/drivers/bus/Kconfig
> +++ b/drivers/bus/Kconfig
> @@ -183,7 +183,7 @@ config UNIPHIER_SYSTEM_BUS
>  	  needed to use on-board devices connected to UniPhier SoCs.
>  
>  config VEXPRESS_CONFIG
> -	bool "Versatile Express configuration bus"
> +	tristate "Versatile Express configuration bus"
>  	default y if ARCH_VEXPRESS
>  	depends on ARM || ARM64
>  	depends on OF
> diff --git a/drivers/bus/vexpress-config.c b/drivers/bus/vexpress-config.c
> index caa35a4cb34d..a58ac0c8e282 100644
> --- a/drivers/bus/vexpress-config.c
> +++ b/drivers/bus/vexpress-config.c
> @@ -7,6 +7,7 @@
>  #include <linux/err.h>
>  #include <linux/init.h>
>  #include <linux/io.h>
> +#include <linux/module.h>
>  #include <linux/of.h>
>  #include <linux/platform_device.h>
>  #include <linux/of_device.h>
> @@ -407,15 +408,12 @@ static const struct platform_device_id vexpress_syscfg_id_table[] = {
>  	{ "vexpress-syscfg", },
>  	{},
>  };
> +MODULE_DEVICE_TABLE(platform, vexpress_syscfg_id_table);
>  
>  static struct platform_driver vexpress_syscfg_driver = {
>  	.driver.name = "vexpress-syscfg",
>  	.id_table = vexpress_syscfg_id_table,
>  	.probe = vexpress_syscfg_probe,
>  };
> -
> -static int __init vexpress_syscfg_init(void)
> -{
> -	return platform_driver_register(&vexpress_syscfg_driver);
> -}
> -core_initcall(vexpress_syscfg_init);
> +module_platform_driver(vexpress_syscfg_driver);
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
