Return-Path: <linux-pm+bounces-23170-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B7951A4981D
	for <lists+linux-pm@lfdr.de>; Fri, 28 Feb 2025 12:11:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D51A11896DAD
	for <lists+linux-pm@lfdr.de>; Fri, 28 Feb 2025 11:12:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1DC4261576;
	Fri, 28 Feb 2025 11:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="C14sm9XU"
X-Original-To: linux-pm@vger.kernel.org
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6756F26157C;
	Fri, 28 Feb 2025 11:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740741105; cv=none; b=EwflBxyZMUdi5cWzvN1Bn0gVK5pQc515QHsCihhLPdx3QeqTXgwmkR8sTHW8/saAOszEz2z1VBYnkMh5nSJAx+VGv1t8bCunIFqdoXiNvPLjOm3nc5gHTfonPUhzsnCXJO5c6EMVKHgyIeBXKGxPfwYlyf2ssNorbGzHrzWCmpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740741105; c=relaxed/simple;
	bh=YuD34HDCBVevDPaLGVJtBZmAYtG5QNk+RZIZJ/O3oMQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xmlhb4U+O08G4JaTUY7o0zrSSckEd22QgIUJkWrdd3EmtUQToCcTQWvBJi+qqyI54wM8uHSbtWynrOfM6xZXLS0/mTJHrkuK2bb4Wfxpecpj+glm8npBYNdDuHJoME7LYf3lNn9nag3NqE/lTHkblYhi7QBUuwxXyL1QIClBgcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=C14sm9XU; arc=none smtp.client-ip=198.47.23.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 51SBBZ592124114
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 28 Feb 2025 05:11:35 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1740741095;
	bh=asqImrv/yYJQ+trytSJVTeaE7rqR1lERUILCexOriWA=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=C14sm9XUww3Zv3doWUTERSq8Co//LZ+fz9KSh8m081ZSWx2NlQVSFPhEBqvId4/tn
	 HUjEh2Rsh68faQbQrRh8vjIhY8sf3vVfkgTQpuUUFBFFrQ9kvI5Seg9gQQZ1Z+qGLl
	 pzhDY/GYzGqPvtvxICjp8wX6vdZr4iiqBKN4m8P0=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 51SBBZdZ048217
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 28 Feb 2025 05:11:35 -0600
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 28
 Feb 2025 05:11:34 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 28 Feb 2025 05:11:35 -0600
Received: from localhost (lcpd911.dhcp.ti.com [172.24.227.226])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 51SBBYkZ031582;
	Fri, 28 Feb 2025 05:11:35 -0600
Date: Fri, 28 Feb 2025 16:41:34 +0530
From: Dhruva Gole <d-gole@ti.com>
To: Kamlesh Gurudasani <kamlesh@ti.com>
CC: Ulf Hansson <ulf.hansson@linaro.org>, <vigneshr@ti.com>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Kevin Hilman
	<khilman@baylibre.com>, Peng Fan <peng.fan@oss.nxp.com>,
        Cristian Marussi
	<cristian.marussi@arm.com>
Subject: Re: [PATCH RFC] pmdomain: core: add support for writeble power
 domain state
Message-ID: <20250228111134.p56fnrcztufuahic@lcpd911>
References: <20250221-pm-debug-v1-1-e5bd815f7ca4@ti.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250221-pm-debug-v1-1-e5bd815f7ca4@ti.com>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

On Feb 21, 2025 at 19:18:10 +0530, Kamlesh Gurudasani wrote:
> Add support for writeable power domain states from debugfs.

ACK.

+CC'ed a few more folks who maybe interested...
 
> Defining GENPD_ALLOW_WRITE_DEBUGFS will enable writeable pd_state
> node in debugfs.
> 
> Signed-off-by: Kamlesh Gurudasani <kamlesh@ti.com>
> ---
> This has turn out to be really helpful when debugging SCMI protocol
> for power domain management.

Agreed, I have found this patch very good for turning off/on power
domains in a "raw" form if you will.
We have also been using something called k3conf on TI K3
class of devices like AM62x family where we basically use a user space
tool to send power on/off/ device status without it going via the kernel
genPD. This approach that Kamlesh is suggesting helps us leverage the
kernel stacks (like SCMI) but while also going via the pmdomain core
driver. This patch helps abstract underneath protocol layers used for power
domain operations in SOCs...

Here's how it looks for anyone wondering: [1]
We also talked about this at last year's Embedded Open Source Summit,
Seattle [2] where we mentioned we'd be upstreaming this patch and the
audience seemed interested to use it.

> 
> Reference has been taken from clock framework which provides similar
> CLOCK_ALLOW_WRITE_DEBUGFS, which helps to test clocks from debugfs.
> ---
>  drivers/pmdomain/core.c | 77 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 77 insertions(+)
> 
> diff --git a/drivers/pmdomain/core.c b/drivers/pmdomain/core.c
> index 9b2f28b34bb5..6aba0c672da0 100644
> --- a/drivers/pmdomain/core.c
> +++ b/drivers/pmdomain/core.c
> @@ -1298,6 +1298,60 @@ late_initcall_sync(genpd_power_off_unused);
>  
>  #ifdef CONFIG_PM_SLEEP
>  
> +#ifdef GENPD_ALLOW_WRITE_DEBUGFS
> +/*
> + * This can be dangerous, therefore don't provide any real compile time
> + * configuration option for this feature.
> + * People who want to use this will need to modify the source code directly.
> + */
> +static int genpd_state_set(void *data, u64 val)
> +{
> +
> +	struct generic_pm_domain *genpd = data;
> +	int ret = 0;
> +
> +	ret = genpd_lock_interruptible(genpd);

Why has it been kept interruptible? Other places I see are just using
genpd_lock(pd);

> +	if (ret)
> +		return -ERESTARTSYS;
> +
> +	if (val == 1) {
> +		genpd->power_on(genpd);
> +		genpd->status = GENPD_STATE_ON;
> +	} else if (val == 0) {
> +		genpd->power_off(genpd);
> +		genpd->status = GENPD_STATE_OFF;
> +	}
> +
> +	genpd_unlock(genpd);
> +	return 0;
> +}
> +
> +#define pd_state_mode	0644

Where's this used?

> +
> +static int genpd_state_get(void *data, u64 *val)
> +{
> +
> +	struct generic_pm_domain *genpd = data;
> +	int ret = 0;
> +
> +	ret = genpd_lock_interruptible(genpd);
> +	if (ret)
> +		return -ERESTARTSYS;
> +
> +	if (genpd->status == GENPD_STATE_OFF)
> +		*val = 0;
> +	else
> +		*val = 1;
> +
> +	genpd_unlock(genpd);
> +	return ret;
> +}
> +
> +DEFINE_DEBUGFS_ATTRIBUTE(pd_state_fops, genpd_state_get,
> +			 genpd_state_set, "%llu\n");
> +
> +#endif /* GENPD_ALLOW_WRITE_DEBUGFS */
> +
>  /**
>   * genpd_sync_power_off - Synchronously power off a PM domain and its parents.
>   * @genpd: PM domain to power off, if possible.
> @@ -3639,6 +3693,11 @@ static void genpd_debug_add(struct generic_pm_domain *genpd)
>  	if (genpd->set_performance_state)
>  		debugfs_create_file("perf_state", 0444,
>  				    d, genpd, &perf_state_fops);
> +#ifdef GENPD_ALLOW_WRITE_DEBUGFS
> +	debugfs_create_file("pd_state", 0644, d, genpd,

Ah this is probably where you wanted to use the #define'd pd_state_mode I guess....

> +			    &pd_state_fops);
> +#endif /* GENPD_ALLOW_WRITE_DEBUGFS */
> +
>  }
>  
>  static int __init genpd_debug_init(void)
> @@ -3653,6 +3712,24 @@ static int __init genpd_debug_init(void)
>  	list_for_each_entry(genpd, &gpd_list, gpd_list_node)
>  		genpd_debug_add(genpd);
>  

Only minor cleanups pending, otherwise patch looks good to me. Hoping
more people can also try it out and jump on this thread with their
thoughts....

Refs:
[1] https://gist.github.com/DhruvaG2000/f3ec24252d4cf2800c97c2e336d0b5db
[2]
https://eoss24.sched.com/event/1aBEs/a-primer-to-clocks-and-power-management-through-arm-scmi-dhruva-gole-kamlesh-gurudasani-texas-instruments

-- 
Best regards,
Dhruva Gole
Texas Instruments Incorporated

