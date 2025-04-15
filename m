Return-Path: <linux-pm+bounces-25421-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F3A8FA891BE
	for <lists+linux-pm@lfdr.de>; Tue, 15 Apr 2025 04:03:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 601F0189C472
	for <lists+linux-pm@lfdr.de>; Tue, 15 Apr 2025 02:03:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA56F207DE2;
	Tue, 15 Apr 2025 02:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="Piv+iOHC"
X-Original-To: linux-pm@vger.kernel.org
Received: from out162-62-57-210.mail.qq.com (out162-62-57-210.mail.qq.com [162.62.57.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC958482EF;
	Tue, 15 Apr 2025 02:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744682593; cv=none; b=PdP8AO0hNH+SF0yKQgOQxIbfk2IYGl5OYQ5fRu6qSyurvt/2gdO604rmmUfAT5Fk2vjzBZA+/Yf6i930LfYmrTTXAiC8yEUlVawBKN6Q5UzOpCL0KnbK3GC4rybWo2GRuOuhIrHS3xdhTRgalcgRXmueHm71e1yFd+JFzQfeOJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744682593; c=relaxed/simple;
	bh=dc96B71x+m953HrpJ99j9K96w+utzbXjFOv4A5h7Dlg=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=d//Qxg8tPyz2dfzSsW2QBu9It7F12/eSfGMjiEGOr09txHsY3jNip2XbE/m3Ko/plVrmxY9YZgZko8i8IemJ0QSWL2JucTG0d9C+V3xff6+PDeqpm1V06r73OaqhF0sKpsAKubYnHPAfe+aOT+kEa3x+pcNoJg0ZyEcCWatTQJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=Piv+iOHC; arc=none smtp.client-ip=162.62.57.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1744682283; bh=Ce2aCcjwPJqIstzu+DW41Jf00bhGwKLlLjZtkpjN5o8=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To;
	b=Piv+iOHCSy9c47LEy0KPpmtblJ7eXk2NJ9SB1Py/kUNLnDHlHMZKMbCfrI1d7e8T8
	 H2vneR5k9Cnyp5YBMxJovC3Fv1iM0doKPYqyyRcSL29Y0p4kXQsvT3bnMc68HT5gT4
	 WAX9/RTM+vpZwXshYKlCSbfpfTJIZII29kviXMbk=
Received: from [10.42.13.21] ([116.128.244.169])
	by newxmesmtplogicsvrsza36-0.qq.com (NewEsmtp) with SMTP
	id E8217280; Tue, 15 Apr 2025 09:58:02 +0800
X-QQ-mid: xmsmtpt1744682282t8jvjypwn
Message-ID: <tencent_002D68A7E02F76C9D218B090D6085F0E8C06@qq.com>
X-QQ-XMAILINFO: NnA3IMNPwBd++tNcGlwsbS2vzUr7sFx8qwGAEaazHKzVw3QDoVB8JgKDimnkbP
	 FO1pT1gL9hr+XL8Xf0Kww4CxbHcoyc6t8dKYndsSEUU4yfek18jqpLtH8BbwfRMYbG3/izivvmTW
	 +BzUDQIdnXs98dAwOA2bCQsSVz3bKFubvNu9XRMgN/2WvANE4FGKEYEOuDlC5dW0aSUpJs3yoSXd
	 +usZEYe3+uwMsJmN7N0HLwEL1UVgq7zJNv47ME7gvQhjYX55wqepYSKi0q+z/zK+rkS9D5GhNuyh
	 RskbJYpx0lH0L+eB1xWULXk9uCyubDBACGMs56uTCLUvGDmmUuf0D6Q26wq6nKDGOkttksbkcV6n
	 AVC30rV0hEys+G9twzGm7a2L7pk7rjfQIULyeQeK3sn1N0xLEI5lk+sIhY/xIygGdF0H7kH0J1jT
	 T5fMzjlD9zfeGIx/mN89tJD4fSeBUeJTXbFG3b+CfKMc/8QfF5TZSU7/ddZU769pnaw/pNAWgHNL
	 6gBGF1bt0Pm8mJiDWapU+GezON4+zCB7HnyqRj7OtE4A3JKqqfa2NcbVpYQ6uBTLie2ccXN6KuhS
	 xeZ1bRAt5S+/172IociRZqgFMIXYmV91Ly/IpYAytAY52kuZdSsZnOL9p7yLhytGbPoq+r1LH/JG
	 NQsAKXOBdvQiTzFMa+lm7OkTDqhAJ/P6P5ZNES1LhqOY/9JsfiZHlA+PxjG+zmW0Eyer3VcJAH3r
	 3oldLQqKLttVBC0i+k9knL/3MnNt+ys5qIDXIwBi/IQznC8/+72hAwwoG825UtyNV1AzF44w+gtG
	 vY4fl5Y+Bf8Z6dT5ZObmkQItaHi6WjM2uUf9SMaGvppnH58UM+VFy+uUAj/z6WLFOhkNO8ATqb/S
	 M/R/vZqXppYJI+PSU7WlPuyBsR19TrlzL7M0BpHjBhg+ipA86TdV3eXlaUUqCU2FMGniKnstOeFo
	 CqPp/MnRKi0Bl5EAnkedsZ95fPylEIKrMP6P8edbgCI3gjrqVME3ZVtomCnBb/ewUupDNCIOM=
X-QQ-XMRINFO: MPJ6Tf5t3I/ycC2BItcBVIA=
X-OQ-MSGID: <5a20548a-ac36-4c4c-ab18-f8936719e5cf@qq.com>
Date: Tue, 15 Apr 2025 09:58:01 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] PM: EM: Fix potential division-by-zero error in
 em_compute_costs()
From: Yaxiong Tian <iambestgod@qq.com>
To: Lukasz Luba <lukasz.luba@arm.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 Yaxiong Tian <tianyaxiong@kylinos.cn>, rafael@kernel.org
References: <tencent_EE27C7D1D6BDB3EE57A2C467CC59A866C405@qq.com>
 <143378b0-5740-4f2b-9a79-f04cf9ef1f77@arm.com>
 <tencent_AE7CE43CDAD6747AFF0E952C8D0908A98D0A@qq.com>
Content-Language: en-US
In-Reply-To: <tencent_AE7CE43CDAD6747AFF0E952C8D0908A98D0A@qq.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/4/15 09:12, Yaxiong Tian 写道:
> 
> 
> 在 2025/4/14 16:08, Lukasz Luba 写道:
>> Hi Yaxiong,
>>
>> On 4/11/25 02:28, Yaxiong Tian wrote:
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
>>> Fixes: <1b600da51073> ("PM: EM: Optimize em_cpu_energy() and remove 
>>> division")
>>> Signed-off-by: Yaxiong Tian <tianyaxiong@kylinos.cn>
>>> ---
>>>   kernel/power/energy_model.c | 2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/kernel/power/energy_model.c b/kernel/power/energy_model.c
>>> index d9b7e2b38c7a..d1fa7e8787b5 100644
>>> --- a/kernel/power/energy_model.c
>>> +++ b/kernel/power/energy_model.c
>>> @@ -244,7 +244,7 @@ static int em_compute_costs(struct device *dev, 
>>> struct em_perf_state *table,
>>>                       cost, ret);
>>>                   return -EINVAL;
>>>               }
>>> -        } else {
>>> +        } else if (_is_cpu_device(dev)) {
>>>               /* increase resolution of 'cost' precision */
>>>               power_res = table[i].power * 10;
>>>               cost = power_res / table[i].performance;
>>
>>
>> As the test robot pointed out, please set the 'cost' to 0
>> where it's declared.
>>
>> The rest should be fine.
>>
>> Regards,
>> Lukasz
> 
> Sorry, the V3 version with cost=0 still has issues.
> 
> I noticed that if the cost is set to 0, the condition "if (table[i].cost
>   >= prev_cost)" in the following code will always evaluate to true. This
>   will incorrectly set the flags to EM_PERF_STATE_INEFFICIENT.
> 
> Should we change ">=" to ">"?
> 

Sorry Again， Setting EM_PERF_STATE_INEFFICIENT in this case is correct.
Earlier, I misunderstood the definition/usage of EM_PERF_STATE_INEFFICIENT.



