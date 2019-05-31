Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6DE4030DDF
	for <lists+linux-pm@lfdr.de>; Fri, 31 May 2019 14:11:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727438AbfEaMKr (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 31 May 2019 08:10:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:39472 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727327AbfEaMK0 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 31 May 2019 08:10:26 -0400
Received: from pobox.suse.cz (prg-ext-pat.suse.com [213.151.95.130])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2D4BB2685F;
        Fri, 31 May 2019 12:10:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559304625;
        bh=clAIEBmajpiQKktOEKSBKpbFw41J7aLzihGd1Cq4U9g=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=LJUT1u8nmKrWqTtqdGX7cDrBNk1X4cVcD5sgVhwJBPzSXBLNYDyOVx4lk82YnTS4B
         gFRwuZPOQwBm61NZd47QschHiuMnsQ2SatbFHoeGGLkwD1Z7+DXQI7HDiQmSl3PKjJ
         bchq8b9ilYkT2a+lkmhzedx7jr//JvmCaF+eAbkY=
Date:   Fri, 31 May 2019 14:09:57 +0200 (CEST)
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
Message-ID: <nycvar.YFH.7.76.1905311401050.1962@cbobk.fhfr.pm>
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

> Something like this (not yet tested)?  Maybe we could also remove the
> resume_play_dead() hack?

I tried to test this, but the resumed kernel doesn't seem to be healthy 
for reason I don't understand yet. 
Symptoms I've seen so far -- 'dazed and confused NMI', spontaneous reboot, 
userspace segfault.

> diff --git a/arch/x86/include/asm/fixmap.h b/arch/x86/include/asm/fixmap.h
> index 9da8cccdf3fb..1c328624162c 100644
> --- a/arch/x86/include/asm/fixmap.h
> +++ b/arch/x86/include/asm/fixmap.h
> @@ -80,6 +80,7 @@ enum fixed_addresses {
>  #ifdef CONFIG_X86_VSYSCALL_EMULATION
>  	VSYSCALL_PAGE = (FIXADDR_TOP - VSYSCALL_ADDR) >> PAGE_SHIFT,
>  #endif
> +	FIX_MWAIT = (FIXADDR_TOP - VSYSCALL_ADDR - 1) >> PAGE_SHIFT,

Two things to this:

- you don't seem to fix x86_32
- shouldn't it rather be FIXADDR_TOP - VSYSCALL_ADDR + 1 instead?

Thanks,

-- 
Jiri Kosina
SUSE Labs

