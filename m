Return-Path: <linux-pm+bounces-3518-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D326B84C2F9
	for <lists+linux-pm@lfdr.de>; Wed,  7 Feb 2024 04:17:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 038601C217A1
	for <lists+linux-pm@lfdr.de>; Wed,  7 Feb 2024 03:17:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07118F9E0;
	Wed,  7 Feb 2024 03:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="k9AW5i/K"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1895D1CAB3;
	Wed,  7 Feb 2024 03:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707275859; cv=none; b=L8NGb49feKz/1IK9dv8vq4GNErdHZKff7owqib4fWe3cPoBL3rf+3wQpDoX5CBsrqubElSnhWONf8w21VFgbHpCVrw4Hz085l6KNMoYLyrDkjMaqtlD6n8smRGbZqy+tEPmZDeXMbpnO7m9oa58lG6Dyc2tI1uq1swRKtAVOkO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707275859; c=relaxed/simple;
	bh=UM1c6ee1czq19GX2kBBAW2nsfxfKEYoOdX0v8dDrmiQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DBejCqHRvKykHgFGojiN/4wJEq8xHrmRJKUCgxAaRrnJlSqYyE63LWMFhZXJsL6H8UfdqqFkEUMd71ObQtcQrQIwHAfj+8xsvPKY9zPWbaSaJZg4rekWh9/eDGdznw+o8NfuuLYlSl+UexNvl8KDAzXZcD00DGjofBnmpGKbDfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=k9AW5i/K; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707275859; x=1738811859;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=UM1c6ee1czq19GX2kBBAW2nsfxfKEYoOdX0v8dDrmiQ=;
  b=k9AW5i/KUKkDH9heFfP/0sTbeZWCNIW3/8usaMV2PHHO/vTTehSM4uRu
   i/sJ56UlQ0SWYeOPsxUroH/wbmWs3KsYIDr58iCuIlcQ8MXPlCiNVOVFS
   kDb/OV6JjOi6eB35NLTbfGTBJEc/6zNfHrnW2mQ/eZoT2nrhRyUFbu8XX
   /6pKIBacspw7hrIGSZgklEENIlFpvEykTsykx+2W03zF8Bn+hDcnGeGNN
   3nQ8kNcARUv3AcHZ+/C0k+zt4NbN+qiDeF2RCD5jcRY04J9zycT+d1VhA
   th1wxIYGqBBfy2virAW9UknT3pXqcjcizkKOiRqLp16D+TwnKVBTmHG9M
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10976"; a="12256403"
X-IronPort-AV: E=Sophos;i="6.05,250,1701158400"; 
   d="scan'208";a="12256403"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2024 19:17:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,250,1701158400"; 
   d="scan'208";a="1565836"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2024 19:17:37 -0800
Date: Tue, 6 Feb 2024 19:18:54 -0800
From: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To: Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>
Cc: linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Johannes Berg <johannes@sipsolutions.net>,
	Florian Westphal <fw@strlen.de>, netdev@vger.kernel.org,
	Zhuocheng Ding <zhuocheng.ding@intel.com>,
	Zhao Liu <zhao1.liu@intel.com>, zhenyu.z.wang@intel.com
Subject: Re: [PATCH v2 3/3] thermal: intel: hfi: Enable interface only when
 required
Message-ID: <20240207031854.GC19695@ranerica-svr.sc.intel.com>
References: <20240206133605.1518373-1-stanislaw.gruszka@linux.intel.com>
 <20240206133605.1518373-4-stanislaw.gruszka@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240206133605.1518373-4-stanislaw.gruszka@linux.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)

On Tue, Feb 06, 2024 at 02:36:05PM +0100, Stanislaw Gruszka wrote:
> Enable and disable hardware feedback interface (HFI) when user space
> handler is present. For example, enable HFI, when intel-speed-select or
> Intel Low Power daemon is running and subscribing to thermal netlink
> events. When user space handlers exit or remove subscription for
> thermal netlink events, disable HFI.
> 
> Summary of changes:
> 
> - Register a thermal genetlink notifier
> 
> - In the notifier, process THERMAL_NOTIFY_BIND and THERMAL_NOTIFY_UNBIND
> reason codes to count number of thermal event group netlink multicast
> clients. If thermal netlink group has any listener enable HFI on all
> packages. If there are no listener disable HFI on all packages.
> 
> - When CPU is online, instead of blindly enabling HFI, check if
> the thermal netlink group has any listener. This will make sure that
> HFI is not enabled by default during boot time.
> 
> - Actual processing to enable/disable matches what is done in
> suspend/resume callbacks. Create two functions hfi_do_enable()
> and hfi_do_disable(), which can be called from  the netlink notifier
> callback and suspend/resume callbacks.
> 
> Signed-off-by: Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>
> ---
>  drivers/thermal/intel/intel_hfi.c | 95 +++++++++++++++++++++++++++----
>  1 file changed, 85 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/thermal/intel/intel_hfi.c b/drivers/thermal/intel/intel_hfi.c
> index 3b04c6ec4fca..5e1e2b5269b7 100644
> --- a/drivers/thermal/intel/intel_hfi.c
> +++ b/drivers/thermal/intel/intel_hfi.c
> @@ -159,6 +159,7 @@ struct hfi_cpu_info {
>  static DEFINE_PER_CPU(struct hfi_cpu_info, hfi_cpu_info) = { .index = -1 };
>  
>  static int max_hfi_instances;
> +static int hfi_thermal_clients_num;

Perhaps this counter can be generalized for other clients besides netlink.
KVM could also use it to enable/disable HFI as needed for virtual machines.

Maybe we should expose a function intel_hfi_toggle(bool enable) or a couple
of intel_hfi_enable()/intel_hfi_disable() functions. The former would
increase the counter and enable HFI on all packages. The latter would
decrease the counter and disable HFI if the counter becomes 0.

>  static struct hfi_instance *hfi_instances;
>  
>  static struct hfi_features hfi_features;
> @@ -477,8 +478,11 @@ void intel_hfi_online(unsigned int cpu)
>  enable:
>  	cpumask_set_cpu(cpu, hfi_instance->cpus);
>  
> -	/* Enable this HFI instance if this is its first online CPU. */
> -	if (cpumask_weight(hfi_instance->cpus) == 1) {
> +	/*
> +	 * Enable this HFI instance if this is its first online CPU and
> +	 * there are user-space clients of thermal events.
> +	 */
> +	if (cpumask_weight(hfi_instance->cpus) == 1 && hfi_thermal_clients_num > 0) {
>  		hfi_set_hw_table(hfi_instance);
>  		hfi_enable();
>  	}
> @@ -573,28 +577,93 @@ static __init int hfi_parse_features(void)
>  	return 0;
>  }
>  
> -static void hfi_do_enable(void)
> +/*
> + * HFI enable/disable run in non-concurrent manner on boot CPU in syscore
> + * callbacks or under protection of hfi_instance_lock.
> + */
> +static void hfi_do_enable(void *ptr)
> +{
> +	struct hfi_instance *hfi_instance = ptr;
> +
> +	hfi_set_hw_table(hfi_instance);
> +	hfi_enable();
> +}
> +
> +static void hfi_do_disable(void *ptr)
> +{
> +	hfi_disable();
> +}
> +
> +static void hfi_syscore_resume(void)
>  {
>  	/* This code runs only on the boot CPU. */
>  	struct hfi_cpu_info *info = &per_cpu(hfi_cpu_info, 0);
>  	struct hfi_instance *hfi_instance = info->hfi_instance;
>  
> -	/* No locking needed. There is no concurrency with CPU online. */
> -	hfi_set_hw_table(hfi_instance);
> -	hfi_enable();
> +	if (hfi_thermal_clients_num > 0)
> +		hfi_do_enable(hfi_instance);
>  }
>  
> -static int hfi_do_disable(void)
> +static int hfi_syscore_suspend(void)
>  {
> -	/* No locking needed. There is no concurrency with CPU offline. */
>  	hfi_disable();
>  
>  	return 0;
>  }
>  
>  static struct syscore_ops hfi_pm_ops = {
> -	.resume = hfi_do_enable,
> -	.suspend = hfi_do_disable,
> +	.resume = hfi_syscore_resume,
> +	.suspend = hfi_syscore_suspend,
> +};
> +
> +static int hfi_thermal_notify(struct notifier_block *nb, unsigned long state,
> +			      void *_notify)
> +{
> +	struct thermal_genl_notify *notify = _notify;
> +	struct hfi_instance *hfi_instance;
> +	smp_call_func_t func;
> +	unsigned int cpu;
> +	int i;
> +
> +	if (notify->mcgrp != THERMAL_GENL_EVENT_GROUP)
> +		return NOTIFY_DONE;
> +
> +	if (state != THERMAL_NOTIFY_BIND && state != THERMAL_NOTIFY_UNBIND)
> +		return NOTIFY_DONE;
> +
> +	mutex_lock(&hfi_instance_lock);
> +
> +	switch (state) {
> +	case THERMAL_NOTIFY_BIND:
> +		hfi_thermal_clients_num++;
> +		break;

Perhaps here you could call intel_hfi_enable()

> +	case THERMAL_NOTIFY_UNBIND:
> +		hfi_thermal_clients_num--;
> +		break;
> +	}

and here intel_hfi_disable().

> +
> +	if (hfi_thermal_clients_num > 0)
> +		func = hfi_do_enable;
> +	else
> +		func = hfi_do_disable;
> +
> +	for (i = 0; i < max_hfi_instances; i++) {
> +		hfi_instance = &hfi_instances[i];
> +		if (cpumask_empty(hfi_instance->cpus))
> +			continue;
> +
> +		cpu = cpumask_any(hfi_instance->cpus);
> +		smp_call_function_single(cpu, func, hfi_instance, true);
> +	}

This block would go in a helper function.

I know this is beyond the scope of the patchset but it would make the
logic more generic for other clients to use.
> +
> +	mutex_unlock(&hfi_instance_lock);
> +
> +	return NOTIFY_OK;
> +}
> +
> +static struct notifier_block hfi_thermal_nb = {
> +	.notifier_call = hfi_thermal_notify,
>  };
>  
>  void __init intel_hfi_init(void)
> @@ -628,10 +697,16 @@ void __init intel_hfi_init(void)
>  	if (!hfi_updates_wq)
>  		goto err_nomem;
>  
> +	if (thermal_genl_register_notifier(&hfi_thermal_nb))
> +		goto err_nl_notif;
> +
>  	register_syscore_ops(&hfi_pm_ops);
>  
>  	return;
>  
> +err_nl_notif:
> +	destroy_workqueue(hfi_updates_wq);
> +
>  err_nomem:
>  	for (j = 0; j < i; ++j) {
>  		hfi_instance = &hfi_instances[j];
> -- 
> 2.34.1
> 

