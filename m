Return-Path: <linux-pm+bounces-37694-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 80819C44531
	for <lists+linux-pm@lfdr.de>; Sun, 09 Nov 2025 19:36:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 0532434679B
	for <lists+linux-pm@lfdr.de>; Sun,  9 Nov 2025 18:36:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76804221277;
	Sun,  9 Nov 2025 18:36:34 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99C9A23535E;
	Sun,  9 Nov 2025 18:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762713394; cv=none; b=DMnyFRLTxoEz++lq5DBMxhO57ss96WFXigrZFwMZV7WC+5M6T1Oqt5NjkxI95PgglHJGndujZyWC3gGcLr0f1am6fiJOSOs0S+Fz8/mGVjoOfEbV6ZIZUGEfRDxSXKYSQi13aRqtUikkBwAeQO9ZM6GEc9E8XVJvZtdssAlwrNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762713394; c=relaxed/simple;
	bh=O1kqeBDqLc8VqrzuUp5s89T5uvVtLs0zaf+FUvVaXOE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ApMZ4V2l7RtuAPQtjQpbNdyGnY7iVCqnbdawH1SLKN4Tbmz+TZZNENNi1GWov9xtAFb0lrBPn6SbYP+mjYovaCBt6oBvCFBSmCt6tI8jVp2vHRI1PrBGBt54N8eYK7w7JR/Ba5QWWH9MIKPvsEo7Bi1V3t5FTTHhzZRytWInoTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
Received: from [192.168.100.50] (unknown [144.48.130.189])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: usama.anjum)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 0D08D17E00B0;
	Sun,  9 Nov 2025 19:36:23 +0100 (CET)
Message-ID: <d09a70c8-4d07-476a-87d3-671c24c97b32@gmail.com>
Date: Sun, 9 Nov 2025 23:36:05 +0500
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] cpufreq: intel_pstate: Use mutex guard for driver
 locking
To: "Rafael J. Wysocki" <rafael@kernel.org>,
 Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
References: <2807232.mvXUDI8C0e@rafael.j.wysocki>
Content-Language: en-US
From: Muhammad Usama Anjum <MUsamaAnjum@gmail.com>
In-Reply-To: <2807232.mvXUDI8C0e@rafael.j.wysocki>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/7/25 11:18 PM, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Use guard(mutex)(&intel_pstate_driver_lock), or the scoped variant of
> it, wherever intel_pstate_driver_lock needs to be held.
It really simplifies the code.

Reviewed-by: Muhammad Usama Anjum <usama.anjum@collabora.com>

> 
> This allows some local variables and goto statements to be dropped as
> they are not necessary any more.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  drivers/cpufreq/intel_pstate.c |   99 +++++++++++++----------------------------
>  1 file changed, 33 insertions(+), 66 deletions(-)
> 
> --- a/drivers/cpufreq/intel_pstate.c
> +++ b/drivers/cpufreq/intel_pstate.c
> @@ -1467,7 +1467,8 @@ static void set_power_ctl_ee_state(bool
>  {
>  	u64 power_ctl;
>  
> -	mutex_lock(&intel_pstate_driver_lock);
> +	guard(mutex)(&intel_pstate_driver_lock);
> +
>  	rdmsrq(MSR_IA32_POWER_CTL, power_ctl);
>  	if (input) {
>  		power_ctl &= ~BIT(MSR_IA32_POWER_CTL_BIT_EE);
> @@ -1477,7 +1478,6 @@ static void set_power_ctl_ee_state(bool
>  		power_ctl_ee_state = POWER_CTL_EE_DISABLE;
>  	}
>  	wrmsrq(MSR_IA32_POWER_CTL, power_ctl);
> -	mutex_unlock(&intel_pstate_driver_lock);
>  }
>  
>  static void intel_pstate_hwp_enable(struct cpudata *cpudata);
> @@ -1599,13 +1599,9 @@ static int intel_pstate_update_status(co
>  static ssize_t show_status(struct kobject *kobj,
>  			   struct kobj_attribute *attr, char *buf)
>  {
> -	ssize_t ret;
> -
> -	mutex_lock(&intel_pstate_driver_lock);
> -	ret = intel_pstate_show_status(buf);
> -	mutex_unlock(&intel_pstate_driver_lock);
> +	guard(mutex)(&intel_pstate_driver_lock);
>  
> -	return ret;
> +	return intel_pstate_show_status(buf);
>  }
>  
>  static ssize_t store_status(struct kobject *a, struct kobj_attribute *b,
> @@ -1614,11 +1610,13 @@ static ssize_t store_status(struct kobje
>  	char *p = memchr(buf, '\n', count);
>  	int ret;
>  
> -	mutex_lock(&intel_pstate_driver_lock);
> +	guard(mutex)(&intel_pstate_driver_lock);
> +
>  	ret = intel_pstate_update_status(buf, p ? p - buf : count);
> -	mutex_unlock(&intel_pstate_driver_lock);
> +	if (ret < 0)
> +		return ret;
>  
> -	return ret < 0 ? ret : count;
> +	return count;
>  }
>  
>  static ssize_t show_turbo_pct(struct kobject *kobj,
> @@ -1628,12 +1626,10 @@ static ssize_t show_turbo_pct(struct kob
>  	int total, no_turbo, turbo_pct;
>  	uint32_t turbo_fp;
>  
> -	mutex_lock(&intel_pstate_driver_lock);
> +	guard(mutex)(&intel_pstate_driver_lock);
>  
> -	if (!intel_pstate_driver) {
> -		mutex_unlock(&intel_pstate_driver_lock);
> +	if (!intel_pstate_driver)
>  		return -EAGAIN;
> -	}
>  
>  	cpu = all_cpu_data[0];
>  
> @@ -1642,8 +1638,6 @@ static ssize_t show_turbo_pct(struct kob
>  	turbo_fp = div_fp(no_turbo, total);
>  	turbo_pct = 100 - fp_toint(mul_fp(turbo_fp, int_tofp(100)));
>  
> -	mutex_unlock(&intel_pstate_driver_lock);
> -
>  	return sprintf(buf, "%u\n", turbo_pct);
>  }
>  
> @@ -1653,38 +1647,26 @@ static ssize_t show_num_pstates(struct k
>  	struct cpudata *cpu;
>  	int total;
>  
> -	mutex_lock(&intel_pstate_driver_lock);
> +	guard(mutex)(&intel_pstate_driver_lock);
>  
> -	if (!intel_pstate_driver) {
> -		mutex_unlock(&intel_pstate_driver_lock);
> +	if (!intel_pstate_driver)
>  		return -EAGAIN;
> -	}
>  
>  	cpu = all_cpu_data[0];
>  	total = cpu->pstate.turbo_pstate - cpu->pstate.min_pstate + 1;
>  
> -	mutex_unlock(&intel_pstate_driver_lock);
> -
>  	return sprintf(buf, "%u\n", total);
>  }
>  
>  static ssize_t show_no_turbo(struct kobject *kobj,
>  			     struct kobj_attribute *attr, char *buf)
>  {
> -	ssize_t ret;
> -
> -	mutex_lock(&intel_pstate_driver_lock);
> +	guard(mutex)(&intel_pstate_driver_lock);
>  
> -	if (!intel_pstate_driver) {
> -		mutex_unlock(&intel_pstate_driver_lock);
> +	if (!intel_pstate_driver)
>  		return -EAGAIN;
> -	}
> -
> -	ret = sprintf(buf, "%u\n", global.no_turbo);
> -
> -	mutex_unlock(&intel_pstate_driver_lock);
>  
> -	return ret;
> +	return sprintf(buf, "%u\n", global.no_turbo);
>  }
>  
>  static ssize_t store_no_turbo(struct kobject *a, struct kobj_attribute *b,
> @@ -1696,29 +1678,25 @@ static ssize_t store_no_turbo(struct kob
>  	if (sscanf(buf, "%u", &input) != 1)
>  		return -EINVAL;
>  
> -	mutex_lock(&intel_pstate_driver_lock);
> +	guard(mutex)(&intel_pstate_driver_lock);
>  
> -	if (!intel_pstate_driver) {
> -		count = -EAGAIN;
> -		goto unlock_driver;
> -	}
> +	if (!intel_pstate_driver)
> +		return -EAGAIN;
>  
>  	no_turbo = !!clamp_t(int, input, 0, 1);
>  
>  	WRITE_ONCE(global.turbo_disabled, turbo_is_disabled());
>  	if (global.turbo_disabled && !no_turbo) {
>  		pr_notice("Turbo disabled by BIOS or unavailable on processor\n");
> -		count = -EPERM;
>  		if (global.no_turbo)
> -			goto unlock_driver;
> -		else
> -			no_turbo = 1;
> -	}
> +			return -EPERM;
>  
> -	if (no_turbo == global.no_turbo) {
> -		goto unlock_driver;
> +		no_turbo = 1;
>  	}
>  
> +	if (no_turbo == global.no_turbo)
> +		return count;
> +
>  	WRITE_ONCE(global.no_turbo, no_turbo);
>  
>  	mutex_lock(&intel_pstate_limits_lock);
> @@ -1737,9 +1715,6 @@ static ssize_t store_no_turbo(struct kob
>  	intel_pstate_update_limits_for_all();
>  	arch_set_max_freq_ratio(no_turbo);
>  
> -unlock_driver:
> -	mutex_unlock(&intel_pstate_driver_lock);
> -
>  	return count;
>  }
>  
> @@ -1789,12 +1764,10 @@ static ssize_t store_max_perf_pct(struct
>  	if (ret != 1)
>  		return -EINVAL;
>  
> -	mutex_lock(&intel_pstate_driver_lock);
> +	guard(mutex)(&intel_pstate_driver_lock);
>  
> -	if (!intel_pstate_driver) {
> -		mutex_unlock(&intel_pstate_driver_lock);
> +	if (!intel_pstate_driver)
>  		return -EAGAIN;
> -	}
>  
>  	mutex_lock(&intel_pstate_limits_lock);
>  
> @@ -1807,8 +1780,6 @@ static ssize_t store_max_perf_pct(struct
>  	else
>  		update_qos_requests(FREQ_QOS_MAX);
>  
> -	mutex_unlock(&intel_pstate_driver_lock);
> -
>  	return count;
>  }
>  
> @@ -1822,12 +1793,10 @@ static ssize_t store_min_perf_pct(struct
>  	if (ret != 1)
>  		return -EINVAL;
>  
> -	mutex_lock(&intel_pstate_driver_lock);
> +	guard(mutex)(&intel_pstate_driver_lock);
>  
> -	if (!intel_pstate_driver) {
> -		mutex_unlock(&intel_pstate_driver_lock);
> +	if (!intel_pstate_driver)
>  		return -EAGAIN;
> -	}
>  
>  	mutex_lock(&intel_pstate_limits_lock);
>  
> @@ -1841,8 +1810,6 @@ static ssize_t store_min_perf_pct(struct
>  	else
>  		update_qos_requests(FREQ_QOS_MIN);
>  
> -	mutex_unlock(&intel_pstate_driver_lock);
> -
>  	return count;
>  }
>  
> @@ -1863,10 +1830,10 @@ static ssize_t store_hwp_dynamic_boost(s
>  	if (ret)
>  		return ret;
>  
> -	mutex_lock(&intel_pstate_driver_lock);
> +	guard(mutex)(&intel_pstate_driver_lock);
> +
>  	hwp_boost = !!input;
>  	intel_pstate_update_policies();
> -	mutex_unlock(&intel_pstate_driver_lock);
>  
>  	return count;
>  }
> @@ -3977,9 +3944,9 @@ hwp_cpu_matched:
>  
>  	}
>  
> -	mutex_lock(&intel_pstate_driver_lock);
> -	rc = intel_pstate_register_driver(default_driver);
> -	mutex_unlock(&intel_pstate_driver_lock);
> +	scoped_guard(mutex, &intel_pstate_driver_lock) {
> +		rc = intel_pstate_register_driver(default_driver);
> +	}
>  	if (rc) {
>  		intel_pstate_sysfs_remove();
>  		return rc;
> 
> 
> 


