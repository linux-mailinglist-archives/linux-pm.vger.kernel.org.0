Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 369631DB58C
	for <lists+linux-pm@lfdr.de>; Wed, 20 May 2020 15:48:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726804AbgETNsd (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 20 May 2020 09:48:33 -0400
Received: from mail.baikalelectronics.com ([87.245.175.226]:59090 "EHLO
        mail.baikalelectronics.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726691AbgETNsc (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 20 May 2020 09:48:32 -0400
Received: from localhost (unknown [127.0.0.1])
        by mail.baikalelectronics.ru (Postfix) with ESMTP id BE2DE8030875;
        Wed, 20 May 2020 13:48:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at baikalelectronics.ru
Received: from mail.baikalelectronics.ru ([127.0.0.1])
        by localhost (mail.baikalelectronics.ru [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 879XwsdEpqBa; Wed, 20 May 2020 16:48:28 +0300 (MSK)
Date:   Wed, 20 May 2020 16:48:26 +0300
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
Message-ID: <20200520134826.pc6si3k6boaexp4i@mobilestation>
References: <20200508154150.GB22247@alpha.franken.de>
 <20200511133121.cz5axbwynhmqkx7x@mobilestation>
 <20200515074827.6p5zx4sb3bmavjih@mobilestation>
 <20200515210647.GA22922@alpha.franken.de>
 <20200518134820.wedoumgbsllvhem6@mobilestation>
 <20200518163206.GA17800@alpha.franken.de>
 <20200518205752.txbylbjt2zkwdwwe@mobilestation>
 <20200519155053.GB15797@alpha.franken.de>
 <20200520121201.wohv6u646rx5otkf@mobilestation>
 <20200520133827.GA17714@alpha.franken.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200520133827.GA17714@alpha.franken.de>
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, May 20, 2020 at 03:38:27PM +0200, Thomas Bogendoerfer wrote:
> On Wed, May 20, 2020 at 03:12:01PM +0300, Serge Semin wrote:
> > Since you don't like the way I initially fixed it, suppose there we don't have
> > another way but to introduce something like CONFIG_MIPS_CPS_NS16550_WIDTH
> > parameter to select a proper accessors, like sw in our case, and sb by defaul).
> > Right?
> 
> to be on the safe side it's probably the best thing. But I don't know
> enough about CPS_NS16550 to judge whether shift value correlates with
> possible access width.

The base address passed to the _mips_cps_putc() leaf is UART-base address. It
has nothing to do with CPS. See:
/**
 * _mips_cps_putc() - write a character to the UART
 * @a0: ASCII character to write
 * @t9: UART base address
 */
LEAF(_mips_cps_putc)
1:      lw              t0, UART_LSR_OFS(t9)
        andi            t0, t0, UART_LSR_TEMT
        beqz            t0, 1b
        sb              a0, UART_TX_OFS(t9)
        jr              ra
        END(_mips_cps_putc)

So it's base address must be accessed with proper alignment. On our case it's
lw/sw instructions. Regarding using lw in the first line of the function. That's
must be a bug, since further in the same function they use sb to access the UART
Tx register. So reading a data from UART_LSR register should be also byte-sized
by using lb.

-Sergey

> 
> Thomas.
> 
> -- 
> Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
> good idea.                                                [ RFC1925, 2.3 ]
