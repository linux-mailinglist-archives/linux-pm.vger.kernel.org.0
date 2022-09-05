Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5FAA5AD351
	for <lists+linux-pm@lfdr.de>; Mon,  5 Sep 2022 14:59:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237511AbiIEM5t (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 5 Sep 2022 08:57:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237491AbiIEM5q (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 5 Sep 2022 08:57:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 734BF20F61
        for <linux-pm@vger.kernel.org>; Mon,  5 Sep 2022 05:57:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E2CFF612A0
        for <linux-pm@vger.kernel.org>; Mon,  5 Sep 2022 12:57:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F1BCC43140
        for <linux-pm@vger.kernel.org>; Mon,  5 Sep 2022 12:57:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662382664;
        bh=2LopleuYkVPMOTSip8CWwYLWQWXAbn7FNeuEEoKh8Uk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=mOTyB9OmYUX2YxyIN4gORcDv2ZFFa4IUCarZBHl+KpDs7Y4FF9vgV/Fh5WuUqlZmf
         mgAPm7E7M72XsDGIGbyg7u/v4ZM0zASTSZVoPQZiCxNrI+1OLPx3H08BLkUhoaGpd5
         ec2icMeXHXsGyMG8msYK4ArVkxcZTu3F7PQU/FgmcfZO6t+C0UFQ5gcs8fWNNk5mbd
         /p3B3osxGP9vPwT/Lc/VNaApJ4+Kj9tgUxuFrcx4Mkk7AkTadx1/IIaRJQPx9weDsw
         sSrJF+zTWiNreEzx4a85Gumc+vfIMC5hk2S0trnF5M05flaHU8s+fYvCqsxiPbuDUr
         jj0Kg+7y4g8HA==
Received: by mail-lf1-f54.google.com with SMTP id br21so13116954lfb.0
        for <linux-pm@vger.kernel.org>; Mon, 05 Sep 2022 05:57:44 -0700 (PDT)
X-Gm-Message-State: ACgBeo21M5KYIWwfX/Igo9BfRxAdVPgp09lBmgz7snepUZf5IIcoHrxp
        LxNSTjFB+ChQqm+cyB4FhR0CDKM9tCoWAqR9SfWXTQ==
X-Google-Smtp-Source: AA6agR5kKACcc5Sb9c7D7rwYKKM6h5pvGfpnRaNoFCC2nHYpp3BKQRqqKMzP+HuIaLOicjrPhA+zt15V/Tc1MT6KCiE=
X-Received: by 2002:a05:6512:146:b0:494:6704:885a with SMTP id
 m6-20020a056512014600b004946704885amr11650534lfo.447.1662382662303; Mon, 05
 Sep 2022 05:57:42 -0700 (PDT)
MIME-Version: 1.0
References: <20220821160032.2206349-1-jic23@kernel.org>
In-Reply-To: <20220821160032.2206349-1-jic23@kernel.org>
From:   Amit Kucheria <amitk@kernel.org>
Date:   Mon, 5 Sep 2022 18:27:31 +0530
X-Gmail-Original-Message-ID: <CAHLCerOYALNuRLMMdrH=t8-zXLiy7v8eLdtuuhC+1XCPFBhrHg@mail.gmail.com>
Message-ID: <CAHLCerOYALNuRLMMdrH=t8-zXLiy7v8eLdtuuhC+1XCPFBhrHg@mail.gmail.com>
Subject: Re: [PATCH] thermal/drivers/qcom: Drop false build dependency of all
 QCOM drivers on QCOM_TSENS
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        Linux PM list <linux-pm@vger.kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Bhupesh Sharma <bhupesh.sharma@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sun, Aug 21, 2022 at 10:05 PM Jonathan Cameron <jic23@kernel.org> wrote:
>
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>
> The SPMI QCOM drivers have no dependency in Kconfig, but the Makefile
> will not be included without QCOM_TSENS. This unnecessarily reduces
> build coverage.
>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Cc: Bhupesh Sharma <bhupesh.sharma@linaro.org>

Acked-by: Amit Kucheria <amitk@kernel.org>

> ---
>
> Run into whilst trying to build test a namespace move for the IIO
> interfaces used in these drivers.
>
> Maintainers entry for TSENS should probably also be made more
> specific.
> ---
>  drivers/thermal/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/thermal/Makefile b/drivers/thermal/Makefile
> index def8e1a0399c..2506c6c8ca83 100644
> --- a/drivers/thermal/Makefile
> +++ b/drivers/thermal/Makefile
> @@ -52,7 +52,7 @@ obj-$(CONFIG_DA9062_THERMAL)  += da9062-thermal.o
>  obj-y                          += intel/
>  obj-$(CONFIG_TI_SOC_THERMAL)   += ti-soc-thermal/
>  obj-y                          += st/
> -obj-$(CONFIG_QCOM_TSENS)       += qcom/
> +obj-y                          += qcom/
>  obj-y                          += tegra/
>  obj-$(CONFIG_HISI_THERMAL)     += hisi_thermal.o
>  obj-$(CONFIG_MTK_THERMAL)      += mtk_thermal.o
> --
> 2.37.2
>
