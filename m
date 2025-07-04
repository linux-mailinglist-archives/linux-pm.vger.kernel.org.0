Return-Path: <linux-pm+bounces-30118-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A096FAF8ECF
	for <lists+linux-pm@lfdr.de>; Fri,  4 Jul 2025 11:38:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C28B6567B4C
	for <lists+linux-pm@lfdr.de>; Fri,  4 Jul 2025 09:38:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B8E52EE97F;
	Fri,  4 Jul 2025 09:37:22 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FA022ED151;
	Fri,  4 Jul 2025 09:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751621842; cv=none; b=pM+ZcQv959zxk3+HOCfxCZBbL+Pxh0Wurow4UNOUjh/YKrZ6nGumYGtOBvhPnjB4dotMXlVcwtmPZbpzSd/7zmaMTVH5o7VKtGncyixu8JobjIFOIBKanwalwiO76n2aftyG8/arDpDbs2uKAEtkzYZ3jyhtLZ+sWVLZrcatdHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751621842; c=relaxed/simple;
	bh=Q6DU9Maaa5t5RS/a/U5aVXjSaZjINPjf3HaqiEQsUdo=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=X2zBCiVb1E12EeHW5Z2wLku+EY2Xxa/W34puUT0fkKn6f0L2BCc5IIblRqMLGhRhp7qxTqUJ6BUpmYuS7AXIqx/O0WhRjek7SqQYalPuj5HaXLiYdLtokAZ0hI2c8Ya42SfErSdU3SDIvrjLTJWPpI1T7V1hvzQXZu2DUXj08fQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4bYT611KsGztSj6;
	Fri,  4 Jul 2025 17:36:09 +0800 (CST)
Received: from kwepemh100008.china.huawei.com (unknown [7.202.181.93])
	by mail.maildlp.com (Postfix) with ESMTPS id 9F664140156;
	Fri,  4 Jul 2025 17:37:16 +0800 (CST)
Received: from [10.67.121.90] (10.67.121.90) by kwepemh100008.china.huawei.com
 (7.202.181.93) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 4 Jul
 2025 17:37:15 +0800
Message-ID: <ea80d7ce-4e5b-4817-a795-6400835c252d@huawei.com>
Date: Fri, 4 Jul 2025 17:37:15 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/7] cpufreq: Refactor code about starting governor in
 cpufreq_set_policy()
To: "Rafael J. Wysocki" <rafael@kernel.org>
CC: <viresh.kumar@linaro.org>, <ionela.voinescu@arm.com>,
	<linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
	<linuxarm@huawei.com>, <jonathan.cameron@huawei.com>,
	<zhanjie9@hisilicon.com>, <lihuisong@huawei.com>, <yubowen8@huawei.com>
References: <20250623133402.3120230-1-zhenglifeng1@huawei.com>
 <20250623133402.3120230-7-zhenglifeng1@huawei.com>
 <CAJZ5v0huLAM5XaGr1MWOwL5V-p7KX-ea7FYGx70GPwyVHETnHg@mail.gmail.com>
From: "zhenglifeng (A)" <zhenglifeng1@huawei.com>
In-Reply-To: <CAJZ5v0huLAM5XaGr1MWOwL5V-p7KX-ea7FYGx70GPwyVHETnHg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 kwepemh100008.china.huawei.com (7.202.181.93)

On 2025/6/23 23:13, Rafael J. Wysocki wrote:

> On Mon, Jun 23, 2025 at 3:34 PM Lifeng Zheng <zhenglifeng1@huawei.com> wrote:
>>
>> Refactor code about starting governor without functional change in
>> cpufreq_set_policy() to make it more readable.
> 
> Sorry, but I don't see the point.

Just some refactoring to reduce nest level and make the style more similar
to other code in this file. If you don't like it, I'll drop it.

> 
>> Signed-off-by: Lifeng Zheng <zhenglifeng1@huawei.com>
>> ---
>>  drivers/cpufreq/cpufreq.c | 16 ++++++++++------
>>  1 file changed, 10 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
>> index 9b2578b905a5..7b82ffb50283 100644
>> --- a/drivers/cpufreq/cpufreq.c
>> +++ b/drivers/cpufreq/cpufreq.c
>> @@ -2698,15 +2698,19 @@ static int cpufreq_set_policy(struct cpufreq_policy *policy,
>>         /* start new governor */
>>         policy->governor = new_gov;
>>         ret = cpufreq_init_governor(policy);
>> -       if (!ret) {
>> -               ret = cpufreq_start_governor(policy);
>> -               if (!ret) {
>> -                       pr_debug("governor change\n");
>> -                       return 0;
>> -               }
>> +       if (ret)
>> +               goto start_old_gov;
>> +
>> +       ret = cpufreq_start_governor(policy);
>> +       if (ret) {
>>                 cpufreq_exit_governor(policy);
>> +               goto start_old_gov;
>>         }
>>
>> +       pr_debug("governor change\n");
>> +       return 0;
>> +
>> +start_old_gov:
>>         /* new governor failed, so re-start old one */
>>         pr_debug("starting governor %s failed\n", policy->governor->name);
>>         if (old_gov) {
>> --
> 


