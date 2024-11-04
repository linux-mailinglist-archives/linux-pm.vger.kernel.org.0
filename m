Return-Path: <linux-pm+bounces-16930-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C22839BAF77
	for <lists+linux-pm@lfdr.de>; Mon,  4 Nov 2024 10:20:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 86948281753
	for <lists+linux-pm@lfdr.de>; Mon,  4 Nov 2024 09:20:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C05D189BB1;
	Mon,  4 Nov 2024 09:20:02 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B71A96FC5;
	Mon,  4 Nov 2024 09:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730712002; cv=none; b=LVCGxO6Bqi3ESbOX4sFOUh3S1+cUq8rLCSmzaLbJtGE95dNMzlw8J7fG+qs+VrCS+pHcxeXpvtT/Zd5s0HirsIkqMKoe3Gkloz1njk4WzYIVAmBENqG02oZXWAWftWUPgJc7bcJO7Rjz5V3UE/6OCFM0IEji1QET1xOhollinLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730712002; c=relaxed/simple;
	bh=d40EuAh3tUcVyTpp9VXfJo/oyZXIJQpqGulWbvnIQsg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Pmky6rShdsCZLXveHIjCwACgaAhPK99kV40Czed9ddIQTeL7SEsB8wZFGZj8ImezhoeYQocJJ6dinExxH8HIdk6jIi/2SwdKJGN2REkGPYTn+GQekx6WTJHYQeRZMzcIVg8kjGoacJ2piviTV0rwPVWlm89i9u8JLcHBe0OBjI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Xhm8M0f95z10PY5;
	Mon,  4 Nov 2024 17:17:39 +0800 (CST)
Received: from kwepemg200008.china.huawei.com (unknown [7.202.181.35])
	by mail.maildlp.com (Postfix) with ESMTPS id 9F585140FA1;
	Mon,  4 Nov 2024 17:19:56 +0800 (CST)
Received: from [10.67.109.254] (10.67.109.254) by
 kwepemg200008.china.huawei.com (7.202.181.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 4 Nov 2024 17:19:55 +0800
Message-ID: <1dcc31f7-1ea9-a595-5ab9-9de4d7130f0b@huawei.com>
Date: Mon, 4 Nov 2024 17:19:55 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH] PM: EM: Fix uninitialized power in em_create_perf_table
Content-Language: en-US
To: Lukasz Luba <lukasz.luba@arm.com>
CC: <rafael@kernel.org>, <pavel@ucw.cz>, <len.brown@intel.com>,
	<linux-pm@vger.kernel.org>, <daniel.lezcano@linaro.org>,
	<linux-kernel@vger.kernel.org>, <qperret@google.com>
References: <20241104090351.1352997-1-ruanjinjie@huawei.com>
 <3386f37a-55f4-43e0-a991-7cf4ece2e55a@arm.com>
From: Jinjie Ruan <ruanjinjie@huawei.com>
In-Reply-To: <3386f37a-55f4-43e0-a991-7cf4ece2e55a@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemg200008.china.huawei.com (7.202.181.35)



On 2024/11/4 17:14, Lukasz Luba wrote:
> Hi Jinjie,
> 
> On 11/4/24 09:03, Jinjie Ruan wrote:
>> In em_create_perf_table(), power is uninitialized and passed the pointer
>> to active_power() hook, but the hook function may not assign it and
>> return 0, such as mtk_cpufreq_get_cpu_power(), so the later zero check
>> for
> 
> Please fix the driver. I have checked that function. It must return
> -EINVAL when the 'policy' is not found. We cannot progress with power=0.

Thank you very much! It will be also good to fix the driver.

> 
> 
>> power is not invalid, initialize power to zero to fix it.
>>
>> Cc: stable@vger.kernel.org
>> Fixes: 7d9895c7fbfc ("PM / EM: introduce em_dev_register_perf_domain
>> function")
>> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
>> ---
>>   kernel/power/energy_model.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/kernel/power/energy_model.c b/kernel/power/energy_model.c
>> index 927cc55ba0b3..866a3e9c05b2 100644
>> --- a/kernel/power/energy_model.c
>> +++ b/kernel/power/energy_model.c
>> @@ -344,7 +344,7 @@ static int em_create_perf_table(struct device
>> *dev, struct em_perf_domain *pd,
>>                   struct em_data_callback *cb,
>>                   unsigned long flags)
>>   {
>> -    unsigned long power, freq, prev_freq = 0;
>> +    unsigned long power = 0, freq, prev_freq = 0;
>>       int nr_states = pd->nr_perf_states;
>>       int i, ret;
>>   
> 
> 
> This patch proposal is just a workaround.
> 
> When you send a patch to that MTK driver, I can review it for you so
> please add me on CC.
> 
> Regards,
> Lukasz
> 

