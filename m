Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A93A73E16B
	for <lists+linux-pm@lfdr.de>; Mon, 26 Jun 2023 16:02:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230397AbjFZOCz (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 26 Jun 2023 10:02:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230400AbjFZOCx (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 26 Jun 2023 10:02:53 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 043C010E2
        for <linux-pm@vger.kernel.org>; Mon, 26 Jun 2023 07:02:47 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id 38308e7fff4ca-2b6a6f224a1so6521881fa.1
        for <linux-pm@vger.kernel.org>; Mon, 26 Jun 2023 07:02:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687788165; x=1690380165;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KwTeJb5rlu1F3icPpirusX7UnLyhDrrYtsrRQQcTXJM=;
        b=VJTbwz/Cn0vLxM4y+28IpN/gMNd4zV6qg3cXBGPHLjvPfMaGugncCiJ8SU/1lche1X
         vAHi6l4H72Q5FhX5soS1kf4xYRnDmHJHbUB7i43VrdS7SdbLkQUH5VzJfgHlz0gu5Gy2
         yfcVsMU8/f4bKsAzkffob9nW4t5YGoavTrnb58luhkHBVXmw1+tWvE1Q3Ysa8BxLtNfs
         tSdo1K07iYqoSW2vrBCwKLzjQlNEHbKh6GYDcc1YSGx0UAPd3DqDrnTrLl8KKXYeY6Wo
         Zc7D7ssMBk7kWrIOJDhfhGHHFTreUr0p7sTTR517s1Pw4pJbWmQfTVQ8YS/wihXjFaA4
         XrcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687788165; x=1690380165;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KwTeJb5rlu1F3icPpirusX7UnLyhDrrYtsrRQQcTXJM=;
        b=fcuGuerqP5b+S+ABiYrcWTIk4U2GkOR9AzMUyxBQl5cmeIUBL4TnEsfcuVPUrcHcY6
         Om0mwdFoYqRBd69Egr9ovIIkyV78sf1xg/e6ygSgjg4wGWoGh/y0F0froYgv2a5hz2if
         Auf/cZgioaadJrqZmsq64yoKF2L+51NkF4yl227Sq+fiy8hRe/tTLmAM3BJoC3ZQmgcG
         TyILWNWXs0n2n7Zp3jyxXnN4+F2cWWdpEvXaN+b84ATuS0HsdQzdOB/O3S682r+AraOM
         o97dgIhbuPF8Gq9yFlE8pb7EGj8TUcUydP//VEyzHtJfeMw5q+HubOWLozsaAs/6dEgo
         o0Lw==
X-Gm-Message-State: AC+VfDy+ySPBKR7ReMarVOGAovsHlElWF4c8/dz2Wfnr2V864OOsIOcy
        KsxJ1ju+PP4N3qOzr7QpJPSleg==
X-Google-Smtp-Source: ACHHUZ5DMl2r4sZdyz2vFP/VeGpG4L9YtKgOJWn90Ul/asn2Gwu/ZC2sVgtH6xZn/NJC2u9WlhI8TQ==
X-Received: by 2002:a2e:9106:0:b0:2b4:6d59:785f with SMTP id m6-20020a2e9106000000b002b46d59785fmr15774919ljg.43.1687788165237;
        Mon, 26 Jun 2023 07:02:45 -0700 (PDT)
Received: from [192.168.1.101] (abyk179.neoplus.adsl.tpnet.pl. [83.9.30.179])
        by smtp.gmail.com with ESMTPSA id g7-20020a2e9e47000000b002b1b92910c8sm1242593ljk.86.2023.06.26.07.02.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Jun 2023 07:02:44 -0700 (PDT)
Message-ID: <9d829b96-d6f0-b551-8312-c6d71bfaa3cd@linaro.org>
Date:   Mon, 26 Jun 2023 16:02:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v2 26/26] ARM: dts: qcom: ipq8064: drop 'regulator'
 property from SAW2 devices
Content-Language: en-US
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Ilia Lin <ilia.lin@kernel.org>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Georgi Djakov <djakov@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-clk@vger.kernel.org,
        Christian Marangi <ansuelsmth@gmail.com>,
        Stephan Gerhold <stephan@gerhold.net>
References: <20230625202547.174647-1-dmitry.baryshkov@linaro.org>
 <20230625202547.174647-27-dmitry.baryshkov@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230625202547.174647-27-dmitry.baryshkov@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 25.06.2023 22:25, Dmitry Baryshkov wrote:
> The SAW2 device should describe the regulator constraints rather than
> just declaring that it has the regulator.
> 
> Drop the 'regulator' property. If/when CPU voltage scaling is
> implemented for this platform, proper regulator nodes show be added
> instead.
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
>  arch/arm/boot/dts/qcom/qcom-ipq8064.dtsi | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/qcom/qcom-ipq8064.dtsi b/arch/arm/boot/dts/qcom/qcom-ipq8064.dtsi
> index 6198f42f6a9c..ecb99e104de0 100644
> --- a/arch/arm/boot/dts/qcom/qcom-ipq8064.dtsi
> +++ b/arch/arm/boot/dts/qcom/qcom-ipq8064.dtsi
> @@ -589,7 +589,6 @@ acc0: clock-controller@2088000 {
>  		saw0: regulator@2089000 {
>  			compatible = "qcom,saw2";
>  			reg = <0x02089000 0x1000>, <0x02009000 0x1000>;
> -			regulator;
>  		};
>  
>  		acc1: clock-controller@2098000 {
> @@ -604,7 +603,6 @@ acc1: clock-controller@2098000 {
>  		saw1: regulator@2099000 {
>  			compatible = "qcom,saw2";
>  			reg = <0x02099000 0x1000>, <0x02009000 0x1000>;
> -			regulator;
>  		};
>  
>  		nss_common: syscon@3000000 {
