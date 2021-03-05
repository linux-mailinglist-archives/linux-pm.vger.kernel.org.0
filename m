Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6990532F68D
	for <lists+linux-pm@lfdr.de>; Sat,  6 Mar 2021 00:23:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229815AbhCEXW7 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 5 Mar 2021 18:22:59 -0500
Received: from mail-oi1-f175.google.com ([209.85.167.175]:34532 "EHLO
        mail-oi1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229651AbhCEXWt (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 5 Mar 2021 18:22:49 -0500
Received: by mail-oi1-f175.google.com with SMTP id x78so4390262oix.1;
        Fri, 05 Mar 2021 15:22:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8bDgjusk3v3TEqzMR3iY18WopMlgkTf5ccZF+W6WfEc=;
        b=uGqwwKS5O5uEj4LnLGVOdb2CoFWd9HRqvPUn5/mgIuz4OoQY5IksTvwoCel/mGyGPK
         IJR7yeaAW2Lv7tc2AhzluiQXMctbpfBTaSXIWh7Jz9UPkRTf9LZoxLimCSMnoRJ2xm66
         MVuRZgQdlbYoxeBKlwcEROOupaSKMARsJdWPYhBgnUojzq1VNw/znjsZP+UXYpQjzA9b
         etL4ayk5YjYTJLLiZBnKhg1gYuEAokC+Qeflb/QcnFMdEcXoC9Q8K7YYG3XbuCV1GDgZ
         fjkmtvzYsNSJlcMW7ux2Hd3vG7eh7sDX8zc2wbgZdoNnAGZSfQNlgs3mVBK6VWSyckS5
         wRRw==
X-Gm-Message-State: AOAM533uBexAxkOgLEfOxsjVFJ5zFmvhwwHOg0AA7VtH8AdOYdv/Nf1v
        CfHhiu9tCbIHtph/aICMPw==
X-Google-Smtp-Source: ABdhPJwnP2ACxLKHwogrpwaQEBPZ44ot+C/dBg82d6j3O7VgN3A+hrtebaQGCd0LIKGxwaRMuGNYrQ==
X-Received: by 2002:a54:4689:: with SMTP id k9mr9011155oic.149.1614986568593;
        Fri, 05 Mar 2021 15:22:48 -0800 (PST)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id s21sm870385oos.5.2021.03.05.15.22.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Mar 2021 15:22:47 -0800 (PST)
Received: (nullmailer pid 830239 invoked by uid 1000);
        Fri, 05 Mar 2021 23:22:45 -0000
Date:   Fri, 5 Mar 2021 17:22:45 -0600
From:   Rob Herring <robh@kernel.org>
To:     Anup Patel <anup.patel@wdc.com>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Pavel Machek <pavel@ucw.cz>,
        Sandeep Tripathy <milun.tripathy@gmail.com>,
        Atish Patra <atish.patra@wdc.com>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        Liush <liush@allwinnertech.com>,
        Anup Patel <anup@brainfault.org>, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [RFC PATCH 7/8] dt-bindings: Add bindings documentation for
 RISC-V idle states
Message-ID: <20210305232245.GA820565@robh.at.kernel.org>
References: <20210221093758.210981-1-anup.patel@wdc.com>
 <20210221093758.210981-8-anup.patel@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210221093758.210981-8-anup.patel@wdc.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sun, Feb 21, 2021 at 03:07:57PM +0530, Anup Patel wrote:
> The RISC-V CPU idle states will be described in DT under the
> /cpus/riscv-idle-states DT node. This patch adds the bindings
> documentation for riscv-idle-states DT nodes and idle state DT
> nodes under it.
> 
> Signed-off-by: Anup Patel <anup.patel@wdc.com>
> ---
>  .../bindings/riscv/idle-states.yaml           | 250 ++++++++++++++++++
>  1 file changed, 250 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/riscv/idle-states.yaml
> 
> diff --git a/Documentation/devicetree/bindings/riscv/idle-states.yaml b/Documentation/devicetree/bindings/riscv/idle-states.yaml
> new file mode 100644
> index 000000000000..3eff763fed23
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/riscv/idle-states.yaml
> @@ -0,0 +1,250 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/riscv/idle-states.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: RISC-V idle states binding description
> +
> +maintainers:
> +  - Anup Patel <anup.patel@wdc.com>
> +
> +description: |+
> +  RISC-V systems can manage power consumption dynamically, where HARTs
> +  (or CPUs) [1] can be put in different platform specific suspend (or
> +  idle) states (ranging from simple WFI, power gating, etc). The RISC-V
> +  SBI [2] hart state management extension provides a standard mechanism
> +  for OSes to request HART state transitions.
> +
> +  The platform specific suspend (or idle) states of a hart can be either
> +  retentive or non-rententive in nature. A retentive suspend state will
> +  preserve hart register and CSR values for all privilege modes whereas
> +  a non-retentive suspend state will not preserve hart register and CSR
> +  values. The suspend (or idle) state entered by executing the WFI
> +  instruction is considered standard on all RISC-V systems and therefore
> +  must not be listed in device tree.
> +
> +  The device tree binding definition for RISC-V idle states described
> +  in this document is quite similar to the ARM idle states [3].
> +
> +  References
> +
> +  [1] RISC-V Linux Kernel documentation - CPUs bindings
> +      Documentation/devicetree/bindings/riscv/cpus.yaml
> +
> +  [2] RISC-V Supervisor Binary Interface (SBI)
> +      http://github.com/riscv/riscv-sbi-doc/riscv-sbi.adoc
> +
> +  [3] ARM idle states binding description - Idle states bindings
> +      Documentation/devicetree/bindings/arm/idle-states.yaml

I'd assume there's common parts we can share.

> +
> +properties:
> +  $nodename:
> +    const: riscv-idle-states

Just 'idle-states' like Arm.

> +
> +patternProperties:
> +  "^(cpu|cluster)-":
> +    type: object
> +    description: |
> +      Each state node represents an idle state description and must be
> +      defined as follows.
> +

       additionalProperties: false

> +    properties:
> +      compatible:
> +        const: riscv,idle-state
> +
> +      local-timer-stop:
> +        description:
> +          If present the CPU local timer control logic is lost on state
> +          entry, otherwise it is retained.
> +        type: boolean
> +
> +      entry-latency-us:
> +        description:
> +          Worst case latency in microseconds required to enter the idle state.
> +
> +      exit-latency-us:
> +        description:
> +          Worst case latency in microseconds required to exit the idle state.
> +          The exit-latency-us duration may be guaranteed only after
> +          entry-latency-us has passed.
> +
> +      min-residency-us:
> +        description:
> +          Minimum residency duration in microseconds, inclusive of preparation
> +          and entry, for this idle state to be considered worthwhile energy
> +          wise (refer to section 2 of this document for a complete description).
> +
> +      wakeup-latency-us:
> +        description: |
> +          Maximum delay between the signaling of a wake-up event and the CPU
> +          being able to execute normal code again. If omitted, this is assumed
> +          to be equal to:
> +
> +            entry-latency-us + exit-latency-us
> +
> +          It is important to supply this value on systems where the duration
> +          of PREP phase (see diagram 1, section 2) is non-neglibigle. In such
> +          systems entry-latency-us + exit-latency-us will exceed
> +          wakeup-latency-us by this duration.
> +
> +      idle-state-name:
> +        $ref: /schemas/types.yaml#/definitions/string
> +        description:
> +          A string used as a descriptive name for the idle state.
> +
> +    required:
> +      - compatible
> +      - entry-latency-us
> +      - exit-latency-us
> +      - min-residency-us
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +
> +    cpus {
> +        #size-cells = <0>;
> +        #address-cells = <1>;
> +
> +        cpu@0 {
> +            device_type = "cpu";
> +            compatible = "riscv";
> +            reg = <0x0>;
> +            riscv,isa = "rv64imafdc";
> +            mmu-type = "riscv,sv48";
> +            cpu-idle-states = <&CPU_RET_0_0 &CPU_NONRET_0_0
> +                            &CLUSTER_RET_0 &CLUSTER_NONRET_0>;

You should need to add this property to your cpu schema.

> +
> +            cpu_intc0: interrupt-controller {
> +                #interrupt-cells = <1>;
> +                compatible = "riscv,cpu-intc";
> +                interrupt-controller;
> +            };
> +        };
> +
> +        cpu@1 {
> +            device_type = "cpu";
> +            compatible = "riscv";
> +            reg = <0x1>;
> +            riscv,isa = "rv64imafdc";
> +            mmu-type = "riscv,sv48";
> +            cpu-idle-states = <&CPU_RET_0_0 &CPU_NONRET_0_0
> +                            &CLUSTER_RET_0 &CLUSTER_NONRET_0>;
> +
> +            cpu_intc1: interrupt-controller {
> +                #interrupt-cells = <1>;
> +                compatible = "riscv,cpu-intc";
> +                interrupt-controller;
> +            };
> +        };
> +
> +        cpu@10 {
> +            device_type = "cpu";
> +            compatible = "riscv";
> +            reg = <0x10>;
> +            riscv,isa = "rv64imafdc";
> +            mmu-type = "riscv,sv48";
> +            cpu-idle-states = <&CPU_RET_1_0 &CPU_NONRET_1_0
> +                            &CLUSTER_RET_1 &CLUSTER_NONRET_1>;
> +
> +            cpu_intc10: interrupt-controller {
> +                #interrupt-cells = <1>;
> +                compatible = "riscv,cpu-intc";
> +                interrupt-controller;
> +            };
> +        };
> +
> +        cpu@11 {
> +            device_type = "cpu";
> +            compatible = "riscv";
> +            reg = <0x11>;
> +            riscv,isa = "rv64imafdc";
> +            mmu-type = "riscv,sv48";
> +            cpu-idle-states = <&CPU_RET_1_0 &CPU_NONRET_1_0
> +                            &CLUSTER_RET_1 &CLUSTER_NONRET_1>;
> +
> +            cpu_intc11: interrupt-controller {
> +                #interrupt-cells = <1>;
> +                compatible = "riscv,cpu-intc";
> +                interrupt-controller;
> +            };
> +        };
> +
> +        riscv-idle-states {
> +            CPU_RET_0_0: cpu-retentive-0-0 {
> +                compatible = "riscv,idle-state";
> +                riscv,sbi-suspend-param = <0x10000000>;

Not documented.

> +                entry-latency-us = <20>;
> +                exit-latency-us = <40>;
> +                min-residency-us = <80>;
> +            };
> +
> +            CPU_NONRET_0_0: cpu-nonretentive-0-0 {
> +                compatible = "riscv,idle-state";
> +                riscv,sbi-suspend-param = <0x90000000>;
> +                entry-latency-us = <250>;
> +                exit-latency-us = <500>;
> +                min-residency-us = <950>;
> +            };
> +
> +            CLUSTER_RET_0: cluster-retentive-0 {
> +                compatible = "riscv,idle-state";
> +                riscv,sbi-suspend-param = <0x11000000>;
> +                local-timer-stop;
> +                entry-latency-us = <50>;
> +                exit-latency-us = <100>;
> +                min-residency-us = <250>;
> +                wakeup-latency-us = <130>;
> +            };
> +
> +            CLUSTER_NONRET_0: cluster-nonretentive-0 {
> +                compatible = "riscv,idle-state";
> +                riscv,sbi-suspend-param = <0x91000000>;
> +                local-timer-stop;
> +                entry-latency-us = <600>;
> +                exit-latency-us = <1100>;
> +                min-residency-us = <2700>;
> +                wakeup-latency-us = <1500>;
> +            };
> +
> +            CPU_RET_1_0: cpu-retentive-1-0 {
> +                compatible = "riscv,idle-state";
> +                riscv,sbi-suspend-param = <0x10000010>;
> +                entry-latency-us = <20>;
> +                exit-latency-us = <40>;
> +                min-residency-us = <80>;
> +            };
> +
> +            CPU_NONRET_1_0: cpu-nonretentive-1-0 {
> +                compatible = "riscv,idle-state";
> +                riscv,sbi-suspend-param = <0x90000010>;
> +                entry-latency-us = <250>;
> +                exit-latency-us = <500>;
> +                min-residency-us = <950>;
> +            };
> +
> +            CLUSTER_RET_1: cluster-retentive-1 {
> +                compatible = "riscv,idle-state";
> +                riscv,sbi-suspend-param = <0x11000010>;
> +                local-timer-stop;
> +                entry-latency-us = <50>;
> +                exit-latency-us = <100>;
> +                min-residency-us = <250>;
> +                wakeup-latency-us = <130>;
> +            };
> +
> +            CLUSTER_NONRET_1: cluster-nonretentive-1 {
> +                compatible = "riscv,idle-state";
> +                riscv,sbi-suspend-param = <0x91000010>;
> +                local-timer-stop;
> +                entry-latency-us = <600>;
> +                exit-latency-us = <1100>;
> +                min-residency-us = <2700>;
> +                wakeup-latency-us = <1500>;
> +            };
> +        };
> +    };
> +
> +...
> -- 
> 2.25.1
> 
