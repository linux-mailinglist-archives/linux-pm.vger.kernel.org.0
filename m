Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1290A737E5A
	for <lists+linux-pm@lfdr.de>; Wed, 21 Jun 2023 11:17:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231712AbjFUIvh (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 21 Jun 2023 04:51:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231680AbjFUIvg (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 21 Jun 2023 04:51:36 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 645751985
        for <linux-pm@vger.kernel.org>; Wed, 21 Jun 2023 01:51:34 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-982a0232bdcso872871866b.1
        for <linux-pm@vger.kernel.org>; Wed, 21 Jun 2023 01:51:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687337493; x=1689929493;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+VbF1k9dd0zR8M+O8v5QVhhHeg+UsKC97YqfD/3djKw=;
        b=W9VaK97xEUvQskcBtLs7tk+n04BFDJpXeUjX+cYAr5LnylC9aKil7zVrTudDVqQP9E
         QZrci0JsHWuz9APMU8guZZAB5tmazOoxXVYsUjZo+f98KuL53kagG+a65Xs7VosLrg9u
         DwJJCrqzh+8A5HeC5WzQ03Y7Pnn90Una0/AfV5usJcXGEJs0/xvQnL9XP6TS0uBi9hr/
         cpNj9UCp/sl9VqaN54jRvpz1X/faOwY+99aaSqpKrWqNib3tmRQU1tUMvoIQU3pBYF2V
         sFnxtV3SKWcLg2EUPXj7T6C5nH3MFV7Hhk7dnSgDW0Fy25RSnqbcFvcNqQIr9Z0Qv0HP
         s7gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687337493; x=1689929493;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+VbF1k9dd0zR8M+O8v5QVhhHeg+UsKC97YqfD/3djKw=;
        b=kGYRhcPccyjGBTC/B2YlVRxHkT3t9CjReu1OllruU4fAdhADf7bfVJ6Wwa/dWs18+O
         0CsGOwg2q96/dvoBk2kxiFQl7y6RxjXi0RX/nNydvozTYVt9GOUwiH+CFPagbX+blRUE
         J6NZ/JySknLCEPF+oXP2im8RH78K5OiHtaxHLLQVU7sJ33E/gMYOTukBKUvX7SNvVJpW
         AaNdaj8RNRnjl4On0xDZmZ21GLhaGmjK6/ceFoBJ43s9kC0v/HHvHF1VnCvfmOMV/uyN
         1IVgoseFR1pW4uGzZM0meGiVkEKi9qXix1uxw5mF4hHNrc+ruGzbM5p7Zwra6qwu/AiW
         0uSA==
X-Gm-Message-State: AC+VfDy5aQHXfYTVpCMII4P6u0K1G9P9Csfa2SlWUTzWt2/zhzGPP7H5
        toUM1Bhq+RA+17+VAvNN9bdDbA==
X-Google-Smtp-Source: ACHHUZ6Enbd+GNv/reZhivVW7l625b/Sh8RzonsXjZQhvpGhNFDvv98VDEanD/um4iUr3kXswgQAmg==
X-Received: by 2002:a17:907:2688:b0:988:4a48:6ff3 with SMTP id bn8-20020a170907268800b009884a486ff3mr9771237ejc.30.1687337492837;
        Wed, 21 Jun 2023 01:51:32 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id a22-20020a1709063a5600b00988e699d07fsm2746507ejf.112.2023.06.21.01.51.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Jun 2023 01:51:32 -0700 (PDT)
Message-ID: <2156ae79-e092-656c-c357-09807f622474@linaro.org>
Date:   Wed, 21 Jun 2023 10:51:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 01/18] dt-bindings: opp: opp-v2-kryo-cpu: support Qualcomm
 Krait SoCs
Content-Language: en-US
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Ilia Lin <ilia.lin@kernel.org>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-clk@vger.kernel.org,
        Christian Marangi <ansuelsmth@gmail.com>
References: <20230612053922.3284394-1-dmitry.baryshkov@linaro.org>
 <20230612053922.3284394-2-dmitry.baryshkov@linaro.org>
 <5c750c6a-a0f8-c6f7-64fe-716da434d819@linaro.org>
 <678a3750-0a89-aedf-b5cf-e68da003f4a0@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <678a3750-0a89-aedf-b5cf-e68da003f4a0@linaro.org>
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

On 14/06/2023 22:11, Dmitry Baryshkov wrote:

>> Why?
>>
>>> +        $ref: /schemas/types.yaml#/definitions/uint32
>>
>> You are changing the type. No. It should be fixed instead (enum applies
>> to items).
> 
> Currenlty this bindings are only usable for msm8996/msm8996pro. As such 
> we listed opp-supported-hw values that are applicable to this platform. 
> This series adds support for apq8064 platform, which will add new items 
> to this enum. I think it is not very sensible to list all of them here.

Sure, but this is uint32-matrix, so don't change the type to something else.

> 
> However granted there is already a good enough base type definition, I 
> think it would be better to drop the $ref, drop the enum, add ': true' 
> (is it necessary if we have a description already?) and expand 
> documentation.

Probably this should be constrained to only one value with:
  items:
    - items:
       - description: foo bar




Best regards,
Krzysztof

