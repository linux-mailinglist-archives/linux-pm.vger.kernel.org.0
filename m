Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7E8A3BE986
	for <lists+linux-pm@lfdr.de>; Wed,  7 Jul 2021 16:14:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231786AbhGGORF (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 7 Jul 2021 10:17:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:33459 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231852AbhGGORC (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 7 Jul 2021 10:17:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1625667261;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=K8itidRGIGvj+JVs3lFjYaeET780+APBr7NU3fZfCkw=;
        b=Ro0/blvA1Tu5ey08BPwMsEEDW6/KUJ81U12B9WbLbAHVIURE+qNUQ2CcFbjf887qSrRRES
        kjXQCgfpPgy7pp6uOgp4Y0TciL1An4QnOlL0nEhEJzGovLP09xEiVcTmKYUiF+x6gO5oyD
        Dnb85a8LUbmZDWvqMPQxB1Ik+100glA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-525-iIeS_AvWNmeMMzoizWlEiw-1; Wed, 07 Jul 2021 10:14:18 -0400
X-MC-Unique: iIeS_AvWNmeMMzoizWlEiw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0ECEE804141;
        Wed,  7 Jul 2021 14:14:16 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.40.193.11])
        by smtp.corp.redhat.com (Postfix) with SMTP id 2785D1036D03;
        Wed,  7 Jul 2021 14:14:12 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Wed,  7 Jul 2021 16:14:15 +0200 (CEST)
Date:   Wed, 7 Jul 2021 16:14:12 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     rjw@rjwysocki.net, mingo@kernel.org, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, mgorman@suse.de,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        tj@kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v2 4/4] freezer,sched: Rewrite core freezer logic
Message-ID: <20210707141412.GA17818@redhat.com>
References: <20210624092156.332208049@infradead.org>
 <20210624092616.009504322@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210624092616.009504322@infradead.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

sorry for delay...

I am still trying to understand this series, just one note for now.

On 06/24, Peter Zijlstra wrote:
>
> +static bool __freeze_task(struct task_struct *p)
> +{
> +	unsigned long flags;
> +	unsigned int state;
> +	bool frozen = false;
> +
> +	raw_spin_lock_irqsave(&p->pi_lock, flags);
> +	state = READ_ONCE(p->__state);
> +	if (state & (TASK_FREEZABLE|__TASK_STOPPED|__TASK_TRACED)) {
> +		/*
> +		 * Only TASK_NORMAL can be augmented with TASK_FREEZABLE,
> +		 * since they can suffer spurious wakeups.
> +		 */
> +		if (state & TASK_FREEZABLE)
> +			WARN_ON_ONCE(!(state & TASK_NORMAL));
> +
> +#ifdef CONFIG_LOCKDEP
> +		/*
> +		 * It's dangerous to freeze with locks held; there be dragons there.
> +		 */
> +		if (!(state & __TASK_FREEZABLE_UNSAFE))
> +			WARN_ON_ONCE(debug_locks && p->lockdep_depth);
> +#endif
> +
> +		if (state & (__TASK_STOPPED|__TASK_TRACED))
> +			WRITE_ONCE(p->__state, TASK_FROZEN|__TASK_FROZEN_SPECIAL);

Well, this doesn't look right.

Firstly, this can race with ptrace_freeze_traced() which can set
p->__state = __TASK_TRACED and clear TASK_FROZEN. Or with
__set_current_state(TASK_RUNNING) in ptrace_stop().


But the main problem is that you can't simply remove __TASK_TRACED,
this can confuse the debugger, any ptrace() request will fail as if
the tracee was killed.


Another problem. Suppose that p->parent sleeps in do_wait(). p calls
ptrace_stop(), sets __TASK_TRACED, and wakes the parent up.

__freeze_task() clears __TASK_TRACED.

The parent calls wait_task_stopped(p) but it fails because
task_is_traced() returns false. The parent sleeps again, and forever
because __thaw_special() won't notify it.


Or. Suppose that __freeze_task() removes __TASK_STOPPED. The new
debugger comes, the tracee should switch from STOPPED to TRACED. But
this won't happen because task_is_stopped() in ptrace_() will return
false and task_set_jobctl_pending/signal_wake_up_state won't be called.

Oleg.

