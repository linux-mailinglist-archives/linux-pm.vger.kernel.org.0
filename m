Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D30DE63D457
	for <lists+linux-pm@lfdr.de>; Wed, 30 Nov 2022 12:22:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234156AbiK3LWG (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 30 Nov 2022 06:22:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234238AbiK3LVR (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 30 Nov 2022 06:21:17 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 729D03D93E
        for <linux-pm@vger.kernel.org>; Wed, 30 Nov 2022 03:20:57 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id c1so26409368lfi.7
        for <linux-pm@vger.kernel.org>; Wed, 30 Nov 2022 03:20:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=p8z4N/bD53MVMrj31OH+QdwJAqTl5OmwA543jlEPLgE=;
        b=RQbKcCc3pbRTn1XcyRiu1RjlTwkKGioXyRRQtEDLoNVTHAZBAtehHzcFxw6CgZK9tN
         AjRwgiBqlfgxHOWZN7/0j3H7AipXC/xiOm/PNEilnhDkSzfvGt0J1YEzooU8UnQcEb0h
         Ol2QO4HJJELN4mieIr2elnrmpqb6TVJynsMHi0r88R3zdimfIm1MuKMVOuP2OAlCw2Hx
         +12EBpf80HdWERUj/9fvby5gZns38Z5TJvL3ebIuPFncI1uYv9dIInVu7fzPb2q4MqLU
         OuR2vKvUUrY2TX+Fc65uNkXpMPsgxpI3YAVHFiEpoh9bmObcs+AYZ5O8TfSuh9eFq6ML
         bgLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=p8z4N/bD53MVMrj31OH+QdwJAqTl5OmwA543jlEPLgE=;
        b=z3Kg4bgMr7MDTVeK81CTbV5W85SDxjkrQAcQzbuFUdZktZqetDoDci9vGVN0IIKHgK
         8t7DSSyqlfppFGm2XETd9onW24z5yAwpFAFOZsuYCtjquJTP4CbLghfSYSu8j0G5zqnf
         pBQxbaVzM2SV6KJKGKzoXYHX0myghKfSUsaH4adLUaUwy33IPVuX+wQjf+tpwuULCvbM
         GUpqxu9MRB5TPDo5JGgVpWdf5ysuyIc1I+wV09Yl7sD+vB73aUDC0dqNkp2DVnHALYnR
         QxZAFXAPqbfnX6+6qyReSy9VxoGXU0O4r30V4rNyFmGFiaVcoQRQqflc4p7Q2IpCInDP
         iKmg==
X-Gm-Message-State: ANoB5pkmjISIVGe7p6kHpIAsh48q9ZtABjVdMksECaHjd+dCJLOed9WV
        /bGQIQ3b/XdDBpVGtiPH4KmK1w==
X-Google-Smtp-Source: AA0mqf5wlmDEFG3H08ZgmA9VY97ACdqNpjQVnmj9UYjdNINlcDXeKxHUOUNrSXADPCEvy23Z/xIL0g==
X-Received: by 2002:ac2:5e70:0:b0:4ad:3f25:60f4 with SMTP id a16-20020ac25e70000000b004ad3f2560f4mr14578605lfr.92.1669807255818;
        Wed, 30 Nov 2022 03:20:55 -0800 (PST)
Received: from [192.168.1.101] (95.49.125.236.neoplus.adsl.tpnet.pl. [95.49.125.236])
        by smtp.gmail.com with ESMTPSA id q20-20020a056512211400b004b0317a1035sm219278lfr.109.2022.11.30.03.20.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Nov 2022 03:20:55 -0800 (PST)
Message-ID: <2efca01d-69b8-b96f-d351-0b68339920c7@linaro.org>
Date:   Wed, 30 Nov 2022 12:20:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH 12/12] arm64: dts: qcom: sm6115: Fallback smmu to qcom
 generic compatible
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
 <20221129204616.47006-13-a39.skl@gmail.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20221129204616.47006-13-a39.skl@gmail.com>
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
> Change fallback to qcom generic compatible
> in order to prevent reboot during SMMU initialization.
> 
> Signed-off-by: Adam Skladowski <a39.skl@gmail.com>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
>  arch/arm64/boot/dts/qcom/sm6115.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm6115.dtsi b/arch/arm64/boot/dts/qcom/sm6115.dtsi
> index 36d1cff23d10..b00d74055eb1 100644
> --- a/arch/arm64/boot/dts/qcom/sm6115.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm6115.dtsi
> @@ -1222,7 +1222,7 @@ dispcc: clock-controller@5f00000 {
>  		};
>  
>  		apps_smmu: iommu@c600000 {
> -			compatible = "qcom,sm6115-smmu-500", "arm,mmu-500";
> +			compatible = "qcom,sm6115-smmu-500", "qcom,smmu-500", "arm,mmu-500";
>  			reg = <0x0c600000 0x80000>;
>  			#iommu-cells = <2>;
>  			#global-interrupts = <1>;
