Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 504556606A8
	for <lists+linux-pm@lfdr.de>; Fri,  6 Jan 2023 19:52:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230047AbjAFSwh (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 6 Jan 2023 13:52:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231281AbjAFSwf (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 6 Jan 2023 13:52:35 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA6CF7DE2A
        for <linux-pm@vger.kernel.org>; Fri,  6 Jan 2023 10:52:31 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id b3so3251429lfv.2
        for <linux-pm@vger.kernel.org>; Fri, 06 Jan 2023 10:52:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TD7cExgBKxjhrMDw5hZV0k9KiTeSdkou8rySHfWyF+4=;
        b=jNOsGP6tpzSAOt1sC85kT/F7skelP98XhZN2T768iMd0t2lMBi4VNsao79siuyhhHZ
         FKHGUgotnCVgQTtcUnQsB4eb9V0nv0brkmW61Ca9c7f7oIksD9OjQUPyFYo1eZjxYgcl
         vLpOGUCcQpkmW8r8A43R0goV87BhQKYb/hmSZvxcT8zeiVvtSRWsfWYPz0MEcVVj5Mxg
         UhhuBQrFWUsmKB38Yyl63Q1zOezcmmDolCH5624D3q8ls+yCsryoQ9K1C/shIC01+iHp
         rBeuwNz2uz0R+3CVGvQ0l/RfiwaBQLSVHgKs193KL9vUsLXiH75dF8mFwU5TcKBG5obH
         ZXpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TD7cExgBKxjhrMDw5hZV0k9KiTeSdkou8rySHfWyF+4=;
        b=LLH/ykghRtPbWrI1zG8yYtTyDR6q7eERUSa8MofE9b/0DMBaiIBMfzmCL+5B/Ljfsj
         kBJmwO5WCC/gdHSbMaUkmDaVnF+YRzD7Ayxp9Cqk//nqAgeujZgvwKKCtgNhvKL5sTvD
         iu/cmgtTH5wYLTDrchN2mQGZaKMbksQsxz28DVN/yGxocVp8OW/+XTfmnAQP+hEfSwv9
         qDHTknYcxM2NIOxubNqZvlFLIJB5qd2xGKHudI7P8PsX2qIzwbGgDtRU3EalPFBWVL60
         RZGUveEhmy2bKgKLt7tbEC4TwBD9IY+q7BpXRHMTZ/IWzzz7cjpRP9kyi0AI5SMhwsnN
         GJ6A==
X-Gm-Message-State: AFqh2kpdQA+5zo7oyTfugiDS5EFxS2kbOSas6LFE2oOTAOacktVln/Br
        LPYTs+Kjl3vBBZ4A5RaWFk4sPw==
X-Google-Smtp-Source: AMrXdXsHdtVlTT5cNfv6PVUfaatqKf11Ub9RrtNJsFNtgnwwrwaJf8in8wgifxiAgC8amQ6bGvR2Iw==
X-Received: by 2002:a05:6512:1395:b0:4b5:b10b:6830 with SMTP id p21-20020a056512139500b004b5b10b6830mr16725097lfa.54.1673031150064;
        Fri, 06 Jan 2023 10:52:30 -0800 (PST)
Received: from ?IPV6:2001:14ba:a085:4d00::8a5? (dzccz6yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a085:4d00::8a5])
        by smtp.gmail.com with ESMTPSA id b10-20020ac2410a000000b004cafd013f54sm237620lfi.118.2023.01.06.10.52.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Jan 2023 10:52:29 -0800 (PST)
Message-ID: <1b2e1431-1fe9-d70e-b45e-71824fe16547@linaro.org>
Date:   Fri, 6 Jan 2023 20:52:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH 3/9] interconnect: qcom: sc7180: drop IP0 remnants
Content-Language: en-GB
To:     Alex Elder <elder@linaro.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Taniya Das <quic_tdas@quicinc.com>
Cc:     Georgi Djakov <djakov@kernel.org>,
        Odelu Kukatla <okukatla@codeaurora.org>,
        Johan Hovold <johan@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20230106073313.1720029-1-dmitry.baryshkov@linaro.org>
 <20230106073313.1720029-4-dmitry.baryshkov@linaro.org>
 <eeb9631c-4494-fc76-5ad4-5fdbdaa8786a@linaro.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <eeb9631c-4494-fc76-5ad4-5fdbdaa8786a@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 06/01/2023 15:44, Alex Elder wrote:
> On 1/6/23 1:33 AM, Dmitry Baryshkov wrote:
>> Drop two defines leftover from the commit 2f3724930eb4 ("interconnect:
>> qcom: sc7180: Drop IP0 interconnects"), which dropped handling of the
>> IP0 resource in favour of handling it in the clk-rpmh driver.
>>
>> Fixes: 2f3724930eb4 ("interconnect: qcom: sc7180: Drop IP0 
>> interconnects")
>> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> 
> On this patch and the rest like it in this series, I suggest
> adding a comment that indicates why there's a gap in the simple
> numeric sequence. 

Ok, sounds fair.

> Feel free to ignore this if you don't think
> this is a good idea.  I'll give examples below, although I
> don't fully understand why there's a master and slave on the
> interconnect, but just a single clock for RPMH clock...

Well, interconnects is a about paths between nodes. So even if we have 
to cast a vote on a single resource, there should be two nodes.

> 
>                      -Alex
> 
>> ---
>>   drivers/interconnect/qcom/sc7180.h | 2 --
>>   1 file changed, 2 deletions(-)
>>
>> diff --git a/drivers/interconnect/qcom/sc7180.h 
>> b/drivers/interconnect/qcom/sc7180.h
>> index c6212a10c2f6..b691d97d56cf 100644
>> --- a/drivers/interconnect/qcom/sc7180.h
>> +++ b/drivers/interconnect/qcom/sc7180.h
>> @@ -11,7 +11,6 @@
>>   #define SC7180_MASTER_APPSS_PROC            0
>>   #define SC7180_MASTER_SYS_TCU                1
>>   #define SC7180_MASTER_NPU_SYS                2
>> -#define SC7180_MASTER_IPA_CORE                3
>      /* MASTER_IPA_CORE (4) is represented as an RPMH clock */
>>   #define SC7180_MASTER_LLCC                4
>>   #define SC7180_MASTER_A1NOC_CFG                5
>>   #define SC7180_MASTER_A2NOC_CFG                6
>> @@ -58,7 +57,6 @@
>>   #define SC7180_MASTER_USB3                47
>>   #define SC7180_MASTER_EMMC                48
>>   #define SC7180_SLAVE_EBI1                49
>> -#define SC7180_SLAVE_IPA_CORE                50
>      /* SLAVE_IPA_CORE (50) is represented as an RPMH clock */
>>   #define SC7180_SLAVE_A1NOC_CFG                51
>>   #define SC7180_SLAVE_A2NOC_CFG                52
>>   #define SC7180_SLAVE_AHB2PHY_SOUTH            53
> 

-- 
With best wishes
Dmitry

