Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 798DC1DB31A
	for <lists+linux-pm@lfdr.de>; Wed, 20 May 2020 14:21:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726443AbgETMVa (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 20 May 2020 08:21:30 -0400
Received: from mail.baikalelectronics.com ([87.245.175.226]:58416 "EHLO
        mail.baikalelectronics.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726224AbgETMVa (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 20 May 2020 08:21:30 -0400
Received: from localhost (unknown [127.0.0.1])
        by mail.baikalelectronics.ru (Postfix) with ESMTP id 7033F8030875;
        Wed, 20 May 2020 12:21:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at baikalelectronics.ru
Received: from mail.baikalelectronics.ru ([127.0.0.1])
        by localhost (mail.baikalelectronics.ru [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id HpXx65hG0gh0; Wed, 20 May 2020 15:21:26 +0300 (MSK)
Date:   Wed, 20 May 2020 15:21:25 +0300
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
Message-ID: <20200520122125.opn53q5wxvcc4ath@mobilestation>
References: <20200506174238.15385-19-Sergey.Semin@baikalelectronics.ru>
 <20200508154150.GB22247@alpha.franken.de>
 <20200511133121.cz5axbwynhmqkx7x@mobilestation>
 <20200515074827.6p5zx4sb3bmavjih@mobilestation>
 <20200515210647.GA22922@alpha.franken.de>
 <20200518134820.wedoumgbsllvhem6@mobilestation>
 <20200518163206.GA17800@alpha.franken.de>
 <20200518205752.txbylbjt2zkwdwwe@mobilestation>
 <20200519155053.GB15797@alpha.franken.de>
 <20200520121201.wohv6u646rx5otkf@mobilestation>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200520121201.wohv6u646rx5otkf@mobilestation>
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, May 20, 2020 at 03:12:02PM +0300, Serge Semin wrote:
> On Tue, May 19, 2020 at 05:50:53PM +0200, Thomas Bogendoerfer wrote:
> > On Mon, May 18, 2020 at 11:57:52PM +0300, Serge Semin wrote:
> > > On Mon, May 18, 2020 at 06:32:06PM +0200, Thomas Bogendoerfer wrote:
> > > > On Mon, May 18, 2020 at 04:48:20PM +0300, Serge Semin wrote:

[nip]

> > > > > ├─>[PATCH v2 13/20] mips: early_printk_8250: Use offset-sized IO-mem accessors
> > > > 
> > > > that's broken. A reg shift of 2 doesn't mean we could use 32bit access
> > > > to the registers on other platforms. As I don't think adding some ifdefery
> > > > makes things nicer, just implement the your prom_putchar in board code.
> > > 
> > > I thought about that initially, but then I decided to alter the generic
> > > early_printk_8250 code instead. My version of prom_putchar() would be almost
> > > the same as one implemented in the early_printk_8250 module except minor
> > > modification of replacing readb/writeb methods with readl/writel. So I didn't
> > > want to duplicate the code, but wanted to provide a general way to fix the
> > > problem potentially also for another platforms.
> > > 
> > > Since you don't like this fix alternatively I'd suggest to add the reg_width
> > > parameter passed to the setup_8250_early_printk_port() method like this:
> > > -setup_8250_early_printk_port(unsigned long base, unsigned int reg_shift,
> > > -                             unsigned int timeout)
> > > +setup_8250_early_printk_port(unsigned long base, unsigned int reg_shift,
> > > +                             unsigned int reg_width, unsigned int timeout)
> > > 
> > > By reg_width parameter we could determine the actual width of the register:
> > >  static inline u8 serial_in(int offset)
> > >  {
> > > -       return readb(serial8250_base + (offset << serial8250_reg_shift));
> > > +       u8 ret = 0xFF;
> > > +
> > > +       offset <<= serial8250_reg_shift;
> > > +       switch (serial8250_reg_width) {
> > > +       case 1:
> > > +               ret = readb(serial8250_base + offset);
> > > +               break;
> > > +       case 2:
> > > +               ret = readw(serial8250_base + offset);
> > > +               break;
> > > +       case 4:
> > > +               ret = readl(serial8250_base + offset);
> > > +               break;
> > > +       default:
> > > +               break;
> > > +       }
> > > +
> > > +       return ret;
> > >  }
> > > 
> > > The similar modification will be implemented for serial_out(). I'll also modify
> > 
> > look at the lines of code you are adding. Doing your own prom_putchar will
> > probably have less lines.
> > 
> > > What do you think about this?
> > 
> > please do your own prom_putchar.
> 
> One more time regarding this problem but in appliance to another part of the
> MIPS code. I've missed the patch to draw your attention to:
> [PATCH v2 14/20] mips: Use offset-sized IO-mem accessors in CPS debug printout
> 
> There I've applied the same fix as in the patch:
> [PATCH v2 13/20] mips: early_printk_8250: Use offset-sized IO-mem accessors
> 
> Since you don't like the way I initially fixed it, suppose there we don't have
> another way but to introduce something like CONFIG_MIPS_CPS_NS16550_WIDTH
> parameter to select a proper accessors, like sw in our case, and sb by defaul).
> Right?
> 

> (Note UART_L is incorrectly created in that patch, I'll remove that macro in
> v3.)

Hm, actually no. The macro is correct. According to the code _mips_cps_putc()
always perform lw from the UART MMIO registers. This must be a bug. Don't you
think?

-Sergey

> 
> -Sergey
> 

