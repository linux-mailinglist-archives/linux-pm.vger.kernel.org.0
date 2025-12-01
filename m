Return-Path: <linux-pm+bounces-38979-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74BD3C980BC
	for <lists+linux-pm@lfdr.de>; Mon, 01 Dec 2025 16:27:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 332C03A330F
	for <lists+linux-pm@lfdr.de>; Mon,  1 Dec 2025 15:27:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 637C532C930;
	Mon,  1 Dec 2025 15:27:24 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E692432C948
	for <linux-pm@vger.kernel.org>; Mon,  1 Dec 2025 15:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764602844; cv=none; b=gxmNYmOi+gnI+SJa+J7aj4zW8KFEH9ISCs/QVCZ4TsmDaal7NRgJcn9Fd83TCLNAB7robWhSp1r0v9uHq0l62taWbsR0wYXj4rO5PHwYuVq4pB5G62SuJ3s+6DZxng9hxB+orjHslBE/X90DjwdlfkfoGbg5dyO4ODTSqthfqhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764602844; c=relaxed/simple;
	bh=5BNrUbY/pkzmu+eeFr5vbjQI8NG4FM5+FLGCVekR+CQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nYPkY2TBnzJkGdty/SDgo47gz5AAsAjnQQXVMDsFpk4walxuF2PHEBCEfYVG6u58bz9T2VCM7eQlT4/PK0Org6jCxtHqu4t+IQ2fLwf5XzCMJpE/Kqamib77r+UQsJKAvlKzcMARpUkQPE4oPaWoUX4rlJt3sPC/oFEuRVwr0fQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5F280153B;
	Mon,  1 Dec 2025 07:27:13 -0800 (PST)
Received: from arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C054F3F836;
	Mon,  1 Dec 2025 07:27:14 -0800 (PST)
Date: Mon, 1 Dec 2025 16:27:12 +0100
From: Beata Michalska <beata.michalska@arm.com>
To: Lifeng Zheng <zhenglifeng1@huawei.com>
Cc: catalin.marinas@arm.com, will@kernel.org, rafael@kernel.org,
	viresh.kumar@linaro.org, sudeep.holla@arm.com,
	gregkh@linuxfoundation.org, dakr@kernel.org,
	ionela.voinescu@arm.com, linux-arm-kernel@lists.infradead.org,
	linux-pm@vger.kernel.org, linuxarm@huawei.com,
	jonathan.cameron@huawei.com, vincent.guittot@linaro.org,
	zhanjie9@hisilicon.com, lihuisong@huawei.com, yubowen8@huawei.com,
	zhangpengjie2@huawei.com, wangzhi12@huawei.com,
	linhongye@h-partners.com
Subject: Re: [PATCH v6 0/3] arm64: topology: Handle AMU FIE setup on CPU
 hotplug
Message-ID: <aS2z0EURwHbbGZab@arm.com>
References: <20251119081356.2495290-1-zhenglifeng1@huawei.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251119081356.2495290-1-zhenglifeng1@huawei.com>

Hi,

Apologies for the delay in reviewing this - currently in progress....
Out of curiosity: what's the cpufreq driver used for testing this series ?

---
BR
Beata
On Wed, Nov 19, 2025 at 04:13:53PM +0800, Lifeng Zheng wrote:
> Solve a problem that causes CPUs Setup AMU FIE failed in a corner case,
> even though they're eligible.
> 
> Changelog:
> 
> v6:
> 
>  - discard the modifications in cpufreq.c, and instead, make
>    supports_scale_freq_counters() checks that at least one CPU in the
>    policy supports AMU FIE, instead of all
>  - based on Beata's feedback, optimize cpuhp_topology_online() to make it
>    more readable
>  - use pr_warn instead of WARN_ON to show warning message when the
>    freq_counters_valid() check fails in cpuhp_topology_online()
>  - modify commit message as Beata and Rafael suggested
> 
> v5:
> 
>  - add a default implementation for cpufreq_cpu_policy() when
>    CONFIG_CPU_FREQ is not defined
> 
> v4:
> 
>  - change the function's name in patch 2 from
>    'cpufreq_cpu_get_raw_no_check' to 'cpufreq_cpu_policy'
>  - use only one line in the function body of cpufreq_cpu_policy()
>  - use cpus mask instead of related_cpus when calling arch_set_freq_scale()
>    in cpufreq.c
>  - add a warning when the freq_counters_valid() check fails in
>    cpuhp_topology_online()
> 
> v3:
> 
>  - add a patch to optimize amu_fie_setup()
>  - add a patch to add a function to get cpufreq policy without checking if
>    the CPU is online
>  - discard the reuse of amu_fie_setup() in cpuhp_topology_online() and keep
>    all the new logic in cpuhp_topology_online()
>  - test only the CPU which is going online in cpuhp_topology_online()
>  - when the freq_counters_valid() check fails, not only clear the scale
>    freq source but also clear all the related CPUs from amu_fie_cpus mask
>  - add some comments
> 
> v2:
> 
>  - keep init_amu_fie_notifier for setting up AMU FIE when the cpufreq
>    policy is being created
>  - set up AMU FIE only for online CPUs instead of related_cpus in
>    init_amu_fie_callback()
>  - check and set all the online CPUs in the same policy when hotplug one
>  - clear scale freq source for all the online CPUs in the same policy to
>    avoid using different source of the freq scale
> 
> ---
> Discussions of previous version:
> v1: https://lore.kernel.org/all/20250607094533.416368-1-zhenglifeng1@huawei.com/
> v2: https://lore.kernel.org/all/20250725102813.1404322-1-zhenglifeng1@huawei.com/
> v3: https://lore.kernel.org/all/20250805093330.3715444-1-zhenglifeng1@huawei.com/
> v4: https://lore.kernel.org/all/20250814072853.3426386-1-zhenglifeng1@huawei.com/
> v5: https://lore.kernel.org/all/20250819072931.1647431-1-zhenglifeng1@huawei.com/
> 
> Lifeng Zheng (3):
>   arm64: topology: Skip already covered CPUs when setting freq source
>   cpufreq: Add new helper function returning cpufreq policy
>   arm64: topology: Handle AMU FIE setup on CPU hotplug
> 
>  arch/arm64/kernel/topology.c | 67 ++++++++++++++++++++++++++++++++++--
>  drivers/base/arch_topology.c |  9 ++++-
>  drivers/cpufreq/cpufreq.c    |  6 ++++
>  include/linux/cpufreq.h      |  5 +++
>  4 files changed, 83 insertions(+), 4 deletions(-)
> 
> -- 
> 2.33.0
> 

