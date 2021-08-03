Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 299D33DF577
	for <lists+linux-pm@lfdr.de>; Tue,  3 Aug 2021 21:22:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239450AbhHCTWl (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 3 Aug 2021 15:22:41 -0400
Received: from mail-il1-f169.google.com ([209.85.166.169]:46630 "EHLO
        mail-il1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238837AbhHCTWl (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 3 Aug 2021 15:22:41 -0400
Received: by mail-il1-f169.google.com with SMTP id r5so20486163ilc.13;
        Tue, 03 Aug 2021 12:22:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=i62AD3moOWwFAL7Cs6cq2TGwdGazIQUY9cbfa6j5bi0=;
        b=F6jpSe5n1qdDD2whrJaCyhzSJ0Lf/mTLhjy/r+KJXK5tJomhMGgs0cD6n2yUoG+0GX
         salf5uigL6Rdjdmbta0MT6KlxYEPrqesJk8RCAs70aOJTH5IEm+EbfpCJocb4P64DsGU
         x+dFhb+YeYDZR0qB4xliaH6tUI+wmF4VtzfEKreudnzy0NmJM0DdIcxeFqiwowocqydb
         wk3RQo45WpnO00uW79B2QrOZPxk6NUqzM8yvH0Lacp31OFTG3m5RXPw6QT1OlKUZ80ja
         k+/guNjSdvkJ/IWhQncQ8G0gxs2J8oX3c/GwR8agTb9BntTc/Mgo6b1MNupDxx7zB4MI
         bFxw==
X-Gm-Message-State: AOAM531SKwJu5uqXIr+vFbnJOy1Led1tVV9MvAsTUOkrXIzaEEbtVAPH
        dzgNcuwpCk7gfU/Tq8TxgQ==
X-Google-Smtp-Source: ABdhPJwgh9BcVJvgkrinoh/evNe99kSmeAxGbfAvV8Fpg6hFfbIYPTrPAVYCd4p/k1Pi06KLy82qQA==
X-Received: by 2002:a05:6e02:1e06:: with SMTP id g6mr621165ila.41.1628018549853;
        Tue, 03 Aug 2021 12:22:29 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id p1sm7769629ilh.47.2021.08.03.12.22.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Aug 2021 12:22:29 -0700 (PDT)
Received: (nullmailer pid 3593480 invoked by uid 1000);
        Tue, 03 Aug 2021 19:22:27 -0000
Date:   Tue, 3 Aug 2021 13:22:27 -0600
From:   Rob Herring <robh@kernel.org>
To:     Hector Yuan <hector.yuan@mediatek.com>
Cc:     linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        wsd_upstream@mediatek.com
Subject: Re: [PATCH v13 1/2] dt-bindings: cpufreq: add bindings for MediaTek
 cpufreq HW
Message-ID: <YQmXc2kofIZacBRw@robh.at.kernel.org>
References: <1627574891-26514-1-git-send-email-hector.yuan@mediatek.com>
 <1627574891-26514-2-git-send-email-hector.yuan@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1627574891-26514-2-git-send-email-hector.yuan@mediatek.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Jul 30, 2021 at 12:08:10AM +0800, Hector Yuan wrote:
> From: "Hector.Yuan" <hector.yuan@mediatek.com>
> 
> Add devicetree bindings for MediaTek HW driver.
> 
> Signed-off-by: Hector.Yuan <hector.yuan@mediatek.com>
> ---
>  .../bindings/cpufreq/cpufreq-mediatek-hw.yaml      |   70 ++++++++++++++++++++
>  1 file changed, 70 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/cpufreq/cpufreq-mediatek-hw.yaml
> 
> diff --git a/Documentation/devicetree/bindings/cpufreq/cpufreq-mediatek-hw.yaml b/Documentation/devicetree/bindings/cpufreq/cpufreq-mediatek-hw.yaml
> new file mode 100644
> index 0000000..6bb2c97
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/cpufreq/cpufreq-mediatek-hw.yaml
> @@ -0,0 +1,70 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/cpufreq/cpufreq-mediatek-hw.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: MediaTek's CPUFREQ Bindings
> +
> +maintainers:
> +  - Hector Yuan <hector.yuan@mediatek.com>
> +
> +description:
> +  CPUFREQ HW is a hardware engine used by MediaTek
> +  SoCs to manage frequency in hardware. It is capable of controlling frequency
> +  for multiple clusters.

Strange choice of line breaks.

> +
> +properties:
> +  compatible:
> +    const: mediatek,cpufreq-hw
> +
> +  reg:
> +    minItems: 1
> +    maxItems: 2
> +    description: |

Don't need '|' unless there's formatting to preserve.

> +      Addresses and sizes for the memory of the
> +      HW bases in each frequency domain.

'Each entry corresponds to a register bank for each frequency 
domain present.'

> +
> +  "#performance-domain-cells":
> +    description:
> +      Number of cells in a performance domain specifier. Typically 1 for nodes
> +      providing multiple performance domains (e.g. performance controllers),
> +      but can be any value as specified by device tree binding documentation
> +      of particular provider.
> +    const: 1
> +
> +required:
> +  - compatible
> +  - reg
> +  - "#performance-domain-cells"
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    cpus {
> +            #address-cells = <1>;
> +            #size-cells = <0>;
> +
> +            cpu0: cpu@0 {
> +                device_type = "cpu";
> +                compatible = "arm,cortex-a55";
> +                enable-method = "psci";
> +                performance-domains = <&performance 0>;
> +                reg = <0x000>;
> +            };
> +    };
> +
> +    /* ... */
> +
> +    soc {
> +        #address-cells = <2>;
> +        #size-cells = <2>;
> +
> +        performance: performance-controller@11bc00 {
> +            compatible = "mediatek,cpufreq-hw";
> +            reg = <0 0x0011bc10 0 0x120>, <0 0x0011bd30 0 0x120>;
> +
> +            #performance-domain-cells = <1>;
> +        };
> +    };
> -- 
> 1.7.9.5
> 
> 
