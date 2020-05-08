Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB5AC1CB07C
	for <lists+linux-pm@lfdr.de>; Fri,  8 May 2020 15:33:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728668AbgEHNbo (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 8 May 2020 09:31:44 -0400
Received: from elvis.franken.de ([193.175.24.41]:44851 "EHLO elvis.franken.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727975AbgEHNbo (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 8 May 2020 09:31:44 -0400
Received: from uucp (helo=alpha)
        by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
        id 1jX36M-0003ty-03; Fri, 08 May 2020 15:31:42 +0200
Received: by alpha.franken.de (Postfix, from userid 1000)
        id 9EAF3C041B; Fri,  8 May 2020 15:28:09 +0200 (CEST)
Date:   Fri, 8 May 2020 15:28:09 +0200
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     Sergey.Semin@baikalelectronics.ru
Cc:     Paul Burton <paulburton@kernel.org>,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Ralf Baechle <ralf@linux-mips.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Rob Herring <robh+dt@kernel.org>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 08/20] mips: Fix cpu_has_mips64r1/2 activation for
 MIPS32 CPUs
Message-ID: <20200508132809.GA15641@alpha.franken.de>
References: <20200306124807.3596F80307C2@mail.baikalelectronics.ru>
 <20200506174238.15385-1-Sergey.Semin@baikalelectronics.ru>
 <20200506174238.15385-9-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200506174238.15385-9-Sergey.Semin@baikalelectronics.ru>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, May 06, 2020 at 08:42:26PM +0300, Sergey.Semin@baikalelectronics.ru wrote:
> From: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> diff --git a/arch/mips/include/asm/cpu-features.h b/arch/mips/include/asm/cpu-features.h
> index e2f31bd6363b..7e22b9c1e279 100644
> --- a/arch/mips/include/asm/cpu-features.h
> +++ b/arch/mips/include/asm/cpu-features.h
> @@ -64,6 +64,8 @@
>  	((MIPS_ISA_REV >= (ge)) && (MIPS_ISA_REV < (lt)))
>  #define __isa_range_or_flag(ge, lt, flag) \
>  	(__isa_range(ge, lt) || ((MIPS_ISA_REV < (lt)) && __isa(flag)))
> +#define __isa_range_and_flag(ge, lt, flag) \
> +	(__isa_range(ge, lt) && __isa(flag))
>  
>  /*
>   * SMP assumption: Options of CPU 0 are a superset of all processors.
> @@ -291,10 +293,10 @@
>  # define cpu_has_mips32r6	__isa_ge_or_flag(6, MIPS_CPU_ISA_M32R6)
>  #endif
>  #ifndef cpu_has_mips64r1
> -# define cpu_has_mips64r1	__isa_range_or_flag(1, 6, MIPS_CPU_ISA_M64R1)
> +# define cpu_has_mips64r1	__isa_range_and_flag(1, 6, MIPS_CPU_ISA_M64R1)

that's not the correct fix. You want to check for cpu_has_64bits here.
Something like 

# define cpu_has_mips64r1    (cpu_has_64bits && __isa_range_or_flag(1, 6, MIPS_CPU_ISA_M64R1))

should do the trick.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
