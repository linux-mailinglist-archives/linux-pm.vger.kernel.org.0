Return-Path: <linux-pm+bounces-31421-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66EFBB11A98
	for <lists+linux-pm@lfdr.de>; Fri, 25 Jul 2025 11:12:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9E8B3B0329
	for <lists+linux-pm@lfdr.de>; Fri, 25 Jul 2025 09:11:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31362273816;
	Fri, 25 Jul 2025 09:11:58 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A1DC273804;
	Fri, 25 Jul 2025 09:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753434718; cv=none; b=exbUI6GiRixnQ+e4I/rn6tp53ju0hazLpsYSNrTHbyZ5PB4+G1SY/jv7givKM0cCwYlfVCVMIgqHT5iRUeUUHRGGeiVMrDKvLa+3ox7JdUczRoPbYpgxk/IOn/9KCIMIUrvtGHBByYkXTK0HAQBtDu9VPTBwjhWZIwEXa8zwa24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753434718; c=relaxed/simple;
	bh=MhpW+DaSUTQ3UDixlp69d36bLN7S44cck6BnAu1ELzc=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=kI0JHTPhFTtbJwDe95bnn6bQeLp31KV5myVaFlQoSG5k7oweDVS8uABT1hRMRPkOI08bjLTCVSopHRkTZivqgCFFfCaVgQkJqEXObcoPfXeQLbZsat+Nd719h37tv8L3+VoyskWdvR7c3KWhmzFxN+b+qZ3oIyBX0qKCErw41aI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4bpMT33cLHzYdQx;
	Fri, 25 Jul 2025 17:07:19 +0800 (CST)
Received: from kwepemh100008.china.huawei.com (unknown [7.202.181.93])
	by mail.maildlp.com (Postfix) with ESMTPS id 74473180B60;
	Fri, 25 Jul 2025 17:11:52 +0800 (CST)
Received: from [10.67.121.90] (10.67.121.90) by kwepemh100008.china.huawei.com
 (7.202.181.93) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 25 Jul
 2025 17:11:51 +0800
Message-ID: <fb4b7ce4-e273-4622-abe2-31610d5da531@huawei.com>
Date: Fri, 25 Jul 2025 17:11:51 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] cpufreq: Avoid get_governor() for first policy
To: Zihuan Zhang <zhangzihuan@kylinos.cn>, "rafael J . wysocki"
	<rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>
CC: <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20250725041450.68754-1-zhangzihuan@kylinos.cn>
From: "zhenglifeng (A)" <zhenglifeng1@huawei.com>
In-Reply-To: <20250725041450.68754-1-zhangzihuan@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 kwepemh100008.china.huawei.com (7.202.181.93)

On 2025/7/25 12:14, Zihuan Zhang wrote:

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
> 
> ---
> Changes in v2:
>  - Fix the case where the governor is NULL.
> ---
> ---
>  drivers/cpufreq/cpufreq.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index d7426e1d8bdd..1aa559f53479 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -1122,7 +1122,8 @@ static int cpufreq_init_policy(struct cpufreq_policy *policy)
>  
>  	if (has_target()) {
>  		/* Update policy governor to the one used before hotplug. */
> -		gov = get_governor(policy->last_governor);
> +		if (policy->last_governor[0] != '\0')
> +			gov = get_governor(policy->last_governor);
>  		if (gov) {
>  			pr_debug("Restoring governor %s for cpu %d\n",
>  				 gov->name, policy->cpu);

Reviewed-by: Lifeng Zheng <zhenglifeng1@huawei.com>

