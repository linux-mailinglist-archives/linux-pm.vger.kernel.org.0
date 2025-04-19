Return-Path: <linux-pm+bounces-25743-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC03DA942A1
	for <lists+linux-pm@lfdr.de>; Sat, 19 Apr 2025 11:36:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3198F7A3F2E
	for <lists+linux-pm@lfdr.de>; Sat, 19 Apr 2025 09:34:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0A0719E975;
	Sat, 19 Apr 2025 09:35:58 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0DCB2AE96;
	Sat, 19 Apr 2025 09:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745055358; cv=none; b=JChDX/yQZgHvwtjPIc+HlXrSm4L+AvozVnjOgcziDHmvfmTP0Vnv/ny3OSRzb5uogjSsF9Mvf/fALnFZ84pbFQdr5JjyCvyfrgVWiO8UY6lajTV5LbZcknKmTiWEnlW7slpPWVGq9Nm2oaTkbfHwX7aI7iZ04GjT2toGgmhhG3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745055358; c=relaxed/simple;
	bh=arihgOkEvq/rFpBVmfQywP7Cnn9CIntQMufo1ibAEcY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Td2NhAfFIJ/ERQvDGoo17Txu/zFczKwPMnAXbmpMzgiCSdfP6SkKUh2aLaQtP9iZT/fshaurjzi1X7sSqL25bb8XI1NdPdbJhRVt5I8irs8MPOMiN4V5IxL9MDitQW5SBLdAedyRl5B+z3CAIfL1HmRCVvC3wcUok/dO0EYw2cU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4Zfmcn14wjzHrFr;
	Sat, 19 Apr 2025 17:32:25 +0800 (CST)
Received: from kwepemh100008.china.huawei.com (unknown [7.202.181.93])
	by mail.maildlp.com (Postfix) with ESMTPS id 00BD7180B53;
	Sat, 19 Apr 2025 17:35:53 +0800 (CST)
Received: from [10.67.121.90] (10.67.121.90) by kwepemh100008.china.huawei.com
 (7.202.181.93) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Sat, 19 Apr
 2025 17:35:52 +0800
Message-ID: <c704850d-1fdd-4f25-8251-5bab03f055bb@huawei.com>
Date: Sat, 19 Apr 2025 17:35:51 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cpufreq: acpi: Don't enable boost on policy exit
To: Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J. Wysocki"
	<rafael@kernel.org>
CC: Nicholas Chin <nic.c3.14@gmail.com>, <linux-kernel@vger.kernel.org>,
	<linux-pm@vger.kernel.org>, <rafael.j.wysocki@intel.com>,
	<vincent.guittot@linaro.org>
References: <2c788c2ca0cab09a8ef4e384f272af928a880b0e.1744781329.git.viresh.kumar@linaro.org>
 <20250417015424.36487-1-nic.c3.14@gmail.com>
 <20250417050226.c6kdp2s5du3y3a3j@vireshk-i7>
 <20250417050911.xycjkalehqsg3i6x@vireshk-i7>
 <CAJZ5v0iO4=nHcATzPyiKiWumdETFRR32C97K_RH=yhD--Tai=g@mail.gmail.com>
 <CAJZ5v0gcf07YykOS9VsQgHwM0DnphBX4yc9dt5cKjNR8G_4mAQ@mail.gmail.com>
 <CAKohpomN1PYn1NPSsxCxqpMfg-9nYgCRQD6dFGQ30B+76vneQw@mail.gmail.com>
 <978bc0b7-4dfe-4ca1-9dd5-6c4a9c892be6@gmail.com>
 <CAJZ5v0iwAsVnvYKjKskLXuu5bDV_SMpgnTTy0zD=7fgnGzHQnA@mail.gmail.com>
 <CAKohponCr6pwgmK+J0WnvY_VZdDhA738JF18L518A2MKJVQLmw@mail.gmail.com>
From: "zhenglifeng (A)" <zhenglifeng1@huawei.com>
In-Reply-To: <CAKohponCr6pwgmK+J0WnvY_VZdDhA738JF18L518A2MKJVQLmw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemh100008.china.huawei.com (7.202.181.93)

On 2025/4/19 15:54, Viresh Kumar wrote:

> On Sat, 19 Apr 2025 at 00:58, Rafael J. Wysocki <rafael@kernel.org> wrote:
> 
>> So it updates policy->boost_enabled in accordance with the current
>> setting in the MSR.
> 
> Yes.
> 
>> IMO it would be better to update the MSR in accordance with
>> policy->boost_enabled or users may get confused if their boost
>> settings change after a suspend-resume cycle.  Or have I got lost
>> completely?
> 
> I wrote this patch based on the sync that happens at the end of
> cpufreq_online():
> 
>         /* Let the per-policy boost flag mirror the cpufreq_driver
> boost during init */
>         if (cpufreq_driver->set_boost && policy->boost_supported &&
>             policy->boost_enabled != cpufreq_boost_enabled()) {
>                 policy->boost_enabled = cpufreq_boost_enabled();
>                 ret = cpufreq_driver->set_boost(policy, policy->boost_enabled);
>                 if (ret) {
>                         /* If the set_boost fails, the online
> operation is not affected */
>                         pr_info("%s: CPU%d: Cannot %s BOOST\n",
> __func__, policy->cpu,
>                                 str_enable_disable(policy->boost_enabled));
>                         policy->boost_enabled = !policy->boost_enabled;
>                 }
>         }
> 
> So my patch works as the cpufreq core force-syncs the state at init
> (pretty much what the driver was doing before).
> 
> Though I now wonder if this code (in cpufreq_online()) is really doing
> the right thing or not. So if global boost is enabled before suspend with
> policy boost being disabled, the policy boost will be enabled on resume.

Yes, the policy boost will be forcibly set to mirror the global boost. This
indicates that the global boost value is the default value of policy boost
each time the CPU goes online. Otherwise, we'll meet things like:

1. The global boost is set to disabled after a CPU going offline but the
policy boost is still be enabled after the CPU going online again.

2. The global boost is set to enabled after a CPU going offline and the
rest of the online CPUs are all boost enabled. However, the offline CPU
remains in the boost disabled state after it going online again. Users
have to set its boost state separately.

IMV, a user set the global boost means "I want all policy boost/unboost",
every CPU going online after that should follow this order. So I think
the code in cpufreq_online() is doing the right thing.

BTW, I think there is optimization can be done in
cpufreq_boost_trigger_state(). Currently, Nothing will happend if users set
global boost flag to true when this flag is already true. But I think it's
better to set all policies to boost in this situation. It might make more
sense to think of this as a refresh operation. This is just my idea. I'd
like to hear your opinion.

> 
> --
> Viresh


