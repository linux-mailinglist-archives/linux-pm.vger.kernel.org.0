Return-Path: <linux-pm+bounces-20772-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 61150A180D7
	for <lists+linux-pm@lfdr.de>; Tue, 21 Jan 2025 16:15:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0932018887D3
	for <lists+linux-pm@lfdr.de>; Tue, 21 Jan 2025 15:15:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B080F14EC5B;
	Tue, 21 Jan 2025 15:15:23 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62184EBE;
	Tue, 21 Jan 2025 15:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737472523; cv=none; b=oIJXhxn5BzXVv4DdM3L82Bsyfk+e9D3uPTQBBBXr4aQCbK1Ap1sYDP22NkZucVBMjSl5xPstkJSc+dDVr0YnnQINCymwMnmV1khm+CsreF09Ac7UTs4VhbqdFzaFUaHXSjuAogT6s8rBR3qR5kCBg5JBxoMGhjWTlpVXpbvXCFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737472523; c=relaxed/simple;
	bh=+n+sIJXaTD1gGUpYrtaMwNZ9Xm0JBUHoumwhed+5Nao=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GylwHNhx7VKyqAEgHRKjj88/7wqWljNSzw9SPefHsbaLMAGVqWdBCLq2CTgvJh4XqBPOKsG9oKl4yAMfE8Rob9Ocas7GZZy5f1GbhtbyJJapSlM5nALjI60QPjyVTYSN4fXHb9qCodJ+CWdkE/x3pz/GQp6dZVgOnHs0526bHsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C7ED31063;
	Tue, 21 Jan 2025 07:15:48 -0800 (PST)
Received: from arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BB5E33F66E;
	Tue, 21 Jan 2025 07:15:16 -0800 (PST)
Date: Tue, 21 Jan 2025 16:14:32 +0100
From: Beata Michalska <beata.michalska@arm.com>
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-pm@vger.kernel.org, ionela.voinescu@arm.com,
	sudeep.holla@arm.com, will@kernel.org, catalin.marinas@arm.com,
	rafael@kernel.org, sumitg@nvidia.com, yang@os.amperecomputing.com,
	vanshikonda@os.amperecomputing.com, lihuisong@huawei.com,
	zhanjie9@hisilicon.com
Subject: Re: [PATCH v9 1/5] cpufreq: Allow arch_freq_get_on_cpu to return an
 error
Message-ID: <Z4-52JUmR7A-7NJP@arm.com>
References: <20250121084435.2839280-1-beata.michalska@arm.com>
 <20250121084435.2839280-2-beata.michalska@arm.com>
 <20250121104706.2gcegucb6hcuksrd@vireshk-i7>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250121104706.2gcegucb6hcuksrd@vireshk-i7>

On Tue, Jan 21, 2025 at 04:17:06PM +0530, Viresh Kumar wrote:
> On 21-01-25, 08:44, Beata Michalska wrote:
> > Allow arch_freq_get_on_cpu to return an error for cases when retrieving
> > current CPU frequency is not possible, whether that being due to lack of
> > required arch support or due to other circumstances when the current
> > frequency cannot be determined at given point of time.
> > 
> > Signed-off-by: Beata Michalska <beata.michalska@arm.com>
> > ---
> >  arch/x86/kernel/cpu/aperfmperf.c | 2 +-
> >  arch/x86/kernel/cpu/proc.c       | 7 +++++--
> >  drivers/cpufreq/cpufreq.c        | 8 ++++----
> >  include/linux/cpufreq.h          | 2 +-
> >  4 files changed, 11 insertions(+), 8 deletions(-)
> > 
> > diff --git a/arch/x86/kernel/cpu/aperfmperf.c b/arch/x86/kernel/cpu/aperfmperf.c
> > index f642de2ebdac..6cf31a1649c4 100644
> > --- a/arch/x86/kernel/cpu/aperfmperf.c
> > +++ b/arch/x86/kernel/cpu/aperfmperf.c
> > @@ -498,7 +498,7 @@ void arch_scale_freq_tick(void)
> >   */
> >  #define MAX_SAMPLE_AGE	((unsigned long)HZ / 50)
> >  
> > -unsigned int arch_freq_get_on_cpu(int cpu)
> > +int arch_freq_get_on_cpu(int cpu)
> >  {
> >  	struct aperfmperf *s = per_cpu_ptr(&cpu_samples, cpu);
> >  	unsigned int seq, freq;
> > diff --git a/arch/x86/kernel/cpu/proc.c b/arch/x86/kernel/cpu/proc.c
> > index 41ed01f46bd9..d79f5845a463 100644
> > --- a/arch/x86/kernel/cpu/proc.c
> > +++ b/arch/x86/kernel/cpu/proc.c
> > @@ -86,9 +86,12 @@ static int show_cpuinfo(struct seq_file *m, void *v)
> >  		seq_printf(m, "microcode\t: 0x%x\n", c->microcode);
> >  
> >  	if (cpu_has(c, X86_FEATURE_TSC)) {
> > -		unsigned int freq = arch_freq_get_on_cpu(cpu);
> > +		int freq = arch_freq_get_on_cpu(cpu);
> >  
> > -		seq_printf(m, "cpu MHz\t\t: %u.%03u\n", freq / 1000, (freq % 1000));
> > +		if (freq <= 0)
> > +			seq_puts(m, "cpu MHz\t\t: Unknown\n");
> > +		else
> > +			seq_printf(m, "cpu MHz\t\t: %u.%03u\n", freq / 1000, (freq % 1000));
> >  	}
> >  
> >  	/* Cache size */
> > diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> > index 418236fef172..6f45684483c4 100644
> > --- a/drivers/cpufreq/cpufreq.c
> > +++ b/drivers/cpufreq/cpufreq.c
> > @@ -728,18 +728,18 @@ show_one(cpuinfo_transition_latency, cpuinfo.transition_latency);
> >  show_one(scaling_min_freq, min);
> >  show_one(scaling_max_freq, max);
> >  
> > -__weak unsigned int arch_freq_get_on_cpu(int cpu)
> > +__weak int arch_freq_get_on_cpu(int cpu)
> >  {
> > -	return 0;
> > +	return -EOPNOTSUPP;
> >  }
> >  
> >  static ssize_t show_scaling_cur_freq(struct cpufreq_policy *policy, char *buf)
> >  {
> >  	ssize_t ret;
> > -	unsigned int freq;
> > +	int freq;
> >  
> >  	freq = arch_freq_get_on_cpu(policy->cpu);
> > -	if (freq)
> > +	if (freq > 0)
> 
> >= ?
> 
> Since we can return error now, 0 should be considered a valid
> frequency value ?
Theoretically speaking - it should, though what would 0 actually
represent then ?

---
BR
Beata
> 
> >  		ret = sysfs_emit(buf, "%u\n", freq);
> >  	else if (cpufreq_driver->setpolicy && cpufreq_driver->get)
> >  		ret = sysfs_emit(buf, "%u\n", cpufreq_driver->get(policy->cpu));
> > diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
> > index 7fe0981a7e46..02fd4746231d 100644
> > --- a/include/linux/cpufreq.h
> > +++ b/include/linux/cpufreq.h
> > @@ -1184,7 +1184,7 @@ static inline int of_perf_domain_get_sharing_cpumask(int pcpu, const char *list_
> >  }
> >  #endif
> >  
> > -extern unsigned int arch_freq_get_on_cpu(int cpu);
> > +extern int arch_freq_get_on_cpu(int cpu);
> >  
> >  #ifndef arch_set_freq_scale
> >  static __always_inline
> > -- 
> > 2.25.1
> 
> -- 
> viresh

