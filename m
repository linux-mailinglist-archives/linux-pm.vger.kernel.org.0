Return-Path: <linux-pm+bounces-30791-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BA953B03E77
	for <lists+linux-pm@lfdr.de>; Mon, 14 Jul 2025 14:17:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4E5197A5A65
	for <lists+linux-pm@lfdr.de>; Mon, 14 Jul 2025 12:16:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFB161FE471;
	Mon, 14 Jul 2025 12:17:22 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BED980B;
	Mon, 14 Jul 2025 12:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752495442; cv=none; b=RGH+h/eXStW/+zXh683NeGhuxStuHjgaLlUvuF+eaFv75jCx6Hk6B6LPwvoolNd9FkHIKYdGVC7my1EEGkXZzi4rOqf+Wes26HXLaFHQexsnR+m3uHavkyAM5faPlCeH9LzVYP9+2yHFgvUGTDSwmaq8P7LTY1HoYn9H9n4q5Ls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752495442; c=relaxed/simple;
	bh=rVzCRsG6jbe1SFUCABKrLG0KeTKJrBiOOgY3bakeaSk=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=DJSLC7vRCMrszNTR5On0CGu0Xx7D7VY2X7bRmjsEqllYDAZJsoYA1OQbkGR7ICJu0qxKSehVGfLZdEak5lxpyRJrNxIyqRMfDuLlevw+SwJHXUnf03eh9EZ3omsjXTwoeGLri04Sy7plMoE370DwLooOjIEcq3Nha1ZQRhKbIHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6A8471BC0;
	Mon, 14 Jul 2025 05:17:10 -0700 (PDT)
Received: from [192.168.178.6] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 13B0D3F694;
	Mon, 14 Jul 2025 05:17:17 -0700 (PDT)
Message-ID: <e89b250a-7e9b-45fa-9e81-fc071487078b@arm.com>
Date: Mon, 14 Jul 2025 14:16:25 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] cpufreq,base/arch_topology: Calculate cpu_capacity
 according to boost
From: Dietmar Eggemann <dietmar.eggemann@arm.com>
To: "Rafael J . Wysocki" <rafael@kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>, Sudeep Holla <sudeep.holla@arm.com>,
 Christian Loehle <christian.loehle@arm.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 Robin Murphy <robin.murphy@arm.com>,
 Beata Michalska <beata.michalska@arm.com>, zhenglifeng1@huawei.com,
 "vincent.guittot@linaro.org" <vincent.guittot@linaro.org>,
 Ionela Voinescu <ionela.voinescu@arm.com>
References: <20250626093018.106265-1-dietmar.eggemann@arm.com>
Content-Language: en-US
In-Reply-To: <20250626093018.106265-1-dietmar.eggemann@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

+cc Vincent Guittot <vincent.guittot@linaro.org>
+cc Ionela Voinescu <ionela.voinescu@arm.com>

On 26/06/2025 11:30, Dietmar Eggemann wrote:
> I noticed on my Arm64 big.Little platform (Juno-r0, scmi-cpufreq) that
> the cpu_scale values (/sys/devices/system/cpu/cpu*/cpu_capacity) of the
> little CPU changed in v6.14 from 446 to 505. I bisected and found that
> commit dd016f379ebc ("cpufreq: Introduce a more generic way to set
> default per-policy boost flag") (1) introduced this change.
> Juno's scmi FW marks the 2 topmost OPPs of each CPUfreq policy (policy0:
> 775000 850000, policy1: 950000 1100000) as boost OPPs.
> 
> The reason is that the 'policy->boost_enabled = true' is now done after
> 'cpufreq_table_validate_and_sort() -> cpufreq_frequency_table_cpuinfo()'
> in cpufreq_online() so that 'policy->cpuinfo.max_freq' is set to the
> 'highest non-boost' instead of the 'highest boost' frequency.
> 
> This is before the CPUFREQ_CREATE_POLICY notifier is fired in
> cpufreq_online() to which the cpu_capacity setup code in
> [drivers/base/arch_topology.c] has registered.
> 
> Its notifier_call init_cpu_capacity_callback() uses
> 'policy->cpuinfo.max_freq' to set the per-cpu
> capacity_freq_ref so that the cpu_capacity can be calculated as:
> 
> cpu_capacity = raw_cpu_capacity (2) * capacity_freq_ref /
> 				      'max system-wide cpu frequency'
> 
> (2) Juno's little CPU has 'capacity-dmips-mhz = <578>'.
> 
> So before (1) for a little CPU:
> 
> cpu_capacity = 578 * 850000 / 1100000 = 446
> 
> and after:
> 
> cpu_capacity = 578 * 700000 / 800000 = 505
> 
> This issue can also be seen on Arm64 boards with cpufreq-dt drivers
> using the 'turbo-mode' dt property for boosted OPPs.
> 
> What's actually needed IMHO is to calculate cpu_capacity according to
> the boost value. I.e.:
> 
> (a) The infrastructure to adjust cpu_capacity in arch_topology.c has to
>     be kept alive after boot.
> 
> (b) There has to be some kind of notification from cpufreq.c to
>     arch_topology.c about the toggling of boost. I'm abusing
>     CPUFREQ_CREATE_POLICY for this right now. Could we perhaps add a
>     CPUFREQ_MOD_POLICY for this?
> 
> (c) Allow unconditional set of policy->cpuinfo.max_freq in case boost
>     is set to 0 in cpufreq_frequency_table_cpuinfo().
>     This currently clashes with the commented feature that in case the
>     driver has set a higher value it should stay untouched.
> 
> Tested on Arm64 Juno (scmi-cpufreq) and Hikey 960 (cpufreq-dt +
> added 'turbo-mode' to the topmost OPPs in dts file).
> 
> This is probably related what Christian Loehle tried to address in
> https://lkml.kernel.org/r/3cc5b83b-f81c-4bd7-b7ff-4d02db4e25d8@arm.com .

Christian L. reminded me that since commit dd016f379ebc we also have a
performance regression on a system with boosted OPPs using schedutil
CPUfreq governor.

The reason is that per cpu 'capacity_freq_ref' is set in
drivers/base/arch_topology.c only during system boot so far based on the
highest non-boosted OPP since boost is disabled per default.

Schedutil uses capacity_freq_ref (*) in get_next_freq() to calculate the
next frequency request:

   next_freq = max_freq * util / max
               ^^^^^^^^
                 (*)

In case the boost OPPs will be enabled:

   echo 1 > /sys/devices/system/cpu/cpufreq/boost

'capacity_freq_ref' stays at the highest non-boosted OPP's so schedutil
won't request any boosted OPPs for util values > ''highest non boosted
OPP'/'highest boosted OPP' * max'. The 'highest non boosted OPP' will be
used by schedutil instead.

This performance regression will go away with the proposed patch as well.

Calling drivers/base/arch_topology.c's init_cpu_capacity_callback() in
the event that boost is toggled makes sure that 'capacity_freq_ref' will
be set to the highest boosted (0->1) or highest non-boosted (1->0) OPP.

[...]






