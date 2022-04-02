Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D7114F0499
	for <lists+linux-pm@lfdr.de>; Sat,  2 Apr 2022 17:50:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357456AbiDBPwS (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 2 Apr 2022 11:52:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357452AbiDBPwR (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 2 Apr 2022 11:52:17 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4BC2201BE
        for <linux-pm@vger.kernel.org>; Sat,  2 Apr 2022 08:50:24 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id qh7so1642011ejb.11
        for <linux-pm@vger.kernel.org>; Sat, 02 Apr 2022 08:50:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=6975MKU9sTkhbv+L8Y2u10WML0H3VB/iCkjt87HVcpo=;
        b=Uq6rZIzCcG2AALKeKDE+g/YwFx0tGeWA6eaEST4TXreWflRtRMKfMjC2DJ3/fkcY1n
         sPsVpDvCjUlKz7TFK4la4f75DBvo4iBuv3dFuB68E9HzMGUV0rVueljK6I81uWdV7qPk
         btZti3rQacMT3uQsMlYyBzJIBgsADoFB4raO9ib0WhiIuahEr55lRnq9sbGP9kfFRtZk
         P0n3DVTR2h8E5ZOuJMukHJzCM63tKkID6ddUVcwbcWMl8SoGAmyoaHjsiF+Vns5ASJfX
         4w9nhuQPUkgGYgUDVBtTR/pP/E8v6Ugc6nBFH4Zw1HFoGO83LdjXRyh+WVHZ7UyNz4+o
         vYRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=6975MKU9sTkhbv+L8Y2u10WML0H3VB/iCkjt87HVcpo=;
        b=nR/+81YK+4n9N6525h4p8CtRQi/amHoBlny5TYZnNCrQmaW/JgRidLFYokxyyxYOWr
         bfSoc3LXSDhyrReXVqFuDIJiBG6Yzh2Nm3mZFD2zw8s866yUBjAHDcHbP1NBK5oVDETG
         nHDWzGCunDqUW4D9tJWrdhWc7SS9qdq9lOS/Gay3I6yGXfSfh+cuj4pNhHRc6a9uG8e0
         V2KFtridg+8YA50E0RRKSdJrN144LGHVZWxXs2D2bGe55Wb7vszKx7rV7be4P6fERsrn
         +OWaQSr0xMoW85eRjls9Zv+8BdqJQkdz9bUySAzVmz7bzPvXRDu4b5kwWLyxgNVpy8vv
         uF+Q==
X-Gm-Message-State: AOAM533bMRo8F0Q4exDV3GcpQsvTASl4ibHTvSldZMz9MVC50r4aypvp
        +YiKUrbR4mhh/BKVmPVkRIIufLz+HPyF9w==
X-Google-Smtp-Source: ABdhPJx8QAoYvVoNwXcpqzI0cVtIj6iw6TjQJw6cn1Dy2UVjJulY+JTWr3wZAJBGvvRkcqAd9ZS9TQ==
X-Received: by 2002:a17:906:32cf:b0:6d5:83bc:e962 with SMTP id k15-20020a17090632cf00b006d583bce962mr4390724ejk.108.1648914623488;
        Sat, 02 Apr 2022 08:50:23 -0700 (PDT)
Received: from [192.168.0.33] (cpc78119-cwma10-2-0-cust590.7-3.cable.virginm.net. [81.96.50.79])
        by smtp.gmail.com with ESMTPSA id s3-20020a1709067b8300b006e4a6dee49dsm2241404ejo.184.2022.04.02.08.50.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 02 Apr 2022 08:50:23 -0700 (PDT)
Message-ID: <e981064e-50a3-05f3-a013-564aea5fe99b@linaro.org>
Date:   Sat, 2 Apr 2022 16:50:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 6/6] dt-bindings: power: supply: qcom,smb2: add bindings
 for smb2 driver
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Cc:     Amit Pundir <amit.pundir@linaro.org>,
        Sumit Semwal <sumit.semwal@linaro.org>
References: <20220401202643.877609-1-caleb.connolly@linaro.org>
 <20220401202643.877609-7-caleb.connolly@linaro.org>
 <f737fd47-e557-45af-035b-af29a88e22e6@linaro.org>
From:   Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <f737fd47-e557-45af-035b-af29a88e22e6@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 02/04/2022 15:22, Krzysztof Kozlowski wrote:
> On 01/04/2022 22:26, Caleb Connolly wrote:
>> Add devicetree bindings for the Qualcomm PMI8998/PM660 SMB2 charger
>> drivers.
>>
>> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
>> ---
>>   .../bindings/power/supply/qcom,smb2.yaml      | 68 +++++++++++++++++++
>>   1 file changed, 68 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/power/supply/qcom,smb2.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/power/supply/qcom,smb2.yaml b/Documentation/devicetree/bindings/power/supply/qcom,smb2.yaml
>> new file mode 100644
>> index 000000000000..1bea1fef78b8
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/power/supply/qcom,smb2.yaml
>> @@ -0,0 +1,68 @@
>> +# SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/power/supply/qcom,smb2.yaml#
> 
> Hi,
Hi Krzysztof,
> 
> Are you sure "smb2" is a real Qualcomm versioning? IOW, is there going
> to be smb3 in the future? If not, better to just name the file according
> to model, so like compatible and like other existing schemas from Qualcomm.
Qualcomm versioning is a complete mystery to me 😅, downstream kernels have a 
"pmi8998_charger" which uses the qpnp-smb2 driver, there is also an "smb5" 
driver presumably for newer PMICs. This driver is used for the charger block 
found on the PMI8998 and PM660 at least, a name like "pmi8998_charger" might be 
more suitable.

> 
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Qualcomm PMI8998/PM660 Switch-Mode Battery Charger "2"
>> +
>> +maintainers:
>> +  - Caleb Connolly <caleb.connolly@linaro.org>
>> +
>> +properties:
>> +  compatible:
>> +    enum:
>> +      - qcom,pmi8998-smb2
>> +
>> +  reg:
>> +    maxItems: 1
>> +
>> +  interrupts:
>> +    items:
>> +      - description: usb plugin
> 
> Just maxItems:1 (description is obvious and matches names).
> 
>> +
>> +  interrupt-names:
>> +    items:
>> +      - const: usb-plugin
>> +
>> +  io-channels:
>> +    items:
>> +      - description: USB in current in uA
>> +      - description: USB in voltage in uV
>> +
>> +  io-channel-names:
>> +    items:
>> +      - const: usbin_i
>> +      - const: usbin_v
>> +
> 
> What about monitored-battery? How do you configure the battery
> characteristics?
> 
>> +required:
>> +  - compatible
>> +  - reg
>> +  - interrupts
>> +  - interrupt-names
>> +  - io-channels
>> +  - io-channel-names
>> +
>> +additionalProperties: false
>> +
>> +examples:
>> +  - |
>> +    #include <dt-bindings/interrupt-controller/irq.h>
>> +    pmic {
>> +      #address-cells = <1>;
>> +      #size-cells = <0>;
>> +      #interrupt-cells = <4>;
>> +
>> +      smb2@1000 {
> 
> Generic node name please, so "charger".
> 
> 
> 
> Best regards,
> Krzysztof

-- 
Kind Regards,
Caleb (they/them)
