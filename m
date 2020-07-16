Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B09892229C6
	for <lists+linux-pm@lfdr.de>; Thu, 16 Jul 2020 19:24:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728182AbgGPRYh (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 16 Jul 2020 13:24:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725867AbgGPRYh (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 16 Jul 2020 13:24:37 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5453C061755;
        Thu, 16 Jul 2020 10:24:36 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id x9so8831234ljc.5;
        Thu, 16 Jul 2020 10:24:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=hjVlWdeLydlGM9Tsn7DxLyu36+NhHY2Z/yvVPpckruQ=;
        b=FiKx9Fwj7zyC3kMQCecAVNhoRN34gTx+1k82pLWEC5BcPLZvzz3vFofaxHQuZn0Jqd
         3dn2K47xydzifkXtMsae/32FQS82VcY9AZcz/5ixGN7CgIMQBufG3AnlFiFlhiM+/VjX
         CfxvV3ZMuLPmxD9lWyy9FsnSnKjrFMlxD3amNehDYulF1hLHTvnNX3oOOw4mHyJLJWJn
         tbBEo8CKRKqdwBknVZgMZ6GXVMZnv5p9ALwSh390MypgUST8afd8hRM4KV3juasyfaCG
         67zmPwybGzA4Kv2ggn0ZUFf4wTK1NQ9L4cJ0QnPx6PeJa5hF9hiAbyXyhv5MLXzd6pVF
         wg+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=hjVlWdeLydlGM9Tsn7DxLyu36+NhHY2Z/yvVPpckruQ=;
        b=cr7uZRD/QpSiYpCl4hLfikb7sQocj/BAWDBmGX9IcDIgJS7GCKTPXstKxJPsyqrgbN
         ZGDdeitEHmEQ67xn56ZjocwEablCE4YvnBwoMSV9pkCa1F9dTEsY0fK9Cnbu2cWInGGs
         b+77zOyqUDbHEEPQBExFEMyVng98rSWGpjPXQBJKU2cqr7t+grPb45EnHRnWFbmKscH1
         gsAuEll+JfkFuifmAd2PT2hA6Ldwf4eEZovID5h8sL0VdUgBOpp73X1yY2FSqT7c0O5V
         zDmSfj4PxtjMimiosIJWYvDJfKew0w4q4gzUbnniLtT7UoFGyJfukZjGEY9i7Q/lGwIC
         w0yw==
X-Gm-Message-State: AOAM531Umyp+2juVwew2xI6yiVAJRXT9PXywZ/z6IEZxNvz3C/Wn8fAv
        07cMSSkhy0RU1f5rng5krl8=
X-Google-Smtp-Source: ABdhPJxWX0RDd8+gr3FZ2UQP1i3XK53rFDnArCj6U8QciBVaSnm+3qrqPz/ZL4wTBZqMD/vPldibxg==
X-Received: by 2002:a2e:8085:: with SMTP id i5mr2631573ljg.97.1594920275133;
        Thu, 16 Jul 2020 10:24:35 -0700 (PDT)
Received: from [192.168.2.145] (ppp91-76-4-184.pppoe.mtu-net.ru. [91.76.4.184])
        by smtp.googlemail.com with ESMTPSA id y18sm1160541ljn.62.2020.07.16.10.24.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Jul 2020 10:24:34 -0700 (PDT)
Subject: Re: [PATCH v2 1/9] dt-bindings: power: supply: Add device-tree
 binding for Summit SMB3xx
To:     Rob Herring <robh@kernel.org>
Cc:     Sebastian Reichel <sre@kernel.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        David Heidelberg <david@ixit.cz>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Jonghwa Lee <jonghwa3.lee@samsung.com>,
        John Stultz <john.stultz@linaro.org>,
        Vinay Simha BN <simhavcs@gmail.com>
References: <20200607144113.10202-1-digetx@gmail.com>
 <20200607144113.10202-2-digetx@gmail.com> <20200713233959.GA928559@bogus>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <8427d000-f803-6f17-3f87-fae17aceb24a@gmail.com>
Date:   Thu, 16 Jul 2020 20:24:33 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200713233959.GA928559@bogus>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

14.07.2020 02:39, Rob Herring пишет:
> On Sun, Jun 07, 2020 at 05:41:05PM +0300, Dmitry Osipenko wrote:
>> From: David Heidelberg <david@ixit.cz>
>>
>> Summit SMB3xx series is a Programmable Switching Li+ Battery Charger.
>> This patch adds device-tree binding for Summit SMB345, SMB347 and SMB358
>> chargers.
>>
>> Signed-off-by: David Heidelberg <david@ixit.cz>
>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
>> ---
>>  .../power/supply/summit,smb347-charger.yaml   | 165 ++++++++++++++++++
>>  .../dt-bindings/power/summit,smb347-charger.h |  19 ++
>>  2 files changed, 184 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/power/supply/summit,smb347-charger.yaml
>>  create mode 100644 include/dt-bindings/power/summit,smb347-charger.h
>>
>> diff --git a/Documentation/devicetree/bindings/power/supply/summit,smb347-charger.yaml b/Documentation/devicetree/bindings/power/supply/summit,smb347-charger.yaml
>> new file mode 100644
>> index 000000000000..eea0a6398c95
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/power/supply/summit,smb347-charger.yaml
>> @@ -0,0 +1,165 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: "http://devicetree.org/schemas/power/supply/summit,smb347-charger.yaml#"
>> +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
>> +
>> +title: Battery charger driver for SMB345, SMB347 and SMB358
>> +
>> +maintainers:
>> +  - David Heidelberg <david@ixit.cz>
>> +  - Dmitry Osipenko <digetx@gmail.com>
>> +
>> +properties:
>> +  compatible:
>> +    enum:
>> +      - summit,smb345
>> +      - summit,smb347
>> +      - summit,smb358
>> +
>> +  reg:
>> +    maxItems: 1
>> +
>> +  interrupts:
>> +    maxItems: 1
>> +
>> +  monitored-battery:
>> +    description: phandle to the battery node
>> +    $ref: /schemas/types.yaml#/definitions/phandle
>> +
>> +  summit,enable-usb-charging:
>> +    type: boolean
>> +    description: Enable charging through USB.
>> +
>> +  summit,enable-otg-charging:
>> +    type: boolean
>> +    description: Provide power for USB OTG
>> +
>> +  summit,enable-mains-charging:
>> +    type: boolean
>> +    description: Enable charging through mains
>> +
>> +  summit,enable-charge-control:
>> +    description: Enable charging control
>> +    allOf:
>> +      - $ref: /schemas/types.yaml#/definitions/uint32
>> +      - enum:
>> +          - 0 # SMB3XX_CHG_ENABLE_SW SW (I2C interface)
>> +          - 1 # SMB3XX_CHG_ENABLE_PIN_ACTIVE_LOW Pin control (Active Low)
>> +          - 2 # SMB3XX_CHG_ENABLE_PIN_ACTIVE_HIGH Pin control (Active High)
>> +
>> +  summit,fast-voltage-threshold-microvolt:
>> +    description: Voltage threshold to transit to fast charge mode (in uV)
>> +    allOf:
>> +      - $ref: /schemas/types.yaml#/definitions/uint32
> 
> Anything with a standard unit suffix already has a type, so drop.

I'll correct it in the next revision, thanks!
