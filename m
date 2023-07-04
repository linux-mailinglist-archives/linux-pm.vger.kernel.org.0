Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7087747234
	for <lists+linux-pm@lfdr.de>; Tue,  4 Jul 2023 15:05:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231218AbjGDNFg (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 4 Jul 2023 09:05:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230262AbjGDNFg (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 4 Jul 2023 09:05:36 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 561B8E7E
        for <linux-pm@vger.kernel.org>; Tue,  4 Jul 2023 06:05:34 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id 38308e7fff4ca-2b6994a8ce3so82725891fa.1
        for <linux-pm@vger.kernel.org>; Tue, 04 Jul 2023 06:05:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688475932; x=1691067932;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PrzP3x8rgX7uv0mcXjM6HV/hGVRhTiexE9S+TLANH1E=;
        b=Zxut4O41cLRVFD5cs5PUSWPh9SfEeQcDbELTYVhRthsJo6xQFCDGahSbWqZSYLA4X+
         zMtVGi04aiOhTDES+x/6AUbNSDR6Urc1LKa8a6iJyT9/9oFMKJotI3ZO8LdsV9t8R07i
         pROV3z06xQ/+1x3NshCcQu462OMjxEylpFcCJTezHRz7XXfpIupN6EuU0W7U8O/AGNGb
         ZYy2ek7hSGNhs6fl4NAQsziFoJWpGd6EAIAFMFg2KOZXJf52g+nBpeDBK/QPbosNIde6
         W9rqir+2/9UNvbk6gZg4g4n1ffo+9d2aVpbf8J0Is4XwcW3XnDpz0pafitZoskV8L5wH
         DUvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688475932; x=1691067932;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PrzP3x8rgX7uv0mcXjM6HV/hGVRhTiexE9S+TLANH1E=;
        b=HJQbI6uCE3fDzuI8eckYy2it9gewEMsRibvo4KI0LXzgOCsJm8EqM0yo8ZN5mExdCC
         hXeHxMID9KI1wL49s6IW4OKmsuT7vOJVwJjtIIWBcWyDvWb3WJgwtwz9rlDBT+27jL1u
         eJVAWPWQtWZy1MXMaD8h5EJsZrEUybvYx2JIwcvQkktAq9A7DKlxVqbAQNLG1lDt4ZnS
         WiXIit9b90kjbjhsZ6ASfUJhzEYp/SkZXtuNdZ5kk5J4hBuHCW29/UNJWzqt+5NtJSOO
         0QNyzLBnkhUnhTyhRRnleTuAVvFzgYi1+iXzcyANun5gYuCcb3DvypJJE0LN/vJQRLGq
         PWyg==
X-Gm-Message-State: ABy/qLZj8uvB9RjB/byOEI9Qwm+FY6hSSfl9ACR22K/U/NEbXnxQjCza
        JxOBvaF6f0CMud+k4P3IeILWIA==
X-Google-Smtp-Source: APBJJlEzzioEHFN8bHZCH2/jAHHFuHEPnRxFPf1nS5EVS+nUae5/UL/W7TMJeeniRpG0UfV0HujkSg==
X-Received: by 2002:a2e:740b:0:b0:2b6:d6e1:a191 with SMTP id p11-20020a2e740b000000b002b6d6e1a191mr8028266ljc.23.1688475932519;
        Tue, 04 Jul 2023 06:05:32 -0700 (PDT)
Received: from [192.168.1.101] (abyj26.neoplus.adsl.tpnet.pl. [83.9.29.26])
        by smtp.gmail.com with ESMTPSA id n13-20020a2e904d000000b002b6d3261571sm2890153ljg.99.2023.07.04.06.05.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Jul 2023 06:05:32 -0700 (PDT)
Message-ID: <3231276b-7906-1cbe-6edd-73098118449a@linaro.org>
Date:   Tue, 4 Jul 2023 15:05:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [RFC PATCH 8/8] ARM: dts: qcom: apq8064: add simple CPUFreq
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
References: <20230702175045.122041-1-dmitry.baryshkov@linaro.org>
 <20230702175045.122041-9-dmitry.baryshkov@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230702175045.122041-9-dmitry.baryshkov@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 2.07.2023 19:50, Dmitry Baryshkov wrote:

Subject: wrong soc

> Declare CPU frequency-scaling properties. Each CPU has its own clock,
> how all CPUs have the same OPP table. Voltage scaling is not (yet)
> enabled with this patch. It will be enabled later.
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---Same concern as patch 4, can't see where these values came from.

Konrad
>  arch/arm/boot/dts/qcom/qcom-msm8960.dtsi | 147 +++++++++++++++++++++++
>  1 file changed, 147 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/qcom/qcom-msm8960.dtsi b/arch/arm/boot/dts/qcom/qcom-msm8960.dtsi
> index 48b3962dd4fb..995ea32f8d66 100644
> --- a/arch/arm/boot/dts/qcom/qcom-msm8960.dtsi
> +++ b/arch/arm/boot/dts/qcom/qcom-msm8960.dtsi
> @@ -8,6 +8,7 @@
>  #include <dt-bindings/clock/qcom,lcc-msm8960.h>
>  #include <dt-bindings/mfd/qcom-rpm.h>
>  #include <dt-bindings/soc/qcom,gsbi.h>
> +#include <dt-bindings/soc/qcom,krait-l2-cache.h>
>  
>  / {
>  	#address-cells = <1>;
> @@ -29,6 +30,13 @@ cpu@0 {
>  			next-level-cache = <&L2>;
>  			qcom,acc = <&acc0>;
>  			qcom,saw = <&saw0>;
> +			clocks = <&kraitcc KRAIT_CPU_0>;
> +			clock-names = "cpu";
> +			clock-latency = <100000>;
> +			vdd-core-supply = <&saw0_vreg>;
> +			interconnects = <&L2 MASTER_KRAIT_L2 &L2 SLAVE_KRAIT_L2>;
> +			operating-points-v2 = <&cpu_opp_table>;
> +			#cooling-cells = <2>;
>  		};
>  
>  		cpu@1 {
> @@ -39,6 +47,13 @@ cpu@1 {
>  			next-level-cache = <&L2>;
>  			qcom,acc = <&acc1>;
>  			qcom,saw = <&saw1>;
> +			clocks = <&kraitcc KRAIT_CPU_0>;
> +			clock-names = "cpu";
> +			clock-latency = <100000>;
> +			vdd-core-supply = <&saw1_vreg>;
> +			interconnects = <&L2 MASTER_KRAIT_L2 &L2 SLAVE_KRAIT_L2>;
> +			operating-points-v2 = <&cpu_opp_table>;
> +			#cooling-cells = <2>;
>  		};
>  
>  		L2: l2-cache {
> @@ -169,6 +184,127 @@ opp-1350000000 {
>  		};
>  	};
>  
> +	cpu_opp_table: opp-table-cpu {
> +		compatible = "operating-points-v2-krait-cpu";
> +		nvmem-cells = <&speedbin_efuse>;
> +
> +		/*
> +		 * Voltage thresholds are <target min max>
> +		 */
> +		opp-384000000 {
> +			opp-hz = /bits/ 64 <384000000>;
> +			opp-peak-kBps = <384000>;
> +			opp-microvolt-speed0-pvs0 = <950000 950000 950000>;
> +			opp-microvolt-speed0-pvs1 = <925000 900000 950000>;
> +			opp-microvolt-speed0-pvs3 = <875000 850000 900000>;
> +			opp-supported-hw = <0x1>;
> +			/*
> +			 * higher latency as it requires switching between
> +			 * clock sources
> +			 */
> +			clock-latency-ns = <244144>;
> +		};
> +
> +		opp-486000000 {
> +			opp-hz = /bits/ 64 <486000000>;
> +			opp-peak-kBps = <702000>;
> +			opp-microvolt-speed0-pvs0 = <975000 975000 975000>;
> +			opp-microvolt-speed0-pvs1 = <950000 925000 975000>;
> +			opp-microvolt-speed0-pvs3 = <900000 875000 925000>;
> +			opp-supported-hw = <0x1>;
> +		};
> +
> +		opp-594000000 {
> +			opp-hz = /bits/ 64 <594000000>;
> +			opp-peak-kBps = <702000>;
> +			opp-microvolt-speed0-pvs0 = <1000000 1000000 1000000>;
> +			opp-microvolt-speed0-pvs1 = <975000 950000 1000000>;
> +			opp-microvolt-speed0-pvs3 = <925000 900000 950000>;
> +			opp-supported-hw = <0x1>;
> +		};
> +
> +		opp-702000000 {
> +			opp-hz = /bits/ 64 <702000000>;
> +			opp-peak-kBps = <702000>;
> +			opp-microvolt-speed0-pvs0 = <1025000 1025000 1025000>;
> +			opp-microvolt-speed0-pvs1 = <1000000 975000 1025000>;
> +			opp-microvolt-speed0-pvs3 = <950000 925000 975000>;
> +			opp-supported-hw = <0x1>;
> +		};
> +
> +		opp-810000000 {
> +			opp-hz = /bits/ 64 <810000000>;
> +			opp-peak-kBps = <702000>;
> +			opp-microvolt-speed0-pvs0 = <1075000 1075000 1075000>;
> +			opp-microvolt-speed0-pvs1 = <1050000 1025000 1075000>;
> +			opp-microvolt-speed0-pvs3 = <1000000 975000 1025000>;
> +			opp-supported-hw = <0x1>;
> +		};
> +
> +		opp-918000000 {
> +			opp-hz = /bits/ 64 <918000000>;
> +			opp-peak-kBps = <702000>;
> +			opp-microvolt-speed0-pvs0 = <1100000 1100000 1100000>;
> +			opp-microvolt-speed0-pvs1 = <1075000 1050000 1100000>;
> +			opp-microvolt-speed0-pvs3 = <1025000 1000000 1050000>;
> +			opp-supported-hw = <0x1>;
> +		};
> +
> +		opp-1026000000 {
> +			opp-hz = /bits/ 64 <1026000000>;
> +			opp-peak-kBps = <702000>;
> +			opp-microvolt-speed0-pvs0 = <1125000 1125000 1125000>;
> +			opp-microvolt-speed0-pvs1 = <1100000 1075000 1125000>;
> +			opp-microvolt-speed0-pvs3 = <1050000 1025000 1075000>;
> +			opp-supported-hw = <0x1>;
> +		};
> +
> +		opp-1134000000 {
> +			opp-hz = /bits/ 64 <1134000000>;
> +			opp-peak-kBps = <1350000>;
> +			opp-microvolt-speed0-pvs0 = <1175000 1175000 1175000>;
> +			opp-microvolt-speed0-pvs1 = <1150000 1125000 1175000>;
> +			opp-microvolt-speed0-pvs3 = <1100000 1075000 1125000>;
> +			opp-supported-hw = <0x1>;
> +		};
> +
> +		opp-1242000000 {
> +			opp-hz = /bits/ 64 <1242000000>;
> +			opp-peak-kBps = <1350000>;
> +			opp-microvolt-speed0-pvs0 = <1200000 1200000 1200000>;
> +			opp-microvolt-speed0-pvs1 = <1175000 1150000 1200000>;
> +			opp-microvolt-speed0-pvs3 = <1125000 1100000 1150000>;
> +			opp-supported-hw = <0x1>;
> +		};
> +
> +		opp-1350000000 {
> +			opp-hz = /bits/ 64 <1350000000>;
> +			opp-peak-kBps = <1350000>;
> +			opp-microvolt-speed0-pvs0 = <1225000 1225000 1225000>;
> +			opp-microvolt-speed0-pvs1 = <1200000 1175000 1225000>;
> +			opp-microvolt-speed0-pvs3 = <1150000 1125000 1175000>;
> +			opp-supported-hw = <0x1>;
> +		};
> +
> +		opp-1458000000 {
> +			opp-hz = /bits/ 64 <1458000000>;
> +			opp-peak-kBps = <1350000>;
> +			opp-microvolt-speed0-pvs0 = <1237500 1237500 1237500>;
> +			opp-microvolt-speed0-pvs1 = <1212500 1187500 1237500>;
> +			opp-microvolt-speed0-pvs3 = <1162500 1137500 1187500>;
> +			opp-supported-hw = <0x1>;
> +		};
> +
> +		opp-1512000000 {
> +			opp-hz = /bits/ 64 <1512000000>;
> +			opp-peak-kBps = <1350000>;
> +			opp-microvolt-speed0-pvs0 = <1250000 1250000 1250000>;
> +			opp-microvolt-speed0-pvs1 = <1225000 1200000 1250000>;
> +			opp-microvolt-speed0-pvs3 = <1175000 1150000 1200000>;
> +			opp-supported-hw = <0x1>;
> +		};
> +	};
> +
>  	memory {
>  		device_type = "memory";
>  		reg = <0x0 0x0>;
> @@ -266,6 +402,17 @@ msmgpio: pinctrl@800000 {
>  			reg = <0x800000 0x4000>;
>  		};
>  
> +		qfprom: qfprom@700000 {
> +			compatible = "qcom,msm8960-qfprom", "qcom,qfprom";
> +			reg = <0x00700000 0x1000>;
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +			ranges;
> +			speedbin_efuse: speedbin@c0 {
> +				reg = <0x0c0 0x4>;
> +			};
> +		};
> +
>  		gcc: clock-controller@900000 {
>  			compatible = "qcom,gcc-msm8960";
>  			#clock-cells = <1>;
