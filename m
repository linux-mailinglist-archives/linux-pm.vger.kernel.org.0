Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EDD82F9B11
	for <lists+linux-pm@lfdr.de>; Mon, 18 Jan 2021 09:15:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387569AbhARIPb (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 18 Jan 2021 03:15:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387558AbhARIP3 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 18 Jan 2021 03:15:29 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7783C061574
        for <linux-pm@vger.kernel.org>; Mon, 18 Jan 2021 00:14:48 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id b8so8235734plx.0
        for <linux-pm@vger.kernel.org>; Mon, 18 Jan 2021 00:14:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=dnqhgTgEgfjpCkQk4DrLg2Pz0vvRJ1haccA0ChmGB4s=;
        b=mvwY2oaxTg2iQvrWRXNERWoR6cwaCxjDhpCZ0S5VRKKdczNs/0DdR+y1z/ewqAdjRV
         mhsmCFaCYnU3ltO6HrGOUFCWtw4ol+8HtqMknFmkog56YMChyjoBIDfS7P9TG5pNxnoL
         AXyfHSPfQu9wm6VvwCe0h+OIhHjvnF1SOsTPQR0S/ah0JgeXkWnf1tlXrfWameq5UUyt
         ALNDRzjzFAnxSqwU6Q1wFigq6zUlw6K9Bs68Ck3U2AcA9GX7Zvdapm1wK+Dn1jqaj6HM
         FZdW/ZRbRpyW9gfzDP/Jfe1Tn2hcHq8lDyLg+5aX2rwYCGN+Ei4swTGcuXc+xAVY3Z4d
         shbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=dnqhgTgEgfjpCkQk4DrLg2Pz0vvRJ1haccA0ChmGB4s=;
        b=bE3s2WGdYJUVQECQ3vD6v07tHQpf/2VAZD74WWXyb9MgW41SjJcebLNwTV10U7zhgh
         znJAGaFqgfHs8KWmWzExC5j6eP7SYFfX/7Tn6nxe3vsfNaU7FPlsVhndhj5CTY/zgCl/
         6joC8dslY6AQTQdtJOiC1FrRt14QjShWkVUPOiUJbqCNYhPmNd6C6S5ZqwUVHNbOJJNH
         qY0i5IwM5p2kPZ+fP0I2Me+C9h4BrayeCqTMPY3YXBTsW1h+p/tUAIQT/EuqyMypankC
         gs05HtGreW+hMkCgwA0O8Z2i4vfDrrqP5mIVh1xikjissx8g9gZ4ESrDYE1Lvrzn0u/J
         OTIA==
X-Gm-Message-State: AOAM530sF4Jy2840Y64UBur45zkRachvIgy+q5puXBQFVmKBG6W3+ite
        Lva3CL6NVM1jXiv6BBOrjFpX7A==
X-Google-Smtp-Source: ABdhPJwSgmbCNCnC88DGOxaRzl97XaTmvifBTgddcnXoxnh9dbVJAGP2zetC2Jy9q5ozo6QCcgA6lg==
X-Received: by 2002:a17:90a:8597:: with SMTP id m23mr3054090pjn.85.1610957688439;
        Mon, 18 Jan 2021 00:14:48 -0800 (PST)
Received: from localhost ([122.172.59.240])
        by smtp.gmail.com with ESMTPSA id n28sm15307014pfq.61.2021.01.18.00.14.47
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Jan 2021 00:14:47 -0800 (PST)
Date:   Mon, 18 Jan 2021 13:44:45 +0530
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
Subject: Re: [PATCH v3 03/12] opp: Correct debug message in
 _opp_add_static_v2()
Message-ID: <20210118081445.zl6nm3hqaoizeijo@vireshk-i7>
References: <20210118005524.27787-1-digetx@gmail.com>
 <20210118005524.27787-4-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210118005524.27787-4-digetx@gmail.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 18-01-21, 03:55, Dmitry Osipenko wrote:
> The debug message always prints rate=0 instead of a proper value, fix it.
> 
> Tested-by: Peter Geis <pgwipeout@gmail.com>
> Tested-by: Nicolas Chauvet <kwizart@gmail.com>
> Tested-by: Matt Merhar <mattmerhar@protonmail.com>
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  drivers/opp/of.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/opp/of.c b/drivers/opp/of.c
> index 50df483c7dc3..63b16cdba5ea 100644
> --- a/drivers/opp/of.c
> +++ b/drivers/opp/of.c
> @@ -755,7 +755,6 @@ static struct dev_pm_opp *_opp_add_static_v2(struct opp_table *opp_table,
>  		struct device *dev, struct device_node *np)
>  {
>  	struct dev_pm_opp *new_opp;
> -	u64 rate = 0;
>  	u32 val;
>  	int ret;
>  	bool rate_not_available = false;
> @@ -772,7 +771,8 @@ static struct dev_pm_opp *_opp_add_static_v2(struct opp_table *opp_table,
>  
>  	/* Check if the OPP supports hardware's hierarchy of versions or not */
>  	if (!_opp_is_supported(dev, opp_table, np)) {
> -		dev_dbg(dev, "OPP not supported by hardware: %llu\n", rate);
> +		dev_dbg(dev, "OPP not supported by hardware: %lu\n",
> +			new_opp->rate);
>  		goto free_opp;
>  	}
>  

Applied and added Fixes tag. Thanks.

-- 
viresh
