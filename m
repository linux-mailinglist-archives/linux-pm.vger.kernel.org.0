Return-Path: <linux-pm+bounces-37869-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 66301C53F8F
	for <lists+linux-pm@lfdr.de>; Wed, 12 Nov 2025 19:46:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 39AB6347A3F
	for <lists+linux-pm@lfdr.de>; Wed, 12 Nov 2025 18:40:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85E3F35295E;
	Wed, 12 Nov 2025 18:33:12 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 801D12F5302
	for <linux-pm@vger.kernel.org>; Wed, 12 Nov 2025 18:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762972392; cv=none; b=iSAt9yHN/V1jZ4/3QhwlIe6B4XiIzEDihLhRKWSVPOKOkKQes/zTxnrc0KmH3YRzSkM0Eqo3ZrKTMPP4dFrTIOLqTyKIi2q6mRGVerBfdSecx0KXlO3DzSujgm+pVR4ZzbIRDTw2ed74l4QT73xKTHgoNNjSOv9KDBil4JN2MVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762972392; c=relaxed/simple;
	bh=9a1Ylmp/oTAcUx7Q15NtoyCks2xsjg2svUWpttPXT6s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KdWsDSlkSk38foT1c60w4iMvbft/fEoqkF4B0oib2vNpoHN+W3yiPTUQuSwK8oXLCYkuQkhKLQMJY2VOIDLC04+WRErro0q7S+hNW/P5hHDOOntddY5dr9a2x05ZUlu3wxowXUEyS63I/BlACKq+oTwkHqjBxQbW20MzJAt0e54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3C6341515;
	Wed, 12 Nov 2025 10:33:02 -0800 (PST)
Received: from [10.1.28.59] (e127648.arm.com [10.1.28.59])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E122D3F63F;
	Wed, 12 Nov 2025 10:33:08 -0800 (PST)
Message-ID: <00928b9d-7189-4929-afc9-7684fc5ef531@arm.com>
Date: Wed, 12 Nov 2025 18:33:06 +0000
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Regression in TEO cpuidle governor between 6.6 and 6.12
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Reka Norman <rekanorman@chromium.org>, daniel.lezcano@linaro.org,
 linux-pm@vger.kernel.org
References: <CAEmPcwsNMNnNXuxgvHTQ93Mx-q3Oz9U57THQsU_qdcCx1m4w5g@mail.gmail.com>
 <b910a35c-83aa-4050-9c6c-de40f13a2a55@arm.com>
 <CAJZ5v0h6qAgWkEad5OGM-V-HOE-1PwD_XqgsDWbnJNxLWOKDfA@mail.gmail.com>
 <CAEmPcws_pvYpzRMQfMyRPBw=7bUyYCcnP3BHN2H4wgUeLLszFg@mail.gmail.com>
 <CAJZ5v0i_ZUD1=3JDABJZ3fcdD7r8uMU36=mam8r2=1P02YksYw@mail.gmail.com>
 <f0a2492b-9cea-4450-88ca-be8f99f3e0fe@arm.com>
 <CAEmPcwvui5Cg5yoa9NEq5b3OZREb08tbmy4=f=adTLuLPBgGgw@mail.gmail.com>
 <0c018867-c092-4f8e-8f7a-32bb02de3ad5@arm.com>
 <CAEmPcwuVPMONrDHcnxbWpoG5K5DFwf-u2i7wuOK4Q9HvF2uOhw@mail.gmail.com>
 <2a429c41-8624-408c-9db0-4450ab76e52f@arm.com>
 <a33965da-81d8-47c5-9fa0-434812f2bd72@arm.com>
 <CAJZ5v0jjswmSsSRqfjrbDVD4rpYvp2qCdweYrK0JV0zUketczQ@mail.gmail.com>
 <939deff8-7856-4d9b-be91-eda06fac21d0@arm.com>
 <CAJZ5v0ic0+sG7yp=wXAcsTBmHdXLe8gKLosFJj48AGuCQ=1beg@mail.gmail.com>
 <571fb9f4-56f5-4d75-a70e-d8741bd1fad2@arm.com>
 <CAJZ5v0ihcLwoMKcPe2RC16sjvf5acU0Y8vjccUu=fYgD+ux12A@mail.gmail.com>
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <CAJZ5v0ihcLwoMKcPe2RC16sjvf5acU0Y8vjccUu=fYgD+ux12A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 11/12/25 14:16, Rafael J. Wysocki wrote:
> On Wed, Nov 12, 2025 at 3:03 PM Christian Loehle
> <christian.loehle@arm.com> wrote:
>>
>> On 11/12/25 13:32, Rafael J. Wysocki wrote:
>>> On Tue, Nov 11, 2025 at 6:20 PM Christian Loehle
>>> <christian.loehle@arm.com> wrote:
>>>>
>>>> On 11/11/25 11:48, Rafael J. Wysocki wrote:
>>>>> On Tue, Nov 11, 2025 at 11:48 AM Christian Loehle
>>>>> <christian.loehle@arm.com> wrote:
>>>>>>
>>>>>> On 11/11/25 10:00, Christian Loehle wrote:
>>>
>>> [...]
>>>
>>>>>>> I see two issues:
>>>>>>> 1) Because of DECAY_SHIFT 3 values < 8 cannot decay (I guess this wouldn't really be an issue without 2))
>>>>>
>>>>> This shouldn't be a problem.
>>>>
>>>> Agreed, it should be a non-issue. Nonetheless if this wasn't the case $subject would've likely
>>>> never been an issue.
>>>
>>> Well, I think that the leftovers can be cleared when they become less than 8.
>>>
>>>>>
>>>>>>> 2) if (2 * idx_intercept_sum > cpu_data->total - idx_hit_sum) isn't an appropriate check, it will
>>>>>>> exclude the state if it its idx_hit_sum make up the vast majority of cpu_data->total (i.e. it would
>>>>>>> have been a really good candidate actually).
>>>>>
>>>>> Well, it would exclude the state if the sum of hits for the states
>>>>> below it is large enough.  This is questionable (because why would
>>>>> hits matter here), but I attempted to make the change below and
>>>>> somebody reported a regression IIRC.
>>>>>
>>>>> This check is related to the problem at hand though (see below).
>>>>>
>>>>>>>
>>>>>>> I lightly tested the below, it seems to be at least comparable to mainline teo.
>>>>>>> (the documentation/comments would need adapting too, of course)
>>>>>>>
>>>>>>> -----8<-----
>>>>>>>
>>>>>>> diff --git a/drivers/cpuidle/governors/teo.c b/drivers/cpuidle/governors/teo.c
>>>>>>> index bfa55c1eab5b..f8f76e3b8364 100644
>>>>>>> --- a/drivers/cpuidle/governors/teo.c
>>>>>>> +++ b/drivers/cpuidle/governors/teo.c
>>>>>>> @@ -355,7 +355,7 @@ static int teo_select(struct cpuidle_driver *drv, struct cpuidle_device *dev,
>>>>>>>          * all of the deeper states, a shallower idle state is likely to be a
>>>>>>>          * better choice.
>>>>>>>          */
>>>>>>> -       if (2 * idx_intercept_sum > cpu_data->total - idx_hit_sum) {
>>>>>>> +       if (2 * idx_intercept_sum > idx_hit_sum) {
>>>>>>>                 int first_suitable_idx = idx;
>>>>>>>
>>>>>>>                 /*
>>>>>>>
>>>>>>>
>>>>>>
>>>>>> ... nevermind the patch, idx_hit_sum is of course the sum of 0...idx-1.
>>>>>> Maybe something like this, again lightly tested:
>>>>>>
>>>>>> -----8<-----
>>>>>>
>>>>>> diff --git a/drivers/cpuidle/governors/teo.c b/drivers/cpuidle/governors/teo.c
>>>>>> index 173ddcac540a..6bfb9cedb75e 100644
>>>>>> --- a/drivers/cpuidle/governors/teo.c
>>>>>> +++ b/drivers/cpuidle/governors/teo.c
>>>>>> @@ -383,13 +395,15 @@ static int teo_select(struct cpuidle_driver *drv, struct cpuidle_device *dev,
>>>>>>                  * has been stopped already into account.
>>>>>>                  */
>>>>>>                 intercept_sum = 0;
>>>>>> +               hit_sum = 0;
>>>>>>
>>>>>>                 for (i = idx - 1; i >= 0; i--) {
>>>>>>                         struct teo_bin *bin = &cpu_data->state_bins[i];
>>>>>>
>>>>>>                         intercept_sum += bin->intercepts;
>>>>>> +                       hit_sum += bin->hits;
>>>>>>
>>>>>> -                       if (2 * intercept_sum > idx_intercept_sum) {
>>>>>> +                       if (2 * intercept_sum > cpu_data->total || 2 * hit_sum > cpu_data->total) {
>>>>>>                                 /*
>>>>>>                                  * Use the current state unless it is too
>>>>>>                                  * shallow or disabled, in which case take the
>>>>>
>>>>> This will only matter after the deepest state has been rejected
>>>>> already and on the system in question this means selecting state 0 no
>>>>> matter what.
>>>>>
>>>>
>>>> Ah, right!
>>>>
>>>>
>>>>> The pre-6.12 behavior can be explained if tick wakeups are taken into account.
>>>>>
>>>>> Namely, when state 0 is chosen (because of the check mentioned above),
>>>>> the tick is not stopped and the sleep length is KTIME_MAX.  If the
>>>>> subsequent wakeup is a tick one, it will be counted as a hit on the
>>>>> deepest state (and it will contribute to the total sum in the check
>>>>> mentioned above).  Then, at one point, cpu_data->total will be large
>>>>> enough and the deepest state will become the candidate one.  If
>>>>> tick_nohz_get_sleep_length() returns a large value at that point, the
>>>>> tick will be stopped and the deepest state will be entered.  Nirvana
>>>>> ensues.
>>>>
>>>> So fundamentally we will have to count tick-wakeups as a) nothing, which
>>>> doesn't allow us to ever break out of the intercept logic that caused us
>>>> to leave the tick on b) intercepts, which is bonkers and doesn't allow us
>>>> to ever break out and c) hits == sleep_length would've been accurate.
>>>> Of course counting a tick wakeup as a hit for sleep_length negates the
>>>> intercept logic.
>>>
>>> Not quite.  The intercept logic is there for wakeups other than tick
>>> wakeups and timer wakeups.
>>>
>>> I actually think that tick wakeups can be counted as hits on the
>>> deepest available state - maybe only when tick wakeups dominate the
>>> wakeup pattern - but generally this is not unreasonable: When the
>>> wakeup pattern is dominated by tick wakeups, this by itself is a good
>>> enough reason to stop the tick.
>>
>> (assuming HZ=1000 below but it doesn't matter)
>> That will exclude any 'intercept' logic from having much effect if the
>> avg idle duration is >TICK_NSEC/2, which is potentially still quite a bit
>> off from state1 residency, like in Reka's case here.
>> That's why I thought it would cause unreasonable regressions here.
>> I'll give it a go as well though!
> 
> Thanks!
> 
> Note that I'd prefer to add a check if tick wakeups dominate the
> wakeup pattern before setting sleep_length_ns to KTIME_MAX though.
> I'd first like to know how the Reka's system reacts to the more
> drastic variant of this change.

Below are my usual tests, it's definitely visible but the impact is limited
on this platform anyway. I think if we gate the KTIME_MAX setting behind
the "tick wakeup dominate" it should be acceptable!
Let's see what Reka reports.

device     gov        iter     iops      idles  idle_miss      ratio     belows     aboves
mmcblk1    teo-m      0      2331     639646        147      0.000        112         35
mmcblk1    teo-m      1      2349     642996         57      0.000         41         16
mmcblk1    teo-m      2      2332     642354         56      0.000         41         15
mmcblk1    teo-patch  0      2326     599172       1879      0.003       1848         31
mmcblk1    teo-patch  1      2326     600758       1985      0.003       1951         34
mmcblk1    teo-patch  2      2325     596952       1958      0.003       1925         33
mmcblk1    teo-6-6    0      2336     592780       1767      0.003       1704         63
mmcblk1    teo-6-6    1      2333     600766       1540      0.003       1509         31
mmcblk1    teo-6-6    2      2332     599472       1619      0.003       1556         63
mmcblk1    teo-6-12   0      2331     699264         28      0.000         18         10
mmcblk1    teo-6-12   1      2336     725778          4      0.000          3          1
mmcblk1    teo-6-12   2      2344     719444          7      0.000          6          1
mmcblk2    teo-m      0      5693     866432        958      0.001        929         29
mmcblk2    teo-m      1      5686     866342         61      0.000         38         23
mmcblk2    teo-m      2      5627     700660       3468      0.005       3411         57
mmcblk2    teo-patch  0      5148     669428      49931      0.075      49888         43
mmcblk2    teo-patch  1      5405     742294      26013      0.035      25988         25
mmcblk2    teo-patch  2      5117     700422      53294      0.076      53276         18
mmcblk2    teo-6-6    0      5658     816016       4851      0.006       4830         21
mmcblk2    teo-6-6    1      5701     847102       3141      0.004       1508       1633
mmcblk2    teo-6-6    2      5823     848040       3504      0.004       2413       1091
mmcblk2    teo-6-12   0      5648     780954          4      0.000          2          2
mmcblk2    teo-6-12   1      5669     975648          6      0.000          4          2
mmcblk2    teo-6-12   2      5681     935194          9      0.000          6          3
nvme0n1    teo-m      0     10486     776106         75      0.000         57         18
nvme0n1    teo-m      1     11795     857688        112      0.000         48         64
nvme0n1    teo-m      2     10374     767134        107      0.000         49         58
nvme0n1    teo-patch  0     10813     752086       1913      0.003       1792        121
nvme0n1    teo-patch  1     10730     752280       1734      0.002       1642         92
nvme0n1    teo-patch  2     11474     798976       1796      0.002       1664        132
nvme0n1    teo-6-6    0     10416     731240       1588      0.002       1525         63
nvme0n1    teo-6-6    1     10693     747664       1699      0.002       1576        123
nvme0n1    teo-6-6    2     10652     745848       1844      0.002       1740        104
nvme0n1    teo-6-12   0     10657     958428         21      0.000         11         10
nvme0n1    teo-6-12   1     11508    1042604          5      0.000          5          0
nvme0n1    teo-6-12   2     10562     917098        120      0.000         61         59
sda        teo-m      0      1271     627586        549      0.001        530         19
sda        teo-m      1      1275     842724         63      0.000         47         16
sda        teo-m      2      1271     843048        303      0.000        229         74
sda        teo-patch  0      1218     749892      56469      0.075      56466          3
sda        teo-patch  1      1238     738258      20579      0.028      20569         10
sda        teo-patch  2      1199     684780      73871      0.108      73822         49
sda        teo-6-6    0      1268     766452       2554      0.003       2544         10
sda        teo-6-6    1      1267     767080       3405      0.004       2857        548
sda        teo-6-6    2      1264     537394       4374      0.008       4359         15
sda        teo-6-12   0      1271     890540          4      0.000          3          1
sda        teo-6-12   1      1271     890898          7      0.000          6          1
sda        teo-6-12   2      1271     897370          1      0.000          1          0
nullb0     teo-m      0    101665     112024        156      0.001         23        133
nullb0     teo-m      1    101735     112060        250      0.002        145        105
nullb0     teo-m      2    101439     112700        105      0.001         50         55
nullb0     teo-patch  0    102434      74802       2024      0.027       1974         50
nullb0     teo-patch  1    101920      75126       1785      0.024       1759         26
nullb0     teo-patch  2    101471      71876       2201      0.031       1998        203
nullb0     teo-6-6    0    101455      75484       1974      0.026       1808        166
nullb0     teo-6-6    1    101893      75116       1862      0.025       1726        136
nullb0     teo-6-6    2    101853      65582       3474      0.053       1529       1945


