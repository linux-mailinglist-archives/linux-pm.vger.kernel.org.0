Return-Path: <linux-pm+bounces-35027-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F358B894B8
	for <lists+linux-pm@lfdr.de>; Fri, 19 Sep 2025 13:39:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 59AA5564F5F
	for <lists+linux-pm@lfdr.de>; Fri, 19 Sep 2025 11:39:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBD95309DA0;
	Fri, 19 Sep 2025 11:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="FZtZrkuu"
X-Original-To: linux-pm@vger.kernel.org
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 405D319755B;
	Fri, 19 Sep 2025 11:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758281971; cv=none; b=VDJIp/YC2x8qyI9pRiJaYjJLfBn34REZCTW24VEZLbDqu2RhUGykbGvQtisp/bPr3SknO3Bp9cZLrUG3SfeKcB1r+Gv5Sac9of1XFKtOG2W4n8wV1yIhPGIsdOCZ/kpg8maC09nzlpBQ8tFjsQnwEB9ZaN+/+17uqi9hqa2W7Rs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758281971; c=relaxed/simple;
	bh=g7diReALNzSEMHJDHkJDR+uRhAHHqz3AfeCCGQYWV2Y=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ix4jL1GC1hRQmyi34UKv0OKcEE7tnvyuSkGBQnu4GrOwY3Fc1MeZQbRzR9LhBDCgnsVyU/BPTaBnHxbj9pzi5W1eFEtedAT5Wc1roM3vNfx4Y6Vl3B8K9K0D+9by8FGn5qr7NkGfarfXNYg0PZV7qpfO7I/tFgLIpKDte1BV7+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=FZtZrkuu; arc=none smtp.client-ip=198.47.23.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllvem-sh03.itg.ti.com ([10.64.41.86])
	by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTP id 58JBdOQD233572;
	Fri, 19 Sep 2025 06:39:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1758281964;
	bh=2eA38zpgEpyx51uHfBOU7titOPtXUmVDwaR8LrY3/rw=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=FZtZrkuu3KueCka7ZVpKi5TOdmpmLfQPhXnxAX2QV+eHjPYGVSH8I2lPg8T6luryh
	 onMNI0n44FTo5EEu1TkTVJqMhBIoCZ5169Sz1SVx2qEP6DAYZ3merPlmN1hUrt8Spl
	 CmdxEwNofwapG6BwMHuLIoY8g9uWkMdJv91N6QRQ=
Received: from DFLE20.ent.ti.com (dfle20.ent.ti.com [10.64.6.57])
	by fllvem-sh03.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 58JBdONQ3121770
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 19 Sep 2025 06:39:24 -0500
Received: from flwvowa02.ent.ti.com (10.64.41.53) by DFLE20.ent.ti.com
 (10.64.6.57) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.20; Fri, 19 Sep
 2025 06:39:24 -0500
Received: from DFLE203.ent.ti.com (10.64.6.61) by flwvowa02.ent.ti.com
 (10.64.41.53) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.55; Fri, 19 Sep
 2025 06:39:23 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE203.ent.ti.com
 (10.64.6.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Fri, 19 Sep 2025 06:39:23 -0500
Received: from localhost (lcpd911.dhcp.ti.com [172.24.233.130])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 58JBdMGW2508551;
	Fri, 19 Sep 2025 06:39:23 -0500
Date: Fri, 19 Sep 2025 17:09:22 +0530
From: Dhruva Gole <d-gole@ti.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
CC: Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH v2] cpuidle: Fail cpuidle device registration if there is
 one already
Message-ID: <20250919113922.7tozmbts6cs3y5va@lcpd911>
References: <12749587.O9o76ZdvQC@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <12749587.O9o76ZdvQC@rafael.j.wysocki>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Hi Rafael,

On Sep 19, 2025 at 13:22:20 +0200, Rafael J. Wysocki wrote:
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
> 
> v1 -> v2:
>    * Add the new check before the driver module reference counting (Dhruva).

Thanks for addressing!

> 
> ---
>  drivers/cpuidle/cpuidle.c |    8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> --- a/drivers/cpuidle/cpuidle.c
> +++ b/drivers/cpuidle/cpuidle.c
> @@ -635,8 +635,14 @@ static void __cpuidle_device_init(struct
>  static int __cpuidle_register_device(struct cpuidle_device *dev)
>  {
>  	struct cpuidle_driver *drv = cpuidle_get_cpu_driver(dev);
> +	unsigned int cpu = dev->cpu;
>  	int i, ret;
>  
> +	if (per_cpu(cpuidle_devices, cpu)) {
> +		pr_info("CPU%d: cpuidle device already registered\n", cpu);

Sorry for not pointing this earlier,
perhaps pr_err makes more sense?

Anyway if you respin/ fix while applying:
Reviewed-by: Dhruva Gole <d-gole@ti.com>


-- 
Best regards,
Dhruva Gole
Texas Instruments Incorporated

