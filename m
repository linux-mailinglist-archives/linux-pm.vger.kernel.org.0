Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF4536C44EB
	for <lists+linux-pm@lfdr.de>; Wed, 22 Mar 2023 09:30:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230182AbjCVIai (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 22 Mar 2023 04:30:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230169AbjCVIah (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 22 Mar 2023 04:30:37 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 587A25CC0F
        for <linux-pm@vger.kernel.org>; Wed, 22 Mar 2023 01:30:34 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id h8so69502736ede.8
        for <linux-pm@vger.kernel.org>; Wed, 22 Mar 2023 01:30:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679473833;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OdUQKUhhiP/AHFjE5Cg++X9BxgvEq6Ybodm+73BF1Fw=;
        b=ZHmz7QEujqa25/gVodDyMAQAUXp9Sq/gc3xuQvmLY4G/iF1suO/4B3EYadt3zZRSsQ
         oNtlOdEmUQxaHReUhUXnAGBpikHd+BULuuWXgRSsmjW0zWJq7LPff8oS4VjqQlcAmK37
         oNdTdwKBTtIe5BEz2eD+tqLpBlT29sFwx/PFFVFkTaZyDFeHaKGio8EEN9VZIoYUqfRm
         jCncRJBglQOyvitQLDtYPuCPW0IzmSbWJxKFJzl9OgpEciXUcCxH6Xl0mT9RmelvNNCO
         2qm3S1vB7eNMbxciqnr2TLafjots2Anfi0V9IXFQoTzNWANthtcPYAGuufpaykyZo3IP
         gSNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679473833;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OdUQKUhhiP/AHFjE5Cg++X9BxgvEq6Ybodm+73BF1Fw=;
        b=kkC12vCfsM3iwlLtIUzsvkv+esYAQWOuh4IGHmYDId8rW6+L+XYht9h7Qs8kBMZ3x/
         IO2saniH3blras2DTup2UFmU7HM7XTkcSrqtLuswX/d8Dqm+C1whCjc1uX+wxwhTBCEV
         8yqTCw8hC8MksIR4o+zNDh6M5Uyg9Wo5NqDwjg3V27xyEJRIAKAxWKZv1JlgdlrCNE9v
         XwUXU7DK6xwJeROZX6oZaliyv8AUJ/ozWBPlLklUJfbo/N2ziqBGheepsmpCmkPYcLVO
         mlXWB1ODEvgVpOa95oOleW4kowlzxvpMgVpReIZc+jLSN9jt5UTMu94yhaXyLdx27D31
         WjvQ==
X-Gm-Message-State: AO0yUKX5F9yqbErB9srm60Tv+aoZF9crS58zZ/yD85uj4X6nUmzSTOyJ
        ooiZTZNxAVe2SMzWCI2xZzCL4Q==
X-Google-Smtp-Source: AK7set8Iw48FCrfKo8mQ85Q2EkmWhTMQeVAiK+kQDGWX8UOpGZtycm/zegmmRF91tp4VF2dnVVk0Yg==
X-Received: by 2002:a17:906:1501:b0:932:853c:c958 with SMTP id b1-20020a170906150100b00932853cc958mr4847233ejd.25.1679473832832;
        Wed, 22 Mar 2023 01:30:32 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:5050:151b:e755:1c6? ([2a02:810d:15c0:828:5050:151b:e755:1c6])
        by smtp.gmail.com with ESMTPSA id md12-20020a170906ae8c00b008e68d2c11d8sm6862203ejb.218.2023.03.22.01.30.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Mar 2023 01:30:32 -0700 (PDT)
Message-ID: <afeecd42-ecda-4d92-bbb5-6dcff84fca7d@linaro.org>
Date:   Wed, 22 Mar 2023 09:30:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v2 5/8] dt-bindings: power: supply: max77658: Add ADI
 MAX77658 Battery
Content-Language: en-US
To:     Zeynep Arslanbenzer <Zeynep.Arslanbenzer@analog.com>,
        lee@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, sre@kernel.org,
        lgirdwood@gmail.com, broonie@kernel.org
Cc:     Nurettin.Bolucu@analog.com, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org
References: <20230322055628.4441-1-Zeynep.Arslanbenzer@analog.com>
 <20230322055628.4441-6-Zeynep.Arslanbenzer@analog.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230322055628.4441-6-Zeynep.Arslanbenzer@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 22/03/2023 06:56, Zeynep Arslanbenzer wrote:
> Add ADI MAX77658 power supply devicetree document.
> 
> Signed-off-by: Nurettin Bolucu <Nurettin.Bolucu@analog.com>
> Signed-off-by: Zeynep Arslanbenzer <Zeynep.Arslanbenzer@analog.com>
> ---
>  .../power/supply/adi,max77658-battery.yaml    | 58 +++++++++++++++++++
>  1 file changed, 58 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/power/supply/adi,max77658-battery.yaml
> 
> diff --git a/Documentation/devicetree/bindings/power/supply/adi,max77658-battery.yaml b/Documentation/devicetree/bindings/power/supply/adi,max77658-battery.yaml
> new file mode 100644
> index 000000000000..0b696f7c4d1b
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/power/supply/adi,max77658-battery.yaml
> @@ -0,0 +1,58 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/power/supply/adi,max77658-battery.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Battery for MAX77658 PMIC from ADI.

Implement all previous comments, not just some.


> +
> +maintainers:
> +  - Nurettin Bolucu <Nurettin.Bolucu@analog.com>
> +  - Zeynep Arslanbenzer <Zeynep.Arslanbenzer@analog.com>
> +
> +description: |
> +  This module is part of the MAX77658 MFD device. For more details
> +  see Documentation/devicetree/bindings/mfd/adi,max77658.yaml.
> +
> +  The fuel gauge is represented as a sub-node of the PMIC node on the device tree.
> +
> +properties:
> +  compatible:
> +    const:
> +      adi,max77658-battery

It's one line.

> +
> +  reg:
> +    maxItems: 1
> +
> +  adi,valrt-min-microvolt:
> +    description: Minimum voltage value that triggers the alarm.
> +
> +  adi,valrt-max-microvolt:
> +    description: Maximum voltage value that triggers the alarm.

Use the same syntax as battery.yaml

> +
> +  adi,salrt-min-percent:
> +    description: Minimum percentage of battery that triggers the alarm.
> +
> +  adi,salrt-max-percent:
> +    description: Maximum percentage of battery that triggers the alarm.

That's not suitable for DT. Do not encode policies into DT.

> +
> +  adi,ialrt-min-microamp:
> +    description: Minimum current value that triggers the alarm.
> +
> +  adi,ialrt-max-microamp:
> +    description: Maximum current value that triggers the alarm.
> +
> +  monitored-battery:
> +    description: >
> +      phandle to a "simple-battery" compatible node.
> +
> +      This property must be a phandle to a node using the format described

You already said it above.

> +      in battery.yaml, with the following properties being required:
> +      - alert-celsius
> +
> +required:
> +  - compatible

Why reg and monitored-batter are not required?


Best regards,
Krzysztof

