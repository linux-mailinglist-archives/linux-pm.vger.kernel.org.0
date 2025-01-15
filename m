Return-Path: <linux-pm+bounces-20491-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9711AA12688
	for <lists+linux-pm@lfdr.de>; Wed, 15 Jan 2025 15:52:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 32D293A6839
	for <lists+linux-pm@lfdr.de>; Wed, 15 Jan 2025 14:52:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40EEE86351;
	Wed, 15 Jan 2025 14:52:22 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A77818614E;
	Wed, 15 Jan 2025 14:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736952742; cv=none; b=TyV/3Is3H6ib5N18oud1GL9aa5/PIFX7lgrtuxTwmzidZ8uOFWitTAmsqRn6UvEcI9jsxyTI3DOAeqEmnLIyIMaTw8g4LzfEM0JfzbdpVlJAoL/IoBEdwmy39UekODi8gdLgVDNaGr3PtUo/qU4ee6URNJ44n6SCmaiBGpM0qNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736952742; c=relaxed/simple;
	bh=CXqKq8LESK2Jdu1Yoemz1VAZWrWfJ+Mj0iDuepPgBLk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Cm2/JgkTDLPMdgMb3NTsJhC+lQkQf2w9IdAmrSrfvnxCS59smjYhvUXptobPbF+f+k13z3aJSQjiz7gZ9xGBVm5dsf0sHPkbJrYvzWonJ+nI9/5eQwoA0sjf5hlQootdH+gxU/uOwKPNNeNE7MRXuCtHn2LMW5of+rwyDAW7eGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7BC6C11FB;
	Wed, 15 Jan 2025 06:52:47 -0800 (PST)
Received: from [10.1.38.43] (e127648.arm.com [10.1.38.43])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 980203F73F;
	Wed, 15 Jan 2025 06:52:17 -0800 (PST)
Message-ID: <d095149c-fb76-40e8-a459-05e4d2e50cf5@arm.com>
Date: Wed, 15 Jan 2025 14:52:15 +0000
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 0/9] cpuidle: teo: Cleanups and very frequent wakeups
 handling update
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Linux PM <linux-pm@vger.kernel.org>,
 Aboorva Devarajan <aboorvad@linux.ibm.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
References: <6116275.lOV4Wx5bFT@rjwysocki.net>
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <6116275.lOV4Wx5bFT@rjwysocki.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/13/25 18:32, Rafael J. Wysocki wrote:
> Hi Everyone,
> 
> This supersedes
> 
> https://lore.kernel.org/linux-pm/4953183.GXAFRqVoOG@rjwysocki.net/
> 
> but because the majority of patches in it are new, I've decided to count
> version numbers back from 1.
> 
> This addresses a relatively recently added inconsistency in behavior of the teo
> governor regarding the handling of very frequent wakeups handling (patch [7/9])
> and makes some other changes that may be regarded as cleanups.
> 
> Please review.

Hi Rafael,
that looks promising. I'll review the individual patches in detail now, but
I let a few tests run overnight and can report that there's no significant
behaviour change with the series on an arm64 (no polling state, rk3399), which
is my expected result.

I'll get something running on a system with a polling state as well.
(I don't have a POWER system, so that will just be x86, adding Aboorva.)

Tested-by: Christian Loehle <christian.loehle@arm.com>
for the entire series

I'll just dump some of the raw results here for reference.
teo-X is teo with everything up to X/9 applied. teo-m is mainline, teo is
the entire series (equivalent to teo-9).

Everything is done with fio direct random4k read. Range of real devices
with varying latency, mapper/slow is 51ms timer delay, nullb0 is
essentially CPU-bound, few intercepts expected.
--

device	 gov	 iter	 iops	 idles	 idle_misses	 idle_miss_ratio	 belows	 aboves	
mmcblk1 	menu 	0 	1284 	344126 	106309 	0.309 	89264 	17045
mmcblk1 	menu 	1 	1340 	358646 	109469 	0.305 	91726 	17743
mmcblk1 	menu 	2 	1316 	348812 	106773 	0.306 	89845 	16928
mmcblk1 	teo 	0 	2023 	559551 	30053 	0.054 	2962 	27091
mmcblk1 	teo 	1 	2007 	548422 	25816 	0.047 	2113 	23703
mmcblk1 	teo 	2 	2010 	557120 	29434 	0.053 	2782 	26652
mmcblk1 	teo-m 	0 	2010 	542790 	23336 	0.043 	1720 	21616
mmcblk1 	teo-m 	1 	2009 	554912 	29239 	0.053 	2750 	26489
mmcblk1 	teo-m 	2 	2013 	548384 	26444 	0.048 	2180 	24264
mmcblk1 	teo-1 	0 	2030 	524056 	3571 	0.007 	610 	2961
mmcblk1 	teo-1 	1 	2022 	559304 	27074 	0.048 	3373 	23701
mmcblk1 	teo-1 	2 	2009 	554744 	27406 	0.049 	2964 	24442
mmcblk1 	teo-2 	0 	2012 	542886 	18233 	0.034 	2140 	16093
mmcblk1 	teo-2 	1 	2010 	554094 	27680 	0.050 	2957 	24723
mmcblk1 	teo-2 	2 	2010 	555222 	28549 	0.051 	3085 	25464
mmcblk1 	teo-3 	0 	2011 	556816 	28708 	0.052 	3076 	25632
mmcblk1 	teo-3 	1 	2015 	546998 	20280 	0.037 	2414 	17866
mmcblk1 	teo-3 	2 	2020 	549758 	20802 	0.038 	2662 	18140
mmcblk1 	teo-4 	0 	2026 	536464 	11692 	0.022 	1457 	10235
mmcblk1 	teo-4 	1 	2031 	557978 	25464 	0.046 	2928 	22536
mmcblk1 	teo-4 	2 	2012 	553812 	26323 	0.048 	2943 	23380
mmcblk1 	teo-5 	0 	2021 	557966 	3454 	0.006 	3003 	451
mmcblk1 	teo-5 	1 	2027 	546630 	18400 	0.034 	2303 	16097
mmcblk1 	teo-5 	2 	2012 	554390 	28013 	0.051 	2990 	25023
mmcblk1 	teo-6 	0 	2037 	539956 	12764 	0.024 	1701 	11063
mmcblk1 	teo-6 	1 	2019 	556202 	29074 	0.052 	3071 	26003
mmcblk1 	teo-6 	2 	2017 	555004 	26814 	0.048 	2869 	23945
mmcblk1 	teo-7 	0 	2028 	545802 	23806 	0.044 	1625 	22181
mmcblk1 	teo-7 	1 	2019 	557030 	29913 	0.054 	2990 	26923
mmcblk1 	teo-7 	2 	2018 	553236 	28534 	0.052 	2657 	25877
mmcblk1 	teo-8 	0 	2018 	554662 	28595 	0.052 	2660 	25935
mmcblk1 	teo-8 	1 	2014 	554646 	28947 	0.052 	2721 	26226
mmcblk1 	teo-8 	2 	2014 	543828 	29379 	0.054 	2915 	26464
mmcblk1 	teo-9 	0 	2013 	555356 	28867 	0.052 	2719 	26148
mmcblk1 	teo-9 	1 	2015 	557254 	29709 	0.053 	2836 	26873
mmcblk1 	teo-9 	2 	2030 	559272 	29321 	0.052 	3052 	26269
mmcblk2 	menu 	0 	2885 	434990 	140864 	0.324 	123507 	17357
mmcblk2 	menu 	1 	2766 	450918 	152931 	0.339 	135384 	17547
mmcblk2 	menu 	2 	2960 	407712 	125573 	0.308 	109224 	16349
mmcblk2 	teo 	0 	5677 	741006 	24131 	0.033 	2233 	21898
mmcblk2 	teo 	1 	5652 	714494 	24412 	0.034 	2680 	21732
mmcblk2 	teo 	2 	5660 	752410 	20497 	0.027 	1809 	18688
mmcblk2 	teo-m 	0 	5683 	855232 	23454 	0.027 	1934 	21520
mmcblk2 	teo-m 	1 	5588 	517234 	32016 	0.062 	5443 	26573
mmcblk2 	teo-m 	2 	5654 	668648 	29108 	0.044 	3171 	25937
mmcblk2 	teo-1 	0 	5666 	773452 	25740 	0.033 	3430 	22310
mmcblk2 	teo-1 	1 	5638 	668190 	27619 	0.041 	4150 	23469
mmcblk2 	teo-1 	2 	5689 	866340 	28191 	0.033 	3122 	25069
mmcblk2 	teo-2 	0 	5769 	859462 	2116 	0.002 	1835 	281
mmcblk2 	teo-2 	1 	5577 	611956 	25490 	0.042 	8647 	16843
mmcblk2 	teo-2 	2 	5665 	721308 	25826 	0.036 	2876 	22950
mmcblk2 	teo-3 	0 	5677 	805946 	30345 	0.038 	3877 	26468
mmcblk2 	teo-3 	1 	5752 	855840 	14392 	0.017 	2588 	11804
mmcblk2 	teo-3 	2 	5740 	825580 	27403 	0.033 	3750 	23653
mmcblk2 	teo-4 	0 	5664 	777848 	3435 	0.004 	3229 	206
mmcblk2 	teo-4 	1 	5660 	728926 	25796 	0.035 	2871 	22925
mmcblk2 	teo-4 	2 	5689 	774342 	7844 	0.010 	2838 	5006
mmcblk2 	teo-5 	0 	5672 	781618 	2733 	0.003 	2551 	182
mmcblk2 	teo-5 	1 	5693 	866530 	28658 	0.033 	3332 	25326
mmcblk2 	teo-5 	2 	5687 	837294 	12172 	0.015 	2338 	9834
mmcblk2 	teo-6 	0 	5859 	892798 	5226 	0.006 	3566 	1660
mmcblk2 	teo-6 	1 	5696 	864197 	24962 	0.029 	2796 	22166
mmcblk2 	teo-6 	2 	5671 	788200 	26612 	0.034 	3157 	23455
mmcblk2 	teo-7 	0 	5617 	525864 	30143 	0.057 	3739 	26404
mmcblk2 	teo-7 	1 	5732 	802794 	25553 	0.032 	3240 	22313
mmcblk2 	teo-7 	2 	5838 	858620 	12661 	0.015 	188 	12473
mmcblk2 	teo-8 	0 	5696 	780894 	24440 	0.031 	2928 	21512
mmcblk2 	teo-8 	1 	5868 	862794 	12978 	0.015 	187 	12791
mmcblk2 	teo-8 	2 	5607 	660124 	31632 	0.048 	6728 	24904
mmcblk2 	teo-9 	0 	5652 	669318 	28330 	0.042 	2692 	25638
mmcblk2 	teo-9 	1 	5657 	710892 	29291 	0.041 	3233 	26058
mmcblk2 	teo-9 	2 	5594 	740988 	37086 	0.050 	10275 	26811
nvme0n1 	menu 	0 	4775 	384186 	70675 	0.184 	54346 	16329
nvme0n1 	menu 	1 	5211 	409374 	69545 	0.170 	53484 	16061
nvme0n1 	menu 	2 	7213 	535088 	81312 	0.152 	64253 	17059
nvme0n1 	teo 	0 	10655 	754882 	29476 	0.039 	2960 	26516
nvme0n1 	teo 	1 	10627 	755322 	29324 	0.039 	3011 	26313
nvme0n1 	teo 	2 	10559 	749498 	29850 	0.040 	3265 	26585
nvme0n1 	teo-m 	0 	10353 	738802 	29937 	0.041 	2996 	26941
nvme0n1 	teo-m 	1 	10629 	748148 	27076 	0.036 	2349 	24727
nvme0n1 	teo-m 	2 	10477 	743256 	28193 	0.038 	2645 	25548
nvme0n1 	teo-1 	0 	10947 	772905 	24896 	0.032 	3150 	21746
nvme0n1 	teo-1 	1 	10412 	732894 	21868 	0.030 	2423 	19445
nvme0n1 	teo-1 	2 	10530 	748377 	26338 	0.035 	3479 	22859
nvme0n1 	teo-2 	0 	10570 	751961 	5195 	0.007 	2853 	2342
nvme0n1 	teo-2 	1 	10482 	732428 	18667 	0.025 	2102 	16565
nvme0n1 	teo-2 	2 	10829 	768292 	26400 	0.034 	3189 	23211
nvme0n1 	teo-3 	0 	10493 	746638 	26371 	0.035 	3320 	23051
nvme0n1 	teo-3 	1 	10445 	742924 	27871 	0.038 	3027 	24844
nvme0n1 	teo-3 	2 	10920 	775112 	25646 	0.033 	3520 	22126
nvme0n1 	teo-4 	0 	10500 	734792 	18125 	0.025 	2283 	15842
nvme0n1 	teo-4 	1 	11091 	783828 	25904 	0.033 	3031 	22873
nvme0n1 	teo-4 	2 	10413 	736248 	23786 	0.032 	2660 	21126
nvme0n1 	teo-5 	0 	10479 	744340 	26933 	0.036 	3096 	23837
nvme0n1 	teo-5 	1 	10740 	764188 	27065 	0.035 	3062 	24003
nvme0n1 	teo-5 	2 	10500 	747060 	25962 	0.035 	3233 	22729
nvme0n1 	teo-6 	0 	10715 	757772 	2186 	0.003 	1872 	314
nvme0n1 	teo-6 	1 	10485 	734878 	17620 	0.024 	2174 	15446
nvme0n1 	teo-6 	2 	10478 	744106 	26909 	0.036 	3007 	23902
nvme0n1 	teo-7 	0 	10549 	750022 	30416 	0.041 	3320 	27096
nvme0n1 	teo-7 	1 	10611 	752182 	29877 	0.040 	3332 	26545
nvme0n1 	teo-7 	2 	11170 	791572 	30790 	0.039 	3453 	27337
nvme0n1 	teo-8 	0 	10622 	752523 	29002 	0.039 	2745 	26257
nvme0n1 	teo-8 	1 	10424 	739904 	28641 	0.039 	2756 	25885
nvme0n1 	teo-8 	2 	10533 	731440 	22101 	0.030 	1280 	20821
nvme0n1 	teo-9 	0 	10367 	727768 	24895 	0.034 	1820 	23075
nvme0n1 	teo-9 	1 	10815 	766230 	29378 	0.038 	3136 	26242
nvme0n1 	teo-9 	2 	10426 	739224 	28173 	0.038 	2563 	25610
sda 	menu 	0 	872 	526240 	175645 	0.334 	159373 	16272
sda 	menu 	1 	900 	536434 	188122 	0.351 	170749 	17373
sda 	menu 	2 	901 	534826 	189778 	0.355 	171745 	18033
sda 	teo 	0 	1687 	999108 	16015 	0.016 	1249 	14766
sda 	teo 	1 	1668 	1007551 	31316 	0.031 	5809 	25507
sda 	teo 	2 	1682 	985830 	18784 	0.019 	1003 	17781
sda 	teo-m 	0 	1676 	969984 	25825 	0.027 	3191 	22634
sda 	teo-m 	1 	1682 	995266 	30340 	0.030 	4040 	26300
sda 	teo-m 	2 	1681 	940562 	20830 	0.022 	1508 	19322
sda 	teo-1 	0 	1680 	996214 	15553 	0.016 	2192 	13361
sda 	teo-1 	1 	1674 	1050168 	28033 	0.027 	4011 	24022
sda 	teo-1 	2 	1665 	808202 	35292 	0.044 	8873 	26419
sda 	teo-2 	0 	1689 	1013360 	546 	0.001 	243 	303
sda 	teo-2 	1 	1672 	1033806 	29432 	0.028 	4363 	25069
sda 	teo-2 	2 	1667 	1046100 	31110 	0.030 	6395 	24715
sda 	teo-3 	0 	1625 	922694 	40891 	0.044 	22925 	17966
sda 	teo-3 	1 	1670 	894480 	27946 	0.031 	3045 	24901
sda 	teo-3 	2 	1658 	1009366 	28514 	0.028 	8887 	19627
sda 	teo-4 	0 	1674 	977280 	3605 	0.004 	3279 	326
sda 	teo-4 	1 	1677 	960990 	2861 	0.003 	1058 	1803
sda 	teo-4 	2 	1660 	1016592 	33894 	0.033 	7687 	26207
sda 	teo-5 	0 	1678 	1033470 	16996 	0.016 	2163 	14833
sda 	teo-5 	1 	1667 	873077 	25011 	0.029 	4393 	20618
sda 	teo-5 	2 	1672 	1042020 	24589 	0.024 	3858 	20731
sda 	teo-6 	0 	1680 	962686 	7255 	0.008 	1797 	5458
sda 	teo-6 	1 	1682 	1055472 	28602 	0.027 	5081 	23521
sda 	teo-6 	2 	1675 	989244 	19110 	0.019 	5620 	13490
sda 	teo-7 	0 	1618 	1001000 	51178 	0.051 	26011 	25167
sda 	teo-7 	1 	1666 	1047310 	34032 	0.032 	6520 	27512
sda 	teo-7 	2 	1676 	982046 	28788 	0.029 	2836 	25952
sda 	teo-8 	0 	1618 	975930 	52929 	0.054 	26386 	26543
sda 	teo-8 	1 	1678 	1023796 	16182 	0.016 	2191 	13991
sda 	teo-8 	2 	1633 	981693 	43520 	0.044 	18782 	24738
sda 	teo-9 	0 	1661 	1029494 	32423 	0.031 	5855 	26568
sda 	teo-9 	1 	1678 	969400 	17843 	0.018 	2763 	15080
sda 	teo-9 	2 	1679 	1055060 	32288 	0.031 	5607 	26681
mtdblock3 	menu 	0 	180 	278442 	80547 	0.289 	65714 	14833
mtdblock3 	menu 	1 	167 	379840 	109168 	0.287 	93460 	15708
mtdblock3 	menu 	2 	155 	373948 	126262 	0.338 	107799 	18463
mtdblock3 	teo 	0 	256 	663190 	29333 	0.044 	4836 	24497
mtdblock3 	teo 	1 	257 	808114 	29394 	0.036 	2742 	26652
mtdblock3 	teo 	2 	257 	456150 	25812 	0.057 	2468 	23344
mtdblock3 	teo-m 	0 	257 	624492 	24678 	0.040 	2326 	22352
mtdblock3 	teo-m 	1 	256 	734548 	31165 	0.042 	4307 	26858
mtdblock3 	teo-m 	2 	257 	812004 	30479 	0.038 	3510 	26969
mtdblock3 	teo-1 	0 	253 	759708 	34146 	0.045 	10081 	24065
mtdblock3 	teo-1 	1 	254 	730160 	23105 	0.032 	7156 	15949
mtdblock3 	teo-1 	2 	253 	721558 	32848 	0.046 	10028 	22820
mtdblock3 	teo-2 	0 	257 	666426 	4948 	0.007 	782 	4166
mtdblock3 	teo-2 	1 	256 	682046 	25126 	0.037 	4886 	20240
mtdblock3 	teo-2 	2 	253 	639950 	36029 	0.056 	11074 	24955
mtdblock3 	teo-3 	0 	252 	709122 	37198 	0.052 	12603 	24595
mtdblock3 	teo-3 	1 	257 	709680 	30000 	0.042 	3670 	26330
mtdblock3 	teo-3 	2 	254 	540408 	32696 	0.061 	9035 	23661
mtdblock3 	teo-4 	0 	256 	442356 	28281 	0.064 	3785 	24496
mtdblock3 	teo-4 	1 	254 	588362 	16934 	0.029 	5663 	11271
mtdblock3 	teo-4 	2 	257 	628776 	28300 	0.045 	3667 	24633
mtdblock3 	teo-5 	0 	250 	762594 	43008 	0.056 	16752 	26256
mtdblock3 	teo-5 	1 	256 	586098 	29744 	0.051 	4035 	25709
mtdblock3 	teo-5 	2 	262 	903736 	375 	0.000 	139 	236
mtdblock3 	teo-6 	0 	250 	795274 	42742 	0.054 	17160 	25582
mtdblock3 	teo-6 	1 	256 	800172 	28195 	0.035 	4016 	24179
mtdblock3 	teo-6 	2 	257 	523365 	26260 	0.050 	2788 	23472
mtdblock3 	teo-7 	0 	261 	944626 	31616 	0.033 	5090 	26526
mtdblock3 	teo-7 	1 	258 	647048 	28997 	0.045 	2728 	26269
mtdblock3 	teo-7 	2 	260 	901858 	18521 	0.021 	3698 	14823
mtdblock3 	teo-8 	0 	256 	914076 	27272 	0.030 	6844 	20428
mtdblock3 	teo-8 	1 	256 	809113 	31696 	0.039 	4672 	27024
mtdblock3 	teo-8 	2 	252 	798396 	40223 	0.050 	13270 	26953
mtdblock3 	teo-9 	0 	259 	726886 	30515 	0.042 	4002 	26513
mtdblock3 	teo-9 	1 	262 	892854 	9411 	0.011 	1686 	7725
mtdblock3 	teo-9 	2 	259 	909528 	16583 	0.018 	3054 	13529
nullb0 	menu 	0 	107364 	86086 	20668 	0.240 	2604 	18064
nullb0 	menu 	1 	107701 	85072 	20251 	0.238 	2808 	17443
nullb0 	menu 	2 	107976 	85178 	20591 	0.242 	3063 	17528
nullb0 	teo 	0 	105758 	84464 	28872 	0.342 	3429 	25443
nullb0 	teo 	1 	106892 	87122 	30255 	0.347 	3722 	26533
nullb0 	teo 	2 	107080 	83374 	27911 	0.335 	2918 	24993
nullb0 	teo-m 	0 	107702 	88337 	29824 	0.338 	2956 	26868
nullb0 	teo-m 	1 	108218 	88130 	29710 	0.337 	3038 	26672
nullb0 	teo-m 	2 	106993 	86866 	30033 	0.346 	3664 	26369
nullb0 	teo-1 	0 	106416 	82936 	23635 	0.285 	3186 	20449
nullb0 	teo-1 	1 	107570 	87425 	27682 	0.317 	3220 	24462
nullb0 	teo-1 	2 	107832 	75656 	19434 	0.257 	2775 	16659
nullb0 	teo-2 	0 	106320 	88182 	28603 	0.324 	3213 	25390
nullb0 	teo-2 	1 	107316 	79968 	21643 	0.271 	3081 	18562
nullb0 	teo-2 	2 	108007 	84018 	25244 	0.300 	3034 	22210
nullb0 	teo-3 	0 	106989 	85160 	24558 	0.288 	3601 	20957
nullb0 	teo-3 	1 	107325 	83582 	24994 	0.299 	2963 	22031
nullb0 	teo-3 	2 	107063 	77066 	18978 	0.246 	2913 	16065
nullb0 	teo-4 	0 	107990 	86156 	25012 	0.290 	3404 	21608
nullb0 	teo-4 	1 	107352 	75750 	15096 	0.199 	2671 	12425
nullb0 	teo-4 	2 	107685 	87644 	26047 	0.297 	3825 	22222
nullb0 	teo-5 	0 	106687 	87788 	13428 	0.153 	2937 	10491
nullb0 	teo-5 	1 	107820 	86442 	25703 	0.297 	3686 	22017
nullb0 	teo-5 	2 	108319 	81498 	22895 	0.281 	2713 	20182
nullb0 	teo-6 	0 	107784 	84364 	24239 	0.287 	3459 	20780
nullb0 	teo-6 	1 	108762 	83854 	24017 	0.286 	3289 	20728
nullb0 	teo-6 	2 	106024 	88238 	27778 	0.315 	3253 	24525
nullb0 	teo-7 	0 	106041 	86354 	30076 	0.348 	3420 	26656
nullb0 	teo-7 	1 	108039 	79564 	26805 	0.337 	2924 	23881
nullb0 	teo-7 	2 	107389 	88264 	30713 	0.348 	3156 	27557
nullb0 	teo-8 	0 	106465 	87924 	29679 	0.338 	2958 	26721
nullb0 	teo-8 	1 	107215 	81348 	27038 	0.332 	2916 	24122
nullb0 	teo-8 	2 	108238 	87070 	29284 	0.336 	2971 	26313
nullb0 	teo-9 	0 	107220 	84508 	28894 	0.342 	3411 	25483
nullb0 	teo-9 	1 	107400 	86920 	29945 	0.345 	3579 	26366
nullb0 	teo-9 	2 	107845 	87686 	30439 	0.347 	3784 	26655
mapper/dm-slow 	menu 	0 	19 	85216 	20060 	0.235 	2478 	17582
mapper/dm-slow 	teo 	0 	19 	86454 	28959 	0.335 	2860 	26099
mapper/dm-slow 	teo-m 	0 	19 	84740 	28056 	0.331 	2582 	25474
mapper/dm-slow 	teo-1 	0 	19 	88698 	28945 	0.326 	3210 	25735
mapper/dm-slow 	teo-2 	0 	19 	83138 	24326 	0.293 	2589 	21737
mapper/dm-slow 	teo-3 	0 	19 	86416 	27274 	0.316 	2998 	24276
mapper/dm-slow 	teo-4 	0 	19 	89286 	29369 	0.329 	3151 	26218
mapper/dm-slow 	teo-5 	0 	19 	88516 	29213 	0.330 	3163 	26050
mapper/dm-slow 	teo-6 	0 	19 	87896 	24675 	0.281 	3113 	21562
mapper/dm-slow 	teo-7 	0 	19 	83986 	27976 	0.333 	2788 	25188
mapper/dm-slow 	teo-8 	0 	19 	88072 	29667 	0.337 	2962 	26705
mapper/dm-slow 	teo-9 	0 	19 	87260 	29428 	0.337 	2923 	26505

