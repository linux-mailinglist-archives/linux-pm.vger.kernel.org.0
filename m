Return-Path: <linux-pm+bounces-22794-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D98CFA41BD8
	for <lists+linux-pm@lfdr.de>; Mon, 24 Feb 2025 12:00:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 88E793B3C69
	for <lists+linux-pm@lfdr.de>; Mon, 24 Feb 2025 10:59:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11706257AFA;
	Mon, 24 Feb 2025 10:59:15 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 293EA146D59;
	Mon, 24 Feb 2025 10:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740394755; cv=none; b=TgYiTdPzGB1EiiXtg22Cb/v63zka2oN3viPuhaFGqIqkQFvzhjoXmyZJizJpImo0tEPqBi2Pb8NdgPhO5lpv2+JMwwkOPzGHTPCRQbzqgvWomc4ISbDLADp8lNQDp1nsCuOGwWwRl/9QoA0UzHqbxYkFAlXGmtXJBkHBwifBgWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740394755; c=relaxed/simple;
	bh=/BJsBBlQ+b6Yp+6OJGBbtUx/kESPkZ9ChX9DC3OVY8U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Owsfep9k5tAVeUbQa6TfD5FNTtMsY5aXZHH5klPHpJ1VikukDGumo/JhAAMPfRKcR2sxeg19EFbccP1sisFG2VO7ofeahaLx6LN551mP/lY2vFc2y+Ny/fFAQbbfOxOIlKwI6vs3d1jsSRQrjFfXzWJO/s8PmvEVCVNRVnERNGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F195A1FCD;
	Mon, 24 Feb 2025 02:59:28 -0800 (PST)
Received: from [10.57.65.109] (unknown [10.57.65.109])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7F8383F673;
	Mon, 24 Feb 2025 02:59:10 -0800 (PST)
Message-ID: <c3ea0f88-3ee2-44b4-9970-17c9de59d50b@arm.com>
Date: Mon, 24 Feb 2025 10:59:11 +0000
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] thermal: of: Fix logic in thermal_of_should_bind
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>,
 Yu-Che Cheng <giver@chromium.org>, Zhang Rui <rui.zhang@intel.com>,
 "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org, Chen-Yu Tsai <wenst@chromium.org>
References: <20250219-fix-thermal-of-v1-1-de36e7a590c4@chromium.org>
 <CAJZ5v0i=Ehi1icm4Tx6cXmdhjq-Qj8Vwv1SwzCyx5oBj-5y9hQ@mail.gmail.com>
 <CAJZ5v0gJGxWA=7zHYU5h=ueqQcXNt94wOAg7sqrphOUb++mAyw@mail.gmail.com>
Content-Language: en-US
From: Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <CAJZ5v0gJGxWA=7zHYU5h=ueqQcXNt94wOAg7sqrphOUb++mAyw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Rafael,

On 2/20/25 20:22, Rafael J. Wysocki wrote:
> On Wed, Feb 19, 2025 at 10:40 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
>>
>> On Wed, Feb 19, 2025 at 8:06 AM Yu-Che Cheng <giver@chromium.org> wrote:
>>>
>>> The current thermal_of_should_bind will stop iterating cooling-maps on
>>> the first matched trip point, leading to subsequent cooling devices
>>> binding to the same trip point failing to find the cooling spec.
>>>
>>> The iteration should continue enumerating subsequent cooling-maps if the
>>> target cooling device is not found.
>>>
>>> Fix the logic to break only when a matched cooling device is found.
>>
>> OK, but ->
>>
>>> Fixes: 94c6110b0b13 ("thermal/of: Use the .should_bind() thermal zone callback")
>>> Signed-off-by: Yu-Che Cheng <giver@chromium.org>
>>> ---
>>>   drivers/thermal/thermal_of.c | 3 ++-
>>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/thermal/thermal_of.c b/drivers/thermal/thermal_of.c
>>> index 5ab4ce4daaeb..69c530e38574 100644
>>> --- a/drivers/thermal/thermal_of.c
>>> +++ b/drivers/thermal/thermal_of.c
>>> @@ -312,7 +312,8 @@ static bool thermal_of_should_bind(struct thermal_zone_device *tz,
>>>                                  break;
>>
>> -> I'd prefer to do a jump from here, that is
>>
>> -                                 break;
>> +                                goto put_cm_np;
>>>                  }
>>>
>>> -               break;
>>
>> and remove the break statement above altogether.
>>
>>> +               if (result)
>>> +                       break;
>>>          }
>>>
>>
>> And of course the label needs to be added too:
>>
>> +put_cm_np:
>>>          of_node_put(cm_np);
>>>
>>> ---
> 
> Or even, to avoid adding a new label, move the loop from
> thermal_of_should_bind() into a new function that will be called by it
> do carry out the cooling-maps lookup, like in the attached patch.
> 
> Can you check if it works for you, please?


I have experimented with your proposed patch with my DT setup.
It looks OK to me and much more clean.

If you have any super-edge-case scenario DT config to try, please let me
know. I will try to create such on my end...

If you would like to go forward with your patch, feel free to add:

Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>
Tested-by: Lukasz Luba <lukasz.luba@arm.com>

Regards,
Lukasz


