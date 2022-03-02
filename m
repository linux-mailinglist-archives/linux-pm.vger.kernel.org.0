Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EADA84CB091
	for <lists+linux-pm@lfdr.de>; Wed,  2 Mar 2022 22:01:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245040AbiCBVCY (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 2 Mar 2022 16:02:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245020AbiCBVCX (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 2 Mar 2022 16:02:23 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 355E1DCE11
        for <linux-pm@vger.kernel.org>; Wed,  2 Mar 2022 13:01:39 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id n14so4712989wrq.7
        for <linux-pm@vger.kernel.org>; Wed, 02 Mar 2022 13:01:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=IotEGEPl+vyvT7dXmaJAP+jOA9ymnn/1Ou6RVmJElPo=;
        b=pC98Gxui5FKMvVnCS2lvd7EDmxqExt/7anZky4i0qilnWRH8AA1eZQ7k+JzXkwQ3go
         wjGsj6ZUDSbpJN198GqqSwRxgdlVm8AY0Txpl9M1/OncZLt0B4SA5sP+gnTsAOeCGv7y
         RhWtOqMlqMw0hobQKS+jFMd4FKY7VnrrLFqi84m2/MWQ1FHC+HxsXA5PBKwTF/gButw1
         osSH0jsjnJUipS/61SLjBXKjgiueFK/jy7WJOMBHdFQjpC66ont/1QMVK+t/IfNyxlut
         8ZbbLJ9eH8L0i+IG7VoVAfehe204+4Zbn5YOHqUr7Go9PavF1SC3qpLerb2LWVEFG+zs
         09KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=IotEGEPl+vyvT7dXmaJAP+jOA9ymnn/1Ou6RVmJElPo=;
        b=uX0UKmOCTLUvq3qX8+7LLQ8OURC+zNy4XzXp/OJoIDrr6A+UodU6+Cq9lS16VRPLtS
         oDNLd4T1MzRqnHU1KcZq7dMvF8ZsaZp2toKPBmZ4svC2GiNzqJjz2h7STeyFq8idQku0
         rM4cRoa+biqmCK4WOIG58arijMe1dg6ATFfg+QoypUNVzAyCz8joHQ2A9e8N/tDID5Z0
         SiGG0vvNYUDUDOavFtbvOt38alfjTmuWwAqmldURyd1F4N9VgRPcmKOzsRywsGcuahRC
         K7yUN7+DOJnAWRw779Nog6XBry+akrYZFUghVqJb+PHgUyQf9M8U3zX0Z/4PnEtT+5HY
         Revw==
X-Gm-Message-State: AOAM530aYfPCaFIeep82cZKNuml3x5eHZV0NPkGHimFi0fFeR3N08ghR
        1DxW5eQdprfdXDGGMa/xqTisVg==
X-Google-Smtp-Source: ABdhPJyu8xSxUgfVUOgYfqeqseA8crLejYQaJqBLvkT4iTpIUedL39JKLwdBq84PfWbf06al81Z94Q==
X-Received: by 2002:a5d:5257:0:b0:1f0:1822:69ad with SMTP id k23-20020a5d5257000000b001f0182269admr6737136wrc.342.1646254897531;
        Wed, 02 Mar 2022 13:01:37 -0800 (PST)
Received: from ?IPV6:2a01:e34:ed2f:f020:b9e3:8853:bc0:bb98? ([2a01:e34:ed2f:f020:b9e3:8853:bc0:bb98])
        by smtp.googlemail.com with ESMTPSA id m5-20020a05600c3b0500b00380da3ac789sm158320wms.1.2022.03.02.13.01.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Mar 2022 13:01:36 -0800 (PST)
Message-ID: <efbb8a52-2e8b-9840-54c4-2696e19dd61c@linaro.org>
Date:   Wed, 2 Mar 2022 22:01:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 2/3] dt-bindings: thermal: samsung: convert to dtschema
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Zhang Rui <rui.zhang@intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Amit Kucheria <amitk@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220122132554.65192-1-krzysztof.kozlowski@canonical.com>
 <20220122132554.65192-2-krzysztof.kozlowski@canonical.com>
 <d27ee47c-6c03-3927-4cac-46a1c2515ab6@canonical.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <d27ee47c-6c03-3927-4cac-46a1c2515ab6@canonical.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 02/03/2022 20:11, Krzysztof Kozlowski wrote:
> On 22/01/2022 14:25, Krzysztof Kozlowski wrote:
>> Convert the Samsung Exynos SoC Thermal Management Unit bindings to DT
>> schema format.
>>
>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
>> ---
>>   .../bindings/thermal/exynos-thermal.txt       | 106 ----------
>>   .../thermal/samsung,exynos-thermal.yaml       | 184 ++++++++++++++++++
>>   2 files changed, 184 insertions(+), 106 deletions(-)
>>   delete mode 100644 Documentation/devicetree/bindings/thermal/exynos-thermal.txt
>>   create mode 100644 Documentation/devicetree/bindings/thermal/samsung,exynos-thermal.yaml
>>
> 
> Hi Amit, Daniel, Rafael and Zhang,
> 
> The patch got review from Rob. Could you pick it up to thermal/PM tree?

https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git/commit/?h=thermal/linux-next&id=ffae973348505a786a145021d72da331509af185


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
