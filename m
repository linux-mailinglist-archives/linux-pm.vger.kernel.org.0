Return-Path: <linux-pm+bounces-36230-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 3815ABE2445
	for <lists+linux-pm@lfdr.de>; Thu, 16 Oct 2025 11:00:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 14A914E9882
	for <lists+linux-pm@lfdr.de>; Thu, 16 Oct 2025 09:00:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90CDF2DEA99;
	Thu, 16 Oct 2025 09:00:36 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C8793081CF;
	Thu, 16 Oct 2025 09:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760605236; cv=none; b=uVUl9+CBGFki/sGluGpPpHJxEa1/8pWzjEaozqzq9POBpL0nMJkbmLO49C4xBoamr2sksSfRct7xpkjtMyHqcK/P9908LLQfJ9KRctu77+UFRgMpS4d/wqSJovfA5P0hjyZbBacSW8fo4+nJPBHguQuBbRAGeqbOhdvEkCQ1a7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760605236; c=relaxed/simple;
	bh=wv3xX13vFSrdHxGgvQF6JICigI+j3Iw0CTH9HHdGfgs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZktjkzS7+H55dLEDvWaj+GTlRMVyWzAEBzmSgJPDr5Z4iCA1aOCqx+RRjkWymE55/r+vYDvM2RxBibVJLmWOe8ek4sBjEn1RQ9ezAnGOhW8+ccSFWtUsPOBfI5sXn01myTrAe7Y02tct6E2X2noLp3rgtxdm7bp+Bt+vj7qgY8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 714D81688;
	Thu, 16 Oct 2025 02:00:19 -0700 (PDT)
Received: from [10.57.2.120] (unknown [10.57.2.120])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3E3B63F6A8;
	Thu, 16 Oct 2025 02:00:26 -0700 (PDT)
Message-ID: <f48b80d5-0098-424d-9a7c-ae07017ab2bb@arm.com>
Date: Thu, 16 Oct 2025 10:00:24 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] cpufreq: intel_pstate: hybrid: Adjust energy model
 rules
To: Yaxiong Tian <tianyaxiong@kylinos.cn>, rafael@kernel.org
Cc: dietmar.eggemann@arm.com, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org, lukasz.luba@arm.com,
 srinivas.pandruvada@linux.intel.com
References: <3394529.aeNJFYEL58@rafael.j.wysocki>
 <20251016074849.1046580-1-tianyaxiong@kylinos.cn>
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <20251016074849.1046580-1-tianyaxiong@kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 10/16/25 08:48, Yaxiong Tian wrote:
> 在 2025/10/15 21:48, Rafael J. Wysocki 写道:> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>
>> Instead of using HWP-to-frequency scaling factors for computing cost
>> coefficients in the energy model used on hybrid systems, which is
>> fragile, rely on CPU type information that is easily accessible now and
>> the information on whether or not L3 cache is present for this purpose.
>>
>> This also allows the cost coefficients for P-cores to be adjusted so
>> that they start to be populated somewhat earlier (that is, before
>> E-cores are loaded up to their full capacity).
>>
>> In addition to the above, replace an inaccurate comment regarding the
>> reason why the freq value is added to the cost in hybrid_get_cost().
>>
>> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>> ---
>>   drivers/cpufreq/intel_pstate.c |   37 +++++++++++++++----------------------
>>   1 file changed, 15 insertions(+), 22 deletions(-)
>>
>> --- a/drivers/cpufreq/intel_pstate.c
>> +++ b/drivers/cpufreq/intel_pstate.c
>> @@ -933,11 +933,8 @@ static int hybrid_active_power(struct de
>>   			       unsigned long *freq)
>>   {
>>   	/*
>> -	 * Create "utilization bins" of 0-40%, 40%-60%, 60%-80%, and 80%-100%
>> -	 * of the maximum capacity such that two CPUs of the same type will be
>> -	 * regarded as equally attractive if the utilization of each of them
>> -	 * falls into the same bin, which should prevent tasks from being
>> -	 * migrated between them too often.
>> +	 * Create four "states" corresponding to 40%, 60%, 80%, and 100% of the
>> +	 * full capacity.
>>   	 *
>>   	 * For this purpose, return the "frequency" of 2 for the first
>>   	 * performance level and otherwise leave the value set by the caller.
>> @@ -970,26 +967,22 @@ static bool hybrid_has_l3(unsigned int c
>>   static int hybrid_get_cost(struct device *dev, unsigned long freq,
>>   			   unsigned long *cost)
>>   {
>> -	struct pstate_data *pstate = &all_cpu_data[dev->id]->pstate;
>> -
>> +	/* Facilitate load balancing between CPUs of the same type. */
>> +	*cost = freq;
>>   	/*
>> -	 * The smaller the perf-to-frequency scaling factor, the larger the IPC
>> -	 * ratio between the given CPU and the least capable CPU in the system.
>> -	 * Regard that IPC ratio as the primary cost component and assume that
>> -	 * the scaling factors for different CPU types will differ by at least
>> -	 * 5% and they will not be above INTEL_PSTATE_CORE_SCALING.
>> +	 * Adjust the cost depending on CPU type.
>>   	 *
>> -	 * Add the freq value to the cost, so that the cost of running on CPUs
>> -	 * of the same type in different "utilization bins" is different.
>> -	 */
>> -	*cost = div_u64(100ULL * INTEL_PSTATE_CORE_SCALING, pstate->scaling) + freq;
>> -	/*
>> -	 * Increase the cost slightly for CPUs able to access L3 to avoid
>> -	 * touching it in case some other CPUs of the same type can do the work
>> -	 * without it.
>> +	 * The idea is to start loading up LPE-cores before E-cores and start
>> +	 * to populate E-cores when LPE-cores are utilized above 60% of the
>> +	 * capacity.  Similarly, P-cores start to be populated when E-cores are
>> +	 * utilized above 60% of the capacity.
>>   	 */
>> -	if (hybrid_has_l3(dev->id))
>> -		*cost += 2;
>> +	if (hybrid_get_cpu_type(dev->id) == INTEL_CPU_TYPE_ATOM) {
>> +		if (hybrid_has_l3(dev->id)) /* E-core */
>> +			*cost += 2;
>> +	} else { /* P-core */
>> +		*cost += 4;
>> +	}
>>   
>>   	return 0;
>>   }
> 
> Hi Rafael J. Wysocki:
> 
> Is the increment of this cost for different types of CPUs by one instead 
> of two?
> 
> cost by increment of 2:
>           0~40%  40%~60%  60%~80% 80%~100
> LPE-core    2       3        4      5
> E-core      4       5        6      7
> P-core      6       7        8      9
> 
> So, tasks only start being allocated to more powerful CPUs when 
> utilization exceeds 80%, but by that point the system is already in an
>  overloaded state.
> 
> cost by increment of 1:
>           0~40%  40%~60%  60%~80% 80%~100
> LPE-core    2       3        4      5
> E-core      3       4        5      6
> P-core      4       5        6      7
> 
> This situation aligns with the description in your patch.
> 
> The idea of this patch looks good to me.

Agreed if you want the threshold to be 60% for both it should be +1 for l3
and +2 for P-core.
Good catch!


