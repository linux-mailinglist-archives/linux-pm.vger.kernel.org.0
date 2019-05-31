Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6B5DE30A40
	for <lists+linux-pm@lfdr.de>; Fri, 31 May 2019 10:26:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726874AbfEaI0l (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 31 May 2019 04:26:41 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:44708 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726240AbfEaI0k (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 31 May 2019 04:26:40 -0400
Received: from 79.184.255.225.ipv4.supernova.orange.pl (79.184.255.225) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.213)
 id 839ca75bcd552a6f; Fri, 31 May 2019 10:26:38 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Jiri Kosina <jikos@kernel.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        the arch/x86 maintainers <x86@kernel.org>,
        Pavel Machek <pavel@ucw.cz>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>
Subject: Re: [PATCH v4] x86/power: Fix 'nosmt' vs. hibernation triple fault during resume
Date:   Fri, 31 May 2019 10:26:37 +0200
Message-ID: <1639292.WxYr0VA4et@kreacher>
In-Reply-To: <20190531051456.fzkvn62qlkf6wqra@treble>
References: <nycvar.YFH.7.76.1905282326360.1962@cbobk.fhfr.pm> <nycvar.YFH.7.76.1905310139380.1962@cbobk.fhfr.pm> <20190531051456.fzkvn62qlkf6wqra@treble>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Friday, May 31, 2019 7:14:56 AM CEST Josh Poimboeuf wrote:
> On Fri, May 31, 2019 at 01:42:02AM +0200, Jiri Kosina wrote:
> > On Thu, 30 May 2019, Josh Poimboeuf wrote:
> > 
> > > > >     Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
> > > > 
> > > > Yes, it is, thanks!
> > > 
> > > I still think changing monitor/mwait to use a fixmap address would be a
> > > much cleaner way to fix this.  I can try to work up a patch tomorrow.
> > 
> > I disagree with that from the backwards compatibility point of view.
> > 
> > I personally am quite frequently using differnet combinations of 
> > resumer/resumee kernels, and I've never been biten by it so far. I'd guess 
> > I am not the only one.
> > Fixmap sort of breaks that invariant.
> 
> Right now there is no backwards compatibility because nosmt resume is
> already broken.
> 
> For "future" backwards compatibility we could just define a hard-coded
> reserved fixmap page address, adjacent to the vsyscall reserved address.
> 
> Something like this (not yet tested)?  Maybe we could also remove the
> resume_play_dead() hack?

Yes, we can IMO, but in a separate patch, please.

> diff --git a/arch/x86/include/asm/fixmap.h b/arch/x86/include/asm/fixmap.h
> index 9da8cccdf3fb..1c328624162c 100644
> --- a/arch/x86/include/asm/fixmap.h
> +++ b/arch/x86/include/asm/fixmap.h
> @@ -80,6 +80,7 @@ enum fixed_addresses {
>  #ifdef CONFIG_X86_VSYSCALL_EMULATION
>  	VSYSCALL_PAGE = (FIXADDR_TOP - VSYSCALL_ADDR) >> PAGE_SHIFT,
>  #endif
> +	FIX_MWAIT = (FIXADDR_TOP - VSYSCALL_ADDR - 1) >> PAGE_SHIFT,
>  #endif
>  	FIX_DBGP_BASE,
>  	FIX_EARLYCON_MEM_BASE,
> diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
> index 73e69aaaa117..9804fbe25d03 100644
> --- a/arch/x86/kernel/smpboot.c
> +++ b/arch/x86/kernel/smpboot.c
> @@ -108,6 +108,8 @@ int __read_mostly __max_smt_threads = 1;
>  /* Flag to indicate if a complete sched domain rebuild is required */
>  bool x86_topology_update;
>  
> +static char __mwait_page[PAGE_SIZE];
> +
>  int arch_update_cpu_topology(void)
>  {
>  	int retval = x86_topology_update;
> @@ -1319,6 +1321,8 @@ void __init native_smp_prepare_cpus(unsigned int max_cpus)
>  	smp_quirk_init_udelay();
>  
>  	speculative_store_bypass_ht_init();
> +
> +	set_fixmap(FIX_MWAIT, __pa_symbol(&__mwait_page));
>  }
>  
>  void arch_enable_nonboot_cpus_begin(void)
> @@ -1631,11 +1635,12 @@ static inline void mwait_play_dead(void)
>  	}
>  
>  	/*
> -	 * This should be a memory location in a cache line which is
> -	 * unlikely to be touched by other processors.  The actual
> -	 * content is immaterial as it is not actually modified in any way.
> +	 * This memory location is never actually written to.  It's mapped at a
> +	 * reserved fixmap address to ensure the monitored address remains
> +	 * valid across a hibernation resume operation.  Otherwise a triple
> +	 * fault can occur.
>  	 */
> -	mwait_ptr = &current_thread_info()->flags;
> +	mwait_ptr = (void *)fix_to_virt(FIX_MWAIT);
>  
>  	wbinvd();
>  
> 

Jiri, any chance to test this?



