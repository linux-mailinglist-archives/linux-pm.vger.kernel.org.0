Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B938A7CB4A
	for <lists+linux-pm@lfdr.de>; Wed, 31 Jul 2019 19:59:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728108AbfGaR73 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 31 Jul 2019 13:59:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:40730 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726079AbfGaR73 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 31 Jul 2019 13:59:29 -0400
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3C2E52067D;
        Wed, 31 Jul 2019 17:59:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564595968;
        bh=NEcDRzJevd+KIyIuh3CpjR4gF6t3vEc53p0FcWTtLWI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=V+3Cky9w/gnN4kXEMxDWMD5MnHLewZ1pxiIZf6mlIMfgMmoZxtIdr1/REo0Vwtwhq
         nvge4kVCvstMykA5EnaWeOTd3osufFD169n3Wqi/7ghc6YNIo5Su492hpn4AIxh4YE
         eEN//AmMDGNkJW4kZ7qDqyKHbSuItzAfyyA+/hY4=
Received: by mail-qk1-f174.google.com with SMTP id v22so49907124qkj.8;
        Wed, 31 Jul 2019 10:59:28 -0700 (PDT)
X-Gm-Message-State: APjAAAU+1F3tSQgcC/1rnZLlnMqzI2mJQJ6Us4Ry9BBTE++api3A/vBs
        B0xUwHlb37889MGoIxf1AKDU71zMVq3vQAH7IQ==
X-Google-Smtp-Source: APXvYqxkCHy8Mu4YbKN2nkHxuSAOaPMHVupqx/C61IqD07sDT2Vj84zboBJUD7SDLxAR33ZQy+yLAkoAgVxagzL0504=
X-Received: by 2002:a05:620a:1447:: with SMTP id i7mr83131890qkl.254.1564595967401;
 Wed, 31 Jul 2019 10:59:27 -0700 (PDT)
MIME-Version: 1.0
References: <20190731153529.30159-1-glaroque@baylibre.com> <20190731153529.30159-2-glaroque@baylibre.com>
In-Reply-To: <20190731153529.30159-2-glaroque@baylibre.com>
From:   Rob Herring <robh@kernel.org>
Date:   Wed, 31 Jul 2019 11:59:14 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLyhiLkpje8a4Qh5K21s9xU6k1kkR0OtyGPss8=efR5Sg@mail.gmail.com>
Message-ID: <CAL_JsqLyhiLkpje8a4Qh5K21s9xU6k1kkR0OtyGPss8=efR5Sg@mail.gmail.com>
Subject: Re: [PATCH v2 1/6] dt-bindings: thermal: Add DT bindings
 documentation for Amlogic Thermal
To:     Guillaume La Roque <glaroque@baylibre.com>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        devicetree@vger.kernel.org, linux-amlogic@lists.infradead.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Jul 31, 2019 at 9:36 AM Guillaume La Roque
<glaroque@baylibre.com> wrote:
>
> Adding the devicetree binding documentation for the Amlogic temperature
> sensor found in the Amlogic Meson G12 SoCs.
> the G12A  and G12B SoCs are supported.
>
> Signed-off-by: Guillaume La Roque <glaroque@baylibre.com>
> ---
>  .../bindings/thermal/amlogic,thermal.yaml     | 58 +++++++++++++++++++
>  1 file changed, 58 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/thermal/amlogic,thermal.yaml
>
> diff --git a/Documentation/devicetree/bindings/thermal/amlogic,thermal.yaml b/Documentation/devicetree/bindings/thermal/amlogic,thermal.yaml
> new file mode 100644
> index 000000000000..f10537ab4c8b
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/thermal/amlogic,thermal.yaml
> @@ -0,0 +1,58 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/thermal/amlogic,thermal.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Amlogic Thermal Driver

This is not a driver.

> +
> +maintainers:
> +  - Guillaume La Roque <glaroque@baylibre.com>
> +
> +description: Amlogic Thermal driver
> +
> +properties:
> +  compatible:
> +    oneOf:

oneOf is not necessary as there is only one of.

> +      - items:
> +          - enum:
> +              - amlogic,g12-cpu-thermal
> +              - amlogic,g12-ddr-thermal
> +          - const:
> +              - amlogic,g12-thermal

Please run 'make dt_binding_check'. You'll find this is not valid json-schema.

> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 1
> +
> +  amlogic,ao-secure:
> +    description: phandle to the ao-secure syscon
> +    allOf:
> +     - $ref: /schemas/types.yaml#/definitions/uint32
> +
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - clocks
> +  - amlogic,ao-secure
> +
> +examples:
> +  - |
> +        cpu_temp: temperature-sensor@ff634800 {
> +                compatible = "amlogic,g12-cpu-thermal",
> +                             "amlogic,g12-thermal";
> +                reg = <0x0 0xff634800 0x0 0x50>;

Examples are built now and this will have an error. The default
address and size cells are 1 for examples, so you either have to
override them or adjust this.

> +                interrupts = <0x0 0x24 0x0>;
> +                clocks = <&clk 164>;
> +                status = "okay";

Don't show status in examples.

> +                #thermal-sensor-cells = <0>;
> +                amlogic,ao-secure = <&sec_AO>;
> +        };
> +...
> \ No newline at end of file
> --
> 2.17.1
>
