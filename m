Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFD36644A16
	for <lists+linux-pm@lfdr.de>; Tue,  6 Dec 2022 18:15:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235747AbiLFRPS (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 6 Dec 2022 12:15:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235719AbiLFRPD (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 6 Dec 2022 12:15:03 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1025B326F5
        for <linux-pm@vger.kernel.org>; Tue,  6 Dec 2022 09:15:02 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id w15so24433410wrl.9
        for <linux-pm@vger.kernel.org>; Tue, 06 Dec 2022 09:15:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+s5rfVzoW3yLox4r2DEYN4/4gPffJ7R6undERdlOa7I=;
        b=tXvl2rihDv/nI8066aMrNTEOGsB2L/nq22jKVqZs02WR3VxbFCh4tXsBIq/Xw1EXef
         6enl0Azbx31SU5rhM5uivq8lw1Ye73A8nrVSdTKvPqCq3wBcYAs5xhRD8bhD7ai0PSJ/
         WQq48VfWN/KyRDmql1axQ2jQJudHKwvdMGznx1vSH3UJ9DpxXpg0Qj8oYiKW11td3eWm
         QCcG4jBcDvVabCY6718psd/imjAo5YKtKMZQfeJk+6ls47l2Y8sjtzosSrOvCny4OkBT
         cxDWxNlxyniNxyQ8AQlteY2+goniDIbhb5S4429d/Z7ue5lpJk8Z0LRh26+X7dtM14tK
         z0Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+s5rfVzoW3yLox4r2DEYN4/4gPffJ7R6undERdlOa7I=;
        b=vdrvuWxWveVPcxRI7oz6THa1wZCVbcyUvQUCbzgx3WswI5kmzWF5Fnrc6kqYYM43wD
         9Mj6IRJAkIuu6GKHdq71/Qtc6aAl1H01vTGFZG16n9M3gYw06IrJ6B12H69S7le3fenx
         FBLankxCN5xOHgBKBzN8Qcjhi1K/yG2BiRqW84E9xnBpZNqrvfuJuZ0o/SPz5fwsCX45
         lYae2hOTq6H9+7zPBjCEpsOpiZpEG57GVJMjOcxuLsc+vTBwodroa2PJwPxZIHz96ix3
         CPa1e2AykgFHrj143F7ABCqpoNV9GVSnkZYqlu/lukqutIdSgbbRE20GEKZvIOcOJRH8
         hpUA==
X-Gm-Message-State: ANoB5plsUr3zORrgS7yRI2FgSKyHR0KJAJy2U5+/dDJF2gZZGopHAGCd
        /fg0KBNH2BiJ67M2DNHWoasnzg==
X-Google-Smtp-Source: AA0mqf5hQpXGaAgJ7nbFJ+jMeijdZS2MNJwgkTHTlnmXa2OnFJssM3CjbFkoRS/WWZoK6Ina6QmVcw==
X-Received: by 2002:adf:dbcd:0:b0:242:1294:5174 with SMTP id e13-20020adfdbcd000000b0024212945174mr26798428wrj.249.1670346900469;
        Tue, 06 Dec 2022 09:15:00 -0800 (PST)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id r20-20020a05600c35d400b003c6d21a19a0sm14936614wmq.29.2022.12.06.09.14.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Dec 2022 09:15:00 -0800 (PST)
Message-ID: <52d2e0c2-a04a-1ae8-cab5-b89a79150fe6@linaro.org>
Date:   Tue, 6 Dec 2022 18:14:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH] dt-bindings: thermal: thermal-idle: Fix example paths
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20221111162729.3381835-1-robh@kernel.org>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20221111162729.3381835-1-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 11/11/2022 17:27, Rob Herring wrote:
> The reference by path (&{/cpus/cpu@101/thermal-idle}) in the example causes
> an error with new version of dtc:
> 
> FATAL ERROR: Can't generate fixup for reference to path &{/cpus/cpu@100/thermal-idle}
> 
> This is because the examples are built as an overlay and absolute paths
> are not valid as references must be by label. The path was also not
> resolvable because, by default, examples are placed under 'example-N'
> nodes.
> 
> As the example contains top-level nodes, the root node must be explicit for
> the example to be extracted as-is. This changes the indentation for the
> whole example, but the existing indentation is a mess of of random amounts.
> Clean this up to be 4 spaces everywhere.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
> The dtc update is in my tree, so I'd prefer to take this via the DT
> tree.
> 
>   .../bindings/thermal/thermal-idle.yaml        | 154 +++++++++---------
>   1 file changed, 80 insertions(+), 74 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/thermal/thermal-idle.yaml b/Documentation/devicetree/bindings/thermal/thermal-idle.yaml
> index cc938d7ad1f3..72d85eb64247 100644
> --- a/Documentation/devicetree/bindings/thermal/thermal-idle.yaml
> +++ b/Documentation/devicetree/bindings/thermal/thermal-idle.yaml
> @@ -48,99 +48,105 @@ additionalProperties: false
>   
>   examples:
>     - |
> -    #include <dt-bindings/thermal/thermal.h>
> +    /{
> +        #include <dt-bindings/thermal/thermal.h>
>   
> -    // Example: Combining idle cooling device on big CPUs with cpufreq cooling device
> -    cpus {
> +        compatible = "foo";
> +        model = "foo";
> +        #address-cells = <1>;
> +        #size-cells = <1>;
> +
> +        // Example: Combining idle cooling device on big CPUs with cpufreq cooling device
> +        cpus {
>               #address-cells = <2>;
>               #size-cells = <0>;
>   
>               /* ... */
>   
> -                 cpu_b0: cpu@100 {
> -                         device_type = "cpu";
> -                         compatible = "arm,cortex-a72";
> -                         reg = <0x0 0x100>;
> -                         enable-method = "psci";
> -                         capacity-dmips-mhz = <1024>;
> -                         dynamic-power-coefficient = <436>;
> -                         #cooling-cells = <2>; /* min followed by max */
> -                         cpu-idle-states = <&CPU_SLEEP>, <&CLUSTER_SLEEP>;
> -                         thermal-idle {
> -                                 #cooling-cells = <2>;
> -                                 duration-us = <10000>;
> -                                 exit-latency-us = <500>;
> -                         };
> +            cpu_b0: cpu@100 {
> +                device_type = "cpu";
> +                compatible = "arm,cortex-a72";
> +                reg = <0x0 0x100>;
> +                enable-method = "psci";
> +                capacity-dmips-mhz = <1024>;
> +                dynamic-power-coefficient = <436>;
> +                #cooling-cells = <2>; /* min followed by max */
> +                cpu-idle-states = <&CPU_SLEEP>, <&CLUSTER_SLEEP>;
> +                thermal-idle {
> +                    #cooling-cells = <2>;
> +                    duration-us = <10000>;
> +                    exit-latency-us = <500>;
> +                };
> +            };
> +
> +            cpu_b1: cpu@101 {
> +                device_type = "cpu";
> +                compatible = "arm,cortex-a72";
> +                reg = <0x0 0x101>;
> +                enable-method = "psci";
> +                capacity-dmips-mhz = <1024>;
> +                dynamic-power-coefficient = <436>;
> +                #cooling-cells = <2>; /* min followed by max */
> +                cpu-idle-states = <&CPU_SLEEP>, <&CLUSTER_SLEEP>;
> +                thermal-idle {
> +                    #cooling-cells = <2>;
> +                    duration-us = <10000>;
> +                    exit-latency-us = <500>;
>                   };
> +            };
>   
> -                cpu_b1: cpu@101 {
> -                        device_type = "cpu";
> -                        compatible = "arm,cortex-a72";
> -                        reg = <0x0 0x101>;
> -                        enable-method = "psci";
> -                        capacity-dmips-mhz = <1024>;
> -                        dynamic-power-coefficient = <436>;
> -                        #cooling-cells = <2>; /* min followed by max */
> -                        cpu-idle-states = <&CPU_SLEEP>, <&CLUSTER_SLEEP>;
> -                        thermal-idle {
> -                                #cooling-cells = <2>;
> -                                duration-us = <10000>;
> -                                exit-latency-us = <500>;
> -                        };
> -                 };
> -
> -          /* ... */
> +            /* ... */
>   
> -    };
> +        };
>   
> -    /* ... */
> +        /* ... */
>   
> -    thermal_zones {
> -         cpu_thermal: cpu {
> +        thermal_zones {
> +            cpu_thermal: cpu {
>                   polling-delay-passive = <100>;
>                   polling-delay = <1000>;
>   
>                   /* ... */
>   
>                   trips {
> -                        cpu_alert0: cpu_alert0 {
> -                                    temperature = <65000>;
> -                                    hysteresis = <2000>;
> -                                    type = "passive";
> -                        };
> -
> -                        cpu_alert1: cpu_alert1 {
> -                                    temperature = <70000>;
> -                                    hysteresis = <2000>;
> -                                    type = "passive";
> -                        };
> -
> -                        cpu_alert2: cpu_alert2 {
> -                                    temperature = <75000>;
> -                                    hysteresis = <2000>;
> -                                    type = "passive";
> -                        };
> -
> -                        cpu_crit: cpu_crit {
> -                                    temperature = <95000>;
> -                                    hysteresis = <2000>;
> -                                    type = "critical";
> -                        };
> +                    cpu_alert0: cpu_alert0 {
> +                        temperature = <65000>;
> +                        hysteresis = <2000>;
> +                        type = "passive";
> +                    };
> +
> +                    cpu_alert1: cpu_alert1 {
> +                        temperature = <70000>;
> +                        hysteresis = <2000>;
> +                        type = "passive";
> +                    };
> +
> +                    cpu_alert2: cpu_alert2 {
> +                        temperature = <75000>;
> +                        hysteresis = <2000>;
> +                        type = "passive";
> +                    };
> +
> +                    cpu_crit: cpu_crit {
> +                        temperature = <95000>;
> +                        hysteresis = <2000>;
> +                        type = "critical";
> +                    };
>                   };
>   
>                   cooling-maps {
> -                        map0 {
> -                             trip = <&cpu_alert1>;
> -                             cooling-device = <&{/cpus/cpu@100/thermal-idle} 0 15 >,
> -                                              <&{/cpus/cpu@101/thermal-idle} 0 15>;
> -                        };
> -
> -                        map1 {
> -                             trip = <&cpu_alert2>;
> -                             cooling-device =
> -                                        <&cpu_b0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> -                                        <&cpu_b1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
> -                       };
> +                    map0 {
> +                        trip = <&cpu_alert1>;
> +                        cooling-device = <&cpu_b0 0 15 >,
> +                                         <&cpu_b1 0 15>;

This is pointing to the DVFS cooling device, not the idle cooling 
device. Should it be <&cpu_b0_idle 0 15> and that label defined in 
thermal_idle ?

> +                    };
> +
> +                    map1 {
> +                        trip = <&cpu_alert2>;
> +                        cooling-device = <&cpu_b0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +                                         <&cpu_b1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
> +                    };
>                   };
> -          };
> +            };
> +        };
>       };

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

