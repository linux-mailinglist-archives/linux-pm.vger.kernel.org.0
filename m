Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 60F411A4927
	for <lists+linux-pm@lfdr.de>; Fri, 10 Apr 2020 19:37:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726657AbgDJRhl (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 10 Apr 2020 13:37:41 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:46338 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726234AbgDJRhl (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 10 Apr 2020 13:37:41 -0400
Received: by mail-ot1-f66.google.com with SMTP id w12so1606169otm.13;
        Fri, 10 Apr 2020 10:37:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=3DzWPSMEsDqR2opTja85cBCPhIQts4PfxTBGkXZroaQ=;
        b=WkFokMvg/CzPVzM5g/MLgUPyXZkxdim72SBOWKn2J/zipf6H6+CQ86yY0nvJY9ytkr
         4FPd9WLEFIOI9mSU0ooZ3CH3TQsOC4fLgNuaUrk3ECXar4HP9yYvxSCQ0r/Tpcf/yNjD
         rHdKbh12rvaEaGDO2xMumBlBvZY5rkl3bwGZ8A2AZeYbyMW9E/+Gu+s+IkbPWc25EGlK
         a7xctNEMW1/4M1BVpwfyrof1ZgK/wNxdEMT0B4RzY29gW2yBER/tNCe09oc+FxG8JN7t
         FpmFFqAJkIkz1otnYA/LdXzJ8KeatLtIDKzjdOOQXGS3824JGuFBytwp3lS0ZOk21fQH
         L/mw==
X-Gm-Message-State: AGi0Pubo3jQw0eI0B+J6qw1m744OfDOUDzwJoroAMHYPlhMC9OZRQX99
        YYtmBE4l2ZVl7GvoMEpo/w==
X-Google-Smtp-Source: APiQypINIQV/4Bo5nN9Dx7YP6T/eGrWbwgKzOk4myEIA8N7bcHl2Vzf+x4x26u1TXX3gZGQoaU2eeA==
X-Received: by 2002:a9d:728e:: with SMTP id t14mr5211727otj.63.1586540260381;
        Fri, 10 Apr 2020 10:37:40 -0700 (PDT)
Received: from rob-hp-laptop (ip-99-203-29-27.pools.cgn.spcsdns.net. [99.203.29.27])
        by smtp.gmail.com with ESMTPSA id 69sm1477933otm.60.2020.04.10.10.37.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2020 10:37:39 -0700 (PDT)
Received: (nullmailer pid 8157 invoked by uid 1000);
        Fri, 10 Apr 2020 16:49:05 -0000
Date:   Fri, 10 Apr 2020 11:49:05 -0500
From:   Rob Herring <robh@kernel.org>
To:     David Heidelberg <david@ixit.cz>
Cc:     Sebastian Reichel <sre@kernel.org>,
        Jonghwa Lee <jonghwa3.lee@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Myungjoo Ham <myungjoo.ham@samsung.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        John Stultz <john.stultz@linaro.org>,
        Vinay Simha BN <simhavcs@gmail.com>,
        mika.westerberg@linux.intel.com, ramakrishna.pallala@intel.com,
        Dmitry Osipenko <digetx@gmail.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 4/9] dt-bindings: power: supply: Add device-tree binding
 for Summit SMB3xx
Message-ID: <20200410164905.GA719@bogus>
References: <20200329161552.215075-1-david@ixit.cz>
 <20200329162128.218584-5-david@ixit.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200329162128.218584-5-david@ixit.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sun, Mar 29, 2020 at 06:21:23PM +0200, David Heidelberg wrote:
> Summit SMB3xx series is a Programmable Switching Li+ Battery Charger.
> This device-tree binding documents Summit SMB345, SMB347 and SMB358 chargers.
> 
> Signed-off-by: David Heidelberg <david@ixit.cz>
> ---
>  .../power/supply/summit,smb347-charger.yaml   | 224 ++++++++++++++++++
>  .../dt-bindings/power/summit,smb347-charger.h |  19 ++
>  2 files changed, 243 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/power/supply/summit,smb347-charger.yaml
>  create mode 100644 include/dt-bindings/power/summit,smb347-charger.h
> 
> diff --git a/Documentation/devicetree/bindings/power/supply/summit,smb347-charger.yaml b/Documentation/devicetree/bindings/power/supply/summit,smb347-charger.yaml
> new file mode 100644
> index 000000000000..1d6bccdcd233
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/power/supply/summit,smb347-charger.yaml
> @@ -0,0 +1,224 @@
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
> +  summit,enable-usb-charging:
> +    type: boolean
> +    description: Enable charging trough USB.
> +
> +  summit,enable-otg-charging:
> +    type: boolean
> +    description: Provide power for USB OTG
> +
> +  summit,enable-mains-charging:
> +    type: boolean
> +    description: Enable charging trough mains
> +
> +  summit,enable-chg-ctrl:
> +    description: Enable charging control
> +    allOf:
> +      - $ref: /schemas/types.yaml#/definitions/uint32
> +      - enum:
> +          - 0 # SMB3XX_CHG_ENABLE_SW SW (I2C interface)
> +          - 1 # SMB3XX_CHG_ENABLE_PIN_ACTIVE_LOW Pin control (Active Low)
> +          - 2 # SMB3XX_CHG_ENABLE_PIN_ACTIVE_HIGH Pin control (Active High)
> +
> +  summit,max-chg-curr:
> +    description: Maximum current for charging (in uA)
> +    allOf:
> +      - $ref: /schemas/types.yaml#/definitions/uint32
> +
> +  summit,max-chg-volt:
> +    description: Maximum voltage for charging (in uV)
> +    allOf:
> +      - $ref: /schemas/types.yaml#/definitions/uint32
> +    minimum: 3500000
> +    maximum: 4500000
> +
> +  summit,pre-chg-curr:
> +    description: Pre-charging current for charging (in uA)
> +    allOf:
> +      - $ref: /schemas/types.yaml#/definitions/uint32
> +
> +  summit,term-curr:
> +    description: Charging cycle termination current (in uA)
> +    allOf:
> +      - $ref: /schemas/types.yaml#/definitions/uint32
> +
> +  summit,fast-volt-threshold:
> +    description: Voltage threshold to transit to fast charge mode (in uV)
> +    allOf:
> +      - $ref: /schemas/types.yaml#/definitions/uint32
> +    minimum: 2400000
> +    maximum: 3000000
> +
> +  summit,mains-curr-limit:
> +    description: Maximum input current from AC/DC input (in uA)
> +    allOf:
> +      - $ref: /schemas/types.yaml#/definitions/uint32
> +
> +  summit,usb-curr-limit:
> +    description: Maximum input current from USB input (in uA)
> +    allOf:
> +      - $ref: /schemas/types.yaml#/definitions/uint32

These are all properties of the battery attached and we have standard 
properties for some/all of these.

Also, any property with units should have a unit suffix as defined in 
property-units.txt. And with that, you don't need to define the type.

> +
> +  summit,chg-curr-comp:
> +    description: Charge current compensation (in uA)
> +    allOf:
> +      - $ref: /schemas/types.yaml#/definitions/uint32
> +
> +  summit,chip-temp-threshold:
> +    description: Chip temperature for thermal regulation in °C.
> +    allOf:
> +      - $ref: /schemas/types.yaml#/definitions/uint32
> +    enum: [100, 110, 120, 130]
> +
> +  summit,soft-cold-temp-limit:
> +    description: Cold battery temperature in °C for soft alarm.
> +    allOf:
> +      - $ref: /schemas/types.yaml#/definitions/uint32
> +    enum: [0, 5, 10, 15]
> +
> +  summit,soft-hot-temp-limit:
> +    description: Hot battery temperature in °C for soft alarm.
> +    allOf:
> +      - $ref: /schemas/types.yaml#/definitions/uint32
> +    enum: [40, 45, 50, 55]
> +
> +  summit,hard-cold-temp-limit:
> +    description: Cold battery temperature in °C for hard alarm.
> +    allOf:
> +      - $ref: /schemas/types.yaml#/definitions/int32
> +    enum: [-5, 0, 5, 10]
> +
> +  summit,hard-hot-temp-limit:
> +    description: Hot battery temperature in °C for hard alarm.
> +    allOf:
> +      - $ref: /schemas/types.yaml#/definitions/uint32
> +    enum: [50, 55, 60, 65]
> +
> +  summit,soft-comp-method:
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
> +        summit,max-chg-curr:
> +          enum: [ 200000,  450000,  600000,  900000,
> +                 1300000, 1500000, 1800000, 2000000]
> +
> +        summit,pre-chg-curr:
> +          enum: [150000, 250000, 350000, 450000]
> +
> +        summit,term-curr:
> +          enum: [ 30000,  40000,  60000,  80000,
> +                 100000, 125000, 150000, 200000]
> +
> +        summit,mains-curr-limit:
> +          enum: [ 300000,  500000,  700000, 1000000,
> +                 1500000, 1800000, 2000000]
> +
> +        summit,usb-curr-limit:
> +          enum: [ 300000,  500000,  700000, 1000000,
> +                 1500000, 1800000, 2000000]
> +
> +        summit,chg-curr-comp:
> +          enum: [200000, 450000, 600000, 900000]
> +
> +    else:
> +      properties:
> +        summit,max-chg-curr:
> +          enum: [ 700000,  900000, 1200000, 1500000,
> +                 1800000, 2000000, 2200000, 2500000]
> +
> +        summit,pre-chg-curr:
> +          enum: [100000, 150000, 200000, 250000]
> +
> +        summit,term-curr:
> +          enum: [ 37500,  50000, 100000, 150000,
> +                 200000, 250000, 500000, 600000]
> +
> +        summit,mains-curr-limit:
> +          enum: [ 300000,  500000,  700000,  900000, 1200000,
> +                 1500000, 1800000, 2000000, 2200000, 2500000]
> +
> +        summit,usb-curr-limit:
> +          enum: [ 300000,  500000,  700000,  900000, 1200000,
> +                 1500000, 1800000, 2000000, 2200000, 2500000]
> +
> +        summit,chg-curr-comp:
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
> +            summit,max-chg-curr = <1800000>;
> +            summit,mains-curr-limit = <2000000>;
> +            summit,usb-curr-limit = <500000>;
> +
> +            summit,chip-temp-threshold = <110>;
> +            summit,soft-cold-temp-limit = <5>;
> +
> +            summit,enable-usb-charging;
> +            summit,enable-mains-charging;
> +
> +            summit,enable-chg-ctrl = <SMB3XX_CHG_ENABLE_PIN_ACTIVE_HIGH>;
> +        };
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
> 2.25.0
> 
