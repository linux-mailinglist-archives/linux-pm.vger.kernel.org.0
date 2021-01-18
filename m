Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BEF3B2F9A7E
	for <lists+linux-pm@lfdr.de>; Mon, 18 Jan 2021 08:29:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726637AbhARH3l (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 18 Jan 2021 02:29:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731575AbhARH3i (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 18 Jan 2021 02:29:38 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 627EAC061574
        for <linux-pm@vger.kernel.org>; Sun, 17 Jan 2021 23:28:58 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id cq1so8917283pjb.4
        for <linux-pm@vger.kernel.org>; Sun, 17 Jan 2021 23:28:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=oTZyvn8+S9h20E1QWm+tasYgvW1yYTa8Mz+DSqTF2ow=;
        b=fb9XT8OZ9BzWNlz6FVyuhVHPrL/Qn9ij36IH24FpbSUrhJ2OVvAsARtyR7eprT47KO
         qWD3pTMnaktMB3JoP76WW+TZft8fkhU6BCsmnbQ2oeVZpnokD98Bmk8k4+Z8kRpnKk4v
         r0C8CYBkpIx8NkxJp1VQH/bFT82lQmLnJbxGUkQ0szRR8yBy9kCFi2xB/NII/TawwdBj
         tkJEtXFIKyKs5dmPH6lXASIQLYSmZl8mGqYbd4w+SeVqib715YmEw0DBcq9Mjdy093/B
         K4HfruIqe+shP3FWqgryshZHEZVdfIBCeTS9fPZ4cGkJtYzo9YsivAz6lSvsrcm6G0nO
         2j6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=oTZyvn8+S9h20E1QWm+tasYgvW1yYTa8Mz+DSqTF2ow=;
        b=DcmxZeq2R3VO5B8CiRFbGSwXo8ynlVjFeGEOVMrJA1f+A+ousizSEmfbIwMWvQTRZh
         a3vEMxObs+qwjiiqAh8RN63gWg8L1JTNHxKDByLN58KTv2v/Bt7grIFKmCzkaXFvVYJv
         9Eg/0tzuKcEkDOw1FmBnN5HWmiYvGkzH/PL1wGy1zisKbN4SBjxwpY+jnFdIr5Ep7imR
         i08C2RYC6hZpOU4w3iWxAnNSuXOlRYBS9bsJ42Dj0AOICqWzSKR4N5Orh898O9W0kwJQ
         J0fFn/MsUATHFiXtwjiMfmhft/XToG6VVycBnGvD/JmWuvWnx5DJtwhoy3ipT3b0fIK4
         9zqg==
X-Gm-Message-State: AOAM530WFytoMbbQ60vlgfhehzJtN1ZA0RpzVeVa/8ezouyGsPp0IbdH
        WH4347dE8kd9GTge3mkW7H+JJw==
X-Google-Smtp-Source: ABdhPJwlgIyH6GodMYF/qixAOZAHC7bgEIgrJL7veGnwjfC3298HiwMe8kqKa/aV4UBZ9Ck4HKrU2g==
X-Received: by 2002:a17:90a:5911:: with SMTP id k17mr25158139pji.152.1610954937951;
        Sun, 17 Jan 2021 23:28:57 -0800 (PST)
Received: from localhost ([122.172.59.240])
        by smtp.gmail.com with ESMTPSA id j23sm14839583pgj.34.2021.01.17.23.28.56
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 17 Jan 2021 23:28:57 -0800 (PST)
Date:   Mon, 18 Jan 2021 12:58:55 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Peter Geis <pgwipeout@gmail.com>,
        Nicolas Chauvet <kwizart@gmail.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Viresh Kumar <vireshk@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Matt Merhar <mattmerhar@protonmail.com>,
        linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH v3 1/3] PM: domains: Make set_performance_state()
 callback optional
Message-ID: <20210118072855.anncyl6z3e5uznvd@vireshk-i7>
References: <20210118011330.4145-1-digetx@gmail.com>
 <20210118011330.4145-2-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210118011330.4145-2-digetx@gmail.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 18-01-21, 04:13, Dmitry Osipenko wrote:
> Make set_performance_state() callback optional in order to remove the
> need from power domain drivers to implement a dummy callback. If callback
> isn't implemented by a GENPD driver, then the performance state is passed
> to the parent domain.
> 
> Tested-by: Peter Geis <pgwipeout@gmail.com>
> Tested-by: Nicolas Chauvet <kwizart@gmail.com>
> Tested-by: Matt Merhar <mattmerhar@protonmail.com>
> Suggested-by: Ulf Hansson <ulf.hansson@linaro.org>
> Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  drivers/base/power/domain.c | 11 +++++------
>  1 file changed, 5 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
> index 9a14eedacb92..a3e1bfc233d4 100644
> --- a/drivers/base/power/domain.c
> +++ b/drivers/base/power/domain.c
> @@ -339,9 +339,11 @@ static int _genpd_set_performance_state(struct generic_pm_domain *genpd,
>  			goto err;
>  	}
>  
> -	ret = genpd->set_performance_state(genpd, state);
> -	if (ret)
> -		goto err;
> +	if (genpd->set_performance_state) {
> +		ret = genpd->set_performance_state(genpd, state);
> +		if (ret)
> +			goto err;
> +	}

Earlier in this routine we also have this:

if (!parent->set_performance_state)
        continue;

Should we change that too ?

>  
>  	genpd->performance_state = state;
>  	return 0;
> @@ -399,9 +401,6 @@ int dev_pm_genpd_set_performance_state(struct device *dev, unsigned int state)
>  	if (!genpd)
>  		return -ENODEV;
>  
> -	if (unlikely(!genpd->set_performance_state))
> -		return -EINVAL;
> -
>  	if (WARN_ON(!dev->power.subsys_data ||
>  		     !dev->power.subsys_data->domain_data))
>  		return -EINVAL;

Reviewed-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
