Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBE9C1D9BDA
	for <lists+linux-pm@lfdr.de>; Tue, 19 May 2020 18:00:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729284AbgESQAK (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 19 May 2020 12:00:10 -0400
Received: from elvis.franken.de ([193.175.24.41]:59264 "EHLO elvis.franken.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729089AbgESQAK (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 19 May 2020 12:00:10 -0400
Received: from uucp (helo=alpha)
        by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
        id 1jb4ex-0001Fc-00; Tue, 19 May 2020 18:00:03 +0200
Received: by alpha.franken.de (Postfix, from userid 1000)
        id ED273C0136; Tue, 19 May 2020 17:50:53 +0200 (CEST)
Date:   Tue, 19 May 2020 17:50:53 +0200
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc:     Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Paul Burton <paulburton@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Rob Herring <robh+dt@kernel.org>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 18/20] mips: csrc-r4k: Decrease r4k-clocksource rating
 if CPU_FREQ enabled
Message-ID: <20200519155053.GB15797@alpha.franken.de>
References: <20200306124807.3596F80307C2@mail.baikalelectronics.ru>
 <20200506174238.15385-1-Sergey.Semin@baikalelectronics.ru>
 <20200506174238.15385-19-Sergey.Semin@baikalelectronics.ru>
 <20200508154150.GB22247@alpha.franken.de>
 <20200511133121.cz5axbwynhmqkx7x@mobilestation>
 <20200515074827.6p5zx4sb3bmavjih@mobilestation>
 <20200515210647.GA22922@alpha.franken.de>
 <20200518134820.wedoumgbsllvhem6@mobilestation>
 <20200518163206.GA17800@alpha.franken.de>
 <20200518205752.txbylbjt2zkwdwwe@mobilestation>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200518205752.txbylbjt2zkwdwwe@mobilestation>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, May 18, 2020 at 11:57:52PM +0300, Serge Semin wrote:
> On Mon, May 18, 2020 at 06:32:06PM +0200, Thomas Bogendoerfer wrote:
> > On Mon, May 18, 2020 at 04:48:20PM +0300, Serge Semin wrote:
> > > On Fri, May 15, 2020 at 11:06:47PM +0200, Thomas Bogendoerfer wrote:
> > > > On Fri, May 15, 2020 at 10:48:27AM +0300, Serge Semin wrote:
> > > > > Thomas,
> > > > > Could you take a look at my comment below so I could proceed with the
> > > > > patchset v3 development?
> > > > 
> > > > I can't help, but using r4k clocksource with changing frequency is
> > > > probaly only usefull as a random generator. So IMHO the only two
> > > > options are disabling it or implement what arch/x86/kernel/tsc.c does.
> > > > 
> > > > Thomas.
> > > 
> > > Thomas, could you proceed with the rest of the patches review?
> > > ├─>[PATCH v2 16/20] bus: cdmm: Add MIPS R5 arch support
> > > ├─>[PATCH v2 15/20] mips: cdmm: Add mti,mips-cdmm dtb node support
> > 
> > both are not my call, but look ok to me.
> 
> Can I add your Reviewed-by tag there then?

only for 16/20. 15/20 looks ok to me, but I have not enough insides
on the hardware to say this is good.

> > > ├─>[PATCH v2 13/20] mips: early_printk_8250: Use offset-sized IO-mem accessors
> > 
> > that's broken. A reg shift of 2 doesn't mean we could use 32bit access
> > to the registers on other platforms. As I don't think adding some ifdefery
> > makes things nicer, just implement the your prom_putchar in board code.
> 
> I thought about that initially, but then I decided to alter the generic
> early_printk_8250 code instead. My version of prom_putchar() would be almost
> the same as one implemented in the early_printk_8250 module except minor
> modification of replacing readb/writeb methods with readl/writel. So I didn't
> want to duplicate the code, but wanted to provide a general way to fix the
> problem potentially also for another platforms.
> 
> Since you don't like this fix alternatively I'd suggest to add the reg_width
> parameter passed to the setup_8250_early_printk_port() method like this:
> -setup_8250_early_printk_port(unsigned long base, unsigned int reg_shift,
> -                             unsigned int timeout)
> +setup_8250_early_printk_port(unsigned long base, unsigned int reg_shift,
> +                             unsigned int reg_width, unsigned int timeout)
> 
> By reg_width parameter we could determine the actual width of the register:
>  static inline u8 serial_in(int offset)
>  {
> -       return readb(serial8250_base + (offset << serial8250_reg_shift));
> +       u8 ret = 0xFF;
> +
> +       offset <<= serial8250_reg_shift;
> +       switch (serial8250_reg_width) {
> +       case 1:
> +               ret = readb(serial8250_base + offset);
> +               break;
> +       case 2:
> +               ret = readw(serial8250_base + offset);
> +               break;
> +       case 4:
> +               ret = readl(serial8250_base + offset);
> +               break;
> +       default:
> +               break;
> +       }
> +
> +       return ret;
>  }
> 
> The similar modification will be implemented for serial_out(). I'll also modify

look at the lines of code you are adding. Doing your own prom_putchar will
probably have less lines.

> What do you think about this?

please do your own prom_putchar.


> > 
> > > ├─>[PATCH v2 12/20] mips: MAAR: Add XPA mode support
> > 
> > looks ok so far.
> 
> Can I add your Reviewed-by tag there then?

As I'm the maintainer of the part, I've simply applied it.

> > 
> > > ├─>[PATCH v2 10/20] mips: Add CONFIG/CONFIG6/Cause reg fields macro
> > 
> > that is fine
> 
> Can I add your Reviewed-by tag there then?

As this didn't apply cleanly, I'll apply it after you've resent it.
IMHO no need for a Reviewed-by.

> > > └─>[PATCH v2 09/20] mips: Add CP0 Write Merge config support
> > 
> > this is IMHO a dangerous change. Enabling write merging for any
> > CPU supporting it might triggers bugs. Do it in your board bringup
> > code and at the moment I don't see a reason for the rest of that
> > patch.
> 
> Let's at least leave the mm_config() implementation but without the write-merge
> enabling by default. Providing features availability macro
> cpu_has_mm_sysad/cpu_has_mm_full and c0 config fields

do you have a user of that ? I'm not introducing code nobody uses.

> I could use them to implement a code pattern like:
> 
> +	if (cpu_has_mm_full) {
> +		unsigned int config0 = read_c0_config();
> +               config0 = (config0 & ~MIPS_CONF_MM) | MIPS_CONF_MM_FULL;
> +               write_c0_config(config0);
> +	}

you know you are running on a R5 core, so you know you have MM_FULL.
No need to check this.

> By doing so I can manually enable/disable the MM feature in the
> cpu-feature-overrides.h. Without that I'd have to locally define these macro,
> which isn't good seeing they are in fact generic and can be useful for other
> platforms with SYSAD and FULL MM feature available. What do you think?

To me this is a hardware feature I expect to be done by firmware and
Linux shouldn't care about it, if it doesn't have any software
implications.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
