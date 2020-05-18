Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E97F1D7E8D
	for <lists+linux-pm@lfdr.de>; Mon, 18 May 2020 18:32:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727782AbgERQcX (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 18 May 2020 12:32:23 -0400
Received: from elvis.franken.de ([193.175.24.41]:58105 "EHLO elvis.franken.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726958AbgERQcX (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 18 May 2020 12:32:23 -0400
Received: from uucp (helo=alpha)
        by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
        id 1jaiga-0006ss-00; Mon, 18 May 2020 18:32:16 +0200
Received: by alpha.franken.de (Postfix, from userid 1000)
        id 8F3ACC010D; Mon, 18 May 2020 18:32:06 +0200 (CEST)
Date:   Mon, 18 May 2020 18:32:06 +0200
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
Message-ID: <20200518163206.GA17800@alpha.franken.de>
References: <20200306124807.3596F80307C2@mail.baikalelectronics.ru>
 <20200506174238.15385-1-Sergey.Semin@baikalelectronics.ru>
 <20200506174238.15385-19-Sergey.Semin@baikalelectronics.ru>
 <20200508154150.GB22247@alpha.franken.de>
 <20200511133121.cz5axbwynhmqkx7x@mobilestation>
 <20200515074827.6p5zx4sb3bmavjih@mobilestation>
 <20200515210647.GA22922@alpha.franken.de>
 <20200518134820.wedoumgbsllvhem6@mobilestation>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200518134820.wedoumgbsllvhem6@mobilestation>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, May 18, 2020 at 04:48:20PM +0300, Serge Semin wrote:
> On Fri, May 15, 2020 at 11:06:47PM +0200, Thomas Bogendoerfer wrote:
> > On Fri, May 15, 2020 at 10:48:27AM +0300, Serge Semin wrote:
> > > Thomas,
> > > Could you take a look at my comment below so I could proceed with the
> > > patchset v3 development?
> > 
> > I can't help, but using r4k clocksource with changing frequency is
> > probaly only usefull as a random generator. So IMHO the only two
> > options are disabling it or implement what arch/x86/kernel/tsc.c does.
> > 
> > Thomas.
> 
> Thomas, could you proceed with the rest of the patches review?
> ├─>[PATCH v2 16/20] bus: cdmm: Add MIPS R5 arch support
> ├─>[PATCH v2 15/20] mips: cdmm: Add mti,mips-cdmm dtb node support

both are not my call, but look ok to me.

> ├─>[PATCH v2 13/20] mips: early_printk_8250: Use offset-sized IO-mem accessors

that's broken. A reg shift of 2 doesn't mean we could use 32bit access
to the registers on other platforms. As I don't think adding some ifdefery
makes things nicer, just implement the your prom_putchar in board code.

> ├─>[PATCH v2 12/20] mips: MAAR: Add XPA mode support

looks ok so far.

> ├─>[PATCH v2 10/20] mips: Add CONFIG/CONFIG6/Cause reg fields macro

that is fine

> └─>[PATCH v2 09/20] mips: Add CP0 Write Merge config support

this is IMHO a dangerous change. Enabling write merging for any
CPU supporting it might triggers bugs. Do it in your board bringup
code and at the moment I don't see a reason for the rest of that
patch.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
