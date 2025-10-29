Return-Path: <linux-pm+bounces-37016-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C13AAC19474
	for <lists+linux-pm@lfdr.de>; Wed, 29 Oct 2025 10:04:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A8F31A25A0E
	for <lists+linux-pm@lfdr.de>; Wed, 29 Oct 2025 09:01:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 997A521765B;
	Wed, 29 Oct 2025 09:00:34 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFEA02D46A1;
	Wed, 29 Oct 2025 09:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761728434; cv=none; b=JKIoyBjnMHJ7QC78rLMWnBL/ITGj03SDpXFz0D/PgGEOkH4XohS5DBz9SxWNgey+OQf8swX+8Q+/obzJQU9mjulb5cLulJSpzVIPKqmCRrqPadIcvyVhNbIKqnO9r0NkfUIIH2yMUR/FAOMVXt5IV9X80zlPVk0iRIS6P0k3Njk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761728434; c=relaxed/simple;
	bh=6CFkJz4ydlkqTa25ChD49yEx481uFMJXakRCvwZ0Jl0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aHR9vJmlyPnY7aqKS3TX6q0uRYt9Q2GpsvGXbdFpDz+6aFlioJLcFzj/NtQGP/Hm9dMqPtwko2K/7EXmlZ3B1a6jRcZh/5ID6t5B5S+aT6GsNtmAH4rjprqpHMQp44oaXUbXglHMyjnTgn+fyL4IpUCXhqDjnLqNuiRwVy4g7M0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 468A61AC1;
	Wed, 29 Oct 2025 02:00:17 -0700 (PDT)
Received: from [10.57.38.252] (unknown [10.57.38.252])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DE3563F63F;
	Wed, 29 Oct 2025 02:00:22 -0700 (PDT)
Message-ID: <40c2f7d9-23cf-4536-a1b1-0a55a0707830@arm.com>
Date: Wed, 29 Oct 2025 09:00:55 +0000
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC] PM: EM: Add to em_pd_list only when no failure
To: Peng Fan <peng.fan@nxp.com>
Cc: arm-scmi@vger.kernel.org, Sudeep Holla <sudeep.holla@arm.com>,
 Pavel Machek <pavel@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>,
 Cristian Marussi <cristian.marussi@arm.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org, Len Brown <lenb@kernel.org>,
 Changwoo Min <changwoo@igalia.com>
References: <20251028-fix-energy-v1-1-ab854fd6a97c@nxp.com>
Content-Language: en-US
From: Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <20251028-fix-energy-v1-1-ab854fd6a97c@nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 10/28/25 14:23, Peng Fan wrote:
> When em_create_perf_table() returns failure, pd is freed, there dev->em_pd
> is not valid. Then accessing dev->em_pd->node will trigger kernel panic
> in em_dev_register_pd_no_update(). So return early if 'ret' is non-zero.
> 
> Kernel dump:
> cpu cpu0: EM: invalid power: 0
> Unable to handle kernel NULL pointer dereference at virtual address
> 0000000000000008
> Mem abort info:
> pc : em_dev_register_pd_no_update+0xb4/0x79c
> lr : em_dev_register_pd_no_update+0x9c/0x79c
> Call trace:
>   em_dev_register_pd_no_update+0xb4/0x79c (P)
>   em_dev_register_perf_domain+0x18/0x58
>   scmi_cpufreq_register_em+0x84/0xb8
>   cpufreq_online+0x48c/0xb74
>   cpufreq_add_dev+0x80/0x98
>   subsys_interface_register+0x100/0x11c
>   cpufreq_register_driver+0x158/0x278
>   scmi_cpufreq_probe+0x1f8/0x2e0
>   scmi_dev_probe+0x28/0x3c
>   really_probe+0xbc/0x29c
>   __driver_probe_device+0x78/0x12c
>   driver_probe_device+0x3c/0x15c
>   __device_attach_driver+0xb8/0x134
>   bus_for_each_drv+0x84/0xe4
> 
> Fixes: cbe5aeedecc7 ("PM: EM: Assign a unique ID when creating a performance domain")
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>   kernel/power/energy_model.c | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/power/energy_model.c b/kernel/power/energy_model.c
> index e669d5057fca6da9612575a1c626474e60e7f7c4..11af9f64aa8276e47e0a5b2d615b227368af5480 100644
> --- a/kernel/power/energy_model.c
> +++ b/kernel/power/energy_model.c
> @@ -693,13 +693,16 @@ int em_dev_register_pd_no_update(struct device *dev, unsigned int nr_states,
>   
>   unlock:
>   	mutex_unlock(&em_pd_mutex);
> +	if (ret)
> +		return ret;
>   
>   	mutex_lock(&em_pd_list_mutex);
>   	list_add_tail(&dev->em_pd->node, &em_pd_list);
>   	mutex_unlock(&em_pd_list_mutex);
>   
>   	em_notify_pd_created(dev->em_pd);
> -	return ret;
> +
> +	return 0;
>   }
>   EXPORT_SYMBOL_GPL(em_dev_register_pd_no_update);
>   
> 
> ---
> base-commit: f7d2388eeec24966fc4d5cf32d706f0514f29ac5
> change-id: 20251028-fix-energy-6b63b72ae9c6
> 
> Best regards,


Thank you for the patch!

Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>

