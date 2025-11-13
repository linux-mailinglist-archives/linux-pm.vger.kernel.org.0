Return-Path: <linux-pm+bounces-37966-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 45B44C589B6
	for <lists+linux-pm@lfdr.de>; Thu, 13 Nov 2025 17:10:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 330874F4882
	for <lists+linux-pm@lfdr.de>; Thu, 13 Nov 2025 15:47:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D56AB2F83AE;
	Thu, 13 Nov 2025 15:43:25 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DE4C2F6586
	for <linux-pm@vger.kernel.org>; Thu, 13 Nov 2025 15:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763048605; cv=none; b=qxkzNGLsuAiXbm3/k4KhRBQ8R4XgeXbv5OCchZrFzfFGmP7+C7kEPjUqawP+StLRwU7DGRhPP2vGkfFEQMOVvN7xvZ1IR5Fowt8W93AT1RAnaEfW+l90z8W8FreQO0Bb80XXjpHZoLbgHk1HCwqRpqluZQa97Px4EUd/uag5bdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763048605; c=relaxed/simple;
	bh=pPSpkzDTyBKBkzS1sg44W/gi7/JERoPEX/GNB5+/pFE=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=ogi9w16LsiP76mi1OmsFLw9By6zHXWl5XWKCMiFnwuEblLB/3ccgidczIgmwecdBD+drdPoYSSbvDbPxMLPKd6UEDUh012x5yGtVRb/YRv4N7PDfW4BANpd8t1mlaeAulqkmUv15WPY14TmS9Q1QFfGTy+liavHnnANukWLwNVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EEF0E12FC;
	Thu, 13 Nov 2025 07:43:13 -0800 (PST)
Received: from [10.1.28.59] (e127648.arm.com [10.1.28.59])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1659F3F66E;
	Thu, 13 Nov 2025 07:43:19 -0800 (PST)
Message-ID: <ca45366d-4c85-4802-8a35-886a6f69d10d@arm.com>
Date: Thu, 13 Nov 2025 15:43:18 +0000
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Regression in TEO cpuidle governor between 6.6 and 6.12
From: Christian Loehle <christian.loehle@arm.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Reka Norman <rekanorman@chromium.org>, daniel.lezcano@linaro.org,
 linux-pm@vger.kernel.org
References: <CAEmPcwsNMNnNXuxgvHTQ93Mx-q3Oz9U57THQsU_qdcCx1m4w5g@mail.gmail.com>
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
 <00928b9d-7189-4929-afc9-7684fc5ef531@arm.com>
Content-Language: en-US
In-Reply-To: <00928b9d-7189-4929-afc9-7684fc5ef531@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 11/12/25 18:33, Christian Loehle wrote:
> On 11/12/25 14:16, Rafael J. Wysocki wrote:
>> On Wed, Nov 12, 2025 at 3:03 PM Christian Loehle
>> <christian.loehle@arm.com> wrote:
>>>
>>> On 11/12/25 13:32, Rafael J. Wysocki wrote:
>>>> On Tue, Nov 11, 2025 at 6:20 PM Christian Loehle
>>>> <christian.loehle@arm.com> wrote:
>>>>>
>>>>> On 11/11/25 11:48, Rafael J. Wysocki wrote:
>>>>>> On Tue, Nov 11, 2025 at 11:48 AM Christian Loehle
>>>>>> <christian.loehle@arm.com> wrote:
>>>>>>>
>>>>>>> On 11/11/25 10:00, Christian Loehle wrote:
>>>>
>>>> [...]
>>>>
>>>>>>>> I see two issues:
>>>>>>>> 1) Because of DECAY_SHIFT 3 values < 8 cannot decay (I guess this wouldn't really be an issue without 2))
>>>>>>
>>>>>> This shouldn't be a problem.
>>>>>
>>>>> Agreed, it should be a non-issue. Nonetheless if this wasn't the case $subject would've likely
>>>>> never been an issue.
>>>>
>>>> Well, I think that the leftovers can be cleared when they become less than 8.
>>>>
>>>>>>
>>>>>>>> 2) if (2 * idx_intercept_sum > cpu_data->total - idx_hit_sum) isn't an appropriate check, it will
>>>>>>>> exclude the state if it its idx_hit_sum make up the vast majority of cpu_data->total (i.e. it would
>>>>>>>> have been a really good candidate actually).
>>>>>>
>>>>>> Well, it would exclude the state if the sum of hits for the states
>>>>>> below it is large enough.  This is questionable (because why would
>>>>>> hits matter here), but I attempted to make the change below and
>>>>>> somebody reported a regression IIRC.
>>>>>>
>>>>>> This check is related to the problem at hand though (see below).
>>>>>>
>>>>>>>>
>>>>>>>> I lightly tested the below, it seems to be at least comparable to mainline teo.
>>>>>>>> (the documentation/comments would need adapting too, of course)
>>>>>>>>
>>>>>>>> -----8<-----
>>>>>>>>
>>>>>>>> diff --git a/drivers/cpuidle/governors/teo.c b/drivers/cpuidle/governors/teo.c
>>>>>>>> index bfa55c1eab5b..f8f76e3b8364 100644
>>>>>>>> --- a/drivers/cpuidle/governors/teo.c
>>>>>>>> +++ b/drivers/cpuidle/governors/teo.c
>>>>>>>> @@ -355,7 +355,7 @@ static int teo_select(struct cpuidle_driver *drv, struct cpuidle_device *dev,
>>>>>>>>          * all of the deeper states, a shallower idle state is likely to be a
>>>>>>>>          * better choice.
>>>>>>>>          */
>>>>>>>> -       if (2 * idx_intercept_sum > cpu_data->total - idx_hit_sum) {
>>>>>>>> +       if (2 * idx_intercept_sum > idx_hit_sum) {
>>>>>>>>                 int first_suitable_idx = idx;
>>>>>>>>
>>>>>>>>                 /*
>>>>>>>>
>>>>>>>>
>>>>>>>
>>>>>>> ... nevermind the patch, idx_hit_sum is of course the sum of 0...idx-1.
>>>>>>> Maybe something like this, again lightly tested:
>>>>>>>
>>>>>>> -----8<-----
>>>>>>>
>>>>>>> diff --git a/drivers/cpuidle/governors/teo.c b/drivers/cpuidle/governors/teo.c
>>>>>>> index 173ddcac540a..6bfb9cedb75e 100644
>>>>>>> --- a/drivers/cpuidle/governors/teo.c
>>>>>>> +++ b/drivers/cpuidle/governors/teo.c
>>>>>>> @@ -383,13 +395,15 @@ static int teo_select(struct cpuidle_driver *drv, struct cpuidle_device *dev,
>>>>>>>                  * has been stopped already into account.
>>>>>>>                  */
>>>>>>>                 intercept_sum = 0;
>>>>>>> +               hit_sum = 0;
>>>>>>>
>>>>>>>                 for (i = idx - 1; i >= 0; i--) {
>>>>>>>                         struct teo_bin *bin = &cpu_data->state_bins[i];
>>>>>>>
>>>>>>>                         intercept_sum += bin->intercepts;
>>>>>>> +                       hit_sum += bin->hits;
>>>>>>>
>>>>>>> -                       if (2 * intercept_sum > idx_intercept_sum) {
>>>>>>> +                       if (2 * intercept_sum > cpu_data->total || 2 * hit_sum > cpu_data->total) {
>>>>>>>                                 /*
>>>>>>>                                  * Use the current state unless it is too
>>>>>>>                                  * shallow or disabled, in which case take the
>>>>>>
>>>>>> This will only matter after the deepest state has been rejected
>>>>>> already and on the system in question this means selecting state 0 no
>>>>>> matter what.
>>>>>>
>>>>>
>>>>> Ah, right!
>>>>>
>>>>>
>>>>>> The pre-6.12 behavior can be explained if tick wakeups are taken into account.
>>>>>>
>>>>>> Namely, when state 0 is chosen (because of the check mentioned above),
>>>>>> the tick is not stopped and the sleep length is KTIME_MAX.  If the
>>>>>> subsequent wakeup is a tick one, it will be counted as a hit on the
>>>>>> deepest state (and it will contribute to the total sum in the check
>>>>>> mentioned above).  Then, at one point, cpu_data->total will be large
>>>>>> enough and the deepest state will become the candidate one.  If
>>>>>> tick_nohz_get_sleep_length() returns a large value at that point, the
>>>>>> tick will be stopped and the deepest state will be entered.  Nirvana
>>>>>> ensues.
>>>>>
>>>>> So fundamentally we will have to count tick-wakeups as a) nothing, which
>>>>> doesn't allow us to ever break out of the intercept logic that caused us
>>>>> to leave the tick on b) intercepts, which is bonkers and doesn't allow us
>>>>> to ever break out and c) hits == sleep_length would've been accurate.
>>>>> Of course counting a tick wakeup as a hit for sleep_length negates the
>>>>> intercept logic.
>>>>
>>>> Not quite.  The intercept logic is there for wakeups other than tick
>>>> wakeups and timer wakeups.
>>>>
>>>> I actually think that tick wakeups can be counted as hits on the
>>>> deepest available state - maybe only when tick wakeups dominate the
>>>> wakeup pattern - but generally this is not unreasonable: When the
>>>> wakeup pattern is dominated by tick wakeups, this by itself is a good
>>>> enough reason to stop the tick.
>>>
>>> (assuming HZ=1000 below but it doesn't matter)
>>> That will exclude any 'intercept' logic from having much effect if the
>>> avg idle duration is >TICK_NSEC/2, which is potentially still quite a bit
>>> off from state1 residency, like in Reka's case here.
>>> That's why I thought it would cause unreasonable regressions here.
>>> I'll give it a go as well though!
>>
>> Thanks!
>>
>> Note that I'd prefer to add a check if tick wakeups dominate the
>> wakeup pattern before setting sleep_length_ns to KTIME_MAX though.
>> I'd first like to know how the Reka's system reacts to the more
>> drastic variant of this change.
> 
> Below are my usual tests, it's definitely visible but the impact is limited
> on this platform anyway. I think if we gate the KTIME_MAX setting behind
> the "tick wakeup dominate" it should be acceptable!
> Let's see what Reka reports.
> 
Forgot to post the full results, anyway as expected with mtdblock (a very slow
/ low frequent wakeup scenario) the impact becomes clearly visible.
Still hopeful that the more conservative approach will be acceptable!

device     gov        iter     iops      idles  idle_miss      ratio     belows     aboves
mmcblk1    teo-m      0      2330     644806         69      0.000         47         22
mmcblk1    teo-m      1      2328     642994        102      0.000         66         36
mmcblk1    teo-m      2      2352     644020         44      0.000         28         16
mmcblk1    teo-patch  0      2323     596298       1830      0.003       1799         31
mmcblk1    teo-patch  1      2324     598574       1964      0.003       1926         38
mmcblk1    teo-patch  2      2325     599980       1908      0.003       1894         14
mmcblk1    teo-6-6    0      2329     596768       1753      0.003       1686         67
mmcblk1    teo-6-6    1      2330     600324       1527      0.003       1495         32
mmcblk1    teo-6-6    2      2331     600110       1439      0.002       1397         42
mmcblk1    teo-6-12   0      2347     741170          6      0.000          4          2
mmcblk1    teo-6-12   1      2329     782232          0      0.000          4          2
mmcblk1    teo-6-12   2      2328     775652         10      0.000          8          2
mmcblk2    teo-m      0      5758     860660         61      0.000         47         14
mmcblk2    teo-m      1      5731     827264        493      0.001        477         16
mmcblk2    teo-m      2      5700     861346         69      0.000         50         19
mmcblk2    teo-patch  0      5494     817672      19415      0.024      19379         36
mmcblk2    teo-patch  1      5474     717618      20018      0.028      19962         56
mmcblk2    teo-patch  2      5308     640356      33998      0.053      33970         28
mmcblk2    teo-6-6    0      5692     848824       1748      0.002       1685         63
mmcblk2    teo-6-6    1      5898     876180       1225      0.001       1215         10
mmcblk2    teo-6-6    2      5646     633846       2248      0.004       2199         49
mmcblk2    teo-6-12   0      5869    1009742          9      0.000          6          3
mmcblk2    teo-6-12   1      5644     775326          4      0.000          4          0
mmcblk2    teo-6-12   2      5671     904480          4      0.000          4          0
nvme0n1    teo-m      0     10342     765802        152      0.000         55         97
nvme0n1    teo-m      1     10703     789232        157      0.000         52        105
nvme0n1    teo-m      2     10405     770046         62      0.000         34         28
nvme0n1    teo-patch  0     10590     740088       1995      0.003       1848        147
nvme0n1    teo-patch  1     10472     733540       1686      0.002       1573        113
nvme0n1    teo-patch  2     10654     741262       1424      0.002       1329         95
nvme0n1    teo-6-6    0     11507     798450       1564      0.002       1505         59
nvme0n1    teo-6-6    1     10499     735294       2009      0.003       1879        130
nvme0n1    teo-6-6    2     10598     740936       1756      0.002       1477        279
nvme0n1    teo-6-12   0     10542     922846         18      0.000         12          6
nvme0n1    teo-6-12   1     10482     922114         23      0.000         16          7
nvme0n1    teo-6-12   2     11046     940398         23      0.000         17          6
sda        teo-m      0      1269     778958        111      0.000        108          3
sda        teo-m      1      1268     831064       1064      0.001       1054         10
sda        teo-m      2      1270     803714       2044      0.003       2034         10
sda        teo-patch  0      1206     763874      62173      0.081      62169          4
sda        teo-patch  1      1219     740656      58484      0.079      58477          7
sda        teo-patch  2      1172     728598      95154      0.131      95151          3
sda        teo-6-6    0      1257     591486       5450      0.009       5435         15
sda        teo-6-6    1      1265     788536       4412      0.006       4404          8
sda        teo-6-6    2      1254     788282       4470      0.006       4461          9
sda        teo-6-12   0      1274     841398          0      0.000       4461          9
sda        teo-6-12   1      1271     840824          0      0.000       4461          9
sda        teo-6-12   2      1272     923816          4      0.000          4          0
nullb0     teo-m      0    101284     114406        178      0.002         70        108
nullb0     teo-m      1    101381     112804        496      0.004        303        193
nullb0     teo-m      2    101716     100370        380      0.004        225        155
nullb0     teo-patch  0    100748      71690       1966      0.027       1853        113
nullb0     teo-patch  1    100858      75426       1716      0.023       1524        192
nullb0     teo-patch  2    101503      74320       1864      0.025       1851         13
nullb0     teo-6-6    0    101295      74346       2369      0.032       2139        230
nullb0     teo-6-6    1    101299      75350       1943      0.026       1803        140
nullb0     teo-6-6    2    100578      73924       2317      0.031       2089        228
nullb0     teo-6-12   0    100005     269180          7      0.000          4          3
nullb0     teo-6-12   1    100705     315302          0      0.000          4          3
nullb0     teo-6-12   2    100861     293350          6      0.000          3          3
mtdblock3  teo-m      0       262     312586         66      0.000         47         19
mtdblock3  teo-m      1       259     635682        100      0.000         97          3
mtdblock3  teo-m      2       258     771110        128      0.000         89         39
mtdblock3  teo-patch  0       244     435660      29414      0.068      29248        166
mtdblock3  teo-patch  1       236     449612      43754      0.097      43631        123
mtdblock3  teo-patch  2       238     814510      35946      0.044      35928         18
mtdblock3  teo-6-6    0       258     782434       1611      0.002       1572         39
mtdblock3  teo-6-6    1       259     591852       1658      0.003       1532        126
mtdblock3  teo-6-6    2       262     274192       1523      0.006       1432         91
mtdblock3  teo-6-12   0       256     986250         11      0.000         10          1
mtdblock3  teo-6-12   1       258     853982         11      0.000          9          2
mtdblock3  teo-6-12   2       260     654184          7      0.000          6          1

test       gov        i     score  %change    idles  idle_miss  miss_rt   belows   aboves
schbench   teo-m      0       196    0      26276         12      0.000         10          2
schbench   teo-m      1       195   -0      25668         23      0.001         19          4
schbench   teo-m      2       208    6      26180         24      0.001         21          3
schbench   teo-m      3       191   -2      25384          4      0.000          3          1
schbench   teo-m      4       194   -1      26060         31      0.001         21         10
schbench   teo-patch  0       195   -0      24678        253      0.010        239         14
schbench   teo-patch  1       192   -2      24100        228      0.009        221          7
schbench   teo-patch  2       192   -2      25154        310      0.012        281         29
schbench   teo-patch  3       194   -1      24426        253      0.010        236         17
schbench   teo-patch  4       193   -2      25008        277      0.011        262         15
schbench   teo-6-6    0       199    2      24676        128      0.005        121          7
schbench   teo-6-6    1       211    8      26794        127      0.005        117         10
schbench   teo-6-6    2       205    5      25026        140      0.006        125         15
schbench   teo-6-6    3       198    1      24816        196      0.008        174         22
schbench   teo-6-6    4       198    1      26604        236      0.009        218         18
schbench   teo-6-12   0       190   -3      24464          0      0.000        218         18
schbench   teo-6-12   1       190   -3      25274          0      0.000        218         18
schbench   teo-6-12   2       190   -3      25256          0      0.000        218         18
schbench   teo-6-12   3       199    2      26342          0      0.000        218         18
schbench   teo-6-12   4       188   -4      25508          0      0.000        218         18
ebizzy     teo-m      0     10733    0       1358          7      0.005          7          0
ebizzy     teo-m      1     10750    0       1206         12      0.010          8          4
ebizzy     teo-m      2     10699   -0       1950         24      0.012         23          1
ebizzy     teo-m      3     10773    0       1384         18      0.013         16          2
ebizzy     teo-m      4     10667   -1       2060         24      0.012         23          1
ebizzy     teo-patch  0     10728   -0       1474         49      0.033         45          4
ebizzy     teo-patch  1     10682   -0        962         26      0.027         26          0
ebizzy     teo-patch  2     10687   -0       1082         56      0.052         56          0
ebizzy     teo-patch  3     10736    0       1072         22      0.021         22          0
ebizzy     teo-patch  4     10674   -1       1156         53      0.046         50          3
ebizzy     teo-6-6    0     10659   -1       1442         58      0.040         46         12
ebizzy     teo-6-6    1     10653   -1       1144         43      0.038         41          2
ebizzy     teo-6-6    2     10696   -0       1256         37      0.029         35          2
ebizzy     teo-6-6    3     10710   -0       1168         43      0.037         38          5
ebizzy     teo-6-6    4     10696   -0       1166         47      0.040         43          4
ebizzy     teo-6-12   0     10709   -0       2186          0      0.000         43          4
ebizzy     teo-6-12   1     10687   -0       1688          0      0.000         43          4
ebizzy     teo-6-12   2     10689   -0       2806          0      0.000         43          4
ebizzy     teo-6-12   3     10734    0       1426          0      0.000         43          4
ebizzy     teo-6-12   4     10757    0       2346          0      0.000         43          4
adrestia   teo-m      0         8    0     103680         21      0.000         19          2
adrestia   teo-m      1        12   50     104026         31      0.000         16         15
adrestia   teo-m      2        12   50     104063         32      0.000         24          8
adrestia   teo-m      3        12   50     104768         44      0.000         22         22
adrestia   teo-m      4        12   50     104388         18      0.000         16          2
adrestia   teo-patch  0        12   50     103096         67      0.001         65          2
adrestia   teo-patch  1        12   50     103128         57      0.001         49          8
adrestia   teo-patch  2         8    0     102812         78      0.001         72          6
adrestia   teo-patch  3        12   50     102990         60      0.001         55          5
adrestia   teo-patch  4        12   50     103168         24      0.000         24          0
adrestia   teo-6-6    0        12   50     102832         61      0.001         51         10
adrestia   teo-6-6    1        12   50     103136         52      0.001         38         14
adrestia   teo-6-6    2        12   50     102882         37      0.000         29          8
adrestia   teo-6-6    3        12   50     103102         51      0.000         40         11
adrestia   teo-6-6    4        12   50     103260         60      0.001         43         17
adrestia   teo-6-12   0        12   50     112320          0      0.000         43         17
adrestia   teo-6-12   1        12   50     114412          0      0.000         43         17
adrestia   teo-6-12   2        11   38     112220          0      0.000         43         17
adrestia   teo-6-12   3        12   50     112028          0      0.000         43         17
adrestia   teo-6-12   4        12   50     112750          0      0.000         43         17

