Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F3961DC0FE
	for <lists+linux-pm@lfdr.de>; Wed, 20 May 2020 23:12:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727115AbgETVMG (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 20 May 2020 17:12:06 -0400
Received: from mail.baikalelectronics.com ([87.245.175.226]:60792 "EHLO
        mail.baikalelectronics.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727018AbgETVMF (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 20 May 2020 17:12:05 -0400
Received: from localhost (unknown [127.0.0.1])
        by mail.baikalelectronics.ru (Postfix) with ESMTP id BD7CB803087B;
        Wed, 20 May 2020 21:12:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at baikalelectronics.ru
Received: from mail.baikalelectronics.ru ([127.0.0.1])
        by localhost (mail.baikalelectronics.ru [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id rm8xPnTOIoPd; Thu, 21 May 2020 00:12:02 +0300 (MSK)
Date:   Thu, 21 May 2020 00:12:00 +0300
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
Message-ID: <20200520211200.qhfgdz4qnatyloob@mobilestation>
References: <20200515074827.6p5zx4sb3bmavjih@mobilestation>
 <20200515210647.GA22922@alpha.franken.de>
 <20200518134820.wedoumgbsllvhem6@mobilestation>
 <20200518163206.GA17800@alpha.franken.de>
 <20200518205752.txbylbjt2zkwdwwe@mobilestation>
 <20200519155053.GB15797@alpha.franken.de>
 <20200520121201.wohv6u646rx5otkf@mobilestation>
 <20200520133827.GA17714@alpha.franken.de>
 <20200520134826.pc6si3k6boaexp4i@mobilestation>
 <20200520183057.GA23855@alpha.franken.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200520183057.GA23855@alpha.franken.de>
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, May 20, 2020 at 08:30:57PM +0200, Thomas Bogendoerfer wrote:
> On Wed, May 20, 2020 at 04:48:26PM +0300, Serge Semin wrote:
> > On Wed, May 20, 2020 at 03:38:27PM +0200, Thomas Bogendoerfer wrote:
> > > On Wed, May 20, 2020 at 03:12:01PM +0300, Serge Semin wrote:
> > > > Since you don't like the way I initially fixed it, suppose there we don't have
> > > > another way but to introduce something like CONFIG_MIPS_CPS_NS16550_WIDTH
> > > > parameter to select a proper accessors, like sw in our case, and sb by defaul).
> > > > Right?
> > > 
> > > to be on the safe side it's probably the best thing. But I don't know
> > > enough about CPS_NS16550 to judge whether shift value correlates with
> > > possible access width.
> > 
> > The base address passed to the _mips_cps_putc() leaf is UART-base address. It
> > has nothing to do with CPS. See:
> 
> ok, I'm confused. So this isn't an uart inside CPS hardware, but an uart used
> by CPS code for debug output, right ? 

Right. It's not CPS, but just UART available on the system. See a comment in the
arch/mips/kernel/cps-vec-ns16550.S:
/**
 * mips_cps_bev_dump() - dump relevant exception state to UART
 * @a0: pointer to NULL-terminated ASCII string naming the exception
 *
 * Write information that may be useful in debugging an exception to the
 * UART configured by CONFIG_MIPS_CPS_NS16550_*.
 *...
 */
LEAF(mips_cps_bev_dump)
        move            s0, ra
        move            s1, a0

        li              t9, CKSEG1ADDR(CONFIG_MIPS_CPS_NS16550_BASE)
        ...

See the base is just loaded to the t9 register.

> 
> To solve the issued please add CONFIG_MIPS_CPS_NS16550_WIDTH to select the
> correct access width.

Ok. Thanks.

-Sergey

> 
> Thomas.
> 
> -- 
> Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
> good idea.                                                [ RFC1925, 2.3 ]
