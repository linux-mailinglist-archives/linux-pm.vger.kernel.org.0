Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50BE630EA6A
	for <lists+linux-pm@lfdr.de>; Thu,  4 Feb 2021 03:50:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231759AbhBDCuK (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 3 Feb 2021 21:50:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231553AbhBDCuJ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 3 Feb 2021 21:50:09 -0500
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3398CC061573
        for <linux-pm@vger.kernel.org>; Wed,  3 Feb 2021 18:49:29 -0800 (PST)
Received: by mail-pf1-x431.google.com with SMTP id i63so1160406pfg.7
        for <linux-pm@vger.kernel.org>; Wed, 03 Feb 2021 18:49:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Bn5azreVFLQ7qN/StWsc+t91I2MG70w1jFYtpayCC+s=;
        b=F2SpybZcrRPLQx8JKELEkQPQQnltU4dYlqWpY27vNrQ9LIP8SkDtmFOTbkGpCuULPn
         uqPG07R7uyqEPEkslR2Ok6ZPRlIziuWFk5O14JumEahpKSyg+GhPVpHg52Cy3swXWt0Y
         /PLe+1C1+JQfrY8AoOXAiSY58t8m1hSsj4TOM7rEOS8P2L9M87yq8tPGXU0SeAPdsIzp
         5ZdumAj0SnEeU+mvSnuvFhNXoHP4BnrEHWQH9m9LETjspFsL44ttdoJMyjR6zOqIyM9k
         YyczDA4O4SPTsnac8RpoRMNcvasHlpUv5J7Sxsj3cvENxL/ACtZ7lioQEY9q0HquRlJJ
         vfaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Bn5azreVFLQ7qN/StWsc+t91I2MG70w1jFYtpayCC+s=;
        b=LM8gf8SlTa5m3XIzomvSOAQ8fYi/dth/QfrCt1v8Oq7RAHBCXYP66gxDvjBo8sda8O
         CSDVuZtFh3zYOn1hX0+Fvn2X6hTIqDVNpWYlyAP+CwBS0g+O8j91lPTjNpRas64R/G80
         VRbzjKZZpsym+v4ITBLOZMFo1P22UAly4fD39P49TzjiIsHXTyhm26HKwmArCX070o3L
         RdhS8cfuRQyWUtq0m6WIxxPxFeRxvSbUT1FoBVTfsc0Wyvp7L7De3fYCigRd7IpCpjiT
         3L5dqPKRPf+7kLbscEZ97qzI/IQpi12DdyDj81mvp8EgI9SRGsSm2yWhjfiT4HKxgBqS
         L6+w==
X-Gm-Message-State: AOAM531gmMiNryN8nWXmNvh4M0FHtwbgiUTj+IOo5jdpN9gvwBcCcnhF
        vgb1gh9DkF6P6c/BDpVMNYWaEQ==
X-Google-Smtp-Source: ABdhPJxdLL3q7YcEbpJ/tML9sJOlkfIdFq3JFDGVux05uGv5fHy5hHgzUeb/CMMOj6uiclkxyoz6KA==
X-Received: by 2002:a63:e101:: with SMTP id z1mr6684962pgh.190.1612406968511;
        Wed, 03 Feb 2021 18:49:28 -0800 (PST)
Received: from localhost ([122.172.59.240])
        by smtp.gmail.com with ESMTPSA id dw23sm3446020pjb.3.2021.02.03.18.49.27
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Feb 2021 18:49:27 -0800 (PST)
Date:   Thu, 4 Feb 2021 08:19:25 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Hsin-Yi Wang <hsinyi@chromium.org>
Cc:     Viresh Kumar <vireshk@kernel.org>, linux-pm@vger.kernel.org,
        Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        linux-kernel@vger.kernel.org,
        "MyungJoo Ham )" <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Saravana Kannan <saravanak@google.com>
Subject: Re: [PATCH v5 3/3] PM / devfreq: Add required OPPs support to
 passive governor
Message-ID: <20210204024925.teamzh3d6aq6qfln@vireshk-i7>
References: <20210203092400.1791884-1-hsinyi@chromium.org>
 <20210203092400.1791884-4-hsinyi@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210203092400.1791884-4-hsinyi@chromium.org>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 03-02-21, 17:24, Hsin-Yi Wang wrote:
> From: Saravana Kannan <saravanak@google.com>
> 
> Look at the required OPPs of the "parent" device to determine the OPP that
> is required from the slave device managed by the passive governor. This
> allows having mappings between a parent device and a slave device even when
> they don't have the same number of OPPs.
> 
> Signed-off-by: Saravana Kannan <saravanak@google.com>
> Acked-by: MyungJoo Ham <myungjoo.ham@samsung.com>
> Acked-by: Chanwoo Choi <cw00.choi@samsung.com>
> Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
> ---
>  drivers/devfreq/governor_passive.c | 20 +++++++++++++++-----
>  1 file changed, 15 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/devfreq/governor_passive.c b/drivers/devfreq/governor_passive.c
> index 63332e4a65ae8..8d92b1964f9c3 100644
> --- a/drivers/devfreq/governor_passive.c
> +++ b/drivers/devfreq/governor_passive.c
> @@ -19,7 +19,7 @@ static int devfreq_passive_get_target_freq(struct devfreq *devfreq,
>  			= (struct devfreq_passive_data *)devfreq->data;
>  	struct devfreq *parent_devfreq = (struct devfreq *)p_data->parent;
>  	unsigned long child_freq = ULONG_MAX;
> -	struct dev_pm_opp *opp;
> +	struct dev_pm_opp *opp = NULL, *p_opp = NULL;

I would initialize p_opp to ERR_PTR(-ENODEV) to avoid using
IS_ERR_OR_NULL. There is no need to initialize opp as well.

>  	int i, count, ret = 0;
>  
>  	/*
> @@ -56,13 +56,20 @@ static int devfreq_passive_get_target_freq(struct devfreq *devfreq,
>  	 * list of parent device. Because in this case, *freq is temporary
>  	 * value which is decided by ondemand governor.
>  	 */
> -	opp = devfreq_recommended_opp(parent_devfreq->dev.parent, freq, 0);
> -	if (IS_ERR(opp)) {
> -		ret = PTR_ERR(opp);
> +	p_opp = devfreq_recommended_opp(parent_devfreq->dev.parent, freq, 0);
> +	if (IS_ERR(p_opp)) {
> +		ret = PTR_ERR(p_opp);
>  		goto out;

Perhaps just return from here, the goto is useless here.

>  	}
>  
> -	dev_pm_opp_put(opp);
> +	if (devfreq->opp_table && parent_devfreq->opp_table)
> +		opp = dev_pm_opp_xlate_required_opp(parent_devfreq->opp_table,
> +						    devfreq->opp_table, p_opp);
> +	if (opp) {

This needs to be part of the above if block itself, else the opp will
always be NULL, isn't it ?

> +		*freq = dev_pm_opp_get_freq(opp);
> +		dev_pm_opp_put(opp);
> +		goto out;
> +	}
>  
>  	/*
>  	 * Get the OPP table's index of decided freqeuncy by governor
> @@ -89,6 +96,9 @@ static int devfreq_passive_get_target_freq(struct devfreq *devfreq,
>  	*freq = child_freq;
>  
>  out:
> +	if (!IS_ERR_OR_NULL(opp))

you should be checking for p_opp here, isn't it ? And perhaps we don't
need this check as well as p_opp can't be invalid here.

> +		dev_pm_opp_put(p_opp);
> +
>  	return ret;
>  }
>  
> -- 
> 2.30.0.365.g02bc693789-goog

-- 
viresh
