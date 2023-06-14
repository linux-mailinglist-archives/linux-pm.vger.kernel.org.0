Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBE13730561
	for <lists+linux-pm@lfdr.de>; Wed, 14 Jun 2023 18:47:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235961AbjFNQrm (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 14 Jun 2023 12:47:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236019AbjFNQrl (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 14 Jun 2023 12:47:41 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3F1E2137
        for <linux-pm@vger.kernel.org>; Wed, 14 Jun 2023 09:47:36 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-977d7bdde43so183308966b.0
        for <linux-pm@vger.kernel.org>; Wed, 14 Jun 2023 09:47:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686761255; x=1689353255;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bFMKvut80z3LPjg3ul3L/YWKHQQlwQuVA6bWWgKI7eY=;
        b=Sn71b6nVxOpGi354aFpLJDXlQ3qg3KLspi4mMLmOGR8ZVuCms4SspiBt0Bf82E6ErC
         9y75/PGKVgb8jnaTjDHJ0RyrOR9MfFD2zTmOwq487o/Tg2ooC5ZmEQxqtB804DXAfPuq
         4gVyTCK9+ZbG28CM2MTswuLwTGYaYL3W0jkKxMOvVKZrq2BQxHiqPSLw4rV/VMx9/SC8
         SQoYUFNE4AOa7Vr2pKeTv9cGzJJCdTgva1HVGMjJ5jz5Wx788T6kKYk5BXbqPauL5zsS
         NqUtDxw++mHqVY8pCpmy3Q8ronQbE7Hw+0thjd0zCqX4hYwLZxVejRtVlQNUiYSiRbvM
         SiZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686761255; x=1689353255;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bFMKvut80z3LPjg3ul3L/YWKHQQlwQuVA6bWWgKI7eY=;
        b=CszQgkv2AFX5Gh5mGxvTsjSJyM6sEAdOkDZjzWPhiOJpHTu1M7J85Uw03pduIdfaux
         CtY3uXfCQJjePIRpfex+vJZWM2pseEE/eBttfRy0PP0GUgqQW+adiHYK58+C5LKMOVrW
         1aSXznYSFLVvz7xEeVRA8LLrbe3WlQwWzV6i4UGrH9u0XHTeWwPxUpvyGZYL+KjsSRWy
         Zhpj/u7ESe6wIqen2G9KM/ud8GYkN+QP+ng1bAln6TrRFnwQYDFfNxonjqqf6nj77jp0
         50MY74u/dmeK/NyaZtXphZOADXcrnjGshKXXS4Vp0CrDeOKXL7JGbxfBH9ltCESBwS/o
         Eciw==
X-Gm-Message-State: AC+VfDw3xWwhD8EZTSaiACQ/1FDFaKfPC1iJG9hkNE1N+FchFYT2GzEC
        t5WxDkZ36eEqftl32XtwTsX6fA==
X-Google-Smtp-Source: ACHHUZ5p4watB2yyle/sZiiLlBZNpiXuBWTFI5uliY8Z9+IvrKJQhP8/SYyHhw8cLKxMyhhDtHkIWw==
X-Received: by 2002:a17:907:96a0:b0:978:af9d:c004 with SMTP id hd32-20020a17090796a000b00978af9dc004mr2495341ejc.4.1686761255472;
        Wed, 14 Jun 2023 09:47:35 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id rv14-20020a17090710ce00b00977c88d70c6sm8162554ejb.192.2023.06.14.09.47.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Jun 2023 09:47:35 -0700 (PDT)
Message-ID: <47cfe777-45b9-6303-1374-bc96803d26d4@linaro.org>
Date:   Wed, 14 Jun 2023 18:47:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v5 01/22] dt-bindings: interconnect: Add Qcom RPM ICC
 bindings
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Georgi Djakov <djakov@kernel.org>,
        Leo Yan <leo.yan@linaro.org>,
        Evan Green <evgreen@chromium.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20230526-topic-smd_icc-v5-0-eeaa09d0082e@linaro.org>
 <20230526-topic-smd_icc-v5-1-eeaa09d0082e@linaro.org>
 <c8573d08-d4e2-41a8-f0b1-e1d7a0c9ce17@linaro.org>
 <e7a083f6-e885-113b-bb6c-d20108777c5e@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <e7a083f6-e885-113b-bb6c-d20108777c5e@linaro.org>
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

On 14/06/2023 18:43, Konrad Dybcio wrote:
> On 14.06.2023 18:43, Krzysztof Kozlowski wrote:
>> On 14/06/2023 12:22, Konrad Dybcio wrote:
>>> The SMD RPM interconnect driver requires different icc tags to the
>>> RPMh driver. Add bindings to reflect that.
>>>
>>> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
>>> ---
>>>  include/dt-bindings/interconnect/qcom,rpm-icc.h | 13 +++++++++++++
>>>  1 file changed, 13 insertions(+)
>>>
>>> diff --git a/include/dt-bindings/interconnect/qcom,rpm-icc.h b/include/dt-bindings/interconnect/qcom,rpm-icc.h
>>> new file mode 100644
>>> index 000000000000..2cd56f91e5c5
>>> --- /dev/null
>>> +++ b/include/dt-bindings/interconnect/qcom,rpm-icc.h
>>> @@ -0,0 +1,13 @@
>>> +/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
>>> +/*
>>> + * Copyright (c) 2023, Linaro Limited
>>> + */
>>> +
>>> +#ifndef __DT_BINDINGS_INTERCONNECT_QCOM_RPM_ICC_H
>>> +#define __DT_BINDINGS_INTERCONNECT_QCOM_RPM_ICC_H
>>> +
>>> +#define RPM_ACTIVE_TAG		(1 << 0)
>>> +#define RPM_SLEEP_TAG		(1 << 1)
>>> +#define RPM_ALWAYS_TAG		(RPM_ACTIVE_TAG | RPM_SLEEP_TAG)
>>
>> Where are these used? I don't see any DTS in your patchset. Did you send
>> it separately?
> In the driver for now, e.g. patch 19. DTS can only come after the
> driver is fixed or things will explode!

You reference it in patch 19, but I still do not see the constants being
used.

Best regards,
Krzysztof

