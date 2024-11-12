Return-Path: <linux-pm+bounces-17412-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0728E9C5987
	for <lists+linux-pm@lfdr.de>; Tue, 12 Nov 2024 14:50:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C12C0282E98
	for <lists+linux-pm@lfdr.de>; Tue, 12 Nov 2024 13:50:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84DD11FBF47;
	Tue, 12 Nov 2024 13:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="QczC1MZp"
X-Original-To: linux-pm@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96B1E1FBCB4;
	Tue, 12 Nov 2024 13:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731419405; cv=none; b=nFvYZK0tj9rjGFjaLmX2hAKZm6tXDktMQyMVAaqWoUbaNYA/STQ/TvrbCEmMkf4RjtOhJPs/rJ/hH9g0jqM9sKg+/s1RIyzNs0bM6tTyXcxO1J1QyPsl9yIYgYX7ZwZIrNyv+Ta13DYq6y7SACgNwtVUr5lnjDOO5DIRxEkmiUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731419405; c=relaxed/simple;
	bh=wNbnPVDNTI08jMStKp3ZCBDwbQM7GErnoyauBVGfL1w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=paAz/RpPmjwNWCuCQEICcCtiKQcHIm9BA3kUmYoovtYJuuAV2FuJIBJigzsG3dtXl3q/aJEfvwc6MrDIBpW53rA8WcR8PhC2Wze7/AMJ9XK6zrOjcXYmXHrnudR85IPp6eXCKIiWayiAbtsOCLH9cB7w/0q8wKvE0nffAj+mGT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=QczC1MZp; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=M9UFpBYRnthoX0zJOVLLNv0Z7hyxw5uB1de5Q9Xf9Sw=; b=QczC1MZpT2+ZT0zBr9SbUh8n7E
	wI5lnpCWNMsVisRKuYnYcsqEUhwu0u6PQg9/J0DwnoHLdcKOWo5bn08DpOQnufKjCwcRLQwW5aAt3
	2QH4+RLQWvlX/7PnrrEk0Q237bpds+sAXmAWXolUjtIjes5aJCwWc3WkUu4U1LKu8q4M9dwPLjTgW
	vorjhs7s7LT3S5ystQXCdn5sd44PKg+/n5ZOCBQG4WANUf36zY9WuOmiflTAOWSJe7m9aWuB+3NhH
	EisJU46pUZKEsWwfsPQ5dMWUx4ryX+ul4uDcJ//wYDHvDaCKVyNFM8C0wJX3dAUrp7vETV3Z3lqX1
	dAPMC1WA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tArHM-0000000D4oF-2Cpy;
	Tue, 12 Nov 2024 13:50:00 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id BA7D6300478; Tue, 12 Nov 2024 14:49:59 +0100 (CET)
Date: Tue, 12 Nov 2024 14:49:59 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Patryk Wlazlyn <patryk.wlazlyn@linux.intel.com>, x86@kernel.org,
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
	rafael.j.wysocki@intel.com, len.brown@intel.com,
	artem.bityutskiy@linux.intel.com, dave.hansen@linux.intel.com
Subject: Re: [PATCH v3 2/3] x86/smp native_play_dead: Prefer
 cpuidle_play_dead() over mwait_play_dead()
Message-ID: <20241112134959.GG6497@noisy.programming.kicks-ass.net>
References: <20241108122909.763663-1-patryk.wlazlyn@linux.intel.com>
 <20241108122909.763663-3-patryk.wlazlyn@linux.intel.com>
 <20241112114743.GQ22801@noisy.programming.kicks-ass.net>
 <CAJZ5v0ivAk1xrcJgiJnDWnL3GdijSdsuV4K_4ORjnsjPUVAEnA@mail.gmail.com>
 <20241112121843.GF6497@noisy.programming.kicks-ass.net>
 <CAJZ5v0iSP4Gh2FwKdkOw20N4hzwQ94+WmnT+3EY94QG3gORWzA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0iSP4Gh2FwKdkOw20N4hzwQ94+WmnT+3EY94QG3gORWzA@mail.gmail.com>

On Tue, Nov 12, 2024 at 01:30:29PM +0100, Rafael J. Wysocki wrote:

> > > Then we are back to the original approach though:
> > >
> > > https://lore.kernel.org/linux-pm/20241029101507.7188-3-patryk.wlazlyn@linux.intel.com/
> >
> > Well, that won't be brilliant for hybrid systems where the available
> > states are different per CPU.
> 
> But they aren't.
> 
> At least so far that has not been the case on any platform known to me
> and I'm not aware of any plans to make that happen (guess what, some
> other OSes may be unhappy).

Well, that's something at least.

> > Also, all of this is a bit of a trainwreck... AFAICT AMD wants IO based
> > idle (per the 2018 commit). So they want the ACPI thing.
> 
> Yes.
> 
> > But on Intel we really don't want HLT, and had that MWAIT, but that has
> > real problems with KEXEC. And I don't think we can rely on INTEL_IDLE=y.
> 
> We could because it handles ACPI now and ACPI idle doesn't add any
> value on top of it except for the IO-based idle case.

You're saying we can mandate INTEL_IDLE=y? Because currently defconfig
doesn't even have it on.

> > The ACPI thing doesn't support FFh states for it's enter_dead(), should it?
> 
> It does AFAICS, but the FFH is still MWAIT.

What I'm trying to say is that acpi_idle_play_dead() doesn't seem to
support FFh and as such won't ever use MWAIT.

> > Anyway, ideally x86 would grow a new instruction to offline a CPU, both
> > MWAIT and HLT have problems vs non-maskable interrupts.
> >
> > I really don't know what is best here, maybe moving that whole CPUID
> > loop to boot, store the value in a per-cpu mwait_play_dead_hint. Have
> > AMD explicitly clear the value, and avoid mwait when 0 -- hint 0 is
> > equal to HLT anyway.
> >
> > But as said, we need a new instruction.
> 
> Before that, there is the problem with the MWAIT hint computation in
> mwait_play_dead() and in fact intel_idle does know what hint to use in
> there.

But we need to deal witn INTEL_IDLE=n. Also, I don't see any MWAIT_LEAF
parsing in intel_idle.c. Yes, it requests the information, but then it
mostly ignores it -- it only consumes two ECX bits or so.

I don't see it finding a max-cstate from mwait_substates anywhere.

So given we don't have any such code, why can't we simply fix the cstate
parsing we have in mwait_play_dead() and call it a day?

