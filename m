Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79E7C306C2D
	for <lists+linux-pm@lfdr.de>; Thu, 28 Jan 2021 05:22:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229578AbhA1EWS (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 27 Jan 2021 23:22:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229728AbhA1EWR (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 27 Jan 2021 23:22:17 -0500
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3BDFC061574
        for <linux-pm@vger.kernel.org>; Wed, 27 Jan 2021 20:21:36 -0800 (PST)
Received: by mail-pf1-x42e.google.com with SMTP id t29so3163087pfg.11
        for <linux-pm@vger.kernel.org>; Wed, 27 Jan 2021 20:21:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=jPEFaIx1yHTK24ypqi53HKXI8fE0uVbSnWtKF2EIgzI=;
        b=OFnSQkYoe9kKZ10tVm3QByzfyaPyo4w5g0/W7GQEoKnbKWJmWdsWEvqe5w5xyC+m33
         Vh2rw+KwAVf7nkrCGPbpyAcI6QIX73/yuWF0aF+JyjkITOluPkr9WpprGKPw+F3W1BJs
         1ADWqUb2ut405RryMrBvk/AsXMSw4LCqqc3BWrzC0mWfBaO3TvN1KaQwLHHfflp8YN4z
         aF08DnoLLtDv9UOM4lnWfLwFTdaa18NIjBw/rghja8kkwEiM3cFs7BYNkJHSmy9+wtrd
         TkwJjryFyIjughIBVu295YEbNMzKjjexhpuiAdaW0cTCGGrqrP7DTmUWkn0D1JODXk4T
         De5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=jPEFaIx1yHTK24ypqi53HKXI8fE0uVbSnWtKF2EIgzI=;
        b=HxiAiDqsvKqomi1PrALj/36XPeLzT9PKzn3zK/r61aNqSSNxAtQDRBWv+2RaXfUNsF
         jH3ebboHyJ1tKfbs6NTe3zZ3OmOUhxhGFDyPeA6T+3nBMm70ge48ivR51c+KlqJe9Q83
         WEDZiSNcwQYlUBT85l+HSo/sFgsiKguT6Gnu6gMcDnPRQ92jF8afNDnsBG95FUOK9rxn
         YJs+jq9emjv/n/jsrDNV8W5zXsWpCSLtW196/V1GWT5rpY71NCny3LhIuGeU1oym/4FM
         50z5fY12OBsXVv8AjBHbGI+bm3avKPC0wqw5Qlq4pZcm9RsNjQgx46J1mQwX6+V0mLx4
         TkqQ==
X-Gm-Message-State: AOAM530dbsej4f/Emw1Y4N2tA+ng7ojoiRoXEPsKs5Z8eRsvu86Zta5u
        wegB0rZ954Hro5RyqOLqOLlLng==
X-Google-Smtp-Source: ABdhPJwx+CivHEPYDbxBD37bGoeyNKiZnYuIXJOD/BG/RuTHRCGk3I8fvJpvt8mr/E+Dvsg5KFUTDA==
X-Received: by 2002:a63:6f0d:: with SMTP id k13mr14661332pgc.256.1611807696385;
        Wed, 27 Jan 2021 20:21:36 -0800 (PST)
Received: from localhost ([122.172.59.240])
        by smtp.gmail.com with ESMTPSA id r194sm3932994pfr.168.2021.01.27.20.21.35
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Jan 2021 20:21:35 -0800 (PST)
Date:   Thu, 28 Jan 2021 09:51:31 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH] opp: Allow dev_pm_opp_set_opp() to be called without opp
Message-ID: <20210128042131.k7mh2a3xneoecwcu@vireshk-i7>
References: <20210128040426.953529-1-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210128040426.953529-1-bjorn.andersson@linaro.org>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 27-01-21, 20:04, Bjorn Andersson wrote:
> a6xx_gmu_stop() calls dev_pm_opp_set_opp() with NULL as opp in order to
> drop its bandwidth request, which was valid with dev_pm_opp_set_bw().
> But after the transition to dev_pm_opp_set_opp() this leads to a NULL
> dereference before jumping into _set_opp(), which does disable the
> vote as expected.
> 
> Fixes: a0d67b94e2ef ("opp: Implement dev_pm_opp_set_opp()")
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---
>  drivers/opp/core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/opp/core.c b/drivers/opp/core.c
> index 583bb1274df9..3ff05f40e443 100644
> --- a/drivers/opp/core.c
> +++ b/drivers/opp/core.c
> @@ -1157,7 +1157,7 @@ int dev_pm_opp_set_opp(struct device *dev, struct dev_pm_opp *opp)
>  		return PTR_ERR(opp_table);
>  	}
>  
> -	ret = _set_opp(dev, opp_table, opp, opp->rate);
> +	ret = _set_opp(dev, opp_table, opp, opp ? opp->rate : 0);
>  	dev_pm_opp_put_opp_table(opp_table);
>  
>  	return ret;

I specially handled this case with care and still missed this :(

I have updated the original patch to fix it, thanks.

-- 
viresh
