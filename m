Return-Path: <linux-pm+bounces-22357-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D56FA3AA9D
	for <lists+linux-pm@lfdr.de>; Tue, 18 Feb 2025 22:17:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E33D168A09
	for <lists+linux-pm@lfdr.de>; Tue, 18 Feb 2025 21:17:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D09881B87F2;
	Tue, 18 Feb 2025 21:17:36 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 797DC286280;
	Tue, 18 Feb 2025 21:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739913456; cv=none; b=syO/ZFF6v0L/p9Of6oHOb+hyjP/OtaXhuH/Ic8jIJf2BWEdBIxJWOrGMmaX+Tk0TD8XtjLjK4mlhfNUwEFeBASbTyfAi5sHP0L+lzDxVL+xbrgC4JOfcKXLn580noCnSoOzWLbmwL8TY+Fuh5ODgA2E/mlBj5hiGKzDdQ/0oINY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739913456; c=relaxed/simple;
	bh=gIWLMTWQStsTMfIIrvNQerDA++3RMMceHCkPSPWs/Zk=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=c/0au0FY3ts9shjOSssufTCtzfukfudq0sEPjCYFT7wkod2L0FKpI2xpXWvdacC0lm0HgxpSv1V1Qc31qdYLrjctXAHg8Cj/XYgpUAGZ6AFdeBQ/FbQ8iJMFk9YUfns8zGPvj4f8BwfMiamb1Nxz6dbsOTJfJrztObxxINtbTEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 32317152B;
	Tue, 18 Feb 2025 13:17:51 -0800 (PST)
Received: from [10.57.78.2] (unknown [10.57.78.2])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 898B43F5A1;
	Tue, 18 Feb 2025 13:17:30 -0800 (PST)
Message-ID: <1d713fe5-485b-4aeb-a279-13fce93692fc@arm.com>
Date: Tue, 18 Feb 2025 21:17:27 +0000
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFT][PATCH v1 0/5] cpuidle: menu: Avoid discarding useful
 information when processing recent idle intervals
From: Christian Loehle <christian.loehle@arm.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Linux PM <linux-pm@vger.kernel.org>, dsmythies@telus.net
Cc: LKML <linux-kernel@vger.kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Artem Bityutskiy <artem.bityutskiy@linux.intel.com>,
 Aboorva Devarajan <aboorvad@linux.ibm.com>
References: <1916668.tdWV9SEqCh@rjwysocki.net>
 <bd69d9dc-0494-4975-bebd-881f3560e659@arm.com>
Content-Language: en-US
In-Reply-To: <bd69d9dc-0494-4975-bebd-881f3560e659@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/10/25 14:15, Christian Loehle wrote:
> On 2/6/25 14:21, Rafael J. Wysocki wrote:
>> Hi Everyone,
>>
>> This work had been triggered by a report that commit 0611a640e60a ("eventpoll:
>> prefer kfree_rcu() in __ep_remove()") had caused the critical-jOPS metric of
>> the SPECjbb 2015 benchmark [1] to drop by around 50% even though it generally
>> reduced kernel overhead.  Indeed, it was found during further investigation
>> that the total interrupt rate while running the SPECjbb workload had fallen as
>> a result of that commit by 55% and the local timer interrupt rate had fallen by
>> almost 80%.
>>
>> That turned out to cause the menu cpuidle governor to select the deepest idle
>> state supplied by the cpuidle driver (intel_idle) much more often which added
>> significantly more idle state latency to the workload and that led to the
>> decrease of the critical-jOPS score.
>>
>> Interestingly enough, this problem was not visible when the teo cpuidle
>> governor was used instead of menu, so it appeared to be specific to the
>> latter.  CPU wakeup event statistics collected while running the workload
>> indicated that the menu governor was effectively ignoring non-timer wakeup
>> information and all of its idle state selection decisions appeared to be
>> based on timer wakeups only.  Thus, it appeared that the reduction of the
>> local timer interrupt rate caused the governor to predict a idle duration
>> much more often while running the workload and the deepest idle state was
>> selected significantly more often as a result of that.
>>
>> A subsequent inspection of the get_typical_interval() function in the menu
>> governor indicated that it might return UINT_MAX too often which then caused
>> the governor's decisions to be based entirely on information related to timers.
>>
>> Generally speaking, UINT_MAX is returned by get_typical_interval() if it
>> cannot make a prediction based on the most recent idle intervals data with
>> sufficiently high confidence, but at least in some cases this means that
>> useful information is not taken into account at all which may lead to
>> significant idle state selection mistakes.  Moreover, this is not really
>> unlikely to happen.
>>
>> One issue with get_typical_interval() is that, when it eliminates outliers from
>> the sample set in an attempt to reduce the standard deviation (and so improve
>> the prediction confidence), it does that by dropping high-end samples only,
>> while samples at the low end of the set are retained.  However, the samples
>> at the low end very well may be the outliers and they should be eliminated
>> from the sample set instead of the high-end samples.  Accordingly, the
>> likelihood of making a meaningful idle duration prediction can be improved
>> by making it also eliminate low-end samples if they are farther from the
>> average than high-end samples.  This is done in patch [4/5].
>>
>> Another issue is that get_typical_interval() gives up after eliminating 1/4
>> of the samples if the standard deviation is still not as low as desired (within
>> 1/6 of the average or within 20 us if the average is close to 0), but the
>> remaining samples in the set still represent useful information at that point
>> and discarding them altogether may lead to suboptimal idle state selection.
>>
>> For instance, the largest idle duration value in the get_typical_interval()
>> data set is the maximum idle duration observed recently and it is likely that
>> the upcoming idle duration will not exceed it.  Therefore, in the absence of
>> a better choice, this value can be used as an upper bound on the target
>> residency of the idle state to select.  Patch [5/5] works along these lines,
>> but it takes the maximum data point remaining after the elimination of
>> outliers.
>>
>> The first two patches in the series are straightforward cleanups (in fact,
>> the first patch is kind of reversed by patch [4/5], but it is there because
>> it can be applied without the latter) and patch [3/5] is a cosmetic change
>> made in preparation for the subsequent ones.
>>
>> This series turns out to restore the SPECjbb critical-jOPS metric on affected
>> systems to the level from before commit 0611a640e60a and it also happens to
>> increase its max-jOPS metric by around 3%.
>>
>> For easier reference/testing it is present in the git branch at
>>
>> https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git/log/?h=experimental/menu
>>
>> based on the cpuidle material that went into 6.14-rc1.
>>
>> If possible, please let me know if it works for you.
>>
>> Thanks!
>>
>>
>> [1] Link: https://www.spec.org/jbb2015/

Another dump for x86 idle this time, tldr: no worrying idle/power numbers

teo 	0 	121.76 	12202 	813 	0.067 	390 	423
teo 	1 	158.53 	8223 	536 	0.065 	328 	208
teo 	2 	219.37 	8373 	527 	0.063 	294 	233
teo 	3 	220.7 	8241 	538 	0.065 	340 	198
teo 	4 	211.8 	7923 	442 	0.056 	268 	174
menu 	0 	151.63 	8185 	326 	0.040 	308 	18
menu 	1 	183.45 	8873 	364 	0.041 	334 	30
menu 	2 	171.96 	8633 	380 	0.044 	369 	11
menu 	3 	164.95 	8451 	358 	0.042 	330 	28
menu 	4 	175.87 	8273 	340 	0.041 	317 	23
menu-1 	0 	119.77 	9041 	394 	0.044 	356 	38
menu-1 	1 	145.73 	8603 	335 	0.039 	293 	42
menu-1 	2 	157.89 	8345 	321 	0.038 	276 	45
menu-1 	3 	119.13 	8447 	346 	0.041 	290 	56
menu-1 	4 	142.77 	8331 	331 	0.040 	312 	19
menu-2 	0 	159.81 	8653 	342 	0.040 	296 	46
menu-2 	1 	165.01 	8421 	307 	0.036 	282 	25
menu-2 	2 	225.06 	8647 	376 	0.043 	317 	59
menu-2 	3 	232.13 	8095 	358 	0.044 	325 	33
menu-2 	4 	150.79 	8231 	323 	0.039 	299 	24
menu-3 	0 	168.87 	8153 	355 	0.044 	330 	25
menu-3 	1 	187.68 	9143 	405 	0.044 	338 	67
menu-3 	2 	129.77 	9705 	384 	0.040 	301 	83
menu-3 	3 	152.49 	9679 	469 	0.048 	374 	95
menu-3 	4 	131.0 	9077 	321 	0.035 	283 	38
menu-4 	0 	116.68 	9107 	373 	0.041 	333 	40
menu-4 	1 	164.1 	8655 	297 	0.034 	287 	10
menu-4 	2 	157.52 	8009 	300 	0.037 	297 	3
menu-4 	3 	138.47 	8567 	345 	0.040 	341 	4
menu-4 	4 	130.84 	8027 	324 	0.040 	316 	8
menu-5 	0 	139.77 	8533 	327 	0.038 	317 	10
menu-5 	1 	157.22 	9127 	433 	0.047 	373 	60
menu-5 	2 	144.54 	8313 	329 	0.040 	311 	18
menu-5 	3 	151.55 	8675 	316 	0.036 	301 	15
menu-5 	4 	137.49 	8823 	354 	0.040 	336 	18
menu 	0 	128.97 	8383 	329 	0.039 	284 	45
menu 	1 	141.97 	8945 	402 	0.045 	344 	58
menu 	2 	88.16 	8829 	368 	0.042 	307 	61
menu 	3 	81.49 	9165 	430 	0.047 	371 	59
menu 	4 	107.58 	9193 	401 	0.044 	335 	66
teo 	0 	149.28 	8399 	521 	0.062 	287 	234
teo 	1 	105.61 	8717 	563 	0.065 	306 	257
teo 	2 	116.65 	7893 	550 	0.070 	284 	266
teo 	3 	119.57 	8259 	489 	0.059 	282 	207
teo 	4 	187.64 	7897 	471 	0.060 	303 	168

And the rk3399 numbers as promised, just like rk3588 we see much better
IO performance (menu-5) without significant worse idle decisions:

device	 gov	 iter	 iops	 idles	 idle_misses	 idle_miss_ratio	 belows	 aboves	
mapper/dm-slow 	teo 	0 	461 	102980 	32260 	0.313 	6036 	26224
mapper/dm-slow 	teo 	1 	461 	100698 	31149 	0.309 	5796 	25353
mapper/dm-slow 	teo 	2 	461 	100346 	32840 	0.327 	6022 	26818
mapper/dm-slow 	teo 	3 	461 	98450 	31513 	0.320 	5129 	26384
mapper/dm-slow 	teo 	4 	461 	98689 	29982 	0.304 	3937 	26045
mapper/dm-slow 	menu 	0 	461 	97860 	22520 	0.230 	5505 	17015
mapper/dm-slow 	menu 	1 	461 	98002 	20858 	0.213 	3596 	17262
mapper/dm-slow 	menu 	2 	461 	100046 	22523 	0.225 	5333 	17190
mapper/dm-slow 	menu 	3 	461 	95020 	20827 	0.219 	4069 	16758
mapper/dm-slow 	menu 	4 	461 	98040 	22302 	0.227 	5498 	16804
mapper/dm-slow 	menu-1 	0 	461 	98186 	20648 	0.210 	3210 	17438
mapper/dm-slow 	menu-1 	1 	461 	94360 	20297 	0.215 	4184 	16113
mapper/dm-slow 	menu-1 	2 	461 	98818 	21680 	0.219 	4750 	16930
mapper/dm-slow 	menu-1 	3 	461 	97822 	20605 	0.211 	3469 	17136
mapper/dm-slow 	menu-1 	4 	461 	100748 	21740 	0.216 	4403 	17337
mapper/dm-slow 	menu-2 	0 	461 	94388 	20289 	0.215 	3449 	16840
mapper/dm-slow 	menu-2 	1 	460 	89124 	18897 	0.212 	2401 	16496
mapper/dm-slow 	menu-2 	2 	461 	94932 	20692 	0.218 	2949 	17743
mapper/dm-slow 	menu-2 	3 	461 	95270 	20612 	0.216 	3048 	17564
mapper/dm-slow 	menu-2 	4 	461 	101954 	23493 	0.230 	5978 	17515
mapper/dm-slow 	menu-3 	0 	461 	98452 	21161 	0.215 	4247 	16914
mapper/dm-slow 	menu-3 	1 	461 	100342 	21035 	0.210 	3891 	17144
mapper/dm-slow 	menu-3 	2 	461 	101156 	23322 	0.231 	5924 	17398
mapper/dm-slow 	menu-3 	3 	461 	98052 	20862 	0.213 	3927 	16935
mapper/dm-slow 	menu-3 	4 	461 	97746 	20977 	0.215 	3706 	17271
mapper/dm-slow 	menu-4 	0 	461 	99826 	23727 	0.238 	5055 	18672
mapper/dm-slow 	menu-4 	1 	461 	101686 	24859 	0.244 	5175 	19684
mapper/dm-slow 	menu-4 	2 	461 	99934 	23568 	0.236 	4477 	19091
mapper/dm-slow 	menu-4 	3 	461 	97298 	22142 	0.228 	3644 	18498
mapper/dm-slow 	menu-4 	4 	461 	98546 	24023 	0.244 	5086 	18937
mapper/dm-slow 	menu-5 	0 	461 	100545 	22833 	0.227 	3830 	19003
mapper/dm-slow 	menu-5 	1 	461 	100827 	23999 	0.238 	5217 	18782
mapper/dm-slow 	menu-5 	2 	461 	97044 	22628 	0.233 	2910 	19718
mapper/dm-slow 	menu-5 	3 	461 	100234 	23303 	0.232 	4819 	18484
mapper/dm-slow 	menu-5 	4 	461 	102358 	24488 	0.239 	4770 	19718
mapper/dm-slow 	menu 	0 	461 	97008 	21114 	0.218 	4540 	16574
mapper/dm-slow 	menu 	1 	461 	96088 	21470 	0.223 	3650 	17820
mapper/dm-slow 	menu 	2 	461 	99008 	21019 	0.212 	3405 	17614
mapper/dm-slow 	menu 	3 	461 	96608 	20145 	0.209 	3729 	16416
mapper/dm-slow 	menu 	4 	461 	83152 	17469 	0.210 	2426 	15043
mapper/dm-slow 	teo 	0 	461 	99340 	32077 	0.323 	5772 	26305
mapper/dm-slow 	teo 	1 	461 	98694 	29426 	0.298 	3585 	25841
mapper/dm-slow 	teo 	2 	461 	100294 	29810 	0.297 	3561 	26249
mapper/dm-slow 	teo 	3 	461 	98726 	29496 	0.299 	3644 	25852
mapper/dm-slow 	teo 	4 	461 	101424 	32654 	0.322 	6029 	26625
mmcblk1 	teo 	0 	2016 	559362 	29994 	0.054 	2896 	27098
mmcblk1 	teo 	1 	2037 	562153 	30001 	0.053 	3171 	26830
mmcblk1 	teo 	2 	2016 	557360 	30185 	0.054 	2986 	27199
mmcblk1 	menu 	0 	1279 	335364 	103600 	0.309 	87662 	15938
mmcblk1 	menu 	1 	1292 	342036 	105446 	0.308 	89031 	16415
mmcblk1 	menu 	2 	1294 	352954 	108588 	0.308 	90420 	18168
mmcblk1 	menu-1 	0 	1271 	331220 	103163 	0.311 	87602 	15561
mmcblk1 	menu-1 	1 	1291 	350084 	108982 	0.311 	90670 	18312
mmcblk1 	menu-1 	2 	1284 	346412 	107494 	0.310 	89899 	17595
mmcblk1 	menu-2 	0 	1306 	344316 	106253 	0.309 	89650 	16603
mmcblk1 	menu-2 	1 	1278 	345684 	107893 	0.312 	90292 	17601
mmcblk1 	menu-2 	2 	1268 	334528 	104494 	0.312 	88457 	16037
mmcblk1 	menu-3 	0 	1270 	333456 	104160 	0.312 	88392 	15768
mmcblk1 	menu-3 	1 	1273 	338328 	105477 	0.312 	88798 	16679
mmcblk1 	menu-3 	2 	1280 	337002 	104623 	0.310 	88516 	16107
mmcblk1 	menu-4 	0 	1311 	344896 	104192 	0.302 	87051 	17141
mmcblk1 	menu-4 	1 	1292 	343878 	106459 	0.310 	88297 	18162
mmcblk1 	menu-4 	2 	1286 	340172 	105502 	0.310 	87753 	17749
mmcblk1 	menu-5 	0 	2006 	550266 	24981 	0.045 	6762 	18219
mmcblk1 	menu-5 	1 	1997 	553590 	26974 	0.049 	6955 	20019
mmcblk1 	menu-5 	2 	1994 	539494 	17652 	0.033 	3903 	13749
mmcblk2 	teo 	0 	5691 	820134 	29346 	0.036 	3078 	26268
mmcblk2 	teo 	1 	5684 	856976 	23202 	0.027 	1908 	21294
mmcblk2 	teo 	2 	5783 	824666 	13984 	0.017 	3938 	10046
mmcblk2 	menu 	0 	2770 	433474 	144860 	0.334 	127466 	17394
mmcblk2 	menu 	1 	3308 	367848 	89597 	0.244 	72668 	16929
mmcblk2 	menu 	2 	2882 	422844 	133523 	0.316 	117170 	16353
mmcblk2 	menu-1 	0 	3323 	394674 	115764 	0.293 	99328 	16436
mmcblk2 	menu-1 	1 	2778 	420262 	139538 	0.332 	122356 	17182
mmcblk2 	menu-1 	2 	2895 	400774 	124841 	0.311 	109572 	15269
mmcblk2 	menu-2 	0 	2679 	429818 	148494 	0.345 	131513 	16981
mmcblk2 	menu-2 	1 	3162 	363888 	96102 	0.264 	79200 	16902
mmcblk2 	menu-2 	2 	2684 	422324 	144606 	0.342 	128528 	16078
mmcblk2 	menu-3 	0 	2953 	392124 	118629 	0.303 	101068 	17561
mmcblk2 	menu-3 	1 	3003 	402614 	120567 	0.299 	103321 	17246
mmcblk2 	menu-3 	2 	2858 	422576 	136118 	0.322 	119485 	16633
mmcblk2 	menu-4 	0 	3288 	436860 	118566 	0.271 	100329 	18237
mmcblk2 	menu-4 	1 	3062 	462484 	139897 	0.302 	121424 	18473
mmcblk2 	menu-4 	2 	3257 	424458 	115493 	0.272 	97739 	17754
mmcblk2 	menu-5 	0 	5316 	573050 	52502 	0.092 	33285 	19217
mmcblk2 	menu-5 	1 	5446 	825538 	44073 	0.053 	24355 	19718
mmcblk2 	menu-5 	2 	5292 	796000 	52828 	0.066 	38640 	14188
nvme0n1 	teo 	0 	11371 	807338 	29879 	0.037 	2961 	26918
nvme0n1 	teo 	1 	11557 	815682 	29116 	0.036 	2947 	26169
nvme0n1 	teo 	2 	11424 	810108 	29800 	0.037 	2953 	26847
nvme0n1 	menu 	0 	7754 	574116 	93148 	0.162 	76482 	16666
nvme0n1 	menu 	1 	8371 	618954 	95502 	0.154 	77657 	17845
nvme0n1 	menu 	2 	5111 	412030 	73440 	0.178 	55997 	17443
nvme0n1 	menu-1 	0 	6628 	506618 	91832 	0.181 	71427 	20405
nvme0n1 	menu-1 	1 	4923 	390294 	68772 	0.176 	52880 	15892
nvme0n1 	menu-1 	2 	5015 	396160 	68840 	0.174 	52867 	15973
nvme0n1 	menu-2 	0 	7883 	589296 	97497 	0.165 	79635 	17862
nvme0n1 	menu-2 	1 	6465 	493796 	81561 	0.165 	64629 	16932
nvme0n1 	menu-2 	2 	5363 	430614 	75499 	0.175 	57528 	17971
nvme0n1 	menu-3 	0 	5090 	415018 	74191 	0.179 	56015 	18176
nvme0n1 	menu-3 	1 	4919 	401452 	71994 	0.179 	54457 	17537
nvme0n1 	menu-3 	2 	5183 	413186 	74199 	0.180 	57542 	16657
nvme0n1 	menu-4 	0 	5402 	424860 	67413 	0.159 	49399 	18014
nvme0n1 	menu-4 	1 	5343 	420538 	67713 	0.161 	49826 	17887
nvme0n1 	menu-4 	2 	9151 	669840 	107892 	0.161 	87774 	20118
nvme0n1 	menu-5 	0 	10475 	741376 	20204 	0.027 	1827 	18377
nvme0n1 	menu-5 	1 	10603 	747262 	19228 	0.026 	1489 	17739
nvme0n1 	menu-5 	2 	11658 	824996 	22954 	0.028 	2631 	20323
sda 	teo 	0 	2328 	1334552 	48960 	0.037 	20922 	28038
sda 	teo 	1 	2328 	1267840 	37740 	0.030 	11934 	25806
sda 	teo 	2 	2394 	1360679 	21853 	0.016 	3394 	18459
sda 	menu 	0 	1004 	587054 	 198775 	0.339 	184002 	14773
sda 	menu 	1 	1205 	663838 	 209623 	0.316 	193325 	16298
sda 	menu 	2 	1117 	615382 	 208813 	0.339 	191893 	16920
sda 	menu-1 	0 	1103 	627838 	 212955 	0.339 	195703 	17252
sda 	menu-1 	1 	1024 	611658 	 221754 	0.363 	203710 	18044
sda 	menu-1 	2 	1209 	639008 	 180597 	0.283 	163837 	16760
sda 	menu-2 	0 	1200 	655398 	 205664 	0.314 	190750 	14914
sda 	menu-2 	1 	1100 	582222 	 201983 	0.347 	185874 	16109
sda 	menu-2 	2 	1124 	602988 	 199623 	0.331 	183798 	15825
sda 	menu-3 	0 	1089 	612112 	 211470 	0.345 	195156 	16314
sda 	menu-3 	1 	1077 	613556 	 213484 	0.348 	196839 	16645
sda 	menu-3 	2 	1157 	636904 	 195439 	0.307 	179535 	15904
sda 	menu-4 	0 	1126 	643468 	 208132 	0.323 	189334 	18798
sda 	menu-4 	1 	1112 	634480 	 216012 	0.340 	196841 	19171
sda 	menu-4 	2 	1190 	594398 	 196059 	0.330 	176190 	19869
sda 	menu-5 	0 	2074 	1134718 	81294 	0.072 	61820 	19474
sda 	menu-5 	1 	2179 	1249056 	76679 	0.061 	55461 	21218
sda 	menu-5 	2 	2075 	1183214 	124075 	0.105 	101650 	22425
nullb0 	teo 	0 	104833 	85906 	29085 	0.339 	3409 	25676
nullb0 	teo 	1 	103787 	88419 	29833 	0.337 	2980 	26853
nullb0 	teo 	2 	104611 	86284 	29390 	0.341 	3315 	26075
nullb0 	menu 	0 	103671 	87146 	20514 	0.235 	2643 	17871
nullb0 	menu 	1 	104380 	70086 	16855 	0.240 	1642 	15213
nullb0 	menu 	2 	103249 	81414 	19403 	0.238 	2274 	17129
nullb0 	menu-1 	0 	103424 	86984 	20448 	0.235 	2617 	17831
nullb0 	menu-1 	1 	103857 	85658 	20840 	0.243 	2544 	18296
nullb0 	menu-1 	2 	103907 	86644 	20639 	0.238 	2586 	18053
nullb0 	menu-2 	0 	103668 	82558 	20053 	0.243 	2655 	17398
nullb0 	menu-2 	1 	104277 	86914 	20472 	0.236 	2593 	17879
nullb0 	menu-2 	2 	103697 	82952 	20221 	0.244 	2410 	17811
nullb0 	menu-3 	0 	103696 	86534 	20782 	0.240 	2968 	17814
nullb0 	menu-3 	1 	103996 	81902 	19795 	0.242 	2773 	17022
nullb0 	menu-3 	2 	103790 	82474 	20058 	0.243 	2344 	17714
nullb0 	menu-4 	0 	103288 	87475 	22688 	0.259 	2596 	20092
nullb0 	menu-4 	1 	103848 	70906 	18106 	0.255 	1557 	16549
nullb0 	menu-4 	2 	104141 	84528 	22147 	0.262 	2969 	19178
nullb0 	menu-5 	0 	103812 	79234 	17989 	0.227 	1302 	16687
nullb0 	menu-5 	1 	104334 	87752 	22878 	0.261 	2511 	20367
nullb0 	menu-5 	2 	104059 	88681 	22765 	0.257 	3030 	19735
mtdblock3 	teo 	0 	257 	604294 	17359 	0.029 	3241 	14118
mtdblock3 	teo 	1 	256 	332344 	31631 	0.095 	4644 	26987
mtdblock3 	teo 	2 	257 	549736 	29559 	0.054 	2841 	26718
mtdblock3 	menu 	0 	148 	417388 	134505 	0.322 	118487 	16018
mtdblock3 	menu 	1 	137 	422132 	149336 	0.354 	132655 	16681
mtdblock3 	menu 	2 	194 	223808 	59631 	0.266 	43076 	16555
mtdblock3 	menu-1 	0 	145 	529186 	143789 	0.272 	129433 	14356
mtdblock3 	menu-1 	1 	147 	452302 	140418 	0.310 	125009 	15409
mtdblock3 	menu-1 	2 	138 	415152 	146470 	0.353 	130607 	15863
mtdblock3 	menu-2 	0 	155 	365750 	118483 	0.324 	102676 	15807
mtdblock3 	menu-2 	1 	165 	316818 	101968 	0.322 	85597 	16371
mtdblock3 	menu-2 	2 	143 	515664 	126014 	0.244 	115854 	10160
mtdblock3 	menu-3 	0 	135 	488188 	150917 	0.309 	136442 	14475
mtdblock3 	menu-3 	1 	125 	437774 	158893 	0.363 	143319 	15574
mtdblock3 	menu-3 	2 	138 	433332 	152457 	0.352 	135017 	17440
mtdblock3 	menu-4 	0 	173 	314250 	101648 	0.323 	81511 	20137
mtdblock3 	menu-4 	1 	149 	489030 	139551 	0.285 	124126 	15425
mtdblock3 	menu-4 	2 	148 	381488 	133543 	0.350 	115885 	17658
mtdblock3 	menu-5 	0 	222 	430158 	63885 	0.149 	45240 	18645
mtdblock3 	menu-5 	1 	218 	752248 	80500 	0.107 	66453 	14047
mtdblock3 	menu-5 	2 	203 	528828 	105885 	0.200 	89573 	1631

And finally a longer firefox youtube 4k playback (10mins) on x86:
device	 gov	 iter	 Joules	 idles	 idle_misses	 idle_miss_ratio	 belows	 aboves	
menu 	0 	1064.48 	357559 	106048 	0.297 	105920 	128
menu 	1 	1029.85 	345569 	104050 	0.301 	103938 	112
menu 	2 	1105.93 	347105 	104958 	0.302 	104885 	73
menu 	3 	1085.86 	347365 	106061 	0.305 	106001 	60
menu 	4 	1115.24 	352609 	107913 	0.306 	107812 	101
menu-5 	0 	1139.09 	345827 	90172 	0.261 	89609 	563
menu-5 	1 	1111.58 	335521 	88953 	0.265 	88904 	49
menu-5 	2 	1093.73 	328645 	85949 	0.262 	85839 	110
menu-5 	3 	1036.69 	330547 	86163 	0.261 	86077 	86
menu-5 	4 	1117.31 	316143 	81707 	0.258 	81580 	127
menu 	0 	1099.72 	353895 	106574 	0.301 	106523 	51
menu 	1 	1148.44 	357867 	107578 	0.301 	107369 	209
menu 	2 	1098.15 	341957 	101995 	0.298 	101870 	125
menu 	3 	1124.41 	350423 	105592 	0.301 	105481 	111
menu 	4 	1185.94 	366799 	111132 	0.303 	111029 	103
menu-5 	0 	1129.85 	332413 	86991 	0.262 	86885 	106
menu-5 	1 	1086.59 	318221 	82020 	0.258 	81924 	96
menu-5 	2 	1063.5  	320273 	83099 	0.259 	83048 	51
menu-5 	3 	1070.7  	331179 	85998 	0.260 	85839 	159
menu-5 	4 	1067.82 	322689 	83634 	0.259 	83548 	86

Significantly improving idle miss belows.

I'll do the Android tests, but that is very unlikely to show something this
doesn't (there's only one non-WFI idle state and most workloads are intercept
heavy, so if anything menu-5 should improve the overall situation.)
Feel free to already add:
Tested-by: Christian Loehle <christian.loehle@arm.com>

