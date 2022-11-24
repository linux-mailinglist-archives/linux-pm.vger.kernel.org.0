Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5529463718C
	for <lists+linux-pm@lfdr.de>; Thu, 24 Nov 2022 05:47:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229576AbiKXEqy (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 23 Nov 2022 23:46:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbiKXEqx (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 23 Nov 2022 23:46:53 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDC1BC72FE
        for <linux-pm@vger.kernel.org>; Wed, 23 Nov 2022 20:46:51 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id b21so453798plc.9
        for <linux-pm@vger.kernel.org>; Wed, 23 Nov 2022 20:46:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Y3IlpfuO1l8t2ZxD1N0L8hvLviKdMAgzjTuRuOu9EfI=;
        b=jt4VHjitQ3Wup4CeA81dpRf+helm/+HSEGDQte2yD19KtMJQuglDaHUiLE7TajwUYm
         VnyAF7wZ60U3xHNBZCa+YMYFnVfdjvIXa0HYdmYFj0fELrJRVas4a04gEoYjxaqyJaRc
         tODpOS6kpov1qofx0XvuxMpRlhSPZHTkj957B+9gq5qtlVfm4sDLt3Jo/P20XzQgkaom
         yR4wtt4R0sC5gEb09zaCIOAiLJdqp3j80AdH/ee5Hai9hdEvW2QJ48EbZvBMG+9M8M77
         Y9yLpNURX/T+SglO8WgeAnPDEC32NxtpmaaSyIOcQAi/189sf2oHPPBNvutwlKwkyWf5
         VHsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y3IlpfuO1l8t2ZxD1N0L8hvLviKdMAgzjTuRuOu9EfI=;
        b=Z8EIRrDQdQERkXhGA34Cq40vxYMU7Zvx/Urp7eigdERPmjZGLmtHMbkCrCE+woyqa0
         hWVZzp7OYygG2jXS0m+XDfSs/wbGs/Ukhhq6NRXso25tKO3MYXxIIzt0MuTp3JhL/0q6
         38PawJWrPV51yKHCg8K98J2mzNAytzbzpEGdRk+aVRglzASxiJl/YY0Lc4h+sJPzLMyQ
         krV8o9fxNi8NTTDeGv7TIaplpncAS+P51ySafjrAKBRmOKaQIe0vzIZpINdn6/qqDZKx
         Ugb6kuD1XCvJZmCSV9gZJtKiKamYpp4avjmqWWOkaZPcJr58a1dP5qSjYpHyYwGRLiZ4
         PX2A==
X-Gm-Message-State: ANoB5plf/WgckscDcOBRYs0nV4QmxAjx7cBPzst+4Xx0Jm9eEHDaXez5
        VDPKz6MP8rFtudv+h7kn0naYIg==
X-Google-Smtp-Source: AA0mqf5wSUfcVmtCaOghYE2CChe2y1omuEl5yFobMM31OPYVNfwTr0+yTaLBrJyDRXDiOv9xXB/jBg==
X-Received: by 2002:a17:90b:2689:b0:218:a059:1c71 with SMTP id pl9-20020a17090b268900b00218a0591c71mr22749395pjb.7.1669265211316;
        Wed, 23 Nov 2022 20:46:51 -0800 (PST)
Received: from localhost ([122.172.85.60])
        by smtp.gmail.com with ESMTPSA id w27-20020aa7955b000000b00574759d2143sm115627pfq.51.2022.11.23.20.46.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Nov 2022 20:46:50 -0800 (PST)
Date:   Thu, 24 Nov 2022 10:16:43 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Xiu Jianfeng <xiujianfeng@huawei.com>
Cc:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        rafael@kernel.org, mani@kernel.org, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] cpufreq: qcom-hw: Fix memory leak in
 qcom_cpufreq_hw_driver_probe()
Message-ID: <20221124044643.x2j7zxugdt6znstk@vireshk-i7>
References: <20221122124627.174403-1-xiujianfeng@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221122124627.174403-1-xiujianfeng@huawei.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 22-11-22, 20:46, Xiu Jianfeng wrote:
> If devm_clk_hw_register() fails, clk_init.name should be freed before
> return error, otherwise will cause memory leak issue, fix it.
> 
> Fixes: 84063a1cbe9e ("cpufreq: qcom-hw: Add CPU clock provider support")
> Signed-off-by: Xiu Jianfeng <xiujianfeng@huawei.com>
> ---
>  drivers/cpufreq/qcom-cpufreq-hw.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/cpufreq/qcom-cpufreq-hw.c b/drivers/cpufreq/qcom-cpufreq-hw.c
> index 1bd1e9ae5308..340fed35e45d 100644
> --- a/drivers/cpufreq/qcom-cpufreq-hw.c
> +++ b/drivers/cpufreq/qcom-cpufreq-hw.c
> @@ -723,6 +723,7 @@ static int qcom_cpufreq_hw_driver_probe(struct platform_device *pdev)
>  		ret = devm_clk_hw_register(dev, &data->cpu_clk);
>  		if (ret < 0) {
>  			dev_err(dev, "Failed to register clock %d: %d\n", i, ret);
> +			kfree(clk_init.name);
>  			return ret;
>  		}

Squashed with the original commit and added your SoB. Thanks.

-- 
viresh
