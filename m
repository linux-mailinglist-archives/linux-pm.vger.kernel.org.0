Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF55357EB8F
	for <lists+linux-pm@lfdr.de>; Sat, 23 Jul 2022 04:37:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229572AbiGWChS (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 22 Jul 2022 22:37:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229825AbiGWChR (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 22 Jul 2022 22:37:17 -0400
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D36E061B23
        for <linux-pm@vger.kernel.org>; Fri, 22 Jul 2022 19:37:15 -0700 (PDT)
Received: by mail-ot1-x32a.google.com with SMTP id c20-20020a9d4814000000b0061cecd22af4so118123otf.12
        for <linux-pm@vger.kernel.org>; Fri, 22 Jul 2022 19:37:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kali.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language
         :from:to:cc:references:in-reply-to:content-transfer-encoding;
        bh=voGugAT13Hil5ADAXFI0Z5pBEP04QpaFfT3ChpCj5yw=;
        b=PlpYiugUWSomUF/0hlCtQAmLPyY8rLDdlVOM61Ba7K6AcyKH+8rdr/ZHZW8P2vICUV
         +9pvpRkiFkdxxazwuSrke9x1L0yJwWQ3MCs88vBxtiAn6b9oUwspxeqqkGEbK6er02+y
         fTt8I3LxCC961fWWYI0tTOm4X2BJgZu+CrmKHEOk4oJRB1u6IjPkw45kGwQ4pLC7yuze
         kX3KfCVDFZizQYirPbxBVwmW2Z8PsRpUHRcB5HWe68nEmGpie7pb+bGuIbYPi1pD3biP
         bmj+Nq18xM53W32WjTeCFR2qW47MDy3Ul6p8K0xh+BQHW/kYO93dhS5S5iHCVGa/SX79
         nNcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:from:to:cc:references:in-reply-to
         :content-transfer-encoding;
        bh=voGugAT13Hil5ADAXFI0Z5pBEP04QpaFfT3ChpCj5yw=;
        b=Yu7alKIQilkQjcM8YV230xEim5UehUG3z827i1Gw79g3/6lnp+iyIAz+mln2V/3ii2
         CczPoWXkoqt0A1zur/tTrTGFVCcVTKh9mqB059bqC/eEPzIdFbpdbgMlH5cWOfXkTisG
         /82Uz7xUZxylwQe27o3keXWXNtZsZ4T+yExclapMIjaVaesTr3EXmXnorAyF8gtE2JGx
         SWWuMiWTPe5jbCrFPVZ8bgbUVlXPzGy73lXqAaLlbcqEGe7y3mYNTjCC6t5coZluM6yA
         4tYhZgn6aMtnO4xzvaybcY36LD77Sp8fgzVXCQWGa9Tr1FjrA1YBFF9gsIfITVBwoKiY
         KzFA==
X-Gm-Message-State: AJIora/ZbJtbGaqtxug+VO6DqexE/YsKotGWQkc8H4OXM6O5Aga0zQbh
        FjGFTnVds04MlyoA8+5C6gOwun+LoES2+8Ens9A=
X-Google-Smtp-Source: AGRyM1vG1vMNCzMDvxCaqBAcafZzpnlk4TyH/Rxj0qwSionFWOgG9Bd4tQwIMCPuO9cYUn4QfHSuag==
X-Received: by 2002:a9d:554f:0:b0:61c:86e4:2f37 with SMTP id h15-20020a9d554f000000b0061c86e42f37mr1054976oti.131.1658543835142;
        Fri, 22 Jul 2022 19:37:15 -0700 (PDT)
Received: from [192.168.11.16] (cpe-173-173-107-246.satx.res.rr.com. [173.173.107.246])
        by smtp.gmail.com with ESMTPSA id k14-20020a056808068e00b0033a2f6e4736sm2489061oig.20.2022.07.22.19.37.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Jul 2022 19:37:14 -0700 (PDT)
Message-ID: <d89a540f-672d-83de-d19d-00f10e4370d1@kali.org>
Date:   Fri, 22 Jul 2022 21:37:12 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.11.0
Subject: Re: [PATCH 10/10] arm64: dts: qcom: sdm845: add LLCC BWMON
Content-Language: en-US
From:   Steev Klimaszewski <steev@kali.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Georgi Djakov <djakov@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Rajendra Nayak <quic_rjendra@quicinc.com>
References: <20220720192807.130098-1-krzysztof.kozlowski@linaro.org>
 <20220720192807.130098-11-krzysztof.kozlowski@linaro.org>
 <25673493-4171-62b0-f696-1316d115f388@kali.org>
 <96552a95-8939-3ac2-c9b3-14dabaf53923@linaro.org>
 <d814a6da-b0d7-2fd1-fd14-8f1f3b88666f@kali.org>
In-Reply-To: <d814a6da-b0d7-2fd1-fd14-8f1f3b88666f@kali.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


On 7/22/22 7:29 PM, Steev Klimaszewski wrote:
>
> On 7/22/22 12:30 PM, Krzysztof Kozlowski wrote:
>> On 22/07/2022 03:22, Steev Klimaszewski wrote:
>>> Hi Krzysztof,
>>>
>>> On 7/20/22 2:28 PM, Krzysztof Kozlowski wrote:
>>>> The SDM845 comes with few instances of Bandwidth Monitor.  The already
>>>> supported one monitors traffic between CPU and Last Level Cache
>>>> Controller (LLCC) and in downstream sources is called BWMON v4 (or 
>>>> v4 of
>>>> register layout).
>>>>
>>>> SDM845 also has also BWMON instance measuring traffic between LLCC and
>>>> memory with different register layout: called v5.
>>>>
>>>> Cc: Rajendra Nayak <quic_rjendra@quicinc.com>
>>>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>>>> ---
>>>>    arch/arm64/boot/dts/qcom/sdm845.dtsi | 37 
>>>> ++++++++++++++++++++++++++++
>>>>    1 file changed, 37 insertions(+)
>>>>
>>>> diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi 
>>>> b/arch/arm64/boot/dts/qcom/sdm845.dtsi
>>>> index fe14f7e7523b..4aab464e2bd6 100644
>>>> --- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
>>>> +++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
>>>> @@ -2053,6 +2053,43 @@ llcc: system-cache-controller@1100000 {
>>>>                interrupts = <GIC_SPI 582 IRQ_TYPE_LEVEL_HIGH>;
>>>>            };
>>>>    +        pmu@114a000 {
>>>> +            compatible = "qcom,sdm845-llcc-bwmon";
>>>> +            reg = <0 0x0114a000 0 0x1000>;
>>>> +            interrupts = <GIC_SPI 580 IRQ_TYPE_LEVEL_HIGH>;
>>>> +            interconnects = <&mem_noc MASTER_LLCC 3 &mem_noc 
>>>> SLAVE_EBI1 3>;
>>>> +
>>>> +            operating-points-v2 = <&llcc_bwmon_opp_table>;
>>>> +
>>>> +            llcc_bwmon_opp_table: opp-table {
>>>> +                compatible = "operating-points-v2";
>>>> +
>>>> +                /*
>>>> +                 * The interconnect path bandwidth taken from
>>>> +                 * cpu4_opp_table bandwidth for gladiator_noc-mem_noc
>>>> +                 * interconnect.  This also matches the
>>>> +                 * bandwidth table of qcom,llccbw (qcom,bw-tbl,
>>>> +                 * bus width: 4 bytes) from msm-4.9 downstream
>>>> +                 * kernel.
>>>> +                 */
>>>> +                opp-0 {
>>>> +                    opp-peak-kBps = <800000>;
>>>> +                };
>>>> +                opp-1 {
>>>> +                    opp-peak-kBps = <1804000>;
>>>> +                };
>>>> +                opp-2 {
>>>> +                    opp-peak-kBps = <3072000>;
>>>> +                };
>>>> +                opp-3 {
>>>> +                    opp-peak-kBps = <5412000>;
>>>> +                };
>>>> +                opp-4 {
>>>> +                    opp-peak-kBps = <7216000>;
>>>> +                };
>>>> +            };
>>>> +        };
>>>> +
>>>>            pmu@1436400 {
>>>>                compatible = "qcom,sdm845-bwmon", "qcom,msm8998-bwmon";
>>>>                reg = <0 0x01436400 0 0x600>;
>>>
>>> With this series applied, testing on a Lenovo Yoga C630, which has an
>>> SDM850, I see the following:
>>>
>>> [    3.673660] qcom-bwmon 114a000.pmu: can't request region for 
>>> resource
>>> [mem 0x0114a000-0x0114afff]
>>> [    3.673673] qcom-bwmon 114a000.pmu: error -EBUSY: failed to map 
>>> bwmon
>>> registers
>>> [    3.673678] qcom-bwmon: probe of 114a000.pmu failed with error -16
>>>
>> Thanks for the report. What are you running there? `uname -r`? Maybe
>> your secure world uses it?
>>
>> Best regards,
>> Krzysztof
>
> Currently it's 5.19.0-rc7 (torvalds tree at 4ba1329c) with a few extra 
> patches on top, the bwmon set included.  It's possible that secure 
> world uses it, but I do not know enough about that to say one way or 
> the other.
>
> -- steev
>
I think you may be right; I just applied this patchset to -next 
(20220722) and i do not see the error message there.  On my 5.19-rc7 
tree, i am also testing a patchset that enables qcom devices to access 
efivars, so possibly we are ending up in secure world there?
