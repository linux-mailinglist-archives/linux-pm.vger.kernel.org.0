Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F7AA5276A2
	for <lists+linux-pm@lfdr.de>; Sun, 15 May 2022 11:41:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236110AbiEOJl1 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 15 May 2022 05:41:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236132AbiEOJlL (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 15 May 2022 05:41:11 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBA53DFDD
        for <linux-pm@vger.kernel.org>; Sun, 15 May 2022 02:41:10 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id c24so11775411lfv.11
        for <linux-pm@vger.kernel.org>; Sun, 15 May 2022 02:41:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=6ydHhXASeqXahTkAd//FnSPFtSMdImHAirTmzKWhapU=;
        b=pWB/QABn6T3KK9W99gpPyH12i3CUzJYbpOwevKiA1X06TypvIY/u6B9whjsR+n9Kkj
         pSntl2oaATftH883/5FpqZXNIKjqgilMRCL5ra19udSQoFa8LVrEBv6ClO26rnkarcx0
         8bziTvsSTVqK6CTCfqg7yldbX3aG6DQD1QZLgXRcoOrWmhXG/70rPUus3F1qz/8EMlhX
         AXrRPcftsjDit4aZYewu9L6e7qiW9d/TI5P7dGyuJ1mTOGE/1zvYYI+fmoBfsh41pTcU
         Ze90MoqLOUo9NVUZWLuTPLj9GvA+Rtg0xoygk8JyqjN9MwgbEiEvIIMsXQWXvXEEtcAs
         Ll3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=6ydHhXASeqXahTkAd//FnSPFtSMdImHAirTmzKWhapU=;
        b=M/DvTUd2ncGcqeRkNTu6xTNpNTHqA35f9R23m/O4PkqzhPiUoRe3q/moMGgHza4Gi1
         7B2e8Wiop/3zOEXyx8GqoOOJ2ThXYjK2/k0KVnJpwQi+f8ffkw0GhRLMjMwg3ex+zsar
         7tPh1gZvaAZTw/PxhDSOW0ND3D2VeEAGIaclOElLbSZEGJs6IJDy0PqGMEY4ZvD/ZtDT
         1dyilXKzqWdRpDTgsAqIKSmFEwdiVR2++OtobDOAX921BKA4izOEWUWjVWXrJT8jsehx
         5oWsAA88h9Ed6YdM414ROdPixQyZWWA0Pqngoo2uf4HFqfDmjC/fojDaKcgtLYXAJ+Nr
         y/ag==
X-Gm-Message-State: AOAM532U52Ul4ibWE4hFRBzKpR5kyNqgmGY6U8Z8ULF4/vnbwzcTZMr7
        WX0guavg+cTEqIZbT4bdROKAzA==
X-Google-Smtp-Source: ABdhPJymLcslf+Wq08S4aHR8fEaAqOGfMtx3fPre3BOyvYXs3o+BsdEANlr2JLXqYxeKPTSTgFzshw==
X-Received: by 2002:ac2:43c6:0:b0:472:1246:85ac with SMTP id u6-20020ac243c6000000b00472124685acmr9198323lfl.173.1652607669152;
        Sun, 15 May 2022 02:41:09 -0700 (PDT)
Received: from [192.168.0.17] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id r14-20020ac25a4e000000b0047255d211c2sm962070lfn.241.2022.05.15.02.41.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 15 May 2022 02:41:08 -0700 (PDT)
Message-ID: <68969550-e18b-3c27-d449-1478b314e129@linaro.org>
Date:   Sun, 15 May 2022 11:41:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCHv2 2/6] thermal: exynos: Reorder the gpu clock
 initialization for exynos5420 SoC
Content-Language: en-US
To:     Anand Moon <linux.amoon@gmail.com>,
        Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220515064126.1424-1-linux.amoon@gmail.com>
 <20220515064126.1424-3-linux.amoon@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220515064126.1424-3-linux.amoon@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 15/05/2022 08:41, Anand Moon wrote:
> Reorder the tmu_gpu clock initialization for exynos5422 SoC.

Why?

> 
> Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> ---
> v1: split the changes and improve the commit messages
> ---
>  drivers/thermal/samsung/exynos_tmu.c | 43 ++++++++++++++--------------
>  1 file changed, 21 insertions(+), 22 deletions(-)
> 
> diff --git a/drivers/thermal/samsung/exynos_tmu.c b/drivers/thermal/samsung/exynos_tmu.c
> index 75b3afadb5be..1ef90dc52c08 100644
> --- a/drivers/thermal/samsung/exynos_tmu.c
> +++ b/drivers/thermal/samsung/exynos_tmu.c
> @@ -1044,42 +1044,41 @@ static int exynos_tmu_probe(struct platform_device *pdev)
>  		dev_err(&pdev->dev, "Failed to get clock\n");
>  		ret = PTR_ERR(data->clk);
>  		goto err_sensor;
> -	}
> -
> -	data->clk_sec = devm_clk_get(&pdev->dev, "tmu_triminfo_apbif");
> -	if (IS_ERR(data->clk_sec)) {
> -		if (data->soc == SOC_ARCH_EXYNOS5420_TRIMINFO) {
> -			dev_err(&pdev->dev, "Failed to get triminfo clock\n");
> -			ret = PTR_ERR(data->clk_sec);
> -			goto err_sensor;
> -		}
>  	} else {
> -		ret = clk_prepare_enable(data->clk_sec);
> +		ret = clk_prepare_enable(data->clk);

This looks a bit odd. The clock was before taken unconditionally, not
within "else" branch...


Best regards,
Krzysztof
