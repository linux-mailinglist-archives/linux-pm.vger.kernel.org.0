Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65812745B1B
	for <lists+linux-pm@lfdr.de>; Mon,  3 Jul 2023 13:31:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231241AbjGCLa7 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 3 Jul 2023 07:30:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231240AbjGCLay (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 3 Jul 2023 07:30:54 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3CE6E61
        for <linux-pm@vger.kernel.org>; Mon,  3 Jul 2023 04:30:41 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-4f766777605so6647834e87.1
        for <linux-pm@vger.kernel.org>; Mon, 03 Jul 2023 04:30:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688383840; x=1690975840;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aqx9N5F2XlYeaK5a2sti8IvxHiDVBIFy2LMVY7f65VE=;
        b=GS3gFbODsNgZwPupk/SLMdjt6yjQFdJxOz8Wn2ag33RAxoIsZXuD5tZTcNad9PoR8o
         bz+ckFx+H8cUWNOae8/maImTeUKp4sI7trnGesuXJX7R8ag3eXeOo0+WyJLc7E7zJcK5
         n5x5ABBt8AwuUSZJUIqJP6vhkiwt5aVFRK7zvPO4JNylvEGN1jMz69hbSHql9KlwhvcF
         SJ5UdMDtQZLZON2x8qn8CXeexfJPtAj4VNbBHQ3lJQhVJufnHLbLK3e9BjVjCIQGI0pB
         pH8Gojyt3/5HwKLtWY45bgw6daVdLinieCbmijtX6Rze2R7+ktPgV5A1rIR56NK7uIoi
         G9qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688383840; x=1690975840;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aqx9N5F2XlYeaK5a2sti8IvxHiDVBIFy2LMVY7f65VE=;
        b=e3kd1UBHtWv8qV3EzrWYpxIWe654mjdDtj2dyu3xLq6UNeYKTCYslSJQHqyj7vDnyd
         NNtSopNIHpnpRTU2yX3/2GTa6+VSUvsQHd0XrBfqrfDzhnj0rg6ERLFsjvBvMfejQ4Ah
         XJ8ZD2lgnepBKFLp8PKX+k5raisxktuoDteZDB49yu/QPvr6aedVKqEbRnpKS0sD4k/m
         bvczAarS3fjLYAgYraEWEgt8Atl1bUOxgqczUciCokVbncph8YGOtwc+rN8Ef3EbLV0Y
         vi6+ShOv+A1FxBYvgPX7ngaBPar3ddrHiMSLCZsWKkjCQTvElJRwz5MW8534eebygKWk
         NwhA==
X-Gm-Message-State: ABy/qLaFE943UD69hido5JdZa2lPGEtYVIPSd5VrQ5BfkcibYeHETzts
        aQleSwgYyC5z+XZV2a9W+dlX8A==
X-Google-Smtp-Source: APBJJlENN4uukIE9GG5iHfqtC3rHnshXkPEaKmjkg8AHkEvMY8oBuKDf8pFZVXicAbtVNorkKMi+Og==
X-Received: by 2002:a05:6512:39c9:b0:4fb:93db:fff3 with SMTP id k9-20020a05651239c900b004fb93dbfff3mr7616076lfu.16.1688383840244;
        Mon, 03 Jul 2023 04:30:40 -0700 (PDT)
Received: from [192.168.1.101] (abyj26.neoplus.adsl.tpnet.pl. [83.9.29.26])
        by smtp.gmail.com with ESMTPSA id w14-20020ac2442e000000b004fbab5283ecsm1493879lfl.126.2023.07.03.04.30.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Jul 2023 04:30:39 -0700 (PDT)
Message-ID: <b7b92190-4c64-7784-22d2-bb4a472386e4@linaro.org>
Date:   Mon, 3 Jul 2023 13:30:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v3 22/28] ARM: dts: qcom: apq8064: add simple CPUFreq
 support
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
References: <20230702174246.121656-1-dmitry.baryshkov@linaro.org>
 <20230702174246.121656-23-dmitry.baryshkov@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230702174246.121656-23-dmitry.baryshkov@linaro.org>
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

On 2.07.2023 19:42, Dmitry Baryshkov wrote:
> Declare CPU frequency-scaling properties. Each CPU has its own clock,
> how all CPUs have the same OPP table. Voltage scaling is not (yet)
> enabled with this patch. It will be enabled later.
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---
[...]

>  
> +        cpu_opp_table: opp-table-cpu {
> +		compatible = "operating-points-v2-krait-cpu";
> +		nvmem-cells = <&speedbin_efuse>;
> +
> +		/*
> +		 * Voltage thresholds are <target min max>
> +		 */
/* Voltage thresholds are <target min max> */

> +		opp-384000000 {
> +			opp-hz = /bits/ 64 <384000000>;
> +			opp-peak-kBps = <384000>;
> +			opp-microvolt-speed0-pvs0 = <950000 950000 975000>;
> +			opp-microvolt-speed0-pvs1 = <925000 900000 950000>;
> +			opp-microvolt-speed0-pvs3 = <875000 850000 900000>;
>
[...]

> +
>  	memory@0 {
>  		device_type = "memory";
>  		reg = <0x0 0x0>;
> @@ -834,6 +1313,9 @@ qfprom: qfprom@700000 {
>  			#address-cells = <1>;
>  			#size-cells = <1>;
>  			ranges;
> +			speedbin_efuse: speedbin@c0 {
> +				reg = <0x0c0 0x4>;
no bits=<>?

> +			};
Newline between properties & subnodes and between each subnode, please

lgtm otherwise, although I'm not checking these magic volt values

Konrad
>  			tsens_calib: calib@404 {
>  				reg = <0x404 0x10>;
>  			};
