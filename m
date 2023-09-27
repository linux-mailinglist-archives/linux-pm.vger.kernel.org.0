Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FB887B0CE3
	for <lists+linux-pm@lfdr.de>; Wed, 27 Sep 2023 21:45:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229460AbjI0Tpa convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pm@lfdr.de>); Wed, 27 Sep 2023 15:45:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjI0Tp3 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 27 Sep 2023 15:45:29 -0400
Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1254310E;
        Wed, 27 Sep 2023 12:45:26 -0700 (PDT)
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-57bf04841ccso490361eaf.0;
        Wed, 27 Sep 2023 12:45:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695843925; x=1696448725;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZdrldCq/11jLKtSHJnC0CV3/MzVWic6Gg0opWfLdlIY=;
        b=RqO4wDtEdl0t5BzX26SqxWEma6WzFCL1n+DVW7rYHhqklu9J69/EWU69vuxIP0Pu2g
         kaxxKS19niUHg6PpMwZ2pATH25Z4iTJTFtA7hJgpzKxnsBSJ6+5jeXvuOOJJMAHL4C5t
         zNAOZms1qG/EaZZgvbK8Iunupx7GE8l92qqi1BCnRvzDzSQfqlKvgpYZsaHXscX2HB38
         TnzaOo+iA/wNow9VO0i/3ZgDVMFSG+AQhiExjIKnM5+pjmxO9fjCIF91hUk3vfD4pYpm
         nwwtAdBLZdiE1GBzv9YZZbYyAPnZceNda83E9Tv/IEABthUtlz68ltsw/zs3QAZDQELW
         B32g==
X-Gm-Message-State: AOJu0YxmVLd+oQdKdUrCJCnOxH6z1fw9XC12KczXYSQ7XNOQ9u4FN7wF
        Kngo9hwuCaQHBBxJmfZiG4VYyfI36s04DbXduZ0=
X-Google-Smtp-Source: AGHT+IGMlW6Putl8V3MXq3RkAqHyCPJSNsGyuWiCwQkEk43f5FSeBHFESqXka7uzLRnNc/5oUKZ3iepgewdBHpsbPHk=
X-Received: by 2002:a4a:e704:0:b0:57b:94b7:c6ba with SMTP id
 y4-20020a4ae704000000b0057b94b7c6bamr3501682oou.0.1695843925125; Wed, 27 Sep
 2023 12:45:25 -0700 (PDT)
MIME-Version: 1.0
References: <20230927193736.2236447-1-u.kleine-koenig@pengutronix.de>
In-Reply-To: <20230927193736.2236447-1-u.kleine-koenig@pengutronix.de>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 27 Sep 2023 21:45:14 +0200
Message-ID: <CAJZ5v0guyQ-SpNHXYBG2F_WyCSvgjXocGBy61Ep1Cy5-H-MOsQ@mail.gmail.com>
Subject: Re: [PATCH 00/31] thermal: Convert to platform remove callback
 returning void
To:     =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Guillaume La Roque <glaroque@baylibre.com>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org,
        linux-amlogic@lists.infradead.org, kernel@pengutronix.de,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        =?UTF-8?Q?Niklas_S=C3=B6derlund?= 
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
        =?UTF-8?Q?Niklas_S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>,
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

On Wed, Sep 27, 2023 at 9:38 PM Uwe Kleine-König
<u.kleine-koenig@pengutronix.de> wrote:
>
> Hello,
>
> this series converts all platform drivers below drivers/thermal to use
> .remove_new(). The motivation is to get rid of an integer return code
> that is (mostly) ignored by the platform driver core and error prone on
> the driver side.
>
> See commit 5c5a7680e67b ("platform: Provide a remove callback that
> returns no value") for an extended explanation and the eventual goal.
>
> There are no interdependencies between the patches. As there are still
> quite a few drivers to convert, I'm happy about every patch that makes
> it in. So even if there is a merge conflict with one patch until you
> apply or a subject prefix is suboptimal, please apply the remainder of
> this series anyhow.

I think I'll go ahead and apply all of this in one go (for 6.7).

Daniel, any objections?


> Uwe Kleine-König (31):
>   thermal: amlogic: Convert to platform remove callback returning void
>   thermal: armada: Convert to platform remove callback returning void
>   thermal: bcm2835: Convert to platform remove callback returning void
>   thermal: ns: Convert to platform remove callback returning void
>   thermal: da9062: Convert to platform remove callback returning void
>   thermal: dove: Convert to platform remove callback returning void
>   thermal: hisi: Convert to platform remove callback returning void
>   thermal: imx8mm: Convert to platform remove callback returning void
>   thermal: imx: Convert to platform remove callback returning void
>   thermal: int3400: Convert to platform remove callback returning void
>   thermal: int3401: Convert to platform remove callback returning void
>   thermal: int3402: Convert to platform remove callback returning void
>   thermal: int3403: Convert to platform remove callback returning void
>   thermal: int3406: Convert to platform remove callback returning void
>   thermal: k3_bandgap: Convert to platform remove callback returning void
>   thermal: k3_j72xx_bandgap: Convert to platform remove callback returning void
>   thermal: kirkwood: Convert to platform remove callback returning void
>   thermal: lvts: Convert to platform remove callback returning void
>   thermal: tsens: Convert to platform remove callback returning void
>   thermal: rcar_gen3: Convert to platform remove callback returning void
>   thermal: rcar: Convert to platform remove callback returning void
>   thermal: rockchip: Convert to platform remove callback returning void
>   thermal: rzg2l: Convert to platform remove callback returning void
>   thermal: exynos_tmu: Convert to platform remove callback returning void
>   thermal: spear: Convert to platform remove callback returning void
>   thermal: sprd: Convert to platform remove callback returning void
>   thermal: stm: Convert to platform remove callback returning void
>   thermal: soctherm: Convert to platform remove callback returning void
>   thermal: tegra-bpmp: Convert to platform remove callback returning void
>   thermal: ti-bandgap: Convert to platform remove callback returning void
>   thermal: uniphier: Convert to platform remove callback returning void
>
>  drivers/thermal/amlogic_thermal.c                    | 12 +++++-------
>  drivers/thermal/armada_thermal.c                     |  6 ++----
>  drivers/thermal/broadcom/bcm2835_thermal.c           |  6 ++----
>  drivers/thermal/broadcom/ns-thermal.c                |  6 ++----
>  drivers/thermal/da9062-thermal.c                     |  5 ++---
>  drivers/thermal/dove_thermal.c                       |  6 ++----
>  drivers/thermal/hisi_thermal.c                       |  6 ++----
>  drivers/thermal/imx8mm_thermal.c                     |  6 ++----
>  drivers/thermal/imx_thermal.c                        |  6 ++----
>  .../thermal/intel/int340x_thermal/int3400_thermal.c  |  5 ++---
>  .../thermal/intel/int340x_thermal/int3401_thermal.c  |  6 ++----
>  .../thermal/intel/int340x_thermal/int3402_thermal.c  |  6 ++----
>  .../thermal/intel/int340x_thermal/int3403_thermal.c  |  6 ++----
>  .../thermal/intel/int340x_thermal/int3406_thermal.c  |  5 ++---
>  drivers/thermal/k3_bandgap.c                         |  6 ++----
>  drivers/thermal/k3_j72xx_bandgap.c                   |  6 ++----
>  drivers/thermal/kirkwood_thermal.c                   |  6 ++----
>  drivers/thermal/mediatek/lvts_thermal.c              |  6 ++----
>  drivers/thermal/qcom/tsens.c                         |  6 ++----
>  drivers/thermal/rcar_gen3_thermal.c                  |  6 ++----
>  drivers/thermal/rcar_thermal.c                       |  6 ++----
>  drivers/thermal/rockchip_thermal.c                   |  6 ++----
>  drivers/thermal/rzg2l_thermal.c                      |  6 ++----
>  drivers/thermal/samsung/exynos_tmu.c                 |  6 ++----
>  drivers/thermal/spear_thermal.c                      |  6 ++----
>  drivers/thermal/sprd_thermal.c                       |  5 ++---
>  drivers/thermal/st/stm_thermal.c                     |  6 ++----
>  drivers/thermal/tegra/soctherm.c                     |  6 ++----
>  drivers/thermal/tegra/tegra-bpmp-thermal.c           |  6 ++----
>  drivers/thermal/ti-soc-thermal/ti-bandgap.c          |  6 ++----
>  drivers/thermal/uniphier_thermal.c                   |  6 ++----
>  31 files changed, 65 insertions(+), 123 deletions(-)
>
> base-commit: 18030226a48de1fbfabf4ae16aaa2695a484254f
> --
> 2.40.1
>
