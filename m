Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1B8D861DB2
	for <lists+linux-pm@lfdr.de>; Mon,  8 Jul 2019 13:13:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730311AbfGHLNx (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 8 Jul 2019 07:13:53 -0400
Received: from foss.arm.com ([217.140.110.172]:45042 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730294AbfGHLNx (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 8 Jul 2019 07:13:53 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4C85B360;
        Mon,  8 Jul 2019 04:13:52 -0700 (PDT)
Received: from e110439-lin (e110439-lin.cambridge.arm.com [10.1.194.43])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 123B63F738;
        Mon,  8 Jul 2019 04:13:50 -0700 (PDT)
Date:   Mon, 8 Jul 2019 12:13:49 +0100
From:   Patrick Bellasi <patrick.bellasi@arm.com>
To:     Douglas Raillard <douglas.raillard@arm.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        mingo@redhat.com, rjw@rjwysocki.net, viresh.kumar@linaro.org,
        quentin.perret@arm.com, dietmar.eggemann@arm.com
Subject: Re: [RFC PATCH v2 0/5] sched/cpufreq: Make schedutil energy aware
Message-ID: <20190708111348.o6o63jisbukuk64d@e110439-lin>
References: <20190627171603.14767-1-douglas.raillard@arm.com>
 <20190702154422.GV3436@hirez.programming.kicks-ass.net>
 <590e3dd9-ea4e-5230-d12c-d04bb3916e89@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <590e3dd9-ea4e-5230-d12c-d04bb3916e89@arm.com>
User-Agent: NeoMutt/20180716
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 03-Jul 14:38, Douglas Raillard wrote:
> Hi Peter,
> 
> On 7/2/19 4:44 PM, Peter Zijlstra wrote:
> > On Thu, Jun 27, 2019 at 06:15:58PM +0100, Douglas RAILLARD wrote:
> > > Make schedutil cpufreq governor energy-aware.
> > > 
> > > - patch 1 introduces a function to retrieve a frequency given a base
> > >    frequency and an energy cost margin.
> > > - patch 2 links Energy Model perf_domain to sugov_policy.
> > > - patch 3 updates get_next_freq() to make use of the Energy Model.
> > 
> > > 
> > > 1) Selecting the highest possible frequency for a given cost. Some
> > >     platforms can have lower frequencies that are less efficient than
> > >     higher ones, in which case they should be skipped for most purposes.
> > >     They can still be useful to give more freedom to thermal throttling
> > >     mechanisms, but not under normal circumstances.
> > >     note: the EM framework will warn about such OPPs "hertz/watts ratio
> > >     non-monotonically decreasing"
> > 
> > Humm, for some reason I was thinking we explicitly skipped those OPPs
> > and they already weren't used.
> > 
> > This isn't in fact so, and these first few patches make it so?
> 
> That's correct, the cost information about each OPP has been introduced recently in mainline
> by the energy model series. Without that info, the only way to skip them that comes to my
> mind is to set a policy min frequency, since these inefficient OPPs are usually located
> at the lower end.

Perhaps it's also worth to point out that the alternative approach you
point out above is a system wide solution.

While, the ramp_boost thingy you propose, it's a more fine grained
mechanisms which could be extended in the future to have a per-task
side. IOW, it could contribute to have better user-space hints, for
example to ramp_boost more certain tasks and not others.

Best,
Patrick

-- 
#include <best/regards.h>

Patrick Bellasi
