Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C2A68C228D
	for <lists+linux-pm@lfdr.de>; Mon, 30 Sep 2019 16:00:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730524AbfI3OAK (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 30 Sep 2019 10:00:10 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:36748 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726314AbfI3OAJ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 30 Sep 2019 10:00:09 -0400
Received: by mail-ot1-f67.google.com with SMTP id 67so8391261oto.3;
        Mon, 30 Sep 2019 07:00:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=zWqOCmK+EVHoXmsprNB6+C5z2qT9lgdlqmwLa5roa9g=;
        b=npLe5k4wJd63nXtRI/4mmfDm0i7wUopYsRHM780oaQiPCUdAwkNm2oHkqq045jUxnm
         +h+tGqYqHtKFaxmpI8EHNXdZxqgSa6poCJFazqAkaDu1mFqtzolySJmp03wm41LG3vxe
         jLZOFVwyGBy/FQWTxRyMkrwH3O0tnOdaUXYXYyimIcIhUMXf9Ii3YwF9jlCXyuycDUKK
         iQjwo9xVZcGhehCZPNbJ2YWaQGxVpIifrg2ZkUOVMdlAaV0xxPQKrHCDoQ8hQ+iIxXhL
         7Te11Tf7rXB8zKyMOwNI/KRlgz+7S0xAY+i8h25k0pi/WHGwFW3ttZkPxQXzveNuY8mH
         7a8A==
X-Gm-Message-State: APjAAAUg9/wyWl7mbur1aNz4GhAWTiDjpT4JtgTHCmYFauPn5sfZwR4C
        iS7qWzTCqFp+x2x73KU2Cg==
X-Google-Smtp-Source: APXvYqwMbnIHHY6UscVP7kTGfaBIXa0wwhPXnmdbiTGP/O2bknzJFYkrofWvrY7McB8yyvqeCiz3yA==
X-Received: by 2002:a9d:7ccd:: with SMTP id r13mr432570otn.191.1569852008304;
        Mon, 30 Sep 2019 07:00:08 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id a9sm3961715otc.75.2019.09.30.07.00.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2019 07:00:07 -0700 (PDT)
Date:   Mon, 30 Sep 2019 09:00:06 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: Re: [RFC 1/2] dt-bindings: power: Convert Generic Power Domain
 bindings to json-schema
Message-ID: <20190930140006.GA9671@bogus>
References: <20190908152813.20646-1-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190908152813.20646-1-krzk@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sun, Sep 08, 2019 at 05:28:12PM +0200, Krzysztof Kozlowski wrote:
> Convert Generic Power Domain bindings to DT schema format using
> json-schema.  The consumer bindings are split to separate file.
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> 
> ---
> 
> TODO:
> 1. How the consumer bindings should match nodes?

How it already done. The consumer binding is always applied so we 
always apply the type schema to the consumer properties. Device specific 
bindings have to list the consumer properties because they need to 
define how many power domains and the names.

> 2. Somehow the example complains:
> Documentation/devicetree/bindings/power/power-domain.example.dt.yaml: power-controller@12341000: power-domains:0: [1, 0] is too long
> Documentation/devicetree/bindings/power/power-domain.example.dt.yaml: power-controller@12341000: power-domains:0:1: missing phandle tag in 0

You used 'phandle' instead of 'phandle-array'. If you have cells, the 
latter is used. Perhaps we should distinguish between having cells or no 
cells.

> 3. Current matching by node name causes false positives:
> arch/arm/boot/dts/am335x-icev2.dt.yaml: power-controller@2d: '#power-domain-cells' is a required property
> arch/arm/boot/dts/qcom-apq8064-cm-qs600.dt.yaml: power-controller@2099000: '#power-domain-cells' is a required property

They should have different node names if they are not power-domain 
providers.

> ---
>  .../devicetree/bindings/arm/arm,scmi.txt      |   2 +-
>  .../devicetree/bindings/arm/arm,scpi.txt      |   2 +-
>  .../bindings/arm/freescale/fsl,scu.txt        |   2 +-
>  .../bindings/clock/clk-exynos-audss.txt       |   2 +-
>  .../bindings/clock/exynos5433-clock.txt       |   4 +-
>  .../bindings/clock/renesas,cpg-mssr.txt       |   2 +-
>  .../clock/renesas,r8a7778-cpg-clocks.txt      |   2 +-
>  .../clock/renesas,r8a7779-cpg-clocks.txt      |   2 +-
>  .../clock/renesas,rcar-gen2-cpg-clocks.txt    |   2 +-
>  .../bindings/clock/renesas,rz-cpg-clocks.txt  |   2 +-
>  .../bindings/clock/ti/davinci/psc.txt         |   2 +-
>  .../bindings/display/etnaviv/etnaviv-drm.txt  |   2 +-
>  .../devicetree/bindings/display/msm/dpu.txt   |   2 +-
>  .../devicetree/bindings/display/msm/mdp5.txt  |   2 +-
>  .../devicetree/bindings/dsp/fsl,dsp.yaml      |   2 +-
>  .../firmware/nvidia,tegra186-bpmp.txt         |   2 +-
>  .../bindings/media/imx7-mipi-csi2.txt         |   3 +-
>  .../bindings/media/mediatek-jpeg-decoder.txt  |   3 +-
>  .../bindings/media/mediatek-mdp.txt           |   3 +-
>  .../bindings/opp/qcom-nvmem-cpufreq.txt       |   2 +-
>  .../devicetree/bindings/pci/pci-keystone.txt  |   2 +-
>  .../bindings/phy/ti,phy-am654-serdes.txt      |   2 +-
>  .../bindings/power/amlogic,meson-gx-pwrc.txt  |   2 +-
>  .../devicetree/bindings/power/fsl,imx-gpc.txt |   2 +-
>  .../bindings/power/fsl,imx-gpcv2.txt          |   2 +-
>  .../power/power-domain-consumers.yaml         | 124 +++++++++++
>  .../bindings/power/power-domain.yaml          | 136 ++++++++++++
>  .../bindings/power/power_domain.txt           | 205 ------------------
>  .../devicetree/bindings/power/qcom,rpmpd.txt  |   2 +-
>  .../bindings/power/renesas,rcar-sysc.txt      |   2 +-
>  .../bindings/power/renesas,sysc-rmobile.txt   |   2 +-
>  .../bindings/power/xlnx,zynqmp-genpd.txt      |   2 +-
>  .../bindings/soc/bcm/brcm,bcm2835-pm.txt      |   2 +-
>  .../bindings/soc/mediatek/scpsys.txt          |   2 +-
>  .../bindings/soc/ti/sci-pm-domain.txt         |   2 +-
>  .../bindings/usb/nvidia,tegra124-xusb.txt     |   4 +-
>  MAINTAINERS                                   |   2 +-
>  37 files changed, 299 insertions(+), 241 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/power/power-domain-consumers.yaml
>  create mode 100644 Documentation/devicetree/bindings/power/power-domain.yaml
>  delete mode 100644 Documentation/devicetree/bindings/power/power_domain.txt


> diff --git a/Documentation/devicetree/bindings/power/power-domain-consumers.yaml b/Documentation/devicetree/bindings/power/power-domain-consumers.yaml
> new file mode 100644
> index 000000000000..95cc6da1e8a8
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/power/power-domain-consumers.yaml
> @@ -0,0 +1,124 @@
> +# SPDX-License-Identifier: GPL-2.0
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/power/power-domain-consumers.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: PM domain consumers
> +
> +maintainers:
> +  - Rafael J. Wysocki <rjw@rjwysocki.net>
> +  - Kevin Hilman <khilman@kernel.org>
> +  - Ulf Hansson <ulf.hansson@linaro.org>
> +
> +description: |+
> +  See power-domain.yaml
> +
> +allOf:
> +  - $ref: /schemas/power-domain/power-domain-consumer.yaml
> +
> +# TODO: missing select (compatible?)
> +
> +properties:
> +  power-domains:
> +    $ref: /schemas/types.yaml#/definitions/phandle-array
> +    description:
> +      A list of PM domain specifiers, as defined by bindings of the power
> +      controller that is the PM domain provider.
> +
> +  power-domain-names:
> +    $ref: /schemas/types.yaml#/definitions/string-array
> +    description:
> +      A list of power domain name strings sorted in the same order
> +      as the power-domains property. Consumers drivers will use
> +      power-domain-names to match power domains with power-domains specifiers.

Why are we duplicating this?

> +
> +  required-opps:
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +    description:
> +      This contains phandle to an OPP node in another device's OPP table.
> +      It may contain an array of phandles, where each phandle points to an OPP
> +      of a different device. It should not contain multiple phandles to the OPP
> +      nodes in the same OPP table. This specifies the minimum required OPP
> +      of the device(s), whose OPP's phandle is present in this property,
> +      for the functioning of the current device at the current OPP (where this
> +      property is present).
> +
> +required:
> +  - power-domains
> +
> +dependencies:
> +  power-domain-names: [ power-domains ]
> +
> +examples:
> +  - |
> +    leaky-device@12350000 {
> +      compatible = "foo,i-leak-current";
> +      reg = <0x12350000 0x1000>;
> +      power-domains = <&power 0>;
> +      power-domain-names = "io";
> +    };
> +
> +    leaky-device@12351000 {
> +      compatible = "foo,i-leak-current";
> +      reg = <0x12351000 0x1000>;
> +      power-domains = <&power 0>, <&power 1> ;
> +      power-domain-names = "io", "clk";
> +    };
> +
> +    // The first example above defines a typical PM domain consumer device, which is
> +    // located inside a PM domain with index 0 of a power controller represented by a
> +    // node with the label "power".
> +    // In the second example the consumer device are partitioned across two PM domains,
> +    // the first with index 0 and the second with index 1, of a power controller that
> +    // is represented by a node with the label "power".
> +
> +  - |
> +    // Example with  OPP table for domain provider that provides two domains:
> +
> +    domain0_opp_table: opp-table0 {
> +      compatible = "operating-points-v2";
> +
> +      domain0_opp_0: opp-1000000000 {
> +        opp-hz = /bits/ 64 <1000000000>;
> +        opp-microvolt = <975000 970000 985000>;
> +      };
> +      domain0_opp_1: opp-1100000000 {
> +        opp-hz = /bits/ 64 <1100000000>;
> +        opp-microvolt = <1000000 980000 1010000>;
> +      };
> +    };
> +
> +    domain1_opp_table: opp-table1 {
> +      compatible = "operating-points-v2";
> +
> +      domain1_opp_0: opp-1200000000 {
> +        opp-hz = /bits/ 64 <1200000000>;
> +        opp-microvolt = <975000 970000 985000>;
> +      };
> +      domain1_opp_1: opp-1300000000 {
> +        opp-hz = /bits/ 64 <1300000000>;
> +        opp-microvolt = <1000000 980000 1010000>;
> +      };
> +    };
> +
> +    power: power-controller@12340000 {
> +      compatible = "foo,power-controller";
> +      reg = <0x12340000 0x1000>;
> +      #power-domain-cells = <1>;
> +      operating-points-v2 = <&domain0_opp_table>, <&domain1_opp_table>;
> +    };
> +
> +    leaky-device0@12350000 {
> +      compatible = "foo,i-leak-current";
> +      reg = <0x12350000 0x1000>;
> +      power-domains = <&power 0>;
> +      required-opps = <&domain0_opp_0>;
> +    };
> +
> +    leaky-device1@12350000 {
> +      compatible = "foo,i-leak-current";
> +      reg = <0x12350000 0x1000>;
> +      power-domains = <&power 1>;
> +      required-opps = <&domain1_opp_1>;
> +    };
> diff --git a/Documentation/devicetree/bindings/power/power-domain.yaml b/Documentation/devicetree/bindings/power/power-domain.yaml
> new file mode 100644
> index 000000000000..9454fdb904ae
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/power/power-domain.yaml
> @@ -0,0 +1,136 @@
> +# SPDX-License-Identifier: GPL-2.0
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/power/power-domain.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Generic PM domains
> +
> +maintainers:
> +  - Rafael J. Wysocki <rjw@rjwysocki.net>
> +  - Kevin Hilman <khilman@kernel.org>
> +  - Ulf Hansson <ulf.hansson@linaro.org>
> +
> +description: |+
> +  System on chip designs are often divided into multiple PM domains that can be
> +  used for power gating of selected IP blocks for power saving by reduced leakage
> +  current.
> +
> +  This device tree binding can be used to bind PM domain consumer devices with
> +  their PM domains provided by PM domain providers. A PM domain provider can be
> +  represented by any node in the device tree and can provide one or more PM
> +  domains. A consumer node can refer to the provider by a phandle and a set of
> +  phandle arguments (so called PM domain specifiers) of length specified by the
> +  \#power-domain-cells property in the PM domain provider node.
> +
> +properties:
> +  $nodename:
> +    pattern: "^(power-controller|power-domain)(@.*)?"
> +
> +  domain-idle-states:
> +    $ref: /schemas/types.yaml#/definitions/phandle-array
> +    description:
> +      A phandle of an idle-state that shall be soaked into a generic domain
> +      power state. The idle state definitions are compatible with
> +      domain-idle-state specified in
> +      Documentation/devicetree/bindings/power/domain-idle-state.txt
> +      phandles that are not compatible with domain-idle-state will be ignored.
> +      The domain-idle-state property reflects the idle state of this PM domain
> +      and not the idle states of the devices or sub-domains in the PM domain.
> +      Devices and sub-domains have their own idle-states independent
> +      of the parent domain's idle states. In the absence of this property,
> +      the domain would be considered as capable of being powered-on
> +      or powered-off.
> +
> +  operating-points-v2:
> +    $ref: /schemas/types.yaml#/definitions/phandle-array

This needs to be defined as part of an OPP schema. I guess there's some 
value listing it here, but a device specific binding will still have to 
list it to define how many entries.

> +    description:
> +      Phandles to the OPP tables of power domains provided by a power domain
> +      provider. If the provider provides a single power domain only or all
> +      the power domains provided by the provider have identical OPP tables,
> +      then this shall contain a single phandle. Refer to ../opp/opp.txt
> +      for more information.
> +
> +  "#power-domain-cells":
> +    $ref: /schemas/types.yaml#/definitions/uint32

Strictly speaking, we don't need to define the type as '#.*-cells' has a 
type.

> +    description:
> +      Number of cells in a PM domain specifier. Typically 0 for nodes
> +      representing a single PM domain and 1 for nodes providing multiple PM
> +      domains (e.g. power controllers), but can be any value as specified
> +      by device tree binding documentation of particular provider.
> +
> +  power-domains:
> +    $ref: /schemas/types.yaml#/definitions/phandle

Don't need type here either.

> +    description:
> +       A phandle and PM domain specifier as defined by bindings of the power
> +       controller specified by phandle. Some power domains might be powered
> +       from another power domain (or have other hardware specific
> +       dependencies). For representing such dependency a standard PM domain
> +       consumer binding is used. When provided, all domains created
> +       by the given provider should be subdomains of the domain specified
> +       by this binding. More details about power domain specifier are
> +       available in the power-domain-consumers.yaml.
> +
> +required:
> +  - "#power-domain-cells"
> +
> +examples:
> +  - |
> +    power: power-controller@12340000 {
> +      compatible = "foo,power-controller";
> +      reg = <0x12340000 0x1000>;
> +      #power-domain-cells = <1>;
> +    };
> +
> +    // The node above defines a power controller that is a PM domain provider and
> +    // expects one cell as its phandle argument.
> +
> +  - |
> +    parent2: power-controller@12340000 {
> +      compatible = "foo,power-controller";
> +      reg = <0x12340000 0x1000>;
> +      #power-domain-cells = <1>;
> +    };
> +
> +    child2: power-controller@12341000 {
> +      compatible = "foo,power-controller";
> +      reg = <0x12341000 0x1000>;
> +      power-domains = <&parent2 0>;
> +      #power-domain-cells = <1>;
> +    };
> +
> +    // The nodes above define two power controllers: 'parent' and 'child'.
> +    // Domains created by the 'child' power controller are subdomains of '0' power
> +    // domain provided by the 'parent' power controller.
> +
> +  - |
> +    parent3: power-controller@12340000 {
> +      compatible = "foo,power-controller";
> +      reg = <0x12340000 0x1000>;
> +      #power-domain-cells = <0>;
> +      domain-idle-states = <&DOMAIN_RET>, <&DOMAIN_PWR_DN>;
> +    };
> +
> +    child3: power-controller@12341000 {
> +      compatible = "foo,power-controller";
> +      reg = <0x12341000 0x1000>;
> +      power-domains = <&parent3>;
> +      #power-domain-cells = <0>;
> +      domain-idle-states = <&DOMAIN_PWR_DN>;
> +    };
> +
> +    DOMAIN_RET: state@0 {
> +      compatible = "domain-idle-state";
> +      reg = <0x0 0x0>;
> +      entry-latency-us = <1000>;
> +      exit-latency-us = <2000>;
> +      min-residency-us = <10000>;
> +    };
> +
> +    DOMAIN_PWR_DN: state@1 {
> +      compatible = "domain-idle-state";
> +      reg = <0x1 0x0>;
> +      entry-latency-us = <5000>;
> +      exit-latency-us = <8000>;
> +      min-residency-us = <7000>;
> +    };


