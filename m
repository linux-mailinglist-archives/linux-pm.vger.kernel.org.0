Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1609933064B
	for <lists+linux-pm@lfdr.de>; Mon,  8 Mar 2021 04:19:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233813AbhCHDSq (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 7 Mar 2021 22:18:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233791AbhCHDSd (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 7 Mar 2021 22:18:33 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56BC4C06175F
        for <linux-pm@vger.kernel.org>; Sun,  7 Mar 2021 19:18:33 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id d15so9896220wrv.5
        for <linux-pm@vger.kernel.org>; Sun, 07 Mar 2021 19:18:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=G0AOWyW95+kXB2pSQONLVe60MBSsKo9TyVsaldv19AI=;
        b=w5NEZ6FcO4p8M25SIBhV2PrtNi9lUSg3atVc+674hJMy6MuCuJsD4bp7j0dg1ebDQq
         sqRRN1m8KYNVNvtnrrEThFWIULuhhkcIEMHx2G1qc02c4IpJMiuZOsDR7DfcVp/nBO3p
         FIG9luFJzHEUjrG6OQdI0QyeeOuUPAJd5XslkRwqy1UEWYMJKyUQ/U5PyaZLxuPsK9DY
         YIp0vlDcOcfPh3y82hHmec4JvKXJN1H+lTAfnj4uF+ffYX6Z1zPzw9vKVVnHmeBDQqj9
         I013k65FIi+Z1Kp4lSlZQ1GZaiRd+4tNldN7oMZard98yoQEozE0eRobDh2oansyuKj/
         bWbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=G0AOWyW95+kXB2pSQONLVe60MBSsKo9TyVsaldv19AI=;
        b=QXafPsyl2F9s0RpyeGks3ICOkK+srUpXnn/1gU8woV+jQdoT85ZB2GPDCJZQ2b/o2S
         mCAYV4n6TZX0BXqt+XHq93wFU8Jcs3yeBLTXZO3nngNtVMfsZQRDrxrJr+CXHxiHIaRg
         O+jbkcP3PTLaMNXzh8Jt7L4hFAAyr6Emn3FQhVS0KfiIP8cplqmSuuG1wNKqrZyb/Lns
         Zks3HitL3h69S+eih4mTb2rWd5BLYokRwz8gAGSCxNzQiKK3I7V3xeu7IrowZp3kFUvA
         hb5TMuQgNoIG9gYCWn0u7GIuZzLa37IPkbcPIRxubdh5l3qA5KzXIrhMMDIG+XARcoe0
         eJlg==
X-Gm-Message-State: AOAM531bc8gHeK6aHf2BubjiJjR5yER0ucdcbbREWVxWyIR5hZEnvrB5
        KMvcxXvXVCnKUvP8S992uRZeBSAYB9YdQTr33Txjsw==
X-Google-Smtp-Source: ABdhPJysLlBZqtYleDHpGEwZP5dHolYf62yfbGM2IZxJANa4NX01cqxqc06D0rG/QY+KDPjRDQUZIyQ62yP0UrKeLRs=
X-Received: by 2002:a5d:5744:: with SMTP id q4mr21144260wrw.390.1615173511850;
 Sun, 07 Mar 2021 19:18:31 -0800 (PST)
MIME-Version: 1.0
References: <20210221093758.210981-1-anup.patel@wdc.com> <20210221093758.210981-8-anup.patel@wdc.com>
 <20210305232245.GA820565@robh.at.kernel.org>
In-Reply-To: <20210305232245.GA820565@robh.at.kernel.org>
From:   Anup Patel <anup@brainfault.org>
Date:   Mon, 8 Mar 2021 08:48:20 +0530
Message-ID: <CAAhSdy0TwcE17-GJp664of4DV_R+6Q-S_h-N4Sbv9KL4Xofxvg@mail.gmail.com>
Subject: Re: [RFC PATCH 7/8] dt-bindings: Add bindings documentation for
 RISC-V idle states
To:     Rob Herring <robh@kernel.org>
Cc:     Anup Patel <anup.patel@wdc.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
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
        Liush <liush@allwinnertech.com>, devicetree@vger.kernel.org,
        linux-riscv <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        linux-pm@vger.kernel.org,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sat, Mar 6, 2021 at 4:52 AM Rob Herring <robh@kernel.org> wrote:
>
> On Sun, Feb 21, 2021 at 03:07:57PM +0530, Anup Patel wrote:
> > The RISC-V CPU idle states will be described in DT under the
> > /cpus/riscv-idle-states DT node. This patch adds the bindings
> > documentation for riscv-idle-states DT nodes and idle state DT
> > nodes under it.
> >
> > Signed-off-by: Anup Patel <anup.patel@wdc.com>
> > ---
> >  .../bindings/riscv/idle-states.yaml           | 250 ++++++++++++++++++
> >  1 file changed, 250 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/riscv/idle-states.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/riscv/idle-states.yaml b/Documentation/devicetree/bindings/riscv/idle-states.yaml
> > new file mode 100644
> > index 000000000000..3eff763fed23
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/riscv/idle-states.yaml
> > @@ -0,0 +1,250 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/riscv/idle-states.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: RISC-V idle states binding description
> > +
> > +maintainers:
> > +  - Anup Patel <anup.patel@wdc.com>
> > +
> > +description: |+
> > +  RISC-V systems can manage power consumption dynamically, where HARTs
> > +  (or CPUs) [1] can be put in different platform specific suspend (or
> > +  idle) states (ranging from simple WFI, power gating, etc). The RISC-V
> > +  SBI [2] hart state management extension provides a standard mechanism
> > +  for OSes to request HART state transitions.
> > +
> > +  The platform specific suspend (or idle) states of a hart can be either
> > +  retentive or non-rententive in nature. A retentive suspend state will
> > +  preserve hart register and CSR values for all privilege modes whereas
> > +  a non-retentive suspend state will not preserve hart register and CSR
> > +  values. The suspend (or idle) state entered by executing the WFI
> > +  instruction is considered standard on all RISC-V systems and therefore
> > +  must not be listed in device tree.
> > +
> > +  The device tree binding definition for RISC-V idle states described
> > +  in this document is quite similar to the ARM idle states [3].
> > +
> > +  References
> > +
> > +  [1] RISC-V Linux Kernel documentation - CPUs bindings
> > +      Documentation/devicetree/bindings/riscv/cpus.yaml
> > +
> > +  [2] RISC-V Supervisor Binary Interface (SBI)
> > +      http://github.com/riscv/riscv-sbi-doc/riscv-sbi.adoc
> > +
> > +  [3] ARM idle states binding description - Idle states bindings
> > +      Documentation/devicetree/bindings/arm/idle-states.yaml
>
> I'd assume there's common parts we can share.

Yes, except few properties most are the same.

We can have a shared DT bindings for both ARM and RISC-V but
both architectures will always have some architecture specific details
(or properties) which need to be documented under arch specific
DT documentation. Is it okay if this is done as a separate series ?

>
> > +
> > +properties:
> > +  $nodename:
> > +    const: riscv-idle-states
>
> Just 'idle-states' like Arm.

I had tried "idle-states" node name but DT bindings check complaints
conflict with ARM idle state bindings.

>
> > +
> > +patternProperties:
> > +  "^(cpu|cluster)-":
> > +    type: object
> > +    description: |
> > +      Each state node represents an idle state description and must be
> > +      defined as follows.
> > +
>
>        additionalProperties: false

okay, will update.

>
> > +    properties:
> > +      compatible:
> > +        const: riscv,idle-state
> > +
> > +      local-timer-stop:
> > +        description:
> > +          If present the CPU local timer control logic is lost on state
> > +          entry, otherwise it is retained.
> > +        type: boolean
> > +
> > +      entry-latency-us:
> > +        description:
> > +          Worst case latency in microseconds required to enter the idle state.
> > +
> > +      exit-latency-us:
> > +        description:
> > +          Worst case latency in microseconds required to exit the idle state.
> > +          The exit-latency-us duration may be guaranteed only after
> > +          entry-latency-us has passed.
> > +
> > +      min-residency-us:
> > +        description:
> > +          Minimum residency duration in microseconds, inclusive of preparation
> > +          and entry, for this idle state to be considered worthwhile energy
> > +          wise (refer to section 2 of this document for a complete description).
> > +
> > +      wakeup-latency-us:
> > +        description: |
> > +          Maximum delay between the signaling of a wake-up event and the CPU
> > +          being able to execute normal code again. If omitted, this is assumed
> > +          to be equal to:
> > +
> > +            entry-latency-us + exit-latency-us
> > +
> > +          It is important to supply this value on systems where the duration
> > +          of PREP phase (see diagram 1, section 2) is non-neglibigle. In such
> > +          systems entry-latency-us + exit-latency-us will exceed
> > +          wakeup-latency-us by this duration.
> > +
> > +      idle-state-name:
> > +        $ref: /schemas/types.yaml#/definitions/string
> > +        description:
> > +          A string used as a descriptive name for the idle state.
> > +
> > +    required:
> > +      - compatible
> > +      - entry-latency-us
> > +      - exit-latency-us
> > +      - min-residency-us
> > +
> > +additionalProperties: false

I will move this up.

> > +
> > +examples:
> > +  - |
> > +
> > +    cpus {
> > +        #size-cells = <0>;
> > +        #address-cells = <1>;
> > +
> > +        cpu@0 {
> > +            device_type = "cpu";
> > +            compatible = "riscv";
> > +            reg = <0x0>;
> > +            riscv,isa = "rv64imafdc";
> > +            mmu-type = "riscv,sv48";
> > +            cpu-idle-states = <&CPU_RET_0_0 &CPU_NONRET_0_0
> > +                            &CLUSTER_RET_0 &CLUSTER_NONRET_0>;
>
> You should need to add this property to your cpu schema.

Okay, will update.

>
> > +
> > +            cpu_intc0: interrupt-controller {
> > +                #interrupt-cells = <1>;
> > +                compatible = "riscv,cpu-intc";
> > +                interrupt-controller;
> > +            };
> > +        };
> > +
> > +        cpu@1 {
> > +            device_type = "cpu";
> > +            compatible = "riscv";
> > +            reg = <0x1>;
> > +            riscv,isa = "rv64imafdc";
> > +            mmu-type = "riscv,sv48";
> > +            cpu-idle-states = <&CPU_RET_0_0 &CPU_NONRET_0_0
> > +                            &CLUSTER_RET_0 &CLUSTER_NONRET_0>;
> > +
> > +            cpu_intc1: interrupt-controller {
> > +                #interrupt-cells = <1>;
> > +                compatible = "riscv,cpu-intc";
> > +                interrupt-controller;
> > +            };
> > +        };
> > +
> > +        cpu@10 {
> > +            device_type = "cpu";
> > +            compatible = "riscv";
> > +            reg = <0x10>;
> > +            riscv,isa = "rv64imafdc";
> > +            mmu-type = "riscv,sv48";
> > +            cpu-idle-states = <&CPU_RET_1_0 &CPU_NONRET_1_0
> > +                            &CLUSTER_RET_1 &CLUSTER_NONRET_1>;
> > +
> > +            cpu_intc10: interrupt-controller {
> > +                #interrupt-cells = <1>;
> > +                compatible = "riscv,cpu-intc";
> > +                interrupt-controller;
> > +            };
> > +        };
> > +
> > +        cpu@11 {
> > +            device_type = "cpu";
> > +            compatible = "riscv";
> > +            reg = <0x11>;
> > +            riscv,isa = "rv64imafdc";
> > +            mmu-type = "riscv,sv48";
> > +            cpu-idle-states = <&CPU_RET_1_0 &CPU_NONRET_1_0
> > +                            &CLUSTER_RET_1 &CLUSTER_NONRET_1>;
> > +
> > +            cpu_intc11: interrupt-controller {
> > +                #interrupt-cells = <1>;
> > +                compatible = "riscv,cpu-intc";
> > +                interrupt-controller;
> > +            };
> > +        };
> > +
> > +        riscv-idle-states {
> > +            CPU_RET_0_0: cpu-retentive-0-0 {
> > +                compatible = "riscv,idle-state";
> > +                riscv,sbi-suspend-param = <0x10000000>;
>
> Not documented.

Ahh, I missed this one. I will add it in next patch revision.

>
> > +                entry-latency-us = <20>;
> > +                exit-latency-us = <40>;
> > +                min-residency-us = <80>;
> > +            };
> > +
> > +            CPU_NONRET_0_0: cpu-nonretentive-0-0 {
> > +                compatible = "riscv,idle-state";
> > +                riscv,sbi-suspend-param = <0x90000000>;
> > +                entry-latency-us = <250>;
> > +                exit-latency-us = <500>;
> > +                min-residency-us = <950>;
> > +            };
> > +
> > +            CLUSTER_RET_0: cluster-retentive-0 {
> > +                compatible = "riscv,idle-state";
> > +                riscv,sbi-suspend-param = <0x11000000>;
> > +                local-timer-stop;
> > +                entry-latency-us = <50>;
> > +                exit-latency-us = <100>;
> > +                min-residency-us = <250>;
> > +                wakeup-latency-us = <130>;
> > +            };
> > +
> > +            CLUSTER_NONRET_0: cluster-nonretentive-0 {
> > +                compatible = "riscv,idle-state";
> > +                riscv,sbi-suspend-param = <0x91000000>;
> > +                local-timer-stop;
> > +                entry-latency-us = <600>;
> > +                exit-latency-us = <1100>;
> > +                min-residency-us = <2700>;
> > +                wakeup-latency-us = <1500>;
> > +            };
> > +
> > +            CPU_RET_1_0: cpu-retentive-1-0 {
> > +                compatible = "riscv,idle-state";
> > +                riscv,sbi-suspend-param = <0x10000010>;
> > +                entry-latency-us = <20>;
> > +                exit-latency-us = <40>;
> > +                min-residency-us = <80>;
> > +            };
> > +
> > +            CPU_NONRET_1_0: cpu-nonretentive-1-0 {
> > +                compatible = "riscv,idle-state";
> > +                riscv,sbi-suspend-param = <0x90000010>;
> > +                entry-latency-us = <250>;
> > +                exit-latency-us = <500>;
> > +                min-residency-us = <950>;
> > +            };
> > +
> > +            CLUSTER_RET_1: cluster-retentive-1 {
> > +                compatible = "riscv,idle-state";
> > +                riscv,sbi-suspend-param = <0x11000010>;
> > +                local-timer-stop;
> > +                entry-latency-us = <50>;
> > +                exit-latency-us = <100>;
> > +                min-residency-us = <250>;
> > +                wakeup-latency-us = <130>;
> > +            };
> > +
> > +            CLUSTER_NONRET_1: cluster-nonretentive-1 {
> > +                compatible = "riscv,idle-state";
> > +                riscv,sbi-suspend-param = <0x91000010>;
> > +                local-timer-stop;
> > +                entry-latency-us = <600>;
> > +                exit-latency-us = <1100>;
> > +                min-residency-us = <2700>;
> > +                wakeup-latency-us = <1500>;
> > +            };
> > +        };
> > +    };
> > +
> > +...
> > --
> > 2.25.1
> >

Regards,
Anup
