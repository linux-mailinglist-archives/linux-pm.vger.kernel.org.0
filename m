Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9C20DFDA03
	for <lists+linux-pm@lfdr.de>; Fri, 15 Nov 2019 10:55:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727128AbfKOJzn (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 15 Nov 2019 04:55:43 -0500
Received: from merlin.infradead.org ([205.233.59.134]:58710 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725829AbfKOJzn (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 15 Nov 2019 04:55:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=GtyCPw9XqiblXcSeWSKatoSztw4h8uQgEpbZa+XD5aU=; b=DLHHau4jKi+lKiykWEk5rBCJj
        pAhYhQBbDOwb1w4sy/tXlvQ+Xy8HXvaSLxIWZvQy8f6vLKr5rpeBrv0fpRF6iMf4wDZ6iyvHjyMMX
        i3Z4wXCJeRubxds/5mlieBaqon4tEkvamFVnDMpPuOu1uB7SoWtzcxYMkIeiXW/FELt8/jWeQD7NV
        Gb4iOhUCbKRlmgVrlAGyRtkILykoYn9j0/AdsWCPTy5Ts+oXjyg9lIyAubzffFoW0CBjT6ZMbAUNa
        ja+3zenTuQUwVxx36CadfaIk8LxtuYT1zmp0LLUzaJbI71qx/bnXEqtDN3mgp0QSQ5D0i69iv0zZe
        NrVhB0yAQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iVYJY-0005qz-0D; Fri, 15 Nov 2019 09:54:52 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 371323006FB;
        Fri, 15 Nov 2019 10:53:39 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 2C10C29E4EBB3; Fri, 15 Nov 2019 10:54:47 +0100 (CET)
Date:   Fri, 15 Nov 2019 10:54:47 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     linux-kernel@vger.kernel.org, mingo@redhat.com,
        dietmar.eggemann@arm.com, juri.lelli@redhat.com,
        rostedt@goodmis.org, mgorman@suse.de, dsmythies@telus.net,
        linux-pm@vger.kernel.org, torvalds@linux-foundation.org,
        tglx@linutronix.de, sargun@sargun.me, tj@kernel.org,
        xiexiuqi@huawei.com, xiezhipeng1@huawei.com,
        srinivas.pandruvada@linux.intel.com
Subject: Re: [PATCH v4] sched/freq: move call to cpufreq_update_util
Message-ID: <20191115095447.GU4114@hirez.programming.kicks-ass.net>
References: <1573751251-3505-1-git-send-email-vincent.guittot@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1573751251-3505-1-git-send-email-vincent.guittot@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Nov 14, 2019 at 06:07:31PM +0100, Vincent Guittot wrote:
> update_cfs_rq_load_avg() calls cfs_rq_util_change() everytime pelt decays,
> which might be inefficient when cpufreq driver has rate limitation.
> 
> When a task is attached on a CPU, we have call path:
> 
> update_load_avg()
>   update_cfs_rq_load_avg()
>     cfs_rq_util_change -- > trig frequency update
>   attach_entity_load_avg()
>     cfs_rq_util_change -- > trig frequency update
> 
> The 1st frequency update will not take into account the utilization of the
> newly attached task and the 2nd one might be discard because of rate
> limitation of the cpufreq driver.

Doesn't this just show that a dumb rate limit in the driver is broken?

> update_cfs_rq_load_avg() is only called by update_blocked_averages()
> and update_load_avg() so we can move the call to
> cfs_rq_util_change/cpufreq_update_util() into these 2 functions. It's also
> interesting to notice that update_load_avg() already calls directly
> cfs_rq_util_change() for !SMP case.
> 
> This changes will also ensure that cpufreq_update_util() is called even
> when there is no more CFS rq in the leaf_cfs_rq_list to update but only
> irq, rt or dl pelt signals.

I don't think it does that; that is, iirc the return value of
___update_load_sum() is 1 every time a period lapses. So even if the avg
is 0 and doesn't change, it'll still return 1 on every period.

Which is what that dumb rate-limit thing wants of course. But I'm still
thinking that it's stupid to do. If nothing changes, don't generate
events.

If anything, update_blocked_avgerages() should look at
@done/others_have_blocked() to emit events for rt,dl,irq.

So why are we making the scheduler code more ugly instead of fixing that
driver?
