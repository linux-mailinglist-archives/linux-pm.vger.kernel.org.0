Return-Path: <linux-pm+bounces-14455-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6128397C766
	for <lists+linux-pm@lfdr.de>; Thu, 19 Sep 2024 11:46:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E363B1F2A218
	for <lists+linux-pm@lfdr.de>; Thu, 19 Sep 2024 09:46:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B93719DF42;
	Thu, 19 Sep 2024 09:44:00 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE3D0199249;
	Thu, 19 Sep 2024 09:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726739040; cv=none; b=WNWwKNh5ewY9HT/OowvwB8Wg4a9JB6GZef1TChLN2p3IAXBk+61spGD24FOHS/ryXFReobEMKzO87gwxjmAmqKpmW/zeUqNEF7ShcVatL6oGghp3MiWgQ0p1ex6TbTVbs4zWDxBQ0niyTdPMZvEtmB1uEEUXdg2TGHzP0T8bZV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726739040; c=relaxed/simple;
	bh=A6+YF+cSMCnWF3SRwu6F7ogw6m5qzYO7soS7KmRb54s=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=fXn2nm59t8ax+bWmB4pobQnHy3hDV/VYcue8qkAeIk2kx/5jN6TF6vEHhUfk0UQskNqNUS4SLgoESEkJe2adjQBOYmNVAJdBso8BJ9ew+ORCXthG/iOsyA3Csc0buZOigk8ZoXZOyWdJLtYSVcFDvg3mXhMnl25va/DM6tHGgEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 46D391007;
	Thu, 19 Sep 2024 02:44:26 -0700 (PDT)
Received: from [192.168.0.16] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EF9703F71A;
	Thu, 19 Sep 2024 02:43:55 -0700 (PDT)
Message-ID: <592a0c06-a23c-464a-9f67-2ce8ce91a306@arm.com>
Date: Thu, 19 Sep 2024 10:43:53 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/1] cpuidle/menu: Address performance drop from favoring
 physical over polling cpuidle state
From: Christian Loehle <christian.loehle@arm.com>
To: Aboorva Devarajan <aboorvad@linux.ibm.com>, rafael@kernel.org,
 daniel.lezcano@linaro.org, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: gautam@linux.ibm.com
References: <20240809073120.250974-1-aboorvad@linux.ibm.com>
 <93d9ffb2-482d-49e0-8c67-b795256d961a@arm.com>
 <9e5ef8ab0f0f3e7cb128291cd60591e3d07b33e4.camel@linux.ibm.com>
 <4c897ab4-d592-427b-9a97-79c2b14d5c46@arm.com>
 <6371848e9c260743f381be6e0114743ffab5e5bb.camel@linux.ibm.com>
 <6ae997ca-9712-4497-b666-11b976b1816d@arm.com>
Content-Language: en-US
In-Reply-To: <6ae997ca-9712-4497-b666-11b976b1816d@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/19/24 09:49, Christian Loehle wrote:
> On 9/19/24 06:02, Aboorva Devarajan wrote:
>> On Wed, 2024-08-21 at 11:55 +0100, Christian Loehle wrote:
> 
>>
>> Timer based wakeup:
>>
>> +------------------------+---------------------+---------------------+
>> | Metric                 | Without Patch       | With Patch          |
>> +------------------------+---------------------+---------------------+
>> | Wakee thread - CPU     | 110                 | 110                 |
>> | Waker thread - CPU     | 20                  | 20                  |
>> | Sleep Interval         | 50 us               | 50 us               |
>> | Total Wakeups          | -                   | -                   |
>> | Avg Wakeup Latency     | -                   | -                   |
>> | Actual Sleep time      | 52.639 us           | 52.627 us           |
>> +------------------------+---------------------+---------------------+
>> | Idle State 0 Usage Diff| 94,879              | 94,879              |
>> | Idle State 0 Time Diff | 4,700,323 ns        | 4,697,576 ns        |
>> | Idle State 1 Usage Diff| 0                   | 0                   |
>> | Idle State 1 Time Diff | 0 ns                | 0 ns                |
>> +------------------------+---------------------+---------------------+
>> | Total Above Usage      | 0 (0.00%)           | (0.00%)             |
>> +------------------------+---------------------+---------------------+
>> | Total Below Usage      | 0 (0.00%)           | 0 (0.00%)           |
>> +------------------------+---------------------+---------------------+
>>
>> In timer-based wakeups, the menu governor effectively predicts the idle
>> duration both with and without the patch. This ensures that there are
>> few or no instances of "Above" usage, allowing the CPU to remain in the
>> correct idle state.
>>
>> The condition (s->target_residency_ns <= data->next_timer_ns) in the menu
>> governor ensures that a physical idle state is not prioritized when a
>> timer event is expected before the target residency of the first physical
>> idle state.
>>
>> As a result, the patch has no impact in this case, and performance
>> remains stable with timer based wakeups.
>>
>> Pipe based wakeup (non-timer wakeup):
>>
>> +------------------------+---------------------+---------------------+
>> | Metric                 | Without Patch       | With Patch          |
>> +------------------------+---------------------+---------------------+
>> | Wakee thread - CPU     | 110                 | 110                 |
>> | Waker thread - CPU     | 20                  | 20                  |
>> | Sleep Interval         | 50 us               | 50 us               |
>> | Total Wakeups          | 97031               | 96583               |
>> | Avg Wakeup Latency     | 7.070 us            | 4.879 us            |
>> | Actual Sleep time      | 51.366 us           | 51.605 us           |
>> +------------------------+---------------------+---------------------+
>> | Idle State 0 Usage Diff| 1209                | 96,586              |
>> | Idle State 0 Time Diff | 55,579 ns           | 4,510,003 ns        |
>> | Idle State 1 Usage Diff| 95,826              | 5                   |
>> | Idle State 1 Time Diff | 4,522,639 ns        | 198 ns              |
>> +------------------------+---------------------+---------------------+
>> +------------------------+---------------------+---------------------+
>> | **Total Above Usage**  | 95,824 (98.75%)     | 5 (0.01%)           |
>> +------------------------+---------------------+---------------------+     
>> +------------------------+---------------------+---------------------+
>> | Total Below Usage      | 0 (0.00%)           | 0 (0.00%)           |
>> +------------------------+---------------------+---------------------+
>>
>> In the pipe-based wakeup scenario, before the patch was applied, the 
>> "Above" metric was notably high around 98.75%. This suggests that the
>> menu governor frequently selected a deeper idle state like CEDE, even
>> when the idle period was relatively short.
>>
>> This happened because the menu governor is inclined to prioritize the
>> physical idle state (CEDE) even when the target residency time of the
>> physical idle state (s->target_residency_ns) was longer than the
>> predicted idle time (predicted_ns), so data->next_timer_ns won't be
>> relevant here in non-timer wakeups.
>>
>> In this test, despite the actual idle period being around 50 microseconds,
>> the menu governor still chose CEDE state, which has a target residency of
>> 120 microseconds.
> 
> And the idle_miss statistics confirms that this was mostly wrong decisions
> in hindsight.
> I'll go through the menu code again, this indeed shouldn't be happening.
> I'd be very surprised if upstream teo performed as badly (or actually badly
> at all) on this, although it doesn't seem to help your actual workload,
> would you mind giving that a try too?
> 
> Regards,
> Christian

So with a workload as static as this, the recent interval detection of menu
should take affect. It records the last 8 idle interval lengths and does some
statistics do see if they are somewhat stable and uses those instead of the
next timer event.
While I wouldn't vouch for the statistics just yet, the results don't seem
to be completely unreasonable.
Do you mind trying a) printing some snapshots of these intervals and the
resulting return value of get_typical_interval()?
b) Trying this out? Setting these values to some around 50us, that returns
50us for me as expected and therefore should not select an idle state above
that.

-->8--

--- a/drivers/cpuidle/governors/menu.c
+++ b/drivers/cpuidle/governors/menu.c
@@ -112,6 +112,8 @@ struct menu_device {
        int             interval_ptr;
 };
 
+static int intervals_dummy[] = {50, 52, 48, 50, 51, 49, 51, 51};
+
 static inline int which_bucket(u64 duration_ns, unsigned int nr_iowaiters)
 {
        int bucket = 0;
@@ -177,7 +179,7 @@ static unsigned int get_typical_interval(struct menu_device *data)
        sum = 0;
        divisor = 0;
        for (i = 0; i < INTERVALS; i++) {
-               unsigned int value = data->intervals[i];
+               unsigned int value = intervals_dummy[i];
                if (value <= thresh) {
                        sum += value;
                        divisor++;
@@ -200,7 +202,7 @@ static unsigned int get_typical_interval(struct menu_device *data)
        /* Then try to determine variance */
        variance = 0;
        for (i = 0; i < INTERVALS; i++) {
-               unsigned int value = data->intervals[i];
+               unsigned int value = intervals_dummy[i];
                if (value <= thresh) {
                        int64_t diff = (int64_t)value - avg;
                        variance += diff * diff;


