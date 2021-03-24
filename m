Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A220F347D49
	for <lists+linux-pm@lfdr.de>; Wed, 24 Mar 2021 17:08:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236959AbhCXQII (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 24 Mar 2021 12:08:08 -0400
Received: from mail-io1-f47.google.com ([209.85.166.47]:41845 "EHLO
        mail-io1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236958AbhCXQHy (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 24 Mar 2021 12:07:54 -0400
Received: by mail-io1-f47.google.com with SMTP id z3so22090934ioc.8;
        Wed, 24 Mar 2021 09:07:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+TKJ7TFEwQUAbTBq1YwmMD5zRQ+v2F+z93Rbx7y6w3w=;
        b=hMj9qJiT73MQmoT/9wJxQfrHewN1bubAp5ujpHfSGcPQARVdUbF56uz3YoiLXbc9rc
         JS0jFD/6i/4S8xJJf759M9V8cZe3T45HF4ouzH9/24Bqxj4NChHlUJ3A77GCoVvnMPJm
         IVscc6Bjoj2kVdjB1pdTqxX+FYeUDBps7rB8b22MP3GqcE6rQ8RLMQpc17F8cpsEQJra
         kBS2Jjw/QirlRsLZU95Ej5NE+xpL2rVPQTgjOaMHyoP1baoGV+bAo2q77K/UornezS+N
         II2mKZwnJ0AwRAYH81ddH0qMqpHCpm92JWDXQQt+td0uCelIn+TmV6OvhO5pAxESifZj
         ai4g==
X-Gm-Message-State: AOAM5301OGZRZWZf+u0KhTn9iLE/cTikKvPkll6duOjZnUYM2O89KlB8
        OzQbsyyPxzhtD7i4z1EgBQ==
X-Google-Smtp-Source: ABdhPJya1dN4uozCjZmQ2auHAPj9umaWDlRyWBJXtu3w7IXLRDTFyu35xHocwAJF6I49H2oa8mwhzg==
X-Received: by 2002:a5e:980e:: with SMTP id s14mr3134530ioj.63.1616602073375;
        Wed, 24 Mar 2021 09:07:53 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id x2sm1279900ilv.36.2021.03.24.09.07.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Mar 2021 09:07:52 -0700 (PDT)
Received: (nullmailer pid 3162147 invoked by uid 1000);
        Wed, 24 Mar 2021 16:07:50 -0000
Date:   Wed, 24 Mar 2021 10:07:50 -0600
From:   Rob Herring <robh@kernel.org>
To:     Hector Yuan <hector.yuan@mediatek.com>
Cc:     linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        wsd_upstream@mediatek.com
Subject: Re: [PATCH v11 2/2] dt-bindings: cpufreq: add bindings for MediaTek
 cpufreq HW
Message-ID: <20210324160750.GA3154702@robh.at.kernel.org>
References: <1615549235-27700-1-git-send-email-hector.yuan@mediatek.com>
 <1615549235-27700-3-git-send-email-hector.yuan@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1615549235-27700-3-git-send-email-hector.yuan@mediatek.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Mar 12, 2021 at 07:40:35PM +0800, Hector Yuan wrote:
> From: "Hector.Yuan" <hector.yuan@mediatek.com>
> 
> Add devicetree bindings for MediaTek HW driver.
> 
> Signed-off-by: Hector.Yuan <hector.yuan@mediatek.com>
> ---
>  .../bindings/cpufreq/cpufreq-mediatek-hw.yaml      |  127 ++++++++++++++++++++
>  1 file changed, 127 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/cpufreq/cpufreq-mediatek-hw.yaml
> 
> diff --git a/Documentation/devicetree/bindings/cpufreq/cpufreq-mediatek-hw.yaml b/Documentation/devicetree/bindings/cpufreq/cpufreq-mediatek-hw.yaml
> new file mode 100644
> index 0000000..0f3ad47
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/cpufreq/cpufreq-mediatek-hw.yaml
> @@ -0,0 +1,127 @@
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

A common binding schema for this and 'performance-domains' needs to land 
first.

> +    description:
> +      Number of cells in a performance domain specifier. Typically 0 for nodes
> +      representing a single performance domain and 1 for nodes providing
> +      multiple performance domains (e.g. performance controllers), but can be
> +      any value as specified by device tree binding documentation of particular
> +      provider.
> +    enum: [ 0, 1 ]
> +
> +required:
> +  - compatible
> +  - reg
> +  - "#performance-domain-cells"
> +
> +additionalProperties: true
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
> +
> +            cpu1: cpu@100 {
> +                device_type = "cpu";
> +                compatible = "arm,cortex-a55";
> +                enable-method = "psci";
> +                performance-domains = <&performance 0>;
> +                reg = <0x100>;
> +            };
> +
> +            cpu2: cpu@200 {
> +                device_type = "cpu";
> +                compatible = "arm,cortex-a55";
> +                enable-method = "psci";
> +                performance-domains = <&performance 0>;
> +                reg = <0x200>;
> +            };
> +
> +            cpu3: cpu@300 {
> +                device_type = "cpu";
> +                compatible = "arm,cortex-a55";
> +                enable-method = "psci";
> +                performance-domains = <&performance 0>;
> +                reg = <0x300>;
> +            };
> +
> +            cpu4: cpu@400 {
> +                device_type = "cpu";
> +                compatible = "arm,cortex-a55";
> +                enable-method = "psci";
> +                performance-domains = <&performance 1>;

Seems a bit odd that a55 and a75 share a perf domain?


> +                reg = <0x400>;
> +            };
> +
> +            cpu5: cpu@500 {
> +                device_type = "cpu";
> +                compatible = "arm,cortex-a55";
> +                enable-method = "psci";
> +                performance-domains = <&performance 1>;
> +                reg = <0x500>;
> +            };
> +
> +            cpu6: cpu@600 {
> +                device_type = "cpu";
> +                compatible = "arm,cortex-a75";
> +                enable-method = "psci";
> +                performance-domains = <&performance 1>;
> +                reg = <0x600>;
> +            };
> +
> +            cpu7: cpu@700 {

Do we really need to show 8 cores to show how to use this binding?

> +                device_type = "cpu";
> +                compatible = "arm,cortex-a75";
> +                enable-method = "psci";
> +                performance-domains = <&performance 1>;
> +                reg = <0x700>;
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
