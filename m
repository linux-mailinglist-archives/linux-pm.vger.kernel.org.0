Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E2F41D7A54
	for <lists+linux-pm@lfdr.de>; Mon, 18 May 2020 15:48:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727823AbgERNsZ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 18 May 2020 09:48:25 -0400
Received: from mail.baikalelectronics.com ([87.245.175.226]:47810 "EHLO
        mail.baikalelectronics.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726800AbgERNsZ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 18 May 2020 09:48:25 -0400
Received: from localhost (unknown [127.0.0.1])
        by mail.baikalelectronics.ru (Postfix) with ESMTP id 354B1803080B;
        Mon, 18 May 2020 13:48:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at baikalelectronics.ru
Received: from mail.baikalelectronics.ru ([127.0.0.1])
        by localhost (mail.baikalelectronics.ru [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 1EWyMC3tE5jO; Mon, 18 May 2020 16:48:21 +0300 (MSK)
Date:   Mon, 18 May 2020 16:48:20 +0300
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
Message-ID: <20200518134820.wedoumgbsllvhem6@mobilestation>
References: <20200306124807.3596F80307C2@mail.baikalelectronics.ru>
 <20200506174238.15385-1-Sergey.Semin@baikalelectronics.ru>
 <20200506174238.15385-19-Sergey.Semin@baikalelectronics.ru>
 <20200508154150.GB22247@alpha.franken.de>
 <20200511133121.cz5axbwynhmqkx7x@mobilestation>
 <20200515074827.6p5zx4sb3bmavjih@mobilestation>
 <20200515210647.GA22922@alpha.franken.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200515210647.GA22922@alpha.franken.de>
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, May 15, 2020 at 11:06:47PM +0200, Thomas Bogendoerfer wrote:
> On Fri, May 15, 2020 at 10:48:27AM +0300, Serge Semin wrote:
> > Thomas,
> > Could you take a look at my comment below so I could proceed with the
> > patchset v3 development?
> 
> I can't help, but using r4k clocksource with changing frequency is
> probaly only usefull as a random generator. So IMHO the only two
> options are disabling it or implement what arch/x86/kernel/tsc.c does.
> 
> Thomas.

Thomas, could you proceed with the rest of the patches review?
├─>[PATCH v2 16/20] bus: cdmm: Add MIPS R5 arch support
├─>[PATCH v2 15/20] mips: cdmm: Add mti,mips-cdmm dtb node support
├─>[PATCH v2 13/20] mips: early_printk_8250: Use offset-sized IO-mem accessors
├─>[PATCH v2 12/20] mips: MAAR: Add XPA mode support
├─>[PATCH v2 10/20] mips: Add CONFIG/CONFIG6/Cause reg fields macro
└─>[PATCH v2 09/20] mips: Add CP0 Write Merge config support

It would be great if I fixed more comments in the next patchset version.

-Sergey

> 
> -- 
> Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
> good idea.                                                [ RFC1925, 2.3 ]
