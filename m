Return-Path: <linux-pm+bounces-24756-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7014FA7A147
	for <lists+linux-pm@lfdr.de>; Thu,  3 Apr 2025 12:47:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B9121895777
	for <lists+linux-pm@lfdr.de>; Thu,  3 Apr 2025 10:47:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 400EC2459EE;
	Thu,  3 Apr 2025 10:47:29 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0949A1E87B;
	Thu,  3 Apr 2025 10:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743677249; cv=none; b=LI8/OowxrhCFQXCUqmcEy/UkzNZZTSRLk5gsVV6YmW7Jy2f9xZjSizyG/CqyZ29q6iaGciU1yCj1b2HVV/WKCMMg4qajUBE83xZMI0EHZuWeXrb5kXiX2IH1emivG2fWORH/zzLWE18cE1nzpzUI44kAwlhk/blp/GCgGVutCHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743677249; c=relaxed/simple;
	bh=8z2Szahwje/h57nnEkDOF4q9orGHQGDPzI90N+VMZo0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DKrwxCU85kEyGooDufjrUm5kKPikqkYY/cB2PbDdabm7onGPBBCoU4JzbWPW16NoM6nvnnT9A4D9ng4P75Xjumo57++rp4ZiF+1MFyB4EsHFifbtMSe/EuwUx165+v2ye4C2yvlHtOtjA2/qhjjQy3mNgmmtAkr/nRHkK4Ct0Bo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D4D52106F;
	Thu,  3 Apr 2025 03:47:28 -0700 (PDT)
Received: from [10.57.40.234] (unknown [10.57.40.234])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 685A83F59E;
	Thu,  3 Apr 2025 03:47:24 -0700 (PDT)
Message-ID: <6ab0531a-d6d8-46ac-9afc-23cf87f37905@arm.com>
Date: Thu, 3 Apr 2025 11:47:22 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC][PATCH v0.3 0/6] cpufreq: intel_pstate: Enable EAS on hybrid
 platforms without SMT - alternative
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
References: <22640172.EfDdHjke4D@rjwysocki.net>
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <22640172.EfDdHjke4D@rjwysocki.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/7/25 19:12, Rafael J. Wysocki wrote:
> Hi Everyone,
> 
> This is a new take on the "EAS for intel_pstate" work:
> 
> https://lore.kernel.org/linux-pm/5861970.DvuYhMxLoT@rjwysocki.net/
> 
> with refreshed preparatory patches and a revised energy model design.
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
> However, this time perf domains are registered per CPU and in addition to the
> primary cost component, which is related to the CPU type, there is a small
> component proportional to performance whose role is to help balance the load
> between CPUs of the same type.
> 
> This is done to avoid migrating tasks too much between CPUs of the same type,
> especially between E-cores, which has been observed in tests of the previous
> iteration of this work.
> 
> The expected effect is still that the CPUs of the "low-cost" type will be
> preferred so long as there is enough spare capacity on any of them.
> 
> The first two patches in the series rearrange cpufreq checks related to EAS so
> that sched_is_eas_possible() doesn't have to access cpufreq internals directly
> and patch [3/6] changes those checks to also allow EAS to be used with cpufreq
> drivers that implement internal governors (like intel_pstate).
> 
> Patches [4-5/6] deal with the Energy Model code.  Patch [4/6] simply rearranges
> it so as to allow the next patch to be simpler and patch [5/6] adds a function
> that's used in the last patch.
> 
> Patch [6/6] is the actual intel_pstate modification which now is significantly
> simpler than before because it doesn't need to track the type of each CPU
> directly in order to put into the right perf domain.
> 
> Please refer to the individual patch changelogs for details.
> 
> For easier access, the series is available on the experimental/intel_pstate/eas-take2
> branch in linux-pm.git:
> 
> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
> experimental/intel_pstate/eas-take2
> 
> or
> 
> https://web.git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git/log/?h=experimental/intel_pstate/eas-take2
> 
> Thanks!
> 


Hi Rafael,
as promised I did the same tests as with v0.2, the results are better with v0.3,
hard to say though if that is because of the cache-affinity on the P-cores.

Interestingly our nosmt Raptor Lake 8+8 should be worse off with its 16 PDs now.
Maybe, if L2 is shared anyway, one PD for e-cores and per-CPU-PD for P-cores
could be experimented with too (so 4+1+1+1+1 for lunar lake).

Anyway these are the results, again 20 iterations of 5 minutes each:

Firefox YouTube 4K video playback:
EAS:
376.229 +-9.566835596650195
CAS:
661.323 +-18.951739322113248
(-43.1% energy used with EAS)
(cf -24.2% energy used with EAS v0.2)

Firefox Web Aquarium 500 fish.
EAS:
331.933 +-10.977847441299437
CAS:
515.594 +-16.997636567737562
(-35.6% energy used with EAS)
(Wasn't tested on v0.2, just to see if above was a lucky workload hit.)

Both don't show any performance hit with EAS (FPS are very stable for both).
v0.2 results:
https://lore.kernel.org/lkml/3861524b-b266-4e54-b7ab-fdccbb7b4177@arm.com/


