Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1936654C521
	for <lists+linux-pm@lfdr.de>; Wed, 15 Jun 2022 11:52:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241711AbiFOJwl (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 15 Jun 2022 05:52:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243811AbiFOJwk (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 15 Jun 2022 05:52:40 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB2005F7F
        for <linux-pm@vger.kernel.org>; Wed, 15 Jun 2022 02:52:39 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id e11so10970969pfj.5
        for <linux-pm@vger.kernel.org>; Wed, 15 Jun 2022 02:52:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=58jiycaIoF5FYY78PZA6fUJClkpQXYZtisx8ZOZslzw=;
        b=j9QqM9A2kpjvfW8lU2O5uiEURw3T9QaeBU3v6ruA0LfZbo5F8VEBV3KxNi6cmJ2Kak
         E+Fx/FGSkoD16sgFhKuzC5c4U8A9SootUUObslbLjOZHWqISZLCQDY2S+5LLjMf7xYas
         H7/rOVGaL3XxYJ7SPDW/dGfCcawzszflPrfvRwrlM0zxi0xDsDorCo1fZfRzq2jEa6hw
         q08aJTmz76Cp0Sh197ZY3tUyGrouXw3XrRt90SwoHI+xCDbhA6GBl9vhN58gJZOFxehS
         iGthg40CYAj0QM0BZwM+NXmQs//1PJHA+ZC4X+fPqtF9A6t+OXbUKUFEJiHyUJuaXexr
         lEsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=58jiycaIoF5FYY78PZA6fUJClkpQXYZtisx8ZOZslzw=;
        b=JKBer4d4UFAA80oha8E8EaZoec85ysTlJA5nag1lq9/T3nKUsyvgFNM88i8OQqKd0d
         umV+XgN7SG+XVmmxJXsphZ0L0KoI4Mp282vlX2BLVEhpKjGP72XYJs2CbwN5e1CDlKI6
         g7pF2kCGU5i+AlkbIbgGBRV1Jh198x1KtTjw8yeJS7MLHRccGIn1vwBI3S+lYeZ/XNQq
         9jkWRynIU4SMb6XlLQq2ZxFbTb7/K1relBWzSmmPD4E/GCLgHZarlCqTyZIVIvwUe0mK
         Mxc7h6ikCQBoRDc2s/WafrRlhEPcY/ZEfnrM2iNq7f/MEOgv/06FALS5F+gX2nuekwlB
         tFGA==
X-Gm-Message-State: AOAM5333iM9+ssvqi0rHJsJvHhV2abF/9x3m+AKkzPqdNd79YtZsjD4+
        TfCYSzl6F6qq5ghaxZu7lc9o2Q==
X-Google-Smtp-Source: ABdhPJxpQGpTs3AoWtsya7eQ9ZbJElWmUTHca/dgBaqbWAO8WnldFcx0ersNOfHlGwJ6lA9GLlh2mg==
X-Received: by 2002:a05:6a00:842:b0:51b:f289:7354 with SMTP id q2-20020a056a00084200b0051bf2897354mr9178778pfk.75.1655286759193;
        Wed, 15 Jun 2022 02:52:39 -0700 (PDT)
Received: from localhost ([122.162.234.2])
        by smtp.gmail.com with ESMTPSA id z22-20020aa79496000000b0051bf9159d2dsm9310765pfk.208.2022.06.15.02.52.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jun 2022 02:52:38 -0700 (PDT)
Date:   Wed, 15 Jun 2022 15:22:37 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     heliang <windhl@126.com>
Cc:     rafael@kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drivers: cpufreq: Add missing of_node_put() in
 qoriq-cpufreq.c
Message-ID: <20220615095237.6eefqhab4p2bbftt@vireshk-i7>
References: <20220615094807.3962918-1-windhl@126.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220615094807.3962918-1-windhl@126.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 15-06-22, 17:48, heliang wrote:
> In qoriq_cpufreq_probe(), of_find_matching_node() will return a
> node pointer with refcount incremented. We should use of_node_put()
> when it is not used anymore.
> 
> Signed-off-by: heliang <windhl@126.com>
> ---
>  drivers/cpufreq/qoriq-cpufreq.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/cpufreq/qoriq-cpufreq.c b/drivers/cpufreq/qoriq-cpufreq.c
> index 6b6b20da2bcf..573b417e1483 100644
> --- a/drivers/cpufreq/qoriq-cpufreq.c
> +++ b/drivers/cpufreq/qoriq-cpufreq.c
> @@ -275,6 +275,7 @@ static int qoriq_cpufreq_probe(struct platform_device *pdev)
>  
>  	np = of_find_matching_node(NULL, qoriq_cpufreq_blacklist);
>  	if (np) {
> +		of_node_put(np);
>  		dev_info(&pdev->dev, "Disabling due to erratum A-008083");
>  		return -ENODEV;
>  	}

Applied with fixes tag. Thanks.

-- 
viresh
