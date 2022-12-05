Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 644D46428AD
	for <lists+linux-pm@lfdr.de>; Mon,  5 Dec 2022 13:42:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231298AbiLEMmo (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 5 Dec 2022 07:42:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230385AbiLEMmm (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 5 Dec 2022 07:42:42 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A7405F56
        for <linux-pm@vger.kernel.org>; Mon,  5 Dec 2022 04:42:41 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id j5-20020a05600c410500b003cfa9c0ea76so9871019wmi.3
        for <linux-pm@vger.kernel.org>; Mon, 05 Dec 2022 04:42:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wBq0xf1ib+5rVsU/RG/zffg8sAypcSuxfGRRhzzRwog=;
        b=IQ+TxF85ix2dk31TwICOEahYelRxviIJs2I91vJQKzNosbIqkCBA3F1peo/glFipUN
         xTjv6j0c+3ELEKvdZNQcXYQ3g3OMkJoew81Z8gLjm8lIWDJ5Hcoi3haWOiUVWF17vw9N
         qI6t7Fp+QgTQSeXb8d+RgwPtAE1Thaxs0vTkVvGcbD/z7oK+ansLRFgO92N5NoRGvGna
         wl1AyzIz6e5YWub5udBTo+HnqYpm8rOYmcmcC7EOm8Qzig7G7g+2TxwrQZkhiyfYLRzx
         1pPg2/ROtVoKgjh6JvvFex9HSh0fcCAAHGqndRtq2pdJKXJa1LnSu7tuN9VE1MoECNkh
         MmTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wBq0xf1ib+5rVsU/RG/zffg8sAypcSuxfGRRhzzRwog=;
        b=3jSATWnyEgqvkeBbPo2bMCUjOq2qEUqr9rDGQcpoCWDmIOZXEHg2Zi5f5y6tQpRtmS
         HAe44hIa60cJaODf4m1dmFDm1WOs/CIuYeAiN/ZIsvxm0/M+TsqUWPyg2qzcgN+EPbmT
         lSJeB/fE6wR9N8+t4eSq2gA1tlh/hnQ/EcpR6C6EZxooLFRYeICEJ252hCGDSnYkGQl7
         E/Tcmx96Ov6vU7ipTB3qJXMO8xfDScEtZvRlONUPjipcWg1An/cbuT+m7Oc7OYIywT4/
         iKWD1o0D45FvlcsvLt/14la/RSV0lpNFeAUL97QqrJTOVTSxOte4U75fZ6zG1h1XTUyD
         GuCw==
X-Gm-Message-State: ANoB5pkZO57pEUcs3uBWipWNPuXMtpPwrWsKtg/LNJh3P4nbotAA4SKi
        fVwfDXbF7r/5ogIuZneEykE5ow==
X-Google-Smtp-Source: AA0mqf67Bcdu4x+N7rcLCItnV2vvyODsCAzYBgt0W9/YevLByMxiT7zcuwZvLU4ITpwtPup7R2Qa5w==
X-Received: by 2002:a05:600c:a3a2:b0:3cf:7267:5b40 with SMTP id hn34-20020a05600ca3a200b003cf72675b40mr60542237wmb.164.1670244159517;
        Mon, 05 Dec 2022 04:42:39 -0800 (PST)
Received: from [192.168.0.162] (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id c2-20020a05600c0a4200b003cfd4cf0761sm23298106wmq.1.2022.12.05.04.42.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Dec 2022 04:42:39 -0800 (PST)
Message-ID: <97651945-428e-c667-b7d8-7e627f900d05@linaro.org>
Date:   Mon, 5 Dec 2022 12:42:38 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v2 08/15] thermal/drivers/tsens: Drop single-cell code for
 msm8939
Content-Language: en-US
To:     Vincent Knecht <vincent.knecht@mailoo.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>
Cc:     linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, Shawn Guo <shawn.guo@linaro.org>,
        Stephan Gerhold <stephan@gerhold.net>
References: <20221204055909.1351895-1-dmitry.baryshkov@linaro.org>
 <20221204055909.1351895-9-dmitry.baryshkov@linaro.org>
 <2186df0393c6cf4dab88772aceed7202090f5a1d.camel@mailoo.org>
 <b0d37b049ebedd5e04f69d505afb36ab6f0a1492.camel@mailoo.org>
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <b0d37b049ebedd5e04f69d505afb36ab6f0a1492.camel@mailoo.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 04/12/2022 19:25, Vincent Knecht wrote:
> Le dimanche 04 décembre 2022 à 19:42 +0100, Vincent Knecht a écrit :
>> Le dimanche 04 décembre 2022 à 07:59 +0200, Dmitry Baryshkov a écrit :
>>> There is no dtsi file for msm8939 in the kernel sources. Drop the
>>> compatibility with unofficial dtsi and remove support for handling the
>>> single-cell calibration data on msm8939.
>>
>> Could one invoke a "msm8916-like exemption" here ?
> 
> Ignore that, guess we'll just have to implement it like there:
> https://lore.kernel.org/linux-arm-msm/20221204055909.1351895-9-dmitry.baryshkov@linaro.org/T/#m19cffb13114b6f4f153058e3e7a1943251acaf81
> 
>> Also, msm8939.dtsi was submitted once [1],
>> and if helps we could send a v2 this month...
>>
>> [1] https://lore.kernel.org/linux-arm-msm/20220419010903.3109514-1-bryan.odonoghue@linaro.org/
> 
> Offer still stands, the current community one is here:
> https://github.com/msm8916-mainline/linux/blob/msm8916/6.1-rc7/arch/arm64/boot/dts/qcom/msm8939.dtsi
> 
> 
> 

heh - here's my current

https://git.linaro.org/landing-teams/working/qualcomm/kernel.git/log/?h=tracking-qcomlt-msm8939

I've been working on clearing out blockages in legacy yaml conversions

phy
mdss-dsi-ctrl

which thrown up errors on 8939

I took a good bunch of feedback from the list for v1 into that dtsi - 
there's not much left blocking v2.

I'll see if I can get that out this week

---
bod


