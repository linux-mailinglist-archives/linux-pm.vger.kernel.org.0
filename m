Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC25E4FF480
	for <lists+linux-pm@lfdr.de>; Wed, 13 Apr 2022 12:14:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234769AbiDMKQ5 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 13 Apr 2022 06:16:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232824AbiDMKQz (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 13 Apr 2022 06:16:55 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D33635DCC
        for <linux-pm@vger.kernel.org>; Wed, 13 Apr 2022 03:14:35 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id ks6so2965400ejb.1
        for <linux-pm@vger.kernel.org>; Wed, 13 Apr 2022 03:14:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=hEGFqrwiFgt0pC+Shr7CLJeqGcsIwA9w+pTgNGd8olk=;
        b=u9eF4UTMKqqJn2yf80zKmxOu4V3adcgtTvwkm2MNvmJzZuO7qiGsV8rQrc4JTcyBGl
         qwBorw27yAvqPnxToESRaWuyxBvqdGenno34azdHslbzGSg2ZwEKR8weCu7r6hqpSxuc
         hw//9qbh/J66eTU5giSOUe07zXk4TXjL2Ym0KglM4gs/6SuH4x9dcTsZLKdv4fzRs8U0
         ZbZ/qG7Yfjjg/o7BYQIeBLA1pUsUFUapHHuaBTD/hc1OJM3hzCC/WwOkLXEzxMSJgbjE
         pCyD+3b057MumA5xCtWvbJzLPtWTWNFYuY1EWQz1qBIFI5rhiGQXdMyZQDeA+/GWz4xa
         sUdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=hEGFqrwiFgt0pC+Shr7CLJeqGcsIwA9w+pTgNGd8olk=;
        b=SNl/dnpKi8boL+EJ4305vknnIMeRCbvA0I/DDY3bpZfm4vUO76/ADAz8mu/R1ASqr5
         TERaVZYgMkq4FMTrs1yfOOW4lVsYSPsWkkh36Cqg0mFyDJWKthfCJYD2NKi4xOXZeQyi
         SApo83WwNwbf76erg3kEAYl2ES4AX3ngKDJL8qdKO0c4MRflJGi3NGPqaTWPB18mtiK5
         6ebc/Uec2Wn3uP1myvaMVSWK95AGKF4yUWbjx9xzslDZOeR+v47Yi0/kbHncXCg9u/b0
         D8We6Sax2V2PXFFXfSjTSiWO3GDttKBHEhW3g+zLSD9aOW9iS9+9bbupi5dwFNLKEn/4
         0CtA==
X-Gm-Message-State: AOAM531+yMM069J0WXO7f1vq+egG1tu0I1gGK7SRlkCstKZ9h17mGleS
        QZxNl3zAWhxiJai81wV1qpKx2Q==
X-Google-Smtp-Source: ABdhPJxPEGyAWUR/lWyrdqUdNHwI42/Y/p/wnXLX9hi6CbHFO0t/QXn2evoIDNPbHWtTJ5n5WcZk/g==
X-Received: by 2002:a17:907:1608:b0:6e8:526a:2312 with SMTP id hb8-20020a170907160800b006e8526a2312mr22422267ejc.200.1649844873737;
        Wed, 13 Apr 2022 03:14:33 -0700 (PDT)
Received: from [192.168.0.203] (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.gmail.com with ESMTPSA id bs2-20020a056402304200b0041fc40eeb91sm358778edb.49.2022.04.13.03.14.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Apr 2022 03:14:33 -0700 (PDT)
Message-ID: <eac272ec-8c33-36f0-5d14-65128cf69abb@linaro.org>
Date:   Wed, 13 Apr 2022 12:14:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v5 3/4] arm64: dts: ti: j7200: Add VTM node
Content-Language: en-US
To:     Keerthy <j-keerthy@ti.com>, robh+dt@kernel.org,
        daniel.lezcano@linaro.org, rui.zhang@intel.com, amitk@kernel.org,
        kristo@kernel.org
Cc:     linux-pm@vger.kernel.org, vigneshr@ti.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220412101409.7980-1-j-keerthy@ti.com>
 <20220412101409.7980-4-j-keerthy@ti.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220412101409.7980-4-j-keerthy@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 12/04/2022 12:14, Keerthy wrote:
> VTM stands for Voltage Thermal Management
> 
> Signed-off-by: Keerthy <j-keerthy@ti.com>
> ---
>  .../boot/dts/ti/k3-j7200-mcu-wakeup.dtsi      |  9 ++++
>  arch/arm64/boot/dts/ti/k3-j7200-thermal.dtsi  | 45 +++++++++++++++++++
>  arch/arm64/boot/dts/ti/k3-j7200.dtsi          |  4 ++
>  3 files changed, 58 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/ti/k3-j7200-thermal.dtsi
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-j7200-mcu-wakeup.dtsi b/arch/arm64/boot/dts/ti/k3-j7200-mcu-wakeup.dtsi
> index 1044ec6c4b0d..2b5c570253cc 100644
> --- a/arch/arm64/boot/dts/ti/k3-j7200-mcu-wakeup.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-j7200-mcu-wakeup.dtsi
> @@ -375,4 +375,13 @@
>  			ti,loczrama = <1>;
>  		};
>  	};
> +
> +	wkup_vtm0: wkup_vtm0@42040000 {

Same issues as in other patches.


Best regards,
Krzysztof
