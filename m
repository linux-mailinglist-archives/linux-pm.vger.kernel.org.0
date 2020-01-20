Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 38D9514248A
	for <lists+linux-pm@lfdr.de>; Mon, 20 Jan 2020 08:54:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726465AbgATHyl (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 20 Jan 2020 02:54:41 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:43139 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726421AbgATHyl (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 20 Jan 2020 02:54:41 -0500
Received: by mail-pf1-f195.google.com with SMTP id x6so15428764pfo.10
        for <linux-pm@vger.kernel.org>; Sun, 19 Jan 2020 23:54:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=CYF/yMkazN9ohF5HZpnUVmWUgzjjynUM6B5AyQbQ8DI=;
        b=kMzHT4itIyuiyHK4KucdNwb5BjZ/PBbwK1c/kCgSQCMGcBggTbo32cDHbcBOvdfO5j
         nKzWGPlunjzanj6kEoeBXsowUHJ9ddDOQKyXqK1jlUzruiof9Cf9gNurbsrsvI8CRM7N
         rfNdvVJZk3TNLWQ04X37lKXtdDlbk8Gu/858sfS2ekEUn33RB/C0LH1rnxvCelKyzhU4
         x8gTdW0PMOnT0yvJqs/mv1LWqWKRnC5goN9L/LOUzt7lVLORdOiMkH/cdZzQpSEPuW6y
         meWHZNqLBsEMDf0MGxRKzBVb5B6xvtMSyvAjDgj4F0Zq3+19Hmc0jXE5zCkcqLhDnze4
         I9qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=CYF/yMkazN9ohF5HZpnUVmWUgzjjynUM6B5AyQbQ8DI=;
        b=ogzpYhkWUt1L8UqjnMLcaO2UbCs+un5Zfjput51QKP7q6PHpCxSX6cX+MK4u+6ZcuT
         n4JfM78MOD4lYX22UreW71msqg+bmYqDCrlSZCZaPT9Ya5KhxQyGh8zcjJ6/KTN6ZFqP
         qdWgSgSR750y86drUlizDqCE7+bTi3Qe+JuB+lY+i7K23xOUH4GS6JWwb2sObwN2UER+
         juJCgd7mqnrulwntUA+xyd1hNP2GkfHvjczRdTtRyvA+roOWs2Kg/2U4u+WyxnDC2w90
         1qtRsCZWJ1bCQhOOhqTeGKmToDTWU1Lec8qHXpkFpMW0bE1GocCw+RaVTyOl4SSJBuIN
         OSHw==
X-Gm-Message-State: APjAAAUuCslo4ncQLQtsFrreMn7jI7/6RGaWdOibLUK6LrW3DzML5Dgf
        EZeJH4vF7twJie7suwnLXZgjTw==
X-Google-Smtp-Source: APXvYqx4SGtEY07w4qJsswx2A9cg0+WMOfmB+F+8W25rXwbomSSyhlIueXer3aOIFxvjWZHU2MzFLw==
X-Received: by 2002:a63:5d03:: with SMTP id r3mr58649765pgb.306.1579506880543;
        Sun, 19 Jan 2020 23:54:40 -0800 (PST)
Received: from localhost ([122.172.71.156])
        by smtp.gmail.com with ESMTPSA id h3sm38524824pfr.15.2020.01.19.23.54.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 19 Jan 2020 23:54:39 -0800 (PST)
Date:   Mon, 20 Jan 2020 13:24:38 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     qiwuchen55@gmail.com
Cc:     mmayer@broadcom.com, rjw@rjwysocki.net, f.fainelli@gmail.com,
        bcm-kernel-feedback-list@broadcom.com, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        chenqiwu <chenqiwu@xiaomi.com>
Subject: Re: [PATCH v4] cpufreq: brcmstb-avs: fix imbalance of cpufreq policy
 refcount
Message-ID: <20200120075438.pxscoeluf4qwblag@vireshk-i7>
References: <1579506088-6736-1-git-send-email-qiwuchen55@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1579506088-6736-1-git-send-email-qiwuchen55@gmail.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 20-01-20, 15:41, qiwuchen55@gmail.com wrote:
> From: chenqiwu <chenqiwu@xiaomi.com>
> 
> brcm_avs_cpufreq_get() calls cpufreq_cpu_get() to get the cpufreq
> policy, meanwhile, it also increments the kobject reference count
> to mark it busy. However, a corresponding call of cpufreq_cpu_put()
> is ignored to decrement the kobject reference count back, which may
> lead to a potential stuck risk that the cpuhp thread deadly waits
> for dropping of kobject refcount when cpufreq policy free.
> 
> With this patch, the cpuhp thread can be easily exercised by
> attempting to force an unbind of the CPUfreq driver.
> 
> Signed-off-by: chenqiwu <chenqiwu@xiaomi.com>
> ---
> changes in v4:
>  - Rewrit commit message.
>  - Use cpufreq_cpu_get() and a corresponding cpufreq_cpu_put()
>    instead of cpufreq_get_policy() for promoting efficiency.
> ---
>  drivers/cpufreq/brcmstb-avs-cpufreq.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/cpufreq/brcmstb-avs-cpufreq.c b/drivers/cpufreq/brcmstb-avs-cpufreq.c
> index 77b0e5d..0767206 100644
> --- a/drivers/cpufreq/brcmstb-avs-cpufreq.c
> +++ b/drivers/cpufreq/brcmstb-avs-cpufreq.c
> @@ -453,7 +453,13 @@ static bool brcm_avs_is_firmware_loaded(struct private_data *priv)
>  static unsigned int brcm_avs_cpufreq_get(unsigned int cpu)
>  {
>  	struct cpufreq_policy *policy = cpufreq_cpu_get(cpu);
> -	struct private_data *priv = policy->driver_data;
> +	struct private_data *priv;
> +
> +	if (!policy)
> +		return 0;
> +

As I told you earlier, this isn't required as policy can't be NULL here.

> +	priv = policy->driver_data;
> +	cpufreq_cpu_put(policy);
>  
>  	return brcm_avs_get_frequency(priv->base);
>  }

Applied the patch with following diff:

req/brcmstb-avs-cpufreq.c b/drivers/cpufreq/brcmstb-avs-cpufreq.c
index 77b0e5d0fb13..4f86ce2db34f 100644
--- a/drivers/cpufreq/brcmstb-avs-cpufreq.c
+++ b/drivers/cpufreq/brcmstb-avs-cpufreq.c
@@ -455,6 +455,8 @@ static unsigned int brcm_avs_cpufreq_get(unsigned int cpu)
        struct cpufreq_policy *policy = cpufreq_cpu_get(cpu);
        struct private_data *priv = policy->driver_data;
 
+       cpufreq_cpu_put(policy);
+
        return brcm_avs_get_frequency(priv->base);
 }
 

-- 
viresh
