Return-Path: <linux-pm+bounces-20189-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 209B4A08B53
	for <lists+linux-pm@lfdr.de>; Fri, 10 Jan 2025 10:20:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EFE2F1883F5D
	for <lists+linux-pm@lfdr.de>; Fri, 10 Jan 2025 09:20:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6865B20A5E8;
	Fri, 10 Jan 2025 09:18:05 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A99020A5E2;
	Fri, 10 Jan 2025 09:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736500685; cv=none; b=Z6Roqu/WCbBynDja6qXCRdlcM8tYxX3JdrP3hnFzKCYS+pt6QlRaozNYdTBBaOAnAXyK+VjfD2l1EFUN07G/DAbdMaeRB89nsX6x1pBEF2o6Ml/w5u0qgcM6MaBfDmrRi6oV0MOLjjNC2sODrjTQX1LNCeR8+9nGEijmDxharrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736500685; c=relaxed/simple;
	bh=VpNo6XlsDOzef8ZX9W7kPIruU0R3nXNQaQFzRgI+Rzc=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=gDjDBqu4rS6navXYRhTRjVPO1EFhXJEGaC2U1J2jgmP4L5n5KpdOaPZLfwwu2s1RFVZ1+AlsZbgVOiWjH6k1Dkpb91mH4zGIE9nC1/g2uOYNr78kFCuu8R8mq+l2iJYvuggncfLZQtuRUb18qerB4dXnzgIekf5wxQb4MrSpD98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4YTwwB0bZBz1V4Nr;
	Fri, 10 Jan 2025 17:14:50 +0800 (CST)
Received: from kwepemh100008.china.huawei.com (unknown [7.202.181.93])
	by mail.maildlp.com (Postfix) with ESMTPS id 865EA1401F4;
	Fri, 10 Jan 2025 17:17:54 +0800 (CST)
Received: from [10.67.121.90] (10.67.121.90) by kwepemh100008.china.huawei.com
 (7.202.181.93) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 10 Jan
 2025 17:17:53 +0800
Message-ID: <ac5af09b-c5a2-47e7-a1a3-9e2d67468906@huawei.com>
Date: Fri, 10 Jan 2025 17:17:53 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] [PATCH] cpufreq/amd-pstate: Fix per-policy boost flag
 incorrect when fail
To: <rafael@kernel.org>, <viresh.kumar@linaro.org>,
	<mario.limonciello@amd.com>, <perry.yuan@amd.com>
CC: <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linuxarm@huawei.com>, <jonathan.cameron@huawei.com>,
	<zhanjie9@hisilicon.com>, <lihuisong@huawei.com>, <fanghao11@huawei.com>
References: <20250110091218.3530092-1-zhenglifeng1@huawei.com>
From: "zhenglifeng (A)" <zhenglifeng1@huawei.com>
In-Reply-To: <20250110091218.3530092-1-zhenglifeng1@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemh100008.china.huawei.com (7.202.181.93)

On 2025/1/10 17:12, Lifeng Zheng wrote:
> Commit c8c68c38b56f ("cpufreq: amd-pstate: initialize core precision
> boost state") sets per-policy boost flag to false when boost fail.
> However, this boost flag will be set to reverse value in
> store_local_boost() and cpufreq_boost_trigger_state() in cpufreq.c. This
> will cause the per-policy boost flag set to true when fail to set boost.
> Remove the extra assignment in amd_pstate_set_boost() and keep all
> operations on per-policy boost flag outside of set_boost() to fix this
> problem.
> 
> Fixes: c8c68c38b56f ("cpufreq: amd-pstate: initialize core precision boost state")
> Signed-off-by: Lifeng Zheng <zhenglifeng1@huawei.com>
> ---
>  drivers/cpufreq/amd-pstate.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index d7b1de97727a..a2573393ce30 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -747,7 +747,6 @@ static int amd_pstate_set_boost(struct cpufreq_policy *policy, int state)
>  	guard(mutex)(&amd_pstate_driver_lock);
>  
>  	ret = amd_pstate_cpu_boost_update(policy, state);
> -	policy->boost_enabled = !ret ? state : false;
>  	refresh_frequency_limits(policy);
>  
>  	return ret;

Got some mistakes, I'll resent another one. Sorry.😭

