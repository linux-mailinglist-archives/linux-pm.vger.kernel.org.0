Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F132C74733E
	for <lists+linux-pm@lfdr.de>; Tue,  4 Jul 2023 15:49:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229451AbjGDNtd (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 4 Jul 2023 09:49:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230264AbjGDNtZ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 4 Jul 2023 09:49:25 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59A9B1703
        for <linux-pm@vger.kernel.org>; Tue,  4 Jul 2023 06:49:20 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id 2adb3069b0e04-4f004cc54f4so8524650e87.3
        for <linux-pm@vger.kernel.org>; Tue, 04 Jul 2023 06:49:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688478558; x=1691070558;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RdzSTB1RF5/u1H8IdhE8g3zk27ow2nHIgIX8dEERahk=;
        b=DZgnqhuq8wSJ0VXT33+e1UqAsuhkWjfVVTWoghREb+WQNq26fc7R1VlNjBcQ+G1hin
         oDaJfOi9iNsiD4Wq/t4pGGlelQlf6xl7fPDo4onz42veCs2ZN/WIYQGSqf5V4d6ayvBx
         fFMa74Qpl1ILQfBznIoKnogrtKaqjWouQPxZnX9CDlOOArNlqENoeR9LBVv58XNn/zaK
         P5azBW01kHIQBG5f4e54VKoOC9vEhlIMFZ56/0bAuB21T0KrHVeL1aJ+hBQ3cy+33dAE
         PrqxVqdaUmbiRxZPcblmChtQMLt4XWwpsHh/r5anG9Nlb+I8fJ4VdbJ94ATHTdlyWLCH
         JASw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688478558; x=1691070558;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RdzSTB1RF5/u1H8IdhE8g3zk27ow2nHIgIX8dEERahk=;
        b=MlUCfO/jzhLZXbIGv6vBeNwujbD3bQES8VFYoBoaYZxdtMyvpQVUIS3ODfuSsRY7Vb
         9uNW6qjmvwHhF8iTZoI7IGraJXZm4T250mve3WTKci9s8FYkcQLyiqqTPllIrF3dBPvl
         OT4KiHoCfA3lWuCGWoI3Flai42XJrWtT5WmpTCTW/xUlzPl8i4MQvf0js2Cz+WZJ5mlk
         MhsmTjwu1+lTqMECqYO6G75Q4UtIn4tujqxeWouTIdcvfBIkyTCsmVVhu0Az8ExsqH62
         XmCV0XHO+BBdyM67WIs8t/EYuxKmBHTMEWLCXFCNu9YF7FkawfruxXY7VfNW7UB3sVtO
         mrpA==
X-Gm-Message-State: ABy/qLYiffUTlsiMJdTdX3SGlI7jvZPv+52SNCw2rE2pislF9fTR5h/8
        ppJIui1guXXH8jHGaym7zyqawA==
X-Google-Smtp-Source: APBJJlGCo8TZHbkQdCPiHyM4qYih0KQiqmy5B4dd793YWfwz9qaoGmg/M1L6KNZd7NtIo8jNG82z0A==
X-Received: by 2002:ac2:5e24:0:b0:4f8:78c9:4f00 with SMTP id o4-20020ac25e24000000b004f878c94f00mr9084862lfg.20.1688478558320;
        Tue, 04 Jul 2023 06:49:18 -0700 (PDT)
Received: from [192.168.1.101] (abyj26.neoplus.adsl.tpnet.pl. [83.9.29.26])
        by smtp.gmail.com with ESMTPSA id x8-20020ac24888000000b004fba4e27abesm2595162lfc.241.2023.07.04.06.49.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Jul 2023 06:49:18 -0700 (PDT)
Message-ID: <00ac128c-bfef-d370-240e-6ff03b87dab4@linaro.org>
Date:   Tue, 4 Jul 2023 15:49:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [RFC PATCH 8/8] ARM: dts: qcom: apq8064: add simple CPUFreq
 support
Content-Language: en-US
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Ilia Lin <ilia.lin@kernel.org>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Georgi Djakov <djakov@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-clk@vger.kernel.org,
        Christian Marangi <ansuelsmth@gmail.com>,
        Stephan Gerhold <stephan@gerhold.net>
References: <20230702175045.122041-1-dmitry.baryshkov@linaro.org>
 <20230702175045.122041-9-dmitry.baryshkov@linaro.org>
 <3231276b-7906-1cbe-6edd-73098118449a@linaro.org>
 <CAA8EJppUA+Ce9fzS8cq13VA0DKspzKY=8pCoy2BMW4zGkiY6rQ@mail.gmail.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <CAA8EJppUA+Ce9fzS8cq13VA0DKspzKY=8pCoy2BMW4zGkiY6rQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 4.07.2023 15:44, Dmitry Baryshkov wrote:
> On Tue, 4 Jul 2023 at 16:05, Konrad Dybcio <konrad.dybcio@linaro.org> wrote:
>>
>> On 2.07.2023 19:50, Dmitry Baryshkov wrote:
>>
>> Subject: wrong soc
>>
>>> Declare CPU frequency-scaling properties. Each CPU has its own clock,
>>> how all CPUs have the same OPP table. Voltage scaling is not (yet)
>>> enabled with this patch. It will be enabled later.
>>>
>>> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
>> ---Same concern as patch 4, can't see where these values came from.
> 
> Explained below.
> 
> Please use https://android.googlesource.com/kernel/msm/+/android-msm-hammerhead-3.4-marshmallow-mr2/arch/arm/mach-msm/acpuclock-8960.c
> as a reference.
> 
>>
>> Konrad
>>>  arch/arm/boot/dts/qcom/qcom-msm8960.dtsi | 147 +++++++++++++++++++++++
>>>  1 file changed, 147 insertions(+)
>>>
>>> diff --git a/arch/arm/boot/dts/qcom/qcom-msm8960.dtsi b/arch/arm/boot/dts/qcom/qcom-msm8960.dtsi
>>> index 48b3962dd4fb..995ea32f8d66 100644
>>> --- a/arch/arm/boot/dts/qcom/qcom-msm8960.dtsi
>>> +++ b/arch/arm/boot/dts/qcom/qcom-msm8960.dtsi
>>> @@ -8,6 +8,7 @@
>>>  #include <dt-bindings/clock/qcom,lcc-msm8960.h>
>>>  #include <dt-bindings/mfd/qcom-rpm.h>
>>>  #include <dt-bindings/soc/qcom,gsbi.h>
>>> +#include <dt-bindings/soc/qcom,krait-l2-cache.h>
>>>
>>>  / {
>>>       #address-cells = <1>;
>>> @@ -29,6 +30,13 @@ cpu@0 {
>>>                       next-level-cache = <&L2>;
>>>                       qcom,acc = <&acc0>;
>>>                       qcom,saw = <&saw0>;
>>> +                     clocks = <&kraitcc KRAIT_CPU_0>;
>>> +                     clock-names = "cpu";
>>> +                     clock-latency = <100000>;
>>> +                     vdd-core-supply = <&saw0_vreg>;
>>> +                     interconnects = <&L2 MASTER_KRAIT_L2 &L2 SLAVE_KRAIT_L2>;
>>> +                     operating-points-v2 = <&cpu_opp_table>;
>>> +                     #cooling-cells = <2>;
>>>               };
>>>
>>>               cpu@1 {
>>> @@ -39,6 +47,13 @@ cpu@1 {
>>>                       next-level-cache = <&L2>;
>>>                       qcom,acc = <&acc1>;
>>>                       qcom,saw = <&saw1>;
>>> +                     clocks = <&kraitcc KRAIT_CPU_0>;
>>> +                     clock-names = "cpu";
>>> +                     clock-latency = <100000>;
>>> +                     vdd-core-supply = <&saw1_vreg>;
>>> +                     interconnects = <&L2 MASTER_KRAIT_L2 &L2 SLAVE_KRAIT_L2>;
>>> +                     operating-points-v2 = <&cpu_opp_table>;
>>> +                     #cooling-cells = <2>;
>>>               };
>>>
>>>               L2: l2-cache {
>>> @@ -169,6 +184,127 @@ opp-1350000000 {
>>>               };
>>>       };
>>>
>>> +     cpu_opp_table: opp-table-cpu {
>>> +             compatible = "operating-points-v2-krait-cpu";
>>> +             nvmem-cells = <&speedbin_efuse>;
>>> +
>>> +             /*
>>> +              * Voltage thresholds are <target min max>
>>> +              */
>>> +             opp-384000000 {
>>> +                     opp-hz = /bits/ 64 <384000000>;
>>> +                     opp-peak-kBps = <384000>;
>>> +                     opp-microvolt-speed0-pvs0 = <950000 950000 950000>;
> 
> acpu_freq_tbl_slow, the voltage column.
> For the PVS_SLOW the pvs_tables doesn't list turbo boost, so all three
> voltages are the same.
> 
>>> +                     opp-microvolt-speed0-pvs1 = <925000 900000 950000>;
> 
> This comes from acpu_freq_tbl_nom. The voltage from the table becomes
> the middle value (min).
> For PVS_NOM the pvs_tables has the turbo value (25000), which
> acpuclock-krait applied by default, this becomes the first (target)
> value.
> For maximum I added another 25 mV to account for this exact value not
> being supported by the core (SAW) regulator.
And PVS3 seems to be correlated with acpu_freq_tbl_fast. Ok.
Makes sense now.

One nit below.
> 
> 
>>> +                     opp-microvolt-speed0-pvs3 = <875000 850000 900000>;
>>> +                     opp-supported-hw = <0x1>;
>>> +                     /*
>>> +                      * higher latency as it requires switching between
>>> +                      * clock sources
>>> +                      */
>>> +                     clock-latency-ns = <244144>;
>>> +             };
>>> +
>>> +             opp-486000000 {
>>> +                     opp-hz = /bits/ 64 <486000000>;
>>> +                     opp-peak-kBps = <702000>;
>>> +                     opp-microvolt-speed0-pvs0 = <975000 975000 975000>;
>>> +                     opp-microvolt-speed0-pvs1 = <950000 925000 975000>;
>>> +                     opp-microvolt-speed0-pvs3 = <900000 875000 925000>;
>>> +                     opp-supported-hw = <0x1>;
>>> +             };
>>> +
>>> +             opp-594000000 {
>>> +                     opp-hz = /bits/ 64 <594000000>;
>>> +                     opp-peak-kBps = <702000>;
>>> +                     opp-microvolt-speed0-pvs0 = <1000000 1000000 1000000>;
>>> +                     opp-microvolt-speed0-pvs1 = <975000 950000 1000000>;
>>> +                     opp-microvolt-speed0-pvs3 = <925000 900000 950000>;
>>> +                     opp-supported-hw = <0x1>;
>>> +             };
>>> +
>>> +             opp-702000000 {
>>> +                     opp-hz = /bits/ 64 <702000000>;
>>> +                     opp-peak-kBps = <702000>;
>>> +                     opp-microvolt-speed0-pvs0 = <1025000 1025000 1025000>;
>>> +                     opp-microvolt-speed0-pvs1 = <1000000 975000 1025000>;
>>> +                     opp-microvolt-speed0-pvs3 = <950000 925000 975000>;
>>> +                     opp-supported-hw = <0x1>;
>>> +             };
>>> +
>>> +             opp-810000000 {
>>> +                     opp-hz = /bits/ 64 <810000000>;
>>> +                     opp-peak-kBps = <702000>;
>>> +                     opp-microvolt-speed0-pvs0 = <1075000 1075000 1075000>;
>>> +                     opp-microvolt-speed0-pvs1 = <1050000 1025000 1075000>;
>>> +                     opp-microvolt-speed0-pvs3 = <1000000 975000 1025000>;
>>> +                     opp-supported-hw = <0x1>;
>>> +             };
>>> +
>>> +             opp-918000000 {
>>> +                     opp-hz = /bits/ 64 <918000000>;
>>> +                     opp-peak-kBps = <702000>;
>>> +                     opp-microvolt-speed0-pvs0 = <1100000 1100000 1100000>;
>>> +                     opp-microvolt-speed0-pvs1 = <1075000 1050000 1100000>;
>>> +                     opp-microvolt-speed0-pvs3 = <1025000 1000000 1050000>;
>>> +                     opp-supported-hw = <0x1>;
>>> +             };
>>> +
>>> +             opp-1026000000 {
>>> +                     opp-hz = /bits/ 64 <1026000000>;
>>> +                     opp-peak-kBps = <702000>;
>>> +                     opp-microvolt-speed0-pvs0 = <1125000 1125000 1125000>;
>>> +                     opp-microvolt-speed0-pvs1 = <1100000 1075000 1125000>;
>>> +                     opp-microvolt-speed0-pvs3 = <1050000 1025000 1075000>;
>>> +                     opp-supported-hw = <0x1>;
>>> +             };
>>> +
>>> +             opp-1134000000 {
>>> +                     opp-hz = /bits/ 64 <1134000000>;
>>> +                     opp-peak-kBps = <1350000>;
>>> +                     opp-microvolt-speed0-pvs0 = <1175000 1175000 1175000>;
>>> +                     opp-microvolt-speed0-pvs1 = <1150000 1125000 1175000>;
>>> +                     opp-microvolt-speed0-pvs3 = <1100000 1075000 1125000>;
>>> +                     opp-supported-hw = <0x1>;
>>> +             };
>>> +
>>> +             opp-1242000000 {
>>> +                     opp-hz = /bits/ 64 <1242000000>;
>>> +                     opp-peak-kBps = <1350000>;
>>> +                     opp-microvolt-speed0-pvs0 = <1200000 1200000 1200000>;
>>> +                     opp-microvolt-speed0-pvs1 = <1175000 1150000 1200000>;
>>> +                     opp-microvolt-speed0-pvs3 = <1125000 1100000 1150000>;
>>> +                     opp-supported-hw = <0x1>;
>>> +             };
>>> +
>>> +             opp-1350000000 {
>>> +                     opp-hz = /bits/ 64 <1350000000>;
>>> +                     opp-peak-kBps = <1350000>;
>>> +                     opp-microvolt-speed0-pvs0 = <1225000 1225000 1225000>;
>>> +                     opp-microvolt-speed0-pvs1 = <1200000 1175000 1225000>;
>>> +                     opp-microvolt-speed0-pvs3 = <1150000 1125000 1175000>;
>>> +                     opp-supported-hw = <0x1>;
>>> +             };
>>> +
>>> +             opp-1458000000 {
>>> +                     opp-hz = /bits/ 64 <1458000000>;
>>> +                     opp-peak-kBps = <1350000>;
>>> +                     opp-microvolt-speed0-pvs0 = <1237500 1237500 1237500>;
>>> +                     opp-microvolt-speed0-pvs1 = <1212500 1187500 1237500>;
>>> +                     opp-microvolt-speed0-pvs3 = <1162500 1137500 1187500>;
>>> +                     opp-supported-hw = <0x1>;
>>> +             };
>>> +
>>> +             opp-1512000000 {
>>> +                     opp-hz = /bits/ 64 <1512000000>;
>>> +                     opp-peak-kBps = <1350000>;
>>> +                     opp-microvolt-speed0-pvs0 = <1250000 1250000 1250000>;
>>> +                     opp-microvolt-speed0-pvs1 = <1225000 1200000 1250000>;
>>> +                     opp-microvolt-speed0-pvs3 = <1175000 1150000 1200000>;
>>> +                     opp-supported-hw = <0x1>;
>>> +             };
>>> +     };
>>> +
>>>       memory {
>>>               device_type = "memory";
>>>               reg = <0x0 0x0>;
>>> @@ -266,6 +402,17 @@ msmgpio: pinctrl@800000 {
>>>                       reg = <0x800000 0x4000>;
>>>               };
>>>
>>> +             qfprom: qfprom@700000 {
>>> +                     compatible = "qcom,msm8960-qfprom", "qcom,qfprom";
>>> +                     reg = <0x00700000 0x1000>;
>>> +                     #address-cells = <1>;
>>> +                     #size-cells = <1>;
>>> +                     ranges;
Please add a newline before the subnode.

Konrad

>>> +                     speedbin_efuse: speedbin@c0 {
>>> +                             reg = <0x0c0 0x4>;
>>> +                     };
>>> +             };
>>> +
>>>               gcc: clock-controller@900000 {
>>>                       compatible = "qcom,gcc-msm8960";
>>>                       #clock-cells = <1>;
> 
> 
> 
