Return-Path: <linux-pm+bounces-24526-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3573FA71BEC
	for <lists+linux-pm@lfdr.de>; Wed, 26 Mar 2025 17:28:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 55DEF842160
	for <lists+linux-pm@lfdr.de>; Wed, 26 Mar 2025 16:26:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A85921F5827;
	Wed, 26 Mar 2025 16:26:56 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93DBA1F4E2F;
	Wed, 26 Mar 2025 16:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743006416; cv=none; b=mxLTO930eKUkkUCU37iY0/hRmWhuGrvVpoS7wTHji8HQqAta7smYwGNT3LEbGoXErdT4hlGk4YNJRQobm2Fg1sBgI+Y45yLTxPHQykt1OS2A0XW+2CC/1t1IIVqQs6OI60gkzJFV1/fxpOvzz7Nr2CufpV7+xyCXuQZjcp0YJi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743006416; c=relaxed/simple;
	bh=F8pUrCH04U9L2zyxZ1cbKiceMS1RmTZoO+a59jmMARg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZfOy3jI7MxsnoHlR+Fka2auZ1/lDM2YLkPORnkO7Rv4Iiu8asPBlN2CrJ1PxmbB49OUC05wiCGz9o+gMj7TdAgJ9CJd4GVvTaowD7qodinpxV3Ed29T8v6kgrn6/KICUk0NjuCofzNPRVqGBvKnKGTs8CDDl9Jh38MZdeQMI4is=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0EFA71424;
	Wed, 26 Mar 2025 09:26:58 -0700 (PDT)
Received: from [10.57.70.44] (unknown [10.57.70.44])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B65FD3F694;
	Wed, 26 Mar 2025 09:26:50 -0700 (PDT)
Message-ID: <ad852ef9-5207-4b70-8834-2db6aa5e1a51@arm.com>
Date: Wed, 26 Mar 2025 16:26:48 +0000
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
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <SJ2PR11MB7670B2AEFF7C0DABE6856F258DA62@SJ2PR11MB7670.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/26/25 15:04, King, Colin wrote:
> Hi,
> 
>> -----Original Message-----
>> From: Bart Van Assche <bvanassche@acm.org>
>> Sent: 23 March 2025 12:36
>> To: King, Colin <colin.king@intel.com>; Christian Loehle
>> <christian.loehle@arm.com>; Jens Axboe <axboe@kernel.dk>; Rafael J.
>> Wysocki <rafael@kernel.org>; Daniel Lezcano <daniel.lezcano@linaro.org>;
>> linux-block@vger.kernel.org; linux-pm@vger.kernel.org
>> Cc: linux-kernel@vger.kernel.org
>> Subject: Re: [PATCH] cpuidle: psd: add power sleep demotion prevention for
>> fast I/O devices
>>
>> On 3/17/25 3:03 AM, King, Colin wrote:
>>> This code is optional, one can enable it or disable it via the config
>>> option. Also, even when it is built-in one can disable it by writing 0 to the
>> sysfs file
>>>    /sys/devices/system/cpu/cpuidle/psd_cpu_lat_timeout_ms
>>
>> I'm not sure we need even more configuration knobs in sysfs. 
> 
> It's useful for enabling / disabling the functionality, as well as some form of tuning for slower I/O devices, so I think it is justifiable.
> 
>> How are users
>> expected to find this configuration option? How should they decide whether
>> to enable or to disable it?
> 
> I can send a V2 with some documentation if that's required.
> 
>>
>> Please take a look at this proposal and let me know whether this would solve
>> the issue that you are looking into: "[LSF/MM/BPF Topic] Energy- Efficient I/O"
>> (https://lore.kernel.org/linux-block/ad1018b6-7c0b-4d70-
>> b845-c869287d3cf3@acm.org/). The only disadvantage of this approach
>> compared to the cpuidle patch is that it requires RPM (runtime power
>> management) to be enabled. Maybe I should look into modifying the
>> approach such that it does not rely on RPM.
> 
> I've had a look, the scope of my patch is a bit wider.  If my patch gets accepted I'm 
> going to also look at putting the psd call into other devices (such as network devices) to 
> also stop deep states while these devices are busy.  Since the code is very lightweight I
> was hoping this was going to be relatively easy and simple to use in various devices in the future.

IMO this needs to be a lot more fine-grained then, both in terms of which devices or even
IO is affected (Surely some IO is fine with at least *some* latency) but also how aggressive
we are in blocking.
Just looking at some common latency/residency of idle states out there I don't think
it's reasonable to force polling for a 3-10ms (rounding up with the jiffie) period.
Playing devil's advocate if the system is under some thermal/power pressure we might
actually reduce throughput by burning so much power on this.
This seems like the stuff that is easily convincing because it improves throughput and
then taking care of power afterwards is really hard. :/



