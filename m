Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E88B32F20B2
	for <lists+linux-pm@lfdr.de>; Mon, 11 Jan 2021 21:24:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404036AbhAKUYc (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 11 Jan 2021 15:24:32 -0500
Received: from mail-oi1-f180.google.com ([209.85.167.180]:42287 "EHLO
        mail-oi1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403977AbhAKUY1 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 11 Jan 2021 15:24:27 -0500
Received: by mail-oi1-f180.google.com with SMTP id l200so667997oig.9;
        Mon, 11 Jan 2021 12:24:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=N+l7oEoC2Gtdd3tsUSXfbCD3VNBOdwhPR2for7AGSP0=;
        b=BfeH9dnmszit+bA8pGswZrF7E/0dltNYlKrH7qRsb9tK8JYOlhSOZgcA3jaQY9IUJK
         8GdZYRW0bCFRk2lCdstkkAUZf6RbpSb05/VpxBfr9soFUnYCAG1HNttS7AWVJFvmstgi
         /klIi7UG2VoEfpNzfFrbJ3cYCvKBw4rD0Ngt+oJpqxT2SMiQKWGzRWMe6FrsIXLlEVnr
         my3QBk6LnzX1KrSFs5jqdPmdXcBAdspNmOIEIYy0+Teo6QeUg62MM5LDNxzmp2/bNykG
         96y5lnGH78/t0WNPXsY0fdgW2JfPZDpnpuYbEWTly+0fNESMhd4Obck/tNz0FAwh7tS2
         r2BQ==
X-Gm-Message-State: AOAM531UHItUO4sNLoEl2TBX++V3yfSbE9kzAxKT80ODd2e0aD5ooibM
        GHmNRvYku2HofybdZb16LQ==
X-Google-Smtp-Source: ABdhPJwWxknOlQUQyjNGUH3P7COKkSvblU0b4yZxPrYfjVei7f813EPmKrrInAQ0BrcWWGXpSQEl5g==
X-Received: by 2002:a05:6808:8f0:: with SMTP id d16mr344964oic.47.1610396626307;
        Mon, 11 Jan 2021 12:23:46 -0800 (PST)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id v4sm171269otk.50.2021.01.11.12.23.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jan 2021 12:23:45 -0800 (PST)
Received: (nullmailer pid 3005685 invoked by uid 1000);
        Mon, 11 Jan 2021 20:23:44 -0000
Date:   Mon, 11 Jan 2021 14:23:44 -0600
From:   Rob Herring <robh@kernel.org>
To:     Hector Yuan <hector.yuan@mediatek.com>
Cc:     linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        wsd_upstream@mediatek.com
Subject: Re: [PATCH v10 2/2] dt-bindings: cpufreq: add bindings for MediaTek
 cpufreq HW
Message-ID: <20210111202344.GA2999777@robh.at.kernel.org>
References: <1609222629-2979-1-git-send-email-hector.yuan@mediatek.com>
 <1609222629-2979-3-git-send-email-hector.yuan@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1609222629-2979-3-git-send-email-hector.yuan@mediatek.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Dec 29, 2020 at 02:17:09PM +0800, Hector Yuan wrote:
> From: "Hector.Yuan" <hector.yuan@mediatek.com>
> 
> Add devicetree bindings for MediaTek HW driver.
> 
> Signed-off-by: Hector.Yuan <hector.yuan@mediatek.com>
> ---
>  .../bindings/cpufreq/cpufreq-mediatek-hw.yaml      |  116 ++++++++++++++++++++
>  1 file changed, 116 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/cpufreq/cpufreq-mediatek-hw.yaml
> 
> diff --git a/Documentation/devicetree/bindings/cpufreq/cpufreq-mediatek-hw.yaml b/Documentation/devicetree/bindings/cpufreq/cpufreq-mediatek-hw.yaml
> new file mode 100644
> index 0000000..53e0eb3
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/cpufreq/cpufreq-mediatek-hw.yaml
> @@ -0,0 +1,116 @@
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
> +required:
> +  - compatible
> +  - reg
> +
> +additionalProperties: true

This is only correct on common bindings which are incomplete. You need 
to define '#performance-domain-cells'.

And this is all dependent on performance-domains binding being accepted.

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
> +            #performance-domain-cells = <1>;
> +        };
> +    };
> -- 
> 1.7.9.5
> 
