Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68F774238E5
	for <lists+linux-pm@lfdr.de>; Wed,  6 Oct 2021 09:30:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237518AbhJFHcA (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 6 Oct 2021 03:32:00 -0400
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:35636
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237548AbhJFHb6 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 6 Oct 2021 03:31:58 -0400
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com [209.85.167.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 71E083FFEA
        for <linux-pm@vger.kernel.org>; Wed,  6 Oct 2021 07:30:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1633505405;
        bh=fT6v+Iw+Sn1Vz786ubdOENDkwSbZLkPOCFIalT5lqFQ=;
        h=Subject:From:To:Cc:References:Message-ID:Date:MIME-Version:
         In-Reply-To:Content-Type;
        b=cleSSBdolkLCqLUycUzpSbwSAuOGSsr8UETWTGLp1eGw8jzjF0OOi4W2ve2nf/JQP
         gMzr+sLGlbA+iqvoFfgEpi78hsV+P0GUXBoLkpJt5VNxozWY2mpUIBUfK7v5C9h6zn
         Ldbmh0s+2FzUzePAn7nhnD6+yNYTgXt8LxcLqGmOY2OKKaC1mnEyEXvvN8pJPdSvE3
         8VJvctO46GyX+hbpisex11g3+5lKmnFyWkDaNBRECZPmYSudxaJoDwGB+MNLmMLqPJ
         aX2JDxvIm93DC3CO3UMU525BfZ7k5f8dfcV+wPT862yJiswfl1//901Bzyf/QorrHt
         f11DK4rQ9ZS1A==
Received: by mail-lf1-f71.google.com with SMTP id i5-20020a056512224500b003fd2d62dcaaso1230396lfu.23
        for <linux-pm@vger.kernel.org>; Wed, 06 Oct 2021 00:30:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=fT6v+Iw+Sn1Vz786ubdOENDkwSbZLkPOCFIalT5lqFQ=;
        b=4r1FHi/OeBaSoCXKFPjTmyAqX+66xWDCJAFz8wJ4AUln9YsE/3yMSTMV178BUy5cE0
         IQSyHGOrf8mCfl/xsYytnY5NMw7kQn35FYgf+ztroexxCNaDNxPOphl/juyZm3TPK7Gj
         gYFidJ9xY0Q91MUsngUB6sWCnD2pAfxOynDtZVZduEej8GnkEAbi3CDQliM/1no1AmU2
         0PZJiRkDIuZuD7/e5+9Uy+I/sxcrs/so14AeaoYrIM0qthKlfcpOBNF2CeiT7DfAfp0P
         1v2jKFfFqwHMAq8JiQkR38WM7JcEtqtRscWOdwhbJDKhPWPUp1Q4wLPUhyMHmmg6GcAM
         N0dQ==
X-Gm-Message-State: AOAM532t3LgjqkpU0AitArUE+T4SLGVDJvbhtaUNDAf/6Sxs0RS5/grm
        Xtkv8qCW1j3zNLWD3FxPcRM2YdMcqDQ7GDfxTRPfXeT2lr43HVdZdlMzguXk6zp03QadNQ9FJGN
        mQn1qdwPgFh/d/jUVUpuoLZZlGiX6ZXT25zh8
X-Received: by 2002:a2e:7d07:: with SMTP id y7mr27779981ljc.406.1633505404674;
        Wed, 06 Oct 2021 00:30:04 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyWNZCUP0DI5Dx+/t94wcL4iJhgEZ5a+axR1WcdpE7rNU/4DtevraB5Fik46XDLGK7xlChSwg==
X-Received: by 2002:a2e:7d07:: with SMTP id y7mr27779953ljc.406.1633505404492;
        Wed, 06 Oct 2021 00:30:04 -0700 (PDT)
Received: from [192.168.0.20] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id n8sm2388437lfl.260.2021.10.06.00.30.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Oct 2021 00:30:04 -0700 (PDT)
Subject: Re: [PATCH 1/7] dt-bindings: arm: apple: Add apple,pmgr binding
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Hector Martin <marcan@marcan.st>,
        linux-arm-kernel@lists.infradead.org
Cc:     Marc Zyngier <maz@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Arnd Bergmann <arnd@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Kettenis <mark.kettenis@xs4all.nl>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-serial@vger.kernel.org
References: <20211005155923.173399-1-marcan@marcan.st>
 <20211005155923.173399-2-marcan@marcan.st>
 <18818eff-87d7-6a53-a4fd-7f3cbf625a0e@canonical.com>
Message-ID: <1c36c3e6-c1aa-0779-5f6d-8980377c45a4@canonical.com>
Date:   Wed, 6 Oct 2021 09:30:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <18818eff-87d7-6a53-a4fd-7f3cbf625a0e@canonical.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 06/10/2021 08:56, Krzysztof Kozlowski wrote:
> On 05/10/2021 17:59, Hector Martin wrote:
>> The PMGR block in Apple Silicon SoCs is responsible for SoC power
>> management. There are two PMGRs in T8103, with different register
>> layouts but compatible registers. In order to support this as well
>> as future SoC generations with backwards-compatible registers, we
>> declare these blocks as syscons and bind to individual registers
>> in child nodes. Each register controls one SoC device.
>>
>> The respective apple compatibles are defined in case device-specific
>> quirks are necessary in the future, but currently these nodes are
>> expected to be bound by the generic syscon driver.
>>
>> Signed-off-by: Hector Martin <marcan@marcan.st>
>> ---
>>  .../bindings/arm/apple/apple,pmgr.yaml        | 74 +++++++++++++++++++
>>  MAINTAINERS                                   |  1 +
>>  2 files changed, 75 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/arm/apple/apple,pmgr.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/arm/apple/apple,pmgr.yaml b/Documentation/devicetree/bindings/arm/apple/apple,pmgr.yaml
>> new file mode 100644
>> index 000000000000..0304164e4140
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/arm/apple/apple,pmgr.yaml
>> @@ -0,0 +1,74 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/arm/apple/apple,pmgr.yaml#
> 
> Please don't store all Apple-related bindings in bindings/arm/apple, but
> instead group per device type like in most of other bindings. In this
> case - this looks like something close to power domain controller, so it
> should be in bindings/power/
> 
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Apple SoC Power Manager (PMGR)
>> +
>> +maintainers:
>> +  - Hector Martin <marcan@marcan.st>
>> +
>> +description: |
>> +  Apple SoCs include a PMGR block responsible for power management,
>> +  which can control various clocks, resets, power states, and
>> +  performance features. This node represents the PMGR as a syscon,
>> +  with sub-nodes representing individual features.
>> +
>> +  Apple SoCs may have a secondary "mini-PMGR"; it is represented
>> +  separately in the device tree, but works the same way.
>> +
>> +select:
>> +  properties:
>> +    compatible:
>> +      contains:
>> +        enum:
>> +          - apple,t8103-pmgr
>> +          - apple,t8103-minipmgr
>> +          - apple,pmgr
>> +
>> +  required:
>> +    - compatible
>> +
>> +properties:
>> +  $nodename:
>> +    pattern: "^power-management@[0-9a-f]+$"
>> +
>> +  compatible:
>> +    items:
>> +      - enum:
>> +          - apple,t8103-pmgr
>> +          - apple,t8103-minipmgr
>> +      - const: apple,pmgr
>> +      - const: syscon
>> +      - const: simple-mfd
> 
> No power-domain-cells? Why? What exactly this device is going to do?
> Maybe I'll check the driver first.... :)
> 

After looking at the code, there is no device for
apple,t8103-pmgr/apple,pmgr. What is this binding about? Is there really
a central (central as in "one device for SoC") block managing power
which you want to model here?


Best regards,
Krzysztof
