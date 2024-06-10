Return-Path: <linux-pm+bounces-8850-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F2CA901DE1
	for <lists+linux-pm@lfdr.de>; Mon, 10 Jun 2024 11:11:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF0EB1C214C3
	for <lists+linux-pm@lfdr.de>; Mon, 10 Jun 2024 09:11:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8680F6F314;
	Mon, 10 Jun 2024 09:11:11 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02B846BFA3;
	Mon, 10 Jun 2024 09:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718010671; cv=none; b=ZA16oQVBdc/hsNg6ws12ianBQNXkfmzBBuVaEiMlGTt2F5NT+tdj9PtUqW5HYWtWqviltB+tCf1imDyUDwwlwHYIsoMzU8WRy4j6qnNG13l5VWYju2CVC2m/bDSUdxG6lFd31gnJ9KisVDN3BS9DdLgu8/6DO0Dp0fRaze4Avvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718010671; c=relaxed/simple;
	bh=h0vH6BRr2TnAPPCehOMOST6X8bmut1Pgvhshrf+Rcos=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=usDg0TJh/WvC4NfpG4ApfTNDrCgLXkIyiEowu6wehNA457bsGTB1OjjAtZlPJDavt6D32hgXQ+xCFhSqkPhPKUn1UoMcpVWxXE9zZGXmiaiWs59KiwwmDOqZX0kGULtTDpV7gjEjHfSBqeMqXIzk9ON8sL85C48/XQqawK8J69k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1CD2F12FC;
	Mon, 10 Jun 2024 02:11:27 -0700 (PDT)
Received: from [10.57.71.68] (unknown [10.57.71.68])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1F5A23F73B;
	Mon, 10 Jun 2024 02:11:01 -0700 (PDT)
Message-ID: <569b7923-d7ba-49a9-a88d-906f44903d20@arm.com>
Date: Mon, 10 Jun 2024 10:11:01 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/6] cpuidle: teo: Increase util-threshold
To: Qais Yousef <qyousef@layalina.io>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 rafael@kernel.org, vincent.guittot@linaro.org, peterz@infradead.org,
 daniel.lezcano@linaro.org, anna-maria@linutronix.de,
 kajetan.puchalski@arm.com, lukasz.luba@arm.com, dietmar.eggemann@arm.com
References: <20240606090050.327614-1-christian.loehle@arm.com>
 <20240606090050.327614-2-christian.loehle@arm.com>
 <20240609224701.pc6om2o5ep6btywe@airbuntu>
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <20240609224701.pc6om2o5ep6btywe@airbuntu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/9/24 23:47, Qais Yousef wrote:
> On 06/06/24 10:00, Christian Loehle wrote:
>> Increase the util-threshold by a lot as it was low enough for some
>> minor load to always be active, especially on smaller CPUs.
>>
>> For small cap CPUs (Pixel6) the util threshold is as low as 1.
>> For CPUs of capacity <64 it is 0. So ensure it is at a minimum, too.
>>
>> Fixes: 9ce0f7c4bc64 ("cpuidle: teo: Introduce util-awareness")
>> Reported-by: Qais Yousef <qyousef@layalina.io>
>> Reported-by: Vincent Guittot <vincent.guittot@linaro.org>
>> Suggested-by: Kajetan Puchalski <kajetan.puchalski@arm.com>
>> Signed-off-by: Christian Loehle <christian.loehle@arm.com>
>> ---
>>  drivers/cpuidle/governors/teo.c | 11 +++++------
>>  1 file changed, 5 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/cpuidle/governors/teo.c b/drivers/cpuidle/governors/teo.c
>> index 7244f71c59c5..45f43e2ee02d 100644
>> --- a/drivers/cpuidle/governors/teo.c
>> +++ b/drivers/cpuidle/governors/teo.c
>> @@ -146,13 +146,11 @@
>>   * The number of bits to shift the CPU's capacity by in order to determine
>>   * the utilized threshold.
>>   *
>> - * 6 was chosen based on testing as the number that achieved the best balance
>> - * of power and performance on average.
>> - *
>>   * The resulting threshold is high enough to not be triggered by background
>> - * noise and low enough to react quickly when activity starts to ramp up.
>> + * noise.
>>   */
>> -#define UTIL_THRESHOLD_SHIFT 6
>> +#define UTIL_THRESHOLD_SHIFT 2
>> +#define UTIL_THRESHOLD_MIN 50
>>  
>>  /*
>>   * The PULSE value is added to metrics when they grow and the DECAY_SHIFT value
>> @@ -671,7 +669,8 @@ static int teo_enable_device(struct cpuidle_driver *drv,
>>  	int i;
>>  
>>  	memset(cpu_data, 0, sizeof(*cpu_data));
>> -	cpu_data->util_threshold = max_capacity >> UTIL_THRESHOLD_SHIFT;
>> +	cpu_data->util_threshold = max(UTIL_THRESHOLD_MIN,
>> +				max_capacity >> UTIL_THRESHOLD_SHIFT);
> 
> Thanks for trying to fix this. But I am afraid this is not a solution. There's
> no magic number that can truly work here - we tried. As I tried to explain
> before, a higher util value doesn't mean long idle time is unlikely. And
> blocked load can cause problems where a decay can take too long.
> 
> We are following up with the suggestions I have thrown back then and we'll
> share results if anything actually works.

Namely watching increase / decrease of utilization?
I think you would have to watch at least a couple of values before entering such
a logic and at that point the intercepts logic will handle it anyway.
Furthermore IMO we should be wary about introducing any state in teo that persists
across calls if not absolutely necessary (like intercept-detection) as it really
makes teo much less predictable.

> 
> For now, I think a revert is more appropriate. There was some perf benefit, but
> the power regressions were bad and there's no threshold value that actually
> works. The thresholding concept itself is incorrect and flawed - it seemed the
> correct thing back then, yes. But in a hindsight now it doesn't work.

Unfortunate :/
OK. I'll do some more testing with that, too. From what I can see a revert wouldn't
have terrible fallout with the series altogether, so I might just change this for
v2 and drop 2/6.

Kind Regards,
Christian


