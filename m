Return-Path: <linux-pm+bounces-37395-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EC959C33600
	for <lists+linux-pm@lfdr.de>; Wed, 05 Nov 2025 00:25:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 478703AF1A1
	for <lists+linux-pm@lfdr.de>; Tue,  4 Nov 2025 23:25:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB94A2DC77B;
	Tue,  4 Nov 2025 23:24:57 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 720A727F166
	for <linux-pm@vger.kernel.org>; Tue,  4 Nov 2025 23:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762298697; cv=none; b=MhWiNFuX9HCvcOuX/bLPJDvl8JpH6ApThLohOba8SL6kiOPmBDRg8v2bGypXmgTzcBpsa6npCfnXL8NeJq8lebNwn1sC9alxeteZ0mYEkEQUqTwDtu+s1bs91KhhP43wYrZkMCo1ZMyTUHwy+JfTFBEEEDgK2zOKHMekgzsJghs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762298697; c=relaxed/simple;
	bh=DhelV3xarfLks4kHcuGmM6M4I8Dy898DEjPUDcV40iY=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=ZN+7tE7MWPARjznoqLL23Q6kM+ARliSKRHneug/Pj+QS/yjfB8njhugretMLo1stMvu7CWj1yJ5WDclw57bL0PwJl3IcYduYNnoy40a54DSOmnv9J7d/OqJ/BGeXB/vJZcW5276CD9JZ7IPUnqW756bYDXZzehfOrVeCe3PxATk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A5CEA175D;
	Tue,  4 Nov 2025 15:24:46 -0800 (PST)
Received: from [192.168.0.16] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6D1563F66E;
	Tue,  4 Nov 2025 15:24:53 -0800 (PST)
Message-ID: <ed1e64dc-91c9-44d9-b3d3-9f142bcf7a8d@arm.com>
Date: Tue, 4 Nov 2025 23:24:50 +0000
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Regression in TEO cpuidle governor between 6.6 and 6.12
From: Christian Loehle <christian.loehle@arm.com>
To: Reka Norman <rekanorman@chromium.org>, rafael@kernel.org
Cc: daniel.lezcano@linaro.org, linux-pm@vger.kernel.org
References: <CAEmPcwsNMNnNXuxgvHTQ93Mx-q3Oz9U57THQsU_qdcCx1m4w5g@mail.gmail.com>
 <a50064b2-e6aa-4237-a715-12f21a65e9a6@arm.com>
Content-Language: en-US
In-Reply-To: <a50064b2-e6aa-4237-a715-12f21a65e9a6@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 11/4/25 09:03, Christian Loehle wrote:
> On 11/4/25 03:36, Reka Norman wrote:
>> Hi,
>>
>> I’m seeing a regression in the TEO governor between 6.6 and 6.12. At
>> 6.12, when the system is idle it’s spending almost 100% of time in
>> WFI, compared to about 6% at 6.6. At mainline it has improved compared
>> to 6.12 but is still a lot worse than 6.6, spending about 50% in WFI.
>>
>> The system is a ChromeOS device with Mediatek MT8196.
>>
>> Bisecting showed the specific commit which caused the regression is:
>> 4b20b07ce72f ("cpuidle: teo: Don't count non-existent intercepts")
>>
>> I’ve attached sysfs dumps showing the issue. All were taken a couple
>> of minutes after boot, with the device having been idle since boot.
>> The cases tested are:
>> cpuidle_6_6.txt      = 6.6 kernel
>> cpuidle_6_12.txt     = 6.6 kernel with teo commits up to 6.12
>> cpuidle_mainline.txt = 6.6 kernel with teo commits up to mainline
>>
>> Summary of the percentage time spent in each state (averaged across CPUs):
>>
>> |            |   6.6 |  6.12 | mainline |
>> |------------|------:|------:|---------:|
>> | WFI        |  6.02 | 99.94 |    56.84 |
>> | cpuoff     | 11.02 |     0 |     0.65 |
>> | clusteroff | 82.96 |  0.05 |    42.51 |
>> | s2idle     |     0 |     0 |        0 |
>>
>> Any help would be much appreciated. Let me know if there's any other
>> debugging information I should provide.
>>
> 
> That's not good.
> If the system is mostly idle (only boot activity but dumps are taken after
> ~3mins?), what is causing the wakeups? Even in 6.6 There are definitely more
> than I would've expected?
> I noticed that clusteroff and cpuoff have equal residency, which is
> obviously a bit awkward for cpuidle, but shouldn't be relevant to your issue.
> 
> I'm a bit puzzled by your bisect results.
> 4b20b07ce72f ("cpuidle: teo: Don't count non-existent intercepts")
> made the intercept logic *less* prone to count (false) intercepts, yet it
> seems to count more of them? (resulting in more WFI).
> I'll think about it some more, for now of course a trace would be very
> helpful. (cpuidle events, ipi_raise, irqs?)
> Are there ever any latency constraints set?
> 
> FWIW the mainline results look the most reasonable, from a 30000 feet view
> anyway:
> Cluster	State		above	below	usage	above%	below%
> LITTLE	cpuoff-l	~75	~65	~140	23%	20%
> LITTLE	clusteroff-l	~800	0	~100	89%	0%
> MID	cpuoff-m	~3–4	~15	~20	15%	55%
> MID	clusteroff-m	~1300	0	~4000	24%	0%
> BIG	cpuoff-b	0	1	1	—	—
> BIG	clusteroff-b	~800	0	~1900	30%	0%
> 
> (WFI seems mostly the correct choice for little CPUs, that's fine, the energy
> savings compared to cpuoff should be marginal anyway.)
> 
> Do you mind trying:
> 13ed5c4a6d9c cpuidle: teo: Skip getting the sleep length if wakeups are very frequent
> on 6.12?
> 

So just thinking out loud, the only case I can actually thing of to explain your
bisect to 4b20b07ce72f ("cpuidle: teo: Don't count non-existent intercepts")
is that the workload essentially changed dramatically because of our calls
to tick_nohz_get_sleep_length() now.
I'm not sure how likely I think that is, but I'm lacking imagination for another
cause. That's why results with 
13ed5c4a6d9c ("cpuidle: teo: Skip getting the sleep length if wakeups are very frequent")
would be interesting.

