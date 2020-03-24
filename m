Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 990261913DD
	for <lists+linux-pm@lfdr.de>; Tue, 24 Mar 2020 16:06:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728004AbgCXPGV (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 24 Mar 2020 11:06:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:51268 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727736AbgCXPGV (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 24 Mar 2020 11:06:21 -0400
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2BAC520775;
        Tue, 24 Mar 2020 15:06:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585062380;
        bh=8pIS4vs8NHSn+hwQhqH3u3RNHDcaAGCJDHvJt0tjNa4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=fc+aeEH5arhksV19znprIHLe75k2fAW9cwMJmmeIORp/Pe8rgRiFxpGXCq0aafd0T
         Fvm/XvCFvYRxQBeqWqjjC+JfnLqguSbXh8UhE1TU4rEnzeTDxYbod/sM84Hl92iRlr
         JMstjao+AeVl6QpFGL2frE+DycngLxvZOPG59jqo=
Received: by mail-qk1-f179.google.com with SMTP id k13so7796136qki.2;
        Tue, 24 Mar 2020 08:06:20 -0700 (PDT)
X-Gm-Message-State: ANhLgQ3nWe7ULCSNnoAzpx/XfxCX3iuPJge3LiMzggjfmzGBU1q/6xkO
        GVVsj280NZw84dI0n84bPWC9LAkWNzXW9ZedLQ==
X-Google-Smtp-Source: ADFU+vtg882wc2BN6wL0hT6KIwxPK3ki0huHjsWp/kB5sbJP9A444Ldp1mPmpZWwv6Ts7ombMhx35L3vr0Yc8fv7dGw=
X-Received: by 2002:a37:4a85:: with SMTP id x127mr26564313qka.152.1585062379195;
 Tue, 24 Mar 2020 08:06:19 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1583412540.git.amit.kucheria@linaro.org>
 <8a0cfe9e3018f7996c1563035bee76048941beb4.1583412540.git.amit.kucheria@linaro.org>
 <20200311144933.GA21587@bogus> <CAHLCerN99eKOofxcCuvNwjNGbJfB7BzoPGAPCtXHNQdN9w8Bcw@mail.gmail.com>
 <CAL_JsqJ6T3LVbKueGn53dZmR=caD2AR7yLX9gffmOc9VwF9kXQ@mail.gmail.com> <CAP245DWgg7KsV9sMXmS571dAAy-cvDy4Q_9vi_KGxoOQ5VBU7w@mail.gmail.com>
In-Reply-To: <CAP245DWgg7KsV9sMXmS571dAAy-cvDy4Q_9vi_KGxoOQ5VBU7w@mail.gmail.com>
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 24 Mar 2020 09:06:07 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKhK-yz+iqe6G+-c0pt9mJSsW8hMnTiWdRh3_+1PeG=dg@mail.gmail.com>
Message-ID: <CAL_JsqKhK-yz+iqe6G+-c0pt9mJSsW8hMnTiWdRh3_+1PeG=dg@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] dt-bindings: thermal: Add yaml bindings for
 thermal zones
To:     Amit Kucheria <amit.kucheria@linaro.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Linux PM list <linux-pm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Mar 24, 2020 at 4:33 AM Amit Kucheria <amit.kucheria@linaro.org> wrote:
>
> On Tue, Mar 24, 2020 at 2:46 AM Rob Herring <robh@kernel.org> wrote:
> >
> > On Mon, Mar 23, 2020 at 2:46 PM Amit Kucheria <amit.kucheria@linaro.org> wrote:
> > >
> > > Hi Rob,
> > >
> > > Thanks for the review.
> > >
> > > On Wed, Mar 11, 2020 at 8:19 PM Rob Herring <robh@kernel.org> wrote:
> > > >
> > > > On Thu, Mar 05, 2020 at 06:26:43PM +0530, Amit Kucheria wrote:
> > > > > As part of moving the thermal bindings to YAML, split it up into 3
> > > > > bindings: thermal sensors, cooling devices and thermal zones.
> > > > >
> > > > > The thermal-zone binding is a software abstraction to capture the
> > > > > properties of each zone - how often they should be checked, the
> > > > > temperature thresholds (trips) at which mitigation actions need to be
> > > > > taken and the level of mitigation needed at those thresholds.
> >
>
> [...]
>
> >
> > > > > +            /* ... */
> > > > > +
> > > > > +            gpu-thermal-top {
> > > >
> > > > This one is not going to match (which should cause an error).
> > >
> > > Good catch. Unfortunately, this isn't getting caught. Nor is the
> > > 12-char limitation before -thermal in the thermal zone name. I can't
> > > figure out why.
> >
> > That's because this schema has to be included by another schema which
> > matches on a parent node containing 'thermal-zones'. If
> > 'thermal-zones' can be at the root node, then you should rework this
> > such that you have $nodename: {const: thermal-zones} as a top-level
> > property.
>
> I've done all the change requested in the review(see attached patch),
> including moving to
>
> properties:
>    $nodename:
>        const: thermal-zones
>
> but that generates a bunch of errors similar to:
>
> /home/amit/work/builds/build-aarch64/Documentation/devicetree/bindings/arm/zte.example.dt.yaml:
> /: $nodename:0: 'thermal-zones' was expected
> /home/amit/work/builds/build-aarch64/Documentation/devicetree/bindings/arm/psci.example.dt.yaml:
> /: $nodename:0: 'thermal-zones' was expected
> /home/amit/work/builds/build-aarch64/Documentation/devicetree/bindings/arm/sunxi.example.dt.yaml:
> /: $nodename:0: 'thermal-zones' was expected
> /home/amit/work/builds/build-aarch64/Documentation/devicetree/bindings/arm/sprd/sprd.example.dt.yaml:
> /: $nodename:0: 'thermal-zones' was expected
> /home/amit/work/builds/build-aarch64/Documentation/devicetree/bindings/arm/calxeda.example.dt.yaml:
> /: $nodename:0: 'thermal-zones' was expected
> /home/amit/work/builds/build-aarch64/Documentation/devicetree/bindings/arm/ti/ti,davinci.example.dt.yaml:
> /: $nodename:0: 'thermal-zones' was expected
> /home/amit/work/builds/build-aarch64/Documentation/devicetree/bindings/arm/spear.example.dt.yaml:
> /: $nodename:0: 'thermal-zones' was expected
> /home/amit/work/builds/build-aarch64/Documentation/devicetree/bindings/arm/ti/nspire.example.dt.yaml:
> /: $nodename:0: 'thermal-zones' was expected
>
> It seems like dtc is expecting every node to have a thermal-zones node?
>
> Looking at other root nodes such as cpus.yaml, the main difference I
> noticed was the absence of the "select: true" property. However, if I
> remove that, we go back to the schema not being applied.

'select: true' should be dropped. It will be applied to any
'thermal-zones' nodes. The generated 'select' will use $nodename if
compatible is not present for the schema.

I tested that putting an error in the example works.

> You mentioned that the thermal-zones schema needs to included by
> another schema. What did you mean by that?

Nevermind, I wasn't thinking that it's a top-level node. If it was a
child node, then you'd want to include it from the parent schemas.

Rob
