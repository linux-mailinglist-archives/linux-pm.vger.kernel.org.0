Return-Path: <linux-pm+bounces-31373-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 18297B1092C
	for <lists+linux-pm@lfdr.de>; Thu, 24 Jul 2025 13:28:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 133561C85B8B
	for <lists+linux-pm@lfdr.de>; Thu, 24 Jul 2025 11:28:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E029F2727E7;
	Thu, 24 Jul 2025 11:28:27 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D904D2701DA;
	Thu, 24 Jul 2025 11:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753356507; cv=none; b=jPhN2kN7NRrnpCx9Gc7hwjikxqIVkS4mK/R01Bdg8ryBaUEPIlIiULhotBHti7e+R6SbWyWjXgxHgPgham0aW2u9rCmyHLBbpdX4wzAFXVV2GUuopsW1osgP+1hQ+BNCFQd+f/p+LUSa22TUhyw+Tz/1CUDZ8MZtWJAdOOywXBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753356507; c=relaxed/simple;
	bh=Q47uJytf0tbZ1v/g40pUETBSdeGUQHTBCLOSXJWcuhY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=q4hH0eTrFuBLOOjpT8db9OIrT/GTMqBzgU5nXtmrJ3JBPLcxBioqFWZN4xhZVBPulXN+KiuJPSiHuUzCu+JcomMqSrec5HzcOEmxpuwhCI6micSGa5owSPOdDzJvRPOu4rky77BuN8EFKp8Ij0+xFS8LH6mKUBprcu//2+25yYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4bnpbg6NZNz2RVsC;
	Thu, 24 Jul 2025 19:26:07 +0800 (CST)
Received: from kwepemh100008.china.huawei.com (unknown [7.202.181.93])
	by mail.maildlp.com (Postfix) with ESMTPS id 940E2140109;
	Thu, 24 Jul 2025 19:28:22 +0800 (CST)
Received: from [10.67.121.90] (10.67.121.90) by kwepemh100008.china.huawei.com
 (7.202.181.93) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 24 Jul
 2025 19:28:22 +0800
Message-ID: <456c9900-1ce3-4a87-8c29-46e65e1240cb@huawei.com>
Date: Thu, 24 Jul 2025 19:28:21 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] cpufreq: Avoid get_governor() for first policy
To: Zihuan Zhang <zhangzihuan@kylinos.cn>, "rafael J . wysocki"
	<rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>
CC: <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20250724093621.61871-1-zhangzihuan@kylinos.cn>
From: "zhenglifeng (A)" <zhenglifeng1@huawei.com>
In-Reply-To: <20250724093621.61871-1-zhangzihuan@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 kwepemh100008.china.huawei.com (7.202.181.93)

On 2025/7/24 17:36, Zihuan Zhang wrote:

> When a cpufreq driver registers the first policy, it may attempt to
> initialize the policy governor from `last_governor`. However, this is
> meaningless for the first policy instance, because `last_governor` is
> only updated when policies are removed (e.g. during CPU offline).
> 
> The `last_governor` mechanism is intended to restore the previously
> used governor across CPU hotplug events. For the very first policy,
> there is no "previous governor" to restore, so calling
> get_governor(last_governor) is unnecessary and potentially confusing.
> 
> This patch skips looking up `last_governor` when registering the first
> policy. Instead, it directly uses the default governor after all
> governors have been registered and are available.
> 
> This avoids meaningless lookups, reduces unnecessary module reference
> handling, and simplifies the initial policy path.
> 
> Signed-off-by: Zihuan Zhang <zhangzihuan@kylinos.cn>
> ---
>  drivers/cpufreq/cpufreq.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index d7426e1d8bdd..b5ebd4519eab 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -1121,9 +1121,9 @@ static int cpufreq_init_policy(struct cpufreq_policy *policy)
>  	int ret;
>  
>  	if (has_target()) {
> -		/* Update policy governor to the one used before hotplug. */
> -		gov = get_governor(policy->last_governor);
> -		if (gov) {
> +		if (policy->last_governor[0] != '\0') {
> +			/* Update policy governor to the one used before hotplug. */
> +			gov = get_governor(policy->last_governor);

What if gov is null here? For example, the last governor has been removed.
The default governor should be used in this situation I think.

>  			pr_debug("Restoring governor %s for cpu %d\n",
>  				 gov->name, policy->cpu);
>  		} else {


