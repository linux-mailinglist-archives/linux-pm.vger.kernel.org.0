Return-Path: <linux-pm+bounces-25632-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5936CA91E01
	for <lists+linux-pm@lfdr.de>; Thu, 17 Apr 2025 15:28:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3778C3B11D7
	for <lists+linux-pm@lfdr.de>; Thu, 17 Apr 2025 13:28:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9B8224635E;
	Thu, 17 Apr 2025 13:28:03 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D6E58F6C;
	Thu, 17 Apr 2025 13:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744896483; cv=none; b=hYJQ4uhIC/Jxr5T90SVr1UQVq212DeVW07ydsgyYvRrR2630FtZi34lJ661jiWHjAj1OdQ67UCwVjLrsDpEs+UMBq6hd/DhdPXv8AgzrHp08Q2qXgC0PtBWyMYVZS/vLR+KUY+9vwReWQFGWlmPb1cvVWKIJf/Qzpr9NKkrmHZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744896483; c=relaxed/simple;
	bh=T5lxbj+4bLeAq9HZRlJ8VOzzlHzVsOhXgHcaNrXz6F4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QlfVGm3SPDOUe6+MdUj07kX1E74IpZgdmyjpiae/JPOpzKc2Hy+ncsIvgsZKxbwjTfgU+JkIFb3g2Vjwg4qmhApFQVkBNGHmw6+nOMpLEvmuaN5R+f4m7vCrjK8id9exe9njI3p/KjRoFXx+BFQ4+1KC+71yIMp8Sbqszh92DYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 23E451515;
	Thu, 17 Apr 2025 06:27:55 -0700 (PDT)
Received: from [10.57.72.153] (unknown [10.57.72.153])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A5D883F59E;
	Thu, 17 Apr 2025 06:27:56 -0700 (PDT)
Message-ID: <1a7f6279-c21c-4d6f-a5ee-48766b1ca34e@arm.com>
Date: Thu, 17 Apr 2025 14:27:54 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] PM: EM: Fix potential division-by-zero error in
 em_compute_costs()
To: Yaxiong Tian <iambestgod@qq.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 Yaxiong Tian <tianyaxiong@kylinos.cn>, rafael@kernel.org
References: <tencent_EE27C7D1D6BDB3EE57A2C467CC59A866C405@qq.com>
 <tencent_2256A7C02F7849F1D89390E488704E826D06@qq.com>
 <1ca192e6-3a45-45c6-b4f0-be6a89eaf192@arm.com>
 <tencent_91D93A837FF94A06C7FE8492461472B86D09@qq.com>
Content-Language: en-US
From: Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <tencent_91D93A837FF94A06C7FE8492461472B86D09@qq.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 4/17/25 08:43, Yaxiong Tian wrote:
> 
> 
> 在 2025/4/17 13:57, Lukasz Luba 写道:
>>
>>
>> On 4/17/25 02:07, Yaxiong Tian wrote:
>>> From: Yaxiong Tian <tianyaxiong@kylinos.cn>
>>>
>>> When the device is of a non-CPU type, table[i].performance won't be
>>> initialized in the previous em_init_performance(), resulting in division
>>> by zero when calculating costs in em_compute_costs().
>>>
>>> Since the 'cost' algorithm is only used for EAS energy efficiency
>>> calculations and is currently not utilized by other device drivers, we
>>> should add the _is_cpu_device(dev) check to prevent this 
>>> division-by-zero
>>> issue.
>>>
>>> Fixes: 1b600da51073 ("PM: EM: Optimize em_cpu_energy() and remove 
>>> division")
>>> Signed-off-by: Yaxiong Tian <tianyaxiong@kylinos.cn>
>>> ---
>>>   kernel/power/energy_model.c | 4 ++++
>>>   1 file changed, 4 insertions(+)
>>>
>>> diff --git a/kernel/power/energy_model.c b/kernel/power/energy_model.c
>>> index d9b7e2b38c7a..41606247c277 100644
>>> --- a/kernel/power/energy_model.c
>>> +++ b/kernel/power/energy_model.c
>>> @@ -233,6 +233,10 @@ static int em_compute_costs(struct device *dev, 
>>> struct em_perf_state *table,
>>>       unsigned long prev_cost = ULONG_MAX;
>>>       int i, ret;
>>> +    /* This is needed only for CPUs and EAS skip other devices */
>>> +    if (!_is_cpu_device(dev))
>>> +        return 0;
>>> +
>>>       /* Compute the cost of each performance state. */
>>>       for (i = nr_states - 1; i >= 0; i--) {
>>>           unsigned long power_res, cost;
>>
>>
>> Please stop for a while. I have to check what happened that you
>> faced the issue in the first place. I have been testing the GPU
>> EMs and there was no issues...
>>
>> Let me debug that today.
> 
> Of course. Since I don't have actual hardware, I can only logically
> deduce that this issue might exist.
> 
> 

I have run with the GPU EM registered in the boot:

-------------------------------------------------------
[    2.753333] panfrost ff9a0000.gpu: EM: created perf domain
[    2.759863] panfrost ff9a0000.gpu: mali-t860 id 0x860 major 0x2 minor 
0x0 status 0x0
[    2.768530] panfrost ff9a0000.gpu: features: 00000000,00000407, 
issues: 00000000,24040400
[    2.777678] panfrost ff9a0000.gpu: Features: L2:0x07120206 
Shader:0x00000000 Tiler:0x00000809 Mem:0x1 MMU:0x00002830 AS:0xff JS:0x7
[    2.780746] mmc_host mmc2: Bus speed (slot 0) = 148500000Hz (slot req 
150000000Hz, actual 148500000HZ div = 0)
[    2.790905] panfrost ff9a0000.gpu: shader_present=0xf l2_present=0x1

root@arm:~# cat /sys/kernel/debug/energy_model/ff9a0000.gpu/flags 

0x1
root@arm:~# grep . /sys/kernel/debug/energy_model/ff9a0000.gpu/ps*/*
/sys/kernel/debug/energy_model/ff9a0000.gpu/ps:200000/cost:0
/sys/kernel/debug/energy_model/ff9a0000.gpu/ps:200000/frequency:200000
/sys/kernel/debug/energy_model/ff9a0000.gpu/ps:200000/inefficient:1
/sys/kernel/debug/energy_model/ff9a0000.gpu/ps:200000/performance:0
/sys/kernel/debug/energy_model/ff9a0000.gpu/ps:200000/power:404250
/sys/kernel/debug/energy_model/ff9a0000.gpu/ps:300000/cost:0
/sys/kernel/debug/energy_model/ff9a0000.gpu/ps:300000/frequency:300000
/sys/kernel/debug/energy_model/ff9a0000.gpu/ps:300000/inefficient:1
/sys/kernel/debug/energy_model/ff9a0000.gpu/ps:300000/performance:0
/sys/kernel/debug/energy_model/ff9a0000.gpu/ps:300000/power:606375
/sys/kernel/debug/energy_model/ff9a0000.gpu/ps:400000/cost:0
/sys/kernel/debug/energy_model/ff9a0000.gpu/ps:400000/frequency:400000
/sys/kernel/debug/energy_model/ff9a0000.gpu/ps:400000/inefficient:1
/sys/kernel/debug/energy_model/ff9a0000.gpu/ps:400000/performance:0
/sys/kernel/debug/energy_model/ff9a0000.gpu/ps:400000/power:808500
/sys/kernel/debug/energy_model/ff9a0000.gpu/ps:600000/cost:0
/sys/kernel/debug/energy_model/ff9a0000.gpu/ps:600000/frequency:600000
/sys/kernel/debug/energy_model/ff9a0000.gpu/ps:600000/inefficient:0
/sys/kernel/debug/energy_model/ff9a0000.gpu/ps:600000/performance:0
/sys/kernel/debug/energy_model/ff9a0000.gpu/ps:600000/power:1505790

--------------------------------------------------------

The EM for the GPU is not modified during the boot like the CPUs'
EM are, thus this code is not triggered. Although, the API is
open and in theory the GPU EM can be modified at runtime
as well and it will reach that em_compute_costs() issue
with 'performance' field having value 0.

So this v4 patch would be needed in this case.

Please re-send this v4 patch as a completely new message.

Thanks for looking at that code path and the fix for potential
issue.

You can also add my:

Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>

Regrds,
Lukasz


