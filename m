Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBD2327763F
	for <lists+linux-pm@lfdr.de>; Thu, 24 Sep 2020 18:08:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728453AbgIXQIt (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 24 Sep 2020 12:08:49 -0400
Received: from foss.arm.com ([217.140.110.172]:50000 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728448AbgIXQIt (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 24 Sep 2020 12:08:49 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 91D601396;
        Thu, 24 Sep 2020 09:08:48 -0700 (PDT)
Received: from localhost (unknown [10.1.199.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 329063F718;
        Thu, 24 Sep 2020 09:08:48 -0700 (PDT)
Date:   Thu, 24 Sep 2020 17:08:46 +0100
From:   Ionela Voinescu <ionela.voinescu@arm.com>
To:     Quentin Perret <qperret@google.com>
Cc:     mingo@redhat.com, peterz@infradead.org, vincent.guittot@linaro.org,
        catalin.marinas@arm.com, will@kernel.org, rjw@rjwysocki.net,
        viresh.kumar@linaro.org, dietmar.eggemann@arm.com,
        valentin.schneider@arm.com, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] condition EAS enablement on FI support
Message-ID: <20200924160846.GB17927@arm.com>
References: <20200924123937.20938-1-ionela.voinescu@arm.com>
 <20200924133727.GB3920949@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200924133727.GB3920949@google.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thursday 24 Sep 2020 at 14:37:27 (+0100), Quentin Perret wrote:
> On Thursday 24 Sep 2020 at 13:39:34 (+0100), Ionela Voinescu wrote:
> > Given the maturity gained by cpufreq-based Frequency Invariance (FI)
> > support following the patches at [1], this series conditions Energy
> > Aware Scheduling (EAS) enablement on a frequency invariant system.
> > 
> > Currently, EAS can be enabled on a system without FI support, leading
> > to incorrect (energy-wise) task placements. As no warning is emitted,
> > it could take some debugging effort to track the behavior back to the
> > lack of FI support; this series changes that by disabling EAS
> > (and advertising it) when FI support is missing.
> > 
> > The series is structured as follows:
> >  - 1/3 - create function that can rebuild the scheduling and EAS'
> >    performance domains if EAS' initial conditions change
> >  - 2/3 - condition EAS enablement on FI support
> >  - 3/3 - arm64: rebuild scheduling and performance domains in the
> >          case of late, counter-driven FI initialisation.
> 
> I'm still reading through this, but shouldn't patch 2 and 3 be swapped?
> Otherwise we have a weird state at patch 2 where EAS will fail to start
> (IIUC), which might not be ideal for bisection.
> 
> Thoughts?

I probably invented myself reasons for not doing it, like: without 2/3,
3/3 does not make any sense having and the scenario at 3/3 is currently
unlikely.

But it would definitely make it safer, so I'll change the order.

Thanks,
Ionela.

> 
> Cheers,
> Quentin
