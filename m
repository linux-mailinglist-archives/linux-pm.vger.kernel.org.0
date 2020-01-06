Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E7F5B130D4D
	for <lists+linux-pm@lfdr.de>; Mon,  6 Jan 2020 06:56:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726620AbgAFF4m (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 6 Jan 2020 00:56:42 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:35413 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726536AbgAFF4l (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 6 Jan 2020 00:56:41 -0500
Received: by mail-pg1-f193.google.com with SMTP id l24so26374711pgk.2
        for <linux-pm@vger.kernel.org>; Sun, 05 Jan 2020 21:56:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=gVecZrqzeRB7HIKM77tdnNGZDqJ0B+ktTZCrajXniX8=;
        b=RrvvyQudXDmB8aCO+LVQrMNG+Kn2MNd2iw5qp1yJk7/PXl/CGC/mXn21y2i4zYA7Zx
         09yRfFJPe/MGOUdu7Y+lqvCCABG2ozlLAgIkgc+MhBMcinCz6mJPChuDnK3jssiOqEvi
         nIQcjQR/QzJxHc1nNOzWrgh+wL38rlJib3J7Lsz5YpeTUecozsfcLon5EAW0cv1lU/Ni
         YBX0GKcM8/dIjwdK96FzRFpSbRNFJQeFpQv8x5TgrBsZqOh78zXUrTPjb5LDrqVos6c0
         kPAw6DiALD8CI/FMVuoWwThKoTDIUDzgNS572SvhKAEpu4JW75WrqBeJMqWSgIYCAmff
         Ti5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=gVecZrqzeRB7HIKM77tdnNGZDqJ0B+ktTZCrajXniX8=;
        b=cYGvFg9bnE4zTJsiArbO8jXLQ2mJYPNl55l/xt8lnWMZCXKiCESt4i+gmYN8pfZXfx
         XDOhmPImgWf3wjRBYgjLNdJa5Aox9wjCwVyuTuDMG+x3LTGT9VrThWQG0PMUjU0NZDOf
         va3UsjwAWfwRAUGcQPYK2Ayotcc4eC0GxjCWSIHKNtjMENvHXE3TtEZbAfVi+r0Ix/PI
         RXrEykoc1vacaURuRa3hcupn08DrvNfMq/j7QbJ432wyedzzm8Xm6SZdlFIBXxQRFXgm
         AAsqx58NYKoJ0iLPZJ6zI9Qy/XKDDBBuAO/x/eDv5dp8z5kp3rP7z8hLElu16oJlEH6g
         4FWQ==
X-Gm-Message-State: APjAAAVDIeZBZ39UJjzysmNBrTJx4SEqZU33Ynn5kRd8AXd9OFOIPT0r
        2epYi4xNfjzov1SCExW5ccL/pg==
X-Google-Smtp-Source: APXvYqyT6ThGReSu3JCs7Q7kEF0HCqtxFWxtHaK+WRQ+do7hOXLFqHXPEzbgSrcPCDAhrE8AtIoUug==
X-Received: by 2002:a62:a209:: with SMTP id m9mr96885746pff.16.1578290200988;
        Sun, 05 Jan 2020 21:56:40 -0800 (PST)
Received: from localhost ([122.172.26.121])
        by smtp.gmail.com with ESMTPSA id a17sm23522840pjv.6.2020.01.05.21.56.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 05 Jan 2020 21:56:40 -0800 (PST)
Date:   Mon, 6 Jan 2020 11:26:37 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     qiwuchen55@gmail.com
Cc:     mmayer@broadcom.com, rjw@rjwysocki.net, f.fainelli@gmail.com,
        bcm-kernel-feedback-list@broadcom.com, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        chenqiwu <chenqiwu@xiaomi.com>
Subject: Re: [PATCH v2] cpufreq: brcmstb-avs-cpufreq: avoid potential stuck
 and UAF risk
Message-ID: <20200106055637.zq4icl5klg4wpvkx@vireshk-i7>
References: <1578228650-17157-1-git-send-email-qiwuchen55@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1578228650-17157-1-git-send-email-qiwuchen55@gmail.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 05-01-20, 20:50, qiwuchen55@gmail.com wrote:
> From: chenqiwu <chenqiwu@xiaomi.com>
> 
> brcm_avs_cpufreq_get() calls cpufreq_cpu_get() to get cpufreq policy,
> meanwhile, it also increments the kobject reference count of policy to
> mark it busy. However, a corresponding call of cpufreq_cpu_put() is
> ignored to decrement the kobject reference count back, which may lead
> to a potential stuck risk that percpu cpuhp thread deadly waits for
> dropping of kobject refcount when percpu cpufreq policy free.
> 
> The call trace of stuck risk could be:
> cpufreq_online()  //If cpufreq online failed, goto out_free_policy.
>     ->cpufreq_policy_free()     //Do cpufreq_policy free.
>         ->cpufreq_policy_put_kobj()
>             ->kobject_put()       //Skip if policy kfref count is not 1.
>                 ->cpufreq_sysfs_release()
>                     ->complete()  //Complete policy->kobj_unregister.
>                 ->wait_for_completion() //Wait for policy->kobj_unregister.
> 
> A simple way to avoid this stuck risk is use cpufreq_cpu_get_raw()
> instead of cpufreq_cpu_get(), since this can be easily exercised by
> attempting to force an unbind of the CPUfreq driver.
> 
> Signed-off-by: chenqiwu <chenqiwu@xiaomi.com>
> ---
>  drivers/cpufreq/brcmstb-avs-cpufreq.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/cpufreq/brcmstb-avs-cpufreq.c b/drivers/cpufreq/brcmstb-avs-cpufreq.c
> index 77b0e5d..6d2bf5c 100644
> --- a/drivers/cpufreq/brcmstb-avs-cpufreq.c
> +++ b/drivers/cpufreq/brcmstb-avs-cpufreq.c
> @@ -452,8 +452,15 @@ static bool brcm_avs_is_firmware_loaded(struct private_data *priv)
>  
>  static unsigned int brcm_avs_cpufreq_get(unsigned int cpu)
>  {
> -	struct cpufreq_policy *policy = cpufreq_cpu_get(cpu);
> -	struct private_data *priv = policy->driver_data;
> +	struct cpufreq_policy *policy = cpufreq_cpu_get_raw(cpu);
> +	struct private_data *priv;
> +
> +	if (!policy)
> +		return 0;
> +

Since we always reach here after the cpufreq driver is registered, we
may not need to check the policy pointer at all.

> +	priv = policy->driver_data;
> +	if (!priv || !priv->base)
> +		return 0;

Can there be a case where priv or priv->base be set to NULL for this
driver ? I don't think so and so this may not be required.

>  
>  	return brcm_avs_get_frequency(priv->base);
>  }
> -- 
> 1.9.1

-- 
viresh
