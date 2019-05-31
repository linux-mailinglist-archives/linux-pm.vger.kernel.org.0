Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0B47931099
	for <lists+linux-pm@lfdr.de>; Fri, 31 May 2019 16:51:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726418AbfEaOv2 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 31 May 2019 10:51:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:41590 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726037AbfEaOv2 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 31 May 2019 10:51:28 -0400
Received: from pobox.suse.cz (prg-ext-pat.suse.com [213.151.95.130])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6E75D26B05;
        Fri, 31 May 2019 14:51:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559314287;
        bh=791bm7XMFp0foBsIcF2oS0fUFQH8SYTCapQ5fJHir8M=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=yFRwOxGvBGlmhGuP2+vkqqBtPsDlqWg0tpQzAjtqdWOVG0Y4nOG7oEZHTvMmqyR4q
         z2J+ImwfhOWxQ78VBiLkH0S8trvEYBg2qeT/9rhOgvLCpjR7jAG0+/zrpsGZFGRH2w
         14m3+Ni1d4eTHO6rECYj7oodMhErf5+nk6UJ3CWY=
Date:   Fri, 31 May 2019 16:51:23 +0200 (CEST)
From:   Jiri Kosina <jikos@kernel.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        the arch/x86 maintainers <x86@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Pavel Machek <pavel@ucw.cz>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>
Subject: Re: [PATCH v4] x86/power: Fix 'nosmt' vs. hibernation triple fault
 during resume
In-Reply-To: <20190531051456.fzkvn62qlkf6wqra@treble>
Message-ID: <nycvar.YFH.7.76.1905311644550.1962@cbobk.fhfr.pm>
References: <nycvar.YFH.7.76.1905282326360.1962@cbobk.fhfr.pm> <nycvar.YFH.7.76.1905300007470.1962@cbobk.fhfr.pm> <CAJZ5v0ja5sQ73zMvUtV+w79LC_d+g6UdomL36rV-EpVDxEzbhA@mail.gmail.com> <alpine.DEB.2.21.1905301425330.2265@nanos.tec.linutronix.de>
 <CAJZ5v0go1g9KhE=mc19VCFrBuEERzFZCoRD4xt=tF=EnMjfH=A@mail.gmail.com> <20190530233804.syv4brpe3ndslyvo@treble> <nycvar.YFH.7.76.1905310139380.1962@cbobk.fhfr.pm> <20190531051456.fzkvn62qlkf6wqra@treble>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, 31 May 2019, Josh Poimboeuf wrote:

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

Looking into SDM:

=====
A store to the address range armed by the MONITOR instruction, an 
interrupt, an NMI or SMI, a debug exception, a machine check exception, 
the BINIT# signal, the INIT# signal, or the RESET# signal will exit the 
implementation-dependent-optimized state.
=====

And mwait doesn't have the 'auto-restart on SMM exit' like hlt does. So I 
guess that's why I am seeing the triple faults even with your (fixed, see 
below) patch as well.

So I don't think we can safely use this aproach.

> 
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

This needs to be __align(PAGE_SIZE) in order for the fixmap to work 
properly.

-- 
Jiri Kosina
SUSE Labs

