Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16CF524FC67
	for <lists+linux-pm@lfdr.de>; Mon, 24 Aug 2020 13:18:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726466AbgHXLSs (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 24 Aug 2020 07:18:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725883AbgHXLSY (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 24 Aug 2020 07:18:24 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 261FCC061573
        for <linux-pm@vger.kernel.org>; Mon, 24 Aug 2020 04:18:24 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id d4so4027996pjx.5
        for <linux-pm@vger.kernel.org>; Mon, 24 Aug 2020 04:18:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=924oG4r/zA6EzR8f8iU/QlmiDvBYHOesbZuQXAnUB10=;
        b=Zxdfow5V0kAcBrq4HyfZh+a/jeM8RuH/QWWl4uQWICbgi4ozmRA63KsdSAHLhF8RiC
         TPVWAZUuoiA39AUM4rVBi11nop10GYFklMD5p7kB7eRSosa+GwNpILRbnbjMv2tEt0WD
         0gUgg4C1UMHcvbANDr33grnpH/zGnvxn5Edm/iukgbIqhVVH1pCA6MpSFxzyc53pawLI
         25AO2othQE3ahdOwe9X7uX2mv2bxFKxzn/u3W8vmofOE125InZArTR7yNS+1uWgYWSVS
         rGXDf5/i9TkwffvnmwUadm2zSXnyyqJwoy7nhsZq1N1N7NrMKdK7wsJJfLMW5WcnJkh9
         0Bvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=924oG4r/zA6EzR8f8iU/QlmiDvBYHOesbZuQXAnUB10=;
        b=cjDQdfpVQTGQTylRq+T7oXhfW/Cc8LbHZkOiwxWmPT/GtPQXC+t4qsSlibIooAukIY
         0WRKhhj1fePmgVK5qThfXaWnGE8WZ8i9jDyG2Qbz18yTa+n/0KgnY/F/2jFPccFoA555
         RaV0IgciIdxdShLBxfouY/ZJ/PFKOACFdeREvchbMdG3JCIilRiks5TZLqmEpc7Sw/2/
         pZCjFjVzLu0xVPzsiHe3J+91bTq4v1XU/bvTax0cmyEltUZUmhagmB0NQxgDGFOOVIbv
         2XLfrKUFKtFsZ7atTRyoghNdH7mQW081u0EhEX8Jx35wgzvIR97wdaz3g7Vc7pNoFBBu
         cY/A==
X-Gm-Message-State: AOAM5318VQnhWcv4QSD9DafRA3Hzlg431Koa5ZJDBGuUovYIjFRQd56L
        9DgfHPCVzUqwcD1tX8x/ycX4HWq9KeMh5Q==
X-Google-Smtp-Source: ABdhPJw9nAi06D5xVylFBDMZzBl0YAscU8qmQ45LkHNjgXXHlWA3I00bTnYySLilETWRcKxo2mlI8g==
X-Received: by 2002:a17:90a:4fe2:: with SMTP id q89mr4578766pjh.70.1598267903407;
        Mon, 24 Aug 2020 04:18:23 -0700 (PDT)
Received: from localhost ([122.172.43.13])
        by smtp.gmail.com with ESMTPSA id 5sm11527604pfw.25.2020.08.24.04.18.22
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Aug 2020 04:18:22 -0700 (PDT)
Date:   Mon, 24 Aug 2020 16:48:20 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Stephan Gerhold <stephan@gerhold.net>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Niklas Cassel <nks@flawful.org>
Subject: Re: [RFC PATCH 1/3] opp: Reduce code duplication in
 _set_required_opps()
Message-ID: <20200824111820.rcaingohxw3wozgd@vireshk-i7>
References: <20200730080146.25185-1-stephan@gerhold.net>
 <20200730080146.25185-2-stephan@gerhold.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200730080146.25185-2-stephan@gerhold.net>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 30-07-20, 10:01, Stephan Gerhold wrote:
> Move call to dev_pm_genpd_set_performance_state() to a separate
> function so we can avoid duplicating the code for the single and
> multiple genpd case.
> 
> Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
> ---
>  drivers/opp/core.c | 40 +++++++++++++++++++++-------------------
>  1 file changed, 21 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/opp/core.c b/drivers/opp/core.c
> index 9d7fb45b1786..f7a476b55069 100644
> --- a/drivers/opp/core.c
> +++ b/drivers/opp/core.c
> @@ -781,6 +781,21 @@ static int _set_opp_custom(const struct opp_table *opp_table,
>  	return opp_table->set_opp(data);
>  }
>  
> +static int _set_required_opp(struct device *dev, struct device *pd_dev,
> +			     struct dev_pm_opp *opp, int i)
> +{
> +	unsigned int pstate = likely(opp) ? opp->required_opps[i]->pstate : 0;
> +	int ret;
> +
> +	ret = dev_pm_genpd_set_performance_state(pd_dev, pstate);
> +	if (ret) {
> +		dev_err(dev, "Failed to set performance rate of %s: %d (%d)\n",
> +			dev_name(pd_dev), pstate, ret);
> +	}
> +
> +	return ret;
> +}
> +
>  /* This is only called for PM domain for now */
>  static int _set_required_opps(struct device *dev,
>  			      struct opp_table *opp_table,
> @@ -788,22 +803,15 @@ static int _set_required_opps(struct device *dev,
>  {
>  	struct opp_table **required_opp_tables = opp_table->required_opp_tables;
>  	struct device **genpd_virt_devs = opp_table->genpd_virt_devs;
> -	unsigned int pstate;
> +	struct device *pd_dev;
>  	int i, ret = 0;
>  
>  	if (!required_opp_tables)
>  		return 0;
>  
>  	/* Single genpd case */
> -	if (!genpd_virt_devs) {
> -		pstate = likely(opp) ? opp->required_opps[0]->pstate : 0;
> -		ret = dev_pm_genpd_set_performance_state(dev, pstate);
> -		if (ret) {
> -			dev_err(dev, "Failed to set performance state of %s: %d (%d)\n",
> -				dev_name(dev), pstate, ret);
> -		}
> -		return ret;
> -	}
> +	if (!genpd_virt_devs)
> +		return _set_required_opp(dev, dev, opp, 0);
>  
>  	/* Multiple genpd case */
>  
> @@ -814,17 +822,11 @@ static int _set_required_opps(struct device *dev,
>  	mutex_lock(&opp_table->genpd_virt_dev_lock);
>  
>  	for (i = 0; i < opp_table->required_opp_count; i++) {
> -		pstate = likely(opp) ? opp->required_opps[i]->pstate : 0;
> -
> -		if (!genpd_virt_devs[i])
> -			continue;

Don't we need this check anymore ?

> +		pd_dev = genpd_virt_devs[i];
>  
> -		ret = dev_pm_genpd_set_performance_state(genpd_virt_devs[i], pstate);
> -		if (ret) {
> -			dev_err(dev, "Failed to set performance rate of %s: %d (%d)\n",
> -				dev_name(genpd_virt_devs[i]), pstate, ret);
> +		ret = _set_required_opp(dev, pd_dev, opp, i);
> +		if (ret)
>  			break;
> -		}
>  	}
>  	mutex_unlock(&opp_table->genpd_virt_dev_lock);
>  
> -- 
> 2.27.0

-- 
viresh
