Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44DA01CDB3A
	for <lists+linux-pm@lfdr.de>; Mon, 11 May 2020 15:31:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728000AbgEKNb1 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 11 May 2020 09:31:27 -0400
Received: from mail.baikalelectronics.com ([87.245.175.226]:49156 "EHLO
        mail.baikalelectronics.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726013AbgEKNb1 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 11 May 2020 09:31:27 -0400
Received: from localhost (unknown [127.0.0.1])
        by mail.baikalelectronics.ru (Postfix) with ESMTP id 83FF7803088B;
        Mon, 11 May 2020 13:31:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at baikalelectronics.ru
Received: from mail.baikalelectronics.ru ([127.0.0.1])
        by localhost (mail.baikalelectronics.ru [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id JL0tmpxOQGd4; Mon, 11 May 2020 16:31:22 +0300 (MSK)
Date:   Mon, 11 May 2020 16:31:21 +0300
From:   Serge Semin <Sergey.Semin@baikalelectronics.ru>
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>
CC:     Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Paul Burton <paulburton@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Rob Herring <robh+dt@kernel.org>, <linux-pm@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        <linux-mips@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 18/20] mips: csrc-r4k: Decrease r4k-clocksource rating
 if CPU_FREQ enabled
Message-ID: <20200511133121.cz5axbwynhmqkx7x@mobilestation>
References: <20200306124807.3596F80307C2@mail.baikalelectronics.ru>
 <20200506174238.15385-1-Sergey.Semin@baikalelectronics.ru>
 <20200506174238.15385-19-Sergey.Semin@baikalelectronics.ru>
 <20200508154150.GB22247@alpha.franken.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200508154150.GB22247@alpha.franken.de>
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, May 08, 2020 at 05:41:50PM +0200, Thomas Bogendoerfer wrote:
> On Wed, May 06, 2020 at 08:42:36PM +0300, Sergey.Semin@baikalelectronics.ru wrote:
> > From: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> > 
> > Commit 07d69579e7fe ("MIPS: Don't register r4k sched clock when
> > CPUFREQ enabled") disabled the r4k-clock usage for scheduler ticks
> > counting due to the scheduler being non-tolerant for unstable
> > clocks sources. For the same reason the clock should be used
> > in the system clocksource framework only as a last resort if CPU
> > frequency may change.
> > 
> > Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> > Cc: Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>
> > Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
> > Cc: Paul Burton <paulburton@kernel.org>
> > Cc: Ralf Baechle <ralf@linux-mips.org>
> > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Cc: Arnd Bergmann <arnd@arndb.de>
> > Cc: Rob Herring <robh+dt@kernel.org>
> > Cc: linux-pm@vger.kernel.org
> > Cc: devicetree@vger.kernel.org
> > ---
> >  arch/mips/kernel/csrc-r4k.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> > 
> > diff --git a/arch/mips/kernel/csrc-r4k.c b/arch/mips/kernel/csrc-r4k.c
> > index 437dda64fd7a..d81fb374f477 100644
> > --- a/arch/mips/kernel/csrc-r4k.c
> > +++ b/arch/mips/kernel/csrc-r4k.c
> > @@ -71,7 +71,11 @@ int __init init_r4k_clocksource(void)
> >  		return -ENXIO;
> >  
> >  	/* Calculate a somewhat reasonable rating value */
> > +#ifndef CONFIG_CPU_FREQ
> >  	clocksource_mips.rating = 200 + mips_hpt_frequency / 10000000;
> > +#else
> > +	clocksource_mips.rating = 99;
> > +#endif
> 
> I dislike this patch. Assuming you have an other clocksource, why not
> simply disable csrc-r4k, if CPU_FREQ is enabled ?

Me neither and the best way would be to update the clocksource frequency
dynamically the same way it's done for cevt-r4k and MIPS GIC timers. Alas the
clocksource doesn't support it. Due to this together with CPU-freq facility
enabled we have to use a very slow DW APB Timer instead of the fast embedded
into the CPU core r4k and MIPS GIC timers. Just note the difference: it takes
220 ns to read the counter from DW APB Timer in comparison to a few nanoseconds
reading from MIPS GIC and R4K. So IMO disabling the timer as you suggest isn't
the best option. By making the CPUFREQ and CSRC_R4K mutual exclusive we'd
assume a use-case that the system will always use the CPU-freq facility changing
the CPU reference frequency. This is obviously not true. Noone prevents the
system administrator to leave the default setting of the CPU-freq with fixed
frequency and select a faster, more accurate timer like in our case.

My idea was not to try to predict how the system would be used, but to let the
system administration to choose which timer is applicable in particular usecase
enabling a safest one by default. So if CPUFREQ is available, then we fallback
to the external timer as safest one. If the system user wouldn't need to have
the CPUFREQ facility utilized, then the system administrator would want to
leave the default CPU-freq governor with pre-defined CPU frequency and
select either R4K (MIPS) or MIPS GIC timer just by writing its name into
/sys/bus/clocksource/devices/clocksource0/current_clocksource .
 
I should note, that currently CPU_FREQ won't be available if there is no
MIPS_EXTERNAL_TIMER available for the platform. It's prohibited by means of the
conditional kbuild config inclusion declared in the arch/mips/Kconfig:
+ if CPU_SUPPORTS_CPUFREQ && MIPS_EXTERNAL_TIMER
+ source "drivers/cpufreq/Kconfig"
+ endif
So if there is no external timer working independently from the CPU core clock
source, the CPUFREQ won't be available to select for the kernel. Though currently
this limitation is supposed to be applicable for the R4K/MIPS GIC clocksource
timers only since clockevents must work fine in unstable reference clock conditions.

So what can we do to improve the patch? First one is a solution I suggested in
this patch but it could be a bit altered by using IS_ENABLED() macro to:
+ clocksource_mips.rating = !IS_ENABLED(CONFIG_CPU_FREQ) ?
+			    200 + mips_hpt_frequency / 10000000 : 99;

Another idea I discovered when have been searching through the x86 arch code.
x86's got the same problem with TSC timer, but it doesn't disable it if
CPU-frequency is switched on. Instead it just marks it as unstable by calling
the clocksource_mark_unstable() method if CPU frequency changes. I suggest to
implement the same approach in our case of MIPS GIC (another patchset
I've sent, see "clocksource: Fix MIPS GIC and DW APB Timer for Baikal-T1 SoC
support" in your email client) and R4K timers. We'll subscribe to the CPU
frequency change and if it changes we'll call clocksource_mark_unstable() with
MIPS GIC and R4K clocksource handlers passed. This shall reduce their rating and
cause selecting a clocksource with better one. BTW I suppose it won't be
necessary to initially lower the rating of the MIPS GIC and R4K clocksource
timers if this is implemented.

So, what do you think?

-Sergey

> 
> Thomas.
> 
> -- 
> Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
> good idea.                                                [ RFC1925, 2.3 ]
