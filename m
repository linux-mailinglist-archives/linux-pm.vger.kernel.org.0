Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 265187B1380
	for <lists+linux-pm@lfdr.de>; Thu, 28 Sep 2023 09:05:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230308AbjI1HFa (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 28 Sep 2023 03:05:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230081AbjI1HF3 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 28 Sep 2023 03:05:29 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED2DABF
        for <linux-pm@vger.kernel.org>; Thu, 28 Sep 2023 00:05:24 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id ffacd0b85a97d-3231df68584so8521060f8f.1
        for <linux-pm@vger.kernel.org>; Thu, 28 Sep 2023 00:05:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695884723; x=1696489523; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JK5FKcmSKFk/poFkH6WaIiPHJq3+6nK77MGlhBlv5xc=;
        b=eMabU90bnM4dFTt5f8JHuzgfBY/en3tQqKF4Kyc1cADJDDJyL/JlrMz6oDwWn4w0n1
         KvmDxZSpD3c8I2zwFi4kb1IgaLIkYod90qxoriKKlmIAFeVFRmu0ZLR4L4goNGCH0uwg
         FNkT6/RjOx6tua2r4wJzKDXFn8avoK8jQhkRxQGAAfP2YqQ96G9CT0vA9FOvAD5fwrcL
         DJn1rJWcRSkY5w+YLdmqtZRTM1qbpU3klvi9UwZBY87CW+AJMt/3ABHiKC6jt9a+0L9P
         5d5LbrEyTRGp2IQ7jmWZ/QYJjSCCZOkQ8AmqiFHPnzxrAu6Li0E3pc/nU4313SerGrfH
         un8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695884723; x=1696489523;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JK5FKcmSKFk/poFkH6WaIiPHJq3+6nK77MGlhBlv5xc=;
        b=kazgqYXLcKN4kZ+YU0e6f6sOFFSCsT+OgAY7t9Dqo/k4s6WWbXLdFIsrspEicrXfj2
         sKfQDdgeCrozTMmwLLVfsaeAczp49/syCpJN6qPlAYd6c0rqZcErSUpexpghqr+dmnnY
         QP6NyNdWHZNrxlNfS7tZ3mN/E4ghJzDFTawHho0sc9MYRZzErt5ThCJ2MzCPdGk6oHW6
         /fMaejx7rlbrO4eSaXGtIPiNIzQKfjiVhLkR56X3HXMXvguKKonBxUQaMFovxSUWT5Ck
         WOIO4lH4o/4mJDNz1WfS8A3t+KiOqra6CYnEQuNWcd8euMwOOTmM/ZgRkfjKT6yfgZkZ
         X5AQ==
X-Gm-Message-State: AOJu0YwhilSwWcsthq4iy6591OCPGi8D/GHLT6JsrS74QfMW/t1kjvZQ
        YUR19Uu3EO6c7aDSyb6JztCU9A==
X-Google-Smtp-Source: AGHT+IHtRxKk7CXcPNdMQTTEBVfCDemBFx4pebeQoAgF8nP7IxdEu3s1ozmEdmztrqIM2F97b6iYUw==
X-Received: by 2002:a5d:5b17:0:b0:31f:a4fa:130a with SMTP id bx23-20020a5d5b17000000b0031fa4fa130amr465227wrb.14.1695884723076;
        Thu, 28 Sep 2023 00:05:23 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:c49e:e1a5:3210:b8c0? ([2a05:6e02:1041:c10:c49e:e1a5:3210:b8c0])
        by smtp.googlemail.com with ESMTPSA id bv19-20020a0560001f1300b0032327b70ef6sm10037825wrb.70.2023.09.28.00.05.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Sep 2023 00:05:22 -0700 (PDT)
Message-ID: <d8515a00-4d41-2d23-09ca-30f474fcbabd@linaro.org>
Date:   Thu, 28 Sep 2023 09:05:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 00/31] thermal: Convert to platform remove callback
 returning void
Content-Language: en-US
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     Guillaume La Roque <glaroque@baylibre.com>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org,
        linux-amlogic@lists.infradead.org, kernel@pengutronix.de,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        =?UTF-8?Q?Niklas_S=c3=b6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>,
        Heiko Stuebner <heiko@sntech.de>,
        ye xingchen <ye.xingchen@zte.com.cn>,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        Balsam CHIHI <bchihi@baylibre.com>,
        Adam Ward <DLG-Adam.Ward.opensource@dm.renesas.com>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Support Opensource <support.opensource@diasemi.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Yang Yingliang <yangyingliang@huawei.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= 
        <nfraprado@collabora.com>,
        Alexandre Mergnat <amergnat@baylibre.com>,
        Chen-Yu Tsai <wenst@chromium.org>,
        Chen Jiahao <chenjiahao16@huawei.com>,
        linux-mediatek@lists.infradead.org,
        Thara Gopinath <thara.gopinath@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org,
        =?UTF-8?Q?Niklas_S=c3=b6derlund?= <niklas.soderlund@ragnatech.se>,
        linux-renesas-soc@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        linux-samsung-soc@vger.kernel.org,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Rob Herring <robh@kernel.org>,
        Minghao Chi <chi.minghao@zte.com.cn>,
        linux-stm32@st-md-mailman.stormreply.com,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Johan Hovold <johan+linaro@kernel.org>,
        linux-tegra@vger.kernel.org,
        Mikko Perttunen <mperttunen@nvidia.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Keerthy <j-keerthy@ti.com>, linux-omap@vger.kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>
References: <20230927193736.2236447-1-u.kleine-koenig@pengutronix.de>
 <CAJZ5v0guyQ-SpNHXYBG2F_WyCSvgjXocGBy61Ep1Cy5-H-MOsQ@mail.gmail.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <CAJZ5v0guyQ-SpNHXYBG2F_WyCSvgjXocGBy61Ep1Cy5-H-MOsQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 27/09/2023 21:45, Rafael J. Wysocki wrote:
> Hi,
> 
> On Wed, Sep 27, 2023 at 9:38 PM Uwe Kleine-König
> <u.kleine-koenig@pengutronix.de> wrote:
>>
>> Hello,
>>
>> this series converts all platform drivers below drivers/thermal to use
>> .remove_new(). The motivation is to get rid of an integer return code
>> that is (mostly) ignored by the platform driver core and error prone on
>> the driver side.
>>
>> See commit 5c5a7680e67b ("platform: Provide a remove callback that
>> returns no value") for an extended explanation and the eventual goal.
>>
>> There are no interdependencies between the patches. As there are still
>> quite a few drivers to convert, I'm happy about every patch that makes
>> it in. So even if there is a merge conflict with one patch until you
>> apply or a subject prefix is suboptimal, please apply the remainder of
>> this series anyhow.
> 
> I think I'll go ahead and apply all of this in one go (for 6.7).
> 
> Daniel, any objections?

No objection, for the series:

Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

