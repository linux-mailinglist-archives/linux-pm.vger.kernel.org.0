Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFB081BC4FE
	for <lists+linux-pm@lfdr.de>; Tue, 28 Apr 2020 18:20:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728084AbgD1QU6 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 28 Apr 2020 12:20:58 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:36259 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728035AbgD1QU6 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 28 Apr 2020 12:20:58 -0400
Received: by mail-ot1-f67.google.com with SMTP id b13so33639474oti.3;
        Tue, 28 Apr 2020 09:20:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=JMWn8pXLk5/8kiVuu/q953brTdcIK/PY1BQH6BDELfQ=;
        b=r0KYrrsqRsZric0zFiNLe7BW8rLE0VjC1R6TyJgQ7BGhMqAjy0md7gTiFbM0kvcx38
         h4fIXEQOsCXSgfazSsNsrncRv9dvDRQfIE7WfX46PjqeMFBOewZ8xOkiHgc4kSuG9Vfc
         LZgMyprq7helhLvyPBjNduNJjrS74mTnnGa0v8m/7KU5vM/V92xnrdzSNdqVxzHVuZsN
         0UTJthU5vDGmgMkaxJSJbs3KVPwo14TyQcqudDXyX9TT7cowA/rHSrOvR3vKuJTpTemt
         po+G9WsRF7S2F5IkV8LotX177LV9L/q/BP5ocGHR73UAzIezyTrszDE0ENUjuU1yKiLt
         thrg==
X-Gm-Message-State: AGi0PuaRZIOixah0TVegJ/i8guvXR//3LPtnDQPwWziMW3HA4w2D6O7h
        kCuPDFgaDoUkTpjHDiqpDQ==
X-Google-Smtp-Source: APiQypJy0uIwGwXRPYx/W8t8j3YChbO+ZkOIvCk2Wk0UGCLxk4GNBBlbC22NGmfDdkMnCXWLDnPaYw==
X-Received: by 2002:aca:f482:: with SMTP id s124mr3552378oih.128.1588090857546;
        Tue, 28 Apr 2020 09:20:57 -0700 (PDT)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id l19sm4939433otp.16.2020.04.28.09.20.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2020 09:20:56 -0700 (PDT)
Received: (nullmailer pid 337 invoked by uid 1000);
        Tue, 28 Apr 2020 16:20:55 -0000
Date:   Tue, 28 Apr 2020 11:20:55 -0500
From:   Rob Herring <robh@kernel.org>
To:     Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Cc:     Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: thermal: Convert UniPhier thermal monitor
 to json-schema
Message-ID: <20200428162055.GA27628@bogus>
References: <1587013935-21760-1-git-send-email-hayashi.kunihiko@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1587013935-21760-1-git-send-email-hayashi.kunihiko@socionext.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Apr 16, 2020 at 02:12:15PM +0900, Kunihiko Hayashi wrote:
> Convert the UniPhier thermal monitor binding to DT schema format.
> 
> Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
> ---
>  .../thermal/socionext,uniphier-thermal.yaml        | 57 +++++++++++++++++++
>  .../bindings/thermal/uniphier-thermal.txt          | 65 ----------------------
>  2 files changed, 57 insertions(+), 65 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/thermal/socionext,uniphier-thermal.yaml
>  delete mode 100644 Documentation/devicetree/bindings/thermal/uniphier-thermal.txt
> 
> diff --git a/Documentation/devicetree/bindings/thermal/socionext,uniphier-thermal.yaml b/Documentation/devicetree/bindings/thermal/socionext,uniphier-thermal.yaml
> new file mode 100644
> index 0000000..bdddc5b
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/thermal/socionext,uniphier-thermal.yaml
> @@ -0,0 +1,57 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/thermal/socionext,uniphier-thermal.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Socionext UniPhier thermal monitor
> +
> +description: |
> +  This describes the devicetree bindings for thermal monitor supported by
> +  PVT(Process, Voltage and Temperature) monitoring unit implemented on
> +  Socionext UniPhier SoCs.
> +
> +maintainers:
> +  - Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
> +
> +properties:
> +  compatible:
> +    enum:
> +      - socionext,uniphier-pxs2-thermal
> +      - socionext,uniphier-ld20-thermal
> +      - socionext,uniphier-pxs3-thermal
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  "#thermal-sensor-cells":
> +    const: 0
> +
> +  socionext,tmod-calibration:
> +    $ref: /schemas/types.yaml#/definitions/uint32-array
> +    description:
> +      A pair of calibrated values referred from PVT, in case that the values
> +      aren't set on SoC, like a reference board.

So?:

maxItems: 2

> +
> +required:
> +  - compatible
> +  - interrupts
> +  - "#thermal-sensor-cells"
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    // The UniPhier thermal should be a subnode of a "syscon" compatible node.
> +
> +    sysctrl@61840000 {
> +        compatible = "socionext,uniphier-ld20-sysctrl",
> +                     "simple-mfd", "syscon";
> +        reg = <0x61840000 0x10000>;
> +
> +        pvtctl: thermal {
> +                compatible = "socionext,uniphier-ld20-thermal";
> +                interrupts = <0 3 1>;
> +                #thermal-sensor-cells = <0>;
> +        };
> +    };
