Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E888644EAC6
	for <lists+linux-pm@lfdr.de>; Fri, 12 Nov 2021 16:44:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232194AbhKLPrY (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 12 Nov 2021 10:47:24 -0500
Received: from mail-oi1-f181.google.com ([209.85.167.181]:45897 "EHLO
        mail-oi1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229841AbhKLPrY (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 12 Nov 2021 10:47:24 -0500
Received: by mail-oi1-f181.google.com with SMTP id 7so8427956oip.12;
        Fri, 12 Nov 2021 07:44:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=46yHjAfatF/D8CH1ucT/f0z/BDG2VdW81V3VG4NmD5w=;
        b=tiMGv2ZcBH64K9lgIEOo2ST5ZtbitEFyRr3RzIvC27+D3YV32wF804UYoBKp0SkCGP
         l8eXVbm0Mq5Osrl/kv7QGnUqKJ9kBDpaZQHeLIdGsCOeVgJW/kxXUAvGEuTtnCzr2KRX
         JARLPFAnLo/U0L5cXFpGDaeoL6VzZsX619h6xx14jqgOtprx1hVBCfLD07edjxWQY7KA
         OZyZ8RlL1iIb0fPUX9I5BJjnrLFPjmNh7BgiNRgfJWwl6Fwif2iNWAhHbNFY79ZG719j
         jVRhiUZNwlEUdy/w8vjVF/7RVrscETdl2yFDyJAzkUUhIXQ/qS3NGTLn4A5MAK0vwci8
         W6Mg==
X-Gm-Message-State: AOAM533uKnsABQlmXK2VohztciPa0Sj5s2ZuqUy62kas9ZkTComHdGRb
        xcHJp/Hnqsa0Hg2DP9f8wFM2Lsx7GQ==
X-Google-Smtp-Source: ABdhPJzISiTmfnExLax2+EFNIj/oeYrEwi+gF6RPWAGHPV+CFvjp6dIAlrmR/8HZH2dv7oS9uCUenw==
X-Received: by 2002:a54:4f0d:: with SMTP id e13mr13376532oiy.110.1636731873392;
        Fri, 12 Nov 2021 07:44:33 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id i16sm1398794oig.15.2021.11.12.07.44.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Nov 2021 07:44:32 -0800 (PST)
Received: (nullmailer pid 2904445 invoked by uid 1000);
        Fri, 12 Nov 2021 15:44:31 -0000
Date:   Fri, 12 Nov 2021 09:44:31 -0600
From:   Rob Herring <robh@kernel.org>
To:     "LH.Kuo" <lhjeff911@gmail.com>
Cc:     rafael@kernel.org, daniel.lezcano@linaro.org, amitk@kernel.org,
        rui.zhang@intel.com, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        qinjian@cqplus1.com, wells.lu@sunplus.com,
        "LH.Kuo" <lh.kuo@sunplus.com>
Subject: Re: [PATCH 2/2] devicetree bindings THERMAL Add bindings doc for
 Sunplus SP7021
Message-ID: <YY6L307obyk2XMx3@robh.at.kernel.org>
References: <1635756310-25415-1-git-send-email-lh.kuo@sunplus.com>
 <1635756310-25415-3-git-send-email-lh.kuo@sunplus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1635756310-25415-3-git-send-email-lh.kuo@sunplus.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Nov 01, 2021 at 04:45:10PM +0800, LH.Kuo wrote:
> Add devicetree bindings THERMAL Add bindings doc for Sunplus SP7021

Not a complete sentence.

Write subject lines matching 'git log --oneline' of the 
directory/subsystem your change is in.

> 
> Signed-off-by: LH.Kuo <lh.kuo@sunplus.com>
> ---
>  .../bindings/thermal/sunplus_thermal.yaml          | 52 ++++++++++++++++++++++
>  MAINTAINERS                                        |  1 +
>  2 files changed, 53 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/thermal/sunplus_thermal.yaml
> 
> diff --git a/Documentation/devicetree/bindings/thermal/sunplus_thermal.yaml b/Documentation/devicetree/bindings/thermal/sunplus_thermal.yaml
> new file mode 100644
> index 0000000..1875d04
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/thermal/sunplus_thermal.yaml
> @@ -0,0 +1,52 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +# Copyright (C) Sunplus Co., Ltd. 2021
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/thermal/sunplus_thermal.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Sunplus Thermal controller
> +
> +maintainers:
> +  - lh.kuo <lh.kuo@sunplus.com>
> +
> +properties:
> +  compatible:
> +    enum:
> +      - sunplus,sp7021-thermal
> +
> +  reg:
> +    items:
> +      - description: Base address and length of the Thermal registers
> +      - description: Base address and length of the Thermal calibration registers
> +
> +  reg-names:
> +    items:
> +      - const: thermal_reg
> +      - const: thermal_moon4

thermal_ is redundant.

> +
> +  nvmem-cells:
> +    maxItems: 1
> +
> +  nvmem-cell-names:
> +    const: therm_calib
> +
> +required:
> +  - compatible
> +  - reg
> +  - reg-names
> +  - nvmem-cells
> +  - nvmem-cell-names
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    thermal: serial@9c000280 {

Drop unused labels.

> +        compatible = "sunplus,sp7021-thermal";
> +        reg = <0x9c000280 0x80>, <0x9c000200 0x80>;
> +        reg-names = "thermal_reg", "thermal_moon4";
> +        nvmem-cells = <&therm_calib>;
> +        nvmem-cell-names = "therm_calib";
> +    };
> +...
> diff --git a/MAINTAINERS b/MAINTAINERS
> index dff822b..2080b00 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -17949,6 +17949,7 @@ SUNPLUS THERMAL DRIVER
>  M:	LH Kuo <lh.kuo@sunplus.com>
>  L:	linux-pm@vger.kernel.org
>  S:	Maintained
> +F:	Documentation/devicetree/bindings/thermal/sunplus_thermal.yaml
>  F:	drivers/thermal/sunplus_thermal.c
>  
>  SUPERH
> -- 
> 2.7.4
> 
> 
