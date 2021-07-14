Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 075CB3C9329
	for <lists+linux-pm@lfdr.de>; Wed, 14 Jul 2021 23:34:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231302AbhGNVhs (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 14 Jul 2021 17:37:48 -0400
Received: from mail-io1-f51.google.com ([209.85.166.51]:42862 "EHLO
        mail-io1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229657AbhGNVhs (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 14 Jul 2021 17:37:48 -0400
Received: by mail-io1-f51.google.com with SMTP id x10so3914208ion.9;
        Wed, 14 Jul 2021 14:34:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=qa19bylC8dbcRYqFYZOWdReoPLODAr1Mpa66XCTD0Sk=;
        b=CgE8/DuP/5LBHWeqsBD4GTMfIZmyWK6qyJ0xHw66U4eh6dpk//X2XhDObwz/nPeYfZ
         6+dAfG2l3yfcqhtLbv5aDkivR5vy6+nQBMsaFlf1JhgwDyfLZji5RiaNiAqpch/KZPHs
         tu9sLMre10B/fSvmvw8OVEWLt0IAyfj8Ey27vbqg9B5MHbUTE1u9d8cxTlFodPzMNiAU
         gBUGmKXWsrdc/Ye5h8aBuoNsTNG75ObjyQMa5PEwQMtsuO3WPILMNN32iqBezirnbgLc
         efW8KppwAm/hBW3TQrwupPLRSEWwjIaD6aGr4a/3vv2q7eJG5srwB71xn0LrzEvsob+g
         pakg==
X-Gm-Message-State: AOAM530bhpi2lrr4d8ugJma3QSbxaTjaMyUvQ4+8O9CdeHDUpd8cv2wq
        VZA5kYiyyeKwQbjUJMa3Yg==
X-Google-Smtp-Source: ABdhPJzJbZoxoyskGUPI9ILx9sH1LHGGrhoqVyK7qYPX2+hjYm09VlmKVmU2vwUju2TJ1+OWuPBbfw==
X-Received: by 2002:a5d:9681:: with SMTP id m1mr127485ion.113.1626298494885;
        Wed, 14 Jul 2021 14:34:54 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id y198sm1967378iof.25.2021.07.14.14.34.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jul 2021 14:34:54 -0700 (PDT)
Received: (nullmailer pid 3567830 invoked by uid 1000);
        Wed, 14 Jul 2021 21:34:52 -0000
Date:   Wed, 14 Jul 2021 15:34:52 -0600
From:   Rob Herring <robh@kernel.org>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>
Cc:     bjorn.andersson@linaro.org, viresh.kumar@linaro.org,
        agross@kernel.org, rjw@rjwysocki.net, devicetree@vger.kernel.org,
        amit.kucheria@linaro.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, phone-devel@vger.kernel.org,
        konrad.dybcio@somainline.org, marijn.suijten@somainline.org,
        martin.botka@somainline.org, jami.kettunen@somainline.org,
        paul.bouchara@somainline.org,
        ~postmarketos/upstreaming@lists.sr.ht, jeffrey.l.hugo@gmail.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: Re: [PATCH v6 4/9] dt-bindings: cpufreq: cpufreq-qcom-hw: Convert to
 YAML bindings
Message-ID: <20210714213452.GA3558561@robh.at.kernel.org>
References: <20210701105730.322718-1-angelogioacchino.delregno@somainline.org>
 <20210701105730.322718-5-angelogioacchino.delregno@somainline.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210701105730.322718-5-angelogioacchino.delregno@somainline.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Jul 01, 2021 at 12:57:25PM +0200, AngeloGioacchino Del Regno wrote:
> From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> 
> Convert Qualcomm cpufreq devicetree binding to YAML.

I agree with moving to the performance domains, but that's a separate 
task from converting the binding.

> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>
> ---
>  .../bindings/cpufreq/cpufreq-qcom-hw.txt      | 172 ---------------
>  .../bindings/cpufreq/cpufreq-qcom-hw.yaml     | 204 ++++++++++++++++++
>  2 files changed, 204 insertions(+), 172 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.txt
>  create mode 100644 Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml
> 
> diff --git a/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.txt b/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.txt
> deleted file mode 100644
> index 9299028ee712..000000000000
> --- a/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.txt
> +++ /dev/null
> @@ -1,172 +0,0 @@
> -Qualcomm Technologies, Inc. CPUFREQ Bindings
> -
> -CPUFREQ HW is a hardware engine used by some Qualcomm Technologies, Inc. (QTI)
> -SoCs to manage frequency in hardware. It is capable of controlling frequency
> -for multiple clusters.
> -
> -Properties:
> -- compatible
> -	Usage:		required
> -	Value type:	<string>
> -	Definition:	must be "qcom,cpufreq-hw" or "qcom,cpufreq-epss".
> -
> -- clocks
> -	Usage:		required
> -	Value type:	<phandle> From common clock binding.
> -	Definition:	clock handle for XO clock and GPLL0 clock.
> -
> -- clock-names
> -	Usage:		required
> -	Value type:	<string> From common clock binding.
> -	Definition:	must be "xo", "alternate".
> -
> -- reg
> -	Usage:		required
> -	Value type:	<prop-encoded-array>
> -	Definition:	Addresses and sizes for the memory of the HW bases in
> -			each frequency domain.
> -- reg-names
> -	Usage:		Optional
> -	Value type:	<string>
> -	Definition:	Frequency domain name i.e.
> -			"freq-domain0", "freq-domain1".
> -
> -- #freq-domain-cells:
> -	Usage:		required.
> -	Definition:	Number of cells in a freqency domain specifier.
> -
> -* Property qcom,freq-domain
> -Devices supporting freq-domain must set their "qcom,freq-domain" property with
> -phandle to a cpufreq_hw followed by the Domain ID(0/1) in the CPU DT node.
> -
> -
> -Example:
> -
> -Example 1: Dual-cluster, Quad-core per cluster. CPUs within a cluster switch
> -DCVS state together.
> -
> -/ {
> -	cpus {
> -		#address-cells = <2>;
> -		#size-cells = <0>;
> -
> -		CPU0: cpu@0 {
> -			device_type = "cpu";
> -			compatible = "qcom,kryo385";
> -			reg = <0x0 0x0>;
> -			enable-method = "psci";
> -			next-level-cache = <&L2_0>;
> -			qcom,freq-domain = <&cpufreq_hw 0>;
> -			L2_0: l2-cache {
> -				compatible = "cache";
> -				next-level-cache = <&L3_0>;
> -				L3_0: l3-cache {
> -				      compatible = "cache";
> -				};
> -			};
> -		};
> -
> -		CPU1: cpu@100 {
> -			device_type = "cpu";
> -			compatible = "qcom,kryo385";
> -			reg = <0x0 0x100>;
> -			enable-method = "psci";
> -			next-level-cache = <&L2_100>;
> -			qcom,freq-domain = <&cpufreq_hw 0>;
> -			L2_100: l2-cache {
> -				compatible = "cache";
> -				next-level-cache = <&L3_0>;
> -			};
> -		};
> -
> -		CPU2: cpu@200 {
> -			device_type = "cpu";
> -			compatible = "qcom,kryo385";
> -			reg = <0x0 0x200>;
> -			enable-method = "psci";
> -			next-level-cache = <&L2_200>;
> -			qcom,freq-domain = <&cpufreq_hw 0>;
> -			L2_200: l2-cache {
> -				compatible = "cache";
> -				next-level-cache = <&L3_0>;
> -			};
> -		};
> -
> -		CPU3: cpu@300 {
> -			device_type = "cpu";
> -			compatible = "qcom,kryo385";
> -			reg = <0x0 0x300>;
> -			enable-method = "psci";
> -			next-level-cache = <&L2_300>;
> -			qcom,freq-domain = <&cpufreq_hw 0>;
> -			L2_300: l2-cache {
> -				compatible = "cache";
> -				next-level-cache = <&L3_0>;
> -			};
> -		};
> -
> -		CPU4: cpu@400 {
> -			device_type = "cpu";
> -			compatible = "qcom,kryo385";
> -			reg = <0x0 0x400>;
> -			enable-method = "psci";
> -			next-level-cache = <&L2_400>;
> -			qcom,freq-domain = <&cpufreq_hw 1>;
> -			L2_400: l2-cache {
> -				compatible = "cache";
> -				next-level-cache = <&L3_0>;
> -			};
> -		};
> -
> -		CPU5: cpu@500 {
> -			device_type = "cpu";
> -			compatible = "qcom,kryo385";
> -			reg = <0x0 0x500>;
> -			enable-method = "psci";
> -			next-level-cache = <&L2_500>;
> -			qcom,freq-domain = <&cpufreq_hw 1>;
> -			L2_500: l2-cache {
> -				compatible = "cache";
> -				next-level-cache = <&L3_0>;
> -			};
> -		};
> -
> -		CPU6: cpu@600 {
> -			device_type = "cpu";
> -			compatible = "qcom,kryo385";
> -			reg = <0x0 0x600>;
> -			enable-method = "psci";
> -			next-level-cache = <&L2_600>;
> -			qcom,freq-domain = <&cpufreq_hw 1>;
> -			L2_600: l2-cache {
> -				compatible = "cache";
> -				next-level-cache = <&L3_0>;
> -			};
> -		};
> -
> -		CPU7: cpu@700 {
> -			device_type = "cpu";
> -			compatible = "qcom,kryo385";
> -			reg = <0x0 0x700>;
> -			enable-method = "psci";
> -			next-level-cache = <&L2_700>;
> -			qcom,freq-domain = <&cpufreq_hw 1>;
> -			L2_700: l2-cache {
> -				compatible = "cache";
> -				next-level-cache = <&L3_0>;
> -			};
> -		};
> -	};
> -
> - soc {
> -	cpufreq_hw: cpufreq@17d43000 {
> -		compatible = "qcom,cpufreq-hw";
> -		reg = <0x17d43000 0x1400>, <0x17d45800 0x1400>;
> -		reg-names = "freq-domain0", "freq-domain1";
> -
> -		clocks = <&rpmhcc RPMH_CXO_CLK>, <&gcc GPLL0>;
> -		clock-names = "xo", "alternate";
> -
> -		#freq-domain-cells = <1>;
> -	};
> -}
> diff --git a/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml b/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml
> new file mode 100644
> index 000000000000..bc81b6203e27
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml
> @@ -0,0 +1,204 @@
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
> +required:
> +  - compatible
> +  - reg
> +  - reg-names

This was optional before. (The names are quite pointless here given they 
just repeat the index.)

With that,

Reviewed-by: Rob Herring <robh@kernel.org>

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
> 2.32.0
> 
> 
