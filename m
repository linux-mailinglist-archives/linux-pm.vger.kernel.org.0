Return-Path: <linux-pm+bounces-24435-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A536FA6CE7E
	for <lists+linux-pm@lfdr.de>; Sun, 23 Mar 2025 10:18:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C02393A98C0
	for <lists+linux-pm@lfdr.de>; Sun, 23 Mar 2025 09:18:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34B10201021;
	Sun, 23 Mar 2025 09:18:46 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1E5A1754B;
	Sun, 23 Mar 2025 09:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742721526; cv=none; b=Eb4J/OlNPJjPpjs5dZUt6Ae8CJXsDGI0GO9MxZvmiMtEp8xcu9Zdry5KnD9kslU2jM1P2v1Oc+QDMWQXIIfBUv7varBiDc18o7h8ieamNDe4MDZa1aPQfNS0RNgvJ/B6JJnJX5ecfKH/wXOBmiGVOOsZkOF1nIaLQHnCZ+vDjUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742721526; c=relaxed/simple;
	bh=5HZmLzce4L9XeAcPttemnSzWQxYapG6GBhfDbqgHz10=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RqU3joL5eo6CjOG/88/9gvhib74ssDnDJm6634WPT7Xv5vAGwOjXxKoXgtltcKPAnQPiY2kcnhechGyh02ymhQG6gIn3PnlFRnZIx/B5NyHW0/mAcYBl4zzCwxpymGTjFGFDcfliw2pxQHmfvqDPnMkyUb+sm+dqXwd7DkD9/So=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B9DDE106F;
	Sun, 23 Mar 2025 02:18:41 -0700 (PDT)
Received: from [10.57.41.149] (unknown [10.57.41.149])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4888E3F63F;
	Sun, 23 Mar 2025 02:18:33 -0700 (PDT)
Message-ID: <1e870bd8-0e13-4e0d-bbe9-e9f601f59a50@arm.com>
Date: Sun, 23 Mar 2025 09:18:30 +0000
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cpuidle: psd: add power sleep demotion prevention for
 fast I/O devices
To: "King, Colin" <colin.king@intel.com>, Jens Axboe <axboe@kernel.dk>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <33882f284ac6e6d1ec766ca4bb2f3b88@intel.com>
 <f18607ca-30dc-43de-be77-fec69968aeec@arm.com>
 <SJ2PR11MB7670F63C7052C88637D305DF8DDF2@SJ2PR11MB7670.namprd11.prod.outlook.com>
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <SJ2PR11MB7670F63C7052C88637D305DF8DDF2@SJ2PR11MB7670.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/17/25 10:03, King, Colin wrote:
> Hi Christian, 
> 
> Follow-up below:
> 
>> -----Original Message-----
>> From: Christian Loehle <christian.loehle@arm.com>
>> Sent: 03 March 2025 22:25
>> To: King, Colin <colin.king@intel.com>; Jens Axboe <axboe@kernel.dk>; Rafael
>> J. Wysocki <rafael@kernel.org>; Daniel Lezcano <daniel.lezcano@linaro.org>;
>> linux-block@vger.kernel.org; linux-pm@vger.kernel.org
>> Cc: linux-kernel@vger.kernel.org
>> Subject: Re: [PATCH] cpuidle: psd: add power sleep demotion prevention for
>> fast I/O devices
>>
>> On 3/3/25 16:43, Colin Ian King wrote:
>>> Modern processors can drop into deep sleep states relatively quickly
>>> to save power. However, coming out of deep sleep states takes a small
>>> amount of time and this is detrimental to performance for I/O devices
>>> such as fast PCIe NVME drives when servicing a completed I/O
>>> transactions.
>>>
>>> Testing with fio with read/write RAID0 PCIe NVME devices on various
>>> modern SMP based systems (such as 96 thead Granite Rapids Xeon 6741P)
>>> has shown that on 85-90% of read/write transactions issued on a CPU
>>> are completed by the same CPU, so it makes some sense to prevent the
>>> CPU from dropping into a deep sleep state to help reduce I/O handling
>>> latency.
>>
>> For the platform you tested on that may be true, but even if we constrain
>> ourselves to pci-nvme there's a variety of queue/irq mappings where this
>> doesn't hold I'm afraid.
> 
> This code is optional, one can enable it or disable it via the config option. Also, 
> even when it is built-in one can disable it by writing 0 to the sysfs file
>   /sys/devices/system/cpu/cpuidle/psd_cpu_lat_timeout_ms
> 
>>
>>>
>>> This commit introduces a simple, lightweight and fast power sleep
>>> demotion mechanism that provides the block layer a way to inform the
>>> menu governor to prevent a CPU from going into a deep sleep when an
>>> I/O operation is requested. While it is true that some I/Os may not
>>
>> s/requested/completed is the full truth, isn't it?
>>
>>> be serviced on the same CPU that issued the I/O request and hence is
>>> not 100% perfect the mechanism does work well in the vast majority of
>>> I/O operations and there is very small overhead with the sleep
>>> demotion prevention.
>>>
>>> Test results on a 96 thread Xeon 6741P with a 6 way RAID0 PCIe NVME md
>>> array using fio 3.35 performing random read and read-write test on a
>>> 512GB file with 8 concurrent I/O jobs. Tested with the
>>> NHM_C1_AUTO_DEMOTE bit set in MSR_PKG_CST_CONFIG_CONTROL set in
>> the BIOS.
>>>
>>> Test case: random reads, results based on geometic mean of results
>>> from
>>> 5 test runs:
>>>            Bandwidth         IO-ops   Latency   Bandwidth
>>>            read (bytes/sec)  per sec    (ns)    % Std.Deviation
>>> Baseline:  21365755610	     20377     390105   1.86%
>>> Patched:   25950107558       24748     322905   0.16%
>>
>> What is the baseline?
>> Do you mind trying with Rafael's recently posted series?
>> Given the IOPS I'd expect good results from that alone already.
>> https://lore.kernel.org/lkml/1916668.tdWV9SEqCh@rjwysocki.net/
>>
>> (Happy to see teo as comparison too, which you don't modify).
> 
> OK, I re-ran the tests on 6.14-rc5 on the same H/W. The "Baseline" is 6.14-rc5 without
> Raphel's patch. I also testing the Baseline with C6 and C6P disabled as this stops deeper
> C-state sleeps and in theory should provide "best performance". I also benchmarked with
> Raphel's patch and just my patch, and finally Raphels patch AND my patch:
> 
> Reads
>                         Bandwidth       Bandwidth       latency         latency
>                         Bytes/sec       %Std.Dev.       nanosecs        %Std.Dev.
> Baseline                25689182477     0.15            326177          0.15
> C6, C6P disabled        25839580014     0.19            324349          0.19
> Raphels Patch:          25695523747     0.06            326150          0.06
> My patch:               25782011833     0.07            324999          0.07
> Raphel + My patch:      25792551514     0.10            324924          0.10

So these are mostly equal right?

> 
> Writes
>                         Bandwidth       Bandwidth       latency         latency
>                         Bytes/sec       %Std.Dev.       nanosecs        %Std.Dev.
> Baseline                15220468898     3.33            550290          3.36
> C6, C6P disabled        13405624707     0.66            625424          0.66
> Raphels Patch:          14017625200     1.15            598049          1.16
> My patch:               15444417488     3.73            467818          29.10
> Raphel + My patch:      14037711032     1.13            597143          1.13

These don't make sense to me, why would C6 / C6P be this bad?
Why would Rafael's patch make it worse?
Are these just noise?

> 
> Combined Read+Writes, Reads
> 
>                         Bandwidth       Bandwidth       latency         latency
>                         Bytes/sec       %Std.Dev.       nanosecs        %Std.Dev.
> Baseline                10132229433     0.41            484919          0.25
> C6, C6P disabled        10567536346     0.60            515260          1.16
> Raphels Patch:          10171044817     0.37            486937          0.20
> My patch:               10468953527     0.07            504797          0.07
> Raphel + My patch:      10174707546     1.26            488263          1.13
> 
> Combined Read+Writes, Writes
> 
>                         Bandwidth       Bandwidth       latency         latency
>                         Bytes/sec       %Std.Dev.       nanosecs        %Std.Dev.
> Baseline                10139393169     0.44            342132          1.23
> C6, C6P disabled        10583264662     0.63            277052          3.87
> Raphels Patch:          10178275035     0.39            336989          0.94
> My patch:               10482766569     1.28            294803          6.87
> Raphel + My patch:      10183837235     0.38            330657          3.39      

The above two indicate a +3% from (now mainline) Rafael's patch to yours.
There's no reason why Rafael + your patch should be worse than just your patch.
If this is statistically significant we would need to look into why.

FWIW I think the energy cost of essentially remaining in polling even for quite
sporadic IO can't be understated IMO.
Comparison for teo, which might slightly better than menu while not outright
disabling idle would be interesting still.




