Return-Path: <linux-pm+bounces-33807-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 46EDEB434E0
	for <lists+linux-pm@lfdr.de>; Thu,  4 Sep 2025 10:00:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BAC241887D4C
	for <lists+linux-pm@lfdr.de>; Thu,  4 Sep 2025 08:00:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5575D2BE622;
	Thu,  4 Sep 2025 07:59:44 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75EEA2C027D;
	Thu,  4 Sep 2025 07:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756972784; cv=none; b=YejrmtK4hmhfXNfuEnMQu/VTx4BOfbie8EFS5xMiaus3Oieur1HrNSxgwmXbT7Jez3PsT4JjPpACikG0DpYHm1wrzdcTz9/H12HcHC4C/bAD7mC1GWzSggxTcxgRf+VycXDCM7XF/TQMtjFdrQGOw20sbRkR1B0PKjacbuZrxHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756972784; c=relaxed/simple;
	bh=BEpL8T3pVthq/Brupqx6F0B7Tu7nfWohdKOdIfMO5T8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LuejpcjVHHjuxKrvkFIN8c6Uti8v9k7U2rpt/gIcU3VuUSfWVPKQXbpHgByYUYs9QbD/HwSYS1pd0cggi0ffXOveLsuKHSdkMR32bbKEf+5gUxT19oTyb5jU4SQYVXsRFt0pTQyl++w4zQso9DmcoR4FGThdF/7n7d3vZE0SrzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4F0C61596;
	Thu,  4 Sep 2025 00:59:33 -0700 (PDT)
Received: from [10.57.60.120] (unknown [10.57.60.120])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 941673F63F;
	Thu,  4 Sep 2025 00:59:40 -0700 (PDT)
Message-ID: <3069755e-770b-4fb7-806e-7a55cc84e26c@arm.com>
Date: Thu, 4 Sep 2025 08:59:50 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] thermal: k3_j72xx_bandgap: register sensors with hwmon
To: Michael Walle <mwalle@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 "Rafael J . Wysocki" <rafael@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>
References: <20250828124042.1680853-1-mwalle@kernel.org>
Content-Language: en-US
From: Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <20250828124042.1680853-1-mwalle@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 8/28/25 13:40, Michael Walle wrote:
> Make the sensors available in the hwmon subsystem (if
> CONFIG_THERMAL_HWMON is enabled).
> 
> Signed-off-by: Michael Walle <mwalle@kernel.org>
> ---
>   drivers/thermal/k3_j72xx_bandgap.c | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/thermal/k3_j72xx_bandgap.c b/drivers/thermal/k3_j72xx_bandgap.c
> index a36289e61315..d9ec3bf19496 100644
> --- a/drivers/thermal/k3_j72xx_bandgap.c
> +++ b/drivers/thermal/k3_j72xx_bandgap.c
> @@ -20,6 +20,8 @@
>   #include <linux/delay.h>
>   #include <linux/slab.h>
>   
> +#include "thermal_hwmon.h"
> +
>   #define K3_VTM_DEVINFO_PWR0_OFFSET		0x4
>   #define K3_VTM_DEVINFO_PWR0_TEMPSENS_CT_MASK	0xf0
>   #define K3_VTM_TMPSENS0_CTRL_OFFSET		0x300
> @@ -513,6 +515,8 @@ static int k3_j72xx_bandgap_probe(struct platform_device *pdev)
>   			ret = PTR_ERR(ti_thermal);
>   			goto err_free_ref_table;
>   		}
> +
> +		devm_thermal_add_hwmon_sysfs(bgp->dev, ti_thermal);
>   	}
>   
>   	platform_set_drvdata(pdev, bgp);


LGTM,

Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>

