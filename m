Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BEA4B399E34
	for <lists+linux-pm@lfdr.de>; Thu,  3 Jun 2021 11:56:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229753AbhFCJ61 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 3 Jun 2021 05:58:27 -0400
Received: from mail-pl1-f173.google.com ([209.85.214.173]:45798 "EHLO
        mail-pl1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229751AbhFCJ61 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 3 Jun 2021 05:58:27 -0400
Received: by mail-pl1-f173.google.com with SMTP id 11so2592703plk.12
        for <linux-pm@vger.kernel.org>; Thu, 03 Jun 2021 02:56:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=bWwoATch/is17syekXXf9OKGsFoEOq9WgVsQ4YbeVPM=;
        b=Mrt+g2TUakUnIZvvo7w0SLH+4c0hsL9MVUWE5Uk4/S4rItImANhOsDyN/6LfOUvGSf
         RevmCO3ibS6kHKic7/BYGFgRL69mUV7BMnkv792C2VRYdRND6XJ7XrK8fbMFeXO1PT2o
         8EAamCaTMNcaPalI2QOcgXqcW9dpHT5bTLVhtqod/JqC36rS6Z9+LeWK3mpFUArZscRE
         vTY6iDzA3Luk5r2WBf23oNvMmNLRXHIkEofkRkIwBz11KcYe41v7ZUEUhMV3Em9MTMcd
         4TAKp7OxhbQbXEwvQlDpvzzncGQxVQUKL7CSzRexC78ySQFIt5UtG6Xum/nW7SxqNxW+
         6ynA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=bWwoATch/is17syekXXf9OKGsFoEOq9WgVsQ4YbeVPM=;
        b=GG5LrBym/DgREI5gnf+EQrHcX1ttUP+cdTpuq4sLzoZekbqjUOKEl+x+cdOlTjY637
         lcV1Opgy3ZCFI7Gjvq6LbCZfTv46beGhSOiw+lb5sAiZRMPWdPQgUUJW1Q6xN/NmHEe0
         Ro1vYq6E5Iq/LAZ2Q2J/9SkzKLf1ifUYpLk5kZMCWY47Zj+06DbmwdxV9gTDCgm9SHAI
         6lc8Lfads6EsiTBQiAVWacq+JLlVcLm+i5E7qpjQ4xiYJLaI9A+6m3j6GG4FBe3DvpaQ
         J/v+xSIdrdZAGyTj6hI0db5qtkQw10iX3ALTWSqSAnLzGfNTXaEx/bIYjc4al4BaN7c4
         NWnA==
X-Gm-Message-State: AOAM532+53DG2Ep5Il2NUJ2iky0Eokj5sl2TDQq/nNvCTqYaRO0LOcuJ
        gbYu1MjnjwLRw9SppnfvKr5b+A==
X-Google-Smtp-Source: ABdhPJy3ETi8TG18LS356HnFPyHJW0fzt2AaED/39O4jlOV5io9iaCRsz7cUFRiTiZhleQ5DTb9OoQ==
X-Received: by 2002:a17:902:b594:b029:f8:fb4f:f8d3 with SMTP id a20-20020a170902b594b02900f8fb4ff8d3mr34898636pls.25.1622714142521;
        Thu, 03 Jun 2021 02:55:42 -0700 (PDT)
Received: from localhost ([136.185.154.93])
        by smtp.gmail.com with ESMTPSA id t12sm2049594pfc.133.2021.06.03.02.55.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Jun 2021 02:55:40 -0700 (PDT)
Date:   Thu, 3 Jun 2021 15:25:38 +0530
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
Subject: Re: [PATCH v2 3/4] PM: domains: Drop/restore performance state votes
 for devices at runtime PM
Message-ID: <20210603095538.b2t3cq25tq7v7kih@vireshk-i7>
References: <20210603093438.138705-1-ulf.hansson@linaro.org>
 <20210603093438.138705-4-ulf.hansson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210603093438.138705-4-ulf.hansson@linaro.org>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 03-06-21, 11:34, Ulf Hansson wrote:
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
> 
> Changes in v2:
> 	- Rebased.
> 	- A few minor cosmetic changes.
> 	- Deal with the error path in genpd_runtime_resume().
> 
> ---
>  drivers/base/power/domain.c | 27 +++++++++++++++++++++++++--
>  include/linux/pm_domain.h   |  1 +
>  2 files changed, 26 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
> index ef25a5b18587..e5d97174c254 100644
> --- a/drivers/base/power/domain.c
> +++ b/drivers/base/power/domain.c
> @@ -400,6 +400,23 @@ static int genpd_set_performance_state(struct device *dev, unsigned int state)
>  	return ret;
>  }
>  
> +static int genpd_drop_performance_state(struct device *dev)

What about passing the state pointer here? that will simplify the
callers to just a call.

> +{
> +	unsigned int prev_state = dev_gpd_data(dev)->performance_state;
> +
> +	if (!genpd_set_performance_state(dev, 0))
> +		return prev_state;
> +
> +	return 0;
> +}
> +
> +static void genpd_restore_performance_state(struct device *dev,
> +					    unsigned int state)
> +{
> +	if (state)

I will skip this check, as we are checking it in
genpd_set_performance_state() anyway ?

> +		genpd_set_performance_state(dev, state);
> +}
> +
>  /**
>   * dev_pm_genpd_set_performance_state- Set performance state of device's power
>   * domain.
> @@ -842,7 +859,8 @@ static int genpd_runtime_suspend(struct device *dev)
>  {
>  	struct generic_pm_domain *genpd;
>  	bool (*suspend_ok)(struct device *__dev);
> -	struct gpd_timing_data *td = &dev_gpd_data(dev)->td;
> +	struct generic_pm_domain_data *gpd_data = dev_gpd_data(dev);
> +	struct gpd_timing_data *td = &gpd_data->td;
>  	bool runtime_pm = pm_runtime_enabled(dev);
>  	ktime_t time_start;
>  	s64 elapsed_ns;
> @@ -899,6 +917,7 @@ static int genpd_runtime_suspend(struct device *dev)
>  		return 0;
>  
>  	genpd_lock(genpd);
> +	gpd_data->rpm_pstate = genpd_drop_performance_state(dev);

So this will become:

	genpd_drop_performance_state(dev, &gpd_data->rpm_pstate);

and it can have return type of void.

-- 
viresh
