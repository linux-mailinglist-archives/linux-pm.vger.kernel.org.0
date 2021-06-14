Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D6703A6AB4
	for <lists+linux-pm@lfdr.de>; Mon, 14 Jun 2021 17:42:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233933AbhFNPo6 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 14 Jun 2021 11:44:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:28285 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233482AbhFNPo6 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 14 Jun 2021 11:44:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623685375;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=IPwviCtPh++s8Xk5zz8ZTKLFy3Lywm0qH1bDrqc5rXg=;
        b=cr82mFeCitBxgXtFUwvKQnQGkfL9M980OLFJlz7EO8tmIvjLXZjZIKCv7U1sgiGJx2KphU
        2U/dEt4yREPXTGpjpsxzC9NsQLqyAdTFFiusAkyuGrmz8J4rjmLW0DIdNKsuT2Bs1V57qC
        7WN8Jgj/QRvMJnz7G+FgAgzmBRvkDzE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-512-25EVXOF9OUGRcT9s-qQWUg-1; Mon, 14 Jun 2021 11:42:53 -0400
X-MC-Unique: 25EVXOF9OUGRcT9s-qQWUg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BCEB3800D55;
        Mon, 14 Jun 2021 15:42:51 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.40.192.47])
        by smtp.corp.redhat.com (Postfix) with SMTP id 8D9B760C0F;
        Mon, 14 Jun 2021 15:42:48 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Mon, 14 Jun 2021 17:42:51 +0200 (CEST)
Date:   Mon, 14 Jun 2021 17:42:47 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     rjw@rjwysocki.net, mingo@kernel.org, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, mgorman@suse.de,
        Will Deacon <will@kernel.org>, Tejun Heo <tj@kernel.org>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH] freezer,sched: Rewrite core freezer logic
Message-ID: <20210614154246.GB13677@redhat.com>
References: <YMMijNqaLDbS3sIv@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YMMijNqaLDbS3sIv@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Peter, sorry for delay,

On 06/11, Peter Zijlstra wrote:
>
> +/* Recursion relies on tail-call optimization to not blow away the stack */
> +static bool __frozen(struct task_struct *p)
> +{
> +	if (p->state == TASK_FROZEN)
> +		return true;
> +
> +	/*
> +	 * If stuck in TRACED, and the ptracer is FROZEN, we're frozen too.
> +	 */
> +	if (task_is_traced(p))
> +		return frozen(rcu_dereference(p->parent));

Why does it use frozen(), not __frozen() ?

This looks racy, p->parent can resume this task and then enter
__refrigerator().

Plus this task can be SIGKILL'ed even if it is traced.


> +	/*
> +	 * If stuck in STOPPED and the parent is FROZEN, we're frozen too.
> +	 */
> +	if (task_is_stopped(p))
> +		return frozen(rcu_dereference(p->real_parent));

(you could use ->parent in this case too and unify this check with the
"traced" case above)

I don't understand. How this connects to ->parent or ->real_parent?
SIGCONT can come from anywhere and wake this stopped task up?


I guess you do this to avoid freezable_schedule() in ptrace/signal_stop,
and we can't use TASK_STOPPED|TASK_FREEZABLE, it should not run after
thaw()... But see above, we can't rely on __frozen(parent).

Oleg.

