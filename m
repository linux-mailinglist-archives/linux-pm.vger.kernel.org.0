Return-Path: <linux-pm+bounces-27396-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 687ADABD0A9
	for <lists+linux-pm@lfdr.de>; Tue, 20 May 2025 09:42:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A0623189E981
	for <lists+linux-pm@lfdr.de>; Tue, 20 May 2025 07:42:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A708F25DAF9;
	Tue, 20 May 2025 07:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="teIyenw9"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CA1D20E32B;
	Tue, 20 May 2025 07:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747726940; cv=none; b=fYmLi8lGXS+2AQ8tYZyuyvkTGgNodPqRDWefpsqqCejrVnWZpcIvHSO9Z4pvjyat4judA6bcHEvkbdMTjUWTzlmmHcjtFbQumzJloYjGpLxRnRqHFbIUqeIayjlHYSmCOljirnNWKojAfGMESY3wPczWmWeakT4YWaav7cGc6ag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747726940; c=relaxed/simple;
	bh=eEi3mKDvtMM13Ex5UlZGmEeN1NuJCNnvqtuW0peVH0Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LSax2nJ2pEYdstOmA9zGI+IqDkrVKkkY9Exip6qEAIDFsD1LRYlauR6YG5qN09OZSC/Rb9VyW4JSLl10JXZ2jYdc1cucKyKqGI9MK8ZCBQQh0bwqlGqOt6AVUjUplq8dGcO8CzsQnkPvLNxzFt+pkltbE9SJBwMh5bf1/beacC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=teIyenw9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D088C4CEE9;
	Tue, 20 May 2025 07:42:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747726940;
	bh=eEi3mKDvtMM13Ex5UlZGmEeN1NuJCNnvqtuW0peVH0Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=teIyenw9nDbvXgqsws1U7d+4gOHxN9QNOsFhbs8og2rTMNZnYx+yVdg8OUHsZKr0b
	 MltxdnR8nH66sVgWyt0PCXNXhRgFfHkXeXaK/8PbLUQFFoC35UHzHamD9JVOlRaBQc
	 M7ZUeoCSOJ+xJVf+xaYu3B4j/Xpa6rjLeteOQ1sxEWstLxp6ahrfHYr/sfJKuHhh2t
	 yoGSnMIT+RZB3HIG37lf6mqwqox0NCB9CVw47qzLqaSQfgccIW1sKRjRjBB1l508wH
	 6eOA/JG7/PD/VPRv1lUJf3alyR461gY1BkZkDieEagwz0mTaL5Oa1U1x3zS4InTP9H
	 jhb3wJpDwGJiw==
Date: Tue, 20 May 2025 09:42:14 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: Eric Biggers <ebiggers@kernel.org>, x86@kernel.org,
	linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
	linux-pm@vger.kernel.org, Borislav Petkov <bp@alien8.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ayush Jain <Ayush.Jain3@amd.com>,
	Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: [PATCH 3/3] x86/fpu: Don't support kernel-mode FPU when
 irqs_disabled()
Message-ID: <aCwyVvgewYum4mrE@gmail.com>
References: <20250516231858.27899-4-ebiggers@kernel.org>
 <aCg2DSYp0nakwX3l@gmail.com>
 <20250517183919.GC1239@sol>
 <aCl_cSO2XqtSQEZT@gmail.com>
 <CAMj1kXGVAbD9zxUQSwwGo=ueadqWWSdaQNDe_-7ZezpFLMJRMA@mail.gmail.com>
 <20250518200114.GA1764@sol>
 <aCrmZnSokvmqfel3@gmail.com>
 <CAMj1kXGe0hMD-71KYN_htJztAL+P8vFNf+9+W_aVDkHx3nCEWA@mail.gmail.com>
 <aCsqyrHdMWlU3yc0@gmail.com>
 <CAMj1kXHzFiQsjUH90J56ds2fgge-MUXmFMBWKtmb0LF=UjbJcg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXHzFiQsjUH90J56ds2fgge-MUXmFMBWKtmb0LF=UjbJcg@mail.gmail.com>


* Ard Biesheuvel <ardb@kernel.org> wrote:

> On Mon, 19 May 2025 at 14:57, Ingo Molnar <mingo@kernel.org> wrote:
> >
> >
> > * Ard Biesheuvel <ardb@kernel.org> wrote:
> >
> > > On Mon, 19 May 2025 at 10:06, Ingo Molnar <mingo@kernel.org> wrote:
> > > >
> > > >
> > > > * Eric Biggers <ebiggers@kernel.org> wrote:
> > > >
> > > > > > # echo PANIC > /sys/kernel/debug/provoke-crash/DIRECT
> > > > > >
> > > > > > Another case that likely executes with IRQs disabled (but I 
> > > > > > haven't double checked) is reset_system(), which may return 
> > > > > > with an error, or reboot/poweroff the machine and never 
> > > > > > return.
> > > > >
> > > > > That makes sense to me.  preempt_disable() and 
> > > > > preempt_enable() are already allowed when IRQs are disabled, 
> > > > > and I'm not sure why local_bh_disable() and local_bh_enable() 
> > > > > are different.
> > > >
> > > > Because local_bh_enable() may run softirq handlers immediately 
> > > > if there's pending softirqs, which shouldn't be done in hardirq 
> > > > context.
> > >
> > > Sure, but why is that mandatory?
> > >
> > >
> > > preempt_disable() has preempt_enable() and 
> > > preempt_enable_no_resched() counterparts.
> >
> > > [...] Could we have a local_bh_enable_no_xxx() version that
> > > re-enables async softirq processing on the current CPU but does not
> > > kick off a synchronous processing run?
> >
> > Yes, that's what __local_bh_enable() does, but if used it for
> > kernel_fpu_end() we'd be introducing random softirq processing
> > latencies. The softirq execution model is for softirqs to be
> > immediately executed after local_bh_enable(), and various networking
> > code is tuned to that behavior.
> >
> 
> All of that only applies when re-enabling softirqs with IRQs enabled.

Yes, of course. BHs in the networking code are typically 
disabled/enabled when IRQs are on. It's the whole *point* of the 
facility: it was written as a 'lightweight' IRQs-on/off facility 
originally, back in the days when local_irq_save() was very expensive, 
especially on non-x86 platforms.

> I don't see why we'd need all of that.
> 
> Conceptually, kernel_fpu_end() would do
> 
> if (irqs_disabled())
>    local_bh_enable_no_xxx();
> else
>    local_bh_enable();

In normal kernel code local_bh_enable() obviously cannot be done with 
IRQs off, and local_bh_disable()/__local_bh_enable() is highly frowned 
upon because it's generally pointless: if irqs are off to begin with, 
why disable any BHs?

What you probably mean is to only disable BHs if IRQs are not off 
(because hardirqs-off state already disables BHs):

  kernel_fpu_begin()
	if (!irqs_disabled)
		local_bh_disable();

  kernel_fpu_end()
	if (!irqs_disabled())
		local_bh_enable();

... which is basically what the current code does:

        if (!irqs_disabled())
                fpregs_lock();

	...

        if (!irqs_disabled())
                fpregs_unlock();

BTW., maybe we should add a lockdep check to make sure we never enable 
hardirqs while kernel FPU handling is ongoing. It should be relatively 
straightforward and cheap.

But that brings is far away from the original question:

> > > > > preempt_disable() and preempt_enable() are already allowed 
> > > > > when IRQs are disabled, and I'm not sure why 
> > > > > local_bh_disable() and local_bh_enable() are different.
> > > >
> > > > Because local_bh_enable() may run softirq handlers immediately 
> > > > if there's pending softirqs, which shouldn't be done in hardirq 
> > > > context.

To rephrase my answer: local_bh_disable()/enable() are part of the 
softirq execution mechanism whose primary historical purpose was to be 
a lighter-weight replacement hardirq disable/enable critical sections, 
combined with a relaxation of how long a softirq could run versus a 
hardirq. It makes little sense to try to nest BH handling primitives to 
within hardirq critical sections.

Thanks,

	Ingo

