Return-Path: <linux-pm+bounces-19978-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B2E1A02018
	for <lists+linux-pm@lfdr.de>; Mon,  6 Jan 2025 08:55:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EC0AD7A1819
	for <lists+linux-pm@lfdr.de>; Mon,  6 Jan 2025 07:54:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91FE11D63C1;
	Mon,  6 Jan 2025 07:55:00 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F75419E997;
	Mon,  6 Jan 2025 07:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736150100; cv=none; b=mibF/b7yRp2n+muSnNWiwUvJRSaiGD9US+s5OxH7+ETfud1O77TrzKcyKgRQKBlMs1Un1GdfnDsAMC4nbILsYKDuf71pcQBioOaFaxl1bhlI86hsTdtFYx/lOgkJ8wX1r6oeMJ5EoHsuVn2m9zO7E9DtAhO7n5kIiH4NFydKzw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736150100; c=relaxed/simple;
	bh=JlY/9THb9hEgf8xzCIUvxkHxxy5lPesXtIKMp81zbCI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=B0a2j96pkoC38xX9he2yQLbeTFac7eFjvamlBgc5bkIzty9QH7/pgRqSeImRbbIJuhgz1Ohal/Rvbj2wLcyb63xsef9vwNSpAcL5u60GflwdrqmGPK2rvIomJEDjU9LXRSqgTutP38hRviUhdVCR95+BIHFKUak3o3MiEGQqC6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4YRRL748yqz20nYy;
	Mon,  6 Jan 2025 15:55:11 +0800 (CST)
Received: from kwepemh100008.china.huawei.com (unknown [7.202.181.93])
	by mail.maildlp.com (Postfix) with ESMTPS id 4BB1014022F;
	Mon,  6 Jan 2025 15:54:49 +0800 (CST)
Received: from [10.67.121.90] (10.67.121.90) by kwepemh100008.china.huawei.com
 (7.202.181.93) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 6 Jan
 2025 15:54:48 +0800
Message-ID: <50f2c002-21c7-4c41-8992-8469b697b8b7@huawei.com>
Date: Mon, 6 Jan 2025 15:54:47 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cpufreq/amd-pstate: Fix per-policy boost flag incorrect
 when fail
To: Mario Limonciello <mario.limonciello@amd.com>, <rafael@kernel.org>,
	<viresh.kumar@linaro.org>, <perry.yuan@amd.com>
CC: <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linuxarm@huawei.com>, <jonathan.cameron@huawei.com>,
	<zhanjie9@hisilicon.com>, <lihuisong@huawei.com>, <fanghao11@huawei.com>
References: <20250103074139.1080092-1-zhenglifeng1@huawei.com>
 <7e777177-417e-41eb-81d0-3635769d3a83@amd.com>
From: "zhenglifeng (A)" <zhenglifeng1@huawei.com>
In-Reply-To: <7e777177-417e-41eb-81d0-3635769d3a83@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemh100008.china.huawei.com (7.202.181.93)

On 2025/1/4 0:56, Mario Limonciello wrote:

> On 1/3/2025 01:41, Lifeng Zheng wrote:
>> Commit c8c68c38b56f ("cpufreq: amd-pstate: initialize core precision
>> boost state") sets per-policy boost flag to false when boost fail.
>> However, this boost flag will be set to reverse value in
>> store_local_boost() and cpufreq_boost_trigger_state() in cpufreq.c. This
>> will cause the per-policy boost flag set to true when fail to set boost.
>> Remove the extra assignment in amd_pstate_set_boost() and keep all
>> operations on per-policy boost flag outside of set_boost() to fix this
>> problem.
>>
>> Fixes: c8c68c38b56f ("cpufreq: amd-pstate: initialize core precision boost state")
>> Signed-off-by: Lifeng Zheng <zhenglifeng1@huawei.com>
>> ---
> 
> Hi There,
> 
> Thanks for the patch.  Unfortunately, it doesn't apply to the current linux-next branch at https://git.kernel.org/pub/scm/linux/kernel/git/superm1/linux.git
> 
> Although the issue you identified is still valid, there have been other contextual changes in the function [1].  Can you rebase on that branch, test it again and send a v2?
> 
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/superm1/linux.git/tree/drivers/cpufreq/amd-pstate.c?h=linux-next#n750
> 
> Thanks!

Thanks, I'll test on this branch and send a v2.

> 
>>   drivers/cpufreq/amd-pstate.c | 1 -
>>   1 file changed, 1 deletion(-)
>>
>> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
>> index 66e5dfc711c0..4ce923788f3a 100644
>> --- a/drivers/cpufreq/amd-pstate.c
>> +++ b/drivers/cpufreq/amd-pstate.c
>> @@ -730,7 +730,6 @@ static int amd_pstate_set_boost(struct cpufreq_policy *policy, int state)
>>       mutex_lock(&amd_pstate_driver_lock);
>>       ret = amd_pstate_cpu_boost_update(policy, state);
>>       WRITE_ONCE(cpudata->boost_state, !ret ? state : false);
>> -    policy->boost_enabled = !ret ? state : false;
>>       refresh_frequency_limits(policy);
>>       mutex_unlock(&amd_pstate_driver_lock);
>>   
> 


