Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7183615D8A1
	for <lists+linux-pm@lfdr.de>; Fri, 14 Feb 2020 14:37:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728437AbgBNNhS (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 14 Feb 2020 08:37:18 -0500
Received: from merlin.infradead.org ([205.233.59.134]:41526 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728083AbgBNNhS (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 14 Feb 2020 08:37:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Ue0dwM4RxyC5uuLjE0GUrxieeodoakuxvnrithwTIGM=; b=k37+qER6Nz1Y/fLSCN0cd8pmRV
        Nzd0eOo1xzqy1MFmt1z3/A/nVaGblkzZ01vqwlm5UuSxYRrIsvoCYKx4oYc5n2hqJ1Va4fr6Jvr8W
        hZhlxPoZv2u5t3Iu1ZveFtd83tzoavmh6z0qKN1SIanztujXi1p0Ldh/8E9WK1VvcZw4FbykWNpiw
        vmw8LLdW7poBZnKsryROvGPf1ykPa/EmtZ90zuN8w4S+tqDcP142Gh5UXosidUjxbgaPkTFbYNILI
        2xwoUDBj3GIJELfeDW7ArJoRkbSbeduKbUcwrVQPS92/RL68UhUUr5hJq8riWBfkYWL1bLGlDHKJT
        5q1x39vA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j2b9b-0003Kl-D5; Fri, 14 Feb 2020 13:37:11 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 8049330257C;
        Fri, 14 Feb 2020 14:35:18 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 6CCBE20206D9B; Fri, 14 Feb 2020 14:37:08 +0100 (CET)
Date:   Fri, 14 Feb 2020 14:37:08 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Douglas Raillard <douglas.raillard@arm.com>
Cc:     linux-kernel@vger.kernel.org, rjw@rjwysocki.net,
        viresh.kumar@linaro.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        qperret@google.com, linux-pm@vger.kernel.org
Subject: Re: [RFC PATCH v4 0/6] sched/cpufreq: Make schedutil energy aware
Message-ID: <20200214133708.GM14879@hirez.programming.kicks-ass.net>
References: <20200122173538.1142069-1-douglas.raillard@arm.com>
 <c49ca012-bb3e-580d-9b45-359caa67d7c1@arm.com>
 <20200210132133.GH14897@hirez.programming.kicks-ass.net>
 <4a664419-f5a6-882f-83ee-5bbf20ff33d3@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4a664419-f5a6-882f-83ee-5bbf20ff33d3@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Feb 13, 2020 at 05:49:48PM +0000, Douglas Raillard wrote:

> > description of it all somewhere.
> 
> Now a textual version of it:
> 
> em_pd_get_higher_freq() does the following:
> 
> # Turn the abstract cost margin on the EM_COST_MARGIN_SCALE into a
> # concrete value. cost_margin=EM_COST_MARGIN_SCALE will give a concrete
> # value of "max_cost", which is the highest OPP on that CPU.
> concrete_margin = (cost_margin * max_cost) / EM_COST_MARGIN_SCALE;
> 
> # Then it finds the lowest OPP satisfying min_freq:
> min_opp = OPP_AT_FREQ(min_freq)
> 
> # It takes the cost associated, and finds the highest OPP that has a
> # cost lower than that:
> max_cost = COST_OF(min_opp) + concrete_margin
> 
> final_freq = MAX(
> 	FREQ_OF(opp)
> 	for opp in available_opps
> 	if COST_OF(opp) <= max_cost
> )

Right; I got that.

> So this means that:
>    util - util_est_enqueued ~= 0

Only if you assume the task will get scheduled out reasonably frequent.

> => cost_margin              ~= 0
> => concrete_cost_margin     ~= 0
> => max_cost   = COST_OF(min_opp) + 0
> => final_freq = FREQ_OF(min_opp)
> 
> The effective boost is ~0, so you will get the current behaviour of
> schedutil.

But the argument holds; because if things don't get scheduled out, we'll
peg u = 1 and hit f = 1 and all is well anyway.

Which is a useful property; it shows that in the steady state, this
patch-set is a NOP, but the above argument only relies on 'util_avg >
util_est' being used a trigger.

> If the task starts needing more cycles than during its previous period,
> `util - util_est_enqueued` will grow like util since util_est_enqueued
> is constant. The longer we wait, the higher the boost, until the task
> goes to sleep again.
> 
> At next wakeup, util_est_enqueued has caught up and either:
> 1) util becomes stable, so no more boosting
> 2) util keeps increasing, so go for another round of boosting

Agreed; however elsewhere you wrote:

> 1) If you care more about predictable battery life (or energy bill) than
> predictability of the boost feature, EM should be used.
>
> 2) If you don't have an EM or you care more about having a predictable
> boost for a given workload, use util (or disable that boost).

This is the part I'm still not sure about; how do the specifics of the
cost_margin setup lead to 1), or how would some frobbing with frequency
selection destroy that property.
