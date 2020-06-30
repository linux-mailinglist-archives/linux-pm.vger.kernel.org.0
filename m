Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EB4020F119
	for <lists+linux-pm@lfdr.de>; Tue, 30 Jun 2020 11:02:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731764AbgF3JCr (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 30 Jun 2020 05:02:47 -0400
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:9472 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731591AbgF3JCr (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 30 Jun 2020 05:02:47 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5efaff530001>; Tue, 30 Jun 2020 02:01:07 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Tue, 30 Jun 2020 02:02:46 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Tue, 30 Jun 2020 02:02:46 -0700
Received: from [10.26.75.203] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 30 Jun
 2020 09:02:44 +0000
Subject: Re: [PATCH v1] cpuidle: tegra: Correctly handle result of
 arm_cpuidle_simple_enter()
To:     Dmitry Osipenko <digetx@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
CC:     <linux-pm@vger.kernel.org>, <linux-tegra@vger.kernel.org>
References: <20200629222625.674-1-digetx@gmail.com>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <d9efb0f5-d6ab-f3db-540e-c6ae1b42e45e@nvidia.com>
Date:   Tue, 30 Jun 2020 10:02:42 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200629222625.674-1-digetx@gmail.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1593507667; bh=Z9j7LGBXe6yVK+/hW2mjYUjn/x07AQ3M1fpHZ8wfI+M=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=qOg+KEG4BpwTRHwoVdurwFcvBMP5jN84EghU4QOwyUtnB4zg+H8HvRnJGmwEbwlq7
         an9a0PrUTii3NLuCrR3NMxLvy/Ccnh7OP+vWh++c+7kRczCQyNoCQ3Pyk45E5u93A6
         S9pMkaic0wvxLdRRG0KIShCan/NUQS5Ii4CeDNh8e0ljTImO4FyebR/iMn6SvYlo6Y
         5D+OqmppAtGIsJYHsn+9W+Y1514jM5BULFG1X5IaMAVFA+jumdn1exiCBUZaZu99we
         wRmvmGlG1nXR0d+U7NLTKJ+scQTt3Yqq//WrC50F7PhNpk5RBlmIJjS/01omsSpIpO
         rtDtWWqlRgEKQ==
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


On 29/06/2020 23:26, Dmitry Osipenko wrote:
> The arm_cpuidle_simple_enter() returns the entered idle-index and not a
> error code. It happened that TEGRA_C1=index=err=0, and hence this typo
> was difficult to notice in the code since everything happened to work
> properly. This patch fixes the minor typo, it doesn't fix any problem.

I guess that is dependent on if CPUIDLE is enabled ...

#ifdef CONFIG_CPU_IDLE
extern int arm_cpuidle_simple_enter(struct cpuidle_device *dev,
                struct cpuidle_driver *drv, int index);
#else
static inline int arm_cpuidle_simple_enter(struct cpuidle_device *dev,
                 struct cpuidle_driver *drv, int index) { return -ENODEV; }
#endif

Looks like it could return an error.
 
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  drivers/cpuidle/cpuidle-tegra.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/cpuidle/cpuidle-tegra.c b/drivers/cpuidle/cpuidle-tegra.c
> index 150045849d78..9e9a9cccd755 100644
> --- a/drivers/cpuidle/cpuidle-tegra.c
> +++ b/drivers/cpuidle/cpuidle-tegra.c
> @@ -236,14 +236,14 @@ static int tegra_cpuidle_enter(struct cpuidle_device *dev,
>  			       int index)
>  {
>  	unsigned int cpu = cpu_logical_map(dev->cpu);
> -	int err;
> +	int err = 0;
>  
>  	index = tegra_cpuidle_adjust_state_index(index, cpu);
>  	if (dev->states_usage[index].disable)
>  		return -1;
>  
>  	if (index == TEGRA_C1)
> -		err = arm_cpuidle_simple_enter(dev, drv, index);
> +		index = arm_cpuidle_simple_enter(dev, drv, index);
>  	else
>  		err = tegra_cpuidle_state_enter(dev, index, cpu);
>  
> 

However, I do think that there is something not right in the error handling
here. Would also be nice to get rid of these -1.

Jon

-- 
nvpublic
