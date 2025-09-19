Return-Path: <linux-pm+bounces-35017-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BAF5B87E3D
	for <lists+linux-pm@lfdr.de>; Fri, 19 Sep 2025 07:09:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D0C11B287F4
	for <lists+linux-pm@lfdr.de>; Fri, 19 Sep 2025 05:10:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3506278E53;
	Fri, 19 Sep 2025 05:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="XHLOVMEB"
X-Original-To: linux-pm@vger.kernel.org
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8CCE2773F1;
	Fri, 19 Sep 2025 05:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758258578; cv=none; b=RLgt+4ceIJlFvL8jkGlnjhA0P6ygzUljhuLClGWJK2tLSG5KDhb8uthctlH/aMWUehKMyXn+D138CjmKOX19uF4OMiDxN6KaJbEeo+LoyoGGr8ipF77YzTdjjShdgsZRJry3UlFLWWUIOv83dkx6NV3QUZngRw7K/E96JnZ9NbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758258578; c=relaxed/simple;
	bh=F5Jn/Mw/73cU80/MsvIS8ddwx6SEJwWBFV97LvLrvuk=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FCxI5BN6tSn9nYy04l2QF7E/k6T1+DQ8M1w7qegSYGYg94AMJTU+NvJrZV6j+UbBs0SEGd/16Ow5xc52Or7Y8nJX1WQ16z/XM/bFIvAOki5EHqeXuIbE44sSLDkCQIjMFxJ3xFa/j4HXek7h9eXgUFOWjbGQphlxog0ChJEKwxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=XHLOVMEB; arc=none smtp.client-ip=198.47.19.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllvem-sh04.itg.ti.com ([10.64.41.54])
	by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTP id 58J59U8J166712;
	Fri, 19 Sep 2025 00:09:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1758258570;
	bh=6HUcjp3FlOUvL5hKJJeDh2/Ly9RvpAMmBbfH7nsNabg=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=XHLOVMEB6/jMFHCd/GsCXR9F/TFETn2jtrmeVUfzmHTYw+tipQm2QPnkri/45wZIh
	 8sXgV4DBcBD3cO3kYqBYVkBnxSOGUztYvUwfPtLVhT5K+q1t0LgV6oU70iBWvfiJKQ
	 6YYPChw/yVSFWxo8FVQ/UIO3WPPpJBhwcLaGK9nA=
Received: from DLEE207.ent.ti.com (dlee207.ent.ti.com [157.170.170.95])
	by fllvem-sh04.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 58J59U2U3694328
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 19 Sep 2025 00:09:30 -0500
Received: from DLEE201.ent.ti.com (157.170.170.76) by DLEE207.ent.ti.com
 (157.170.170.95) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 19 Sep
 2025 00:09:29 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE201.ent.ti.com
 (157.170.170.76) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Fri, 19 Sep 2025 00:09:29 -0500
Received: from localhost (lcpd911.dhcp.ti.com [172.24.233.130])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 58J59ScT1741305;
	Fri, 19 Sep 2025 00:09:29 -0500
Date: Fri, 19 Sep 2025 10:39:28 +0530
From: Dhruva Gole <d-gole@ti.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
CC: Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH v1] cpuidle: Fail cpuidle device registration if there is
 one already
Message-ID: <20250919050928.6sprmdpz2pwgydcc@lcpd911>
References: <3374815.aeNJFYEL58@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <3374815.aeNJFYEL58@rafael.j.wysocki>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Hi Rafael,

On Sep 18, 2025 at 23:19:20 +0200, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Refuse to register a cpuidle device if the given CPU has a cpuidle
> device already and print a message regarding it.
> 
> Without this, an attempt to register a new cpuidle device without
> unregistering the existing one leads to the removal of the existing
> cpuidle device without removing its sysfs interface.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  drivers/cpuidle/cpuidle.c |    8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> --- a/drivers/cpuidle/cpuidle.c
> +++ b/drivers/cpuidle/cpuidle.c
> @@ -635,11 +635,17 @@ static void __cpuidle_device_init(struct
>  static int __cpuidle_register_device(struct cpuidle_device *dev)
>  {
>  	struct cpuidle_driver *drv = cpuidle_get_cpu_driver(dev);
> +	unsigned int cpu = dev->cpu;
>  	int i, ret;
>  
>  	if (!try_module_get(drv->owner))
>  		return -EINVAL;
>  
> +	if (per_cpu(cpuidle_devices, cpu)) {
> +		pr_info("CPU%d: cpuidle device already registered\n", cpu);
> +		return -EEXIST;

Here we return prematurely after a try_module_get right?
Do we need a module_put() similar to how you do it later by calling
unregister_device function by checking ret = cpuidle_coupled_register_device ?

> +	}
> +
>  	for (i = 0; i < drv->state_count; i++) {
>  		if (drv->states[i].flags & CPUIDLE_FLAG_UNUSABLE)
>  			dev->states_usage[i].disable |= CPUIDLE_STATE_DISABLED_BY_DRIVER;
> @@ -648,7 +654,7 @@ static int __cpuidle_register_device(str
>  			dev->states_usage[i].disable |= CPUIDLE_STATE_DISABLED_BY_USER;
>  	}
>  
> -	per_cpu(cpuidle_devices, dev->cpu) = dev;
> +	per_cpu(cpuidle_devices, cpu) = dev;
>  	list_add(&dev->device_list, &cpuidle_detected_devices);
>  
>  	ret = cpuidle_coupled_register_device(dev);
> 
> 
> 
> 

-- 
Best regards,
Dhruva Gole
Texas Instruments Incorporated

