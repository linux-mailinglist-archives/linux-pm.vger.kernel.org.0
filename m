Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9A0829244D
	for <lists+linux-pm@lfdr.de>; Mon, 19 Aug 2019 15:08:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727527AbfHSNIN (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 19 Aug 2019 09:08:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:43500 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726987AbfHSNIN (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 19 Aug 2019 09:08:13 -0400
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EE87A2086C;
        Mon, 19 Aug 2019 13:08:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566220092;
        bh=aNdhMw9pTzSNXMvd8zBhzKtZwip3u33guY+/cmKcJHk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=mFYl6u+9PFkdrzCmYHHk3N60eDG+2lCKry7kthtLwvp6wDP4XZwZ7EL6VWz+oaIrQ
         vV2WniF+MyQVZrTrq+aGzW0N5UrsuZw40zv+UQ4t2boGeY/uBSdNXpUzpiBfUG1OI8
         NLXVcH53908hxzvwH/eGLABI+eho3Z9gDBuQWDhs=
Received: by mail-qt1-f172.google.com with SMTP id t12so1754952qtp.9;
        Mon, 19 Aug 2019 06:08:11 -0700 (PDT)
X-Gm-Message-State: APjAAAVA183c/pBfwfWim7eL7FzDxnt+3cRuInWOWEvQgFEz+4yYtpdP
        r2IJ1RttIDZ4sINnCCPpx6KYVcfHnVpO/n6pGw==
X-Google-Smtp-Source: APXvYqxC0s2t9OjgqaT8S7zFTuZn8jGd4550FmIgb/4UW3GjnAooZWmnHahEJ+Jt+Tz6djdh3cqhFFDW+2ThtYjwY00=
X-Received: by 2002:a0c:eb92:: with SMTP id x18mr10632709qvo.39.1566220091056;
 Mon, 19 Aug 2019 06:08:11 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1564091601.git.amit.kucheria@linaro.org>
 <72bce036fa8cba3db6e5ba82249837ee46e9c077.1564091601.git.amit.kucheria@linaro.org>
 <20190816213648.GA10244@bogus> <CAP245DVUKRxvU3wWygOFtZuwbvCxfW=wUH=xArOKmYiRZf+EXA@mail.gmail.com>
 <CAL_Jsq+bymJXY-ffeuCc-15Vkmh88AsUAj5znBN+b-3YWP-Kqg@mail.gmail.com> <CAHLCerN6uOijzj4skWSRhNr+dSPZ6ysXV5AQjuY9tpa7ndbMUw@mail.gmail.com>
In-Reply-To: <CAHLCerN6uOijzj4skWSRhNr+dSPZ6ysXV5AQjuY9tpa7ndbMUw@mail.gmail.com>
From:   Rob Herring <robh@kernel.org>
Date:   Mon, 19 Aug 2019 08:07:58 -0500
X-Gmail-Original-Message-ID: <CAL_JsqL9LXH3qcCc_J-aL3CxO8xyOFEjmYgxPo_Fp+3GQ=tsew@mail.gmail.com>
Message-ID: <CAL_JsqL9LXH3qcCc_J-aL3CxO8xyOFEjmYgxPo_Fp+3GQ=tsew@mail.gmail.com>
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

On Mon, Aug 19, 2019 at 2:10 AM Amit Kucheria <amit.kucheria@linaro.org> wrote:
>
> On Sun, Aug 18, 2019 at 12:55 AM Rob Herring <robh@kernel.org> wrote:
> >
> > On Fri, Aug 16, 2019 at 5:02 PM Amit Kucheria <amit.kucheria@linaro.org> wrote:
> > >
> > > On Sat, Aug 17, 2019 at 3:06 AM Rob Herring <robh@kernel.org> wrote:
> > > >
> > > > On Fri, Jul 26, 2019 at 03:48:42AM +0530, Amit Kucheria wrote:
> > > > > Define two new required properties to define interrupts and
> > > > > interrupt-names for tsens.
> > > > >
> > > > > Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
> > > > > ---
> > > > >  Documentation/devicetree/bindings/thermal/qcom-tsens.txt | 5 +++++
> > > > >  1 file changed, 5 insertions(+)
> > > > >
> > > > > diff --git a/Documentation/devicetree/bindings/thermal/qcom-tsens.txt b/Documentation/devicetree/bindings/thermal/qcom-tsens.txt
> > > > > index 673cc1831ee9..3d3dd5dc6d36 100644
> > > > > --- a/Documentation/devicetree/bindings/thermal/qcom-tsens.txt
> > > > > +++ b/Documentation/devicetree/bindings/thermal/qcom-tsens.txt
> > > > > @@ -22,6 +22,8 @@ Required properties:
> > > > >
> > > > >  - #thermal-sensor-cells : Should be 1. See ./thermal.txt for a description.
> > > > >  - #qcom,sensors: Number of sensors in tsens block
> > > > > +- interrupts: Interrupts generated from Always-On subsystem (AOSS)
> > > > > +- interrupt-names: The name of the interrupt e.g. "tsens0", "tsens1"
> > > >
> > > > How many interrupts? A name with just indices isn't too useful.
> > >
> > > Depending on the version of the tsens IP, there can be 1 (upper/lower
> > > threshold), 2 (upper/lower + critical threshold) or 3 (upper/lower +
> > > critical + zero degree) interrupts. This patch series only introduces
> > > support for a single interrupt (upper/lower).
> >
> > I would expect a different compatible for each possibility.
>
> We're currently using the 'qcom,tsens-v1' and 'qcom,tsens-v2'
> compatibles to broadly capture the feature (and register map)
> differences.
>
> By defining the following, I should be able to check at runtime (using
> platform_get_irq_by_name() as suggested) if a particular interrupt
> type is available on the platform, no? So do we really require three
> different compatibles?

Yes and no. I would assume the SoC specific compatibles would meet
this, but the driver can ignore that and just use
platform_get_irq_by_name() or count the number of interrupts.

>     interrupt-names = "uplow", "crit", "cold"
>
> [1] Respin of older SoC with a newer version of IP
>
> > > I used the names tsens0, tsens1 to encapsulate the controller instance
> > > since some SoCs have 1 controller, others have two. So we'll end up
> > > with something like the following in DT:
> >
> > That's not really how *-names is supposed to work. The name is for
> > identifying what is at each index. Or to put it another way, a driver
> > should be able to use platform_get_irq_by_name(). So 'critical',
> > 'zero' and something for the first one.
>
> Fair point. I'll rework it to use "uplow", "crit" and "cold" or
> something to the effect.
>
> Is there another way I get the controller instance index in the name
> in /proc/interrupts?

Not sure offhand. Add the dev_name() into the IRQ name perhaps.

Rob
