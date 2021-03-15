Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E02C33C5D9
	for <lists+linux-pm@lfdr.de>; Mon, 15 Mar 2021 19:38:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229761AbhCOSiR (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 15 Mar 2021 14:38:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:54850 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231801AbhCOSiD (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 15 Mar 2021 14:38:03 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4544264F3F;
        Mon, 15 Mar 2021 18:38:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615833483;
        bh=uF298eM0LgGS85hwZQZdhr2Tvj40xbTDjSMSlStBdiE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=WY3ykGyuf2z16E//2lN9Ht4BBF7x9q9KAlNOEsa3TVvelBahqe/tGWegrMKsNhzHX
         phPZe+Wpi00XbfBRmrjKzI+ZbNVtUUKasaegNWyRoCqpJ5zcpR8sc/BJWhf6VV3a4f
         c44sLRf8C8rsk+Ewhx12kvZRjEr2mHrGHZV8Q5R/6A3lC4V7P4d1oUyGZ5u6SLG+Cp
         4fEq7VpyA51Ne70DgHNTg329XW/sbk2vjSC2xOSd3+scDieO4laW3OB+hLd/KE+Lm5
         CBYVdz1nP28jV+SzNa8Ycv7XEUTq4+lCGtGmGgvNzqJ9swhmC8hjrNIKCuX0mfx1qF
         nBMOyJl8QvUiQ==
Received: by mail-ed1-f44.google.com with SMTP id bx7so18533511edb.12;
        Mon, 15 Mar 2021 11:38:03 -0700 (PDT)
X-Gm-Message-State: AOAM531WKOyqOjbM6nkTr3yUTxf3DgqhrQpu09EUM1Vvn6NrMip5/s90
        urBz9vlJybvFQL09Cbyl8TWNDSj4Fz2rhfV+Xg==
X-Google-Smtp-Source: ABdhPJwCS5XJGWYKh7bAlUpniPAputEA0i7ZybxpT5socnCxDSiPxZONyhD2Zf8cAJBagyAbp/RgXRg26/VkuqaO2w8=
X-Received: by 2002:a05:6402:2d0:: with SMTP id b16mr31943444edx.194.1615833481821;
 Mon, 15 Mar 2021 11:38:01 -0700 (PDT)
MIME-Version: 1.0
References: <20210312154357.1561730-1-sebastian.reichel@collabora.com> <20210312154357.1561730-31-sebastian.reichel@collabora.com>
In-Reply-To: <20210312154357.1561730-31-sebastian.reichel@collabora.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Mon, 15 Mar 2021 12:37:50 -0600
X-Gmail-Original-Message-ID: <CAL_JsqL59Lq5=x-kxpjBwa3dactNVnhXbDPWTPe965DPOs-bWw@mail.gmail.com>
Message-ID: <CAL_JsqL59Lq5=x-kxpjBwa3dactNVnhXbDPWTPe965DPOs-bWw@mail.gmail.com>
Subject: Re: [PATCH 30/38] dt-bindings: power: supply: lp8727: Convert to DT
 schema format
To:     Sebastian Reichel <sebastian.reichel@collabora.com>
Cc:     Sebastian Reichel <sre@kernel.org>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Collabora Kernel ML <kernel@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Mar 12, 2021 at 8:52 AM Sebastian Reichel
<sebastian.reichel@collabora.com> wrote:
>
> Convert the binding to DT schema format.
>
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> ---
>  .../bindings/power/supply/lp8727_charger.txt  |  43 -------
>  .../bindings/power/supply/ti,lp8727.yaml      | 112 ++++++++++++++++++
>  2 files changed, 112 insertions(+), 43 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/power/supply/lp8727_charger.txt
>  create mode 100644 Documentation/devicetree/bindings/power/supply/ti,lp8727.yaml
>
> diff --git a/Documentation/devicetree/bindings/power/supply/lp8727_charger.txt b/Documentation/devicetree/bindings/power/supply/lp8727_charger.txt
> deleted file mode 100644
> index 0355a4b68f79..000000000000
> --- a/Documentation/devicetree/bindings/power/supply/lp8727_charger.txt
> +++ /dev/null
> @@ -1,43 +0,0 @@
> -Binding for TI/National Semiconductor LP8727 Charger
> -
> -Required properties:
> -- compatible: "ti,lp8727"
> -- reg: I2C slave address 27h
> -
> -Optional properties:
> -- interrupts: interrupt specifier (see interrupt binding[0])
> -- debounce-ms: interrupt debounce time. (u32)
> -
> -AC and USB charging parameters
> -- charger-type: "ac" or "usb" (string)
> -- eoc-level: value of 'enum lp8727_eoc_level' (u8)
> -- charging-current: value of 'enum lp8727_ichg' (u8)
> -
> -[0]: Documentation/devicetree/bindings/interrupt-controller/interrupts.txt
> -
> -Example)
> -
> -lp8727@27 {
> -       compatible = "ti,lp8727";
> -       reg = <0x27>;
> -
> -       /* GPIO 134 is used for LP8728 interrupt pin */
> -       interrupt-parent = <&gpio5>;    /* base = 128 */
> -       interrupts = <6 0x2>;           /* offset = 6, falling edge type */
> -
> -       debounce-ms = <300>;
> -
> -       /* AC charger: 5% EOC and 500mA charging current */
> -       ac {
> -               charger-type = "ac";
> -               eoc-level = /bits/ 8 <0>;
> -               charging-current = /bits/ 8 <4>;
> -       };
> -
> -       /* USB charger: 10% EOC and 400mA charging current */
> -       usb {
> -               charger-type = "usb";
> -               eoc-level = /bits/ 8 <1>;
> -               charging-current = /bits/ 8 <2>;
> -       };
> -};
> diff --git a/Documentation/devicetree/bindings/power/supply/ti,lp8727.yaml b/Documentation/devicetree/bindings/power/supply/ti,lp8727.yaml
> new file mode 100644
> index 000000000000..65894b36a69d
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/power/supply/ti,lp8727.yaml
> @@ -0,0 +1,112 @@
> +# SPDX-License-Identifier: GPL-2.0
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/power/supply/ti,lp8727.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Binding for TI/National Semiconductor LP8727 Charger
> +
> +maintainers:
> +  - Sebastian Reichel <sre@kernel.org>
> +
> +allOf:
> +  - $ref: power-supply.yaml#
> +
> +properties:
> +  compatible:
> +    const: ti,lp8727
> +
> +  reg:
> +    const: 0x27
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  debounce-ms:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: interrupt debounce time in ms
> +
> +  ac:
> +    type: object
> +    description: AC charging parameters
> +    properties:
> +      charger-type:
> +        const: ac
> +
> +      eoc-level:
> +        $ref: /schemas/types.yaml#/definitions/uint8
> +        minimum: 0
> +        maximum: 6
> +        description: |
> +          End of Charge Percentage with the following mapping:
> +          0 = 5%, 1 = 10%, 2 = 16%, 3 = 20%, 4 = 25%, 5 = 33%, 6 = 50%
> +
> +      charging-current:
> +        $ref: /schemas/types.yaml#/definitions/uint8
> +        minimum: 0
> +        maximum: 9
> +        description: |
> +          Charging current with the following mapping:
> +          0 = 90mA, 1 = 100mA, 2 = 400mA, 3 = 450mA, 4 = 500mA, 5 = 600mA,
> +          6 = 700mA, 7 = 800mA, 8 = 900mA, 9 = 1000mA
> +
> +  usb:
> +    type: object
> +    description: USB charging parameters
> +    properties:
> +      charger-type:
> +        const: usb
> +
> +      eoc-level:
> +        $ref: /schemas/types.yaml#/definitions/uint8
> +        minimum: 0
> +        maximum: 6
> +        description: |
> +          End of Charge Percentage with the following mapping:
> +          0 = 5%, 1 = 10%, 2 = 16%, 3 = 20%, 4 = 25%, 5 = 33%, 6 = 50%
> +
> +      charging-current:
> +        $ref: /schemas/types.yaml#/definitions/uint8
> +        minimum: 0
> +        maximum: 9
> +        description: |
> +          Charging current with the following mapping:
> +          0 = 90mA, 1 = 100mA, 2 = 400mA, 3 = 450mA, 4 = 500mA, 5 = 600mA,
> +          6 = 700mA, 7 = 800mA, 8 = 900mA, 9 = 1000mA

You can avoid the duplication here with:

patternProperties:
  '^(ac|usb)$':
     type: object
     ...

> +
> +required:
> +  - compatible
> +  - reg
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    i2c0 {
> +      #address-cells = <1>;
> +      #size-cells = <0>;
> +
> +      lp8727: charger@27 {
> +        compatible = "ti,lp8727";
> +        reg = <0x27>;
> +        interrupt-parent = <&gpio5>;
> +        interrupts = <6 IRQ_TYPE_EDGE_FALLING>;
> +        debounce-ms = <300>;
> +
> +        /* AC charger: 5% EOC and 500mA charging current */
> +        ac {
> +          charger-type = "ac";
> +          eoc-level = /bits/ 8 <0>;
> +          charging-current = /bits/ 8 <4>;
> +        };
> +
> +        /* USB charger: 10% EOC and 400mA charging current */
> +        usb {
> +          charger-type = "usb";
> +          eoc-level = /bits/ 8 <1>;
> +          charging-current = /bits/ 8 <2>;
> +        };
> +      };
> +    };
> +
> --
> 2.30.1
>
