Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 98650101702
	for <lists+linux-pm@lfdr.de>; Tue, 19 Nov 2019 07:00:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730675AbfKSFqM (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 19 Nov 2019 00:46:12 -0500
Received: from mail-pj1-f65.google.com ([209.85.216.65]:41808 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729545AbfKSFqL (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 19 Nov 2019 00:46:11 -0500
Received: by mail-pj1-f65.google.com with SMTP id gc1so2239844pjb.8
        for <linux-pm@vger.kernel.org>; Mon, 18 Nov 2019 21:46:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=TwTrHFfUEXPF0AdUJSKGrhG7MiL19etHomK5sNh967I=;
        b=J6Z97g+qaqyRgX61FIN/BkQqzrRD+3LDgXXlfrFFZUoLkXr3VLk5HxrFc6KPw5VfYv
         mPoKIl19kU5HhwhdhdkAWzztoA0y2uE4VaYw+uHYmgYHjZBYEtSUDbmfcIoXEzCbUJBy
         cw+J+sJeTJgo/WX3zDt3uGuy8amvs6hITpY/ha3yrfiZTntAO6fHEiqksp0x4S9efA4U
         aic+9ItWAQjBiV2GBVuc/PteN5zRsmNhPssJmFr06wR/eK2arqFLIWuZL8EJtn0wpp7J
         HsVMJByIUyx82zeS2IB/dVia5hQPA3f5xGsyzam3wZeRnsWZ+PZ4OCZykcACpxI2iSB2
         4NqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=TwTrHFfUEXPF0AdUJSKGrhG7MiL19etHomK5sNh967I=;
        b=dpKiQVUATnbvU5C6QoVZ4hr766qFqTU+8C5UaBp9qAw5E9udZK5ObD+h0xRSPIoSiw
         a/Ysx0ie+gqZffsZ52NHS0Jqr3pdIs5UJ+BQDT0ppPjyO22ZsbFxuzBRUR+i1QQzTBNv
         xkvsMah8Sd0BTz0CW/wtYHUTfPbmJiXCAZqkRMNhLVRJZVvNhCy8X6JzP7WotA7Wm8eT
         jJez7fLKuZIKpULOT/NTtc0x+1seo+qbedUO88IekjLdV8r8roFX3TiMTqWbYAP+NX6x
         aaRHcV6BdHkoZtiU3x1kn6gVm7+TXeenyENm7JFEUZNlj0YXNZAP6qSlRHjPEjNIH/VO
         iNuA==
X-Gm-Message-State: APjAAAWKwdLjNi8+w1BxjgljvMqoLAZ3jUaCyGaHGL8g+c+dvqpwpn1L
        KWeoVORRdnhlyr0CYSsVvE0fZg==
X-Google-Smtp-Source: APXvYqwqcOsssd3YquYy0WRNNJ5pR2v2XZW1TLZfs/VZBu5jO8v1LBqaLVMMQWSkuKN7wawDZ28Phw==
X-Received: by 2002:a17:90a:c2:: with SMTP id v2mr3866143pjd.140.1574142370364;
        Mon, 18 Nov 2019 21:46:10 -0800 (PST)
Received: from localhost ([223.226.74.76])
        by smtp.gmail.com with ESMTPSA id z1sm1494163pju.27.2019.11.18.21.46.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Nov 2019 21:46:09 -0800 (PST)
Date:   Tue, 19 Nov 2019 11:16:07 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     rjw@rjwysocki.net, edubezval@gmail.com, rui.zhang@intel.com,
        linux-pm@vger.kernel.org, amit.kucheria@linaro.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] thermal/drivers/Kconfig: Convert the CPU cooling
 device to a choice
Message-ID: <20191119054607.m4bcztc5euhe3jve@vireshk-i7>
References: <20191113084042.5707-1-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191113084042.5707-1-daniel.lezcano@linaro.org>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 13-11-19, 09:40, Daniel Lezcano wrote:
> The next changes will add a new way to cool down a CPU by injecting
> idle cycles. With the current configuration, a CPU cooling device is
> the cpufreq cooling device. As we want to add a new CPU cooling
> device, let's convert the CPU cooling to a choice giving a list of CPU
> cooling devices. At this point, there is obviously only one CPU
> cooling device.
> 
> There is no functional changes.
> 
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---
>  drivers/thermal/Kconfig     | 13 +++++++++++--
>  drivers/thermal/Makefile    |  2 +-
>  include/linux/cpu_cooling.h |  6 +++---
>  3 files changed, 15 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
> index 001a21abcc28..2b82c4861091 100644
> --- a/drivers/thermal/Kconfig
> +++ b/drivers/thermal/Kconfig
> @@ -150,8 +150,17 @@ config THERMAL_GOV_POWER_ALLOCATOR
>  
>  config CPU_THERMAL
>  	bool "Generic cpu cooling support"
> -	depends on CPU_FREQ
>  	depends on THERMAL_OF
> +	help
> +	  Enable the CPU cooling features. If the system has no active
> +	  cooling device available, this option allows to use the CPU
> +	  as a cooling device.
> +
> +if CPU_THERMAL
> +
> +config CPU_FREQ_THERMAL
> +	bool "CPU frequency cooling device"
> +	depends on CPU_FREQ

Many of the current set of defconfigs have CONFIG_CPU_THERMAL=y for
them and they will break now as CONFIG_CPU_FREQ_THERMAL won't be
selected for them without any defconfig changes. Can we have this
option selected by default if CONFIG_CPU_THERMAL is enabled ?

>  	help
>  	  This implements the generic cpu cooling mechanism through frequency
>  	  reduction. An ACPI version of this already exists
> @@ -159,7 +168,7 @@ config CPU_THERMAL
>  	  This will be useful for platforms using the generic thermal interface
>  	  and not the ACPI interface.
>  
> -	  If you want this support, you should say Y here.
> +endif
>  
>  config CLOCK_THERMAL
>  	bool "Generic clock cooling support"
> diff --git a/drivers/thermal/Makefile b/drivers/thermal/Makefile
> index 74a37c7f847a..d3b01cc96981 100644
> --- a/drivers/thermal/Makefile
> +++ b/drivers/thermal/Makefile
> @@ -19,7 +19,7 @@ thermal_sys-$(CONFIG_THERMAL_GOV_USER_SPACE)	+= user_space.o
>  thermal_sys-$(CONFIG_THERMAL_GOV_POWER_ALLOCATOR)	+= power_allocator.o
>  
>  # cpufreq cooling
> -thermal_sys-$(CONFIG_CPU_THERMAL)	+= cpu_cooling.o
> +thermal_sys-$(CONFIG_CPU_FREQ_THERMAL)	+= cpu_cooling.o
>  
>  # clock cooling
>  thermal_sys-$(CONFIG_CLOCK_THERMAL)	+= clock_cooling.o
> diff --git a/include/linux/cpu_cooling.h b/include/linux/cpu_cooling.h
> index b74732535e4b..3cdd85f987d7 100644
> --- a/include/linux/cpu_cooling.h
> +++ b/include/linux/cpu_cooling.h
> @@ -19,7 +19,7 @@
>  
>  struct cpufreq_policy;
>  
> -#ifdef CONFIG_CPU_THERMAL
> +#ifdef CONFIG_CPU_FREQ_THERMAL
>  /**
>   * cpufreq_cooling_register - function to create cpufreq cooling device.
>   * @policy: cpufreq policy.
> @@ -40,7 +40,7 @@ void cpufreq_cooling_unregister(struct thermal_cooling_device *cdev);
>  struct thermal_cooling_device *
>  of_cpufreq_cooling_register(struct cpufreq_policy *policy);
>  
> -#else /* !CONFIG_CPU_THERMAL */
> +#else /* !CONFIG_CPU_FREQ_THERMAL */
>  static inline struct thermal_cooling_device *
>  cpufreq_cooling_register(struct cpufreq_policy *policy)
>  {
> @@ -58,6 +58,6 @@ of_cpufreq_cooling_register(struct cpufreq_policy *policy)
>  {
>  	return NULL;
>  }
> -#endif /* CONFIG_CPU_THERMAL */
> +#endif /* CONFIG_CPU_FREQ_THERMAL */
>  
>  #endif /* __CPU_COOLING_H__ */
> -- 
> 2.17.1

-- 
viresh
