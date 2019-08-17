Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E1E79912AD
	for <lists+linux-pm@lfdr.de>; Sat, 17 Aug 2019 21:25:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726089AbfHQTZv (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 17 Aug 2019 15:25:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:47570 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725929AbfHQTZu (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sat, 17 Aug 2019 15:25:50 -0400
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DCC2121773;
        Sat, 17 Aug 2019 19:25:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566069950;
        bh=0NanKliApozmuL7V6nL8uKH5LTiliTZ9hOPreXVS068=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=bgGST+iX4UmnS3RqbOu/FfRSnf0c7+mYCCB8xVHjEcod3//fj+6o2zG1MpR2/BmIF
         wQgcm5O3WBckm7FwnV0gomnJn/VVVXFl/zHj2WWkecLSu901qGNgM7znj7t4gDjMEx
         ihM+ds/w+EeZDUEPWQqQH/13p80Go2CjQigV0YE0=
Received: by mail-qk1-f178.google.com with SMTP id m10so7619127qkk.1;
        Sat, 17 Aug 2019 12:25:49 -0700 (PDT)
X-Gm-Message-State: APjAAAVM193W5zvF+74UATNxRYAo8cYYAiTyj5bRv1WdvYwDLSC0/0ds
        setRVhg6U1zJf36nx9uAgVI0xxyEx518GARHow==
X-Google-Smtp-Source: APXvYqyv7XInpncxlHnUpAoRjR6KiBVMpFQYJtiz5LwyqLgNtnlZCWotwsrOV9MPpCCDbso+5ciSPlsOWp3IGl53e/A=
X-Received: by 2002:a37:d8f:: with SMTP id 137mr13539239qkn.254.1566069949063;
 Sat, 17 Aug 2019 12:25:49 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1564091601.git.amit.kucheria@linaro.org>
 <72bce036fa8cba3db6e5ba82249837ee46e9c077.1564091601.git.amit.kucheria@linaro.org>
 <20190816213648.GA10244@bogus> <CAP245DVUKRxvU3wWygOFtZuwbvCxfW=wUH=xArOKmYiRZf+EXA@mail.gmail.com>
In-Reply-To: <CAP245DVUKRxvU3wWygOFtZuwbvCxfW=wUH=xArOKmYiRZf+EXA@mail.gmail.com>
From:   Rob Herring <robh@kernel.org>
Date:   Sat, 17 Aug 2019 14:25:36 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+bymJXY-ffeuCc-15Vkmh88AsUAj5znBN+b-3YWP-Kqg@mail.gmail.com>
Message-ID: <CAL_Jsq+bymJXY-ffeuCc-15Vkmh88AsUAj5znBN+b-3YWP-Kqg@mail.gmail.com>
Subject: Re: [PATCH 07/15] dt: thermal: tsens: Document interrupt support in
 tsens driver
To:     Amit Kucheria <amit.kucheria@linaro.org>
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

On Fri, Aug 16, 2019 at 5:02 PM Amit Kucheria <amit.kucheria@linaro.org> wrote:
>
> On Sat, Aug 17, 2019 at 3:06 AM Rob Herring <robh@kernel.org> wrote:
> >
> > On Fri, Jul 26, 2019 at 03:48:42AM +0530, Amit Kucheria wrote:
> > > Define two new required properties to define interrupts and
> > > interrupt-names for tsens.
> > >
> > > Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
> > > ---
> > >  Documentation/devicetree/bindings/thermal/qcom-tsens.txt | 5 +++++
> > >  1 file changed, 5 insertions(+)
> > >
> > > diff --git a/Documentation/devicetree/bindings/thermal/qcom-tsens.txt b/Documentation/devicetree/bindings/thermal/qcom-tsens.txt
> > > index 673cc1831ee9..3d3dd5dc6d36 100644
> > > --- a/Documentation/devicetree/bindings/thermal/qcom-tsens.txt
> > > +++ b/Documentation/devicetree/bindings/thermal/qcom-tsens.txt
> > > @@ -22,6 +22,8 @@ Required properties:
> > >
> > >  - #thermal-sensor-cells : Should be 1. See ./thermal.txt for a description.
> > >  - #qcom,sensors: Number of sensors in tsens block
> > > +- interrupts: Interrupts generated from Always-On subsystem (AOSS)
> > > +- interrupt-names: The name of the interrupt e.g. "tsens0", "tsens1"
> >
> > How many interrupts? A name with just indices isn't too useful.
>
> Depending on the version of the tsens IP, there can be 1 (upper/lower
> threshold), 2 (upper/lower + critical threshold) or 3 (upper/lower +
> critical + zero degree) interrupts. This patch series only introduces
> support for a single interrupt (upper/lower).

I would expect a different compatible for each possibility.

> I used the names tsens0, tsens1 to encapsulate the controller instance
> since some SoCs have 1 controller, others have two. So we'll end up
> with something like the following in DT:

That's not really how *-names is supposed to work. The name is for
identifying what is at each index. Or to put it another way, a driver
should be able to use platform_get_irq_by_name(). So 'critical',
'zero' and something for the first one.

> tsens0: thermal-sensor@c263000 {
>                         compatible = "qcom,sdm845-tsens", "qcom,tsens-v2";
>                         reg = <0 0x0c263000 0 0x1ff>, /* TM */
>                               <0 0x0c222000 0 0x1ff>; /* SROT */
>                         #qcom,sensors = <13>;
>                         interrupts = <GIC_SPI 506 IRQ_TYPE_LEVEL_HIGH>,
>                                      <GIC_SPI 508 IRQ_TYPE_LEVEL_HIGH>;
>                         interrupt-names = "tsens0", "tsens0-critical";
>                         #thermal-sensor-cells = <1>;
> };
>
> tsens1: thermal-sensor@c265000 {
>                         compatible = "qcom,sdm845-tsens", "qcom,tsens-v2";
>                         reg = <0 0x0c265000 0 0x1ff>, /* TM */
>                               <0 0x0c223000 0 0x1ff>; /* SROT */
>                         #qcom,sensors = <8>;
>                         interrupts = <GIC_SPI 507 IRQ_TYPE_LEVEL_HIGH>,
>                                      <GIC_SPI 509 IRQ_TYPE_LEVEL_HIGH>;
>                         interrupt-names = "tsens1", "tsens1-critical";
>                         #thermal-sensor-cells = <1>;
> }
>
> Does that work?
>
> Regards,
> Amit
>
> > >  - Refer to Documentation/devicetree/bindings/nvmem/nvmem.txt to know how to specify
> > >  nvmem cells
> > >
> > > @@ -40,6 +42,9 @@ tsens0: thermal-sensor@c263000 {
> > >               reg = <0xc263000 0x1ff>, /* TM */
> > >                       <0xc222000 0x1ff>; /* SROT */
> > >               #qcom,sensors = <13>;
> > > +             interrupts = <GIC_SPI 506 IRQ_TYPE_LEVEL_HIGH>;
> > > +             interrupt-names = "tsens0";
> > > +
> > >               #thermal-sensor-cells = <1>;
> > >       };
> > >
> > > --
> > > 2.17.1
> > >
