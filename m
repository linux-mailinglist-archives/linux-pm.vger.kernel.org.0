Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B04E729089D
	for <lists+linux-pm@lfdr.de>; Fri, 16 Oct 2020 17:38:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408473AbgJPPi3 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 16 Oct 2020 11:38:29 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:38197 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2408427AbgJPPi3 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 16 Oct 2020 11:38:29 -0400
Received: by mail-ed1-f67.google.com with SMTP id i5so2900389edr.5;
        Fri, 16 Oct 2020 08:38:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=l7ooLLyjU79cfl+bt7sttr4E3DYykAdem+WSTdZT84Q=;
        b=cPO2H6lrMx3ANOh7oH82eqjP9PYFhHHZMmUEWrKH049ckoc5ZP4FKGExZsh/2X1aJw
         iiAbCQ/7w461JvNwBanHcQ/fSMifHUc/LUQWaWXlY0Ytqr7GxHPe/elWQPar7GWJjmHk
         uXAXsNi8J9/mBxpX3MRfWEXNizlLI9LDQOdsISS9utip8I1ELnuJDs0fdlcaVwibXLJZ
         gzPLqjGYVCcFFRWLPF2q8GQ5iJ6tbZv6is9a3s+fwJ9NN6B8ZW017kDz8J994X17QSVI
         TFYGKK58I30hydV9PSM6/s2vYmH5VcSBzbbsWhuDGFH5zxm//MKotb14ljUqQGbwhyxU
         MuGg==
X-Gm-Message-State: AOAM5304I3iufa+nwgC7/Ekf2zZhF/gewBORfp7FqthqI0ut2JV3vG2g
        zHWG3hgc55J78jzUqgPgOcE=
X-Google-Smtp-Source: ABdhPJx2vXirUY8EO6Lr8GnfzXGhnxo0d9l8dBuveqgE4nywFvaNT1O0eVe8BcAWvhYByAs4SHpmPw==
X-Received: by 2002:aa7:d7c1:: with SMTP id e1mr4740554eds.4.1602862706986;
        Fri, 16 Oct 2020 08:38:26 -0700 (PDT)
Received: from kozik-lap ([194.230.155.171])
        by smtp.googlemail.com with ESMTPSA id s25sm1894221ejc.29.2020.10.16.08.38.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2020 08:38:25 -0700 (PDT)
Date:   Fri, 16 Oct 2020 17:38:23 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Gene Chen <gene.chen.richtek@gmail.com>
Cc:     sre@kernel.org, matthias.bgg@gmail.com, robh+dt@kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Gene Chen <gene_chen@richtek.com>
Subject: Re: [PATCH 1/2] dt-bindings: power: Add bindings document for
 Charger support on MT6360 PMIC
Message-ID: <20201016153823.GA9890@kozik-lap>
References: <1600859910-15855-1-git-send-email-gene.chen.richtek@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1600859910-15855-1-git-send-email-gene.chen.richtek@gmail.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Sep 23, 2020 at 07:18:29PM +0800, Gene Chen wrote:
> From: Gene Chen <gene_chen@richtek.com>
> 
> Add bindings document for Charger support on MT6360 PMIC
> 
> Signed-off-by: Gene Chen <gene_chen@richtek.com>
> ---
>  .../bindings/power/supply/mt6360_charger.yaml      | 44 ++++++++++++++++++++++
>  1 file changed, 44 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/power/supply/mt6360_charger.yaml
> 
> diff --git a/Documentation/devicetree/bindings/power/supply/mt6360_charger.yaml b/Documentation/devicetree/bindings/power/supply/mt6360_charger.yaml
> new file mode 100644
> index 0000000..711fc19
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/power/supply/mt6360_charger.yaml
> @@ -0,0 +1,44 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/power/supply/mt6360_charger.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Battery charger driver for MT6360 PMIC from MediaTek Integrated.
> +
> +maintainers:
> +  - Gene Chen <gene_chen@richtek.com>
> +
> +description: |
> +  This module is part of the MT6360 MFD device.
> +  Provides Battery Charger, Boost for OTG devices and BC1.2 detection.
> +
> +properties:
> +  compatible:
> +    const: mediatek,mt6360-chg
> +
> +  vinovp:
> +    description:
> +      Maximum CHGIN regulation voltage.

1. You need to describe the type.
2. Use proper unit suffix (see property-units.txt).
3. Is this a custom property? If yes, it misses vendor prefix. If not,
   most likely there is already such property. Reuse.

> +
> +  usb-otg-vbus:
> +      $ref: /schemas/regulator/regulator.yaml#

1. Wrong indentation.
2. Name should be more or less generic, so maybe
   "usb-otg-vbus-regulator".

> +
> +required:
> +  - compatible

No address/reg? How does it bind?

> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    mt6360_chg: chg {

s/chg/charger/

> +      compatible = "mediatek,mt6360-chg";
> +      vinovp = <14500000>;

Empty line break

Best regards,
Krzysztof
