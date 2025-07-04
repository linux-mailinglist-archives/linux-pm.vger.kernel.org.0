Return-Path: <linux-pm+bounces-30113-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F1F63AF8DC7
	for <lists+linux-pm@lfdr.de>; Fri,  4 Jul 2025 11:11:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 73B1C1C234CD
	for <lists+linux-pm@lfdr.de>; Fri,  4 Jul 2025 09:12:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 283392F4338;
	Fri,  4 Jul 2025 09:04:38 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFBE52F49E2;
	Fri,  4 Jul 2025 09:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751619878; cv=none; b=CJ8imtzO08Z4cqdUAM+2/CDOaPiQe+joidR8CoYWxkklWzgOGAtKP+yRAhFSz/wIyqDgM2seLWJRxXOCPg92siJuepiwuiKtj8RpyR4NHpbWBS4uJkdnazxAYo8NlfAM0fA1wX2J5vAPdfG5c5BNg2elP5RSg9AiXwuwBpC0ZGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751619878; c=relaxed/simple;
	bh=74zR0IQGlRsiYI2E0BMXAKeqrtVItaULN4XiH6/6OvY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=I4Wfd9ua8hLNUJKj5rgMAChwEV5BFiypT/MpCZJGByR6rjT64c0Q9vQHztDuzAzKFZVkNZNqWC44jfQyIgRc1Ib3BxK1YrNkjwr2/4R2YvKjrUtXo6o7JguF5n66oC8QwcOY8PVhWrtkDcO1cLFuJglFeUgN0gMedyZfJumbR98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4bYSQc5HMnz2qFCK;
	Fri,  4 Jul 2025 17:05:28 +0800 (CST)
Received: from kwepemh100008.china.huawei.com (unknown [7.202.181.93])
	by mail.maildlp.com (Postfix) with ESMTPS id E78E01A0188;
	Fri,  4 Jul 2025 17:04:31 +0800 (CST)
Received: from [10.67.121.90] (10.67.121.90) by kwepemh100008.china.huawei.com
 (7.202.181.93) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 4 Jul
 2025 17:04:31 +0800
Message-ID: <a6a20085-e1c7-4015-b0cc-d4ba4a21be30@huawei.com>
Date: Fri, 4 Jul 2025 17:04:30 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/7] cpufreq: Init policy->rwsem before it may be possibly
 used
To: "Rafael J. Wysocki" <rafael@kernel.org>
CC: <viresh.kumar@linaro.org>, <ionela.voinescu@arm.com>,
	<linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
	<linuxarm@huawei.com>, <jonathan.cameron@huawei.com>,
	<zhanjie9@hisilicon.com>, <lihuisong@huawei.com>, <yubowen8@huawei.com>
References: <20250623133402.3120230-1-zhenglifeng1@huawei.com>
 <20250623133402.3120230-3-zhenglifeng1@huawei.com>
 <CAJZ5v0jHjyPMwB5dt9qv01nXAN5z+Kbztb_Mho0Py0cUqZO+sg@mail.gmail.com>
From: "zhenglifeng (A)" <zhenglifeng1@huawei.com>
In-Reply-To: <CAJZ5v0jHjyPMwB5dt9qv01nXAN5z+Kbztb_Mho0Py0cUqZO+sg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 kwepemh100008.china.huawei.com (7.202.181.93)

On 2025/6/23 23:29, Rafael J. Wysocki wrote:

> On Mon, Jun 23, 2025 at 3:34 PM Lifeng Zheng <zhenglifeng1@huawei.com> wrote:
>>
>> In cpufreq_policy_put_kobj(), policy->rwsem is used. But in
>> cpufreq_policy_alloc(), if freq_qos_add_notifier() returns an error, error
>> path via err_kobj_remove or err_min_qos_notifier will be reached and
>> cpufreq_policy_put_kobj() will be called before policy->rwsem is
>> initialized. Thus, the calling of init_rwsem() should be moved to where
>> before these two error paths can be reached.
> 
> Since this is a fix, any chance to add a Fixes: tag here?

You are right. Will add it. Thanks.

> 
>> Signed-off-by: Lifeng Zheng <zhenglifeng1@huawei.com>
>> ---
>>  drivers/cpufreq/cpufreq.c | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
>> index 1bc665b5bba8..efc1f4ac85cb 100644
>> --- a/drivers/cpufreq/cpufreq.c
>> +++ b/drivers/cpufreq/cpufreq.c
>> @@ -1284,6 +1284,8 @@ static struct cpufreq_policy *cpufreq_policy_alloc(unsigned int cpu)
>>                 goto err_free_real_cpus;
>>         }
>>
>> +       init_rwsem(&policy->rwsem);
>> +
>>         freq_constraints_init(&policy->constraints);
>>
>>         policy->nb_min.notifier_call = cpufreq_notifier_min;
>> @@ -1306,7 +1308,6 @@ static struct cpufreq_policy *cpufreq_policy_alloc(unsigned int cpu)
>>         }
>>
>>         INIT_LIST_HEAD(&policy->policy_list);
>> -       init_rwsem(&policy->rwsem);
>>         spin_lock_init(&policy->transition_lock);
>>         init_waitqueue_head(&policy->transition_wait);
>>         INIT_WORK(&policy->update, handle_update);
>> --
>> 2.33.0
>>
> 


