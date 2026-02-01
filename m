Return-Path: <linux-pm+bounces-41871-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aAYtD5enf2kWvQIAu9opvQ
	(envelope-from <linux-pm+bounces-41871-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Sun, 01 Feb 2026 20:20:55 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CABA5C70CB
	for <lists+linux-pm@lfdr.de>; Sun, 01 Feb 2026 20:20:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id F39DB3001002
	for <lists+linux-pm@lfdr.de>; Sun,  1 Feb 2026 19:20:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 615562BE058;
	Sun,  1 Feb 2026 19:20:52 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D611C285CBA;
	Sun,  1 Feb 2026 19:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769973652; cv=none; b=b/Pwn/q0x2ckPSRAGlpi1LonEopo428JUDa01gjakQUB0guFXcbS0sDZEaqcFQhVYzkjqrK12A2O70HmSuflndfQSg/eeneQNLQfBGfxSUFsobiUQ3brYk+CPmgDyzW4KpgAu+a01u9eKJ94uud1RVoldKhTf3h+OhDzg8GwZoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769973652; c=relaxed/simple;
	bh=AUEGYdRV4PdRBv70K9cCUlN2ha6S3FLNRrXxcEwneN4=;
	h=Content-Type:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To; b=J0vQcCYD8avQrdUOmROwW12k3zP6q06jUe+YcwyMk8WQ7rzMnETH21Kor3pOLvPEMdKLy8aWmRUQhl1HyjhW7sFTaOXXCcMrmQqNUBfnhu1NGrnJftOjsCn6dIP6v5FMIscwVA5O72zlqZ6Vznc2y3Klzf2j/X/HijAlKWF2bGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D9DCB339;
	Sun,  1 Feb 2026 11:20:35 -0800 (PST)
Received: from [10.57.70.83] (unknown [10.57.70.83])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 815273F740;
	Sun,  1 Feb 2026 11:20:40 -0800 (PST)
Content-Type: multipart/mixed; boundary="------------XrZ3nh6S3L265OUxkao1nDCK"
Message-ID: <3b0720d2-9b72-48d0-998a-1fd091cec44f@arm.com>
Date: Sun, 1 Feb 2026 19:20:38 +0000
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Performance regressions introduced via Revert "cpuidle: menu:
 Avoid discarding useful information" on 5.15 LTS
To: "Rafael J. Wysocki" <rafael@kernel.org>,
 Doug Smythies <dsmythies@telus.net>
Cc: Harshvardhan Jha <harshvardhan.j.jha@oracle.com>,
 Sasha Levin <sashal@kernel.org>,
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
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <CAJZ5v0gcSb_6QPMfHkjSMJ6OOF+PaCZrUKOafYQ++tHE2jBB4w@mail.gmail.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.26 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[arm.com : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[multipart/mixed,text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	HAS_ATTACHMENT(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_FROM(0.00)[bounces-41871-lists,linux-pm=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:+,3:+,4:+,5:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[christian.loehle@arm.com,linux-pm@vger.kernel.org];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	R_DKIM_NA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	REDIRECTOR_URL(0.00)[urldefense.com];
	TAGGED_RCPT(0.00)[linux-pm];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,urldefense.com:url]
X-Rspamd-Queue-Id: CABA5C70CB
X-Rspamd-Action: no action

This is a multi-part message in MIME format.
--------------XrZ3nh6S3L265OUxkao1nDCK
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 1/30/26 19:28, Rafael J. Wysocki wrote:
> On Thu, Jan 29, 2026 at 11:27 PM Doug Smythies <dsmythies@telus.net> wrote:
>>
>> On 2026.01.28 15:53 Doug Smythies wrote:
>>> On 2026.01.27 21:07 Doug Smythies wrote:
>>>> On 2026.01.27 07:45 Harshvardhan Jha wrote:
>>>>> On 08/12/25 6:17 PM, Christian Loehle wrote:
>>>>>> On 12/8/25 11:33, Harshvardhan Jha wrote:
>>>>>>> On 04/12/25 4:00 AM, Doug Smythies wrote:
>>>>>>>> On 2025.12.03 08:45 Christian Loehle wrote:
>>>>>>>>> On 12/3/25 16:18, Harshvardhan Jha wrote:
>>> ... snip ...
>>>
>>>>>> It would be nice to get the idle states here, ideally how the states' usage changed
>>>>>> from base to revert.
>>>>>> The mentioned thread did this and should show how it can be done, but a dump of
>>>>>> cat /sys/devices/system/cpu/cpu*/cpuidle/state*/*
>>>>>> before and after the workload is usually fine to work with:
>>>>>> https://urldefense.com/v3/__https://lore.kernel.org/linux-pm/8da42386-282e-4f97-af93-4715ae206361@arm.com/__;!!ACWV5N9M2RV99hQ!PEhkFcO7emFLMaNxWEoE2Gtnw3zSkpghP17iuEvZM3W6KUpmkbgKw_tr91FwGfpzm4oA5f7c5sz8PkYvKiEVwI_iLIPpMt53$
>>>
>>>>> Apologies for the late reply, I'm attaching a tar ball which has the cpu
>>>>> states for the test suites before and after tests. The folders with the
>>>>> name of the test contain two folders good-kernel and bad-kernel
>>>>> containing two files having the before and after states. Please note
>>>>> that different machines were used for different test suites due to
>>>>> compatibility reasons. The jbb test was run using containers.
>>>
>>> Please provide the results of the test runs that were done for
>>> the supplied before and after idle data.
>>> In particular, what is the "fio" test and it results. Its idle data is not very revealing.
>>> Is it a test I can run on my test computer?
>>
>> I see that I have fio installed on my test computer.
>>
>>>> It is a considerable amount of work to manually extract and summarize the data.
>>>> I have only done it for the phoronix-sqlite data.
>>>
>>> I have done the rest now, see below.
>>> I have also attached the results, in case the formatting gets screwed up.
>>>
>>>> There seems to be 40 CPUs, 5 idle states, with idle state 3 defaulting to disabled.
>>>> I remember seeing a Linux-pm email about why but couldn't find it just now.
>>>> Summary (also attached as a PNG file, in case the formatting gets messed up):
>>>> The total idle entries (usage)  and time seem low to me, which is why the ???.
>>>>
>>>> phoronix-sqlite
>>>>      Good Kernel: Time between samples 4 seconds (estimated and ???)
>>>>              Usage   Above   Below   Above   Below
>>>> state 0      220     0       218     0.00%   99.09%
>>>> state 1      70212   5213    34602   7.42%   49.28%
>>>> state 2      30273   5237    1806    17.30%  5.97%
>>>> state 3      0       0       0       0.00%   0.00%
>>>> state 4      11824   2120    0       17.93%  0.00%
>>>>
>>>> total                112529  12570   36626   43.72%   <<< Misses %
>>>>
>>>>      Bad Kernel: Time between samples 3.8 seconds (estimated and ???)
>>>>              Usage   Above   Below   Above   Below
>>>> state 0      262     0       260     0.00%   99.24%
>>>> state 1      62751   3985    35588   6.35%   56.71%
>>>> state 2      24941   7896    1433    31.66%  5.75%
>>>> state 3      0       0       0       0.00%   0.00%
>>>> state 4      24489   11543   0       47.14%  0.00%
>>>>
>>>> total                112443  23424   37281   53.99%   <<< Misses %
>>>>
>>>> Observe 2X use of idle state 4 for the "Bad Kernel"
>>>>
>>>> I have a template now, and can summarize the other 40 CPU data
>>>> faster, but I would have to rework the template for the 56 CPU data,
>>>> and is it a 64 CPU data set at 4 idle states per CPU?
>>>
>>> jbb: 40 CPU's; 5 idle states, with idle state 3 defaulting to disabled.
>>> POLL, C1, C1E, C3 (disabled), C6
>>>
>>>       Good Kernel: Time between samples > 2 hours (estimated)
>>>       Usage           Above           Below           Above   Below
>>> state 0       297550          0               296084          0.00%   99.51%
>>> state 1       8062854 341043          4962635 4.23%   61.55%
>>> state 2       56708358        12688379        6252051 22.37%  11.02%
>>> state 3       0               0               0               0.00%   0.00%
>>> state 4       54624476        15868752        0               29.05%  0.00%
>>>
>>> total 119693238       28898174        11510770        33.76%  <<< Misses
>>>
>>>       Bad Kernel: Time between samples > 2 hours (estimated)
>>>       Usage           Above           Below           Above   Below
>>> state 0       90715           0               75134           0.00%   82.82%
>>> state 1       8878738 312970          6082180 3.52%   68.50%
>>> state 2       12048728        2576251 603316          21.38%  5.01%
>>> state 3       0               0               0               0.00%   0.00%
>>> state 4       85999424        44723273        0               52.00%  0.00%
>>>
>>> total 107017605       47612494        6760630 50.81%  <<< Misses
>>>
>>> As with the previous test, observe 1.6X use of idle state 4 for the "Bad Kernel"
>>>
>>> fio: 64 CPUs; 4 idle states; POLL, C1, C1E, C6.
>>>
>>> fio
>>>       Good Kernel: Time between samples ~ 1 minute (estimated)
>>>       Usage           Above   Below   Above   Below
>>> state 0       3822            0       3818    0.00%   99.90%
>>> state 1       148640          4406    68956   2.96%   46.39%
>>> state 2       593455          45344   105675  7.64%   17.81%
>>> state 3       3209648 807014  0       25.14%  0.00%
>>>
>>> total 3955565 856764  178449  26.17%  <<< Misses
>>>
>>>       Bad Kernel: Time between samples ~ 1 minute (estimated)
>>>       Usage           Above   Below   Above   Below
>>> state 0       916             0       756     0.00%   82.53%
>>> state 1       80230           2028    42791   2.53%   53.34%
>>> state 2       59231           6888    6791    11.63%  11.47%
>>> state 3       2455784 564797  0       23.00%  0.00%
>>>
>>> total 2596161 573713  50338   24.04%  <<< Misses
>>>
>>> It is not clear why the number of idle entries differs so much
>>> between the tests, but there is a bit of a different distribution
>>> of the workload among the CPUs.
>>>
>>> rds-stress: 56 CPUs; 5 idle states, with idle state 3 defaulting to disabled.
>>> POLL, C1, C1E, C3 (disabled), C6
>>>
>>> rds-stress-test
>>>       Good Kernel: Time between samples ~70 Seconds (estimated)
>>>       Usage   Above   Below   Above   Below
>>> state 0       1561    0       1435    0.00%   91.93%
>>> state 1       13855   899     2410    6.49%   17.39%
>>> state 2       467998  139254  23679   29.76%  5.06%
>>> state 3       0       0       0       0.00%   0.00%
>>> state 4       213132  107417  0       50.40%  0.00%
>>>
>>> total 696546  247570  27524   39.49%  <<< Misses
>>>
>>>       Bad Kernel: Time between samples ~ 70 Seconds (estimated)
>>>       Usage   Above   Below   Above   Below
>>> state 0       231     0       231     0.00%   100.00%
>>> state 1       5413    266     1186    4.91%   21.91%
>>> state 2       54365   719     3789    1.32%   6.97%
>>> state 3       0       0       0       0.00%   0.00%
>>> state 4       267055  148327  0       55.54%  0.00%
>>>
>>> total 327064  149312  5206    47.24%  <<< Misses
>>>
>>> Again, differing numbers of idle entries between tests.
>>> This time the load distribution between CPUs is more
>>> obvious. In the "Bad" case most work is done on 2 or 3 CPU's.
>>> In the "Good" case the work is distributed over more CPUs.
>>> I assume without proof, that the scheduler is deciding not to migrate
>>> the next bit of work to another CPU in the one case verses the other.
>>
>> The above is incorrect. The CPUs involved between the "Good"
>> and "Bad" tests are very similar, mainly 2 CPUs with a little of
>> a 3rd and 4th. See the attached graph for more detail / clarity.
>>
>> All of the tests show higher usage of shallower idle states with
>> the "Good" verses the "Bad", which was the expectation of the
>> original patch, as has been mentioned a few times in the emails.
>>
>> My input is to revert the reversion.
> 
> OK, noted, thanks!
> 
> Christian, what do you think?

I've attached readable diffs of the values provided the tldr is:

+--------------------+-----------+-----------+
| Workload           | Δ above % | Δ below % |
+--------------------+-----------+-----------+
| fio                |  -10.11   |  +2.36    |
| rds-stress-test    |   -0.44   |  +2.57    |
| jbb                |  -20.35   |  +3.30    |
| phoronix-sqlite    |   -9.66   |  -0.61    |
+--------------------+-----------+-----------+

I think the overall trend however is clear, the commit
85975daeaa4d ("cpuidle: menu: Avoid discarding useful information")
improved menu on many systems and workloads, I'd dare to say most.

Even on the reported regression introduced by it, the cpuidle governor
performed better on paper, system metrics regressed because other
CPUs' P-states weren't available due to being in a shallower state.
https://lore.kernel.org/linux-pm/36iykr223vmcfsoysexug6s274nq2oimcu55ybn6ww4il3g3cv@cohflgdbpnq7/
(+CC Sergey)
It could be argued that this is a limitation of a per-CPU cpuidle
governor and a more holistic approach would be needed for that platform
(i.e. power/thermal-budget-sharing-CPUs want to use higher P-states,
skew towards deeper cpuidle states).

I also think that the change made sense, for small residency values
with a bit of random noise mixed in, performing the same statistical
test doesn't seem sensible, the short intervals will look noisier.

So options are:
1. Revert revert on mainline+stable
2. Revert revert on mainline only
3. Keep revert, miss out on the improvement for many.
4. Revert only when we have a good solution for the platforms like
Sergey's.

I'd lean towards 2 because 4 won't be easy, unless of course a minor
hack like playing with the deep idle state residency values would
be enough to mitigate.




--------------XrZ3nh6S3L265OUxkao1nDCK
Content-Type: text/plain; charset=UTF-8; name="diff_rds_stress-test.txt"
Content-Disposition: attachment; filename="diff_rds_stress-test.txt"
Content-Transfer-Encoding: base64

YmFkLWtlcm5lbDoKCmluZGV4MCBQT0xMICBsYXRlbmN5PTAgcmVzaWRlbmN5PTAgIGRlc2M9
J0NQVUlETEUgQ09SRSBQT0xMIElETEUnCiAgYWJvdmUgICAgICAgICAgICAgICAgIDogMAog
IGJlbG93ICAgICAgICAgICAgICAgICA6IDIzMQogIHVzYWdlICAgICAgICAgICAgICAgICA6
IDIzMQogIHRpbWUgICAgICAgICAgICAgICAgICA6IDQ0MjAKICBhdmdfdGltZV91c19wZXJf
dXNhZ2UgOiAxOS4xMzQxOTkxMzQxOTkxMzIKICBhYm92ZV9wY3Rfb3Zlcl91c2FnZSAgOiAw
LjAKICBiZWxvd19wY3Rfb3Zlcl91c2FnZSAgOiAxMDAuMAoKaW5kZXgxIEMxICBsYXRlbmN5
PTIgcmVzaWRlbmN5PTIgIGRlc2M9J01XQUlUIDB4MDAnCiAgYWJvdmUgICAgICAgICAgICAg
ICAgIDogMjY2CiAgYmVsb3cgICAgICAgICAgICAgICAgIDogMTE4NgogIHVzYWdlICAgICAg
ICAgICAgICAgICA6IDU0MTMKICB0aW1lICAgICAgICAgICAgICAgICAgOiAyNjQzNjUKICBh
dmdfdGltZV91c19wZXJfdXNhZ2UgOiA0OC44Mzg5MDYzMzY1OTcwODQKICBhYm92ZV9wY3Rf
b3Zlcl91c2FnZSAgOiA0LjkxNDA5NTY5NTU0Nzc1NQogIGJlbG93X3BjdF9vdmVyX3VzYWdl
ICA6IDIxLjkxMDIxNjE0NjMxNDQzCgppbmRleDIgQzFFICBsYXRlbmN5PTEwIHJlc2lkZW5j
eT0yMCAgZGVzYz0nTVdBSVQgMHgwMScKICBhYm92ZSAgICAgICAgICAgICAgICAgOiA3MTkK
ICBiZWxvdyAgICAgICAgICAgICAgICAgOiAzNzg5CiAgdXNhZ2UgICAgICAgICAgICAgICAg
IDogNTQzNjUKICB0aW1lICAgICAgICAgICAgICAgICAgOiAxMTk3OTIxMwogIGF2Z190aW1l
X3VzX3Blcl91c2FnZSA6IDIyMC4zNDc4ODkyNjY5OTE2NAogIGFib3ZlX3BjdF9vdmVyX3Vz
YWdlICA6IDEuMzIyNTQyMDc2NzAzNzYxNwogIGJlbG93X3BjdF9vdmVyX3VzYWdlICA6IDYu
OTY5NTU3NjE5NzkyMTQ2CgppbmRleDMgQzMgIGxhdGVuY3k9NDAgcmVzaWRlbmN5PTEwMCAg
ZGVzYz0nTVdBSVQgMHgxMCcKICBhYm92ZSAgICAgICAgICAgICAgICAgOiAwCiAgYmVsb3cg
ICAgICAgICAgICAgICAgIDogMAogIHVzYWdlICAgICAgICAgICAgICAgICA6IDAKICB0aW1l
ICAgICAgICAgICAgICAgICAgOiAwCiAgYXZnX3RpbWVfdXNfcGVyX3VzYWdlIDogbmFuCiAg
YWJvdmVfcGN0X292ZXJfdXNhZ2UgIDogbmFuCiAgYmVsb3dfcGN0X292ZXJfdXNhZ2UgIDog
bmFuCgppbmRleDQgQzYgIGxhdGVuY3k9MTMzIHJlc2lkZW5jeT00MDAgIGRlc2M9J01XQUlU
IDB4MjAnCiAgYWJvdmUgICAgICAgICAgICAgICAgIDogMTQ4MzI3CiAgYmVsb3cgICAgICAg
ICAgICAgICAgIDogMAogIHVzYWdlICAgICAgICAgICAgICAgICA6IDI2NzA1NQogIHRpbWUg
ICAgICAgICAgICAgICAgICA6IDM3Mjg0MjMxMjQKICBhdmdfdGltZV91c19wZXJfdXNhZ2Ug
OiAxMzk2MS4yNTU2MzY0NzkzNzYKICBhYm92ZV9wY3Rfb3Zlcl91c2FnZSAgOiA1NS41NDE3
NDIzMzc3MjA2OQogIGJlbG93X3BjdF9vdmVyX3VzYWdlICA6IDAuMAoKT1ZFUkFMTAogIGFi
b3ZlICAgICAgICAgICAgICAgICA6IDE0OTMxMgogIGJlbG93ICAgICAgICAgICAgICAgICA6
IDUyMDYKICB1c2FnZSAgICAgICAgICAgICAgICAgOiAzMjcwNjQKICB0aW1lICAgICAgICAg
ICAgICAgICAgOiAzNzQwNjcxMTIyCiAgYXZnX3RpbWVfdXNfcGVyX3VzYWdlIDogMTE0Mzcu
MTIyNzcxMDc4NDQ0CiAgYWJvdmVfcGN0X292ZXJfdXNhZ2UgIDogNDUuNjUyMjI3MDg3MDUz
MwogIGJlbG93X3BjdF9vdmVyX3VzYWdlICA6IDEuNTkxNzM3Mzk2OTYyMDYyNQoKZ29vZC1r
ZXJuZWw6CgppbmRleDAgUE9MTCAgbGF0ZW5jeT0wIHJlc2lkZW5jeT0wICBkZXNjPSdDUFVJ
RExFIENPUkUgUE9MTCBJRExFJwogIGFib3ZlICAgICAgICAgICAgICAgICA6IDAKICBiZWxv
dyAgICAgICAgICAgICAgICAgOiAxNDM1CiAgdXNhZ2UgICAgICAgICAgICAgICAgIDogMTU2
MQogIHRpbWUgICAgICAgICAgICAgICAgICA6IDIzOTk3CiAgYXZnX3RpbWVfdXNfcGVyX3Vz
YWdlIDogMTUuMzcyODM3OTI0NDA3NDMxCiAgYWJvdmVfcGN0X292ZXJfdXNhZ2UgIDogMC4w
CiAgYmVsb3dfcGN0X292ZXJfdXNhZ2UgIDogOTEuOTI4MjUxMTIxMDc2MjMKCmluZGV4MSBD
MSAgbGF0ZW5jeT0yIHJlc2lkZW5jeT0yICBkZXNjPSdNV0FJVCAweDAwJwogIGFib3ZlICAg
ICAgICAgICAgICAgICA6IDg5OQogIGJlbG93ICAgICAgICAgICAgICAgICA6IDI0MTAKICB1
c2FnZSAgICAgICAgICAgICAgICAgOiAxMzg1NQogIHRpbWUgICAgICAgICAgICAgICAgICA6
IDU4MDg5NQogIGF2Z190aW1lX3VzX3Blcl91c2FnZSA6IDQxLjkyNjc0MTI0ODY0NjcKICBh
Ym92ZV9wY3Rfb3Zlcl91c2FnZSAgOiA2LjQ4ODYzMjI2MjcyMTAzOTUKICBiZWxvd19wY3Rf
b3Zlcl91c2FnZSAgOiAxNy4zOTQ0NDI0Mzk1NTI1MQoKaW5kZXgyIEMxRSAgbGF0ZW5jeT0x
MCByZXNpZGVuY3k9MjAgIGRlc2M9J01XQUlUIDB4MDEnCiAgYWJvdmUgICAgICAgICAgICAg
ICAgIDogMTM5MjU0CiAgYmVsb3cgICAgICAgICAgICAgICAgIDogMjM2NzkKICB1c2FnZSAg
ICAgICAgICAgICAgICAgOiA0Njc5OTgKICB0aW1lICAgICAgICAgICAgICAgICAgOiA3MTA0
NDgyNQogIGF2Z190aW1lX3VzX3Blcl91c2FnZSA6IDE1MS44MDU4MzAzNjY3OTY0NAogIGFi
b3ZlX3BjdF9vdmVyX3VzYWdlICA6IDI5Ljc1NTI1NTM2NDMzOTE2MwogIGJlbG93X3BjdF9v
dmVyX3VzYWdlICA6IDUuMDU5NjM3MDA2OTk1NzU2CgppbmRleDMgQzMgIGxhdGVuY3k9NDAg
cmVzaWRlbmN5PTEwMCAgZGVzYz0nTVdBSVQgMHgxMCcKICBhYm92ZSAgICAgICAgICAgICAg
ICAgOiAwCiAgYmVsb3cgICAgICAgICAgICAgICAgIDogMAogIHVzYWdlICAgICAgICAgICAg
ICAgICA6IDAKICB0aW1lICAgICAgICAgICAgICAgICAgOiAwCiAgYXZnX3RpbWVfdXNfcGVy
X3VzYWdlIDogbmFuCiAgYWJvdmVfcGN0X292ZXJfdXNhZ2UgIDogbmFuCiAgYmVsb3dfcGN0
X292ZXJfdXNhZ2UgIDogbmFuCgppbmRleDQgQzYgIGxhdGVuY3k9MTMzIHJlc2lkZW5jeT00
MDAgIGRlc2M9J01XQUlUIDB4MjAnCiAgYWJvdmUgICAgICAgICAgICAgICAgIDogMTA3NDE3
CiAgYmVsb3cgICAgICAgICAgICAgICAgIDogMAogIHVzYWdlICAgICAgICAgICAgICAgICA6
IDIxMzEzMgogIHRpbWUgICAgICAgICAgICAgICAgICA6IDM2NzA3NDU2MDIKICBhdmdfdGlt
ZV91c19wZXJfdXNhZ2UgOiAxNzIyMi44NzQwOTY4MDM4NgogIGFib3ZlX3BjdF9vdmVyX3Vz
YWdlICA6IDUwLjM5OTI4MzA3MzQwMDUyNQogIGJlbG93X3BjdF9vdmVyX3VzYWdlICA6IDAu
MAoKT1ZFUkFMTAogIGFib3ZlICAgICAgICAgICAgICAgICA6IDI0NzU3MAogIGJlbG93ICAg
ICAgICAgICAgICAgICA6IDI3NTI0CiAgdXNhZ2UgICAgICAgICAgICAgICAgIDogNjk2NTQ2
CiAgdGltZSAgICAgICAgICAgICAgICAgIDogMzc0MjM5NTMxOQogIGF2Z190aW1lX3VzX3Bl
cl91c2FnZSA6IDUzNzIuNzg5OTA3NjI5OTM0CiAgYWJvdmVfcGN0X292ZXJfdXNhZ2UgIDog
MzUuNTQyNTE5ODA0ODY1NzMKICBiZWxvd19wY3Rfb3Zlcl91c2FnZSAgOiAzLjk1MTQ5Nzgx
OTIzOTUwNDUK
--------------XrZ3nh6S3L265OUxkao1nDCK
Content-Type: text/plain; charset=UTF-8; name="diff_fio.txt"
Content-Disposition: attachment; filename="diff_fio.txt"
Content-Transfer-Encoding: base64

YmFkLWtlcm5lbDoKCmluZGV4MCBQT0xMICBsYXRlbmN5PTAgcmVzaWRlbmN5PTAgIGRlc2M9
J0NQVUlETEUgQ09SRSBQT0xMIElETEUnCiAgYWJvdmUgICAgICAgICAgICAgICAgIDogMAog
IGJlbG93ICAgICAgICAgICAgICAgICA6IDc1NgogIHVzYWdlICAgICAgICAgICAgICAgICA6
IDkxNgogIHRpbWUgICAgICAgICAgICAgICAgICA6IDEzMzA0CiAgYXZnX3RpbWVfdXNfcGVy
X3VzYWdlIDogMTQuNTI0MDE3NDY3MjQ4OTA5CiAgYWJvdmVfcGN0X292ZXJfdXNhZ2UgIDog
MC4wCiAgYmVsb3dfcGN0X292ZXJfdXNhZ2UgIDogODIuNTMyNzUxMDkxNzAzMDYKCmluZGV4
MSBDMSAgbGF0ZW5jeT0yIHJlc2lkZW5jeT0yICBkZXNjPSdNV0FJVCAweDAwJwogIGFib3Zl
ICAgICAgICAgICAgICAgICA6IDIwMjgKICBiZWxvdyAgICAgICAgICAgICAgICAgOiA0Mjc5
MQogIHVzYWdlICAgICAgICAgICAgICAgICA6IDgwMjMwCiAgdGltZSAgICAgICAgICAgICAg
ICAgIDogMTQxMjEwNDMKICBhdmdfdGltZV91c19wZXJfdXNhZ2UgOiAxNzYuMDA3MDE3MzI1
MTkwMDgKICBhYm92ZV9wY3Rfb3Zlcl91c2FnZSAgOiAyLjUyNzczMjc2ODI5MTE2MwogIGJl
bG93X3BjdF9vdmVyX3VzYWdlICA6IDUzLjMzNTQxMDY5NDI1NDAyCgppbmRleDIgQzFFICBs
YXRlbmN5PTEwIHJlc2lkZW5jeT0yMCAgZGVzYz0nTVdBSVQgMHgwMScKICBhYm92ZSAgICAg
ICAgICAgICAgICAgOiA2ODg4CiAgYmVsb3cgICAgICAgICAgICAgICAgIDogNjc5MQogIHVz
YWdlICAgICAgICAgICAgICAgICA6IDU5MjMxCiAgdGltZSAgICAgICAgICAgICAgICAgIDog
OTUxODQ4OQogIGF2Z190aW1lX3VzX3Blcl91c2FnZSA6IDE2MC43MDExMzYyMjkzMzkzNwog
IGFib3ZlX3BjdF9vdmVyX3VzYWdlICA6IDExLjYyOTA0NTYwMTEyMTAzNQogIGJlbG93X3Bj
dF9vdmVyX3VzYWdlICA6IDExLjQ2NTI4MDAwNTQwMjU3NgoKaW5kZXgzIEM2ICBsYXRlbmN5
PTkyIHJlc2lkZW5jeT0yNzYgIGRlc2M9J01XQUlUIDB4MjAnCiAgYWJvdmUgICAgICAgICAg
ICAgICAgIDogNTY0Nzk3CiAgYmVsb3cgICAgICAgICAgICAgICAgIDogMAogIHVzYWdlICAg
ICAgICAgICAgICAgICA6IDI0NTU3ODQKICB0aW1lICAgICAgICAgICAgICAgICAgOiAzNjU2
MjMyNjQ1CiAgYXZnX3RpbWVfdXNfcGVyX3VzYWdlIDogMTQ4OC44MjUwMTI3MDQ3MDA0CiAg
YWJvdmVfcGN0X292ZXJfdXNhZ2UgIDogMjIuOTk4NjQzMjAzMTQ4MTYKICBiZWxvd19wY3Rf
b3Zlcl91c2FnZSAgOiAwLjAKCk9WRVJBTEwKICBhYm92ZSAgICAgICAgICAgICAgICAgOiA1
NzM3MTMKICBiZWxvdyAgICAgICAgICAgICAgICAgOiA1MDMzOAogIHVzYWdlICAgICAgICAg
ICAgICAgICA6IDI1OTYxNjEKICB0aW1lICAgICAgICAgICAgICAgICAgOiAzNjc5ODg1NDgx
CiAgYXZnX3RpbWVfdXNfcGVyX3VzYWdlIDogMTQxNy40MzM0NjQ2NDI2MDEyCiAgYWJvdmVf
cGN0X292ZXJfdXNhZ2UgIDogMjIuMDk4NTEzOTIxMTMyMDEKICBiZWxvd19wY3Rfb3Zlcl91
c2FnZSAgOiAxLjkzODkzOTg0MjMyODczMDcKCmdvb2Qta2VybmVsOgoKaW5kZXgwIFBPTEwg
IGxhdGVuY3k9MCByZXNpZGVuY3k9MCAgZGVzYz0nQ1BVSURMRSBDT1JFIFBPTEwgSURMRScK
ICBhYm92ZSAgICAgICAgICAgICAgICAgOiAwCiAgYmVsb3cgICAgICAgICAgICAgICAgIDog
MzgxOAogIHVzYWdlICAgICAgICAgICAgICAgICA6IDM4MjIKICB0aW1lICAgICAgICAgICAg
ICAgICAgOiA4NDYxOAogIGF2Z190aW1lX3VzX3Blcl91c2FnZSA6IDIyLjEzOTcxNzQyNTQz
MTcxMgogIGFib3ZlX3BjdF9vdmVyX3VzYWdlICA6IDAuMAogIGJlbG93X3BjdF9vdmVyX3Vz
YWdlICA6IDk5Ljg5NTM0Mjc1MjQ4NTYKCmluZGV4MSBDMSAgbGF0ZW5jeT0yIHJlc2lkZW5j
eT0yICBkZXNjPSdNV0FJVCAweDAwJwogIGFib3ZlICAgICAgICAgICAgICAgICA6IDQ0MDYK
ICBiZWxvdyAgICAgICAgICAgICAgICAgOiA2ODk1NgogIHVzYWdlICAgICAgICAgICAgICAg
ICA6IDE0ODY0MAogIHRpbWUgICAgICAgICAgICAgICAgICA6IDIyNTI3NDIyCiAgYXZnX3Rp
bWVfdXNfcGVyX3VzYWdlIDogMTUxLjU1NjkyOTQ5NDA3OTY3CiAgYWJvdmVfcGN0X292ZXJf
dXNhZ2UgIDogMi45NjQyMDg4MjY2OTUzNzE0CiAgYmVsb3dfcGN0X292ZXJfdXNhZ2UgIDog
NDYuMzkxMjgwOTQ3MjU1MTEKCmluZGV4MiBDMUUgIGxhdGVuY3k9MTAgcmVzaWRlbmN5PTIw
ICBkZXNjPSdNV0FJVCAweDAxJwogIGFib3ZlICAgICAgICAgICAgICAgICA6IDQ1MzQ0CiAg
YmVsb3cgICAgICAgICAgICAgICAgIDogMTA1Njc1CiAgdXNhZ2UgICAgICAgICAgICAgICAg
IDogNTkzNDU1CiAgdGltZSAgICAgICAgICAgICAgICAgIDogMTIxMDA2NTIyCiAgYXZnX3Rp
bWVfdXNfcGVyX3VzYWdlIDogMjAzLjkwMTc2NTA4NzQ5NjEKICBhYm92ZV9wY3Rfb3Zlcl91
c2FnZSAgOiA3LjY0MDY4MDQyMjI3Mjk2MQogIGJlbG93X3BjdF9vdmVyX3VzYWdlICA6IDE3
LjgwNjc0MTg3NTk2MzYzOAoKaW5kZXgzIEM2ICBsYXRlbmN5PTkyIHJlc2lkZW5jeT0yNzYg
IGRlc2M9J01XQUlUIDB4MjAnCiAgYWJvdmUgICAgICAgICAgICAgICAgIDogODA3MDE0CiAg
YmVsb3cgICAgICAgICAgICAgICAgIDogMAogIHVzYWdlICAgICAgICAgICAgICAgICA6IDMy
MDk2NDgKICB0aW1lICAgICAgICAgICAgICAgICAgOiAzNTEwNjk4NTU0CiAgYXZnX3RpbWVf
dXNfcGVyX3VzYWdlIDogMTA5My43OTU1MDQ2NzgzOTQ1CiAgYWJvdmVfcGN0X292ZXJfdXNh
Z2UgIDogMjUuMTQzMzgwMjA4NjcwODYKICBiZWxvd19wY3Rfb3Zlcl91c2FnZSAgOiAwLjAK
Ck9WRVJBTEwKICBhYm92ZSAgICAgICAgICAgICAgICAgOiA4NTY3NjQKICBiZWxvdyAgICAg
ICAgICAgICAgICAgOiAxNzg0NDkKICB1c2FnZSAgICAgICAgICAgICAgICAgOiAzOTU1NTY1
CiAgdGltZSAgICAgICAgICAgICAgICAgIDogMzY1NDMxNzExNgogIGF2Z190aW1lX3VzX3Bl
cl91c2FnZSA6IDkyMy44NDIwMDg5MTY1NTE4CiAgYWJvdmVfcGN0X292ZXJfdXNhZ2UgIDog
MjEuNjU5NzEyMzI5MzM4NTQKICBiZWxvd19wY3Rfb3Zlcl91c2FnZSAgOiA0LjUxMTM0MDM1
MjEzNjc5OQoK
--------------XrZ3nh6S3L265OUxkao1nDCK
Content-Type: text/plain; charset=UTF-8; name="diff_jbb.txt"
Content-Disposition: attachment; filename="diff_jbb.txt"
Content-Transfer-Encoding: base64

amJiOgpiYWQta2VybmVsOgoKaW5kZXgwIFBPTEwgIGxhdGVuY3k9MCByZXNpZGVuY3k9MCAg
ZGVzYz0nQ1BVSURMRSBDT1JFIFBPTEwgSURMRScKICBhYm92ZSAgICAgICAgICAgICAgICAg
OiAwCiAgYmVsb3cgICAgICAgICAgICAgICAgIDogNzUxMzQKICB1c2FnZSAgICAgICAgICAg
ICAgICAgOiA5MDcxNQogIHRpbWUgICAgICAgICAgICAgICAgICA6IDE1NjM4NDQKICBhdmdf
dGltZV91c19wZXJfdXNhZ2UgOiAxNy4yMzkwODk0NTU5ODg1MzQKICBhYm92ZV9wY3Rfb3Zl
cl91c2FnZSAgOiAwLjAKICBiZWxvd19wY3Rfb3Zlcl91c2FnZSAgOiA4Mi44MjQyMjk3MzA0
NzQ1NgoKaW5kZXgxIEMxICBsYXRlbmN5PTIgcmVzaWRlbmN5PTIgIGRlc2M9J01XQUlUIDB4
MDAnCiAgYWJvdmUgICAgICAgICAgICAgICAgIDogMzEyOTcwCiAgYmVsb3cgICAgICAgICAg
ICAgICAgIDogNjA4MjE4MAogIHVzYWdlICAgICAgICAgICAgICAgICA6IDg4Nzg3MzgKICB0
aW1lICAgICAgICAgICAgICAgICAgOiAxMDE1NDQzOTAxCiAgYXZnX3RpbWVfdXNfcGVyX3Vz
YWdlIDogMTE0LjM2ODA0NDMwOTkwMDgKICBhYm92ZV9wY3Rfb3Zlcl91c2FnZSAgOiAzLjUy
NDkzNzg5MDk0ODAxNTQKICBiZWxvd19wY3Rfb3Zlcl91c2FnZSAgOiA2OC41MDI3NTM0MzE4
NTAzNAoKaW5kZXgyIEMxRSAgbGF0ZW5jeT0xMCByZXNpZGVuY3k9MjAgIGRlc2M9J01XQUlU
IDB4MDEnCiAgYWJvdmUgICAgICAgICAgICAgICAgIDogMjU3NjI1MQogIGJlbG93ICAgICAg
ICAgICAgICAgICA6IDYwMzMxNgogIHVzYWdlICAgICAgICAgICAgICAgICA6IDEyMDQ4NzI4
CiAgdGltZSAgICAgICAgICAgICAgICAgIDogMTQ3ODQxOTMwMAogIGF2Z190aW1lX3VzX3Bl
cl91c2FnZSA6IDEyMi43MDMzNTA5MjYzMzg0NAogIGFib3ZlX3BjdF9vdmVyX3VzYWdlICA6
IDIxLjM4MTkzMzQyODk4OTM1CiAgYmVsb3dfcGN0X292ZXJfdXNhZ2UgIDogNS4wMDczMDAz
NTU2ODg5OTkKCmluZGV4MyBDMyAgbGF0ZW5jeT00MCByZXNpZGVuY3k9MTAwICBkZXNjPSdN
V0FJVCAweDEwJwogIGFib3ZlICAgICAgICAgICAgICAgICA6IDAKICBiZWxvdyAgICAgICAg
ICAgICAgICAgOiAwCiAgdXNhZ2UgICAgICAgICAgICAgICAgIDogMAogIHRpbWUgICAgICAg
ICAgICAgICAgICA6IDAKICBhdmdfdGltZV91c19wZXJfdXNhZ2UgOiBuYW4KICBhYm92ZV9w
Y3Rfb3Zlcl91c2FnZSAgOiBuYW4KICBiZWxvd19wY3Rfb3Zlcl91c2FnZSAgOiBuYW4KCmlu
ZGV4NCBDNiAgbGF0ZW5jeT0xMzMgcmVzaWRlbmN5PTQwMCAgZGVzYz0nTVdBSVQgMHgyMCcK
ICBhYm92ZSAgICAgICAgICAgICAgICAgOiA0NDcyMzI3MwogIGJlbG93ICAgICAgICAgICAg
ICAgICA6IDAKICB1c2FnZSAgICAgICAgICAgICAgICAgOiA4NTk5OTQyNAogIHRpbWUgICAg
ICAgICAgICAgICAgICA6IDMwMDM4NDcwMzA5MwogIGF2Z190aW1lX3VzX3Blcl91c2FnZSA6
IDM0OTIuODY4Nzc4OTAwMTk0CiAgYWJvdmVfcGN0X292ZXJfdXNhZ2UgIDogNTIuMDA0MTU0
MTIwODQ2MgogIGJlbG93X3BjdF9vdmVyX3VzYWdlICA6IDAuMAoKT1ZFUkFMTAogIGFib3Zl
ICAgICAgICAgICAgICAgICA6IDQ3NjEyNDk0CiAgYmVsb3cgICAgICAgICAgICAgICAgIDog
Njc2MDYzMAogIHVzYWdlICAgICAgICAgICAgICAgICA6IDEwNzAxNzYwNQogIHRpbWUgICAg
ICAgICAgICAgICAgICA6IDMwMjg4MDEzMDEzOAogIGF2Z190aW1lX3VzX3Blcl91c2FnZSA6
IDI4MzAuMTg5NzYzMDU4MTQzNAogIGFib3ZlX3BjdF9vdmVyX3VzYWdlICA6IDQ0LjQ5MDMz
NzgyODA2MTA5NAogIGJlbG93X3BjdF9vdmVyX3VzYWdlICA6IDYuMzE3MzA2MzkwODUwMzY1
CiAgCmdvb2Qta2VybmVsCgppbmRleDAgUE9MTCAgbGF0ZW5jeT0wIHJlc2lkZW5jeT0wICBk
ZXNjPSdDUFVJRExFIENPUkUgUE9MTCBJRExFJwogIGFib3ZlICAgICAgICAgICAgICAgICA6
IDAKICBiZWxvdyAgICAgICAgICAgICAgICAgOiAyOTYwODQKICB1c2FnZSAgICAgICAgICAg
ICAgICAgOiAyOTc1NTAKICB0aW1lICAgICAgICAgICAgICAgICAgOiA1OTk2MDc5CiAgYXZn
X3RpbWVfdXNfcGVyX3VzYWdlIDogMjAuMTUxNTAwNTg4MTM2NDQ3CiAgYWJvdmVfcGN0X292
ZXJfdXNhZ2UgIDogMC4wCiAgYmVsb3dfcGN0X292ZXJfdXNhZ2UgIDogOTkuNTA3MzA5Njk1
ODQ5NDQKCmluZGV4MSBDMSAgbGF0ZW5jeT0yIHJlc2lkZW5jeT0yICBkZXNjPSdNV0FJVCAw
eDAwJwogIGFib3ZlICAgICAgICAgICAgICAgICA6IDM0MTA0MwogIGJlbG93ICAgICAgICAg
ICAgICAgICA6IDQ5NjI2MzUKICB1c2FnZSAgICAgICAgICAgICAgICAgOiA4MDYyODU0CiAg
dGltZSAgICAgICAgICAgICAgICAgIDogOTk0MzU4MzA2CiAgYXZnX3RpbWVfdXNfcGVyX3Vz
YWdlIDogMTIzLjMyNTg0Nzg5NDU1NDQ2CiAgYWJvdmVfcGN0X292ZXJfdXNhZ2UgIDogNC4y
Mjk4MDQ5Nzk3MjU1NDEKICBiZWxvd19wY3Rfb3Zlcl91c2FnZSAgOiA2MS41NDkzNTk1Njky
MDQ2NTQKCmluZGV4MiBDMUUgIGxhdGVuY3k9MTAgcmVzaWRlbmN5PTIwICBkZXNjPSdNV0FJ
VCAweDAxJwogIGFib3ZlICAgICAgICAgICAgICAgICA6IDEyNjg4Mzc5CiAgYmVsb3cgICAg
ICAgICAgICAgICAgIDogNjI1MjA1MQogIHVzYWdlICAgICAgICAgICAgICAgICA6IDU2NzA4
MzU4CiAgdGltZSAgICAgICAgICAgICAgICAgIDogOTkwMjI2NjMyNwogIGF2Z190aW1lX3Vz
X3Blcl91c2FnZSA6IDE3NC42MTc0MDUxOTgwMTMzMwogIGFib3ZlX3BjdF9vdmVyX3VzYWdl
ICA6IDIyLjM3NDc5NTI2Mzg2NTY5CiAgYmVsb3dfcGN0X292ZXJfdXNhZ2UgIDogMTEuMDI0
OTE5ODE4Njk3NjI0CgppbmRleDMgQzMgIGxhdGVuY3k9NDAgcmVzaWRlbmN5PTEwMCAgZGVz
Yz0nTVdBSVQgMHgxMCcKICBhYm92ZSAgICAgICAgICAgICAgICAgOiAwCiAgYmVsb3cgICAg
ICAgICAgICAgICAgIDogMAogIHVzYWdlICAgICAgICAgICAgICAgICA6IDAKICB0aW1lICAg
ICAgICAgICAgICAgICAgOiAwCiAgYXZnX3RpbWVfdXNfcGVyX3VzYWdlIDogbmFuCiAgYWJv
dmVfcGN0X292ZXJfdXNhZ2UgIDogbmFuCiAgYmVsb3dfcGN0X292ZXJfdXNhZ2UgIDogbmFu
CgppbmRleDQgQzYgIGxhdGVuY3k9MTMzIHJlc2lkZW5jeT00MDAgIGRlc2M9J01XQUlUIDB4
MjAnCiAgYWJvdmUgICAgICAgICAgICAgICAgIDogMTU4Njg3NTIKICBiZWxvdyAgICAgICAg
ICAgICAgICAgOiAwCiAgdXNhZ2UgICAgICAgICAgICAgICAgIDogNTQ2MjQ0NzYKICB0aW1l
ICAgICAgICAgICAgICAgICAgOiAyNzYyMzY2MjczMzAKICBhdmdfdGltZV91c19wZXJfdXNh
Z2UgOiA1MDU3LjAxMTkzOTY2NjAyMQogIGFib3ZlX3BjdF9vdmVyX3VzYWdlICA6IDI5LjA1
MDYyNTU4NDAzMzA2NAogIGJlbG93X3BjdF9vdmVyX3VzYWdlICA6IDAuMAoKT1ZFUkFMTAog
IGFib3ZlICAgICAgICAgICAgICAgICA6IDI4ODk4MTc0CiAgYmVsb3cgICAgICAgICAgICAg
ICAgIDogMTE1MTA3NzAKICB1c2FnZSAgICAgICAgICAgICAgICAgOiAxMTk2OTMyMzgKICB0
aW1lICAgICAgICAgICAgICAgICAgOiAyODcxMzkyNDgwNDIKICBhdmdfdGltZV91c19wZXJf
dXNhZ2UgOiAyMzk4Ljk1OTY0NzUxMTU4MjcKICBhYm92ZV9wY3Rfb3Zlcl91c2FnZSAgOiAy
NC4xNDM1MzA5ODIwOTI3MzgKICBiZWxvd19wY3Rfb3Zlcl91c2FnZSAgOiA5LjYxNjg5MjQ3
NjQxNTQxNwoK
--------------XrZ3nh6S3L265OUxkao1nDCK
Content-Type: text/plain; charset=UTF-8; name="diff_phoronix-sqlite.txt"
Content-Disposition: attachment; filename="diff_phoronix-sqlite.txt"
Content-Transfer-Encoding: base64

YmFkLWtlcm5lbDoKCmluZGV4MCBQT0xMICBsYXRlbmN5PTAgcmVzaWRlbmN5PTAgIGRlc2M9
J0NQVUlETEUgQ09SRSBQT0xMIElETEUnCiAgYWJvdmUgICAgICAgICAgICAgICAgIDogMAog
IGJlbG93ICAgICAgICAgICAgICAgICA6IDI2MAogIHVzYWdlICAgICAgICAgICAgICAgICA6
IDI2MgogIHRpbWUgICAgICAgICAgICAgICAgICA6IDY2MzQKICBhdmdfdGltZV91c19wZXJf
dXNhZ2UgOiAyNS4zMjA2MTA2ODcwMjI5CiAgYWJvdmVfcGN0X292ZXJfdXNhZ2UgIDogMC4w
CiAgYmVsb3dfcGN0X292ZXJfdXNhZ2UgIDogOTkuMjM2NjQxMjIxMzc0MDQKCmluZGV4MSBD
MSAgbGF0ZW5jeT0yIHJlc2lkZW5jeT0yICBkZXNjPSdNV0FJVCAweDAwJwogIGFib3ZlICAg
ICAgICAgICAgICAgICA6IDM5ODUKICBiZWxvdyAgICAgICAgICAgICAgICAgOiAzNTU4OAog
IHVzYWdlICAgICAgICAgICAgICAgICA6IDYyNzUxCiAgdGltZSAgICAgICAgICAgICAgICAg
IDogMjk3MjEzMQogIGF2Z190aW1lX3VzX3Blcl91c2FnZSA6IDQ3LjM2Mzg4MjY0NzI4ODQ5
CiAgYWJvdmVfcGN0X292ZXJfdXNhZ2UgIDogNi4zNTA0OTY0MDY0MzE3NwogIGJlbG93X3Bj
dF9vdmVyX3VzYWdlICA6IDU2LjcxMzA0MDQyOTYzNDU5CgppbmRleDIgQzFFICBsYXRlbmN5
PTEwIHJlc2lkZW5jeT0yMCAgZGVzYz0nTVdBSVQgMHgwMScKICBhYm92ZSAgICAgICAgICAg
ICAgICAgOiA3ODk2CiAgYmVsb3cgICAgICAgICAgICAgICAgIDogMTQzMwogIHVzYWdlICAg
ICAgICAgICAgICAgICA6IDI0OTQxCiAgdGltZSAgICAgICAgICAgICAgICAgIDogMjE4NTI0
MQogIGF2Z190aW1lX3VzX3Blcl91c2FnZSA6IDg3LjYxNjQxNDczODc4MzUzCiAgYWJvdmVf
cGN0X292ZXJfdXNhZ2UgIDogMzEuNjU4NzE0NTY2Mzc2NjUKICBiZWxvd19wY3Rfb3Zlcl91
c2FnZSAgOiA1Ljc0NTU1OTUyMDQ2ODMwNQoKaW5kZXgzIEMzICBsYXRlbmN5PTQwIHJlc2lk
ZW5jeT0xMDAgIGRlc2M9J01XQUlUIDB4MTAnCiAgYWJvdmUgICAgICAgICAgICAgICAgIDog
MAogIGJlbG93ICAgICAgICAgICAgICAgICA6IDAKICB1c2FnZSAgICAgICAgICAgICAgICAg
OiAwCiAgdGltZSAgICAgICAgICAgICAgICAgIDogMAogIGF2Z190aW1lX3VzX3Blcl91c2Fn
ZSA6IG5hbgogIGFib3ZlX3BjdF9vdmVyX3VzYWdlICA6IG5hbgogIGJlbG93X3BjdF9vdmVy
X3VzYWdlICA6IG5hbgoKaW5kZXg0IEM2ICBsYXRlbmN5PTEzMyByZXNpZGVuY3k9NDAwICBk
ZXNjPSdNV0FJVCAweDIwJwogIGFib3ZlICAgICAgICAgICAgICAgICA6IDExNTQzCiAgYmVs
b3cgICAgICAgICAgICAgICAgIDogMAogIHVzYWdlICAgICAgICAgICAgICAgICA6IDI0NDg5
CiAgdGltZSAgICAgICAgICAgICAgICAgIDogMTIzOTIwMTcyCiAgYXZnX3RpbWVfdXNfcGVy
X3VzYWdlIDogNTA2MC4yMzgxNDc3Mzk4MDEKICBhYm92ZV9wY3Rfb3Zlcl91c2FnZSAgOiA0
Ny4xMzU0NDg1Njg3NDUxNTQKICBiZWxvd19wY3Rfb3Zlcl91c2FnZSAgOiAwLjAKCk9WRVJB
TEwKICBhYm92ZSAgICAgICAgICAgICAgICAgOiAyMzQyNAogIGJlbG93ICAgICAgICAgICAg
ICAgICA6IDM3MjgxCiAgdXNhZ2UgICAgICAgICAgICAgICAgIDogMTEyNDQzCiAgdGltZSAg
ICAgICAgICAgICAgICAgIDogMTI5MDg0MTc4CiAgYXZnX3RpbWVfdXNfcGVyX3VzYWdlIDog
MTE0Ny45OTY1NjcxNDk1NzgKICBhYm92ZV9wY3Rfb3Zlcl91c2FnZSAgOiAyMC44MzE4ODgx
NTY2NjYwNDMKICBiZWxvd19wY3Rfb3Zlcl91c2FnZSAgOiAzMy4xNTU0NjU0MzU4MjA4MTUK
Cmdvb2Qta2VybmVsOgoKaW5kZXgwIFBPTEwgIGxhdGVuY3k9MCByZXNpZGVuY3k9MCAgZGVz
Yz0nQ1BVSURMRSBDT1JFIFBPTEwgSURMRScKICBhYm92ZSAgICAgICAgICAgICAgICAgOiAw
CiAgYmVsb3cgICAgICAgICAgICAgICAgIDogMjE4CiAgdXNhZ2UgICAgICAgICAgICAgICAg
IDogMjIwCiAgdGltZSAgICAgICAgICAgICAgICAgIDogNTU5NQogIGF2Z190aW1lX3VzX3Bl
cl91c2FnZSA6IDI1LjQzMTgxODE4MTgxODE4MwogIGFib3ZlX3BjdF9vdmVyX3VzYWdlICA6
IDAuMAogIGJlbG93X3BjdF9vdmVyX3VzYWdlICA6IDk5LjA5MDkwOTA5MDkwOTEKCmluZGV4
MSBDMSAgbGF0ZW5jeT0yIHJlc2lkZW5jeT0yICBkZXNjPSdNV0FJVCAweDAwJwogIGFib3Zl
ICAgICAgICAgICAgICAgICA6IDUyMTMKICBiZWxvdyAgICAgICAgICAgICAgICAgOiAzNDYw
MgogIHVzYWdlICAgICAgICAgICAgICAgICA6IDcwMjEyCiAgdGltZSAgICAgICAgICAgICAg
ICAgIDogMzI4ODA0MwogIGF2Z190aW1lX3VzX3Blcl91c2FnZSA6IDQ2LjgzMDIxNDIwODM5
NzQyCiAgYWJvdmVfcGN0X292ZXJfdXNhZ2UgIDogNy40MjQ2NTY3NTM4MzEyNTQKICBiZWxv
d19wY3Rfb3Zlcl91c2FnZSAgOiA0OS4yODIxNzM5ODczNTI1OQoKaW5kZXgyIEMxRSAgbGF0
ZW5jeT0xMCByZXNpZGVuY3k9MjAgIGRlc2M9J01XQUlUIDB4MDEnCiAgYWJvdmUgICAgICAg
ICAgICAgICAgIDogNTIzNwogIGJlbG93ICAgICAgICAgICAgICAgICA6IDE4MDYKICB1c2Fn
ZSAgICAgICAgICAgICAgICAgOiAzMDI3MwogIHRpbWUgICAgICAgICAgICAgICAgICA6IDQ4
MjU5NTAKICBhdmdfdGltZV91c19wZXJfdXNhZ2UgOiAxNTkuNDE0MzI5NjAwNjM0MjMKICBh
Ym92ZV9wY3Rfb3Zlcl91c2FnZSAgOiAxNy4yOTkyNDM1NTAzNTg0MDUKICBiZWxvd19wY3Rf
b3Zlcl91c2FnZSAgOiA1Ljk2NTcxMjAyMDYxMjQyNwoKaW5kZXgzIEMzICBsYXRlbmN5PTQw
IHJlc2lkZW5jeT0xMDAgIGRlc2M9J01XQUlUIDB4MTAnCiAgYWJvdmUgICAgICAgICAgICAg
ICAgIDogMAogIGJlbG93ICAgICAgICAgICAgICAgICA6IDAKICB1c2FnZSAgICAgICAgICAg
ICAgICAgOiAwCiAgdGltZSAgICAgICAgICAgICAgICAgIDogMAogIGF2Z190aW1lX3VzX3Bl
cl91c2FnZSA6IG5hbgogIGFib3ZlX3BjdF9vdmVyX3VzYWdlICA6IG5hbgogIGJlbG93X3Bj
dF9vdmVyX3VzYWdlICA6IG5hbgoKaW5kZXg0IEM2ICBsYXRlbmN5PTEzMyByZXNpZGVuY3k9
NDAwICBkZXNjPSdNV0FJVCAweDIwJwogIGFib3ZlICAgICAgICAgICAgICAgICA6IDIxMjAK
ICBiZWxvdyAgICAgICAgICAgICAgICAgOiAwCiAgdXNhZ2UgICAgICAgICAgICAgICAgIDog
MTE4MjQKICB0aW1lICAgICAgICAgICAgICAgICAgOiAxMjQ3NjI4MTMKICBhdmdfdGltZV91
c19wZXJfdXNhZ2UgOiAxMDU1MS42NTg3NDQ5MjU1NzUKICBhYm92ZV9wY3Rfb3Zlcl91c2Fn
ZSAgOiAxNy45Mjk2MzQ2NDE0MDczMDgKICBiZWxvd19wY3Rfb3Zlcl91c2FnZSAgOiAwLjAK
Ck9WRVJBTEwKICBhYm92ZSAgICAgICAgICAgICAgICAgOiAxMjU3MAogIGJlbG93ICAgICAg
ICAgICAgICAgICA6IDM2NjI2CiAgdXNhZ2UgICAgICAgICAgICAgICAgIDogMTEyNTI5CiAg
dGltZSAgICAgICAgICAgICAgICAgIDogMTMyODgyNDAxCiAgYXZnX3RpbWVfdXNfcGVyX3Vz
YWdlIDogMTE4MC44NzI0OTUwOTAxNTQ2CiAgYWJvdmVfcGN0X292ZXJfdXNhZ2UgIDogMTEu
MTcwNDUzODM4NTY2MDU4CiAgYmVsb3dfcGN0X292ZXJfdXNhZ2UgIDogMzIuNTQ4MDU0Mjc5
MzQxMzIKCg==

--------------XrZ3nh6S3L265OUxkao1nDCK--

