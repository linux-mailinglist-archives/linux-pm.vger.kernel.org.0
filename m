Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19C03399812
	for <lists+linux-pm@lfdr.de>; Thu,  3 Jun 2021 04:34:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229667AbhFCCg2 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 2 Jun 2021 22:36:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbhFCCg2 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 2 Jun 2021 22:36:28 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 971FFC06174A
        for <linux-pm@vger.kernel.org>; Wed,  2 Jun 2021 19:34:44 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id k15so3742321pfp.6
        for <linux-pm@vger.kernel.org>; Wed, 02 Jun 2021 19:34:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=LEpREQsIMN25PFBx0nhcaFLBaBbVRZob8Sf02Ij6Cck=;
        b=i8dKvZZR+wF97amDsa6Q7nmotXXv77Z2NaB5PQjbkGomRxwbdE+DbrVA8WDzMf6Q/f
         /nG/956gJUdAV0PLQYybZl4tKtx/21ryeLXykHTLPGLUi7LQbBPz13t6qeV8tK16UiE2
         gTABqPAjnXhhhrl2Q+td8ukbDooV3ImTbvDRQfmulZ1+0og/oQWgUiGqYjYtOWdqoURv
         M6a61GxoBc1aP+pttXszg4noo1psAyF0SGEkh8G08glwhxx/kr1O8p5+DmdnWqsoNjy2
         7/ODqvE8UON3vvt5vc1JTj6mZGbRl99wzcD+WW8K6iN8Wfs07F3TikAD6LE7vxSeRSHE
         AP6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=LEpREQsIMN25PFBx0nhcaFLBaBbVRZob8Sf02Ij6Cck=;
        b=hJh0Oi0WVIsYgOEKiSq8HA7AHOEHuzWxGAzGqmuGZnI/kvewtwJywR6I8sHIsLhjGk
         KcgUkwYg6ThYC7Xs8ut/fd3UEcLzFhIwGG/gdHsY77iQ+DhnwD0FVn57EvAEJDBPGRlu
         xsur9vl5lCRnKUH0p1ttHS7cfIhaDZsIjopj/BWj+zZTzLWTCmJJ80oUfdzo8/ZUQG71
         1w4/Oe3c2jL8y/vDcYNN0D4+uknIK6fcX5wFTFyTBK58Kpe7Cl0dayCazjPr0i3Eeahn
         7hO6EaaV+rw9Dad/Reiyile5ftLXysp6jOB+sDXuQ+yD2lnvFde5gr4SNpN2A3n0/Yjg
         u27g==
X-Gm-Message-State: AOAM532NvHMgGKw2lL9BgXjldRHj+CMuH8bzWdOdiT2LruFd8X+Rjp0U
        CkQoFOqmgVb90LK6xs02PYtS5g==
X-Google-Smtp-Source: ABdhPJwPVmIxvrB65hE96ik3Vkf6ezjjJSVTqpjbYw9YfY27RkLjo37f5+JnToTXQxDLpk/z+KOiLg==
X-Received: by 2002:a05:6a00:14d0:b029:2cf:ee47:dfd9 with SMTP id w16-20020a056a0014d0b02902cfee47dfd9mr30747720pfu.31.1622687683952;
        Wed, 02 Jun 2021 19:34:43 -0700 (PDT)
Received: from localhost ([136.185.154.93])
        by smtp.gmail.com with ESMTPSA id j12sm888661pgj.14.2021.06.02.19.34.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jun 2021 19:34:43 -0700 (PDT)
Date:   Thu, 3 Jun 2021 08:04:41 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org,
        Dmitry Osipenko <digetx@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        Roja Rani Yarubandi <rojay@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] PM: domains: Drop/restore performance state votes
 for devices at runtime PM
Message-ID: <20210603023441.bs47nwtmskrdz2el@vireshk-i7>
References: <20210602101215.78094-1-ulf.hansson@linaro.org>
 <20210602101215.78094-3-ulf.hansson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210602101215.78094-3-ulf.hansson@linaro.org>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 02-06-21, 12:12, Ulf Hansson wrote:
> A subsystem/driver that need to manage OPPs for its device, should
> typically drop its vote for the OPP when the device becomes runtime
> suspended. In this way, the corresponding aggregation of the performance
> state votes that is managed in genpd for the attached PM domain, may find
> that the aggregated vote can be decreased. Hence, it may allow genpd to set
> the lower performance state for the PM domain, thus avoiding to waste
> energy.
> 
> To accomplish this, typically a subsystem/driver would need to call
> dev_pm_opp_set_rate|opp() for its device from its ->runtime_suspend()
> callback, to drop the vote for the OPP. Accordingly, it needs another call
> to dev_pm_opp_set_rate|opp() to restore the vote for the OPP from its
> ->runtime_resume() callback.
> 
> To avoid boilerplate code in subsystems/driver to deal with these things,
> let's instead manage this internally in genpd.
> 
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---
>  drivers/base/power/domain.c | 21 +++++++++++++++++++--
>  include/linux/pm_domain.h   |  1 +
>  2 files changed, 20 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
> index a3b6e751f366..81b9d4652b90 100644
> --- a/drivers/base/power/domain.c
> +++ b/drivers/base/power/domain.c
> @@ -397,6 +397,18 @@ static int genpd_set_performance_state(struct device *dev, unsigned int state)
>  	return ret;
>  }
>  
> +static int genpd_drop_performance_state(struct device *dev)
> +{
> +	struct generic_pm_domain_data *gpd_data = dev_gpd_data(dev);
> +	unsigned int prev_state;
> +
> +	prev_state = gpd_data->performance_state;
> +	if (prev_state && !genpd_set_performance_state(dev, 0))

What about adding this prev_state check in
genpd_set_performance_state() itself ? We already have one for the
genpd in _genpd_set_performance_state(), why not one for the device ?

> +		return prev_state;
> +
> +	return 0;

Hmm, we will return 0 in case genpd_set_performance_state() fails,
which will make us set the state to 0 again on resume. Maybe add a
comment for this somewhere ?

> +}
> +
>  /**
>   * dev_pm_genpd_set_performance_state- Set performance state of device's power
>   * domain.
> @@ -839,7 +851,8 @@ static int genpd_runtime_suspend(struct device *dev)
>  {
>  	struct generic_pm_domain *genpd;
>  	bool (*suspend_ok)(struct device *__dev);
> -	struct gpd_timing_data *td = &dev_gpd_data(dev)->td;
> +	struct generic_pm_domain_data *gpd_data = dev_gpd_data(dev);
> +	struct gpd_timing_data *td = &gpd_data->td;
>  	bool runtime_pm = pm_runtime_enabled(dev);
>  	ktime_t time_start;
>  	s64 elapsed_ns;
> @@ -896,6 +909,7 @@ static int genpd_runtime_suspend(struct device *dev)
>  		return 0;
>  
>  	genpd_lock(genpd);
> +	gpd_data->rpm_saved_pstate = genpd_drop_performance_state(dev);
>  	genpd_power_off(genpd, true, 0);
>  	genpd_unlock(genpd);
>  
> @@ -913,7 +927,8 @@ static int genpd_runtime_suspend(struct device *dev)
>  static int genpd_runtime_resume(struct device *dev)
>  {
>  	struct generic_pm_domain *genpd;
> -	struct gpd_timing_data *td = &dev_gpd_data(dev)->td;
> +	struct generic_pm_domain_data *gpd_data = dev_gpd_data(dev);
> +	struct gpd_timing_data *td = &gpd_data->td;
>  	bool runtime_pm = pm_runtime_enabled(dev);
>  	ktime_t time_start;
>  	s64 elapsed_ns;
> @@ -937,6 +952,8 @@ static int genpd_runtime_resume(struct device *dev)
>  
>  	genpd_lock(genpd);
>  	ret = genpd_power_on(genpd, 0);
> +	if (!ret && gpd_data->rpm_saved_pstate)
> +		genpd_set_performance_state(dev, gpd_data->rpm_saved_pstate);
>  	genpd_unlock(genpd);
>  
>  	if (ret)
> diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
> index dfcfbcecc34b..c3d6c15788a3 100644
> --- a/include/linux/pm_domain.h
> +++ b/include/linux/pm_domain.h
> @@ -198,6 +198,7 @@ struct generic_pm_domain_data {
>  	struct notifier_block *power_nb;
>  	int cpu;
>  	unsigned int performance_state;
> +	unsigned int rpm_saved_pstate;
>  	ktime_t	next_wakeup;
>  	void *data;
>  };
> -- 
> 2.25.1

-- 
viresh
