Return-Path: <linux-pm+bounces-17102-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 049089C0396
	for <lists+linux-pm@lfdr.de>; Thu,  7 Nov 2024 12:14:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 361261C213D6
	for <lists+linux-pm@lfdr.de>; Thu,  7 Nov 2024 11:14:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B0AD1F4279;
	Thu,  7 Nov 2024 11:14:36 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B40891E2601;
	Thu,  7 Nov 2024 11:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730978076; cv=none; b=YktkMje6v6Xo3OAapx8WWJG+TaGAYsW+jEizmzZ9wB9NIe4WvRxT7UaP0aU1AUMxmdsasPaBtmjk4tRceMiQBWZHet4fxAwkjZ8ycPfFsEt492MGDQ/lHP7l/wTENhko/VE5jI63gL5/XUAaJ0fFfdBJ1lvOoCrCMJLg7PHDXNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730978076; c=relaxed/simple;
	bh=wKksMUfW/1iTIUd2EHFCVSqjEASCCmtdjLb41c6jTOE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=V0CsZMvjvWtbgFH1yoFUNml6anLt6NvgcNN4yZ4r8QjHdQNd+6FmMV/xcQlEgmWC4ZHqhd3A4JeJ/8GMKV6igkB7SqO+YdYlssjbVqoSg9MrM5rfjw7ZwO3tgBEGWlwuoOw0iyy0VBYVSgCvfI9+ty9PqznaQBzXFgdm3Yd4h7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4XkfZW6h0nz20snH;
	Thu,  7 Nov 2024 19:13:23 +0800 (CST)
Received: from kwepemg200008.china.huawei.com (unknown [7.202.181.35])
	by mail.maildlp.com (Postfix) with ESMTPS id EF6A3140136;
	Thu,  7 Nov 2024 19:14:31 +0800 (CST)
Received: from [10.67.109.254] (10.67.109.254) by
 kwepemg200008.china.huawei.com (7.202.181.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 7 Nov 2024 19:14:31 +0800
Message-ID: <8364b0cd-5171-7e76-d450-6593395dce61@huawei.com>
Date: Thu, 7 Nov 2024 19:14:30 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH v2] PM: EM: Fix wrong return value in
 mtk_cpufreq_get_cpu_power()
Content-Language: en-US
To: "Rafael J. Wysocki" <rafael@kernel.org>, <viresh.kumar@linaro.org>
CC: <matthias.bgg@gmail.com>, <angelogioacchino.delregno@collabora.com>,
	<hector.yuan@mediatek.com>, <lukasz.luba@arm.com>, <qperret@google.com>,
	<linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-mediatek@lists.infradead.org>
References: <20241104113615.1397410-1-ruanjinjie@huawei.com>
 <786c90d1-29e7-72a7-acc6-394b3bbaeb75@huawei.com>
 <CAJZ5v0jC9_03euACrmahnDRBgU=0O60p0rkChR2BVOxx0J2Pzw@mail.gmail.com>
From: Jinjie Ruan <ruanjinjie@huawei.com>
In-Reply-To: <CAJZ5v0jC9_03euACrmahnDRBgU=0O60p0rkChR2BVOxx0J2Pzw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemg200008.china.huawei.com (7.202.181.35)



On 2024/11/7 18:58, Rafael J. Wysocki wrote:
> On Thu, Nov 7, 2024 at 2:50 AM Jinjie Ruan <ruanjinjie@huawei.com> wrote:
>>
>>
>>
>> On 2024/11/4 19:36, Jinjie Ruan wrote:
>>> mtk_cpufreq_get_cpu_power() return 0 if the policy is NULL. Then in
>>> em_create_perf_table(), the later zero check for power is not invalid
>>> as power is uninitialized. As Lukasz suggested, it must return -EINVAL when
>>> the 'policy' is not found. So return -EINVAL to fix it.
>>>
>>> Cc: stable@vger.kernel.org
>>> Fixes: 4855e26bcf4d ("cpufreq: mediatek-hw: Add support for CPUFREQ HW")
>>> Suggested-by: Lukasz Luba <lukasz.luba@arm.com>
>>> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
>>
>> Hi, could this be merged.
> 
> It's for Viresh to take care of and please replace the "PM: EM:"
> prefix in the subject with the proper cpufreq driver one.

Thank you for your kind reminder.

> 
> Thanks!
> 
>>> ---
>>> v2:
>>> - Fix the driver instead of em_create_perf_table() as suggested.
>>> - Update the commit message.
>>> - Add Suggested-by.
>>> ---
>>>  drivers/cpufreq/mediatek-cpufreq-hw.c | 2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/cpufreq/mediatek-cpufreq-hw.c b/drivers/cpufreq/mediatek-cpufreq-hw.c
>>> index 8925e096d5b9..aeb5e6304542 100644
>>> --- a/drivers/cpufreq/mediatek-cpufreq-hw.c
>>> +++ b/drivers/cpufreq/mediatek-cpufreq-hw.c
>>> @@ -62,7 +62,7 @@ mtk_cpufreq_get_cpu_power(struct device *cpu_dev, unsigned long *uW,
>>>
>>>       policy = cpufreq_cpu_get_raw(cpu_dev->id);
>>>       if (!policy)
>>> -             return 0;
>>> +             return -EINVAL;
>>>
>>>       data = policy->driver_data;
>>>

