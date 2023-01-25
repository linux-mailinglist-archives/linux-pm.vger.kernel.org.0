Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0B2C67A96F
	for <lists+linux-pm@lfdr.de>; Wed, 25 Jan 2023 04:56:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230160AbjAYD4t (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 24 Jan 2023 22:56:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230009AbjAYD4s (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 24 Jan 2023 22:56:48 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFC5715C90
        for <linux-pm@vger.kernel.org>; Tue, 24 Jan 2023 19:56:43 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id v23so16766959plo.1
        for <linux-pm@vger.kernel.org>; Tue, 24 Jan 2023 19:56:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OrsIoezfJrUg2zQGISzctLe0/lXbaW63fLUx0i183RI=;
        b=OMtGPHzpqEWPop6RWXnOqWem0mFRTowxFRKKhkYUI+yOLwa9jkpnuRbuQc7+LnFYCS
         5Q4OexuhHiA0FTa/LsFvz2dscNq9sTui4rya4tlXnwT/WrAdDZNB2uzhunfh0sDtXHUh
         sZWQb9lnX56BakBbLY8sQJT778oX4xWAVsF/L/9+UperZ+frhk+/j3pZTxPxs3FDKmS7
         /jKzn2HLB/y/5Ca9P6/WyWlOH9LMvtfq9rWaRfvVFVVl84Pj9nNROHXkE7D92YrENqgs
         No9ZK9+/HWKI9adVsA4jKYmcHRyjcYZkF7ZzFLHFr1NeELWMY0MxxGBHn6KFVGbAJ22C
         OOTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OrsIoezfJrUg2zQGISzctLe0/lXbaW63fLUx0i183RI=;
        b=lGUCC481npzLuzFkSqoIEvG7KdKNJxFV036JnzTNwJzbLCxeGcyTDF/ZvdaOA3dHxM
         qjoVKXH+eNpZmjFz7Z+DNxrzNzDgINqn/ts9yI/dbMVNyfWY4AW/PLwa136wQFNB5201
         G6SqLaDjcjEk+gNn4kREZwBi8y6LXMRWajs1Oq2ZaNLbxL8fYkEZNosXcetm5lCNIta2
         mM8H6nwcttyOCHXG7eO248dZ7A9k/Tff93zv96s/y8a3ZrXJH+qpagZr77onLVVmUuQi
         7G9kD7xAbSU4AjjN7id1OoB1gTAJVTdMlLaLOxuZYqUMyZpw0ds31uiAEB+AZ2ht80C/
         w+PA==
X-Gm-Message-State: AFqh2kr7pmyBA1Mg9/IHanI5J1hWypRoisyAad9GHz1rBOVySbC/MJBl
        nRKIl/0je/4eM2MfUQJtVNkaucjWFHkjwwBf
X-Google-Smtp-Source: AMrXdXvtRQs19nN8nmIUV7F6R2AbPFDGeA82fPqiMJ3U7qn4L9G8wT2CkSaQzc6Whs0Gcn2VV/VVwg==
X-Received: by 2002:a05:6a20:d68c:b0:b5:fdf8:6130 with SMTP id it12-20020a056a20d68c00b000b5fdf86130mr35048804pzb.28.1674619003264;
        Tue, 24 Jan 2023 19:56:43 -0800 (PST)
Received: from localhost ([122.172.83.155])
        by smtp.gmail.com with ESMTPSA id z9-20020a656109000000b004c13dddf521sm2151150pgu.30.2023.01.24.19.56.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jan 2023 19:56:42 -0800 (PST)
Date:   Wed, 25 Jan 2023 09:26:40 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Jon Hunter <jonathanh@nvidia.com>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        Yi-Wei Wang <yiweiw@nvidia.com>
Subject: Re: [PATCH] cpufreq: tegra194: Enable CPUFREQ thermal cooling
Message-ID: <20230125035640.yyppfo5zcdv6bqj2@vireshk-i7>
References: <20230124115323.21910-1-jonathanh@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230124115323.21910-1-jonathanh@nvidia.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 24-01-23, 11:53, Jon Hunter wrote:
> From: Yi-Wei Wang <yiweiw@nvidia.com>
> 
> Populate the flag CPUFREQ_IS_COOLING_DEV for the Tegra194 CPUFREQ driver
> to register it as a cooling device. This enables CPU frequency
> throttling for CPUs when the passive trip points are crossed.
> 
> Signed-off-by: Yi-Wei Wang <yiweiw@nvidia.com>
> Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
> ---
>  drivers/cpufreq/tegra194-cpufreq.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/cpufreq/tegra194-cpufreq.c b/drivers/cpufreq/tegra194-cpufreq.c
> index 4596c3e323aa..5890e25d7f77 100644
> --- a/drivers/cpufreq/tegra194-cpufreq.c
> +++ b/drivers/cpufreq/tegra194-cpufreq.c
> @@ -411,7 +411,8 @@ static int tegra194_cpufreq_set_target(struct cpufreq_policy *policy,
>  
>  static struct cpufreq_driver tegra194_cpufreq_driver = {
>  	.name = "tegra194",
> -	.flags = CPUFREQ_CONST_LOOPS | CPUFREQ_NEED_INITIAL_FREQ_CHECK,
> +	.flags = CPUFREQ_CONST_LOOPS | CPUFREQ_NEED_INITIAL_FREQ_CHECK |
> +		 CPUFREQ_IS_COOLING_DEV,
>  	.verify = cpufreq_generic_frequency_table_verify,
>  	.target_index = tegra194_cpufreq_set_target,
>  	.get = tegra194_get_speed,

Applied. Thanks.

-- 
viresh
