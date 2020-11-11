Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACBE32AEC53
	for <lists+linux-pm@lfdr.de>; Wed, 11 Nov 2020 09:51:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726091AbgKKIvW (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 11 Nov 2020 03:51:22 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:39571 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725859AbgKKIvU (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 11 Nov 2020 03:51:20 -0500
Received: by mail-ed1-f66.google.com with SMTP id e18so1439470edy.6;
        Wed, 11 Nov 2020 00:51:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=fcsUtbmIi6pFoAIg04QDTS8zIxpoVv9zR1KLLhX/rbU=;
        b=DWnx559xWzavUW3mDHZY7RMcpsXEQEFYw9Zrl56yOVM/WyYeGHsVM14CJWmKcP6ATi
         IUZNB/IJL+WLT/NwtNEu2HF8+hbetKsxV2xZXFqGzRsOGOFkJo9FsJfOyQUlfOHSGjp+
         qxsjjV8jIKRTC9/jkF+a8pbVAw/Zp/AOJ6NT//pQDW2Czz9TNi5gDaqK+rUbbLk3UOVU
         Bb+xA1K6JiJ5mTI2R3R+JOkuZJcvHutEHMCw/6QVo50PZVnuGakU/22k2a+VmXqYIVSH
         pTAmqB+sGVlSobzpk3itpc/+XJI4WYBC/QD3RHyVqMB2sUEu6kyYH7PzLzLb94Sc8bym
         6jog==
X-Gm-Message-State: AOAM533Alu/v958Pxh5TLVAxLfmSuUOCbzOXTZK+JgO78+FmlTNUU/XV
        FoHTUxrPW4VB9X0PQCxj/miLw+wD0rE=
X-Google-Smtp-Source: ABdhPJyosmQwjhLlFhsYwZ0U8CJ9JICx9URz6T+qKYOPqiXzdUHJVKdbracph63JeRVetfKsp0cT0g==
X-Received: by 2002:a05:6402:17ad:: with SMTP id j13mr3701504edy.347.1605084678122;
        Wed, 11 Nov 2020 00:51:18 -0800 (PST)
Received: from kozik-lap (adsl-84-226-167-205.adslplus.ch. [84.226.167.205])
        by smtp.googlemail.com with ESMTPSA id m27sm575741eji.64.2020.11.11.00.51.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2020 00:51:16 -0800 (PST)
Date:   Wed, 11 Nov 2020 09:51:15 +0100
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Mikko Perttunen <cyndis@kapsi.fi>,
        Viresh Kumar <vireshk@kernel.org>,
        Peter Geis <pgwipeout@gmail.com>,
        Nicolas Chauvet <kwizart@gmail.com>,
        linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v8 10/26] memory: tegra30-emc: Factor out clk
 initialization
Message-ID: <20201111085115.GA4050@kozik-lap>
References: <20201111011456.7875-1-digetx@gmail.com>
 <20201111011456.7875-11-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201111011456.7875-11-digetx@gmail.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Nov 11, 2020 at 04:14:40AM +0300, Dmitry Osipenko wrote:
> Factor out clk initialization and make it resource-managed. This makes
> easier to follow code and will help to make further changes cleaner.
> 
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  drivers/memory/tegra/tegra30-emc.c | 70 ++++++++++++++++++++----------
>  1 file changed, 47 insertions(+), 23 deletions(-)
> 
> diff --git a/drivers/memory/tegra/tegra30-emc.c b/drivers/memory/tegra/tegra30-emc.c
> index d27df842a667..1df42e212d73 100644
> --- a/drivers/memory/tegra/tegra30-emc.c
> +++ b/drivers/memory/tegra/tegra30-emc.c
> @@ -1550,6 +1550,49 @@ static int tegra_emc_opp_table_init(struct tegra_emc *emc)
>  	return err;
>  }
>  
> +static void devm_tegra_emc_unset_callback(void *data)
> +{
> +	tegra20_clk_set_emc_round_callback(NULL, NULL);
> +}
> +
> +static void devm_tegra_emc_unreg_clk_notifier(void *data)
> +{
> +	struct tegra_emc *emc = data;
> +
> +	clk_notifier_unregister(emc->clk, &emc->clk_nb);
> +}
> +
> +static int tegra_emc_init_clk(struct tegra_emc *emc)
> +{
> +	int err;
> +
> +	tegra20_clk_set_emc_round_callback(emc_round_rate, emc);
> +
> +	err = devm_add_action_or_reset(emc->dev, devm_tegra_emc_unset_callback,
> +				       NULL);
> +	if (err)
> +		return err;
> +
> +	emc->clk = devm_clk_get(emc->dev, NULL);
> +	if (IS_ERR(emc->clk)) {
> +		dev_err(emc->dev, "failed to get EMC clock: %pe\n", emc->clk);
> +		return PTR_ERR(emc->clk);
> +	}
> +
> +	err = clk_notifier_register(emc->clk, &emc->clk_nb);
> +	if (err) {
> +		dev_err(emc->dev, "failed to register clk notifier: %d\n", err);
> +		return err;
> +	}
> +
> +	err = devm_add_action_or_reset(emc->dev,
> +				       devm_tegra_emc_unreg_clk_notifier, emc);
> +	if (err)
> +		return err;
> +
> +	return 0;
> +}
> +
>  static int tegra_emc_probe(struct platform_device *pdev)
>  {
>  	struct device_node *np;
> @@ -1599,25 +1642,13 @@ static int tegra_emc_probe(struct platform_device *pdev)
>  		return err;
>  	}
>  
> -	tegra20_clk_set_emc_round_callback(emc_round_rate, emc);
> -
> -	emc->clk = devm_clk_get(&pdev->dev, "emc");
> -	if (IS_ERR(emc->clk)) {
> -		err = PTR_ERR(emc->clk);
> -		dev_err(&pdev->dev, "failed to get emc clock: %d\n", err);
> -		goto unset_cb;
> -	}
> -
> -	err = clk_notifier_register(emc->clk, &emc->clk_nb);
> -	if (err) {
> -		dev_err(&pdev->dev, "failed to register clk notifier: %d\n",
> -			err);
> -		goto unset_cb;
> -	}
> +	err = tegra_emc_init_clk(emc);
> +	if (err)
> +		return err;
>  
>  	err = tegra_emc_opp_table_init(emc);
>  	if (err)
> -		goto unreg_notifier;
> +		return err;
>  
>  	platform_set_drvdata(pdev, emc);
>  	tegra_emc_rate_requests_init(emc);
> @@ -1632,13 +1663,6 @@ static int tegra_emc_probe(struct platform_device *pdev)
>  	try_module_get(THIS_MODULE);
>  
>  	return 0;
> -
> -unreg_notifier:
> -	clk_notifier_unregister(emc->clk, &emc->clk_nb);

You added this code in patch #8, so adding-and-removing a piece of code
is a nice hint that this patch should be before. Don't add new code
which later you simplify. Move all bugfixes and all simplifications to
beginning of patchset.

That's quite similar case to v6 where you put bugfixes in the middle
of patchset.

Best regards,
Krzysztof
