Return-Path: <linux-pm+bounces-25420-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EC50A8910A
	for <lists+linux-pm@lfdr.de>; Tue, 15 Apr 2025 03:13:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2030D3A77F1
	for <lists+linux-pm@lfdr.de>; Tue, 15 Apr 2025 01:12:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E533D199949;
	Tue, 15 Apr 2025 01:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="exO+S9i/"
X-Original-To: linux-pm@vger.kernel.org
Received: from out162-62-57-64.mail.qq.com (out162-62-57-64.mail.qq.com [162.62.57.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C86B3EAC7;
	Tue, 15 Apr 2025 01:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744679584; cv=none; b=bTzsCf8iyV40UWWgICMz2ivdntqDaZVRiefJjYfPUxVOswIcLojhrp+pi/DECcOmLrZOPoRZybXzc5D0IgbT73YnjfYP+DuSL1fYy0IIGrK6Vqf2q3kyEGWvAK9bjPBw9C5aJUZ85+84t8I+SyjiCUmGfI45taxHIaPVHYvncko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744679584; c=relaxed/simple;
	bh=84YCmoE01lUz2YapbrjPW8M0/IKGwioAWUGj+qkTfDw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=n92nvFp6LdwOV9Hyx5c5dA4mR8Dib5pt5oxTLSDiV9ahE79UCK+2Ke5wL/6hK9Lfmu7qz9JKWI+b5Mfwfm3JWbJH+bvgmnrb8exT1ppvXbtPeb4u7guiYCMKCxnq584RGMG8OopVQ/FsSf9VZTwNj+Kwoa+00EKpdFndkk6xmBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=exO+S9i/; arc=none smtp.client-ip=162.62.57.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1744679574; bh=YUfCUXc9dLZAgNOChQgWAb9EGyfeu6+s4QfhyEy+3bw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=exO+S9i/7cpNjHciwzQtrjRi0Npr3sdxBbAv9aktvV9OQbGRJcZwSzfUSKPbprM+x
	 YXlmybLUwBuHgG6ghO0ilv881s2ijqIot/gDWwXCPGMspot16JiPadYboybARRVDo0
	 QOgqleOsq+qJsFgpjfXDHG9iommHoOwBfB5iPrGI=
Received: from [10.42.13.21] ([116.128.244.169])
	by newxmesmtplogicsvrszc16-0.qq.com (NewEsmtp) with SMTP
	id 3343ACA5; Tue, 15 Apr 2025 09:12:52 +0800
X-QQ-mid: xmsmtpt1744679572tl5xrvhpq
Message-ID: <tencent_AE7CE43CDAD6747AFF0E952C8D0908A98D0A@qq.com>
X-QQ-XMAILINFO: OVAgSpUT8SOPvEgLvZV/uG70/5NHHXIy7HWky6Qmc4Qyt2WEHHhTQRsok7f0wY
	 0aZrNczMkcwgXyXxHyd6M6gJfd2XEy0e8I9u7JKbfvMFzz8y6e/HITuw8ZQxYSQqBOP+50lNEbkf
	 reJwJuXvqg6NNgj6QBnURVWHma28IaIe81kaZozWFMdWEpR00J5lXUlm/qAeIuGOiF+UqXEZXB+w
	 q6mX84savOHARMEuwphCJZmsAfjwqhiv8j+nqap+HWxWmfws6DQjAtcNK6lTPPEFcyMw4Twycmcb
	 u6m4Zdiv08l8rNOr96ITTpxsv5871M7+Iwd3gI9UYUE5jeOiZMfvuWwv0qqeitU6thDXsCT36/uU
	 h7t3TH34ZKf+iQY/PWgestHeAkcX21gbgDVqQqKmY7jxMHQEpCMDkLzkoka08CwN2HpZA4OKcSM0
	 C7iJiTUwL9P7Fz5BUXU5iQprhXuevSU7rRKJjr69ulwe78MxmYC32sfJJKn2fsHjkFzM3iyBsWWw
	 u/GPXcX3OKeq2yyrePC4S8JeiqsUx/foS4kN0wB+jdbZ5HttEozX9XAs8/5FxBvz9rexYLNzgpao
	 wi+hwsvQHKIjqdL2e5D/cZhKGush7J+w8L4en9vK7ne8Fq6PF6IYI8qLM7mP6o6MQHx6EL40dEDq
	 j9jVVLibLGjYTe+2agONkCtegYnLd5WHIq+cNEQjiQxiqccYincxG1yQSRmJKyifIoiz45MB9U71
	 zngTbwqiIXFGRYtn9Eyuw7dan7vb6gyxVcMqXtmp2Ol+9QYHdepVXzGP7bPHHvLbKFYRzLvaDp1G
	 p1DOFS0ra6vlU9a1MoDIV/zO4EbDQSvryd9v5RlQs0RhP5+vvWQTs7e353+nwpUWLkzriXVje+6m
	 x4MvxM2FzfSvrDSC0h76tHPwC+KszuRu5hiWN/R5IjZi5blqjH6tz0UenGjWJ61cEFHGOOaX2UEp
	 GltgMleO4=
X-QQ-XMRINFO: Mp0Kj//9VHAxr69bL5MkOOs=
X-OQ-MSGID: <b1cd955e-3d10-4251-9d83-cd73401ef3e2@qq.com>
Date: Tue, 15 Apr 2025 09:12:51 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] PM: EM: Fix potential division-by-zero error in
 em_compute_costs()
To: Lukasz Luba <lukasz.luba@arm.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 Yaxiong Tian <tianyaxiong@kylinos.cn>, rafael@kernel.org
References: <tencent_EE27C7D1D6BDB3EE57A2C467CC59A866C405@qq.com>
 <143378b0-5740-4f2b-9a79-f04cf9ef1f77@arm.com>
Content-Language: en-US
From: Yaxiong Tian <iambestgod@qq.com>
In-Reply-To: <143378b0-5740-4f2b-9a79-f04cf9ef1f77@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/4/14 16:08, Lukasz Luba 写道:
> Hi Yaxiong,
> 
> On 4/11/25 02:28, Yaxiong Tian wrote:
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
>> Fixes: <1b600da51073> ("PM: EM: Optimize em_cpu_energy() and remove 
>> division")
>> Signed-off-by: Yaxiong Tian <tianyaxiong@kylinos.cn>
>> ---
>>   kernel/power/energy_model.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/kernel/power/energy_model.c b/kernel/power/energy_model.c
>> index d9b7e2b38c7a..d1fa7e8787b5 100644
>> --- a/kernel/power/energy_model.c
>> +++ b/kernel/power/energy_model.c
>> @@ -244,7 +244,7 @@ static int em_compute_costs(struct device *dev, 
>> struct em_perf_state *table,
>>                       cost, ret);
>>                   return -EINVAL;
>>               }
>> -        } else {
>> +        } else if (_is_cpu_device(dev)) {
>>               /* increase resolution of 'cost' precision */
>>               power_res = table[i].power * 10;
>>               cost = power_res / table[i].performance;
> 
> 
> As the test robot pointed out, please set the 'cost' to 0
> where it's declared.
> 
> The rest should be fine.
> 
> Regards,
> Lukasz

Sorry, the V3 version with cost=0 still has issues.

I noticed that if the cost is set to 0, the condition "if (table[i].cost
  >= prev_cost)" in the following code will always evaluate to true. This
  will incorrectly set the flags to EM_PERF_STATE_INEFFICIENT.

Should we change ">=" to ">"?







