Return-Path: <linux-pm+bounces-17804-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CD059D3716
	for <lists+linux-pm@lfdr.de>; Wed, 20 Nov 2024 10:31:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1E59AB2467C
	for <lists+linux-pm@lfdr.de>; Wed, 20 Nov 2024 09:31:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5682158D6A;
	Wed, 20 Nov 2024 09:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="TAnSY5SQ"
X-Original-To: linux-pm@vger.kernel.org
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7CE815C15F;
	Wed, 20 Nov 2024 09:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732095078; cv=none; b=Bt2Z2m90q3EFPSz9vB8GyaE0jGGlUXBt5xJIxCbI5ZCSziPMgiPOOYBMHHwBdHT/dy47oaoxLVZawCXrk6FZGSKuQFFOUjcKJdTkfDEnCpg4S0H5TtUfJhAUCCXtItyOgNutnKU78AyId6NDtiMVxYrgZGTTgg/hUf12eQMnWOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732095078; c=relaxed/simple;
	bh=qHgdT6ArI512NA+4mWJ1GrsHqJSMtCO1updHHFx1ai0=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QB5w6y1Wl/UgbgmXomSNSFJL7RUliTlZDDQVyQovz5PUpdNMVJji4w1SkkqskA3v9AwPyBMdWR2pIwZhpUTcEn1bSk+46jNiFCOjPVEkuqWQVMDw0SXCdd3QxUI0LLTdqgs3LL1ZTYeLyVWK+uuTQv7hOlrPZfxGNm93LO/x0og=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=TAnSY5SQ; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4AK9UkWf053730;
	Wed, 20 Nov 2024 03:30:46 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1732095046;
	bh=U40w8bgx80+U51qZz8LaooL3Yp1nnphNk5nf7bSVTts=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=TAnSY5SQzcGz+JUhGdciBYlxvde52ldvrUoOqpv8nX3TYeo1yqXUZTLFCjkTXuAPk
	 vzu4CfIyQRWfXiPYcERfyipf9UdMmoEn6ztn9acKIVZV1HzEtfQsq5t120vtbAPtoT
	 voxmn/qLu/tETsheEl/jv2KCkGbcuJHJmWVfRmlU=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4AK9UkVK055478
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 20 Nov 2024 03:30:46 -0600
Received: from flwvowa02.ent.ti.com (10.64.41.53) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 20
 Nov 2024 03:30:45 -0600
Received: from DFLE114.ent.ti.com (10.64.6.35) by flwvowa02.ent.ti.com
 (10.64.41.53) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2507.34; Wed, 20 Nov
 2024 03:30:45 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 20 Nov 2024 03:30:45 -0600
Received: from localhost (lcpd911.dhcp.ti.com [172.24.227.226])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4AK9UiLR034922;
	Wed, 20 Nov 2024 03:30:45 -0600
Date: Wed, 20 Nov 2024 15:00:44 +0530
From: Dhruva Gole <d-gole@ti.com>
To: Jacky Bai <ping.bai@nxp.com>
CC: <lpieralisi@kernel.org>, <sudeep.holla@arm.com>, <rafael@kernel.org>,
        <daniel.lezcano@linaro.org>, <james.morse@arm.com>,
        <linux-pm@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <imx@lists.linux.dev>,
        <khilman@baylibre.com>
Subject: Re: [PATCH] cpuidle: psci: Init cpuidle only for present CPUs
Message-ID: <20241120093044.5yeyel4263fc27k7@lcpd911>
References: <20241120070608.1314850-1-ping.bai@nxp.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20241120070608.1314850-1-ping.bai@nxp.com>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Hi,

On Nov 20, 2024 at 15:06:08 +0800, Jacky Bai wrote:
> With 'nosmp' or 'maxcpus=0' boot command line paremeters,

s/paremeters/parameters

checkpatch should've caught this for you.

> the 'cpu_present_mask' may not be the same as 'cpu_possible_mask'
> 
> In current psci cpuidle driver init, for_each_possible_cpu()
> is used to init the cpudile for each possible CPU. but in

s/cpudile/cpuidle

> drivers/base/cpu.c ->cpu_dev_register_generic(),
> for_each_present_cpu() is used to register cpu device for
> present CPUs.
> 
> When boot system with 'nosmp' or 'maxcpus=0', the cpuidle driver
> init failed due to no valid CPU device sysfs node for non-boot CPUs.
> 
> [ 0.182993] Failed to register cpuidle device for cpu1

Please can we get a "Fixes:" Tag?

> 
> Use for_each_present_cpu() to register cpuidle only for present
> CPUs.
> 
> Signed-off-by: Jacky Bai <ping.bai@nxp.com>
> ---
>  drivers/cpuidle/cpuidle-psci.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/cpuidle/cpuidle-psci.c b/drivers/cpuidle/cpuidle-psci.c
> index 2562dc001fc1..00117e9b33e8 100644
> --- a/drivers/cpuidle/cpuidle-psci.c
> +++ b/drivers/cpuidle/cpuidle-psci.c
> @@ -410,7 +410,7 @@ static int psci_cpuidle_probe(struct platform_device *pdev)
>  	struct cpuidle_driver *drv;
>  	struct cpuidle_device *dev;
>  
> -	for_each_possible_cpu(cpu) {
> +	for_each_present_cpu(cpu) {

With above concerns addressed,

Reviewed-by: Dhruva Gole <d-gole@ti.com>

>  		ret = psci_idle_init_cpu(&pdev->dev, cpu);
>  		if (ret)
>  			goto out_fail;
> -- 
> 2.34.1
> 
> 

-- 
Best regards,
Dhruva Gole
Texas Instruments Incorporated

