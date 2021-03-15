Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 071CA33C5A0
	for <lists+linux-pm@lfdr.de>; Mon, 15 Mar 2021 19:28:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231513AbhCOS2K (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 15 Mar 2021 14:28:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:52342 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229806AbhCOS1r (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 15 Mar 2021 14:27:47 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id EEE3F64F42;
        Mon, 15 Mar 2021 18:27:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615832866;
        bh=qoYDstJDuKBPusQErDzsKJ7v8otxcmd+GoIi3yjBdvs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=DbkMKoXKBITh8xp1IDTw5UlEpIGgV3TC9Xt3eDaxf9ytfDqJqotl2s7hcr/e9rSwG
         O/PltwnQVJXFw3mjbY83DCoF1TtLzlc93Ivgk51slyXBzBuKJt7HT/kq8fdkXpCbMy
         EgVZfCSGdfMvfF5WoUFMSizIOJ6Z3Ew58eH1ywnpXmYdw/5U7/oewvwId5G+4oW0Bq
         I3avcRVRfRF75g77uZJRpGQnY0q4K0ENr9aLPIC3unksxUnnKZB4gr4Jrqsh6yeTfv
         A/3MQd1NGXr7ygmsckhrOrZJGiXW8wim+e1OJKj2If3ZhbCNBR7tm9KF0fCwkuQ4Oy
         j5DvAkYpAw+/w==
Received: by mail-ej1-f41.google.com with SMTP id dx17so67996214ejb.2;
        Mon, 15 Mar 2021 11:27:45 -0700 (PDT)
X-Gm-Message-State: AOAM5310jR4im5n2Da3fx0qeYBy174KtJahtgaOlTNvCVhXwZ8NQ03hn
        SLoFD/wIfI7jsD2bDXaWTXlCQEnyMaWuRypY+Q==
X-Google-Smtp-Source: ABdhPJzJml081H6SIYahYqA8uEEgm/OD0od3fSnVnZVgt4FXBjqGqhAOSfDHPUGyU/lLLWSzdhf5vI72e94Y+2JcZVE=
X-Received: by 2002:a17:906:7806:: with SMTP id u6mr4851146ejm.130.1615832864582;
 Mon, 15 Mar 2021 11:27:44 -0700 (PDT)
MIME-Version: 1.0
References: <20210312154357.1561730-1-sebastian.reichel@collabora.com> <20210312154357.1561730-12-sebastian.reichel@collabora.com>
In-Reply-To: <20210312154357.1561730-12-sebastian.reichel@collabora.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Mon, 15 Mar 2021 12:27:33 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+TLt0ousbggKGF5wEdJYLqofxt9a-qDqLCkq0AE_y2Rg@mail.gmail.com>
Message-ID: <CAL_Jsq+TLt0ousbggKGF5wEdJYLqofxt9a-qDqLCkq0AE_y2Rg@mail.gmail.com>
Subject: Re: [PATCH 11/38] dt-bindings: power: supply: sbs-manager: Convert to
 DT schema format
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

On Fri, Mar 12, 2021 at 8:45 AM Sebastian Reichel
<sebastian.reichel@collabora.com> wrote:
>
> Convert the binding to DT schema format.
>
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> ---
>  .../bindings/power/supply/sbs,sbs-manager.txt |  66 -----------
>  .../power/supply/sbs,sbs-manager.yaml         | 111 ++++++++++++++++++
>  2 files changed, 111 insertions(+), 66 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/power/supply/sbs,sbs-manager.txt
>  create mode 100644 Documentation/devicetree/bindings/power/supply/sbs,sbs-manager.yaml
>


> diff --git a/Documentation/devicetree/bindings/power/supply/sbs,sbs-manager.yaml b/Documentation/devicetree/bindings/power/supply/sbs,sbs-manager.yaml
> new file mode 100644
> index 000000000000..592c476d83e6
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/power/supply/sbs,sbs-manager.yaml
> @@ -0,0 +1,111 @@
> +# SPDX-License-Identifier: GPL-2.0
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/power/supply/sbs,sbs-manager.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: SBS compliant manger
> +
> +maintainers:
> +  - Sebastian Reichel <sre@kernel.org>
> +
> +allOf:
> +  - $ref: power-supply.yaml#
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - items:
> +          - enum:
> +              - lltc,ltc1760
> +          - enum:
> +              - sbs,sbs-manager
> +      - items:
> +          - const: sbs,sbs-manager
> +
> +  reg:
> +    const: 0xa
> +
> +  "#address-cells":
> +    const: 1
> +
> +  "#size-cells":
> +    const: 0
> +
> +  gpio-controller: true
> +
> +  "#gpio-cells":
> +    const: 2
> +
> +required:
> +  - compatible
> +  - reg
> +
> +additionalProperties: false
> +
> +dependencies:
> +  '#gpio-cells': [gpio-controller]
> +  gpio-controller: ['#gpio-cells']

The core schema should capture these dependencies.

> +
> +patternProperties:
> +  "^i2c@[1-4]$":
> +    type: object
> +
> +    allOf:
> +      - $ref: /schemas/i2c/i2c-controller.yaml#
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    #include <dt-bindings/gpio/gpio.h>
> +
> +    i2c {
> +      #address-cells = <1>;
> +      #size-cells = <0>;
> +
> +      batman: battery-manager@a {
> +        compatible = "lltc,ltc1760", "sbs,sbs-manager";
> +        reg = <0x0a>;
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        gpio-controller;
> +        #gpio-cells = <2>;
> +
> +        i2c@1 {
> +          #address-cells = <1>;
> +          #size-cells = <0>;
> +          reg = <1>;
> +
> +          battery@b {
> +            compatible = "ti,bq20z65", "sbs,sbs-battery";
> +            reg = <0x0b>;
> +            sbs,battery-detect-gpios = <&batman 1 1>;
> +          };
> +        };
> +
> +        i2c@2 {
> +          #address-cells = <1>;
> +          #size-cells = <0>;
> +          reg = <2>;
> +
> +          battery@b {
> +            compatible = "ti,bq20z65", "sbs,sbs-battery";
> +            reg = <0x0b>;
> +            sbs,battery-detect-gpios = <&batman 2 1>;
> +          };
> +        };
> +
> +        i2c@3 {
> +          #address-cells = <1>;
> +          #size-cells = <0>;
> +          reg = <3>;
> +
> +          battery@b {
> +            compatible = "ti,bq20z65", "sbs,sbs-battery";
> +            reg = <0x0b>;
> +            sbs,battery-detect-gpios = <&batman 3 1>;
> +          };
> +        };
> +      };
> +    };
> --
> 2.30.1
>
