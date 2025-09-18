Return-Path: <linux-pm+bounces-34967-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D13D6B85747
	for <lists+linux-pm@lfdr.de>; Thu, 18 Sep 2025 17:09:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 566151791E9
	for <lists+linux-pm@lfdr.de>; Thu, 18 Sep 2025 15:08:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0617230E0CE;
	Thu, 18 Sep 2025 15:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J49zAjBu"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1F1A30E0C6;
	Thu, 18 Sep 2025 15:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758208059; cv=none; b=BrFGK37jqbYpD7WXBGiGwlZ3KcFyLmCK5yOE40XvQeOrk913zS8dOM+MmpVbQOaMs0EuiOZb+TzJ15ECP6Be0OJ8/SIQND2P2pM/IUWFt+aOq7yus9IxuDD5D5OBUR9VS5CEvvi0xcuO9EPLpdlUVJs1nEzccavSv6nuLRi+Tas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758208059; c=relaxed/simple;
	bh=Nd/9GkL+qkT14w7XNwikMbqgds8mmQ2AdtXlZv+hUOA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rJ/JpiEB5KzlWSbVtq7TdCZOpAZdWIBSnjfCyPp8CAgae9vy1TfVltVKMcy/KpJ9U3oh4yOMt6ShqFVfRD9Zve9GxYDZIYVUAKXMfmRK/8ClOhq5IbUnRv6cJQQ1vjwe+aF0zEOm6V8r4oJZ1YfPTJM4vnOrmjXAGSXVCpOp8qk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J49zAjBu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E02EC4CEE7;
	Thu, 18 Sep 2025 15:07:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758208059;
	bh=Nd/9GkL+qkT14w7XNwikMbqgds8mmQ2AdtXlZv+hUOA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=J49zAjBuUFRsSs1ZINVWyLbNPB0bESrlzlFyZhFZ3uaAHVCz+dw+jnv5jB8L4reIf
	 mPaStDuVdhWWEDEDZlO0YiAfO4Dt9j6mv/qGBD52/INUslaATmBwn70PkAJyEC1gHw
	 PRdJgfJJVXXLnDNKkCdBS+1eHQPKdpU2vnxRde4Ip+f6vKJsQxXyAf61HcmUwvkL6n
	 ZG/PRCgGTTSjMbjwRbX1pMfUlj1rtPk+MO2qNQwIKdAyM+mHIA9WQ7H6d1TmitdE2H
	 a9xGkNO8NW1WNA6G/5iZ6yMws3bAkaHxAdDNb2Ot7LIED8qM3Y33AzhPe41Q2qsBLc
	 b6hNrm6c/vqrQ==
Date: Thu, 18 Sep 2025 17:07:36 +0200
From: Frederic Weisbecker <frederic@kernel.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linux PM <linux-pm@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Christian Loehle <christian.loehle@arm.com>
Subject: Re: [PATCH v1 3/3] cpuidle: governors: menu: Special-case nohz_full
 CPUs
Message-ID: <aMwgOJc6Hq17uFzj@localhost.localdomain>
References: <2804546.mvXUDI8C0e@rafael.j.wysocki>
 <2244365.irdbgypaU6@rafael.j.wysocki>
 <aMLaEwBHwiDhgaWM@localhost.localdomain>
 <CAJZ5v0h3eWw3B15SamchCVWfxfEEbOOgjm4ZbmkTt9ijZvvHMA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0h3eWw3B15SamchCVWfxfEEbOOgjm4ZbmkTt9ijZvvHMA@mail.gmail.com>

Le Thu, Sep 11, 2025 at 07:07:42PM +0200, Rafael J. Wysocki a écrit :
> On Thu, Sep 11, 2025 at 4:17 PM Frederic Weisbecker <frederic@kernel.org> wrote:
> > So, when !tick_nohz_full_cpu(dev->cpu), what is the purpose of this tick stopped
> > special case?
> >
> > Is it because the next dynamic tick is a better prediction than the typical
> > interval once the tick is stopped?
> 
> When !tick_nohz_full_cpu(dev->cpu), the tick is a safety net against
> getting stuck in a shallow idle state for too long.  In that case, if
> the tick is stopped, the safety net is not there and it is better to
> use a deep state.

Right.

> However, data->next_timer_ns is a lower limit for the idle state
> target residency because this is when the next timer is going to
> trigger.

Ok.

> 
> > Does that mean we might become more "pessimistic" concerning the predicted idle
> > time for nohz_full CPUs?
> 
> Yes, and not just we might, but we do unless the idle periods in the
> workload are "long".

Ok.

> 
> > I guess too shallow C-states are still better than too deep but there should be
> > a word about that introduced side effect (if any).
> 
> Yeah, I agree.
> 
> That said, on a nohz_full CPU there is no safety net against getting
> stuck in a shallow idle state because the tick is not present.  That's
> why currently the governors don't allow shallow states to be used on
> nohz_full CPUs.
> 
> The lack of a safety net is generally not a problem when the CPU has
> been isolated to run something doing real work all the time, with
> possible idle periods in the workload, but there are people who
> isolate CPUs for energy-saving reasons and don't run anything on them
> on purpose.  For those folks, the current behavior to select deep idle
> states every time is actually desirable.

So far I haven't heard from anybody using nohz_full for powersavings. If
you have I'd be curious about it. Whether a task runs tickless or not, it
still runs and the CPU isn't sleeping. Also CPU 0 stays periodic on nohz_full,
which alone is a problem for powersaving but also prevents a whole package
from entering low power mode on NUMA.

Let's say it not optimized toward powersaving...

> So there are two use cases that cannot be addressed at once and I'm
> thinking about adding a control knob to allow the user to decide which
> way to go.

I'm tempted to say we should focus on having not too deep states,
at the expense of having too shallow. Of course I'm not entirely
comfortable with the idea because nohz_full CPUs may be idle for a while
on some workloads. And everyone deserves a rest at some point after
a long day.

I guess force restarting the tick upon idle entry would probably be
bad for tiny idle round-trips?

As for such a knob, I'm not sure anybody would use it.

Thanks.

-- 
Frederic Weisbecker
SUSE Labs

