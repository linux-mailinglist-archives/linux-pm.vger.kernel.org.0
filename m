Return-Path: <linux-pm+bounces-26317-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 05794A9EA4D
	for <lists+linux-pm@lfdr.de>; Mon, 28 Apr 2025 10:07:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 57C6D17649A
	for <lists+linux-pm@lfdr.de>; Mon, 28 Apr 2025 08:07:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3175125334E;
	Mon, 28 Apr 2025 08:07:15 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 407402522B7;
	Mon, 28 Apr 2025 08:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745827635; cv=none; b=tUc6ru6/3smMUOgkUVV8xr7Fa/aDTGa++Zi/gmKqeeWVXml8HAH50noiAyxmn3TOsp1TIbeClsj9uh5rq+AGKocuImIfrOL5Qd9Q3RlatsaoYRoxmFYloNqbDPzapjh88t743Z+WGh+qPxYwbaXXgu8FXhG52RATID2zt/UHIys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745827635; c=relaxed/simple;
	bh=OS4u7BttzmczJ9R95EpzGMv95MuYZJ5HYSD77iITxG0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=VhwzXwGX2pknLHfNs6NAqOIgPqwnq7OBgf5HyACRH0uHdzQGVgJBcrnshLvJYQdDL+Q9VLlHj9MWSrCkhMMyf5UyONbe2CTG6q1ofPZFrvg0lBH5yvSfYzryZK26JfqBsKRZNO+6xnOw+FFSm2CbAgl7BaCKUUI2Cpbd2lidMHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4ZmGCd6vzFz69by;
	Mon, 28 Apr 2025 16:03:09 +0800 (CST)
Received: from kwepemh100008.china.huawei.com (unknown [7.202.181.93])
	by mail.maildlp.com (Postfix) with ESMTPS id 7A89B1400D1;
	Mon, 28 Apr 2025 16:07:03 +0800 (CST)
Received: from [10.67.121.90] (10.67.121.90) by kwepemh100008.china.huawei.com
 (7.202.181.93) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 28 Apr
 2025 16:07:02 +0800
Message-ID: <215066b4-5f61-4a12-91f8-57b3c37ba3e8@huawei.com>
Date: Mon, 28 Apr 2025 16:07:02 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] PM / devfreq: governor: Replace sscanf() with
 kstrtoul() in set_freq_store()
To: David Laight <david.laight.linux@gmail.com>
CC: <myungjoo.ham@samsung.com>, <kyungmin.park@samsung.com>,
	<cw00.choi@samsung.com>, <linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linuxarm@huawei.com>,
	<jonathan.cameron@huawei.com>, <zhanjie9@hisilicon.com>,
	<lihuisong@huawei.com>, <yubowen8@huawei.com>, <cenxinghai@h-partners.com>
References: <20250421030020.3108405-1-zhenglifeng1@huawei.com>
 <20250421030020.3108405-2-zhenglifeng1@huawei.com>
 <20250427121704.51e3af2a@pumpkin>
From: "zhenglifeng (A)" <zhenglifeng1@huawei.com>
In-Reply-To: <20250427121704.51e3af2a@pumpkin>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemh100008.china.huawei.com (7.202.181.93)

On 2025/4/27 19:17, David Laight wrote:
> On Mon, 21 Apr 2025 11:00:17 +0800
> Lifeng Zheng <zhenglifeng1@huawei.com> wrote:
> 
>> Replace sscanf() with kstrtoul() in set_freq_store() and check the result
>> to avoid invalid input.
> 
> Isn't this a UAPI change?
> 
> The sscanf() version will ignore trailing characters.
> In this case it is actually likely that value might have a trailing "Hz".

I tried to still use sscanf() at first, but checkpatch warned: "Prefer
kstrto<type> to single variable sscanf".

I'm not sure if we should ignore this warning.

> 
> 	David
> 
>>
>> Signed-off-by: Lifeng Zheng <zhenglifeng1@huawei.com>
>> ---
>>  drivers/devfreq/governor_userspace.c | 6 +++++-
>>  1 file changed, 5 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/devfreq/governor_userspace.c b/drivers/devfreq/governor_userspace.c
>> index d1aa6806b683..175de0c0b50e 100644
>> --- a/drivers/devfreq/governor_userspace.c
>> +++ b/drivers/devfreq/governor_userspace.c
>> @@ -9,6 +9,7 @@
>>  #include <linux/slab.h>
>>  #include <linux/device.h>
>>  #include <linux/devfreq.h>
>> +#include <linux/kstrtox.h>
>>  #include <linux/pm.h>
>>  #include <linux/mutex.h>
>>  #include <linux/module.h>
>> @@ -39,10 +40,13 @@ static ssize_t set_freq_store(struct device *dev, struct device_attribute *attr,
>>  	unsigned long wanted;
>>  	int err = 0;
>>  
>> +	err = kstrtoul(buf, 0, &wanted);
>> +	if (err)
>> +		return err;
>> +
>>  	mutex_lock(&devfreq->lock);
>>  	data = devfreq->governor_data;
>>  
>> -	sscanf(buf, "%lu", &wanted);
>>  	data->user_frequency = wanted;
>>  	data->valid = true;
>>  	err = update_devfreq(devfreq);
> 
> 


