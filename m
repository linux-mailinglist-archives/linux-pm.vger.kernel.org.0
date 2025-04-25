Return-Path: <linux-pm+bounces-26258-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E0FDA9D41F
	for <lists+linux-pm@lfdr.de>; Fri, 25 Apr 2025 23:32:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 796091BC5FE3
	for <lists+linux-pm@lfdr.de>; Fri, 25 Apr 2025 21:32:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4498B21D5BE;
	Fri, 25 Apr 2025 21:32:26 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 580BE20C000;
	Fri, 25 Apr 2025 21:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745616746; cv=none; b=FK6WZgZb77uYIL+QPE8cQpjMwlw/zuI6bpv2ritEFKsLQ76Ni/7vrdBrHyTBHKR+m9umQt/LAwfXCBnOnM6hTGvTG8WFZ6mvqUcfAQtlPRetIrXrY25HEOV/yvVJhYMtQimfTkr2vqEbNXhvkS7AbuAh99ah+GB1g+amgHE4lws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745616746; c=relaxed/simple;
	bh=6lXg65MUiOuqW0EOoABffYufulqRAP6hL9vJPvekLSE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QmTTZDZeOVaprtaVmZhq8pPQNEZ3H/NhTEPIjG1H7O092TBrdWeQ94LJg34XMMk1bSoXD8uY5GvHITRbQAYIGgxnuc/QC7kfIN/vBJKFGfWoz3GrbNpTTuDXwsJOjRT3dlZbppTi2J1GwvN8SiKbFJgD1ZIOaAfF4gR+IoWaqSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BB873106F;
	Fri, 25 Apr 2025 14:32:16 -0700 (PDT)
Received: from [10.57.71.211] (unknown [10.57.71.211])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C2F8C3F59E;
	Fri, 25 Apr 2025 14:32:19 -0700 (PDT)
Message-ID: <1c6b70d1-279c-4d9d-ae31-2751daed04f6@arm.com>
Date: Fri, 25 Apr 2025 22:32:17 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFT][PATCH v1 8/8] cpufreq: intel_pstate: EAS: Increase cost for
 CPUs using L3 cache
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
 <47159248.fMDQidcC6G@rjwysocki.net>
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <47159248.fMDQidcC6G@rjwysocki.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/16/25 19:12, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> On some hybrid platforms some efficient CPUs (E-cores) are not connected
> to the L3 cache, but there are no other differences between them and the
> other E-cores that use L3.  In that case, it is generally more efficient
> to run "light" workloads on the E-cores that do not use L3 and allow all
> of the cores using L3, including P-cores, to go into idle states.
> 
> For this reason, slightly increase the cost for all CPUs sharing the L3
> cache to make EAS prefer CPUs that do not use it to the other CPUs with
> the same perf-to-frequency scaling factor (if any).
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  drivers/cpufreq/intel_pstate.c |    8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> --- a/drivers/cpufreq/intel_pstate.c
> +++ b/drivers/cpufreq/intel_pstate.c
> @@ -979,6 +979,7 @@
>  			   unsigned long *cost)
>  {
>  	struct pstate_data *pstate = &all_cpu_data[dev->id]->pstate;
> +	struct cpu_cacheinfo *cacheinfo = get_cpu_cacheinfo(dev->id);
>  
>  	/*
>  	 * The smaller the perf-to-frequency scaling factor, the larger the IPC
> @@ -991,6 +992,13 @@
>  	 * of the same type in different "utilization bins" is different.
>  	 */
>  	*cost = div_u64(100ULL * INTEL_PSTATE_CORE_SCALING, pstate->scaling) + freq;
> +	/*
> +	 * Inrease the cost slightly for CPUs able to access L3 to avoid litting

s/Inrease/Increase
and I guess s/litting/littering

> +	 * it up too eagerly in case some other CPUs of the same type cannot
> +	 * access it.
> +	 */
> +	if (cacheinfo->num_levels >= 3)
> +		(*cost)++;

This makes cost(OPP1) of the SoC Tile e-core as expensive as cost(OPP0) of a
normal e-core.
Is that the intended behaviour?

