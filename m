Return-Path: <linux-pm+bounces-20739-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E839A17744
	for <lists+linux-pm@lfdr.de>; Tue, 21 Jan 2025 07:23:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3943E188A36A
	for <lists+linux-pm@lfdr.de>; Tue, 21 Jan 2025 06:23:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1604919F101;
	Tue, 21 Jan 2025 06:23:14 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 240A485931;
	Tue, 21 Jan 2025 06:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737440594; cv=none; b=oPXh5dkUfZw0gq/Nr9dU7Bw+jdZLl/GH4NwQe6BYUCTxripG+jlDTNHSxJnCNlxF7LT9+UGX46W8DmtUOg2oG190AMS0fiY5XHGU6veu+q11ATwbupfBXwZzcgIKMXu5d49lu04ox5nvaLgZU6sAE9RNdbua78RkjYT2IrUaEuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737440594; c=relaxed/simple;
	bh=Q3BlAUuMMxmJJwW+ElGlFONfYopKdKJGV4ozPBV+u90=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=bppOdyP6vvun5P7FaWaxIeAhX0WleGYsuXmw5hKMfxPKUCFtWzjWFOBYVzJuvA3adJfPtK4u0GrdL1uSHSKIrhYYo1FN0lZ4g+xw+7EW8pb8ithj1ljzVquU67pXGyYPPNexHepOV52oNh6NgLIFnsLfeODh1CaGio+DNkzN658=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4YccW25Hkdz1kysl;
	Tue, 21 Jan 2025 14:19:42 +0800 (CST)
Received: from kwepemh100008.china.huawei.com (unknown [7.202.181.93])
	by mail.maildlp.com (Postfix) with ESMTPS id 429F61402C3;
	Tue, 21 Jan 2025 14:23:00 +0800 (CST)
Received: from [10.67.121.90] (10.67.121.90) by kwepemh100008.china.huawei.com
 (7.202.181.93) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 21 Jan
 2025 14:22:59 +0800
Message-ID: <2f9433f1-a826-4198-b4aa-9089f566916f@huawei.com>
Date: Tue, 21 Jan 2025 14:22:59 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/4] cpufreq: Introduce a more generic way to set
 default per-policy boost flag
To: Viresh Kumar <viresh.kumar@linaro.org>
CC: <rafael@kernel.org>, <linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linuxarm@huawei.com>,
	<jonathan.cameron@huawei.com>, <zhanjie9@hisilicon.com>,
	<lihuisong@huawei.com>, <fanghao11@huawei.com>
References: <20250117101457.1530653-1-zhenglifeng1@huawei.com>
 <20250117101457.1530653-3-zhenglifeng1@huawei.com>
 <20250120090102.erm2ffkbnwa5vraa@vireshk-i7>
 <0c910772-368b-4e30-9ce2-1f68510703c4@huawei.com>
 <20250121042024.pstn2otfqnnajgxl@vireshk-i7>
From: "zhenglifeng (A)" <zhenglifeng1@huawei.com>
In-Reply-To: <20250121042024.pstn2otfqnnajgxl@vireshk-i7>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemh100008.china.huawei.com (7.202.181.93)

On 2025/1/21 12:20, Viresh Kumar wrote:

> On 21-01-25, 09:45, zhenglifeng (A) wrote:
>> On 2025/1/20 17:01, Viresh Kumar wrote:
>>> On 17-01-25, 18:14, Lifeng Zheng wrote:
>>>> +	/* Let the per-policy boost flag mirror the cpufreq_driver boost during init */
>>>> +	if (policy->boost_enabled != cpufreq_boost_enabled()) {
>>>> +		policy->boost_enabled = cpufreq_boost_enabled();
>>>> +		ret = cpufreq_driver->set_boost(policy, policy->boost_enabled);
>>>
>>> I though you agreed to do some optimization here ?
>>
>> Sorry. Do I miss something here?
> 
> https://lore.kernel.org/all/17c7ed77-21f1-4093-91fc-f3eaa863d312@huawei.com/
> 

I think I already done that, isn't it?


