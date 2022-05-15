Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 516EA5276A9
	for <lists+linux-pm@lfdr.de>; Sun, 15 May 2022 11:43:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236135AbiEOJnV (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 15 May 2022 05:43:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236119AbiEOJnU (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 15 May 2022 05:43:20 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35A49275C0
        for <linux-pm@vger.kernel.org>; Sun, 15 May 2022 02:43:19 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id a23so6854368ljd.9
        for <linux-pm@vger.kernel.org>; Sun, 15 May 2022 02:43:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=Pt6G3dPF8Zt8XeHJg2gaFEt91Dc0HgS53/V5velP1Sk=;
        b=ITlVUPlGfZyv+7a/EilVFVl1Gk1mFMaY2yhXbyWEGMyQip5275wed4ULnbdh0766mQ
         U3AB/Q1NKj/kGshg3RdXPoec0Hihn/G/+K8vE14Yf5VmhmpkRgvkuvR6Yq5N7Vrc69TE
         q2eLiI8XtdoynDJGe0jnomFiwA/zNa6rJTUoMHqWSbUGlID6Ve2pPuWcYhY3F4K9YmeO
         mK0/6XhFd7UMBW3MnjhEr7wWy2h6zWW0HlZkNpwqu8g0QXKEcRAPPAd75Qjc0dAZ4Opi
         GG1tNEH3K+OC2P9d/noga7m6PLdhGOlVnoz3W+pKUxjqrABmYTsiZFNFR1EQXxM5H5tQ
         lw7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Pt6G3dPF8Zt8XeHJg2gaFEt91Dc0HgS53/V5velP1Sk=;
        b=qSLOKNmTEyDde2PUybFHAiBXfXA/Y/Gxyzzwzm7tNIJP5eoDIkjmOphQiYk+fKJH71
         SPKs64YGoZ65s8J8OU1GCAJMtQSPd/ykwJvsaUt/SUuwpyMXRaFw7KLno6Zpdmr+JaEo
         K+8s01fvzD+hucZ9/nhtgE5VVtulyWgE5nAQKial99rolXYJK9oCpB6uzMaTA42bEOmw
         Z/fn8nXSYYLAKnhOEOfeogfsTlDgalKkoOTlb7NgMfVI+Kb3xK+5hPlb9bHUmojPjm8i
         YOvC2iiJQLLx8sRgMJCzoeVMQOhOPYXfmiIgofhYDsXnKgS415/JuBW2/6n11ULq8mDo
         E6PA==
X-Gm-Message-State: AOAM532PbKbtEKmK6WFkPCtuswN/634zbGrh+3Wf3p492FUUZRgoXjdW
        dh9XL7fNdjpemdCsUTaRblzPhw==
X-Google-Smtp-Source: ABdhPJwA2OhaOBCwKTPixvleagueOpD+Za/kYH7EQQd3X2W4nG6luGi2OVIczI+WHbzlEGeGmCFpXw==
X-Received: by 2002:a05:651c:1684:b0:250:c5ec:bc32 with SMTP id bd4-20020a05651c168400b00250c5ecbc32mr8133343ljb.92.1652607797625;
        Sun, 15 May 2022 02:43:17 -0700 (PDT)
Received: from [192.168.0.17] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id k15-20020a2eb74f000000b0024f3d1daee3sm1099269ljo.107.2022.05.15.02.43.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 15 May 2022 02:43:17 -0700 (PDT)
Message-ID: <7c479bdb-4bf7-68a5-c6e7-20dc19b91dc8@linaro.org>
Date:   Sun, 15 May 2022 11:43:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCHv2 3/6] thermal: exynos: Check before
 clk_disable_unprepare() not needed
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
 <20220515064126.1424-4-linux.amoon@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220515064126.1424-4-linux.amoon@gmail.com>
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
> All code in clk_disable_unprepare() already checks the clk ptr using
> IS_ERR_OR_NULL so there is no need to check it again before calling it.
> A lot of other drivers already rely on this behaviour, so it's safe
> to do so here.
> 
> Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> ---
> v1: improve the commit message
> ---
>  drivers/thermal/samsung/exynos_tmu.c | 12 ++++--------
>  1 file changed, 4 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/thermal/samsung/exynos_tmu.c b/drivers/thermal/samsung/exynos_tmu.c
> index 1ef90dc52c08..58ff1b577c47 100644
> --- a/drivers/thermal/samsung/exynos_tmu.c
> +++ b/drivers/thermal/samsung/exynos_tmu.c
> @@ -289,8 +289,7 @@ static int exynos_tmu_initialize(struct platform_device *pdev)
>  
>  	mutex_lock(&data->lock);
>  	clk_enable(data->clk);
> -	if (!IS_ERR(data->clk_sec))
> -		clk_enable(data->clk_sec);
> +	clk_enable(data->clk_sec);

You say that clk_enable() checks for IS_ERR_OR_NULL. Where? I see only
check for non-null case and then immediately taking clk prepare lock.

This looks buggy... did you test it?

Best regards,
Krzysztof
