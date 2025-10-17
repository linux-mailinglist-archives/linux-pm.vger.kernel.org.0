Return-Path: <linux-pm+bounces-36369-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A645DBEB3F4
	for <lists+linux-pm@lfdr.de>; Fri, 17 Oct 2025 20:37:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A98874E121C
	for <lists+linux-pm@lfdr.de>; Fri, 17 Oct 2025 18:37:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5053032E126;
	Fri, 17 Oct 2025 18:37:28 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EED05231842;
	Fri, 17 Oct 2025 18:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760726248; cv=none; b=U7YFKNDOmPmW8n9KwKB9ltRyEJg3c5nA/tZA0Aoy2w5KEDZQ2R31vznC4WXz4YX3kTH225Gq7TzUQ0dPnsCoB959IxX5mXOIITy/p2qC+yrrhOFcybaEbspS8LDtHDrboonL49bIumB3rbZWXznKJ6Oj8ljGCmXvcPokN6SjZRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760726248; c=relaxed/simple;
	bh=V9nRtprV4Fy3L/RtjgTOBjGRXGt7eZgwB6iGwK71cSY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SwVxEd4mpJCGuP4vxjUWy7tRr2rP/Jrq7qq1OVR22b/hq8EQkGw1rf2/qsWPtZqWMY0d64LwQtAnhQejjWSU78BvRV+dYCTabkJxPAJWXHhJGUbJaGCXMd9hSdlKIorUmuANmOnhT9Z+3T22EGf124r4Oz4OK7zoaKBEU35AXjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 750591595;
	Fri, 17 Oct 2025 11:37:17 -0700 (PDT)
Received: from [10.1.35.23] (e127648.arm.com [10.1.35.23])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BAF653F6A8;
	Fri, 17 Oct 2025 11:37:23 -0700 (PDT)
Message-ID: <28ecb23b-ecee-409a-9771-24f801081d07@arm.com>
Date: Fri, 17 Oct 2025 19:37:21 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] cpuidle: governors: menu: Predict longer idle time
 when in doubt
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linux PM <linux-pm@vger.kernel.org>,
 Sergey Senozhatsky <senozhatsky@chromium.org>,
 LKML <linux-kernel@vger.kernel.org>,
 Artem Bityutskiy <artem.bityutskiy@linux.intel.com>,
 Tomasz Figa <tfiga@chromium.org>, Doug Smythies <dsmythies@telus.net>
References: <4687373.LvFx2qVVIh@rafael.j.wysocki>
 <5f0aa630-b30a-44c4-a52c-e08179cd3bf9@arm.com>
 <CAJZ5v0gBtv0bpK2swkc6D0AmanpKAvqO53dgRp2e7p9cWAM3TA@mail.gmail.com>
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <CAJZ5v0gBtv0bpK2swkc6D0AmanpKAvqO53dgRp2e7p9cWAM3TA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 10/17/25 10:39, Rafael J. Wysocki wrote:
> On Fri, Oct 17, 2025 at 10:22 AM Christian Loehle
> <christian.loehle@arm.com> wrote:
>>
>> On 10/16/25 17:25, Rafael J. Wysocki wrote:
>>> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>>
>>> It is reported that commit 85975daeaa4d ("cpuidle: menu: Avoid discarding
>>> useful information") led to a performance regression on Intel Jasper Lake
>>> systems because it reduced the time spent by CPUs in idle state C7 which
>>> is correlated to the maximum frequency the CPUs can get to because of an
>>> average running power limit [1].
>>> [snip]
>> [snip]
>> Anyway, the patch makes sense, let me run some tests and get back.
> 
> Thanks!

Unfortunately this patch regresses my tests about as much as a revert of
85975daeaa4d would.
(menu-1 is $SUBJECT, menu-m current mainline, menu-r mainline with
85975daeaa4d reverted):


device	 gov	 iter	 iops	 idles	 idle_misses	 idle_miss_ratio	 belows	 aboves	
mmcblk1 	menu-1 	0 	1523 	402522 	119988 	0.298 	98552 	21436
mmcblk1 	menu-1 	1 	1481 	395766 	118596 	0.300 	97640 	20956
mmcblk1 	menu-1 	2 	1503 	396560 	117876 	0.297 	97506 	20370
mmcblk1 	menu-m 	0 	2355 	703732 	22275 	0.032 	2628 	19647
mmcblk1 	menu-m 	1 	2359 	637522 	24815 	0.039 	4075 	20740
mmcblk1 	menu-m 	2 	2356 	706980 	23836 	0.034 	3208 	20628
mmcblk1 	menu-r 	0 	1490 	388180 	118294 	0.305 	97871 	20423
mmcblk1 	menu-r 	1 	1498 	393402 	119984 	0.305 	99187 	20797
mmcblk1 	menu-r 	2 	1462 	388597 	119504 	0.308 	98640 	20864
mmcblk2 	menu-1 	0 	3303 	503938 	170251 	0.338 	150276 	19975
mmcblk2 	menu-1 	1 	3310 	480508 	132132 	0.275 	114398 	17734
mmcblk2 	menu-1 	2 	3554 	466884 	113659 	0.243 	95841 	17818
mmcblk2 	menu-m 	0 	5746 	706262 	24618 	0.035 	3802 	20816
mmcblk2 	menu-m 	1 	5741 	727174 	24152 	0.033 	3737 	20415
mmcblk2 	menu-m 	2 	5777 	836940 	12424 	0.015 	335 	12089
mmcblk2 	menu-r 	0 	3241 	463112 	133052 	0.287 	114616 	18436
mmcblk2 	menu-r 	1 	3551 	422006 	100494 	0.238 	82425 	18069
mmcblk2 	menu-r 	2 	3523 	508542 	140085 	0.275 	122880 	17205
nvme0n1 	menu-1 	0 	5407 	436834 	74314 	0.170 	54133 	20181
nvme0n1 	menu-1 	1 	5763 	459510 	72673 	0.158 	51530 	21143
nvme0n1 	menu-1 	2 	6266 	489570 	78651 	0.161 	58609 	20042
nvme0n1 	menu-m 	0 	10786 	767740 	23840 	0.031 	2855 	20985
nvme0n1 	menu-m 	1 	10586 	757540 	23612 	0.031 	2933 	20679
nvme0n1 	menu-m 	2 	11805 	834012 	23528 	0.028 	2768 	20760
nvme0n1 	menu-r 	0 	5323 	431906 	77426 	0.179 	56166 	21260
nvme0n1 	menu-r 	1 	5484 	438142 	76033 	0.174 	55956 	20077
nvme0n1 	menu-r 	2 	5353 	428826 	77024 	0.180 	57016 	20008
sda 	menu-1 	0 	972 	444116 	149643 	0.337 	129023 	20620
sda 	menu-1 	1 	954 	557068 	176479 	0.317 	159092 	17387
sda 	menu-1 	2 	878 	540360 	196405 	0.363 	176792 	19613
sda 	menu-m 	0 	1634 	1017918 	29614 	0.029 	8587 	21027
sda 	menu-m 	1 	1622 	878140 	25323 	0.029 	8238 	17085
sda 	menu-m 	2 	1632 	1027167 	28798 	0.028 	8428 	20370
sda 	menu-r 	0 	918 	531112 	188314 	0.355 	168375 	19939
sda 	menu-r 	1 	924 	521378 	185727 	0.356 	165327 	20400
sda 	menu-r 	2 	880 	529146 	196391 	0.371 	176908 	19483
nullb0 	menu-1 	0 	101419 	88988 	23923 	0.269 	3080 	20843
nullb0 	menu-1 	1 	101610 	88484 	23678 	0.268 	2821 	20857
nullb0 	menu-1 	2 	101369 	89336 	23711 	0.265 	2795 	20916
nullb0 	menu-m 	0 	101696 	88698 	23860 	0.269 	2910 	20950
nullb0 	menu-m 	1 	101103 	88120 	23294 	0.264 	3295 	19999
nullb0 	menu-m 	2 	101880 	86676 	22730 	0.262 	2709 	20021
nullb0 	menu-r 	0 	101856 	87742 	23493 	0.268 	3204 	20289
nullb0 	menu-r 	1 	101514 	89070 	23653 	0.266 	2848 	20805
nullb0 	menu-r 	2 	101754 	86318 	23163 	0.268 	3229 	19934
mtdblock3 	menu-1 	0 	163 	350284 	115149 	0.329 	97166 	17983
mtdblock3 	menu-1 	1 	179 	315948 	99038 	0.313 	78243 	20795
mtdblock3 	menu-1 	2 	134 	481584 	160754 	0.334 	144150 	16604
mtdblock3 	menu-m 	0 	215 	410034 	70261 	0.171 	55445 	14816
mtdblock3 	menu-m 	1 	205 	570150 	109273 	0.192 	90189 	19084
mtdblock3 	menu-m 	2 	252 	866616 	23492 	0.027 	9717 	13775
mtdblock3 	menu-r 	0 	132 	467365 	161835 	0.346 	144056 	17779
mtdblock3 	menu-r 	1 	164 	348682 	117704 	0.338 	97859 	19845
mtdblock3 	menu-r 	2 	132 	483300 	165179 	0.342 	147164 	18015



