Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49A123990FE
	for <lists+linux-pm@lfdr.de>; Wed,  2 Jun 2021 18:58:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230272AbhFBRAY (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 2 Jun 2021 13:00:24 -0400
Received: from mail-ot1-f44.google.com ([209.85.210.44]:39681 "EHLO
        mail-ot1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230029AbhFBRAY (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 2 Jun 2021 13:00:24 -0400
Received: by mail-ot1-f44.google.com with SMTP id 5-20020a9d01050000b02903c700c45721so1986452otu.6;
        Wed, 02 Jun 2021 09:58:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Zf5qRUfCpeGGvJMUCSGIUbY/+04iGlClb4uduIjNhR0=;
        b=aY7HMGXfOa45vXYD49C0wM9/kcwaL6u99FhGGydlkiaD+1VJZGhpFfjHg7CbOGNJ8O
         +cvBflvJn+2sClkeQAOQmxJX7TbHOQuNoJwbi4pdnMTIVrjzZtAKdQzHjs54ckIzlDQr
         JjppIu2aVsamXHo5zFL9jrPjRJ066hvB1wcUGBfXWsmCwvobTGzhQ+OtRc6v5R6dyLJv
         MCOueBfyJ+Zj4yBS6OAG8oMkv9S//HaDty3yizWjVvRDaeqrP+IUzhPxDeGxmc7aKnqA
         Fe0YGCZDmrcr8MaPdICPTgL5dUMDWKKOBo0qOKO8Htse8Y33WEkc6nmalTUzpH6ZK7h1
         K8ow==
X-Gm-Message-State: AOAM532NVaDtaWLyC5XODzKlT4GV2y55tmu8XBJfxUOS05faUu7C35MY
        cCCd4ONd2U8FpRdnHmGucBGXuTeEBg==
X-Google-Smtp-Source: ABdhPJx1wdxS3bAZXIYWDE40ru5uXYnHiXfbK4Phi9RGSYCkcilqMyYnar4EpNED8xQ5RgHOGXF/TQ==
X-Received: by 2002:a9d:1d21:: with SMTP id m30mr27563140otm.145.1622653109495;
        Wed, 02 Jun 2021 09:58:29 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id l128sm90445oif.16.2021.06.02.09.58.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jun 2021 09:58:28 -0700 (PDT)
Received: (nullmailer pid 3566137 invoked by uid 1000);
        Wed, 02 Jun 2021 16:58:27 -0000
Date:   Wed, 2 Jun 2021 11:58:27 -0500
From:   Rob Herring <robh@kernel.org>
To:     Hector Yuan <hector.yuan@mediatek.com>
Cc:     linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        wsd_upstream@mediatek.com
Subject: Re: [PATCH v12 2/2] dt-bindings: cpufreq: add bindings for MediaTek
 cpufreq HW
Message-ID: <20210602165827.GA3558170@robh.at.kernel.org>
References: <1622307153-3639-1-git-send-email-hector.yuan@mediatek.com>
 <1622307153-3639-3-git-send-email-hector.yuan@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1622307153-3639-3-git-send-email-hector.yuan@mediatek.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sun, May 30, 2021 at 12:52:33AM +0800, Hector Yuan wrote:
> From: "Hector.Yuan" <hector.yuan@mediatek.com>
> 
> Add devicetree bindings for MediaTek HW driver.
> 
> Signed-off-by: Hector.Yuan <hector.yuan@mediatek.com>
> ---
>  .../bindings/cpufreq/cpufreq-mediatek-hw.yaml      |   71 ++++++++++++++++++++
>  1 file changed, 71 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/cpufreq/cpufreq-mediatek-hw.yaml
> 
> diff --git a/Documentation/devicetree/bindings/cpufreq/cpufreq-mediatek-hw.yaml b/Documentation/devicetree/bindings/cpufreq/cpufreq-mediatek-hw.yaml
> new file mode 100644
> index 0000000..1aa4d54
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/cpufreq/cpufreq-mediatek-hw.yaml
> @@ -0,0 +1,71 @@
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
> +
> +properties:
> +  compatible:
> +    const: mediatek,cpufreq-hw
> +
> +  reg:
> +    minItems: 1
> +    maxItems: 2
> +    description: |
> +      Addresses and sizes for the memory of the
> +      HW bases in each frequency domain.
> +
> +  "#performance-domain-cells":
> +    description:
> +      Number of cells in a performance domain specifier. Typically 0 for nodes
> +      representing a single performance domain and 1 for nodes providing
> +      multiple performance domains (e.g. performance controllers), but can be
> +      any value as specified by device tree binding documentation of particular
> +      provider.
> +    enum: [ 0, 1 ]

Can't you restrict this to be 1 for Mediatek h/w? Even if you sometimes 
have a single domain, it's probably more simple for the driver if this 
is fixed.

> +
> +required:
> +  - compatible
> +  - reg
> +  - "#performance-domain-cells"
> +
> +additionalProperties: true

Should be false.

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
