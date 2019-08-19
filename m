Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B3A6091D92
	for <lists+linux-pm@lfdr.de>; Mon, 19 Aug 2019 09:10:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726677AbfHSHKa (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 19 Aug 2019 03:10:30 -0400
Received: from mail-vs1-f68.google.com ([209.85.217.68]:42778 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726211AbfHSHK0 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 19 Aug 2019 03:10:26 -0400
Received: by mail-vs1-f68.google.com with SMTP id b187so522443vsc.9
        for <linux-pm@vger.kernel.org>; Mon, 19 Aug 2019 00:10:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=y8m3DvKUVQn6N1HW0gIQQ7gYIdKX67/oqlvKN4V7k4g=;
        b=jvyr15lA21Gvj4GxmkpqfAs4cs8toEwumYAI5Ol1FCuRGLqSlPz7Mms3ar2WAZPXB7
         VFrfZY71I0tDrKSd9mnQXL+xgzGvJv6pcWczggTeiMURjlba3lyn27n+rL/6lYdUf6FW
         nV9CYw8nSY2nYfw4Ogx98BixH2z/KKzie18FdS9HrbR76GbI3qqWEvPP/2L8JXg30e0y
         j9RqJQ7efJJPJSlKMZaP7CarkNDd/Pr837CAzo97JCNqNVseQFI/2pRrOqJq4UaowVQg
         NFtn8HbfBJ3OPNBmWRC5Etm7p9qYAzeKvmuTc5IXfggdwzqvVppSootMavqklZnPfPYu
         5cAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=y8m3DvKUVQn6N1HW0gIQQ7gYIdKX67/oqlvKN4V7k4g=;
        b=k1CAH2Z4nj2FJxa0yag6MOzWWMwdubyqvaC+yaEKg9PyUQTbGE0q1gGxMZ7UuQGsqr
         dHTNewi1ZUW9mnZjq+C6RmPlZWTPHjCct/7amgZ/0Qq4t3+snBd6E1ACEKy9F4Yz5TzM
         UlR7BSh60s0nhMklI9ZlfyH3/cvzeV/XNFJhu/hQLIs7DqRLI/mbM+EWzXSG2Wp68rxc
         +RneljKawbCggQ3kZpqC5Vu1k5r8LW7J6lVexBIn6AmoH8LKqk50fyxE42p1KL+GdH4j
         qdXdbLlNeqZ4pNW77abzvp0FwVysmRFlfN6W9EAm8imp7EANmfdPIK8QCFMZdz5euNYr
         ztLA==
X-Gm-Message-State: APjAAAVBSim0UBlMqmLiObyhKwcgyNbzfp6AJRGYUQDCa5fuAFMNJwBE
        lTBuW6g9g5CKqOkTubl44LhHo9i2eKx9RM9HANcMfg==
X-Google-Smtp-Source: APXvYqyo1QVfevP+pCL/x/t+F+qbPKOXd5mdJAlBG/8ol+QP2NTLeVb51tMsUI3hIwZTYTfKhFA/cIJmmmFhZ4bwWJk=
X-Received: by 2002:a67:e181:: with SMTP id e1mr11761262vsl.159.1566198624539;
 Mon, 19 Aug 2019 00:10:24 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1564091601.git.amit.kucheria@linaro.org>
 <72bce036fa8cba3db6e5ba82249837ee46e9c077.1564091601.git.amit.kucheria@linaro.org>
 <20190816213648.GA10244@bogus> <CAP245DVUKRxvU3wWygOFtZuwbvCxfW=wUH=xArOKmYiRZf+EXA@mail.gmail.com>
 <CAL_Jsq+bymJXY-ffeuCc-15Vkmh88AsUAj5znBN+b-3YWP-Kqg@mail.gmail.com>
In-Reply-To: <CAL_Jsq+bymJXY-ffeuCc-15Vkmh88AsUAj5znBN+b-3YWP-Kqg@mail.gmail.com>
From:   Amit Kucheria <amit.kucheria@linaro.org>
Date:   Mon, 19 Aug 2019 12:40:13 +0530
Message-ID: <CAHLCerN6uOijzj4skWSRhNr+dSPZ6ysXV5AQjuY9tpa7ndbMUw@mail.gmail.com>
Subject: Re: [PATCH 07/15] dt: thermal: tsens: Document interrupt support in
 tsens driver
To:     Rob Herring <robh@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Eduardo Valentin <edubezval@gmail.com>,
        Andy Gross <andy.gross@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Linux PM list <linux-pm@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sun, Aug 18, 2019 at 12:55 AM Rob Herring <robh@kernel.org> wrote:
>
> On Fri, Aug 16, 2019 at 5:02 PM Amit Kucheria <amit.kucheria@linaro.org> wrote:
> >
> > On Sat, Aug 17, 2019 at 3:06 AM Rob Herring <robh@kernel.org> wrote:
> > >
> > > On Fri, Jul 26, 2019 at 03:48:42AM +0530, Amit Kucheria wrote:
> > > > Define two new required properties to define interrupts and
> > > > interrupt-names for tsens.
> > > >
> > > > Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
> > > > ---
> > > >  Documentation/devicetree/bindings/thermal/qcom-tsens.txt | 5 +++++
> > > >  1 file changed, 5 insertions(+)
> > > >
> > > > diff --git a/Documentation/devicetree/bindings/thermal/qcom-tsens.txt b/Documentation/devicetree/bindings/thermal/qcom-tsens.txt
> > > > index 673cc1831ee9..3d3dd5dc6d36 100644
> > > > --- a/Documentation/devicetree/bindings/thermal/qcom-tsens.txt
> > > > +++ b/Documentation/devicetree/bindings/thermal/qcom-tsens.txt
> > > > @@ -22,6 +22,8 @@ Required properties:
> > > >
> > > >  - #thermal-sensor-cells : Should be 1. See ./thermal.txt for a description.
> > > >  - #qcom,sensors: Number of sensors in tsens block
> > > > +- interrupts: Interrupts generated from Always-On subsystem (AOSS)
> > > > +- interrupt-names: The name of the interrupt e.g. "tsens0", "tsens1"
> > >
> > > How many interrupts? A name with just indices isn't too useful.
> >
> > Depending on the version of the tsens IP, there can be 1 (upper/lower
> > threshold), 2 (upper/lower + critical threshold) or 3 (upper/lower +
> > critical + zero degree) interrupts. This patch series only introduces
> > support for a single interrupt (upper/lower).
>
> I would expect a different compatible for each possibility.

We're currently using the 'qcom,tsens-v1' and 'qcom,tsens-v2'
compatibles to broadly capture the feature (and register map)
differences.

By defining the following, I should be able to check at runtime (using
platform_get_irq_by_name() as suggested) if a particular interrupt
type is available on the platform, no? So do we really require three
different compatibles?

    interrupt-names = "uplow", "crit", "cold"

[1] Respin of older SoC with a newer version of IP

> > I used the names tsens0, tsens1 to encapsulate the controller instance
> > since some SoCs have 1 controller, others have two. So we'll end up
> > with something like the following in DT:
>
> That's not really how *-names is supposed to work. The name is for
> identifying what is at each index. Or to put it another way, a driver
> should be able to use platform_get_irq_by_name(). So 'critical',
> 'zero' and something for the first one.

Fair point. I'll rework it to use "uplow", "crit" and "cold" or
something to the effect.

Is there another way I get the controller instance index in the name
in /proc/interrupts?

> > tsens0: thermal-sensor@c263000 {
> >                         compatible = "qcom,sdm845-tsens", "qcom,tsens-v2";
> >                         reg = <0 0x0c263000 0 0x1ff>, /* TM */
> >                               <0 0x0c222000 0 0x1ff>; /* SROT */
> >                         #qcom,sensors = <13>;
> >                         interrupts = <GIC_SPI 506 IRQ_TYPE_LEVEL_HIGH>,
> >                                      <GIC_SPI 508 IRQ_TYPE_LEVEL_HIGH>;
> >                         interrupt-names = "tsens0", "tsens0-critical";
> >                         #thermal-sensor-cells = <1>;
> > };
> >
> > tsens1: thermal-sensor@c265000 {
> >                         compatible = "qcom,sdm845-tsens", "qcom,tsens-v2";
> >                         reg = <0 0x0c265000 0 0x1ff>, /* TM */
> >                               <0 0x0c223000 0 0x1ff>; /* SROT */
> >                         #qcom,sensors = <8>;
> >                         interrupts = <GIC_SPI 507 IRQ_TYPE_LEVEL_HIGH>,
> >                                      <GIC_SPI 509 IRQ_TYPE_LEVEL_HIGH>;
> >                         interrupt-names = "tsens1", "tsens1-critical";
> >                         #thermal-sensor-cells = <1>;
> > }
> >
> > Does that work?
> >
> > Regards,
> > Amit
> >
> > > >  - Refer to Documentation/devicetree/bindings/nvmem/nvmem.txt to know how to specify
> > > >  nvmem cells
> > > >
> > > > @@ -40,6 +42,9 @@ tsens0: thermal-sensor@c263000 {
> > > >               reg = <0xc263000 0x1ff>, /* TM */
> > > >                       <0xc222000 0x1ff>; /* SROT */
> > > >               #qcom,sensors = <13>;
> > > > +             interrupts = <GIC_SPI 506 IRQ_TYPE_LEVEL_HIGH>;
> > > > +             interrupt-names = "tsens0";
> > > > +
> > > >               #thermal-sensor-cells = <1>;
> > > >       };
> > > >
> > > > --
> > > > 2.17.1
> > > >
