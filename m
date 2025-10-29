Return-Path: <linux-pm+bounces-36997-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 45CA8C178FA
	for <lists+linux-pm@lfdr.de>; Wed, 29 Oct 2025 01:37:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E3B59355323
	for <lists+linux-pm@lfdr.de>; Wed, 29 Oct 2025 00:37:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C3AD2C3277;
	Wed, 29 Oct 2025 00:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="dqjShmvh"
X-Original-To: linux-pm@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 187C828489E;
	Wed, 29 Oct 2025 00:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761698253; cv=none; b=A9iAeo+7bH+Oti4WiNk6oJz4f3iGMcTYGy7i07YHJhIM0F4Dss+/3Q0Ixi8ZVVcWrB7zKldOr3N/wlOjX7KifACM3lOcAi/u5vDF4hH94wnzenhsfJh8SvmupyicJxcDQE25lLoWwUCP67xZXh/5gBV3yTUsohdmz2X7ckQzzfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761698253; c=relaxed/simple;
	bh=n4U5sktTWDNfljsftyz9lEtPPFzgeB/BYQXUA+Vu5Nc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MsStRcPJ6UON9s8pRQB7pPiZgxu+5som5ca1Ju+jS76H/OYjTsnuW5xWTnyLpdXx+9WN1VXKORdriAHY+YfgoLbFyUCXVlLJ7YJaPxgpi00tPUyf0NeXKaO8p/XKwx5cjG0KabXoXmaKXNWha47+fw4MxlMv2lODdzS4ULloMM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=dqjShmvh; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=pvFBzg0ivoS4HqTxLkoVPFh0lZtIc5fGtLrqfQHAED4=; b=dqjShmvhGXzhonzvXmF1g6445N
	Xfp1gZxMGtPqxvDlbOqT414S+n9Rn7T+wH8fQvM8X4eoJhuIPqjQTr7DJqgTgz5Ejlbx/XxSOY4cE
	tbnC9r57ZxkQzODIKk9c+9hl0op1nb78H3KcNz0253wwMJQ0jsjOTX4CrkuQOcWJajH9oru3ZAbte
	az+f/u2x/AUiZaXBfnovvQ0fr8+btNX7B4NTsjkHmASeHbOrvktU4qFl4Hn4/dOwINRF/MibSXYqq
	J66B5JqiCdxWhWhQk5bdd7Hg4fqHeftZzdZFe2tDTHzHwD3E63Wzj0ZK68aew95eoLe7bq0p2Oha9
	zx9Pe8OQ==;
Received: from [58.29.143.236] (helo=[192.168.1.7])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1vDuBh-00GOeg-CP; Wed, 29 Oct 2025 01:37:17 +0100
Message-ID: <819e3c75-9831-4190-aa01-e76aed423460@igalia.com>
Date: Wed, 29 Oct 2025 09:37:02 +0900
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC] PM: EM: Add to em_pd_list only when no failure
To: Peng Fan <peng.fan@nxp.com>, Lukasz Luba <lukasz.luba@arm.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@kernel.org>,
 Len Brown <lenb@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>,
 Sudeep Holla <sudeep.holla@arm.com>,
 Cristian Marussi <cristian.marussi@arm.com>
Cc: arm-scmi@vger.kernel.org, "Rafael J. Wysocki"
 <rafael.j.wysocki@intel.com>, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20251028-fix-energy-v1-1-ab854fd6a97c@nxp.com>
From: Changwoo Min <changwoo@igalia.com>
Content-Language: en-US, ko-KR, en-US-large, ko
In-Reply-To: <20251028-fix-energy-v1-1-ab854fd6a97c@nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Thanks, Peng, for catching this. This makes sense.
So, feel free to add:

Reviewed-by: Changwoo Min <changwoo@igalia.com>

On 10/28/25 23:23, Peng Fan wrote:
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


