Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1E011DBD0C
	for <lists+linux-pm@lfdr.de>; Wed, 20 May 2020 20:40:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726805AbgETSki (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 20 May 2020 14:40:38 -0400
Received: from elvis.franken.de ([193.175.24.41]:60593 "EHLO elvis.franken.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726548AbgETSkg (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 20 May 2020 14:40:36 -0400
Received: from uucp (helo=alpha)
        by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
        id 1jbTdq-0005JR-00; Wed, 20 May 2020 20:40:34 +0200
Received: by alpha.franken.de (Postfix, from userid 1000)
        id ABE3CC0153; Wed, 20 May 2020 20:30:57 +0200 (CEST)
Date:   Wed, 20 May 2020 20:30:57 +0200
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
Message-ID: <20200520183057.GA23855@alpha.franken.de>
References: <20200511133121.cz5axbwynhmqkx7x@mobilestation>
 <20200515074827.6p5zx4sb3bmavjih@mobilestation>
 <20200515210647.GA22922@alpha.franken.de>
 <20200518134820.wedoumgbsllvhem6@mobilestation>
 <20200518163206.GA17800@alpha.franken.de>
 <20200518205752.txbylbjt2zkwdwwe@mobilestation>
 <20200519155053.GB15797@alpha.franken.de>
 <20200520121201.wohv6u646rx5otkf@mobilestation>
 <20200520133827.GA17714@alpha.franken.de>
 <20200520134826.pc6si3k6boaexp4i@mobilestation>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200520134826.pc6si3k6boaexp4i@mobilestation>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, May 20, 2020 at 04:48:26PM +0300, Serge Semin wrote:
> On Wed, May 20, 2020 at 03:38:27PM +0200, Thomas Bogendoerfer wrote:
> > On Wed, May 20, 2020 at 03:12:01PM +0300, Serge Semin wrote:
> > > Since you don't like the way I initially fixed it, suppose there we don't have
> > > another way but to introduce something like CONFIG_MIPS_CPS_NS16550_WIDTH
> > > parameter to select a proper accessors, like sw in our case, and sb by defaul).
> > > Right?
> > 
> > to be on the safe side it's probably the best thing. But I don't know
> > enough about CPS_NS16550 to judge whether shift value correlates with
> > possible access width.
> 
> The base address passed to the _mips_cps_putc() leaf is UART-base address. It
> has nothing to do with CPS. See:

ok, I'm confused. So this isn't an uart inside CPS hardware, but an uart used
by CPS code for debug output, right ? 

To solve the issued please add CONFIG_MIPS_CPS_NS16550_WIDTH to select the
correct access width.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
