Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E0D921E3B2
	for <lists+linux-pm@lfdr.de>; Tue, 14 Jul 2020 01:40:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726863AbgGMXkE (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 13 Jul 2020 19:40:04 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:34998 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726339AbgGMXkD (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 13 Jul 2020 19:40:03 -0400
Received: by mail-io1-f67.google.com with SMTP id v8so15427833iox.2;
        Mon, 13 Jul 2020 16:40:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=cGg7d7tV4w5UbMq23q7yKIkfee+l0kw7iwNJqfig+x8=;
        b=Vn/p25UEff09W/bfqmKcoXhETdtmyJmYWU1nYtey9t2AiTvdPalqFEBnELTf7ftwyI
         vaAWI5C+rC4LSBPp5HzPr750Zu97XtlyYDEY/UUigKO4YD6p2BaAElxh9zFboX6jfwQ+
         /02zqNMDGuUwqKv5HRx6ZKZ95H3nfkigEjR9j3zpyusg0g0AQYTVxW19FpITOa55Wl17
         /bNW/7xlQWUsURz31Lo6nnuEYAE6QQfTeW27BrbQfQ4GZ9G6hpSjDAFZM8bT9QxHzEAo
         If+CazcEyR8skK9ilTaQ1PPQzOu+3SINJT9jrGX7htnIQ5aFjlM3ms2No1rI4uX3zzly
         VbgA==
X-Gm-Message-State: AOAM531yKQXT6qubk6oiaL8zUUpyNvCcwJdq+SCNLr5UF/cecAaKiLNP
        M477WZZ6/4rARGcA3TE4Jw==
X-Google-Smtp-Source: ABdhPJwb293LXKyIEQNeGkK1sLAdpG1wm5kpKwV8Rtq3nT60dgt4JuKB9E6vIfN8wBhxnQXTG9ZGxg==
X-Received: by 2002:a05:6638:223:: with SMTP id f3mr2871376jaq.144.1594683602330;
        Mon, 13 Jul 2020 16:40:02 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id c9sm8950695ilm.57.2020.07.13.16.40.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2020 16:40:01 -0700 (PDT)
Received: (nullmailer pid 935209 invoked by uid 1000);
        Mon, 13 Jul 2020 23:39:59 -0000
Date:   Mon, 13 Jul 2020 17:39:59 -0600
From:   Rob Herring <robh@kernel.org>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Sebastian Reichel <sre@kernel.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        David Heidelberg <david@ixit.cz>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Jonghwa Lee <jonghwa3.lee@samsung.com>,
        John Stultz <john.stultz@linaro.org>,
        Vinay Simha BN <simhavcs@gmail.com>
Subject: Re: [PATCH v2 1/9] dt-bindings: power: supply: Add device-tree
 binding for Summit SMB3xx
Message-ID: <20200713233959.GA928559@bogus>
References: <20200607144113.10202-1-digetx@gmail.com>
 <20200607144113.10202-2-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200607144113.10202-2-digetx@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sun, Jun 07, 2020 at 05:41:05PM +0300, Dmitry Osipenko wrote:
> From: David Heidelberg <david@ixit.cz>
> 
> Summit SMB3xx series is a Programmable Switching Li+ Battery Charger.
> This patch adds device-tree binding for Summit SMB345, SMB347 and SMB358
> chargers.
> 
> Signed-off-by: David Heidelberg <david@ixit.cz>
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  .../power/supply/summit,smb347-charger.yaml   | 165 ++++++++++++++++++
>  .../dt-bindings/power/summit,smb347-charger.h |  19 ++
>  2 files changed, 184 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/power/supply/summit,smb347-charger.yaml
>  create mode 100644 include/dt-bindings/power/summit,smb347-charger.h
> 
> diff --git a/Documentation/devicetree/bindings/power/supply/summit,smb347-charger.yaml b/Documentation/devicetree/bindings/power/supply/summit,smb347-charger.yaml
> new file mode 100644
> index 000000000000..eea0a6398c95
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/power/supply/summit,smb347-charger.yaml
> @@ -0,0 +1,165 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: "http://devicetree.org/schemas/power/supply/summit,smb347-charger.yaml#"
> +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> +
> +title: Battery charger driver for SMB345, SMB347 and SMB358
> +
> +maintainers:
> +  - David Heidelberg <david@ixit.cz>
> +  - Dmitry Osipenko <digetx@gmail.com>
> +
> +properties:
> +  compatible:
> +    enum:
> +      - summit,smb345
> +      - summit,smb347
> +      - summit,smb358
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  monitored-battery:
> +    description: phandle to the battery node
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +
> +  summit,enable-usb-charging:
> +    type: boolean
> +    description: Enable charging through USB.
> +
> +  summit,enable-otg-charging:
> +    type: boolean
> +    description: Provide power for USB OTG
> +
> +  summit,enable-mains-charging:
> +    type: boolean
> +    description: Enable charging through mains
> +
> +  summit,enable-charge-control:
> +    description: Enable charging control
> +    allOf:
> +      - $ref: /schemas/types.yaml#/definitions/uint32
> +      - enum:
> +          - 0 # SMB3XX_CHG_ENABLE_SW SW (I2C interface)
> +          - 1 # SMB3XX_CHG_ENABLE_PIN_ACTIVE_LOW Pin control (Active Low)
> +          - 2 # SMB3XX_CHG_ENABLE_PIN_ACTIVE_HIGH Pin control (Active High)
> +
> +  summit,fast-voltage-threshold-microvolt:
> +    description: Voltage threshold to transit to fast charge mode (in uV)
> +    allOf:
> +      - $ref: /schemas/types.yaml#/definitions/uint32

Anything with a standard unit suffix already has a type, so drop.

> +    minimum: 2400000
> +    maximum: 3000000
> +
> +  summit,mains-current-limit-microamp:
> +    description: Maximum input current from AC/DC input (in uA)
> +    allOf:
> +      - $ref: /schemas/types.yaml#/definitions/uint32
> +
> +  summit,usb-current-limit-microamp:
> +    description: Maximum input current from USB input (in uA)
> +    allOf:
> +      - $ref: /schemas/types.yaml#/definitions/uint32
> +
> +  summit,charge-current-compensation-microamp:
> +    description: Charge current compensation (in uA)
> +    allOf:
> +      - $ref: /schemas/types.yaml#/definitions/uint32
> +
> +  summit,chip-temperature-threshold-celsius:
> +    description: Chip temperature for thermal regulation in °C.
> +    allOf:
> +      - $ref: /schemas/types.yaml#/definitions/uint32
> +    enum: [100, 110, 120, 130]
> +
> +  summit,soft-compensation-method:
> +    description: Soft temperature limit compensation method
> +    allOf:
> +      - $ref: /schemas/types.yaml#/definitions/uint32
> +      - enum:
> +          - 0 # SMB3XX_SOFT_TEMP_COMPENSATE_NONE Compensation none
> +          - 1 # SMB3XX_SOFT_TEMP_COMPENSATE_CURRENT Current compensation
> +          - 2 # SMB3XX_SOFT_TEMP_COMPENSATE_VOLTAGE Voltage compensation
> +
> +allOf:
> +  - if:
> +      properties:
> +        compatible:
> +          enum:
> +            - summit,smb345
> +            - summit,smb358
> +
> +    then:
> +      properties:
> +        summit,mains-current-limit-microamp:
> +          enum: [ 300000,  500000,  700000, 1000000,
> +                 1500000, 1800000, 2000000]
> +
> +        summit,usb-current-limit-microamp:
> +          enum: [ 300000,  500000,  700000, 1000000,
> +                 1500000, 1800000, 2000000]
> +
> +        summit,charge-current-compensation-microamp:
> +          enum: [200000, 450000, 600000, 900000]
> +
> +    else:
> +      properties:
> +        summit,mains-current-limit-microamp:
> +          enum: [ 300000,  500000,  700000,  900000, 1200000,
> +                 1500000, 1800000, 2000000, 2200000, 2500000]
> +
> +        summit,usb-current-limit-microamp:
> +          enum: [ 300000,  500000,  700000,  900000, 1200000,
> +                 1500000, 1800000, 2000000, 2200000, 2500000]
> +
> +        summit,charge-current-compensation-microamp:
> +          enum: [250000, 700000, 900000, 1200000]
> +
> +required:
> +  - compatible
> +  - reg
> +
> +anyOf:
> +  - required:
> +      - summit,enable-usb-charging
> +  - required:
> +      - summit,enable-otg-charging
> +  - required:
> +      - summit,enable-mains-charging
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/power/summit,smb347-charger.h>
> +
> +    i2c {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        charger@7f {
> +            compatible = "summit,smb347";
> +            reg = <0x7f>;
> +            status = "okay";
> +
> +            summit,enable-charge-control = <SMB3XX_CHG_ENABLE_PIN_ACTIVE_HIGH>;
> +            summit,chip-temperature-threshold-celsius = <110>;
> +            summit,mains-current-limit-microamp = <2000000>;
> +            summit,usb-current-limit-microamp = <500000>;
> +            summit,enable-usb-charging;
> +            summit,enable-mains-charging;
> +
> +            monitored-battery = <&battery>;
> +        };
> +    };
> +
> +    battery: battery-cell {
> +        compatible = "simple-battery";
> +        constant-charge-current-max-microamp = <1800000>;
> +        temperature-min-alert-celsius = <5>;
> +        temperature-max-alert-celsius = <40>;
> +    };
> diff --git a/include/dt-bindings/power/summit,smb347-charger.h b/include/dt-bindings/power/summit,smb347-charger.h
> new file mode 100644
> index 000000000000..d918bf321a71
> --- /dev/null
> +++ b/include/dt-bindings/power/summit,smb347-charger.h
> @@ -0,0 +1,19 @@
> +/* SPDX-License-Identifier: (GPL-2.0-or-later or MIT) */
> +/*
> + * Author: David Heidelberg <david@ixit.cz>
> + */
> +
> +#ifndef _DT_BINDINGS_SMB347_CHARGER_H
> +#define _DT_BINDINGS_SMB347_CHARGER_H
> +
> +/* Charging compensation method */
> +#define SMB3XX_SOFT_TEMP_COMPENSATE_NONE	0
> +#define SMB3XX_SOFT_TEMP_COMPENSATE_CURRENT	1
> +#define SMB3XX_SOFT_TEMP_COMPENSATE_VOLTAGE	2
> +
> +/* Charging enable control */
> +#define SMB3XX_CHG_ENABLE_SW			0
> +#define SMB3XX_CHG_ENABLE_PIN_ACTIVE_LOW	1
> +#define SMB3XX_CHG_ENABLE_PIN_ACTIVE_HIGH	2
> +
> +#endif
> -- 
> 2.26.0
> 
