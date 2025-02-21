Return-Path: <linux-pm+bounces-22617-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D3B42A3F230
	for <lists+linux-pm@lfdr.de>; Fri, 21 Feb 2025 11:35:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 832DF3B61A3
	for <lists+linux-pm@lfdr.de>; Fri, 21 Feb 2025 10:35:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4707E204588;
	Fri, 21 Feb 2025 10:35:35 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1A2E1FF1AF;
	Fri, 21 Feb 2025 10:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740134135; cv=none; b=TT6Oz08genoPCmGHgNby0eDu86EPKHEddyIXtvX4EKYeOMzGc4q6ytMRl/g46peBMu+sQOoWkrJk1S/b4oPusR4WCbqwKjQQQ1BSSx6QLzYT/fWwuocrg4wpD36Hs/9Dz1fBQAX325GMICt7iQIuBwzTcEpCYjzheUrwAeYbZPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740134135; c=relaxed/simple;
	bh=9yfpDYwiRXTbAwNM4+S8KEq65OP2vDs72ScJnryKwII=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rUth7q4Tr3TfyITKUGR2WtMCDQ2xKv7qO8rYvNGC2exqQOg47d7w2K4A3D3odJi417zPKMgu4UyhAUIRHXvWYCrFSPh3X0y+jfu9+ln1xMoJYpPgdvEofjjAoYg9ADidrXDOQWU5Lr7w1ACz7N5eK/1KYpQ+6+acK04Ye99MDxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B5521169C;
	Fri, 21 Feb 2025 02:35:50 -0800 (PST)
Received: from [10.57.64.214] (unknown [10.57.64.214])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 669A63F5A1;
	Fri, 21 Feb 2025 02:35:31 -0800 (PST)
Message-ID: <9cc02f9e-9326-4fe1-820b-ca725f68de29@arm.com>
Date: Fri, 21 Feb 2025 10:35:30 +0000
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] thermal: gov_power_allocator: Fix incorrect calculation
 in divvy_up_power
To: "Rafael J. Wysocki" <rafael@kernel.org>, Yu-Che Cheng <giver@chromium.org>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>,
 Zhang Rui <rui.zhang@intel.com>,
 "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org, Chen-Yu Tsai <wenst@chromium.org>
References: <20250219-fix-power-allocator-calc-v1-1-48b860291919@chromium.org>
 <CAJZ5v0jSh=aOfP7BKTCSxnPGy-XKJKcHNw8bN5PXPH0LA0tAGg@mail.gmail.com>
Content-Language: en-US
From: Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <CAJZ5v0jSh=aOfP7BKTCSxnPGy-XKJKcHNw8bN5PXPH0LA0tAGg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2/20/25 19:45, Rafael J. Wysocki wrote:
> On Wed, Feb 19, 2025 at 8:07 AM Yu-Che Cheng <giver@chromium.org> wrote:
>>
>> divvy_up_power should use weighted_req_power instead of req_power to
>> calculate the granted_power. Otherwise, the granted_power may be
>> unexpected as the denominator total_req_power is weighted sum.
> 
> Yes, this is what's happening, to my eyes.
> 
>> This is a mistake during the previous refactor.
>>
>> Replace the req_power with weighted_req_power in divvy_up_power
>> calculation.
>>
>> Fixes: 912e97c67cc3 ("thermal: gov_power_allocator: Move memory allocation out of throttle()")
>> Signed-off-by: Yu-Che Cheng <giver@chromium.org>
>> ---
>>   drivers/thermal/gov_power_allocator.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/thermal/gov_power_allocator.c b/drivers/thermal/gov_power_allocator.c
>> index 3b644de3292e..3b626db55b2b 100644
>> --- a/drivers/thermal/gov_power_allocator.c
>> +++ b/drivers/thermal/gov_power_allocator.c
>> @@ -370,7 +370,7 @@ static void divvy_up_power(struct power_actor *power, int num_actors,
>>
>>          for (i = 0; i < num_actors; i++) {
>>                  struct power_actor *pa = &power[i];
>> -               u64 req_range = (u64)pa->req_power * power_range;
>> +               u64 req_range = (u64)pa->weighted_req_power * power_range;
>>
>>                  pa->granted_power = DIV_ROUND_CLOSEST_ULL(req_range,
>>                                                            total_req_power);
>>
>> ---
> 
> And the fix looks good to me.
> 
> Lukasz, any concerns?

Good catch! It went through since the test didn't set different weights.

Thanks for the fix!

Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>

