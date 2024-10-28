Return-Path: <linux-pm+bounces-16577-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B388F9B31C9
	for <lists+linux-pm@lfdr.de>; Mon, 28 Oct 2024 14:34:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 716F22846D8
	for <lists+linux-pm@lfdr.de>; Mon, 28 Oct 2024 13:34:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D0691917FA;
	Mon, 28 Oct 2024 13:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G29d776m"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E71992913;
	Mon, 28 Oct 2024 13:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730122485; cv=none; b=o8Zftbef6wRRZPK9FA/gzFWWM+OJVlxD4rR3EW11LhPEvHiUFtbocXMA5k7j8zLzHwMb2IXxNHLA2kb6ZNe5gw0YOrJrOsoJJt+CZ4UZcznyG0j9jeAD0qkBqsYOE6ZBI+7/32ZJSFR2IfkOdv+i+pySeAmr9CwwMpBOWWa1Hgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730122485; c=relaxed/simple;
	bh=XwxqvYBDmnUn+j7grkaXLDj769grXSa8I84Kc/dRT9Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BFM4NpAuIvg3nKBDmqevAXt4K0dWmXhfg7WBqTtc+u5YTBeWr1VzaRiIHTU1KFQtHZcHeQDr6eSVTghYEBi1WXPVOU3OfBtma8C/+NXBWwcG1dAm39nv8EKCqOBjZHFpipl7j2aE6AUcyhL1FpRQBu1FqeIkOHkHd9qQgOjOyK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G29d776m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFEA6C4CEC3;
	Mon, 28 Oct 2024 13:34:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730122484;
	bh=XwxqvYBDmnUn+j7grkaXLDj769grXSa8I84Kc/dRT9Y=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=G29d776mojj36TvyUHgX61KIIa3RYx1CqH9P8jih9fVHZXevxJ9Ta/R0TFwlHq0eu
	 rJE1ZA61BS7/TJLZg9cQT5DiCeKW096/N/RPWylZxDzDppMCHn5ye6WcGkTo8Uoj0/
	 8Mhf4NhtfEw9jTOFejJJO6W7h1pSIeOjXu6iAzBjroybIXSGZwmw4rRQ+FEGqd+DSn
	 hMq20rNxdd4cGIprcfQUBexjhk6r1nmfrzVd1/n9pSPQAjZPpT0Bmo3O+6GxIU6qKh
	 0LuCZoV/SWo+PKKk8dpfAIF3zORrGoGLV0ThM6EXA3BxEBwHTGoQ/Fry6pAsHa8oEp
	 TnW3pmz0dA0VQ==
Message-ID: <70db8fea-a695-476b-83b4-5cd5787dc7de@kernel.org>
Date: Mon, 28 Oct 2024 08:34:42 -0500
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cpufreq: amd-pstate: Register driver after static call
 update
To: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>,
 "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
 Perry Yuan <perry.yuan@amd.com>
Cc: "open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)"
 <linux-kernel@vger.kernel.org>,
 "open list:CPU FREQUENCY SCALING FRAMEWORK" <linux-pm@vger.kernel.org>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Klara Modin <klarasmodin@gmail.com>
References: <20241027122612.749674-1-superm1@kernel.org>
 <145ac73d-000e-46c2-818b-d0d5deefd37a@amd.com>
Content-Language: en-US
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <145ac73d-000e-46c2-818b-d0d5deefd37a@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/27/2024 23:27, Dhananjay Ugwekar wrote:
> Hello Mario,
> 
> On 10/27/2024 5:56 PM, Mario Limonciello wrote:
>> From: Mario Limonciello <mario.limonciello@amd.com>
>>
>> The driver must be registered specifically after the static call
>> update.
>>
>> Fixes: e238968a2087 ("cpufreq/amd-pstate: Remove the redundant amd_pstate_set_driver() call")
>> Reported-and-tested-by: Klara Modin <klarasmodin@gmail.com>
>> Closes: https://lore.kernel.org/linux-pm/cf9c146d-bacf-444e-92e2-15ebf513af96@gmail.com/#t
>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>> ---
>>   drivers/cpufreq/amd-pstate.c | 12 ++++++------
>>   1 file changed, 6 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
>> index 206725219d8c9..2f0e29b05963d 100644
>> --- a/drivers/cpufreq/amd-pstate.c
>> +++ b/drivers/cpufreq/amd-pstate.c
>> @@ -1857,12 +1857,6 @@ static int __init amd_pstate_init(void)
>>   		return -ENODEV;
>>   	}
>>   
>> -	ret = amd_pstate_register_driver(cppc_state);
>> -	if (ret) {
>> -		pr_err("failed to register with return %d\n", ret);
>> -		return ret;
>> -	}
>> -
>>   	/* capability check */
>>   	if (cpu_feature_enabled(X86_FEATURE_CPPC)) {
>>   		pr_debug("AMD CPPC MSR based functionality is supported\n");
> 1865                 if (cppc_state != AMD_PSTATE_ACTIVE)
> 1866                         current_pstate_driver->adjust_perf = amd_pstate_adjust_perf;
> 
> If we move the "amd_pstate_register_driver()" call to the below point, wont the above dereference (current_pstate_driver->)
> cause a null pointer error in MSR based systems with amd_pstate=passive/guided boot param. As we initialize
> "current_pstate_driver" in amd_pstate_register_driver().
> 
> We probably need to break up the if-else condition and handle the MSR based "if" part after the register call and "else"
> part before the "amd_pstate_register_driver()" call.
> 
> Something like,
> 		
> 	if (!cpu_feature_enabled(X86_FEATURE_CPPC)) {
>                   pr_debug("AMD CPPC shared memory based functionality is supported\n");
>                   static_call_update(amd_pstate_enable, shmem_enable);
>                   static_call_update(amd_pstate_init_perf, shmem_init_perf);
>                   static_call_update(amd_pstate_update_perf, shmem_update_perf);  	<---- static call updates done
>      	}
> 	
> 	ret = amd_pstate_register_driver(cppc_state);					<---- Initializes "current_pstate_driver"
> 	if (ret) {
> 		pr_err("failed to register with return %d\n", ret);
> 		return ret;
> 	}
> 	
> 	if (cpu_feature_enabled(X86_FEATURE_CPPC)) {
> 		pr_debug("AMD CPPC MSR based functionality is supported\n");
>                  if (cppc_state != AMD_PSTATE_ACTIVE)
>                           current_pstate_driver->adjust_perf = amd_pstate_adjust_perf;	<---- Now we dereference "current_pstate_driver"
> 	}
> 	
> 
> What do you think?

Makes sense, I'll send out a v2 like this, thanks for the suggestion.

> 
> Thanks,
> Dhananjay
> 
>> @@ -1881,6 +1875,12 @@ static int __init amd_pstate_init(void)
>>   			return ret;
>>   	}
>>   
>> +	ret = amd_pstate_register_driver(cppc_state);
>> +	if (ret) {
>> +		pr_err("failed to register with return %d\n", ret);
>> +		return ret;
>> +	}
>> +
>>   	dev_root = bus_get_dev_root(&cpu_subsys);
>>   	if (dev_root) {
>>   		ret = sysfs_create_group(&dev_root->kobj, &amd_pstate_global_attr_group);


