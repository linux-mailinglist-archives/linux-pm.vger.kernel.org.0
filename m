Return-Path: <linux-pm+bounces-33232-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 938E6B398B6
	for <lists+linux-pm@lfdr.de>; Thu, 28 Aug 2025 11:47:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C81AB1C8296F
	for <lists+linux-pm@lfdr.de>; Thu, 28 Aug 2025 09:48:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A60152EF652;
	Thu, 28 Aug 2025 09:47:37 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A6F92EE29F;
	Thu, 28 Aug 2025 09:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756374457; cv=none; b=Kpk0KkQSHBwbdKxG0pY7bwcI0ME+S+Z+NqflCXb4yxWtTQ7q+Rh5RumOMB3hz4GBu5yxoJlWJudJRmGBaTD0XB0EnbVWqHudyauZX7VEOmbVk6EHIxVaJVa2YHNex2evPlRFHt54Wti4QPcbu0xnEEgElT0DE+7N6mQv+RkwoFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756374457; c=relaxed/simple;
	bh=unCCanafWD+Op7SxlPP2RcQR5N9rwlsOfSFaqOPYg70=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=vDE+FdBo4R5+3T8gQ9x0MM95l+7Eriwsu75c7TZbeAht4PZhpA0XWQyVFvu2eH43CHNowshcKT1Nfcz+XEh1I7LkdG0MihmlGRqkNqfp9e21XhY0DHCCVSJ2RAD7SF+zepPRwGolcc7PlnlacQ50G/+AJtpq5zZ7ieg2HhS/jMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 47EE81688;
	Thu, 28 Aug 2025 02:47:21 -0700 (PDT)
Received: from [10.1.37.80] (e127648.arm.com [10.1.37.80])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 236663F694;
	Thu, 28 Aug 2025 02:47:27 -0700 (PDT)
Message-ID: <d6c93660-f7d9-4be4-ab7a-0d099d548c6a@arm.com>
Date: Thu, 28 Aug 2025 10:47:25 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [linus:master] [cpuidle] 779b1a1cb1:
 perf-bench-sched-pipe.ops_per_sec 12.9% regression
To: kernel test robot <oliver.sang@intel.com>,
 "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc: oe-lkp@lists.linux.dev, lkp@intel.com, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org
References: <202508251419.d8117ed7-lkp@intel.com>
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <202508251419.d8117ed7-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/25/25 08:11, kernel test robot wrote:
> 
> 
> Hello,
> 
> kernel test robot noticed a 12.9% regression of perf-bench-sched-pipe.ops_per_sec on:
> 
> 
> commit: 779b1a1cb13ae17028aeddb2fbbdba97357a1e15 ("cpuidle: governors: menu: Avoid selecting states with too much latency")
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
> 
> [still regression on      linus/master 1b237f190eb3d36f52dffe07a40b5eb210280e00]
> [still regression on linux-next/master 0f4c93f7eb861acab537dbe94441817a270537bf]
> 
> testcase: perf-bench-sched-pipe
> config: x86_64-rhel-9.4
> compiler: gcc-12
> test machine: 192 threads 4 sockets Intel(R) Xeon(R) Platinum 9242 CPU @ 2.30GHz (Cascade Lake) with 176G memory
> parameters:
> 
> 	loops: 10000000ops
> 	mode: threads
> 	cpufreq_governor: performance
> 
> 
> In addition to that, the commit also has significant impact on the following tests:
> 
> +------------------+-----------------------------------------------------------------------------+
> | testcase: change | qperf: qperf.udp.latency 8.1% regression                                    |
> | test machine     | 8 threads Intel(R) Core(TM) i7-6700 CPU @ 3.40GHz (Skylake) with 16G memory |
> | test parameters  | cluster=cs-localhost                                                        |
> |                  | cpufreq_governor=performance                                                |
> |                  | runtime=600s                                                                |
> +------------------+-----------------------------------------------------------------------------+
> 
> [snip]

This looks reasonable to me, we no longer compare s->exit_latency_ns <= latency_req( == predicted_ns)
but now just s->target_residency_ns <= data->next_timer_ns) to NOT select a polling state.

Plugging in some values:
idx0 POLLING 0:0
idx1 20000:50000
No latency_req, tick_nohz_tick_stopped() == false.
predicted_ns == 10000, data->next_timer_ns == 1000000

used to pick polling idx0 because:
latency_req = predicted_ns
// for i = 1, idx = 0
                if (s->target_residency_ns > predicted_ns) { // true
                        /*
                         * Use a physical idle state, not busy polling, unless
                         * a timer is going to trigger soon enough.
                         */
                        if ((drv->states[idx].flags & CPUIDLE_FLAG_POLLING) && // true
                            s->exit_latency_ns <= latency_req && // false
                            s->target_residency_ns <= data->next_timer_ns) { // true
                                predicted_ns = s->target_residency_ns;
                                idx = i;

now:
// for i = 1, idx = 0
(latency_req == UINT_MAX, predicted_ns == 10000)
                if (s->target_residency_ns > predicted_ns) { // true
                        /*
                         * Use a physical idle state, not busy polling, unless
                         * a timer is going to trigger soon enough.
                         */
                        if ((drv->states[idx].flags & CPUIDLE_FLAG_POLLING) && // true
                            s->target_residency_ns <= data->next_timer_ns) { // true
                                predicted_ns = s->target_residency_ns;
                                idx = i;


