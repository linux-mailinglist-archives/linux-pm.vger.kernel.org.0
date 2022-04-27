Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60B5C511B88
	for <lists+linux-pm@lfdr.de>; Wed, 27 Apr 2022 16:58:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235360AbiD0PAM (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 27 Apr 2022 11:00:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239034AbiD0PAL (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 27 Apr 2022 11:00:11 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 22F867C175
        for <linux-pm@vger.kernel.org>; Wed, 27 Apr 2022 07:57:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651071419;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ntMBAFtwiC9qpWMmFF/p+IGii2jJjeJe+SyCWkAlVJI=;
        b=D971mpPD6vy0jZs8Fl9IRi8kcsTkn1yVBPz6+76ccjRRlqiZoxEp9Q3s3BMnsVakrp61FW
        lFRNtuRCCULW7jgETFhnTiatN95S9E53+zALwqtZFl0uxpvBqtlWblx6XHU/vx0QtlAtcC
        BuW236Ncf5ufUHKhGjFwRKUD9nKK958=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-643-oLs-316kMymZlYXURsAZcw-1; Wed, 27 Apr 2022 10:56:55 -0400
X-MC-Unique: oLs-316kMymZlYXURsAZcw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C53CF8039D7;
        Wed, 27 Apr 2022 14:56:54 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.40.192.128])
        by smtp.corp.redhat.com (Postfix) with SMTP id D07F714A5061;
        Wed, 27 Apr 2022 14:56:48 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Wed, 27 Apr 2022 16:56:54 +0200 (CEST)
Date:   Wed, 27 Apr 2022 16:56:47 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     linux-kernel@vger.kernel.org, rjw@rjwysocki.net, mingo@kernel.org,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, mgorman@suse.de, bigeasy@linutronix.de,
        Will Deacon <will@kernel.org>, tj@kernel.org,
        linux-pm@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        linux-um@lists.infradead.org, Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>,
        inux-xtensa@linux-xtensa.org, Kees Cook <keescook@chromium.org>,
        Jann Horn <jannh@google.com>
Subject: Re: [PATCH 6/9] signal: Always call do_notify_parent_cldstop with
 siglock held
Message-ID: <20220427145646.GC17421@redhat.com>
References: <878rrrh32q.fsf_-_@email.froward.int.ebiederm.org>
 <20220426225211.308418-6-ebiederm@xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220426225211.308418-6-ebiederm@xmission.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.7
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 04/26, Eric W. Biederman wrote:
>
> @@ -2209,6 +2213,34 @@ static int ptrace_stop(int exit_code, int why, int clear_code,
>  		spin_lock_irq(&current->sighand->siglock);
>  	}
>  
> +	/* Don't stop if current is not ptraced */
> +	if (unlikely(!current->ptrace))
> +		return (clear_code) ? 0 : exit_code;
> +
> +	/*
> +	 * If @why is CLD_STOPPED, we're trapping to participate in a group
> +	 * stop.  Do the bookkeeping.  Note that if SIGCONT was delievered
> +	 * across siglock relocks since INTERRUPT was scheduled, PENDING
> +	 * could be clear now.  We act as if SIGCONT is received after
> +	 * TASK_TRACED is entered - ignore it.
> +	 */
> +	if (why == CLD_STOPPED && (current->jobctl & JOBCTL_STOP_PENDING))
> +		gstop_done = task_participate_group_stop(current);
> +
> +	/*
> +	 * Notify parents of the stop.
> +	 *
> +	 * While ptraced, there are two parents - the ptracer and
> +	 * the real_parent of the group_leader.  The ptracer should
> +	 * know about every stop while the real parent is only
> +	 * interested in the completion of group stop.  The states
> +	 * for the two don't interact with each other.  Notify
> +	 * separately unless they're gonna be duplicates.
> +	 */
> +	do_notify_parent_cldstop(current, true, why);
> +	if (gstop_done && ptrace_reparented(current))
> +		do_notify_parent_cldstop(current, false, why);

This doesn't look right too. The parent should be notified only after
we set __state = TASK_TRACED and ->exit code.

Suppose that debugger sleeps in do_wait(). do_notify_parent_cldstop()
wakes it up, debugger calls wait_task_stopped() and then it will sleep
again, task_stopped_code() returns 0.

This can be probably fixed if you remove the lockless (fast path)
task_stopped_code() check in wait_task_stopped(), but this is not
nice performance-wise...

Oleg.

