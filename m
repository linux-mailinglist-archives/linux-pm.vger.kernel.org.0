Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BB273920AF
	for <lists+linux-pm@lfdr.de>; Mon, 19 Aug 2019 11:50:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726842AbfHSJuF (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 19 Aug 2019 05:50:05 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:44814 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726805AbfHSJuF (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 19 Aug 2019 05:50:05 -0400
Received: by mail-pf1-f193.google.com with SMTP id c81so862431pfc.11
        for <linux-pm@vger.kernel.org>; Mon, 19 Aug 2019 02:50:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=GwxTKfEAgdYinZ1pQ0qUdgZm8MLLK/a050DZxr6TIIA=;
        b=E5QuFSKe3zCu6j5dp7nU++ADdVgtHyQte4iITIu6YTh4OdZRKxRmfrT64Fvnsff5Ji
         cEhhwOIbqR4CTkTOMNuUhBeIC2P9XRFwxBURIQz1Jq+2ro3StIV0vN/jL2YIgLbT8Gfr
         U/vIELNamnuLogvXmPQEFrWff8FYxY4fcPsEpZfeLP5f+24Xqj7WUQfiEHyntro3l8w+
         vjZT4ohjF4OWDcGS5auUBZ4WePwk20Nbo93S2DD3safgibkoEgynTTtO3mzHbHp4xhaV
         ZyHX+FH2WNDbIwnUlbfe9Vij6y1rgljSS1WutnAscTU9K6TnV6RXbKxmv6q3yyNb8tWc
         S1dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=GwxTKfEAgdYinZ1pQ0qUdgZm8MLLK/a050DZxr6TIIA=;
        b=N+iAUL3gWk9Wldry54ipIT3XH4Q7vu54pSCmB/BsK0uaIoHPKF7BI+EFVtZHbluvkQ
         rJ42J+Y6vCp6pHvvvVBZOdqqRhPRGJ0hi5iRKMgSb7VFjFRJM3WOHJ1kHQCYsHYlUk/Y
         YEovn1l2KzHOR3R4DHmMFKyCnWrfY5L4gQCPzjm7GvZ88iUD0DMuGO3XpdArwkBTgkWb
         rzvYBv52i8PaFOcjQrNnA8DDTGJyXCnwQlmMqPR2WZkZl/uEcAFUxcssDkGN3MkszTJz
         bcKs4wlwsFsf4rtnWU8KXf/epvGMalzWLAmV/mNeQFm493CnjS5ZocQFFFR1x76eZ6iq
         BILg==
X-Gm-Message-State: APjAAAUw4grNeqWTHzBe0/tRIh16HCdGY0XAqC6gkiSQ1T7VVy4GJJ+W
        2WX+Q0wt+W88g6t4EUPdD2bu4w==
X-Google-Smtp-Source: APXvYqztyBlcXrsfuYCccymx2QeJyImR1KtB/92fHFvsu4CmhBvOr2ya1KA4fBmG+LhnG94tJ7THOw==
X-Received: by 2002:a17:90a:35a7:: with SMTP id r36mr20029074pjb.17.1566208204653;
        Mon, 19 Aug 2019 02:50:04 -0700 (PDT)
Received: from localhost ([122.172.76.219])
        by smtp.gmail.com with ESMTPSA id w9sm15258821pfn.19.2019.08.19.02.50.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 19 Aug 2019 02:50:03 -0700 (PDT)
Date:   Mon, 19 Aug 2019 15:20:02 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     "Andrew-sh.Cheng" <andrew-sh.cheng@mediatek.com>
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        srv_heupstream@mediatek.com, fan.chen@mediatek.com
Subject: Re: [v4, 2/8] cpufreq: mediatek: add clock enable for intermediate
 clock
Message-ID: <20190819095002.ncpzxzahzqfvsjba@vireshk-i7>
References: <1565703113-31479-1-git-send-email-andrew-sh.cheng@mediatek.com>
 <1565703113-31479-3-git-send-email-andrew-sh.cheng@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1565703113-31479-3-git-send-email-andrew-sh.cheng@mediatek.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 13-08-19, 21:31, Andrew-sh.Cheng wrote:
> From: "Andrew-sh.Cheng" <andrew-sh.cheng@mediatek.com>
> 
> Intermediate clock is not always enabled by ccf in different projects,
> so cpufreq should always enable it by itself.
> 
> Signed-off-by: Andrew-sh.Cheng <andrew-sh.cheng@mediatek.com>
> ---
>  drivers/cpufreq/mediatek-cpufreq.c | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/cpufreq/mediatek-cpufreq.c b/drivers/cpufreq/mediatek-cpufreq.c
> index a370577ffc73..acd9539e95de 100644
> --- a/drivers/cpufreq/mediatek-cpufreq.c
> +++ b/drivers/cpufreq/mediatek-cpufreq.c
> @@ -368,13 +368,17 @@ static int mtk_cpu_dvfs_info_init(struct mtk_cpu_dvfs_info *info, int cpu)
>  		goto out_free_resources;
>  	}
>  
> +	ret = clk_prepare_enable(inter_clk);
> +	if (ret)
> +		goto out_free_opp_table;
> +
>  	/* Search a safe voltage for intermediate frequency. */
>  	rate = clk_get_rate(inter_clk);
>  	opp = dev_pm_opp_find_freq_ceil(cpu_dev, &rate);
>  	if (IS_ERR(opp)) {
>  		pr_err("failed to get intermediate opp for cpu%d\n", cpu);
>  		ret = PTR_ERR(opp);
> -		goto out_free_opp_table;
> +		goto out_disable_clock;
>  	}
>  	info->intermediate_voltage = dev_pm_opp_get_voltage(opp);
>  	dev_pm_opp_put(opp);
> @@ -393,6 +397,9 @@ static int mtk_cpu_dvfs_info_init(struct mtk_cpu_dvfs_info *info, int cpu)
>  
>  	return 0;
>  
> +out_disable_clock:
> +	clk_disable_unprepare(inter_clk);
> +
>  out_free_opp_table:
>  	dev_pm_opp_of_cpumask_remove_table(&info->cpus);
>  
> @@ -419,6 +426,10 @@ static void mtk_cpu_dvfs_info_release(struct mtk_cpu_dvfs_info *info)
>  		clk_put(info->cpu_clk);
>  	if (!IS_ERR(info->inter_clk))
>  		clk_put(info->inter_clk);

Shouldn't you remove this part now ?

> +	if (!IS_ERR(info->inter_clk)) {
> +		clk_disable_unprepare(info->inter_clk);
> +		clk_put(info->inter_clk);
> +	}
>  
>  	dev_pm_opp_of_cpumask_remove_table(&info->cpus);
>  }
> -- 
> 2.12.5

-- 
viresh
