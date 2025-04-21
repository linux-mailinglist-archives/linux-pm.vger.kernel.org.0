Return-Path: <linux-pm+bounces-25791-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04CDAA94D73
	for <lists+linux-pm@lfdr.de>; Mon, 21 Apr 2025 09:45:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A31C17010A
	for <lists+linux-pm@lfdr.de>; Mon, 21 Apr 2025 07:45:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A92D220E33A;
	Mon, 21 Apr 2025 07:45:25 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A984E2B9A8;
	Mon, 21 Apr 2025 07:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745221525; cv=none; b=teVfX5s9T6xqDYyDujU8zuryehzejAd8LIjGvwga0PBlwHd4BlcHSnezGNZ0zBgwYzztsbFatspRgnq+M/lEXZypHoyDKI6c8RoTvNYUc8bJHUQsikiPDB5zCusPsLvUD8RlD+lxcO42kDX0WUmVraDk4oE9YEYF6gP4lozg3vk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745221525; c=relaxed/simple;
	bh=kIM7s0Aj9UnhmqjU0UyLzWBt4wOoBW79+q3PC305GS8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=SeqRjaFUqdQpY33p6jB3LGxqSW/AbkGOtVH4RRE7q9zeu2aR/2EjMghMbjkRsSSCreBIjAPmJZGmu/Awbfitxhv5vYJ6pSCutPhTEoMA1grAwD5QXSF2NNY+ovWz8PmL/q12blMwuQaGbuqc6lp5ayGEXHyzX4jrRzOpT2yY3iM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4Zgy794xwvz1d03c;
	Mon, 21 Apr 2025 15:44:21 +0800 (CST)
Received: from kwepemh100008.china.huawei.com (unknown [7.202.181.93])
	by mail.maildlp.com (Postfix) with ESMTPS id D18C0180B5A;
	Mon, 21 Apr 2025 15:45:17 +0800 (CST)
Received: from [10.67.121.90] (10.67.121.90) by kwepemh100008.china.huawei.com
 (7.202.181.93) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 21 Apr
 2025 15:45:17 +0800
Message-ID: <b135ad48-fa77-4455-b83a-92a6367bfacc@huawei.com>
Date: Mon, 21 Apr 2025 15:45:16 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cpufreq: acpi: Don't enable boost on policy exit
To: Viresh Kumar <viresh.kumar@linaro.org>
CC: "Rafael J. Wysocki" <rafael@kernel.org>, Nicholas Chin
	<nic.c3.14@gmail.com>, <linux-kernel@vger.kernel.org>,
	<linux-pm@vger.kernel.org>, <rafael.j.wysocki@intel.com>,
	<vincent.guittot@linaro.org>
References: <20250417015424.36487-1-nic.c3.14@gmail.com>
 <20250417050226.c6kdp2s5du3y3a3j@vireshk-i7>
 <20250417050911.xycjkalehqsg3i6x@vireshk-i7>
 <CAJZ5v0iO4=nHcATzPyiKiWumdETFRR32C97K_RH=yhD--Tai=g@mail.gmail.com>
 <CAJZ5v0gcf07YykOS9VsQgHwM0DnphBX4yc9dt5cKjNR8G_4mAQ@mail.gmail.com>
 <CAKohpomN1PYn1NPSsxCxqpMfg-9nYgCRQD6dFGQ30B+76vneQw@mail.gmail.com>
 <978bc0b7-4dfe-4ca1-9dd5-6c4a9c892be6@gmail.com>
 <CAJZ5v0iwAsVnvYKjKskLXuu5bDV_SMpgnTTy0zD=7fgnGzHQnA@mail.gmail.com>
 <CAKohponCr6pwgmK+J0WnvY_VZdDhA738JF18L518A2MKJVQLmw@mail.gmail.com>
 <c704850d-1fdd-4f25-8251-5bab03f055bb@huawei.com>
 <20250421062003.lbxdxhlp6ulnjq7f@vireshk-i7>
From: "zhenglifeng (A)" <zhenglifeng1@huawei.com>
In-Reply-To: <20250421062003.lbxdxhlp6ulnjq7f@vireshk-i7>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemh100008.china.huawei.com (7.202.181.93)

On 2025/4/21 14:20, Viresh Kumar wrote:

> On 19-04-25, 17:35, zhenglifeng (A) wrote:
>> Yes, the policy boost will be forcibly set to mirror the global boost. This
>> indicates that the global boost value is the default value of policy boost
>> each time the CPU goes online. Otherwise, we'll meet things like:
>>
>> 1. The global boost is set to disabled after a CPU going offline but the
>> policy boost is still be enabled after the CPU going online again.
>>
>> 2. The global boost is set to enabled after a CPU going offline and the
>> rest of the online CPUs are all boost enabled. However, the offline CPU
>> remains in the boost disabled state after it going online again. Users
>> have to set its boost state separately.
> 
> I agree that both of these are valid issues, but so is retaining state
> across suspend/resume too.. There is a difference in a user manually
> removing a CPU (offline) and suspend/resume.
> 
> With a manual offline operation, the code in cpufreq_online() is doing
> the right thing, default to global boost. But the user configuration
> shouldn't change with just suspend resume.
> 
>> IMV, a user set the global boost means "I want all policy boost/unboost",
>> every CPU going online after that should follow this order. So I think
>> the code in cpufreq_online() is doing the right thing.
> 
> Yes, but any change to policy->boost after that must also be honored.

I see. Then I think the key is how to distinguish CPU offline/online and
suspend/resume in cpufreq_online().

> 
>> BTW, I think there is optimization can be done in
>> cpufreq_boost_trigger_state(). Currently, Nothing will happend if users set
>> global boost flag to true when this flag is already true. But I think it's
>> better to set all policies to boost in this situation. It might make more
>> sense to think of this as a refresh operation. This is just my idea. I'd
>> like to hear your opinion.
> 
> Makes sense.
> 


