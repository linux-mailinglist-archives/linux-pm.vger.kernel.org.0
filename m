Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B01DC6A08F2
	for <lists+linux-pm@lfdr.de>; Thu, 23 Feb 2023 13:52:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234055AbjBWMwD (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 23 Feb 2023 07:52:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233844AbjBWMwA (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 23 Feb 2023 07:52:00 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A18743450
        for <linux-pm@vger.kernel.org>; Thu, 23 Feb 2023 04:51:58 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id r7so10434105wrz.6
        for <linux-pm@vger.kernel.org>; Thu, 23 Feb 2023 04:51:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=He3/T5rNjZxbvQvsLoh9SavvhiALDTplmrGhWdH6/2E=;
        b=alxxBCSG2sPNWiZwA17ja0FEz5b1RDxTTs4NGCFVIi8pqg9nexPHIGFFiVv19m7MF7
         9lQqxzBWsGQfoFuqnSSabuDcCcD9lLoEBQlTsTiTzzXMAhJwzI3msL3PxuEc4lX2LN7N
         PAUR1w6FHcB0gAgWqzWp+HhtdnvRT8MZq2jpz5WCzdFjfk2IAPyooUwKK4XswJVhkqMo
         YmIHqfHGLxCxaEf9bKUoaUZe74VVxinp9k1p0nQZyGUHYaZb2DAvdkDy4IcO9owSUaR0
         3o3gkdcYBcjVQvYgurSYyIazojzvlQ/gje1S+X7QFhPaWhuAI0wP7Yzp6C8UTFqkU/zu
         c4GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=He3/T5rNjZxbvQvsLoh9SavvhiALDTplmrGhWdH6/2E=;
        b=JOTKXaWZOUMbU+ohR4Nt88/mP/kgYb+t+j+iW869Z1staqsRZ5iYNunrnN65I19LUB
         9jsTGXrsb9NLfV7t6oa0vpXO8F7swCltlhiNrJfS318ldTWfQgrfoVmyWlmtAz0gv3yU
         l+FJckGsnCA3XzYUDCOlmTou9o1x0jsBdXgi67dn2KiO6xWpWy7ciSU4s8tcApAKPEsX
         qYJK5rvHkK4mTBFCz3UrFdHaFbHa9c3i7VimCWuJxZ0xPi3/OgnzwqLOh9t8/EuI0C5D
         b3QWNIa8b+Hq23W5cQkPQnEe6uQ0X/vLAPReTdcazUDGS2GCe16os2L+/wl2iblMVG9R
         sl3w==
X-Gm-Message-State: AO0yUKWRrLX7muKC4j31Mj/MePO5X4xMskUI3IYgzf6/xk9LUFzcSlD5
        KJlX5qafZm6RyXvVTwrz9t08UA==
X-Google-Smtp-Source: AK7set9ix212YSCnyGx56kbZG1wFRQMw0z+jnmOA6BkbGPbPtnvuzNhWX3F4lLDb03ZsXuDk0ySpaQ==
X-Received: by 2002:a05:6000:136a:b0:2c7:f56:28d9 with SMTP id q10-20020a056000136a00b002c70f5628d9mr2470997wrz.54.1677156716880;
        Thu, 23 Feb 2023 04:51:56 -0800 (PST)
Received: from [192.168.0.162] (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id v10-20020a05600c214a00b003e209186c07sm11194549wml.19.2023.02.23.04.51.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Feb 2023 04:51:56 -0800 (PST)
Message-ID: <f852bf35-6f29-a91a-00ab-9f7b2d709328@linaro.org>
Date:   Thu, 23 Feb 2023 12:51:55 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [PATCH v6 2/5] arm64: dts: qcom: Add msm8939 SoC
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>, agross@kernel.org,
        andersson@kernel.org, djakov@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        benl@squareup.com, shawn.guo@linaro.org, fabien.parent@linaro.org,
        leo.yan@linaro.org, dmitry.baryshkov@linaro.org,
        stephan@gerhold.net, Jun Nie <jun.nie@linaro.org>,
        James Willcox <jwillcox@squareup.com>,
        Joseph Gates <jgates@squareup.com>,
        Max Chen <mchen@squareup.com>, Zac Crosby <zac@squareup.com>,
        Vincent Knecht <vincent.knecht@mailoo.org>
References: <20230222120411.55197-1-bryan.odonoghue@linaro.org>
 <20230222120411.55197-3-bryan.odonoghue@linaro.org>
 <56ed6a30-9815-002f-8174-95e7e9fc0954@linaro.org>
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <56ed6a30-9815-002f-8174-95e7e9fc0954@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 22/02/2023 17:08, Konrad Dybcio wrote:
>> +			interrupt-names = "wdog", "fatal", "ready",
>> +					  "handover", "stop-ack";
> This should be a vertical list
> 
>> +
>> +			clocks = <&gcc GCC_MSS_CFG_AHB_CLK>,
>> +				 <&gcc GCC_MSS_Q6_BIMC_AXI_CLK>,
>> +				 <&gcc GCC_BOOT_ROM_AHB_CLK>,
>> +				 <&rpmcc RPM_SMD_XO_CLK_SRC>;
>> +			clock-names = "iface", "bus", "mem", "xo";
> This could also be one
> 

Sorry what are you asking for here Konrad

clock-names = "iface",
               "bus",

if so, why ?
