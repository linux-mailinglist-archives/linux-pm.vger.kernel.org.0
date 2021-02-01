Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCF9530B107
	for <lists+linux-pm@lfdr.de>; Mon,  1 Feb 2021 20:59:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232391AbhBAT6l (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 1 Feb 2021 14:58:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232408AbhBAT6C (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 1 Feb 2021 14:58:02 -0500
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 512D5C061573;
        Mon,  1 Feb 2021 11:57:22 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id h7so24539557lfc.6;
        Mon, 01 Feb 2021 11:57:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=jags3qvJfYgEQ14KjYOoGcQ9AwJcrMbj7KmApNgTAWE=;
        b=gMqkBksxWaYSfdPJPNB7K4My5e+qh885nWMrYBwUlRqg7b2Z7NE3+hlxBMjOv9h/eP
         wb22i0TsklkZ0oFwXAWBtmwo8oZ+2jSrpX6rnsKPcuHBNiD8i5Y/3FUa2JeA5sdrhrzn
         fpVDXnY1NU+MYy3UfABPRrq5gPkpkKMlQlnKeIFHvBe7YFf53WWprMrWfwDoifV1TWGc
         cpDsRCOkArZK1JkHmri8t0ToTeU7sR2uTWnuOIY9koHSOxIAMDoQuKnzuuua7AGl5puX
         Ds64H5Vp/AfGa7tv7YJW5tZ3uNZkGZ9DKI2CXRgEg4b3me+RmoYZOnoG2hzSuKMPcPpG
         eh9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=jags3qvJfYgEQ14KjYOoGcQ9AwJcrMbj7KmApNgTAWE=;
        b=LhNiHSw7I6ysuOOD0DKPfR0QrjdafRj0rlcs+rYbkL+e6H51j2uy1Ja1ByoII+ReUF
         x9bku+Z3KVJtLHIoJ61sJgsDFuizR7uM3A4NkvjeKuRVydw7GfzyOomWQWu4KjmE7i4W
         eWltYoJ9ijl8Mo8kLBBX/hGpPA0YQRtxUELkwVwAYKWZADGUmA0eHR5lh5ltU0EfYCFf
         Sqk/JM2ZcqCNWV5Zf7b5cbqqLsaAgIXH8iaQYYKKBjJ3kwYSUsfzVRhmEo7Fy9xZszf5
         XZ6pmrGBOIJT9bcGaTlcgjLNVIFMrto9XPontdyohgDUd2+axqAqOYjDm//5i6UgWqZy
         menw==
X-Gm-Message-State: AOAM53218+x2cJq7zfnxVzSSw+kQd2EGw3RNYMDlNMAZ93Bl5wfFEMcQ
        +uCk8xSKNsZr9pDRnRREjp7VjyB+TaY=
X-Google-Smtp-Source: ABdhPJyCYrJoeLXl/a1I/jsmotO3KKyCFToHNmJcCEZeI4IT1RCinCGkhykUj2udkEikBrX9HeCG9A==
X-Received: by 2002:a05:6512:2254:: with SMTP id i20mr9278793lfu.534.1612209440613;
        Mon, 01 Feb 2021 11:57:20 -0800 (PST)
Received: from ?IPv6:2a00:1370:814d:ea25:a10:76ff:fe69:21b6? ([2a00:1370:814d:ea25:a10:76ff:fe69:21b6])
        by smtp.googlemail.com with ESMTPSA id d9sm3061573lfm.293.2021.02.01.11.57.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Feb 2021 11:57:20 -0800 (PST)
Subject: Re: [PATCH V2 11/13] devfreq: tegra30: Migrate to
 dev_pm_opp_set_opp()
To:     Viresh Kumar <viresh.kumar@linaro.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>
Cc:     linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Rafael Wysocki <rjw@rjwysocki.net>,
        Stephen Boyd <sboyd@kernel.org>, Nishanth Menon <nm@ti.com>,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
References: <3345fd49f7987d022f4f61edb6c44f230f7354c4.1611227342.git.viresh.kumar@linaro.org>
 <f0341655361aa0107266ed9c838aa8bcfe50a3ed.1611738418.git.viresh.kumar@linaro.org>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <a07c21b5-c791-4599-8e6d-85083d3958a9@gmail.com>
Date:   Mon, 1 Feb 2021 22:57:19 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.2
MIME-Version: 1.0
In-Reply-To: <f0341655361aa0107266ed9c838aa8bcfe50a3ed.1611738418.git.viresh.kumar@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

27.01.2021 12:10, Viresh Kumar пишет:
> dev_pm_opp_set_bw() is getting removed and dev_pm_opp_set_opp() should
> be used instead. Migrate to the new API.
> 
> We don't want the OPP core to manage the clk for this driver, migrate to
> dev_pm_opp_of_add_table_noclk() to make sure dev_pm_opp_set_opp()
> doesn't have any side effects.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
> Dmitry,
> 
> This is based over the patches sent here:
> 
> https://lore.kernel.org/lkml/6c2160ff30a8f421563793020264cf9f533f293c.1611738228.git.viresh.kumar@linaro.org/
> 
> This should fix the problem you mentioned earlier. Will push this for
> linux-next unless you have any issues with it.
> 
>  drivers/devfreq/tegra30-devfreq.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/devfreq/tegra30-devfreq.c b/drivers/devfreq/tegra30-devfreq.c
> index 117cad7968ab..31f7dec5990b 100644
> --- a/drivers/devfreq/tegra30-devfreq.c
> +++ b/drivers/devfreq/tegra30-devfreq.c
> @@ -647,7 +647,7 @@ static int tegra_devfreq_target(struct device *dev, unsigned long *freq,
>  		return PTR_ERR(opp);
>  	}
>  
> -	ret = dev_pm_opp_set_bw(dev, opp);
> +	ret = dev_pm_opp_set_opp(dev, opp);
>  	dev_pm_opp_put(opp);
>  
>  	return ret;
> @@ -849,7 +849,7 @@ static int tegra_devfreq_probe(struct platform_device *pdev)
>  		return err;
>  	}
>  
> -	err = dev_pm_opp_of_add_table(&pdev->dev);
> +	err = dev_pm_opp_of_add_table_noclk(&pdev->dev);
>  	if (err) {
>  		dev_err(&pdev->dev, "Failed to add OPP table: %d\n", err);
>  		goto put_hw;
> 

Tested-by: Dmitry Osipenko <digetx@gmail.com>
