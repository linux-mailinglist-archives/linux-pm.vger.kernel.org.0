Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B6634A043F
	for <lists+linux-pm@lfdr.de>; Sat, 29 Jan 2022 00:30:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351115AbiA1XaH (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 28 Jan 2022 18:30:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349754AbiA1XaF (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 28 Jan 2022 18:30:05 -0500
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93618C061714
        for <linux-pm@vger.kernel.org>; Fri, 28 Jan 2022 15:30:05 -0800 (PST)
Received: by mail-qk1-x72a.google.com with SMTP id 71so7017042qkf.4
        for <linux-pm@vger.kernel.org>; Fri, 28 Jan 2022 15:30:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language
         :from:to:cc:references:in-reply-to:content-transfer-encoding;
        bh=nsBX3QJ2ghJeOq/9+uY7jBjzqsh2dD9tjPcTxYYCvdU=;
        b=wsYazgCIyCBLEVDL/L65FKcl/DWJR5FL3BbfHngOPkjI6aiOoYh+YsQ0PcDav1gU8J
         PJaSpMtBkSMfDDPzGwsr3kVfKk06UTXMpjCDV9gaKHZ68knYMxWUXRevF/JHjjkTpivg
         VmcbEwobilXqVfC8VGLxhMBXFC3SI6T9SaMB+iffyrBnl+GsGNMpb4uruhMlc6uy5Fc7
         +ESP818i7w88Lgq49WzT4uxImEmmiSSFvaLOW7ZTEKYmv1irFdxSdUdPWpKjQeWp5WX1
         QfMCcK8ArKyZylmhs4C8SPVHmjphBN+svNqhbjhVu5Or93aP0lNWXYMPs8WqTk0ceAUv
         lIAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:from:to:cc:references:in-reply-to
         :content-transfer-encoding;
        bh=nsBX3QJ2ghJeOq/9+uY7jBjzqsh2dD9tjPcTxYYCvdU=;
        b=4lZbUv8a4YuEw7qzATdgMNdAbpey/Nmy+A4eatsMJOeyl6GSsRqHpPF47sgq3rFBQL
         YNlyNouWjXZUC9Pe0wkt+X6dVG/xL1c5ASipKpC6hCSY4Z6ye3Dm3Cjn1i8Hx3iwRemL
         3yN5bW8WvMo7EtXJmQLHVdrsLR7mOaE3+5qjqq5t98xdJLPUJmhNMY71YdfM6uCZ++Kq
         RnGlSeToRporPvGdiKCugnKP/QjpNvVG2xOhvaB/SSLbwPfOccF3y6FZuG3FxHZiBNBL
         E8kmV92woFafCpon9tvMPRC2OvTxMp5AQiLGU3b6YaY185rPre7Oc7rQlSOobgRtfXf6
         +P7g==
X-Gm-Message-State: AOAM530beiRSsssB32l7ekejy0Xrn164+HOR6vbkViU20qVZHO0JzQrL
        prxlR9zSWbfARxqiRG0xqDbPHA==
X-Google-Smtp-Source: ABdhPJycCPLtV/K7Ijdx2dTaRSgLBL3CU7OwjgisYBfJahjabpg2pqH2pPvT045hxRNm5FGQA170gg==
X-Received: by 2002:a37:6493:: with SMTP id y141mr7272611qkb.180.1643412604776;
        Fri, 28 Jan 2022 15:30:04 -0800 (PST)
Received: from [192.168.0.162] (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id t11sm1719294qkp.54.2022.01.28.15.30.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Jan 2022 15:30:04 -0800 (PST)
Message-ID: <2acd53d0-c14e-a149-0708-d8ee4f33d15d@linaro.org>
Date:   Fri, 28 Jan 2022 23:30:02 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.1
Subject: Re: [PATCH 2/3] interconnect: qcom: msm8939: Merge snoc and snoc_mm
 into one
Content-Language: en-US
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     djakov@kernel.org, bjorn.andersson@linaro.org, agross@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        jun.nie@linaro.org, shawn.guo@linaro.org, benl@squareup.com
References: <20220128161002.2308563-1-bryan.odonoghue@linaro.org>
 <20220128161002.2308563-3-bryan.odonoghue@linaro.org>
 <CAA8EJpqvDqTH3+ATsdC2pwtfT-OWpLNSUgOPmeU_Tpu8Uqa1+g@mail.gmail.com>
 <251a8515-7f8d-2535-e222-17443266f275@linaro.org>
In-Reply-To: <251a8515-7f8d-2535-e222-17443266f275@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 28/01/2022 23:23, Bryan O'Donoghue wrote:
> On 28/01/2022 22:24, Dmitry Baryshkov wrote:
>> This would lead to higher frequencies being set on both 'normal' and
>> mm snoc clocks, thus (possibly) increasing power consumption.
>>
> How so ?
> 
> There are four clocks
> 
> bus
> bus_a
> bus_mm
> bus_a_mm
> 
> The last two clocks
> 
> SNOC performance points are
> 0 | 19.2  | XO
> 1 | 50    | GPLL0
> 2 | 100   | GPLL0
> 3 | 133.3 | GPLL0
> 4 | 160   | GPLL0
> 5 | 200   | GPLL0
> 6 | 266.6 | GPLL0
> 
> SNOC_MM performance points are
> 0 | 19.2  | XO
> 1 | 50    | GPLL0
> 2 | 100   | GPLL0
> 3 | 133.3 | GPLL0
> 4 | 160   | GPLL0
> 5 | 200   | GPLL0
> 6 | 266.6 | GPLL0
> 7 | 320   | GPLL0
> 8 | 400   | GPLL0
> 
> Its GPLL0 being set, the snoc_mm clocks really just map back to GPLL0

So taking an example

If venus
interconnects = <&snoc_mm MASTER_VIDEO_P0 &bimc SLAVE_EBI_CH0>;

or mdp
interconnects = <&snoc_mm MASTER_MDP_PORT0 &bimc SLAVE_EBI_CH0>,
                 <&snoc_mm MASTER_MDP_PORT1 &bimc SLAVE_EBI_CH0>;

wants performance point #6 GPLL0 runs at 266.6 but for performance point 
#7 it runs at 320 MHz

Since the points all map back to a GPLL0 frequency, how does aggregating 
snoc and snoc_mm - result in higher power consumption ?
