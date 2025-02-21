Return-Path: <linux-pm+bounces-22619-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 838CFA3F253
	for <lists+linux-pm@lfdr.de>; Fri, 21 Feb 2025 11:43:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B5BB3BE85C
	for <lists+linux-pm@lfdr.de>; Fri, 21 Feb 2025 10:43:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C4EA2066F4;
	Fri, 21 Feb 2025 10:43:05 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 721DA205E18;
	Fri, 21 Feb 2025 10:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740134585; cv=none; b=QDN6chTiLkeqy1W2xGIW45zfSOpnBwxm7aZDL03em0E+xk7fhhQkirk012z0Xe1/KmXuNGuMW7H0nN3pgLqQ2HV1fiX+jEydGBqBzCu1WygpaLpCesocqJvnAzLsZrZV0BI6IqsAG/ZrMrzbFXaRWOqVE+TEk1iRwWEeNt4fC4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740134585; c=relaxed/simple;
	bh=KWrFDt8ZyyvDNI14klHHLJn5BJSmuLX3HftfhtVunO0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=g5qeDUBS5cInOx6HfLLr2vrNbKGlj3jPpO73O0Bj/eZzVUzSVzQT141kOXg2UnaXKtiLmrEP+jRPVUhhYiM7A5YyLUPBJlD+n5pQRu1ceS2LcPo/nsXUk9CQ7X858Plac5OF6Dt3XD/bdN++iKPTgwUqLd3BItVBW61y1roPtNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 97305169C;
	Fri, 21 Feb 2025 02:43:20 -0800 (PST)
Received: from [10.57.64.214] (unknown [10.57.64.214])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 465213F5A1;
	Fri, 21 Feb 2025 02:43:01 -0800 (PST)
Message-ID: <32fe0e71-e8d9-4404-8b48-a8b8e9ec71e7@arm.com>
Date: Fri, 21 Feb 2025 10:43:00 +0000
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] thermal: gov_power_allocator: Update total_weight on bind
 and cdev updates
To: "Rafael J. Wysocki" <rafael@kernel.org>, Yu-Che Cheng <giver@chromium.org>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>,
 Zhang Rui <rui.zhang@intel.com>,
 "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org, Chen-Yu Tsai <wenst@chromium.org>
References: <20250219-fix-power-allocator-weight-v1-1-79b1a99e94eb@chromium.org>
 <CAJZ5v0h8MyqEgC8Hf1_s4=kCj2W3Y0TWdVnbhwAiVLqED7WPow@mail.gmail.com>
Content-Language: en-US
From: Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <CAJZ5v0h8MyqEgC8Hf1_s4=kCj2W3Y0TWdVnbhwAiVLqED7WPow@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2/20/25 19:40, Rafael J. Wysocki wrote:
> On Wed, Feb 19, 2025 at 8:07 AM Yu-Che Cheng <giver@chromium.org> wrote:
>>
>> params->total_weight is not initialized during bind and not updated when
>> the bound cdev changes. The cooling device weight will not be used due
>> to the uninitialized total_weight, until we trigger an update via sysfs.
>>
>> The bound cdev update will be triggered during thermal zone registration,
>> where each cooling device will be bound to the thermal zone one by one.
>>
>> The power_allocator_bind can be called without additional cdev update
>> when manually changing the policy of a thermal zone via sysfs.

Thanks Yu-Che for catching this.

>>
>> Update total_weight when bind and cdev updates to ensure total_weight is
>> correct.
>>
>> Fixes: a3cd6db4cc2e ("thermal: gov_power_allocator: Support new update callback of weights")
>> Signed-off-by: Yu-Che Cheng <giver@chromium.org>
>> ---
>>   drivers/thermal/gov_power_allocator.c | 9 +++++----
>>   1 file changed, 5 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/thermal/gov_power_allocator.c b/drivers/thermal/gov_power_allocator.c
>> index 3b644de3292e..600cb0e367c3 100644
>> --- a/drivers/thermal/gov_power_allocator.c
>> +++ b/drivers/thermal/gov_power_allocator.c
>> @@ -656,11 +656,10 @@ static void power_allocator_update_tz(struct thermal_zone_device *tz,
>>                          if (power_actor_is_valid(instance))
>>                                  num_actors++;
>>
>> -               if (num_actors == params->num_actors)
>> -                       return;
>> +               if (num_actors != params->num_actors)
>> +                       allocate_actors_buffer(params, num_actors);
>>
>> -               allocate_actors_buffer(params, num_actors);
>> -               break;
>> +               fallthrough;
> 
> This is basically fine, but I would add a new function, say
> power_allocator_update_weight(), for updating the weight.
> 
>>          case THERMAL_INSTANCE_WEIGHT_CHANGED:
> 
> And I'd call it from here and from power_allocator_bind() below.
> 
>>                  params->total_weight = 0;
>>                  list_for_each_entry(instance, &td->thermal_instances, trip_node)
>> @@ -731,6 +730,8 @@ static int power_allocator_bind(struct thermal_zone_device *tz)
>>
>>          tz->governor_data = params;
>>
>> +       power_allocator_update_tz(tz, THERMAL_INSTANCE_WEIGHT_CHANGED);
> 
> Because this is kind of confusing (although it will work AFAICS).
> 

Thanks Rafael, I agree with suggestions. It would look cleaner.

