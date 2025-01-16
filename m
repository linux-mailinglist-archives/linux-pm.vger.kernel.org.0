Return-Path: <linux-pm+bounces-20521-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 855A2A130EE
	for <lists+linux-pm@lfdr.de>; Thu, 16 Jan 2025 02:51:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B417B1888ECC
	for <lists+linux-pm@lfdr.de>; Thu, 16 Jan 2025 01:51:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32FED36AF5;
	Thu, 16 Jan 2025 01:51:41 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0133728E37;
	Thu, 16 Jan 2025 01:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736992301; cv=none; b=T6oe9LmQ3Xmylz/KsUwsq9qrbLKKJG8anbp3+KBBD7v+FDsmI9tN3/C5NrJfc5ncvxD3It9qHCSuQea0Jqog5pce0uM145NuoVc9rZQlADzN6LFXvq0uboaG3aW33s/Oft3ACeMS7Xpq/s6OqggSidxvfUGWvOjMQqzM3Pq5C40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736992301; c=relaxed/simple;
	bh=xtffX8k62NoCjC4yop20Aq8ZduDLVsKfFoubw2cCQJw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=nAfLKeX+padZ57alpkPnvX9SksFLJw4yqZ3GCP9WlNUTjeHXzMrvX9KOSCemMWz9pmmgz2h5a28Qk6U/dtkX/ZEcc/NYl+ZgHKIsY40MghN18WtQoD8Bd+0P/av0ihQbTu28cB2YdYidOW/Qkk5rPVmjDw+TizWA2UiVHplQNRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4YYQkC1vvCzbkCh;
	Thu, 16 Jan 2025 09:48:19 +0800 (CST)
Received: from kwepemh100008.china.huawei.com (unknown [7.202.181.93])
	by mail.maildlp.com (Postfix) with ESMTPS id D2347180101;
	Thu, 16 Jan 2025 09:51:27 +0800 (CST)
Received: from [10.67.121.90] (10.67.121.90) by kwepemh100008.china.huawei.com
 (7.202.181.93) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 16 Jan
 2025 09:51:27 +0800
Message-ID: <5a404c4b-686c-4686-94be-8785cb44fc46@huawei.com>
Date: Thu, 16 Jan 2025 09:51:26 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] cpufreq: Fix re-boost issue after hotplugging a cpu
To: "Rafael J. Wysocki" <rafael@kernel.org>, Viresh Kumar
	<viresh.kumar@linaro.org>
CC: <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linuxarm@huawei.com>, <jonathan.cameron@huawei.com>,
	<zhanjie9@hisilicon.com>, <lihuisong@huawei.com>, <fanghao11@huawei.com>
References: <20250115100123.241110-1-zhenglifeng1@huawei.com>
 <20250115100123.241110-2-zhenglifeng1@huawei.com>
 <20250115111852.hluxcprc7cbrxqtc@vireshk-i7>
 <CAJZ5v0h9zb=_HTR-nraCZj18YcOSfkMm7WVZ4ePsziOzpV0ndg@mail.gmail.com>
From: "zhenglifeng (A)" <zhenglifeng1@huawei.com>
In-Reply-To: <CAJZ5v0h9zb=_HTR-nraCZj18YcOSfkMm7WVZ4ePsziOzpV0ndg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemh100008.china.huawei.com (7.202.181.93)

On 2025/1/15 20:50, Rafael J. Wysocki wrote:

> On Wed, Jan 15, 2025 at 12:18 PM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>>
>> On 15-01-25, 18:01, Lifeng Zheng wrote:
>>> It turns out that cpuX will stay on the base frequency after performing
>>> these operations:
>>>
>>> 1. boost all cpus: echo 1 > /sys/devices/system/cpu/cpufreq/boost
>>>
>>> 2. offline the cpu: echo 0 > /sys/devices/system/cpu/cpuX/online
>>>
>>> 3. deboost all cpus: echo 0 > /sys/devices/system/cpu/cpufreq/boost
>>>
>>> 4. online the cpu: echo 1 > /sys/devices/system/cpu/cpuX/online
>>>
>>> 5. boost all cpus again: echo 1 > /sys/devices/system/cpu/cpufreq/boost
>>>
>>> This is because max_freq_req of the policy is not updated during the
>>> online process, and the value of max_freq_req before the last offline is
>>> retained. When the CPU is boosted again, freq_qos_update_request() will
>>> do nothing because the old value is the same as the new one. This causes
>>> the CPU stay on the base frequency. Update max_freq_req (and
>>> min_freq_req of course) in cpufreq_online() will solve this problem.
>>>
>>> Signed-off-by: Lifeng Zheng <zhenglifeng1@huawei.com>
>>> ---
>>>  drivers/cpufreq/cpufreq.c | 7 +++++++
>>>  1 file changed, 7 insertions(+)
>>>
>>> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
>>> index 1a4cae54a01b..03ae879d50b9 100644
>>> --- a/drivers/cpufreq/cpufreq.c
>>> +++ b/drivers/cpufreq/cpufreq.c
>>> @@ -1475,6 +1475,13 @@ static int cpufreq_online(unsigned int cpu)
>>>
>>>               blocking_notifier_call_chain(&cpufreq_policy_notifier_list,
>>>                               CPUFREQ_CREATE_POLICY, policy);
>>> +     } else {
>>> +             ret = freq_qos_update_request(policy->min_freq_req, policy->min);
>>
>> This may not be required, as min-freq-req is never updated.
> 
> It gets updated via scaling_min_freq AFAICS.  Doesn't this matter?

If fact, scaling_min_freq cannot be operated when a cpu is offline. So this
update may indeed be unnecessary.

> 
>>> +             if (ret < 0)
>>> +                     goto out_destroy_policy;
>>> +             ret = freq_qos_update_request(policy->max_freq_req, policy->max);
>>> +             if (ret < 0)
>>> +                     goto out_destroy_policy;
>>>       }
>>>
>>>       if (cpufreq_driver->get && has_target()) {
>>> --


