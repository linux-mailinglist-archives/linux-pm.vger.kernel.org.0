Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D108F73E0CE
	for <lists+linux-pm@lfdr.de>; Mon, 26 Jun 2023 15:37:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229900AbjFZNhj (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 26 Jun 2023 09:37:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229848AbjFZNhi (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 26 Jun 2023 09:37:38 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49EF5E7A
        for <linux-pm@vger.kernel.org>; Mon, 26 Jun 2023 06:37:36 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-4f8777caaa1so4390294e87.3
        for <linux-pm@vger.kernel.org>; Mon, 26 Jun 2023 06:37:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687786654; x=1690378654;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=b70tBBR+s8g2FHbpppaXz0s6vjnEtUV8jPD3BAkiQPw=;
        b=Ypgop4Hyx2XTkJeQ98hu4g0UYIXqXOYHp0u8VHuoYR8gEBs+OmDgQgcD2KALQ59jGB
         hmxPecHNRYlyNhSX6wjOKUurdZOByrQY1Ornx3wzjLs9RAj9xAlmzVbMRCubb3xkT6zB
         yM0ENGEmfwhzhRQiisjQU8On54q2E3Q7UddYTGOefFFZPq+zvKBtV7RP3hctLK3ZdaTc
         /di7vtNhhvZlYCIOPTd/m3nZbtvQBC4YIg4YRylgUXuRbrlocAyB10XtBMSpv+4ku9mt
         QZBw6x2pjgIf95A4Zp01dbRY9w5Mtsc1T4B29xUhZbGAHwTalwLglpt4pdiTULUTCtjA
         E/Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687786654; x=1690378654;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=b70tBBR+s8g2FHbpppaXz0s6vjnEtUV8jPD3BAkiQPw=;
        b=fUOgaOyz8du7YXfH9cALcp5nj01hu/MeSqfFJWO4mSE4rzgl8yMnrFSOC9OimvkA/q
         NNubHRC75HGKNCZO/mea8QDkX6tcb4zQr6PJ2J13wCtHBITTNDUeM/4th72fHutvu8xU
         MOoIu2xSYL48EOWTyTI0ev1H5L+xddmiUKBiGWiAvRLXp2+jDWDHcRUoFzGqmQcAALti
         Wr61E7dKsXCzYWKtqHM2kziymYVjnSQ1lNrIjPtpB+yUMFCpyXFdLl/Yr5IQmGKJaHQa
         0yPzZDFgfyqwslpqlofg4kiHpReV6ae6HCWJd2nloOKYFyWBJKii0Vi4untn90pxiwoI
         pzQg==
X-Gm-Message-State: AC+VfDwM/smSoeEqEok3IwQ5EosSRFbeDcnTkDyrUM1g4jXeYOuHi2N5
        izVtmTRU5pMzoSTwnpCuXlLs2g==
X-Google-Smtp-Source: ACHHUZ5QAMzrbfEKpDdFBklC58HqvaRJMzfo4fBLrlBMnQXzV4bt88s5RWJN7aPg6hsGLkpylGPK2A==
X-Received: by 2002:a19:5e48:0:b0:4f6:29cf:c0dd with SMTP id z8-20020a195e48000000b004f629cfc0ddmr15141802lfi.8.1687786654409;
        Mon, 26 Jun 2023 06:37:34 -0700 (PDT)
Received: from ?IPV6:2001:14ba:a0db:1f00::8a5? (dzdqv0yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a0db:1f00::8a5])
        by smtp.gmail.com with ESMTPSA id m9-20020a195209000000b004f86943d11fsm1105226lfb.49.2023.06.26.06.37.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Jun 2023 06:37:33 -0700 (PDT)
Message-ID: <363c3902-a91a-a3a1-b721-65c10ac88421@linaro.org>
Date:   Mon, 26 Jun 2023 16:37:33 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 04/26] dt-bindings: clock: qcom,krait-cc: Krait core
 clock controller
Content-Language: en-GB
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Ilia Lin <ilia.lin@kernel.org>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Georgi Djakov <djakov@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-clk@vger.kernel.org,
        Christian Marangi <ansuelsmth@gmail.com>,
        Stephan Gerhold <stephan@gerhold.net>
References: <20230625202547.174647-1-dmitry.baryshkov@linaro.org>
 <20230625202547.174647-5-dmitry.baryshkov@linaro.org>
 <40e70fff-88dc-683e-0016-1a24389b75b8@linaro.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <40e70fff-88dc-683e-0016-1a24389b75b8@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 26/06/2023 14:21, Konrad Dybcio wrote:
> On 25.06.2023 22:25, Dmitry Baryshkov wrote:
>> Define bindings for the Qualcomm Krait CPU and L2 clock controller. This
>> device is used on old Qualcomm SoCs (APQ8064, MSM8960) and supports up
>> to 4 core clocks and a separate L2 clock. Furthermore, L2 clock is
>> represented as the interconnect to facilitate L2 frequency scaling
>> together with scaling the CPU frequencies.
>>
>> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
>> ---
> Worth noting that there's no Krait cluster containing more than 4
> cores and the last SoC using this uarch was released 10y ago, so
> we can quite confidently say that the max cpu no won't change.

Yep. It it were new bindings, I'd probably use a different order: L2, 
then CPUs. But here I'm just documenting what is already done by the driver.

> 
> Konrad
>>   include/dt-bindings/clock/qcom,krait-cc.h | 17 +++++++++++++++++
>>   1 file changed, 17 insertions(+)
>>   create mode 100644 include/dt-bindings/clock/qcom,krait-cc.h
>>
>> diff --git a/include/dt-bindings/clock/qcom,krait-cc.h b/include/dt-bindings/clock/qcom,krait-cc.h
>> new file mode 100644
>> index 000000000000..ff69a0a968d8
>> --- /dev/null
>> +++ b/include/dt-bindings/clock/qcom,krait-cc.h
>> @@ -0,0 +1,17 @@
>> +/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
>> +/*
>> + * Copyright (C) 2023 Linaro Ltd. All rights reserved.
>> + */
>> +
>> +#ifndef __DT_BINDINGS_CLOCK_QCOM_KRAIT_CC_H
>> +#define __DT_BINDINGS_CLOCK_QCOM_KRAIT_CC_H
>> +
>> +#define KRAIT_CPU_0		0
>> +#define KRAIT_CPU_1		1
>> +#define KRAIT_CPU_2		2
>> +#define KRAIT_CPU_3		3
>> +#define KRAIT_L2		4
>> +
>> +#define KRAIT_NUM_CLOCKS	5
>> +
>> +#endif

-- 
With best wishes
Dmitry

