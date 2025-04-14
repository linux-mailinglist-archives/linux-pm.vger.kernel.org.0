Return-Path: <linux-pm+bounces-25360-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5D69A87B9C
	for <lists+linux-pm@lfdr.de>; Mon, 14 Apr 2025 11:14:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E0153AD029
	for <lists+linux-pm@lfdr.de>; Mon, 14 Apr 2025 09:13:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7AF825D90F;
	Mon, 14 Apr 2025 09:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="pwoHy4he"
X-Original-To: linux-pm@vger.kernel.org
Received: from out203-205-221-173.mail.qq.com (out203-205-221-173.mail.qq.com [203.205.221.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2160A1ACECD;
	Mon, 14 Apr 2025 09:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744622038; cv=none; b=N8NGlA3qdU38xV6GO4Zti5yhO80od8DkIHcZpsoq6yaiaO8wxWdtnOyCMu3iK4U0nZaeo6zyUOAdl/4cqhD8tV3se7BKudUxRtEmA95jbUoOiSoAUXXOuaIMX11JM+8ZE1iAbF4Vn9wC4lNs7D3Q1Y07j837Ao40HNrkORqmmFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744622038; c=relaxed/simple;
	bh=1qqSAJZ/PwAdy62qVn9BQF0MgJ9ab7JoKj7ppdolhW4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mWSMW9As709dwmrFcDRsUM1kmnqHHO5hgv0lndXvfGm8jtAzs540IVAFuV565ZtFvYAhh8UGrdRbBLemYJtSDZby2Fstz7YLiSo04zLqoryThwG+ivZmmPkNqAaY8JJydqJ+RSdlXpcQH9UaELyuz3clmffdHQjsRggxhkAoMdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=pwoHy4he; arc=none smtp.client-ip=203.205.221.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1744621726; bh=JyZI+rw4HfhhbQ/+Fl0XVLkTQxuLHv0Bx+Vl7zI4WkI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=pwoHy4heCDWRWMPmZEyi9eZHxXPzZ5E1pSfHnIB/cXwMRup/uMAXBR/zv9D0hia/x
	 rK9QFksgbuxDBzPoYKSODjLf0yzQvzLEtd8QKa+2NTOdRAiLTwvsbxzRSbC9FVQYHV
	 nEwS7lAkj6HIZVKiz+ZHm/Xy3C5PcRIJnFCDhRvQ=
Received: from [10.42.13.21] ([116.128.244.169])
	by newxmesmtplogicsvrsza29-0.qq.com (NewEsmtp) with SMTP
	id 22C91837; Mon, 14 Apr 2025 17:08:44 +0800
X-QQ-mid: xmsmtpt1744621724tojvj56qr
Message-ID: <tencent_C16C813B177E434BEAC73E842C46D872BC09@qq.com>
X-QQ-XMAILINFO: MUV+lZ/VG+GeMaJWvBPQHXphYXqors6nUDUksAGYKrI59uirbryIhoro5c4cQY
	 tRpKIij4NKeBX2YRDoS193Gji9emLtgDodKiLW9MDi80pSkbYrWG7mQ/roAroqLKsDa4sBHsIYRG
	 +NCNsmCC4qNyk1DRPLpk714a2cYClUbOobrHVF5mUah9R83GgCuXDcxTcsUGo4bjNxDn2GmUZPpZ
	 9FKLcI1/AM0FyBiwosYnTu6m5VaJE7GCSEiZMJ7lNhx19tzhEQzE5riCLSgu7TZfkRZfYpOc/tb8
	 BUpfrGjsbs0f2wqEw6t84gSyiC2SmelYNmoT17lX08Nd5HH2CmK1q8H8Gz//pHrHHo0mpcopm26U
	 XZYi78YMSRIptxcMzkb1kQ9eSbdWcnXNm2UiUVyfV1KukPUgY74w44t+pCmjuQzGQrLIBRGfNotW
	 dwFk5F5XC9VHcT6WOFtmxkcqogm99vcB9/wGYL2MK99zfXcUlrgwTTox/XT8P8jtPNwpXCZe9Gav
	 FNV/r7V9ecUHsPuxKGrVl1CbX6FK8KLjvvHujKU7DmH8Pk4BpywWFVDDz91K4t+rNNojDhmcWLDK
	 Cz8dEdiD+hxtJeAOSzSbSK2L7NheGMKNzAJQVMR3E9el4o9blSIlKCUrd3VtsrwfLSCZYXvg5Nhp
	 G8awqjyWheP4C9jduyQwo8hdpNb51qcmdfTleiMSMYtmdC8TUZo+USI3vq7MnSabcOBwhqxuEJsf
	 7rDdgstgqPNywTzDofi7suEmz/ILFOzjClyy6gaNOVpulqDZ4gWAoNA6xBn5yZoYYx2VJn+/fpbU
	 NEGZP6qYMFHYkVw04Eccuf8wkISkZIfdgKaXH/Enl+y3HiDgsw+o0Tq+cwTCrbre9fWW6L4hnOWB
	 9BLmTkuqmLSQwNKk2iuTas60ouqdoAnUEBk4kP4RCRY/vmz6HlgW5RhPP4GR2zw91T/4zJ/EmMUi
	 2tZ4Ro0iofihY4ccP0QmUo303z0bI9
X-QQ-XMRINFO: Nq+8W0+stu50PRdwbJxPCL0=
X-OQ-MSGID: <e8980e05-5cad-44f9-bda3-56546ba28111@qq.com>
Date: Mon, 14 Apr 2025 17:08:44 +0800
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

Okay.
I wasn’t sure whether the new patch should reuse the current Message-ID
or create a new one, so I checked with ChatGPT and kept the original
Message-ID for v2. If a new Message-ID is required, I can resend the
email.


