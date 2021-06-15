Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E0533A874C
	for <lists+linux-pm@lfdr.de>; Tue, 15 Jun 2021 19:15:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229557AbhFORRm (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 15 Jun 2021 13:17:42 -0400
Received: from foss.arm.com ([217.140.110.172]:41380 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229539AbhFORRm (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 15 Jun 2021 13:17:42 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4C72013D5;
        Tue, 15 Jun 2021 10:15:37 -0700 (PDT)
Received: from e120877-lin.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 10DA93F694;
        Tue, 15 Jun 2021 10:15:35 -0700 (PDT)
Date:   Tue, 15 Jun 2021 18:15:30 +0100
From:   Vincent Donnefort <vincent.donnefort@arm.com>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     peterz@infradead.org, rjw@rjwysocki.net,
        vincent.guittot@linaro.org, qperret@google.com,
        linux-pm@vger.kernel.org, ionela.voinescu@arm.com,
        lukasz.luba@arm.com, dietmar.eggemann@arm.com
Subject: Re: [PATCH v3 3/6] cpufreq: Add an interface to mark inefficient
 frequencies
Message-ID: <20210615171530.GA277695@e120877-lin.cambridge.arm.com>
References: <1622804761-126737-1-git-send-email-vincent.donnefort@arm.com>
 <1622804761-126737-4-git-send-email-vincent.donnefort@arm.com>
 <20210614072835.z2tjoaffcflry7pk@vireshk-i7>
 <20210614133522.GA34061@e120877-lin.cambridge.arm.com>
 <20210615050211.5gpx4faha6heytad@vireshk-i7>
 <20210615084418.GA167242@e120877-lin.cambridge.arm.com>
 <20210615101706.mabloqrmakeiwcf5@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210615101706.mabloqrmakeiwcf5@vireshk-i7>
User-Agent: Mutt/1.5.24 (2015-08-30)
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Jun 15, 2021 at 03:47:06PM +0530, Viresh Kumar wrote:
> On 15-06-21, 09:44, Vincent Donnefort wrote:
> > The cpufreq_policy is accessed through percpu data. I originally tried to get it
> > with cpufreq_cpu_get_raw(). But when we init the cpufreq driver (and by
> > extension when we call em_dev_register_perf_domain()), the percpu data isn't
> > updated yet.
> 
> Right.
> 
> > I guess the only way at that moment would be to propagate the cpufreq_policy
> > pointer through the functions parameters, which is a bit cumbersome, especially
> > as the EM can be used with devfreq as well and that em_dev_register_perf_domain()
> > can be called from dev_pm_opp_of_register_em()
> > 
> > Would we be ok with that?
> 
> No.
> 
> You only talked about freq_table earlier and that's all I checked :)
> 
> > I could use em_data_callback as well ... but that doesn't change the fact some
> > registration is going through dev_pm_opp_of_register_em() which has no knowledge
> > about the cpufreq_policy. Doesn't look a better approach.
> 
> The point is that I don't want cpufreq to carry this for users, we
> have EM today, tomorrow we may want to mark a frequency as inefficient
> from somewhere else. The call need to initiate from EM core.

In the current version of this patchset, any driver can mark inefficiencies
without relying on the EM, just by adding the flag CPUFREQ_INEFFICIENT_FREQ in
cpufreq_frequency_table.

Populating cpufreq_frequency_table from the EM in cpufreq was just an attempt to
a less intrusive set of changes.

> 
> And this isn't a cpufreq only thing, but is going to be generic along
> with other device types.
> 
> This is exactly why I asked you earlier to play with OPP core for
> this. That is the central place for data for all such users.
> 
> If this information is present at the OPP table (somehow), then we can
> just fix dev_pm_opp_init_cpufreq_table() to set this for cpufreq core
> as well.
> 
> This is the sequence that is followed in cpufreq drivers today:
> 
> dev_pm_opp_of_cpumask_add_table();
> dev_pm_opp_init_cpufreq_table();
> dev_pm_opp_of_register_em();
> 
> What about changing this to:
> 
> dev_pm_opp_of_cpumask_add_table();
> 
> /* Mark OPPs are inefficient here */
> dev_pm_opp_of_register_em();
> 
> /* This should automatically pick the right set */
> dev_pm_opp_init_cpufreq_table();
> 
> Will this break anything ?

Probably not, but with this approach I'll have to modify all the cpufreq drivers
that are registering the EM, which I tried to avoid as much as possible so far.

But if we sum-up:

1. em_dev_register_perf_domain() find inefficiencies

2. dev_pm_opp_of_register_em() apply EM inefficiencies into the OPP structures

   Note: scmi-cpufreq would need special treatment, as it doesn't rely
   dev_pm_opp_of_register_em().

3. dev_pm_opp_init_cpufreq_table() marks the cpufreq table with the OPP
   inefficiencies 

Guess it would ease the adoption by other OPP clients. However this patchset
will clearly get bigger.

Would you agree with that?
