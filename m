Return-Path: <linux-pm+bounces-30112-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D12AAF8DF6
	for <lists+linux-pm@lfdr.de>; Fri,  4 Jul 2025 11:15:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3DC597628A2
	for <lists+linux-pm@lfdr.de>; Fri,  4 Jul 2025 09:09:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCCBD2FC3D4;
	Fri,  4 Jul 2025 09:03:43 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6AEB2EBDF6;
	Fri,  4 Jul 2025 09:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751619823; cv=none; b=JW0Lnwn+RDQkm0tVA/1Z6ZpT4g4J/mZyJ8A9DfMrXBWXbQZggEL1M/P3H+RL5ZRTX1JG3BW6U3LGYnwGrdwBMugXwzNs8HDXYmlPvV2O7Xrlrpf2apEZ1cNrKcVt9+1XCnBcyBis/OrVsgoB8sK24S91avmIdjFNr5GM9ht5FWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751619823; c=relaxed/simple;
	bh=+Gg52JJf0j0VZxb05WhHWNL8qJGcoNd3eehmGfF4JKQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=kIwM78jeI52TbbBbOPRYwIdEPfXVXzaZlqhtEXOW7FcflDa1nReATvsQF6m0WWkuZQtg5xXwmftK6qW03YJzGlSGUMT0mFiG3hG00XZGA7NCue5QsGovB16j35ZnrmDHDpO8li3DcqG0CK7h9FcGIjUeoUrJNlsp6LDSdNBVbNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4bYSKR6m58zZcGn;
	Fri,  4 Jul 2025 17:00:59 +0800 (CST)
Received: from kwepemh100008.china.huawei.com (unknown [7.202.181.93])
	by mail.maildlp.com (Postfix) with ESMTPS id 3D746140258;
	Fri,  4 Jul 2025 17:03:32 +0800 (CST)
Received: from [10.67.121.90] (10.67.121.90) by kwepemh100008.china.huawei.com
 (7.202.181.93) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 4 Jul
 2025 17:03:31 +0800
Message-ID: <496ade71-6e77-4dea-88ca-a47322fa81c0@huawei.com>
Date: Fri, 4 Jul 2025 17:03:31 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/7] cpufreq: Disable cpufreq-based invariance when fail
 to register driver
To: "Rafael J. Wysocki" <rafael@kernel.org>
CC: <viresh.kumar@linaro.org>, <ionela.voinescu@arm.com>,
	<linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
	<linuxarm@huawei.com>, <jonathan.cameron@huawei.com>,
	<zhanjie9@hisilicon.com>, <lihuisong@huawei.com>, <yubowen8@huawei.com>
References: <20250623133402.3120230-1-zhenglifeng1@huawei.com>
 <20250623133402.3120230-2-zhenglifeng1@huawei.com>
 <CAJZ5v0hnb3q1bdsgKDL+E0QG92ju8DoEU-=Rk9cfu7Q8QEBB8Q@mail.gmail.com>
From: "zhenglifeng (A)" <zhenglifeng1@huawei.com>
In-Reply-To: <CAJZ5v0hnb3q1bdsgKDL+E0QG92ju8DoEU-=Rk9cfu7Q8QEBB8Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 kwepemh100008.china.huawei.com (7.202.181.93)

On 2025/6/23 23:27, Rafael J. Wysocki wrote:

> On Mon, Jun 23, 2025 at 3:34 PM Lifeng Zheng <zhenglifeng1@huawei.com> wrote:
>>
>> The cpufreq-based invariance is enabled in cpufreq_register_driver(), but
>> never disabled after that when fail. Add a
>> static_branch_disable_cpuslocked() to do that as
>> cpufreq_unregister_driver() does.
> 
> What about moving the invariance initialization to the point when 0 is
> going to be returned?

Yes, that'll do it, too, thank you.

> 
>> Fixes: 874f63531064 ("cpufreq: report whether cpufreq supports Frequency Invariance (FI)")
>> Signed-off-by: Lifeng Zheng <zhenglifeng1@huawei.com>
>> ---
>>  drivers/cpufreq/cpufreq.c | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
>> index d7426e1d8bdd..1bc665b5bba8 100644
>> --- a/drivers/cpufreq/cpufreq.c
>> +++ b/drivers/cpufreq/cpufreq.c
>> @@ -2991,6 +2991,7 @@ int cpufreq_register_driver(struct cpufreq_driver *driver_data)
>>  err_boost_unreg:
>>         remove_boost_sysfs_file();
>>  err_null_driver:
>> +       static_branch_disable_cpuslocked(&cpufreq_freq_invariance);
>>         write_lock_irqsave(&cpufreq_driver_lock, flags);
>>         cpufreq_driver = NULL;
>>         write_unlock_irqrestore(&cpufreq_driver_lock, flags);
>> --


