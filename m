Return-Path: <linux-pm+bounces-15799-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 52C459A145B
	for <lists+linux-pm@lfdr.de>; Wed, 16 Oct 2024 22:46:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 130D6280C7D
	for <lists+linux-pm@lfdr.de>; Wed, 16 Oct 2024 20:46:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 209871B6CF2;
	Wed, 16 Oct 2024 20:46:24 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9EFC4409;
	Wed, 16 Oct 2024 20:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729111584; cv=none; b=Dfxn9HBogMVXeDYKmg5FOmCLNx/MrAblq0UWzelMjeyS4aCKgvN+oJbPgMu7jg7gFXWyaBEuxZlc3U4CKMjHR8HXsodegs9IRGE/e0rSUKLlK+YQxh6+dhY+/qn0+6BVtJWgaATbUJmQJEmb7Y+FZPPrckAW369/nTnBce+TTDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729111584; c=relaxed/simple;
	bh=/KMPwYFTR0mcPuXM/4Ws8Eh2JBFSNKdpOapdPGGNn/E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T2uV8JP6UQo8GzuAmG/g+CvKd3220RnQI1T1r+3hlZnTnUP4kRLgqDGMCjKhY0SgrAvFBHyp8npGYAqoK1OEcpapZUba+onsibHd0kn3LBpf1WdXbhuTdBifHqNWRoflhpxtPjT3kL77DD8cmeiL4+ihdbwNdWtutBEK/fY1GTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 91F32FEC;
	Wed, 16 Oct 2024 13:46:49 -0700 (PDT)
Received: from arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9DEC03F58B;
	Wed, 16 Oct 2024 13:46:15 -0700 (PDT)
Date: Wed, 16 Oct 2024 22:45:35 +0200
From: Beata Michalska <beata.michalska@arm.com>
To: Sumit Gupta <sumitg@nvidia.com>
Cc: Vanshidhar Konda <vanshikonda@os.amperecomputing.com>,
	viresh.kumar@linaro.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
	ionela.voinescu@arm.com, sudeep.holla@arm.com, will@kernel.org,
	catalin.marinas@arm.com, rafael@kernel.org,
	yang@os.amperecomputing.com, lihuisong@huawei.com,
	zhanjie9@hisilicon.com, linux-tegra <linux-tegra@vger.kernel.org>,
	Bibek Basu <bbasu@nvidia.com>
Subject: Re: [PATCH v7 3/4] arm64: Provide an AMU-based version of
 arch_freq_avg_get_on_cpu
Message-ID: <ZxAl77IYcMO2SfWh@arm.com>
References: <20240913132944.1880703-1-beata.michalska@arm.com>
 <20240913132944.1880703-4-beata.michalska@arm.com>
 <aa254516-968e-4665-bb5b-981c296ffc35@nvidia.com>
 <ZvU4mR_FZa7jXUgk@arm.com>
 <ylcfqw4swz6xjxxfoyljyifs4ibbueywogqxusxfz3a3fgh3du@cfaajchbwgvn>
 <Zv8PKlr_PJgxazro@arm.com>
 <5y3yz2ct2o42c53dc6rwpse3andstjx74lowt2b3hohj4ogbct@nu2szdnxvxid>
 <Zwe1p0La_AFknglf@arm.com>
 <evllzzjufritriziohz22gm5qs44jedpft5lcfjfwnekarqtdx@eg42ik2l7bxu>
 <a183068c-9244-4448-b81c-d1c0556bd43b@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a183068c-9244-4448-b81c-d1c0556bd43b@nvidia.com>

On Mon, Oct 14, 2024 at 11:16:36PM +0530, Sumit Gupta wrote:
> 
> 
> On 11/10/24 21:59, Vanshidhar Konda wrote:
> > External email: Use caution opening links or attachments
> > 
> > 
> > On Thu, Oct 10, 2024 at 01:08:23PM GMT, Beata Michalska wrote:
> > > On Thu, Oct 03, 2024 at 02:54:22PM -0700, Vanshidhar Konda wrote:
> > > > On Thu, Oct 03, 2024 at 11:39:54PM GMT, Beata Michalska wrote:
> > > > > On Thu, Sep 26, 2024 at 04:21:14PM -0700, Vanshidhar Konda wrote:
> > > > > > On Thu, Sep 26, 2024 at 12:34:01PM GMT, Beata Michalska wrote:
> > > > > > > On Tue, Sep 17, 2024 at 05:41:09PM +0530, Sumit Gupta wrote:
> > > > > > > > Hi Beata,
> > > > > > > Hi Sumit,
> > > > > > > >
> > > > > > > > Thank you for the patches.
> > > > > > > Thank you for having a look at those.
> > > > > > > >
> > > > > > > > On 13/09/24 18:59, Beata Michalska wrote:
> > > > > > > > > External email: Use caution opening links or attachments
> > > > > > > > >
> > > > > > > > >
> > > > > > > > > With the Frequency Invariance Engine (FIE) being
> > > > already wired up with
> > > > > > > > > sched tick and making use of relevant (core counter
> > > > and constant
> > > > > > > > > counter) AMU counters, getting the average frequency
> > > > for a given CPU,
> > > > > > > > > can be achieved by utilizing the frequency scale
> > > > factor which reflects
> > > > > > > > > an average CPU frequency for the last tick period length.
> > > > > > > > >
> > > > > > > > > The solution is partially based on APERF/MPERF
> > > > implementation of
> > > > > > > > > arch_freq_get_on_cpu.
> > > > > > > > >
> > > > > > > > > Suggested-by: Ionela Voinescu <ionela.voinescu@arm.com>
> > > > > > > > > Signed-off-by: Beata Michalska <beata.michalska@arm.com>
> > > > > > > > > ---
> > > > > > > > >   arch/arm64/kernel/topology.c | 109
> > > > +++++++++++++++++++++++++++++++----
> > > > > > > > >   1 file changed, 99 insertions(+), 10 deletions(-)
> > > > > > > > >
> > > > 
> > > > --- snip ----
> > > > 
> > > > > > > >
> > > > > > > >     ..
> > > > > > > >   freq_comput:
> > > > > > > >     scale = arch_scale_freq_capacity(cpu);
> > > > > > > >     freq = scale * arch_scale_freq_ref(cpu);
> > > > > > > >   ----
> > > > > > > >
> > > > > > > This boils down to the question what that function, and
> > > > the information it
> > > > > > > provides, represent really. The 'unknown' here simply says
> > > > the CPU has been idle
> > > > > > > for a while and as such the frequency data is a bit stale
> > > > and it does not
> > > > > > > represent the average freq the CPU is actually running at
> > > > anymore, which is
> > > > > > > the intention here really. Or, that the given CPU is a
> > > > non-housekeeping one.
> > > > > > > Either way I believe this is a useful information, instead
> > > > of providing
> > > > > > > stale data with no indication on whether the frequency is
> > > > really the 'current'
> > > > > > > one or not.
> > > > > > >
> > > > > > > If that is somehow undesirable we can discuss this
> > > > further, though I'd rather
> > > > > > > avoid exposing an interface where the feedback provided is open to
> > > > > > > interpretation at all times.
> > > > > >
> > > > > > Would it make sense to identify that the frequency reporting
> > > > is unknown due to
> > > > > > cpu being idle vs some other issue like being a
> > > > non-housekeeping CPU? Would
> > > > > > returning a value of 0 make it easier for tools to represent
> > > > that the CPU is
> > > > > > currently idle?
> > > > > That is an option.
> > > > > Another one would be to return an error for those cases. This
> > > > would make it
> > > > > easier to distinguish between valid frequency &/| idle CPU vs
> > > > tickless CPU
> > > > > (EINVAL vs ENOENT) ?
> > > > >
> > > > 
> > > > That seems like a good idea but I suspect it would be confusing
> > > > to the end user.
> > > > 
> > > > If a user runs `cat
> > > > /sys/devices/system/cpu/cpu2/cpuinfo_avg_freq` they would
> > > > get an error in some cases or get a number in some other iterations.
> > > > 
> > > That is a fair point but I am not entirely convinced using '0'
> > > instead makes
> > > things any more clearer as this is in no way a valid CPU frequency.
> > > As long as we document the expected behaviour keeping the interface well
> > > defined,  both options should be fine I guess.
> > > 
> > 
> > Another option could be to list out the reason as 'idle' or 'no entry'
> > instead of
> > returning EINVAL or ENOENT. These wouldn't be valid values either but
> > cat on the
> > sysfs node wouldn't return an error.
> > 
> > Thanks,
> > Vanshidhar
> > 
> 
> Ya, listing the clear reason sounds better.
> 
> Thank you,
> Sumit Gupta
>
I'd still prefer returning an error as that is a clear indication on failure
upon read. Furthermore, that would also make that attribute stick to single-type
rule for sysfs, which is currently not the case and will not be if we return
'idle' or 'no entry'. That said, I am happy to make that change if that would be
the final decision and that one is not mine, as the change is ultimately the
cpufreq one.


---
BR
Beata
> > > @Viresh: what is your opinion on that one ?
> > > 
> > > ---
> > > BR
> > > Beata
> > > > Thanks,
> 
> ....
> 
> > > > > > > > > +               cpu = ref_cpu;
> > > > > > > > > +               goto retry;
> > > > > > > > > +       }
> > > > > > > > > +       /*
> > > > > > > > > +        * Reversed computation to the one used to determine
> > > > > > > > > +        * the arch_freq_scale value
> > > > > > > > > +        * (see amu_scale_freq_tick for details)
> > > > > > > > > +        */
> > > > > > > > > +       scale = arch_scale_freq_capacity(cpu);
> > > > > > > > > +       freq = scale * arch_scale_freq_ref(cpu);
> > > > > > > > > +       freq >>= SCHED_CAPACITY_SHIFT;
> > > > > > > > > +       return freq;
> > > > > > > > > +}
> > > > > > > > > +
> > > > > > > >
> > > > > > > > >   static void amu_fie_setup(const struct cpumask *cpus)
> > > > > > > > >   {
> > > > > > > > >          int cpu;
> > > > > > > > > --
> > > > > > > > > 2.25.1
> > > > > > > > >

