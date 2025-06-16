Return-Path: <linux-pm+bounces-28856-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40C33ADB957
	for <lists+linux-pm@lfdr.de>; Mon, 16 Jun 2025 21:10:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 47C403B6248
	for <lists+linux-pm@lfdr.de>; Mon, 16 Jun 2025 19:10:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 798F7281513;
	Mon, 16 Jun 2025 19:10:45 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69EA33208;
	Mon, 16 Jun 2025 19:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750101045; cv=none; b=kwRuYzFiZnEsnIQduhvd39sE1qvOpjthore/My5Lf28loP6Ma2bMPfnbOop87BXeN/RYb3/pK+IsaIAdqOWz3qGxHE0fnmMO2kHvI7ghY8Ocx71PdKC+EQ/svXZk94igyfk+nWOZ558e50U5xMDptfuXLWZFGDwbOFCAnVaX8wY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750101045; c=relaxed/simple;
	bh=pky1JRhBtMQ+IyjWAw9BGfBuLo0Cz4zA51FLub5I7Ms=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=R2/4EAQ5Hl7gqr6z9tGfYdKH7lMWI4esKB/QIi8ohKxUr+zqN8tOB3WYAl2k0WPV/ZYDC7IXcewJycaZr/aop3LkiAmW9xxBqpzE10t9ojFaZcf18mhczg1pGvgXwIMc+7M6EmPu3BWQVkekqN0P5LAX4D+okXDtGubDAMWzIfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1F3AC1424;
	Mon, 16 Jun 2025 12:10:19 -0700 (PDT)
Received: from [10.57.26.223] (unknown [10.57.26.223])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 577003F58B;
	Mon, 16 Jun 2025 12:10:39 -0700 (PDT)
Message-ID: <34651625-08eb-46df-8075-4c5a08d15c18@arm.com>
Date: Mon, 16 Jun 2025 20:10:37 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cpufreq: Fix initialization with disabled boost
To: Christian Loehle <christian.loehle@arm.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 linux-pm <linux-pm@vger.kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>
Cc: zhenglifeng1@huawei.com
References: <3cc5b83b-f81c-4bd7-b7ff-4d02db4e25d8@arm.com>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <3cc5b83b-f81c-4bd7-b7ff-4d02db4e25d8@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2025-06-16 6:25 pm, Christian Loehle wrote:
> The boost_enabled early return in policy_set_boost() caused
> the boost disabled at initialization to not actually set the
> initial policy->max, therefore effectively enabling boost while
> it should have been enabled.
> 
> Fixes: 27241c8b63bd ("cpufreq: Introduce policy_set_boost()")

I think it's a bit older than that - I noticed this with 6.15 stable, 
prior to that refactoring, and from a poke through the history the 
underlying logic appears to date back to dd016f379ebc ("cpufreq: 
Introduce a more generic way to set default per-policy boost flag"). 
Hopefully someone can figure out the appropriate stable backport.

I can at least confirm that equivalently hacking out the "&& 
policy->boost_enabled != cpufreq_boost_enabled()" condition previously 
here does have the desired effect for me of initialising 
scaling_max_freq correctly at boot, but I'm not sure that's entirely 
correct on its own...

Thanks,
Robin.

> Reported-by: Robin Murphy <robin.murphy@arm.com>
> Signed-off-by: Christian Loehle <christian.loehle@arm.com>
> ---
>   drivers/cpufreq/cpufreq.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index d7426e1d8bdd..e85139bd0436 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -1630,7 +1630,7 @@ static int cpufreq_online(unsigned int cpu)
>   	 */
>   	if (cpufreq_driver->set_boost && policy->boost_supported &&
>   	    (new_policy || !cpufreq_boost_enabled())) {
> -		ret = policy_set_boost(policy, cpufreq_boost_enabled());
> +		ret = cpufreq_driver->set_boost(policy, cpufreq_boost_enabled());
>   		if (ret) {
>   			/* If the set_boost fails, the online operation is not affected */
>   			pr_info("%s: CPU%d: Cannot %s BOOST\n", __func__, policy->cpu,


