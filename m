Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A785F8779A
	for <lists+linux-pm@lfdr.de>; Fri,  9 Aug 2019 12:37:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726140AbfHIKhN (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 9 Aug 2019 06:37:13 -0400
Received: from foss.arm.com ([217.140.110.172]:45238 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726091AbfHIKhM (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 9 Aug 2019 06:37:12 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E35191596;
        Fri,  9 Aug 2019 03:37:11 -0700 (PDT)
Received: from queper01-lin (queper01-lin.cambridge.arm.com [10.1.195.48])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D64833F575;
        Fri,  9 Aug 2019 03:37:10 -0700 (PDT)
Date:   Fri, 9 Aug 2019 11:37:06 +0100
From:   Quentin Perret <quentin.perret@arm.com>
To:     Douglas Raillard <douglas.raillard@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, rjw@rjwysocki.net,
        viresh.kumar@linaro.org, agross@kernel.org
Subject: Re: [PATCH 1/2] cpufreq: drivers: Enable frequency invariance in
 qcom-cpufreq-hw
Message-ID: <20190809103704.fatayhzso2b62fmx@queper01-lin>
References: <20190808131857.21082-1-douglas.raillard@arm.com>
 <20190808173230.53ddupihjlr6uvne@queper01-lin>
 <14762a81-a81d-d05f-b42a-495dacb28168@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <14762a81-a81d-d05f-b42a-495dacb28168@arm.com>
User-Agent: NeoMutt/20171215
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Friday 09 Aug 2019 at 11:16:12 (+0100), Douglas Raillard wrote:
> Hi Quentin,
> 
> On 8/8/19 6:32 PM, Quentin Perret wrote:
> > Hi Douglas,
> > 
> > On Thursday 08 Aug 2019 at 14:18:57 (+0100), Douglas RAILLARD wrote:
> > > Add calls to arch_set_freq_scale() in qcom-cpufreq-hw driver to enable
> > > frequency invariance.
> > 
> > Is there a patch 2/2 ?
> 
> That slipped through when format-patch-ing unrelated commits, there is no 2nd patch.
> 
> > > 
> > > Signed-off-by: Douglas RAILLARD <douglas.raillard@arm.com>
> > > ---
> > >   drivers/cpufreq/qcom-cpufreq-hw.c | 10 +++++++++-
> > >   1 file changed, 9 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/cpufreq/qcom-cpufreq-hw.c b/drivers/cpufreq/qcom-cpufreq-hw.c
> > > index 4b0b50403901..3bd3b8b268d9 100644
> > > --- a/drivers/cpufreq/qcom-cpufreq-hw.c
> > > +++ b/drivers/cpufreq/qcom-cpufreq-hw.c
> > > @@ -34,9 +34,12 @@ static int qcom_cpufreq_hw_target_index(struct cpufreq_policy *policy,
> > >   					unsigned int index)
> > >   {
> > >   	void __iomem *perf_state_reg = policy->driver_data;
> > > +	unsigned long freq = policy->freq_table[index].frequency;
> > >   	writel_relaxed(index, perf_state_reg);
> > > +	arch_set_freq_scale(policy->related_cpus, freq,
> > > +			    policy->cpuinfo.max_freq);
> > >   	return 0;
> > >   }
> > > @@ -63,6 +66,7 @@ static unsigned int qcom_cpufreq_hw_fast_switch(struct cpufreq_policy *policy,
> > >   {
> > >   	void __iomem *perf_state_reg = policy->driver_data;
> > >   	int index;
> > > +	unsigned long freq;
> > >   	index = policy->cached_resolved_idx;
> > >   	if (index < 0)
> > > @@ -70,7 +74,11 @@ static unsigned int qcom_cpufreq_hw_fast_switch(struct cpufreq_policy *policy,
> > >   	writel_relaxed(index, perf_state_reg);
> > > -	return policy->freq_table[index].frequency;
> > > +	freq = policy->freq_table[index].frequency;
> > > +	arch_set_freq_scale(policy->related_cpus, freq,
> > > +			    policy->cpuinfo.max_freq);
> > > +
> > > +	return freq;
> > >   }
> > >   static int qcom_cpufreq_hw_read_lut(struct device *cpu_dev,
> > > -- 
> > > 2.22.0
> > 
> > Reviewed-by: Quentin Perret <quentin.perret@arm.com>
> > 
> > Thanks,
> > Quentin
> > 
> 
> Thanks,
> Douglas

Actually, one nit, the $subject should probably be formatted as:

  cpufreq: qcom-hw: invoke frequency-invariance setter function

for consistency with other patches in this area.

Thanks,
Quentin
