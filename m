Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB2B234041C
	for <lists+linux-pm@lfdr.de>; Thu, 18 Mar 2021 12:03:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230378AbhCRLCf (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 18 Mar 2021 07:02:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230367AbhCRLCb (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 18 Mar 2021 07:02:31 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C266C06175F
        for <linux-pm@vger.kernel.org>; Thu, 18 Mar 2021 04:02:31 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id x13so5029337wrs.9
        for <linux-pm@vger.kernel.org>; Thu, 18 Mar 2021 04:02:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RaGPtlv7SLOWssA/2OUjy96UMHcyvtNafHHhHgBI9nE=;
        b=neqRkEFXfZtkXLH4oNWGmf98m9VyR+4pLz7ASX4JlNjSA6r6ofaHXscCkatdoeYd5k
         aRfr5v8VAE6CtRo7HZlZ65DmqICPLY8kkVkihKsluSQcGn3SgGUB/o7MUze+ng08Hmv9
         TL7LKIkxU0b33vA6ReNJYCye9qZjTPlI3wONrsLDAiiZddT4kebuRD9d+rRXJYQp2e3B
         PCIM9nQI6rC18zQbFtlhYEKgzxH0gE5q6MWOdX4RtQjHIGKgbWAZnz/v6PX23SyMKBvU
         /hAsigmRLuPntdq+nMH6jHjHw1/VWop6UFemTQ9ap7osnLB+t5QNs8ctn8ORhViD8nUg
         d+uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RaGPtlv7SLOWssA/2OUjy96UMHcyvtNafHHhHgBI9nE=;
        b=BNlAlR+ek6JTwj4zHg7LxWj7K4ADGm7bfCHYK0LxAwJtXLIjw4lWzzImBZkVyKa8oN
         UZ0ZUI5QhJrxefzrLzQ4Ry9tpo82aRKQgLRZRayivX9UeRr8SCOIaN9lk+LRhr10xRFP
         hYyK7ORWtzPhwSQNOXp8FMek5XI5iTYK30x9bV0D8nZit4n+zXzgZJSUfRo1lWOL/SZa
         3ntV21vFN2NAvuPH2G3PAZW48fZCWY4qTtMwqoSafey9fzd0vYjYlifdZJ7PukdwDKnx
         vZtuxItI9Jqrv7nbzs38b5b0svVDkzUDoZN+FTV6DoxqID1H2hBWaLFdRrF5V5QHXC/4
         /aLQ==
X-Gm-Message-State: AOAM533A5A6ci9sM3SSxHdHSPelgndGX5Q/CKj6qt77Q7qUMvtiPL16P
        9xtSfRheqCjp8LsLkcciMENaTB2vXBOsnKKaMNat4w==
X-Google-Smtp-Source: ABdhPJwFsXGsLWhLFOZr4bxCvM8KZC8buTThv4SMuDErXUoXK9GWDjMjklpqTSS37yJlD7sfGHJb4PqkhUXq40SX3e0=
X-Received: by 2002:a05:6000:250:: with SMTP id m16mr9289960wrz.325.1616065349871;
 Thu, 18 Mar 2021 04:02:29 -0700 (PDT)
MIME-Version: 1.0
References: <20210221093758.210981-1-anup.patel@wdc.com> <20210221093758.210981-8-anup.patel@wdc.com>
 <20210305232245.GA820565@robh.at.kernel.org> <CAAhSdy0TwcE17-GJp664of4DV_R+6Q-S_h-N4Sbv9KL4Xofxvg@mail.gmail.com>
 <CAL_JsqKPwND6BGq3gEuMugEnv4TNvM2_DMdB-p-v7qh5NXyPiQ@mail.gmail.com>
In-Reply-To: <CAL_JsqKPwND6BGq3gEuMugEnv4TNvM2_DMdB-p-v7qh5NXyPiQ@mail.gmail.com>
From:   Anup Patel <anup@brainfault.org>
Date:   Thu, 18 Mar 2021 16:32:18 +0530
Message-ID: <CAAhSdy0ex1PjGa+=KgkSYFd+BteH7txJSrRdOhZnetwXaL42hQ@mail.gmail.com>
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
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Mar 16, 2021 at 9:24 PM Rob Herring <robh@kernel.org> wrote:
>
> On Sun, Mar 7, 2021 at 8:18 PM Anup Patel <anup@brainfault.org> wrote:
> >
> > On Sat, Mar 6, 2021 at 4:52 AM Rob Herring <robh@kernel.org> wrote:
> > >
> > > On Sun, Feb 21, 2021 at 03:07:57PM +0530, Anup Patel wrote:
> > > > The RISC-V CPU idle states will be described in DT under the
> > > > /cpus/riscv-idle-states DT node. This patch adds the bindings
> > > > documentation for riscv-idle-states DT nodes and idle state DT
> > > > nodes under it.
> > > >
> > > > Signed-off-by: Anup Patel <anup.patel@wdc.com>
> > > > ---
> > > >  .../bindings/riscv/idle-states.yaml           | 250 ++++++++++++++++++
> > > >  1 file changed, 250 insertions(+)
> > > >  create mode 100644 Documentation/devicetree/bindings/riscv/idle-states.yaml
> > > >
> > > > diff --git a/Documentation/devicetree/bindings/riscv/idle-states.yaml b/Documentation/devicetree/bindings/riscv/idle-states.yaml
> > > > new file mode 100644
> > > > index 000000000000..3eff763fed23
> > > > --- /dev/null
> > > > +++ b/Documentation/devicetree/bindings/riscv/idle-states.yaml
> > > > @@ -0,0 +1,250 @@
> > > > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > > > +%YAML 1.2
> > > > +---
> > > > +$id: http://devicetree.org/schemas/riscv/idle-states.yaml#
> > > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > > +
> > > > +title: RISC-V idle states binding description
> > > > +
> > > > +maintainers:
> > > > +  - Anup Patel <anup.patel@wdc.com>
> > > > +
> > > > +description: |+
> > > > +  RISC-V systems can manage power consumption dynamically, where HARTs
> > > > +  (or CPUs) [1] can be put in different platform specific suspend (or
> > > > +  idle) states (ranging from simple WFI, power gating, etc). The RISC-V
> > > > +  SBI [2] hart state management extension provides a standard mechanism
> > > > +  for OSes to request HART state transitions.
> > > > +
> > > > +  The platform specific suspend (or idle) states of a hart can be either
> > > > +  retentive or non-rententive in nature. A retentive suspend state will
> > > > +  preserve hart register and CSR values for all privilege modes whereas
> > > > +  a non-retentive suspend state will not preserve hart register and CSR
> > > > +  values. The suspend (or idle) state entered by executing the WFI
> > > > +  instruction is considered standard on all RISC-V systems and therefore
> > > > +  must not be listed in device tree.
> > > > +
> > > > +  The device tree binding definition for RISC-V idle states described
> > > > +  in this document is quite similar to the ARM idle states [3].
> > > > +
> > > > +  References
> > > > +
> > > > +  [1] RISC-V Linux Kernel documentation - CPUs bindings
> > > > +      Documentation/devicetree/bindings/riscv/cpus.yaml
> > > > +
> > > > +  [2] RISC-V Supervisor Binary Interface (SBI)
> > > > +      http://github.com/riscv/riscv-sbi-doc/riscv-sbi.adoc
> > > > +
> > > > +  [3] ARM idle states binding description - Idle states bindings
> > > > +      Documentation/devicetree/bindings/arm/idle-states.yaml
> > >
> > > I'd assume there's common parts we can share.
> >
> > Yes, except few properties most are the same.
> >
> > We can have a shared DT bindings for both ARM and RISC-V but
> > both architectures will always have some architecture specific details
> > (or properties) which need to be documented under arch specific
> > DT documentation. Is it okay if this is done as a separate series ?
>
> No...

Okay, I will create a common DT bindings for both ARM and RISC-V
in the next revision.

>
> > > > +
> > > > +properties:
> > > > +  $nodename:
> > > > +    const: riscv-idle-states
> > >
> > > Just 'idle-states' like Arm.
> >
> > I had tried "idle-states" node name but DT bindings check complaints
> > conflict with ARM idle state bindings.
>
> ...and this being one reason why.
>
> Actually, I think this can all be in 1 doc if you want. It's fine with
> me if a common doc has RiscV and Arm specific properties.

Sure, will add common DT bindings.

>
> > > > +
> > > > +patternProperties:
> > > > +  "^(cpu|cluster)-":
> > > > +    type: object
> > > > +    description: |
> > > > +      Each state node represents an idle state description and must be
> > > > +      defined as follows.
> > > > +
> > >
> > >        additionalProperties: false
> >
> > okay, will update.
> >
> > >
> > > > +    properties:
> > > > +      compatible:
> > > > +        const: riscv,idle-state
> > > > +
> > > > +      local-timer-stop:
> > > > +        description:
> > > > +          If present the CPU local timer control logic is lost on state
> > > > +          entry, otherwise it is retained.
> > > > +        type: boolean
> > > > +
> > > > +      entry-latency-us:
> > > > +        description:
> > > > +          Worst case latency in microseconds required to enter the idle state.
> > > > +
> > > > +      exit-latency-us:
> > > > +        description:
> > > > +          Worst case latency in microseconds required to exit the idle state.
> > > > +          The exit-latency-us duration may be guaranteed only after
> > > > +          entry-latency-us has passed.
> > > > +
> > > > +      min-residency-us:
> > > > +        description:
> > > > +          Minimum residency duration in microseconds, inclusive of preparation
> > > > +          and entry, for this idle state to be considered worthwhile energy
> > > > +          wise (refer to section 2 of this document for a complete description).
> > > > +
> > > > +      wakeup-latency-us:
> > > > +        description: |
> > > > +          Maximum delay between the signaling of a wake-up event and the CPU
> > > > +          being able to execute normal code again. If omitted, this is assumed
> > > > +          to be equal to:
> > > > +
> > > > +            entry-latency-us + exit-latency-us
> > > > +
> > > > +          It is important to supply this value on systems where the duration
> > > > +          of PREP phase (see diagram 1, section 2) is non-neglibigle. In such
> > > > +          systems entry-latency-us + exit-latency-us will exceed
> > > > +          wakeup-latency-us by this duration.
> > > > +
> > > > +      idle-state-name:
> > > > +        $ref: /schemas/types.yaml#/definitions/string
> > > > +        description:
> > > > +          A string used as a descriptive name for the idle state.
> > > > +
> > > > +    required:
> > > > +      - compatible
> > > > +      - entry-latency-us
> > > > +      - exit-latency-us
> > > > +      - min-residency-us
> > > > +
> > > > +additionalProperties: false
> >
> > I will move this up.
>
> TBC, you need this at 2 levels. Both the idle-states node and child nodes.

Sure, I will add at both levels.

Regards,
Anup
