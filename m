Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EA37B63469
	for <lists+linux-pm@lfdr.de>; Tue,  9 Jul 2019 12:38:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726108AbfGIKiR (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 9 Jul 2019 06:38:17 -0400
Received: from foss.arm.com ([217.140.110.172]:41194 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725947AbfGIKiQ (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 9 Jul 2019 06:38:16 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EFEF92B;
        Tue,  9 Jul 2019 03:38:15 -0700 (PDT)
Received: from e110439-lin (e110439-lin.cambridge.arm.com [10.1.194.43])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B60603F738;
        Tue,  9 Jul 2019 03:38:14 -0700 (PDT)
Date:   Tue, 9 Jul 2019 11:37:50 +0100
From:   Patrick Bellasi <patrick.bellasi@arm.com>
To:     Douglas Raillard <douglas.raillard@arm.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        mingo@redhat.com, rjw@rjwysocki.net, viresh.kumar@linaro.org,
        quentin.perret@arm.com, dietmar.eggemann@arm.com
Subject: Re: [RFC PATCH v2 0/5] sched/cpufreq: Make schedutil energy aware
Message-ID: <20190709103750.hnm4bav6tjy7g37u@e110439-lin>
References: <20190627171603.14767-1-douglas.raillard@arm.com>
 <20190702155115.GW3436@hirez.programming.kicks-ass.net>
 <5198292b-1874-9ff4-6a9f-826a5ea00466@arm.com>
 <20190708110904.ecrlr4p77n4r6qzk@e110439-lin>
 <b35c2281-4d91-2164-65f9-9ef3a28c35d0@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b35c2281-4d91-2164-65f9-9ef3a28c35d0@arm.com>
User-Agent: NeoMutt/20180716
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 08-Jul 14:46, Douglas Raillard wrote:
> Hi Patrick,
> 
> On 7/8/19 12:09 PM, Patrick Bellasi wrote:
> > On 03-Jul 17:36, Douglas Raillard wrote:
> > > On 7/2/19 4:51 PM, Peter Zijlstra wrote:
> > > > On Thu, Jun 27, 2019 at 06:15:58PM +0100, Douglas RAILLARD wrote:

[...]

> > You are also correct in pointing out that in the steady state
> > ramp_boost will not be triggered in that steady state.
> > 
> > IMU, that's for two main reasons:
> >   a) it's very likely that enqueued <= util_avg
> >   b) even in case enqueued should turn out to be _slightly_ bigger then
> >      util_avg, the corresponding (proportional) ramp_boost would be so
> >      tiny to not have any noticeable effect on OPP selection.
> > 
> > Am I correct on point b) above?
> 
> Assuming you meant "util_avg slightly bigger than enqueued" (which is when boosting triggers),
> then yes since ramp_boost effect is proportional to "task_ue.enqueue - task_u". It makes it robust
> against that.

Right :)

> > Could you maybe come up with some experimental numbers related to that
> > case specifically?
> 
> With:
> * an rt-app task ramping up from 5% to 75% util in one big step. The
> whole cycle is 0.6s long (0.3s at 5% followed by 0.3s at 75%). This
> cycle is repeated 20 times and the average of boosting is taken.
> 
> * a hikey 960 (this impact the frequency at which the test runs at
> the beginning of 75% phase, which impacts the number of missed
> activations before the util ramped up).
> 
> * assuming an OPP exists for each util value (i.e. 1024 OPPs, so the
> effect of boost on consumption is not impacted by OPP capacities
> granularity)
> 
> Then the boosting feature would increase the average power
> consumption by 3.1%, out of which 0.12% can be considered "spurious
> boosting" due to the util taking some time to really converge to its
> steady state value.
>
> In practice, the impact of small boosts will be even lower since
> they will less likely trigger the selection of a high OPP due to OPP
> capacity granularity > 1 util unit.

That's ok for the energy side: you estimate a ~3% worst case more
energy on that specific target.

By boosting I expect the negative boost to improve.
Do you have also numbers/stats related to the negative slack?
Can you share a percentage figure for that improvement?

Best,
Patrick

-- 
#include <best/regards.h>

Patrick Bellasi
