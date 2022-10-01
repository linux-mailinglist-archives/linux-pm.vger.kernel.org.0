Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 460A15F1A83
	for <lists+linux-pm@lfdr.de>; Sat,  1 Oct 2022 09:13:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229561AbiJAHNi (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 1 Oct 2022 03:13:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbiJAHNg (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 1 Oct 2022 03:13:36 -0400
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com [IPv6:2607:f8b0:4864:20::112e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46C1AC746D
        for <linux-pm@vger.kernel.org>; Sat,  1 Oct 2022 00:13:35 -0700 (PDT)
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-35711e5a5ceso23990247b3.13
        for <linux-pm@vger.kernel.org>; Sat, 01 Oct 2022 00:13:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=kHHAs8z9o03GW97wZcdGSq147rwO8mX8P39g1geDY7Y=;
        b=HmNj8+Qu+jozDXBHZ3WMI7lUi35CuBJ+wsS7hlPf4hcsx8ch6gKLu3B0soytiyI8hR
         FoBpedxs4nZZrsnIw8fyTeQJ17y36rINCMmqNqVYWu0v7qXY5QoQFm77KKrOItlDy01z
         vWLKRue2pFi2VvDhnVvlNYym3fJrEwliWyJ8cidhaguHONl24D+cY1riqeTSs7sTn2uB
         nPEYCFosEDYsnB/IShHF7/LmaNZ6DtZvbm0OJ+knk46cv6o49224hCRbVyx/oNiN9gSz
         JakMwswkh9p0HtRuWkR64y9rN5VuVsK9kLQPLHlbHn9KL5mAggIOeXkE6bARNYx6c8r6
         itXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=kHHAs8z9o03GW97wZcdGSq147rwO8mX8P39g1geDY7Y=;
        b=ZwBbJ8G6Lk+xuloHRxYCzDAQw13iS6iBJVaUHb4VOHXRCZUrA2kpMopnfXMuzgsWsM
         eBUNZeAooxaW7QLC+ISeA3FhFnaRM7AZPDH6wBcJ4j59Z4NOgZan1TFtMSdvfA7tmI+B
         ttgb2+jQf0LVeuYJwC6K5LW7K/Dp0SxZaulTNxoan4kb9P1SyNFPm5mgqcI93PvE2BEW
         +mh2BetplFA5JJ/wThgVjQnOYV1vA7cRgdmN3gFz33UMIB6+u5PDvcyAi95bYcljcIlE
         CiakkTesaqfTRCbFjMmkEJCqNP/G+tJRwr+rSHC7J5T0da0n7dCuNqyA3GMX9svZSOPw
         rH2g==
X-Gm-Message-State: ACrzQf1QCdGb9Y8QE6gH/1ie4jGM+ND5kVxJAolyu9AXWCicLcIjeNvi
        u/N6KgU9aexfJdhX3NQdpO2EBzfd7t5pjWYPg+UVjw==
X-Google-Smtp-Source: AMsMyM5YuSPt8VxqmgnoLZzJmw0xHS9SQrJHd4MrI2PzZBCWU1QUan+joBtvnZfU84wUHG+k+5488i3G0pI9PdE0AGc=
X-Received: by 2002:a0d:f685:0:b0:343:bd3d:80b2 with SMTP id
 g127-20020a0df685000000b00343bd3d80b2mr11152029ywf.485.1664608414462; Sat, 01
 Oct 2022 00:13:34 -0700 (PDT)
MIME-Version: 1.0
References: <20221001030602.28232-1-quic_molvera@quicinc.com> <20221001030602.28232-3-quic_molvera@quicinc.com>
In-Reply-To: <20221001030602.28232-3-quic_molvera@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Sat, 1 Oct 2022 10:13:23 +0300
Message-ID: <CAA8EJpopGgmThv1BUHAP-bYsgm-ojF0FJ_KVNgycwOAOj=_D4g@mail.gmail.com>
Subject: Re: [PATCH 2/2] interconnect: qcom: Add QDU1000/QRU1000 interconnect driver
To:     Melody Olvera <quic_molvera@quicinc.com>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Georgi Djakov <djakov@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sat, 1 Oct 2022 at 06:08, Melody Olvera <quic_molvera@quicinc.com> wrote:
>
> Add interconnect provider driver for Qualcomm QDU1000 and QRU1000
> platforms.
>
> Signed-off-by: Melody Olvera <quic_molvera@quicinc.com>
> ---
>  drivers/interconnect/qcom/Kconfig    |    9 +
>  drivers/interconnect/qcom/Makefile   |    2 +
>  drivers/interconnect/qcom/qdru1000.c | 1091 ++++++++++++++++++++++++++
>  drivers/interconnect/qcom/qdru1000.h |   95 +++
>  4 files changed, 1197 insertions(+)
>  create mode 100644 drivers/interconnect/qcom/qdru1000.c
>  create mode 100644 drivers/interconnect/qcom/qdru1000.h
>
> diff --git a/drivers/interconnect/qcom/Kconfig b/drivers/interconnect/qcom/Kconfig
> index 25d5b4baf6f6..760f855d7618 100644
> --- a/drivers/interconnect/qcom/Kconfig
> +++ b/drivers/interconnect/qcom/Kconfig
> @@ -200,5 +200,14 @@ config INTERCONNECT_QCOM_SM8450
>           This is a driver for the Qualcomm Network-on-Chip on SM8450-based
>           platforms.
>
> +config INTERCONNECT_QCOM_QDRU1000
> +       tristate "Qualcomm QDU1000/QRU1000 interconnect driver"
> +       depends on INTERCONNECT_QCOM_RPMH_POSSIBLE
> +       select INTERCONNECT_QCOM_RPMH
> +       select INTERCONNECT_QCOM_BCM_VOTER
> +       help
> +         This is a driver for the Qualcomm Network-on-Chip on QDU1000-based
> +         and QRU1000-based platforms.
> +
>  config INTERCONNECT_QCOM_SMD_RPM
>         tristate
> diff --git a/drivers/interconnect/qcom/Makefile b/drivers/interconnect/qcom/Makefile
> index 8e357528185d..85b7f0de473d 100644
> --- a/drivers/interconnect/qcom/Makefile
> +++ b/drivers/interconnect/qcom/Makefile
> @@ -25,6 +25,7 @@ qnoc-sm8150-objs                      := sm8150.o
>  qnoc-sm8250-objs                       := sm8250.o
>  qnoc-sm8350-objs                       := sm8350.o
>  qnoc-sm8450-objs                       := sm8450.o
> +qnoc-qdru1000-objs                     := qdru1000.o

Alphabetic sorting

>  icc-smd-rpm-objs                       := smd-rpm.o icc-rpm.o
>
>  obj-$(CONFIG_INTERCONNECT_QCOM_BCM_VOTER) += icc-bcm-voter.o
> @@ -49,4 +50,5 @@ obj-$(CONFIG_INTERCONNECT_QCOM_SM8150) += qnoc-sm8150.o
>  obj-$(CONFIG_INTERCONNECT_QCOM_SM8250) += qnoc-sm8250.o
>  obj-$(CONFIG_INTERCONNECT_QCOM_SM8350) += qnoc-sm8350.o
>  obj-$(CONFIG_INTERCONNECT_QCOM_SM8450) += qnoc-sm8450.o
> +obj-$(CONFIG_INTERCONNECT_QCOM_QDRU1000) += qnoc-qdru1000.o

Alphabetic sorting.


-- 
With best wishes
Dmitry
