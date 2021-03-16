Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45BA333D854
	for <lists+linux-pm@lfdr.de>; Tue, 16 Mar 2021 16:55:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232589AbhCPPy5 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 16 Mar 2021 11:54:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:57630 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238165AbhCPPyR (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 16 Mar 2021 11:54:17 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3B508650FB;
        Tue, 16 Mar 2021 15:54:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615910055;
        bh=X12PNJv2d0hJKm6jO5RnPyqX3jbiT5UMgSEL9vbW3EE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=KzHoZOMhlpzYcn1CRIhtE4ooow1l63zN6VWakgCwpzv8oGLP3vR44t/KSQwRBV/z1
         uv3bQQupAnCluDeqWhDIRKCvikHNnHogx83YaL7jz04YnZpnnXgwGJshuAHs+nSEs1
         pZCV5ERjWHcvf5SBT5GQQMMW/q+qF1hZc4kWvztq+9YtQmaigZ4L6PQZrVTPgTv0UJ
         bzVEOsCh1bEpdwpKQ/DDIFZpWlwUQfP1b96yG3wb09atbvzs6HN595LSlCwvAW9Wyz
         JiMkLMlZyXOCg8eiO3NLKoh07EWMGLJ9UACNS2PAjIAnpBr5Bl2BQk0qYrIGFwstD3
         neXZPDuMb8DjA==
Received: by mail-ej1-f52.google.com with SMTP id r17so72974853ejy.13;
        Tue, 16 Mar 2021 08:54:15 -0700 (PDT)
X-Gm-Message-State: AOAM533+XEYihNf2Il7e7B+oEqv41LhJcuGLMBSqZN/2GXQ1cXUX/+cE
        urkORKS9iZ3AuIUd+tDRMf1SzQd/gJhKzFQXpg==
X-Google-Smtp-Source: ABdhPJycsWYz3fT3883XYO8HdWUAMWiioah7z7v/xLx8OUz48pmocraYngYGK/4bxrZQrDz7oItmcFSb3RpciZ/Tj9U=
X-Received: by 2002:a17:906:2312:: with SMTP id l18mr31109055eja.468.1615910053805;
 Tue, 16 Mar 2021 08:54:13 -0700 (PDT)
MIME-Version: 1.0
References: <20210221093758.210981-1-anup.patel@wdc.com> <20210221093758.210981-8-anup.patel@wdc.com>
 <20210305232245.GA820565@robh.at.kernel.org> <CAAhSdy0TwcE17-GJp664of4DV_R+6Q-S_h-N4Sbv9KL4Xofxvg@mail.gmail.com>
In-Reply-To: <CAAhSdy0TwcE17-GJp664of4DV_R+6Q-S_h-N4Sbv9KL4Xofxvg@mail.gmail.com>
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 16 Mar 2021 09:53:58 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKPwND6BGq3gEuMugEnv4TNvM2_DMdB-p-v7qh5NXyPiQ@mail.gmail.com>
Message-ID: <CAL_JsqKPwND6BGq3gEuMugEnv4TNvM2_DMdB-p-v7qh5NXyPiQ@mail.gmail.com>
Subject: Re: [RFC PATCH 7/8] dt-bindings: Add bindings documentation for
 RISC-V idle states
To:     Anup Patel <anup@brainfault.org>
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
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sun, Mar 7, 2021 at 8:18 PM Anup Patel <anup@brainfault.org> wrote:
>
> On Sat, Mar 6, 2021 at 4:52 AM Rob Herring <robh@kernel.org> wrote:
> >
> > On Sun, Feb 21, 2021 at 03:07:57PM +0530, Anup Patel wrote:
> > > The RISC-V CPU idle states will be described in DT under the
> > > /cpus/riscv-idle-states DT node. This patch adds the bindings
> > > documentation for riscv-idle-states DT nodes and idle state DT
> > > nodes under it.
> > >
> > > Signed-off-by: Anup Patel <anup.patel@wdc.com>
> > > ---
> > >  .../bindings/riscv/idle-states.yaml           | 250 ++++++++++++++++++
> > >  1 file changed, 250 insertions(+)
> > >  create mode 100644 Documentation/devicetree/bindings/riscv/idle-states.yaml
> > >
> > > diff --git a/Documentation/devicetree/bindings/riscv/idle-states.yaml b/Documentation/devicetree/bindings/riscv/idle-states.yaml
> > > new file mode 100644
> > > index 000000000000..3eff763fed23
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/riscv/idle-states.yaml
> > > @@ -0,0 +1,250 @@
> > > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > > +%YAML 1.2
> > > +---
> > > +$id: http://devicetree.org/schemas/riscv/idle-states.yaml#
> > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > +
> > > +title: RISC-V idle states binding description
> > > +
> > > +maintainers:
> > > +  - Anup Patel <anup.patel@wdc.com>
> > > +
> > > +description: |+
> > > +  RISC-V systems can manage power consumption dynamically, where HARTs
> > > +  (or CPUs) [1] can be put in different platform specific suspend (or
> > > +  idle) states (ranging from simple WFI, power gating, etc). The RISC-V
> > > +  SBI [2] hart state management extension provides a standard mechanism
> > > +  for OSes to request HART state transitions.
> > > +
> > > +  The platform specific suspend (or idle) states of a hart can be either
> > > +  retentive or non-rententive in nature. A retentive suspend state will
> > > +  preserve hart register and CSR values for all privilege modes whereas
> > > +  a non-retentive suspend state will not preserve hart register and CSR
> > > +  values. The suspend (or idle) state entered by executing the WFI
> > > +  instruction is considered standard on all RISC-V systems and therefore
> > > +  must not be listed in device tree.
> > > +
> > > +  The device tree binding definition for RISC-V idle states described
> > > +  in this document is quite similar to the ARM idle states [3].
> > > +
> > > +  References
> > > +
> > > +  [1] RISC-V Linux Kernel documentation - CPUs bindings
> > > +      Documentation/devicetree/bindings/riscv/cpus.yaml
> > > +
> > > +  [2] RISC-V Supervisor Binary Interface (SBI)
> > > +      http://github.com/riscv/riscv-sbi-doc/riscv-sbi.adoc
> > > +
> > > +  [3] ARM idle states binding description - Idle states bindings
> > > +      Documentation/devicetree/bindings/arm/idle-states.yaml
> >
> > I'd assume there's common parts we can share.
>
> Yes, except few properties most are the same.
>
> We can have a shared DT bindings for both ARM and RISC-V but
> both architectures will always have some architecture specific details
> (or properties) which need to be documented under arch specific
> DT documentation. Is it okay if this is done as a separate series ?

No...

> > > +
> > > +properties:
> > > +  $nodename:
> > > +    const: riscv-idle-states
> >
> > Just 'idle-states' like Arm.
>
> I had tried "idle-states" node name but DT bindings check complaints
> conflict with ARM idle state bindings.

...and this being one reason why.

Actually, I think this can all be in 1 doc if you want. It's fine with
me if a common doc has RiscV and Arm specific properties.

> > > +
> > > +patternProperties:
> > > +  "^(cpu|cluster)-":
> > > +    type: object
> > > +    description: |
> > > +      Each state node represents an idle state description and must be
> > > +      defined as follows.
> > > +
> >
> >        additionalProperties: false
>
> okay, will update.
>
> >
> > > +    properties:
> > > +      compatible:
> > > +        const: riscv,idle-state
> > > +
> > > +      local-timer-stop:
> > > +        description:
> > > +          If present the CPU local timer control logic is lost on state
> > > +          entry, otherwise it is retained.
> > > +        type: boolean
> > > +
> > > +      entry-latency-us:
> > > +        description:
> > > +          Worst case latency in microseconds required to enter the idle state.
> > > +
> > > +      exit-latency-us:
> > > +        description:
> > > +          Worst case latency in microseconds required to exit the idle state.
> > > +          The exit-latency-us duration may be guaranteed only after
> > > +          entry-latency-us has passed.
> > > +
> > > +      min-residency-us:
> > > +        description:
> > > +          Minimum residency duration in microseconds, inclusive of preparation
> > > +          and entry, for this idle state to be considered worthwhile energy
> > > +          wise (refer to section 2 of this document for a complete description).
> > > +
> > > +      wakeup-latency-us:
> > > +        description: |
> > > +          Maximum delay between the signaling of a wake-up event and the CPU
> > > +          being able to execute normal code again. If omitted, this is assumed
> > > +          to be equal to:
> > > +
> > > +            entry-latency-us + exit-latency-us
> > > +
> > > +          It is important to supply this value on systems where the duration
> > > +          of PREP phase (see diagram 1, section 2) is non-neglibigle. In such
> > > +          systems entry-latency-us + exit-latency-us will exceed
> > > +          wakeup-latency-us by this duration.
> > > +
> > > +      idle-state-name:
> > > +        $ref: /schemas/types.yaml#/definitions/string
> > > +        description:
> > > +          A string used as a descriptive name for the idle state.
> > > +
> > > +    required:
> > > +      - compatible
> > > +      - entry-latency-us
> > > +      - exit-latency-us
> > > +      - min-residency-us
> > > +
> > > +additionalProperties: false
>
> I will move this up.

TBC, you need this at 2 levels. Both the idle-states node and child nodes.

Rob
