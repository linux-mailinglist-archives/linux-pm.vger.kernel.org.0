Return-Path: <linux-pm+bounces-10030-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DF1D4917AAB
	for <lists+linux-pm@lfdr.de>; Wed, 26 Jun 2024 10:16:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C4291C21E7F
	for <lists+linux-pm@lfdr.de>; Wed, 26 Jun 2024 08:16:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDA1E160877;
	Wed, 26 Jun 2024 08:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="s3TNqbdI"
X-Original-To: linux-pm@vger.kernel.org
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AE241607A5;
	Wed, 26 Jun 2024 08:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719389784; cv=none; b=pQ+yG6xoG0X7ouOyipjiZwBaaDVszhqaSmefAyz0h5Zglbi681Xj9UZJKuk0YInsSZKQ8opeZ3BKgaMps17Gnk4NKegpX5fjBXO/ypJXyVxVG96LaCqa1DYkv6BKnVMpyrQiw1B54p474U8r4P2PR0PC998KANwpuM8QYvcjk/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719389784; c=relaxed/simple;
	bh=uo0b3ziM5aHxc9KxibrJRLCwVCeLFONGwX1Jma/wC/I=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XmxgaBj8NTecVFegFYa3DShGPilxLEaVd1oecvoVMh1eNV71LxS2yBFzMIKi86ATMKLbmugpCIuLS73BSecAvRSMmsfJw+KDbH0iPLgNDDsR5FbLGN/FukeCqvMd4X/z9maDjzlgXOjTbFQbP+L9ARIZjB3tOVk5+/qNP5aq4T0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=s3TNqbdI; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 45Q8G9Xi061421;
	Wed, 26 Jun 2024 03:16:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1719389769;
	bh=3C0uHGOqSVziV3txa6MMh3IsvviPc4mebKQzDXCHUYo=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=s3TNqbdIWGgiNkGnTIolWzvFI/1KnkxfKGow6wDveRXFGJ9vkSd9qbA6rPrCJ2Zf4
	 PhsF9nObHuO6l6Rfy0FcPtV1PP/hdoeldq8+FonnxQeljAbNwHbH8aZGBTBAHsRCbf
	 aG4YQWfafHeOMgeHi6pmo43FJwmqXw5J8B8DUM3M=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 45Q8G9bo057273
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 26 Jun 2024 03:16:09 -0500
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 26
 Jun 2024 03:16:08 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 26 Jun 2024 03:16:09 -0500
Received: from localhost (dhruva.dhcp.ti.com [172.24.227.68])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 45Q8G8oM119119;
	Wed, 26 Jun 2024 03:16:08 -0500
Date: Wed, 26 Jun 2024 13:46:07 +0530
From: Dhruva Gole <d-gole@ti.com>
To: Mario Limonciello <mario.limonciello@amd.com>
CC: <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Viresh Kumar
	<viresh.kumar@linaro.org>,
        "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
        Sibi Sankar <quic_sibis@quicinc.com>,
        Dietmar Eggemann
	<dietmar.eggemann@arm.com>,
        Yipeng Zou <zouyipeng@huawei.com>,
        "Rafael J .
 Wysocki" <rafael.j.wysocki@intel.com>
Subject: Re: [PATCH 1/2] cpufreq: Allow drivers to advertise boost enabled
Message-ID: <20240626081607.zgjs5edtwrritbpq@dhruva>
References: <20240626041135.1559-1-mario.limonciello@amd.com>
 <20240626041135.1559-2-mario.limonciello@amd.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240626041135.1559-2-mario.limonciello@amd.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

On Jun 25, 2024 at 23:11:34 -0500, Mario Limonciello wrote:
> The behavior introduced in commit f37a4d6b4a2c ("cpufreq: Fix per-policy
> boost behavior on SoCs using cpufreq_boost_set_sw()") sets up the boost
> policy incorrectly when boost has been enabled by the platform firmware
> initially even if a driver sets the policy up.
> 
> This is because policy_has_boost_freq() assumes that there is a frequency
> table set up by the driver and that the boost frequencies are advertised
> in that table. This assumption doesn't work for acpi-cpufreq or
> amd-pstate. Only use this check to enable boost if it's not already
> enabled instead of also disabling it if alreayd enabled.
> 
> Fixes: f37a4d6b4a2c ("cpufreq: Fix per-policy boost behavior on SoCs using cpufreq_boost_set_sw()")
> Suggested-by: Viresh Kumar <viresh.kumar@linaro.org>
> Suggested-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
> Cc: Sibi Sankar <quic_sibis@quicinc.com>
> Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
> Cc: Viresh Kumar <viresh.kumar@linaro.org>
> Cc: Dhruva Gole <d-gole@ti.com>
> Cc: Yipeng Zou <zouyipeng@huawei.com>
> Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> v14->v15:
>  * Use Viresh's suggestion
> ---
>  drivers/cpufreq/cpufreq.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index 1fdabb660231..270ea04fb616 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -1430,7 +1430,8 @@ static int cpufreq_online(unsigned int cpu)
>  		}
>  
>  		/* Let the per-policy boost flag mirror the cpufreq_driver boost during init */
> -		policy->boost_enabled = cpufreq_boost_enabled() && policy_has_boost_freq(policy);
> +		if (cpufreq_boost_enabled() && policy_has_boost_freq(policy))
> +			policy->boost_enabled = true;

Reviewed-by: Dhruva Gole <d-gole@ti.com>

-- 
Best regards,
Dhruva

