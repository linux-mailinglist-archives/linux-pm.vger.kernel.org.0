Return-Path: <linux-pm+bounces-17414-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A1469C59CF
	for <lists+linux-pm@lfdr.de>; Tue, 12 Nov 2024 15:01:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0033D283BCA
	for <lists+linux-pm@lfdr.de>; Tue, 12 Nov 2024 14:01:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A398B1FBC90;
	Tue, 12 Nov 2024 14:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="XDgap37h"
X-Original-To: linux-pm@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B039B1885A4;
	Tue, 12 Nov 2024 14:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731420097; cv=none; b=nZq65zN8IorxX8Ti0AiB5+w1Y/jwwKCw2zzTjxV+0LT+nvGZ/82LL+9Bh1uSOA3BopyOs25jTN/VvrAcDR7LX/eSwrX6cnXm1d3qSySLWy5qdJSXQOm5j2+3fWS3uA9D2bJcmHXjDJFnWyPcFpYhhQCHE4AvXl7sYz/irPTEJco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731420097; c=relaxed/simple;
	bh=2F6raWkeasLa1Dfln6V+p6Nu6ZY+Rc0S83Pxu1vJ3es=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b2i16Qj0wjQOR1NPlA/9/4KSQWUZOo4Faidbn6h6cAhoZovzPSRFu7/Inyrfn+64p69SbsLTe192g9CJooN/ayconlQhb51HzD/9romYQCsnh845MIwxVA+iBV8mDHOMwX7FcXmPktcceZ8hr/e+QydsucdiJ6a1N8rlHgs21bg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=XDgap37h; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=+LwC9+l0EzZQ0PhPfDklx8frcQ3khr2ko874GAYlLE8=; b=XDgap37ho91c02OdHKL9m6Jet7
	UnUFDtaOm+6gjeqOyZlJkLnAhNoBYR7a9UhlyiVBYPzjYPz4ghY5ZmqmhxLR4izB8OkeTTiW22IrD
	JHuKjWrmA+ommOZ03fe75hVYEGb+fgimcAXMsFIOa/GUeHb+nRS2GrzC1LZuG5bG8zYXBnNGLjgqJ
	xVz7v1pUZTobUlrHEV1d7vO3wxmM/0gtn+8ply6mSO2FVv1tZotdYWeXKHHesaRracR+ovIetAcZV
	u3sn0rIc+R7v8BCKP9qTBN+uF6pHKBO5x4v9ijK6X8mr64wra/gYjm99vurRxrOebt826Ea659Xto
	s2qEaBUQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tArSS-0000000EUfi-0pFD;
	Tue, 12 Nov 2024 14:01:28 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 7E0E6300478; Tue, 12 Nov 2024 15:01:27 +0100 (CET)
Date: Tue, 12 Nov 2024 15:01:27 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Patryk Wlazlyn <patryk.wlazlyn@linux.intel.com>, x86@kernel.org,
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
	rafael.j.wysocki@intel.com, len.brown@intel.com,
	dave.hansen@linux.intel.com
Subject: Re: [PATCH v3 2/3] x86/smp native_play_dead: Prefer
 cpuidle_play_dead() over mwait_play_dead()
Message-ID: <20241112140127.GH6497@noisy.programming.kicks-ass.net>
References: <20241108122909.763663-1-patryk.wlazlyn@linux.intel.com>
 <20241108122909.763663-3-patryk.wlazlyn@linux.intel.com>
 <20241112114743.GQ22801@noisy.programming.kicks-ass.net>
 <CAJZ5v0ivAk1xrcJgiJnDWnL3GdijSdsuV4K_4ORjnsjPUVAEnA@mail.gmail.com>
 <20241112121843.GF6497@noisy.programming.kicks-ass.net>
 <0ecea0e5be59e63b7827f4db368f2aa3322fb71d.camel@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0ecea0e5be59e63b7827f4db368f2aa3322fb71d.camel@linux.intel.com>

On Tue, Nov 12, 2024 at 02:44:49PM +0200, Artem Bityutskiy wrote:
> On Tue, 2024-11-12 at 13:18 +0100, Peter Zijlstra wrote:
> > But on Intel we really don't want HLT, and had that MWAIT, but that has
> > real problems with KEXEC. And I don't think we can rely on INTEL_IDLE=y.
> 
> If INTEL_IDLE is not set, then we'll just use existing mwait creation algorithm
> in 'mwait_play_dead()', which works too, just not ideal.

So why not fix the substate detectoring function and ignore everything?

> > Anyway, ideally x86 would grow a new instruction to offline a CPU, both
> > MWAIT and HLT have problems vs non-maskable interrupts.
> ... snip ...
> > But as said, we need a new instruction.
> 
> FYI, I already started discussing a special "gimme the deepest C-state" mwait
> hint - just a constant like 0xFF. CPUID leaf 5 has many reserved bits, one could
> be used for enumeration of this feature.
> 
> But this is just a quick idea so far, and informal discussions so far.

No, not mwait hint. We need an instruction that:

 - goes to deepest C state
 - drops into WAIT-for-Start-IPI (SIPI)

Notably, it should not wake from:

 - random memory writes
 - NMI, MCE, SMI and other such non-maskable thingies
 - anything else -- the memory pointed to by RIP might no longer exist

Lets call the instruction: DEAD.

With the mwait 'hack', kexec still goes belly up if it gets a spurious
NMI (and them others) at an inopportune time, and this does happen
afaik. Just not enough to worry the data center guys like the mwait
thing.

