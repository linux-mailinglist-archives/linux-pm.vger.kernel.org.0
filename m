Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57ECC5EEFAF
	for <lists+linux-pm@lfdr.de>; Thu, 29 Sep 2022 09:50:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235418AbiI2HuH (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 29 Sep 2022 03:50:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235437AbiI2Hty (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 29 Sep 2022 03:49:54 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCE441C134
        for <linux-pm@vger.kernel.org>; Thu, 29 Sep 2022 00:49:49 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id q17so622031lji.11
        for <linux-pm@vger.kernel.org>; Thu, 29 Sep 2022 00:49:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=RgPG0USwVM/ZQsIGor/U3Nk/vnbKnWFN6HNjYDCluLQ=;
        b=m/NXVfBlK23P1WxNw3m0FC3BqabMQnKVx5+MjcnhCkxsGMAjbOxWV/Xc2yE/XCdMl4
         BrYp8wFA9OVZj1Jzp85vWYZ0sL5xWDi9/pM4n45KBva5Kuz4M55j8yq3Mim5WJVwRwpF
         Af6mMKj/8E6sxz+XdAkH65OpIotN3YhBePPpQl//QwKYyLcB+E7OKcv/5e5DKs9Jhpk8
         4ntoUKZa4RpFf1nGYVUMUBzhHEgOqwae64WUNYnH1X+DhJpJ/h6C9I8oT38qhcEFDPJt
         PriYlVu6F+NV2Ii+8bvL+sarp/8cLUsMyl9H8JKcbojKMHVKgsHTLTSgTdA5omeJhOyt
         5XfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=RgPG0USwVM/ZQsIGor/U3Nk/vnbKnWFN6HNjYDCluLQ=;
        b=jKJSQ3NWiM82syr1w6jf6B8+OaZesb5OxJsJ8I3kgWjOJlgBXUjQ9gw7mpJlCq2yR5
         k5YVrBAVrlfAtvkrhXoWyCx3LMapgaovMY2d/fz02yaOMUBsMW1CYfXekZaGmUrqJe89
         LqtWJPz+2zZV3QsX8iPhd3h7+7pyydRXmNOiz0ehvpp6M889SeV+QP/CSv3R6e4b8qXH
         5nJvn1WiPaVZI/qVo9QBmXyumsBfFcIkEKoYRa8pLhHy7daIfVoORIqjF60mrdgWXXwN
         Chc8JAMCQrkcYwYM9+Z0P0yOnGIumEy6bfoIAyRnaLZaNcDZe2PmGtOoDAiTYMeeChMM
         /Tbw==
X-Gm-Message-State: ACrzQf0tXPKiCgxyiDR8gI/ogddVpQ+MTq2BaNVxiLCIhl5MMq5pR53q
        icqEljHax/zd07oZW3P29JhLtwXH7CIzFA==
X-Google-Smtp-Source: AMsMyM6maqNswlDMVYjwrBAEZUtH7AQ13FvcUcMruemjt0vdoA3ZK4T+WWXZ1PIQezCvvYdg7+Hm9A==
X-Received: by 2002:a2e:7217:0:b0:26d:b206:b3fa with SMTP id n23-20020a2e7217000000b0026db206b3famr694742ljc.323.1664437788037;
        Thu, 29 Sep 2022 00:49:48 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id bf34-20020a2eaa22000000b00261eb75fa5dsm649403ljb.41.2022.09.29.00.49.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Sep 2022 00:49:47 -0700 (PDT)
Message-ID: <d6880b08-e370-5fa1-b4f0-a6cc2f13a8f5@linaro.org>
Date:   Thu, 29 Sep 2022 09:49:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH v6 1/3] MAINTAINERS: add maintainer for thermal driver for
 loongson2 SoCs
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
References: <20220929071312.29536-1-zhuyinbo@loongson.cn>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220929071312.29536-1-zhuyinbo@loongson.cn>
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

On 29/09/2022 09:13, Yinbo Zhu wrote:
> Add zhanghongchen and myself as maintainer of the loongson2 SoC
> series thermal driver.
> 
> Signed-off-by: Yinbo Zhu <zhuyinbo@loongson.cn>
> ---
>  MAINTAINERS | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 589517372408..0be0f520c032 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -11899,6 +11899,14 @@ F:	drivers/*/*loongarch*
>  F:	Documentation/loongarch/
>  F:	Documentation/translations/zh_CN/loongarch/
>  
> +LOONGSON2 SOC SERIES THERMAL DRIVER
> +M:	zhanghongchen <zhanghongchen@loongson.cn>
> +M:	Yinbo Zhu <zhuyinbo@loongson.cn>
> +L:	linux-pm@vger.kernel.org
> +S:	Maintained
> +F:	Documentation/devicetree/bindings/thermal/loongson,ls2k-thermal.yaml

This cannot be a first patch. It is not bisectable and causes (again)
warnings. Either this should be squashed with last patch (driver change)
or just be a last patch in the series.

Best regards,
Krzysztof

