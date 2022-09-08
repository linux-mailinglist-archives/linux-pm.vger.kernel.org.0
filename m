Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD5205B15A2
	for <lists+linux-pm@lfdr.de>; Thu,  8 Sep 2022 09:28:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230096AbiIHH2l (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 8 Sep 2022 03:28:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230009AbiIHH2e (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 8 Sep 2022 03:28:34 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6A14AC277
        for <linux-pm@vger.kernel.org>; Thu,  8 Sep 2022 00:28:32 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id x14so10918067lfu.10
        for <linux-pm@vger.kernel.org>; Thu, 08 Sep 2022 00:28:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=/zRU8A5zoUoera6+7kmx9n/i4jIslUbut0IRuDzdvno=;
        b=SkAAEinM04H9PtwZ1jj8CzoAqhQTTLn94foHWPoddRmeWSz3LGkamHEXOymO2VqH0X
         fl3NIuxXYFvv9LRbI7VnhjD2S32YGC7l5NKPKPop3wNgSMQAaphzCUEF+/EbISrWfkxY
         TIsO7nr+qloe3bTQgZVnZmYx8sGTn0/Fk74P4QOqAaozAIErcI/ri/6x9TDRzWpbmzX2
         tIlRUs+qYmGr/nFw0B3KJvb+BncgRP3BO/e3hDX5ccoP08kwOWl/1Rxv8bXBTWjvzktO
         unmC71LY1ec24YDw7ZSDvYiEkd5H8n7p51/YK62/XbpDFj6KmTGN5mOq5wzihZp0v635
         pYVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=/zRU8A5zoUoera6+7kmx9n/i4jIslUbut0IRuDzdvno=;
        b=kwna7uy1SoDMFZN2sm6utPPVuFOtpcqBysga6DVaij4YAgf5h6Onpb3bYgrgExuLD/
         j3cwUwEvEpXjGJAtSug89uAnl7VkEu68V4sFfTTRvD3CMCVAhkfUPSXS+alI7PZiMjQp
         EdkYce1hfcnCqqAtuLIu2bQmgEqll6+1l9ea1xNCxhvkt+sQmjyRHEHFO+oWkj4LjMqa
         R8p6xBkidvSQhGy+KSBD1nJs2sn/C+5JGLmkj0z7347qSNFhTejB7li/AZq8BvF2SmSU
         AlIaXf4m4sVzmqTI5hx0dRY8KAqSaaDq9XbwKdiyzo3pa8nyH/sy6X9XdITtzpkj2fcE
         Vlaw==
X-Gm-Message-State: ACgBeo0puD3vJKreM3fzjegpR0feUNzNzSA44mkRIBwr55fXIuBpnsUc
        3to8m2bFyrXoT8PjuDjGbGdatA==
X-Google-Smtp-Source: AA6agR4xJkIpSra4HQ47hmqX2ndsvUw8AiEud7UngRNoAhTtNTolU6lSMipCCm8VQHTaOwhjtqm3YQ==
X-Received: by 2002:a05:6512:139c:b0:48f:da64:d050 with SMTP id p28-20020a056512139c00b0048fda64d050mr2094541lfa.268.1662622111120;
        Thu, 08 Sep 2022 00:28:31 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id a9-20020a196609000000b004946274b7d6sm2914742lfc.166.2022.09.08.00.28.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Sep 2022 00:28:30 -0700 (PDT)
Message-ID: <219597ff-a409-e19c-b03f-86885d6825c8@linaro.org>
Date:   Thu, 8 Sep 2022 09:28:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH] dt-bindings: power: reset: restart-handler: add common
 schema
Content-Language: en-US
To:     =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali@kernel.org>
Cc:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220907123630.57383-1-krzysztof.kozlowski@linaro.org>
 <20220907163218.aja4pazw3sbxnoop@pali>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220907163218.aja4pazw3sbxnoop@pali>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 07/09/2022 18:32, Pali Rohár wrote:
> On Wednesday 07 September 2022 14:36:30 Krzysztof Kozlowski wrote:
>> Add common schema for restart and shutdown handlers, so they all use
>> same meaning of "priority" field.  The Linux drivers already have this
>> property and some systems want to customize it per-board in DTS.
>>
>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>>
>> ---
>>
>> See also:
>> https://lore.kernel.org/all/8fe93da3-f768-16ae-7025-1cfa97a42b27@linaro.org/
>> https://lore.kernel.org/all/20220831081715.14673-1-pali@kernel.org/
>> ---
>>  .../bindings/power/reset/gpio-restart.yaml    | 13 ++------
>>  .../bindings/power/reset/restart-handler.yaml | 30 +++++++++++++++++++
>>  2 files changed, 33 insertions(+), 10 deletions(-)
>>  create mode 100644 Documentation/devicetree/bindings/power/reset/restart-handler.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/power/reset/gpio-restart.yaml b/Documentation/devicetree/bindings/power/reset/gpio-restart.yaml
>> index a72d5c721516..d3d18e0f5db3 100644
>> --- a/Documentation/devicetree/bindings/power/reset/gpio-restart.yaml
>> +++ b/Documentation/devicetree/bindings/power/reset/gpio-restart.yaml
>> @@ -25,6 +25,9 @@ description: >
>>    inactive-delay, the GPIO is driven active again.  After a delay specified by wait-delay, the
>>    restart handler completes allowing other restart handlers to be attempted.
>>  
>> +allOf:
>> +  - $ref: restart-handler.yaml#
>> +
>>  properties:
>>    compatible:
>>      const: gpio-restart
>> @@ -41,16 +44,6 @@ properties:
>>        in its inactive state.
>>  
>>    priority:
>> -    $ref: /schemas/types.yaml#/definitions/uint32
>> -    description: |
>> -      A priority ranging from 0 to 255 (default 129) according to the following guidelines:
>> -
>> -        0:   Restart handler of last resort, with limited restart capabilities.
>> -        128: Default restart handler; use if no other restart handler is expected to be available,
>> -             and/or if restart functionality is sufficient to restart the entire system.
>> -        255: Highest priority restart handler, will preempt all other restart handlers.
>> -    minimum: 0
>> -    maximum: 255
>>      default: 129
>>  
>>    active-delay:
>> diff --git a/Documentation/devicetree/bindings/power/reset/restart-handler.yaml b/Documentation/devicetree/bindings/power/reset/restart-handler.yaml
>> new file mode 100644
>> index 000000000000..f5d22ca0cd45
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/power/reset/restart-handler.yaml
>> @@ -0,0 +1,30 @@
>> +# SPDX-License-Identifier: GPL-2.0-only or BSD-2-Clause
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/power/reset/restart-handler.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Restart and shutdown handler generic binding
>> +
>> +maintainers:
>> +  - Sebastian Reichel <sre@kernel.org>
>> +
>> +description:
>> +  Restart and shutdown handler device is responsible for powering off the
>> +  system, e.g. my cutting off the power.  System might have several restart
>> +  handlers, which usually are tried from most precise to last resort.
>> +
>> +properties:
>> +  priority:
>> +    $ref: /schemas/types.yaml#/definitions/uint32
> 
> IIRC priority is signed integer number, not unsigned.

Although technically in the kernel it is int, all existing kernel users
assign here unsigned number and existing bindings were unsigned int, so
I don't think there is benefit to change it to signed.

Best regards,
Krzysztof
