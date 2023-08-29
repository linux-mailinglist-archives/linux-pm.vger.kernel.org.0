Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 225B978C1BE
	for <lists+linux-pm@lfdr.de>; Tue, 29 Aug 2023 11:52:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234499AbjH2Jv4 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 29 Aug 2023 05:51:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234940AbjH2Jvz (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 29 Aug 2023 05:51:55 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2543EC
        for <linux-pm@vger.kernel.org>; Tue, 29 Aug 2023 02:51:51 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-9a5be3166a2so191575766b.1
        for <linux-pm@vger.kernel.org>; Tue, 29 Aug 2023 02:51:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693302710; x=1693907510;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mpZOvmtn/uBflk6UybG+LvnSX9jdUkyMKQebc/rvrZU=;
        b=k8Jpl+T/nVE735bxJtvutdmgAHlJzhxATj53E0fbQBJzzqiwTEJT/5XdSfpU15UDBd
         NwTzq0gRFx7x83pnPe1NaEglOkzxXuZSzOI9E/G33syssQok6GKFaghyaWHWAAC4tkTs
         o/r9q8MnybrwrIpTox/ign049K0ThTIJwOgLSuMDFryT5DulQ48DEO6YA7zbsRJfoba+
         0E9aOqG7fSp8auH9xK1M97yl6NJb4EB60YleWTQ0UJY2PRVCT6cqZAQHTeQK7M0ZG0zJ
         kkOJ70ZTBd3q+umTLG3LG1RSa8MOBNwasd2/i/tJrH6e6v9P4YsAbtC+Z1mEflaVMgQB
         dz3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693302710; x=1693907510;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mpZOvmtn/uBflk6UybG+LvnSX9jdUkyMKQebc/rvrZU=;
        b=ZqGSaV3/DA5wBubemkKt/OSCBJV31pegdMIYKoo7DZqkJKpvSbzWYvCZ0zcEDmGKwt
         V3DCU8++Q8xoTUwuCQ7mSyUz2wcIxNTigv6NBlD8z02SJBF1ex6V3s/AON5W3X0PXrhE
         CDUbLzfCex8J3G13eGCLyUDy+BMBa/ZQdNiGqJ8O7IRU0BzclH1fH+5wJq6/zcSDpr9C
         QPsb0jXODE3kiVtAtK0Y0K4PrUPBwzDQ39CUIoUkHESsmh095/BSpyF8hxmsAeFwJEeZ
         s0Nh9f9XAKUIqU/9Eel0iZWMB6Gy2Nx+fxxm+CR1jxxacILpmBv/TgY9Lk/7bhnu2t1x
         IEgA==
X-Gm-Message-State: AOJu0YzyT5dDyZp0c+9Lw8Y9flcvOUaQ9t+B9+WHjb1KkdwYPlo7Qe3Q
        5fEvv1ijrDQd3IOhgXHRkdWkDw==
X-Google-Smtp-Source: AGHT+IFUiV8p/ANbFTNC9RIN/3r4iqb4l6G/ZsoMzvfM4AkWJBdPw90kH5yF7d7rR4Roq+3CcYVclg==
X-Received: by 2002:a17:906:530c:b0:9a5:8155:6de with SMTP id h12-20020a170906530c00b009a5815506demr7288568ejo.45.1693302709860;
        Tue, 29 Aug 2023 02:51:49 -0700 (PDT)
Received: from [192.168.0.22] ([77.252.47.196])
        by smtp.gmail.com with ESMTPSA id d16-20020a1709061f5000b009931a3adf64sm5857775ejk.17.2023.08.29.02.51.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Aug 2023 02:51:49 -0700 (PDT)
Message-ID: <0cb5fbd9-083f-8db7-e850-fcda9817bd23@linaro.org>
Date:   Tue, 29 Aug 2023 11:51:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH 03/11] thermal: exynos: switch from workqueue-driven
 interrupt handling to threaded interrupts
Content-Language: en-US
To:     Mateusz Majewski <m.majewski2@samsung.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>
References: <20230829091853.626011-1-m.majewski2@samsung.com>
 <CGME20230829092410eucas1p243a88662e8e64f0c406685931d9a80a3@eucas1p2.samsung.com>
 <20230829091853.626011-4-m.majewski2@samsung.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230829091853.626011-4-m.majewski2@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 29/08/2023 11:18, Mateusz Majewski wrote:
> The workqueue boilerplate is mostly one-to-one what the threaded
> interrupts do.
> 
> Signed-off-by: Mateusz Majewski <m.majewski2@samsung.com>


>  	data->clk = devm_clk_get(&pdev->dev, "tmu_apbif");
>  	if (IS_ERR(data->clk)) {
>  		dev_err(&pdev->dev, "Failed to get clock\n");
> @@ -1094,8 +1080,10 @@ static int exynos_tmu_probe(struct platform_device *pdev)
>  		goto err_sclk;
>  	}
>  
> -	ret = devm_request_irq(&pdev->dev, data->irq, exynos_tmu_irq,
> -		IRQF_TRIGGER_RISING | IRQF_SHARED, dev_name(&pdev->dev), data);
> +	ret = devm_request_threaded_irq(
> +		&pdev->dev, data->irq, NULL, exynos_tmu_threaded_irq,

This does not look properly aligned.

Best regards,
Krzysztof

