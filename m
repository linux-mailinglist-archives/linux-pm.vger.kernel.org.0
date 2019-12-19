Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 43CEF126E7D
	for <lists+linux-pm@lfdr.de>; Thu, 19 Dec 2019 21:12:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726897AbfLSUMx (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 19 Dec 2019 15:12:53 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:33148 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726884AbfLSUMx (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 19 Dec 2019 15:12:53 -0500
Received: by mail-ot1-f66.google.com with SMTP id b18so8699376otp.0;
        Thu, 19 Dec 2019 12:12:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=yEsnOS+OJlfdn2ya+oI/IM/M4B/BUkejIrhzJ5Fn3Yg=;
        b=RaVPzQmymmdRu+3fMeli7rbHS0Z/Z708JQJuGFVpxqY0AIWrEfuChc+rImIox3aV0z
         ioveUd4Wte/Ki4Gg+UFeAqjPIzc1EknXtmg7e24uJTA3DfeglsT5VaNswvdYvRM9UUGb
         Rf6JGgTJ4yEZtOMW+muS+WM1Z9WH8LNHm8YAuw536A6KInf/Dxro6682qU7gFyWNrZbk
         2rjkMQSOEfIRYrvXDfKNpwyEi77EZpJB+Wp2mMrlzcUNmaJzRG/Mok2Bdgl3IhnjOvNf
         0iiNQT5z47UQn5P2hiMCp8Vk8XptYAt3m+Lp11VfWMrxt/DQ4nkwwl30b4sfyzFQYQeq
         jR4Q==
X-Gm-Message-State: APjAAAUDLqpdSX7h64kcAJrHxG7shSr4i5EhwYuIoPPPJhIusvPUD6iS
        eLeO1UcZQMwjIrFLHkkTLQ==
X-Google-Smtp-Source: APXvYqwNJK+Rd61vCyU7qwkUD4jByn2n3KevwwFyhFxb//LMNfrlX3KQoeago107d1SmGHaGQBaatA==
X-Received: by 2002:a05:6830:1e5c:: with SMTP id e28mr10927417otj.293.1576786372073;
        Thu, 19 Dec 2019 12:12:52 -0800 (PST)
Received: from localhost (ip-184-205-110-29.ftwttx.spcsdns.net. [184.205.110.29])
        by smtp.gmail.com with ESMTPSA id f1sm2501751otq.4.2019.12.19.12.12.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Dec 2019 12:12:51 -0800 (PST)
Date:   Thu, 19 Dec 2019 14:12:49 -0600
From:   Rob Herring <robh@kernel.org>
To:     Baolin Wang <baolin.wang7@gmail.com>
Cc:     rui.zhang@intel.com, edubezval@gmail.com,
        daniel.lezcano@linaro.org, amit.kucheria@verdurent.com,
        mark.rutland@arm.com, orsonzhai@gmail.com, baolin.wang@linaro.org,
        freeman.liu@unisoc.com, zhang.lyra@gmail.com,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: thermal: sprd: Add the Spreadtrum
 thermal documentation
Message-ID: <20191219201248.GA5109@bogus>
References: <8d5358a67746b2aff5f6995cabd11d0d7c9e579e.1575978484.git.baolin.wang7@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8d5358a67746b2aff5f6995cabd11d0d7c9e579e.1575978484.git.baolin.wang7@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Dec 10, 2019 at 08:07:17PM +0800, Baolin Wang wrote:
> From: Baolin Wang <baolin.wang@unisoc.com>
> 
> Add the Spreadtrum thermal documentation.
> 
> Signed-off-by: Baolin Wang <baolin.wang@unisoc.com>
> Signed-off-by: Baolin Wang <baolin.wang7@gmail.com>
> ---
> Changes from v1:
>  - Change to yaml format.
> ---
>  .../devicetree/bindings/thermal/sprd-thermal.yaml  |   97 ++++++++++++++++++++
>  1 file changed, 97 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/thermal/sprd-thermal.yaml
> 
> diff --git a/Documentation/devicetree/bindings/thermal/sprd-thermal.yaml b/Documentation/devicetree/bindings/thermal/sprd-thermal.yaml
> new file mode 100644
> index 0000000..92d208a
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/thermal/sprd-thermal.yaml
> @@ -0,0 +1,97 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/thermal/sprd-thermal.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Spreadtrum thermal sensor controller bindings
> +
> +maintainers:
> +  - Orson Zhai <orsonzhai@gmail.com>
> +  - Baolin Wang <baolin.wang7@gmail.com>
> +  - Chunyan Zhang <zhang.lyra@gmail.com>
> +
> +properties:
> +  compatible:
> +    const: sprd,ums512-thermal
> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 1
> +
> +  clock-names:
> +    items:
> +      - const: enable
> +
> +  nvmem-cells:
> +    maxItems: 2
> +    description:
> +      Reference to nvmem nodes for the calibration data.
> +
> +  nvmem-cells-names:
> +    maxItems: 2
> +    items:
> +      - const: thm_sign_cal
> +      - const: thm_ratio_cal
> +
> +  "#thermal-sensor-cells":
> +    const: 1
> +
> +  child-node:

You need actual child node names. It can be a pattern with 
patternProperties.

Make sure 'make dt_binding_check' passes.

> +    description: Represent one thermal sensor.
> +
> +    properties:
> +      reg:
> +        description: Specify the sensor id.
> +        maxItems: 1
> +
> +      nvmem-cells:
> +        maxItems: 1
> +        description:
> +          Reference to an nvmem node for the calibration data.
> +
> +      nvmem-cells-names:
> +        maxItems: 1
> +        items:
> +          - const: sen_delta_cal

Can be simplified to

nvmem-cells-names:
  const: sen_delta_cal

> +
> +    required:
> +      - reg
> +      - nvmem-cells
> +      - nvmem-cells-names
> +
> +required:
> +  - compatible
> +  - reg
> +  - clocks
> +  - clock-names
> +  - nvmem-cells
> +  - nvmem-cells-names
> +  - "#thermal-sensor-cells"
> +
> +examples:
> +  - |
> +        ap_thm0: thermal@32200000 {
> +                compatible = "sprd,ums512-thermal";
> +                reg = <0 0x32200000 0 0x10000>;
> +                clock-names = "enable";
> +                clocks = <&aonapb_gate 32>;
> +                #thermal-sensor-cells = <1>;
> +                nvmem-cells = <&thm0_sign>, <&thm0_ratio>;
> +                nvmem-cell-names = "thm_sign_cal", "thm_ratio_cal";
> +
> +                prometheus0-sensor@0 {
> +                        reg = <0>;

This should fail to build. You need #size-cells and #address-cells in 
the parent.

> +                        nvmem-cells = <&thm0_sen0>;
> +                        nvmem-cell-names = "sen_delta_cal";
> +                };
> +
> +                ank1-sensor@1 {
> +                        reg = <1>;
> +                        nvmem-cells = <&thm0_sen1>;
> +                        nvmem-cell-names = "sen_delta_cal";
> +                };
> +        };
> +...
> -- 
> 1.7.9.5
> 
