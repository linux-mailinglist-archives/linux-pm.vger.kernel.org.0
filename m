Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CE523A6C7A
	for <lists+linux-pm@lfdr.de>; Mon, 14 Jun 2021 18:54:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234771AbhFNQ4h (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 14 Jun 2021 12:56:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:21437 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233843AbhFNQ4g (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 14 Jun 2021 12:56:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623689672;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5UZ4I1ViyrqDSpBZUqCRFFwEAWXTuZyzQaEF1SQ5YV8=;
        b=Q3EAZdJ6ekZprJKaA4jMOJomi2avn8491UrroKjBl4+dOyejRUdcVOQZK1FUc0WgMjOX+H
        pn8oo+Uetk2COLXdFEU3km5dMZHM8Tl3SRxhtCTByyvdPs0Pne5GMJAQ2b/cyc2y9cZq75
        8BezeLFiIoI1VhtV8u5QN1e2FSENykw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-163-qkZsRJmKMuqaRyKLTCb_Ow-1; Mon, 14 Jun 2021 12:54:29 -0400
X-MC-Unique: qkZsRJmKMuqaRyKLTCb_Ow-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8C4678015F5;
        Mon, 14 Jun 2021 16:54:27 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.40.192.47])
        by smtp.corp.redhat.com (Postfix) with SMTP id C136E60657;
        Mon, 14 Jun 2021 16:54:24 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Mon, 14 Jun 2021 18:54:27 +0200 (CEST)
Date:   Mon, 14 Jun 2021 18:54:23 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     rjw@rjwysocki.net, mingo@kernel.org, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, mgorman@suse.de,
        Will Deacon <will@kernel.org>, Tejun Heo <tj@kernel.org>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH] freezer,sched: Rewrite core freezer logic
Message-ID: <20210614165422.GC13677@redhat.com>
References: <YMMijNqaLDbS3sIv@hirez.programming.kicks-ass.net>
 <20210614154246.GB13677@redhat.com>
 <20210614161221.GC68749@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210614161221.GC68749@worktop.programming.kicks-ass.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 06/14, Peter Zijlstra wrote:
>
> On Mon, Jun 14, 2021 at 05:42:47PM +0200, Oleg Nesterov wrote:
> >
> > > +	/*
> > > +	 * If stuck in TRACED, and the ptracer is FROZEN, we're frozen too.
> > > +	 */
> > > +	if (task_is_traced(p))
> > > +		return frozen(rcu_dereference(p->parent));
> >
> > This looks racy, p->parent can resume this task and then enter
> > __refrigerator().
>
> But this is about the child, we won't report it frozen, unless the
> parent is also frozen. If the parent is frozen, it cannot resume the
> task.

Yes, but...

> The other way around, if the parent resumes the task and then gets
> frozen,

Yes ...

> then we'll wait until the task gets frozen.

how/where will we wait until the tracee gets frozen ?

Again, suppose that p->parent resumes p and gets frozen after the
task_is_traced(p) check and before the frozen(p->parent) check.

Then try_to_freeze_tasks() can succeed with todo == 0 and miss the
running "p" ?

> > > +	 * If stuck in STOPPED and the parent is FROZEN, we're frozen too.
> > > +	 */
> > > +	if (task_is_stopped(p))
> > > +		return frozen(rcu_dereference(p->real_parent));
> >
> > (you could use ->parent in this case too and unify this check with the
> > "traced" case above)
>
> Are you sure? The way I read the code ptrace_attach() will change
> ->parent, but STOPPED is controlled by the jobctl.

Yes, sorry I was not clear. let me add more details.

task_is_stopped() is only possible if task is not ptraced, see the
"if (!current->ptrace)" check before set_special_state(TASK_STOPPED)
in do_signal_stop(). And if the task is not traced, then
task->parent == task->real_parent.

> > I don't understand. How this connects to ->parent or ->real_parent?
> > SIGCONT can come from anywhere and wake this stopped task up?
>
> Could be me who's not understanding, I thought only the real parent
> could do that.

No, any task can do this, as long as check_kill_permission() succeeds.
Even the kernel can send SIGCONT, say, you can use F_SETSIG(SIGCONT).

> > I guess you do this to avoid freezable_schedule() in ptrace/signal_stop,
> > and we can't use TASK_STOPPED|TASK_FREEZABLE, it should not run after
> > thaw()... But see above, we can't rely on __frozen(parent).
>
> I do this because freezing puts a task in TASK_FROZEN, and that cannot
> preserve TAKS_STOPPED or TASK_TRACED without being subject to wakups

Yes, yes, this is what I tried to say.

Oleg.

