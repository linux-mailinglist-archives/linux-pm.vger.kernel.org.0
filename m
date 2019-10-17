Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DD861DB647
	for <lists+linux-pm@lfdr.de>; Thu, 17 Oct 2019 20:35:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438873AbfJQSfr (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 17 Oct 2019 14:35:47 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:34632 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2438870AbfJQSfq (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 17 Oct 2019 14:35:46 -0400
Received: by mail-ot1-f68.google.com with SMTP id m19so2801629otp.1;
        Thu, 17 Oct 2019 11:35:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=rLXeE5tDWR528aYmAdtQR/tQKMyidpkE7QGnDFQ38Io=;
        b=IcFJY0gnT0UBrPh6/Cy32lwDFrIAMwNa2l/ci9KluKFFRFA6SWoGKaKhUDcoVsX9Ou
         Ai/ss2cbSHiuri++vruETpVOrxtXd34lBUyk/bhjf7M8dVceYrLlzviSRe7wal9h47mT
         oMAjhr0S0kZIcABStm9kT9QElbGVIe9rip74s6nfNRxq095rQK0FB7t2b4su1jyUvltJ
         NBkCO2jCqUHXmvi+/Y+suodU74/3txTHzObDKByvOuZzQ3TJJEzUjnhedqD2fIkbo/q6
         3ogRz3EouCAELh+ViJOTbvjdetnTIp3exaizxpAU1fSUp5Lnb8ZtXvV6Pbpo6PilLezO
         NSTg==
X-Gm-Message-State: APjAAAUiKQgCWMhuQp2Aumq5JkLmHLapAeAhxJ8I3vJgPsfPVrlfHf3J
        1GjYuH0nqGQR13b4Tc+f+g==
X-Google-Smtp-Source: APXvYqx1QhuF+1Hdzlmm+RA+5TKr7r6oHJCWnwtex4XEqDWWEc7Ao9vjGEquEZQuo0+tlgF0u4VyvA==
X-Received: by 2002:a9d:6a0c:: with SMTP id g12mr4020150otn.141.1571337345362;
        Thu, 17 Oct 2019 11:35:45 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id q14sm790999otc.50.2019.10.17.11.35.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2019 11:35:44 -0700 (PDT)
Date:   Thu, 17 Oct 2019 13:35:43 -0500
From:   Rob Herring <robh@kernel.org>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>, Dan Murphy <dmurphy@ti.com>,
        Lee Jones <lee.jones@linaro.org>,
        Sebastian Reichel <sre@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-input@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-leds@vger.kernel.org, linux-pm@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: Re: [PATCH v3 3/6] dt-bindings: regulator: max77650: convert the
 binding document to yaml
Message-ID: <20191017183543.GA28403@bogus>
References: <20191017071234.8719-1-brgl@bgdev.pl>
 <20191017071234.8719-4-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191017071234.8719-4-brgl@bgdev.pl>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Oct 17, 2019 at 09:12:31AM +0200, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> 
> Convert the binding document for MAX77650 regulator module to YAML.
> 
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> ---
>  .../bindings/regulator/max77650-regulator.txt | 41 -------------------
>  .../regulator/max77650-regulator.yaml         | 31 ++++++++++++++
>  2 files changed, 31 insertions(+), 41 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/regulator/max77650-regulator.txt
>  create mode 100644 Documentation/devicetree/bindings/regulator/max77650-regulator.yaml
> 
> diff --git a/Documentation/devicetree/bindings/regulator/max77650-regulator.txt b/Documentation/devicetree/bindings/regulator/max77650-regulator.txt
> deleted file mode 100644
> index f1cbe813c30f..000000000000
> --- a/Documentation/devicetree/bindings/regulator/max77650-regulator.txt
> +++ /dev/null
> @@ -1,41 +0,0 @@
> -Regulator driver for MAX77650 PMIC from Maxim Integrated.
> -
> -This module is part of the MAX77650 MFD device. For more details
> -see Documentation/devicetree/bindings/mfd/max77650.txt.
> -
> -The regulator controller is represented as a sub-node of the PMIC node
> -on the device tree.
> -
> -The device has a single LDO regulator and a SIMO buck-boost regulator with
> -three independent power rails.
> -
> -Required properties:
> ---------------------
> -- compatible:		Must be "maxim,max77650-regulator"
> -
> -Each rail must be instantiated under the regulators subnode of the top PMIC
> -node. Up to four regulators can be defined. For standard regulator properties
> -refer to Documentation/devicetree/bindings/regulator/regulator.txt.
> -
> -Available regulator compatible strings are: "ldo", "sbb0", "sbb1", "sbb2".
> -
> -Example:
> ---------
> -
> -	regulators {
> -		compatible = "maxim,max77650-regulator";
> -
> -		max77650_ldo: regulator@0 {
> -			regulator-compatible = "ldo";
> -			regulator-name = "max77650-ldo";
> -			regulator-min-microvolt = <1350000>;
> -			regulator-max-microvolt = <2937500>;
> -		};
> -
> -		max77650_sbb0: regulator@1 {
> -			regulator-compatible = "sbb0";
> -			regulator-name = "max77650-sbb0";
> -			regulator-min-microvolt = <800000>;
> -			regulator-max-microvolt = <1587500>;
> -		};
> -	};
> diff --git a/Documentation/devicetree/bindings/regulator/max77650-regulator.yaml b/Documentation/devicetree/bindings/regulator/max77650-regulator.yaml
> new file mode 100644
> index 000000000000..a8770742836d
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/regulator/max77650-regulator.yaml
> @@ -0,0 +1,31 @@
> +# SPDX-License-Identifier: GPL-2.0
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/regulator/max77650-regulator.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Regulator driver for MAX77650 PMIC from Maxim Integrated.
> +
> +maintainers:
> +  - Bartosz Golaszewski <bgolaszewski@baylibre.com>
> +
> +description: |
> +  This module is part of the MAX77650 MFD device. For more details
> +  see Documentation/devicetree/bindings/mfd/max77650.txt.

.yaml?

> +
> +  The regulator controller is represented as a sub-node of the PMIC node
> +  on the device tree.
> +
> +  The device has a single LDO regulator and a SIMO buck-boost regulator with
> +  three independent power rails.
> +
> +properties:
> +  compatible:
> +    const: maxim,max77650-regulator
> +
> +patternProperties:
> +  "^regulator@[0-3]$":
> +    $ref: "regulator.yaml#"
> +
> +required:
> +  - compatible
> -- 
> 2.23.0
> 
