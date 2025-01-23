Return-Path: <linux-pm+bounces-20901-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8DB3A1AC12
	for <lists+linux-pm@lfdr.de>; Thu, 23 Jan 2025 22:48:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 86FB87A1239
	for <lists+linux-pm@lfdr.de>; Thu, 23 Jan 2025 21:47:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A0FD1C07DC;
	Thu, 23 Jan 2025 21:47:55 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74A1613D520;
	Thu, 23 Jan 2025 21:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737668875; cv=none; b=KzlO8N690ES1gf5d/VnabjVdfHCAsg69dneSvIlT5lk7K5TMWSFikgOh2e+U/obyw9Hrhe6x4t+mqjZJGYRBDTLomKVYgh7njC3EUQFPZID3/8gg2bJq6Aw9Ptb/04JbmjsK0oh8fqIV4zqo7f7HjO+KoTWRzBiOqBbU1U/J4ws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737668875; c=relaxed/simple;
	bh=kzmLEOAZ0rTU1ollLjWGBjU7Ohqr4Khh71V8j3pSV68=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CHJwFue/61tqTfTpL2rs/gsf6/sGWRcPQBD2ijEJXqoZiG7aOQfaCcc53+DeSJdyeVLvkv5GovKhe7aFUD6VhzDJ/DxM5b6NWo7J1cbC2GkwV3+UZTZia7vqddanUkFj9yn4SunOqdjkW0L4PRef0eyKztlF8cPkhbSoUWe4oFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 849D51063;
	Thu, 23 Jan 2025 13:48:20 -0800 (PST)
Received: from arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 489A93F66E;
	Thu, 23 Jan 2025 13:47:47 -0800 (PST)
Date: Thu, 23 Jan 2025 22:47:07 +0100
From: Beata Michalska <beata.michalska@arm.com>
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-pm@vger.kernel.org, ionela.voinescu@arm.com,
	sudeep.holla@arm.com, will@kernel.org, catalin.marinas@arm.com,
	rafael@kernel.org, sumitg@nvidia.com, yang@os.amperecomputing.com,
	vanshikonda@os.amperecomputing.com, lihuisong@huawei.com,
	zhanjie9@hisilicon.com, Jonathan Corbet <corbet@lwn.net>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H . Peter Anvin" <hpa@zytor.com>, Phil Auld <pauld@redhat.com>,
	x86@kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v9 2/5] cpufreq: Introduce an optional cpuinfo_avg_freq
 sysfs entry
Message-ID: <Z5K42yXtcDSZGuUF@arm.com>
References: <20250121084435.2839280-1-beata.michalska@arm.com>
 <20250121084435.2839280-3-beata.michalska@arm.com>
 <20250121105355.sdrgmjv2w2256qfn@vireshk-i7>
 <Z4-6bsDzfe9CLcVf@arm.com>
 <20250122060902.5pgfr5g24jpjrxw3@vireshk-i7>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250122060902.5pgfr5g24jpjrxw3@vireshk-i7>

On Wed, Jan 22, 2025 at 11:39:02AM +0530, Viresh Kumar wrote:
> On 21-01-25, 16:17, Beata Michalska wrote:
> > On Tue, Jan 21, 2025 at 04:23:55PM +0530, Viresh Kumar wrote:
> > > On 21-01-25, 08:44, Beata Michalska wrote:
> > > > diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> > > > index 6f45684483c4..b2a8efa83c98 100644
> > > > --- a/drivers/cpufreq/cpufreq.c
> > > > +++ b/drivers/cpufreq/cpufreq.c
> > > > @@ -733,12 +733,20 @@ __weak int arch_freq_get_on_cpu(int cpu)
> > > >  	return -EOPNOTSUPP;
> > > >  }
> > > >  
> > > >  static ssize_t show_scaling_cur_freq(struct cpufreq_policy *policy, char *buf)
> > > >  {
> > > >  	ssize_t ret;
> > > >  	int freq;
> > > >  
> > > > -	freq = arch_freq_get_on_cpu(policy->cpu);
> > > > +	freq = IS_ENABLED(CONFIG_CPUFREQ_ARCH_CUR_FREQ)
> > > > +		? arch_freq_get_on_cpu(policy->cpu)
> > > > +		: 0;
> > > > +
> > > >  	if (freq > 0)
> > > >  		ret = sysfs_emit(buf, "%u\n", freq);
> > > >  	else if (cpufreq_driver->setpolicy && cpufreq_driver->get)
> > > 
> > > Maybe this should be a separate commit ? And also I am not very happy
> > Initially it was supposed to be one, but then the rest of the series justifies
> > the changes so it made sense to send those in one go.
> > > with the new kconfig option. I don't want others to use it as we want
> > > to get rid of this for X86 too eventually. Making it a kconfig option
> > > allows anyone to enable it and then depend on it without us knowing..
> > > 
> > > Rather just write it as "if (x86)", with a comment on what we plan to
> > > do with it in few release cycles.
> > Right, those changes are based on discussion in [1].
> 
> Ahh I see.. What about making it depend on X86 for now, as we really
> don't want new users to use it ?
Do you mean the new config option? If so, it is in Kconfig.x86 already.
Unless you have smth else in mind ?

---
BR
Beata
> 
> -- 
> viresh

