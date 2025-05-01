Return-Path: <linux-pm+bounces-26504-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DD50AA5E6A
	for <lists+linux-pm@lfdr.de>; Thu,  1 May 2025 14:30:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B56451BC43C3
	for <lists+linux-pm@lfdr.de>; Thu,  1 May 2025 12:30:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1FEC188A0E;
	Thu,  1 May 2025 12:30:28 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F7DF1DA53;
	Thu,  1 May 2025 12:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746102628; cv=none; b=kgYdm8+3xmnA7xB+WQtjOKFVg43ogg+0dW4WAgWXu4SNoKrafvtsVAeABVNv9eqrBjTQ9mTAAwpmjnkE2DHoPN9/8TaEV2ytweo+dho+aAiMvFdp+jUmpWaPy7fCHWzHpIUO98Ts/UdPbn5VIV/VxzJf+Jud/LRpuOkYNbFl0Is=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746102628; c=relaxed/simple;
	bh=dOykAr9eT1haE1ID/jylavyCYevbyxlVphpG7wSzCxk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KKH4ol2GWAqllFfQ4CipcAjltHe2tWMyTQJX3XQ41syaTHE63CgSB9ZNo0XdyoJGihjJ2z9RNK4byQWBa7sYDLrlMmCw0vKE5/rENhNqU6B2yAI4Lh/YdrdqT+YhhGbe7jLOURKx4RmySWEuxPn48xgTw+xNemPgeciUlfXKKdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A2EE41D14;
	Thu,  1 May 2025 05:30:18 -0700 (PDT)
Received: from [192.168.178.25] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EBBF73F673;
	Thu,  1 May 2025 05:30:23 -0700 (PDT)
Message-ID: <c3eda6eb-3e01-4d9c-bcbc-348e5f5552cc@arm.com>
Date: Thu, 1 May 2025 14:30:07 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFT][PATCH v1 5/8] PM: EM: Introduce em_adjust_cpu_capacity()
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 Lukasz Luba <lukasz.luba@arm.com>, Peter Zijlstra <peterz@infradead.org>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 Morten Rasmussen <morten.rasmussen@arm.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
 Pierre Gondois <pierre.gondois@arm.com>,
 Christian Loehle <christian.loehle@arm.com>
References: <3344336.aeNJFYEL58@rjwysocki.net>
 <2649447.Lt9SDvczpP@rjwysocki.net>
 <61cd69f5-6790-4480-8fe7-77ef763ed82b@arm.com>
 <CAJZ5v0h=wR464YqDEesnm3QscJ4UBy8CX0ixZV6QsY0DS22E8A@mail.gmail.com>
From: Dietmar Eggemann <dietmar.eggemann@arm.com>
Content-Language: en-US
In-Reply-To: <CAJZ5v0h=wR464YqDEesnm3QscJ4UBy8CX0ixZV6QsY0DS22E8A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 30/04/2025 21:23, Rafael J. Wysocki wrote:
> On Sun, Apr 27, 2025 at 4:07 PM Dietmar Eggemann
> <dietmar.eggemann@arm.com> wrote:
>>
>> On 16/04/2025 20:06, Rafael J. Wysocki wrote:
>>> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

[...]

>>> +     if (!(pd->flags & EM_PERF_DOMAIN_ARTIFICIAL)) {
>>
>> This looks weird to me. How can an artificial EM ever have a non-ZERO
>> em_data_callback here?
>>
>> There is already EM_PERF_DOMAIN_ARTIFICIAL specific handling in
>> em_compute_costs(). Which probably works well for the
>> em_create_perf_table() call-site.
> 
> Yes, but that one doesn't pass a NULL cb pointer to it.
> 
>> Will there be cases for Hybrid CPU EM's in which 'em_max_perf !=
>> cpu_capacity':
> 
> When the capacity is updated, the EM needs to be updated accordingly,
> which is why the new function is being added.
> 
>> em_adjust_new_capacity()
>>
>>   if (em_max_perf == cpu_capacity)
>>     return
>>
>>   em_recalc_and_update()
>>     em_compute_costs()
>>
>> so that em_compute_costs() might be called?
>>
>> Maybe:
>>
>> @@ -233,11 +237,17 @@ static int em_compute_costs(struct device *dev,
>> struct em_perf_state *table,
>>         unsigned long prev_cost = ULONG_MAX;
>>         int i, ret;
>>
>> +       if (!cb && (flags & EM_PERF_DOMAIN_ARTIFICIAL))
>> +               return 0;
>>
>> is somehow clearer in this case?
> 
> This would work, but I prefer my version because it does one check
> less and it does the check directly in em_recalc_and_update(), so it
> is clear that this doesn't call em_compute_costs() for artificial PDs
> at all.

OK, but checking it inside em_compute_costs() would also avoid this 'cb
= NULL' crash for an artificial EM in:

int em_dev_compute_costs(struct device *dev, struct em_perf_state
                         *table, int nr_states)
{
        return em_compute_costs(dev, table, NULL, nr_states, 0);
}

BTW, there is this:

#define em_is_artificial(em) ((em)->flags & EM_PERF_DOMAIN_ARTIFICIAL)

(I guess s/em/pd ?) which lets you check this when you have the perf
domain. So far it's used in dtpm, cpu- and devfreq cooling.

Anyway, you can add my:

Reviewed-by: Dietmar Eggemann <dietmar.eggemann@arm.com>

for the entire set.














