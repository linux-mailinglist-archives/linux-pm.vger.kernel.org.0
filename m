Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9AE0B6AAA9
	for <lists+linux-pm@lfdr.de>; Tue, 16 Jul 2019 16:34:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387748AbfGPOek (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 16 Jul 2019 10:34:40 -0400
Received: from foss.arm.com ([217.140.110.172]:35792 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726997AbfGPOek (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 16 Jul 2019 10:34:40 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AC16D337;
        Tue, 16 Jul 2019 07:34:39 -0700 (PDT)
Received: from e110439-lin (e110439-lin.cambridge.arm.com [10.1.194.43])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 597623F59C;
        Tue, 16 Jul 2019 07:34:37 -0700 (PDT)
Date:   Tue, 16 Jul 2019 15:34:35 +0100
From:   Patrick Bellasi <patrick.bellasi@arm.com>
To:     Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tejun Heo <tj@kernel.org>,
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
Subject: Re: [PATCH v11 4/5] sched/core: uclamp: Use TG's clamps to restrict
 TASK's clamps
Message-ID: <20190716143435.iwwd6fjr3udlqol4@e110439-lin>
References: <20190708084357.12944-1-patrick.bellasi@arm.com>
 <20190708084357.12944-5-patrick.bellasi@arm.com>
 <20190715164248.GA21982@blackbody.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190715164248.GA21982@blackbody.suse.cz>
User-Agent: NeoMutt/20180716
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 15-Jul 18:42, Michal Koutný wrote:
> On Mon, Jul 08, 2019 at 09:43:56AM +0100, Patrick Bellasi <patrick.bellasi@arm.com> wrote:
> > This mimics what already happens for a task's CPU affinity mask when the
> > task is also in a cpuset, i.e. cgroup attributes are always used to
> > restrict per-task attributes.
> If I am not mistaken when set_schedaffinity(2) call is made that results
> in an empty cpuset, the call fails with EINVAL [1].
> 
> If I track the code correctly, the values passed to sched_setattr(2) are
> checked against the trivial validity (umin <= umax) and later on, they
> are adjusted to match the effective clamping of the containing
> task_group. Is that correct?
> 
> If the user attempted to sched_setattr [a, b], and the effective uclamp
> was [c, d] such that [a, b] ∩ [c, d] = ∅, the set uclamp will be
> silently moved out of their intended range. Wouldn't it be better to
> return with EINVAL too when the intersection is empty (since the user
> supplied range won't be attained)?

You right for the cpuset case, but I don't think we never end up with
a "empty" set in the case of utilization clamping.

We limit clamps hierarchically in such a way that:

  clamp[clamp_id] = min(task::clamp[clamp_id],
                        tg::clamp[clamp_id],
                        system::clamp[clamp_id])

and we ensure, on top of the above that:

  clamp[UCLAMP_MIN] = min(clamp[UCLAMP_MIN], clamp[UCLAMP_MAX])

Since it's all and only about "capping" values, at the very extreme
case you can end up with:

  clamp[UCLAMP_MIN] = clamp[UCLAMP_MAX] = 0

but that's till a valid configuration.

Am I missing something?

Otherwise, I think the changelog sentence you quoted is just
misleading.  I'll remove it from v12 since it does not really clarify
anything more then the rest of the message.

Cheers,
Patrick

-- 
#include <best/regards.h>

Patrick Bellasi
