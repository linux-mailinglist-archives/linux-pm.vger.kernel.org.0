Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59131651EAE
	for <lists+linux-pm@lfdr.de>; Tue, 20 Dec 2022 11:22:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230235AbiLTKWJ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 20 Dec 2022 05:22:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233747AbiLTKWE (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 20 Dec 2022 05:22:04 -0500
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2768A9FC2
        for <linux-pm@vger.kernel.org>; Tue, 20 Dec 2022 02:22:03 -0800 (PST)
Received: by mail-lj1-x234.google.com with SMTP id b9so11952842ljr.5
        for <linux-pm@vger.kernel.org>; Tue, 20 Dec 2022 02:22:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Jxxu8mAn5D37rXv54OBicgE5WEKYbeNJX0Ra9K7kui0=;
        b=ZAOoVsOoxx0faw2zFkJBnZTmoSM1hESuATBy7sCXx4AgJvuxNTEbAYXk7wTBYhRe9Y
         cbXa52oSid0P8I14yCOd4ByFypCLcJV+r6nrMfbUEOvP1fom4XNFhQ1LjJTBJaw0F10D
         JQOIbPXiS+qAhlFx/4GEZchS2veQgpKU97++usk7nqmt/R9jkQTB9ZgT4DCnrblNxOJC
         qv8ENM03yQRHvPzcV1MK6g3hxFSBf8gXndy+D18vnt7p9boqtoXNBqS2P7VKlaw2eKVn
         kE57dtGR0ClgFzUUrAF08QHvSYKz0AKE3xdoLGlLGvORcWAXFy7OTF7nQbnVA74fkRo1
         /LsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Jxxu8mAn5D37rXv54OBicgE5WEKYbeNJX0Ra9K7kui0=;
        b=wZrfsPZqZjr0NmgkAOHyxiVx6BBEecqM6bMKc7Y5+72sXzHFGX+tdzM6yof35fODPJ
         ARv9+fUJXa45Ax6bRLWXgQ5z4aAHdwSTtpUu4puqkZuuzVPhDOWss/UBidaf4OWukEgI
         ujByfMTSlW3GP9a5Bp1+rmmGbPY2+mJ6w4hpGryK4AptxiGgoK87ZRxOid6TOrKZOpwR
         Ez49RSogiuTXBxr1SDKWdLlLd1tJyLCbFavM+66vMlI+FG93BjSvyNPi00m7+Z4YW/nD
         GUPuMoR5YBWYL7JiUFSh5Hyt+dQHDsZax638Vq6YUsJ4TtCuOYQLcnc+MGnl/v6/xIEa
         GzhA==
X-Gm-Message-State: AFqh2kpA7+jo2Rhaly5Ay4ge2t3GjCdwCxvYmE/l3XdV7p0vNBng2VLv
        d1p64PRJXTsnH3kJ1itoiFQwQtLJk2cuh4W0
X-Google-Smtp-Source: AMrXdXtfARpOOyYcE5O4K1e6ZvXUz7YxwwHF9LHz5ExiyxVTExjIFfFWs68zhgGEGrN5dY+Qp7QSFg==
X-Received: by 2002:a05:651c:44f:b0:27e:34cf:17b1 with SMTP id g15-20020a05651c044f00b0027e34cf17b1mr6036232ljg.29.1671531721517;
        Tue, 20 Dec 2022 02:22:01 -0800 (PST)
Received: from [192.168.1.101] (abxh212.neoplus.adsl.tpnet.pl. [83.9.1.212])
        by smtp.gmail.com with ESMTPSA id i25-20020a2ea379000000b0026e0434eb1esm944227ljn.67.2022.12.20.02.22.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Dec 2022 02:22:01 -0800 (PST)
Message-ID: <d0a6b9cb-f321-7d5b-5767-acd12cfd78f1@linaro.org>
Date:   Tue, 20 Dec 2022 11:21:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v3 08/15] thermal/drivers/tsens: Drop single-cell code for
 msm8939
Content-Language: en-US
To:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>
Cc:     linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, Shawn Guo <shawn.guo@linaro.org>
References: <20221220024721.947147-1-dmitry.baryshkov@linaro.org>
 <20221220024721.947147-9-dmitry.baryshkov@linaro.org>
 <78fd7174-9aa4-f067-72ca-514c8fb09ee5@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <78fd7174-9aa4-f067-72ca-514c8fb09ee5@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 20.12.2022 11:08, Bryan O'Donoghue wrote:
> On 20/12/2022 02:47, Dmitry Baryshkov wrote:
>> There is no dtsi file for msm8939 in the kernel sources. Drop the
>> compatibility with unofficial dtsi and remove support for handling the
>> single-cell calibration data on msm8939.
>>
>> Cc: Shawn Guo <shawn.guo@linaro.org>
>> Cc: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
>> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> 
> Maybe its a better idea to just - finally - get the 8939 dtsi upstream.
> 
> Is there anything that needs to change in this ? If not I'll just V2 in in the next few hours.
The point of this patchset is to remove logic like this, as it's
very repetetive and all it does is read fuses with a ton of magic
offsets. Dmitry pushes that to DT with the generic nvmem API, so
that instead of these magic &s and <<s, one is simply supposed to
define QFPROM fuses at the correct offset and with a matching bits=<>
property. This does not remove any functionality, it just changes
how the fuses are accessed and makes the code more generic.

Konrad
> 
> tsens: thermal-sensor@4a9000 {
>         compatible = "qcom,msm8939-tsens", "qcom,tsens-v0_1";
>          reg = <0x004a9000 0x1000>, /* TM */
>                <0x004a8000 0x1000>; /* SROT */
>          nvmem-cells = <&tsens_caldata>;
>          nvmem-cell-names = "calib";
>          #qcom,sensors = <10>;
>          interrupts = <GIC_SPI 184 IRQ_TYPE_LEVEL_HIGH>;
>          interrupt-names = "uplow";
>          #thermal-sensor-cells = <1>;
> };
> 
> https://git.linaro.org/people/bryan.odonoghue/kernel.git/commit/?h=linux-next-22-12-15-msm8939-no-cpr&id=146087a134306dfb6e1ec48b20b19a278f336b15
> 
> ---
> bod
