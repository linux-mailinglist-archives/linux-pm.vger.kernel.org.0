Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35F0E73EB4C
	for <lists+linux-pm@lfdr.de>; Mon, 26 Jun 2023 21:52:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230033AbjFZTtd (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 26 Jun 2023 15:49:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230047AbjFZTtc (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 26 Jun 2023 15:49:32 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2F90170A
        for <linux-pm@vger.kernel.org>; Mon, 26 Jun 2023 12:49:27 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id 38308e7fff4ca-2b5e7dba43cso33592611fa.1
        for <linux-pm@vger.kernel.org>; Mon, 26 Jun 2023 12:49:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687808966; x=1690400966;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OxcFta/DvWzstkO+bX4qUH4lC0yv3Ria011e70aTaPY=;
        b=VGk9wU8nDHqjWkK/NdSbFWeLsMj50IODxJ6it8eJKkV8hss+eNB9ncica1jzjoWryD
         y0SrkYwScg5lYpXQCDd564OI5tx5QuEpWN+7G0J+5N5zwH6sMnPB15trrEarPkMQxrmf
         q4gPDmTB/GReOXIQDXzNMjvOgpEdogaL6snVxWGvimD0qoeDjrLaVgTl5GBlHh6QinG7
         NsbQaQsUKaQkaVkK4g1d+oY0p4/K6DvDEjyrlr08GdKWPQSWlaUb08F90DdNQK7kbvEv
         nvTUDGtxV+gqurfUn4cNEfVtgq4Z4T1ZEQVx6Y1MwQ1zR2KQHFdGnzmSwsMb3Pb3xFC6
         jlGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687808966; x=1690400966;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OxcFta/DvWzstkO+bX4qUH4lC0yv3Ria011e70aTaPY=;
        b=Vc6MX0TbUop1DxQAVrmE95Tz1N5qpuchAkd5AUCdHd5ccii9RVMcCjYeNxvw4zwhGR
         RymdGHLIDpWS/9hQwQphNFt59hbPJlNFOgWKejGMQBfvzzqxWS88hjGEsBS2sohKp7uf
         3oU5quGB10n+PtvUAMFj7hLvXaR2NktqEEq6D0wga0fXAEddDhfGdLVPx2LzNhIcKmYp
         iWSjLMrKiiDaZzKbCHnpHr+JBT7VI5Fsen118WXch+FukrafjUny5P1lTMZzH5u9G85F
         aHokpS0VosJGhJzpToU2Out8hWpr8CqFi5UxbTdZCd6PInadJQeCK9S/U4vU4QZRpbeo
         dlJQ==
X-Gm-Message-State: AC+VfDw9pnaqu1eno2NiEth9V+XGezrU88GlZ7OXcl1+zUg71hvDSeuq
        1hGIpy8pj1S8+L+Agc6OhqMKcA==
X-Google-Smtp-Source: ACHHUZ4LONBxVN5MzN6lLLzQRC0oTvIPh5M17c1CoI2M6sPGOaC6gnYiJceTcCJQxHNm9gIeWirung==
X-Received: by 2002:a2e:9c8f:0:b0:2b6:9c24:77a with SMTP id x15-20020a2e9c8f000000b002b69c24077amr2654459lji.46.1687808965834;
        Mon, 26 Jun 2023 12:49:25 -0700 (PDT)
Received: from ?IPV6:2001:14ba:a0db:1f00::8a5? (dzdqv0yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a0db:1f00::8a5])
        by smtp.gmail.com with ESMTPSA id m10-20020a2e910a000000b002b32600ab9fsm1356340ljg.60.2023.06.26.12.49.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Jun 2023 12:49:25 -0700 (PDT)
Message-ID: <2232c6e7-cbca-30c1-9ec5-1cea7f759daf@linaro.org>
Date:   Mon, 26 Jun 2023 22:49:24 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 17/26] ARM: dts: qcom: apq8064: add simple CPUFreq
 support
Content-Language: en-GB
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
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
 <0f139da8-ae01-fc28-d14c-0ea207cf760e@linaro.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <0f139da8-ae01-fc28-d14c-0ea207cf760e@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

On 26/06/2023 19:40, Konrad Dybcio wrote:
> On 25.06.2023 22:25, Dmitry Baryshkov wrote:
>> Declare CPU frequency-scaling properties. Each CPU has its own clock,
>> how
> however?

yes

> 
>> all CPUs have the same OPP table. Voltage scaling is not (yet)
>> enabled with this patch. It will be enabled later.
> Risky business.

But it works :D

> 
>>
>> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
>> ---
>>   arch/arm/boot/dts/qcom/qcom-apq8064.dtsi | 170 +++++++++++++++++++++++
>>   1 file changed, 170 insertions(+)
>>
>> diff --git a/arch/arm/boot/dts/qcom/qcom-apq8064.dtsi b/arch/arm/boot/dts/qcom/qcom-apq8064.dtsi
>> index ac07170c702f..e4d2fd48d843 100644
>> --- a/arch/arm/boot/dts/qcom/qcom-apq8064.dtsi
>> +++ b/arch/arm/boot/dts/qcom/qcom-apq8064.dtsi
>> @@ -2,11 +2,13 @@
>>   /dts-v1/;
>>   
>>   #include <dt-bindings/clock/qcom,gcc-msm8960.h>
>> +#include <dt-bindings/clock/qcom,krait-cc.h>
>>   #include <dt-bindings/clock/qcom,lcc-msm8960.h>
>>   #include <dt-bindings/reset/qcom,gcc-msm8960.h>
>>   #include <dt-bindings/clock/qcom,mmcc-msm8960.h>
>>   #include <dt-bindings/clock/qcom,rpmcc.h>
>>   #include <dt-bindings/soc/qcom,gsbi.h>
>> +#include <dt-bindings/soc/qcom,krait-l2-cache.h>
>>   #include <dt-bindings/interrupt-controller/irq.h>
>>   #include <dt-bindings/interrupt-controller/arm-gic.h>
>>   / {
>> @@ -45,6 +47,12 @@ CPU0: cpu@0 {
>>   			qcom,acc = <&acc0>;
>>   			qcom,saw = <&saw0>;
>>   			cpu-idle-states = <&CPU_SPC>;
>> +			clocks = <&kraitcc KRAIT_CPU_0>;
>> +			clock-names = "cpu";
>> +			clock-latency = <100000>;
>> +			interconnects = <&L2 MASTER_KRAIT_L2 &L2 SLAVE_KRAIT_L2>;
>> +			operating-points-v2 = <&cpu_opp_table>;
>> +			#cooling-cells = <2>;
>>   		};
>>   
>>   		CPU1: cpu@1 {
>> @@ -56,6 +64,12 @@ CPU1: cpu@1 {
>>   			qcom,acc = <&acc1>;
>>   			qcom,saw = <&saw1>;
>>   			cpu-idle-states = <&CPU_SPC>;
>> +			clocks = <&kraitcc KRAIT_CPU_1>;
>> +			clock-names = "cpu";
>> +			clock-latency = <100000>;
>> +			interconnects = <&L2 MASTER_KRAIT_L2 &L2 SLAVE_KRAIT_L2>;
>> +			operating-points-v2 = <&cpu_opp_table>;
>> +			#cooling-cells = <2>;
>>   		};
>>   
>>   		CPU2: cpu@2 {
>> @@ -67,6 +81,12 @@ CPU2: cpu@2 {
>>   			qcom,acc = <&acc2>;
>>   			qcom,saw = <&saw2>;
>>   			cpu-idle-states = <&CPU_SPC>;
>> +			clocks = <&kraitcc KRAIT_CPU_2>;
>> +			clock-names = "cpu";
>> +			clock-latency = <100000>;
>> +			interconnects = <&L2 MASTER_KRAIT_L2 &L2 SLAVE_KRAIT_L2>;
>> +			operating-points-v2 = <&cpu_opp_table>;
>> +			#cooling-cells = <2>;
>>   		};
>>   
>>   		CPU3: cpu@3 {
>> @@ -78,6 +98,12 @@ CPU3: cpu@3 {
>>   			qcom,acc = <&acc3>;
>>   			qcom,saw = <&saw3>;
>>   			cpu-idle-states = <&CPU_SPC>;
>> +			clocks = <&kraitcc KRAIT_CPU_3>;
>> +			clock-names = "cpu";
>> +			clock-latency = <100000>;
>> +			interconnects = <&L2 MASTER_KRAIT_L2 &L2 SLAVE_KRAIT_L2>;
>> +			operating-points-v2 = <&cpu_opp_table>;
>> +			#cooling-cells = <2>;
>>   		};
>>   
>>   		L2: l2-cache {
>> @@ -196,6 +222,121 @@ CPU_SPC: spc {
>>   		};
>>   	};
>>   
>> +        cpu_opp_table: opp-table-cpu {
>> +		compatible = "operating-points-v2-krait-cpu";
>> +		nvmem-cells = <&speedbin_efuse>;
>> +
>> +		/*
>> +		 * Voltage thresholds are <target min max>
>> +		 */
> What voltage thresholds?

Ack, should be moved to the next patch.

> 
>> +		opp-384000000 {
>> +			opp-hz = /bits/ 64 <384000000>;
>> +			opp-peak-kBps = <384000>;
>> +			opp-supported-hw = <0x4007>;
>> +			/*
>> +			 * higher latency as it requires switching between
>> +			 * clock sources
>> +			 */
>> +			clock-latency-ns = <244144>;
>> +		};
>> +
>> +		opp-486000000 {
>> +			opp-hz = /bits/ 64 <486000000>;
>> +			opp-peak-kBps = <648000>;
>> +			opp-supported-hw = <0x4007>;
>> +		};
>> +
>> +		opp-594000000 {
>> +			opp-hz = /bits/ 64 <594000000>;
>> +			opp-peak-kBps = <648000>;
>> +			opp-supported-hw = <0x4007>;
>> +		};
>> +
>> +		opp-702000000 {
>> +			opp-hz = /bits/ 64 <702000000>;
>> +			opp-peak-kBps = <648000>;
>> +			opp-supported-hw = <0x4007>;
>> +		};
>> +
>> +		opp-810000000 {
>> +			opp-hz = /bits/ 64 <810000000>;
>> +			opp-peak-kBps = <648000>;
>> +			opp-supported-hw = <0x4007>;
>> +		};
>> +
>> +		opp-918000000 {
>> +			opp-hz = /bits/ 64 <918000000>;
>> +			opp-peak-kBps = <648000>;
>> +			opp-supported-hw = <0x4007>;
>> +		};
>> +
>> +		opp-1026000000 {
>> +			opp-hz = /bits/ 64 <1026000000>;
>> +			opp-peak-kBps = <648000>;
>> +			opp-supported-hw = <0x4007>;
>> +		};
>> +
>> +		opp-1134000000 {
>> +			opp-hz = /bits/ 64 <1134000000>;
>> +			opp-peak-kBps = <1134000>;
>> +			opp-supported-hw = <0x4007>;
>> +		};
>> +
>> +		opp-1242000000 {
>> +			opp-hz = /bits/ 64 <1242000000>;
>> +			opp-peak-kBps = <1134000>;
>> +			opp-supported-hw = <0x4007>;
>> +		};
>> +
>> +		opp-1350000000 {
>> +			opp-hz = /bits/ 64 <1350000000>;
>> +			opp-peak-kBps = <1134000>;
>> +			opp-supported-hw = <0x4007>;
>> +		};
>> +
>> +		opp-1458000000 {
>> +			opp-hz = /bits/ 64 <1458000000>;
>> +			opp-peak-kBps = <1134000>;
>> +			opp-supported-hw = <0x4007>;
>> +		};
>> +
>> +		opp-1512000000 {
>> +			opp-hz = /bits/ 64 <1512000000>;
>> +			opp-peak-kBps = <1134000>;
>> +			opp-supported-hw = <0x4001>;
>> +		};
>> +
>> +		opp-1566000000 {
>> +			opp-hz = /bits/ 64 <1566000000>;
>> +			opp-peak-kBps = <1134000>;
>> +			opp-supported-hw = <0x06>;
>> +		};
>> +
>> +		opp-1674000000 {
>> +			opp-hz = /bits/ 64 <1674000000>;
>> +			opp-peak-kBps = <1134000>;
>> +			opp-supported-hw = <0x06>;
>> +		};
>> +
>> +		opp-1728000000 {
>> +			opp-hz = /bits/ 64 <1728000000>;
>> +			opp-peak-kBps = <1134000>;
>> +			opp-supported-hw = <0x02>;
>> +		};
>> +
>> +		opp-1782000000 {
>> +			opp-hz = /bits/ 64 <1782000000>;
>> +			opp-peak-kBps = <1134000>;
>> +			opp-supported-hw = <0x04>;
>> +		};
>> +
>> +		opp-1890000000 {
>> +			opp-hz = /bits/ 64 <1890000000>;
>> +			opp-peak-kBps = <1134000>;
>> +			opp-supported-hw = <0x04>;
>> +		};
>> +	};
>> +
>>   	memory@0 {
>>   		device_type = "memory";
>>   		reg = <0x0 0x0>;
>> @@ -312,6 +453,32 @@ sleep_clk: sleep_clk {
>>   		};
>>   	};
>>   
>> +	kraitcc: clock-controller {
>> +		compatible = "qcom,krait-cc-v1";
> Are we sure we don't wanna rework this compatible? Check the comment in
> drivers/clk/qcom/krait-cc.c : krait_add_sec_mux()

I remember that comment. I'd rather not introduce another compat string 
for such old hw. Would there be any direct benefits?

> 
> 
>> +		clocks = <&gcc PLL9>, /* hfpll0 */
>> +			 <&gcc PLL10>, /* hfpll1 */
>> +			 <&gcc PLL16>, /* hfpll2 */
>> +			 <&gcc PLL17>, /* hfpll3 */
>> +			 <&gcc PLL12>, /* hfpll_l2 */
>> +			 <&acc0>,
>> +			 <&acc1>,
>> +			 <&acc2>,
>> +			 <&acc3>,
>> +			 <&l2cc>;
>> +		clock-names = "hfpll0",
>> +			      "hfpll1",
>> +			      "hfpll2",
>> +			      "hfpll3",
>> +			      "hfpll_l2",
>> +			      "acpu0_aux",
>> +			      "acpu1_aux",
>> +			      "acpu2_aux",
>> +			      "acpu3_aux",
>> +			      "acpu_l2_aux";
>> +		#clock-cells = <1>;
>> +		#interconnect-cells = <1>;
>> +	};
>> +
>>   	sfpb_mutex: hwmutex {
>>   		compatible = "qcom,sfpb-mutex";
>>   		syscon = <&sfpb_wrapper_mutex 0x604 0x4>;
>> @@ -933,6 +1100,9 @@ qfprom: qfprom@700000 {
>>   			#address-cells = <1>;
>>   			#size-cells = <1>;
>>   			ranges;
>> +			speedbin_efuse: speedbin@c0 {
>> +				reg = <0x0c0 0x4>;
>> +			};
> Newline between properties and subnodes & between individual subnodes,
> please

ack.

> 
> Konrad
>>   			tsens_calib: calib@404 {
>>   				reg = <0x404 0x10>;
>>   			};

-- 
With best wishes
Dmitry

