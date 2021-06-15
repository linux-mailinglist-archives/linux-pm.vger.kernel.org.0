Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DE893A7942
	for <lists+linux-pm@lfdr.de>; Tue, 15 Jun 2021 10:44:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230455AbhFOIqh (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 15 Jun 2021 04:46:37 -0400
Received: from foss.arm.com ([217.140.110.172]:56856 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230454AbhFOIqf (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 15 Jun 2021 04:46:35 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9128DD6E;
        Tue, 15 Jun 2021 01:44:31 -0700 (PDT)
Received: from e120877-lin.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 18BE83F694;
        Tue, 15 Jun 2021 01:44:29 -0700 (PDT)
Date:   Tue, 15 Jun 2021 09:44:21 +0100
From:   Vincent Donnefort <vincent.donnefort@arm.com>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     peterz@infradead.org, rjw@rjwysocki.net,
        vincent.guittot@linaro.org, qperret@google.com,
        linux-pm@vger.kernel.org, ionela.voinescu@arm.com,
        lukasz.luba@arm.com, dietmar.eggemann@arm.com
Subject: Re: [PATCH v3 3/6] cpufreq: Add an interface to mark inefficient
 frequencies
Message-ID: <20210615084418.GA167242@e120877-lin.cambridge.arm.com>
References: <1622804761-126737-1-git-send-email-vincent.donnefort@arm.com>
 <1622804761-126737-4-git-send-email-vincent.donnefort@arm.com>
 <20210614072835.z2tjoaffcflry7pk@vireshk-i7>
 <20210614133522.GA34061@e120877-lin.cambridge.arm.com>
 <20210615050211.5gpx4faha6heytad@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210615050211.5gpx4faha6heytad@vireshk-i7>
User-Agent: Mutt/1.5.24 (2015-08-30)
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Jun 15, 2021 at 10:32:11AM +0530, Viresh Kumar wrote:
> On 14-06-21, 14:35, Vincent Donnefort wrote:
> > On Mon, Jun 14, 2021 at 12:58:35PM +0530, Viresh Kumar wrote:
> > > On 04-06-21, 12:05, Vincent Donnefort wrote:
> > > >  int cpufreq_table_validate_and_sort(struct cpufreq_policy *policy)
> > > >  {
> > > >  	int ret;
> > > > @@ -362,7 +409,13 @@ int cpufreq_table_validate_and_sort(struct cpufreq_policy *policy)
> > > >  	if (ret)
> > > >  		return ret;
> > > >  
> > > > -	return set_freq_table_sorted(policy);
> > > > +	ret = set_freq_table_sorted(policy);
> > > > +	if (ret)
> > > > +		return ret;
> > > > +
> > > > +	set_freq_table_efficiencies(policy);
> > > > +
> > > > +	return ret;
> > > >  }
> > > 
> > > Lets provide a single callback from the cpufreq core to do all
> > > settings related to efficient frequencies and call it from
> > > em_dev_register_perf_domain() ?
> > 
> > Sadly we cannot do it in em_dev_register_perf_domain(). This function is called
> > from the cpufreq driver init, when the table isn't available yet.
> 
> I looked at all the users of em_dev_register_perf_domain() and each
> one of them have the freq table ready at that point of time.

The cpufreq_policy is accessed through percpu data. I originally tried to get it
with cpufreq_cpu_get_raw(). But when we init the cpufreq driver (and by
extension when we call em_dev_register_perf_domain()), the percpu data isn't
updated yet.

I guess the only way at that moment would be to propagate the cpufreq_policy
pointer through the functions parameters, which is a bit cumbersome, especially
as the EM can be used with devfreq as well and that em_dev_register_perf_domain()
can be called from dev_pm_opp_of_register_em()

Would we be ok with that?

I could use em_data_callback as well ... but that doesn't change the fact some
registration is going through dev_pm_opp_of_register_em() which has no knowledge
about the cpufreq_policy. Doesn't look a better approach.

> 
> > > 
> > > So we only do them for the cpufreq drivers that register themselves
> > > with EM.
> > 
> > Currently, only the EM would set those inefficient OPPs. But it also gives the
> > possibility for individual drivers to set them, even if they do not use the EM.
> 
> This is exactly why I want those parts of the kernel to call a
> specific API to get this done. This shouldn't be done automatically by
> the cpufreq core.
> 
> -- 
> viresh
