Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A32DB1ECD2C
	for <lists+linux-pm@lfdr.de>; Wed,  3 Jun 2020 12:07:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726788AbgFCKHe (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 3 Jun 2020 06:07:34 -0400
Received: from foss.arm.com ([217.140.110.172]:59482 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726787AbgFCKHd (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 3 Jun 2020 06:07:33 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5158F31B;
        Wed,  3 Jun 2020 03:07:32 -0700 (PDT)
Received: from bogus (unknown [10.37.12.118])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0D2653F305;
        Wed,  3 Jun 2020 03:07:29 -0700 (PDT)
Date:   Wed, 3 Jun 2020 11:07:27 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Xiongfeng Wang <wangxiongfeng2@huawei.com>, rjw@rjwysocki.net,
        guohanjun@huawei.com, ionela.voinescu@arm.com,
        Sudeep Holla <sudeep.holla@arm.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [Question]: about 'cpuinfo_cur_freq' shown in sysfs when the CPU
 is in idle state
Message-ID: <20200603100727.GB7259@bogus>
References: <f1773fdc-f6ef-ec28-0c0a-4a09e66ab63b@huawei.com>
 <20200603075200.hbyofgcyiwocl565@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200603075200.hbyofgcyiwocl565@vireshk-i7>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Jun 03, 2020 at 01:22:00PM +0530, Viresh Kumar wrote:
> On 02-06-20, 11:34, Xiongfeng Wang wrote:
> > Hi Viresh,
> > 
> > Sorry to disturb you about another problem as follows.
> > 
> > CPPC use the increment of Desired Performance counter and Reference Performance
> > counter to get the CPU frequency and show it in sysfs through
> > 'cpuinfo_cur_freq'. But ACPI CPPC doesn't specifically define the behavior of
> > these two counters when the CPU is in idle state, such as stop incrementing when
> > the CPU is in idle state.
> > 
> > ARMv8.4 Extension inctroduced support for the Activity Monitors Unit (AMU). The
> > processor frequency cycles and constant frequency cycles in AMU can be used as
> > Delivered Performance counter and Reference Performance counter. These two
> > counter in AMU does not increase when the PE is in WFI or WFE. So the increment
> > is zero when the PE is in WFI/WFE. This cause no issue because
> > 'cppc_get_rate_from_fbctrs()' in cppc_cpufreq driver will check the increment
> > and return the desired performance if the increment is zero.
> > 
> > But when the CPU goes into power down idle state, accessing these two counters
> > in AMU by memory-mapped address will return zero. Such as CPU1 went into power
> > down idle state and CPU0 try to get the frequency of CPU1. In this situation,
> > will display a very big value for 'cpuinfo_cur_freq' in sysfs. Do you have some
> > advice about this problem ?
> > 
> > I was thinking about an idea as follows. We can run 'cppc_cpufreq_get_rate()' on
> > the CPU to be measured, so that we can make sure the CPU is in C0 state when we
> > access the two counters. Also we can return the actual frequency rather than
> > desired performance when the CPU is in WFI/WFE. But this modification will
> > change the existing logical and I am not sure if this will cause some bad effect.
> > 
> > 
> > diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
> > index 257d726..ded3bcc 100644
> > --- a/drivers/cpufreq/cppc_cpufreq.c
> > +++ b/drivers/cpufreq/cppc_cpufreq.c
> > @@ -396,9 +396,10 @@ static int cppc_get_rate_from_fbctrs(struct cppc_cpudata *cpu,
> >         return cppc_cpufreq_perf_to_khz(cpu, delivered_perf);
> >  }
> > 
> > -static unsigned int cppc_cpufreq_get_rate(unsigned int cpunum)
> > +static int cppc_cpufreq_get_rate_cpu(void *info)
> >  {
> >         struct cppc_perf_fb_ctrs fb_ctrs_t0 = {0}, fb_ctrs_t1 = {0};
> > + unsigned int cpunum = *(unsigned int *)info;
> >         struct cppc_cpudata *cpu = all_cpu_data[cpunum];
> >         int ret;
> > 
> > @@ -418,6 +419,22 @@ static unsigned int cppc_cpufreq_get_rate(unsigned int cpunum)
> >         return cppc_get_rate_from_fbctrs(cpu, fb_ctrs_t0, fb_ctrs_t1);
> >  }
> > 
> > +static unsigned int cppc_cpufreq_get_rate(unsigned int cpunum)
> > +{
> > + unsigned int ret;
> > +
> > + ret = smp_call_on_cpu(cpunum, cppc_cpufreq_get_rate_cpu, &cpunum, true);
> > +
> > + /*
> > +  * convert negative error code to zero, otherwise we will display
> > +  * an odd value for 'cpuinfo_cur_freq' in sysfs
> > +  */
> > + if (ret < 0)
> > +         ret = 0;
> > +
> > + return ret;
> > +}
> > +
> >  static int cppc_cpufreq_set_boost(struct cpufreq_policy *policy, int state)
> >  {
> >         struct cppc_cpudata *cpudata;
> 
> I don't see any other sane solution, even if this brings the CPU back
> to normal state and waste power. We should be able to reliably provide
> value to userspace.
> 
> Rafael / Sudeep: What you do say ?

Agreed on returning 0 as it aligns with the semantics followed. We can't
return the last set/fetched value as it fails to align with the values
returned when CPU is not idle.

But I have another question. If we can detect that CPPC on some platforms
rely on CPU registers(I assume FFH registers here and not system/io/...
type of GAS registers), can we set dvfs_on_any_cpu(can't recall exact
flag name) to false if not already done to prevent such issues. Or I am
talking non-sense as it may be applicable only for _set operation and
not _get.

-- 
Regards,
Sudeep
