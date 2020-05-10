Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9AD891CCED0
	for <lists+linux-pm@lfdr.de>; Mon, 11 May 2020 02:00:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729208AbgEJX7r (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 10 May 2020 19:59:47 -0400
Received: from mail.baikalelectronics.com ([87.245.175.226]:47676 "EHLO
        mail.baikalelectronics.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729078AbgEJX7r (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 10 May 2020 19:59:47 -0400
Received: from localhost (unknown [127.0.0.1])
        by mail.baikalelectronics.ru (Postfix) with ESMTP id 0AB0C803088B;
        Sun, 10 May 2020 23:59:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at baikalelectronics.ru
Received: from mail.baikalelectronics.ru ([127.0.0.1])
        by localhost (mail.baikalelectronics.ru [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id okmZ8RUkSoro; Mon, 11 May 2020 02:59:43 +0300 (MSK)
Date:   Mon, 11 May 2020 02:59:42 +0300
From:   Serge Semin <Sergey.Semin@baikalelectronics.ru>
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>
CC:     Serge Semin <fancer.lancer@gmail.com>,
        Paul Burton <paulburton@kernel.org>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Ralf Baechle <ralf@linux-mips.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Rob Herring <robh+dt@kernel.org>, <linux-pm@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
        <linux-mips@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 08/20] mips: Fix cpu_has_mips64r1/2 activation for
 MIPS32 CPUs
Message-ID: <20200510235942.msznsepuaww7gj2c@mobilestation>
References: <20200306124807.3596F80307C2@mail.baikalelectronics.ru>
 <20200506174238.15385-1-Sergey.Semin@baikalelectronics.ru>
 <20200506174238.15385-9-Sergey.Semin@baikalelectronics.ru>
 <20200508132809.GA15641@alpha.franken.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200508132809.GA15641@alpha.franken.de>
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, May 08, 2020 at 03:28:09PM +0200, Thomas Bogendoerfer wrote:
> On Wed, May 06, 2020 at 08:42:26PM +0300, Sergey.Semin@baikalelectronics.ru wrote:
> > From: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> > diff --git a/arch/mips/include/asm/cpu-features.h b/arch/mips/include/asm/cpu-features.h
> > index e2f31bd6363b..7e22b9c1e279 100644
> > --- a/arch/mips/include/asm/cpu-features.h
> > +++ b/arch/mips/include/asm/cpu-features.h
> > @@ -64,6 +64,8 @@
> >  	((MIPS_ISA_REV >= (ge)) && (MIPS_ISA_REV < (lt)))
> >  #define __isa_range_or_flag(ge, lt, flag) \
> >  	(__isa_range(ge, lt) || ((MIPS_ISA_REV < (lt)) && __isa(flag)))
> > +#define __isa_range_and_flag(ge, lt, flag) \
> > +	(__isa_range(ge, lt) && __isa(flag))
> >  
> >  /*
> >   * SMP assumption: Options of CPU 0 are a superset of all processors.
> > @@ -291,10 +293,10 @@
> >  # define cpu_has_mips32r6	__isa_ge_or_flag(6, MIPS_CPU_ISA_M32R6)
> >  #endif
> >  #ifndef cpu_has_mips64r1
> > -# define cpu_has_mips64r1	__isa_range_or_flag(1, 6, MIPS_CPU_ISA_M64R1)
> > +# define cpu_has_mips64r1	__isa_range_and_flag(1, 6, MIPS_CPU_ISA_M64R1)
> 
> that's not the correct fix. You want to check for cpu_has_64bits here.
> Something like 
> 
> # define cpu_has_mips64r1    (cpu_has_64bits && __isa_range_or_flag(1, 6, MIPS_CPU_ISA_M64R1))
> 
> should do the trick.

Good point. Thanks. I'll fix it in v3.

-Sergey

> 
> Thomas.
> 
> -- 
> Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
> good idea.                                                [ RFC1925, 2.3 ]
