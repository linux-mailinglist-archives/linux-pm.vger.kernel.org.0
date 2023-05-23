Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B04C170E9AF
	for <lists+linux-pm@lfdr.de>; Wed, 24 May 2023 01:35:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238893AbjEWXfV (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 23 May 2023 19:35:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238894AbjEWXfU (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 23 May 2023 19:35:20 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E752185
        for <linux-pm@vger.kernel.org>; Tue, 23 May 2023 16:34:42 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-4f3bb61f860so122818e87.3
        for <linux-pm@vger.kernel.org>; Tue, 23 May 2023 16:34:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684884878; x=1687476878;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uZg4v0RTyzNREljAm+hWtlmx8oK1tgGcQi54orgW1ds=;
        b=OstWqeJ8EBmWlFGue4DAaM6ZZhqrbhVBiHBeqwEkfBiE7hUwN6EVNxk44rPHYYdjLx
         ouN7tkRmfck3Ej5JJQklzLGP92BrvTcGGDW4hja4smz2EhINxCFPlTkaiaOiaDU/Wk+W
         mYgEbHiM211S4AGUPMcQXwc7dK853YjrtHjfdLYnT3NIjW3R+vgewHmI6kkDkYpLekIA
         pLP/cE6iTnzsf6gFCB4EMkvCHF+k6ish4fvk3T5CT6o/pulNQIidz5bi/Y0lOBj/lvuz
         Me7nnL4FEqfYoUPIwyR8YMVMqKK4I5ztKCertmHEi9Om4kVA68ten7F8tT59p6Vyfr8W
         EAfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684884878; x=1687476878;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uZg4v0RTyzNREljAm+hWtlmx8oK1tgGcQi54orgW1ds=;
        b=VEjLLfo5qwP+FB3E107Dgznec8KeNmFxwXHs6EYqgCv4PTMxwgbLTPM5+iYD7ju1dJ
         6ta8JWS2MipcCDI77yg6SozHckirAQLUqAs87gLfj8Qa1DM4uL34bsRKnlIqjzSmioFv
         tToeVOSgBDisFrCec4cp8hm8CVY3KWEPA0QhULuvQgdEYGafw+jQf9HJ72HT5HnqOr6T
         9iXUceXf8/jh3XuRZY2It09fM06zLGy6ypL+jvJVuFny4nM9mAzENNidxYt4CbAhIOV8
         UWH1D+XUX1EV4lPhrnWL/1l8wUGVoBJnJIENBggkaDO794X+Acqth5q/vPKves2VD4Hp
         iYXg==
X-Gm-Message-State: AC+VfDwNmewxE0EFz939ThHowcZ6LJNErmv1WIPlXoFJYcIWEL927Qul
        5uGmdnAaggZGBPEpRKxCPFDd4A==
X-Google-Smtp-Source: ACHHUZ5VDMwnlQ1kaA9DshgcAwp1SpRlIsOFRsbkhg4YoGBxLfOqCiRKUEVf4TbW3N9bzRfshL/0vw==
X-Received: by 2002:ac2:4556:0:b0:4f3:a8f2:2138 with SMTP id j22-20020ac24556000000b004f3a8f22138mr4811916lfm.58.1684884878607;
        Tue, 23 May 2023 16:34:38 -0700 (PDT)
Received: from ?IPV6:2001:14ba:a0db:1f00::8a5? (dzdqv0yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a0db:1f00::8a5])
        by smtp.gmail.com with ESMTPSA id g10-20020a19ac0a000000b004f3af454556sm1490213lfc.246.2023.05.23.16.34.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 May 2023 16:34:38 -0700 (PDT)
Message-ID: <2ef03df1-00ec-4e93-ecca-5cc4a4ef3b23@linaro.org>
Date:   Wed, 24 May 2023 02:34:37 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v2 6/6] ARM: dts: qcom: apq8074-dragonboard: enable
 coincell charger
Content-Language: en-GB
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Vinod Koul <vkoul@kernel.org>
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
References: <20230508160446.2374438-1-dmitry.baryshkov@linaro.org>
 <20230508160446.2374438-7-dmitry.baryshkov@linaro.org>
In-Reply-To: <20230508160446.2374438-7-dmitry.baryshkov@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 08/05/2023 19:04, Dmitry Baryshkov wrote:
> Enable coincell charger for the coin battery which can be installed on
> the APQ8074 dragonboard.
> 
> Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---
>   arch/arm/boot/dts/qcom-apq8074-dragonboard.dts | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/qcom-apq8074-dragonboard.dts b/arch/arm/boot/dts/qcom-apq8074-dragonboard.dts
> index 07db6451f273..93a059641957 100644
> --- a/arch/arm/boot/dts/qcom-apq8074-dragonboard.dts
> +++ b/arch/arm/boot/dts/qcom-apq8074-dragonboard.dts
> @@ -58,6 +58,12 @@ eeprom: eeprom@52 {
>   	};
>   };
>   
> +&pm8941_coincell {
> +	qcom,rset-ohms = <2100>;
> +	qcom,vset-millivolts = <3000>;
> +	status = "okay";
> +};

Ok, this one might need reconsideration. I still didn't find the lithium 
accumulator of this size and granted that it might be the battery 
instead of the accumulator, it is safer not to enable the charger, at 
least by default.

> +
>   &pm8941_gpios {
>           msm_keys_default: pm8941-gpio-keys-state {
>   		pins = "gpio5", "gpio23";

-- 
With best wishes
Dmitry

