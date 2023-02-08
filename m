Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDBCC68EBF3
	for <lists+linux-pm@lfdr.de>; Wed,  8 Feb 2023 10:45:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229483AbjBHJo7 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 8 Feb 2023 04:44:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230414AbjBHJoz (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 8 Feb 2023 04:44:55 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CC1710F3
        for <linux-pm@vger.kernel.org>; Wed,  8 Feb 2023 01:44:54 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id w5so8615936plg.8
        for <linux-pm@vger.kernel.org>; Wed, 08 Feb 2023 01:44:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=exdCzy9d9DpQNs3HOQEbR5io3J3IIALSbBkebG7xhEA=;
        b=sEpVY0yqT5kT//OAQbhQtM606NSkPZ8J8YmbsrayL9I9iBN7NbktvvyDJaZrjjHsKh
         CGLRuHj8KlyfT5a2P4IAkfBJztVJgAXhoswaN0ESmDTVoBeurc988e8PiTYN5GMzOb3i
         SFojxcDC+ART9A5y7NnxrGUVOW6Y1tcDZ+ddF6zGRP8fg1W5hLcXnEtWsJ+tQ7IXFv+B
         dLd4T225Zj7q073bnmTL08E1ZgFEG/IKXrrqr4uXK3r6yzK2XTCIUQhd06Cl7EY0l0lf
         bwysh0iOVzYB+JNvsmRbXLUQVEWa1O7txxKtm97IwZPP3G510x/tvUHbRR4nieavMzAI
         ltjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=exdCzy9d9DpQNs3HOQEbR5io3J3IIALSbBkebG7xhEA=;
        b=Bknwpo9k7hMnWtZNNP5fumAx1rcT71Y6mAq7mFcAmMcn3/kEBVcY4CCzGjCikzOy3R
         b/f8RAaobC2mYB2QLkYxUo0nfQ9v72/5PLp9o++V4vCC943K6TgC7hLuwZSiWCUdDDCq
         eVfaI6W9JlBfUme9EefSm7KSePr1wNop5K7jaB0wZPBXbqvqUZy4O9fNstJeKHsC+//m
         /9j0/ComEtMSF3sfead3y/cRtJMFWOroOBkAkM1zERn6VLjUullbLwoXh+iENdW4h2fm
         qLVIPG5SG1IUyv0iWZpsVqgSrqHxFS92ceVbHA4fZ1IuoKAgEiOvL9hfEHlt5omper9C
         eEsw==
X-Gm-Message-State: AO0yUKWP4md0DbKEcm1eJh6HwSJxIvDqGsblPDCPuUddSz74WRzkk3yy
        oOMNr83gAb9boALAthgRYZ3QJQ==
X-Google-Smtp-Source: AK7set/a693+rWqTDrQ9eoByoGHXbFV0LuEXDD2atWQRi1LnnchGW5wXS7xOHy3YpyRUTzbxRlAo4A==
X-Received: by 2002:a17:903:1c8:b0:193:3845:de53 with SMTP id e8-20020a17090301c800b001933845de53mr7832125plh.39.1675849494174;
        Wed, 08 Feb 2023 01:44:54 -0800 (PST)
Received: from localhost ([122.172.83.155])
        by smtp.gmail.com with ESMTPSA id j3-20020a170903024300b0019667318941sm10489949plh.176.2023.02.08.01.44.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Feb 2023 01:44:53 -0800 (PST)
Date:   Wed, 8 Feb 2023 15:14:51 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Kevin Hilman <khilman@deeprootsystems.com>,
        Sekhar Nori <nsekhar@ti.com>, linux-pm@vger.kernel.org,
        kernel@pengutronix.de
Subject: Re: [PATCH] cpufreq: davinci: Fix clk use after free
Message-ID: <20230208094451.wib7on57imsujbaj@vireshk-i7>
References: <20230208092654.551466-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230208092654.551466-1-u.kleine-koenig@pengutronix.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 08-02-23, 10:26, Uwe Kleine-König wrote:
> The remove function first frees the clks and only then calls
> cpufreq_unregister_driver(). If one of the cpufreq callbacks is called
> just before cpufreq_unregister_driver() is run, the freed clks might be
> used.
> 
> Fixes: 6601b8030de3 ("davinci: add generic CPUFreq driver for DaVinci")
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> ---
>  drivers/cpufreq/davinci-cpufreq.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/cpufreq/davinci-cpufreq.c b/drivers/cpufreq/davinci-cpufreq.c
> index 2d23015e2abd..ebb3a8102681 100644
> --- a/drivers/cpufreq/davinci-cpufreq.c
> +++ b/drivers/cpufreq/davinci-cpufreq.c
> @@ -133,13 +133,13 @@ static int __init davinci_cpufreq_probe(struct platform_device *pdev)
>  
>  static int __exit davinci_cpufreq_remove(struct platform_device *pdev)
>  {
> +	cpufreq_unregister_driver(&davinci_driver);
> +
>  	clk_put(cpufreq.armclk);
>  
>  	if (cpufreq.asyncclk)
>  		clk_put(cpufreq.asyncclk);
>  
> -	cpufreq_unregister_driver(&davinci_driver);
> -
>  	return 0;
>  }

Rafael, please take this directly as the dependency patch will go via your tree
too (the one that makes cpufreq_unregister_driver() return void).

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
