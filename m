Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D1AC5ED704
	for <lists+linux-pm@lfdr.de>; Wed, 28 Sep 2022 10:01:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233746AbiI1IBm (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 28 Sep 2022 04:01:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233806AbiI1IBk (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 28 Sep 2022 04:01:40 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CCD01EE755
        for <linux-pm@vger.kernel.org>; Wed, 28 Sep 2022 01:01:36 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id 10so19194229lfy.5
        for <linux-pm@vger.kernel.org>; Wed, 28 Sep 2022 01:01:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=/tJFSKHI3KE+2w8Mp5fH7AqdtUfhsF9MOlEfNhHwM7I=;
        b=sZNK31UuiHEMJfT8TgQ1DF3bkj2FDYT+XYHsuJ5D7t/0VNkyDCF4GMpRWhZZf4/wGo
         ZD2kE+L5ISVXseZzlL7xBjh0tWnXSqTV8tYwhOPhEDO3pIvXIjQ7F53Sh6+QCL8aFJno
         YRswSUWfxeP/80mumiLIqa4GXxA5Y/MyQ+hZ7IEO7qFhyopNrKkTWgr9FW9Yt9yCZT9o
         LCbWTfmzYwJ7wXIzDNdSK9EaMHYqPGIT1dQDrHnCyn6xviu8HM1o+mSIJs4EgVR+iqfw
         819Y9ZTIB2LSwCHSFCAmyGaiDYHeXx0jLZSezFb/fb49/2EPqLU/dhoa3E8ozPCtgoio
         CVOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=/tJFSKHI3KE+2w8Mp5fH7AqdtUfhsF9MOlEfNhHwM7I=;
        b=zl3nM+qxtDg86ZntimkRNXg6PNvxPRYLcLzT93FhQRAfxzjPLK7VTF2p8lNI5BMpDS
         aFXtY4sOUmkQZkMXmoGI9biWym8RgjcK79zOM2CuIrxT2TsIwCFF1bEAI7d5HbwkCNVL
         1opLYU6oHEPpLj4tJXEA/4mPl9rZIk9INU0JzEeIZYm0RxqZp0SPlaDZct6kYtT+WF/a
         4Mla5mwYqLQfkt4+5GiSFW/D3usqC0OGG1xiEB2sKNCOK22fZMRi/610rVRpdW6khcj0
         fMO39i+RMTXW42Ym9jd9Vsq8wqNeVAkllcJa/BjmhH7YypNhVNlZgy89xMegJ9675zlg
         0VzQ==
X-Gm-Message-State: ACrzQf2Y2jhQE7NQWcol4yeQG0KzcOi/QpgEsyl3nyOyf6adOw0HX3iw
        9oG/cG8gxA8bVGR2jqTcuYv2cg==
X-Google-Smtp-Source: AMsMyM5+OHfsYNiw9519Tq7XbP5R9nzBpq18Ms24ne3Ny6o05PjkBLEQZWX4oKBVghzP7qhGQV+ADA==
X-Received: by 2002:a05:6512:10c8:b0:49c:14c5:e081 with SMTP id k8-20020a05651210c800b0049c14c5e081mr13054391lfg.615.1664352094458;
        Wed, 28 Sep 2022 01:01:34 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id cf32-20020a056512282000b0048a934168c0sm403159lfb.35.2022.09.28.01.01.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Sep 2022 01:01:33 -0700 (PDT)
Message-ID: <1b2d1e4f-6b95-cf20-8c2d-f87a91ae599c@linaro.org>
Date:   Wed, 28 Sep 2022 10:01:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH v4 2/3] dt-bindings: thermal: add loongson2k thermal
 binding
Content-Language: en-US
To:     Yinbo Zhu <zhuyinbo@loongson.cn>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     zhanghongchen <zhanghongchen@loongson.cn>,
        Liu Peibao <liupeibao@loongson.cn>
References: <20220928031628.6463-1-zhuyinbo@loongson.cn>
 <20220928031628.6463-2-zhuyinbo@loongson.cn>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220928031628.6463-2-zhuyinbo@loongson.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 28/09/2022 05:16, Yinbo Zhu wrote:
> Add the loongson2k thermal binding with DT schema format using
> json-schema.
> 
> Signed-off-by: Yinbo Zhu <zhuyinbo@loongson.cn>

Thank you for your patch. There is something to discuss/improve.

> +$id: http://devicetree.org/schemas/thermal/loongson,ls2k-thermal.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Thermal sensors on loongson2k SoCs
> +
> +maintainers:
> +  - zhanghongchen <zhanghongchen@loongson.cn>
> +  - Yinbo Zhu <zhuyinbo@loongson.cn>
> +
> +properties:
> +  compatible:
> +    const: loongson,ls2k-thermal
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  "#thermal-sensor-cells":

Use same quotes in all places - either ' or "

> +    const: 1> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - '#thermal-sensor-cells'

With quotes fixed:

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

