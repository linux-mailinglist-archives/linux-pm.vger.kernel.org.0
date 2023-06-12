Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4724772C607
	for <lists+linux-pm@lfdr.de>; Mon, 12 Jun 2023 15:33:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232660AbjFLNdR (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 12 Jun 2023 09:33:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235876AbjFLNdP (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 12 Jun 2023 09:33:15 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D8A0F1
        for <linux-pm@vger.kernel.org>; Mon, 12 Jun 2023 06:33:13 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-4f6170b1486so5289863e87.0
        for <linux-pm@vger.kernel.org>; Mon, 12 Jun 2023 06:33:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686576791; x=1689168791;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=j0BtWef05P50AZolUyxN0L22aqNjqMA9iLYT2Vrx8+Y=;
        b=IuDOVYUWJTrtVM24OGVA8/rlFHy+y1Y6hkL5PK0wbxK3vLwgD3SY3BX8HrNBULnbvU
         gfNdk07aqfXijq5d8ip4FtvWlxoka0locpI4e59IX5WIYNqW2EyxOI87BE7YwVv0wnOk
         AY8ecLHBiTdSgm7lkJgVnDazQW+6OUzSYqA7Wpag0cRx9OgE0H0u1ziWfkv6FjEPGDqU
         4Qbw7lXx+PyMevgo/81gjp9TXSYLc3KXDQiOaMd8RY7+ogRxPnKIzedqhbAEf+wWekci
         Fa/Xh6dFkgng/yZtkfpWCdT2yY12GvQxK2CSmiqg/ZBygxULYpC2BrtukEnZKSDQAp78
         vizA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686576791; x=1689168791;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=j0BtWef05P50AZolUyxN0L22aqNjqMA9iLYT2Vrx8+Y=;
        b=EVkCxfyWogmFR1lx4+ecjgmS3X/dtV/2UhkZL7iflsgdqqEykB2PszHOGh7TcImEzg
         WKMllzesOVfGZujNI3SKVv8son5KNuVSrimn7XbDzJnEawJ55dw17b603ne9EzvG/gPn
         p5SApHhMetdDCzMNt0Zw6dcLzsJYPT8NOhYls21b5UtoGeopxy0Cax63xcyaJLo/IbRf
         hmSRzVwiAPfMwwKJk9Dvev/+prbwNyt+BSB8LoaggG+BI97I9AfLSuCkWhYu8YJdsEAw
         wavGUw29Fi/EuvgNDOT9iQIXqRo2YKxUF0Ngc2lpc6ZVhKQpzYSvL203hd9zdmFtwkez
         kkkg==
X-Gm-Message-State: AC+VfDxkY64l2kTCszb7eNVyVb4gPQG6ZzrhfSGWe+JDRsKhjYSN5GX8
        lfoazmOf29gfzNL3gD/3Pp/lQQ==
X-Google-Smtp-Source: ACHHUZ5jg8U5re+laJc3UhaUZ6VSMxMxuIF+CKl/Y9e6iJ4ubnZWGquHHnHTu+8mWEPO+Pk1PZqv3A==
X-Received: by 2002:a05:6512:1ca:b0:4f4:2717:7e6f with SMTP id f10-20020a05651201ca00b004f427177e6fmr3166286lfp.23.1686576791391;
        Mon, 12 Jun 2023 06:33:11 -0700 (PDT)
Received: from ?IPV6:2001:14ba:a0db:1f00::8a5? (dzdqv0yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a0db:1f00::8a5])
        by smtp.gmail.com with ESMTPSA id x3-20020ac259c3000000b004f39bb71ed2sm1440105lfn.138.2023.06.12.06.33.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Jun 2023 06:33:10 -0700 (PDT)
Message-ID: <8c1085fd-8a73-d192-6624-d4f35728e68a@linaro.org>
Date:   Mon, 12 Jun 2023 16:33:09 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 15/18] ARM: dts: qcom: apq8064: provide voltage scaling
 tables
Content-Language: en-GB
To:     Stephan Gerhold <stephan@gerhold.net>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Ilia Lin <ilia.lin@kernel.org>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-clk@vger.kernel.org,
        Christian Marangi <ansuelsmth@gmail.com>
References: <20230612053922.3284394-1-dmitry.baryshkov@linaro.org>
 <20230612053922.3284394-16-dmitry.baryshkov@linaro.org>
 <ZIbez4RA0OoVfHzt@gerhold.net>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <ZIbez4RA0OoVfHzt@gerhold.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

On 12/06/2023 12:01, Stephan Gerhold wrote:
> On Mon, Jun 12, 2023 at 08:39:19AM +0300, Dmitry Baryshkov wrote:
>> APQ8064 has 4 speed bins, each of them having from 4 to 6 categorization
>> kinds. Provide tables necessary to handle voltage scaling on this SoC.
>>
>> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
>> ---
>>   arch/arm/boot/dts/qcom-apq8064.dtsi | 1017 +++++++++++++++++++++++++++
>>   1 file changed, 1017 insertions(+)
>>
>> diff --git a/arch/arm/boot/dts/qcom-apq8064.dtsi b/arch/arm/boot/dts/qcom-apq8064.dtsi
>> index 4ef13f3d702b..f35853b59544 100644
>> --- a/arch/arm/boot/dts/qcom-apq8064.dtsi
>> +++ b/arch/arm/boot/dts/qcom-apq8064.dtsi
>> @@ -49,6 +49,9 @@ CPU0: cpu@0 {
>>   			clocks = <&kraitcc KRAIT_CPU_0>;
>>   			clock-names = "cpu";
>>   			clock-latency = <100000>;
>> +			vdd-mem-supply = <&pm8921_l24>;
>> +			vdd-dig-supply = <&pm8921_s3>;
>> +			vdd-core-supply = <&saw0_vreg>;
>>   			interconnects = <&kraitcc MASTER_KRAIT_L2 &kraitcc SLAVE_KRAIT_L2>;
>>   			operating-points-v2 = <&cpu_opp_table>;
>>   			#cooling-cells = <2>;
>> @@ -66,6 +69,9 @@ CPU1: cpu@1 {
>>   			clocks = <&kraitcc KRAIT_CPU_1>;
>>   			clock-names = "cpu";
>>   			clock-latency = <100000>;
>> +			vdd-mem-supply = <&pm8921_l24>;
>> +			vdd-dig-supply = <&pm8921_s3>;
>> +			vdd-core-supply = <&saw1_vreg>;
>>   			interconnects = <&kraitcc MASTER_KRAIT_L2 &kraitcc SLAVE_KRAIT_L2>;
>>   			operating-points-v2 = <&cpu_opp_table>;
>>   			#cooling-cells = <2>;
>> @@ -83,6 +89,9 @@ CPU2: cpu@2 {
>>   			clocks = <&kraitcc KRAIT_CPU_2>;
>>   			clock-names = "cpu";
>>   			clock-latency = <100000>;
>> +			vdd-mem-supply = <&pm8921_l24>;
>> +			vdd-dig-supply = <&pm8921_s3>;
>> +			vdd-core-supply = <&saw2_vreg>;
>>   			interconnects = <&kraitcc MASTER_KRAIT_L2 &kraitcc SLAVE_KRAIT_L2>;
>>   			operating-points-v2 = <&cpu_opp_table>;
>>   			#cooling-cells = <2>;
>> @@ -100,6 +109,9 @@ CPU3: cpu@3 {
>>   			clocks = <&kraitcc KRAIT_CPU_3>;
>>   			clock-names = "cpu";
>>   			clock-latency = <100000>;
>> +			vdd-mem-supply = <&pm8921_l24>;
>> +			vdd-dig-supply = <&pm8921_s3>;
>> +			vdd-core-supply = <&saw3_vreg>;
>>   			interconnects = <&kraitcc MASTER_KRAIT_L2 &kraitcc SLAVE_KRAIT_L2>;
>>   			operating-points-v2 = <&cpu_opp_table>;
>>   			#cooling-cells = <2>;
>> @@ -132,6 +144,81 @@ cpu_opp_table: opp-table-cpu {
>>   		opp-384000000 {
>>   			opp-hz = /bits/ 64 <384000000>;
>>   			opp-peak-kBps = <384000>;
>> +			opp-microvolt-speed0-pvs0 = <1050000 1050000 1150000>,
>> +						    <950000 950000 1150000>,
>> +						    <950000 950000 975000>;
> 
> I think this won't result in the correct switch order without making
> some changes to the OPP core. In _set_opp() the OPP core does
> 
> 	/* Scaling up? Configure required OPPs before frequency */
> 	if (!scaling_down) {
> 		_set_required_opps();
> 		_set_opp_bw();
> 		opp_table->config_regulators();
> 	}
> 
> 	opp_table->config_clks();
> 
> 	/* Scaling down? Configure required OPPs after frequency */
> 	if (scaling_down) {
> 		opp_table->config_regulators();
> 		_set_opp_bw();
> 		_set_required_opps();
> 	}
> 
> Since the "bandwidth" for the L2 cache is set before the regulators
> there is a short window where the L2 clock is running at a high
> frequency with too low voltage, which could potentially cause
> instability. On downstream this seems to be done in the proper order [1].
> 
> I'm not sure if the order in the OPP core is on purpose. If not, you
> could propose moving the config_regulators() first (for scaling up)
> and last (for scaling down). This would resolve the problem.

Nice catch, I missed this ordering point.

> 
> The alternative that I've already argued for on IRC in #linux-msm a
> couple of days ago would be to give the L2 cache (here: "interconnect")
> an own OPP table where it can describe its voltage requirements,
> independent from the CPU. That way the icc_set_bw() would be guaranteed
> to apply the correct voltage before adjusting the L2 cache clock. It
> looks like the "l2_level" voltages for vdd_dig and vdd_mem are not
> speedbin/PVS-specific [2] so this would also significantly reduce the DT
> size, since you wouldn't need to repeat the same vdd_dig/vdd_mem
> voltages for all of them.

Yes. I fact our discussion triggered me to do this patchset.

So, another option would be to have something like the following 
snippet. Do you know if we are allowed to squish additional data into 
the L2 cache DT node?

CPU0: cpu@0 {
     vdd-core-supply = <&saw0_vreg>;
     interconnects = <&L2 MASTER_KRAIT_L2 &L2 SLAVE_KRAIT_L2>;
     operating-points-v2 = <&cpu_opp_table>;
};

L2: l2-cache {
     compatible = "qcom,apq8064-l2-cache", "cache";

     clocks = <&kraitcc KRAIT_L2>;
     vdd-mem-supply = <&pm8921_l24>;
     vdd-dig-supply = <&pm8921_s3>;
     operating-points-v2 = <&l2_opp_table>;

     l2_opp_table {
         compatible = "operating-points-v2";
         opp-384000000 {
             opp-hz = /bits/ 64 <384000000>;
             opp-microvolt = <1050000 1050000 1150000>,
                             <950000 950000 1150000>;
         };

         opp-648000000 {
             opp-hz = /bits/ 64 <648000000>;
             opp-microvolt = <1050000 1050000 1150000>,
                             <1050000 1050000 1150000>;
         };

         opp-1134000000 {
             opp-hz = /bits/ 64 <1134000000>;
             opp-microvolt = <1150000 1150000 1150000>,
                             <1150000 1150000 1150000>;
         };
     };
};

> 
> Thanks,
> Stephan
> 
> [1]: https://git.codelinaro.org/clo/la/kernel/msm/-/blob/LA.AF.1.2.1-08410-8064.0/arch/arm/mach-msm/acpuclock-krait.c#L529-588
> [2]: https://git.codelinaro.org/clo/la/kernel/msm/-/blob/LA.AF.1.2.1-08410-8064.0/arch/arm/mach-msm/acpuclock-8064.c#L118-135

-- 
With best wishes
Dmitry

