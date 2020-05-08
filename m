Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B91191CB3A3
	for <lists+linux-pm@lfdr.de>; Fri,  8 May 2020 17:42:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728344AbgEHPm0 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 8 May 2020 11:42:26 -0400
Received: from elvis.franken.de ([193.175.24.41]:44977 "EHLO elvis.franken.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726736AbgEHPmX (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 8 May 2020 11:42:23 -0400
Received: from uucp (helo=alpha)
        by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
        id 1jX58n-0005J7-00; Fri, 08 May 2020 17:42:21 +0200
Received: by alpha.franken.de (Postfix, from userid 1000)
        id 106BCC041B; Fri,  8 May 2020 17:40:46 +0200 (CEST)
Date:   Fri, 8 May 2020 17:40:46 +0200
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     Sergey.Semin@baikalelectronics.ru
Cc:     Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Paul Burton <paulburton@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Rob Herring <robh+dt@kernel.org>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org,
        afzal mohammed <afzal.mohd.ma@gmail.com>,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 19/20] mips: cevt-r4k: Update the r4k-clockevent
 frequency in sync with CPU
Message-ID: <20200508154045.GA22247@alpha.franken.de>
References: <20200306124807.3596F80307C2@mail.baikalelectronics.ru>
 <20200506174238.15385-1-Sergey.Semin@baikalelectronics.ru>
 <20200506174238.15385-20-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200506174238.15385-20-Sergey.Semin@baikalelectronics.ru>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, May 06, 2020 at 08:42:37PM +0300, Sergey.Semin@baikalelectronics.ru wrote:
> diff --git a/arch/mips/kernel/cevt-r4k.c b/arch/mips/kernel/cevt-r4k.c
> index 17a9cbb8b3df..f5b72fb7d5ee 100644
> --- a/arch/mips/kernel/cevt-r4k.c
> +++ b/arch/mips/kernel/cevt-r4k.c
> @@ -8,6 +8,7 @@
>   */
>  #include <linux/clockchips.h>
>  #include <linux/interrupt.h>
> +#include <linux/cpufreq.h>
>  #include <linux/percpu.h>
>  #include <linux/smp.h>
>  #include <linux/irq.h>
> @@ -250,6 +251,49 @@ unsigned int __weak get_c0_compare_int(void)
>  	return MIPS_CPU_IRQ_BASE + cp0_compare_irq;
>  }
>  
> +#ifdef CONFIG_CPU_FREQ
> +
> +static unsigned long mips_ref_freq;
> +
> +static int cpufreq_callback(struct notifier_block *nb,
> +			    unsigned long val, void *data)

please prefix function names with r4k_ to make them different from
the other ones you implemented in kernel/time.c. I know they are
static, but keeping different names makes looking at crashes easier.

> +	struct cpufreq_freqs *freq = data;
> +	struct clock_event_device *cd;
> +	unsigned long rate;
> +	int cpu;
> +
> +	if (!mips_ref_freq)
> +		mips_ref_freq = freq->old;

isn't this the same as mips_hpt_frequency ?

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
