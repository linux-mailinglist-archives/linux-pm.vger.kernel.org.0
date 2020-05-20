Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CE781DC106
	for <lists+linux-pm@lfdr.de>; Wed, 20 May 2020 23:13:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728117AbgETVNO (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 20 May 2020 17:13:14 -0400
Received: from mail.baikalelectronics.com ([87.245.175.226]:60824 "EHLO
        mail.baikalelectronics.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727018AbgETVNO (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 20 May 2020 17:13:14 -0400
Received: from localhost (unknown [127.0.0.1])
        by mail.baikalelectronics.ru (Postfix) with ESMTP id DFFF580307C1;
        Wed, 20 May 2020 21:13:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at baikalelectronics.ru
Received: from mail.baikalelectronics.ru ([127.0.0.1])
        by localhost (mail.baikalelectronics.ru [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id vhE8g358omkw; Thu, 21 May 2020 00:13:10 +0300 (MSK)
Date:   Thu, 21 May 2020 00:13:09 +0300
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
Message-ID: <20200520211309.y4phl4unnkbvztfe@mobilestation>
References: <20200508154150.GB22247@alpha.franken.de>
 <20200511133121.cz5axbwynhmqkx7x@mobilestation>
 <20200515074827.6p5zx4sb3bmavjih@mobilestation>
 <20200515210647.GA22922@alpha.franken.de>
 <20200518134820.wedoumgbsllvhem6@mobilestation>
 <20200518163206.GA17800@alpha.franken.de>
 <20200518205752.txbylbjt2zkwdwwe@mobilestation>
 <20200519155053.GB15797@alpha.franken.de>
 <20200520115926.lk6ycke75flwzcd2@mobilestation>
 <20200520184024.GB23855@alpha.franken.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200520184024.GB23855@alpha.franken.de>
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, May 20, 2020 at 08:40:24PM +0200, Thomas Bogendoerfer wrote:
> On Wed, May 20, 2020 at 02:59:26PM +0300, Serge Semin wrote:
> > I think there is a misunderstanding here. In this patch I am not enabling
> 
> you are right, I've missed the fact, that this also needs to be enabled
> in TLB entries. Strange that MIPS added the enable bit while R10k simply
> do uncached acclerated, whenever TLB entry selects it.
> 
> > If there is no misunderstanding and you said what you said, that even enabling
> > the feature for utilization might be dangerous, let's at least leave the
> > MIPS_CONF_MM, MIPS_CONF_MM_FULL and MIPS_CONF_MM_SYS_SYSAD fields
> > definition in the "arch/mips/include/asm/mipsregs.h" header. I'll use
> > them to enable the write-merge in my platform code.
> > 
> > What do you think?
> 
> I withdraw my concerns and will apply the patch as is.

Great! Thanks.

-Sergey

> 
> Thomas.
> 
> -- 
> Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
> good idea.                                                [ RFC1925, 2.3 ]
