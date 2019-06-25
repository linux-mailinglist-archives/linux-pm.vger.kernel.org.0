Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6C3AC52820
	for <lists+linux-pm@lfdr.de>; Tue, 25 Jun 2019 11:31:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731346AbfFYJbt (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 25 Jun 2019 05:31:49 -0400
Received: from foss.arm.com ([217.140.110.172]:36740 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728506AbfFYJbt (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 25 Jun 2019 05:31:49 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3B040360;
        Tue, 25 Jun 2019 02:31:49 -0700 (PDT)
Received: from e110439-lin (e110439-lin.cambridge.arm.com [10.1.194.43])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D7C2C3F71E;
        Tue, 25 Jun 2019 02:31:46 -0700 (PDT)
Date:   Tue, 25 Jun 2019 10:31:44 +0100
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
Message-ID: <20190625093144.g6forddrdql5lotv@e110439-lin>
References: <20190621084217.8167-1-patrick.bellasi@arm.com>
 <20190621084217.8167-13-patrick.bellasi@arm.com>
 <20190622150332.GM657710@devbig004.ftw2.facebook.com>
 <20190624172906.3d3w6352ji4izjgo@e110439-lin>
 <20190624175215.GR657710@devbig004.ftw2.facebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190624175215.GR657710@devbig004.ftw2.facebook.com>
User-Agent: NeoMutt/20180716
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 24-Jun 10:52, Tejun Heo wrote:

> Hey, Patrick.

Hi,

> On Mon, Jun 24, 2019 at 06:29:06PM +0100, Patrick Bellasi wrote:
> > > I kinda wonder whether the term bandwidth is a bit confusing because
> > > it's also used for cpu.max/min.  Would just calling it frequency be
> > > clearer?
> > 
> > Maybe I should find a better way to express the concept above.
> > 
> > I agree that bandwidth is already used by cpu.{max,min}, what I want
> > to call out is that clamps allows to enrich that concept.
> > 
> > By hinting the scheduler on min/max required utilization we can better
> > defined the amount of actual CPU cycles required/allowed.
> > That's a bit more precise bandwidth control compared to just rely on
> > temporal runnable/period limits.
> 
> I see.  I wonder whether it's overloading the same term too subtly
> tho.  It's great to document how they interact but it *might* be
> easier for readers if a different term is used even if the meaning is
> essentially the same.  Anyways, it's a nitpick.  Please feel free to
> ignore.

Got it, will try come up with a better description in the v11 to avoid
confusion and better explain the "improvements" without polluting too
much the original concept.

> > > > +	tg = css_tg(of_css(of));
> > > > +	if (tg == &root_task_group) {
> > > > +		ret = -EINVAL;
> > > > +		goto out;
> > > > +	}
> > > 
> > > I don't think you need the above check.
> > 
> > Don't we want to forbid attributes tuning from the root group?
> 
> Yeah, that's enforced by NOT_ON_ROOT flag, right?

Oh right, since we don't show them we can't write them :)

> > > So, uclamp.max limits the maximum freq% can get and uclamp.min limits
> > > hte maximum freq% protection can get in the subtree.  Let's say
> > > uclamp.max is 50% and uclamp.min is 100%.
> > 
> > That's not possible, in the current implementation we always enforce
> > the limit (uclamp.max) to be _not smaller_ then the protection
> > (uclamp.min).
> > 
> > Indeed, in principle, it does not make sense to ask for a minimum
> > utilization (i.e. frequency boosting) which is higher then the
> > maximum allowed utilization (i.e. frequency capping).
> 
> Yeah, I'm trying to explain actually it does.
> 
> > > It means that protection is not limited but the actual freq% is
> > > limited upto 50%, which isn't necessarily invalid.
> > > For a simple example, a user might be saying
> > > that they want to get whatever protection they can get from its parent
> > > but wanna limit eventual freq at 50% and it isn't too difficult to
> > > imagine cases where the two knobs are configured separately especially
> > > configuration is being managed hierarchically / automatically.
> > 
> > That's not my understanding, in v10 by default when we create a
> > subgroup we assign it uclamp.min=0%, meaning that we don't boost
> > frequencies.
> > 
> > It seems instead that you are asking to set uclamp.min=100% by
> > default, so that the effective value will give us whatever the father
> > allow. Is that correct?
> 
> No, the defaults are fine.  I'm trying to say that min/max
> configurations don't need to be coupled like this and there are valid
> use cases where the configured min is higher than max when
> configurations are nested and managed automatically.
> 
> Limits always trump protection in effect of course but please don't
> limit what can be configured.

Got it, thanks!

Will fix it in v11.

> Thanks.
> 
> --
> tejun

Cheers,
Patrick

-- 
#include <best/regards.h>

Patrick Bellasi
