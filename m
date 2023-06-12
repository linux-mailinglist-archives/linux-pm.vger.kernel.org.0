Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CA1772C815
	for <lists+linux-pm@lfdr.de>; Mon, 12 Jun 2023 16:21:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238046AbjFLOVS (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 12 Jun 2023 10:21:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240009AbjFLOUs (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 12 Jun 2023 10:20:48 -0400
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6D48422A
        for <linux-pm@vger.kernel.org>; Mon, 12 Jun 2023 07:18:23 -0700 (PDT)
Received: by mail-ot1-x330.google.com with SMTP id 46e09a7af769-6b16cbe4fb6so2930029a34.1
        for <linux-pm@vger.kernel.org>; Mon, 12 Jun 2023 07:18:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686579407; x=1689171407;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=3KEZk+7J6jH+5aotS2FyIOrhqYERHH/vUHWmZ4rNxhg=;
        b=bZn+CTs4P4E4qcCwjLB17/HmQbPIV+EwRKaOn23NbrEuaKywaKECFGxeDgst7oqsry
         8E98zn+lshy2NuH5ncrt0TPX773Fh3BUnKyZOJXTrb+aI0PfHvf5qUCxUFJbVl/XslS3
         +gsKNRFIbTVDnRADz5urtCDpqGMxa28zNgdKG1Vxj70c2LJ2QFJEBwG8LMn7suVLP8iw
         LefKkfedKJhJ1lcUFm17eU5OqV/HvYn0aTLy/+6upZJjMMvC+fq6eZd6oul8eY67Zpam
         5zmZR76yLa/RmoORuZOeTP+DANNTQeXifYt5BiW1xK381d+qJbG6Ejvl6fUWnQ1ivCzC
         QIug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686579407; x=1689171407;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3KEZk+7J6jH+5aotS2FyIOrhqYERHH/vUHWmZ4rNxhg=;
        b=VEan548RpVbvPtQxYts3jRvAqrb6kosd3W9ie9gTlhgYqouBYjSFYETIaZttzIihKZ
         Y88vxakn7U73ENYkt41MgJ9xKj07CWxWiuQbA7NKcgUhUwitYZtV8dcAUsXaMPau1iuO
         AxwS+Jn/TV8nE6NQsXiw5XE1r7dH2vMGkEfTe81dUw7fMHS8v7Syjo83C8fdnVsfkBrJ
         vyveFWjCpH5OZOVN1hYlBKgiOHCoGULJd0cSrypHY0rVCqIyDyke2SIEqpbuWPtVQy1Y
         PXKZ99ZhuMcXH2862aRV5R/CfVNmiBKMMYJcZ6/h3A/mhMltO94uq/i5JoQPqEP8TL+l
         fnzQ==
X-Gm-Message-State: AC+VfDx6HmElsuqcV584Z8ckZhU2xJw8HMUW1gNDF78X1WvNm6AFHL44
        vYCWUfd4BvWwP40j13bGO4IDGu6x6xoUNwkR5821vg==
X-Google-Smtp-Source: ACHHUZ57+N2fxPaYk1KsjJ78p5skxj4sQPHQWMVRz384v60dInqhXhnP1Xd2BZXxN8RcGnafD1Ct7EAMdvyTUPuUwhE=
X-Received: by 2002:a05:6359:679d:b0:123:4e5e:d65 with SMTP id
 sq29-20020a056359679d00b001234e5e0d65mr4491115rwb.10.1686579406844; Mon, 12
 Jun 2023 07:16:46 -0700 (PDT)
MIME-Version: 1.0
References: <20230604121223.9625-1-stefan.wahren@i2se.com> <20230604121223.9625-9-stefan.wahren@i2se.com>
In-Reply-To: <20230604121223.9625-9-stefan.wahren@i2se.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 12 Jun 2023 16:16:10 +0200
Message-ID: <CAPDyKFpfcWifMwWHrFzKg+o8hD860x+eB5hT5ZUKyO6uc75Sug@mail.gmail.com>
Subject: Re: [PATCH 08/10] dt-bindings: mmc: convert bcm2835-sdhost bindings
 to YAML
To:     Stefan Wahren <stefan.wahren@i2se.com>
Cc:     Vinod Koul <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-arm-kernel@lists.infradead.org, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-pwm@vger.kernel.org, linux-pm@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sun, 4 Jun 2023 at 14:13, Stefan Wahren <stefan.wahren@i2se.com> wrote:
>
> Convert the DT binding document for bcm2835-sdhost from .txt to YAML.
>
> Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  .../bindings/mmc/brcm,bcm2835-sdhost.txt      | 23 --------
>  .../bindings/mmc/brcm,bcm2835-sdhost.yaml     | 54 +++++++++++++++++++
>  2 files changed, 54 insertions(+), 23 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/mmc/brcm,bcm2835-sdhost.txt
>  create mode 100644 Documentation/devicetree/bindings/mmc/brcm,bcm2835-sdhost.yaml
>
> diff --git a/Documentation/devicetree/bindings/mmc/brcm,bcm2835-sdhost.txt b/Documentation/devicetree/bindings/mmc/brcm,bcm2835-sdhost.txt
> deleted file mode 100644
> index d876580ae3b8..000000000000
> --- a/Documentation/devicetree/bindings/mmc/brcm,bcm2835-sdhost.txt
> +++ /dev/null
> @@ -1,23 +0,0 @@
> -Broadcom BCM2835 SDHOST controller
> -
> -This file documents differences between the core properties described
> -by mmc.txt and the properties that represent the BCM2835 controller.
> -
> -Required properties:
> -- compatible: Should be "brcm,bcm2835-sdhost".
> -- clocks: The clock feeding the SDHOST controller.
> -
> -Optional properties:
> -- dmas: DMA channel for read and write.
> -          See Documentation/devicetree/bindings/dma/dma.txt for details
> -
> -Example:
> -
> -sdhost: mmc@7e202000 {
> -       compatible = "brcm,bcm2835-sdhost";
> -       reg = <0x7e202000 0x100>;
> -       interrupts = <2 24>;
> -       clocks = <&clocks BCM2835_CLOCK_VPU>;
> -       dmas = <&dma 13>;
> -       dma-names = "rx-tx";
> -};
> diff --git a/Documentation/devicetree/bindings/mmc/brcm,bcm2835-sdhost.yaml b/Documentation/devicetree/bindings/mmc/brcm,bcm2835-sdhost.yaml
> new file mode 100644
> index 000000000000..3a5a44800675
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mmc/brcm,bcm2835-sdhost.yaml
> @@ -0,0 +1,54 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/mmc/brcm,bcm2835-sdhost.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Broadcom BCM2835 SDHOST controller
> +
> +maintainers:
> +  - Stefan Wahren <stefan.wahren@i2se.com>
> +
> +allOf:
> +  - $ref: mmc-controller.yaml
> +
> +properties:
> +  compatible:
> +    const: brcm,bcm2835-sdhost
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 1
> +
> +  dmas:
> +    maxItems: 1
> +
> +  dma-names:
> +    const: rx-tx
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - clocks
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/bcm2835.h>
> +
> +    sdhost: mmc@7e202000 {
> +      compatible = "brcm,bcm2835-sdhost";
> +      reg = <0x7e202000 0x100>;
> +      interrupts = <2 24>;
> +      clocks = <&clocks BCM2835_CLOCK_VPU>;
> +      dmas = <&dma 13>;
> +      dma-names = "rx-tx";
> +      bus-width = <4>;
> +    };
> --
> 2.34.1
>
