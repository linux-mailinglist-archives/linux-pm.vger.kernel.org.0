Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29ADC2F9D9E
	for <lists+linux-pm@lfdr.de>; Mon, 18 Jan 2021 12:09:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389630AbhARLIo (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 18 Jan 2021 06:08:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389554AbhARLId (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 18 Jan 2021 06:08:33 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B068FC0613D3
        for <linux-pm@vger.kernel.org>; Mon, 18 Jan 2021 03:07:13 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id be12so8469069plb.4
        for <linux-pm@vger.kernel.org>; Mon, 18 Jan 2021 03:07:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=feZ3uWkB45G3qkYHMMjyOtNUBHLqccPp2pLPUm8pRu4=;
        b=mf7Kssn8S1yHDw/w76N+87+PuNxRCtuQ4Q7V26JolTVWkTJqTVssqj5A0/ZYmV7hi6
         oYuIePahHHVAVzyA2+166KrT6Pdk5tpow750hu8lZZC4VT2Q47/uW20VRlIzfX+hjv5I
         JTkmnU9VF56N2+WGikQJZz3LkSlECSbEayo2tZIkyLXwV80N9bNcK/k+Dm0cGqPyp6eQ
         NvsT8FwbhcbntiQwPd0MN2YQ5W4oyvacO7T/AjSdKFKUcXFoshWjvZ5Yjy6tdPiPZXok
         acFyyB1AjREkIgK64CGKxrEb8kCmaljUQEI64KC9uJuztdEP1INUYG3KvWA8XhcPX9MF
         ejng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=feZ3uWkB45G3qkYHMMjyOtNUBHLqccPp2pLPUm8pRu4=;
        b=YAxutvtfbSapWSK7nwg1fu4Zxm4TZ2GLiAxe7p35brVX84gRxON0mivdNxv2SJPL9a
         pw7yaQDZjYNyHrUrNKwrpYOAgdeKchwzvfyqJNsabJSN8G4SgN0FjKKMSbwzspV1x1VC
         zcyFQH72pLBHczAOFl4d/Tz8yrkPGHnHU6/Ns49pXEh6KXf+D2avdHLK7sE3knIafyBa
         N6nT81Z6VpzLUApnesr8FnNtcX4qHrEG1zVescHDrCgjLLYKI3LYskuaSiu+7B+NMQK4
         0AMUT9k1x3BKHPQrAaXmHeEX/kTktlkvXpXIpeqejowhXmrp5tnlZB0IL5sIKxFFp4mR
         1CCQ==
X-Gm-Message-State: AOAM5328Dgloukh6Ni5btV9/mNucy2CDLHa3DMOZPZnRthuHzRYHs/Ay
        Hmvptn8pNj9sWgPQVoWJ/3bMOg==
X-Google-Smtp-Source: ABdhPJxHeOFm6YMK83rgDcn0XX+UetzTWiWwZhJq25SgCZO1Pf4dGh7auwwWXMr4/ThdAxMZxCPIfQ==
X-Received: by 2002:a17:902:a512:b029:db:cf4c:336b with SMTP id s18-20020a170902a512b02900dbcf4c336bmr26211199plq.17.1610968033238;
        Mon, 18 Jan 2021 03:07:13 -0800 (PST)
Received: from localhost ([122.172.59.240])
        by smtp.gmail.com with ESMTPSA id 67sm3508157pfv.20.2021.01.18.03.07.12
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Jan 2021 03:07:12 -0800 (PST)
Date:   Mon, 18 Jan 2021 16:37:10 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Peter Geis <pgwipeout@gmail.com>,
        Nicolas Chauvet <kwizart@gmail.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Viresh Kumar <vireshk@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>, Nishanth Menon <nm@ti.com>,
        Yangtao Li <tiny.windzz@gmail.com>,
        Matt Merhar <mattmerhar@protonmail.com>,
        linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH v3 08/12] opp: Add devm_pm_opp_register_set_opp_helper
Message-ID: <20210118110710.q55fa44cle5fuhfk@vireshk-i7>
References: <20210118005524.27787-1-digetx@gmail.com>
 <20210118005524.27787-9-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210118005524.27787-9-digetx@gmail.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 18-01-21, 03:55, Dmitry Osipenko wrote:
> Add resource-managed version of dev_pm_opp_register_set_opp_helper().
> 
> Tested-by: Peter Geis <pgwipeout@gmail.com>
> Tested-by: Nicolas Chauvet <kwizart@gmail.com>
> Tested-by: Matt Merhar <mattmerhar@protonmail.com>
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  drivers/opp/core.c     | 34 ++++++++++++++++++++++++++++++++++
>  include/linux/pm_opp.h |  8 ++++++++
>  2 files changed, 42 insertions(+)
> 
> diff --git a/drivers/opp/core.c b/drivers/opp/core.c
> index fde2ec00ab0e..8e0d2193fd5f 100644
> --- a/drivers/opp/core.c
> +++ b/drivers/opp/core.c
> @@ -2857,3 +2857,37 @@ int dev_pm_opp_set_voltage(struct device *dev, struct dev_pm_opp *opp)
>  	return ret;
>  }
>  EXPORT_SYMBOL_GPL(dev_pm_opp_set_voltage);
> +
> +static void devm_pm_opp_unregister_set_opp_helper(void *data)
> +{
> +	dev_pm_opp_unregister_set_opp_helper(data);
> +}
> +
> +/**
> + * devm_pm_opp_register_set_opp_helper() - Register custom set OPP helper
> + * @dev: Device for which the helper is getting registered.
> + * @set_opp: Custom set OPP helper.
> + *
> + * This is a resource-managed version of dev_pm_opp_register_set_opp_helper().
> + *
> + * Return: pointer to 'struct opp_table' on success and errorno otherwise.
> + */
> +struct opp_table *
> +devm_pm_opp_register_set_opp_helper(struct device *dev,
> +				    int (*set_opp)(struct dev_pm_set_opp_data *data))
> +{
> +	struct opp_table *opp_table;
> +	int err;
> +
> +	opp_table = dev_pm_opp_register_set_opp_helper(dev, set_opp);
> +	if (IS_ERR(opp_table))
> +		return opp_table;
> +
> +	err = devm_add_action_or_reset(dev, devm_pm_opp_unregister_set_opp_helper,
> +				       opp_table);
> +	if (err)
> +		return ERR_PTR(err);
> +
> +	return opp_table;
> +}
> +EXPORT_SYMBOL_GPL(devm_pm_opp_register_set_opp_helper);
> diff --git a/include/linux/pm_opp.h b/include/linux/pm_opp.h
> index e072148ae0e1..6de5853aaada 100644
> --- a/include/linux/pm_opp.h
> +++ b/include/linux/pm_opp.h
> @@ -169,6 +169,7 @@ void dev_pm_opp_remove_table(struct device *dev);
>  void dev_pm_opp_cpumask_remove_table(const struct cpumask *cpumask);
>  int dev_pm_opp_sync_regulators(struct device *dev);
>  int dev_pm_opp_set_voltage(struct device *dev, struct dev_pm_opp *opp);
> +struct opp_table *devm_pm_opp_register_set_opp_helper(struct device *dev, int (*set_opp)(struct dev_pm_set_opp_data *data));
>  #else
>  static inline struct opp_table *dev_pm_opp_get_opp_table(struct device *dev)
>  {
> @@ -428,6 +429,13 @@ static inline int dev_pm_opp_set_voltage(struct device *dev, struct dev_pm_opp *
>  	return -ENOTSUPP;
>  }
>  
> +static inline struct opp_table *
> +devm_pm_opp_register_set_opp_helper(struct device *dev,
> +				    int (*set_opp)(struct dev_pm_set_opp_data *data))
> +{
> +	return ERR_PTR(-ENOTSUPP);
> +}
> +
>  #endif		/* CONFIG_PM_OPP */
>  
>  #if defined(CONFIG_PM_OPP) && defined(CONFIG_OF)

Applied. Thanks.

I had to apply it manually, please make sure it works fine.

-- 
viresh
