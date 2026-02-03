Return-Path: <linux-pm+bounces-41939-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sODpDPW6gWm7JAMAu9opvQ
	(envelope-from <linux-pm+bounces-41939-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Tue, 03 Feb 2026 10:08:05 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D9BBD695E
	for <lists+linux-pm@lfdr.de>; Tue, 03 Feb 2026 10:08:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C60663006007
	for <lists+linux-pm@lfdr.de>; Tue,  3 Feb 2026 09:07:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 322D31DE885;
	Tue,  3 Feb 2026 09:07:56 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D468438F25A;
	Tue,  3 Feb 2026 09:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770109676; cv=none; b=bHDbmD0vJx+eqjs1rGBnN/0XVkCBgNlUMJ5RkJj6VqlJram3f+qCB7ZVSoZcaiOvXLVqnSPtbzYlOHLObSIwjHCV4q8NpJMO0HqUfAswRCFJvNV/vszZymf70ZIujnYNN95onUYzshaIAq7HuS/7vQNXv8nT2KC1mbW4v/lpRW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770109676; c=relaxed/simple;
	bh=EJJ1oecVlRs3jmRIw2eAMScwoa8Uf876cdNjbXprpjg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=a20U0C+KedCycMpw902SqB/pqnDcLc1asX5jtBCDE+1ycVL7VCm5q0X+tzg/hyL6OQJo7SEoBniLCh7Xc1oWwQADmt02mIzVaJ+LlEao6tIHiXb2o5FP3vm+rL2k54UhYWdGb5q/bYTmH6xzjNKWdujIm8/nFnng6ioC6CwL4XU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EF75E339;
	Tue,  3 Feb 2026 01:07:39 -0800 (PST)
Received: from [10.57.68.168] (unknown [10.57.68.168])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3E9293F632;
	Tue,  3 Feb 2026 01:07:44 -0800 (PST)
Message-ID: <8fd5a9d4-e555-4db1-aa02-8fe5b8a2962c@arm.com>
Date: Tue, 3 Feb 2026 09:07:42 +0000
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Performance regressions introduced via Revert "cpuidle: menu:
 Avoid discarding useful information" on 5.15 LTS
To: Harshvardhan Jha <harshvardhan.j.jha@oracle.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Doug Smythies <dsmythies@telus.net>
Cc: Sasha Levin <sashal@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-pm@vger.kernel.org,
 stable@vger.kernel.org, Daniel Lezcano <daniel.lezcano@linaro.org>,
 Sergey Senozhatsky <senozhatsky@chromium.org>
References: <d4690be7-9b81-498e-868b-fb4f1d558e08@oracle.com>
 <39c7d882-6711-4178-bce6-c1e4fc909b84@arm.com>
 <005401dc64a4$75f1d770$61d58650$@telus.net>
 <b36a7037-ca96-49ec-9b39-6e9808d6718c@oracle.com>
 <6347bf83-545b-4e85-a5af-1d0c7ea24844@arm.com>
 <849ee0ff-e15b-4b69-84de-6503e3b3168d@oracle.com>
 <003e01dc9013$e3bc5060$ab34f120$@telus.net>
 <004e01dc90b1$4b28f9e0$e17aeda0$@telus.net>
 <002601dc916e$6acbe650$4063b2f0$@telus.net>
 <CAJZ5v0gcSb_6QPMfHkjSMJ6OOF+PaCZrUKOafYQ++tHE2jBB4w@mail.gmail.com>
 <3b0720d2-9b72-48d0-998a-1fd091cec44f@arm.com>
 <5d4b624c-f993-49aa-95ab-5f279f7f6599@oracle.com>
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <5d4b624c-f993-49aa-95ab-5f279f7f6599@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[arm.com : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-41939-lists,linux-pm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[];
	REDIRECTOR_URL(0.00)[urldefense.com];
	TAGGED_RCPT(0.00)[linux-pm];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[christian.loehle@arm.com,linux-pm@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	R_DKIM_NA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[urldefense.com:url,arm.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7D9BBD695E
X-Rspamd-Action: no action

On 2/2/26 17:31, Harshvardhan Jha wrote:
> 
> On 02/02/26 12:50 AM, Christian Loehle wrote:
>> On 1/30/26 19:28, Rafael J. Wysocki wrote:
>>> On Thu, Jan 29, 2026 at 11:27 PM Doug Smythies <dsmythies@telus.net> wrote:
>>>> On 2026.01.28 15:53 Doug Smythies wrote:
>>>>> On 2026.01.27 21:07 Doug Smythies wrote:
>>>>>> On 2026.01.27 07:45 Harshvardhan Jha wrote:
>>>>>>> On 08/12/25 6:17 PM, Christian Loehle wrote:
>>>>>>>> On 12/8/25 11:33, Harshvardhan Jha wrote:
>>>>>>>>> On 04/12/25 4:00 AM, Doug Smythies wrote:
>>>>>>>>>> On 2025.12.03 08:45 Christian Loehle wrote:
>>>>>>>>>>> On 12/3/25 16:18, Harshvardhan Jha wrote:
>>>>> ... snip ...
>>>>>
>>>>>>>> It would be nice to get the idle states here, ideally how the states' usage changed
>>>>>>>> from base to revert.
>>>>>>>> The mentioned thread did this and should show how it can be done, but a dump of
>>>>>>>> cat /sys/devices/system/cpu/cpu*/cpuidle/state*/*
>>>>>>>> before and after the workload is usually fine to work with:
>>>>>>>> https://urldefense.com/v3/__https://lore.kernel.org/linux-pm/8da42386-282e-4f97-af93-4715ae206361@arm.com/__;!!ACWV5N9M2RV99hQ!PEhkFcO7emFLMaNxWEoE2Gtnw3zSkpghP17iuEvZM3W6KUpmkbgKw_tr91FwGfpzm4oA5f7c5sz8PkYvKiEVwI_iLIPpMt53$
>>>>>>> Apologies for the late reply, I'm attaching a tar ball which has the cpu
>>>>>>> states for the test suites before and after tests. The folders with the
>>>>>>> name of the test contain two folders good-kernel and bad-kernel
>>>>>>> containing two files having the before and after states. Please note
>>>>>>> that different machines were used for different test suites due to
>>>>>>> compatibility reasons. The jbb test was run using containers.
>>>>> Please provide the results of the test runs that were done for
>>>>> the supplied before and after idle data.
>>>>> In particular, what is the "fio" test and it results. Its idle data is not very revealing.
>>>>> Is it a test I can run on my test computer?
>>>> I see that I have fio installed on my test computer.
>>>>
>>>>>> It is a considerable amount of work to manually extract and summarize the data.
>>>>>> I have only done it for the phoronix-sqlite data.
>>>>> I have done the rest now, see below.
>>>>> I have also attached the results, in case the formatting gets screwed up.
>>>>>
>>>>>> There seems to be 40 CPUs, 5 idle states, with idle state 3 defaulting to disabled.
>>>>>> I remember seeing a Linux-pm email about why but couldn't find it just now.
>>>>>> Summary (also attached as a PNG file, in case the formatting gets messed up):
>>>>>> The total idle entries (usage)  and time seem low to me, which is why the ???.
>>>>>>
>>>>>> phoronix-sqlite
>>>>>>      Good Kernel: Time between samples 4 seconds (estimated and ???)
>>>>>>              Usage   Above   Below   Above   Below
>>>>>> state 0      220     0       218     0.00%   99.09%
>>>>>> state 1      70212   5213    34602   7.42%   49.28%
>>>>>> state 2      30273   5237    1806    17.30%  5.97%
>>>>>> state 3      0       0       0       0.00%   0.00%
>>>>>> state 4      11824   2120    0       17.93%  0.00%
>>>>>>
>>>>>> total                112529  12570   36626   43.72%   <<< Misses %
>>>>>>
>>>>>>      Bad Kernel: Time between samples 3.8 seconds (estimated and ???)
>>>>>>              Usage   Above   Below   Above   Below
>>>>>> state 0      262     0       260     0.00%   99.24%
>>>>>> state 1      62751   3985    35588   6.35%   56.71%
>>>>>> state 2      24941   7896    1433    31.66%  5.75%
>>>>>> state 3      0       0       0       0.00%   0.00%
>>>>>> state 4      24489   11543   0       47.14%  0.00%
>>>>>>
>>>>>> total                112443  23424   37281   53.99%   <<< Misses %
>>>>>>
>>>>>> Observe 2X use of idle state 4 for the "Bad Kernel"
>>>>>>
>>>>>> I have a template now, and can summarize the other 40 CPU data
>>>>>> faster, but I would have to rework the template for the 56 CPU data,
>>>>>> and is it a 64 CPU data set at 4 idle states per CPU?
>>>>> jbb: 40 CPU's; 5 idle states, with idle state 3 defaulting to disabled.
>>>>> POLL, C1, C1E, C3 (disabled), C6
>>>>>
>>>>>       Good Kernel: Time between samples > 2 hours (estimated)
>>>>>       Usage           Above           Below           Above   Below
>>>>> state 0       297550          0               296084          0.00%   99.51%
>>>>> state 1       8062854 341043          4962635 4.23%   61.55%
>>>>> state 2       56708358        12688379        6252051 22.37%  11.02%
>>>>> state 3       0               0               0               0.00%   0.00%
>>>>> state 4       54624476        15868752        0               29.05%  0.00%
>>>>>
>>>>> total 119693238       28898174        11510770        33.76%  <<< Misses
>>>>>
>>>>>       Bad Kernel: Time between samples > 2 hours (estimated)
>>>>>       Usage           Above           Below           Above   Below
>>>>> state 0       90715           0               75134           0.00%   82.82%
>>>>> state 1       8878738 312970          6082180 3.52%   68.50%
>>>>> state 2       12048728        2576251 603316          21.38%  5.01%
>>>>> state 3       0               0               0               0.00%   0.00%
>>>>> state 4       85999424        44723273        0               52.00%  0.00%
>>>>>
>>>>> total 107017605       47612494        6760630 50.81%  <<< Misses
>>>>>
>>>>> As with the previous test, observe 1.6X use of idle state 4 for the "Bad Kernel"
>>>>>
>>>>> fio: 64 CPUs; 4 idle states; POLL, C1, C1E, C6.
>>>>>
>>>>> fio
>>>>>       Good Kernel: Time between samples ~ 1 minute (estimated)
>>>>>       Usage           Above   Below   Above   Below
>>>>> state 0       3822            0       3818    0.00%   99.90%
>>>>> state 1       148640          4406    68956   2.96%   46.39%
>>>>> state 2       593455          45344   105675  7.64%   17.81%
>>>>> state 3       3209648 807014  0       25.14%  0.00%
>>>>>
>>>>> total 3955565 856764  178449  26.17%  <<< Misses
>>>>>
>>>>>       Bad Kernel: Time between samples ~ 1 minute (estimated)
>>>>>       Usage           Above   Below   Above   Below
>>>>> state 0       916             0       756     0.00%   82.53%
>>>>> state 1       80230           2028    42791   2.53%   53.34%
>>>>> state 2       59231           6888    6791    11.63%  11.47%
>>>>> state 3       2455784 564797  0       23.00%  0.00%
>>>>>
>>>>> total 2596161 573713  50338   24.04%  <<< Misses
>>>>>
>>>>> It is not clear why the number of idle entries differs so much
>>>>> between the tests, but there is a bit of a different distribution
>>>>> of the workload among the CPUs.
>>>>>
>>>>> rds-stress: 56 CPUs; 5 idle states, with idle state 3 defaulting to disabled.
>>>>> POLL, C1, C1E, C3 (disabled), C6
>>>>>
>>>>> rds-stress-test
>>>>>       Good Kernel: Time between samples ~70 Seconds (estimated)
>>>>>       Usage   Above   Below   Above   Below
>>>>> state 0       1561    0       1435    0.00%   91.93%
>>>>> state 1       13855   899     2410    6.49%   17.39%
>>>>> state 2       467998  139254  23679   29.76%  5.06%
>>>>> state 3       0       0       0       0.00%   0.00%
>>>>> state 4       213132  107417  0       50.40%  0.00%
>>>>>
>>>>> total 696546  247570  27524   39.49%  <<< Misses
>>>>>
>>>>>       Bad Kernel: Time between samples ~ 70 Seconds (estimated)
>>>>>       Usage   Above   Below   Above   Below
>>>>> state 0       231     0       231     0.00%   100.00%
>>>>> state 1       5413    266     1186    4.91%   21.91%
>>>>> state 2       54365   719     3789    1.32%   6.97%
>>>>> state 3       0       0       0       0.00%   0.00%
>>>>> state 4       267055  148327  0       55.54%  0.00%
>>>>>
>>>>> total 327064  149312  5206    47.24%  <<< Misses
>>>>>
>>>>> Again, differing numbers of idle entries between tests.
>>>>> This time the load distribution between CPUs is more
>>>>> obvious. In the "Bad" case most work is done on 2 or 3 CPU's.
>>>>> In the "Good" case the work is distributed over more CPUs.
>>>>> I assume without proof, that the scheduler is deciding not to migrate
>>>>> the next bit of work to another CPU in the one case verses the other.
>>>> The above is incorrect. The CPUs involved between the "Good"
>>>> and "Bad" tests are very similar, mainly 2 CPUs with a little of
>>>> a 3rd and 4th. See the attached graph for more detail / clarity.
>>>>
>>>> All of the tests show higher usage of shallower idle states with
>>>> the "Good" verses the "Bad", which was the expectation of the
>>>> original patch, as has been mentioned a few times in the emails.
>>>>
>>>> My input is to revert the reversion.
>>> OK, noted, thanks!
>>>
>>> Christian, what do you think?
>> I've attached readable diffs of the values provided the tldr is:
>>
>> +--------------------+-----------+-----------+
>> | Workload           | Δ above % | Δ below % |
>> +--------------------+-----------+-----------+
>> | fio                |  -10.11   |  +2.36    |
>> | rds-stress-test    |   -0.44   |  +2.57    |
>> | jbb                |  -20.35   |  +3.30    |
>> | phoronix-sqlite    |   -9.66   |  -0.61    |
>> +--------------------+-----------+-----------+
>>
>> I think the overall trend however is clear, the commit
>> 85975daeaa4d ("cpuidle: menu: Avoid discarding useful information")
>> improved menu on many systems and workloads, I'd dare to say most.
>>
>> Even on the reported regression introduced by it, the cpuidle governor
>> performed better on paper, system metrics regressed because other
>> CPUs' P-states weren't available due to being in a shallower state.
>> https://urldefense.com/v3/__https://lore.kernel.org/linux-pm/36iykr223vmcfsoysexug6s274nq2oimcu55ybn6ww4il3g3cv@cohflgdbpnq7/__;!!ACWV5N9M2RV99hQ!KSEGRBOHs7E_E4fRenT3y3MovrhDewsTY-E4lu1JCX0Py-r4GiEJefoLfcHrummpmvmeO_vp1beh-OO_MYxG9xLU0BuBunAS$ 
>> (+CC Sergey)
>> It could be argued that this is a limitation of a per-CPU cpuidle
>> governor and a more holistic approach would be needed for that platform
>> (i.e. power/thermal-budget-sharing-CPUs want to use higher P-states,
>> skew towards deeper cpuidle states).
>>
>> I also think that the change made sense, for small residency values
>> with a bit of random noise mixed in, performing the same statistical
>> test doesn't seem sensible, the short intervals will look noisier.
>>
>> So options are:
>> 1. Revert revert on mainline+stable
>> 2. Revert revert on mainline only
>> 3. Keep revert, miss out on the improvement for many.
>> 4. Revert only when we have a good solution for the platforms like
>> Sergey's.
>>
>> I'd lean towards 2 because 4 won't be easy, unless of course a minor
>> hack like playing with the deep idle state residency values would
>> be enough to mitigate.
> 
> Wouldn't it be better to choose option 1 as reverting the revert has
> even more pronounced improvements on older kernels? I've tested this on
> 6.12, 5.15 and 5.4 stable based kernels and found massive improvements.
> Since the revert has optimizations present only in Jasper Lake Systems
> which is new, isn't reverting the revert more relevant on stable
> kernels? It's more likely that older hardware runs older kernels than
> newer hardware although not always necessary imo.
> 

FWIW Jasper Lake seems to be supported from 5.6 on, see
b2d32af0bff4 ("x86/cpu: Add Jasper Lake to Intel family")


