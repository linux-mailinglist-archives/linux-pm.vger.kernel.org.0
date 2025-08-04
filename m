Return-Path: <linux-pm+bounces-31897-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FDDCB1A314
	for <lists+linux-pm@lfdr.de>; Mon,  4 Aug 2025 15:18:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D7CB516166E
	for <lists+linux-pm@lfdr.de>; Mon,  4 Aug 2025 13:18:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 643752609D0;
	Mon,  4 Aug 2025 13:18:29 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 472532550A4;
	Mon,  4 Aug 2025 13:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754313509; cv=none; b=IcT65LzpA7Dx1ZybR6y5reMJvypQL2JWWzwZ/oHAWpOMqQ9jqAr2p1U5AZ6M2BUxOLZgaGEfQAqBOkUOhJCAsJpcWwwEymN1ogN8cAPR2BM93Xyq/xZIVqtD0ZrkJyTzkSojuJha3IiSfAoFwXGLk/lV5U2ytcLROVz9ctUVEVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754313509; c=relaxed/simple;
	bh=wor2xWQChUtDZcWUwteOYy76UzHiV0aWif9cukNHpac=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=g+Z0U6xvja13Q++RjsP30Y6zTX1WcPaCj/4S81oZFZGTAfyWVGtdRZ+DH59ZbSAXOYMWVIaSkIF8tPTsKOfB3mOjBNGUlHU2jvU6z9cVauLYTvkSj2Ab9ShBHbkxCVWSTB/djBE6SnBuQkk6lXayiS3Ivkz6kLx8xts+0T0KYZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6F6D3150C;
	Mon,  4 Aug 2025 06:18:18 -0700 (PDT)
Received: from [10.1.25.45] (e127648.arm.com [10.1.25.45])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2630C3F673;
	Mon,  4 Aug 2025 06:18:23 -0700 (PDT)
Message-ID: <16b728e6-6fb9-48eb-8160-73c4ace229d2@arm.com>
Date: Mon, 4 Aug 2025 14:18:22 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] cpufreq,base/arch_topology: Calculate cpu_capacity
 according to boost
To: Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>, Sudeep Holla <sudeep.holla@arm.com>,
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 Robin Murphy <robin.murphy@arm.com>,
 Beata Michalska <beata.michalska@arm.com>, zhenglifeng1@huawei.com,
 Ionela Voinescu <ionela.voinescu@arm.com>
References: <20250626093018.106265-1-dietmar.eggemann@arm.com>
 <e89b250a-7e9b-45fa-9e81-fc071487078b@arm.com>
 <CAKfTPtAwy1ZFQ=-t7SbbDuHj6ZJPtB3pJS6fZxt=1robLwvXjg@mail.gmail.com>
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <CAKfTPtAwy1ZFQ=-t7SbbDuHj6ZJPtB3pJS6fZxt=1robLwvXjg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/4/25 14:01, Vincent Guittot wrote:
> On Mon, 14 Jul 2025 at 14:17, Dietmar Eggemann <dietmar.eggemann@arm.com> wrote:
>>
>> +cc Vincent Guittot <vincent.guittot@linaro.org>
>> +cc Ionela Voinescu <ionela.voinescu@arm.com>
>>
>> On 26/06/2025 11:30, Dietmar Eggemann wrote:
>>> I noticed on my Arm64 big.Little platform (Juno-r0, scmi-cpufreq) that
>>> the cpu_scale values (/sys/devices/system/cpu/cpu*/cpu_capacity) of the
>>> little CPU changed in v6.14 from 446 to 505. I bisected and found that
>>> commit dd016f379ebc ("cpufreq: Introduce a more generic way to set
>>> default per-policy boost flag") (1) introduced this change.
>>> Juno's scmi FW marks the 2 topmost OPPs of each CPUfreq policy (policy0:
>>> 775000 850000, policy1: 950000 1100000) as boost OPPs.
>>>
>>> The reason is that the 'policy->boost_enabled = true' is now done after
>>> 'cpufreq_table_validate_and_sort() -> cpufreq_frequency_table_cpuinfo()'
>>> in cpufreq_online() so that 'policy->cpuinfo.max_freq' is set to the
>>> 'highest non-boost' instead of the 'highest boost' frequency.
>>>
>>> This is before the CPUFREQ_CREATE_POLICY notifier is fired in
>>> cpufreq_online() to which the cpu_capacity setup code in
>>> [drivers/base/arch_topology.c] has registered.
>>>
>>> Its notifier_call init_cpu_capacity_callback() uses
>>> 'policy->cpuinfo.max_freq' to set the per-cpu
>>> capacity_freq_ref so that the cpu_capacity can be calculated as:
>>>
>>> cpu_capacity = raw_cpu_capacity (2) * capacity_freq_ref /
>>>                                     'max system-wide cpu frequency'
>>>
>>> (2) Juno's little CPU has 'capacity-dmips-mhz = <578>'.
>>>
>>> So before (1) for a little CPU:
>>>
>>> cpu_capacity = 578 * 850000 / 1100000 = 446
>>>
>>> and after:
>>>
>>> cpu_capacity = 578 * 700000 / 800000 = 505
>>>
>>> This issue can also be seen on Arm64 boards with cpufreq-dt drivers
>>> using the 'turbo-mode' dt property for boosted OPPs.
>>>
>>> What's actually needed IMHO is to calculate cpu_capacity according to
>>> the boost value. I.e.:
>>>
>>> (a) The infrastructure to adjust cpu_capacity in arch_topology.c has to
>>>     be kept alive after boot.
> 
> If we adjust the cpu_capacity at runtime this will create oscillation
> in PELT values. We should stay with one single capacity all time :
> - either include boost value but when boost is disable we will never
> reach the max capacity of the cpu which could imply that the cpu will
> never be overloaded (from scheduler pov)

overutilized I'm assuming, that's the issue I was worried about here.
Strictly speaking the platform doesn't guarantee that the capacity can
be reached and sustained indefinitely. Whether the frequency is marked
as boost or not.

> - either not include boost_value but allow to go above cpu max compute
> capacity which is something we already discussed for x86 and the turbo
> freq in the past.
> 

But that currently breaks schedutil, i.e. boost frequencies will never
be used with schedutil. There's also some other locations where capacities
>1024 just break some assumptions (e.g. the kernel/sched/ext.c cpuperf
interface defines SCX_CPUPERF_ONE).


So we have either:
a) Potential wrong capacity estimation of CPUs when boost is disabled
(but capacity calculation assumed enabled).
b) Boost frequencies completely unused by schedutil.
c) Oscillating PELT values due to boost enable/disable.

Isn't c) (what Dietmar proposed here) by far the smallest evil of these
three?
I've also found a) very hard to actually trigger, although it's obviously
a problem that depends on the platform.

