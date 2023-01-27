Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5DC467DCD3
	for <lists+linux-pm@lfdr.de>; Fri, 27 Jan 2023 05:17:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232406AbjA0ERQ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 26 Jan 2023 23:17:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232229AbjA0ERP (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 26 Jan 2023 23:17:15 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94BEF7377C
        for <linux-pm@vger.kernel.org>; Thu, 26 Jan 2023 20:17:06 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id g23so3787888plq.12
        for <linux-pm@vger.kernel.org>; Thu, 26 Jan 2023 20:17:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=P7ZY02wnB++PrtjjVebywq2P+KdwsUUnvCgPrCN1viE=;
        b=O1dz04cJ9kZB389iORyVGSppE1KZyeImi1gkXdGZe+K6gTCkXMDsrzWFY/B1rG4uZY
         WsPe9B61kEKUrWaOtn/KkG6VGyorkeI4CgGpvzq6csEgwlPPcRRrjzHlnFBjGsjXGswi
         oT6I1R0Xe+hMpv8JH4B+88d1P/RDoM0LUxCyqEqup+80+okrXb4RLJEhfuYDlZOVDdk8
         F1yifj+oHz0wluaxO0aItc5lHE2nkkpE4zSGTePtL3m2rC97jKI7OdX6HI5d1++8Bo4R
         yFi8Lt5dD/yR+jk2yiQnLMmMnhDFfRBuyQ5mwGOyZNHEfWzjpnQukJwrjtnx+5aFNESG
         qMGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=P7ZY02wnB++PrtjjVebywq2P+KdwsUUnvCgPrCN1viE=;
        b=ebNRKwrWM2VLrELbc5v2+kRQvzMOUvfSgkPMHZ4cenkpYBMNfTl5tt/z78ZZfXsbrY
         7HeAA+xByxi0OobF1IskgktULq7jx5KTPTPYGJp8dveQpW1Tk5ensXEdDDrmeBVM7hiQ
         BAkpGTLH9np/ZSQ4lJ4HC9vgaka/WDj4UXrkNN778fYSTPn3jSv8H4Gf8/s1Vp1bgeX9
         YvhnXdbc/EEX6seWwdUyWekPa8XxMoXQlxQPYSonXyWWkFyY8O0cqEMlh8Ajq5NyEwpx
         jYnu16rKBUCdSkz2IYtv+M5RPGSoTOZAGeHx5U4UzQe9cxUWah10PAs8vsQrl37rctG7
         QFKQ==
X-Gm-Message-State: AFqh2koksvZx6f/90gaivj8lVq7CT7f8pC4cz4uQHdSXEVS+AKfkKzwE
        UXtJndkvKlDjMPhbJdVcOdMEeg29IFHvvfh9
X-Google-Smtp-Source: AMrXdXviEje4NBqjKMkEyy4TLr/lPqx6nBeGPG8VZTMVcSSpAEjb5nSV2Wrb7k5N2Pep7SUuznqsXg==
X-Received: by 2002:a17:902:6bc6:b0:194:9c69:290c with SMTP id m6-20020a1709026bc600b001949c69290cmr34716033plt.67.1674793026085;
        Thu, 26 Jan 2023 20:17:06 -0800 (PST)
Received: from localhost ([122.172.83.155])
        by smtp.gmail.com with ESMTPSA id x7-20020a1709029a4700b001949b915188sm1786613plv.12.2023.01.26.20.17.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jan 2023 20:17:05 -0800 (PST)
Date:   Fri, 27 Jan 2023 09:47:03 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     =?utf-8?B?TsOtY29sYXMgRi4gUi4gQS4=?= Prado 
        <nfraprado@collabora.com>
Cc:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, kernel@collabora.com,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH] cpufreq: mediatek-hw: Register to module device table
Message-ID: <20230127041703.325luwaf47topv4b@vireshk-i7>
References: <20230126154856.1322193-1-nfraprado@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230126154856.1322193-1-nfraprado@collabora.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 26-01-23, 10:48, Nícolas F. R. A. Prado wrote:
> Register the compatibles for this module on the module device table so
> it can be automatically loaded when a matching device is found on the
> system.
> 
> Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
> 
> ---
> 
>  drivers/cpufreq/mediatek-cpufreq-hw.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/cpufreq/mediatek-cpufreq-hw.c b/drivers/cpufreq/mediatek-cpufreq-hw.c
> index f80339779084..115b0eda38c1 100644
> --- a/drivers/cpufreq/mediatek-cpufreq-hw.c
> +++ b/drivers/cpufreq/mediatek-cpufreq-hw.c
> @@ -324,6 +324,7 @@ static const struct of_device_id mtk_cpufreq_hw_match[] = {
>  	{ .compatible = "mediatek,cpufreq-hw", .data = &cpufreq_mtk_offsets },
>  	{}
>  };
> +MODULE_DEVICE_TABLE(of, mtk_cpufreq_hw_match);
>  
>  static struct platform_driver mtk_cpufreq_hw_driver = {
>  	.probe = mtk_cpufreq_hw_driver_probe,

Applied. Thanks.

-- 
viresh
