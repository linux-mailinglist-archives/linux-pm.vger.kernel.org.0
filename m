Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F3AAA90AA6
	for <lists+linux-pm@lfdr.de>; Sat, 17 Aug 2019 00:02:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727734AbfHPWCV (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 16 Aug 2019 18:02:21 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:42799 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727732AbfHPWCV (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 16 Aug 2019 18:02:21 -0400
Received: by mail-qk1-f196.google.com with SMTP id 201so5947532qkm.9
        for <linux-pm@vger.kernel.org>; Fri, 16 Aug 2019 15:02:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cIdFGwAFSrX7ZRwqgTTFqmzXANmZBCVeaNYXvQ0ZoyU=;
        b=dUJONrVPTpPrPScArOmcSXk2K3n6gMPUME0lg/JAo05DH5KjPKEObft+IvMnsF54PC
         cdlSN+TqqDKcX8H/y0wGj7aYiFj5o+97V7xlnGGJjySN8HgwdAFlhcdn+RzcwrpAj3oE
         6f37nXrGs5jWjp2vUtdD8Erckv9FzWgr1b192uQujyK171boGIJ98LdDYXsi+rOSnEwg
         aNh5aLncqA3uQ4PD29IYKUMqA45Sji2ad3iGhgDEVIKSYSlJD+0sdJUXgbIAWg1XZCdt
         jmtv16rt6wEphtlRbGW8D5coFLmUKNj0lGwCTQfJ5Qqp9/yXMHi5TIcUF/fOtu8M8JTO
         bjiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cIdFGwAFSrX7ZRwqgTTFqmzXANmZBCVeaNYXvQ0ZoyU=;
        b=GNb3D8Mr6c62LwWWyaOaGJn8wug8+Li1LdHRKKfm6kl5VX4kDlru9oQO3Lb0a/VNsA
         DmM8t5IILBz6WfOer4+V1Sj/6vZ8AgPe7Us/APe77hD/f0fAVAmong7AMdrbrVHnSJnP
         SwyjJc7ubjAVtddJnCM9ua+HutY2ZZLBmKYSZQoyrLkVhFtK6Ilz/zTObrvzp1qQYDj4
         2XGpQACfI7CavE2329N6grRgYJ6NkRjQpCRAtqJXWM4UAS1PF4JsPIQqWNNDJnknHby9
         2168wzYQH+ghtSpvbhPsvXIz/sJ/WuHZY5mGLrnLpWFX/UodLT9JkqQqU5B1H/jLFibe
         ZRsg==
X-Gm-Message-State: APjAAAWSCjrCdekpyVorZryy3oHtJHbSqZiz8RLyWO6d0BfBH3V4bWVd
        jxVrhEffC3KhUi0a19Q0GaheydOkLuZFejKqL7ejqA==
X-Google-Smtp-Source: APXvYqypnd3g6pObymvX1ggP+t1mK2WV/HTF38MOuIt/cN09z3g8TKh79RVWmSC6hH79TdcEYkJ2tm6koOa/IBMyAOw=
X-Received: by 2002:a05:620a:5f7:: with SMTP id z23mr10726778qkg.106.1565992939659;
 Fri, 16 Aug 2019 15:02:19 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1564091601.git.amit.kucheria@linaro.org>
 <72bce036fa8cba3db6e5ba82249837ee46e9c077.1564091601.git.amit.kucheria@linaro.org>
 <20190816213648.GA10244@bogus>
In-Reply-To: <20190816213648.GA10244@bogus>
From:   Amit Kucheria <amit.kucheria@linaro.org>
Date:   Sat, 17 Aug 2019 03:32:08 +0530
Message-ID: <CAP245DVUKRxvU3wWygOFtZuwbvCxfW=wUH=xArOKmYiRZf+EXA@mail.gmail.com>
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

On Sat, Aug 17, 2019 at 3:06 AM Rob Herring <robh@kernel.org> wrote:
>
> On Fri, Jul 26, 2019 at 03:48:42AM +0530, Amit Kucheria wrote:
> > Define two new required properties to define interrupts and
> > interrupt-names for tsens.
> >
> > Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
> > ---
> >  Documentation/devicetree/bindings/thermal/qcom-tsens.txt | 5 +++++
> >  1 file changed, 5 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/thermal/qcom-tsens.txt b/Documentation/devicetree/bindings/thermal/qcom-tsens.txt
> > index 673cc1831ee9..3d3dd5dc6d36 100644
> > --- a/Documentation/devicetree/bindings/thermal/qcom-tsens.txt
> > +++ b/Documentation/devicetree/bindings/thermal/qcom-tsens.txt
> > @@ -22,6 +22,8 @@ Required properties:
> >
> >  - #thermal-sensor-cells : Should be 1. See ./thermal.txt for a description.
> >  - #qcom,sensors: Number of sensors in tsens block
> > +- interrupts: Interrupts generated from Always-On subsystem (AOSS)
> > +- interrupt-names: The name of the interrupt e.g. "tsens0", "tsens1"
>
> How many interrupts? A name with just indices isn't too useful.

Depending on the version of the tsens IP, there can be 1 (upper/lower
threshold), 2 (upper/lower + critical threshold) or 3 (upper/lower +
critical + zero degree) interrupts. This patch series only introduces
support for a single interrupt (upper/lower).

I used the names tsens0, tsens1 to encapsulate the controller instance
since some SoCs have 1 controller, others have two. So we'll end up
with something like the following in DT:

tsens0: thermal-sensor@c263000 {
                        compatible = "qcom,sdm845-tsens", "qcom,tsens-v2";
                        reg = <0 0x0c263000 0 0x1ff>, /* TM */
                              <0 0x0c222000 0 0x1ff>; /* SROT */
                        #qcom,sensors = <13>;
                        interrupts = <GIC_SPI 506 IRQ_TYPE_LEVEL_HIGH>,
                                     <GIC_SPI 508 IRQ_TYPE_LEVEL_HIGH>;
                        interrupt-names = "tsens0", "tsens0-critical";
                        #thermal-sensor-cells = <1>;
};

tsens1: thermal-sensor@c265000 {
                        compatible = "qcom,sdm845-tsens", "qcom,tsens-v2";
                        reg = <0 0x0c265000 0 0x1ff>, /* TM */
                              <0 0x0c223000 0 0x1ff>; /* SROT */
                        #qcom,sensors = <8>;
                        interrupts = <GIC_SPI 507 IRQ_TYPE_LEVEL_HIGH>,
                                     <GIC_SPI 509 IRQ_TYPE_LEVEL_HIGH>;
                        interrupt-names = "tsens1", "tsens1-critical";
                        #thermal-sensor-cells = <1>;
}

Does that work?

Regards,
Amit

> >  - Refer to Documentation/devicetree/bindings/nvmem/nvmem.txt to know how to specify
> >  nvmem cells
> >
> > @@ -40,6 +42,9 @@ tsens0: thermal-sensor@c263000 {
> >               reg = <0xc263000 0x1ff>, /* TM */
> >                       <0xc222000 0x1ff>; /* SROT */
> >               #qcom,sensors = <13>;
> > +             interrupts = <GIC_SPI 506 IRQ_TYPE_LEVEL_HIGH>;
> > +             interrupt-names = "tsens0";
> > +
> >               #thermal-sensor-cells = <1>;
> >       };
> >
> > --
> > 2.17.1
> >
