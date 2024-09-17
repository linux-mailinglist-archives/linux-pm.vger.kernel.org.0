Return-Path: <linux-pm+bounces-14376-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5144797B466
	for <lists+linux-pm@lfdr.de>; Tue, 17 Sep 2024 21:41:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22B9E28349B
	for <lists+linux-pm@lfdr.de>; Tue, 17 Sep 2024 19:41:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D30C317C99B;
	Tue, 17 Sep 2024 19:41:34 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D287E1E520;
	Tue, 17 Sep 2024 19:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726602094; cv=none; b=EH1zyl5fo66CQ53xpefKjIbruhTcU61XApfgowa3E38g2OR411oEghR0w6TMxjsSKfp5D+ntupGWik9LztLQXwyjMhsDINCPVHxDCiCpWYbZCWE+NvEklrMt9EIVjaEz4TQGy5KqPOADvI3kcbMxvUwZ3vjoUaVkl2Oudob9B10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726602094; c=relaxed/simple;
	bh=1HeKqf7aKDKjVP6DHY3EQCHjKTcXwcwSP5hCyb26e4Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rIaFhoJbaEXHMWZifNuPj0I3M7op5vk9vljCEpcbCn2sXA8WaNPBc1XrZHCgTriM0GSIrBlkv1hjmiEyH0hp/gNQIR5QjTDlPTCDUvDhxcEO86J1YSRIvsgRSMU8DRnlSmsALAbQpwtlEIbg9IO9IhL4ZSSkwWX0toibWbto6SI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AD8BC339;
	Tue, 17 Sep 2024 12:41:59 -0700 (PDT)
Received: from [10.1.47.44] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AE4023F64C;
	Tue, 17 Sep 2024 12:41:27 -0700 (PDT)
Message-ID: <2544d644-d107-49a7-a64e-25334315b51a@arm.com>
Date: Tue, 17 Sep 2024 21:41:25 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 04/16] sched/fair: Remove magic hardcoded margin in
 fits_capacity()
To: "Sultan Alsawaf (unemployed)" <sultan@kerneltoast.com>,
 Qais Yousef <qyousef@layalina.io>
Cc: Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>, Juri Lelli <juri.lelli@redhat.com>,
 Steven Rostedt <rostedt@goodmis.org>, John Stultz <jstultz@google.com>,
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240820163512.1096301-1-qyousef@layalina.io>
 <20240820163512.1096301-5-qyousef@layalina.io>
 <ZsbH_EtbOPxtLMU0@sultan-box.localdomain>
From: Dietmar Eggemann <dietmar.eggemann@arm.com>
Content-Language: en-US
In-Reply-To: <ZsbH_EtbOPxtLMU0@sultan-box.localdomain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 22/08/2024 07:09, Sultan Alsawaf (unemployed) wrote:
> Hi Qais,
> 
> On Tue, Aug 20, 2024 at 05:35:00PM +0100, Qais Yousef wrote:
>> Replace hardcoded margin value in fits_capacity() with better dynamic
>> logic.
>>
>> 80% margin is a magic value that has served its purpose for now, but it
>> no longer fits the variety of systems that exist today. If a system is
>> over powered specifically, this 80% will mean we leave a lot of capacity
>> unused before we decide to upmigrate on HMP system.
>>
>> On many systems the little cores are under powered and ability to
>> migrate faster away from them is desired.
>>
>> Redefine misfit migration to mean the utilization threshold at which the
>> task would become misfit at the next load balance event assuming it
>> becomes an always running task.
>>
>> To calculate this threshold, we use the new approximate_util_avg()
>> function to find out the threshold, based on arch_scale_cpu_capacity()
>> the task will be misfit if it continues to run for a TICK_USEC which is
>> our worst case scenario for when misfit migration will kick in.

[...]

>> +	/*
>> +	 * Calculate the util at which the task must be considered a misfit.
>> +	 *
>> +	 * We must ensure that a task experiences the same ramp-up time to
>> +	 * reach max performance point of the system regardless of the CPU it
>> +	 * is running on (due to invariance, time will stretch and task will
>> +	 * take longer to achieve the same util value compared to a task
>> +	 * running on a big CPU) and a delay in misfit migration which depends
>> +	 * on TICK doesn't end up hurting it as it can happen after we would
>> +	 * have crossed this threshold.
>> +	 *
>> +	 * To ensure that invaraince is taken into account, we don't scale time
>> +	 * and use it as-is, approximate_util_avg() will then let us know the
>> +	 * our threshold.
>> +	 */
>> +	limit = approximate_runtime(arch_scale_cpu_capacity(cpu)) * USEC_PER_MSEC;
> 
> Perhaps it makes more sense to use `capacity` here instead of
> `arch_scale_cpu_capacity(cpu)`? Seems like reduced capacity due to HW pressure
> (and IRQs + RT util) should be considered, e.g. for a capacity inversion due to
> HW pressure on a mid core that results in a little core being faster.

If you want to keep it strictly 'uarch & freq-invariant' based, then it
wouldn't have to be called periodically in update_cpu_capacity(). Just
set rq->fits_capacity_threshold once after cpu_scale has been fully
(uArch & Freq) normalized.

[...]

