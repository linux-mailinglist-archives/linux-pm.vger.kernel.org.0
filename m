Return-Path: <linux-pm+bounces-25586-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81F43A910FC
	for <lists+linux-pm@lfdr.de>; Thu, 17 Apr 2025 03:01:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8CBDA4457DE
	for <lists+linux-pm@lfdr.de>; Thu, 17 Apr 2025 01:01:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A40613AD3F;
	Thu, 17 Apr 2025 01:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="QZR3WKAq"
X-Original-To: linux-pm@vger.kernel.org
Received: from out162-62-57-64.mail.qq.com (out162-62-57-64.mail.qq.com [162.62.57.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44CE785626;
	Thu, 17 Apr 2025 01:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744851710; cv=none; b=fkBGKkiHMrzT8X0H1Vb+AJUUFeVpHIEHVuIb2zIN8MRmHrOfekQ+sRITPl3tbMgbGa5yHZAbgZYSQ/ppVI6gegvHwAHlKVXZuS0A4uk7U9iBiSF5U3Dofk+QdQYPuOEDGIk6SCX35rn1W0To+eeYgoIlmuGZMmirk6FP4T/WZFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744851710; c=relaxed/simple;
	bh=Z33tGbXNa/Z+ukflV9OKQZbiaePdJSU6ARsBUB0pew4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NapkQFLLHNuiDO/dXO5zOGArFWsf9NIE1PlQAqhC7AomnjKZK7kcYEwKwdkJwlXSo+jzpOkffQueUqThftOsf6PaftvpJls3v470wAvcmmej5RFZkIqAsjv6vn2YjDhzdD8Pk3NcbELAfQjbTkL9e+/i5dEs61vOPElH0idiAxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=QZR3WKAq; arc=none smtp.client-ip=162.62.57.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1744851394; bh=YD9f5yEVr2z0iCTLFWkQnJV5hp8mGuqx+T5Wt6TbArM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=QZR3WKAqcPbFhpl67xZTj2oDRsNGe/G5DKVo6XQldJ1vOGg/ZaWePV8vt/q/PSgpN
	 /l38BcreoXlW4lzW/UmepVzRaueDjQ/QXGw2RVE1DvFdxJ5PgfJolsms9G76vbrpy6
	 Ym3o3YX7nfSyJDeQvP6s96nkeqcsURWCsAtAMbL4=
Received: from [IPV6:240e:469:644:c677:5cc9:79d:eef7:ec59] ([240e:469:644:c677:5cc9:79d:eef7:ec59])
	by newxmesmtplogicsvrszb16-1.qq.com (NewEsmtp) with SMTP
	id E20048E1; Thu, 17 Apr 2025 08:56:32 +0800
X-QQ-mid: xmsmtpt1744851392tnxqa3qki
Message-ID: <tencent_BBA191F51C3CDBF54EB8DFE592ECB1232107@qq.com>
X-QQ-XMAILINFO: Mm0jDPjQYDdlyaklPYmsac73KLMPAUvWabU3YECQILwOKjt9sBhbRqduKFQI57
	 O8Taee4gQYWoyeesyBSGTVedxqB85okCYo8cBXYTPyb4gWgTMH9YEERLbRgYzWW5ppWY4j0N0zq1
	 WFuc048D8JJFpFLBNprv2kvvAqeG7dWniE+J1pXhKtXqpKt95UJz/7yYRl8XNtbaC1B0kYW0Hykx
	 hT57fhgg2qZJFvRjo31FSzsZ+vJEjvN2SSDsrYG4TFItKk+eY8nUPclIZ6hCdSppK+hQOFWbTvYL
	 5uTgpdCUFVKU0wEUtz9QfXFqXly9r9DHXuxk1sFBnwLUIC6arGN66vEs0LC7aMJAB+bGDQVF3DRG
	 i1SaomXUXrVvl5g3nMKwPXTC1YxdzAZywQzjfuhE9KoIoRG2wLCa9lYWsvqvgd+gm/vwskMxKjZX
	 KyPdun1W5+Q7FXDFd3MqR6tRqn32AqyOnpVNig+QcOnK3GBs3n9EXcNoUUUqNfB88YfKdT5uU6k9
	 w4m3OJUyifDLJ7nI9n6p++hTHHC+IA3aNML3gdUPTAiiwyZ+Wpx24Xz9Tt+KAAWSJSSRQmC9gy+D
	 YZLKtHn6FGXnrqfAgWJYjdPN0nrjGlXEBT8xWN/9cCw/kylxEzgIL2JhJcdGtmfsFhZu6WIosM2D
	 cWgYxQ4IxiUBZw2hMZBphSHpt/cD40BezxuPAtipE631PuBMbVblmHljYFUVXPMi7h8sT5FDUIEn
	 HnMKUVzV1EgW90XgJUKA3QxGoZbPySdszFT+kdl9aUoAR+wP28rm6KJ7PNhjsjS7E+arNx4sWhJA
	 WIXvknqItmLvDAHHMovrB3/orpzKztY+NQd9+plvmNVzuWZA+bTT30PjujZLE5kn8IHQwvckt2lV
	 nVyl5fDrJjU6U4Bx5IBmQjoAiRVRsR2CA1oZ24ynbMqieCF+z5Fx5gCMMnI6P1TsAdmyEEBitHHy
	 PeiFeb3tjWbOTbrJ22Y6g/sw0kgVFmGJlJvZONe4QQUcktMKVwzSQKKc5BkG3s
X-QQ-XMRINFO: Nq+8W0+stu50PRdwbJxPCL0=
X-OQ-MSGID: <d4dcc44e-90c8-41af-a1ec-7239cdd8bac9@qq.com>
Date: Thu, 17 Apr 2025 08:56:31 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] PM: EM: Fix potential division-by-zero error in
 em_compute_costs()
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: lukasz.luba@arm.com, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org, Yaxiong Tian <tianyaxiong@kylinos.cn>
References: <tencent_EE27C7D1D6BDB3EE57A2C467CC59A866C405@qq.com>
 <tencent_6D2374392DB66C9D23BF6E2546638A42EC08@qq.com>
 <CAJZ5v0iE_iw+pSBppEWnJw=2=DFNa-J2VPDorTNF=Mve+0PNCg@mail.gmail.com>
 <tencent_8E3A87C6D6A193F757BA846F0C41887CC405@qq.com>
 <CAJZ5v0iq4bw3WAk1yQRP=B3zk-rRYwibKNRjSfu=PGqTt6RNYw@mail.gmail.com>
Content-Language: en-US
From: Yaxiong Tian <iambestgod@qq.com>
In-Reply-To: <CAJZ5v0iq4bw3WAk1yQRP=B3zk-rRYwibKNRjSfu=PGqTt6RNYw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/4/16 19:58, Rafael J. Wysocki 写道:
> On Wed, Apr 16, 2025 at 4:57 AM Yaxiong Tian <iambestgod@qq.com> wrote:
>>
>> 在 2025/4/16 01:17, Rafael J. Wysocki 写道:
>>> On Mon, Apr 14, 2025 at 11:09 AM Yaxiong Tian <iambestgod@qq.com> wrote:
>>>>
>>>> From: Yaxiong Tian <tianyaxiong@kylinos.cn>
>>>>
>>>> When the device is of a non-CPU type, table[i].performance won't be
>>>> initialized in the previous em_init_performance(), resulting in division
>>>> by zero when calculating costs in em_compute_costs().
>>>>
>>>> Since the 'cost' algorithm is only used for EAS energy efficiency
>>>> calculations and is currently not utilized by other device drivers, we
>>>> should add the _is_cpu_device(dev) check to prevent this division-by-zero
>>>> issue.
>>>>
>>>> Fixes: <1b600da51073> ("PM: EM: Optimize em_cpu_energy() and remove division")
>>>
>>> Please look at the Fixes: tags in the kernel git history.  They don't
>>> look like the one above.
>>>
>> Yes, there's an extra '<>' here.
>>
>>>> Signed-off-by: Yaxiong Tian <tianyaxiong@kylinos.cn>
>>>> ---
>>>>    kernel/power/energy_model.c | 4 ++--
>>>>    1 file changed, 2 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/kernel/power/energy_model.c b/kernel/power/energy_model.c
>>>> index d9b7e2b38c7a..fc972cc1fc12 100644
>>>> --- a/kernel/power/energy_model.c
>>>> +++ b/kernel/power/energy_model.c
>>>> @@ -235,7 +235,7 @@ static int em_compute_costs(struct device *dev, struct em_perf_state *table,
>>>>
>>>>           /* Compute the cost of each performance state. */
>>>>           for (i = nr_states - 1; i >= 0; i--) {
>>>> -               unsigned long power_res, cost;
>>>> +               unsigned long power_res, cost = 0;
>>>>
>>>>                   if ((flags & EM_PERF_DOMAIN_ARTIFICIAL) && cb->get_cost) {
>>>>                           ret = cb->get_cost(dev, table[i].frequency, &cost);
>>>> @@ -244,7 +244,7 @@ static int em_compute_costs(struct device *dev, struct em_perf_state *table,
>>>>                                           cost, ret);
>>>>                                   return -EINVAL;
>>>>                           }
>>>> -               } else {
>>>> +               } else if (_is_cpu_device(dev)) {
>>>
>>> Can't you just check this upfront at the beginning of the function and
>>> make it bail out if dev is not a CPU device?
>>>
>> Sure, But the current implementation applies em_compute_costs() to both
>> non-CPU devices and CPU devices.
> 
> Maybe it shouldn't do that for non-CPU ones?
> 
>> After carefully reviewing the latest code,
>> I've found this issue has expanded in scope.
>>
>> There are currently three call paths for invoking em_compute_costs():
>>
>> 1) Registering performance domains (for both non-CPU and CPU devices)
>> em_dev_register_perf_domain() → em_create_pd() →
>> em_create_perf_table() → em_compute_costs()
>>
>> 2)EM update paths (CPU devices only)
>>
>> Periodic 1000ms update check via em_update_work work item:
>> em_check_capacity_update() → em_adjust_new_capacity() →
>> em_recalc_and_update() → em_compute_costs()
>>
>> Exynos-chip initialization:
>> em_dev_update_chip_binning() → em_recalc_and_update() → em_compute_costs()
>>
>> 3) Device cost computation (non-CPU devices only - currently unused)
>> em_dev_compute_costs() → em_compute_costs()
> 
> So because this one is unused and AFAICS the cost values are never
> used for non-CPU devices, it's better to just avoid computing them at
> all.
> 
>> Note: In em_dev_compute_costs(), when calling em_compute_costs(),
>> neither the callback (cb) nor flags are set.In fact, it either does
>> nothing at all or performs incorrect operations.
>>
>> Therefore, should we mandate that non-CPU devices must provide a
>> get_cost callback?
> 
> Why would that be an improvement?
> 
>> So Should we add a check at the beginning of the em_compute_costs() to:
>>
>>          if (!_is_cpu_device(dev) && !cb->get_cost) {
>>                  dev_dbg(dev, "EM: No get_cost provided, cost unset.\n");
>>                  return 0;
>>          }
>> And Modify em_dev_compute_costs() to require callers to provide the cb
>> callback function,Also need to update its corresponding comments.
>>
>>
>>>>                           /* increase resolution of 'cost' precision */
>>>>                           power_res = table[i].power * 10;
>>>>                           cost = power_res / table[i].performance;
>>>> --
> 
> I think until there is a user of em_dev_compute_costs() this is all
> moot and hard to figure out.
> 
> I would drop em_dev_compute_costs() altogether for now and put a
> _is_cpu_device(dev) upfront check into em_compute_costs().

Yes, I agree with your point. Currently no non-CPU devices are using
'cost'. The best approach would be to just add the _is_cpu_device check. 
I'll update it in V4.

By the way, em_dev_compute_costs should only apply to CPU devices. I was
mistaken earlier—it’s really hard to tell just from the function name.


