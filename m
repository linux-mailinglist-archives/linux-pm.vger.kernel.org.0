Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 629276FB52D
	for <lists+linux-pm@lfdr.de>; Mon,  8 May 2023 18:35:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234148AbjEHQfb (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 8 May 2023 12:35:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234114AbjEHQfa (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 8 May 2023 12:35:30 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0487E5BA9
        for <linux-pm@vger.kernel.org>; Mon,  8 May 2023 09:35:29 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-50bc075d6b2so9079750a12.0
        for <linux-pm@vger.kernel.org>; Mon, 08 May 2023 09:35:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683563727; x=1686155727;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QUEcs1Xi1xeQy3sb8mO7FcLmtClbP8Nvb3I3pqaSRzk=;
        b=uxj7FzIQt2huhDQKebHOAM0KoBjTNYYtsr5GTdJFWqy4cuXaBspKqAN7C/32SDFPaE
         e5wgqnBude0Ntl5qIJvM2Nj1mrjkEtgIyXqkg0lXVu6Ur/6GMn6ypcBQSFTmpcYHLExw
         x0IDah4hQnOm+g3xYGldP7RK3gsqqlNgvU4Cek3uDioS3NaXTR3q6hxgosGGrGAa4sqp
         cxEoSEZVhCK0ZAxbUHVTiIOtnaq3syB91qDsoftb+GRA4xLJp7c6JtGNTsMWfbaNMPUG
         cwJ4GjCrX/IEsEWvuPkkgon29lGSQKGfyLuD69qRaH6422/GPrajcJBlTGBFZQb3a+h6
         f4cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683563727; x=1686155727;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QUEcs1Xi1xeQy3sb8mO7FcLmtClbP8Nvb3I3pqaSRzk=;
        b=iuiDSobc02IjHncR/zUDrncluC0Z4tqvSV1J4ZZiddKXiz0lXOBuXL+mqaZ5FqYc+z
         qGHI8iG6kNS9HtM4U1EJoCR4fxvMHGD/x3GYl2M5E2Al/PPZkJEnuc6Pe/oN5eE5D2L2
         09PtPmx221rQ8xwQKSpFjG7JeyCXaj8HFYefcWCPuWLzlJhREMLsj6fdM4Sjx63jAa/l
         X949MLEwNoA10XRryU6GmaNu7CGxv/d/arEhpmgXC+rj+zNRLoDqbYVJLzRjM32Zkefy
         Vn6VTmheNFACaHfAdVGjXU/uhuAi9+0WiNPY6ZD/HM3wNYxDkT4Q2GUKLEM/cgNnO3aq
         Y3eQ==
X-Gm-Message-State: AC+VfDwJVNYQg5rkx73BQmBPIxtJi8qbLuzmbi1EpCTNNw5mN2uToRw9
        7ylHK7PxC3lY92OLMlgExqLmsQ==
X-Google-Smtp-Source: ACHHUZ6JxK1GLPRkiwjpCYkPcMT+crbT6/Dx1pkt5m2S3nIS0wjuRzuTyipDzsrF9lzIoDU7ldHjoQ==
X-Received: by 2002:a17:907:96a3:b0:94e:d17f:eacf with SMTP id hd35-20020a17090796a300b0094ed17feacfmr10203368ejc.23.1683563727469;
        Mon, 08 May 2023 09:35:27 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:50e0:ebdf:b755:b300? ([2a02:810d:15c0:828:50e0:ebdf:b755:b300])
        by smtp.gmail.com with ESMTPSA id ml18-20020a170906cc1200b0094f124a37c4sm184504ejb.18.2023.05.08.09.35.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 May 2023 09:35:26 -0700 (PDT)
Message-ID: <8880cccc-aed2-1517-eb41-60ac43c3bef1@linaro.org>
Date:   Mon, 8 May 2023 18:35:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 5/6] ARM: dts: qcom: apq8074-dragonboard: add onboard
 leds
Content-Language: en-US
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Vinod Koul <vkoul@kernel.org>
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
References: <20230508160446.2374438-1-dmitry.baryshkov@linaro.org>
 <20230508160446.2374438-6-dmitry.baryshkov@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230508160446.2374438-6-dmitry.baryshkov@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 08/05/2023 18:04, Dmitry Baryshkov wrote:
> The dragonboard as three LEDs: red, green and blue. Add corresponding
> description.
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---
>  .../arm/boot/dts/qcom-apq8074-dragonboard.dts | 24 +++++++++++++++++++
>  1 file changed, 24 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/qcom-apq8074-dragonboard.dts b/arch/arm/boot/dts/qcom-apq8074-dragonboard.dts
> index 630180edecfd..07db6451f273 100644
> --- a/arch/arm/boot/dts/qcom-apq8074-dragonboard.dts
> +++ b/arch/arm/boot/dts/qcom-apq8074-dragonboard.dts
> @@ -1,6 +1,7 @@
>  // SPDX-License-Identifier: GPL-2.0
>  #include <dt-bindings/gpio/gpio.h>
>  #include <dt-bindings/input/input.h>
> +#include <dt-bindings/leds/common.h>
>  #include <dt-bindings/pinctrl/qcom,pmic-gpio.h>
>  #include "qcom-msm8974.dtsi"
>  #include "qcom-pm8841.dtsi"
> @@ -69,6 +70,29 @@ msm_keys_default: pm8941-gpio-keys-state {
>          };
>  };
>  
> +&pm8941_lpg {
> +        qcom,power-source = <1>;
> +	status = "okay";

Broken indentation.



Best regards,
Krzysztof

