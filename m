Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54EFC63D42C
	for <lists+linux-pm@lfdr.de>; Wed, 30 Nov 2022 12:17:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234230AbiK3LR3 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 30 Nov 2022 06:17:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234119AbiK3LRT (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 30 Nov 2022 06:17:19 -0500
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FD8F76144
        for <linux-pm@vger.kernel.org>; Wed, 30 Nov 2022 03:17:18 -0800 (PST)
Received: by mail-lj1-x22b.google.com with SMTP id a19so4744085ljk.0
        for <linux-pm@vger.kernel.org>; Wed, 30 Nov 2022 03:17:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=afzp4FWEpwSn4P0lsi57nrF3Llc8uEfxBSb17oyT0Dc=;
        b=OFZnac3RQf0g0XdLHH+pZFgz2YWG12V3IOmX0UZWiEPxbfeLPv5iBAnVeM4cgXhRD4
         fcIxZhBGT52Ey+cpPhoL+XbWEo8TsCjMBfvLZaJxCZJiCf634DrjexXY1gEdKHMyTbDI
         AqXS0pv5qPLY3vEiDdzsCfGa0aXrY8DMtgomWD0esDjxzQlU+qH6J4+I9b/HTQ29HOQF
         Zx7vUvSerVFo1/wUo+AVdDY7Ob8kxPhRRztn5iQWT3+alJBGj0vQUB5Jsljm0gb+qko0
         g4WrgvOBeRHunQm3/r0fjVRKt+23QtsBpPnqoGAACBcphshprWFUaSk2bE5Qwfg730Z6
         XaFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=afzp4FWEpwSn4P0lsi57nrF3Llc8uEfxBSb17oyT0Dc=;
        b=l010sWEssSbB+mVjERJaa8JgIusXCcdK1yqcG4HKUJs8wol6MmkkV+mqcdLeLIoYts
         TgNBBTCl0WycLAJ2PR4dXLZUNWhLjS1uknWhO2oz3XcIk4bOFCR4JFoEq+5UrXGFPt5p
         bzsdrRBpg94vB3DeZzvKXD3ogUpN/YiKO9NXBe8JrqT4RKdoIPl5lFkNrSDE7ROYJjOS
         JDLLUrevA2qoqUnnLfNbyc3Iu5++iwWAowxKVUi7snZogs3C3D5wz52PaQ+FbcyhGttV
         1AOl0IucoUyesqMDuD2AqQb8d2bnYhBIkwBuCzoG9NRGX8zyZ0unJSB1d/aukMlT6phP
         5Xgw==
X-Gm-Message-State: ANoB5pmVjIgA2lHCqkbmc2+7W3SSucYrdw4lYda+BuBI6sTZUW1qqd0O
        QwpC6Z1bIncbBmoFSP8+WvQ8TQ==
X-Google-Smtp-Source: AA0mqf5mC/ri0BgfaDrZbrRFbczWPWfnOC6qwQb/WrdmleMZypvwB+lzH+SCuVbRmHd+GgSIBBwL3A==
X-Received: by 2002:a05:651c:ba5:b0:279:9a7c:ed14 with SMTP id bg37-20020a05651c0ba500b002799a7ced14mr6401877ljb.351.1669807037688;
        Wed, 30 Nov 2022 03:17:17 -0800 (PST)
Received: from [192.168.1.101] (95.49.125.236.neoplus.adsl.tpnet.pl. [95.49.125.236])
        by smtp.gmail.com with ESMTPSA id a15-20020a19f80f000000b004949f7cbb6esm219873lff.79.2022.11.30.03.17.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Nov 2022 03:17:16 -0800 (PST)
Message-ID: <7169238b-becd-2702-278c-f355df66ea97@linaro.org>
Date:   Wed, 30 Nov 2022 12:17:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH 05/12] arm64: dts: qcom: sm6115: Add PRNG node
Content-Language: en-US
To:     Adam Skladowski <a39.skl@gmail.com>
Cc:     phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Loic Poulain <loic.poulain@linaro.org>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
References: <20221129204616.47006-1-a39.skl@gmail.com>
 <20221129204616.47006-6-a39.skl@gmail.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20221129204616.47006-6-a39.skl@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 29.11.2022 21:46, Adam Skladowski wrote:
> Add a node for the PRNG to enable hw-accelerated pseudo-random number
> generation.
> 
> Signed-off-by: Adam Skladowski <a39.skl@gmail.com>
> ---
>  ar
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
ch/arm64/boot/dts/qcom/sm6115.dtsi | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm6115.dtsi b/arch/arm64/boot/dts/qcom/sm6115.dtsi
> index decbf7ca8a03..04620c272227 100644
> --- a/arch/arm64/boot/dts/qcom/sm6115.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm6115.dtsi
> @@ -497,6 +497,13 @@ qusb2_hstx_trim: hstx-trim@25b {
>  			};
>  		};
>  
> +		rng: rng@1b53000 {
> +			compatible = "qcom,prng-ee";
> +			reg = <0x01b53000 0x1000>;
> +			clocks = <&gcc GCC_PRNG_AHB_CLK>;
> +			clock-names = "core";
> +		};
> +
>  		spmi_bus: spmi@1c40000 {
>  			compatible = "qcom,spmi-pmic-arb";
>  			reg = <0x01c40000 0x1100>,
