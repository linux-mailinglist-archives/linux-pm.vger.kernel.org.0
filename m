Return-Path: <linux-pm+bounces-25682-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CDE9FA92F4E
	for <lists+linux-pm@lfdr.de>; Fri, 18 Apr 2025 03:32:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5C2CB7A97D6
	for <lists+linux-pm@lfdr.de>; Fri, 18 Apr 2025 01:31:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20BDE1C5D7D;
	Fri, 18 Apr 2025 01:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="Ken9vZV/"
X-Original-To: linux-pm@vger.kernel.org
Received: from out203-205-221-221.mail.qq.com (out203-205-221-221.mail.qq.com [203.205.221.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8D54184E;
	Fri, 18 Apr 2025 01:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744939927; cv=none; b=Zx55SmIbyOGvV04kWQuJXB+jQd7YA1HIO2M3EgFA/20xNpIGV7v/aqK2yVI0pQ67sEw/TvJwZMc0ZUvmJuX6wHVu23qxQwHtsKC6hImbv3owzjRkuv+GeEDA36gvJvfFLOaqGP8ayZxw/MAHnG5mW9qqbgKM5KijQ/zPd6vJXvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744939927; c=relaxed/simple;
	bh=jekfTa9V30p9Z0YsCtA2/HSKfXwCMg4Wx7EMinWsgk0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ny2dCSdCKPoEOlVYB0JG2ctQs/UEQQsNX74q6h47vTU2hucU3AwtOMJFx5tWcBqd9+/7fFosFkvAvjODdgIStLIScv5APLwokF/Z6KSMMw4Tql83gQgHcLzl8+bi8Hsrdml8xGRFeoDP7Nh7uQVJNDFOY35mEVmSX2bQo2qOyqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=Ken9vZV/; arc=none smtp.client-ip=203.205.221.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1744939610; bh=HevGOi1X0mZXbeVlJrmCyia/jNHwBFQD50J/snF8XCI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=Ken9vZV/f7kgs80KtLY4T0e/bKgVLOWSi+qRp8iHuTUMD9rlD3SN/JDNYlDuPWrAZ
	 7jv2Ks04YX8ICZCVriZgYzgOw0SRaBVBAZ++ESYLjP22xIcQXwJUGXNzvKCxnuLXSh
	 +nEnNpx7ZiBrSCnTfq+Z9pEjGYc6f0DQUNv2Nd5U=
Received: from [10.42.13.21] ([116.128.244.169])
	by newxmesmtplogicsvrszb16-1.qq.com (NewEsmtp) with SMTP
	id 6B139465; Fri, 18 Apr 2025 09:26:49 +0800
X-QQ-mid: xmsmtpt1744939609t8f0vwbn3
Message-ID: <tencent_F59412B7B14221D391FE1C1ADBAF4EBD5F07@qq.com>
X-QQ-XMAILINFO: NQR8mRxMnur9Dov2d0lKs+xY+CV9nImtN7dQtaXynqINr664JPoEpVGYDL9Djk
	 5bRkyPq1dnVF98I+nOQYVPeEAZ8U1u/6t2qvJhpXkwmwYs89hFVUnmpVEV7C1hyi6DJuuqERpZ9h
	 3QQltE3NyBS6M/zc923xe/7JOT1Vyc5N/L5PjR3lEkAR3h0cDS5Q6kedrvwEz7ppq2y5ekEkfiWH
	 pP4pTUIR+OCd4VBycL0efTntBK+Y+Lcmih27xM3VqB8Enh4mzKMSdde+pU7S2zDl8LbtIGWB4pEX
	 ufNwdTmcGVXcF+P6UdBORRme6McCA0NTloz1kq3RgJhwQAlOtOv5k8eqKurLjuWlfKyeJxTPRq9/
	 BO59fCTzttJg95Czv0GHuRXdoG5KirkuIrcU/mbH0WbUtqoN/+1mUBC5fFoX60HnzP7Rhjgu7pQP
	 opcz1nTIQIVpk3yno/ZtdU31xqfUUMkZfv7/Kj5yxvOGL6C+RAI+2gk46j6T5+PFlWt1ajeAs4v6
	 qF4GPUGa9lhhwHg9jT7PqDGgQUimGT5Cl85t9/IbM6qs9vNJ6S8dtFWPkSF21i22YY7Pm8ET7z1l
	 Fh2oynRdVvFqe52cMU31odQHQ9aQfSk6JzJKzYNOpD+jDo9EHb8zVte7iG2h3cbE691UukpAOveN
	 jLWn6R5PqPqWhdXluJstZWgz0lERWHvz7cYoFp5qGQXpAR7LzmBmQGZMTFJKBIymxZCu2Kcu8uiX
	 ipsmWV1MOKKPWeKvVbO1Mza9bxWpA+1x251jHMb7KyKXbj2H/xMi6hoTeDFx1buGWYj1eRbvoe9V
	 OMT49eIsQo3Qk/BVmqQ4KSFHMdTheJDsvsl/IJUhT6SrAfj43xdO5tQbG9CwzdrghvpMCpxTBH06
	 RNrvPO+5SOy0NUxh8ZhpeFnwNzjUNLCtOehxfATHf/VL5qxQsRJEfgNI4xNr5+eV4+2k0mFTUlzA
	 8xSUxzD/mc61Rg+SmR7MvLKoedSMh+cZ0Gjzg4gNcK3xrUH9gktFMYocVpr+Mm
X-QQ-XMRINFO: NyFYKkN4Ny6FSmKK/uo/jdU=
X-OQ-MSGID: <75d26d83-aa3a-4acc-9341-e901b1793f1e@qq.com>
Date: Fri, 18 Apr 2025 09:26:49 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] PM: EM: Fix potential division-by-zero error in
 em_compute_costs()
To: Lukasz Luba <lukasz.luba@arm.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 Yaxiong Tian <tianyaxiong@kylinos.cn>, rafael@kernel.org
References: <tencent_EE27C7D1D6BDB3EE57A2C467CC59A866C405@qq.com>
 <tencent_2256A7C02F7849F1D89390E488704E826D06@qq.com>
 <1ca192e6-3a45-45c6-b4f0-be6a89eaf192@arm.com>
 <tencent_91D93A837FF94A06C7FE8492461472B86D09@qq.com>
 <1a7f6279-c21c-4d6f-a5ee-48766b1ca34e@arm.com>
Content-Language: en-US
From: Yaxiong Tian <iambestgod@qq.com>
In-Reply-To: <1a7f6279-c21c-4d6f-a5ee-48766b1ca34e@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/4/17 21:27, Lukasz Luba 写道:
> 
> 
> On 4/17/25 08:43, Yaxiong Tian wrote:
>>
>>
>> 在 2025/4/17 13:57, Lukasz Luba 写道:
>>>
>>>
>>> On 4/17/25 02:07, Yaxiong Tian wrote:
>>>> From: Yaxiong Tian <tianyaxiong@kylinos.cn>
>>>>
>>>> When the device is of a non-CPU type, table[i].performance won't be
>>>> initialized in the previous em_init_performance(), resulting in 
>>>> division
>>>> by zero when calculating costs in em_compute_costs().
>>>>
>>>> Since the 'cost' algorithm is only used for EAS energy efficiency
>>>> calculations and is currently not utilized by other device drivers, we
>>>> should add the _is_cpu_device(dev) check to prevent this 
>>>> division-by-zero
>>>> issue.
>>>>
>>>> Fixes: 1b600da51073 ("PM: EM: Optimize em_cpu_energy() and remove 
>>>> division")
>>>> Signed-off-by: Yaxiong Tian <tianyaxiong@kylinos.cn>
>>>> ---
>>>>   kernel/power/energy_model.c | 4 ++++
>>>>   1 file changed, 4 insertions(+)
>>>>
>>>> diff --git a/kernel/power/energy_model.c b/kernel/power/energy_model.c
>>>> index d9b7e2b38c7a..41606247c277 100644
>>>> --- a/kernel/power/energy_model.c
>>>> +++ b/kernel/power/energy_model.c
>>>> @@ -233,6 +233,10 @@ static int em_compute_costs(struct device *dev, 
>>>> struct em_perf_state *table,
>>>>       unsigned long prev_cost = ULONG_MAX;
>>>>       int i, ret;
>>>> +    /* This is needed only for CPUs and EAS skip other devices */
>>>> +    if (!_is_cpu_device(dev))
>>>> +        return 0;
>>>> +
>>>>       /* Compute the cost of each performance state. */
>>>>       for (i = nr_states - 1; i >= 0; i--) {
>>>>           unsigned long power_res, cost;
>>>
>>>
>>> Please stop for a while. I have to check what happened that you
>>> faced the issue in the first place. I have been testing the GPU
>>> EMs and there was no issues...
>>>
>>> Let me debug that today.
>>
>> Of course. Since I don't have actual hardware, I can only logically
>> deduce that this issue might exist.
>>
>>
> 
> I have run with the GPU EM registered in the boot:
> 
> -------------------------------------------------------
> [    2.753333] panfrost ff9a0000.gpu: EM: created perf domain
> [    2.759863] panfrost ff9a0000.gpu: mali-t860 id 0x860 major 0x2 minor 
> 0x0 status 0x0
> [    2.768530] panfrost ff9a0000.gpu: features: 00000000,00000407, 
> issues: 00000000,24040400
> [    2.777678] panfrost ff9a0000.gpu: Features: L2:0x07120206 
> Shader:0x00000000 Tiler:0x00000809 Mem:0x1 MMU:0x00002830 AS:0xff JS:0x7
> [    2.780746] mmc_host mmc2: Bus speed (slot 0) = 148500000Hz (slot req 
> 150000000Hz, actual 148500000HZ div = 0)
> [    2.790905] panfrost ff9a0000.gpu: shader_present=0xf l2_present=0x1
> 
> root@arm:~# cat /sys/kernel/debug/energy_model/ff9a0000.gpu/flags
> 0x1
> root@arm:~# grep . /sys/kernel/debug/energy_model/ff9a0000.gpu/ps*/*
> /sys/kernel/debug/energy_model/ff9a0000.gpu/ps:200000/cost:0
> /sys/kernel/debug/energy_model/ff9a0000.gpu/ps:200000/frequency:200000
> /sys/kernel/debug/energy_model/ff9a0000.gpu/ps:200000/inefficient:1
> /sys/kernel/debug/energy_model/ff9a0000.gpu/ps:200000/performance:0
> /sys/kernel/debug/energy_model/ff9a0000.gpu/ps:200000/power:404250
> /sys/kernel/debug/energy_model/ff9a0000.gpu/ps:300000/cost:0
> /sys/kernel/debug/energy_model/ff9a0000.gpu/ps:300000/frequency:300000
> /sys/kernel/debug/energy_model/ff9a0000.gpu/ps:300000/inefficient:1
> /sys/kernel/debug/energy_model/ff9a0000.gpu/ps:300000/performance:0
> /sys/kernel/debug/energy_model/ff9a0000.gpu/ps:300000/power:606375
> /sys/kernel/debug/energy_model/ff9a0000.gpu/ps:400000/cost:0
> /sys/kernel/debug/energy_model/ff9a0000.gpu/ps:400000/frequency:400000
> /sys/kernel/debug/energy_model/ff9a0000.gpu/ps:400000/inefficient:1
> /sys/kernel/debug/energy_model/ff9a0000.gpu/ps:400000/performance:0
> /sys/kernel/debug/energy_model/ff9a0000.gpu/ps:400000/power:808500
> /sys/kernel/debug/energy_model/ff9a0000.gpu/ps:600000/cost:0
> /sys/kernel/debug/energy_model/ff9a0000.gpu/ps:600000/frequency:600000
> /sys/kernel/debug/energy_model/ff9a0000.gpu/ps:600000/inefficient:0
> /sys/kernel/debug/energy_model/ff9a0000.gpu/ps:600000/performance:0
> /sys/kernel/debug/energy_model/ff9a0000.gpu/ps:600000/power:1505790
> 
> --------------------------------------------------------
> 
> The EM for the GPU is not modified during the boot like the CPUs'
> EM are, thus this code is not triggered. Although, the API is
> open and in theory the GPU EM can be modified at runtime
> as well and it will reach that em_compute_costs() issue
> with 'performance' field having value 0.
> 
> So this v4 patch would be needed in this case.
> 
> Please re-send this v4 patch as a completely new message.
> 
> Thanks for looking at that code path and the fix for potential
> issue.
> 
> You can also add my:
> 
> Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>
> 
> Regrds,
> Lukasz

Got it - patch resent with Reviewed-by.

https://lore.kernel.org/all/tencent_7F99ED4767C1AF7889D0D8AD50F34859CE06@qq.com/


