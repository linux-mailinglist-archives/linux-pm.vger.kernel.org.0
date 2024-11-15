Return-Path: <linux-pm+bounces-17621-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 065B79CDEC0
	for <lists+linux-pm@lfdr.de>; Fri, 15 Nov 2024 13:55:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 74038B245F9
	for <lists+linux-pm@lfdr.de>; Fri, 15 Nov 2024 12:55:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2686D1BE854;
	Fri, 15 Nov 2024 12:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="dFl0gh7C"
X-Original-To: linux-pm@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 552571BD01E;
	Fri, 15 Nov 2024 12:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731675332; cv=none; b=CJhI4HMaysQiDOq9jkQ78p+W6ddx1q1VYh8PSvq0nbRms4iSrauyJfxyjXK7MyncqLQo1z0DaYTF8T3xRABLFrM8mSER8bj2fPJBgl8XJpza6DuDpMn/GQJfT4neACHqKi/fUQqmRSkNpWzff968v/ps6kZ6DO2uC8+i23G+Kdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731675332; c=relaxed/simple;
	bh=kNaRc/S746doOvmOeZ21CW+tnGTJ42AZjB6cKjgPbqY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=labXwkJfRcxRTPt3obZpRBeweGxqXD8SF9Hmd1KQi5MPIH8k2oJbQrtJ/UTCc/sgdPnckQYSTCH5nfe8bj/bMp+QgO6VbkfqxgxlGLctIdLIDOwxJiEpTWElRWVXia313elLDR8JOwk/LWC1fXuBmqP3rtEhk/yqzUaiHlec5MY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=dFl0gh7C; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=jO7wLYRzYfuaTdWE90vwtqzp5NOET7KuqVmx7tLtIE4=; b=dFl0gh7CMpx0MbdpK5hsamgOEp
	/0VO6hLG2U12qJ04d/orPAA25l+1ulLwcZeCKWSkDVHBVsbXJFuTyIRZwHrfVykVRWDredug3QjPJ
	L2BSGPb02/K3pNOm0Mfor/ZI4CLN+yivmAYrDobqHEwNdndrC7lyv14qnsr5LhBMsNMrP9EDfmbFz
	CtSViMRe9ODeHkH3TNI1POjD5ftIg09yN+yCSv0bZsLh76XxFNDaNwB/Q52RCXkzRzcx8tJEEewOt
	8/RNSZ79c6VqoR77wBHIpVapxQ8e5Vv4hH/A8ooHfSKQOXM926I5M/LpAsZaucvR/Kr7TcMa+TinK
	ULemGJIA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tBvrA-00000000EaF-1GZg;
	Fri, 15 Nov 2024 12:55:25 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id EBA1D30066A; Fri, 15 Nov 2024 13:55:23 +0100 (CET)
Date: Fri, 15 Nov 2024 13:55:23 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Linux PM <linux-pm@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	x86 Maintainers <x86@kernel.org>,
	Patryk Wlazlyn <patryk.wlazlyn@linux.intel.com>,
	"Gautham R. Shenoy" <gautham.shenoy@amd.com>,
	Artem Bityutskiy <artem.bityutskiy@linux.intel.com>,
	Mario Limonciello <mario.limonciello@amd.com>
Subject: Re: [PATCH v1] cpuidle: Do not return from cpuidle_play_dead() on
 callback failures
Message-ID: <20241115125523.GD22801@noisy.programming.kicks-ass.net>
References: <4992010.31r3eYUQgx@rjwysocki.net>
 <20241115101427.GA22801@noisy.programming.kicks-ass.net>
 <CAJZ5v0gfSpzjD1PDhMOmqV_wcnCtr=m12noAqVpQkDsjetu+Ug@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0gfSpzjD1PDhMOmqV_wcnCtr=m12noAqVpQkDsjetu+Ug@mail.gmail.com>

On Fri, Nov 15, 2024 at 01:46:29PM +0100, Rafael J. Wysocki wrote:
> On Fri, Nov 15, 2024 at 11:14 AM Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > On Thu, Nov 14, 2024 at 06:46:20PM +0100, Rafael J. Wysocki wrote:
> > > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > >
> > > If the :enter_dead() idle state callback fails for a certain state,
> > > there may be still a shallower state for which it will work.
> > >
> > > Because the only caller of cpuidle_play_dead(), native_play_dead(),
> > > falls back to hlt_play_dead() if it returns an error, it should
> > > better try all of the idle states for which :enter_dead() is present
> > > before failing, so change it accordingly.
> > >
> > > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > > ---
> > >  drivers/cpuidle/cpuidle.c |    7 ++++---
> > >  1 file changed, 4 insertions(+), 3 deletions(-)
> > >
> > > Index: linux-pm/drivers/cpuidle/cpuidle.c
> > > ===================================================================
> > > --- linux-pm.orig/drivers/cpuidle/cpuidle.c
> > > +++ linux-pm/drivers/cpuidle/cpuidle.c
> > > @@ -70,9 +70,10 @@ int cpuidle_play_dead(void)
> > >               return -ENODEV;
> > >
> > >       /* Find lowest-power state that supports long-term idle */
> > > -     for (i = drv->state_count - 1; i >= 0; i--)
> > > -             if (drv->states[i].enter_dead)
> > > -                     return drv->states[i].enter_dead(dev, i);
> > > +     for (i = drv->state_count - 1; i >= 0; i--) {
> > > +             if (drv->states[i].enter_dead && !drv->states[i].enter_dead(dev, i))
> > > +                     return 0;
> > > +     }
> >
> > Hmm, strictly speaking there is no 'success' return from play_dead(). On
> > success, the CPU is dead :-)
> 
> Well, would you prefer something like
> 
> for (i = drv->state_count - 1; i >= 0; i--) {
>         if (drv->states[i].enter_dead)
>                 drv->states[i].enter_dead(dev, i);
> }
> 
> and adding a comment before the final return statement that
> :enter_dead() only returns on failure?

Yeah, but perhaps remove the return value entirely if we're going to
ignore it anyway. And then assume that any return is a failure to die.

I mean, something like:

	if (drv->states[i].enter_dead && !drv->states[i].enter_dead(dev, i))
		panic("Dead CPU walking...");

is 'fun' but not very useful.

