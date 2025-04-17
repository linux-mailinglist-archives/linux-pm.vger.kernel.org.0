Return-Path: <linux-pm+bounces-25612-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DBA8A915AF
	for <lists+linux-pm@lfdr.de>; Thu, 17 Apr 2025 09:49:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1ECF45A4602
	for <lists+linux-pm@lfdr.de>; Thu, 17 Apr 2025 07:48:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56A8621B1BC;
	Thu, 17 Apr 2025 07:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="r3T5zzQ4"
X-Original-To: linux-pm@vger.kernel.org
Received: from out203-205-221-245.mail.qq.com (out203-205-221-245.mail.qq.com [203.205.221.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A1401DE3BA;
	Thu, 17 Apr 2025 07:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744876122; cv=none; b=pUOByE+iCS9Y7k1EbxNgZmuoy9dQIkFf7ZIwFpvSrhW9HN3p8TO2PBhlPdTPI6k7Or0f7scQcdu6BEMcisrCM2BL52Yaq099IBiRgGg6SfJeUqWukxcBAi7//jrDAtLQFR5zHv1A9wEsDMYACdrlO7JFfaNbcRcmaGBb8Oe2FX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744876122; c=relaxed/simple;
	bh=V4ZdTBOdAnf4x7XHdVxrwP0So59hsxD4auzKQf4usvk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ar1iiYGjrInJC41/fe6Nm6NxXE/x9U77e+SA9OaPeDV6Cd6OiL9Hv0i4tbc63HbIZ3e8jDs6Mnm632alDgkhQZO+7MhBNUXb/MSaC9OWkww/3lk3R5YhUpdbhjMeI+0ktTygVbRee+qOBDCqsuTG+Xt6juIah3kLnLVr69BTJ7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=r3T5zzQ4; arc=none smtp.client-ip=203.205.221.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1744875809; bh=Rke5HdMYnCS5otM+F4H5jVE6Nq1snFf9qz3WwCRGqLo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=r3T5zzQ4lmFfYnBYGCgiZJsmbOYxQWg5C8NupnZ2APMHQnsP/6wzelMQH0R9dv2Bl
	 dv9usTv9TEopl22q8p6k4qLSrMTKkJTCx7O2ob3jwMVJhzFu4wVZrR/DDQL3cPyusW
	 f1ncq+HcFJMxd0P5faF/ym45aEO4lB2OHf+9RKzo=
Received: from [10.42.13.21] ([116.128.244.169])
	by newxmesmtplogicsvrszc13-0.qq.com (NewEsmtp) with SMTP
	id ADB3D0D2; Thu, 17 Apr 2025 15:43:27 +0800
X-QQ-mid: xmsmtpt1744875807t45ml89rq
Message-ID: <tencent_91D93A837FF94A06C7FE8492461472B86D09@qq.com>
X-QQ-XMAILINFO: MQAOa38Yz/8/BA9r/BqbKbAVwM4a+i7NBmueZEdzdR6KAMU83k+uzKboJDM7RH
	 JAOFbIkJgZ1G8J1UbJmuPMoEWGQwVRoAIYMz0OxwGF7/8Ea7nuOaw/oiYVQ2wLr/0HRfny9o36U4
	 gxxrrv4q1TyWGM0/BilAoRkLGF/7OLk+py5OAn/4qHpjmsnYHJGpMbs0kj+pez01BgA1xjCIa7+/
	 EByBvWaFegItErpEMcKGG5Tg2fqQAnyj6tk6/kyUXu2f22DrduMPEtpOoZsbjGvAGBsCXn+BqXnS
	 iQ8IPWuQZHwiY5MNnmotAz2/GldyxAO7RjMFpWt+4Y1dbGaBe5FYfRseUZVxumTU4xYWOxxhA+0L
	 NqZxX5WOF2Rv5dvq7trlYd+du8Tzwe8wlr4HadNSY0q3MFofMv+vmGi4XVjYgxDyiEU/v1J85TGS
	 CGEGwb2HlJbLQpDI1nq04/xYBKGbbLQnakAnj6cQz7OZ0JI8udsNzERg+JYKfRFAVyPIGvixV/1V
	 RO2+31BlgGRZrVbov5zLEZdtGFZxBq/Lgl/XOv1jlCnel5s3Z8UGLxxYvhu0kiCWpVeSZHppfsAx
	 SQmFdu9CkZ5qhOaP0mxzZ9htD6hwWeRhQMvmEzj9gcXkDEC32+dm4owApFv1umu/nQXqJSsBaP2R
	 bY4QJc0c5ndaAps0DDCgqHDB+7ihSNErOKXi47YaO97BVO+i1WnB1g4dv2z+3srx2nLLAHraEsTc
	 je12hgvY+mQI9Bw2dLvbFG7Hlu3ise1sQISIcZYkLujVoLKKaQZvmJ2QBjAKGqdVNq+AjlTJSITq
	 lhqPOxzrIMRd/SEYz9+O+KLiTD0fgx6wHJZ0DdxUtQj9Usp1xgzzJs3TKn96WXaZ1UC5AspI3clH
	 rMziZsQFJKNldETx3JbGDY3SqgFCPlSf0mPPw3reaBiur1VV3WWFpPDaKdp0N13BkbJwyGBbqm3B
	 WtgGCisVqwhV+GI/SQ6GOXm6QtTJXFaD21DuRezLzedNirTRtZ6368tXolkGABclvLybirWE8wIW
	 qY/KOvnAgcXkNoA8is
X-QQ-XMRINFO: NyFYKkN4Ny6FSmKK/uo/jdU=
X-OQ-MSGID: <c1261f4a-2b57-445b-bac8-d199a162bc25@qq.com>
Date: Thu, 17 Apr 2025 15:43:27 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] PM: EM: Fix potential division-by-zero error in
 em_compute_costs()
To: Lukasz Luba <lukasz.luba@arm.com>, rafael@kernel.org
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 Yaxiong Tian <tianyaxiong@kylinos.cn>
References: <tencent_EE27C7D1D6BDB3EE57A2C467CC59A866C405@qq.com>
 <tencent_2256A7C02F7849F1D89390E488704E826D06@qq.com>
 <1ca192e6-3a45-45c6-b4f0-be6a89eaf192@arm.com>
Content-Language: en-US
From: Yaxiong Tian <iambestgod@qq.com>
In-Reply-To: <1ca192e6-3a45-45c6-b4f0-be6a89eaf192@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/4/17 13:57, Lukasz Luba 写道:
> 
> 
> On 4/17/25 02:07, Yaxiong Tian wrote:
>> From: Yaxiong Tian <tianyaxiong@kylinos.cn>
>>
>> When the device is of a non-CPU type, table[i].performance won't be
>> initialized in the previous em_init_performance(), resulting in division
>> by zero when calculating costs in em_compute_costs().
>>
>> Since the 'cost' algorithm is only used for EAS energy efficiency
>> calculations and is currently not utilized by other device drivers, we
>> should add the _is_cpu_device(dev) check to prevent this division-by-zero
>> issue.
>>
>> Fixes: 1b600da51073 ("PM: EM: Optimize em_cpu_energy() and remove 
>> division")
>> Signed-off-by: Yaxiong Tian <tianyaxiong@kylinos.cn>
>> ---
>>   kernel/power/energy_model.c | 4 ++++
>>   1 file changed, 4 insertions(+)
>>
>> diff --git a/kernel/power/energy_model.c b/kernel/power/energy_model.c
>> index d9b7e2b38c7a..41606247c277 100644
>> --- a/kernel/power/energy_model.c
>> +++ b/kernel/power/energy_model.c
>> @@ -233,6 +233,10 @@ static int em_compute_costs(struct device *dev, 
>> struct em_perf_state *table,
>>       unsigned long prev_cost = ULONG_MAX;
>>       int i, ret;
>> +    /* This is needed only for CPUs and EAS skip other devices */
>> +    if (!_is_cpu_device(dev))
>> +        return 0;
>> +
>>       /* Compute the cost of each performance state. */
>>       for (i = nr_states - 1; i >= 0; i--) {
>>           unsigned long power_res, cost;
> 
> 
> Please stop for a while. I have to check what happened that you
> faced the issue in the first place. I have been testing the GPU
> EMs and there was no issues...
> 
> Let me debug that today.

Of course. Since I don't have actual hardware, I can only logically
deduce that this issue might exist.


