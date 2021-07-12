Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 222C53C5FA5
	for <lists+linux-pm@lfdr.de>; Mon, 12 Jul 2021 17:45:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234594AbhGLPsO (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 12 Jul 2021 11:48:14 -0400
Received: from mail-il1-f179.google.com ([209.85.166.179]:38769 "EHLO
        mail-il1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233166AbhGLPsO (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 12 Jul 2021 11:48:14 -0400
Received: by mail-il1-f179.google.com with SMTP id e2so3441166ilu.5;
        Mon, 12 Jul 2021 08:45:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=bjiErdISvJzz8sZViNEzz+bDHd/bqQjAqSKMHKmAddo=;
        b=DI6UaomLpHZeEH+Xz49yYX9+vpIUfWRBc9TuGvbvAUk6I91m0apvSvUH59gwMgyVZS
         mdQULYfoCfUvV7kSXRj/6QjE14NXBXRsuqWYFEHZL/TGXTSRiMgCmxkX96meV+B/oScL
         TBh6IXPjN7htwVEOwkUYcRRyZcXNtuYuIUwiW+aU4L5kU1bmcWdLw4L/I3flqSrMf0H1
         U2LSJs/WosJ8NkrvYkWBVlZUaO3BL3qzKhqZKdf78jaVdx6UF2wwXK0++C1x78tNGS6A
         AQJll7OvSurEipM/Kg/FFn1PeMXmTfHBeZGT3PuLR66RJ66EdaLrFFGuPeApQMJ5wc6x
         EFlQ==
X-Gm-Message-State: AOAM530NsDCAu7vjxyxMv3GcjIDh3+0wZqFPDkcH3VQKmMVCJiv3XuIG
        fKGoJVByeqXLXnH4qRi28w==
X-Google-Smtp-Source: ABdhPJzTRCtdC+9FJWhpQUH8hfogXfrqm1xOLRX2Lit76DloUO2QE5jBGcamGXbkUimFLHMn8PhYCw==
X-Received: by 2002:a92:3647:: with SMTP id d7mr38199063ilf.231.1626104724908;
        Mon, 12 Jul 2021 08:45:24 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id b3sm8110077ilm.73.2021.07.12.08.45.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jul 2021 08:45:23 -0700 (PDT)
Received: (nullmailer pid 1993221 invoked by uid 1000);
        Mon, 12 Jul 2021 15:45:21 -0000
Date:   Mon, 12 Jul 2021 09:45:21 -0600
From:   Rob Herring <robh@kernel.org>
To:     Shawn Guo <shawn.guo@linaro.org>
Cc:     Sebastian Reichel <sre@kernel.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        Vinod Koul <vkoul@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH 1/3] dt-bindings: power: reset: Convert qcom,pon to DT
 schema
Message-ID: <20210712154521.GA1987910@robh.at.kernel.org>
References: <20210705025032.12804-1-shawn.guo@linaro.org>
 <20210705025032.12804-2-shawn.guo@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210705025032.12804-2-shawn.guo@linaro.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Jul 05, 2021 at 10:50:30AM +0800, Shawn Guo wrote:
> It converts qcom,pon DT bindings from legacy bare text to YAML format.
> 
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> ---
>  .../bindings/power/reset/qcom,pon.txt         | 49 -------------------
>  .../bindings/power/reset/qcom,pon.yaml        | 49 +++++++++++++++++++
>  2 files changed, 49 insertions(+), 49 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/power/reset/qcom,pon.txt
>  create mode 100644 Documentation/devicetree/bindings/power/reset/qcom,pon.yaml
> 
> diff --git a/Documentation/devicetree/bindings/power/reset/qcom,pon.txt b/Documentation/devicetree/bindings/power/reset/qcom,pon.txt
> deleted file mode 100644
> index 0c0dc3a1e693..000000000000
> --- a/Documentation/devicetree/bindings/power/reset/qcom,pon.txt
> +++ /dev/null
> @@ -1,49 +0,0 @@
> -Qualcomm PON Device
> -
> -The Power On device for Qualcomm PM8xxx is MFD supporting pwrkey
> -and resin along with the Android reboot-mode.
> -
> -This DT node has pwrkey and resin as sub nodes.
> -
> -Required Properties:
> --compatible: Must be one of:
> -	"qcom,pm8916-pon"
> -	"qcom,pms405-pon"
> -	"qcom,pm8998-pon"
> -
> --reg: Specifies the physical address of the pon register
> -
> -Optional subnode:
> --pwrkey: Specifies the subnode pwrkey and should follow the
> - qcom,pm8941-pwrkey.txt description.
> --resin: Specifies the subnode resin and should follow the
> - qcom,pm8xxx-pwrkey.txt description.
> -
> -The rest of the properties should follow the generic reboot-mode description
> -found in reboot-mode.txt
> -
> -Example:
> -
> -	pon@800 {
> -		compatible = "qcom,pm8916-pon";
> -
> -		reg = <0x800>;
> -		mode-bootloader = <0x2>;
> -		mode-recovery = <0x1>;
> -
> -		pwrkey {
> -			compatible = "qcom,pm8941-pwrkey";
> -			interrupts = <0x0 0x8 0 IRQ_TYPE_EDGE_BOTH>;
> -			debounce = <15625>;
> -			bias-pull-up;
> -			linux,code = <KEY_POWER>;
> -		};
> -
> -		resin {
> -			compatible = "qcom,pm8941-resin";
> -			interrupts = <0x0 0x8 1 IRQ_TYPE_EDGE_BOTH>;
> -			debounce = <15625>;
> -			bias-pull-up;
> -			linux,code = <KEY_VOLUMEDOWN>;
> -		};
> -	};
> diff --git a/Documentation/devicetree/bindings/power/reset/qcom,pon.yaml b/Documentation/devicetree/bindings/power/reset/qcom,pon.yaml
> new file mode 100644
> index 000000000000..7764c804af1d
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/power/reset/qcom,pon.yaml
> @@ -0,0 +1,49 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/power/reset/qcom,pon.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Qualcomm PON Device
> +
> +maintainers:
> +  - Vinod Koul <vkoul@kernel.org>
> +
> +description: |
> +  The Power On device for Qualcomm PM8xxx is MFD supporting pwrkey
> +  and resin along with the Android reboot-mode.

allOf:
  - $ref: /schemas/power/reset/reboot-mode.yaml#

And then...

> +
> +properties:
> +  compatible:
> +    enum:
> +      - qcom,pm8916-pon
> +      - qcom,pms405-pon
> +      - qcom,pm8998-pon
> +
> +  reg:
> +    maxItems: 1
> +
> +patternProperties:
> +  "^mode-.+":
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: Vendor-specific mode value written to the mode register

Drop this.

> +
> +required:
> +  - compatible
> +  - reg
> +
> +additionalProperties: false

unevaluatedProperties: false

> +
> +examples:
> +  - |
> +    pmic {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        pon@800 {
> +            compatible = "qcom,pm8916-pon";
> +            reg = <0x800>;
> +            mode-bootloader = <0x2>;
> +            mode-recovery = <0x1>;
> +        };
> +    };
> -- 
> 2.17.1
> 
> 
