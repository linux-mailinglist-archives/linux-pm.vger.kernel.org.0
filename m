Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D84626650BA
	for <lists+linux-pm@lfdr.de>; Wed, 11 Jan 2023 01:57:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233981AbjAKA51 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 10 Jan 2023 19:57:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231853AbjAKA50 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 10 Jan 2023 19:57:26 -0500
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E6E15005C;
        Tue, 10 Jan 2023 16:57:22 -0800 (PST)
Received: by mail-io1-xd2c.google.com with SMTP id h6so6965689iof.9;
        Tue, 10 Jan 2023 16:57:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xGqHIyp6cnKLvffx+mW9TGvUeUClSMPnbrvibeZXH5c=;
        b=bliib5A9s/Vhj2Mc8/7xUPI0hs0mwPdlWK4ts1HZR15BvK9MG/h7yoV08ct9Z5G0u8
         YObuE8adylVaoM2ln3MzMV3EvMvRvzAQqxOufVJbcKL+b/Si0ekdJTG8480p8XuE4ZvW
         G4LCyQBJeZ/vnA1R6W1cTE2Nm+swL3a54nJNKaVGeQlDPtysW8CPnXHMoM8+Bl7+vePs
         yHwc2EmWWNu/fKNDd96Qe8CAxrOmD+2QVOuTsisF69EheWH6SYKCNfsl20uX1CCtnF+h
         tAYGtAEtGJh9HN6N/N3HsQhcPZ7AFVE+mt1MAfvN/ktgeB2vTlqyYZ1eOcG8RhAjnW0U
         OXvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xGqHIyp6cnKLvffx+mW9TGvUeUClSMPnbrvibeZXH5c=;
        b=KtEo2Bp1C9U8u2ZiArnuAetbDtbEOsWJLLWRR+bvuyeRP7hYd761gbzJsDGw8grc60
         jNOUI1Glak8CwPxAC4giis5Vy9UIM/BkUXoFMgNrRcc25iVSDW6u7ZuOIvxgOaJplClE
         Ce8tpPdSMt1pncvqGlZgJvDGda3bxHpNIdQiuKqF0OtafXGDLFoiJ2BApU3QU9T2NHex
         WGKZGGO/1dHiAyWuZ6/sEAaPIKwHNNENhtxksS8TSZrIUfjw8rNvsfR2dpGmqfc0whjH
         MuI/iu0kUcelU+LP3hMCImFqSllzyYD/LUX4YxPnjUJ6jUI5y8joPt5qKhF/I7EQau2e
         NmgA==
X-Gm-Message-State: AFqh2kqlKpRlC1vOCdxU3uRYgCC45+akwyF+nKKCxOsmdlFYjSsRvk9w
        IjelLMm6OmQamNNn4TkUBJU=
X-Google-Smtp-Source: AMrXdXvKkUP1SHauKZ6vRwaKXWlnQ8stGsoUe1XxagOtazi5b2jS3o6JgsaNjLwFmSscwhd0TN2W8g==
X-Received: by 2002:a6b:8e83:0:b0:6de:9711:9962 with SMTP id q125-20020a6b8e83000000b006de97119962mr505971iod.5.1673398641716;
        Tue, 10 Jan 2023 16:57:21 -0800 (PST)
Received: from localhost ([2607:fea8:a2df:3d00::11ab])
        by smtp.gmail.com with ESMTPSA id g15-20020a02850f000000b0039ea1677a45sm455288jai.9.2023.01.10.16.57.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jan 2023 16:57:21 -0800 (PST)
Date:   Tue, 10 Jan 2023 19:57:19 -0500
From:   Richard Acayan <mailingradian@gmail.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Georgi Djakov <djakov@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     Odelu Kukatla <quic_okukatla@quicinc.com>,
        Luca Weiss <luca@z3ntu.xyz>,
        Richard Acayan <mailingradian@gmail.com>
Subject: Re: [PATCH v4 0/4] SDM670 Interconnects
Message-ID: <Y74Jb3PXt49NR93K@radian>
References: <20230111005155.50452-1-mailingradian@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230111005155.50452-1-mailingradian@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Jan 10, 2023 at 07:51:51PM -0500, Richard Acayan wrote:
> Changes since v3:
>  - fix a merge conflict on linux-next (1/4)
This conflict is caused by fae28c82bbbd ("dt-bindings: interconnect:
split SC8280XP to own schema"), so it now depends on:

https://lore.kernel.org/r/20221223132040.80858-2-krzysztof.kozlowski@linaro.org

> 
> Changes since v2:
>  - change qcom,sdm670.h to qcom,sdm670-rpmh.h (2/4)
>  - use SPDX v3 license identifiers (1/4, 2/4)
>  - accumulate ack tag (1/4)
>  - format changelog (0/4)
> 
> Changes since v1:
>  - change qcom,sdm670.h to qcom,sdm670-rpmh.h (1/4, 4/4)
> 
> This series adds interconnects and consumers to the Snapdragon 670.
> 
> Richard Acayan (4):
>   dt-bindings: interconnect: add sdm670 interconnects
>   interconnect: qcom: add sdm670 interconnects
>   arm64: dts: qcom: sdm670: add interconnects
>   arm64: dts: qcom: sdm670: add opps for peripherals
> 
>  .../bindings/interconnect/qcom,rpmh.yaml      |   8 +
>  arch/arm64/boot/dts/qcom/sdm670.dtsi          | 165 +++++++
>  drivers/interconnect/qcom/Kconfig             |   9 +
>  drivers/interconnect/qcom/Makefile            |   2 +
>  drivers/interconnect/qcom/sdm670.c            | 440 ++++++++++++++++++
>  drivers/interconnect/qcom/sdm670.h            | 128 +++++
>  .../interconnect/qcom,sdm670-rpmh.h           | 136 ++++++
>  7 files changed, 888 insertions(+)
>  create mode 100644 drivers/interconnect/qcom/sdm670.c
>  create mode 100644 drivers/interconnect/qcom/sdm670.h
>  create mode 100644 include/dt-bindings/interconnect/qcom,sdm670-rpmh.h
> 
> -- 
> 2.39.0
> 
