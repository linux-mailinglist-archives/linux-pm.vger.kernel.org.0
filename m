Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AEA174EB43
	for <lists+linux-pm@lfdr.de>; Fri, 21 Jun 2019 16:55:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726002AbfFUOzh (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 21 Jun 2019 10:55:37 -0400
Received: from foss.arm.com ([217.140.110.172]:33916 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725985AbfFUOzh (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 21 Jun 2019 10:55:37 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A70E028;
        Fri, 21 Jun 2019 07:55:36 -0700 (PDT)
Received: from e110439-lin (e110439-lin.cambridge.arm.com [10.1.194.43])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6D84D3F575;
        Fri, 21 Jun 2019 07:55:34 -0700 (PDT)
Date:   Fri, 21 Jun 2019 15:55:32 +0100
From:   Patrick Bellasi <patrick.bellasi@arm.com>
To:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc:     Ingo Molnar <mingo@redhat.com>,
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
Subject: Re: [PATCH v10 00/16] Add utilization clamping support
Message-ID: <20190621145532.dvghqs32zprl6ty2@e110439-lin>
References: <20190621084217.8167-1-patrick.bellasi@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190621084217.8167-1-patrick.bellasi@arm.com>
User-Agent: NeoMutt/20180716
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 21-Jun 09:42, Patrick Bellasi wrote:
> Hi all, this is a respin of:
> 
>   https://lore.kernel.org/lkml/20190515094459.10317-1-patrick.bellasi@arm.com/
> 
> which addresses all Tejun's concerns:
> 
>  - rename cgroup attributes to be cpu.uclamp.{min,max}
>  - update initialization of subgroups clamps to be "no clamps" by default
>  - use percentage rational numbers for clamp attributes, e.g. "12.34" for 12.34%.
> 
> by introducing modifications impacting only patches:
> 
>  [PATCH v10 12/16] sched/core: uclamp: Extend CPU's cgroup controller
>  [PATCH v10 13/16] sched/core: uclamp: Propagate parent clamps
> 
> The rest of the patches are the same as per in v9, they have been just rebased
> on top of:
> 
>    tj/cgroup.git	for-5.3
>    tip/tip.git		sched/core
> 
> AFAIU, all the first 11 patches have been code reviewed and should be at a
> "ready to merge" quality level. Please let me know if I'm wrong and there
> is something else I need/can to do on those patches.
> 
> Otherwise, now that we should have settled all the behavioral aspects, I'm

Regarding the behavioral aspects, here I have a report with some
simple tests for the current implementation:

   https://gist.github.com/derkling/519459b5a2be35d8681fbaf1d6efe225

There are a couple of sections at the end to test the "Delegation
Model" with both CGroups v1 and v2.

I'm sharing the link just in case it can be helpful to verify if what
has been implemented is actually matching what Tejun expects as a sane
cgroups interface.

Cheers,
Patrick

-- 
#include <best/regards.h>

Patrick Bellasi
