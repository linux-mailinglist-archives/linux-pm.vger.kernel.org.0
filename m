Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E50A668D975
	for <lists+linux-pm@lfdr.de>; Tue,  7 Feb 2023 14:35:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232047AbjBGNfp (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 7 Feb 2023 08:35:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231823AbjBGNfo (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 7 Feb 2023 08:35:44 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E01F923869
        for <linux-pm@vger.kernel.org>; Tue,  7 Feb 2023 05:35:42 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id n28-20020a05600c3b9c00b003ddca7a2bcbso11470146wms.3
        for <linux-pm@vger.kernel.org>; Tue, 07 Feb 2023 05:35:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=k1ykxnCSPogB0kbxJnMoBL8O048yCl07opBue4WpgaQ=;
        b=tTuj0/XbFSyS4dn6D7rW1NOCwMHRyzAh+O6FP2x0BBLP/2F0FxstsfvHct8fILSH/K
         0GllB2iScPYt8V7iN34H0RSFKCruoUivMiSVGCtxTkSnKMZpYaIpKftzuLJyH0leBR0+
         qSJCq3ldl5dw6okdCiYezdtVaU1jvRex6x4G6R0UYxPklWw1Pn6TtaMyVhomxJuPkWMC
         FpOPOnGAt3n96q4B+oUkaXxF7ct2JK8etPczii+PuYqtxUsmT2vaQP62U8p/PFz4SLTg
         W11hImxwMZc1PGSjZR6AGekxCjzEeZzJJIP+OHLZ6Sb10ADbKfHuPKUElUaTxONnUgjE
         sEjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=k1ykxnCSPogB0kbxJnMoBL8O048yCl07opBue4WpgaQ=;
        b=DATGbHNNQRxoryQA2r3WaGVTGzj54nHdxyBahCkQP8mA375EN822KTVWMCxyENGhxE
         RcO+TMugLcGjO4d/Q51N70i2r5j6OVhh++JUYZFdkZ6k71pyqaojmSCSWMoiRBtaIqz8
         a9NhOO/hQqIFCVrn89MQ93m2HFlVqjAvQcaBDYsi16rpjlw7VEOLYmt6j/3BjYX1lasz
         3h98kj1voJL37IJ/gsQ+gL6E3ZUgR0Z/+aJDAixQUS/ToPCsZFhIzSKus6Nk6bBP/m1Q
         7gzOEgr3pbMyAvHt4UKFLRsSrzAFCqooFCUKcVzzo9K1O4mq0jEE8W3yP5LE4PeOIGgi
         xHog==
X-Gm-Message-State: AO0yUKUTWlOY7naxCd1KQntKnLtEYm2f+VCtFDTwHY1ZcOzbrgzU8QEQ
        wdD02tvZbj1q57KzmtsTm72pfQ==
X-Google-Smtp-Source: AK7set9N2kRdkmfxK++BVbR4XXH+Yw/7DgZyRt1NfDA/eM1SF/QMNr1FLrcIAOqKD1ls1/bhgKNttg==
X-Received: by 2002:a05:600c:3596:b0:3df:d431:cf64 with SMTP id p22-20020a05600c359600b003dfd431cf64mr3061555wmq.39.1675776941479;
        Tue, 07 Feb 2023 05:35:41 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id f1-20020a1cc901000000b003df14531724sm18521999wmb.21.2023.02.07.05.35.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Feb 2023 05:35:41 -0800 (PST)
Message-ID: <046b3b31-cbf7-674d-f05c-b825d6b46bf6@linaro.org>
Date:   Tue, 7 Feb 2023 14:35:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v13 2/6] dt-bindings: thermal: mediatek: Add LVTS thermal
 controllers
Content-Language: en-US
To:     bchihi@baylibre.com, daniel.lezcano@linaro.org,
        angelogioacchino.delregno@collabora.com, rafael@kernel.org,
        amitk@kernel.org, rui.zhang@intel.com, matthias.bgg@gmail.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        rdunlap@infradead.org, ye.xingchen@zte.com.cn,
        p.zabel@pengutronix.de
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        khilman@baylibre.com, james.lo@mediatek.com,
        rex-bc.chen@mediatek.com
References: <20230207130958.608305-1-bchihi@baylibre.com>
 <20230207130958.608305-3-bchihi@baylibre.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230207130958.608305-3-bchihi@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 07/02/2023 14:09, bchihi@baylibre.com wrote:
> From: Balsam CHIHI <bchihi@baylibre.com>
> 
> Add LVTS thermal controllers dt-binding definition for mt8192 and mt8195.
> 


> +allOf:
> +  - $ref: thermal-sensor.yaml#
> +
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - mediatek,mt8192-lvts-ap
> +              - mediatek,mt8192-lvts-mcu
> +    then:
> +      properties:
> +        nvmem-cells:
> +          maxItems: 1
> +
> +        nvmem-cell-names:
> +          maxItems: 1
> +
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - mediatek,mt8195-lvts-ap
> +              - mediatek,mt8195-lvts-mcu
> +    then:
> +      properties:
> +        nvmem-cells:

minItems: 2

> +          maxItems: 2
> +
> +        nvmem-cell-names:

minItems: 2

> +          maxItems: 2
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts

(...)

> diff --git a/include/dt-bindings/thermal/mediatek,lvts-thermal.h b/include/dt-bindings/thermal/mediatek,lvts-thermal.h
> new file mode 100644
> index 000000000000..4f2082065a31
> --- /dev/null
> +++ b/include/dt-bindings/thermal/mediatek,lvts-thermal.h
> @@ -0,0 +1,19 @@
> +/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
> +/*
> + * Copyright (c) 2023 MediaTek Inc.
> + * Author: Balsam CHIHI <bchihi@baylibre.com>
> + */
> +
> +#ifndef __MEDIATEK_LVTS_DT_H
> +#define __MEDIATEK_LVTS_DT_H
> +
> +#define MT8195_MCU_BIG_CPU0		0
> +#define MT8195_MCU_BIG_CPU1		1
> +#define MT8195_MCU_BIG_CPU2		2
> +#define MT8195_MCU_BIG_CPU3		3
> +#define MT8195_MCU_LITTLE_CPU0	4

These changed for some reason. Why? The indentation is now broken
(although not visible above quote, but visible in diff and code).

Best regards,
Krzysztof

