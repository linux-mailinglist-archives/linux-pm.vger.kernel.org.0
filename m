Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A942174015E
	for <lists+linux-pm@lfdr.de>; Tue, 27 Jun 2023 18:35:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231953AbjF0QfX (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 27 Jun 2023 12:35:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232467AbjF0Qem (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 27 Jun 2023 12:34:42 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B9D330F6
        for <linux-pm@vger.kernel.org>; Tue, 27 Jun 2023 09:34:22 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id 38308e7fff4ca-2b69923a715so46503671fa.0
        for <linux-pm@vger.kernel.org>; Tue, 27 Jun 2023 09:34:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687883655; x=1690475655;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ff9pjKl2q4eHTKuAX2lYIQZCeKYxi6bK6im7HAgmKWY=;
        b=NclSazdNKNrmEAtS2NuCIf0AxXRmHZlJJF0xMew+V+MXMUDYIaIwyaignBS/QZ7KmW
         MF8ayCpieSfYysc8aHOOVyrYS4sNAJVstkrsWA1Fyd7umsLpm+6t6L80jtxMnl4cSqU5
         RFbT3p9tNIqJroB45JaN6KGiFNve/bHP0c+KGagi5KzLUYvGbxQMXGC4iyOfmNveGcaa
         /2zzSxpkN3UyWFaNTSD4kyoateTAoUDhjbHWytizGoN/ozU9RI8vYI1+9gEkMTgOJQfl
         AKNsbz/hCHGf+0lhhHf3t5h8o9b8CuI4xu13brI1eA1V3Nb2B6MKp8YWvXP9MRvyo/AN
         HAvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687883655; x=1690475655;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ff9pjKl2q4eHTKuAX2lYIQZCeKYxi6bK6im7HAgmKWY=;
        b=FWiuV2czTgigEvNV+spxEbHVnxOCfce3i/nmv8MdPjl8z9gKcE/wAgsD6hD2Nr3to5
         w3HmfhJZDjBG0L/ExUU+xEWMSlmTyyLP2ulRCvguYoOi3emyxVSl0E9zgcAWWLjnyOSa
         Urv3x87UcUND8QsOTGJiUpyzPY/COHiUNH6udwXdON90fiAxzr6G+JlEb1KRy69wZZYJ
         jmIaheNY4oRF9x7N1KIsREpgM3pD9eAMl0XUi2K3auAuvmZQ4Fdg7D5oKyhqd+nHIC+E
         nLGfHDZ5i4YieHDlz8OAKhtCcv57yFdZLs8li5rOJkxwkNVkUa+uTaR6xbnsestZRNti
         FSjg==
X-Gm-Message-State: AC+VfDzdr3Ry8H9uWATrrjqCSNop03vjhLzPlzoY6rNBiyhCUjVdTm8x
        VOKq623gXGkm7janoDUU1rwtBQ==
X-Google-Smtp-Source: ACHHUZ7LVhAwSbtCo/gLWLb/gfGIhWH6n3nwZUR7RuQ1M9SqpG1hNGXy+SIpdfY7Leaozk3IkKOVrQ==
X-Received: by 2002:a2e:848a:0:b0:2b4:6c76:332f with SMTP id b10-20020a2e848a000000b002b46c76332fmr22560841ljh.9.1687883655046;
        Tue, 27 Jun 2023 09:34:15 -0700 (PDT)
Received: from [192.168.1.101] (abxj103.neoplus.adsl.tpnet.pl. [83.9.3.103])
        by smtp.gmail.com with ESMTPSA id z20-20020a2e8e94000000b002af8aaebce4sm1801500ljk.8.2023.06.27.09.34.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Jun 2023 09:34:14 -0700 (PDT)
Message-ID: <443b84f3-7e9d-301b-c9c0-44b9360563f7@linaro.org>
Date:   Tue, 27 Jun 2023 18:34:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v2 17/26] ARM: dts: qcom: apq8064: add simple CPUFreq
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
References: <20230625202547.174647-1-dmitry.baryshkov@linaro.org>
 <20230625202547.174647-18-dmitry.baryshkov@linaro.org>
 <0f139da8-ae01-fc28-d14c-0ea207cf760e@linaro.org>
 <2232c6e7-cbca-30c1-9ec5-1cea7f759daf@linaro.org>
 <8217b8db-cd27-185d-c6b5-e32009202c21@linaro.org>
 <CAA8EJpq8J4fQoqrt3Jdf3C_mGUQdqaNbybdPD-zhEYxmB7DTcg@mail.gmail.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <CAA8EJpq8J4fQoqrt3Jdf3C_mGUQdqaNbybdPD-zhEYxmB7DTcg@mail.gmail.com>
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

On 27.06.2023 16:11, Dmitry Baryshkov wrote:
> On Tue, 27 Jun 2023 at 15:13, Konrad Dybcio <konrad.dybcio@linaro.org> wrote:
>>
>> On 26.06.2023 21:49, Dmitry Baryshkov wrote:
>>> On 26/06/2023 19:40, Konrad Dybcio wrote:
>>>> On 25.06.2023 22:25, Dmitry Baryshkov wrote:
>>>>> Declare CPU frequency-scaling properties. Each CPU has its own clock,
>>>>> how
>>>> however?
>>>
>>> yes
>>>
>>>>
>>>>> all CPUs have the same OPP table. Voltage scaling is not (yet)
>>>>> enabled with this patch. It will be enabled later.
>>>> Risky business.
>>>
>>> But it works :D
>> On your machine ;)
> 
> On two nexus-7 and one ifc6410.
> 
>>
>> [...]
>>
>>>>>   +    kraitcc: clock-controller {
>>>>> +        compatible = "qcom,krait-cc-v1";
>>>> Are we sure we don't wanna rework this compatible? Check the comment in
>>>> drivers/clk/qcom/krait-cc.c : krait_add_sec_mux()
>>>
>>> I remember that comment. I'd rather not introduce another compat string for such old hw. Would there be any direct benefits?
>>>
>> I'd say that the one we have here never made much sense.. Perhaps (since
>> nobody used it for 10 years) it would make sense to remodel it..
> 
> Well we have the bindings for this driver. And also it was used by the
> OpenWRT people, IIRC.
> Thus I don't feel comfortable with throwing out old compat strings.
Oh, OK

Konrad
> 
>>
>> Konrad
>>>>
>>>>
>>>>> +        clocks = <&gcc PLL9>, /* hfpll0 */
>>>>> +             <&gcc PLL10>, /* hfpll1 */
>>>>> +             <&gcc PLL16>, /* hfpll2 */
>>>>> +             <&gcc PLL17>, /* hfpll3 */
>>>>> +             <&gcc PLL12>, /* hfpll_l2 */
>>>>> +             <&acc0>,
>>>>> +             <&acc1>,
>>>>> +             <&acc2>,
>>>>> +             <&acc3>,
>>>>> +             <&l2cc>;
>>>>> +        clock-names = "hfpll0",
>>>>> +                  "hfpll1",
>>>>> +                  "hfpll2",
>>>>> +                  "hfpll3",
>>>>> +                  "hfpll_l2",
>>>>> +                  "acpu0_aux",
>>>>> +                  "acpu1_aux",
>>>>> +                  "acpu2_aux",
>>>>> +                  "acpu3_aux",
>>>>> +                  "acpu_l2_aux";
>>>>> +        #clock-cells = <1>;
>>>>> +        #interconnect-cells = <1>;
>>>>> +    };
>>>>> +
>>>>>       sfpb_mutex: hwmutex {
>>>>>           compatible = "qcom,sfpb-mutex";
>>>>>           syscon = <&sfpb_wrapper_mutex 0x604 0x4>;
>>>>> @@ -933,6 +1100,9 @@ qfprom: qfprom@700000 {
>>>>>               #address-cells = <1>;
>>>>>               #size-cells = <1>;
>>>>>               ranges;
>>>>> +            speedbin_efuse: speedbin@c0 {
>>>>> +                reg = <0x0c0 0x4>;
>>>>> +            };
>>>> Newline between properties and subnodes & between individual subnodes,
>>>> please
>>>
>>> ack.
>>>
>>>>
>>>> Konrad
>>>>>               tsens_calib: calib@404 {
>>>>>                   reg = <0x404 0x10>;
>>>>>               };
>>>
> 
> 
> 
