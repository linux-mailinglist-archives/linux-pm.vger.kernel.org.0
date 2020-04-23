Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49E601B5FF2
	for <lists+linux-pm@lfdr.de>; Thu, 23 Apr 2020 17:53:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729348AbgDWPx4 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 23 Apr 2020 11:53:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:36120 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729230AbgDWPxz (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 23 Apr 2020 11:53:55 -0400
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 010E721582;
        Thu, 23 Apr 2020 15:53:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587657235;
        bh=s3YHiF3eHUkNFeBMptoPc4xjgSN1RME0WUf4jO6w/us=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=A4phta+jNe4PkzlcXnUchsz34o2lcWJYlSeHvPrXxVgP2NqWk+Xq1dOTpvwJ/2nKr
         JPrRIp+D3x3lLbTzRDRlRzzAZZxaVLBa/87IcYH6WfNHeYa8pqIXKbQtfh1zk24sCJ
         AtLQweB9a+m8MyWv2FPyhkscdXMXQfFul7pYyNXs=
Received: by mail-yb1-f175.google.com with SMTP id e17so3407067ybq.0;
        Thu, 23 Apr 2020 08:53:54 -0700 (PDT)
X-Gm-Message-State: AGi0PuYpEtJkNaXLu9+jIMjSpDdZgzIdcLSS0VUmw78ABaOiW8tWfZ4r
        JhmD3dgwed1aHDn/eP4BqnImJPekKwF2U+c/pg==
X-Google-Smtp-Source: APiQypItf6P4u5QhuwYnh32TjB2B27BbwMX+t2h/1EzeCIMKMBZ70JAemO83CNpLnyd2kyd3i8vYaBELfUOCkztl7Xo=
X-Received: by 2002:a25:b74c:: with SMTP id e12mr8433306ybm.472.1587657234161;
 Thu, 23 Apr 2020 08:53:54 -0700 (PDT)
MIME-Version: 1.0
References: <20200419170810.5738-1-robh@kernel.org> <20200419170810.5738-9-robh@kernel.org>
 <20200422210802.GH25585@bogus> <20200423133342.GA10628@bogus>
In-Reply-To: <20200423133342.GA10628@bogus>
From:   Rob Herring <robh@kernel.org>
Date:   Thu, 23 Apr 2020 10:53:40 -0500
X-Gmail-Original-Message-ID: <CAL_JsqLnKd5_ifeARuc8RfsUCnc37jNBOkGSeWEp6EPA4J9tqA@mail.gmail.com>
Message-ID: <CAL_JsqLnKd5_ifeARuc8RfsUCnc37jNBOkGSeWEp6EPA4J9tqA@mail.gmail.com>
Subject: Re: [PATCH 08/17] clk: vexpress-osc: Support building as a module
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Liviu Dudau <liviu.dudau@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Lee Jones <lee.jones@linaro.org>,
        Sebastian Reichel <sre@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>, Will Deacon <will@kernel.org>,
        Kevin Brodsky <Kevin.Brodsky@arm.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        Michael Turquette <mturquette@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Apr 23, 2020 at 8:45 AM Sudeep Holla <sudeep.holla@arm.com> wrote:
>
> On Wed, Apr 22, 2020 at 10:08:02PM +0100, Sudeep Holla wrote:
> > On Sun, Apr 19, 2020 at 12:08:01PM -0500, Rob Herring wrote:
> > > Enable building the vexpress-osc clock driver as a module.
> > >
> > > Cc: Linus Walleij <linus.walleij@linaro.org>
> > > Cc: Liviu Dudau <liviu.dudau@arm.com>
> > > Cc: Sudeep Holla <sudeep.holla@arm.com>
> > > Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> > > Cc: Michael Turquette <mturquette@baylibre.com>
> > > Cc: Stephen Boyd <sboyd@kernel.org>
> > > Cc: linux-clk@vger.kernel.org
> > > Signed-off-by: Rob Herring <robh@kernel.org>
> > > ---
> > >  drivers/clk/versatile/Kconfig            |  4 ++--
> > >  drivers/clk/versatile/clk-vexpress-osc.c | 10 ++++------
> > >  2 files changed, 6 insertions(+), 8 deletions(-)
> > >
> > > diff --git a/drivers/clk/versatile/Kconfig b/drivers/clk/versatile/Kconfig
> > > index 5bdd5c98990b..9de2396dcf9b 100644
> > > --- a/drivers/clk/versatile/Kconfig
> > > +++ b/drivers/clk/versatile/Kconfig
> > > @@ -15,8 +15,8 @@ config CLK_SP810
> > >       of the ARM SP810 System Controller cell.
> > >
> > >  config CLK_VEXPRESS_OSC
> > > -   bool "Clock driver for Versatile Express OSC clock generators"
> > > -   depends on VEXPRESS_CONFIG || COMPILE_TEST
> > > +   tristate "Clock driver for Versatile Express OSC clock generators"
> > > +   depends on VEXPRESS_CONFIG
> > >     default y if ARCH_VEXPRESS
> > >     ---help---
> > >       Simple regmap-based driver driving clock generators on Versatile
> > > diff --git a/drivers/clk/versatile/clk-vexpress-osc.c b/drivers/clk/versatile/clk-vexpress-osc.c
> > > index 5bb1d5a714d0..b2b32fa2d7c3 100644
> > > --- a/drivers/clk/versatile/clk-vexpress-osc.c
> > > +++ b/drivers/clk/versatile/clk-vexpress-osc.c
> > > @@ -7,6 +7,7 @@
> > >  #include <linux/clkdev.h>
> > >  #include <linux/clk-provider.h>
> > >  #include <linux/err.h>
> > > +#include <linux/module.h>
> > >  #include <linux/of.h>
> > >  #include <linux/platform_device.h>
> > >  #include <linux/slab.h>
> > > @@ -108,6 +109,7 @@ static const struct of_device_id vexpress_osc_of_match[] = {
> > >     { .compatible = "arm,vexpress-osc", },
> > >     {}
> > >  };
> > > +MODULE_DEVICE_TABLE(of, vexpress_osc_of_match);
> > >
> > >  static struct platform_driver vexpress_osc_driver = {
> > >     .driver = {
> > > @@ -116,9 +118,5 @@ static struct platform_driver vexpress_osc_driver = {
> > >     },
> > >     .probe = vexpress_osc_probe,
> > >  };
> > > -
> > > -static int __init vexpress_osc_init(void)
> > > -{
> > > -   return platform_driver_register(&vexpress_osc_driver);
> > > -}
> > > -core_initcall(vexpress_osc_init);
> > > +module_platform_driver(vexpress_osc_driver);
> >
> > I am not 100% sure of this. This might break the boot on CA9 and TC2
> > at-least. There are loads of MB peripherals that need this. This will
> > break the boot. We need to check if all the dependent modules are also
> > at module_initcall level and if they deal with deferred probe correctly.
> > Lot of them are legacy and may happen to be working by carefully initcall
> > level adjustments.
> >
>
> OK I managed to try this on my TC2 and it fails to boot. However when I
> enable earlyprintk as I see no log without it, it boots just fine.

Well, the uart clocks for TC2 are all dependent on vexpress-osc. The
console setup is going to fail to get the clocks and just fail as
there's no deferred probe for consoles. We need some way to retrigger
the console matching.

> I also checked adding initcall_debug and I may be wrong on the dependency
> part. The modules dependent on vexpress-osc are probed later correctly.
>
> This make it more difficult to debug as I don't have any debugger attached
> at the moment to look at the logbuf when it hangs without earlyprintk.
>
> --
> Regards,
> Sudeep
