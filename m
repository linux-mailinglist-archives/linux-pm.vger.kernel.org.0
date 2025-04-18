Return-Path: <linux-pm+bounces-25695-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EF97A935B7
	for <lists+linux-pm@lfdr.de>; Fri, 18 Apr 2025 11:58:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F2AC1B668E9
	for <lists+linux-pm@lfdr.de>; Fri, 18 Apr 2025 09:58:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18061270EBB;
	Fri, 18 Apr 2025 09:58:24 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15DAC26FDB5;
	Fri, 18 Apr 2025 09:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744970304; cv=none; b=MHsb9D5qoMAKSpxet/JQoyrMC73njLlXrqosVbC1DKuA+GLs7hFtt57hvthwWNFHrdbj8Lh3wZ+CcVDbm/ltAfM6c+55FCf8O3INCLekVwHAM9PnvILgh23dV4dGpZnbbnxthPRI0qW4yqgBsLkV1NTIJi2h0LpdmIoDS8SufKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744970304; c=relaxed/simple;
	bh=XIZzjwZdbWdpoNV6axPw6Vsb8O60yPWyM4dz5GU1H74=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TzJX/P2XHz8f4EZhftzH42P88rg0UKSr0/MBTlVGdOTkauDNu/rONdGpKZm1XZbFHPhFZqPWGPs/7UjDfVOBYb8vc2wSrSTj3pMxh0BwtuZrk+bVSyKjad3x8/NaGb6TR+4yVhHl18YNOH7hO0H0OCOzF1tnj4AAgiwx++q+Au8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 86DF2150C;
	Fri, 18 Apr 2025 02:58:10 -0700 (PDT)
Received: from [10.57.83.52] (unknown [10.57.83.52])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DC2453F694;
	Fri, 18 Apr 2025 02:58:10 -0700 (PDT)
Message-ID: <12d630f9-e917-4b9f-ab27-621886c13334@arm.com>
Date: Fri, 18 Apr 2025 10:58:08 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFT][PATCH v1 0/8] cpufreq: intel_pstate: Enable EAS on hybrid
 platforms without SMT
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Lukasz Luba <lukasz.luba@arm.com>,
 Peter Zijlstra <peterz@infradead.org>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Morten Rasmussen <morten.rasmussen@arm.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
 Pierre Gondois <pierre.gondois@arm.com>
References: <3344336.aeNJFYEL58@rjwysocki.net>
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <3344336.aeNJFYEL58@rjwysocki.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/16/25 18:44, Rafael J. Wysocki wrote:
> Hi Everyone,
> 
> This is a new version of
> 
> https://lore.kernel.org/linux-pm/22640172.EfDdHjke4D@rjwysocki.net/
> 
> which is not regarded as RFC any more.  It appears to be better than
> 
> https://lore.kernel.org/linux-pm/5861970.DvuYhMxLoT@rjwysocki.net/
> 
> but still requires more testing, so I'd appreciate any help here.
> 
> The following paragraph from the original cover letter still applies:
> 
> "The underlying observation is that on the platforms targeted by these changes,
> Lunar Lake at the time of this writing, the "small" CPUs (E-cores), when run at
> the same performance level, are always more energy-efficient than the "big" or
> "performance" CPUs (P-cores).  This means that, regardless of the scale-
> invariant utilization of a task, as long as there is enough spare capacity on
> E-cores, the relative cost of running it there is always lower."
> 
> The first 3 patches have been updated since v0.3 and they now depend on the new
> cpufreq material in linux-next.
> 
> The next 2 patches (Energy Model code changes) have been reviewed in the
> meantime, but they are only needed for the last 3 patches.
> 
> Patch [6/8] is essentially the same as before.  It causes perf domains to be
> registered per CPU and in addition to the primary cost component, which is
> related to the CPU type, there is a small component proportional to performance
> whose role is to help balance the load between CPUs of the same type.
> 
> This is done to avoid migrating tasks too much between CPUs of the same type,
> especially between E-cores, which has been observed in tests of
> 
> https://lore.kernel.org/linux-pm/5861970.DvuYhMxLoT@rjwysocki.net/
> 
> The expected effect is still that the CPUs of the "low-cost" type will be
> preferred so long as there is enough spare capacity on any of them.
> 
> The last 2 patches are new.
> 
> Patch [7/8] looks at the cache topology to avoid creating per-CPU perf domains
> for CPUs sharing an L2 cache.  Typically, on the chips that will be affected
> by this patch, CPUs sharing an L2 cache also share a voltage regulator and a
> clock, so they technically belong to the same OPP domain and they will be put
> into a shared perf domain after this patch.
> 
> Patch [8/8] makes CPUs sharing the L3 cache look slightly more expensive to
> cause the scheduler to prefer placing tasks on CPUs that don't use the L3,
> which in some cases should allow all of the CPUs sharing the L3 to stay in
> idle states and the energy usage should be reduced.
> 
> Please refer to the individual patch changelogs for details.
> 
> Since patches [7-8/8] also apply on top of the v0.3, I have created a git branch at
> 
> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
> experimental/intel_pstate/eas-take2-extended
> 
> or
> 
> https://web.git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git/log/?h=experimental/intel_pstate/eas-take2-extended
> 
> to allow the difference they make with respect to the v0.3 to be seen (if any).
> 
> Later, I'm going to put this series as a whole into a new git branch on top of
> the mainline and the cpufreq material queued up for 6.16.
> 
> Thanks!
> 

Similar to the v0.3 tests done here:
https://lore.kernel.org/linux-pm/6ab0531a-d6d8-46ac-9afc-23cf87f37905@arm.com/
here are the results for the same raptor lake nosmt machine (now with
4 e-cores + 4 e-cores and 8x1 p-core PDs, 10 PDs in total).

Firefox YouTube 4K video playback:
EAS:
684.504 +-19.167841239372198
CAS:
929.83 +-50.41498564690636
(-26.3844% energy used with EAS)
(cf. -43.1% energy used with EAS v0.3)
(cf. -24.2% energy used with EAS v0.2)

Firefox Web Aquarium 500 fish.
EAS:
540.192 +-14.294833410089904
CAS:
712.896 +-16.821304745272684
(-24.2257% energy used with EAS)
(cf. -35.6% energy used with EAS v0.3)

Seems the per-CPU PD worked better, at least for this machine, which arguably
isn't the main target of the series.
Feel free to add
Tested-by: Christian Loehle <christian.loehle@arm.com>
to patches 1 to 7 (the tested system isn't affected by 8/8).

