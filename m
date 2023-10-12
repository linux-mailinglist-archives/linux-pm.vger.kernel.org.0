Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A31737C735D
	for <lists+linux-pm@lfdr.de>; Thu, 12 Oct 2023 18:45:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379559AbjJLQpd (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 12 Oct 2023 12:45:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379509AbjJLQpc (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 12 Oct 2023 12:45:32 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4DC5CA
        for <linux-pm@vger.kernel.org>; Thu, 12 Oct 2023 09:45:30 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-9b1ebc80d0aso184100266b.0
        for <linux-pm@vger.kernel.org>; Thu, 12 Oct 2023 09:45:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697129129; x=1697733929; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kRh+Vupx0XypJiTrUDbDPsKcsjU0eEhEwWX6GsRTbtw=;
        b=M3WGMV8HoyeP3/jPDaNPDSuBqQsHKWODClmLyKtJx5di7YL2ABsiR3lArZpDnoumXB
         8bFjAN3ypyaQqT81WUikEEqAnU98o/GReLZq3ZlWj2c9Q9Q3MC2EdTsdi45HU4B+KL9A
         5TViomjOKTzo+8cszm5QM1cIqu/U67wiXDwLuXxnajEWKY3dcO4nc+5KwEIDyvAp5847
         uINnPS8vjP/c9O+a2Em+7OVO6mOhnafH9oC7YOY264/3xg/tBtentb1fTonuEXjR9ThP
         l4cwoSgJB6+9CdCHbHAkgNiqdmpSxWzYLQgcNtG2YTVoowrJLrQRX6tCPlaNFGVoiRWo
         8+9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697129129; x=1697733929;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kRh+Vupx0XypJiTrUDbDPsKcsjU0eEhEwWX6GsRTbtw=;
        b=MbM5TYeTGcR3P/3Ih/DnutIOJSxzM215VvTKERSdHrOKYDn7N7VYEev9b56qJXpB97
         xBlWFS9IUEXUsTG2S2Ix5yDawkr0ogdsIeg0GQO22pLKIdsk3VoXGDwCuBe/I/wfnIoo
         b0LlN0mtaa2PjGBhCvzzf2WibjDVdlRbcL/4DERYEKev9agZxUa/4owYEG/ePX/yoqbz
         y7JfCdvOx6EE56E6iBJXs6e/4lDYenKpijYtONrpMCL1KEhutA1S8ay9f8+3fd6OQu42
         nEzLTxFdoEBrV9DNvZ6jEvDLJ6NabgqXqzZeHQD9i3em9bQzBIsUhOpmEIf0OcH0d7mh
         RSYw==
X-Gm-Message-State: AOJu0YxNvtuK1hDiH50zH+QIT0SOdTaG0ZKl95kTEW0iZQqKi9nG9ZNA
        8Qv3EXnoJEBhTGRm/OJCFB/Cig==
X-Google-Smtp-Source: AGHT+IEXqEp3kFB6IUpjF8BAzbvasyJj3DSZYDjbuCP/F0tb8JGBX/QQLV+mGV4P8Tus5qj+oyhvlg==
X-Received: by 2002:a17:906:24e:b0:9a1:e293:9882 with SMTP id 14-20020a170906024e00b009a1e2939882mr21330362ejl.63.1697129129266;
        Thu, 12 Oct 2023 09:45:29 -0700 (PDT)
Received: from [172.30.204.175] (UNUSED.212-182-62-129.lubman.net.pl. [212.182.62.129])
        by smtp.gmail.com with ESMTPSA id g7-20020a1709067c4700b0099bd1a78ef5sm11250236ejp.74.2023.10.12.09.45.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Oct 2023 09:45:28 -0700 (PDT)
Message-ID: <fef38d0e-f24b-41ce-9d28-82cd637ce342@linaro.org>
Date:   Thu, 12 Oct 2023 18:45:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 4/4] ARM: dts: qcom: ipq8064: Add CPU OPP table
Content-Language: en-US
To:     Christian Marangi <ansuelsmth@gmail.com>
Cc:     Robert Marko <robimarko@gmail.com>, ilia.lin@kernel.org,
        vireshk@kernel.org, nm@ti.com, sboyd@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, agross@kernel.org, andersson@kernel.org,
        rafael@kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
References: <20230930102218.229613-1-robimarko@gmail.com>
 <20230930102218.229613-4-robimarko@gmail.com>
 <e2d6c9c7-ff59-408f-94cf-81e66d291963@linaro.org>
 <6525ae86.050a0220.827f2.c59d@mx.google.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <6525ae86.050a0220.827f2.c59d@mx.google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 10/10/23 22:05, Christian Marangi wrote:
> On Tue, Oct 10, 2023 at 09:55:26PM +0200, Konrad Dybcio wrote:
>>
>>
>> On 9/30/23 12:21, Robert Marko wrote:
>>> From: Christian Marangi <ansuelsmth@gmail.com>
>>>
>>> Add CPU OPP table for IPQ8062, IPQ8064 and IPQ8065 SoC.
>>> Use opp-supported-hw binding to correctly enable and disable the
>>> frequency as IPQ8062 supports up to 1.0Ghz, IPQ8064 supports up to
>>> 1.4GHz with 1.2GHz as an additional frequency and IPQ8065 supports
>>> 1.7GHZ but doesn't have 1.2GHZ frequency and has to be disabled.
>>>
>>> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
>>> Signed-off-by: Robert Marko <robimarko@gmail.com>
>>> ---
>>> Changes v4:
>>> * Add OPP DTS patch for IPQ8064
>>>
>>>    arch/arm/boot/dts/qcom/qcom-ipq8062.dtsi | 30 +++++++++++
>>>    arch/arm/boot/dts/qcom/qcom-ipq8064.dtsi | 67 ++++++++++++++++++++++++
>>>    arch/arm/boot/dts/qcom/qcom-ipq8065.dtsi | 65 +++++++++++++++++++++++
>>>    3 files changed, 162 insertions(+)
>>>
>>> diff --git a/arch/arm/boot/dts/qcom/qcom-ipq8062.dtsi b/arch/arm/boot/dts/qcom/qcom-ipq8062.dtsi
>>> index 5d3ebd3e2e51..72d9782c3d6f 100644
>>> --- a/arch/arm/boot/dts/qcom/qcom-ipq8062.dtsi
>>> +++ b/arch/arm/boot/dts/qcom/qcom-ipq8062.dtsi
>>> @@ -6,3 +6,33 @@ / {
>>>    	model = "Qualcomm Technologies, Inc. IPQ8062";
>>>    	compatible = "qcom,ipq8062", "qcom,ipq8064";
>>>    };
>>> +
>>> +&opp_table_cpu {
>>> +	opp-384000000 {
>>> +		opp-microvolt-speed0-pvs0 = <1000000 950000 1050000>;
>>> +		opp-microvolt-speed0-pvs1 = <925000 878750 971250>;
>>> +		opp-microvolt-speed0-pvs2 = <875000 831250 918750>;
>>> +		opp-microvolt-speed0-pvs3 = <800000 760000 840000>;
>> We can just make use of opp-supported-hw and define opp-384...-0,
>> opp-384..-1 etc. with a valid corresponding bitmask in opp-supported-hw
>>
>> otherwise it's somewhat confusing to follow, I think..
>>
> 
> Ehh should we really double the nodes for ipq8062 and ipq8065?
Hm.. I'm not 100% sure, both solutions are kinda meh, but perhaps 
overwriting it will be less of a hassle for looking at the decompiled dt 
indeed..

> The idea here was to overwrite the one since the pvs always match and at
> worst(ipq8065) have 7 pvs instead of 4. From the system it would be
> easier to read since only one table is present in the final dts and not
> 2 and referring to the opp-supported-hw.
> 
> The original idea was to declare one opp table and reuse pvs version (by
> faking it with hardcoded values) to put additional pvs for ipq8062 and
> ipq8065, but Dmitry didn't like it and asked to move the opp in
> different dtsi.
Yeah this fusing thing is complex enough already

KOnrad
