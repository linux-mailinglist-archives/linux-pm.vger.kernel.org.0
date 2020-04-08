Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6993E1A1CA5
	for <lists+linux-pm@lfdr.de>; Wed,  8 Apr 2020 09:30:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726689AbgDHHaO (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 8 Apr 2020 03:30:14 -0400
Received: from mail-vs1-f68.google.com ([209.85.217.68]:45908 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726894AbgDHHaN (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 8 Apr 2020 03:30:13 -0400
Received: by mail-vs1-f68.google.com with SMTP id x82so4065535vsc.12
        for <linux-pm@vger.kernel.org>; Wed, 08 Apr 2020 00:30:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=verdurent-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OD0elTcRIMFole7OUjT/DPArTHrKmfnpdtzqT2CbEcI=;
        b=GNlgSOyiQVP/6vjJXE5Rs4MFQbMsECQtEYiSwZIozcKyRs9mM4wRwjT22otR46/bpO
         ugZ0Iyn1HrM55Y5B+2Z2FQuJBHYxKWKO8FWDVeOxDerfhaPBbEyyOJk3Y10aDHk0TjAW
         PLJA7f6mYqIA9YTyjPORzo870AqyXh6ywRbcQ/3f9Leq5QMxdDAgAIoeLt76D3gdwqJ9
         3MNqNWCByDkHGQ7MTsliT4ScHxUkOr+sD0/eP1A8bnbGa+gsLo4/1hFICx9OnlRnjcGc
         iqIBMnR9TSOEDIp0jJukL+HTyhqGnhOv0GFgZcf0UYNRRluNUWJ6WdujUSDa63WYSgCS
         /hdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OD0elTcRIMFole7OUjT/DPArTHrKmfnpdtzqT2CbEcI=;
        b=FDlQYDRhmg8ptvZVlWuwbRfHmxefD+idQp3ExO77jXv2u4ThdcXJVxfrozyEEvT+hn
         LIcuPeFC4MRM6fjEawlpraOaob6RU9LW/Ra2U8qExWvCSbAXZJ4IobMKEY4F57ItVffw
         ooV8i9dTXcnlz/oEGWA1rpeeLpe62GcUF2hI+5r2isunMsDVvPzA8oYwaWlT/5C+tyQT
         ypt2+CpJbvQqhOUCW7preJw4gyXv3HtretBXuocV1edvvHt0XUdurxBDuSgHxQSOI5lU
         IODRjPZYdlJOAu/Cdy4M1noBOMYsXrwa5hl6BHPJZAh/xi1+dl63wYa+2E1VQw/wQUdk
         +MKA==
X-Gm-Message-State: AGi0PuYjT//jqm4Qjm1dyrov5kBSBfpNeSaMo3pDTihvlZqTImtcLT7m
        6UMJbZIzkjyrfc+8MRlrdgA4yjhqeu7cEDoFmv+urg==
X-Google-Smtp-Source: APiQypJT4BDwUnwGDmpI1r6J0epGgiyiPB5hfa/7yBBHYhqblfZim4j2sA6EX0KF68n7dcnpUQxer/An5Kt5MflCHmU=
X-Received: by 2002:a67:4242:: with SMTP id p63mr1661875vsa.159.1586331012758;
 Wed, 08 Apr 2020 00:30:12 -0700 (PDT)
MIME-Version: 1.0
References: <20200407055116.16082-1-j-keerthy@ti.com> <20200407055116.16082-2-j-keerthy@ti.com>
In-Reply-To: <20200407055116.16082-2-j-keerthy@ti.com>
From:   Amit Kucheria <amit.kucheria@verdurent.com>
Date:   Wed, 8 Apr 2020 13:00:00 +0530
Message-ID: <CAHLCerOYfG4eifkWdecJ49cSx05pgDwc30L3zZuu0d9dVQN-AQ@mail.gmail.com>
Subject: Re: [PATCH v6 1/4] dt-bindings: thermal: k3: Add VTM bindings documentation
To:     Keerthy <j-keerthy@ti.com>
Cc:     Zhang Rui <rui.zhang@intel.com>, Rob Herring <robh+dt@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>, t-kristo@ti.com,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        lakml <linux-arm-kernel@lists.infradead.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Apr 7, 2020 at 11:21 AM Keerthy <j-keerthy@ti.com> wrote:
>
> Add VTM bindings documentation. In the Voltage Thermal
> Management Module(VTM), K3 AM654 supplies a voltage
> reference and a temperature sensor feature that are gathered in the band
> gap voltage and temperature sensor (VBGAPTS) module. The band
> gap provides current and voltage reference for its internal
> circuits and other analog IP blocks. The analog-to-digital
> converter (ADC) produces an output value that is proportional
> to the silicon temperature.
>
> Signed-off-by: Keerthy <j-keerthy@ti.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
Reviewed-by: Amit Kucheria <amit.kucheria@linaro.org>

> ---
>
> Changes in v6:
>
>   * Reordered the properties to match the order of definition.
>
>  .../bindings/thermal/ti,am654-thermal.yaml    | 56 +++++++++++++++++++
>  1 file changed, 56 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/thermal/ti,am654-thermal.yaml
>
> diff --git a/Documentation/devicetree/bindings/thermal/ti,am654-thermal.yaml b/Documentation/devicetree/bindings/thermal/ti,am654-thermal.yaml
> new file mode 100644
> index 000000000000..25b9209c2e5d
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/thermal/ti,am654-thermal.yaml
> @@ -0,0 +1,56 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/thermal/ti,am654-thermal.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Texas Instruments AM654 VTM (DTS) binding
> +
> +maintainers:
> +  - Keerthy <j-keerthy@ti.com>
> +
> +properties:
> +  compatible:
> +    const: ti,am654-vtm
> +
> +  reg:
> +    maxItems: 1
> +
> +  power-domains:
> +    maxItems: 1
> +
> +  "#thermal-sensor-cells":
> +    const: 1
> +
> +required:
> +  - compatible
> +  - reg
> +  - power-domains
> +  - "#thermal-sensor-cells"
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/soc/ti,sci_pm_domain.h>
> +    vtm: thermal@42050000 {
> +        compatible = "ti,am654-vtm";
> +        reg = <0x0 0x42050000 0x0 0x25c>;
> +        power-domains = <&k3_pds 80 TI_SCI_PD_EXCLUSIVE>;
> +        #thermal-sensor-cells = <1>;
> +    };
> +
> +    mpu0_thermal: mpu0_thermal {
> +        polling-delay-passive = <250>; /* milliseconds */
> +        polling-delay = <500>; /* milliseconds */
> +        thermal-sensors = <&vtm0 0>;
> +
> +        trips {
> +                mpu0_crit: mpu0_crit {
> +                        temperature = <125000>; /* milliCelsius */
> +                        hysteresis = <2000>; /* milliCelsius */
> +                        type = "critical";
> +                };
> +        };
> +    };
> +...
> --
> 2.17.1
>
