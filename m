Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 695A52F9DDA
	for <lists+linux-pm@lfdr.de>; Mon, 18 Jan 2021 12:19:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389909AbhARLRv (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 18 Jan 2021 06:17:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389659AbhARLPR (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 18 Jan 2021 06:15:17 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A917BC061573
        for <linux-pm@vger.kernel.org>; Mon, 18 Jan 2021 03:14:36 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id t6so8486678plq.1
        for <linux-pm@vger.kernel.org>; Mon, 18 Jan 2021 03:14:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=f3ptHcRddHo09JrwqOLmYiudCQiAUluKch7z8eba8is=;
        b=wkPXHPlId40HzO8PZUMzx9aTccRVG2EL/1dSDB7zwRCHCpq9qqVzzeRzhtgjNpNqo5
         DZcuN7C8k/tMeYfV6jqWNbqc9mU2Jk+S2kdMxxyKuOeKLHKM6EoSs4YFFAxcytPYgbg7
         u8m8XcB6WHO1MXjC9wtuVpfuMQD3DFQdXGVnH/8CgVkeFgLxCLZG2CCwKzAuHsWF6A1A
         Xg60cL7VbyXm4RkiE+jqb/c4UYpAkwzPGRYUEgkIOXmA6G+G1bwGqLBqKm8zGAbk2Z6H
         Pq9wZM/Nng4J1etd9aiUPsPhkRNkTjx72PeDBDcBc/hHAOypMNLJiuxofrqc2Dl635el
         lC7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=f3ptHcRddHo09JrwqOLmYiudCQiAUluKch7z8eba8is=;
        b=edWIY2bAi5lfkHWuyU8epB5mJXJoCotyvnbidFS+P/65DikzsPtB+o0BmFlT2kaLPd
         d6Lvcq11Z0RcV9JFkOlEUnqcKzcrayFgmNQVhDDcPlXm0Ll0ZYmOwPti+aEbGy7s71Dy
         wO63Lfd4q4At9qTJ/5Ed62wa/xEaP14/GNzqzLfZSRRQp4PBxIZfTVOg3UwfDAkUcgb/
         xwIhAkAE+ymt3FIeSHmsjfqEuKIup0iTeKwr4tvanKEVfPSw6dCmEdVV89XS6jPwnTyE
         Ma/b2ZqZkXF491LrTB+Mm0T/SqpE9ZdFxLWYxDkd5J2BIjuAfINeI0SE+1LgxJPg6eC2
         e/GQ==
X-Gm-Message-State: AOAM533J53l+2q0O7ADQtA0aD1XQyTVXcuYcumbmWSBaDxbpr8tCuBdK
        a2XAVNQyHw89R/3Poe3a0xf9Ye5YoH8WBg==
X-Google-Smtp-Source: ABdhPJy9rOVxWu9qXQj/5gpR2cxezh7bnttUrCNX41iIej7vmVNd5QEsZpouZRMc8eHDr1/m6VIvpw==
X-Received: by 2002:a17:90a:4403:: with SMTP id s3mr17503732pjg.216.1610968476162;
        Mon, 18 Jan 2021 03:14:36 -0800 (PST)
Received: from localhost ([122.172.59.240])
        by smtp.gmail.com with ESMTPSA id k25sm15357509pfi.10.2021.01.18.03.14.27
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Jan 2021 03:14:36 -0800 (PST)
Date:   Mon, 18 Jan 2021 16:44:26 +0530
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
Subject: Re: [PATCH v3 09/12] opp: Add devm_pm_opp_attach_genpd
Message-ID: <20210118111426.3nahqv3pjklhxa2t@vireshk-i7>
References: <20210118005524.27787-1-digetx@gmail.com>
 <20210118005524.27787-10-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210118005524.27787-10-digetx@gmail.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 18-01-21, 03:55, Dmitry Osipenko wrote:
> Add resource-managed version of dev_pm_opp_attach_genpd().
> 
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  drivers/opp/core.c     | 35 +++++++++++++++++++++++++++++++++++
>  include/linux/pm_opp.h |  8 ++++++++
>  2 files changed, 43 insertions(+)
> 
> diff --git a/drivers/opp/core.c b/drivers/opp/core.c
> index 8e0d2193fd5f..49419ab9fbb4 100644
> --- a/drivers/opp/core.c
> +++ b/drivers/opp/core.c
> @@ -2891,3 +2891,38 @@ devm_pm_opp_register_set_opp_helper(struct device *dev,
>  	return opp_table;
>  }
>  EXPORT_SYMBOL_GPL(devm_pm_opp_register_set_opp_helper);
> +
> +static void devm_pm_opp_detach_genpd(void *data)
> +{
> +	dev_pm_opp_detach_genpd(data);
> +}
> +
> +/**
> + * devm_pm_opp_attach_genpd - Attach genpd(s) for the device and save virtual device pointer
> + * @dev: Consumer device for which the genpd is getting attached.
> + * @names: Null terminated array of pointers containing names of genpd to attach.
> + * @virt_devs: Pointer to return the array of virtual devices.
> + *
> + * This is a resource-managed version of dev_pm_opp_attach_genpd().
> + *
> + * Return: pointer to 'struct opp_table' on success and errorno otherwise.
> + */
> +struct opp_table *
> +devm_pm_opp_attach_genpd(struct device *dev, const char **names,
> +			 struct device ***virt_devs)
> +{
> +	struct opp_table *opp_table;
> +	int err;
> +
> +	opp_table = dev_pm_opp_attach_genpd(dev, names, virt_devs);
> +	if (IS_ERR(opp_table))
> +		return opp_table;
> +
> +	err = devm_add_action_or_reset(dev, devm_pm_opp_detach_genpd,
> +				       opp_table);
> +	if (err)
> +		return ERR_PTR(err);
> +
> +	return opp_table;
> +}
> +EXPORT_SYMBOL_GPL(devm_pm_opp_attach_genpd);
> diff --git a/include/linux/pm_opp.h b/include/linux/pm_opp.h
> index 6de5853aaada..eefd0b15890c 100644
> --- a/include/linux/pm_opp.h
> +++ b/include/linux/pm_opp.h
> @@ -170,6 +170,7 @@ void dev_pm_opp_cpumask_remove_table(const struct cpumask *cpumask);
>  int dev_pm_opp_sync_regulators(struct device *dev);
>  int dev_pm_opp_set_voltage(struct device *dev, struct dev_pm_opp *opp);
>  struct opp_table *devm_pm_opp_register_set_opp_helper(struct device *dev, int (*set_opp)(struct dev_pm_set_opp_data *data));
> +struct opp_table *devm_pm_opp_attach_genpd(struct device *dev, const char **names, struct device ***virt_devs);
>  #else
>  static inline struct opp_table *dev_pm_opp_get_opp_table(struct device *dev)
>  {
> @@ -436,6 +437,13 @@ devm_pm_opp_register_set_opp_helper(struct device *dev,
>  	return ERR_PTR(-ENOTSUPP);
>  }
>  
> +static inline struct opp_table *
> +devm_pm_opp_attach_genpd(struct device *dev, const char **names,
> +			 struct device ***virt_devs)
> +{
> +	return ERR_PTR(-ENOTSUPP);
> +}
> +
>  #endif		/* CONFIG_PM_OPP */
>  
>  #if defined(CONFIG_PM_OPP) && defined(CONFIG_OF)

Manually applied. Thanks.

-- 
viresh
