Return-Path: <linux-pm+bounces-17406-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DAC349C5787
	for <lists+linux-pm@lfdr.de>; Tue, 12 Nov 2024 13:18:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E84628573B
	for <lists+linux-pm@lfdr.de>; Tue, 12 Nov 2024 12:18:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70CAA1CD21A;
	Tue, 12 Nov 2024 12:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="azM7U5Iw"
X-Original-To: linux-pm@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5485784D2B;
	Tue, 12 Nov 2024 12:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731413929; cv=none; b=gNazkfKrDLl2/DgvX3UG0r6ld+IX+uhco4BUVtn9S7li2xaewcVxQ2VEiIivS4Jiwt5TcK62rneO8roSympShmf2h7Gl/x5gVLs2dgv8Vix/lPkNuBIIHWmKCiivL3ib3Kt6PLCEqnKy580zUiRLSy9E1de8uTJHNtK7dUgYdQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731413929; c=relaxed/simple;
	bh=wbVHGtRugFym72R5V63xDjxYOfwCu+w7zmQD9sXa4vw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tomdAtc3WLfF38fXyW1iH2XxVifWMLgIDkPWuITxbtljcRxLvvvZflx5BWW0a74c9UNIgfsIPzqithaGTt7MeLWbPzXh3kZAw9kyTV8l2df+n+RyhEZB61mcNyvVeujzq3Xg7lFD0R6FjOZqLSLr0zUiywbf97kCjgJvKVULegw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=azM7U5Iw; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=7922zFMt6vaxnu1/CkiAwabM2nK+b5lhyNnrOylVdDY=; b=azM7U5Iw2XTuAkoW+Bx/f6K/mS
	yd/W+W0G3T2abJJotFez/8VIgca9yvDA+61YVMAZ9uwmKizeI5641h67NuuVEB3mf6EiydiwztZgG
	AkrL6PC1PgEbVSGIy4MvLlcLe/F0rlcWSIZFXNjZdPYSLF+Umkjre5q3malwbqOgTldG0M2e74whb
	f3codcIXKRv0L6e35VDleGG/wDusyGj+LlmNiOctcwX2mAxJnduxirqYVP9UY+8+SPTuuPNGc2mLb
	MlPBP00cAqC4VNA1CARWRYiJoptjKwFc0HDLLVjo7Pc6RYgJseYE7yJxvhs+bh4g9DBXSDTuRIeGt
	ebAm/X4Q==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tApr2-0000000ENAn-0Lh5;
	Tue, 12 Nov 2024 12:18:44 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 826A1300478; Tue, 12 Nov 2024 13:18:43 +0100 (CET)
Date: Tue, 12 Nov 2024 13:18:43 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Patryk Wlazlyn <patryk.wlazlyn@linux.intel.com>, x86@kernel.org,
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
	rafael.j.wysocki@intel.com, len.brown@intel.com,
	artem.bityutskiy@linux.intel.com, dave.hansen@linux.intel.com
Subject: Re: [PATCH v3 2/3] x86/smp native_play_dead: Prefer
 cpuidle_play_dead() over mwait_play_dead()
Message-ID: <20241112121843.GF6497@noisy.programming.kicks-ass.net>
References: <20241108122909.763663-1-patryk.wlazlyn@linux.intel.com>
 <20241108122909.763663-3-patryk.wlazlyn@linux.intel.com>
 <20241112114743.GQ22801@noisy.programming.kicks-ass.net>
 <CAJZ5v0ivAk1xrcJgiJnDWnL3GdijSdsuV4K_4ORjnsjPUVAEnA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0ivAk1xrcJgiJnDWnL3GdijSdsuV4K_4ORjnsjPUVAEnA@mail.gmail.com>

On Tue, Nov 12, 2024 at 01:03:49PM +0100, Rafael J. Wysocki wrote:
> On Tue, Nov 12, 2024 at 12:47 PM Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > On Fri, Nov 08, 2024 at 01:29:08PM +0100, Patryk Wlazlyn wrote:
> > > The generic implementation, based on cpuid leaf 0x5, for looking up the
> > > mwait hint for the deepest cstate, depends on them to be continuous in
> > > range [0, NUM_SUBSTATES-1]. While that is correct on most Intel x86
> > > platforms, it is not architectural and may not result in reaching the
> > > most optimized idle state on some of them.
> > >
> > > Prefer cpuidle_play_dead() over the generic mwait_play_dead() loop and
> > > fallback to the later in case of missing enter_dead() handler.
> > >
> > > Signed-off-by: Patryk Wlazlyn <patryk.wlazlyn@linux.intel.com>
> > > ---
> > >  arch/x86/kernel/smpboot.c | 4 ++--
> > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
> > > index 44c40781bad6..721bb931181c 100644
> > > --- a/arch/x86/kernel/smpboot.c
> > > +++ b/arch/x86/kernel/smpboot.c
> > > @@ -1416,9 +1416,9 @@ void native_play_dead(void)
> > >       play_dead_common();
> > >       tboot_shutdown(TB_SHUTDOWN_WFS);
> > >
> > > -     mwait_play_dead();
> > >       if (cpuidle_play_dead())
> > > -             hlt_play_dead();
> > > +             mwait_play_dead();
> > > +     hlt_play_dead();
> > >  }
> >
> > Yeah, I don't think so. we don't want to accidentally hit
> > acpi_idle_play_dead().
> 
> Fair enough.
> 
> Then we are back to the original approach though:
> 
> https://lore.kernel.org/linux-pm/20241029101507.7188-3-patryk.wlazlyn@linux.intel.com/

Well, that won't be brilliant for hybrid systems where the available
states are different per CPU.

Also, all of this is a bit of a trainwreck... AFAICT AMD wants IO based
idle (per the 2018 commit). So they want the ACPI thing.

But on Intel we really don't want HLT, and had that MWAIT, but that has
real problems with KEXEC. And I don't think we can rely on INTEL_IDLE=y.

The ACPI thing doesn't support FFh states for it's enter_dead(), should
it?

Anyway, ideally x86 would grow a new instruction to offline a CPU, both
MWAIT and HLT have problems vs non-maskable interrupts.

I really don't know what is best here, maybe moving that whole CPUID
loop to boot, store the value in a per-cpu mwait_play_dead_hint. Have
AMD explicitly clear the value, and avoid mwait when 0 -- hint 0 is
equal to HLT anyway.

But as said, we need a new instruction.

