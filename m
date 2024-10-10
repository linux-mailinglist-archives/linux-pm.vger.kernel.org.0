Return-Path: <linux-pm+bounces-15447-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ADD3998482
	for <lists+linux-pm@lfdr.de>; Thu, 10 Oct 2024 13:09:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B36991F22E10
	for <lists+linux-pm@lfdr.de>; Thu, 10 Oct 2024 11:09:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD9371C2327;
	Thu, 10 Oct 2024 11:08:55 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2430E1BF324;
	Thu, 10 Oct 2024 11:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728558535; cv=none; b=XKYFodiVcm6Zt+U/KGUReVzuV2SVpJux4FOcsKpYbnujiFqSrUHz11PP0zHnx/pBv6k6kZnKXOWr6dDv1wSFDGkq+iOs9Gwva1Z6d7T4uAP4zIUuutG26akyVw5Xw9774B3qEC+1uD977ACAjxzWIAj7Zq8Znuk+RNAj1YaWE1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728558535; c=relaxed/simple;
	bh=p9H07rn+wuNRM2dxfXfbDsuYp44eVoznRlNZZ4yosiE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J8XpBu42a/KYhHz14/tszFWkTDs26OJUqjH3ig+23sOW4MvrZj5uMP18brInGGFTBqZ+gQCw0uQ79rT1j8Y5R5OkFtLh4zIBpiIF0pZOBCfLlZSJg2qG4Vy0+V76hdyxOUfdkKwX0zQ49ybwh1Yaues9dowiCNLouNBAt4mXLDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 16EB5497;
	Thu, 10 Oct 2024 04:09:23 -0700 (PDT)
Received: from arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1F8CF3F58B;
	Thu, 10 Oct 2024 04:08:48 -0700 (PDT)
Date: Thu, 10 Oct 2024 13:08:23 +0200
From: Beata Michalska <beata.michalska@arm.com>
To: Vanshidhar Konda <vanshikonda@os.amperecomputing.com>,
	viresh.kumar@linaro.org
Cc: Sumit Gupta <sumitg@nvidia.com>, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
	ionela.voinescu@arm.com, sudeep.holla@arm.com, will@kernel.org,
	catalin.marinas@arm.com, rafael@kernel.org, viresh.kumar@linaro.org,
	yang@os.amperecomputing.com, lihuisong@huawei.com,
	zhanjie9@hisilicon.com, linux-tegra <linux-tegra@vger.kernel.org>,
	Bibek Basu <bbasu@nvidia.com>
Subject: Re: [PATCH v7 3/4] arm64: Provide an AMU-based version of
 arch_freq_avg_get_on_cpu
Message-ID: <Zwe1p0La_AFknglf@arm.com>
References: <20240913132944.1880703-1-beata.michalska@arm.com>
 <20240913132944.1880703-4-beata.michalska@arm.com>
 <aa254516-968e-4665-bb5b-981c296ffc35@nvidia.com>
 <ZvU4mR_FZa7jXUgk@arm.com>
 <ylcfqw4swz6xjxxfoyljyifs4ibbueywogqxusxfz3a3fgh3du@cfaajchbwgvn>
 <Zv8PKlr_PJgxazro@arm.com>
 <5y3yz2ct2o42c53dc6rwpse3andstjx74lowt2b3hohj4ogbct@nu2szdnxvxid>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5y3yz2ct2o42c53dc6rwpse3andstjx74lowt2b3hohj4ogbct@nu2szdnxvxid>

On Thu, Oct 03, 2024 at 02:54:22PM -0700, Vanshidhar Konda wrote:
> On Thu, Oct 03, 2024 at 11:39:54PM GMT, Beata Michalska wrote:
> > On Thu, Sep 26, 2024 at 04:21:14PM -0700, Vanshidhar Konda wrote:
> > > On Thu, Sep 26, 2024 at 12:34:01PM GMT, Beata Michalska wrote:
> > > > On Tue, Sep 17, 2024 at 05:41:09PM +0530, Sumit Gupta wrote:
> > > > > Hi Beata,
> > > > Hi Sumit,
> > > > >
> > > > > Thank you for the patches.
> > > > Thank you for having a look at those.
> > > > >
> > > > > On 13/09/24 18:59, Beata Michalska wrote:
> > > > > > External email: Use caution opening links or attachments
> > > > > >
> > > > > >
> > > > > > With the Frequency Invariance Engine (FIE) being already wired up with
> > > > > > sched tick and making use of relevant (core counter and constant
> > > > > > counter) AMU counters, getting the average frequency for a given CPU,
> > > > > > can be achieved by utilizing the frequency scale factor which reflects
> > > > > > an average CPU frequency for the last tick period length.
> > > > > >
> > > > > > The solution is partially based on APERF/MPERF implementation of
> > > > > > arch_freq_get_on_cpu.
> > > > > >
> > > > > > Suggested-by: Ionela Voinescu <ionela.voinescu@arm.com>
> > > > > > Signed-off-by: Beata Michalska <beata.michalska@arm.com>
> > > > > > ---
> > > > > >   arch/arm64/kernel/topology.c | 109 +++++++++++++++++++++++++++++++----
> > > > > >   1 file changed, 99 insertions(+), 10 deletions(-)
> > > > > >
> 
> --- snip ----
> 
> > > > >
> > > > >     ..
> > > > >   freq_comput:
> > > > >     scale = arch_scale_freq_capacity(cpu);
> > > > >     freq = scale * arch_scale_freq_ref(cpu);
> > > > >   ----
> > > > >
> > > > This boils down to the question what that function, and the information it
> > > > provides, represent really. The 'unknown' here simply says the CPU has been idle
> > > > for a while and as such the frequency data is a bit stale and it does not
> > > > represent the average freq the CPU is actually running at anymore, which is
> > > > the intention here really. Or, that the given CPU is a non-housekeeping one.
> > > > Either way I believe this is a useful information, instead of providing
> > > > stale data with no indication on whether the frequency is really the 'current'
> > > > one or not.
> > > >
> > > > If that is somehow undesirable we can discuss this further, though I'd rather
> > > > avoid exposing an interface where the feedback provided is open to
> > > > interpretation at all times.
> > > 
> > > Would it make sense to identify that the frequency reporting is unknown due to
> > > cpu being idle vs some other issue like being a non-housekeeping CPU? Would
> > > returning a value of 0 make it easier for tools to represent that the CPU is
> > > currently idle?
> > That is an option.
> > Another one would be to return an error for those cases. This would make it
> > easier to distinguish between valid frequency &/| idle CPU vs tickless CPU
> > (EINVAL vs ENOENT) ?
> > 
> 
> That seems like a good idea but I suspect it would be confusing to the end user.
> 
> If a user runs `cat /sys/devices/system/cpu/cpu2/cpuinfo_avg_freq` they would
> get an error in some cases or get a number in some other iterations.
>
That is a fair point but I am not entirely convinced using '0' instead makes
things any more clearer as this is in no way a valid CPU frequency.
As long as we document the expected behaviour keeping the interface well
defined,  both options should be fine I guess.

@Viresh: what is your opinion on that one ?

---
BR
Beata
> Thanks,
> Vanshidhar
> 
> > ---
> > BR
> > Beata
> > > 
> > > Thanks,
> > > Vanshidhar
> > > 
> > > >
> > > > ---
> > > > Best Regards
> > > > Beata
> > > > > Thank you,
> > > > > Sumit Gupta
> > > > >
> > > > > P.S. Will be on afk for next 2 weeks with no access to email. Please expect
> > > > > a delay in response.
> > > > >
> > > > > > +               cpu = ref_cpu;
> > > > > > +               goto retry;
> > > > > > +       }
> > > > > > +       /*
> > > > > > +        * Reversed computation to the one used to determine
> > > > > > +        * the arch_freq_scale value
> > > > > > +        * (see amu_scale_freq_tick for details)
> > > > > > +        */
> > > > > > +       scale = arch_scale_freq_capacity(cpu);
> > > > > > +       freq = scale * arch_scale_freq_ref(cpu);
> > > > > > +       freq >>= SCHED_CAPACITY_SHIFT;
> > > > > > +       return freq;
> > > > > > +}
> > > > > > +
> > > > >
> > > > > >   static void amu_fie_setup(const struct cpumask *cpus)
> > > > > >   {
> > > > > >          int cpu;
> > > > > > --
> > > > > > 2.25.1
> > > > > >

