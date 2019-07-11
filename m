Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D512365EC2
	for <lists+linux-pm@lfdr.de>; Thu, 11 Jul 2019 19:39:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728596AbfGKRje (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 11 Jul 2019 13:39:34 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:34245 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728591AbfGKRje (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 11 Jul 2019 13:39:34 -0400
Received: by mail-pg1-f194.google.com with SMTP id p10so3288805pgn.1
        for <linux-pm@vger.kernel.org>; Thu, 11 Jul 2019 10:39:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=HFZ1x9Bwz0GUDiOhP+7WxNPTOOqtjhEpu7L1QSIu54o=;
        b=kqlroZe7s+T13xYRD1th/uV6N3YkpWdMDzxIIFwQ3gDiLT3wa7qh4YgQEuuSkugzgL
         /uXB2s+618wSOpYeEZEOx6Zo55mhAdfZv/xCopvHTtWqNOKJeYU4lgzerllcKFHYhijw
         gdiTnf31KYPqhs4yGxw35020hpX2r6WA+B2RPXfPw4V4of15OtygEKGbF714c9A1Xd5W
         4wKQiw62KZEMrT6SZa0nDXpVHa8q9AvAxMR3hm6Po+LZ12pKj2EMBkKdJf4QBV/ilvFC
         eleQlxQf1VpsKLBBysZ3aGGheMnoi1f+o6NOiqHTH4Qo35DRdhokkSp4EOoU6am5pStB
         1e6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=HFZ1x9Bwz0GUDiOhP+7WxNPTOOqtjhEpu7L1QSIu54o=;
        b=m3f3T85MesjK4LjnmaG5taUF11CSvBr9V5ONApmQTGUkgmFfvPCYZDpg9AHI0TLxoR
         PY0k/cfdTOIuIzt7r6gtfO1AvjNW0bdo2wJ+OT3UsM0Nc/rVOSHHiFYgU+KIBoqiuPay
         PaZ+BUV3nwPSHYU2ROYO8FID9/iDBX893ceqFr05Fjuo5cllVj2qodOA08oG68H50AMy
         JLsK4HQ009zxAJB+rUmb/zOG5ieZ1MtZjEZMVMnjGezyjfX18S5x87PYCayb3kbcwoc5
         IF/WaiyaxFagU/OKRHT+PSv9KdIjppoe0V8byfu1/oLa0Kd0vq4NPWJRFnV6FKZCoFna
         Tnjg==
X-Gm-Message-State: APjAAAW6wOgpyVf/21RLzoM0Uj+vyiLRO/shQ6OnhQCsCQbn8Q42uIih
        q5fuH2gA52uqoFeLtU/SUIdjuA==
X-Google-Smtp-Source: APXvYqx53DWisrIUx8wtw7I10qDwRqbUe57mjMuQjMcDn74PJCZFUDQRHQVTvfGYi0yrHyXySpJJsw==
X-Received: by 2002:a17:90a:7148:: with SMTP id g8mr6263776pjs.51.1562866772910;
        Thu, 11 Jul 2019 10:39:32 -0700 (PDT)
Received: from tuxbook-pro (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id i124sm13165127pfe.61.2019.07.11.10.39.30
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 11 Jul 2019 10:39:32 -0700 (PDT)
Date:   Thu, 11 Jul 2019 10:40:43 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Sibi Sankar <sibis@codeaurora.org>
Cc:     viresh.kumar@linaro.org, nm@ti.com, sboyd@kernel.org,
        georgi.djakov@linaro.org, agross@kernel.org,
        david.brown@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com,
        rjw@rjwysocki.net, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, saravanak@google.com
Subject: Re: [PATCH RFC 2/4] OPP: Add and export helper to set bandwidth
Message-ID: <20190711174043.GU7234@tuxbook-pro>
References: <20190627133424.4980-1-sibis@codeaurora.org>
 <20190627133424.4980-3-sibis@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190627133424.4980-3-sibis@codeaurora.org>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu 27 Jun 06:34 PDT 2019, Sibi Sankar wrote:

> Add and export 'dev_pm_opp_set_bw' to set the bandwidth
> levels associated with an OPP for a given frequency.
> 

While this looks quite reasonable I'm uncertain about the overall OPP
API.

With the profiling based (bwmon/llcc) approach we would acquire the peak
bandwidth from the OPP table and calculate the average dynamically,
based on measurements and heuristics.

For that I think we will have a struct dev_pm_opp at hand (e.g. from
devfreq_recommended_opp() or similar), from which we want to read the
peak value and then apply the icc vote. Or would we want to update the
avg bw and then apply the opp using a method like this? (In which case
we probably don't want to pass a freq, but a struct dev_pm_opp *, to
avoid the additional lookup)

Regards,
Bjorn

> Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
> ---
>  drivers/opp/core.c     | 46 ++++++++++++++++++++++++++++++++++++++++++
>  include/linux/pm_opp.h |  6 ++++++
>  2 files changed, 52 insertions(+)
> 
> diff --git a/drivers/opp/core.c b/drivers/opp/core.c
> index c85c04dc2c7de..78f42960860d1 100644
> --- a/drivers/opp/core.c
> +++ b/drivers/opp/core.c
> @@ -746,6 +746,52 @@ static int _set_required_opps(struct device *dev,
>  	return ret;
>  }
>  
> +/**
> + * dev_pm_opp_set_bw() - Configures OPP bandwidth levels
> + * @dev:	device for which we do this operation
> + * @freq:	bandwidth values to set with matching 'freq'
> + *
> + * This configures the bandwidth to the levels specified
> + * by the OPP corresponding to the given frequency.
> + *
> + * Return: 0 on success or a negative error value.
> + */
> +int dev_pm_opp_set_bw(struct device *dev, unsigned long freq)
> +{
> +	struct opp_table *opp_table;
> +	struct dev_pm_opp *opp;
> +	int ret = 0;
> +	int i;
> +
> +	opp = dev_pm_opp_find_freq_exact(dev, freq, true);
> +	if (IS_ERR(opp))
> +		return PTR_ERR(opp);
> +
> +	opp_table = _find_opp_table(dev);
> +	if (IS_ERR(opp_table)) {
> +		dev_err(dev, "%s: device opp table doesn't exist\n", __func__);
> +		ret = PTR_ERR(opp_table);
> +		goto put_opp;
> +	}
> +
> +	if (IS_ERR_OR_NULL(opp_table->paths)) {
> +		ret = -ENODEV;
> +		goto put_opp_table;
> +	}
> +
> +	for (i = 0; i < opp_table->path_count; i++) {
> +		ret = icc_set_bw(opp_table->paths[i], opp->bandwidth[i].avg,
> +				 opp->bandwidth[i].peak);
> +	}
> +
> +put_opp_table:
> +	dev_pm_opp_put_opp_table(opp_table);
> +put_opp:
> +	dev_pm_opp_put(opp);
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(dev_pm_opp_set_bw);
> +
>  /**
>   * dev_pm_opp_set_rate() - Configure new OPP based on frequency
>   * @dev:	 device for which we do this operation
> diff --git a/include/linux/pm_opp.h b/include/linux/pm_opp.h
> index a17c462974851..1cdc2d0a2b20e 100644
> --- a/include/linux/pm_opp.h
> +++ b/include/linux/pm_opp.h
> @@ -152,6 +152,7 @@ struct opp_table *dev_pm_opp_attach_genpd(struct device *dev, const char **names
>  void dev_pm_opp_detach_genpd(struct opp_table *opp_table);
>  int dev_pm_opp_xlate_performance_state(struct opp_table *src_table, struct opp_table *dst_table, unsigned int pstate);
>  int dev_pm_opp_set_rate(struct device *dev, unsigned long target_freq);
> +int dev_pm_opp_set_bw(struct device *dev, unsigned long freq);
>  int dev_pm_opp_set_sharing_cpus(struct device *cpu_dev, const struct cpumask *cpumask);
>  int dev_pm_opp_get_sharing_cpus(struct device *cpu_dev, struct cpumask *cpumask);
>  void dev_pm_opp_remove_table(struct device *dev);
> @@ -336,6 +337,11 @@ static inline int dev_pm_opp_set_rate(struct device *dev, unsigned long target_f
>  	return -ENOTSUPP;
>  }
>  
> +static inline int dev_pm_opp_set_bw(struct device *dev, unsigned long freq)
> +{
> +	return -ENOTSUPP;
> +}
> +
>  static inline int dev_pm_opp_set_sharing_cpus(struct device *cpu_dev, const struct cpumask *cpumask)
>  {
>  	return -ENOTSUPP;
> -- 
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
> 
