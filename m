Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E13B1DB1C8
	for <lists+linux-pm@lfdr.de>; Wed, 20 May 2020 13:31:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726510AbgETLbI (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 20 May 2020 07:31:08 -0400
Received: from mail.baikalelectronics.com ([87.245.175.226]:57970 "EHLO
        mail.baikalelectronics.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726224AbgETLbH (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 20 May 2020 07:31:07 -0400
Received: from localhost (unknown [127.0.0.1])
        by mail.baikalelectronics.ru (Postfix) with ESMTP id 2D97180307C1;
        Wed, 20 May 2020 11:31:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at baikalelectronics.ru
Received: from mail.baikalelectronics.ru ([127.0.0.1])
        by localhost (mail.baikalelectronics.ru [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id yGC09t4w11r0; Wed, 20 May 2020 14:31:00 +0300 (MSK)
Date:   Wed, 20 May 2020 14:30:58 +0300
From:   Serge Semin <Sergey.Semin@baikalelectronics.ru>
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>
CC:     Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Paul Burton <paulburton@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Rob Herring <robh+dt@kernel.org>, <linux-pm@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Allison Randal <allison@lohutok.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Zhou Yanjie <zhouyanjie@zoho.com>,
        Paul Cercueil <paul@crapouillou.net>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        <linux-mips@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 12/20] mips: MAAR: Add XPA mode support
Message-ID: <20200520113058.nd7fsafrbhdcp2c7@mobilestation>
References: <20200306124807.3596F80307C2@mail.baikalelectronics.ru>
 <20200506174238.15385-1-Sergey.Semin@baikalelectronics.ru>
 <20200506174238.15385-13-Sergey.Semin@baikalelectronics.ru>
 <20200519154213.GA15797@alpha.franken.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200519154213.GA15797@alpha.franken.de>
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, May 19, 2020 at 05:42:13PM +0200, Thomas Bogendoerfer wrote:
> On Wed, May 06, 2020 at 08:42:30PM +0300, Sergey.Semin@baikalelectronics.ru wrote:
> > From: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> > 
> > When XPA mode is enabled the normally 32-bits MAAR pair registers
> > are extended to be of 64-bits width as in pure 64-bits MIPS
> > architecture. In this case the MAAR registers can enable the
> > speculative loads/stores for addresses of up to 39-bits width.
> > But in this case the process of the MAAR initialization changes a bit.
> > The upper 32-bits of the registers are supposed to be accessed by mean
> > of the dedicated instructions mfhc0/mthc0 and there is a CP0.MAAR.VH
> > bit which should be set together with CP0.MAAR.VL as indication
> > of the boundary validity. All of these peculiarities were taken into
> > account in this commit so the speculative loads/stores would work
> > when XPA mode is enabled.
> > 
> > Co-developed-by: Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>
> > Signed-off-by: Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>
> > Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> > Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
> > Cc: Paul Burton <paulburton@kernel.org>
> > Cc: Ralf Baechle <ralf@linux-mips.org>
> > Cc: Arnd Bergmann <arnd@arndb.de>
> > Cc: Rob Herring <robh+dt@kernel.org>
> > Cc: linux-pm@vger.kernel.org
> > Cc: devicetree@vger.kernel.org
> > ---
> >  arch/mips/include/asm/maar.h     | 17 +++++++++++++++--
> >  arch/mips/include/asm/mipsregs.h | 10 ++++++++++
> >  arch/mips/mm/init.c              |  8 +++++++-
> >  3 files changed, 32 insertions(+), 3 deletions(-)
> 
> applied to mips-next.

Great! Thanks.

-Sergey

> 
> Thomas.
> 
> -- 
> Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
> good idea.                                                [ RFC1925, 2.3 ]
