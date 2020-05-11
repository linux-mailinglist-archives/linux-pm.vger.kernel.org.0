Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3120D1CCEE1
	for <lists+linux-pm@lfdr.de>; Mon, 11 May 2020 02:34:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729313AbgEKAey (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 10 May 2020 20:34:54 -0400
Received: from mail.baikalelectronics.com ([87.245.175.226]:47740 "EHLO
        mail.baikalelectronics.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729255AbgEKAey (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 10 May 2020 20:34:54 -0400
Received: from localhost (unknown [127.0.0.1])
        by mail.baikalelectronics.ru (Postfix) with ESMTP id 83B488030807;
        Mon, 11 May 2020 00:34:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at baikalelectronics.ru
Received: from mail.baikalelectronics.ru ([127.0.0.1])
        by localhost (mail.baikalelectronics.ru [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id MfPFw58JDpyC; Mon, 11 May 2020 03:34:46 +0300 (MSK)
Date:   Mon, 11 May 2020 03:34:44 +0300
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
        afzal mohammed <afzal.mohd.ma@gmail.com>,
        <linux-mips@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 19/20] mips: cevt-r4k: Update the r4k-clockevent
 frequency in sync with CPU
Message-ID: <20200511003444.rcxp7e4elxdcgpyi@mobilestation>
References: <20200306124807.3596F80307C2@mail.baikalelectronics.ru>
 <20200506174238.15385-1-Sergey.Semin@baikalelectronics.ru>
 <20200506174238.15385-20-Sergey.Semin@baikalelectronics.ru>
 <20200508154045.GA22247@alpha.franken.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200508154045.GA22247@alpha.franken.de>
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, May 08, 2020 at 05:40:46PM +0200, Thomas Bogendoerfer wrote:
> On Wed, May 06, 2020 at 08:42:37PM +0300, Sergey.Semin@baikalelectronics.ru wrote:
> > diff --git a/arch/mips/kernel/cevt-r4k.c b/arch/mips/kernel/cevt-r4k.c
> > index 17a9cbb8b3df..f5b72fb7d5ee 100644
> > --- a/arch/mips/kernel/cevt-r4k.c
> > +++ b/arch/mips/kernel/cevt-r4k.c
> > @@ -8,6 +8,7 @@
> >   */
> >  #include <linux/clockchips.h>
> >  #include <linux/interrupt.h>
> > +#include <linux/cpufreq.h>
> >  #include <linux/percpu.h>
> >  #include <linux/smp.h>
> >  #include <linux/irq.h>
> > @@ -250,6 +251,49 @@ unsigned int __weak get_c0_compare_int(void)
> >  	return MIPS_CPU_IRQ_BASE + cp0_compare_irq;
> >  }
> >  
> > +#ifdef CONFIG_CPU_FREQ
> > +
> > +static unsigned long mips_ref_freq;
> > +
> > +static int cpufreq_callback(struct notifier_block *nb,
> > +			    unsigned long val, void *data)
> 
> please prefix function names with r4k_ to make them different from
> the other ones you implemented in kernel/time.c. I know they are
> static, but keeping different names makes looking at crashes easier.

Agreed. I'll fix it in v3.

> 
> > +	struct cpufreq_freqs *freq = data;
> > +	struct clock_event_device *cd;
> > +	unsigned long rate;
> > +	int cpu;
> > +
> > +	if (!mips_ref_freq)
> > +		mips_ref_freq = freq->old;
> 
> isn't this the same as mips_hpt_frequency ?

No. Here I save the initial CPU frequency so use one then to scale the
mips_hpt_frequency value in accordance with the CPU clock rate change. Yes,
mips_hpt_frequency value may initially match the CPU frequency on some platforms
but normally the r4k timer is clocked with half of it while some systems may have
a complicated algorithm of the timer ref clock rate calculation.

-Sergey

> 
> Thomas.
> 
> -- 
> Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
> good idea.                                                [ RFC1925, 2.3 ]
