Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB7B85EF452
	for <lists+linux-pm@lfdr.de>; Thu, 29 Sep 2022 13:31:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235290AbiI2Lbb (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 29 Sep 2022 07:31:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235100AbiI2Lba (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 29 Sep 2022 07:31:30 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1156713C873
        for <linux-pm@vger.kernel.org>; Thu, 29 Sep 2022 04:31:28 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id d42so1837976lfv.0
        for <linux-pm@vger.kernel.org>; Thu, 29 Sep 2022 04:31:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=cNbvBpJQ8ytsaQU5m5L7uhDa6I7TxFtFcCoKpSC+nFg=;
        b=W1V/Q3GOj1L0xzmOMHfldXmwA0xiI87MV8akcr2iy7CI8ojb02e3ycmVFQiQ4pe6Tz
         HSD/tNHZSJceUOQJ3KZcMLEEXn+wCM5dDMCaAsHY7TSLk+6PRTT+z+Vc1tBfgiegpqiy
         M9PmBEa5As7rJ1ZwXFkQMcSvRGd48NSimRi6n7yFOTE+oncYUHefUqhShvDIGjxmPUC/
         zBBDeUOHSC33O9mzMbTOtTOGLn49o40BE1MmJVdHIHmFxSp18MRYADUPj3tEm2IvjtnC
         vcYEA0/xhwSVeIR5cONyJyv4jNmIYyGCaO2LnJBvgHTqhJzjSP5yKS1b1G9lIJJ68yTI
         +z+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=cNbvBpJQ8ytsaQU5m5L7uhDa6I7TxFtFcCoKpSC+nFg=;
        b=1l1JFVUxuJ5P3SaUlKir59SUUmlCOZHcXenDwr7FoOSL1+doCxwB2ZyPOBQCMVOszo
         ELn14zzROiJEr6eBSANdd+qesAADxaopuBDR9kHVX3uzVik00lux/8/8b1zJTpYmzTF4
         Yr59Ni9OKS2WZVBLYXLnOb0n8v+/qcCcewgC7LHwciTOLhkSRhQnbi+Z2qqJFsPEq+vg
         0WktVda7pErCLYfpvmM5rHLFd6rWeQEpaei7Tg+s1wMKL3BRITk4MBYmE4/6UO/+atFP
         kPcOH7+GGLdjljkMEygUibzILPMPOET72E4CQg+Zh1emDHMWioYK8skvqbd+v6yA+OI1
         cnBQ==
X-Gm-Message-State: ACrzQf2N/ykm6h2f/mp+f1kvVOKWLOsbCiw9pw8q3EPfnZNTDuPnmcVa
        Fw9DndKQXJerk9PVNE/ctPtTnBKlzTY+dw==
X-Google-Smtp-Source: AMsMyM7/7burRUOysN5RGdTSdq7pYL2TS5pJVCGWHCWIFB0cZWr4oLtY45IVvxvQJsFPk52kWZElFw==
X-Received: by 2002:a05:6512:511:b0:4a1:d9f3:ea10 with SMTP id o17-20020a056512051100b004a1d9f3ea10mr1255898lfb.555.1664451086461;
        Thu, 29 Sep 2022 04:31:26 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id v16-20020a056512049000b0048aef1abb08sm756680lfq.297.2022.09.29.04.31.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Sep 2022 04:31:26 -0700 (PDT)
Message-ID: <8322b054-27c4-32c5-53a4-abb40845d66c@linaro.org>
Date:   Thu, 29 Sep 2022 13:31:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH 1/2] dt-bindings: power: supply: Add Richtek RT9467
 battery charger
Content-Language: en-US
To:     ChiaEn Wu <peterwu.pub@gmail.com>, sre@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org
Cc:     chiaen_wu@richtek.com, cy_huang@richtek.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
References: <cover.1664475743.git.chiaen_wu@richtek.com>
 <2590163cabaef9ece537c5453eeef9f259e56cef.1664475743.git.chiaen_wu@richtek.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <2590163cabaef9ece537c5453eeef9f259e56cef.1664475743.git.chiaen_wu@richtek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 29/09/2022 12:37, ChiaEn Wu wrote:
> From: ChiaEn Wu <chiaen_wu@richtek.com>
> 
> Add bindings for the Richtek RT9467 battery charger.
> 
> Co-developed-by: ChiYuan Huang <cy_huang@richtek.com>
> Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
> Signed-off-by: ChiaEn Wu <chiaen_wu@richtek.com>
> ---

Thank you for your patch. There is something to discuss/improve.

> +
> +  reg:
> +    maxItems: 1
> +
> +  wakeup-source: true
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  charge-enable-gpios:
> +    description: GPIO is used to turn on and off charging.
> +    maxItems: 1
> +
> +  usb-otg-vbus-regulator:
> +    type: object
> +    description: OTG boost regulator.
> +    unevaluatedProperties: false
> +    $ref: /schemas/regulator/regulator.yaml#
> +
> +    properties:
> +      enable-gpios:
> +        maxItems: 1

maxItems are coming from gpio-consumer-common.yaml, so just
enable-gpios: true

> +
> +required:
> +  - compatible
> +  - reg
> +  - wakeup-source
> +  - interrupts
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    #include <dt-bindings/gpio/gpio.h>
> +    i2c {
> +      #address-cells = <1>;
> +      #size-cells = <0>;
> +
> +      rt9467@5b {

Node names should be generic.
https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation

> +        compatible = "richtek,rt9467-charger";
> +        reg = <0x5b>;
> +        wakeup-source;
> +        interrupts-extended = <&gpio_intc 32 IRQ_TYPE_LEVEL_LOW>;
> +        charge-enable-gpios = <&gpio26 1 0>;

Use defines for GPIO flags.

> +
> +        rt9467_otg_vbus: usb-otg-vbus-regulator {
> +          regulator-name = "rt9467-usb-otg-vbus";
> +          regulator-min-microvolt = <4425000>;
> +          regulator-max-microvolt = <5825000>;
> +          regulator-min-microamp = <500000>;
> +          regulator-max-microamp = <3000000>;
> +        };
> +      };
> +    };

Best regards,
Krzysztof

