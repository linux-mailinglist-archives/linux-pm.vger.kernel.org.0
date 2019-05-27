Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E0B382B285
	for <lists+linux-pm@lfdr.de>; Mon, 27 May 2019 12:53:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726668AbfE0Kxp (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 27 May 2019 06:53:45 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:63322 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726476AbfE0Kxo (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 27 May 2019 06:53:44 -0400
Received: from 79.184.255.36.ipv4.supernova.orange.pl (79.184.255.36) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.213)
 id 3e9dcd1393346651; Mon, 27 May 2019 12:53:42 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Mathieu Malaterre <malat@debian.org>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v2] powerpc/power: Expose pfn_is_nosave prototype
Date:   Mon, 27 May 2019 12:53:41 +0200
Message-ID: <1929721.iDiXxTFbjN@kreacher>
In-Reply-To: <20190524104418.17194-1-malat@debian.org>
References: <20190523114736.30268-1-malat@debian.org> <20190524104418.17194-1-malat@debian.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Friday, May 24, 2019 12:44:18 PM CEST Mathieu Malaterre wrote:
> The declaration for pfn_is_nosave is only available in
> kernel/power/power.h. Since this function can be override in arch,
> expose it globally. Having a prototype will make sure to avoid warning
> (sometime treated as error with W=1) such as:
> 
>   arch/powerpc/kernel/suspend.c:18:5: error: no previous prototype for 'pfn_is_nosave' [-Werror=missing-prototypes]
> 
> This moves the declaration into a globally visible header file and add
> missing include to avoid a warning on powerpc. Also remove the
> duplicated prototypes since not required anymore.
> 
> Cc: Christophe Leroy <christophe.leroy@c-s.fr>
> Signed-off-by: Mathieu Malaterre <malat@debian.org>
> ---
> v2: As suggestion by christophe remove duplicates prototypes
> 
>  arch/powerpc/kernel/suspend.c | 1 +
>  arch/s390/kernel/entry.h      | 1 -
>  include/linux/suspend.h       | 1 +
>  kernel/power/power.h          | 2 --
>  4 files changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/powerpc/kernel/suspend.c b/arch/powerpc/kernel/suspend.c
> index a531154cc0f3..9e1b6b894245 100644
> --- a/arch/powerpc/kernel/suspend.c
> +++ b/arch/powerpc/kernel/suspend.c
> @@ -8,6 +8,7 @@
>   */
>  
>  #include <linux/mm.h>
> +#include <linux/suspend.h>
>  #include <asm/page.h>
>  #include <asm/sections.h>
>  
> diff --git a/arch/s390/kernel/entry.h b/arch/s390/kernel/entry.h
> index 20420c2b8a14..b2956d49b6ad 100644
> --- a/arch/s390/kernel/entry.h
> +++ b/arch/s390/kernel/entry.h
> @@ -63,7 +63,6 @@ void __init startup_init(void);
>  void die(struct pt_regs *regs, const char *str);
>  int setup_profiling_timer(unsigned int multiplier);
>  void __init time_init(void);
> -int pfn_is_nosave(unsigned long);
>  void s390_early_resume(void);
>  unsigned long prepare_ftrace_return(unsigned long parent, unsigned long sp, unsigned long ip);
>  
> diff --git a/include/linux/suspend.h b/include/linux/suspend.h
> index 6b3ea9ea6a9e..e8b8a7bede90 100644
> --- a/include/linux/suspend.h
> +++ b/include/linux/suspend.h
> @@ -395,6 +395,7 @@ extern bool system_entering_hibernation(void);
>  extern bool hibernation_available(void);
>  asmlinkage int swsusp_save(void);
>  extern struct pbe *restore_pblist;
> +int pfn_is_nosave(unsigned long pfn);
>  #else /* CONFIG_HIBERNATION */
>  static inline void register_nosave_region(unsigned long b, unsigned long e) {}
>  static inline void register_nosave_region_late(unsigned long b, unsigned long e) {}
> diff --git a/kernel/power/power.h b/kernel/power/power.h
> index 9e58bdc8a562..44bee462ff57 100644
> --- a/kernel/power/power.h
> +++ b/kernel/power/power.h
> @@ -75,8 +75,6 @@ static inline void hibernate_reserved_size_init(void) {}
>  static inline void hibernate_image_size_init(void) {}
>  #endif /* !CONFIG_HIBERNATION */
>  
> -extern int pfn_is_nosave(unsigned long);
> -
>  #define power_attr(_name) \
>  static struct kobj_attribute _name##_attr = {	\
>  	.attr	= {				\
> 

With an ACK from the powerpc maintainers, I could apply this one.




