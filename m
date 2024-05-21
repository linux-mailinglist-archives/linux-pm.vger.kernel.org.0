Return-Path: <linux-pm+bounces-8024-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 273968CAE91
	for <lists+linux-pm@lfdr.de>; Tue, 21 May 2024 14:51:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 97AFE1F21148
	for <lists+linux-pm@lfdr.de>; Tue, 21 May 2024 12:51:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B6C96CDCA;
	Tue, 21 May 2024 12:51:17 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3E1B12E6A;
	Tue, 21 May 2024 12:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716295877; cv=none; b=VXZsjYpaSpsgXUjxhPHxZ1coRBHU3nf3imZRhid7TuuH4PCz6gVh+c6fKV7zmA4CDMQZOybPDVMrH2KFlxgF11IWSqBHWqh8ncfhVHt2Z+8Id/L+6QwLYSN4JT/nftFJHS4wovCVDLAh2Iici0reph9+hUGCW+ue8rB9M2I5WX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716295877; c=relaxed/simple;
	bh=WY2XyDJtXE1LjxFvWXph1an3HyHAqYE6QVllgkoifVo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VbcCNCUn8pUYJzuSOA4KnpfaYpDNicBm3p2SKcNBSdFx5HU0vs47zlXI71xfG+ja99aFguznVIbMsI030iV5l5Gt2PesLWw3ua31Z2pRT+/3/6bmipLJH+IfPpMvbiK1XmQSpr+UmbTs/7+n3G5/lI0GPEKOyl6YEcMUrSUpGh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 90749DA7;
	Tue, 21 May 2024 05:51:37 -0700 (PDT)
Received: from [192.168.178.6] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 107A23F641;
	Tue, 21 May 2024 05:51:11 -0700 (PDT)
Message-ID: <ef951861-2759-40ed-9d8c-d2eb92da632c@arm.com>
Date: Tue, 21 May 2024 14:51:04 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC][PATCH v1 3/3] cpufreq: intel_pstate: Set asymmetric CPU
 capacity on hybrid systems
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, x86 Maintainers
 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 Linux PM <linux-pm@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Peter Zijlstra <peterz@infradead.org>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 Ricardo Neri <ricardo.neri@intel.com>, Tim Chen <tim.c.chen@intel.com>
References: <7663799.EvYhyI6sBW@kreacher> <1799046.VLH7GnMWUR@kreacher>
 <050c561c-487e-4e89-a7b2-9752cebc9f46@arm.com>
 <CAJZ5v0hGiwoytVmVr=h8JJ1yf5KTcr+p7BrRgSUM-L_X6fciUA@mail.gmail.com>
From: Dietmar Eggemann <dietmar.eggemann@arm.com>
Content-Language: en-US
In-Reply-To: <CAJZ5v0hGiwoytVmVr=h8JJ1yf5KTcr+p7BrRgSUM-L_X6fciUA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 06/05/2024 16:39, Rafael J. Wysocki wrote:
> On Thu, May 2, 2024 at 12:43 PM Dietmar Eggemann
> <dietmar.eggemann@arm.com> wrote:
>>
>> On 25/04/2024 21:06, Rafael J. Wysocki wrote:
>>> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

[...]

>> So cpu_capacity has a direct mapping to itmt prio. cpu_capacity is itmt
>> prio with max itmt prio scaled to 1024.
> 
> Right.
> 
> The choice to make the ITMT prio reflect the capacity is deliberate,
> although this code works with values retrieved via CPPC (which are the
> same as the HWP_CAP values in the majority of cases but not always).
> 
>> Running it on i7-13700K (while allowing SMT) gives:
>>
>> root@gulliver:~# dmesg | grep sched_set_itmt_core_prio
>> [    3.957826] sched_set_itmt_core_prio() cpu=0 prio=68
>> [    3.990401] sched_set_itmt_core_prio() cpu=1 prio=68
>> [    4.015551] sched_set_itmt_core_prio() cpu=2 prio=68
>> [    4.040720] sched_set_itmt_core_prio() cpu=3 prio=68
>> [    4.065871] sched_set_itmt_core_prio() cpu=4 prio=68
>> [    4.091018] sched_set_itmt_core_prio() cpu=5 prio=68
>> [    4.116175] sched_set_itmt_core_prio() cpu=6 prio=68
>> [    4.141374] sched_set_itmt_core_prio() cpu=7 prio=68
>> [    4.166543] sched_set_itmt_core_prio() cpu=8 prio=69
>> [    4.196289] sched_set_itmt_core_prio() cpu=9 prio=69
>> [    4.214964] sched_set_itmt_core_prio() cpu=10 prio=69
>> [    4.239281] sched_set_itmt_core_prio() cpu=11 prio=69
> 
> CPUs 8 - 10 appear to be "favored cores" that can turbo up higher than
> the other P-cores.
> 
>> [    4.263438] sched_set_itmt_core_prio() cpu=12 prio=68
>> [    4.283790] sched_set_itmt_core_prio() cpu=13 prio=68
>> [    4.308905] sched_set_itmt_core_prio() cpu=14 prio=68
>> [    4.331751] sched_set_itmt_core_prio() cpu=15 prio=68
>> [    4.356002] sched_set_itmt_core_prio() cpu=16 prio=42
>> [    4.381639] sched_set_itmt_core_prio() cpu=17 prio=42
>> [    4.395175] sched_set_itmt_core_prio() cpu=18 prio=42
>> [    4.425625] sched_set_itmt_core_prio() cpu=19 prio=42
>> [    4.449670] sched_set_itmt_core_prio() cpu=20 prio=42
>> [    4.479681] sched_set_itmt_core_prio() cpu=21 prio=42
>> [    4.506319] sched_set_itmt_core_prio() cpu=22 prio=42
>> [    4.523774] sched_set_itmt_core_prio() cpu=23 prio=42

I wonder what the relation between this CPU capacity value based on
HWP_CAP is to the per-IPC class performance values of the 'HFI
performance and efficiency score' table is.

Running '[PATCH v3 00/24] sched: Introduce classes of tasks for load
balance' on i7-13700K w/ 'nosmt' I get:

			Score
CPUs	         Class  0 	1	2	3
			SSE	AVX2	VNNI	PAUSE		

0 2,4,6, 12, 14		68 	80	106	53
8, 10			69 	81	108	54
16-23			42 	42	42	42

Looks like the HWP_CAP values are in sync with the scores of IPP Class
0. I was expecting that the HWP_CAP values reflect more an average over
all classes? Or maybe I misinterpret this relation?

[...]

>>> If the driver's "no_trubo" sysfs attribute is updated, all of the CPU
>>> capacity information is computed from scratch to reflect the new turbo
>>> status.
>>
>> So if I do:
>>
>> echo 1 > /sys/devices/system/cpu/intel_pstate/no_turbo
>>
>> I get:
>>
>> [ 1692.801368] hybrid_update_cpu_scaling() called
>> [ 1692.801381] hybrid_update_cpu_scaling() max_cap_perf=44, max_perf_cpu=0
>> [ 1692.801389] hybrid_set_cpu_capacity() cpu=1 cap=1024
>> [ 1692.801395] hybrid_set_cpu_capacity() cpu=2 cap=1024
>> [ 1692.801399] hybrid_set_cpu_capacity() cpu=3 cap=1024
>> [ 1692.801402] hybrid_set_cpu_capacity() cpu=4 cap=1024
>> [ 1692.801405] hybrid_set_cpu_capacity() cpu=5 cap=1024
>> [ 1692.801408] hybrid_set_cpu_capacity() cpu=6 cap=1024
>> [ 1692.801410] hybrid_set_cpu_capacity() cpu=7 cap=1024
>> [ 1692.801413] hybrid_set_cpu_capacity() cpu=8 cap=1024
>> [ 1692.801416] hybrid_set_cpu_capacity() cpu=9 cap=1024
>> [ 1692.801419] hybrid_set_cpu_capacity() cpu=10 cap=1024
>> [ 1692.801422] hybrid_set_cpu_capacity() cpu=11 cap=1024
>> [ 1692.801425] hybrid_set_cpu_capacity() cpu=12 cap=1024
>> [ 1692.801428] hybrid_set_cpu_capacity() cpu=13 cap=1024
>> [ 1692.801431] hybrid_set_cpu_capacity() cpu=14 cap=1024
>> [ 1692.801433] hybrid_set_cpu_capacity() cpu=15 cap=1024
>> [ 1692.801436] hybrid_set_cpu_capacity() cpu=16 cap=605
>> [ 1692.801439] hybrid_set_cpu_capacity() cpu=17 cap=605
>> [ 1692.801442] hybrid_set_cpu_capacity() cpu=18 cap=605
>> [ 1692.801445] hybrid_set_cpu_capacity() cpu=19 cap=605
>> [ 1692.801448] hybrid_set_cpu_capacity() cpu=20 cap=605
>> [ 1692.801451] hybrid_set_cpu_capacity() cpu=21 cap=605
>> [ 1692.801453] hybrid_set_cpu_capacity() cpu=22 cap=605
>> [ 1692.801456] hybrid_set_cpu_capacity() cpu=23 cap=605
>>
>> Turbo on this machine stands only for the cpu_capacity diff 1009 vs 1024?
> 
> Not really.
> 
> The capacity of the fastest CPU is always 1024 and the capacities of
> all of the other CPUs are adjusted to that.
> 
> When turbo is disabled, the capacity of the "favored cores" is the
> same as for the other P-cores (i.e. 1024) and the capacity of E-cores
> is relative to that.
> 
> Of course, this means that task placement may be somewhat messed up
> after disabling or enabling turbo (which is a global switch), but I
> don't think that there is a way to avoid it.

I assume that this is OK. In task placement we don't deal with a system
of perfectly aligned values (including their sums) anyway.
And we recreate the sched domains (including updating the capacity sums
on sched groups) after this so the so load balance (smp nice etc) should
be fine too.

