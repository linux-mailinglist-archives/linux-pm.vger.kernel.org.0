Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0639B6FA2EE
	for <lists+linux-pm@lfdr.de>; Mon,  8 May 2023 11:04:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233527AbjEHJEL (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 8 May 2023 05:04:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233630AbjEHJEA (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 8 May 2023 05:04:00 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58F882270C
        for <linux-pm@vger.kernel.org>; Mon,  8 May 2023 02:03:28 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-4f00c33c3d6so4859437e87.2
        for <linux-pm@vger.kernel.org>; Mon, 08 May 2023 02:03:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683536579; x=1686128579;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=L5XC8hcrbTH9T9jfdCxjdW2XSIA/sXIbztYYYcjqdn8=;
        b=mnnaGoG8V9JX35yCilZU3TXa8R+IWgTZ5yL9un2xU5cZcwlYjj77Lnl+a+Nj2Ltn6f
         0228pycqbRTvMTXoy2w4VTy99if637NBlNFVXvPsUV1FLUraKNusRl4d2hDzkAwf9KzM
         DqeoVAHwjGyo0SbaPEEk7k+dEqbvSrEq3UroAhj+znykKzNBU0RfHt2TCj0aGfudy45Y
         h2wi9TthbvbgdUpFQ0oAIBO9ek5HOqw9d/o2QKwregTcrxMW0YUJ/g2aHYWSDG/0g9cb
         laxfQIEZNRZW7GkrRPKXGoD4+QDMJbU8IePCIU/b1gKLtEAEcy/LNi2mLRgF6T2QfmQQ
         xx+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683536579; x=1686128579;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=L5XC8hcrbTH9T9jfdCxjdW2XSIA/sXIbztYYYcjqdn8=;
        b=mG53V7SUhyrs2aYKstrk54S8GOnN9akmXkVALX4aZcsDDfYFICYuDPViQZzkJQlzxo
         H4zw3JP9rdToIdXIkgCUHESFv7Y/9F8ryXZzUXPM8LjeHzaeJ5SIVnZN747KAeiNnZJ6
         wxwGsRaBvBNktkgqGkQ4FCBTQNtQN4jAxTXiyoEUJBXrUbppNhaEb2cH/iD0y791NB/G
         PkwYuFYcjNS/6Bp8rA3AsBh+bXeEN5IDlqHSNIfElYa+JIqCNBxKXyarsGronR+ASUPH
         g+UeIwVOt3kJSBw9CMdLhaDP3q/ykCkGpOtWYbEIMiS6/+MTztuofrdPMUptpoeHIEu3
         tQAg==
X-Gm-Message-State: AC+VfDwsW3SJ/ln+DvE/nApPCxdmLKEtGMdzqXwGlqwPhyZGQ9y3F0Pa
        rMGC0HLP28/3vYIXhbB1tdksGmCTMdzMxOy/428=
X-Google-Smtp-Source: ACHHUZ4JSRH8ERvqg/6gCRmhtrXiAiXlxZTv7304piWXkYDo8633+T951jXmfq8X6w0AOcUzwalHUQ==
X-Received: by 2002:ac2:4944:0:b0:4ef:f64b:65a9 with SMTP id o4-20020ac24944000000b004eff64b65a9mr2611495lfi.36.1683536578975;
        Mon, 08 May 2023 02:02:58 -0700 (PDT)
Received: from [192.168.1.101] (abyl248.neoplus.adsl.tpnet.pl. [83.9.31.248])
        by smtp.gmail.com with ESMTPSA id n2-20020ac242c2000000b004eca2b1c5b4sm1240152lfl.229.2023.05.08.02.02.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 May 2023 02:02:58 -0700 (PDT)
Message-ID: <e6120d5e-cba5-200a-1c27-0a69ca7a5c5b@linaro.org>
Date:   Mon, 8 May 2023 11:02:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH 6/6] ARM: dts: qcom: apq8074-dragonboard: enable coincell
 charger
Content-Language: en-US
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Vinod Koul <vkoul@kernel.org>
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
References: <20230508003309.2363787-1-dmitry.baryshkov@linaro.org>
 <20230508003309.2363787-7-dmitry.baryshkov@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230508003309.2363787-7-dmitry.baryshkov@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 8.05.2023 02:33, Dmitry Baryshkov wrote:
> Enable coincell charger for the coin battery which can be installed on
> the APQ8074 dragonboard.
Wait.. you can insert a CR2023 or whatever and charge it?

That's the most expensive and ridiculous charger.. I love it..
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
>  arch/arm/boot/dts/qcom-apq8074-dragonboard.dts | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/qcom-apq8074-dragonboard.dts b/arch/arm/boot/dts/qcom-apq8074-dragonboard.dts
> index 16d609b85dfe..1d1c08674254 100644
> --- a/arch/arm/boot/dts/qcom-apq8074-dragonboard.dts
> +++ b/arch/arm/boot/dts/qcom-apq8074-dragonboard.dts
> @@ -113,6 +113,12 @@ &mdss {
>  	status = "okay";
>  };
>  
> +&pm8941_coincell {
> +	qcom,rset-ohms = <2100>;
> +	qcom,vset-millivolts = <3000>;
> +	status = "okay";
> +};
> +
>  &pm8941_gpios {
>          msm_keys_default: pm8941-gpio-keys-state {
>                  pinconf {
