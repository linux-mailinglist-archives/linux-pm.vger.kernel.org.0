Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9011368DA37
	for <lists+linux-pm@lfdr.de>; Tue,  7 Feb 2023 15:12:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232112AbjBGOMV (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 7 Feb 2023 09:12:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232096AbjBGOMU (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 7 Feb 2023 09:12:20 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 904672884A
        for <linux-pm@vger.kernel.org>; Tue,  7 Feb 2023 06:12:18 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id sa10so13022890ejc.9
        for <linux-pm@vger.kernel.org>; Tue, 07 Feb 2023 06:12:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=sZ5mpqE2ocgxdfOCGy+CSBqlukMgoxHcZxwHA7en+qo=;
        b=L5y670ucwvznmASN/AgU3Adj4DK9TRbO1/1YS+dn/0W79V62OSh3ZRPjtCulNArAWE
         ivzFlnK2NeAwdYtafs0lMvGfiH6K7jW+0Que/knBzosItpl7clydO5JDQfAoD+SCMNWK
         srqvl4iD1hYoDi36HJpgXDjxTHqXBnSjZNbu4692jQ9G5xa8usPfaPGDVtzDeMlX/rpT
         qaSIopQsD6R+m7ErR4b+qrfgAcSl78f3JkYiC7AhQEZgeMGDFkTTjYESoNDoxMbN0cRr
         odLHYw+6+82HUhV/gWdPCrf2cNxB0aO4vC70oa2SQlJflzZNMziU2XPjBThE/PSOd44z
         +PxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sZ5mpqE2ocgxdfOCGy+CSBqlukMgoxHcZxwHA7en+qo=;
        b=xmqc01qNknh7t0o+I+Kskn7RtQKqCX2gCCC3GDuAcf1DvRaG2ljyiQVkYtu2rj3Ffo
         t2etEkQ1wJ1Ge0LErnudXcMYzs5x8RBtW0oNUMtvOmAYT/aTPtm9FwP9rTGTLZLkFtJ2
         NTLTbvMuLYES4V+NLotYjI29BvcyHACJqaLjqOGNZMPi9/BxPZb6b7T240ffALB0uB+m
         j7DgM7p9nmunA8Or138zVP3s2PY4exStaQPjy1OJVJFPBESWXFCy7mS0gqDL1hSYuJeS
         TWLyDa1xmfuJ5StoKbLz4ftY3aIb40oXRS7N4g6UcddrNcyp4it5CvVJLZwN195q+eoy
         1xeg==
X-Gm-Message-State: AO0yUKXmAcwdzvhFRGs/WPLl+lzyJt0L82A7VOtvxfZeRyL2fhZRf9fZ
        ktRNouIzOFTUcIDvinjQJ+UYX/0XnkghLox67MrIZA==
X-Google-Smtp-Source: AK7set/oFiHS7dnqOHD5CRTN/KUIGukzO1ouxhtBnCV18RKKz15grDjDu1XvBQC50v14OV0tRya/fbXqJ7mbQOxpli4=
X-Received: by 2002:a17:906:ca04:b0:7c0:f45e:22ff with SMTP id
 jt4-20020a170906ca0400b007c0f45e22ffmr999899ejb.104.1675779137174; Tue, 07
 Feb 2023 06:12:17 -0800 (PST)
MIME-Version: 1.0
References: <20230207130958.608305-1-bchihi@baylibre.com> <20230207130958.608305-3-bchihi@baylibre.com>
 <046b3b31-cbf7-674d-f05c-b825d6b46bf6@linaro.org>
In-Reply-To: <046b3b31-cbf7-674d-f05c-b825d6b46bf6@linaro.org>
From:   Balsam CHIHI <bchihi@baylibre.com>
Date:   Tue, 7 Feb 2023 15:11:40 +0100
Message-ID: <CAGuA+opvh95SXN-YGfxH0-NA8o4dBNkQJd9PfEXATFPbKHsHuA@mail.gmail.com>
Subject: Re: [PATCH v13 2/6] dt-bindings: thermal: mediatek: Add LVTS thermal controllers
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     daniel.lezcano@linaro.org, angelogioacchino.delregno@collabora.com,
        rafael@kernel.org, amitk@kernel.org, rui.zhang@intel.com,
        matthias.bgg@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, rdunlap@infradead.org,
        ye.xingchen@zte.com.cn, p.zabel@pengutronix.de,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        khilman@baylibre.com, james.lo@mediatek.com,
        rex-bc.chen@mediatek.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Krzysztof,

Thank you for the review.

On Tue, Feb 7, 2023 at 2:35 PM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 07/02/2023 14:09, bchihi@baylibre.com wrote:
> > From: Balsam CHIHI <bchihi@baylibre.com>
> >
> > Add LVTS thermal controllers dt-binding definition for mt8192 and mt8195.
> >
>
>
> > +allOf:
> > +  - $ref: thermal-sensor.yaml#
> > +
> > +  - if:
> > +      properties:
> > +        compatible:
> > +          contains:
> > +            enum:
> > +              - mediatek,mt8192-lvts-ap
> > +              - mediatek,mt8192-lvts-mcu
> > +    then:
> > +      properties:
> > +        nvmem-cells:
> > +          maxItems: 1
> > +
> > +        nvmem-cell-names:
> > +          maxItems: 1
> > +
> > +  - if:
> > +      properties:
> > +        compatible:
> > +          contains:
> > +            enum:
> > +              - mediatek,mt8195-lvts-ap
> > +              - mediatek,mt8195-lvts-mcu
> > +    then:
> > +      properties:
> > +        nvmem-cells:
>
> minItems: 2
>

OK,
I will do the change.

> > +          maxItems: 2
> > +
> > +        nvmem-cell-names:
>
> minItems: 2
>

OK,
I will do this change too.

> > +          maxItems: 2
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - interrupts
>
> (...)
>
> > diff --git a/include/dt-bindings/thermal/mediatek,lvts-thermal.h b/include/dt-bindings/thermal/mediatek,lvts-thermal.h
> > new file mode 100644
> > index 000000000000..4f2082065a31
> > --- /dev/null
> > +++ b/include/dt-bindings/thermal/mediatek,lvts-thermal.h
> > @@ -0,0 +1,19 @@
> > +/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
> > +/*
> > + * Copyright (c) 2023 MediaTek Inc.
> > + * Author: Balsam CHIHI <bchihi@baylibre.com>
> > + */
> > +
> > +#ifndef __MEDIATEK_LVTS_DT_H
> > +#define __MEDIATEK_LVTS_DT_H
> > +
> > +#define MT8195_MCU_BIG_CPU0          0
> > +#define MT8195_MCU_BIG_CPU1          1
> > +#define MT8195_MCU_BIG_CPU2          2
> > +#define MT8195_MCU_BIG_CPU3          3
> > +#define MT8195_MCU_LITTLE_CPU0       4
>
> These changed for some reason. Why? The indentation is now broken
> (although not visible above quote, but visible in diff and code).

I thought that I fixed the indentation.
I will restore it.

>
> Best regards,
> Krzysztof
>

Best regards,
Balsam
