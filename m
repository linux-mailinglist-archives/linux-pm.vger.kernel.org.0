Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E2CA3ECD8A
	for <lists+linux-pm@lfdr.de>; Mon, 16 Aug 2021 06:17:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229550AbhHPESC (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 16 Aug 2021 00:18:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbhHPER4 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 16 Aug 2021 00:17:56 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2D63C061764
        for <linux-pm@vger.kernel.org>; Sun, 15 Aug 2021 21:17:21 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id n13-20020a17090a4e0d00b0017946980d8dso11386264pjh.5
        for <linux-pm@vger.kernel.org>; Sun, 15 Aug 2021 21:17:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Hx4SkasqHslIrkDgnLhNdvAsspclML8ZdzK0kZt3bgQ=;
        b=nk3VDIgd23DD3SPeU1QaCI04yRwaNdCElwpLEL+QnPbgWztx6y+IenZkEqvYt3bbda
         KhYFqS5LjiT5U+z9otfnJob8ezly+O/p+5X9UoxseetHcn87sClcYhy3gakoCl3OmSPA
         81X5IJiuY+hNuvEHQrvKXUf99f5X4YSLvZQQIX6svQYBuf7CvML2DhdSLEK3i2DAaAL3
         hD+XzuaYLz70iOOHae45AcK+ZRRBUCNhikKPn909cn0RiGqp5rzXoQbvNyb+2290lyuu
         J3BJcYvxJnu5XS1VfUw1MjUm3Q7PDp1u7NnwmRyEvkFucJeA34p+NH2jASOnJIpUja/R
         g4cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Hx4SkasqHslIrkDgnLhNdvAsspclML8ZdzK0kZt3bgQ=;
        b=SXwo/HeHj23HFTYfpjk54veLkGP0uhTy0KkkWV2Ii3wFTPPAhEJb8DAuaGdEqmZLGY
         r+25fdT+d2+eHbPavusah+MJ4/G7dIvmtswuw42z0dN1a/ckW0lUqMTu8p4jc7dDyrZr
         CxVuU3Sisvby71kRRg9AzWy5IyWDeZGksNGJM21B1kGFqGvCrqvh2SaoYhFOiSAPJtqb
         DR40QgarjgriDHgmtM21jPmWMNWkCewCQ9GTmkL1oYlcSCHa9zgsn7zyhQReKshklzwW
         Ivb5Z/QgssHiwsbS044kF5hfNgImvCbDJhv1vcx8RQF0fIdavB/tPNKAVngZcvC0H1rB
         kduw==
X-Gm-Message-State: AOAM531oaiqp1nqXa25z21jI1Y8UiR5YN/1Dbb9mK9GFCH7yv1IsA8yV
        fuVJqh3WLGlPR7P2MKzZE6hrTQ==
X-Google-Smtp-Source: ABdhPJwSgSjgEUvvzoEEm5XqAAvnv82h9wIkZthBG0xOjXr2hpHl3GotbydTdxfNnQhSq8gAh8JHvg==
X-Received: by 2002:a65:6444:: with SMTP id s4mr5065185pgv.11.1629087441329;
        Sun, 15 Aug 2021 21:17:21 -0700 (PDT)
Received: from localhost ([122.172.201.85])
        by smtp.gmail.com with ESMTPSA id l126sm11484011pgl.14.2021.08.15.21.17.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Aug 2021 21:17:20 -0700 (PDT)
Date:   Mon, 16 Aug 2021 09:47:18 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Viresh Kumar <vireshk@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
        Nishanth Menon <nm@ti.com>, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH v1] opp: Drop empty-table checks from _put functions
Message-ID: <20210816041718.yguabfbebzgdf5ea@vireshk-i7>
References: <20210815164344.7796-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210815164344.7796-1-digetx@gmail.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 15-08-21, 19:43, Dmitry Osipenko wrote:
> The current_opp is released only when whole OPP table is released,
> otherwise it's only marked as removed by dev_pm_opp_remove_table().
> Functions like dev_pm_opp_put_clkname() and dev_pm_opp_put_supported_hw()
> are checking whether OPP table is empty and it's not if current_opp is
> set since it holds the refcount of OPP, this produces a noisy warning
> from these functions about busy OPP table. Remove the checks to fix it.
> 
> Cc: stable@vger.kernel.org
> Fixes: 81c4d8a3c414 ("opp: Keep track of currently programmed OPP")
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  drivers/opp/core.c | 15 ---------------
>  1 file changed, 15 deletions(-)
> 
> diff --git a/drivers/opp/core.c b/drivers/opp/core.c
> index b335c077f215..5543c54dacc5 100644
> --- a/drivers/opp/core.c
> +++ b/drivers/opp/core.c
> @@ -1856,9 +1856,6 @@ void dev_pm_opp_put_supported_hw(struct opp_table *opp_table)
>  	if (unlikely(!opp_table))
>  		return;
>  
> -	/* Make sure there are no concurrent readers while updating opp_table */
> -	WARN_ON(!list_empty(&opp_table->opp_list));
> -
>  	kfree(opp_table->supported_hw);
>  	opp_table->supported_hw = NULL;
>  	opp_table->supported_hw_count = 0;
> @@ -1944,9 +1941,6 @@ void dev_pm_opp_put_prop_name(struct opp_table *opp_table)
>  	if (unlikely(!opp_table))
>  		return;
>  
> -	/* Make sure there are no concurrent readers while updating opp_table */
> -	WARN_ON(!list_empty(&opp_table->opp_list));
> -
>  	kfree(opp_table->prop_name);
>  	opp_table->prop_name = NULL;
>  
> @@ -2056,9 +2050,6 @@ void dev_pm_opp_put_regulators(struct opp_table *opp_table)
>  	if (!opp_table->regulators)
>  		goto put_opp_table;
>  
> -	/* Make sure there are no concurrent readers while updating opp_table */
> -	WARN_ON(!list_empty(&opp_table->opp_list));
> -
>  	if (opp_table->enabled) {
>  		for (i = opp_table->regulator_count - 1; i >= 0; i--)
>  			regulator_disable(opp_table->regulators[i]);
> @@ -2178,9 +2169,6 @@ void dev_pm_opp_put_clkname(struct opp_table *opp_table)
>  	if (unlikely(!opp_table))
>  		return;
>  
> -	/* Make sure there are no concurrent readers while updating opp_table */
> -	WARN_ON(!list_empty(&opp_table->opp_list));
> -
>  	clk_put(opp_table->clk);
>  	opp_table->clk = ERR_PTR(-EINVAL);
>  
> @@ -2279,9 +2267,6 @@ void dev_pm_opp_unregister_set_opp_helper(struct opp_table *opp_table)
>  	if (unlikely(!opp_table))
>  		return;
>  
> -	/* Make sure there are no concurrent readers while updating opp_table */
> -	WARN_ON(!list_empty(&opp_table->opp_list));
> -
>  	opp_table->set_opp = NULL;
>  
>  	mutex_lock(&opp_table->lock);

Applied. Thanks.

-- 
viresh
