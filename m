Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EC0A1C88A9
	for <lists+linux-pm@lfdr.de>; Thu,  7 May 2020 13:44:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725903AbgEGLnh (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 7 May 2020 07:43:37 -0400
Received: from elvis.franken.de ([193.175.24.41]:43600 "EHLO elvis.franken.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726579AbgEGLnW (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 7 May 2020 07:43:22 -0400
Received: from uucp (helo=alpha)
        by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
        id 1jWevq-00081e-05; Thu, 07 May 2020 13:43:14 +0200
Received: by alpha.franken.de (Postfix, from userid 1000)
        id 89780C0409; Thu,  7 May 2020 13:17:35 +0200 (CEST)
Date:   Thu, 7 May 2020 13:17:35 +0200
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     Sergey.Semin@baikalelectronics.ru
Cc:     Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Paul Burton <paulburton@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Rob Herring <robh+dt@kernel.org>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Alexander Lobakin <alobakin@dlink.ru>,
        Huacai Chen <chenhc@lemote.com>,
        Cedric Hombourger <Cedric_Hombourger@mentor.com>,
        =?iso-8859-1?Q?Ren=E9?= van Dorst <opensource@vdorst.com>,
        Ard Biesheuvel <ardb@kernel.org>, Jessica Yu <jeyu@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 07/20] mips: Add MIPS Warrior P5600 support
Message-ID: <20200507111735.GF11616@alpha.franken.de>
References: <20200306124807.3596F80307C2@mail.baikalelectronics.ru>
 <20200506174238.15385-1-Sergey.Semin@baikalelectronics.ru>
 <20200506174238.15385-8-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200506174238.15385-8-Sergey.Semin@baikalelectronics.ru>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, May 06, 2020 at 08:42:25PM +0300, Sergey.Semin@baikalelectronics.ru wrote:
>  
> +config CPU_P5600
> +	bool "MIPS Warrior P5600"
> +	depends on SYS_HAS_CPU_P5600
> +	select CPU_HAS_PREFETCH
> +	select CPU_SUPPORTS_32BIT_KERNEL
> +	select CPU_SUPPORTS_HIGHMEM
> +	select CPU_SUPPORTS_MSA
> +	select CPU_SUPPORTS_UNCACHED_ACCELERATED
> +	select CPU_SUPPORTS_CPUFREQ
> +	select CPU_MIPSR2_IRQ_VI
> +	select CPU_MIPSR2_IRQ_EI
> +	select HAVE_KVM
> +	select MIPS_O32_FP64_SUPPORT
> +	help
> +	  Choose this option to build a kernel for MIPS Warrior P5600 CPU.
> +	  It's based on MIPS32r5 ISA with XPA, EVA, dual/quad issue exec pipes,
> +	  MMU with two-levels TLB, UCA, MSA, MDU core level features and system
> +	  level features like up to six P5600 calculation cores, CM2 with L2
> +	  cache, IOCU/IOMMU (though might be unused depending on the system-
> +	  specific IP core configuration), GIC, CPC, virtualisation module,
> +	  eJTAG and PDtrace.
> +
>  config CPU_R3000
>  	bool "R3000"
>  	depends on SYS_HAS_CPU_R3000
> @@ -1841,7 +1863,8 @@ endchoice
>  config CPU_MIPS32_3_5_FEATURES
>  	bool "MIPS32 Release 3.5 Features"
>  	depends on SYS_HAS_CPU_MIPS32_R3_5
> -	depends on CPU_MIPS32_R2 || CPU_MIPS32_R5 || CPU_MIPS32_R6
> +	depends on CPU_MIPS32_R2 || CPU_MIPS32_R5 || CPU_MIPS32_R6 || \
> +		   CPU_P5600
>  	help
>  	  Choose this option to build a kernel for release 2 or later of the
>  	  MIPS32 architecture including features from the 3.5 release such as
> @@ -1861,7 +1884,7 @@ config CPU_MIPS32_3_5_EVA
>  config CPU_MIPS32_R5_FEATURES
>  	bool "MIPS32 Release 5 Features"
>  	depends on SYS_HAS_CPU_MIPS32_R5
> -	depends on CPU_MIPS32_R2 || CPU_MIPS32_R5
> +	depends on CPU_MIPS32_R2 || CPU_MIPS32_R5 || CPU_P5600
>  	help
>  	  Choose this option to build a kernel for release 2 or later of the
>  	  MIPS32 architecture including features from release 5 such as
> @@ -2016,6 +2039,10 @@ config SYS_HAS_CPU_MIPS64_R6
>  	bool
>  	select ARCH_HAS_SYNC_DMA_FOR_CPU if DMA_NONCOHERENT
>  
> +config SYS_HAS_CPU_P5600
> +	bool
> +	select ARCH_HAS_SYNC_DMA_FOR_CPU if DMA_NONCOHERENT
> +

P5600 is CPU_MIPS_R5 so can't you select it here and drop all the || CPU_5600
above/below ?

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
