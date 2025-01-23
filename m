Return-Path: <linux-pm+bounces-20899-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 10F5CA1ABF9
	for <lists+linux-pm@lfdr.de>; Thu, 23 Jan 2025 22:38:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC9241886B68
	for <lists+linux-pm@lfdr.de>; Thu, 23 Jan 2025 21:38:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5614B1C5F22;
	Thu, 23 Jan 2025 21:38:17 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E4D916EC19;
	Thu, 23 Jan 2025 21:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737668297; cv=none; b=hxbGnH6N1ZhuOc1AKhQeV3mW6iJSw6zHvzRnPJAzQBshzdRfr1mh8prpDMQMdYXWFNLpF2d+P4lD7Yarz+d3kd5eIL6N1rNaKTV9CnwK+gsSAl18QawF2lELQjDWuM5Dgukl037B9EBMl/tf1jEpZZOgdzWt3/FqbJohaCWBsb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737668297; c=relaxed/simple;
	bh=AFRfiADfsUNtzpUWIQTUffb02DMtezPq++wn4LFbveQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JtQvR9dJK0DKWnkFm8B6iFi+upqEstLuK5osR0DxVwErTQ5+JzkBAgxVyCI3eRHkEVjLvFjXGGhKfU/hJaI4DCiLR7yUEz1B4bDwOCoMAycPIzqQ4aLfGb4VLdZ3EVhxraDMZLi5I0xnKopYfW9uk/VTRwZ4o/eMSr490TPEKM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9D0DB1063;
	Thu, 23 Jan 2025 13:38:40 -0800 (PST)
Received: from arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3544A3F66E;
	Thu, 23 Jan 2025 13:38:09 -0800 (PST)
Date: Thu, 23 Jan 2025 22:37:29 +0100
From: Beata Michalska <beata.michalska@arm.com>
To: Vanshidhar Konda <vanshikonda@os.amperecomputing.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
	ionela.voinescu@arm.com, sudeep.holla@arm.com, will@kernel.org,
	catalin.marinas@arm.com, rafael@kernel.org, sumitg@nvidia.com,
	yang@os.amperecomputing.com, lihuisong@huawei.com,
	zhanjie9@hisilicon.com
Subject: Re: [PATCH v9 1/5] cpufreq: Allow arch_freq_get_on_cpu to return an
 error
Message-ID: <Z5K2mdin7hyPXIIP@arm.com>
References: <20250121084435.2839280-1-beata.michalska@arm.com>
 <20250121084435.2839280-2-beata.michalska@arm.com>
 <20250121104706.2gcegucb6hcuksrd@vireshk-i7>
 <Z4-52JUmR7A-7NJP@arm.com>
 <j4s4amaknobmjvoq7jf734h7oieob3qxr5eigsrawakgxltszy@6kixp27xhwn6>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <j4s4amaknobmjvoq7jf734h7oieob3qxr5eigsrawakgxltszy@6kixp27xhwn6>

On Tue, Jan 21, 2025 at 10:40:55AM -0800, Vanshidhar Konda wrote:
> On Tue, Jan 21, 2025 at 04:14:32PM +0100, Beata Michalska wrote:
> > On Tue, Jan 21, 2025 at 04:17:06PM +0530, Viresh Kumar wrote:
> > > On 21-01-25, 08:44, Beata Michalska wrote:
> > > > Allow arch_freq_get_on_cpu to return an error for cases when retrieving
> > > > current CPU frequency is not possible, whether that being due to lack of
> > > > required arch support or due to other circumstances when the current
> > > > frequency cannot be determined at given point of time.
> > > >
> > > > Signed-off-by: Beata Michalska <beata.michalska@arm.com>
> > > > ---
> > > >  arch/x86/kernel/cpu/aperfmperf.c | 2 +-
> > > >  arch/x86/kernel/cpu/proc.c       | 7 +++++--
> > > >  drivers/cpufreq/cpufreq.c        | 8 ++++----
> > > >  include/linux/cpufreq.h          | 2 +-
> > > >  4 files changed, 11 insertions(+), 8 deletions(-)
> > > >
> > > > diff --git a/arch/x86/kernel/cpu/aperfmperf.c b/arch/x86/kernel/cpu/aperfmperf.c
> > > > index f642de2ebdac..6cf31a1649c4 100644
> > > > --- a/arch/x86/kernel/cpu/aperfmperf.c
> > > > +++ b/arch/x86/kernel/cpu/aperfmperf.c
> > > > @@ -498,7 +498,7 @@ void arch_scale_freq_tick(void)
> > > >   */
> > > >  #define MAX_SAMPLE_AGE	((unsigned long)HZ / 50)
> > > >
> > > > -unsigned int arch_freq_get_on_cpu(int cpu)
> > > > +int arch_freq_get_on_cpu(int cpu)
> > > >  {
> > > >  	struct aperfmperf *s = per_cpu_ptr(&cpu_samples, cpu);
> > > >  	unsigned int seq, freq;
> > > > diff --git a/arch/x86/kernel/cpu/proc.c b/arch/x86/kernel/cpu/proc.c
> > > > index 41ed01f46bd9..d79f5845a463 100644
> > > > --- a/arch/x86/kernel/cpu/proc.c
> > > > +++ b/arch/x86/kernel/cpu/proc.c
> > > > @@ -86,9 +86,12 @@ static int show_cpuinfo(struct seq_file *m, void *v)
> > > >  		seq_printf(m, "microcode\t: 0x%x\n", c->microcode);
> > > >
> > > >  	if (cpu_has(c, X86_FEATURE_TSC)) {
> > > > -		unsigned int freq = arch_freq_get_on_cpu(cpu);
> > > > +		int freq = arch_freq_get_on_cpu(cpu);
> > > >
> > > > -		seq_printf(m, "cpu MHz\t\t: %u.%03u\n", freq / 1000, (freq % 1000));
> > > > +		if (freq <= 0)
> > > > +			seq_puts(m, "cpu MHz\t\t: Unknown\n");
> > > > +		else
> > > > +			seq_printf(m, "cpu MHz\t\t: %u.%03u\n", freq / 1000, (freq % 1000));
> > > >  	}
> > > >
> > > >  	/* Cache size */
> > > > diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> > > > index 418236fef172..6f45684483c4 100644
> > > > --- a/drivers/cpufreq/cpufreq.c
> > > > +++ b/drivers/cpufreq/cpufreq.c
> > > > @@ -728,18 +728,18 @@ show_one(cpuinfo_transition_latency, cpuinfo.transition_latency);
> > > >  show_one(scaling_min_freq, min);
> > > >  show_one(scaling_max_freq, max);
> > > >
> > > > -__weak unsigned int arch_freq_get_on_cpu(int cpu)
> > > > +__weak int arch_freq_get_on_cpu(int cpu)
> > > >  {
> > > > -	return 0;
> > > > +	return -EOPNOTSUPP;
> > > >  }
> > > >
> > > >  static ssize_t show_scaling_cur_freq(struct cpufreq_policy *policy, char *buf)
> > > >  {
> > > >  	ssize_t ret;
> > > > -	unsigned int freq;
> > > > +	int freq;
> > > >
> > > >  	freq = arch_freq_get_on_cpu(policy->cpu);
> > > > -	if (freq)
> > > > +	if (freq > 0)
> > > 
> > > >= ?
> > > 
> > > Since we can return error now, 0 should be considered a valid
> > > frequency value ?
> > Theoretically speaking - it should, though what would 0 actually
> > represent then ?
> I would think the value of 0 would be valid and should be interpreted in a
> product/architecture specific manner? From silicon behavior, to me only negative
> frequency values wouldn't make any sense.
Still not convinced as of when '0' could represent a valid frequency and what
that one would actually imply but I do not have that strong of an opinion here.
> 
> In Patch 1 of this series we interpret 0 as "Unknown" on a x86 system though. So
> for the sake of consistency should we consider 0 a valid value everywhere?
Yes, but on the other hand, showing 'Unknown' could be skipped entirely here as
the arch_freq_get_on_cpu for x86 is always providing a 'valid' frequency.
The change here was just to make things somewhat sane.
Note that the new attribute introduced in the following patch will utilise
potential error values from arch_freq_get_on_cpu though.

---
BR
Beata
> 
> Regards,
> Vanshi
> 
> > 
> > ---
> > BR
> > Beata
> > > 
> > > >  		ret = sysfs_emit(buf, "%u\n", freq);
> > > >  	else if (cpufreq_driver->setpolicy && cpufreq_driver->get)
> > > >  		ret = sysfs_emit(buf, "%u\n", cpufreq_driver->get(policy->cpu));
> > > > diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
> > > > index 7fe0981a7e46..02fd4746231d 100644
> > > > --- a/include/linux/cpufreq.h
> > > > +++ b/include/linux/cpufreq.h
> > > > @@ -1184,7 +1184,7 @@ static inline int of_perf_domain_get_sharing_cpumask(int pcpu, const char *list_
> > > >  }
> > > >  #endif
> > > >
> > > > -extern unsigned int arch_freq_get_on_cpu(int cpu);
> > > > +extern int arch_freq_get_on_cpu(int cpu);
> > > >
> > > >  #ifndef arch_set_freq_scale
> > > >  static __always_inline
> > > > --
> > > > 2.25.1
> > > 
> > > --
> > > viresh

