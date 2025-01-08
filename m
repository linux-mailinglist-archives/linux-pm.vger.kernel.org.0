Return-Path: <linux-pm+bounces-20079-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CA9AA05748
	for <lists+linux-pm@lfdr.de>; Wed,  8 Jan 2025 10:47:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 822173A4F4C
	for <lists+linux-pm@lfdr.de>; Wed,  8 Jan 2025 09:47:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31DAC1EF0A5;
	Wed,  8 Jan 2025 09:47:48 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E2801A8413;
	Wed,  8 Jan 2025 09:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736329668; cv=none; b=ZLX3lnX+UySNNuKSP4s6JR6fOVnrFMyysrCkNYSiZlnmHSl6jcAUQISm1ZL3x5p32bVNj0807I8Hcq1/bhRVg5WzWK6SaimY8isGuaT1SFmTByx2fGxvBNeLXr4dcT5vptfac6qVb+Bgn3E27b0tlvGjfyKHnYMK+wHbX2/tE5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736329668; c=relaxed/simple;
	bh=+BJgSHh+2S3fLPTVT2MQmgY8JUrXp25EkhvHQ5F8bwo=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=M3F/mTNO115tRhKHK2te2+17ZYK2aYD4c1M6SDI5TjEepRf9UMEeIVmlSDxUHZgtTN64ziHxqwxwbd3bdmaemuo3flNzkk3mbNOnhftlqYRElALH9dSRIZCOSJpoGvRnzVoO9t4Uy+jI23IYa4sk0cK80rI1jzy76OsvcJlzp8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4YSjgY2QLjz2DkF6;
	Wed,  8 Jan 2025 17:44:41 +0800 (CST)
Received: from kwepemh100008.china.huawei.com (unknown [7.202.181.93])
	by mail.maildlp.com (Postfix) with ESMTPS id AAF0F1401E0;
	Wed,  8 Jan 2025 17:47:42 +0800 (CST)
Received: from [10.67.121.90] (10.67.121.90) by kwepemh100008.china.huawei.com
 (7.202.181.93) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 8 Jan
 2025 17:47:42 +0800
Message-ID: <b6cf42a9-72f8-473f-8e93-e0ad9ac1d49e@huawei.com>
Date: Wed, 8 Jan 2025 17:47:41 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cpufreq/amd-pstate: Fix per-policy boost flag incorrect
 when fail
To: Mario Limonciello <mario.limonciello@amd.com>
CC: <rafael@kernel.org>, <viresh.kumar@linaro.org>, <perry.yuan@amd.com>,
	<linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linuxarm@huawei.com>, <jonathan.cameron@huawei.com>,
	<zhanjie9@hisilicon.com>, <lihuisong@huawei.com>, <fanghao11@huawei.com>
References: <20250103074139.1080092-1-zhenglifeng1@huawei.com>
 <7e777177-417e-41eb-81d0-3635769d3a83@amd.com>
 <8fcec19d-9f3c-4ec9-99e9-d3003a94efcd@huawei.com>
 <4d4ba2f4-a294-44cf-b79e-c93c4e23cb2e@amd.com>
From: "zhenglifeng (A)" <zhenglifeng1@huawei.com>
In-Reply-To: <4d4ba2f4-a294-44cf-b79e-c93c4e23cb2e@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemh100008.china.huawei.com (7.202.181.93)

On 2025/1/8 10:26, Mario Limonciello wrote:

> On 1/7/2025 19:31, zhenglifeng (A) wrote:
>> On 2025/1/4 0:56, Mario Limonciello wrote:
>>
>>> On 1/3/2025 01:41, Lifeng Zheng wrote:
>>>> Commit c8c68c38b56f ("cpufreq: amd-pstate: initialize core precision
>>>> boost state") sets per-policy boost flag to false when boost fail.
>>>> However, this boost flag will be set to reverse value in
>>>> store_local_boost() and cpufreq_boost_trigger_state() in cpufreq.c. This
>>>> will cause the per-policy boost flag set to true when fail to set boost.
>>>> Remove the extra assignment in amd_pstate_set_boost() and keep all
>>>> operations on per-policy boost flag outside of set_boost() to fix this
>>>> problem.
>>>>
>>>> Fixes: c8c68c38b56f ("cpufreq: amd-pstate: initialize core precision boost state")
>>>> Signed-off-by: Lifeng Zheng <zhenglifeng1@huawei.com>
>>>> ---
>>>
>>> Hi There,
>>>
>>> Thanks for the patch.  Unfortunately, it doesn't apply to the current linux-next branch at https://git.kernel.org/pub/scm/linux/kernel/git/superm1/linux.git
>>
>> Hello Mario,
>>
>> When I try to build on this branch, I got an error:
>>
>> arch/x86/kernel/relocate_kernel_64.o: In function `virtual_mapped':
>> .../linux/arch/x86/kernel/relocate_kernel_64.S:249: undefined reference to `saved_context_gdt_desc'
>> scripts/Makefile.vmlinux:77: recipe for target 'vmlinux' failed
>>
>> This error occurs when CONFIG_KEXEC_JUMP=y, and doesn't occur when build on
>> torvalds master branch with same config. Please check if there is any
>> problem whith this branch.
>>
> Hi,
> 
> It's because the branch is based on an earlier 6.13-rc.
> 
> Two ideas that can help you:
> 
> 1) You can pull this patch manually on top of it to avoid that issue.
> https://git.kernel.org/torvalds/c/aeb68937614f4
> 
> 2) You can manually rebase the branch on newer 6.13-rc locally to make your commit.  That commit that fixed it landed in 6.13-rc3, so rc3 or later would be fine.

This solves the problem, thanks!

> 
>>>
>>> Although the issue you identified is still valid, there have been other contextual changes in the function [1].  Can you rebase on that branch, test it again and send a v2?
>>>
>>> [1] https://git.kernel.org/pub/scm/linux/kernel/git/superm1/linux.git/tree/drivers/cpufreq/amd-pstate.c?h=linux-next#n750
>>>
>>> Thanks!
>>>
>>>>    drivers/cpufreq/amd-pstate.c | 1 -
>>>>    1 file changed, 1 deletion(-)
>>>>
>>>> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
>>>> index 66e5dfc711c0..4ce923788f3a 100644
>>>> --- a/drivers/cpufreq/amd-pstate.c
>>>> +++ b/drivers/cpufreq/amd-pstate.c
>>>> @@ -730,7 +730,6 @@ static int amd_pstate_set_boost(struct cpufreq_policy *policy, int state)
>>>>        mutex_lock(&amd_pstate_driver_lock);
>>>>        ret = amd_pstate_cpu_boost_update(policy, state);
>>>>        WRITE_ONCE(cpudata->boost_state, !ret ? state : false);
>>>> -    policy->boost_enabled = !ret ? state : false;
>>>>        refresh_frequency_limits(policy);
>>>>        mutex_unlock(&amd_pstate_driver_lock);
>>>>    
>>>
>>
> 


