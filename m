Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 833A374CF7F
	for <lists+linux-pm@lfdr.de>; Mon, 10 Jul 2023 10:09:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232446AbjGJIJ3 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 10 Jul 2023 04:09:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230387AbjGJIJ2 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 10 Jul 2023 04:09:28 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BF3AFB
        for <linux-pm@vger.kernel.org>; Mon, 10 Jul 2023 01:09:26 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-9741caaf9d4so478471566b.0
        for <linux-pm@vger.kernel.org>; Mon, 10 Jul 2023 01:09:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688976565; x=1691568565;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ai5VPz1A3P6zIF7jpvLukucy9yK0spksXLW5++Hkwu0=;
        b=hYB7np9XfCdqXie44QMhTkunjecFnATwad8Cyyo3cA9qi6t2sLlUyjZCOYKCXDlGBV
         nPna4VI9M6GkZXB4xK6fNvW+h2no2VMNwFyLvVwppl0bLdpvu/ViZMPwORarP9e4pqQF
         lCxPiKrh08E9NC8wgQMqe7MX7c82bz1j1fyJbRi4LmFUhdBTWfCLjcI1DRNuJE9BUOgQ
         NCbjeoEirKXeWOUVREL+B+SDFq2LpNio6UIYpZzxzFqQe5T50i08sQaBkFKxGvg+coHX
         R0sEgDEIDAjlfjNLg7nQur6OoGDxjONrnhAyMW4YEaGc3jO98Y7RMsITypd4VHglyA0R
         AtQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688976565; x=1691568565;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ai5VPz1A3P6zIF7jpvLukucy9yK0spksXLW5++Hkwu0=;
        b=FTNYJoKwZMxFpJR5pQXT08Y8S6iSKUyMr/caufX49WzbMzC8nrKGqtj6Bsh1Mdu44L
         CWFSFS+kYr2QPS3H3f3zMJTSL7cqAGcJ0fQ6jFEn1SWTTnZxvZqrRf3VnEhOxCIioEWv
         wznG6wAgFrzObeEmcr01mt2v1YBbE7iph3KVxXtN2o13lGA2dSH3Iz0lwiiIp8EVj8Ar
         YiUFhvo6RVZvnDx+VNGDZ1YexKypZGqoROeJsSj81xauU1uTnaEljq+Ms/6C5CnvUBDW
         4UYGYLLX3v/WyT7cIMzLNrPpldtiSbv56NAOOo/UCuT9SbDHtoCv+2djF+ENiqDzXZPL
         uV4Q==
X-Gm-Message-State: ABy/qLZnj/22Ci3gR9KPXGnI3QAKNITXvwFpUFoSjBELo+Ov63yrhQ5w
        DrIitQ2+HRHBQYKdzfTuSWDREQ==
X-Google-Smtp-Source: APBJJlFFTpAolmaqeCsAlbJoBZcfe0TaJ9E4fo1wShcyU+Kz/UIB/z6U65faCFChzdghvGoQPNILgQ==
X-Received: by 2002:a17:907:cca1:b0:974:771e:6bf0 with SMTP id up33-20020a170907cca100b00974771e6bf0mr10941305ejc.56.1688976564772;
        Mon, 10 Jul 2023 01:09:24 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id xa20-20020a170907b9d400b00993004239a4sm5738182ejc.215.2023.07.10.01.09.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Jul 2023 01:09:24 -0700 (PDT)
Message-ID: <d6386a66-4cc2-9358-e65e-b09e614800c3@linaro.org>
Date:   Mon, 10 Jul 2023 10:09:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] dt-bindings: thermal: tegra: Convert to json-schema
Content-Language: en-US
To:     Thierry Reding <thierry.reding@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     Jon Hunter <jonathanh@nvidia.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org
References: <20230707133333.2998802-1-thierry.reding@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230707133333.2998802-1-thierry.reding@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 07/07/2023 15:33, Thierry Reding wrote:
> From: Thierry Reding <treding@nvidia.com>
> 
> Convert the Tegra thermal bindings from the free-form text format to
> json-schema.
> 
> Signed-off-by: Thierry Reding <treding@nvidia.com>

Thank you for your patch. There is something to discuss/improve.

...

> +properties:
> +  compatible:
> +    enum:
> +      - nvidia,tegra124-soctherm
> +      - nvidia,tegra132-soctherm
> +      - nvidia,tegra210-soctherm
> +
> +  reg:
> +    minItems: 2

Drop minItems, not needed if equals to maxItems.

> +    maxItems: 2
> +
> +  reg-names:
> +    minItems: 2

Drop minItems, not needed if equals to maxItems.


> +    maxItems: 2
> +
> +  interrupts:
> +    items:
> +      - description: module interrupt
> +      - description: EDP interrupt
> +
> +  interrupt-names:
> +    items:
> +      - const: thermal
> +      - const: edp
> +
> +  clocks:
> +    items:
> +      - description: thermal sensor clock
> +      - description: module clock
> +
> +  clock-names:
> +    items:
> +      - const: tsensor
> +      - const: soctherm
> +
> +  resets:
> +    items:
> +      - description: module reset
> +
> +  reset-names:
> +    items:
> +      - const: soctherm
> +
> +  "#thermal-sensor-cells":
> +    const: 1
> +
> +  throttle-cfgs:
> +    $ref: thermal-cooling-devices.yaml

Missing unevaluatedProperties: false on this level.

> +    description: A sub-node which is a container of configuration for each
> +      hardware throttle events. These events can be set as cooling devices.
> +      Throttle event sub-nodes must be named as "light" or "heavy".
> +    patternProperties:
> +      "^(light|heavy)$":
> +        type: object
> +        properties:
> +          nvidia,priority:
> +            $ref: /schemas/types.yaml#/definitions/uint32
> +            minimum: 1
> +            maximum: 100
> +            description: Each throttles has its own throttle settings, so the
> +              SW need to set priorities for various throttle, the HW arbiter
> +              can select the final throttle settings. Bigger value indicates
> +              higher priority, In general, higher priority translates to lower
> +              target frequency. SW needs to ensure that critical thermal
> +              alarms are given higher priority, and ensure that there is no
> +              race if priority of two vectors is set to the same value.
> +
> +          nvidia,cpu-throt-percent:

Missing type

> +            description: This property is for Tegra124 and Tegra210. It is the
> +              throttling depth of pulse skippers, it's the percentage
> +              throttling.
> +
> +          nvidia,cpu-throt-level:
> +            $ref: /schemas/types.yaml#/definitions/uint32
> +            description: This property is only for Tegra132, it is the level
> +              of pulse skippers, which used to throttle clock frequencies. It
> +              indicates cpu clock throttling depth, and the depth can be
> +              programmed.
> +            enum:
> +              # none (TEGRA_SOCTHERM_THROT_LEVEL_NONE)
> +              - 0
> +              # low (TEGRA_SOCTHERM_THROT_LEVEL_LOW)
> +              - 1
> +              # medium (TEGRA_SOCTHERM_THROT_LEVEL_MED)
> +              - 2
> +              # high (TEGRA_SOCTHERM_THROT_LEVEL_HIGH)
> +              - 3
> +
> +          nvidia,gpu-throt-level:
> +            $ref: /schemas/types.yaml#/definitions/uint32
> +            description: This property is for Tegra124 and Tegra210. It is the
> +              level of pulse skippers, which used to throttle clock
> +              frequencies. It indicates gpu clock throttling depth and can be
> +              programmed to any of the following values which represent a
> +              throttling percentage.
> +            enum:
> +              # none (0%, TEGRA_SOCTHERM_THROT_LEVEL_NONE)
> +              - 0
> +              # low (50%, TEGRA_SOCTHERM_THROT_LEVEL_LOW)
> +              - 1
> +              # medium (75%, TEGRA_SOCTHERM_THROT_LEVEL_MED)
> +              - 2
> +              # high (85%, TEGRA_SOCTHERM_THROT_LEVEL_HIGH)
> +              - 3
> +
> +          # optional
> +          # Tegra210 specific and valid only for OCx throttle events
> +          nvidia,count-threshold:
> +            $ref: /schemas/types.yaml#/definitions/uint32
> +            description: Specifies the number of OC events that are required
> +              for triggering an interrupt. Interrupts are not triggered if the
> +              property is missing. A value of 0 will interrupt on every OC
> +              alarm.
> +
> +          nvidia,polarity-active-low:
> +            $ref: /schemas/types.yaml#/definitions/flag
> +            description: Configures the polarity of the OC alaram signal. If
> +              present, this means assert low, otherwise assert high.
> +
> +          nvidia,alarm-filter:
> +            $ref: /schemas/types.yaml#/definitions/uint32
> +            description: Number of clocks to filter event. When the filter
> +              expires (which means the OC event has not occurred for a long
> +              time), the counter is cleared and filter is rearmed.
> +            default: 0
> +
> +          nvidia,throttle-period-us:
> +            description: Specifies the number of microseconds for which
> +              throttling is engaged after the OC event is deasserted.
> +            default: 0
> +
> +  # optional
> +  nvidia,thermtrips:
> +    $ref: /schemas/types.yaml#/definitions/uint32-matrix

Missing items describing the matrix.

> +    description: |
> +      When present, this property specifies the temperature at which the
> +      SOCTHERM hardware will assert the thermal trigger signal to the Power
> +      Management IC, which can be configured to reset or shutdown the device.
> +      It is an array of pairs where each pair represents a tsensor ID followed
> +      by a temperature in milli Celcius. In the absence of this property the
> +      critical trip point will be used for thermtrip temperature.
> +
> +      Note:
> +      - the "critical" type trip points will be used to set the temperature at
> +        which the SOCTHERM hardware will assert a thermal trigger if the
> +        "nvidia,thermtrips" property is missing.  When the thermtrips property
> +        is present, the breach of a critical trip point is reported back to
> +        the thermal framework to implement software shutdown.
> +
> +      - the "hot" type trip points will be set to SOCTHERM hardware as the
> +        throttle temperature.  Once the temperature of this thermal zone is
> +        higher than it, it will trigger the HW throttle event.
> +


Best regards,
Krzysztof

