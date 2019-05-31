Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3509830808
	for <lists+linux-pm@lfdr.de>; Fri, 31 May 2019 07:15:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726002AbfEaFPC (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 31 May 2019 01:15:02 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33948 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725955AbfEaFPC (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 31 May 2019 01:15:02 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 8824D30832C2;
        Fri, 31 May 2019 05:15:01 +0000 (UTC)
Received: from treble (ovpn-124-142.rdu2.redhat.com [10.10.124.142])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id DB2EA60CA7;
        Fri, 31 May 2019 05:14:58 +0000 (UTC)
Date:   Fri, 31 May 2019 00:14:56 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Jiri Kosina <jikos@kernel.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
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
Message-ID: <20190531051456.fzkvn62qlkf6wqra@treble>
References: <nycvar.YFH.7.76.1905282326360.1962@cbobk.fhfr.pm>
 <nycvar.YFH.7.76.1905300007470.1962@cbobk.fhfr.pm>
 <CAJZ5v0ja5sQ73zMvUtV+w79LC_d+g6UdomL36rV-EpVDxEzbhA@mail.gmail.com>
 <alpine.DEB.2.21.1905301425330.2265@nanos.tec.linutronix.de>
 <CAJZ5v0go1g9KhE=mc19VCFrBuEERzFZCoRD4xt=tF=EnMjfH=A@mail.gmail.com>
 <20190530233804.syv4brpe3ndslyvo@treble>
 <nycvar.YFH.7.76.1905310139380.1962@cbobk.fhfr.pm>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <nycvar.YFH.7.76.1905310139380.1962@cbobk.fhfr.pm>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.44]); Fri, 31 May 2019 05:15:01 +0000 (UTC)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, May 31, 2019 at 01:42:02AM +0200, Jiri Kosina wrote:
> On Thu, 30 May 2019, Josh Poimboeuf wrote:
> 
> > > >     Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
> > > 
> > > Yes, it is, thanks!
> > 
> > I still think changing monitor/mwait to use a fixmap address would be a
> > much cleaner way to fix this.  I can try to work up a patch tomorrow.
> 
> I disagree with that from the backwards compatibility point of view.
> 
> I personally am quite frequently using differnet combinations of 
> resumer/resumee kernels, and I've never been biten by it so far. I'd guess 
> I am not the only one.
> Fixmap sort of breaks that invariant.

Right now there is no backwards compatibility because nosmt resume is
already broken.

For "future" backwards compatibility we could just define a hard-coded
reserved fixmap page address, adjacent to the vsyscall reserved address.

Something like this (not yet tested)?  Maybe we could also remove the
resume_play_dead() hack?

diff --git a/arch/x86/include/asm/fixmap.h b/arch/x86/include/asm/fixmap.h
index 9da8cccdf3fb..1c328624162c 100644
--- a/arch/x86/include/asm/fixmap.h
+++ b/arch/x86/include/asm/fixmap.h
@@ -80,6 +80,7 @@ enum fixed_addresses {
 #ifdef CONFIG_X86_VSYSCALL_EMULATION
 	VSYSCALL_PAGE = (FIXADDR_TOP - VSYSCALL_ADDR) >> PAGE_SHIFT,
 #endif
+	FIX_MWAIT = (FIXADDR_TOP - VSYSCALL_ADDR - 1) >> PAGE_SHIFT,
 #endif
 	FIX_DBGP_BASE,
 	FIX_EARLYCON_MEM_BASE,
diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index 73e69aaaa117..9804fbe25d03 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -108,6 +108,8 @@ int __read_mostly __max_smt_threads = 1;
 /* Flag to indicate if a complete sched domain rebuild is required */
 bool x86_topology_update;
 
+static char __mwait_page[PAGE_SIZE];
+
 int arch_update_cpu_topology(void)
 {
 	int retval = x86_topology_update;
@@ -1319,6 +1321,8 @@ void __init native_smp_prepare_cpus(unsigned int max_cpus)
 	smp_quirk_init_udelay();
 
 	speculative_store_bypass_ht_init();
+
+	set_fixmap(FIX_MWAIT, __pa_symbol(&__mwait_page));
 }
 
 void arch_enable_nonboot_cpus_begin(void)
@@ -1631,11 +1635,12 @@ static inline void mwait_play_dead(void)
 	}
 
 	/*
-	 * This should be a memory location in a cache line which is
-	 * unlikely to be touched by other processors.  The actual
-	 * content is immaterial as it is not actually modified in any way.
+	 * This memory location is never actually written to.  It's mapped at a
+	 * reserved fixmap address to ensure the monitored address remains
+	 * valid across a hibernation resume operation.  Otherwise a triple
+	 * fault can occur.
 	 */
-	mwait_ptr = &current_thread_info()->flags;
+	mwait_ptr = (void *)fix_to_virt(FIX_MWAIT);
 
 	wbinvd();
 
