Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B2751B42FA
	for <lists+linux-pm@lfdr.de>; Wed, 22 Apr 2020 13:18:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726457AbgDVLS4 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 22 Apr 2020 07:18:56 -0400
Received: from foss.arm.com ([217.140.110.172]:47854 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726104AbgDVLS4 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 22 Apr 2020 07:18:56 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EBE3B31B;
        Wed, 22 Apr 2020 04:18:55 -0700 (PDT)
Received: from e110455-lin.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CD23A3F6CF;
        Wed, 22 Apr 2020 04:18:55 -0700 (PDT)
Received: by e110455-lin.cambridge.arm.com (Postfix, from userid 1000)
        id 99924682F3F; Wed, 22 Apr 2020 12:18:54 +0100 (BST)
Date:   Wed, 22 Apr 2020 12:18:54 +0100
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
Subject: Re: [PATCH 11/17] mfd: vexpress-sysreg: Use devres API variants
Message-ID: <20200422111854.GW364558@e110455-lin.cambridge.arm.com>
References: <20200419170810.5738-1-robh@kernel.org>
 <20200419170810.5738-12-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200419170810.5738-12-robh@kernel.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sun, Apr 19, 2020 at 12:08:04PM -0500, Rob Herring wrote:
> Use the managed devm_gpiochip_add_data() and devm_mfd_add_devices()
> instead of their unmanaged counterparts. With this, no .remove() hook is
> needed for driver unbind.
> 
> Cc: Liviu Dudau <liviu.dudau@arm.com>

Acked-by: Liviu Dudau <liviu.dudau@arm.com>

> Cc: Sudeep Holla <sudeep.holla@arm.com>
> Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Lee Jones <lee.jones@linaro.org>
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  drivers/mfd/vexpress-sysreg.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mfd/vexpress-sysreg.c b/drivers/mfd/vexpress-sysreg.c
> index 90a4eda2ba2b..9fb37fa689e0 100644
> --- a/drivers/mfd/vexpress-sysreg.c
> +++ b/drivers/mfd/vexpress-sysreg.c
> @@ -140,9 +140,9 @@ static int vexpress_sysreg_probe(struct platform_device *pdev)
>  	bgpio_init(mmc_gpio_chip, &pdev->dev, 0x4, base + SYS_MCI,
>  			NULL, NULL, NULL, NULL, 0);
>  	mmc_gpio_chip->ngpio = 2;
> -	gpiochip_add_data(mmc_gpio_chip, NULL);
> +	devm_gpiochip_add_data(&pdev->dev, mmc_gpio_chip, NULL);
>  
> -	return mfd_add_devices(&pdev->dev, PLATFORM_DEVID_AUTO,
> +	return devm_mfd_add_devices(&pdev->dev, PLATFORM_DEVID_AUTO,
>  			vexpress_sysreg_cells,
>  			ARRAY_SIZE(vexpress_sysreg_cells), mem, 0, NULL);
>  }
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
