Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 026E5662517
	for <lists+linux-pm@lfdr.de>; Mon,  9 Jan 2023 13:09:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237152AbjAIMJ0 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 9 Jan 2023 07:09:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237192AbjAIMJR (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 9 Jan 2023 07:09:17 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2E431AA07
        for <linux-pm@vger.kernel.org>; Mon,  9 Jan 2023 04:09:15 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id ay12-20020a05600c1e0c00b003d9ea12bafcso3424976wmb.3
        for <linux-pm@vger.kernel.org>; Mon, 09 Jan 2023 04:09:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ubIY8cqTTMrHzwn/rOzLM8k5TET4fQZpHUbYsaKwgy4=;
        b=FgsMJhHKOSgY0WEucP/bhTU/fz9+EwejuuO2nyThYEeyIvXxWUIc5SnCZJCxtITZpj
         oiPGvLhzFlYlC5LXOd58puBIa/D6DHjzrt/6qYuFW0Wc1vpWHnv4qVzMdOb+uvTRndL/
         JupNIpF7Xe6CSkMH9c70oYhM/fp+Ac1FXdh1ZEl+KISUDqC3Qxvi2df9Ds2jg+Mn8j22
         HceNXde4+BNjIyxuwyWe9GFiib7xYNlyMNzH674iGSdwfqrNSSVhmSZ/8wk3YjEEjkyA
         OoDWnNcHMJ0SyAgmBl1uYpIXq4oBz+umcMQzbpnCVnIEMhp+Lo1RXTOLH+rbHwzayj3G
         tqxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ubIY8cqTTMrHzwn/rOzLM8k5TET4fQZpHUbYsaKwgy4=;
        b=4X5bCXuI/SoyQ/T4guwEmCAgsaDktnu9RObwodX2XmYUMDklxKPiS2gkq0iVRYzk1G
         6agtZjs30dkQz+jg6P7x2NZYg89cxAgmHheTZ9bYg01qZFByatYc2PbuTumckNnkrHH9
         NOzJ15e9uGlSv01gR31/OceErlFwE6Ow2SKHHqUKe34T/1kD3iZgWHGbp8uGma5KjxvC
         9Bm1tbWzg/X7BxVO05IWScl719ycnAIs6RBIpNRHpzcsffQFEfo3uRrQYKowTEnA87x/
         2eHGt2C8P+cTzgRHmV/tPP8uAJ7gI4FBk38fAmZFv9ffBQelYMueYMmP3sYjOPUosC4f
         jRlw==
X-Gm-Message-State: AFqh2krzYQV/JJpLxk8aHBHSCE2Yqd+3gob+94qWzjnMFlrDy5jaORVJ
        jI9hPnUkKIhoVhVkETsIwPrK5Tt3qQuiN85K
X-Google-Smtp-Source: AMrXdXvnKhQdJ9Rk4Ynk4IPzWl/jCBNq3OCF0U6dM9pe93RXcnG36DqnUMj1l+vrKe7LQwpHbfP5QQ==
X-Received: by 2002:a05:600c:c06:b0:3d9:7065:5b9c with SMTP id fm6-20020a05600c0c0600b003d970655b9cmr41042585wmb.6.1673266154409;
        Mon, 09 Jan 2023 04:09:14 -0800 (PST)
Received: from [192.168.7.111] (679773502.box.freepro.com. [212.114.21.58])
        by smtp.gmail.com with ESMTPSA id m7-20020a05600c3b0700b003cfd4cf0761sm17559387wms.1.2023.01.09.04.09.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Jan 2023 04:09:14 -0800 (PST)
Message-ID: <c64360d4-6d7a-2581-7d35-8bea295320c7@linaro.org>
Date:   Mon, 9 Jan 2023 13:09:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
From:   neil.armstrong@linaro.org
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v2] dt-bindings: interconnect: qcom-bwmon: document SM8550
 compatibles
Content-Language: en-US
To:     Georgi Djakov <djakov@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>
Cc:     devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-kernel@vger.kernel.org
References: <20221114-narmstrong-sm8550-upstream-bwmon-v2-0-20c555e3ba5d@linaro.org>
 <655f4a05-5fed-7481-1d00-a6a4faf4c6d8@linaro.org>
 <65880fc7-0b2e-befa-f024-558e97ee5a91@kernel.org>
Organization: Linaro Developer Services
In-Reply-To: <65880fc7-0b2e-befa-f024-558e97ee5a91@kernel.org>
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

On 09/01/2023 12:18, Georgi Djakov wrote:
> Hi Neil,
> 
> On 9.01.23 12:09, Neil Armstrong wrote:
>> Hi Georgi,
>>
>> On 18/11/2022 09:29, Neil Armstrong wrote:
>>> Document the compatibles used to describe the Bandwidth Monitors
>>> present on the SM8550 platform.
>>>
>>> A BWMON v4 IP monitors the CPU bandwidth, and a v5 does the LLCC
>>> bandwidth monitoring.
>>>
>>> This is described by adding "llcc" and "cpu" into the compatible
>>> strings to differentiate the BWMON IPs.
>>>
>>> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
>>> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>>> ---
>>> To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>>> To: Andy Gross <agross@kernel.org>
>>> To: Bjorn Andersson <andersson@kernel.org>
>>> To: Konrad Dybcio <konrad.dybcio@somainline.org>
>>> To: Georgi Djakov <djakov@kernel.org>
>>> To: Rob Herring <robh+dt@kernel.org>
>>> Cc: linux-arm-msm@vger.kernel.org
>>> Cc: linux-pm@vger.kernel.org
>>> Cc: devicetree@vger.kernel.org
>>> Cc: linux-kernel@vger.kernel.org
>>> ---
>>> Changes in v2:
>>> - Reworded commit message
>>> - Added Reviewed-by from Krzysztof
>>> - Link to v1: https://lore.kernel.org/r/20221114-narmstrong-sm8550-upstream-bwmon-v1-0-b6dd08927f35@linaro.org
>>> ---
>>>   .../devicetree/bindings/interconnect/qcom,msm8998-bwmon.yaml         | 5 +++++
>>>   1 file changed, 5 insertions(+)
>>>
>>
>> <snip>
>>
>>
>> Gentle ping,
> 
> Thanks for the patch! Could you please rebase and resend?

Sure

Thanks,
Neil

> 
> BR,
> Georgi

