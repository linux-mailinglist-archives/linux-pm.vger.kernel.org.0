Return-Path: <linux-pm+bounces-24707-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AAFCAA77EAD
	for <lists+linux-pm@lfdr.de>; Tue,  1 Apr 2025 17:15:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D42B167E93
	for <lists+linux-pm@lfdr.de>; Tue,  1 Apr 2025 15:15:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A23B1BD9E3;
	Tue,  1 Apr 2025 15:15:12 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90ED62080C7;
	Tue,  1 Apr 2025 15:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743520512; cv=none; b=kwwYMPgdUeKEacWKE7Q/6HtcO5neFtCgUUEAU1qEg6lE3NGs6Kb0mpKqmOQXDFTxxXSCJPSJQIgGSnoSe34FUdutpEasXQEqqJwTbFKS1r0ueA24Nvxajxipar8/hg7xCbENlYs3NH9bZ1JtdGEC2c7qLy+RN3MQMvf2SDQsBg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743520512; c=relaxed/simple;
	bh=rwl5oV58wmFMXgEw4y5Os/5OTv1cLl8IW2Vh6yov/Z8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=G6FWWQ+/CBxym+x1kDgDOSKctQuSlzQaBSBzDqg85RKmwPO2rPfoUWeXB8nCZg1t67rYo01VzU1X+DBuS+OCEF6xK5MX6dDcElkZj7SgKBGXmNQ4qo7wQ5Yh4O8Yqr+iEwRwnGa1Zg2CnNY1JFJyhM2qY+z42CIBijcC2jG6oJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 46F3014BF;
	Tue,  1 Apr 2025 08:15:13 -0700 (PDT)
Received: from [10.57.40.234] (unknown [10.57.40.234])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 624673F694;
	Tue,  1 Apr 2025 08:15:08 -0700 (PDT)
Message-ID: <743b3472-e1a4-4fdc-ac2d-6e74c51022c4@arm.com>
Date: Tue, 1 Apr 2025 16:15:06 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cpuidle: psd: add power sleep demotion prevention for
 fast I/O devices
To: "King, Colin" <colin.king@intel.com>, Bart Van Assche
 <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <33882f284ac6e6d1ec766ca4bb2f3b88@intel.com>
 <f18607ca-30dc-43de-be77-fec69968aeec@arm.com>
 <SJ2PR11MB7670F63C7052C88637D305DF8DDF2@SJ2PR11MB7670.namprd11.prod.outlook.com>
 <1ae51ccc-66cc-4551-b649-2f5883e2f5a2@acm.org>
 <SJ2PR11MB7670B2AEFF7C0DABE6856F258DA62@SJ2PR11MB7670.namprd11.prod.outlook.com>
 <ad852ef9-5207-4b70-8834-2db6aa5e1a51@arm.com>
 <SJ2PR11MB7670E05E066CCC16AFEA16A18DAC2@SJ2PR11MB7670.namprd11.prod.outlook.com>
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <SJ2PR11MB7670E05E066CCC16AFEA16A18DAC2@SJ2PR11MB7670.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/1/25 16:03, King, Colin wrote:
> Hi,
> 
> Reply at end..
> 
>> -----Original Message-----
>> From: Christian Loehle <christian.loehle@arm.com>
>> Sent: 26 March 2025 16:27
>> To: King, Colin <colin.king@intel.com>; Bart Van Assche
>> <bvanassche@acm.org>; Jens Axboe <axboe@kernel.dk>; Rafael J. Wysocki
>> <rafael@kernel.org>; Daniel Lezcano <daniel.lezcano@linaro.org>; linux-
>> block@vger.kernel.org; linux-pm@vger.kernel.org
>> Cc: linux-kernel@vger.kernel.org
>> Subject: Re: [PATCH] cpuidle: psd: add power sleep demotion prevention for
>> fast I/O devices
>>
>> On 3/26/25 15:04, King, Colin wrote:
>>> Hi,
>>>
>>>> -----Original Message-----
>>>> From: Bart Van Assche <bvanassche@acm.org>
>>>> Sent: 23 March 2025 12:36
>>>> To: King, Colin <colin.king@intel.com>; Christian Loehle
>>>> <christian.loehle@arm.com>; Jens Axboe <axboe@kernel.dk>; Rafael J.
>>>> Wysocki <rafael@kernel.org>; Daniel Lezcano
>>>> <daniel.lezcano@linaro.org>; linux-block@vger.kernel.org;
>>>> linux-pm@vger.kernel.org
>>>> Cc: linux-kernel@vger.kernel.org
>>>> Subject: Re: [PATCH] cpuidle: psd: add power sleep demotion
>>>> prevention for fast I/O devices
>>>>
>>>> On 3/17/25 3:03 AM, King, Colin wrote:
>>>>> This code is optional, one can enable it or disable it via the
>>>>> config option. Also, even when it is built-in one can disable it by
>>>>> writing 0 to the
>>>> sysfs file
>>>>>    /sys/devices/system/cpu/cpuidle/psd_cpu_lat_timeout_ms
>>>>
>>>> I'm not sure we need even more configuration knobs in sysfs.
>>>
>>> It's useful for enabling / disabling the functionality, as well as some form of
>> tuning for slower I/O devices, so I think it is justifiable.
>>>
>>>> How are users
>>>> expected to find this configuration option? How should they decide
>>>> whether to enable or to disable it?
>>>
>>> I can send a V2 with some documentation if that's required.
>>>
>>>>
>>>> Please take a look at this proposal and let me know whether this
>>>> would solve the issue that you are looking into: "[LSF/MM/BPF Topic]
>> Energy- Efficient I/O"
>>>> (https://lore.kernel.org/linux-block/ad1018b6-7c0b-4d70-
>>>> b845-c869287d3cf3@acm.org/). The only disadvantage of this approach
>>>> compared to the cpuidle patch is that it requires RPM (runtime power
>>>> management) to be enabled. Maybe I should look into modifying the
>>>> approach such that it does not rely on RPM.
>>>
>>> I've had a look, the scope of my patch is a bit wider.  If my patch
>>> gets accepted I'm going to also look at putting the psd call into
>>> other devices (such as network devices) to also stop deep states while
>>> these devices are busy.  Since the code is very lightweight I was hoping this
>> was going to be relatively easy and simple to use in various devices in the
>> future.
>>
>> IMO this needs to be a lot more fine-grained then, both in terms of which
>> devices or even IO is affected (Surely some IO is fine with at least *some*
>> latency) but also how aggressive we are in blocking.
>> Just looking at some common latency/residency of idle states out there I don't
>> think it's reasonable to force polling for a 3-10ms (rounding up with the jiffie)
>> period.
> 
> The current solution by a customer is that they are resorting to disabling C6/C6P and hence
> all the CPUs are essentially in a non-low power state all the time.  The opt-in solution 
> provided in the patch provides nearly the same performance and will re-enable deeper
> C-states once the I/O is completed.
> 
> As I mentioned earlier, the jiffies are used because it's low-touch and very fast with negligible
> impact on the I/O paths. Using finer grained timing is far more an expensive operation and
> is a huge overhead on very fast I/O devices.
> 
> Also, this is a user config and tune-able choice. Users can opt-in to using this if they want
> to pay for the extra CPU overhead for a bit more I/O performance. If they don't want it, they
> don't need to enable it.
> 
>> Playing devil's advocate if the system is under some thermal/power pressure
>> we might actually reduce throughput by burning so much power on this.
>> This seems like the stuff that is easily convincing because it improves
>> throughput and then taking care of power afterwards is really hard. :/
>>
> 
> The current solution is when the user is trying to get maximum bandwidth and disabling C6/C6P 
> so they are already keeping the system busy. This solution at least will save power when I/O is idling.
> 

No. They can set the pm qos latency constraint when they care about 'maximum bandwidth'
and remove the constraint when they don't.
If they just disable the idle states at boot and never enable them at least they have no
grounds to complain to kernel people about, they should know what they're doing is detrimental
to power.

Furthermore we might be better off disabling C6/C6P than staying in a polling state (whenever we've
completed an IO in the last ~5 to 20ms, depending on the HZ setting).
Again, the wastefulness of a polling state can hardly be overestimated, especially given
that it doesn't seem to be necessary at all here?

