Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 941B2196130
	for <lists+linux-pm@lfdr.de>; Fri, 27 Mar 2020 23:33:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727585AbgC0Wd3 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 27 Mar 2020 18:33:29 -0400
Received: from mail-pj1-f65.google.com ([209.85.216.65]:40553 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727774AbgC0Wd2 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 27 Mar 2020 18:33:28 -0400
Received: by mail-pj1-f65.google.com with SMTP id kx8so4332051pjb.5
        for <linux-pm@vger.kernel.org>; Fri, 27 Mar 2020 15:33:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=d/KauctItzFcz4MTqqd1vUXD0AkHqsSbhj7pDruk56s=;
        b=MWJ1hSHBbc9XdAiP8isr7WdcCfHrTAeSAsfLsPttskj8ru14jpS6XSJExEd+D7+x4n
         4OHW2Cs8ZTnFhZHBE2sVlbg2ZypZVkj4l/D59p5XFsqhZYu3WD2zx2F7zy2h5dX/Ug6u
         yNX6pRubA0w24iXYco8yZAHRcurEHhYjqV2aH/zKx0uxz5fXGBddmYF0NAkVL10Q95AA
         sp26mugVpC/waCWnzEzrhSSABUDGc3ZoS3JoFYu/kWGJruy2KDEB9+8dD7VCQbG7Ybz8
         7bUrhQUowP+5vlnF03HfBpMlnoh9Zp7Zp6/T3laPaky46OLqvH2R5fy4I9UWglSN9dZf
         0TOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=d/KauctItzFcz4MTqqd1vUXD0AkHqsSbhj7pDruk56s=;
        b=nhhV2kBGN5i61LqygDdBK23OcKJPwUIJafg30/P5kwL5zrvaEOgIypvoSO63I4UKyi
         tf7w/yIPRr7TdD41A3A5o553cDUPxyykNznuT6toYfGzILI/VxwNic1/8oVRPqV0CI+8
         V5Q5hInENzb3PmSpqpayLB/2lOgXHJMdGZ+h3E4YmAubyVa46vhlaTOrAzeQLgzhFsJa
         iMnRfBKmxmh05hSt5iZsNlS/k6LQJRkv6tdgo79ZyRClbAMZha+6zNdsMktIihmXkox3
         1hK6VG5qJXhQl5eJT45qNw+2kfeo5Se2OCKRBweFXzJ4rq2fdOJns4oeiSBb0aS6BmMr
         L+Qg==
X-Gm-Message-State: ANhLgQ12uKaSNaSWdj6OCaK9XswzTZDN59/etahGKn8g1d8k72MRAaeR
        xAMO4Z1dovTeR0XB8ZBCW+RDGg==
X-Google-Smtp-Source: ADFU+vssCeEO2fNVLOHh9lVPMb7g8Vyce8f9YZ3fpI0mEUsCWO+pn45g3L8i2nWBTgIMNEM/YhFfUg==
X-Received: by 2002:a17:90a:1b4f:: with SMTP id q73mr1577559pjq.188.1585348405138;
        Fri, 27 Mar 2020 15:33:25 -0700 (PDT)
Received: from builder (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id c9sm4451481pjr.47.2020.03.27.15.33.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Mar 2020 15:33:24 -0700 (PDT)
Date:   Fri, 27 Mar 2020 15:33:22 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Thara Gopinath <thara.gopinath@linaro.org>
Cc:     rui.zhang@intel.com, ulf.hansson@linaro.org,
        daniel.lezcano@linaro.org, agross@kernel.org, robh@kernel.org,
        amit.kucheria@verdurent.com, mark.rutland@arm.com,
        rjw@rjwysocki.net, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [Patch v5 1/6] PM/Domains: Add support for retrieving genpd
 performance states information
Message-ID: <20200327223322.GG5063@builder>
References: <20200320014107.26087-1-thara.gopinath@linaro.org>
 <20200320014107.26087-2-thara.gopinath@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200320014107.26087-2-thara.gopinath@linaro.org>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu 19 Mar 18:41 PDT 2020, Thara Gopinath wrote:

> Add two new APIs in the genpd framework, dev_pm_genpd_get_performance_state
> to return the current performance state of a power domain and
> dev_pm_genpd_performance_state_count to return the total number of
> performance states supported by a power domain. Since the genpd framework
> does not maintain a count of number of performance states supported by a
> power domain, introduce a new callback(.get_performance_state_count) that
> can be used to retrieve this information from power domain drivers.
> 
> These APIs are added to aid the implementation of a power domain as a
> warming device. Linux kernel cooling device framework(into which warming
> device can be plugged in) requires during initialization to be provided
> with the maximum number of states that can be supported. When a power
> domain acts as a warming device, the max state is the max number of
> perfomrance states supported by the power domain. The cooling device
> framework implements API to retrieve the current state of the cooling
> device. This in turn translates to the current performance state of the
> power domain.
> 
> Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
> Signed-off-by: Thara Gopinath <thara.gopinath@linaro.org>

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

> ---
>  drivers/base/power/domain.c | 37 +++++++++++++++++++++++++++++++++++++
>  include/linux/pm_domain.h   | 13 +++++++++++++
>  2 files changed, 50 insertions(+)
> 
> diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
> index 959d6d5eb000..d0297c48fa79 100644
> --- a/drivers/base/power/domain.c
> +++ b/drivers/base/power/domain.c
> @@ -408,6 +408,43 @@ int dev_pm_genpd_set_performance_state(struct device *dev, unsigned int state)
>  }
>  EXPORT_SYMBOL_GPL(dev_pm_genpd_set_performance_state);
>  
> +int dev_pm_genpd_get_performance_state(struct device *dev)
> +{
> +	struct generic_pm_domain *genpd;
> +	unsigned int state;
> +
> +	genpd = dev_to_genpd_safe(dev);
> +	if (IS_ERR(genpd))
> +		return -ENODEV;
> +
> +	genpd_lock(genpd);
> +	state = genpd->performance_state;
> +	genpd_unlock(genpd);
> +
> +	return state;
> +}
> +EXPORT_SYMBOL_GPL(dev_pm_genpd_get_performance_state);
> +
> +int dev_pm_genpd_performance_state_count(struct device *dev)
> +{
> +	struct generic_pm_domain *genpd;
> +	int count;
> +
> +	genpd = dev_to_genpd_safe(dev);
> +	if (IS_ERR(genpd))
> +		return -ENODEV;
> +
> +	if (unlikely(!genpd->get_performance_state_count))
> +		return -EINVAL;
> +
> +	genpd_lock(genpd);
> +	count = genpd->get_performance_state_count(genpd);
> +	genpd_unlock(genpd);
> +
> +	return count;
> +}
> +EXPORT_SYMBOL_GPL(dev_pm_genpd_performance_state_count);
> +
>  static int _genpd_power_on(struct generic_pm_domain *genpd, bool timed)
>  {
>  	unsigned int state_idx = genpd->state_idx;
> diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
> index 9ec78ee53652..7d415350380f 100644
> --- a/include/linux/pm_domain.h
> +++ b/include/linux/pm_domain.h
> @@ -117,6 +117,7 @@ struct generic_pm_domain {
>  						 struct dev_pm_opp *opp);
>  	int (*set_performance_state)(struct generic_pm_domain *genpd,
>  				     unsigned int state);
> +	int (*get_performance_state_count)(struct generic_pm_domain *genpd);
>  	struct gpd_dev_ops dev_ops;
>  	s64 max_off_time_ns;	/* Maximum allowed "suspended" time. */
>  	bool max_off_time_changed;
> @@ -204,6 +205,8 @@ int pm_genpd_init(struct generic_pm_domain *genpd,
>  		  struct dev_power_governor *gov, bool is_off);
>  int pm_genpd_remove(struct generic_pm_domain *genpd);
>  int dev_pm_genpd_set_performance_state(struct device *dev, unsigned int state);
> +int dev_pm_genpd_get_performance_state(struct device *dev);
> +int dev_pm_genpd_performance_state_count(struct device *dev);
>  
>  extern struct dev_power_governor simple_qos_governor;
>  extern struct dev_power_governor pm_domain_always_on_gov;
> @@ -251,6 +254,16 @@ static inline int dev_pm_genpd_set_performance_state(struct device *dev,
>  	return -ENOTSUPP;
>  }
>  
> +static inline int dev_pm_genpd_get_performance_state(struct device *dev)
> +{
> +	return -ENOTSUPP;
> +}
> +
> +static inline int dev_pm_genpd_performance_state_count(struct device *dev)
> +{
> +	return -ENOTSUPP;
> +}
> +
>  #define simple_qos_governor		(*(struct dev_power_governor *)(NULL))
>  #define pm_domain_always_on_gov		(*(struct dev_power_governor *)(NULL))
>  #endif
> -- 
> 2.20.1
> 
