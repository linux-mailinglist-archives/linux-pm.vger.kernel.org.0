Return-Path: <linux-pm+bounces-40896-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 03AFAD2252D
	for <lists+linux-pm@lfdr.de>; Thu, 15 Jan 2026 04:41:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B78DB3025A48
	for <lists+linux-pm@lfdr.de>; Thu, 15 Jan 2026 03:41:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13DB029E110;
	Thu, 15 Jan 2026 03:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="3a2O+IrY"
X-Original-To: linux-pm@vger.kernel.org
Received: from canpmsgout06.his.huawei.com (canpmsgout06.his.huawei.com [113.46.200.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 049CC1531C8;
	Thu, 15 Jan 2026 03:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768448516; cv=none; b=ELkyrGSnbb0yVNJveRYB7uDaxVQzWKtx/gGGENzeAcbW0e4gXAr1YMhFazLc6OLJHx8BCMcgtjgQKdl0WPQD8IqzABj3UEvjXOnUIpqhVSduuafiDQvUshWE++ZqBFGfjyvIrlC1KcJv1ebbvBcx5lC31Hv7yIzytKNzCjzJygk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768448516; c=relaxed/simple;
	bh=/0J65nERfDk84Z8Kg7SWERzpPaopmKYiaZ8mYGBC/gc=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ZNsoIKapuJruKoDuBWldxAZuz0eRZGVsvorhWVr+jEAuvykXV6wEFZz7C1KDLKdyD01ighOR82P7Y273fPqIyHFvuWY7BC9dHqxZj34LkgErvs1GMjvwjMrxHc/QN8lMlhBpq4P8qJb77iakYHBXLQmmknlgieZO2+5Q2f7Lqvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=3a2O+IrY; arc=none smtp.client-ip=113.46.200.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=ZVkvkXxYcfmY+ycsushaE5yujw58WG17UahLiZ3mnOA=;
	b=3a2O+IrYhVDBxlumUT3vQnCJJ4qVvXKVrfPT8d4Bym/wqHjK+nw3sfuRY5qS8qfEMmEQ/V8vr
	STcRMvOTGpO+QAM1/vZTxIcLjIGbEMcREiwP8+B+EE2uNpIh2qFQZQ6bSe+ppPN85rPi6kSsr5r
	SnccqlSvsmnnIO7YfKgavi0=
Received: from mail.maildlp.com (unknown [172.19.163.0])
	by canpmsgout06.his.huawei.com (SkyGuard) with ESMTPS id 4ds7xL4NBFzRhRw;
	Thu, 15 Jan 2026 11:38:30 +0800 (CST)
Received: from kwepemf200001.china.huawei.com (unknown [7.202.181.227])
	by mail.maildlp.com (Postfix) with ESMTPS id E325F40537;
	Thu, 15 Jan 2026 11:41:50 +0800 (CST)
Received: from [10.67.121.90] (10.67.121.90) by kwepemf200001.china.huawei.com
 (7.202.181.227) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 15 Jan
 2026 11:41:50 +0800
Message-ID: <0c06c697-69e1-48c7-99c5-e54581e7818a@huawei.com>
Date: Thu, 15 Jan 2026 11:41:49 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] cpufreq: Update set_boost callbacks to rely on
 boost_freq_req
To: Pierre Gondois <pierre.gondois@arm.com>
CC: "Rafael J. Wysocki" <rafael@kernel.org>, Viresh Kumar
	<viresh.kumar@linaro.org>, <linux-kernel@vger.kernel.org>, Christian Loehle
	<christian.loehle@arm.com>, Ionela Voinescu <ionela.voinescu@arm.com>, Jie
 Zhan <zhanjie9@hisilicon.com>, Huang Rui <ray.huang@amd.com>, "Gautham R.
 Shenoy" <gautham.shenoy@amd.com>, Mario Limonciello
	<mario.limonciello@amd.com>, Perry Yuan <perry.yuan@amd.com>,
	<linux-pm@vger.kernel.org>
References: <20251208105933.1369125-1-pierre.gondois@arm.com>
 <20251208105933.1369125-4-pierre.gondois@arm.com>
 <14ad55ce-413f-46e0-9ce0-f35fc421056c@huawei.com>
 <73da1186-5edd-4465-bd49-e18d9064a501@arm.com>
 <ea9111b5-cd85-4526-a959-54d8037d6ffb@huawei.com>
 <36630a40-b6e6-4bf6-8fa1-1a004e0d2798@arm.com>
 <ppzoeb4wod6jjhlvkiqogcd26v3shfh5cjiuq63r7bbnsyzzok@sdx5usgvcqzu>
 <CAJZ5v0hZMSWxd6u0ZpPosDu9j0ibYeGyqRRqnaiVBNcA1kmPXA@mail.gmail.com>
From: "zhenglifeng (A)" <zhenglifeng1@huawei.com>
In-Reply-To: <CAJZ5v0hZMSWxd6u0ZpPosDu9j0ibYeGyqRRqnaiVBNcA1kmPXA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 kwepemf200001.china.huawei.com (7.202.181.227)

Hi Pierre,

On 2026/1/13 20:20, Rafael J. Wysocki wrote:
> On Tue, Jan 13, 2026 at 2:30 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>>
>> On 12-01-26, 16:02, Pierre Gondois wrote:
>>> In:
>>> cpufreq_set_policy()
>>> \-cpufreq_driver->verify(&new_data)
>>>   \-cpufreq_verify_within_cpu_limits()
>>>
>>> the requested min/max values are clamped wrt the cpuinfo.[min|max]_freq.
>>> However this clamping happens after the QoS constraints have been
>>> aggregated. This means that if a CPU has:
>>> - min = 100.000 kHz
>>> - max = 1.000.000 kHz
>>> - boost = 1.200.000 kHz
>>>
>>> With boost enabled, the user requests:
>>> - scaling_min: 1.100.000
>>> - scaling_max: 1.200.000
>>>
>>> If boost is disabled, we will have:
>>> policy->min == policy->max == 1.000.000
>>> without notifying anybody.
>>>
>>> Ideally I assume it would be better to prevent the user from disabling
>>> boost without first asking to update the scaling_[min|max] frequencies,
>>> or at least detecting this case and have a warning message.
>>
>> I don't think this is a problem and doesn't really need special care.
>> It is the user who is disabling the boost feature, its okay to force
>> set to clamped values.
>>
>>> Please let me know if you prefer not adding the new qos constraint,
>>> I ll try harder not to have it if yes.
>>
>> But even with that (the issue pointed earlier not being a problem), I
>> think a new constraint for boost does make the code cleaner and easy
>> to follow.
>>
>> Rafael ?
> 
> I agree.
> 

An explicitly defined QoS helps make the code cleaner and easy to follow.
I agree too. Let's do it that way.




