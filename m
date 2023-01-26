Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6ACEC67D1AB
	for <lists+linux-pm@lfdr.de>; Thu, 26 Jan 2023 17:32:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230324AbjAZQcY (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 26 Jan 2023 11:32:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230046AbjAZQcX (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 26 Jan 2023 11:32:23 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E96902068C
        for <linux-pm@vger.kernel.org>; Thu, 26 Jan 2023 08:32:19 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id l8so1514861wms.3
        for <linux-pm@vger.kernel.org>; Thu, 26 Jan 2023 08:32:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ht6SLMPOXpO5uQjEKRBlkeAFxtNjyW1ofM/NJzMtXes=;
        b=bQUKqFOePcwq2+andSurp3CyehEw/rCw1c3LYc7LOeoXkGX1+8eWEqskfuK06Ku9cq
         latkyqL/y3AVFaLVtFzWf55vMnVx49WLM+I434CoMoggsC+6nhlEbJlDvxA5cqTLydzh
         z8WIoAAvZG9n8B1FVbRtm0sNn9f2fdvXLUYKLtWXs/ZOOtIKyc5SC6bu1A6UOcUSYvg4
         9VWuqka7d9K/wf0135wn6kZNLCeevbDgrDzryTjmByxjiT6xz/bNsXaaj2+rALWez4WN
         pweX25STJgKwGIgMxDuqt6TXvs1CjXV+EF5KXICf1sIYgPvu88lCdQrJjhjLde21oxmX
         76Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ht6SLMPOXpO5uQjEKRBlkeAFxtNjyW1ofM/NJzMtXes=;
        b=ozAN4MT11IiSyjgYZ7dLmiaXt/usQkqY/wMxHTjW5fTZUF2nJwHp2xRwvTjbQsXjvX
         zfmT0+xbKFU/J23/DQp2QTc/EBY5Zo/wwrND8LrBqLbDtO7iwNlM0krr3wmMk8npEhUL
         eAEvIgeTYoJ/fE9xhIp12qM7BZ6OG7xUXWPv1Duys2gAvRXOaY2UFdTILA5cuHG6D5WW
         kJDnn99Gy6sVuI2I0N7aiC58qm4tE+EKLAZN17LRNUiTIPMU+SUH+vP325oWUV+Vn/NG
         FMBgEnP5Cp6c3JWEr9VeeIJLmJ8nyKlKeS0Rp6tg6njSgBwn3bNcDEhWV0KnTSpBO7x1
         pOdg==
X-Gm-Message-State: AFqh2kpYxAHAM6D6WO5x5axuU9GOw5y7wTvrXqJB+L73uVKYIk9pBPnj
        SGrbhzjN4u4qC9Gmfp3sWHlsKQ==
X-Google-Smtp-Source: AMrXdXueF3WB3UYX7Y62NPQUcdVtJfLtkKm2OG2DuDdwF6CXMCUWMJCTRgiP0i0grNrhL7mpvJ2Hhg==
X-Received: by 2002:a05:600c:c10:b0:3da:f5e6:a320 with SMTP id fm16-20020a05600c0c1000b003daf5e6a320mr40747301wmb.22.1674750738488;
        Thu, 26 Jan 2023 08:32:18 -0800 (PST)
Received: from [192.168.0.162] (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id ip6-20020a05600ca68600b003d04e4ed873sm5027940wmb.22.2023.01.26.08.32.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Jan 2023 08:32:18 -0800 (PST)
Message-ID: <b7343ea6-7194-e709-8fed-4a1a17f7beb5@linaro.org>
Date:   Thu, 26 Jan 2023 16:32:17 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v4 0/6] Add MSM8939 SoC support with two devices
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Stephan Gerhold <stephan@gerhold.net>
Cc:     agross@kernel.org, andersson@kernel.org, djakov@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        benl@squareup.com, shawn.guo@linaro.org, fabien.parent@linaro.org,
        leo.yan@linaro.org, dmitry.baryshkov@linaro.org
References: <20230123023127.1186619-1-bryan.odonoghue@linaro.org>
 <42baa874-c926-9111-b0b3-2df2562d8de6@linaro.org>
 <Y86CPmgvAi+kChQI@gerhold.net>
 <87192098-b7f4-060f-9274-933d974c0a7d@linaro.org>
 <df4c76eb-aec7-823e-28f9-5ba96cc200c6@linaro.org>
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <df4c76eb-aec7-823e-28f9-5ba96cc200c6@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 26/01/2023 15:34, Konrad Dybcio wrote:
>>> To me this looks like a confirmation of what downstream does, that both
>>> DSI byte clocks are actually sourced from the dsi0_phy and the PLL of
>> A better name would have been dsiX_phy_pll_out_byteclk.
> I believe Stephan is just confused what the clock source of both
> pairs of GCC DSI clocks are, as you're suggesting that:
> 
> phy_clock0
>    |_gcc_clock0
> 
> and
> 
> phy_clock0 (yes, zero)
>    |_gcc_clock1
> 
> whereas on most other SoCs the following is true:
> 
> phy_clock0
>    |_gcc_clock0
> 
> phy_clock1
>    |_gcc_clock_1
> 
> Konrad

The only input clock to GCC is XO or buffered CXO if routed through the 
PMIC.

You can select via GCC::RCGR where dsiX_phy_pll_out_byteclk is *sourced* 
from XO, GPLL0_AUX or P_DSI0_PHYPLL_BYTE.

So, obvs the byte clock can be any one of those input sources.

But the question is, if you select dsi0_phy_pll_out_byteclk - what 
provides it ?

Reviewing the LK bootloader for 3.18, it *looks* to me like the dsi0 pll 
is always switched on. The downstream kernel tree doesn't represent that.

0x01A9811C MDSS_DSI_0_CLK_CTRL
Type: RW
Reset State: 0x00000000 -> BIT(4) -> Turns on/off BYTECLK for the DSI. 
If set to 1, clock is ON.

Hmm. I think actually it must be the case that DSI1 is a slave of DSI0.

You can have both interfaces running or just DSI0 on its own.

Hmm, I'll change it.

---
bod
