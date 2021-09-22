Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33546414353
	for <lists+linux-pm@lfdr.de>; Wed, 22 Sep 2021 10:11:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233699AbhIVINY (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 22 Sep 2021 04:13:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233383AbhIVINX (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 22 Sep 2021 04:13:23 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BC12C061574;
        Wed, 22 Sep 2021 01:11:54 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id h3so1855747pgb.7;
        Wed, 22 Sep 2021 01:11:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Hl+l5LFSpIDeQUEySt0GHF3c1F9KFKOw7mjaQzOrdXI=;
        b=I1YF2aKIleMUXgQ9iHtUTpphruTuxaIDUcAZ0pHyK4YspkVeMSCRDsibG1yWpRuAiS
         9/6bFmDD8RfSGPPjNiYGXaC8iKGZTPYIW2MutyJdJ8zQhJ0AakfYvheE4J5ZwJnjkC5S
         rPQW+W8yGkGVOxrf6DAzksnHx2dtA+dsRM5HG/jvMGTXV4LKFOy+XMKiEsUSVyCKO7Ak
         6sRU8pEeFPgDTf4cywnnZj23T4yrSgY5X+1F2+uolWawvpvTdJWH9kYqKg6gAEemJ+yL
         zUGV2l1cOs62MMZG/1PZS3gL2TxtChlPlvTPShq8+kNgJRV9NZ+QTvIEnH23CkUHfepO
         de1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Hl+l5LFSpIDeQUEySt0GHF3c1F9KFKOw7mjaQzOrdXI=;
        b=0AFOD9LJNVYCpudcuQoN7ocJecDZ5R0FYq6E/id2ZVwOIPK/FSI7k2XHH+vlVhgsXZ
         EyvLeXf6ukemmGUw1ldqgC8PMBAXIsDttQmUt5bDTb/mp0CHF9L3ZAYiwXPaEi1oYJHE
         6bTze80mAJttYnjlTRqzX2tDEnb3mOTYGhncXJiXyKoBmon3fiXAUt7nzHrvOw9DJ3hj
         l4xetsfmcrpKGvoGnLlL3QbUHn76IABy+AhIWVp5GQ/MFXKYv+UPpoY22KgovOYn2kmo
         TFcegPCmQfn1qinkepNLI/ReVKrViqkjy95o0ZdgKvZcuoUiY3xSQuzYAjFSpl57svje
         uJ7Q==
X-Gm-Message-State: AOAM533hOE3qqGbESE/951uylNGSNb4dTpy+awERUtDPg50fjWSnAo6F
        ANnHSDE0NZl41eO++6ft7AGTn9kXBHs=
X-Google-Smtp-Source: ABdhPJySdvkwKodKuedOd9YnaeTKwiWEaTtE8BOdl3CGeD88OFl53NdTvbqCHmMgygrX+cJ3jUA4Ug==
X-Received: by 2002:a62:5803:0:b0:447:d62d:161a with SMTP id m3-20020a625803000000b00447d62d161amr10300663pfb.85.1632298313379;
        Wed, 22 Sep 2021 01:11:53 -0700 (PDT)
Received: from [172.30.1.2] ([14.32.163.5])
        by smtp.gmail.com with ESMTPSA id j9sm4785067pjb.33.2021.09.22.01.11.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Sep 2021 01:11:52 -0700 (PDT)
Subject: Re: [PATCH v2 3/4] PM / devfreq: tegra30: Use resource-managed
 helpers
To:     Dmitry Osipenko <digetx@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>
Cc:     linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
References: <20210920172249.28206-1-digetx@gmail.com>
 <20210920172249.28206-4-digetx@gmail.com>
From:   Chanwoo Choi <cwchoi00@gmail.com>
Message-ID: <6acf32f7-99d2-af23-758d-14d503cfdc61@gmail.com>
Date:   Wed, 22 Sep 2021 17:11:50 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210920172249.28206-4-digetx@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 21. 9. 21. 오전 2:22, Dmitry Osipenko wrote:
> Use resource-managed API helpers to simplify driver's probe() function,
> making code cleaner.
> 
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>   drivers/devfreq/tegra30-devfreq.c | 107 +++++++++++++-----------------
>   1 file changed, 46 insertions(+), 61 deletions(-)
> 
> diff --git a/drivers/devfreq/tegra30-devfreq.c b/drivers/devfreq/tegra30-devfreq.c
> index 10661eb2aed8..d83fdc2713ed 100644
> --- a/drivers/devfreq/tegra30-devfreq.c
> +++ b/drivers/devfreq/tegra30-devfreq.c
> @@ -178,7 +178,6 @@ struct tegra_devfreq_soc_data {
>   
>   struct tegra_devfreq {
>   	struct devfreq		*devfreq;
> -	struct opp_table	*opp_table;
>   
>   	struct reset_control	*reset;
>   	struct clk		*clock;
> @@ -789,6 +788,39 @@ static struct devfreq_governor tegra_devfreq_governor = {
>   	.event_handler = tegra_governor_event_handler,
>   };
>   
> +static void devm_tegra_devfreq_deinit_hw(void *data)
> +{
> +	struct tegra_devfreq *tegra = data;
> +
> +	reset_control_reset(tegra->reset);
> +	clk_disable_unprepare(tegra->clock);
> +}
> +
> +static int devm_tegra_devfreq_init_hw(struct device *dev,
> +				      struct tegra_devfreq *tegra)
> +{
> +	int err;
> +
> +	err = clk_prepare_enable(tegra->clock);
> +	if (err) {
> +		dev_err(dev, "Failed to prepare and enable ACTMON clock\n");
> +		return err;
> +	}
> +
> +	err = devm_add_action_or_reset(dev, devm_tegra_devfreq_deinit_hw,
> +				       tegra);
> +	if (err)
> +		return err;
> +
> +	err = reset_control_reset(tegra->reset);
> +	if (err) {
> +		dev_err(dev, "Failed to reset hardware: %d\n", err);
> +		return err;
> +	}
> +
> +	return err;
> +}
> +
>   static int tegra_devfreq_probe(struct platform_device *pdev)
>   {
>   	u32 hw_version = BIT(tegra_sku_info.soc_speedo_id);
> @@ -842,38 +874,26 @@ static int tegra_devfreq_probe(struct platform_device *pdev)
>   		return err;
>   	}
>   
> -	tegra->opp_table = dev_pm_opp_set_supported_hw(&pdev->dev,
> -						       &hw_version, 1);
> -	err = PTR_ERR_OR_ZERO(tegra->opp_table);
> +	err = devm_pm_opp_set_supported_hw(&pdev->dev, &hw_version, 1);
>   	if (err) {
>   		dev_err(&pdev->dev, "Failed to set supported HW: %d\n", err);
>   		return err;
>   	}
>   
> -	err = dev_pm_opp_of_add_table_noclk(&pdev->dev, 0);
> +	err = devm_pm_opp_of_add_table_noclk(&pdev->dev, 0);
>   	if (err) {
>   		dev_err(&pdev->dev, "Failed to add OPP table: %d\n", err);
> -		goto put_hw;
> -	}
> -
> -	err = clk_prepare_enable(tegra->clock);
> -	if (err) {
> -		dev_err(&pdev->dev,
> -			"Failed to prepare and enable ACTMON clock\n");
> -		goto remove_table;
> +		return err;
>   	}
>   
> -	err = reset_control_reset(tegra->reset);
> -	if (err) {
> -		dev_err(&pdev->dev, "Failed to reset hardware: %d\n", err);
> -		goto disable_clk;
> -	}
> +	err = devm_tegra_devfreq_init_hw(&pdev->dev, tegra);
> +	if (err)
> +		return err;
>   
>   	rate = clk_round_rate(tegra->emc_clock, ULONG_MAX);
>   	if (rate < 0) {
>   		dev_err(&pdev->dev, "Failed to round clock rate: %ld\n", rate);
> -		err = rate;
> -		goto disable_clk;
> +		return rate;
>   	}
>   
>   	tegra->max_freq = rate / KHZ;
> @@ -892,52 +912,18 @@ static int tegra_devfreq_probe(struct platform_device *pdev)
>   	INIT_DELAYED_WORK(&tegra->cpufreq_update_work,
>   			  tegra_actmon_delayed_update);
>   
> -	err = devfreq_add_governor(&tegra_devfreq_governor);
> +	err = devm_devfreq_add_governor(&pdev->dev, &tegra_devfreq_governor);
>   	if (err) {
>   		dev_err(&pdev->dev, "Failed to add governor: %d\n", err);
> -		goto remove_opps;
> +		return err;
>   	}
>   
>   	tegra_devfreq_profile.initial_freq = clk_get_rate(tegra->emc_clock);
>   
> -	devfreq = devfreq_add_device(&pdev->dev, &tegra_devfreq_profile,
> -				     "tegra_actmon", NULL);
> -	if (IS_ERR(devfreq)) {
> -		err = PTR_ERR(devfreq);
> -		goto remove_governor;
> -	}
> -
> -	return 0;
> -
> -remove_governor:
> -	devfreq_remove_governor(&tegra_devfreq_governor);
> -
> -remove_opps:
> -	dev_pm_opp_remove_all_dynamic(&pdev->dev);
> -
> -	reset_control_reset(tegra->reset);
> -disable_clk:
> -	clk_disable_unprepare(tegra->clock);
> -remove_table:
> -	dev_pm_opp_of_remove_table(&pdev->dev);
> -put_hw:
> -	dev_pm_opp_put_supported_hw(tegra->opp_table);
> -
> -	return err;
> -}
> -
> -static int tegra_devfreq_remove(struct platform_device *pdev)
> -{
> -	struct tegra_devfreq *tegra = platform_get_drvdata(pdev);
> -
> -	devfreq_remove_device(tegra->devfreq);
> -	devfreq_remove_governor(&tegra_devfreq_governor);
> -
> -	reset_control_reset(tegra->reset);
> -	clk_disable_unprepare(tegra->clock);
> -
> -	dev_pm_opp_of_remove_table(&pdev->dev);
> -	dev_pm_opp_put_supported_hw(tegra->opp_table);
> +	devfreq = devm_devfreq_add_device(&pdev->dev, &tegra_devfreq_profile,
> +					  "tegra_actmon", NULL);
> +	if (IS_ERR(devfreq))
> +		return PTR_ERR(devfreq);
>   
>   	return 0;
>   }
> @@ -967,7 +953,6 @@ MODULE_DEVICE_TABLE(of, tegra_devfreq_of_match);
>   
>   static struct platform_driver tegra_devfreq_driver = {
>   	.probe	= tegra_devfreq_probe,
> -	.remove	= tegra_devfreq_remove,
>   	.driver = {
>   		.name = "tegra-devfreq",
>   		.of_match_table = tegra_devfreq_of_match,
> 

It is more readable than before. Thanks.

Acked-by: Chanwoo Choi <cw00.choi@samsung.com>

-- 
Best Regards,
Samsung Electronics
Chanwoo Choi
