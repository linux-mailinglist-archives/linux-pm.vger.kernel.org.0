Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 067642862A3
	for <lists+linux-pm@lfdr.de>; Wed,  7 Oct 2020 17:54:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728820AbgJGPx5 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 7 Oct 2020 11:53:57 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:34385 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726129AbgJGPx5 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 7 Oct 2020 11:53:57 -0400
Received: by mail-ot1-f65.google.com with SMTP id d28so2697245ote.1;
        Wed, 07 Oct 2020 08:53:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=KbjfCdsNwGyDcg/k4BW/d7Ia3QjY2peoXvXiPInjTco=;
        b=W0XrHYa0z7yUWGILSwQHmjSDn+yx81Xbw9wa78ImL8+gz5V7vFJbK1X5Nl0cUzW64y
         bDZmhu0o2g5oWOsS47nsWxmfJVTuGykiXYFaN9ILJ3GewBhXM9wKiiBFKI27x0dugYHm
         3JZWX0yk8+TUU53d61OdVHgLsad/exGh6+v2Zr5aROP1OhIPKyzR7/rPZQEmLjomnbE6
         jnXYCBiTvu4uxm2uXfnPDMD78sQesT5XDCMI9RjiV+QftRM2Pyk2zE/NpPsAIjlKiOjj
         EgZDjPIdYo9q97dd0wh5U90lcKzWJtvdCz2z3ffkR2vs8pj7/80zTHhQUJEhHJpuN3Kj
         65ww==
X-Gm-Message-State: AOAM530Bytjnj37CIrSkYCB7wmbb27AJjEBotJYP9i2lBX/8986wWJAv
        cww8iOji+bwx9h6PTeUdQ0J2kUE0YhAB
X-Google-Smtp-Source: ABdhPJx07dav7FJlUaTyDCuhfex1+oExX1zwuEoT7zsF/BD2GZmyOLS4HYhMvBUJN+IGNFr5AM3AUA==
X-Received: by 2002:a05:6830:211a:: with SMTP id i26mr2191412otc.101.1602086034246;
        Wed, 07 Oct 2020 08:53:54 -0700 (PDT)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id o205sm2205554oig.8.2020.10.07.08.53.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Oct 2020 08:53:53 -0700 (PDT)
Received: (nullmailer pid 288914 invoked by uid 1000);
        Wed, 07 Oct 2020 15:53:52 -0000
Date:   Wed, 7 Oct 2020 10:53:52 -0500
From:   Rob Herring <robh@kernel.org>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     rjw@rjwysocki.net, viresh.kumar@linaro.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, bjorn.andersson@linaro.org,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: cpufreq: cpufreq-qcom-hw: Convert to YAML
 bindings
Message-ID: <20201007155352.GA285247@bogus>
References: <20201006095047.30242-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201006095047.30242-1-manivannan.sadhasivam@linaro.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Oct 06, 2020 at 03:20:47PM +0530, Manivannan Sadhasivam wrote:
> Convert Qualcomm cpufreq devicetree binding to YAML.
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>  .../bindings/cpufreq/cpufreq-qcom-hw.txt      | 172 --------------
>  .../bindings/cpufreq/cpufreq-qcom-hw.yaml     | 212 ++++++++++++++++++
>  2 files changed, 212 insertions(+), 172 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.txt
>  create mode 100644 Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml

> diff --git a/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml b/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml
> new file mode 100644
> index 000000000000..a11c69a29b5d
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml
> @@ -0,0 +1,212 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/cpufreq/cpufreq-qcom-hw.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Qualcomm Technologies, Inc. CPUFREQ
> +
> +maintainers:
> +  - Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> +
> +description: |
> +
> +  CPUFREQ HW is a hardware engine used by some Qualcomm Technologies, Inc. (QTI)
> +  SoCs to manage frequency in hardware. It is capable of controlling frequency
> +  for multiple clusters.
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - description: v1 of CPUFREQ HW
> +        items:
> +          - const: qcom,cpufreq-hw
> +
> +      - description: v2 of CPUFREQ HW (EPSS)
> +        items:
> +          - enum:
> +              - qcom,sm8250-cpufreq-epss
> +          - const: qcom,cpufreq-epss
> +
> +  reg:
> +    minItems: 2
> +    maxItems: 3
> +    items:
> +      - description: Frequency domain 0 register region
> +      - description: Frequency domain 1 register region
> +      - description: Frequency domain 2 register region
> +
> +  reg-names:
> +    minItems: 2
> +    maxItems: 3
> +    items:
> +      - const: freq-domain0
> +      - const: freq-domain1
> +      - const: freq-domain2
> +
> +  clocks:
> +    items:
> +      - description: XO Clock
> +      - description: GPLL0 Clock
> +
> +  clock-names:
> +    items:
> +      - const: xo
> +      - const: alternate
> +
> +  '#freq-domain-cells':
> +    const: 1
> +
> +  qcom,freq-domain:
> +    $ref: /schemas/types.yaml#/definitions/phandle-array
> +    maxItems: 1
> +    description:
> +      Devices supporting freq-domain must set their "qcom,freq-domain"
> +      property with phandle to a cpufreq_hw followed by the Domain ID(0/1)
> +      in the CPU DT node.

This doesn't belong here as it goes in cpu nodes. You're going to need 
to define a QCom cpu schema that defines this.

> +
> +required:
> +  - compatible
> +  - reg
> +  - reg-names
> +  - clocks
> +  - clock-names
> +  - '#freq-domain-cells'
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/qcom,gcc-sdm845.h>
> +    #include <dt-bindings/clock/qcom,rpmh.h>
> +
> +    // Example 1: Dual-cluster, Quad-core per cluster. CPUs within a cluster
> +    // switch DCVS state together.
> +    cpus {
> +      #address-cells = <2>;
> +      #size-cells = <0>;
> +
> +      CPU0: cpu@0 {
> +        device_type = "cpu";
> +        compatible = "qcom,kryo385";
> +        reg = <0x0 0x0>;
> +        enable-method = "psci";
> +        next-level-cache = <&L2_0>;
> +        qcom,freq-domain = <&cpufreq_hw 0>;
> +        L2_0: l2-cache {
> +          compatible = "cache";
> +          next-level-cache = <&L3_0>;
> +          L3_0: l3-cache {
> +            compatible = "cache";
> +          };
> +        };
> +      };
> +
> +      CPU1: cpu@100 {
> +        device_type = "cpu";
> +        compatible = "qcom,kryo385";
> +        reg = <0x0 0x100>;
> +        enable-method = "psci";
> +        next-level-cache = <&L2_100>;
> +        qcom,freq-domain = <&cpufreq_hw 0>;
> +        L2_100: l2-cache {
> +          compatible = "cache";
> +          next-level-cache = <&L3_0>;
> +        };
> +      };
> +
> +      CPU2: cpu@200 {
> +        device_type = "cpu";
> +        compatible = "qcom,kryo385";
> +        reg = <0x0 0x200>;
> +        enable-method = "psci";
> +        next-level-cache = <&L2_200>;
> +        qcom,freq-domain = <&cpufreq_hw 0>;
> +        L2_200: l2-cache {
> +          compatible = "cache";
> +          next-level-cache = <&L3_0>;
> +        };
> +      };
> +
> +      CPU3: cpu@300 {
> +        device_type = "cpu";
> +        compatible = "qcom,kryo385";
> +        reg = <0x0 0x300>;
> +        enable-method = "psci";
> +        next-level-cache = <&L2_300>;
> +        qcom,freq-domain = <&cpufreq_hw 0>;
> +        L2_300: l2-cache {
> +          compatible = "cache";
> +          next-level-cache = <&L3_0>;
> +        };
> +      };
> +
> +      CPU4: cpu@400 {
> +        device_type = "cpu";
> +        compatible = "qcom,kryo385";
> +        reg = <0x0 0x400>;
> +        enable-method = "psci";
> +        next-level-cache = <&L2_400>;
> +        qcom,freq-domain = <&cpufreq_hw 1>;
> +        L2_400: l2-cache {
> +          compatible = "cache";
> +          next-level-cache = <&L3_0>;
> +        };
> +      };
> +
> +      CPU5: cpu@500 {
> +        device_type = "cpu";
> +        compatible = "qcom,kryo385";
> +        reg = <0x0 0x500>;
> +        enable-method = "psci";
> +        next-level-cache = <&L2_500>;
> +        qcom,freq-domain = <&cpufreq_hw 1>;
> +        L2_500: l2-cache {
> +          compatible = "cache";
> +          next-level-cache = <&L3_0>;
> +        };
> +      };
> +
> +      CPU6: cpu@600 {
> +        device_type = "cpu";
> +        compatible = "qcom,kryo385";
> +        reg = <0x0 0x600>;
> +        enable-method = "psci";
> +        next-level-cache = <&L2_600>;
> +        qcom,freq-domain = <&cpufreq_hw 1>;
> +        L2_600: l2-cache {
> +          compatible = "cache";
> +          next-level-cache = <&L3_0>;
> +        };
> +      };
> +
> +      CPU7: cpu@700 {
> +        device_type = "cpu";
> +        compatible = "qcom,kryo385";
> +        reg = <0x0 0x700>;
> +        enable-method = "psci";
> +        next-level-cache = <&L2_700>;
> +        qcom,freq-domain = <&cpufreq_hw 1>;
> +        L2_700: l2-cache {
> +          compatible = "cache";
> +          next-level-cache = <&L3_0>;
> +        };
> +      };
> +    };
> +
> +    soc {
> +      #address-cells = <1>;
> +      #size-cells = <1>;
> +
> +      cpufreq@17d43000 {
> +        compatible = "qcom,cpufreq-hw";
> +        reg = <0x17d43000 0x1400>, <0x17d45800 0x1400>;
> +        reg-names = "freq-domain0", "freq-domain1";
> +
> +        clocks = <&rpmhcc RPMH_CXO_CLK>, <&gcc GPLL0>;
> +        clock-names = "xo", "alternate";
> +
> +        #freq-domain-cells = <1>;
> +      };
> +    };
> +...
> -- 
> 2.17.1
> 
