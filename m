Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3293867F758
	for <lists+linux-pm@lfdr.de>; Sat, 28 Jan 2023 11:49:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230397AbjA1KtE (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 28 Jan 2023 05:49:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233810AbjA1Ks6 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 28 Jan 2023 05:48:58 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4181F222F7
        for <linux-pm@vger.kernel.org>; Sat, 28 Jan 2023 02:48:56 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id f12-20020a7bc8cc000000b003daf6b2f9b9so6991626wml.3
        for <linux-pm@vger.kernel.org>; Sat, 28 Jan 2023 02:48:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BDMyuNY9y2+mLIY91GGCJaf3jR2VGlODgfIJsSjay2k=;
        b=hmFG1UC0xZDkKe8YXYtTsoSlN+mukQIUz+DjLBJydedkPIcvK8+eReW4WbgNupYvZt
         otEbRmzGeNzYEdhfu5WWDr4pMIvYjLYxP6InEc0nUuCcaRf0SB/Y4aSWVyesWuExKx/z
         U2lItJlcCAexXE1oyUeaEu2jwUYHH2FB54OL0XBD7MkMe2sqyALHhf+IVDik6zoqEA/O
         9QIUe5775lSgBt5BwcqaOcoxUykdawfEypSNY1Ri7B8E7cuh9Dixjig1gfWl9m5hph33
         pWybVYBJaz1U5+OhpUxD3/m7lbmdS9SiXu3hYg4/J1pIDsyAsE7t+v4Xk9Y9A5nM2yRE
         bgbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BDMyuNY9y2+mLIY91GGCJaf3jR2VGlODgfIJsSjay2k=;
        b=xqwKHPIoXi6yQOGvvtE8EcKkpVWRNVjcTjS+XBSJfi8l3ujvtKuasEP1app3xHssQ1
         msdNT+kFS6GrCSe5y+RJA46sITgsxMiMybZnIA+3n1oItDj0rToScZ1iw44RoNQw9Q0j
         dKZLjdiGQlQonfwW0a13nC3VHSZCrTmgn6ZFDW9hz7qVxXwsQ77Ds6ZOHSAhL6HPnhQR
         KpLBFRyT05d3vmJ6pUE5HsZxapGU2bIhPiPN9klwFDRRt0pkFCSDqBIItXe2xO4QcE4u
         Ahh3YUf86lfMNzTMDnu5jw/NAlAgafsys8REYNUiq/hP7DXBUVr+ct9/IHzBmQO+W0J6
         IDbw==
X-Gm-Message-State: AFqh2krJ9zqLdYvFd540Uo+k9BEclrS9YL2ccOCJorJnkU2jp+5Utf9d
        yhS7casFSvYC1LjPVhz3eH7dYQ==
X-Google-Smtp-Source: AMrXdXvzLKnPJzKgzaJo+Fihga+fGeShpAelemc3eeNsipvcvTqGS01hVJ+Ze/uvvnAp2CCmGSCNMQ==
X-Received: by 2002:a05:600c:3b18:b0:3db:eab:3c5c with SMTP id m24-20020a05600c3b1800b003db0eab3c5cmr40476863wms.32.1674902934819;
        Sat, 28 Jan 2023 02:48:54 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id j6-20020a05600c42c600b003daf89e01d3sm6781867wme.11.2023.01.28.02.48.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 28 Jan 2023 02:48:54 -0800 (PST)
Message-ID: <5ec49108-6ad8-daf7-54ec-104f0923a31d@linaro.org>
Date:   Sat, 28 Jan 2023 11:48:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v12 2/6] dt-bindings: thermal: mediatek: Add LVTS thermal
 controllers dt-binding definition
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
References: <20230124131717.128660-3-bchihi@baylibre.com>
 <20230126161048.94089-1-bchihi@baylibre.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230126161048.94089-1-bchihi@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 26/01/2023 17:10, bchihi@baylibre.com wrote:
> From: Balsam CHIHI <bchihi@baylibre.com>
> 
> Add LVTS thermal controllers dt-binding definition for mt8195.

Subject: drop second/last, redundant "dt-binding definition". The
"dt-bindings" prefix is already stating that these are bindings.

Plus two comments at the end.

> 
> Signed-off-by: Balsam CHIHI <bchihi@baylibre.com>
> ---
> Changelog:
>   v12:
>      - Fixed subject prefix
>      - Fixed licences GPL-2.0+ to GPL-2.0
>      - Added dual licenses


> +    };
> diff --git a/include/dt-bindings/thermal/mediatek-lvts.h b/include/dt-bindings/thermal/mediatek-lvts.h
> new file mode 100644
> index 000000000000..902d5b1e4f43
> --- /dev/null
> +++ b/include/dt-bindings/thermal/mediatek-lvts.h

Same filename as bindings.

> @@ -0,0 +1,19 @@
> +/* SPDX-License-Identifier: (GPL-2.0 or MIT) */

Although this is correct, any reason why not using exactly the same
license as bindings?

> +/*
> + * Copyright (c) 2023 MediaTek Inc.
> + * Author: Balsam CHIHI <bchihi@baylibre.com>
> + */

Best regards,
Krzysztof

