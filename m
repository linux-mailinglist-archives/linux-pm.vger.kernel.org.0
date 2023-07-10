Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA3E274D50E
	for <lists+linux-pm@lfdr.de>; Mon, 10 Jul 2023 14:14:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230250AbjGJMOw (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 10 Jul 2023 08:14:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231358AbjGJMOs (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 10 Jul 2023 08:14:48 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 818C6198
        for <linux-pm@vger.kernel.org>; Mon, 10 Jul 2023 05:14:43 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-4f4b2bc1565so6708215e87.2
        for <linux-pm@vger.kernel.org>; Mon, 10 Jul 2023 05:14:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688991281; x=1691583281;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FIUM80sem4wvBeLJM7gxDVfcq4hFkz0TAKhA7YTlha0=;
        b=T3lrZkp+l0MpEVWQYcpC2aYnnrChpg4lobA/mkpPEJVQV0pIGNWa0GXgLs88EXFpVa
         ZIbQ5WhqtTETOmfuAtQZWpm7a/seTDSxVWUY4T3NAkD0y5jRdx4LjPD9ket4+PskCCG7
         VWASjUFKokDKj4uXztwOem+R9vh9h+qY9UTEfjIiQy+FqDQAxBmTsxjNeVGlFoTMj/s0
         GgQj9Ott1jKbkncPXlMA2NlotE2xmFU7hW/CcyYp3aOW10tyDmManBPJtOr/iHHEl72B
         9x+74s98lapudBtz3j57nWmfsPOGbqnK7gIyXrMWs9n8oPLnxLfn3wv0CWZ7ZtOLHjwn
         /o8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688991282; x=1691583282;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FIUM80sem4wvBeLJM7gxDVfcq4hFkz0TAKhA7YTlha0=;
        b=WWVrZUrlUOJ/iVIzr0TzNjQVzJ1PqRgzWHIUHoOyQkeLVJbLD+FdF4gSeq7qneJuLx
         BwJQBu+tBsW47chDgX+l0hWnJhG1q7yoquERD0pEpOcACvCsGWUQHGDEnLjg8CsXu/8j
         Z0Jedzzz3TRHqqzWsmJQm5SSZg8T7p1OLTM7/RFOGI2gADgeZBs5X6Zd0dROWnlm9NeE
         8S9MoH/LZl/W4MvrYOUkDu65toxF3T6Qr6onWaLYHTQSStxx9kk1P3C7M0iQyOxM+/w2
         h2LtCj0bV5hCz7+u3MCmU44iHk27qA6sgIfQVffUrSV942DCOQC/9d+44Xwe4MUw06Ef
         U8iA==
X-Gm-Message-State: ABy/qLaQBrUgpQaJTJ3RE9yiGvmxT1nGmz+Xfyt9igGdJjT4gcjgM1Su
        79c1X4bBPa90IcUfwOmCWL+KxQ==
X-Google-Smtp-Source: APBJJlEggwbPNBYWyFhjvfF6GLwQ/BHHtenN1h2x1ww8Fde/Lb05kPWkKWYva1WKoqvyG5xx6CJVPw==
X-Received: by 2002:a05:6512:239f:b0:4fb:77d6:89c3 with SMTP id c31-20020a056512239f00b004fb77d689c3mr11852649lfv.12.1688991281113;
        Mon, 10 Jul 2023 05:14:41 -0700 (PDT)
Received: from [192.168.1.101] (abxj141.neoplus.adsl.tpnet.pl. [83.9.3.141])
        by smtp.gmail.com with ESMTPSA id e7-20020ac25467000000b004fb763b5171sm1678441lfn.86.2023.07.10.05.14.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Jul 2023 05:14:40 -0700 (PDT)
Message-ID: <b1346bc7-4bf0-e885-c3d4-6fac01516bf4@linaro.org>
Date:   Mon, 10 Jul 2023 14:14:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 5/6] arm64: dts: qcom: ipq5332: Add thermal zone nodes
Content-Language: en-US
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Praveenkumar I <quic_ipkumar@quicinc.com>, agross@kernel.org,
        andersson@kernel.org, amitk@kernel.org, thara.gopinath@gmail.com,
        rafael@kernel.org, daniel.lezcano@linaro.org, rui.zhang@intel.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     quic_varada@quicinc.com
References: <20230710103735.1375847-1-quic_ipkumar@quicinc.com>
 <20230710103735.1375847-6-quic_ipkumar@quicinc.com>
 <3f6ab4b4-b5f5-5807-0cb4-8ae782bd6044@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <3f6ab4b4-b5f5-5807-0cb4-8ae782bd6044@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 10.07.2023 13:23, Dmitry Baryshkov wrote:
> On 10/07/2023 13:37, Praveenkumar I wrote:
>> This patch adds thermal zone nodes for sensors present in
>> IPQ5332.
>>
>> Signed-off-by: Praveenkumar I <quic_ipkumar@quicinc.com>
>> ---
>>   arch/arm64/boot/dts/qcom/ipq5332.dtsi | 72 +++++++++++++++++++++++++++
>>   1 file changed, 72 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/ipq5332.dtsi b/arch/arm64/boot/dts/qcom/ipq5332.dtsi
>> index a1e3527178c0..8b276aeca53e 100644
>> --- a/arch/arm64/boot/dts/qcom/ipq5332.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/ipq5332.dtsi
>> @@ -527,4 +527,76 @@ timer {
>>                    <GIC_PPI 4 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
>>                    <GIC_PPI 1 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>;
>>       };
>> +
>> +    thermal-zones {
>> +        rfa-0-thermal{
thermal {


>> +            polling-delay-passive = <0>;
>> +            polling-delay = <0>;
>> +            thermal-sensors = <&tsens 11>;
>> +
>> +            trips {
Indentation seems off, tab size for kernel code is 8 spaces.

Konrad
>> +                rfa-0-critical {
>> +                    temperature = <125000>;
>> +                    hysteresis = <1000>;
>> +                    type = "critical";
>> +                };
>> +            };
>> +        };
>> +
>> +        rfa-1-thermal {
>> +            polling-delay-passive = <0>;
>> +            polling-delay = <0>;
>> +            thermal-sensors = <&tsens 12>;
>> +
>> +            trips {
>> +                rfa-1-critical {
>> +                    temperature = <125000>;
>> +                    hysteresis = <1000>;
>> +                    type = "critical";
>> +                };
>> +            };
>> +        };
>> +
>> +        misc-thermal {
>> +            polling-delay-passive = <0>;
>> +            polling-delay = <0>;
>> +            thermal-sensors = <&tsens 13>;
>> +
>> +            trips {
>> +                misc-critical {
>> +                    temperature = <125000>;
>> +                    hysteresis = <1000>;
>> +                    type = "critical";
>> +                };
>> +            };
>> +        };
>> +
>> +        cpu-top-thermal {
>> +            polling-delay-passive = <0>;
>> +            polling-delay = <0>;
>> +            thermal-sensors = <&tsens 14>;
>> +
>> +            trips {
>> +                cpu-top-critical {
>> +                    temperature = <125000>;
>> +                    hysteresis = <1000>;
>> +                    type = "critical";
>> +                };
>> +            };
> 
> Could you please add a passive cooling devices for the CPU?
> 
>> +        };
>> +
>> +        top-glue-thermal {
>> +            polling-delay-passive = <0>;
>> +            polling-delay = <0>;
>> +            thermal-sensors = <&tsens 15>;
>> +
>> +            trips {
>> +                top-glue-critical {
>> +                    temperature = <125000>;
>> +                    hysteresis = <1000>;
>> +                    type = "critical";
>> +                };
>> +            };
>> +        };
>> +    };
>>   };
> 
