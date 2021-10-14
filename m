Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 864FD42DE8F
	for <lists+linux-pm@lfdr.de>; Thu, 14 Oct 2021 17:46:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232057AbhJNPsF (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 14 Oct 2021 11:48:05 -0400
Received: from mail-oi1-f174.google.com ([209.85.167.174]:35574 "EHLO
        mail-oi1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbhJNPsE (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 14 Oct 2021 11:48:04 -0400
Received: by mail-oi1-f174.google.com with SMTP id n64so9038201oih.2;
        Thu, 14 Oct 2021 08:45:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=uNPZr7lfyE7U8LVCNey/hJb75vNEIPdslz9gWirhsWQ=;
        b=o36cV6sK9ZbivfUV8/vHm/1W5ueJVOQGrrbu8HbtdKLOV6FCgKCbFTGF6Hz7706Fcl
         kL1xx2USThz9KhnQy5uGGZFXERTdVexgxmZ/A2e71w5o76HtjBYtSzVQwFAnAauZg9Gu
         Qu3A0GhmhpwjvryHm39NS97wrtbnN3oGebFmLrP1tVhN34+DVQMxnbIS2YK/pTl2362S
         l592HGJDfp4fmLr2RRCrqcV7cKiZJ2dohUiPULpi9o4ALnZXc+t2A/hS/mxw986lrwh2
         aLrjxbAnwXpslJ7T3reJmRyWVES8v8l2h1wt2eMO9n/3AmOK688J3w7pdN1BAUtSbdhZ
         B2Yg==
X-Gm-Message-State: AOAM530YdiGMD9XDpfzQNHpIjGY5bGL2PCzkh+cc4RRthDuRIXnrcRXW
        qqO2Kh8hzu/evGDm/Er6A8G7PyOHrA==
X-Google-Smtp-Source: ABdhPJzWuYc44bfEXIACL3CeG00BdInDt8v8PmbGBnDRQus7nARxCXQo4Y69mwBubUF28uDMJIj7eQ==
X-Received: by 2002:aca:ea82:: with SMTP id i124mr14106507oih.152.1634226358933;
        Thu, 14 Oct 2021 08:45:58 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id x28sm657216ote.24.2021.10.14.08.45.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Oct 2021 08:45:58 -0700 (PDT)
Received: (nullmailer pid 3412414 invoked by uid 1000);
        Thu, 14 Oct 2021 15:45:57 -0000
Date:   Thu, 14 Oct 2021 10:45:57 -0500
From:   Rob Herring <robh@kernel.org>
To:     Yassine Oudjana <y.oudjana@protonmail.com>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Ilia Lin <ilia.lin@kernel.org>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Loic Poulain <loic.poulain@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        phone-devel@vger.kernel.org
Subject: Re: [PATCH 5/8] dt-bindings: opp: Convert qcom-nvmem-cpufreq to DT
 schema
Message-ID: <YWhQteTI/dRwSRXR@robh.at.kernel.org>
References: <20211014083016.137441-1-y.oudjana@protonmail.com>
 <20211014083016.137441-6-y.oudjana@protonmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211014083016.137441-6-y.oudjana@protonmail.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Oct 14, 2021 at 08:32:35AM +0000, Yassine Oudjana wrote:
> Convert qcom-nvmem-cpufreq to DT schema format.
> 
> Signed-off-by: Yassine Oudjana <y.oudjana@protonmail.com>
> ---
>  .../bindings/opp/qcom-cpufreq-nvmem.yaml      | 877 ++++++++++++++++++
>  .../bindings/opp/qcom-nvmem-cpufreq.txt       | 796 ----------------
>  MAINTAINERS                                   |   2 +-
>  3 files changed, 878 insertions(+), 797 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/opp/qcom-cpufreq-nvmem.yaml
>  delete mode 100644 Documentation/devicetree/bindings/opp/qcom-nvmem-cpufreq.txt
> 
> diff --git a/Documentation/devicetree/bindings/opp/qcom-cpufreq-nvmem.yaml b/Documentation/devicetree/bindings/opp/qcom-cpufreq-nvmem.yaml
> new file mode 100644
> index 000000000000..4a7d4826746e
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/opp/qcom-cpufreq-nvmem.yaml
> @@ -0,0 +1,877 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/opp/qcom-cpufreq-nvmem.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Qualcomm Technologies, Inc. NVMEM CPUFreq and OPP bindings
> +
> +maintainers:
> +  - Ilia Lin <ilia.lin@kernel.org>
> +
> +description: |
> +  In Certain Qualcomm Technologies, Inc. SoCs like apq8096 and msm8996,
> +  the CPU frequencies subset and voltage value of each OPP varies based on
> +  the silicon variant in use.
> +  Qualcomm Technologies, Inc. Process Voltage Scaling Tables
> +  defines the voltage and frequency value based on the msm-id in SMEM
> +  and speedbin blown in the efuse combination.
> +  The qcom-cpufreq-nvmem driver reads the msm-id and efuse value from the SoC
> +  to provide the OPP framework with required information (existing HW bitmap).
> +  This is used to determine the voltage and frequency value for each OPP of
> +  operating-points-v2 table when it is parsed by the OPP framework.
> +
> +patternProperties:
> +  compatible:

Not a pattern... Putting this under 'properties' probably didn't work 
for you either if these are the top-level compatibles. What you want to 
use here is 'select'.


> +    enum:
> +      - qcom,apq8096
> +      - qcom,msm8996
> +      - qcom,qcs404
> +      - qcom,ipq8064
> +      - qcom,apq8064
> +      - qcom,msm8974
> +      - qcom,msm8960
> +
> +  '^opp-table(-[a-z0-9]+)?$':
> +    type: object
> +
> +    patternProperties:
> +      compatible:
> +        const: operating-points-v2-kryo-cpu
> +
> +      nvmem-cells:
> +        description: |
> +          A phandle pointing to a nvmem-cells node representing the
> +          efuse registers that has information about the
> +          speedbin that is used to select the right frequency/voltage
> +          value pair.
> +
> +      opp-shared: true
> +
> +      '^opp-?[0-9]+$':
> +        type: object
> +
> +        properties:
> +          opp-hz: true
> +          opp-microvolt: true
> +          clock-latency-ns: true
> +
> +          opp-supported-hw:
> +            description: |
> +              A single 32 bit bitmap value, representing compatible HW.
> +              Bitmap:
> +              0:  MSM8996 V3, speedbin 0
> +              1:  MSM8996 V3, speedbin 1
> +              2:  MSM8996 V3, speedbin 2
> +              3:  unused
> +              4:  MSM8996 SG, speedbin 0
> +              5:  MSM8996 SG, speedbin 1
> +              6:  MSM8996 SG, speedbin 2
> +              7-31:  unused

maximum: 0x77

> +
> +        required:
> +          - opp-hz
> +          - opp-supported-hw
> +
> +allOf:
> +  - $ref: opp-v2-base.yaml#

This is at the wrong level. It needs to be within 
'^opp-table(-[a-z0-9]+)?$' node schema.

> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: qcom,qcs404
> +    then:
> +      patternProperties:
> +        cpus:
> +          type: object
> +
> +          patternProperties:
> +            'cpu@[0-9a-f]+':
> +              type: object
> + 
> +              properties:
> +                power-domains:
> +                  items:
> +                    - description: A phandle pointing to the PM domain specifier
> +                        which provides the performance states available for active
> +                        state management.

No need to describe common properties unless you have something specific 
to say for this binding in particular.

maxItems: 1

> +                power-domain-names:
> +                  items:
> +                    - const: cpr
> +
> +        '^opp-?[0-9]+$':
> +          properties:
> +            required-opps: true
> +
> +          required:
> +            - opp-hz
> +            - opp-supported-hw
> +            - required-opps
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    / {
> +        model = "Qualcomm Technologies, Inc. MSM8996";
> +        compatible = "qcom,msm8996";
> +        #address-cells = <2>;
> +        #size-cells = <2>;
> +
> +        cpus {
> +            #address-cells = <2>;
> +            #size-cells = <0>;
> +
> +            CPU0: cpu@0 {
> +                device_type = "cpu";
> +                compatible = "qcom,kryo";
> +                reg = <0x0 0x0>;
> +                enable-method = "psci";
> +                cpu-idle-states = <&CPU_SLEEP_0>;
> +                capacity-dmips-mhz = <1024>;
> +                clocks = <&kryocc 0>;
> +                operating-points-v2 = <&cluster0_opp>;
> +                #cooling-cells = <2>;
> +                next-level-cache = <&L2_0>;
> +                L2_0: l2-cache {
> +                    compatible = "cache";
> +                    cache-level = <2>;
> +                };
> +            };
> +
> +            CPU1: cpu@1 {
> +                device_type = "cpu";
> +                compatible = "qcom,kryo";
> +                reg = <0x0 0x1>;
> +                enable-method = "psci";
> +                cpu-idle-states = <&CPU_SLEEP_0>;
> +                capacity-dmips-mhz = <1024>;
> +                clocks = <&kryocc 0>;
> +                operating-points-v2 = <&cluster0_opp>;
> +                #cooling-cells = <2>;
> +                next-level-cache = <&L2_0>;
> +            };
> +
> +            CPU2: cpu@100 {
> +                device_type = "cpu";
> +                compatible = "qcom,kryo";
> +                reg = <0x0 0x100>;
> +                enable-method = "psci";
> +                cpu-idle-states = <&CPU_SLEEP_0>;
> +                capacity-dmips-mhz = <1024>;
> +                clocks = <&kryocc 1>;
> +                operating-points-v2 = <&cluster1_opp>;
> +                #cooling-cells = <2>;
> +                next-level-cache = <&L2_1>;
> +                L2_1: l2-cache {
> +                    compatible = "cache";
> +                    cache-level = <2>;
> +                };
> +            };
> +
> +            CPU3: cpu@101 {
> +                device_type = "cpu";
> +                compatible = "qcom,kryo";
> +                reg = <0x0 0x101>;
> +                enable-method = "psci";
> +                cpu-idle-states = <&CPU_SLEEP_0>;
> +                capacity-dmips-mhz = <1024>;
> +                clocks = <&kryocc 1>;
> +                operating-points-v2 = <&cluster1_opp>;
> +                #cooling-cells = <2>;
> +                next-level-cache = <&L2_1>;
> +            };
> +
> +            cpu-map {
> +                cluster0 {
> +                    core0 {
> +                        cpu = <&CPU0>;
> +                    };
> +
> +                    core1 {
> +                        cpu = <&CPU1>;
> +                    };
> +                };
> +
> +                cluster1 {
> +                    core0 {
> +                        cpu = <&CPU2>;
> +                    };
> +
> +                    core1 {
> +                        cpu = <&CPU3>;
> +                    };
> +                };
> +            };
> +        };
> +
> +        cluster0_opp: opp_table0 {
> +            compatible = "operating-points-v2-kryo-cpu";
> +            nvmem-cells = <&speedbin_efuse>;
> +            opp-shared;
> +
> +            opp-307200000 {
> +                opp-hz = /bits/ 64 <307200000>;
> +                opp-microvolt = <905000 905000 1140000>;
> +                opp-supported-hw = <0x77>;
> +                clock-latency-ns = <200000>;
> +            };
> +            opp-384000000 {
> +                opp-hz = /bits/ 64 <384000000>;
> +                opp-microvolt = <905000 905000 1140000>;
> +                opp-supported-hw = <0x70>;
> +                clock-latency-ns = <200000>;
> +            };
> +            opp-422400000 {
> +                opp-hz = /bits/ 64 <422400000>;
> +                opp-microvolt = <905000 905000 1140000>;
> +                opp-supported-hw = <0x7>;
> +                clock-latency-ns = <200000>;
> +            };
> +            opp-460800000 {
> +                opp-hz = /bits/ 64 <460800000>;
> +                opp-microvolt = <905000 905000 1140000>;
> +                opp-supported-hw = <0x70>;
> +                clock-latency-ns = <200000>;
> +            };
> +            opp-480000000 {
> +                opp-hz = /bits/ 64 <480000000>;
> +                opp-microvolt = <905000 905000 1140000>;
> +                opp-supported-hw = <0x7>;
> +                clock-latency-ns = <200000>;
> +            };
> +            opp-537600000 {
> +                opp-hz = /bits/ 64 <537600000>;
> +                opp-microvolt = <905000 905000 1140000>;
> +                opp-supported-hw = <0x70>;
> +                clock-latency-ns = <200000>;
> +            };
> +            opp-556800000 {
> +                opp-hz = /bits/ 64 <556800000>;
> +                opp-microvolt = <905000 905000 1140000>;
> +                opp-supported-hw = <0x7>;
> +                clock-latency-ns = <200000>;
> +            };
> +            opp-614400000 {
> +                opp-hz = /bits/ 64 <614400000>;
> +                opp-microvolt = <905000 905000 1140000>;
> +                opp-supported-hw = <0x70>;
> +                clock-latency-ns = <200000>;
> +            };
> +            opp-652800000 {
> +                opp-hz = /bits/ 64 <652800000>;
> +                opp-microvolt = <905000 905000 1140000>;
> +                opp-supported-hw = <0x7>;
> +                clock-latency-ns = <200000>;
> +            };
> +            opp-691200000 {
> +                opp-hz = /bits/ 64 <691200000>;
> +                opp-microvolt = <905000 905000 1140000>;
> +                opp-supported-hw = <0x70>;
> +                clock-latency-ns = <200000>;
> +            };
> +            opp-729600000 {
> +                opp-hz = /bits/ 64 <729600000>;
> +                opp-microvolt = <905000 905000 1140000>;
> +                opp-supported-hw = <0x7>;
> +                clock-latency-ns = <200000>;
> +            };
> +            opp-768000000 {
> +                opp-hz = /bits/ 64 <768000000>;
> +                opp-microvolt = <905000 905000 1140000>;
> +                opp-supported-hw = <0x70>;
> +                clock-latency-ns = <200000>;
> +            };
> +            opp-844800000 {
> +                opp-hz = /bits/ 64 <844800000>;
> +                opp-microvolt = <905000 905000 1140000>;
> +                opp-supported-hw = <0x77>;
> +                clock-latency-ns = <200000>;
> +            };
> +            opp-902400000 {
> +                opp-hz = /bits/ 64 <902400000>;
> +                opp-microvolt = <905000 905000 1140000>;
> +                opp-supported-hw = <0x70>;
> +                clock-latency-ns = <200000>;
> +            };
> +            opp-960000000 {
> +                opp-hz = /bits/ 64 <960000000>;
> +                opp-microvolt = <905000 905000 1140000>;
> +                opp-supported-hw = <0x7>;
> +                clock-latency-ns = <200000>;
> +            };
> +            opp-979200000 {
> +                opp-hz = /bits/ 64 <979200000>;
> +                opp-microvolt = <905000 905000 1140000>;
> +                opp-supported-hw = <0x70>;
> +                clock-latency-ns = <200000>;
> +            };
> +            opp-1036800000 {
> +                opp-hz = /bits/ 64 <1036800000>;
> +                opp-microvolt = <905000 905000 1140000>;
> +                opp-supported-hw = <0x7>;
> +                clock-latency-ns = <200000>;
> +            };
> +            opp-1056000000 {
> +                opp-hz = /bits/ 64 <1056000000>;
> +                opp-microvolt = <905000 905000 1140000>;
> +                opp-supported-hw = <0x70>;
> +                clock-latency-ns = <200000>;
> +            };
> +            opp-1113600000 {
> +                opp-hz = /bits/ 64 <1113600000>;
> +                opp-microvolt = <905000 905000 1140000>;
> +                opp-supported-hw = <0x7>;
> +                clock-latency-ns = <200000>;
> +            };
> +            opp-1132800000 {
> +                opp-hz = /bits/ 64 <1132800000>;
> +                opp-microvolt = <905000 905000 1140000>;
> +                opp-supported-hw = <0x70>;
> +                clock-latency-ns = <200000>;
> +            };
> +            opp-1190400000 {
> +                opp-hz = /bits/ 64 <1190400000>;
> +                opp-microvolt = <905000 905000 1140000>;
> +                opp-supported-hw = <0x7>;
> +                clock-latency-ns = <200000>;
> +            };
> +            opp-1209600000 {
> +                opp-hz = /bits/ 64 <1209600000>;
> +                opp-microvolt = <905000 905000 1140000>;
> +                opp-supported-hw = <0x70>;
> +                clock-latency-ns = <200000>;
> +            };
> +            opp-1228800000 {
> +                opp-hz = /bits/ 64 <1228800000>;
> +                opp-microvolt = <905000 905000 1140000>;
> +                opp-supported-hw = <0x7>;
> +                clock-latency-ns = <200000>;
> +            };
> +            opp-1286400000 {
> +                opp-hz = /bits/ 64 <1286400000>;
> +                opp-microvolt = <1140000 905000 1140000>;
> +                opp-supported-hw = <0x70>;
> +                clock-latency-ns = <200000>;
> +            };
> +            opp-1324800000 {
> +                opp-hz = /bits/ 64 <1324800000>;
> +                opp-microvolt = <1140000 905000 1140000>;
> +                opp-supported-hw = <0x5>;
> +                clock-latency-ns = <200000>;
> +            };
> +            opp-1363200000 {
> +                opp-hz = /bits/ 64 <1363200000>;
> +                opp-microvolt = <1140000 905000 1140000>;
> +                opp-supported-hw = <0x72>;
> +                clock-latency-ns = <200000>;
> +            };
> +            opp-1401600000 {
> +                opp-hz = /bits/ 64 <1401600000>;
> +                opp-microvolt = <1140000 905000 1140000>;
> +                opp-supported-hw = <0x5>;
> +                clock-latency-ns = <200000>;
> +            };
> +            opp-1440000000 {
> +                opp-hz = /bits/ 64 <1440000000>;
> +                opp-microvolt = <1140000 905000 1140000>;
> +                opp-supported-hw = <0x70>;
> +                clock-latency-ns = <200000>;
> +            };
> +            opp-1478400000 {
> +                opp-hz = /bits/ 64 <1478400000>;
> +                opp-microvolt = <1140000 905000 1140000>;
> +                opp-supported-hw = <0x1>;
> +                clock-latency-ns = <200000>;
> +            };
> +            opp-1497600000 {
> +                opp-hz = /bits/ 64 <1497600000>;
> +                opp-microvolt = <1140000 905000 1140000>;
> +                opp-supported-hw = <0x4>;
> +                clock-latency-ns = <200000>;
> +            };
> +            opp-1516800000 {
> +                opp-hz = /bits/ 64 <1516800000>;
> +                opp-microvolt = <1140000 905000 1140000>;
> +                opp-supported-hw = <0x70>;
> +                clock-latency-ns = <200000>;
> +            };
> +            opp-1593600000 {
> +                opp-hz = /bits/ 64 <1593600000>;
> +                opp-microvolt = <1140000 905000 1140000>;
> +                opp-supported-hw = <0x71>;
> +                clock-latency-ns = <200000>;
> +            };
> +            opp-1996800000 {
> +                opp-hz = /bits/ 64 <1996800000>;
> +                opp-microvolt = <1140000 905000 1140000>;
> +                opp-supported-hw = <0x20>;
> +                clock-latency-ns = <200000>;
> +            };
> +            opp-2188800000 {
> +                opp-hz = /bits/ 64 <2188800000>;
> +                opp-microvolt = <1140000 905000 1140000>;
> +                opp-supported-hw = <0x10>;
> +                clock-latency-ns = <200000>;
> +            };

Maybe drop some opp nodes for brievity.

> +        };
> +
> +        cluster1_opp: opp_table1 {
> +            compatible = "operating-points-v2-kryo-cpu";
> +            nvmem-cells = <&speedbin_efuse>;
> +            opp-shared;
> +
> +            opp-307200000 {
> +                opp-hz = /bits/ 64 <307200000>;
> +                opp-microvolt = <905000 905000 1140000>;
> +                opp-supported-hw = <0x77>;
> +                clock-latency-ns = <200000>;
> +            };
> +            opp-384000000 {
> +                opp-hz = /bits/ 64 <384000000>;
> +                opp-microvolt = <905000 905000 1140000>;
> +                opp-supported-hw = <0x70>;
> +                clock-latency-ns = <200000>;
> +            };
> +            opp-403200000 {
> +                opp-hz = /bits/ 64 <403200000>;
> +                opp-microvolt = <905000 905000 1140000>;
> +                opp-supported-hw = <0x7>;
> +                clock-latency-ns = <200000>;
> +            };
> +            opp-460800000 {
> +                opp-hz = /bits/ 64 <460800000>;
> +                opp-microvolt = <905000 905000 1140000>;
> +                opp-supported-hw = <0x70>;
> +                clock-latency-ns = <200000>;
> +            };
> +            opp-480000000 {
> +                opp-hz = /bits/ 64 <480000000>;
> +                opp-microvolt = <905000 905000 1140000>;
> +                opp-supported-hw = <0x7>;
> +                clock-latency-ns = <200000>;
> +            };
> +            opp-537600000 {
> +                opp-hz = /bits/ 64 <537600000>;
> +                opp-microvolt = <905000 905000 1140000>;
> +                opp-supported-hw = <0x70>;
> +                clock-latency-ns = <200000>;
> +            };
> +            opp-556800000 {
> +                opp-hz = /bits/ 64 <556800000>;
> +                opp-microvolt = <905000 905000 1140000>;
> +                opp-supported-hw = <0x7>;
> +                clock-latency-ns = <200000>;
> +            };
> +            opp-614400000 {
> +                opp-hz = /bits/ 64 <614400000>;
> +                opp-microvolt = <905000 905000 1140000>;
> +                opp-supported-hw = <0x70>;
> +                clock-latency-ns = <200000>;
> +            };
> +            opp-652800000 {
> +                opp-hz = /bits/ 64 <652800000>;
> +                opp-microvolt = <905000 905000 1140000>;
> +                opp-supported-hw = <0x7>;
> +                clock-latency-ns = <200000>;
> +            };
> +            opp-691200000 {
> +                opp-hz = /bits/ 64 <691200000>;
> +                opp-microvolt = <905000 905000 1140000>;
> +                opp-supported-hw = <0x70>;
> +                clock-latency-ns = <200000>;
> +            };
> +            opp-729600000 {
> +                opp-hz = /bits/ 64 <729600000>;
> +                opp-microvolt = <905000 905000 1140000>;
> +                opp-supported-hw = <0x7>;
> +                clock-latency-ns = <200000>;
> +            };
> +            opp-748800000 {
> +                opp-hz = /bits/ 64 <748800000>;
> +                opp-microvolt = <905000 905000 1140000>;
> +                opp-supported-hw = <0x70>;
> +                clock-latency-ns = <200000>;
> +            };
> +            opp-806400000 {
> +                opp-hz = /bits/ 64 <806400000>;
> +                opp-microvolt = <905000 905000 1140000>;
> +                opp-supported-hw = <0x7>;
> +                clock-latency-ns = <200000>;
> +            };
> +            opp-825600000 {
> +                opp-hz = /bits/ 64 <825600000>;
> +                opp-microvolt = <905000 905000 1140000>;
> +                opp-supported-hw = <0x70>;
> +                clock-latency-ns = <200000>;
> +            };
> +            opp-883200000 {
> +                opp-hz = /bits/ 64 <883200000>;
> +                opp-microvolt = <905000 905000 1140000>;
> +                opp-supported-hw = <0x7>;
> +                clock-latency-ns = <200000>;
> +            };
> +            opp-902400000 {
> +                opp-hz = /bits/ 64 <902400000>;
> +                opp-microvolt = <905000 905000 1140000>;
> +                opp-supported-hw = <0x70>;
> +                clock-latency-ns = <200000>;
> +            };
> +            opp-940800000 {
> +                opp-hz = /bits/ 64 <940800000>;
> +                opp-microvolt = <905000 905000 1140000>;
> +                opp-supported-hw = <0x7>;
> +                clock-latency-ns = <200000>;
> +            };
> +            opp-979200000 {
> +                opp-hz = /bits/ 64 <979200000>;
> +                opp-microvolt = <905000 905000 1140000>;
> +                opp-supported-hw = <0x70>;
> +                clock-latency-ns = <200000>;
> +            };
> +            opp-1036800000 {
> +                opp-hz = /bits/ 64 <1036800000>;
> +                opp-microvolt = <905000 905000 1140000>;
> +                opp-supported-hw = <0x7>;
> +                clock-latency-ns = <200000>;
> +            };
> +            opp-1056000000 {
> +                opp-hz = /bits/ 64 <1056000000>;
> +                opp-microvolt = <905000 905000 1140000>;
> +                opp-supported-hw = <0x70>;
> +                clock-latency-ns = <200000>;
> +            };
> +            opp-1113600000 {
> +                opp-hz = /bits/ 64 <1113600000>;
> +                opp-microvolt = <905000 905000 1140000>;
> +                opp-supported-hw = <0x7>;
> +                clock-latency-ns = <200000>;
> +            };
> +            opp-1132800000 {
> +                opp-hz = /bits/ 64 <1132800000>;
> +                opp-microvolt = <905000 905000 1140000>;
> +                opp-supported-hw = <0x70>;
> +                clock-latency-ns = <200000>;
> +            };
> +            opp-1190400000 {
> +                opp-hz = /bits/ 64 <1190400000>;
> +                opp-microvolt = <905000 905000 1140000>;
> +                opp-supported-hw = <0x7>;
> +                clock-latency-ns = <200000>;
> +            };
> +            opp-1209600000 {
> +                opp-hz = /bits/ 64 <1209600000>;
> +                opp-microvolt = <905000 905000 1140000>;
> +                opp-supported-hw = <0x70>;
> +                clock-latency-ns = <200000>;
> +            };
> +            opp-1248000000 {
> +                opp-hz = /bits/ 64 <1248000000>;
> +                opp-microvolt = <905000 905000 1140000>;
> +                opp-supported-hw = <0x7>;
> +                clock-latency-ns = <200000>;
> +            };
> +            opp-1286400000 {
> +                opp-hz = /bits/ 64 <1286400000>;
> +                opp-microvolt = <905000 905000 1140000>;
> +                opp-supported-hw = <0x70>;
> +                clock-latency-ns = <200000>;
> +            };
> +            opp-1324800000 {
> +                opp-hz = /bits/ 64 <1324800000>;
> +                opp-microvolt = <1140000 905000 1140000>;
> +                opp-supported-hw = <0x7>;
> +                clock-latency-ns = <200000>;
> +            };
> +            opp-1363200000 {
> +                opp-hz = /bits/ 64 <1363200000>;
> +                opp-microvolt = <1140000 905000 1140000>;
> +                opp-supported-hw = <0x70>;
> +                clock-latency-ns = <200000>;
> +            };
> +            opp-1401600000 {
> +                opp-hz = /bits/ 64 <1401600000>;
> +                opp-microvolt = <1140000 905000 1140000>;
> +                opp-supported-hw = <0x7>;
> +                clock-latency-ns = <200000>;
> +            };
> +            opp-1440000000 {
> +                opp-hz = /bits/ 64 <1440000000>;
> +                opp-microvolt = <1140000 905000 1140000>;
> +                opp-supported-hw = <0x70>;
> +                clock-latency-ns = <200000>;
> +            };
> +            opp-1478400000 {
> +                opp-hz = /bits/ 64 <1478400000>;
> +                opp-microvolt = <1140000 905000 1140000>;
> +                opp-supported-hw = <0x7>;
> +                clock-latency-ns = <200000>;
> +            };
> +            opp-1516800000 {
> +                opp-hz = /bits/ 64 <1516800000>;
> +                opp-microvolt = <1140000 905000 1140000>;
> +                opp-supported-hw = <0x70>;
> +                clock-latency-ns = <200000>;
> +            };
> +            opp-1555200000 {
> +                opp-hz = /bits/ 64 <1555200000>;
> +                opp-microvolt = <1140000 905000 1140000>;
> +                opp-supported-hw = <0x7>;
> +                clock-latency-ns = <200000>;
> +            };
> +            opp-1593600000 {
> +                opp-hz = /bits/ 64 <1593600000>;
> +                opp-microvolt = <1140000 905000 1140000>;
> +                opp-supported-hw = <0x70>;
> +                clock-latency-ns = <200000>;
> +            };
> +            opp-1632000000 {
> +                opp-hz = /bits/ 64 <1632000000>;
> +                opp-microvolt = <1140000 905000 1140000>;
> +                opp-supported-hw = <0x7>;
> +                clock-latency-ns = <200000>;
> +            };
> +            opp-1670400000 {
> +                opp-hz = /bits/ 64 <1670400000>;
> +                opp-microvolt = <1140000 905000 1140000>;
> +                opp-supported-hw = <0x70>;
> +                clock-latency-ns = <200000>;
> +            };
> +            opp-1708800000 {
> +                opp-hz = /bits/ 64 <1708800000>;
> +                opp-microvolt = <1140000 905000 1140000>;
> +                opp-supported-hw = <0x7>;
> +                clock-latency-ns = <200000>;
> +            };
> +            opp-1747200000 {
> +                opp-hz = /bits/ 64 <1747200000>;
> +                opp-microvolt = <1140000 905000 1140000>;
> +                opp-supported-hw = <0x70>;
> +                clock-latency-ns = <200000>;
> +            };
> +            opp-1785600000 {
> +                opp-hz = /bits/ 64 <1785600000>;
> +                opp-microvolt = <1140000 905000 1140000>;
> +                opp-supported-hw = <0x7>;
> +                clock-latency-ns = <200000>;
> +            };
> +            opp-1804800000 {
> +                opp-hz = /bits/ 64 <1804800000>;
> +                opp-microvolt = <1140000 905000 1140000>;
> +                opp-supported-hw = <0x6>;
> +                clock-latency-ns = <200000>;
> +            };
> +            opp-1824000000 {
> +                opp-hz = /bits/ 64 <1824000000>;
> +                opp-microvolt = <1140000 905000 1140000>;
> +                opp-supported-hw = <0x71>;
> +                clock-latency-ns = <200000>;
> +            };
> +            opp-1900800000 {
> +                opp-hz = /bits/ 64 <1900800000>;
> +                opp-microvolt = <1140000 905000 1140000>;
> +                opp-supported-hw = <0x74>;
> +                clock-latency-ns = <200000>;
> +            };
> +            opp-1920000000 {
> +                opp-hz = /bits/ 64 <1920000000>;
> +                opp-microvolt = <1140000 905000 1140000>;
> +                opp-supported-hw = <0x1>;
> +                clock-latency-ns = <200000>;
> +            };
> +            opp-1977600000 {
> +                opp-hz = /bits/ 64 <1977600000>;
> +                opp-microvolt = <1140000 905000 1140000>;
> +                opp-supported-hw = <0x30>;
> +                clock-latency-ns = <200000>;
> +            };
> +            opp-1996800000 {
> +                opp-hz = /bits/ 64 <1996800000>;
> +                opp-microvolt = <1140000 905000 1140000>;
> +                opp-supported-hw = <0x1>;
> +                clock-latency-ns = <200000>;
> +            };
> +            opp-2054400000 {
> +                opp-hz = /bits/ 64 <2054400000>;
> +                opp-microvolt = <1140000 905000 1140000>;
> +                opp-supported-hw = <0x30>;
> +                clock-latency-ns = <200000>;
> +            };
> +            opp-2073600000 {
> +                opp-hz = /bits/ 64 <2073600000>;
> +                opp-microvolt = <1140000 905000 1140000>;
> +                opp-supported-hw = <0x1>;
> +                clock-latency-ns = <200000>;
> +            };
> +            opp-2150400000 {
> +                opp-hz = /bits/ 64 <2150400000>;
> +                opp-microvolt = <1140000 905000 1140000>;
> +                opp-supported-hw = <0x31>;
> +                clock-latency-ns = <200000>;
> +            };
> +            opp-2246400000 {
> +                opp-hz = /bits/ 64 <2246400000>;
> +                opp-microvolt = <1140000 905000 1140000>;
> +                opp-supported-hw = <0x10>;
> +                clock-latency-ns = <200000>;
> +            };
> +            opp-2342400000 {
> +                opp-hz = /bits/ 64 <2342400000>;
> +                opp-microvolt = <1140000 905000 1140000>;
> +                opp-supported-hw = <0x10>;
> +                clock-latency-ns = <200000>;
> +            };
> +        };
> +
> +        reserved-memory {
> +            #address-cells = <2>;
> +            #size-cells = <2>;
> +            ranges;
> +
> +            smem_mem: smem-mem@86000000 {
> +                reg = <0x0 0x86000000 0x0 0x200000>;
> +                no-map;
> +            };
> +        };
> +
> +        smem {
> +            compatible = "qcom,smem";
> +            memory-region = <&smem_mem>;
> +            hwlocks = <&tcsr_mutex 3>;
> +        };
> +
> +        soc {
> +            #address-cells = <1>;
> +            #size-cells = <1>;
> +
> +            qfprom: qfprom@74000 {
> +                compatible = "qcom,msm8996-qfprom", "qcom,qfprom";
> +                reg = <0x00074000 0x8ff>;
> +                #address-cells = <1>;
> +                #size-cells = <1>;
> +
> +                speedbin_efuse: speedbin@133 {
> +                    reg = <0x133 0x1>;
> +                    bits = <5 3>;
> +                };
> +            };
> +        };
> +    };
> +
> +  - |
> +    / {

I think this is going to do weird things. The examples aren't really 
independent. The result is going to be the 2 examples are merged to 1 
root node.

Maybe qcs404 should be a different schema anyways. Doesn't look like a 
lot of overlap (any more so than any other OPP).

> +        model = "Qualcomm Technologies, Inc. QCS404";
> +        compatible = "qcom,qcs404";
> +        #address-cells = <2>;
> +        #size-cells = <2>;
> +
> +        cpus {
> +            #address-cells = <1>;
> +            #size-cells = <0>;
> +
> +            cpu@100 {
> +                device_type = "cpu";
> +                compatible = "arm,cortex-a53";
> +                reg = <0x100>;
> +                enable-method = "psci";
> +                cpu-idle-states = <&CPU_SLEEP_0>;
> +                next-level-cache = <&L2_0>;
> +                #cooling-cells = <2>;
> +                clocks = <&apcs_glb>;
> +                operating-points-v2 = <&cpu_opp_table>;
> +                power-domains = <&cpr>;
> +                power-domain-names = "cpr";
> +            };
> +
> +            cpu@101 {
> +                device_type = "cpu";
> +                compatible = "arm,cortex-a53";
> +                reg = <0x101>;
> +                enable-method = "psci";
> +                cpu-idle-states = <&CPU_SLEEP_0>;
> +                next-level-cache = <&L2_0>;
> +                #cooling-cells = <2>;
> +                clocks = <&apcs_glb>;
> +                operating-points-v2 = <&cpu_opp_table>;
> +                power-domains = <&cpr>;
> +                power-domain-names = "cpr";
> +            };
> +
> +            cpu@102 {
> +                device_type = "cpu";
> +                compatible = "arm,cortex-a53";
> +                reg = <0x102>;
> +                enable-method = "psci";
> +                cpu-idle-states = <&CPU_SLEEP_0>;
> +                next-level-cache = <&L2_0>;
> +                #cooling-cells = <2>;
> +                clocks = <&apcs_glb>;
> +                operating-points-v2 = <&cpu_opp_table>;
> +                power-domains = <&cpr>;
> +                power-domain-names = "cpr";
> +            };
> +
> +            cpu@103 {
> +                device_type = "cpu";
> +                compatible = "arm,cortex-a53";
> +                reg = <0x103>;
> +                enable-method = "psci";
> +                cpu-idle-states = <&CPU_SLEEP_0>;
> +                next-level-cache = <&L2_0>;
> +                #cooling-cells = <2>;
> +                clocks = <&apcs_glb>;
> +                operating-points-v2 = <&cpu_opp_table>;
> +                power-domains = <&cpr>;
> +                power-domain-names = "cpr";
> +            };
> +        };
> +
> +        cpu_opp_table: cpu-opp-table {
> +            compatible = "operating-points-v2-kryo-cpu";
> +            opp-shared;
> +
> +            opp-1094400000 {
> +                opp-hz = /bits/ 64 <1094400000>;
> +                required-opps = <&cpr_opp1>;
> +            };
> +            opp-1248000000 {
> +                opp-hz = /bits/ 64 <1248000000>;
> +                required-opps = <&cpr_opp2>;
> +            };
> +            opp-1401600000 {
> +                opp-hz = /bits/ 64 <1401600000>;
> +                required-opps = <&cpr_opp3>;
> +            };
> +        };
> +
> +        cpr_opp_table: cpr-opp-table {
> +            compatible = "operating-points-v2-qcom-level";
> +
> +            cpr_opp1: opp1 {
> +                opp-level = <1>;
> +                qcom,opp-fuse-level = <1>;
> +            };
> +            cpr_opp2: opp2 {
> +                opp-level = <2>;
> +                qcom,opp-fuse-level = <2>;
> +            };
> +            cpr_opp3: opp3 {
> +                opp-level = <3>;
> +                qcom,opp-fuse-level = <3>;
> +            };
> +        };
> +
> +        soc {
> +            #address-cells = <1>;
> +            #size-cells = <1>;
> +
> +            cpr: power-controller@b018000 {
> +                compatible = "qcom,qcs404-cpr", "qcom,cpr";
> +                reg = <0x0b018000 0x1000>;
> +
> +                vdd-apc-supply = <&pms405_s3>;
> +                #power-domain-cells = <0>;
> +                operating-points-v2 = <&cpr_opp_table>;
> +            };
> +        };
> +    };
> diff --git a/Documentation/devicetree/bindings/opp/qcom-nvmem-cpufreq.txt b/Documentation/devicetree/bindings/opp/qcom-nvmem-cpufreq.txt
> deleted file mode 100644
> index 64f07417ecfb..000000000000
> --- a/Documentation/devicetree/bindings/opp/qcom-nvmem-cpufreq.txt
> +++ /dev/null
> @@ -1,796 +0,0 @@
> -Qualcomm Technologies, Inc. NVMEM CPUFreq and OPP bindings
> -===================================
> -
> -In Certain Qualcomm Technologies, Inc. SoCs like apq8096 and msm8996,
> -the CPU frequencies subset and voltage value of each OPP varies based on
> -the silicon variant in use.
> -Qualcomm Technologies, Inc. Process Voltage Scaling Tables
> -defines the voltage and frequency value based on the msm-id in SMEM
> -and speedbin blown in the efuse combination.
> -The qcom-cpufreq-nvmem driver reads the msm-id and efuse value from the SoC
> -to provide the OPP framework with required information (existing HW bitmap).
> -This is used to determine the voltage and frequency value for each OPP of
> -operating-points-v2 table when it is parsed by the OPP framework.
> -
> -Required properties:
> ---------------------
> -In 'cpu' nodes:
> -- operating-points-v2: Phandle to the operating-points-v2 table to use.
> -
> -In 'operating-points-v2' table:
> -- compatible: Should be
> -	- 'operating-points-v2-kryo-cpu' for apq8096, msm8996, msm8974,
> -					     apq8064, ipq8064, msm8960 and ipq8074.
> -
> -Optional properties:
> ---------------------
> -In 'cpu' nodes:
> -- power-domains: A phandle pointing to the PM domain specifier which provides
> -		the performance states available for active state management.
> -		Please refer to the power-domains bindings
> -		Documentation/devicetree/bindings/power/power_domain.txt
> -		and also examples below.
> -- power-domain-names: Should be
> -	- 'cpr' for qcs404.
> -
> -In 'operating-points-v2' table:
> -- nvmem-cells: A phandle pointing to a nvmem-cells node representing the
> -		efuse registers that has information about the
> -		speedbin that is used to select the right frequency/voltage
> -		value pair.
> -		Please refer the for nvmem-cells
> -		bindings Documentation/devicetree/bindings/nvmem/nvmem.txt
> -		and also examples below.
> -
> -In every OPP node:
> -- opp-supported-hw: A single 32 bit bitmap value, representing compatible HW.
> -		    Bitmap:
> -			0:	MSM8996 V3, speedbin 0
> -			1:	MSM8996 V3, speedbin 1
> -			2:	MSM8996 V3, speedbin 2
> -			3:	unused
> -			4:	MSM8996 SG, speedbin 0
> -			5:	MSM8996 SG, speedbin 1
> -			6:	MSM8996 SG, speedbin 2
> -			7-31:	unused
> -
> -Example 1:
> ----------
> -
> -	cpus {
> -		#address-cells = <2>;
> -		#size-cells = <0>;
> -
> -		CPU0: cpu@0 {
> -			device_type = "cpu";
> -			compatible = "qcom,kryo";
> -			reg = <0x0 0x0>;
> -			enable-method = "psci";
> -			clocks = <&kryocc 0>;
> -			cpu-supply = <&pm8994_s11_saw>;
> -			operating-points-v2 = <&cluster0_opp>;
> -			#cooling-cells = <2>;
> -			next-level-cache = <&L2_0>;
> -			L2_0: l2-cache {
> -			      compatible = "cache";
> -			      cache-level = <2>;
> -			};
> -		};
> -
> -		CPU1: cpu@1 {
> -			device_type = "cpu";
> -			compatible = "qcom,kryo";
> -			reg = <0x0 0x1>;
> -			enable-method = "psci";
> -			clocks = <&kryocc 0>;
> -			cpu-supply = <&pm8994_s11_saw>;
> -			operating-points-v2 = <&cluster0_opp>;
> -			#cooling-cells = <2>;
> -			next-level-cache = <&L2_0>;
> -		};
> -
> -		CPU2: cpu@100 {
> -			device_type = "cpu";
> -			compatible = "qcom,kryo";
> -			reg = <0x0 0x100>;
> -			enable-method = "psci";
> -			clocks = <&kryocc 1>;
> -			cpu-supply = <&pm8994_s11_saw>;
> -			operating-points-v2 = <&cluster1_opp>;
> -			#cooling-cells = <2>;
> -			next-level-cache = <&L2_1>;
> -			L2_1: l2-cache {
> -			      compatible = "cache";
> -			      cache-level = <2>;
> -			};
> -		};
> -
> -		CPU3: cpu@101 {
> -			device_type = "cpu";
> -			compatible = "qcom,kryo";
> -			reg = <0x0 0x101>;
> -			enable-method = "psci";
> -			clocks = <&kryocc 1>;
> -			cpu-supply = <&pm8994_s11_saw>;
> -			operating-points-v2 = <&cluster1_opp>;
> -			#cooling-cells = <2>;
> -			next-level-cache = <&L2_1>;
> -		};
> -
> -		cpu-map {
> -			cluster0 {
> -				core0 {
> -					cpu = <&CPU0>;
> -				};
> -
> -				core1 {
> -					cpu = <&CPU1>;
> -				};
> -			};
> -
> -			cluster1 {
> -				core0 {
> -					cpu = <&CPU2>;
> -				};
> -
> -				core1 {
> -					cpu = <&CPU3>;
> -				};
> -			};
> -		};
> -	};
> -
> -	cluster0_opp: opp_table0 {
> -		compatible = "operating-points-v2-kryo-cpu";
> -		nvmem-cells = <&speedbin_efuse>;
> -		opp-shared;
> -
> -		opp-307200000 {
> -			opp-hz = /bits/ 64 <307200000>;
> -			opp-microvolt = <905000 905000 1140000>;
> -			opp-supported-hw = <0x77>;
> -			clock-latency-ns = <200000>;
> -		};
> -		opp-384000000 {
> -			opp-hz = /bits/ 64 <384000000>;
> -			opp-microvolt = <905000 905000 1140000>;
> -			opp-supported-hw = <0x70>;
> -			clock-latency-ns = <200000>;
> -		};
> -		opp-422400000 {
> -			opp-hz = /bits/ 64 <422400000>;
> -			opp-microvolt = <905000 905000 1140000>;
> -			opp-supported-hw = <0x7>;
> -			clock-latency-ns = <200000>;
> -		};
> -		opp-460800000 {
> -			opp-hz = /bits/ 64 <460800000>;
> -			opp-microvolt = <905000 905000 1140000>;
> -			opp-supported-hw = <0x70>;
> -			clock-latency-ns = <200000>;
> -		};
> -		opp-480000000 {
> -			opp-hz = /bits/ 64 <480000000>;
> -			opp-microvolt = <905000 905000 1140000>;
> -			opp-supported-hw = <0x7>;
> -			clock-latency-ns = <200000>;
> -		};
> -		opp-537600000 {
> -			opp-hz = /bits/ 64 <537600000>;
> -			opp-microvolt = <905000 905000 1140000>;
> -			opp-supported-hw = <0x70>;
> -			clock-latency-ns = <200000>;
> -		};
> -		opp-556800000 {
> -			opp-hz = /bits/ 64 <556800000>;
> -			opp-microvolt = <905000 905000 1140000>;
> -			opp-supported-hw = <0x7>;
> -			clock-latency-ns = <200000>;
> -		};
> -		opp-614400000 {
> -			opp-hz = /bits/ 64 <614400000>;
> -			opp-microvolt = <905000 905000 1140000>;
> -			opp-supported-hw = <0x70>;
> -			clock-latency-ns = <200000>;
> -		};
> -		opp-652800000 {
> -			opp-hz = /bits/ 64 <652800000>;
> -			opp-microvolt = <905000 905000 1140000>;
> -			opp-supported-hw = <0x7>;
> -			clock-latency-ns = <200000>;
> -		};
> -		opp-691200000 {
> -			opp-hz = /bits/ 64 <691200000>;
> -			opp-microvolt = <905000 905000 1140000>;
> -			opp-supported-hw = <0x70>;
> -			clock-latency-ns = <200000>;
> -		};
> -		opp-729600000 {
> -			opp-hz = /bits/ 64 <729600000>;
> -			opp-microvolt = <905000 905000 1140000>;
> -			opp-supported-hw = <0x7>;
> -			clock-latency-ns = <200000>;
> -		};
> -		opp-768000000 {
> -			opp-hz = /bits/ 64 <768000000>;
> -			opp-microvolt = <905000 905000 1140000>;
> -			opp-supported-hw = <0x70>;
> -			clock-latency-ns = <200000>;
> -		};
> -		opp-844800000 {
> -			opp-hz = /bits/ 64 <844800000>;
> -			opp-microvolt = <905000 905000 1140000>;
> -			opp-supported-hw = <0x77>;
> -			clock-latency-ns = <200000>;
> -		};
> -		opp-902400000 {
> -			opp-hz = /bits/ 64 <902400000>;
> -			opp-microvolt = <905000 905000 1140000>;
> -			opp-supported-hw = <0x70>;
> -			clock-latency-ns = <200000>;
> -		};
> -		opp-960000000 {
> -			opp-hz = /bits/ 64 <960000000>;
> -			opp-microvolt = <905000 905000 1140000>;
> -			opp-supported-hw = <0x7>;
> -			clock-latency-ns = <200000>;
> -		};
> -		opp-979200000 {
> -			opp-hz = /bits/ 64 <979200000>;
> -			opp-microvolt = <905000 905000 1140000>;
> -			opp-supported-hw = <0x70>;
> -			clock-latency-ns = <200000>;
> -		};
> -		opp-1036800000 {
> -			opp-hz = /bits/ 64 <1036800000>;
> -			opp-microvolt = <905000 905000 1140000>;
> -			opp-supported-hw = <0x7>;
> -			clock-latency-ns = <200000>;
> -		};
> -		opp-1056000000 {
> -			opp-hz = /bits/ 64 <1056000000>;
> -			opp-microvolt = <905000 905000 1140000>;
> -			opp-supported-hw = <0x70>;
> -			clock-latency-ns = <200000>;
> -		};
> -		opp-1113600000 {
> -			opp-hz = /bits/ 64 <1113600000>;
> -			opp-microvolt = <905000 905000 1140000>;
> -			opp-supported-hw = <0x7>;
> -			clock-latency-ns = <200000>;
> -		};
> -		opp-1132800000 {
> -			opp-hz = /bits/ 64 <1132800000>;
> -			opp-microvolt = <905000 905000 1140000>;
> -			opp-supported-hw = <0x70>;
> -			clock-latency-ns = <200000>;
> -		};
> -		opp-1190400000 {
> -			opp-hz = /bits/ 64 <1190400000>;
> -			opp-microvolt = <905000 905000 1140000>;
> -			opp-supported-hw = <0x7>;
> -			clock-latency-ns = <200000>;
> -		};
> -		opp-1209600000 {
> -			opp-hz = /bits/ 64 <1209600000>;
> -			opp-microvolt = <905000 905000 1140000>;
> -			opp-supported-hw = <0x70>;
> -			clock-latency-ns = <200000>;
> -		};
> -		opp-1228800000 {
> -			opp-hz = /bits/ 64 <1228800000>;
> -			opp-microvolt = <905000 905000 1140000>;
> -			opp-supported-hw = <0x7>;
> -			clock-latency-ns = <200000>;
> -		};
> -		opp-1286400000 {
> -			opp-hz = /bits/ 64 <1286400000>;
> -			opp-microvolt = <1140000 905000 1140000>;
> -			opp-supported-hw = <0x70>;
> -			clock-latency-ns = <200000>;
> -		};
> -		opp-1324800000 {
> -			opp-hz = /bits/ 64 <1324800000>;
> -			opp-microvolt = <1140000 905000 1140000>;
> -			opp-supported-hw = <0x5>;
> -			clock-latency-ns = <200000>;
> -		};
> -		opp-1363200000 {
> -			opp-hz = /bits/ 64 <1363200000>;
> -			opp-microvolt = <1140000 905000 1140000>;
> -			opp-supported-hw = <0x72>;
> -			clock-latency-ns = <200000>;
> -		};
> -		opp-1401600000 {
> -			opp-hz = /bits/ 64 <1401600000>;
> -			opp-microvolt = <1140000 905000 1140000>;
> -			opp-supported-hw = <0x5>;
> -			clock-latency-ns = <200000>;
> -		};
> -		opp-1440000000 {
> -			opp-hz = /bits/ 64 <1440000000>;
> -			opp-microvolt = <1140000 905000 1140000>;
> -			opp-supported-hw = <0x70>;
> -			clock-latency-ns = <200000>;
> -		};
> -		opp-1478400000 {
> -			opp-hz = /bits/ 64 <1478400000>;
> -			opp-microvolt = <1140000 905000 1140000>;
> -			opp-supported-hw = <0x1>;
> -			clock-latency-ns = <200000>;
> -		};
> -		opp-1497600000 {
> -			opp-hz = /bits/ 64 <1497600000>;
> -			opp-microvolt = <1140000 905000 1140000>;
> -			opp-supported-hw = <0x4>;
> -			clock-latency-ns = <200000>;
> -		};
> -		opp-1516800000 {
> -			opp-hz = /bits/ 64 <1516800000>;
> -			opp-microvolt = <1140000 905000 1140000>;
> -			opp-supported-hw = <0x70>;
> -			clock-latency-ns = <200000>;
> -		};
> -		opp-1593600000 {
> -			opp-hz = /bits/ 64 <1593600000>;
> -			opp-microvolt = <1140000 905000 1140000>;
> -			opp-supported-hw = <0x71>;
> -			clock-latency-ns = <200000>;
> -		};
> -		opp-1996800000 {
> -			opp-hz = /bits/ 64 <1996800000>;
> -			opp-microvolt = <1140000 905000 1140000>;
> -			opp-supported-hw = <0x20>;
> -			clock-latency-ns = <200000>;
> -		};
> -		opp-2188800000 {
> -			opp-hz = /bits/ 64 <2188800000>;
> -			opp-microvolt = <1140000 905000 1140000>;
> -			opp-supported-hw = <0x10>;
> -			clock-latency-ns = <200000>;
> -		};
> -	};
> -
> -	cluster1_opp: opp_table1 {
> -		compatible = "operating-points-v2-kryo-cpu";
> -		nvmem-cells = <&speedbin_efuse>;
> -		opp-shared;
> -
> -		opp-307200000 {
> -			opp-hz = /bits/ 64 <307200000>;
> -			opp-microvolt = <905000 905000 1140000>;
> -			opp-supported-hw = <0x77>;
> -			clock-latency-ns = <200000>;
> -		};
> -		opp-384000000 {
> -			opp-hz = /bits/ 64 <384000000>;
> -			opp-microvolt = <905000 905000 1140000>;
> -			opp-supported-hw = <0x70>;
> -			clock-latency-ns = <200000>;
> -		};
> -		opp-403200000 {
> -			opp-hz = /bits/ 64 <403200000>;
> -			opp-microvolt = <905000 905000 1140000>;
> -			opp-supported-hw = <0x7>;
> -			clock-latency-ns = <200000>;
> -		};
> -		opp-460800000 {
> -			opp-hz = /bits/ 64 <460800000>;
> -			opp-microvolt = <905000 905000 1140000>;
> -			opp-supported-hw = <0x70>;
> -			clock-latency-ns = <200000>;
> -		};
> -		opp-480000000 {
> -			opp-hz = /bits/ 64 <480000000>;
> -			opp-microvolt = <905000 905000 1140000>;
> -			opp-supported-hw = <0x7>;
> -			clock-latency-ns = <200000>;
> -		};
> -		opp-537600000 {
> -			opp-hz = /bits/ 64 <537600000>;
> -			opp-microvolt = <905000 905000 1140000>;
> -			opp-supported-hw = <0x70>;
> -			clock-latency-ns = <200000>;
> -		};
> -		opp-556800000 {
> -			opp-hz = /bits/ 64 <556800000>;
> -			opp-microvolt = <905000 905000 1140000>;
> -			opp-supported-hw = <0x7>;
> -			clock-latency-ns = <200000>;
> -		};
> -		opp-614400000 {
> -			opp-hz = /bits/ 64 <614400000>;
> -			opp-microvolt = <905000 905000 1140000>;
> -			opp-supported-hw = <0x70>;
> -			clock-latency-ns = <200000>;
> -		};
> -		opp-652800000 {
> -			opp-hz = /bits/ 64 <652800000>;
> -			opp-microvolt = <905000 905000 1140000>;
> -			opp-supported-hw = <0x7>;
> -			clock-latency-ns = <200000>;
> -		};
> -		opp-691200000 {
> -			opp-hz = /bits/ 64 <691200000>;
> -			opp-microvolt = <905000 905000 1140000>;
> -			opp-supported-hw = <0x70>;
> -			clock-latency-ns = <200000>;
> -		};
> -		opp-729600000 {
> -			opp-hz = /bits/ 64 <729600000>;
> -			opp-microvolt = <905000 905000 1140000>;
> -			opp-supported-hw = <0x7>;
> -			clock-latency-ns = <200000>;
> -		};
> -		opp-748800000 {
> -			opp-hz = /bits/ 64 <748800000>;
> -			opp-microvolt = <905000 905000 1140000>;
> -			opp-supported-hw = <0x70>;
> -			clock-latency-ns = <200000>;
> -		};
> -		opp-806400000 {
> -			opp-hz = /bits/ 64 <806400000>;
> -			opp-microvolt = <905000 905000 1140000>;
> -			opp-supported-hw = <0x7>;
> -			clock-latency-ns = <200000>;
> -		};
> -		opp-825600000 {
> -			opp-hz = /bits/ 64 <825600000>;
> -			opp-microvolt = <905000 905000 1140000>;
> -			opp-supported-hw = <0x70>;
> -			clock-latency-ns = <200000>;
> -		};
> -		opp-883200000 {
> -			opp-hz = /bits/ 64 <883200000>;
> -			opp-microvolt = <905000 905000 1140000>;
> -			opp-supported-hw = <0x7>;
> -			clock-latency-ns = <200000>;
> -		};
> -		opp-902400000 {
> -			opp-hz = /bits/ 64 <902400000>;
> -			opp-microvolt = <905000 905000 1140000>;
> -			opp-supported-hw = <0x70>;
> -			clock-latency-ns = <200000>;
> -		};
> -		opp-940800000 {
> -			opp-hz = /bits/ 64 <940800000>;
> -			opp-microvolt = <905000 905000 1140000>;
> -			opp-supported-hw = <0x7>;
> -			clock-latency-ns = <200000>;
> -		};
> -		opp-979200000 {
> -			opp-hz = /bits/ 64 <979200000>;
> -			opp-microvolt = <905000 905000 1140000>;
> -			opp-supported-hw = <0x70>;
> -			clock-latency-ns = <200000>;
> -		};
> -		opp-1036800000 {
> -			opp-hz = /bits/ 64 <1036800000>;
> -			opp-microvolt = <905000 905000 1140000>;
> -			opp-supported-hw = <0x7>;
> -			clock-latency-ns = <200000>;
> -		};
> -		opp-1056000000 {
> -			opp-hz = /bits/ 64 <1056000000>;
> -			opp-microvolt = <905000 905000 1140000>;
> -			opp-supported-hw = <0x70>;
> -			clock-latency-ns = <200000>;
> -		};
> -		opp-1113600000 {
> -			opp-hz = /bits/ 64 <1113600000>;
> -			opp-microvolt = <905000 905000 1140000>;
> -			opp-supported-hw = <0x7>;
> -			clock-latency-ns = <200000>;
> -		};
> -		opp-1132800000 {
> -			opp-hz = /bits/ 64 <1132800000>;
> -			opp-microvolt = <905000 905000 1140000>;
> -			opp-supported-hw = <0x70>;
> -			clock-latency-ns = <200000>;
> -		};
> -		opp-1190400000 {
> -			opp-hz = /bits/ 64 <1190400000>;
> -			opp-microvolt = <905000 905000 1140000>;
> -			opp-supported-hw = <0x7>;
> -			clock-latency-ns = <200000>;
> -		};
> -		opp-1209600000 {
> -			opp-hz = /bits/ 64 <1209600000>;
> -			opp-microvolt = <905000 905000 1140000>;
> -			opp-supported-hw = <0x70>;
> -			clock-latency-ns = <200000>;
> -		};
> -		opp-1248000000 {
> -			opp-hz = /bits/ 64 <1248000000>;
> -			opp-microvolt = <905000 905000 1140000>;
> -			opp-supported-hw = <0x7>;
> -			clock-latency-ns = <200000>;
> -		};
> -		opp-1286400000 {
> -			opp-hz = /bits/ 64 <1286400000>;
> -			opp-microvolt = <905000 905000 1140000>;
> -			opp-supported-hw = <0x70>;
> -			clock-latency-ns = <200000>;
> -		};
> -		opp-1324800000 {
> -			opp-hz = /bits/ 64 <1324800000>;
> -			opp-microvolt = <1140000 905000 1140000>;
> -			opp-supported-hw = <0x7>;
> -			clock-latency-ns = <200000>;
> -		};
> -		opp-1363200000 {
> -			opp-hz = /bits/ 64 <1363200000>;
> -			opp-microvolt = <1140000 905000 1140000>;
> -			opp-supported-hw = <0x70>;
> -			clock-latency-ns = <200000>;
> -		};
> -		opp-1401600000 {
> -			opp-hz = /bits/ 64 <1401600000>;
> -			opp-microvolt = <1140000 905000 1140000>;
> -			opp-supported-hw = <0x7>;
> -			clock-latency-ns = <200000>;
> -		};
> -		opp-1440000000 {
> -			opp-hz = /bits/ 64 <1440000000>;
> -			opp-microvolt = <1140000 905000 1140000>;
> -			opp-supported-hw = <0x70>;
> -			clock-latency-ns = <200000>;
> -		};
> -		opp-1478400000 {
> -			opp-hz = /bits/ 64 <1478400000>;
> -			opp-microvolt = <1140000 905000 1140000>;
> -			opp-supported-hw = <0x7>;
> -			clock-latency-ns = <200000>;
> -		};
> -		opp-1516800000 {
> -			opp-hz = /bits/ 64 <1516800000>;
> -			opp-microvolt = <1140000 905000 1140000>;
> -			opp-supported-hw = <0x70>;
> -			clock-latency-ns = <200000>;
> -		};
> -		opp-1555200000 {
> -			opp-hz = /bits/ 64 <1555200000>;
> -			opp-microvolt = <1140000 905000 1140000>;
> -			opp-supported-hw = <0x7>;
> -			clock-latency-ns = <200000>;
> -		};
> -		opp-1593600000 {
> -			opp-hz = /bits/ 64 <1593600000>;
> -			opp-microvolt = <1140000 905000 1140000>;
> -			opp-supported-hw = <0x70>;
> -			clock-latency-ns = <200000>;
> -		};
> -		opp-1632000000 {
> -			opp-hz = /bits/ 64 <1632000000>;
> -			opp-microvolt = <1140000 905000 1140000>;
> -			opp-supported-hw = <0x7>;
> -			clock-latency-ns = <200000>;
> -		};
> -		opp-1670400000 {
> -			opp-hz = /bits/ 64 <1670400000>;
> -			opp-microvolt = <1140000 905000 1140000>;
> -			opp-supported-hw = <0x70>;
> -			clock-latency-ns = <200000>;
> -		};
> -		opp-1708800000 {
> -			opp-hz = /bits/ 64 <1708800000>;
> -			opp-microvolt = <1140000 905000 1140000>;
> -			opp-supported-hw = <0x7>;
> -			clock-latency-ns = <200000>;
> -		};
> -		opp-1747200000 {
> -			opp-hz = /bits/ 64 <1747200000>;
> -			opp-microvolt = <1140000 905000 1140000>;
> -			opp-supported-hw = <0x70>;
> -			clock-latency-ns = <200000>;
> -		};
> -		opp-1785600000 {
> -			opp-hz = /bits/ 64 <1785600000>;
> -			opp-microvolt = <1140000 905000 1140000>;
> -			opp-supported-hw = <0x7>;
> -			clock-latency-ns = <200000>;
> -		};
> -		opp-1804800000 {
> -			opp-hz = /bits/ 64 <1804800000>;
> -			opp-microvolt = <1140000 905000 1140000>;
> -			opp-supported-hw = <0x6>;
> -			clock-latency-ns = <200000>;
> -		};
> -		opp-1824000000 {
> -			opp-hz = /bits/ 64 <1824000000>;
> -			opp-microvolt = <1140000 905000 1140000>;
> -			opp-supported-hw = <0x71>;
> -			clock-latency-ns = <200000>;
> -		};
> -		opp-1900800000 {
> -			opp-hz = /bits/ 64 <1900800000>;
> -			opp-microvolt = <1140000 905000 1140000>;
> -			opp-supported-hw = <0x74>;
> -			clock-latency-ns = <200000>;
> -		};
> -		opp-1920000000 {
> -			opp-hz = /bits/ 64 <1920000000>;
> -			opp-microvolt = <1140000 905000 1140000>;
> -			opp-supported-hw = <0x1>;
> -			clock-latency-ns = <200000>;
> -		};
> -		opp-1977600000 {
> -			opp-hz = /bits/ 64 <1977600000>;
> -			opp-microvolt = <1140000 905000 1140000>;
> -			opp-supported-hw = <0x30>;
> -			clock-latency-ns = <200000>;
> -		};
> -		opp-1996800000 {
> -			opp-hz = /bits/ 64 <1996800000>;
> -			opp-microvolt = <1140000 905000 1140000>;
> -			opp-supported-hw = <0x1>;
> -			clock-latency-ns = <200000>;
> -		};
> -		opp-2054400000 {
> -			opp-hz = /bits/ 64 <2054400000>;
> -			opp-microvolt = <1140000 905000 1140000>;
> -			opp-supported-hw = <0x30>;
> -			clock-latency-ns = <200000>;
> -		};
> -		opp-2073600000 {
> -			opp-hz = /bits/ 64 <2073600000>;
> -			opp-microvolt = <1140000 905000 1140000>;
> -			opp-supported-hw = <0x1>;
> -			clock-latency-ns = <200000>;
> -		};
> -		opp-2150400000 {
> -			opp-hz = /bits/ 64 <2150400000>;
> -			opp-microvolt = <1140000 905000 1140000>;
> -			opp-supported-hw = <0x31>;
> -			clock-latency-ns = <200000>;
> -		};
> -		opp-2246400000 {
> -			opp-hz = /bits/ 64 <2246400000>;
> -			opp-microvolt = <1140000 905000 1140000>;
> -			opp-supported-hw = <0x10>;
> -			clock-latency-ns = <200000>;
> -		};
> -		opp-2342400000 {
> -			opp-hz = /bits/ 64 <2342400000>;
> -			opp-microvolt = <1140000 905000 1140000>;
> -			opp-supported-hw = <0x10>;
> -			clock-latency-ns = <200000>;
> -		};
> -	};
> -
> -....
> -
> -reserved-memory {
> -	#address-cells = <2>;
> -	#size-cells = <2>;
> -	ranges;
> -....
> -	smem_mem: smem-mem@86000000 {
> -		reg = <0x0 0x86000000 0x0 0x200000>;
> -		no-map;
> -	};
> -....
> -};
> -
> -smem {
> -	compatible = "qcom,smem";
> -	memory-region = <&smem_mem>;
> -	hwlocks = <&tcsr_mutex 3>;
> -};
> -
> -soc {
> -....
> -	qfprom: qfprom@74000 {
> -		compatible = "qcom,qfprom";
> -		reg = <0x00074000 0x8ff>;
> -		#address-cells = <1>;
> -		#size-cells = <1>;
> -		....
> -		speedbin_efuse: speedbin@133 {
> -			reg = <0x133 0x1>;
> -			bits = <5 3>;
> -		};
> -	};
> -};
> -
> -Example 2:
> ----------
> -
> -	cpus {
> -		#address-cells = <1>;
> -		#size-cells = <0>;
> -
> -		CPU0: cpu@100 {
> -			device_type = "cpu";
> -			compatible = "arm,cortex-a53";
> -			reg = <0x100>;
> -			....
> -			clocks = <&apcs_glb>;
> -			operating-points-v2 = <&cpu_opp_table>;
> -			power-domains = <&cpr>;
> -			power-domain-names = "cpr";
> -		};
> -
> -		CPU1: cpu@101 {
> -			device_type = "cpu";
> -			compatible = "arm,cortex-a53";
> -			reg = <0x101>;
> -			....
> -			clocks = <&apcs_glb>;
> -			operating-points-v2 = <&cpu_opp_table>;
> -			power-domains = <&cpr>;
> -			power-domain-names = "cpr";
> -		};
> -
> -		CPU2: cpu@102 {
> -			device_type = "cpu";
> -			compatible = "arm,cortex-a53";
> -			reg = <0x102>;
> -			....
> -			clocks = <&apcs_glb>;
> -			operating-points-v2 = <&cpu_opp_table>;
> -			power-domains = <&cpr>;
> -			power-domain-names = "cpr";
> -		};
> -
> -		CPU3: cpu@103 {
> -			device_type = "cpu";
> -			compatible = "arm,cortex-a53";
> -			reg = <0x103>;
> -			....
> -			clocks = <&apcs_glb>;
> -			operating-points-v2 = <&cpu_opp_table>;
> -			power-domains = <&cpr>;
> -			power-domain-names = "cpr";
> -		};
> -	};
> -
> -	cpu_opp_table: cpu-opp-table {
> -		compatible = "operating-points-v2-kryo-cpu";
> -		opp-shared;
> -
> -		opp-1094400000 {
> -			opp-hz = /bits/ 64 <1094400000>;
> -			required-opps = <&cpr_opp1>;
> -		};
> -		opp-1248000000 {
> -			opp-hz = /bits/ 64 <1248000000>;
> -			required-opps = <&cpr_opp2>;
> -		};
> -		opp-1401600000 {
> -			opp-hz = /bits/ 64 <1401600000>;
> -			required-opps = <&cpr_opp3>;
> -		};
> -	};
> -
> -	cpr_opp_table: cpr-opp-table {
> -		compatible = "operating-points-v2-qcom-level";
> -
> -		cpr_opp1: opp1 {
> -			opp-level = <1>;
> -			qcom,opp-fuse-level = <1>;
> -		};
> -		cpr_opp2: opp2 {
> -			opp-level = <2>;
> -			qcom,opp-fuse-level = <2>;
> -		};
> -		cpr_opp3: opp3 {
> -			opp-level = <3>;
> -			qcom,opp-fuse-level = <3>;
> -		};
> -	};
> -
> -....
> -
> -soc {
> -....
> -	cpr: power-controller@b018000 {
> -		compatible = "qcom,qcs404-cpr", "qcom,cpr";
> -		reg = <0x0b018000 0x1000>;
> -		....
> -		vdd-apc-supply = <&pms405_s3>;
> -		#power-domain-cells = <0>;
> -		operating-points-v2 = <&cpr_opp_table>;
> -		....
> -	};
> -};
> diff --git a/MAINTAINERS b/MAINTAINERS
> index a7715fc859f7..e62cd1f613c5 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -15660,7 +15660,7 @@ QUALCOMM CPUFREQ DRIVER MSM8996/APQ8096
>  M:	Ilia Lin <ilia.lin@kernel.org>
>  L:	linux-pm@vger.kernel.org
>  S:	Maintained
> -F:	Documentation/devicetree/bindings/opp/qcom-nvmem-cpufreq.txt
> +F:	Documentation/devicetree/bindings/opp/qcom-cpufreq-nvmem.yaml
>  F:	drivers/cpufreq/qcom-cpufreq-nvmem.c
>  
>  QUALCOMM CRYPTO DRIVERS
> -- 
> 2.33.0
> 
> 
> 
