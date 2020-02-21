Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 33C20168118
	for <lists+linux-pm@lfdr.de>; Fri, 21 Feb 2020 16:05:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729032AbgBUPE5 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 21 Feb 2020 10:04:57 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:35048 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728699AbgBUPE4 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 21 Feb 2020 10:04:56 -0500
Received: by mail-wr1-f66.google.com with SMTP id w12so2441034wrt.2
        for <linux-pm@vger.kernel.org>; Fri, 21 Feb 2020 07:04:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=u7fybSbTVdeR3YQux270IM8jxeqEYCpR8SjGQKbdS+k=;
        b=yIRt2pGBKux6fna4iimxJdfcUZZX7Pgn5c6QhcImT0+fqlkJ70TZrIyVpdvl4aLeFR
         Nr7nuvMgeoCApKCZlt4nP5Ucj2AHDlsbw08qr65dAnNkbMnCmv2RMyxR5TR4+NmMz8js
         9Im0qZSoca51IRRJFaDwfiDzaH5uRfTXRkdoMECNLhBwp8O+bAXjxSrqMDeSygJdBp1G
         jhdWu0+Ef9eU3YAyfGS/vNc1oRY4gSh4QeWLwhfOykOEgwsWPTHVICpRbSeLB0D4JOBw
         8QMFUbnYFIWGUPME6xRjwGJ6MYlNEquUit9WtT6EBYaDCKtsOC/Gc65UA401aFdYFW6i
         uVYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=u7fybSbTVdeR3YQux270IM8jxeqEYCpR8SjGQKbdS+k=;
        b=Ca8/SHxGAj7vnkuUubzdCIHS067tdzJ0tVn4IrEyLVA8e/6gOvnTnBj6m2gvu3s3f+
         x03Mu+XLwkN0ik5gqmXzu4TS3bft3bhDbUxzKF0PzZwnZtCC9OFikoFbAO9nbiF3AcvT
         2cTiZv8PlKUQz3Mkq60qTJ227EcZxsw+TmnY+Mk4a/U5xVvuuxz+CMfhZe521j9eQrEe
         CeBYNfpyaSp278CU6N4/Cctnh614KTyQjSe9qcSOmA8LYlAv6YpC+jgzFg2wxmYGC62i
         JjwbHlW+n/BQU1C6/FvrLDXAoEiIqcd+EzV22ySPWLYUL+3KNRy3T/+bZsz35BdtkgHI
         GDmQ==
X-Gm-Message-State: APjAAAVN8s0m5FOH7YHYQHAGVqMVDur/DxZa8DpQb2NKuiM06bAlQUu5
        aUU3wbzOUKk71mwlyxQ/NdyyzQ==
X-Google-Smtp-Source: APXvYqyT1A5BG6nNdcMIM8CIrJkFezF89ObeJm7AWArr+UMLbxM3TxaSf1fpv516rDO8s/4z6atg/A==
X-Received: by 2002:adf:f7c4:: with SMTP id a4mr49456348wrq.361.1582297493908;
        Fri, 21 Feb 2020 07:04:53 -0800 (PST)
Received: from linaro.org ([2a01:e34:ed2f:f020:903b:a048:f296:e3ae])
        by smtp.gmail.com with ESMTPSA id c141sm3900298wme.41.2020.02.21.07.04.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 21 Feb 2020 07:04:52 -0800 (PST)
Date:   Fri, 21 Feb 2020 16:04:50 +0100
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        =?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
        Jasper Korten <jja2000@gmail.com>,
        David Heidelberg <david@ixit.cz>,
        Peter Geis <pgwipeout@gmail.com>, linux-pm@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v9 04/17] ARM: tegra: Change tegra_set_cpu_in_lp2() type
 to void
Message-ID: <20200221150450.GI10516@linaro.org>
References: <20200212235134.12638-1-digetx@gmail.com>
 <20200212235134.12638-5-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200212235134.12638-5-digetx@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Feb 13, 2020 at 02:51:21AM +0300, Dmitry Osipenko wrote:
> The Tegra30 CPUIDLE driver has intention to check whether primary CPU was
> the last CPU that entered LP2 (CC6) idle-state, but that functionality
> never got utilized because driver never supported the CC6 state for the
> case where any secondary CPU is online. The new cpuidle driver will
> properly support CC6 on Tegra30, including the case where secondary CPUs
> are online, and that knowledge about what CPUs entered into CC6 won't be
> needed at all because new driver will use different approach by making use
> of the coupled idle-state and explicitly parking secondary CPUs before
> entering into CC6. Thus this patch is just a minor cleanup change.
> 
> Acked-by: Peter De Schrijver <pdeschrijver@nvidia.com>
> Tested-by: Peter Geis <pgwipeout@gmail.com>
> Tested-by: Jasper Korten <jja2000@gmail.com>
> Tested-by: David Heidelberg <david@ixit.cz>
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  arch/arm/mach-tegra/cpuidle-tegra30.c | 14 ++++----------

Mind to move to drivers/cpuidle ?

Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>

>  arch/arm/mach-tegra/pm.c              |  8 +-------
>  arch/arm/mach-tegra/pm.h              |  2 +-
>  3 files changed, 6 insertions(+), 18 deletions(-)
> 
> diff --git a/arch/arm/mach-tegra/cpuidle-tegra30.c b/arch/arm/mach-tegra/cpuidle-tegra30.c
> index c6128526877d..a3ce8dabfe18 100644
> --- a/arch/arm/mach-tegra/cpuidle-tegra30.c
> +++ b/arch/arm/mach-tegra/cpuidle-tegra30.c
> @@ -98,22 +98,16 @@ static int tegra30_idle_lp2(struct cpuidle_device *dev,
>  			    int index)
>  {
>  	bool entered_lp2 = false;
> -	bool last_cpu;
>  
>  	local_fiq_disable();
>  
> -	last_cpu = tegra_set_cpu_in_lp2();
> +	tegra_set_cpu_in_lp2();
>  	cpu_pm_enter();
>  
> -	if (dev->cpu == 0) {
> -		if (last_cpu)
> -			entered_lp2 = tegra30_cpu_cluster_power_down(dev, drv,
> -								     index);
> -		else
> -			cpu_do_idle();
> -	} else {
> +	if (dev->cpu == 0)
> +		entered_lp2 = tegra30_cpu_cluster_power_down(dev, drv, index);
> +	else
>  		entered_lp2 = tegra30_cpu_core_power_down(dev, drv, index);
> -	}
>  
>  	cpu_pm_exit();
>  	tegra_clear_cpu_in_lp2();
> diff --git a/arch/arm/mach-tegra/pm.c b/arch/arm/mach-tegra/pm.c
> index 1ff499068bb1..a72f9a2d3cb7 100644
> --- a/arch/arm/mach-tegra/pm.c
> +++ b/arch/arm/mach-tegra/pm.c
> @@ -123,11 +123,9 @@ void tegra_clear_cpu_in_lp2(void)
>  	spin_unlock(&tegra_lp2_lock);
>  }
>  
> -bool tegra_set_cpu_in_lp2(void)
> +void tegra_set_cpu_in_lp2(void)
>  {
>  	int phy_cpu_id = cpu_logical_map(smp_processor_id());
> -	bool last_cpu = false;
> -	cpumask_t *cpu_lp2_mask = tegra_cpu_lp2_mask;
>  	u32 *cpu_in_lp2 = tegra_cpu_lp2_mask;
>  
>  	spin_lock(&tegra_lp2_lock);
> @@ -135,11 +133,7 @@ bool tegra_set_cpu_in_lp2(void)
>  	BUG_ON((*cpu_in_lp2 & BIT(phy_cpu_id)));
>  	*cpu_in_lp2 |= BIT(phy_cpu_id);
>  
> -	if ((phy_cpu_id == 0) && cpumask_equal(cpu_lp2_mask, cpu_online_mask))
> -		last_cpu = true;
> -
>  	spin_unlock(&tegra_lp2_lock);
> -	return last_cpu;
>  }
>  
>  static int tegra_sleep_cpu(unsigned long v2p)
> diff --git a/arch/arm/mach-tegra/pm.h b/arch/arm/mach-tegra/pm.h
> index b9cc12222bb1..2c294f6365c0 100644
> --- a/arch/arm/mach-tegra/pm.h
> +++ b/arch/arm/mach-tegra/pm.h
> @@ -24,7 +24,7 @@ void tegra30_lp1_iram_hook(void);
>  void tegra30_sleep_core_init(void);
>  
>  void tegra_clear_cpu_in_lp2(void);
> -bool tegra_set_cpu_in_lp2(void);
> +void tegra_set_cpu_in_lp2(void);
>  void tegra_idle_lp2_last(void);
>  extern void (*tegra_tear_down_cpu)(void);
>  
> -- 
> 2.24.0
> 

-- 

 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
