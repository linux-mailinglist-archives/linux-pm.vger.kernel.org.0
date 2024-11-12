Return-Path: <linux-pm+bounces-17418-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A0859C5CCC
	for <lists+linux-pm@lfdr.de>; Tue, 12 Nov 2024 17:07:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7D406B3BBAC
	for <lists+linux-pm@lfdr.de>; Tue, 12 Nov 2024 15:00:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BC48200BB9;
	Tue, 12 Nov 2024 14:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="TxcMSsES"
X-Original-To: linux-pm@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37A11200C85;
	Tue, 12 Nov 2024 14:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731423387; cv=none; b=HN9ylE59EXwaSJhr7FzR3tkEcEDVTi+T9jxoZrJyY7sY29uSK+oSHUcxfsN96qvXekB1hTDo3ssm/8ibfFHGM61DX+VILnIAcxz5pPwb9BeS54/I4ue6XFeHxlYnd8nOTAnVyiRm0tQv8QJIqRxOF995xBxQ0nyzeOgC28Rxp3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731423387; c=relaxed/simple;
	bh=Mde5nHBWqkDLtf+xBmnzxuSjwc8sFgr2SRF6Jm+LflQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h7hNjCB9JdzbnBstI4ByHEyRQ3mqFusVMCJmkwAEtDpFFpfqVURiyQfhM7CyNLUaX55YnRo9q7A9MNV9RmvE575xUbojyC9vKAmKWKOBbEwC0x0vvHViYB3JdJwwoQFDww45zytXuZeElJyF7JsXkNnQBaD2VYNEq+Ww3VD6rew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=TxcMSsES; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=ihScYvVrdqNdLsMzYkQ13Zw8VVF2lrSr479gXJJuxz8=; b=TxcMSsES+NIybXxgQ0v4Mt+l0L
	dOX5d9BduXcdlo0mYXASMEti/MVrGlp64gyOjzh+jfwgnjp3RBogQO/vILQBXlx4/Si5uQIxa0aCs
	qwWrPest4/n9DtRr9/NeMvHmexCXn1YrigwPFanYjxvSsmCCr6mdW8JaiJ7nOyOM6HFiMBsgM9BAO
	WpGYs7yyVWBFeFG2fL8F/KLS+WmT8dmwGu+oSU6RLLfHZ/rFLw1nGkvzPHUMpzXIc427lp7Ug7ST/
	EtiffHQoIQE2uTul9fhDvobYzcDZsrmA4zG+IIjQHCfM8df29Itu3S6xSrzS+cKq/qWZv31K/CiLh
	Sk7ggUzQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tAsJX-0000000D5fl-1ZpJ;
	Tue, 12 Nov 2024 14:56:19 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 85576300478; Tue, 12 Nov 2024 15:56:18 +0100 (CET)
Date: Tue, 12 Nov 2024 15:56:18 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Patryk Wlazlyn <patryk.wlazlyn@linux.intel.com>, x86@kernel.org,
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
	rafael.j.wysocki@intel.com, len.brown@intel.com,
	artem.bityutskiy@linux.intel.com, dave.hansen@linux.intel.com,
	gautham.shenoy@amd.com
Subject: Re: [PATCH v3 2/3] x86/smp native_play_dead: Prefer
 cpuidle_play_dead() over mwait_play_dead()
Message-ID: <20241112145618.GR22801@noisy.programming.kicks-ass.net>
References: <20241108122909.763663-1-patryk.wlazlyn@linux.intel.com>
 <20241108122909.763663-3-patryk.wlazlyn@linux.intel.com>
 <20241112114743.GQ22801@noisy.programming.kicks-ass.net>
 <CAJZ5v0hJ8NoFgjtnYce99+qjCZc3_ihBojyK1gRrcyU5Fp6inw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0hJ8NoFgjtnYce99+qjCZc3_ihBojyK1gRrcyU5Fp6inw@mail.gmail.com>

On Tue, Nov 12, 2024 at 02:23:14PM +0100, Rafael J. Wysocki wrote:
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
> Having inspected the code once again, I'm not sure what your concern is.
> 
> :enter.dead() is set to acpi_idle_play_dead() for all states in ACPI
> idle - see acpi_processor_setup_cstates() and the role of the type
> check is to filter out bogus table entries (the "type" must be 1, 2,
> or 3 as per the spec).
> 
> Then cpuidle_play_dead() calls drv->states[i].enter_dead() for the
> deepest state where it is set and if this is FFH,
> acpi_idle_play_dead() will return an error.  So after the change, the
> code above will fall back to mwait_play_dead() then.
> 
> Or am I missing anything?

So it relies on there being a C2/C3 state enumerated and that being FFh.
Otherwise it will find a 'working' state and we're up a creek.

Typically I expect C2/C3 FFh states will be there on Intel stuff, but it
seems awefully random to rely on this hole. AMD might unwittinly change
the ACPI driver (they're the main user) and then we'd be up a creek.

Robustly we'd teach the ACPI driver about FFh and set enter_dead on
every state -- but we'd have to double check that with AMD.

At the same time, intel_idle should then also set enter_dead on all
states.

And then the mwait case is only ever reached if CPUIDLE=n.


