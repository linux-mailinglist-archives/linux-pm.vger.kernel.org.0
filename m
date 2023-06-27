Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41CE073F5E8
	for <lists+linux-pm@lfdr.de>; Tue, 27 Jun 2023 09:44:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231202AbjF0HoD (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 27 Jun 2023 03:44:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230054AbjF0HoC (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 27 Jun 2023 03:44:02 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1F4510C9
        for <linux-pm@vger.kernel.org>; Tue, 27 Jun 2023 00:44:00 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-4f957a45b10so5507404e87.0
        for <linux-pm@vger.kernel.org>; Tue, 27 Jun 2023 00:44:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687851839; x=1690443839;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nXDjy7JPJ8XrZiw8dYtuA9M7FtFKUmW4GijlGMiZDeo=;
        b=W3StrIEt1NsXEWvdU5avGU95Enq3cbFYCcn4JQnVWeuR2OJCVzshq5XVbRERJWATTj
         a8gTuNq+u+zQTtVHVlxCyJhcjzGRjssWWYa18rsYhWT5uM9hOtRtst7HejvUCbqZ9b6U
         oBLhEK3ey+uadLyH3jqFHft76Hup2g93+m5WYHqveVWRtmePCFkN+4j5sJ9GDFM4Es8X
         OdXG1uZChre1Rw0EPQGwd8DTHS9Tw2mPeNoAlu4qfwnbKprxnJ7GDcvEt9NC5IkZSfrh
         Up8W3fdSXm5G/T2XZcqeOIo6DdRVHrwqkx6R8Eu7VZs1I+uQ9V8bQ4PbTI/hPhZT9Zo8
         eLtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687851839; x=1690443839;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nXDjy7JPJ8XrZiw8dYtuA9M7FtFKUmW4GijlGMiZDeo=;
        b=Mc4k2uOMvUcV4rtJ+/blO/ZMjeIJ32iznJTy9YO8KEWH3Ff2iAxnUlYqdeGDnl/K5x
         +8ySfSmMLd85o0aq0XYqWUO0J9ksh0kZlnkZcIwK5D0Yx4r6xqAkVof3e1d5kswlUvH0
         8vWC89bG7MeijHyQNog76RFSB3VZeeUx9zxF7It2dwmiSKa4DAsoXxDkdkwheeSXmj3N
         kQuyxupTsF5BmNskjp4typ7e6VSIAjv+R/eg3kFpuva8RNcBhM2fk8y5lJdmWWK/4z64
         dJkFVimEK3yRNW+GFy+FR8Wigils5C3bfFVdHQs4mvZJ25d79Rq1SvEBEH2h3NJ2/3i5
         QyKg==
X-Gm-Message-State: AC+VfDzyhgmJGcnb0qtE2JgT90embTrb/7jMaojyd1X5OrGYWWIFXKxa
        ZlDpUpZgtIdXG27aEf7zobzcfg==
X-Google-Smtp-Source: ACHHUZ6qtmjN/vi/vgCBazSl8DAEcvTTiaFDRa2Iv5DYB3acC9xLxbjSTFmH5IakkXPbPPvl85v0lA==
X-Received: by 2002:a05:6512:3f1d:b0:4fa:ce08:a9d0 with SMTP id y29-20020a0565123f1d00b004face08a9d0mr4045130lfa.57.1687851838802;
        Tue, 27 Jun 2023 00:43:58 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id 21-20020a05600c22d500b003f9cb3c8958sm12898448wmg.3.2023.06.27.00.43.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Jun 2023 00:43:58 -0700 (PDT)
Message-ID: <82dc5efc-35fe-15ff-d0ea-e1a19da71c5c@linaro.org>
Date:   Tue, 27 Jun 2023 09:43:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 01/15] genirq/devres: Add error information printing for
 devm_request_threaded_irq()
To:     Yangtao Li <frank.li@vivo.com>, miquel.raynal@bootlin.com,
        rafael@kernel.org, daniel.lezcano@linaro.org, amitk@kernel.org,
        rui.zhang@intel.com, mmayer@broadcom.com,
        bcm-kernel-feedback-list@broadcom.com,
        florian.fainelli@broadcom.com, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, agross@kernel.org, andersson@kernel.org,
        konrad.dybcio@linaro.org, thara.gopinath@gmail.com,
        heiko@sntech.de, mcoquelin.stm32@gmail.com,
        alexandre.torgue@foss.st.com, thierry.reding@gmail.com,
        jonathanh@nvidia.com, tglx@linutronix.de, matthias.bgg@gmail.com,
        angelogioacchino.delregno@collabora.com,
        srinivas.pandruvada@linux.intel.com,
        DLG-Adam.Ward.opensource@dm.renesas.com, shangxiaojing@huawei.com,
        bchihi@baylibre.com, wenst@chromium.org,
        u.kleine-koenig@pengutronix.de, hayashi.kunihiko@socionext.com,
        niklas.soderlund+renesas@ragnatech.se, chi.minghao@zte.com.cn,
        johan+linaro@kernel.org, jernej.skrabec@gmail.com
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-tegra@vger.kernel.org, linux-mediatek@lists.infradead.org
References: <20230627071707.77659-1-frank.li@vivo.com>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230627071707.77659-1-frank.li@vivo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 27/06/2023 09:16, Yangtao Li wrote:
> Ensure that all error handling branches print error information. In this
> way, when this function fails, the upper-layer functions can directly
> return an error code without missing debugging information. Otherwise,
> the error message will be printed redundantly or missing.
> 
> There are more than 700 calls to the devm_request_threaded_irq method.
> If error messages are printed everywhere, more than 1000 lines of code
> can be saved by removing the msg in the driver.
> 
> Signed-off-by: Yangtao Li <frank.li@vivo.com>
> ---
>  kernel/irq/devres.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/irq/devres.c b/kernel/irq/devres.c
> index f6e5515ee077..94039a915218 100644
> --- a/kernel/irq/devres.c
> +++ b/kernel/irq/devres.c
> @@ -58,8 +58,10 @@ int devm_request_threaded_irq(struct device *dev, unsigned int irq,
>  
>  	dr = devres_alloc(devm_irq_release, sizeof(struct irq_devres),
>  			  GFP_KERNEL);
> -	if (!dr)
> +	if (!dr) {
> +		dev_err(dev, "Failed to allocate device resource data\n");

Just like any memory allocation, I don't think we print anything for
devres failures. Why do you think we should start doing it?

>  		return -ENOMEM;
> +	}
>  
>  	if (!devname)
>  		devname = dev_name(dev);
> @@ -67,6 +69,7 @@ int devm_request_threaded_irq(struct device *dev, unsigned int irq,
>  	rc = request_threaded_irq(irq, handler, thread_fn, irqflags, devname,
>  				  dev_id);
>  	if (rc) {
> +		dev_err(dev, "Failed to request threaded irq\n");

I don't like that one path - devm() managed - prints error, but regular
path does not. Code should be here consistent. Also error message is too
generic. You need to print at least irq number, maybe also devname?

Best regards,
Krzysztof

