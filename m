Return-Path: <linux-pm+bounces-30119-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EFCA6AF8ED7
	for <lists+linux-pm@lfdr.de>; Fri,  4 Jul 2025 11:39:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD5BE561BD0
	for <lists+linux-pm@lfdr.de>; Fri,  4 Jul 2025 09:38:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4C142EACEC;
	Fri,  4 Jul 2025 09:38:24 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A67B3288519;
	Fri,  4 Jul 2025 09:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751621904; cv=none; b=D7HZUv6X4pxwdAMe0vx+oA1OdiH47f6/P8E0CZwGVXb/oZCamWZcwFe//eTy8fP5KVgNys6nhtt/nkgAYdNOUDzUXx3vqOdf/N1ZoRkCc2WZWLnbVZ/YiB/5YD0pqBaNloeTgY1Z7b9GUmfROWcf0fVXJNpyGc0phD3s2FIvdzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751621904; c=relaxed/simple;
	bh=yHlVwFo1lvJkn9EREZZHeIKuge4a8SF1Sq9If1qBrSo=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=A+EslDLhLAG8YRmSenYKQRi7imGcK7ZqdvB5eyAy9wY8LJw5oRyJhph4oKq/l4eyQC3bKXrCeLdv9G0JZf3CQbZVaM5R36HCf2KTLmOG8gFL9cBWiMQzTuuxdtjrMmaFBieHNdR98d22QQ59VEsItt6noq8QhGZSFDCZfAbV2Uc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4bYT5b5phCzZhtT;
	Fri,  4 Jul 2025 17:35:47 +0800 (CST)
Received: from kwepemh100008.china.huawei.com (unknown [7.202.181.93])
	by mail.maildlp.com (Postfix) with ESMTPS id 2571E140156;
	Fri,  4 Jul 2025 17:38:20 +0800 (CST)
Received: from [10.67.121.90] (10.67.121.90) by kwepemh100008.china.huawei.com
 (7.202.181.93) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 4 Jul
 2025 17:38:19 +0800
Message-ID: <7c509446-7925-4bcb-97c5-1a6082550d96@huawei.com>
Date: Fri, 4 Jul 2025 17:38:19 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/7] cpufreq: Exit governor when failed to start old
 governor
To: "Rafael J. Wysocki" <rafael@kernel.org>
CC: <viresh.kumar@linaro.org>, <ionela.voinescu@arm.com>,
	<linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
	<linuxarm@huawei.com>, <jonathan.cameron@huawei.com>,
	<zhanjie9@hisilicon.com>, <lihuisong@huawei.com>, <yubowen8@huawei.com>
References: <20250623133402.3120230-1-zhenglifeng1@huawei.com>
 <20250623133402.3120230-8-zhenglifeng1@huawei.com>
 <CAJZ5v0hizEYaJw77feqAoHJWYuANvbdxZ6BbogZ52sTU2eKTUA@mail.gmail.com>
From: "zhenglifeng (A)" <zhenglifeng1@huawei.com>
In-Reply-To: <CAJZ5v0hizEYaJw77feqAoHJWYuANvbdxZ6BbogZ52sTU2eKTUA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 kwepemh100008.china.huawei.com (7.202.181.93)

On 2025/6/23 23:12, Rafael J. Wysocki wrote:

> On Mon, Jun 23, 2025 at 3:34 PM Lifeng Zheng <zhenglifeng1@huawei.com> wrote:
>>
>> Detect the result of starting old governor in cpufreq_set_policy(). If it
>> fails, exit the governor and clear policy->governor.
>>
>> Signed-off-by: Lifeng Zheng <zhenglifeng1@huawei.com>
>> ---
>>  drivers/cpufreq/cpufreq.c | 8 +++++---
>>  1 file changed, 5 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
>> index 7b82ffb50283..2b431845a8a3 100644
>> --- a/drivers/cpufreq/cpufreq.c
>> +++ b/drivers/cpufreq/cpufreq.c
>> @@ -2715,10 +2715,12 @@ static int cpufreq_set_policy(struct cpufreq_policy *policy,
>>         pr_debug("starting governor %s failed\n", policy->governor->name);
>>         if (old_gov) {
>>                 policy->governor = old_gov;
>> -               if (cpufreq_init_governor(policy))
>> +               if (cpufreq_init_governor(policy)) {
>>                         policy->governor = NULL;
>> -               else
>> -                       cpufreq_start_governor(policy);
>> +               } else if (cpufreq_start_governor(policy)) {
>> +                       cpufreq_exit_governor(policy);
> 
> This may introduce a governor module reference imbalance AFAICS.

Sorry, I don't really understand this. Could you explain more? Thanks.

> 
>> +                       policy->governor = NULL;
>> +               }
>>         }
>>
>>         return ret;
>> --
> 


