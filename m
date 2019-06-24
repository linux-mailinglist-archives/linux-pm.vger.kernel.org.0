Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4B29151988
	for <lists+linux-pm@lfdr.de>; Mon, 24 Jun 2019 19:29:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732433AbfFXR3L (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 24 Jun 2019 13:29:11 -0400
Received: from foss.arm.com ([217.140.110.172]:55422 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726009AbfFXR3L (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 24 Jun 2019 13:29:11 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 71F36360;
        Mon, 24 Jun 2019 10:29:10 -0700 (PDT)
Received: from e110439-lin (e110439-lin.cambridge.arm.com [10.1.194.43])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 37EB03F718;
        Mon, 24 Jun 2019 10:29:08 -0700 (PDT)
Date:   Mon, 24 Jun 2019 18:29:06 +0100
From:   Patrick Bellasi <patrick.bellasi@arm.com>
To:     Tejun Heo <tj@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Paul Turner <pjt@google.com>,
        Quentin Perret <quentin.perret@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Todd Kjos <tkjos@google.com>,
        Joel Fernandes <joelaf@google.com>,
        Steve Muckle <smuckle@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Alessio Balsini <balsini@android.com>
Subject: Re: [PATCH v10 12/16] sched/core: uclamp: Extend CPU's cgroup
 controller
Message-ID: <20190624172906.3d3w6352ji4izjgo@e110439-lin>
References: <20190621084217.8167-1-patrick.bellasi@arm.com>
 <20190621084217.8167-13-patrick.bellasi@arm.com>
 <20190622150332.GM657710@devbig004.ftw2.facebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190622150332.GM657710@devbig004.ftw2.facebook.com>
User-Agent: NeoMutt/20180716
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 22-Jun 08:03, Tejun Heo wrote:
> Hello,

Hi,

> Generally looks good to me.  Some nitpicks.
> 
> On Fri, Jun 21, 2019 at 09:42:13AM +0100, Patrick Bellasi wrote:
> > @@ -951,6 +951,12 @@ controller implements weight and absolute bandwidth limit models for
> >  normal scheduling policy and absolute bandwidth allocation model for
> >  realtime scheduling policy.
> > 
> > +Cycles distribution is based, by default, on a temporal base and it
> > +does not account for the frequency at which tasks are executed.
> > +The (optional) utilization clamping support allows to enforce a minimum
> > +bandwidth, which should always be provided by a CPU, and a maximum bandwidth,
> > +which should never be exceeded by a CPU.
> 
> I kinda wonder whether the term bandwidth is a bit confusing because
> it's also used for cpu.max/min.  Would just calling it frequency be
> clearer?

Maybe I should find a better way to express the concept above.

I agree that bandwidth is already used by cpu.{max,min}, what I want
to call out is that clamps allows to enrich that concept.

By hinting the scheduler on min/max required utilization we can better
defined the amount of actual CPU cycles required/allowed.
That's a bit more precise bandwidth control compared to just rely on
temporal runnable/period limits.

> > +static ssize_t cpu_uclamp_min_write(struct kernfs_open_file *of,
> > +				    char *buf, size_t nbytes,
> > +				    loff_t off)
> > +{
> > +	struct task_group *tg;
> > +	u64 min_value;
> > +	int ret;
> > +
> > +	ret = uclamp_scale_from_percent(buf, &min_value);
> > +	if (ret)
> > +		return ret;
> > +	if (min_value > SCHED_CAPACITY_SCALE)
> > +		return -ERANGE;
> > +
> > +	rcu_read_lock();
> > +
> > +	tg = css_tg(of_css(of));
> > +	if (tg == &root_task_group) {
> > +		ret = -EINVAL;
> > +		goto out;
> > +	}
> 
> I don't think you need the above check.

Don't we want to forbid attributes tuning from the root group?

> > +	if (tg->uclamp_req[UCLAMP_MIN].value == min_value)
> > +		goto out;
> > +	if (tg->uclamp_req[UCLAMP_MAX].value < min_value) {
> > +		ret = -EINVAL;
> 
> So, uclamp.max limits the maximum freq% can get and uclamp.min limits
> hte maximum freq% protection can get in the subtree.  Let's say
> uclamp.max is 50% and uclamp.min is 100%.

That's not possible, in the current implementation we always enforce
the limit (uclamp.max) to be _not smaller_ then the protection
(uclamp.min).

Indeed, in principle, it does not make sense to ask for a minimum
utilization (i.e. frequency boosting) which is higher then the
maximum allowed utilization (i.e. frequency capping).


> It means that protection is not limited but the actual freq% is
> limited upto 50%, which isn't necessarily invalid.
> For a simple example, a user might be saying
> that they want to get whatever protection they can get from its parent
> but wanna limit eventual freq at 50% and it isn't too difficult to
> imagine cases where the two knobs are configured separately especially
> configuration is being managed hierarchically / automatically.

That's not my understanding, in v10 by default when we create a
subgroup we assign it uclamp.min=0%, meaning that we don't boost
frequencies.

It seems instead that you are asking to set uclamp.min=100% by
default, so that the effective value will give us whatever the father
allow. Is that correct?

> tl;dr is that we don't need the above restriction and shouldn't
> generally be restricting configurations when they don't need to.
> 
> Thanks.
> 
> -- 
> tejun

Cheers,
Patrick

-- 
#include <best/regards.h>

Patrick Bellasi
