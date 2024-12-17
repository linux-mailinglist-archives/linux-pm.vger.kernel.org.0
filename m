Return-Path: <linux-pm+bounces-19369-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7342C9F4B28
	for <lists+linux-pm@lfdr.de>; Tue, 17 Dec 2024 13:42:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB87D164D21
	for <lists+linux-pm@lfdr.de>; Tue, 17 Dec 2024 12:42:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 621C51F2C23;
	Tue, 17 Dec 2024 12:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="C8bVd78O"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61D1D1F12FA;
	Tue, 17 Dec 2024 12:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734439371; cv=none; b=YVjo1iPYPYkcSNP9prmxBz8Z16lXu/zNizvpkjbm9gB3T2Lp41jgxYoxZPlRIKCxLSYjRbCMFIhRSVt10lWaFfzqpu6AUI4NGPlbwzLsTVl6hONSKdh+zax79IJwPlHC+BKsgkhB8F+lp8SVLBoCbM6I+MnX9g8QDh7b78D7lLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734439371; c=relaxed/simple;
	bh=IBow5Q+/ahbEbl2AJp+9GIlzjEFcfY6jpwl/h1/bkjA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=I2iVYcIuBF26juz1tRIZRSNOfDPfDpfUTm7AUxDMkCQTDRuHkeU6oQNT+wZvNwxYy+oL1tOWke0kGEdoLZclZlRJpFrVNNmGdjHW2zW/k/FY5wiaYFg+lczjFcnwSEdByqI/+hnZ1t1bsNnNy/b4MKkM6YBOTL/muNW+tEDx4pg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=C8bVd78O; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734439369; x=1765975369;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=IBow5Q+/ahbEbl2AJp+9GIlzjEFcfY6jpwl/h1/bkjA=;
  b=C8bVd78OGzKLuJzT7JtsRM4sq/t2k6ZzL8LYCWimoMH9CFtnBlSR938v
   JobdPyJ7Ob05/iwLt7rt4Ncq57ZeZTXAM6JYZ8p2QOY/wU5Q5k7tZgkyJ
   Jm1cChFmjg3THm2N5SBmfZYKZrsUvWlmZJeAQf4yky0xxqWMWIsk1wWmw
   Dc84XuaD17HoiTnlU23RN3BBhFUcC3kj7Bvk4ZpHEhQ1JOo5E3bgW0n1C
   G6efBhAR4nTuEGbDgR/nsv2Gx0NCbbXNl0fuvepZ/CqmYmqI5W5IpzKX1
   oPScS6b0HmGn/VIS9fMHnlEQoQsWzPH+uIMia0KObiRyAY+o9O/qdcdtl
   Q==;
X-CSE-ConnectionGUID: drg3KRuBS6W3CEFIsGyEzQ==
X-CSE-MsgGUID: 8zXQ8oN9Si6atLWpgg0M4Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11288"; a="35084438"
X-IronPort-AV: E=Sophos;i="6.12,241,1728975600"; 
   d="scan'208";a="35084438"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Dec 2024 04:42:48 -0800
X-CSE-ConnectionGUID: sG414cBhRt6lumNQ8O7dfA==
X-CSE-MsgGUID: Jm79IggMSQa7+VUnFhhvnw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="134866979"
Received: from ksztyber-mobl2.ger.corp.intel.com (HELO [10.245.245.179]) ([10.245.245.179])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Dec 2024 04:42:45 -0800
Message-ID: <6bb2ba2e-bb51-4637-b254-2603c38a5537@linux.intel.com>
Date: Tue, 17 Dec 2024 13:42:35 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 3/4] intel_idle: Provide the default enter_dead()
 handler
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
 rafael.j.wysocki@intel.com, peterz@infradead.org,
 dave.hansen@linux.intel.com, gautham.shenoy@amd.com, tglx@linutronix.de,
 len.brown@intel.com, artem.bityutskiy@linux.intel.com
References: <20241204140828.11699-1-patryk.wlazlyn@linux.intel.com>
 <20241204140828.11699-4-patryk.wlazlyn@linux.intel.com>
 <CAJZ5v0hL0QOT17DnsUKONHVy1+Yy84soPWU74gHAxjsozerPgg@mail.gmail.com>
Content-Language: en-US
From: Patryk Wlazlyn <patryk.wlazlyn@linux.intel.com>
In-Reply-To: <CAJZ5v0hL0QOT17DnsUKONHVy1+Yy84soPWU74gHAxjsozerPgg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

>> Recent Intel platforms require idle driver to provide information about
>> the MWAIT hint used to enter the deepest idle state in the play_dead
>> code.
>>
>> Provide the default enter_dead() handler for all of the platforms and
>> allow overwriting with a custom handler for each platform if needed.
>
> My changelog for this patch:
>
> "A subsequent change is going to make native_play_dead() rely on the
> idle driver to put CPUs going offline into appropriate idle states.
>
> For this reason, provide the default :enter_dead() handler for all of
> the idle states on all platforms supported by intel_idle with an
> option to override it with a custom handler if needed."
>

Ok. I'll apply that in the next version.

>> Signed-off-by: Patryk Wlazlyn <patryk.wlazlyn@linux.intel.com>
>> ---
>>  drivers/idle/intel_idle.c | 18 ++++++++++++++++--
>>  1 file changed, 16 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/idle/intel_idle.c b/drivers/idle/intel_idle.c
>> index ac4d8faa3886..c6874a6dbe95 100644
>> --- a/drivers/idle/intel_idle.c
>> +++ b/drivers/idle/intel_idle.c
>> @@ -56,6 +56,7 @@
>>  #include <asm/mwait.h>
>>  #include <asm/spec-ctrl.h>
>>  #include <asm/fpu/api.h>
>> +#include <asm/smp.h>
>>
>>  #define INTEL_IDLE_VERSION "0.5.1"
>>
>> @@ -227,6 +228,16 @@ static __cpuidle int intel_idle_s2idle(struct cpuidle_device *dev,
>>         return 0;
>>  }
>>
>> +static __cpuidle void intel_idle_enter_dead(struct cpuidle_device *dev,
>> +                                           int index)
>> +{
>> +       struct cpuidle_driver *drv = cpuidle_get_cpu_driver(dev);
>> +       struct cpuidle_state *state = &drv->states[index];
>> +       unsigned long eax = flg2MWAIT(state->flags);
>> +
>> +       mwait_play_dead(eax);
>> +}
>> +
>>  /*
>>   * States are indexed by the cstate number,
>>   * which is also the index into the MWAIT hint array.
>> @@ -1798,6 +1809,7 @@ static void __init intel_idle_init_cstates_acpi(struct cpuidle_driver *drv)
>>                         state->flags |= CPUIDLE_FLAG_TIMER_STOP;
>>
>>                 state->enter = intel_idle;
>> +               state->enter_dead = intel_idle_enter_dead;
>>                 state->enter_s2idle = intel_idle_s2idle;
>>         }
>>  }
>> @@ -2143,10 +2155,12 @@ static void __init intel_idle_init_cstates_icpu(struct cpuidle_driver *drv)
>>                 if (intel_idle_max_cstate_reached(cstate))
>>                         break;
>>
>> -               if (!cpuidle_state_table[cstate].enter &&
>> -                   !cpuidle_state_table[cstate].enter_s2idle)
>> +               if (!cpuidle_state_table[cstate].enter)
>
> I don't think that the above change belongs to this patch.  If I'm
> mistaken, it should be mentioned in the changelog and the reason for
> making it should be explained.

Yeah, you are right, removing enter_s2idle check doesn't make much sense.
I think I was changing much more code, but eventually decided not to
change too much in one go and forgot to roll back that one.

With this:
                if (!cpuidle_state_table[cstate].enter &&
                    !cpuidle_state_table[cstate].enter_s2idle)

we would not set enter_dead for states that only provide enter_dead handler, but I doesn't seem to happen in practice, so for the sake of simplicity I am just going to leave the check unchanged.
Unless you think it makes more sense to do:
                if (!cpuidle_state_table[cstate].enter &&
+                   !cpuidle_state_table[cstate].enter_dead &&
                    !cpuidle_state_table[cstate].enter_s2idle)

>
>>                         break;
>>
>> +               if (!cpuidle_state_table[cstate].enter_dead)
>> +                       cpuidle_state_table[cstate].enter_dead = intel_idle_enter_dead;
>> +
>>                 /* If marked as unusable, skip this state. */
>>                 if (cpuidle_state_table[cstate].flags & CPUIDLE_FLAG_UNUSABLE) {
>>                         pr_debug("state %s is disabled\n",
>> --


