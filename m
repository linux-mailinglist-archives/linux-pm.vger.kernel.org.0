Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E96B073E562
	for <lists+linux-pm@lfdr.de>; Mon, 26 Jun 2023 18:41:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229780AbjFZQkz (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 26 Jun 2023 12:40:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230223AbjFZQke (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 26 Jun 2023 12:40:34 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34734E70
        for <linux-pm@vger.kernel.org>; Mon, 26 Jun 2023 09:40:32 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id 2adb3069b0e04-4f875b267d9so4897479e87.1
        for <linux-pm@vger.kernel.org>; Mon, 26 Jun 2023 09:40:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687797630; x=1690389630;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=I30T5rH8EQUOarhNXE0Wcb0ruWVBGpc8SiPezr2NNr0=;
        b=Lf2uqQZU+lb9ByBEZ18MtqHBbJA5reo0qTJhqrNDhz62WlWsr3KKDrqsWX3jAqBrJN
         GdCUbz582WwOp8+wpRNE36O9BwIweLsoNfdNa2qrf4wfS6OT7n2Vsprz1W7KnfM7JIYa
         Zw2q6jxMiG5ArST5QPLVO+dRh1HCpD7QORmMgLcJzT/ff62in4I9RfY5uo2dc02bXWx7
         DR6hdkhf8ws7emejXMA/ODFwyMJ6Hk+RPC9q84EjmzdyhLqr+/re9v2GtCQdt7B5TTv2
         NXEMH94ovkPe/+5JknmbxtePc9ARomtbfL0gvSVYoUncjup7WNuK+H0sHgt7EUCSIGjr
         zqxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687797630; x=1690389630;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=I30T5rH8EQUOarhNXE0Wcb0ruWVBGpc8SiPezr2NNr0=;
        b=HiFk5RQOFscFaATyVtQvFoo1ZLlc7/sQykET+ChsAle0VbcNS7qfhM4W4M3NrTz+lW
         AmDDl3AKx34G1XDZv/yli1zoHVSDpCgKJ9wgUQDWAEFtz8ZCsNvMVadT6z2KvS0SOKli
         Fel1RUz0jq5xYmEdILoYCSjIF29s43fpVBvEU5YZulDr0z/1QzIf2uYlvSX2wWRiECU9
         GF+2rWhmr+8fUqt73eCZJ5cI2QgtKsYyB/gu4FKA9ey5yvtD7yhm7dEP2iKd5sOHdr33
         yjqC67D9PmnfCmh6Vw8FmzgZLHFv+iQU3ar38eM8BpB9ubXuNsW4Ip3lb2OwSKMvwBS/
         EftA==
X-Gm-Message-State: AC+VfDz8GmAIU4BT9kxDe+ybf2K3PKj0vGnHa59mScBgowXXKs5PHhNd
        uDpOwVGJ+tY1czpL7R1BSgyUyg==
X-Google-Smtp-Source: ACHHUZ7dYOpMAb4Yg9HSREqprExh8U34FMraYvwbcUKKXBs7w56sYK8twKbQBht3ATNCUEMgp4zIng==
X-Received: by 2002:a19:435a:0:b0:4f8:5905:8e0a with SMTP id m26-20020a19435a000000b004f859058e0amr15802062lfj.6.1687797630336;
        Mon, 26 Jun 2023 09:40:30 -0700 (PDT)
Received: from [192.168.1.101] (abyk179.neoplus.adsl.tpnet.pl. [83.9.30.179])
        by smtp.gmail.com with ESMTPSA id v16-20020a056512049000b004fb7775cd14sm364373lfq.177.2023.06.26.09.40.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Jun 2023 09:40:29 -0700 (PDT)
Message-ID: <0f139da8-ae01-fc28-d14c-0ea207cf760e@linaro.org>
Date:   Mon, 26 Jun 2023 18:40:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v2 17/26] ARM: dts: qcom: apq8064: add simple CPUFreq
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
References: <20230625202547.174647-1-dmitry.baryshkov@linaro.org>
 <20230625202547.174647-18-dmitry.baryshkov@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230625202547.174647-18-dmitry.baryshkov@linaro.org>
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
> Declare CPU frequency-scaling properties. Each CPU has its own clock,
> how
however?

> all CPUs have the same OPP table. Voltage scaling is not (yet)
> enabled with this patch. It will be enabled later.
Risky business.

> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---
>  arch/arm/boot/dts/qcom/qcom-apq8064.dtsi | 170 +++++++++++++++++++++++
>  1 file changed, 170 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/qcom/qcom-apq8064.dtsi b/arch/arm/boot/dts/qcom/qcom-apq8064.dtsi
> index ac07170c702f..e4d2fd48d843 100644
> --- a/arch/arm/boot/dts/qcom/qcom-apq8064.dtsi
> +++ b/arch/arm/boot/dts/qcom/qcom-apq8064.dtsi
> @@ -2,11 +2,13 @@
>  /dts-v1/;
>  
>  #include <dt-bindings/clock/qcom,gcc-msm8960.h>
> +#include <dt-bindings/clock/qcom,krait-cc.h>
>  #include <dt-bindings/clock/qcom,lcc-msm8960.h>
>  #include <dt-bindings/reset/qcom,gcc-msm8960.h>
>  #include <dt-bindings/clock/qcom,mmcc-msm8960.h>
>  #include <dt-bindings/clock/qcom,rpmcc.h>
>  #include <dt-bindings/soc/qcom,gsbi.h>
> +#include <dt-bindings/soc/qcom,krait-l2-cache.h>
>  #include <dt-bindings/interrupt-controller/irq.h>
>  #include <dt-bindings/interrupt-controller/arm-gic.h>
>  / {
> @@ -45,6 +47,12 @@ CPU0: cpu@0 {
>  			qcom,acc = <&acc0>;
>  			qcom,saw = <&saw0>;
>  			cpu-idle-states = <&CPU_SPC>;
> +			clocks = <&kraitcc KRAIT_CPU_0>;
> +			clock-names = "cpu";
> +			clock-latency = <100000>;
> +			interconnects = <&L2 MASTER_KRAIT_L2 &L2 SLAVE_KRAIT_L2>;
> +			operating-points-v2 = <&cpu_opp_table>;
> +			#cooling-cells = <2>;
>  		};
>  
>  		CPU1: cpu@1 {
> @@ -56,6 +64,12 @@ CPU1: cpu@1 {
>  			qcom,acc = <&acc1>;
>  			qcom,saw = <&saw1>;
>  			cpu-idle-states = <&CPU_SPC>;
> +			clocks = <&kraitcc KRAIT_CPU_1>;
> +			clock-names = "cpu";
> +			clock-latency = <100000>;
> +			interconnects = <&L2 MASTER_KRAIT_L2 &L2 SLAVE_KRAIT_L2>;
> +			operating-points-v2 = <&cpu_opp_table>;
> +			#cooling-cells = <2>;
>  		};
>  
>  		CPU2: cpu@2 {
> @@ -67,6 +81,12 @@ CPU2: cpu@2 {
>  			qcom,acc = <&acc2>;
>  			qcom,saw = <&saw2>;
>  			cpu-idle-states = <&CPU_SPC>;
> +			clocks = <&kraitcc KRAIT_CPU_2>;
> +			clock-names = "cpu";
> +			clock-latency = <100000>;
> +			interconnects = <&L2 MASTER_KRAIT_L2 &L2 SLAVE_KRAIT_L2>;
> +			operating-points-v2 = <&cpu_opp_table>;
> +			#cooling-cells = <2>;
>  		};
>  
>  		CPU3: cpu@3 {
> @@ -78,6 +98,12 @@ CPU3: cpu@3 {
>  			qcom,acc = <&acc3>;
>  			qcom,saw = <&saw3>;
>  			cpu-idle-states = <&CPU_SPC>;
> +			clocks = <&kraitcc KRAIT_CPU_3>;
> +			clock-names = "cpu";
> +			clock-latency = <100000>;
> +			interconnects = <&L2 MASTER_KRAIT_L2 &L2 SLAVE_KRAIT_L2>;
> +			operating-points-v2 = <&cpu_opp_table>;
> +			#cooling-cells = <2>;
>  		};
>  
>  		L2: l2-cache {
> @@ -196,6 +222,121 @@ CPU_SPC: spc {
>  		};
>  	};
>  
> +        cpu_opp_table: opp-table-cpu {
> +		compatible = "operating-points-v2-krait-cpu";
> +		nvmem-cells = <&speedbin_efuse>;
> +
> +		/*
> +		 * Voltage thresholds are <target min max>
> +		 */
What voltage thresholds?

> +		opp-384000000 {
> +			opp-hz = /bits/ 64 <384000000>;
> +			opp-peak-kBps = <384000>;
> +			opp-supported-hw = <0x4007>;
> +			/*
> +			 * higher latency as it requires switching between
> +			 * clock sources
> +			 */
> +			clock-latency-ns = <244144>;
> +		};
> +
> +		opp-486000000 {
> +			opp-hz = /bits/ 64 <486000000>;
> +			opp-peak-kBps = <648000>;
> +			opp-supported-hw = <0x4007>;
> +		};
> +
> +		opp-594000000 {
> +			opp-hz = /bits/ 64 <594000000>;
> +			opp-peak-kBps = <648000>;
> +			opp-supported-hw = <0x4007>;
> +		};
> +
> +		opp-702000000 {
> +			opp-hz = /bits/ 64 <702000000>;
> +			opp-peak-kBps = <648000>;
> +			opp-supported-hw = <0x4007>;
> +		};
> +
> +		opp-810000000 {
> +			opp-hz = /bits/ 64 <810000000>;
> +			opp-peak-kBps = <648000>;
> +			opp-supported-hw = <0x4007>;
> +		};
> +
> +		opp-918000000 {
> +			opp-hz = /bits/ 64 <918000000>;
> +			opp-peak-kBps = <648000>;
> +			opp-supported-hw = <0x4007>;
> +		};
> +
> +		opp-1026000000 {
> +			opp-hz = /bits/ 64 <1026000000>;
> +			opp-peak-kBps = <648000>;
> +			opp-supported-hw = <0x4007>;
> +		};
> +
> +		opp-1134000000 {
> +			opp-hz = /bits/ 64 <1134000000>;
> +			opp-peak-kBps = <1134000>;
> +			opp-supported-hw = <0x4007>;
> +		};
> +
> +		opp-1242000000 {
> +			opp-hz = /bits/ 64 <1242000000>;
> +			opp-peak-kBps = <1134000>;
> +			opp-supported-hw = <0x4007>;
> +		};
> +
> +		opp-1350000000 {
> +			opp-hz = /bits/ 64 <1350000000>;
> +			opp-peak-kBps = <1134000>;
> +			opp-supported-hw = <0x4007>;
> +		};
> +
> +		opp-1458000000 {
> +			opp-hz = /bits/ 64 <1458000000>;
> +			opp-peak-kBps = <1134000>;
> +			opp-supported-hw = <0x4007>;
> +		};
> +
> +		opp-1512000000 {
> +			opp-hz = /bits/ 64 <1512000000>;
> +			opp-peak-kBps = <1134000>;
> +			opp-supported-hw = <0x4001>;
> +		};
> +
> +		opp-1566000000 {
> +			opp-hz = /bits/ 64 <1566000000>;
> +			opp-peak-kBps = <1134000>;
> +			opp-supported-hw = <0x06>;
> +		};
> +
> +		opp-1674000000 {
> +			opp-hz = /bits/ 64 <1674000000>;
> +			opp-peak-kBps = <1134000>;
> +			opp-supported-hw = <0x06>;
> +		};
> +
> +		opp-1728000000 {
> +			opp-hz = /bits/ 64 <1728000000>;
> +			opp-peak-kBps = <1134000>;
> +			opp-supported-hw = <0x02>;
> +		};
> +
> +		opp-1782000000 {
> +			opp-hz = /bits/ 64 <1782000000>;
> +			opp-peak-kBps = <1134000>;
> +			opp-supported-hw = <0x04>;
> +		};
> +
> +		opp-1890000000 {
> +			opp-hz = /bits/ 64 <1890000000>;
> +			opp-peak-kBps = <1134000>;
> +			opp-supported-hw = <0x04>;
> +		};
> +	};
> +
>  	memory@0 {
>  		device_type = "memory";
>  		reg = <0x0 0x0>;
> @@ -312,6 +453,32 @@ sleep_clk: sleep_clk {
>  		};
>  	};
>  
> +	kraitcc: clock-controller {
> +		compatible = "qcom,krait-cc-v1";
Are we sure we don't wanna rework this compatible? Check the comment in
drivers/clk/qcom/krait-cc.c : krait_add_sec_mux()


> +		clocks = <&gcc PLL9>, /* hfpll0 */
> +			 <&gcc PLL10>, /* hfpll1 */
> +			 <&gcc PLL16>, /* hfpll2 */
> +			 <&gcc PLL17>, /* hfpll3 */
> +			 <&gcc PLL12>, /* hfpll_l2 */
> +			 <&acc0>,
> +			 <&acc1>,
> +			 <&acc2>,
> +			 <&acc3>,
> +			 <&l2cc>;
> +		clock-names = "hfpll0",
> +			      "hfpll1",
> +			      "hfpll2",
> +			      "hfpll3",
> +			      "hfpll_l2",
> +			      "acpu0_aux",
> +			      "acpu1_aux",
> +			      "acpu2_aux",
> +			      "acpu3_aux",
> +			      "acpu_l2_aux";
> +		#clock-cells = <1>;
> +		#interconnect-cells = <1>;
> +	};
> +
>  	sfpb_mutex: hwmutex {
>  		compatible = "qcom,sfpb-mutex";
>  		syscon = <&sfpb_wrapper_mutex 0x604 0x4>;
> @@ -933,6 +1100,9 @@ qfprom: qfprom@700000 {
>  			#address-cells = <1>;
>  			#size-cells = <1>;
>  			ranges;
> +			speedbin_efuse: speedbin@c0 {
> +				reg = <0x0c0 0x4>;
> +			};
Newline between properties and subnodes & between individual subnodes,
please

Konrad
>  			tsens_calib: calib@404 {
>  				reg = <0x404 0x10>;
>  			};
