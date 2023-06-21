Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C212738B59
	for <lists+linux-pm@lfdr.de>; Wed, 21 Jun 2023 18:33:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232694AbjFUQdi (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 21 Jun 2023 12:33:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232606AbjFUQdW (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 21 Jun 2023 12:33:22 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC8A42683
        for <linux-pm@vger.kernel.org>; Wed, 21 Jun 2023 09:33:01 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-3f8ff5fe50aso41878275e9.0
        for <linux-pm@vger.kernel.org>; Wed, 21 Jun 2023 09:33:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687365176; x=1689957176;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HLGr90Ct6YiiWYZK3C/9ohPmOziEp9WBnHBSoxvZVKg=;
        b=CdOcoVkfqUF7yQFTakDIkkGOhpaulKgfWZ9V+c0O0STLC3VXDnnY/fsTI1UbU3oLwR
         YxIFdJ1cmh2qnq9KgzpxEXcmTwDBNmJy/wq/35qxLUGbHc+331EwP5AcT+ptSmjlAPvy
         dGWBDIZHyCECOH2s5r6UzmVvhVB+0K4TXmjdP3jJxPEqu59z6eg3IcLAj39EbG7eau1L
         Fn7wTPrNmIHb2cq8djegYjzjxw0VOgcOiNruftBF1eeXF+1YtvAS4l05B5vPK3UW+ZoM
         rZT0g+tLtSHcu6T7ru/lSwPlxvIXjPScVxO23osmrJHETsTLCopV30woDua/MshQNBwS
         7uTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687365176; x=1689957176;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HLGr90Ct6YiiWYZK3C/9ohPmOziEp9WBnHBSoxvZVKg=;
        b=RFCpW840ZwAX/CdsDoNW75w6bGEEzEkq0ixqxS1RQ/HVfuZS3lFfETyiL9wFoELKwl
         i9ppR/93zUvZ77RO2usJM50eg7xLK5+46pjm+2/Xw0dm1UZngWyJY10aFw8cDYxByVpU
         YoYiIiQzhCRawHK7atu6P/nyZ6C7h9Sxc8EaQ5/LluUJTRiFP+twmQc17q0MB7BfRhKW
         KspIEQXH6aEvi7mW9DDaI3EGx7FTwF96naImHzIlSCeW5JwI1d3bBgjLph255JavdnLY
         x1M7xrSwq0jg5ePaWVZ6+5LfmPCwTjZ30BsvvFZ1I5BRy4qoTLjee0GXl90G6UBozURj
         Bihg==
X-Gm-Message-State: AC+VfDwixBnuhwb/O7nt5hA6vAdPlApR2Mgu5qbLMrkqb1VWCuVLDg5X
        I2wpbazcl/eVuFVlkqiGDgghTQ==
X-Google-Smtp-Source: ACHHUZ7xXM1RwY58kyvXjTjJcIvjnaCnAMjZVA66OVbtjFywGkQrMDgpxkkyuFFk/+F5RpQxRl5/WA==
X-Received: by 2002:a05:600c:230c:b0:3f8:f1db:d1f5 with SMTP id 12-20020a05600c230c00b003f8f1dbd1f5mr14997447wmo.5.1687365175902;
        Wed, 21 Jun 2023 09:32:55 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id a21-20020a05600c225500b003f7f4dc6d14sm5405348wmm.14.2023.06.21.09.32.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Jun 2023 09:32:55 -0700 (PDT)
Message-ID: <e6ae26d6-dec4-d9c2-0d9e-31e80c8d58f5@linaro.org>
Date:   Wed, 21 Jun 2023 18:32:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 1/3] dt-bindings: vendor-prefixes: Add Mitsumi Electric
 Co., Ltd.
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Sebastian Reichel <sre@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
References: <20230621-topic-mm8013-v1-0-4407c6260053@linaro.org>
 <20230621-topic-mm8013-v1-1-4407c6260053@linaro.org>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230621-topic-mm8013-v1-1-4407c6260053@linaro.org>
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

On 21/06/2023 17:39, Konrad Dybcio wrote:
> Mitsumi was [1] a Japanese company making various electronics devices
> and components. They've merged into a new entity, MinebeaMitsumi in 2017.
> 
> Their current main page is available at [2]
> 
> [1] https://en.wikipedia.org/wiki/Mitsumi_Electric


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

