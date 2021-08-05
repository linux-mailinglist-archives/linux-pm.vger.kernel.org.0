Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70C8B3E141D
	for <lists+linux-pm@lfdr.de>; Thu,  5 Aug 2021 13:50:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241103AbhHELvJ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 5 Aug 2021 07:51:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232513AbhHELvI (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 5 Aug 2021 07:51:08 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85BF8C061765;
        Thu,  5 Aug 2021 04:50:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=jwTUKdnUOWzKUoGdDvWps429sFSTOQ6uJd0xwXBgDQU=; b=GW2GxMPdGI3+eboXYgxVAvqvyR
        Yvq4mWzeNlEOE9mBAaOcyMoxy95M0W/l7NytTuNPdj7zdTCMqsMD4azTtAGjiFCOLCdZm+sUNmoLO
        mojECtQfz/WhlkVHOHSs8d/sfXmiJbdA2Meh/PxfJYRhxlS4pCGZaXEtAnNR00BNCXi2owa1KNA07
        p+g32C+I95Q4QLf/EbrIK3PCFBhVQOj5TJLKQej7kq9p2O2gKEf5aiJvgAYvBHlZeWKNYHm8GrePb
        LCiWQ1pahXzrB2s0QHAiuCi7aE1M4VQaqn0+/FIybwazM1DfH09rh6GUhx5t/y6qSQXI/F2YLuS78
        ipPUIDUQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mBbtV-0061J3-Mo; Thu, 05 Aug 2021 11:50:37 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id E5FCE300084;
        Thu,  5 Aug 2021 13:50:35 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id CA98F20D8934D; Thu,  5 Aug 2021 13:50:35 +0200 (CEST)
Date:   Thu, 5 Aug 2021 13:50:35 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     rjw@rjwysocki.net, mingo@kernel.org, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, mgorman@suse.de,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        tj@kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v2 4/4] freezer,sched: Rewrite core freezer logic
Message-ID: <YQvQiyn3xz2hte9v@hirez.programming.kicks-ass.net>
References: <20210624092156.332208049@infradead.org>
 <20210624092616.009504322@infradead.org>
 <20210707141412.GA17818@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210707141412.GA17818@redhat.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Jul 07, 2021 at 04:14:12PM +0200, Oleg Nesterov wrote:
> sorry for delay...

And me.. :/

> I am still trying to understand this series, just one note for now.

The main motivation is to ensure tasks don't wake up early on resume.
The current code has a problem between clearing pm_freezing and calling
__thaw_task(), a task can get spuriously woken there.

(Will is doing unspeakable things that suffer there.)

I'm trying to fix that by making frozen a special wait state, but that
then gets me complications vs the existing special states.

I also don't want to change the wakeup path, as you suggested earlier
because that's adding code (abeit fairly trivial) to every single wakeup
for the benefit of these exceptional cases, which I feel is just wrong
(tempting as it might be).

> On 06/24, Peter Zijlstra wrote:
> >
> > +static bool __freeze_task(struct task_struct *p)
> > +{
> > +	unsigned long flags;
> > +	unsigned int state;
> > +	bool frozen = false;
> > +
> > +	raw_spin_lock_irqsave(&p->pi_lock, flags);
> > +	state = READ_ONCE(p->__state);
> > +	if (state & (TASK_FREEZABLE|__TASK_STOPPED|__TASK_TRACED)) {
> > +		/*
> > +		 * Only TASK_NORMAL can be augmented with TASK_FREEZABLE,
> > +		 * since they can suffer spurious wakeups.
> > +		 */
> > +		if (state & TASK_FREEZABLE)
> > +			WARN_ON_ONCE(!(state & TASK_NORMAL));
> > +
> > +#ifdef CONFIG_LOCKDEP
> > +		/*
> > +		 * It's dangerous to freeze with locks held; there be dragons there.
> > +		 */
> > +		if (!(state & __TASK_FREEZABLE_UNSAFE))
> > +			WARN_ON_ONCE(debug_locks && p->lockdep_depth);
> > +#endif
> > +
> > +		if (state & (__TASK_STOPPED|__TASK_TRACED))
> > +			WRITE_ONCE(p->__state, TASK_FROZEN|__TASK_FROZEN_SPECIAL);
> 
> Well, this doesn't look right.

> But the main problem is that you can't simply remove __TASK_TRACED,
> this can confuse the debugger, any ptrace() request will fail as if
> the tracee was killed.

Urgh.. indeed. I missed the obvious *again* :/ Other, not-yet-frozen,
tasks will observe this 'intermediate' state and misbehave. And similar
on wakeup I suppose, if we wake the ptracer before the tracee it again
can observe this state.

I suppose we could cure that, have stopped/trace users use a special
accessor for task::__state... not pretty. Let me see if I can come up
with anything else.


