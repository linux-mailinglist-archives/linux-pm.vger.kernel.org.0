Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F38F1B4296
	for <lists+linux-pm@lfdr.de>; Wed, 22 Apr 2020 13:02:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726654AbgDVLCe (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 22 Apr 2020 07:02:34 -0400
Received: from foss.arm.com ([217.140.110.172]:47676 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732435AbgDVLCc (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 22 Apr 2020 07:02:32 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id ABE1E31B;
        Wed, 22 Apr 2020 04:02:31 -0700 (PDT)
Received: from e110455-lin.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8B6DB3F6CF;
        Wed, 22 Apr 2020 04:02:31 -0700 (PDT)
Received: by e110455-lin.cambridge.arm.com (Postfix, from userid 1000)
        id 451BC682F3D; Wed, 22 Apr 2020 12:02:30 +0100 (BST)
Date:   Wed, 22 Apr 2020 12:02:30 +0100
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
Subject: Re: [PATCH 09/17] mfd: vexpress-sysreg: Drop selecting
 CONFIG_CLKSRC_MMIO
Message-ID: <20200422110230.GU364558@e110455-lin.cambridge.arm.com>
References: <20200419170810.5738-1-robh@kernel.org>
 <20200419170810.5738-10-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200419170810.5738-10-robh@kernel.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sun, Apr 19, 2020 at 12:08:02PM -0500, Rob Herring wrote:
> Nothing in the VExpress sysregs nor the MFD child drivers use
> CONFIG_CLKSRC_MMIO. There's the 24MHz counter, but that's handled by
> drivers/clocksource/timer-versatile.c which doesn't use
> CONFIG_CLKSRC_MMIO either. So let's just drop CONFIG_CLKSRC_MMIO.
> 
> As the !ARCH_USES_GETTIMEOFFSET dependency was added for
> CONFIG_CLKSRC_MMIO, that can be dropped, too.
> 
> Cc: Liviu Dudau <liviu.dudau@arm.com>

Acked-by: Liviu Dudau <liviu.dudau@arm.com>

> Cc: Sudeep Holla <sudeep.holla@arm.com>
> Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Lee Jones <lee.jones@linaro.org>
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  drivers/mfd/Kconfig | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> index 0a59249198d3..b1311dea2da1 100644
> --- a/drivers/mfd/Kconfig
> +++ b/drivers/mfd/Kconfig
> @@ -2029,9 +2029,8 @@ endmenu
>  
>  config MFD_VEXPRESS_SYSREG
>  	bool "Versatile Express System Registers"
> -	depends on VEXPRESS_CONFIG && GPIOLIB && !ARCH_USES_GETTIMEOFFSET
> +	depends on VEXPRESS_CONFIG && GPIOLIB
>  	default y
> -	select CLKSRC_MMIO
>  	select GPIO_GENERIC_PLATFORM
>  	select MFD_CORE
>  	select MFD_SYSCON
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
