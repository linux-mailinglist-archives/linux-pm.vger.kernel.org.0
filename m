Return-Path: <linux-pm+bounces-681-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE26880386B
	for <lists+linux-pm@lfdr.de>; Mon,  4 Dec 2023 16:13:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 296902812A3
	for <lists+linux-pm@lfdr.de>; Mon,  4 Dec 2023 15:13:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E1632C194;
	Mon,  4 Dec 2023 15:13:09 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF90DB2;
	Mon,  4 Dec 2023 07:13:05 -0800 (PST)
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-3b844357f7cso2420513b6e.1;
        Mon, 04 Dec 2023 07:13:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701702785; x=1702307585;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lQuwH9WUYT+pgLpAUKwBB834gsdJ8BIx7PCmxcItZLs=;
        b=r9kTaUqzjhpWLelGwD23YaBmnO8Qu9HsexXgzfjs26DFhytrtB/ya3RueeaG4YQ15j
         FVe9yZKpHS8eA4xecizqcBp30rfhl3LGKWlwhWXOFdSE9xWmShMCQOe+nLKcXJNiJcxP
         BGtWFodFOcYgMAMmW5TQ9OR/Vb007SG/Q4BdQp4KJn6dxWJHayeYirs/VL5wksWcuXHm
         e1FJCvmQ4LG0Hc8+EFk3DV1If4FfMu2Tt1fb3jxal/Xgfqgr0DFo3uwL2307LbN47HIS
         VIIJgFNPSEDBG42YQBde3aYnbsVU20gmE4Wgcr+omFNiYVcRl95HPsSlbIl2iEBXre9C
         LY9A==
X-Gm-Message-State: AOJu0YxDEtRk5e5L20g0kdG5YclEde/t+FVlhoSzMH+zIVbINGF/cfg4
	7ZZKZslqx0gXMeexRsPSMw==
X-Google-Smtp-Source: AGHT+IGEPjoALtHmQxgb3/6E3xleYkYIRBBjXNioqkZbcrEFAN2RwdZ/SiofVetZqdbFnaY8aGrMTQ==
X-Received: by 2002:a05:6808:180b:b0:3a7:d566:8b5e with SMTP id bh11-20020a056808180b00b003a7d5668b5emr5211406oib.44.1701702785157;
        Mon, 04 Dec 2023 07:13:05 -0800 (PST)
Received: from herring.priv (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id 10-20020aca090a000000b003b8b56905b4sm1002082oij.32.2023.12.04.07.13.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Dec 2023 07:13:04 -0800 (PST)
Received: (nullmailer pid 1355175 invoked by uid 1000);
	Mon, 04 Dec 2023 15:13:03 -0000
Date: Mon, 4 Dec 2023 09:13:03 -0600
From: Rob Herring <robh@kernel.org>
To: Biju Das <biju.das.jz@bp.renesas.com>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, Support Opensource <support.opensource@diasemi.com>, "Rafael J. Wysocki" <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>, Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>, Biju Das <biju.das.au@gmail.com>, linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v2 04/11] dt-bindings: thermal: Convert da906{1,2}
 thermal to json-schema
Message-ID: <20231204151303.GB1260709-robh@kernel.org>
References: <20231202192536.266885-1-biju.das.jz@bp.renesas.com>
 <20231202192536.266885-5-biju.das.jz@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231202192536.266885-5-biju.das.jz@bp.renesas.com>

On Sat, Dec 02, 2023 at 07:25:28PM +0000, Biju Das wrote:
> Convert the da906{1,2} thermal device tree binding documentation to
> json-schema.
> 
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> ---
>  .../bindings/thermal/da9062-thermal.txt       | 36 ------------
>  .../bindings/thermal/dlg,da9062-thermal.yaml  | 58 +++++++++++++++++++
>  2 files changed, 58 insertions(+), 36 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/thermal/da9062-thermal.txt
>  create mode 100644 Documentation/devicetree/bindings/thermal/dlg,da9062-thermal.yaml
> 
> diff --git a/Documentation/devicetree/bindings/thermal/da9062-thermal.txt b/Documentation/devicetree/bindings/thermal/da9062-thermal.txt
> deleted file mode 100644
> index e241bb5a5584..000000000000
> --- a/Documentation/devicetree/bindings/thermal/da9062-thermal.txt
> +++ /dev/null
> @@ -1,36 +0,0 @@
> -* Dialog DA9062/61 TJUNC Thermal Module
> -
> -This module is part of the DA9061/DA9062. For more details about entire
> -DA9062 and DA9061 chips see Documentation/devicetree/bindings/mfd/da9062.txt
> -
> -Junction temperature thermal module uses an interrupt signal to identify
> -high THERMAL_TRIP_HOT temperatures for the PMIC device.
> -
> -Required properties:
> -
> -- compatible: should be one of the following valid compatible string lines:
> -        "dlg,da9061-thermal", "dlg,da9062-thermal"
> -        "dlg,da9062-thermal"
> -
> -Optional properties:
> -
> -- polling-delay-passive : Specify the polling period, measured in
> -    milliseconds, between thermal zone device update checks.
> -
> -Example: DA9062
> -
> -	pmic0: da9062@58 {
> -		thermal {
> -			compatible = "dlg,da9062-thermal";
> -			polling-delay-passive = <3000>;
> -		};
> -	};
> -
> -Example: DA9061 using a fall-back compatible for the DA9062 onkey driver
> -
> -	pmic0: da9061@58 {
> -		thermal {
> -			compatible = "dlg,da9061-thermal", "dlg,da9062-thermal";
> -			polling-delay-passive = <3000>;
> -		};
> -	};
> diff --git a/Documentation/devicetree/bindings/thermal/dlg,da9062-thermal.yaml b/Documentation/devicetree/bindings/thermal/dlg,da9062-thermal.yaml
> new file mode 100644
> index 000000000000..0021ebdd83a0
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/thermal/dlg,da9062-thermal.yaml
> @@ -0,0 +1,58 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/thermal/dlg,da9062-thermal.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Dialog DA9062/61 TJUNC Thermal Module
> +
> +description:
> +  This module is part of the DA9061/DA9062. For more details about entire
> +  DA9062 and DA9061 chips see Documentation/devicetree/bindings/mfd/da9062.txt
> +
> +  Junction temperature thermal module uses an interrupt signal to identify
> +  high THERMAL_TRIP_HOT temperatures for the PMIC device.
> +
> +maintainers:
> +  - Biju Das <biju.das.jz@bp.renesas.com>
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - items:
> +          - enum:
> +              - dlg,da9062-thermal
> +      - items:
> +          - enum:
> +              - dlg,da9061-thermal
> +          - const: dlg,da9062-thermal # da9062-thermal fallback
> +
> +  polling-delay-passive:
> +    description:
> +      Specify the polling period, measured in milliseconds, between
> +      thermal zone device update checks.
> +
> +required:
> +  - compatible
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    i2c {
> +      #address-cells = <1>;
> +      #size-cells = <0>;
> +      pmic@58 {
> +        compatible = "dlg,da9062";
> +        reg = <0x58>;
> +        interrupt-parent = <&gpio6>;
> +        interrupts = <11 IRQ_TYPE_LEVEL_LOW>;
> +        interrupt-controller;
> +
> +        thermal {
> +          compatible = "dlg,da9062-thermal";
> +          polling-delay-passive = <3000>;
> +        };
> +      };
> +    };

Just drop the example here. No need for 2 examples, just provide 1 
complete example in the MFD schema.

With that,

Reviewed-by: Rob Herring <robh@kernel.org>

Rob

