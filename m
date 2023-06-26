Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A83173DE38
	for <lists+linux-pm@lfdr.de>; Mon, 26 Jun 2023 13:52:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229553AbjFZLwf (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 26 Jun 2023 07:52:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjFZLwf (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 26 Jun 2023 07:52:35 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBAC41AA
        for <linux-pm@vger.kernel.org>; Mon, 26 Jun 2023 04:52:33 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id 38308e7fff4ca-2b5c231f842so22368401fa.2
        for <linux-pm@vger.kernel.org>; Mon, 26 Jun 2023 04:52:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687780352; x=1690372352;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xIJ9hRsLZ2UaL/GL73p9WL5lXmaut5AkhhP3GWo2LBU=;
        b=C5UMMImzWaPz4ozUJoP2a4zxQLewr7CfnLmALdNL7X4MVmGinmod8eAEJzTT1FbOzf
         wbZ6FVM64Zxl7VNNWsYyPPhgy/lWfkKAkelR7rqCMcoWL5nNhkVHmDjKLVHJD0QRmHCg
         y5UjDkvx31QH+KXJ10qAI6z2J73YykkpIK3XmTDCanv6VCgJmIvJ/J0Lna4lkKoS6ub2
         WCRhGhY7RtpQ1YYEeIsbA5mE/VLWzr7t8Bj2bOuIgtr5Bh8bGU5lKzZ1fF4a5exqJ/lK
         mQKNrH7TsCPMmCmOX8yhXK6SAZyyqAvug1xK9HrXJTSjRScKmFAqPPnSDhHSOuvGLBpo
         Bdng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687780352; x=1690372352;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xIJ9hRsLZ2UaL/GL73p9WL5lXmaut5AkhhP3GWo2LBU=;
        b=ZV4lCi3w191FsZGohFTwmKQpFpKmXi01VkOJxdSFxahDDZPMTZg8IcVyqmft5F/n+H
         inFXmB0ObKGBnCovp3eLR+1cZjXkQbii3ORqNUjn3Ygw+Sn54Sd3qWP7PP/I8HfvBnob
         CVwYEpARtZUPFzNJ7867NoVgOfnmOWp0TV48kM8yLxfi8k5ReUXR6+2KvEpLufCzLVT/
         8TM8sDximFGkM5rth2qBE5lhmP7ek52Zb7J/sjT3o9nTHHDu1bKufUqlF9PNAi7jNNMu
         t8784i+A9WXuoi/gPAsdR+JC050C+4Ldn8lgCAurC+eVu3tPx2C8Mn9q3O3bIpB9Xhs5
         w3yw==
X-Gm-Message-State: AC+VfDxFOwOk3PUNABviuEX03hDNSBaUIWAtulVF1wtgtw740BANUpdp
        z7a8OP/w7r8KM9uYyuwHz65dsw==
X-Google-Smtp-Source: ACHHUZ4r5ANrjA23+metmms4eHgovsDYKjO7/JJoIOH4/b2T+DWKksrzrNU6ocMu3ZUIgTJ42QuqTw==
X-Received: by 2002:a05:651c:1036:b0:2b6:a4d5:2a4b with SMTP id w22-20020a05651c103600b002b6a4d52a4bmr903803ljm.33.1687780352176;
        Mon, 26 Jun 2023 04:52:32 -0700 (PDT)
Received: from [192.168.1.101] (abyk179.neoplus.adsl.tpnet.pl. [83.9.30.179])
        by smtp.gmail.com with ESMTPSA id w10-20020a2e998a000000b002b4840990d7sm1172054lji.114.2023.06.26.04.52.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Jun 2023 04:52:31 -0700 (PDT)
Message-ID: <de216014-e5df-dbfa-b861-3b880694893f@linaro.org>
Date:   Mon, 26 Jun 2023 13:52:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v2 14/26] ARM: dts: qcom: apq8064: rename SAW nodes to
 power-manager
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
 <20230625202547.174647-15-dmitry.baryshkov@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230625202547.174647-15-dmitry.baryshkov@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 25.06.2023 22:25, Dmitry Baryshkov wrote:
> Per the power-domain.yaml, the power-controller node name is reserved
> for power-domain providers. Rename SAW2 nodes to 'power-manager', the
> name which is suggested by qcom,spm.yaml
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
>  arch/arm/boot/dts/qcom/qcom-apq8064.dtsi | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/qcom/qcom-apq8064.dtsi b/arch/arm/boot/dts/qcom/qcom-apq8064.dtsi
> index d2289205ff81..471eeca6a589 100644
> --- a/arch/arm/boot/dts/qcom/qcom-apq8064.dtsi
> +++ b/arch/arm/boot/dts/qcom/qcom-apq8064.dtsi
> @@ -422,25 +422,25 @@ acc3: clock-controller@20b8000 {
>  			#clock-cells = <0>;
>  		};
>  
> -		saw0: power-controller@2089000 {
> +		saw0: power-manager@2089000 {
>  			compatible = "qcom,apq8064-saw2-v1.1-cpu", "qcom,saw2";
>  			reg = <0x02089000 0x1000>, <0x02009000 0x1000>;
>  			regulator;
>  		};
>  
> -		saw1: power-controller@2099000 {
> +		saw1: power-manager@2099000 {
>  			compatible = "qcom,apq8064-saw2-v1.1-cpu", "qcom,saw2";
>  			reg = <0x02099000 0x1000>, <0x02009000 0x1000>;
>  			regulator;
>  		};
>  
> -		saw2: power-controller@20a9000 {
> +		saw2: power-manager@20a9000 {
>  			compatible = "qcom,apq8064-saw2-v1.1-cpu", "qcom,saw2";
>  			reg = <0x020a9000 0x1000>, <0x02009000 0x1000>;
>  			regulator;
>  		};
>  
> -		saw3: power-controller@20b9000 {
> +		saw3: power-manager@20b9000 {
>  			compatible = "qcom,apq8064-saw2-v1.1-cpu", "qcom,saw2";
>  			reg = <0x020b9000 0x1000>, <0x02009000 0x1000>;
>  			regulator;
