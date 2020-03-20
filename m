Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C01B618DB2B
	for <lists+linux-pm@lfdr.de>; Fri, 20 Mar 2020 23:31:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727015AbgCTWbN (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 20 Mar 2020 18:31:13 -0400
Received: from mail-il1-f195.google.com ([209.85.166.195]:41330 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726666AbgCTWbN (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 20 Mar 2020 18:31:13 -0400
Received: by mail-il1-f195.google.com with SMTP id l14so7134631ilj.8;
        Fri, 20 Mar 2020 15:31:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=JbU2dosdCini5Alcj8LeOFq9N2sPnu4NOnoc6JVvZkQ=;
        b=gRLeJDD0siZslsZu3I7LXo+10yfLrrflYELUhK8sRCGJEDG+taBFfTRczAFjKxigih
         oZjq43XyLWiCyRyXfbCVWednSDrsUvSq1BtqFV117NbhIJlE+yoLfr8e+vuS9kwBkpxG
         etHqJ9WAW6aW2OUAyxAZbQhPxckzJ6nbmEvkspg3pL3BOqqxBvb5KRiQaAXP2C+f7c6l
         AtP4BLJR4IBu+4gySbbJb1Dq4GIeEnfoQ2g9XwgRElhdRAjTu4akalXXTMiQSjQ+00cL
         r8WNgcGbH62x1Ph8WUT6MqG5kYkaGWNPYrPyGpUTiPKUnwi6IpqF1VBrQYBBzp+sx7zG
         oEYg==
X-Gm-Message-State: ANhLgQ0hamFdXDoMI0PWJ/Ni2GVXaPBqt4JPqbDrJlWgW2SUQ6aekSzG
        eGzp0FhUe7c59UUEmQ+fbw==
X-Google-Smtp-Source: ADFU+vuAr/1geagueED3n6s9IMNErC9xfjnITMbv0Pm2Y2IjvNLGuYkP1Q5LKBmI3AJRO4CpVTCi3w==
X-Received: by 2002:a92:af8c:: with SMTP id v12mr11221455ill.6.1584743472284;
        Fri, 20 Mar 2020 15:31:12 -0700 (PDT)
Received: from rob-hp-laptop ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id q6sm2444398ild.70.2020.03.20.15.31.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2020 15:31:11 -0700 (PDT)
Received: (nullmailer pid 14819 invoked by uid 1000);
        Fri, 20 Mar 2020 22:31:08 -0000
Date:   Fri, 20 Mar 2020 16:31:08 -0600
From:   Rob Herring <robh@kernel.org>
To:     Tobias Schramm <t.schramm@manjaro.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Sebastian Reichel <sre@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Maxime Ripard <mripard@kernel.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Heiko Stuebner <heiko.stuebner@theobroma-systems.com>,
        Stephan Gerhold <stephan@gerhold.net>,
        Mark Brown <broonie@kernel.org>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 2/3] dt-bindings: power: supply: add cw2015_battery
 bindings
Message-ID: <20200320223108.GB32311@bogus>
References: <20200315191914.118565-1-t.schramm@manjaro.org>
 <20200315191914.118565-3-t.schramm@manjaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200315191914.118565-3-t.schramm@manjaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sun, Mar 15, 2020 at 08:19:13PM +0100, Tobias Schramm wrote:
> This patch adds the dts binding schema for the cw2015 fuel gauge.
> 
> Signed-off-by: Tobias Schramm <t.schramm@manjaro.org>
> ---
>  .../bindings/power/supply/cw2015_battery.yaml | 83 +++++++++++++++++++
>  1 file changed, 83 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/power/supply/cw2015_battery.yaml
> 
> diff --git a/Documentation/devicetree/bindings/power/supply/cw2015_battery.yaml b/Documentation/devicetree/bindings/power/supply/cw2015_battery.yaml
> new file mode 100644
> index 000000000000..f789882312da
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/power/supply/cw2015_battery.yaml
> @@ -0,0 +1,83 @@
> +# SPDX-License-Identifier: GPL-2.0

Dual license new bindings please:

(GPL-2.0-only OR BSD-2-Clause)

> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/power/supply/cw2015_battery.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Battery driver for CW2015 shuntless fuel gauge by CellWise.
> +
> +maintainers:
> +  - Tobias Schramm <t.schramm@manjaro.org>
> +
> +description: |
> +  The driver can utilize information from a simple-battery linked via a
> +  phandle in monitored-battery. If specified the driver uses the
> +  charge-full-design-microamp-hours property of the battery.
> +
> +properties:
> +  compatible:
> +    const: cellwise,cw2015
> +
> +  reg:
> +    items:
> +      - description: i2c address

Just:

maxItems: 1

> +
> +  cellwise,battery-profile:
> +    description: |
> +      This property specifies characteristics of the battery used. The format
> +      of this binary blob is kept secret by CellWise. The only way to obtain
> +      it is to mail two batteries to a test facility of CellWise and receive
> +      back a test report with the binary blob.
> +    allOf:
> +      - $ref: /schemas/types.yaml#definitions/uint8-array
> +    items:
> +      - minItems: 64
> +        maxItems: 64
> +
> +  cellwise,monitor-interval-ms:
> +    description:
> +      Specifies the interval in milliseconds gauge values are polled at
> +    $ref: /schemas/types.yaml#/definitions/uint32

Drop this as standard units already have a type definition. Is there 
some bounds to this?

> +
> +  power-supplies:
> +    description:
> +      Specifies supplies used for charging the battery connected to this gauge
> +    allOf:
> +      - $ref: /schemas/types.yaml#/definitions/phandle-array
> +      - minItems: 1
> +        maxItems: 8 # Should be enough
> +
> +  monitored-battery:
> +    description:
> +      Specifies the phandle of a simple-battery connected to this gauge
> +    $ref: /schemas/types.yaml#/definitions/phandle

These 2 properties should really have a common definition, but fine for 
now. 

> +
> +required:
> +  - compatible
> +  - reg
> +
> +examples:
> +  - |
> +    i2c {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        cw2015@62 {
> +            compatible = "cellwise,cw201x";
> +            reg = <0x62>;
> +            cellwise,battery-profile = /bits/ 8 <
> +                0x17 0x67 0x80 0x73 0x6E 0x6C 0x6B 0x63
> +                0x77 0x51 0x5C 0x58 0x50 0x4C 0x48 0x36
> +                0x15 0x0C 0x0C 0x19 0x5B 0x7D 0x6F 0x69
> +                0x69 0x5B 0x0C 0x29 0x20 0x40 0x52 0x59
> +                0x57 0x56 0x54 0x4F 0x3B 0x1F 0x7F 0x17
> +                0x06 0x1A 0x30 0x5A 0x85 0x93 0x96 0x2D
> +                0x48 0x77 0x9C 0xB3 0x80 0x52 0x94 0xCB
> +                0x2F 0x00 0x64 0xA5 0xB5 0x11 0xF0 0x11
> +           >;
> +           cellwise,monitor-interval-ms = <5000>;
> +           monitored-battery = <&bat>;
> +           power-supplies = <&mains_charger>, <&usb_charger>;
> +       };
> +    };
> +
> -- 
> 2.24.1
> 
