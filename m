Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F59473E5A1
	for <lists+linux-pm@lfdr.de>; Mon, 26 Jun 2023 18:46:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229728AbjFZQqs (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 26 Jun 2023 12:46:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230385AbjFZQqn (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 26 Jun 2023 12:46:43 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7012B83
        for <linux-pm@vger.kernel.org>; Mon, 26 Jun 2023 09:46:29 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id 2adb3069b0e04-4fb7b2e3dacso1098024e87.0
        for <linux-pm@vger.kernel.org>; Mon, 26 Jun 2023 09:46:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687797988; x=1690389988;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kLVBZW3jhIX4WPNShh3aPc/rKcNIqlHAuakYQi0HsRE=;
        b=O+3kX2iDBkcxeYoXg7gCMyTUDfPBiPK1ie9WMimjyWh/CiDDk9COE48XLhC2wBOhiV
         TCKUrJmMuL2Fr/P5DLAb2hN0ux3sQzrpxX38Uzd89a77XsOU3kmiKSYxru+8aYFnuCs2
         syhkcgUgisZ1xBqy8hQYsQgK0CGXKBYoeiy3aTtNDVOOqrvwpPLzn/m3xJtBMECiaBA+
         fal6iKPa7YAlMcud6yVIqa2A5HvPytOz3mUlRWm2wX8ERfXh2942ZKsvcoyTyogEaLVV
         kTIP/A45ziKfhl1D/iXO72fE/oTuJjKqjaVoYbz6JFJUNebG2yvT8BawE3kBJQqsMBZ9
         88tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687797988; x=1690389988;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kLVBZW3jhIX4WPNShh3aPc/rKcNIqlHAuakYQi0HsRE=;
        b=a15kNNOuQOhC0RixakK7sMe3mlt9mXwgCEOkqcqMmV9BoAZ7rYRk2xw+qJxIfCHyfy
         +ScPz+eYToYsu9fj7z76o+FxZMu6i78kSDDzmfKRc8U356hEPA3VXj8WRY11Js/FKNj3
         DpGp/1JGFM7LwW++18IaE/+EutEcfxZZZTBhGBJOaATSHEQO0CumADD/BrGGTwYxqRE7
         x9xUxY8Sh5AUXmnXLO9Gx3uwjq2GWeZj0tB6/bMkFXf85jMMsXnVAF+cM4joSbnLSZbE
         RZCJKA+gfyRqPO4Wa3pPKB4mEmqt7or31iYZWvvqXVH2Z6NOoqNOg8wbmnJfMMP3d0MJ
         mHOw==
X-Gm-Message-State: AC+VfDyt3AxRZolmk+NLgAF2UB6kcyP8zdZfZOwab17RaEVSSPyJ2S+l
        2W/lHenEh/NKajMgHziacy0uAQ==
X-Google-Smtp-Source: ACHHUZ5nXflaTvxrhp4WYWZZsaF8/Ff7sr/AIAPNmkh7EJ56+AothaEJp1GWUAGXoUeYZdVGHtb4DQ==
X-Received: by 2002:ac2:4f0a:0:b0:4fb:7404:538b with SMTP id k10-20020ac24f0a000000b004fb7404538bmr2402636lfr.66.1687797987624;
        Mon, 26 Jun 2023 09:46:27 -0700 (PDT)
Received: from [192.168.1.101] (abyk179.neoplus.adsl.tpnet.pl. [83.9.30.179])
        by smtp.gmail.com with ESMTPSA id z5-20020ac25de5000000b004fa52552c7csm1026056lfq.151.2023.06.26.09.46.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Jun 2023 09:46:27 -0700 (PDT)
Message-ID: <98c55d93-3971-513c-0f3f-4d4ac373aaac@linaro.org>
Date:   Mon, 26 Jun 2023 18:46:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v2 16/26] ARM: dts: qcom: apq8064: add L2 cache scaling
Content-Language: en-US
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
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
 <20230625202547.174647-17-dmitry.baryshkov@linaro.org>
 <9d49ecb6-1efd-0f19-c787-9baca79846fe@linaro.org>
In-Reply-To: <9d49ecb6-1efd-0f19-c787-9baca79846fe@linaro.org>
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

On 26.06.2023 18:37, Konrad Dybcio wrote:
> On 25.06.2023 22:25, Dmitry Baryshkov wrote:
>> Populate L2 cache node with clock, supplies and OPP information to
>> facilitate scaling L2 frequency.
>>
>> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
>> ---
> Are the L2 voltage ranges independent of speedbin?
> 
> Konrad
>>  arch/arm/boot/dts/qcom/qcom-apq8064.dtsi | 101 ++++++++++++++++++++++-
>>  1 file changed, 100 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/arm/boot/dts/qcom/qcom-apq8064.dtsi b/arch/arm/boot/dts/qcom/qcom-apq8064.dtsi
>> index 1eb6d752ebae..ac07170c702f 100644
>> --- a/arch/arm/boot/dts/qcom/qcom-apq8064.dtsi
>> +++ b/arch/arm/boot/dts/qcom/qcom-apq8064.dtsi
>> @@ -81,9 +81,108 @@ CPU3: cpu@3 {
>>  		};
>>  
>>  		L2: l2-cache {
>> -			compatible = "cache";
>> +			compatible = "qcom,krait-l2-cache", "cache";
>>  			cache-level = <2>;
>>  			cache-unified;
>> +			vdd-mem-supply = <&pm8921_l24>;
>> +			vdd-dig-supply = <&pm8921_s3>;
Another thing I've noticed.. we've grown out of referencing
PMIC specifics in the SoC dtsi..

Do we know what PMIC configurations has this one shipped with?

Konrad
>> +			clocks = <&kraitcc KRAIT_L2>;
>> +			#interconnect-cells = <1>;
>> +			operating-points-v2 = <&l2_opp_table>;
>> +
>> +			l2_opp_table: opp-table-l2 {
>> +				compatible = "operating-points-v2";
>> +
>> +				opp-384000000 {
>> +					opp-hz = /bits/ 64 <384000000>;
>> +					opp-microvolt = <1050000 1050000 1150000>,
>> +							<950000 950000 1150000>;
>> +				};
>> +
>> +				opp-432000000 {
>> +					opp-hz = /bits/ 64 <432000000>;
>> +					opp-microvolt = <1050000 1050000 1150000>,
>> +							<1050000 1050000 1150000>;
>> +				};
>> +
>> +				opp-486000000 {
>> +					opp-hz = /bits/ 64 <486000000>;
>> +					opp-microvolt = <1050000 1050000 1150000>,
>> +							<1050000 1050000 1150000>;
>> +				};
>> +
>> +				opp-540000000 {
>> +					opp-hz = /bits/ 64 <540000000>;
>> +					opp-microvolt = <1050000 1050000 1150000>,
>> +							<1050000 1050000 1150000>;
>> +				};
>> +
>> +				opp-594000000 {
>> +					opp-hz = /bits/ 64 <594000000>;
>> +					opp-microvolt = <1050000 1050000 1150000>,
>> +							<1050000 1050000 1150000>;
>> +				};
>> +
>> +				opp-648000000 {
>> +					opp-hz = /bits/ 64 <648000000>;
>> +					opp-microvolt = <1050000 1050000 1150000>,
>> +							<1050000 1050000 1150000>;
>> +				};
>> +
>> +				opp-702000000 {
>> +					opp-hz = /bits/ 64 <702000000>;
>> +					opp-microvolt = <1150000 1150000 1150000>,
>> +							<1150000 1150000 1150000>;
>> +				};
>> +
>> +				opp-756000000 {
>> +					opp-hz = /bits/ 64 <756000000>;
>> +					opp-microvolt = <1150000 1150000 1150000>,
>> +							<1150000 1150000 1150000>;
>> +				};
>> +
>> +				opp-810000000 {
>> +					opp-hz = /bits/ 64 <810000000>;
>> +					opp-microvolt = <1150000 1150000 1150000>,
>> +							<1150000 1150000 1150000>;
>> +				};
>> +
>> +				opp-864000000 {
>> +					opp-hz = /bits/ 64 <864000000>;
>> +					opp-microvolt = <1150000 1150000 1150000>,
>> +							<1150000 1150000 1150000>;
>> +				};
>> +
>> +				opp-918000000 {
>> +					opp-hz = /bits/ 64 <918000000>;
>> +					opp-microvolt = <1150000 1150000 1150000>,
>> +							<1150000 1150000 1150000>;
>> +				};
>> +
>> +				opp-972000000 {
>> +					opp-hz = /bits/ 64 <972000000>;
>> +					opp-microvolt = <1150000 1150000 1150000>,
>> +							<1150000 1150000 1150000>;
>> +				};
>> +
>> +				opp-1026000000 {
>> +					opp-hz = /bits/ 64 <1026000000>;
>> +					opp-microvolt = <1150000 1150000 1150000>,
>> +							<1150000 1150000 1150000>;
>> +				};
>> +
>> +				opp-1080000000 {
>> +					opp-hz = /bits/ 64 <1080000000>;
>> +					opp-microvolt = <1150000 1150000 1150000>,
>> +							<1150000 1150000 1150000>;
>> +				};
>> +
>> +				opp-1134000000 {
>> +					opp-hz = /bits/ 64 <1134000000>;
>> +					opp-microvolt = <1150000 1150000 1150000>,
>> +							<1150000 1150000 1150000>;
>> +				};
>> +			};
>>  		};
>>  
>>  		idle-states {
