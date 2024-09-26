Return-Path: <linux-pm+bounces-14822-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 65F909871D1
	for <lists+linux-pm@lfdr.de>; Thu, 26 Sep 2024 12:43:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0FF581F29833
	for <lists+linux-pm@lfdr.de>; Thu, 26 Sep 2024 10:43:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 466641AE87A;
	Thu, 26 Sep 2024 10:43:14 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B17B1AD3E9;
	Thu, 26 Sep 2024 10:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727347394; cv=none; b=n8t/UvqE31OFfuUKxf23yqTv70hLsHvdibinr8GZA+IJO6iWx1nzp1rK2opyS+b+6sosvc8ZlECXptIiQC9L0ZLdTv0hYSXMo4mbMsop88yI3lYhKP0/zXasRiOIyrJWuBbQ0C1aEzHQcQxsh5BOaFsk3m2cQnzfEObxkENDkRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727347394; c=relaxed/simple;
	bh=40lVeyvzc1LeHlOl9oiwkD/ayqXzJZn8V+yxkrlXn4E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hpYtTKjSuILIjMVoCDO2O4EEJRdJTyZSdaxgslsXDCfMjj0jADaWiJkoQAHeAqlVJ6nFotSlRBWJgatVRhqWShYPi1B+YvvpEFcLGsjPGqpnovv1GIGM7ZO2xXGbU2Kap9sbrf+O7vmbXRBxpRKySGEZm2LrWQlmsoPaDA+AG70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2A62D14BF;
	Thu, 26 Sep 2024 03:43:41 -0700 (PDT)
Received: from arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 436D93F6A8;
	Thu, 26 Sep 2024 03:43:08 -0700 (PDT)
Date: Thu, 26 Sep 2024 12:42:45 +0200
From: Beata Michalska <beata.michalska@arm.com>
To: Jie Zhan <zhanjie9@hisilicon.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-pm@vger.kernel.org, ionela.voinescu@arm.com,
	sudeep.holla@arm.com, will@kernel.org, catalin.marinas@arm.com,
	rafael@kernel.org, viresh.kumar@linaro.org, sumitg@nvidia.com,
	yang@os.amperecomputing.com, vanshikonda@os.amperecomputing.com,
	lihuisong@huawei.com
Subject: Re: [PATCH v7 1/4] cpufreq: Introduce an optional cpuinfo_avg_freq
 sysfs entry
Message-ID: <ZvU6pdjAljs55dqH@arm.com>
References: <20240913132944.1880703-1-beata.michalska@arm.com>
 <20240913132944.1880703-2-beata.michalska@arm.com>
 <09887c82-2813-59c3-2ff2-0b7223b37b9e@hisilicon.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <09887c82-2813-59c3-2ff2-0b7223b37b9e@hisilicon.com>

On Wed, Sep 25, 2024 at 04:58:36PM +0800, Jie Zhan wrote:
> Hi Beata,
Hi Jie
> 
> Great thanks for the update.
> 
> On 13/09/2024 21:29, Beata Michalska wrote:
> > Currently the CPUFreq core exposes two sysfs attributes that can be used
> > to query current frequency of a given CPU(s): namely cpuinfo_cur_freq
> > and scaling_cur_freq. Both provide slightly different view on the
> > subject and they do come with their own drawbacks.
> > 
> > cpuinfo_cur_freq provides higher precision though at a cost of being
> > rather expensive. Moreover, the information retrieved via this attribute
> > is somewhat short lived as frequency can change at any point of time
> > making it difficult to reason from.
> > 
> > scaling_cur_freq, on the other hand, tends to be less accurate but then
> > the actual level of precision (and source of information) varies between
> > architectures making it a bit ambiguous.
> > 
> > The new attribute, cpuinfo_avg_freq, is intended to provide more stable,
> > distinct interface, exposing an average frequency of a given CPU(s), as
> > reported by the hardware, over a time frame spanning no more than a few
> > milliseconds. As it requires appropriate hardware support, this
> > interface is optional.
> > 
> > Signed-off-by: Beata Michalska <beata.michalska@arm.com>
> > ---
> >  Documentation/admin-guide/pm/cpufreq.rst | 10 ++++++++
> >  drivers/cpufreq/cpufreq.c                | 31 ++++++++++++++++++++++++
> >  include/linux/cpufreq.h                  |  1 +
> >  3 files changed, 42 insertions(+)
> > 
> > diff --git a/Documentation/admin-guide/pm/cpufreq.rst b/Documentation/admin-guide/pm/cpufreq.rst
> > index fe1be4ad88cb..2204d6132c05 100644
> > --- a/Documentation/admin-guide/pm/cpufreq.rst
> > +++ b/Documentation/admin-guide/pm/cpufreq.rst
> > @@ -248,6 +248,16 @@ are the following:
> >  	If that frequency cannot be determined, this attribute should not
> >  	be present.
> >  
> > +``cpuinfo_avg_freq``
> > +        An average frequency (in KHz) of all CPUs belonging to a given policy,
> > +        derived from a hardware provided feedback and reported on a time frame
> > +        spanning at most few milliseconds.
> 
> I don't think it's necessary to put the 'at most few milliseconds'
> limitation on.
> 
> It's supposed to be fine for other platforms to implement the interface
> with a longer time period, e.g. a few seconds, in the future.  Otherwise,
> this would probably force the implementation of 'cpuinfo_avg_freq' to be
> binded with the 'scale freq tick' stuff.
Actually the sched_tick was intentionally omitted from the description
to avoid associating one with another.
Not really sure how useful it would be to have a longer time-frames for the
average frequency though.
It is still intended to be rather accurate - thus the 'at most few
milliseconds' statement. Extending that period reduces the accuracy.
If we allow that - meaning getting average frequency over different time-frame
spans , we introduce yet again platform specific behaviour for common interface,
which might not be that desired.

> 
> > +
> > +        This is expected to be based on the frequency the hardware actually runs
> > +        at and, as such, might require specialised hardware support (such as AMU
> > +        extension on ARM). If one cannot be determined, this attribute should
> > +        not be present.
> > +
> >  ``cpuinfo_max_freq``
> >  	Maximum possible operating frequency the CPUs belonging to this policy
> >  	can run at (in kHz).
> 
> ...
> 
> > diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
> > index d4d2f4d1d7cb..48262073707e 100644
> > --- a/include/linux/cpufreq.h
> > +++ b/include/linux/cpufreq.h
> > @@ -1195,6 +1195,7 @@ static inline int of_perf_domain_get_sharing_cpumask(int pcpu, const char *list_
> >  #endif
> >  
> >  extern unsigned int arch_freq_get_on_cpu(int cpu);
> > +extern int arch_freq_avg_get_on_cpu(int cpu);
> 
> It's werid to have two different functions with mostly the same behaviour,
> i.e. arch_freq_get_on_cpu() and arch_freq_avg_get_on_cpu().
> 
> Appreciated that there would be some capatibility work with x86 at the
> moment if merging them, e.g. return type, default implementation, impact on
> some userspace tools, etc.
The intention here was indeed to have a clean distinction between the two.
> 
> Anyhow, are they supposed to be merged in the near future?
That depends on any further comments on that new sysfs attribute I guess.

---
Thanks
Beata
> 
> 
> Thanks,
> Jie
> >  
> >  #ifndef arch_set_freq_scale
> >  static __always_inline

