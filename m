Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8AD1F3FFA13
	for <lists+linux-pm@lfdr.de>; Fri,  3 Sep 2021 08:01:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236242AbhICGB7 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 3 Sep 2021 02:01:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233634AbhICGB7 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 3 Sep 2021 02:01:59 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F337C061760;
        Thu,  2 Sep 2021 23:00:59 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id i28so7877293ljm.7;
        Thu, 02 Sep 2021 23:00:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=SS3V2W7eXZoP72eB0dNOwnog6SXuQ/C6UHFp2+JfZGw=;
        b=R9dDX2T14oDoEKx683zCy++Xv/CAPNNlfzWgOaJhaFiOcwdCpmNxJ5SELcoEYEAiFy
         M9KKB4uXxOB2d7rrmmcTEWdfGN4Yu09YpEgg0YTMr1BTKrcmNoiFH91FoMpnLdz+z3li
         68V9RLI2aaJjRI015cLpYjuPpSRePCbs9Wbm9z7iO96yBukOUnv2jUCsjh21qIBhN5eL
         ucdgNuXFLM571qwPSTVw6TZDWAL1diXBnkqpMBQyNCkB1CQCDVlq449Y5zUiKlnRrrwd
         w0sfS5Cj+xNK/y4anrGdLy7Kkbp8BWb7l43eQrEfV8TdFCmIcVXZHXDyExuazqjdYBtl
         cwCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=SS3V2W7eXZoP72eB0dNOwnog6SXuQ/C6UHFp2+JfZGw=;
        b=RRb+2Z4W3yhOOPXRXjGqME9OCxeUAPio4FqFEzHtq9cyGKsW2dUMqRM+FBiqKikTQh
         DXWbZXytLfBrR+OeEIEC8//rF/7FU+D0tqhqxNGhaV7PohdtMoY+nDXX9M4aFp8TqWq+
         L5lFF7KkYVqfIPw7ENzHr2BlW7Mp7vJUjnqEAajphkzclaQN2f1Ug3QSnv8Pv4BxX7s9
         CjEzQ14ZSfEqn2/vnH7exazl15QDkyfVHcEVt+R8NaB0LjGU1aM6FK9jfQKM0yaBqIXm
         a1Xm9xBX3zGRyrU+9JSsBTKBusweac6DKZQYt+JTW7hyAvRJOb+5ODrpsNrpivlOIr8/
         1QXQ==
X-Gm-Message-State: AOAM532Z8h8EDkie/buZkN6fF/QvoR6xpmJQrjgnG0DoXlyxqcKsSeKz
        033d9TNNYmL5xs8SmfGuU843UlnzXM8=
X-Google-Smtp-Source: ABdhPJyJCkOBGaqkZOl8FXnvhO3LuowRf0vib98qqnnyYHT6qHeOk/hFrHs33I31k6easfCeqUMX8w==
X-Received: by 2002:a05:651c:11c7:: with SMTP id z7mr1606998ljo.464.1630648857737;
        Thu, 02 Sep 2021 23:00:57 -0700 (PDT)
Received: from [192.168.2.145] (46-138-26-37.dynamic.spd-mgts.ru. [46.138.26.37])
        by smtp.googlemail.com with ESMTPSA id u10sm397071lft.252.2021.09.02.23.00.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Sep 2021 23:00:57 -0700 (PDT)
Subject: Re: [PATCH 3/3] PM: domains: Add a ->dev_get_performance_state()
 callback to genpd
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        linux-pm@vger.kernel.org
Cc:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20210902101634.827187-1-ulf.hansson@linaro.org>
 <20210902101634.827187-4-ulf.hansson@linaro.org>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <4e36e732-6ca3-1d00-e6dd-38bb8877577b@gmail.com>
Date:   Fri, 3 Sep 2021 09:00:56 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210902101634.827187-4-ulf.hansson@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

02.09.2021 13:16, Ulf Hansson пишет:
> Hardware may be preprogrammed to a specific performance state, which may
> not be zero initially during boot. This may lead to that genpd's current
> performance state becomes inconsistent with the state of the hardware. To
> deal with this, the driver for a device that is being attached to its
> genpd, need to request an initial performance state vote, which is
> typically done by calling some of the OPP APIs while probing.
> 
> In some cases this would lead to boilerplate code in the drivers. Let's
> make it possible to avoid this, by adding a new optional callback to genpd
> and invoke it per device during the attach process. In this way, the genpd
> provider driver can inform genpd about the initial performance state that
> is needed for the device.
> 
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---
>  drivers/base/power/domain.c | 8 +++++---
>  include/linux/pm_domain.h   | 2 ++
>  2 files changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
> index 800adf831cae..1a6f3538af8d 100644
> --- a/drivers/base/power/domain.c
> +++ b/drivers/base/power/domain.c
> @@ -2640,13 +2640,15 @@ static void genpd_dev_pm_sync(struct device *dev)
>  	genpd_queue_power_off_work(pd);
>  }
>  
> -static int genpd_get_default_performance_state(struct device *dev,
> +static int genpd_get_default_performance_state(struct generic_pm_domain *genpd,
> +					       struct device *dev,
>  					       unsigned int index)
>  {
>  	int pstate = of_get_required_opp_performance_state(dev->of_node, index);
>  
>  	if (pstate == -ENODEV || pstate == -EOPNOTSUPP)
> -		return 0;
> +		pstate = genpd->dev_get_performance_state ?
> +			 genpd->dev_get_performance_state(genpd, dev) : 0;
>  
>  	return pstate;
>  }
> @@ -2701,7 +2703,7 @@ static int __genpd_dev_pm_attach(struct device *dev, struct device *base_dev,
>  	}
>  
>  	/* Set the default performance state */
> -	pstate = genpd_get_default_performance_state(dev, index);
> +	pstate = genpd_get_default_performance_state(pd, dev, index);

If base device is suspended, then its performance state is zero.

When device will be rpm-resumed, then its performance should be set to
the default state.

You're setting performance state of the wrong device, it should be the
base device and not the virtual domain device.

These all is handled properly by my patch [1]. Hence it's complicated
for the reason.

[1]
https://patchwork.ozlabs.org/project/linux-tegra/patch/20210831135450.26070-5-digetx@gmail.com/
