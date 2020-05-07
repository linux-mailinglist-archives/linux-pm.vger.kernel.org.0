Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA1E81C9D1A
	for <lists+linux-pm@lfdr.de>; Thu,  7 May 2020 23:19:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726565AbgEGVTb (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 7 May 2020 17:19:31 -0400
Received: from mail.baikalelectronics.com ([87.245.175.226]:38566 "EHLO
        mail.baikalelectronics.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726531AbgEGVTa (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 7 May 2020 17:19:30 -0400
Received: from localhost (unknown [127.0.0.1])
        by mail.baikalelectronics.ru (Postfix) with ESMTP id 8EF3C803087C;
        Thu,  7 May 2020 21:19:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at baikalelectronics.ru
Received: from mail.baikalelectronics.ru ([127.0.0.1])
        by localhost (mail.baikalelectronics.ru [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id iD8rLD5BeSaP; Fri,  8 May 2020 00:19:26 +0300 (MSK)
Date:   Fri, 8 May 2020 00:19:23 +0300
From:   Serge Semin <Sergey.Semin@baikalelectronics.ru>
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>
CC:     Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Paul Burton <paulburton@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Rob Herring <robh+dt@kernel.org>, <linux-pm@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Alexander Lobakin <alobakin@dlink.ru>,
        Huacai Chen <chenhc@lemote.com>,
        Cedric Hombourger <Cedric_Hombourger@mentor.com>,
        =?utf-8?B?UmVuw6k=?= van Dorst <opensource@vdorst.com>,
        Ard Biesheuvel <ardb@kernel.org>, Jessica Yu <jeyu@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        <linux-mips@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 07/20] mips: Add MIPS Warrior P5600 support
Message-ID: <20200507211923.kfu2ly3ncqms4c2u@mobilestation>
References: <20200306124807.3596F80307C2@mail.baikalelectronics.ru>
 <20200506174238.15385-1-Sergey.Semin@baikalelectronics.ru>
 <20200506174238.15385-8-Sergey.Semin@baikalelectronics.ru>
 <20200507111735.GF11616@alpha.franken.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200507111735.GF11616@alpha.franken.de>
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, May 07, 2020 at 01:17:35PM +0200, Thomas Bogendoerfer wrote:
> On Wed, May 06, 2020 at 08:42:25PM +0300, Sergey.Semin@baikalelectronics.ru wrote:
> >  
> > +config CPU_P5600
> > +	bool "MIPS Warrior P5600"
> > +	depends on SYS_HAS_CPU_P5600
> > +	select CPU_HAS_PREFETCH
> > +	select CPU_SUPPORTS_32BIT_KERNEL
> > +	select CPU_SUPPORTS_HIGHMEM
> > +	select CPU_SUPPORTS_MSA
> > +	select CPU_SUPPORTS_UNCACHED_ACCELERATED
> > +	select CPU_SUPPORTS_CPUFREQ
> > +	select CPU_MIPSR2_IRQ_VI
> > +	select CPU_MIPSR2_IRQ_EI
> > +	select HAVE_KVM
> > +	select MIPS_O32_FP64_SUPPORT
> > +	help
> > +	  Choose this option to build a kernel for MIPS Warrior P5600 CPU.
> > +	  It's based on MIPS32r5 ISA with XPA, EVA, dual/quad issue exec pipes,
> > +	  MMU with two-levels TLB, UCA, MSA, MDU core level features and system
> > +	  level features like up to six P5600 calculation cores, CM2 with L2
> > +	  cache, IOCU/IOMMU (though might be unused depending on the system-
> > +	  specific IP core configuration), GIC, CPC, virtualisation module,
> > +	  eJTAG and PDtrace.
> > +
> >  config CPU_R3000
> >  	bool "R3000"
> >  	depends on SYS_HAS_CPU_R3000
> > @@ -1841,7 +1863,8 @@ endchoice
> >  config CPU_MIPS32_3_5_FEATURES
> >  	bool "MIPS32 Release 3.5 Features"
> >  	depends on SYS_HAS_CPU_MIPS32_R3_5
> > -	depends on CPU_MIPS32_R2 || CPU_MIPS32_R5 || CPU_MIPS32_R6
> > +	depends on CPU_MIPS32_R2 || CPU_MIPS32_R5 || CPU_MIPS32_R6 || \
> > +		   CPU_P5600
> >  	help
> >  	  Choose this option to build a kernel for release 2 or later of the
> >  	  MIPS32 architecture including features from the 3.5 release such as
> > @@ -1861,7 +1884,7 @@ config CPU_MIPS32_3_5_EVA
> >  config CPU_MIPS32_R5_FEATURES
> >  	bool "MIPS32 Release 5 Features"
> >  	depends on SYS_HAS_CPU_MIPS32_R5
> > -	depends on CPU_MIPS32_R2 || CPU_MIPS32_R5
> > +	depends on CPU_MIPS32_R2 || CPU_MIPS32_R5 || CPU_P5600
> >  	help
> >  	  Choose this option to build a kernel for release 2 or later of the
> >  	  MIPS32 architecture including features from release 5 such as
> > @@ -2016,6 +2039,10 @@ config SYS_HAS_CPU_MIPS64_R6
> >  	bool
> >  	select ARCH_HAS_SYNC_DMA_FOR_CPU if DMA_NONCOHERENT
> >  
> > +config SYS_HAS_CPU_P5600
> > +	bool
> > +	select ARCH_HAS_SYNC_DMA_FOR_CPU if DMA_NONCOHERENT
> > +
> 
> P5600 is CPU_MIPS_R5 so can't you select it here and drop all the || CPU_5600
> above/below ?

Alas, We can't do this so easy. CONFIG_CPU_MIPS32_{R2,R5,R6} and any other
CONFIG_CPU_* configs is something that kernel config-file is supposed to select.
Their availability is enabled by the CONFIG_SYS_HAS_CPU_* configs. CONFIG_CPU_*
is supposed to activate CPU-specific features and there is only one
CONFIG_CPU_x can be enabled at a time seeing it's a part of the "CPU type"
choice kconfig menu. In addition the CPU config also tunes a compiler to activate
the arch-specific ISA and optimizations in the arch/mips/Makefile by setting
-march=cpu-name (where cpu-name can be p5600, mips32r5, etc).

Yes, P5600 is based on the MIPS32r5, but it also has got some specific features
(see config CPU_P5600 and config MIPS32_R5), which makes it to be different from
the ancestor. So In addition to the difficulties described above IMHO converting
CPU_P5600 to a set of features activated on top of the CPU_MIPS32_R5 config
would contradict the design of the CPU-support configs implemented in the MIPS
arch subsystem.

-Sergey

> 
> Thomas.
> 
> -- 
> Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
> good idea.                                                [ RFC1925, 2.3 ]
