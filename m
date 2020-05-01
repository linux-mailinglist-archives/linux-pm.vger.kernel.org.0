Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B0951C1A9F
	for <lists+linux-pm@lfdr.de>; Fri,  1 May 2020 18:33:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729577AbgEAQcw (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 1 May 2020 12:32:52 -0400
Received: from foss.arm.com ([217.140.110.172]:43532 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728443AbgEAQcv (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 1 May 2020 12:32:51 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8FFE930E;
        Fri,  1 May 2020 09:32:46 -0700 (PDT)
Received: from bogus (unknown [10.37.12.80])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D52B43F68F;
        Fri,  1 May 2020 09:32:42 -0700 (PDT)
Date:   Fri, 1 May 2020 17:32:39 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Liviu Dudau <liviu.dudau@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Kevin Brodsky <Kevin.Brodsky@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Lee Jones <lee.jones@linaro.org>,
        Sebastian Reichel <sre@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>, Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH v2 05/16] clk: versatile: Only enable SP810 on 32-bit by
 default
Message-ID: <20200501163239.GB14018@bogus>
References: <20200429205825.10604-1-robh@kernel.org>
 <20200429205825.10604-6-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200429205825.10604-6-robh@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Apr 29, 2020 at 03:58:14PM -0500, Rob Herring wrote:
> While 64-bit Arm reference platforms have SP810 for clocks for SP804
> timers, they are not needed since the arch timers are used instead.
> 
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Sudeep Holla <sudeep.holla@arm.com>

With a note below for sake of information,

Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>

> Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Stephen Boyd <sboyd@kernel.org>
> Cc: linux-clk@vger.kernel.org
> Acked-by: Arnd Bergmann <arnd@arndb.de>
> Acked-by: Liviu Dudau <liviu.dudau@arm.com>
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  drivers/clk/versatile/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/clk/versatile/Kconfig b/drivers/clk/versatile/Kconfig
> index df0d50bb846c..a47dd6c86d2e 100644
> --- a/drivers/clk/versatile/Kconfig
> +++ b/drivers/clk/versatile/Kconfig
> @@ -17,7 +17,7 @@ config ICST
>  
>  config CLK_SP810
>  	bool "Clock driver for ARM SP810 System Controller"
> -	default y if ARCH_VEXPRESS
> +	default y if (ARCH_VEXPRESS && ARM)

Just note that SP804 is selected by ARCH_HISILICON and ARCH_BRCM or
something for Raspberry Pi. So, this will result in the warnings on
Juno like:

sp804: timer clock not found: -517
sp804: arm,sp804 clock not found: -2
sp804: timer clock not found: -517
sp804: arm,sp804 clock not found: -2

This can be ignored as we rely on arch-timers and they are just there
in DT for completion. We can disable them in DT if that's fine ?

-- 
Regards,
Sudeep
