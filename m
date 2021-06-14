Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C02363A6B61
	for <lists+linux-pm@lfdr.de>; Mon, 14 Jun 2021 18:13:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234600AbhFNQPY (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 14 Jun 2021 12:15:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234572AbhFNQPX (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 14 Jun 2021 12:15:23 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5666C061574;
        Mon, 14 Jun 2021 09:13:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=i0UaLutP0pg/vUIZxWE/ltq43kwiXqxNum5X8NZGTo8=; b=U8Xwjjw6zrH3Oo18gWDo7ilt9p
        upiw+9VDQglmP39R9+HNWCk7Sqn7eO5XapCgeXWrdgUR9RZ7rMLT9sXYv92lkl4BNM9rYNb4Dy5lW
        THftCVWv6HOLtRgimjqkSiMw4oh0rpPMQ4Qh6NHr+67Di+rBJGWyk7zAJxge1UsYbMmeemy8ywDrH
        mpm10YJRQA/lVwl63ZkhVEa3X2FaTuwRM461jqfzvo4CYXPXe9vZnx9pSu7275MR2vrKiyKN8COiQ
        vW8UC/vEqhczEdN/94MrjoOxmkngWizKEfRJsbZwR/at5SAxogX7Ilu9qnB1/gpUW4wX9XCpaYyv3
        mNRhgoLQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lspCI-005bOz-2a; Mon, 14 Jun 2021 16:12:25 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 18DAB9831CA; Mon, 14 Jun 2021 18:12:21 +0200 (CEST)
Date:   Mon, 14 Jun 2021 18:12:21 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     rjw@rjwysocki.net, mingo@kernel.org, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, mgorman@suse.de,
        Will Deacon <will@kernel.org>, Tejun Heo <tj@kernel.org>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH] freezer,sched: Rewrite core freezer logic
Message-ID: <20210614161221.GC68749@worktop.programming.kicks-ass.net>
References: <YMMijNqaLDbS3sIv@hirez.programming.kicks-ass.net>
 <20210614154246.GB13677@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210614154246.GB13677@redhat.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Jun 14, 2021 at 05:42:47PM +0200, Oleg Nesterov wrote:
> Hi Peter, sorry for delay,
> 
> On 06/11, Peter Zijlstra wrote:
> >
> > +/* Recursion relies on tail-call optimization to not blow away the stack */
> > +static bool __frozen(struct task_struct *p)
> > +{
> > +	if (p->state == TASK_FROZEN)
> > +		return true;
> > +
> > +	/*
> > +	 * If stuck in TRACED, and the ptracer is FROZEN, we're frozen too.
> > +	 */
> > +	if (task_is_traced(p))
> > +		return frozen(rcu_dereference(p->parent));
> 
> Why does it use frozen(), not __frozen() ?

(because I'm an idiot :/)

> This looks racy, p->parent can resume this task and then enter
> __refrigerator().

But this is about the child, we won't report it frozen, unless the
parent is also frozen. If the parent is frozen, it cannot resume the
task.

The other way around, if the parent resumes the task and then gets
frozen, then we'll wait until the task gets frozen.

That is, I don't see the race. Maybe it's been too warm, but could you
spell it out?

> Plus this task can be SIGKILL'ed even if it is traced.

Hurmm.. *that* is a problem.

> > +	/*
> > +	 * If stuck in STOPPED and the parent is FROZEN, we're frozen too.
> > +	 */
> > +	if (task_is_stopped(p))
> > +		return frozen(rcu_dereference(p->real_parent));
> 
> (you could use ->parent in this case too and unify this check with the
> "traced" case above)

Are you sure? The way I read the code ptrace_attach() will change
->parent, but STOPPED is controlled by the jobctl.

> I don't understand. How this connects to ->parent or ->real_parent?
> SIGCONT can come from anywhere and wake this stopped task up?

Could be me who's not understanding, I thought only the real parent
could do that.

> I guess you do this to avoid freezable_schedule() in ptrace/signal_stop,
> and we can't use TASK_STOPPED|TASK_FREEZABLE, it should not run after
> thaw()... But see above, we can't rely on __frozen(parent).

I do this because freezing puts a task in TASK_FROZEN, and that cannot
preserve TAKS_STOPPED or TASK_TRACED without being subject to wakups
from those bits. I suppose I can add TASK_FROZEN_STOPPED and
TASK_FROZEN_TRACED bits. Let me try that... (tomorrow, brain is cooked).
