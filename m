Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFE411B5CD4
	for <lists+linux-pm@lfdr.de>; Thu, 23 Apr 2020 15:45:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728437AbgDWNpk (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 23 Apr 2020 09:45:40 -0400
Received: from foss.arm.com ([217.140.110.172]:40142 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727898AbgDWNpk (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 23 Apr 2020 09:45:40 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0C68431B;
        Thu, 23 Apr 2020 06:45:39 -0700 (PDT)
Received: from bogus (unknown [10.37.12.118])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 72B2E3F6CF;
        Thu, 23 Apr 2020 06:45:35 -0700 (PDT)
Date:   Thu, 23 Apr 2020 14:45:28 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Liviu Dudau <liviu.dudau@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Lee Jones <lee.jones@linaro.org>,
        Sebastian Reichel <sre@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>, Will Deacon <will@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Kevin Brodsky <Kevin.Brodsky@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-pm@vger.kernel.org,
        Michael Turquette <mturquette@baylibre.com>
Subject: Re: [PATCH 08/17] clk: vexpress-osc: Support building as a module
Message-ID: <20200423133342.GA10628@bogus>
References: <20200419170810.5738-1-robh@kernel.org>
 <20200419170810.5738-9-robh@kernel.org>
 <20200422210802.GH25585@bogus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200422210802.GH25585@bogus>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Apr 22, 2020 at 10:08:02PM +0100, Sudeep Holla wrote:
> On Sun, Apr 19, 2020 at 12:08:01PM -0500, Rob Herring wrote:
> > Enable building the vexpress-osc clock driver as a module.
> >
> > Cc: Linus Walleij <linus.walleij@linaro.org>
> > Cc: Liviu Dudau <liviu.dudau@arm.com>
> > Cc: Sudeep Holla <sudeep.holla@arm.com>
> > Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> > Cc: Michael Turquette <mturquette@baylibre.com>
> > Cc: Stephen Boyd <sboyd@kernel.org>
> > Cc: linux-clk@vger.kernel.org
> > Signed-off-by: Rob Herring <robh@kernel.org>
> > ---
> >  drivers/clk/versatile/Kconfig            |  4 ++--
> >  drivers/clk/versatile/clk-vexpress-osc.c | 10 ++++------
> >  2 files changed, 6 insertions(+), 8 deletions(-)
> >
> > diff --git a/drivers/clk/versatile/Kconfig b/drivers/clk/versatile/Kconfig
> > index 5bdd5c98990b..9de2396dcf9b 100644
> > --- a/drivers/clk/versatile/Kconfig
> > +++ b/drivers/clk/versatile/Kconfig
> > @@ -15,8 +15,8 @@ config CLK_SP810
> >  	  of the ARM SP810 System Controller cell.
> >
> >  config CLK_VEXPRESS_OSC
> > -	bool "Clock driver for Versatile Express OSC clock generators"
> > -	depends on VEXPRESS_CONFIG || COMPILE_TEST
> > +	tristate "Clock driver for Versatile Express OSC clock generators"
> > +	depends on VEXPRESS_CONFIG
> >  	default y if ARCH_VEXPRESS
> >  	---help---
> >  	  Simple regmap-based driver driving clock generators on Versatile
> > diff --git a/drivers/clk/versatile/clk-vexpress-osc.c b/drivers/clk/versatile/clk-vexpress-osc.c
> > index 5bb1d5a714d0..b2b32fa2d7c3 100644
> > --- a/drivers/clk/versatile/clk-vexpress-osc.c
> > +++ b/drivers/clk/versatile/clk-vexpress-osc.c
> > @@ -7,6 +7,7 @@
> >  #include <linux/clkdev.h>
> >  #include <linux/clk-provider.h>
> >  #include <linux/err.h>
> > +#include <linux/module.h>
> >  #include <linux/of.h>
> >  #include <linux/platform_device.h>
> >  #include <linux/slab.h>
> > @@ -108,6 +109,7 @@ static const struct of_device_id vexpress_osc_of_match[] = {
> >  	{ .compatible = "arm,vexpress-osc", },
> >  	{}
> >  };
> > +MODULE_DEVICE_TABLE(of, vexpress_osc_of_match);
> >
> >  static struct platform_driver vexpress_osc_driver = {
> >  	.driver	= {
> > @@ -116,9 +118,5 @@ static struct platform_driver vexpress_osc_driver = {
> >  	},
> >  	.probe = vexpress_osc_probe,
> >  };
> > -
> > -static int __init vexpress_osc_init(void)
> > -{
> > -	return platform_driver_register(&vexpress_osc_driver);
> > -}
> > -core_initcall(vexpress_osc_init);
> > +module_platform_driver(vexpress_osc_driver);
>
> I am not 100% sure of this. This might break the boot on CA9 and TC2
> at-least. There are loads of MB peripherals that need this. This will
> break the boot. We need to check if all the dependent modules are also
> at module_initcall level and if they deal with deferred probe correctly.
> Lot of them are legacy and may happen to be working by carefully initcall
> level adjustments.
>

OK I managed to try this on my TC2 and it fails to boot. However when I
enable earlyprintk as I see no log without it, it boots just fine.

I also checked adding initcall_debug and I may be wrong on the dependency
part. The modules dependent on vexpress-osc are probed later correctly.

This make it more difficult to debug as I don't have any debugger attached
at the moment to look at the logbuf when it hangs without earlyprintk.

--
Regards,
Sudeep
