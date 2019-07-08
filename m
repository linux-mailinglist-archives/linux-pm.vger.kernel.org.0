Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0715761DAB
	for <lists+linux-pm@lfdr.de>; Mon,  8 Jul 2019 13:09:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730358AbfGHLJJ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 8 Jul 2019 07:09:09 -0400
Received: from foss.arm.com ([217.140.110.172]:44956 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727668AbfGHLJI (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 8 Jul 2019 07:09:08 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E06FE14F6;
        Mon,  8 Jul 2019 04:09:07 -0700 (PDT)
Received: from e110439-lin (e110439-lin.cambridge.arm.com [10.1.194.43])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A77353F738;
        Mon,  8 Jul 2019 04:09:06 -0700 (PDT)
Date:   Mon, 8 Jul 2019 12:09:04 +0100
From:   Patrick Bellasi <patrick.bellasi@arm.com>
To:     Douglas Raillard <douglas.raillard@arm.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        mingo@redhat.com, rjw@rjwysocki.net, viresh.kumar@linaro.org,
        quentin.perret@arm.com, dietmar.eggemann@arm.com
Subject: Re: [RFC PATCH v2 0/5] sched/cpufreq: Make schedutil energy aware
Message-ID: <20190708110904.ecrlr4p77n4r6qzk@e110439-lin>
References: <20190627171603.14767-1-douglas.raillard@arm.com>
 <20190702155115.GW3436@hirez.programming.kicks-ass.net>
 <5198292b-1874-9ff4-6a9f-826a5ea00466@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5198292b-1874-9ff4-6a9f-826a5ea00466@arm.com>
User-Agent: NeoMutt/20180716
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 03-Jul 17:36, Douglas Raillard wrote:
> On 7/2/19 4:51 PM, Peter Zijlstra wrote:
> > On Thu, Jun 27, 2019 at 06:15:58PM +0100, Douglas RAILLARD wrote:

[...]

> > I'm not immediately seeing how it is transient; that is, PELT has a
> > wobble in it's steady state, is that accounted for?
> > 
> 
> The transient-ness of the ramp boost I'm introducing comes from the fact that for a
> periodic task at steady state, task_ue.enqueued <= task_u when the task is executing.
                ^^^^^^^^^^^^^^^

I find your above "at steady state" a bit confusing.

The condition "task_ue.enqueue <= task_u" is true only for the first
task's big activation after a series of small activations, e.g. a task
switching from 20% to 70%.

That's the transient stat you refer to, isn't it?

> That is because task_ue.enqueued is sampled at dequeue time, precisely at the moment
> at which task_u is reaching its max for that task.

Right, so in the example above we will have enqueued=20% while task_u
is going above to converge towards 70%

> Since we only take into account positive boosts, ramp boost will
> only have an impact in the "increase transients".

Right.

I think Peter was referring to the smallish wobbles we see when the
task already converged to 70%. If that's the case I would say they are
already fully covered also by the current util_est.

You are also correct in pointing out that in the steady state
ramp_boost will not be triggered in that steady state.

IMU, that's for two main reasons:
 a) it's very likely that enqueued <= util_avg
 b) even in case enqueued should turn out to be _slightly_ bigger then
    util_avg, the corresponding (proportional) ramp_boost would be so
    tiny to not have any noticeable effect on OPP selection.

Am I correct on point b) above?

Could you maybe come up with some experimental numbers related to that
case specifically?

Best,
Patrick

-- 
#include <best/regards.h>

Patrick Bellasi
