Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7E29E190021
	for <lists+linux-pm@lfdr.de>; Mon, 23 Mar 2020 22:16:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726971AbgCWVQ2 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 23 Mar 2020 17:16:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:33282 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726203AbgCWVQ1 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 23 Mar 2020 17:16:27 -0400
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E43AD2073E;
        Mon, 23 Mar 2020 21:16:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584998187;
        bh=lAcPaGMeuTbQ0e60tGnw6ov4e5Q5aILJQN/wYj3AAMk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=z5xnYgUgdU2DIBDs8HEZaSJH752225z4W2JUWCZZIukzeTeclguBbUyeCUXDTX9I8
         56K0xXKFuMxB2oxCqLne3IK+sazlamo7gKkDX4NAYNCTIwlU+bNmXO0p1L/aH5bs+1
         CFPOr47ciju93GlG08d1OyFZizI1aN3zdH+eNNxc=
Received: by mail-qt1-f180.google.com with SMTP id f20so13149902qtq.6;
        Mon, 23 Mar 2020 14:16:26 -0700 (PDT)
X-Gm-Message-State: ANhLgQ1+8lGd7B0mnyiOmqvoggfla72NQPnqp9c/0D/Lol8BN2BPjJfy
        lRGWyAiiokq0/hMdw1pIryXDSfx+69F03WXlhg==
X-Google-Smtp-Source: ADFU+vum708OpcpjRaJMVDkorGVUHHFISsRaDWFsZpbGSzR6ZkKzsCsNyMn7et2Npg4zVfxkp3GAuYA09s21/oTFXis=
X-Received: by 2002:aed:3461:: with SMTP id w88mr23486218qtd.143.1584998186039;
 Mon, 23 Mar 2020 14:16:26 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1583412540.git.amit.kucheria@linaro.org>
 <8a0cfe9e3018f7996c1563035bee76048941beb4.1583412540.git.amit.kucheria@linaro.org>
 <20200311144933.GA21587@bogus> <CAHLCerN99eKOofxcCuvNwjNGbJfB7BzoPGAPCtXHNQdN9w8Bcw@mail.gmail.com>
In-Reply-To: <CAHLCerN99eKOofxcCuvNwjNGbJfB7BzoPGAPCtXHNQdN9w8Bcw@mail.gmail.com>
From:   Rob Herring <robh@kernel.org>
Date:   Mon, 23 Mar 2020 15:16:14 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJ6T3LVbKueGn53dZmR=caD2AR7yLX9gffmOc9VwF9kXQ@mail.gmail.com>
Message-ID: <CAL_JsqJ6T3LVbKueGn53dZmR=caD2AR7yLX9gffmOc9VwF9kXQ@mail.gmail.com>
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

On Mon, Mar 23, 2020 at 2:46 PM Amit Kucheria <amit.kucheria@linaro.org> wrote:
>
> Hi Rob,
>
> Thanks for the review.
>
> On Wed, Mar 11, 2020 at 8:19 PM Rob Herring <robh@kernel.org> wrote:
> >
> > On Thu, Mar 05, 2020 at 06:26:43PM +0530, Amit Kucheria wrote:
> > > As part of moving the thermal bindings to YAML, split it up into 3
> > > bindings: thermal sensors, cooling devices and thermal zones.
> > >
> > > The thermal-zone binding is a software abstraction to capture the
> > > properties of each zone - how often they should be checked, the
> > > temperature thresholds (trips) at which mitigation actions need to be
> > > taken and the level of mitigation needed at those thresholds.

[...]

> > > +          trips:
> > > +            type: object
> > > +            description:
> > > +              This node describes a set of points in the temperature domain at
> > > +              which the thermal framework needs to takes action. The actions to
> > > +              be taken are defined in another node called cooling-maps.
> > > +
> > > +            patternProperties:
> > > +              "^[a-zA-Z][a-zA-Z0-9,+\\._]{0,63}$":
> >
> > Drop ',', '+', '.', and ideally '_'. Probably need to add '-'.
>
> Dropping underscore flags a lot of DTs in dtbs_check. Do you want me
> to go fix them or can we live with the underscore. Is there some
> document I should read on why underscore isn't desirable?

Just convention. dtc will warn (with W=2), but we probably should
document that better. Anyways, fine to leave '_' here.


> > > +            /* ... */
> > > +
> > > +            gpu-thermal-top {
> >
> > This one is not going to match (which should cause an error).
>
> Good catch. Unfortunately, this isn't getting caught. Nor is the
> 12-char limitation before -thermal in the thermal zone name. I can't
> figure out why.

That's because this schema has to be included by another schema which
matches on a parent node containing 'thermal-zones'. If
'thermal-zones' can be at the root node, then you should rework this
such that you have $nodename: {const: thermal-zones} as a top-level
property.

Rob
