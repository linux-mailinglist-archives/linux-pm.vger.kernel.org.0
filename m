Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 91A3E4CC98
	for <lists+linux-pm@lfdr.de>; Thu, 20 Jun 2019 13:05:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726392AbfFTLFt (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 20 Jun 2019 07:05:49 -0400
Received: from foss.arm.com ([217.140.110.172]:59850 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726391AbfFTLFt (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 20 Jun 2019 07:05:49 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3C174360;
        Thu, 20 Jun 2019 04:05:48 -0700 (PDT)
Received: from e110439-lin (e110439-lin.cambridge.arm.com [10.1.194.43])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3785B3F718;
        Thu, 20 Jun 2019 04:05:47 -0700 (PDT)
Date:   Thu, 20 Jun 2019 12:05:42 +0100
From:   Patrick Bellasi <patrick.bellasi@arm.com>
To:     Douglas Raillard <douglas.raillard@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        mingo@redhat.com, peterz@infradead.org, quentin.perret@arm.com,
        dietmar.eggemann@arm.com
Subject: Re: [RFC PATCH 6/7] sched/cpufreq: Improve sugov_cpu_is_busy accuracy
Message-ID: <20190620110541.iweliy7vyzjvhahf@e110439-lin>
References: <20190508174301.4828-1-douglas.raillard@arm.com>
 <20190508174301.4828-7-douglas.raillard@arm.com>
 <20190516125552.hol3rasllhveekxq@e110439-lin>
 <e908b2ab-5c86-5be1-d3f0-36f2b26973c5@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e908b2ab-5c86-5be1-d3f0-36f2b26973c5@arm.com>
User-Agent: NeoMutt/20180716
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 19-Jun 17:19, Douglas Raillard wrote:
> Hi Patrick,

Hi!

> On 5/16/19 1:55 PM, Patrick Bellasi wrote:
> > On 08-May 18:43, douglas.raillard@arm.com wrote:
> > > From: Douglas RAILLARD <douglas.raillard@arm.com>
> > > 
> > > Avoid assuming a CPU is busy when it has begun being idle before
> > > get_next_freq() is called. This is achieved by making sure the CPU will
> > > not be detected as busy by other CPUs whenever its utilization is
> > > decreasing.
> > 
> > If I understand it correctly, what you are after here is a "metric"
> > which tells you (in a shared performance domain) if a CPU has been
> > busy for a certain amount of time.
> > You do that by reworking the way idle_calls are accounted for the
> > sugov_update_single() case.
> > 
> > That approach could work but it looks a bit convoluted in the way it's
> > coded and it's also difficult to exclude there could be corner cases
> > with wired behaviors.
> > Isn't that why you "fix" the saved_idle_calls counter after all?
> > 
> > What about a different approach where we:
> > 
> > 1. we annotate the timestamp a CPU wakes up from IDLE (last_wakeup_time)
> > 
> > 2. we use that annotated last_wake_time and the rq->nr_running to
> >     define the "cpu is busy" heuristic.
> > 
> > Looking at a sibling CPU, I think we can end up with two main cases:
> > 
> > 1. CPU's nr_running is == 0
> >     then we don't consider busy that CPU
> > 
> > 2. CPU's nr_running is  > 0
> >     then the CPU is busy iff
> >        (current_time - last_wakeup_tim) >= busy_threshold
> > 
> > Notice that, when a CPU is active, its rq clock is periodically
> > updated, at least once per tick. Thus, provided a tick time is not too
> > long to declare busy a CPU, then the above logic should work.
> > 
> > Perhaps the busy_threshold can also be defined considering the PELT
> > dynamics and starting from an expected utilization increase converted
> > in time.
> 
> After experimenting with quite a few combinations, I managed to get a heuristic
> based on util_avg and util_est_enqueued that seems to work better in my case.
> Key differences are:
> * this new heuristic only really takes into account CFS signals
>  (current one based on idle calls takes into account everything that executes
>   on a given CPU.)

Right, that should not be an issue. You are after boosting for CFS
tasks at the end, while for RT and DL we don't need boosting since
they have their own mechanisms.

> * it will mark a CPU as busy less often, since it should only trigger when
>   there is a change in the utilization of a currently enqueued tasks.

That sounds right too.

>   Util changes due to enqueue/dequeue will not trigger it, which IMHO
>   is desirable, since we only want to bias frequency selection
>   when we know that we don't have precise utilization values for the
>   enqueued tasks (because the task has changed its behavior).

Agree.

Best,
Patrick

-- 
#include <best/regards.h>

Patrick Bellasi
