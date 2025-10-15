Return-Path: <linux-pm+bounces-36201-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 10F75BDF4A9
	for <lists+linux-pm@lfdr.de>; Wed, 15 Oct 2025 17:13:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id F3CA34E2898
	for <lists+linux-pm@lfdr.de>; Wed, 15 Oct 2025 15:13:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E56D62DF14D;
	Wed, 15 Oct 2025 15:13:54 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31D5C2DF149;
	Wed, 15 Oct 2025 15:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760541234; cv=none; b=n91B7nqXtmKUGNGLGe1bLo54L+BpsmbKIoARTct8sqMdqWXCqm+DaN1HkdRQKg+kwqNazumbmBkyvu2bMYysnudcCwroxbR0bwVZz70okV4qW7brTrkeU7kWBDaQP4jECsKN55Ytulr6u7Br0rxLqrjoqqsMbX+ksGW86vtk7o4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760541234; c=relaxed/simple;
	bh=syOQNuZ+chkT69+dUmBGhembYwbff5K2oDJ9i7viO9I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=d5ZBUXoojHRxm3P3s0B9oJ9EzTWG5qY09aUwU9EAbLhy22+OB5fF7ekpF7DmMIjd4o0PHoBXol1f0bam27rBkWSMZymwdQ+RSYEB3QoD1vENLBvzI7fFZymebqsxn58q9yrAccmEkiqrX4tQXUfzPkLAHHOA2CJQQVVspL1vqmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 560A91655;
	Wed, 15 Oct 2025 08:13:44 -0700 (PDT)
Received: from [10.1.32.75] (e127648.arm.com [10.1.32.75])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D5A6E3F738;
	Wed, 15 Oct 2025 08:13:50 -0700 (PDT)
Message-ID: <012930da-7b24-4670-981b-f5eab98c93d7@arm.com>
Date: Wed, 15 Oct 2025 16:13:48 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] cpufreq: intel_pstate: hybrid: Adjust energy model
 rules
To: "Rafael J. Wysocki" <rafael@kernel.org>,
 Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Lukasz Luba <lukasz.luba@arm.com>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Yaxiong Tian <tianyaxiong@kylinos.cn>
References: <2404176.ElGaqSPkdT@rafael.j.wysocki>
 <3394529.aeNJFYEL58@rafael.j.wysocki>
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <3394529.aeNJFYEL58@rafael.j.wysocki>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/15/25 14:48, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Instead of using HWP-to-frequency scaling factors for computing cost
> coefficients in the energy model used on hybrid systems, which is
> fragile, rely on CPU type information that is easily accessible now and
> the information on whether or not L3 cache is present for this purpose.
> 
> This also allows the cost coefficients for P-cores to be adjusted so
> that they start to be populated somewhat earlier (that is, before
> E-cores are loaded up to their full capacity).
> 
> In addition to the above, replace an inaccurate comment regarding the
> reason why the freq value is added to the cost in hybrid_get_cost().
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  drivers/cpufreq/intel_pstate.c |   37 +++++++++++++++----------------------
>  1 file changed, 15 insertions(+), 22 deletions(-)
> 
> --- a/drivers/cpufreq/intel_pstate.c
> +++ b/drivers/cpufreq/intel_pstate.c
> @@ -933,11 +933,8 @@ static int hybrid_active_power(struct de
>  			       unsigned long *freq)
>  {
>  	/*
> -	 * Create "utilization bins" of 0-40%, 40%-60%, 60%-80%, and 80%-100%
> -	 * of the maximum capacity such that two CPUs of the same type will be
> -	 * regarded as equally attractive if the utilization of each of them
> -	 * falls into the same bin, which should prevent tasks from being
> -	 * migrated between them too often.
> +	 * Create four "states" corresponding to 40%, 60%, 80%, and 100% of the
> +	 * full capacity.
>  	 *
>  	 * For this purpose, return the "frequency" of 2 for the first
>  	 * performance level and otherwise leave the value set by the caller.
> @@ -970,26 +967,22 @@ static bool hybrid_has_l3(unsigned int c
>  static int hybrid_get_cost(struct device *dev, unsigned long freq,
>  			   unsigned long *cost)
>  {
> -	struct pstate_data *pstate = &all_cpu_data[dev->id]->pstate;
> -
> +	/* Facilitate load balancing between CPUs of the same type. */
> +	*cost = freq;
>  	/*
> -	 * The smaller the perf-to-frequency scaling factor, the larger the IPC
> -	 * ratio between the given CPU and the least capable CPU in the system.
> -	 * Regard that IPC ratio as the primary cost component and assume that
> -	 * the scaling factors for different CPU types will differ by at least
> -	 * 5% and they will not be above INTEL_PSTATE_CORE_SCALING.
> +	 * Adjust the cost depending on CPU type.
>  	 *
> -	 * Add the freq value to the cost, so that the cost of running on CPUs
> -	 * of the same type in different "utilization bins" is different.
> -	 */
> -	*cost = div_u64(100ULL * INTEL_PSTATE_CORE_SCALING, pstate->scaling) + freq;
> -	/*
> -	 * Increase the cost slightly for CPUs able to access L3 to avoid
> -	 * touching it in case some other CPUs of the same type can do the work
> -	 * without it.
> +	 * The idea is to start loading up LPE-cores before E-cores and start
> +	 * to populate E-cores when LPE-cores are utilized above 60% of the
> +	 * capacity.  Similarly, P-cores start to be populated when E-cores are
> +	 * utilized above 60% of the capacity.
>  	 */
> -	if (hybrid_has_l3(dev->id))
> -		*cost += 2;
> +	if (hybrid_get_cpu_type(dev->id) == INTEL_CPU_TYPE_ATOM) {
> +		if (hybrid_has_l3(dev->id)) /* E-core */
> +			*cost += 2;
> +	} else { /* P-core */
> +		*cost += 4;
> +	}

Interesting, is there any reason in particular why you're looking to change this?
Is it just performance because of the extra headroom? (I recall that your E-cores
are always more efficient than your P-cores at comparable computing power).

How long does it take to trigger overutilized for you?
I still have the OU based on 'last idle time' observation patches lying around,
although I haven't found the time to do more extensive testing if it doesn't
regress some platform / workload combination. I will dust them off soon, although
I'm not sure if they would help your case.
Happy to try though if you had a particular workload in mind!

