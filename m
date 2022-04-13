Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CDCE4FF6B2
	for <lists+linux-pm@lfdr.de>; Wed, 13 Apr 2022 14:25:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235493AbiDMM1a (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 13 Apr 2022 08:27:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235483AbiDMM13 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 13 Apr 2022 08:27:29 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FD7C5B3D7
        for <linux-pm@vger.kernel.org>; Wed, 13 Apr 2022 05:25:08 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id s18so3683755ejr.0
        for <linux-pm@vger.kernel.org>; Wed, 13 Apr 2022 05:25:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=IPvL+x9UQrwXvR+utNinpI9NAsoIPUuR7BzTYCnsPmc=;
        b=I6HtBB7uA/yx0vq72axTx9u/3uqWUB99OEtYm5nNLXwI17sSjJos+fifoXsLy57+yP
         U2KtYRXjs8SZyZrd18o5WhlGMNXFxtIHEtB/xgrqGaR5ByLqNRGLW/HENfnLQA9Jl7Vt
         bmjosDfmIT0dJiuKMt6iWAKp4XXe3SIeM5KosBgRqvOO9+HVaE60mjmO1qJHsF0vh6xQ
         VtKnlsgh4C7fu/UxA6Lp3YLM2Hx/mvxP8VK3vMK/Kb+Ow576CmJ8GesR/EQc+Ck0Hmft
         oLrpUOG8TAzDRXOE21VAtyJ7a6MR1YL15APvvYvfwfhUKYVC71LEK0TtuFpRvmS4wmCs
         kSng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=IPvL+x9UQrwXvR+utNinpI9NAsoIPUuR7BzTYCnsPmc=;
        b=sPgvsxlhFhH/vzB3OZQVlAXWi1DSndJ1AT7D2lXmyTpmzpXZgGT4reafgCGOUWQkqh
         2Zo4gibejbwWcYLaDkGeh/Yp5FAc8Ry5gyjCzQJ5U/4EuDvzdKQWUyqONEfBg09G8pYz
         /2m0aCrPx6L6iR7uH5NMgMv0HpipKKZ0KAV84VT2ntLKMq7ZpyJ6j66zrOhNU4Os7aoA
         E/+U7UYHwLtSUiF31LpqpEktWKdZFmeP0J9qnAqdqgki7EEXG26n55OHAEKAUtTMzU8L
         Muw/UMlPM2EpEerfXTaCa5OZxYsqbAzK19CWkW/nutSfdHHSVEp6SAOwByRqNsiUigO2
         U8gw==
X-Gm-Message-State: AOAM5308OIgkruD5tQYT5NDjq/zx0hFSq1pFPRdbiEQfO2H9HpmL0KcS
        OtJ2EEohoZXSw2u+uK1ZLMi6WQ==
X-Google-Smtp-Source: ABdhPJz31ZrmQcG0YyMsnYKKIybMJUwfMZzrUtJTz4S+3vdABkkqHUaU2YMflXKJ/VRzTNNjPk62NQ==
X-Received: by 2002:a17:906:3104:b0:6ce:6b85:ecc9 with SMTP id 4-20020a170906310400b006ce6b85ecc9mr37638157ejx.339.1649852706904;
        Wed, 13 Apr 2022 05:25:06 -0700 (PDT)
Received: from [192.168.0.204] (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.gmail.com with ESMTPSA id fu13-20020a170907b00d00b006e8ae97f91asm1987512ejc.64.2022.04.13.05.25.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Apr 2022 05:25:06 -0700 (PDT)
Message-ID: <a01f58d5-b42b-e870-1f10-4945d3b6fba6@linaro.org>
Date:   Wed, 13 Apr 2022 14:25:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v5 1/4] dt-bindings: thermal: k3-j72xx: Add VTM bindings
 documentation
Content-Language: en-US
To:     "J, KEERTHY" <j-keerthy@ti.com>, robh+dt@kernel.org,
        daniel.lezcano@linaro.org, rui.zhang@intel.com, amitk@kernel.org,
        kristo@kernel.org
Cc:     linux-pm@vger.kernel.org, vigneshr@ti.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220412101409.7980-1-j-keerthy@ti.com>
 <20220412101409.7980-2-j-keerthy@ti.com>
 <17474b72-d823-e1ff-9831-c5f9f887fccd@linaro.org>
 <54d597e9-5cad-fc44-954d-7de45018fdcf@ti.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <54d597e9-5cad-fc44-954d-7de45018fdcf@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 13/04/2022 14:04, J, KEERTHY wrote:
> Apologies. Some issues with my mailbox. Rob's response didn't reach me 
> for some reason.
> 
> I am now seeing them on the web: 
> https://lore.kernel.org/lkml/YY7HvCyJ90Ge8mr7@robh.at.kernel.org/
> 
> It wasn't deliberate to ignore comments. Apologies.
> 
> I will fix them in v6.

Sure :)


Best regards,
Krzysztof
