Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 589C578DA58
	for <lists+linux-pm@lfdr.de>; Wed, 30 Aug 2023 20:37:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233576AbjH3SgH (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 30 Aug 2023 14:36:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244381AbjH3NHH (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 30 Aug 2023 09:07:07 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CB4B185
        for <linux-pm@vger.kernel.org>; Wed, 30 Aug 2023 06:07:02 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-9a21b6d105cso716935666b.3
        for <linux-pm@vger.kernel.org>; Wed, 30 Aug 2023 06:07:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693400820; x=1694005620; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hDC9ESUef36Mte2IBID4F1U1QCc8COjSUPt3loc3xqg=;
        b=c5cymgYTEbaJ6XaRn4Cx18yAW2AnOYtaQXhcTkPWtZUs1LCpJM/sHTO349WcCAxQbJ
         Oz6MofGG6ypJI/c7J5GYdtb3sbHC/S8KVFAusUg8lgxChD98pvD/pXHWsdIdfj624J9h
         BpzFJzoDYQFBUM0uFKXrsjBLwzPw6r7Xm7hFkxz48I8bpCfGGZUxs9j25RD+e7qTz0U9
         o0PdWco7TXZ7Ci92/6X0YQLq9R/2R8c0BQJ4l/YkN1n1Sc1EfBP5GEyS1+GuWHbTaaGI
         nhAQqSJ/Pwg8Q5AcMtVvpS5S35evclxZECmnAzBA4A84/B4j4lOAbyoedFQsv3ynb6x4
         aCeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693400820; x=1694005620;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hDC9ESUef36Mte2IBID4F1U1QCc8COjSUPt3loc3xqg=;
        b=F37Nv3LpAvoFO5VW4EfA4X5LLDHiZJR0YxR4TlhUrZI2Dq6hI+Uu5Voqq5r7bDkdCD
         dpg3bK7PBezVbyQKrgSjLAw60hk1v/YN79foipdMS2wsS1wpVHEECuN/DMfgtg7xa8Y3
         A6cpNiPxuJzptu6cwC+AW1RwQNzBH5VdaDKTBMrWiBPIFY1HS5ONP1WogNCWB5NkJt0X
         urPb1Fh1kEa2db6lNsvWhMXCOOqloLxX553XqsM4H/NokfBQE1x+uvvLgC27BVLEi51Z
         /agVNqx3Hu1s14QxDcChZpLJpE0Qd/vvIPMyV0Ua9isalhZTuji/PgrmhaAZr7YB1UlV
         YgCA==
X-Gm-Message-State: AOJu0YwqNHDcIM4lcnA8p3Eqi1MYxM2XNPzAEWGH3jmyjUA2Fe0t4pKV
        6U+NL3/tE8qp0OB5JINtHEw+og==
X-Google-Smtp-Source: AGHT+IFYKkGvGmx/eCPeJ7zhxeO+D0prvW6xzkjQM9iAjR6tCDe1nTyr22bqGnmByYCAcaZcchFmrA==
X-Received: by 2002:a17:907:270c:b0:9a1:cb2c:b55f with SMTP id w12-20020a170907270c00b009a1cb2cb55fmr1453302ejk.53.1693400820483;
        Wed, 30 Aug 2023 06:07:00 -0700 (PDT)
Received: from [192.168.0.22] (77-252-46-238.static.ip.netia.com.pl. [77.252.46.238])
        by smtp.gmail.com with ESMTPSA id 17-20020a170906059100b0098963eb0c3dsm7147506ejn.26.2023.08.30.06.06.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Aug 2023 06:07:00 -0700 (PDT)
Message-ID: <c5d72559-4a97-c865-e51e-855d2bc1edee@linaro.org>
Date:   Wed, 30 Aug 2023 15:06:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v5 1/3] dt-bindings: thermal-zones: Document
 critical-action
Content-Language: en-US
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Fabio Estevam <festevam@gmail.com>
Cc:     daniel.lezcano@linaro.org, amitk@kernel.org, rui.zhang@intel.com,
        linux-pm@vger.kernel.org, krzysztof.kozlowski+dt@linaro.org,
        robh+dt@kernel.org, conor+dt@kernel.org,
        devicetree@vger.kernel.org, Fabio Estevam <festevam@denx.de>
References: <20230829194200.1901988-1-festevam@gmail.com>
 <CAJZ5v0hZR3WD+wMA6c-Gt86hM5oCRZDcSsYF4SrYTvT2HtQ=fQ@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CAJZ5v0hZR3WD+wMA6c-Gt86hM5oCRZDcSsYF4SrYTvT2HtQ=fQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 30/08/2023 13:37, Rafael J. Wysocki wrote:
> On Tue, Aug 29, 2023 at 9:42 PM Fabio Estevam <festevam@gmail.com> wrote:
>>
>> From: Fabio Estevam <festevam@denx.de>
>>
>> Document the critical-action property to describe the thermal action
>> the OS should perform after the critical temperature is reached.
>>
>> The possible values are "shutdown" and "reboot".
>>
>> The motivation for introducing the critical-action property is that
>> different systems may need different thermal actions when the critical
>> temperature is reached.
>>
>> For example, a desktop PC may want the OS to trigger a shutdown
>> when the critical temperature is reached.
>>
>> However, in some embedded cases, such behavior does not suit well,
>> as the board may be unattended in the field and rebooting may be a
>> better approach.
>>
>> The bootloader may also benefit from this new property as it can check
>> the SoC temperature and in case the temperature is above the critical
>> point, it can trigger a shutdown or reboot accordingly.
>>
>> Signed-off-by: Fabio Estevam <festevam@denx.de>
>> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>> ---
>> Changes since v4:
>> - None.
>>
>>  .../devicetree/bindings/thermal/thermal-zones.yaml       | 9 +++++++++
>>  1 file changed, 9 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/thermal/thermal-zones.yaml b/Documentation/devicetree/bindings/thermal/thermal-zones.yaml
>> index 4f3acdc4dec0..c2e4d28f885b 100644
>> --- a/Documentation/devicetree/bindings/thermal/thermal-zones.yaml
>> +++ b/Documentation/devicetree/bindings/thermal/thermal-zones.yaml
>> @@ -75,6 +75,15 @@ patternProperties:
>>            framework and assumes that the thermal sensors in this zone
>>            support interrupts.
>>
>> +      critical-action:
>> +        $ref: /schemas/types.yaml#/definitions/string
>> +        description:
>> +          The action the OS should perform after the critical temperature is reached.
>> +
>> +        enum:
>> +          - shutdown
>> +          - reboot
>> +
>>        thermal-sensors:
>>          $ref: /schemas/types.yaml#/definitions/phandle-array
>>          maxItems: 1
>> --
> 
> I'm wondering if this should be a bool property called
> "critical-reboot", say, which when present would mean to carry out a
> reboot instead of a shutdown in an emergency.
> 
> As defined above, the "shutdown" value is simply redundant, because
> the code will effectively convert any other value to "shutdown"
> anyway.

We covered this at v1. Bool does not allow this property to change in
the future, e.g. for a third mode. And how would you change the action
to shutdown if default action in the system was reboot?

Best regards,
Krzysztof

