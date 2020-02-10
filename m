Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5E02315792B
	for <lists+linux-pm@lfdr.de>; Mon, 10 Feb 2020 14:13:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727836AbgBJNNK (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 10 Feb 2020 08:13:10 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:40920 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730732AbgBJNNJ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 10 Feb 2020 08:13:09 -0500
Received: by mail-lj1-f196.google.com with SMTP id n18so7071680ljo.7
        for <linux-pm@vger.kernel.org>; Mon, 10 Feb 2020 05:13:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OW7a6sFO2Iqv10j6Lrm9vfeuEckoEH9rsnAFekhcXZ4=;
        b=Xl9RTe3eBD6wMc4vG5QTCpt/zeyykjk96CyAlj4kBN2T7mEH+Q6bUywzN2mWBIzF56
         /wN4KQWXHJGtTcO/3i5dMzX0mjYCdJ6A89h2Q+g2D+ce/u4z/peOkdZmDDw19aoymXfF
         9w/d7vdCJaHPitDl68u/m0TtZwyVl31MtFjWV7g6MoLhiGvZ/6/rjhDaYtdmB9S1KMzd
         2wsJk2MteEVGP3h3D1eM2OyaIz5nYGz4UAteuPExApGbYR5KvmBcq5UHZ7eLOl6mYxeC
         IingSG0GeZdr8h2zXBxd9h1ASzumrOlLOsg4TTKmu2CL+jZ9JQMGhLJBOIlXvzYG3ZG4
         TF7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OW7a6sFO2Iqv10j6Lrm9vfeuEckoEH9rsnAFekhcXZ4=;
        b=AjWv6lfmxHpJa6+wALA/rdxxQIwGjIbf+f2WFMyOuTJrXL+PJtekpNVUEFQtu2USNe
         P/mACwk/AU6YlDeuOgbIk0/bzYMvqikeohOxTbZpIUKaBj24J/6saDkX5/+k1rxDaoVQ
         AVZPvKfgStkNBj7LjfNH/kKOuMzChHW2LhXpY4YS3J6gfDzt/KzyTyJkkvEvt6pubRol
         7Iw5cKbxrVudGU580ZmlXg6k1wM216oyUMYj9r68kygesErYvu4o5Uajxyg/H60lf2UO
         K/yQgrai3mblaGDZ92iGZzY1Mg510tU7GG16wZI1jtop58XvdKdWr1wIdLfMAwDjWOtY
         1GkA==
X-Gm-Message-State: APjAAAXMfhAAjg3pcPLcWW+9wmDLCzQKnP7dOE4BHzZxtQicLWjFaTqI
        CWTlDBH1C6JIkKJG13G9m54zcxfMCovytC1UHbfrkKm9oXo=
X-Google-Smtp-Source: APXvYqyqFAwdkMFg3ysvCO6zj/hGx0EcCiuEehH7lrqyRelVl56YcATuj3ZDmJ9Rr5sKXDsttop3K5UBLHQgpLvaOfQ=
X-Received: by 2002:a2e:b6ce:: with SMTP id m14mr836003ljo.99.1581340387514;
 Mon, 10 Feb 2020 05:13:07 -0800 (PST)
MIME-Version: 1.0
References: <20190125110600.GA29332@localhost.localdomain> <CACRpkdYTCgXo8FeitEfRujeWdshnsR3Kn57cKUZsA3CsZ5Cnrw@mail.gmail.com>
 <20190128135354.GA4156@localhost.localdomain> <CACRpkdZDOJJ6qSS8fkqQsgmchDWATfhTP=TZATwt6-Z_WQXpJQ@mail.gmail.com>
 <bf72c35353dc2442794ab5cf19c7074abaccea9d.camel@fi.rohmeurope.com>
In-Reply-To: <bf72c35353dc2442794ab5cf19c7074abaccea9d.camel@fi.rohmeurope.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 10 Feb 2020 14:12:56 +0100
Message-ID: <CACRpkdaxJ-xM4Tak=C1Y_e9xy1KK21v93fhtUdh+TH=-Nx30zg@mail.gmail.com>
Subject: Re: [RFC PATCH v2 09/10] power: supply: Initial support for ROHM
 BD70528 PMIC charger block
To:     "Vaittinen, Matti" <Matti.Vaittinen@fi.rohmeurope.com>
Cc:     "sre@kernel.org" <sre@kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Feb 6, 2020 at 8:54 AM Vaittinen, Matti
<Matti.Vaittinen@fi.rohmeurope.com> wrote:

> I started working for a driver for ROHM BD99954 charger chip and ended
> up writing the linear range code once again. And that reminded me of
> this year old discussion :)

OK!

> > They all seem to have trickle and fast charging, USB phy
> > interaction and AC plug interaction of some kind for detecting
> > those and in some cases temperature detection directly
> > or using an ADC.
>
> Yes. That's pretty much what these ROHM chips have. But SW mostly needs
> to set the limit values - it does not need to participate in state
> changing and most of these things are also something users do not care
> (I guess). Fuel gauging is other topic but I'm not planning to
> implement it for in-tree drivers at least for now :/
>
> The thing that comes to (my) mind is just a common DT properties for
> input current/voltage limits, battery voltages for switching to next
> charging state, current values for different charging states - and
> parsing of these properties.
>
> I've seen some comments about DT not being a good place for battery
> specific properties as batteries may be replaced with another having
> different type - but I don't think this is valid problem for many of
> the devices today. Of course some devices may have batteries that can
> be changed - but many don't - and for those it is perfectly Ok to have
> battery data defined in DT, right?

If something is a property of the charging circuit, then it can be derived
from the compatible value, so anything that is just peculiar for this
chip version doesn't go into device tree, just use a custom struct and
the match data for that.

Then we have the battery. I suppose that could be defined as a DT
node for the battery itself, and not as part of the charging IC, and we
should think about how to create a battery DT binding. What
characteristics are chargers really interested in? This could be some
work.

If different devices have different batteries then the boot loader
could ideally patch the DT with the right battery. This was the solution
advocated for devices with different display panels, to a question
from Hans de Goede at one point IIRC.

> But ... do we need to provide a way for user-space to configure these
> settings instead of the DT? Or any other possible sources for this
> information?

What we usually have said is that "policy should be in userspace"
and "kernel manages hardware". This creates a not-so-small
grey area in between and it is unfortunately up to interpretation.

Today there is also a THIRD alternative, and that is to let
userspace insert a policy using a BPF program. This is the
approach taken by the network and tracing stacks and we look at
more applications. If the kernel needs to be able to handle charging
and emergencies even if userspace is not up or available, this or other
userspace policies are not viable.

I have a strong feeling that it should be a battery node in the device
tree.

> Hmm. If changing means state changes - then these ROHM chips probably
> play no role here as there the HW does most of the state changes
> autonomously. (AFAIR, it's been a while since I looked at the other but
> BD99954).

Good it's a simpler hardware. We just need to think about making
the code reusable.

> So ... If I extract the linear_range code from BD70528 driver (it
> should be usable for the BD99954 as such) - should I place it to some
> common header/lib? (This is plain integer math so I don't like the
> idea of placing it in fixp-arith.h).

Start with moving it to some separate file, like
power_supply_interpolation.c that we just always compile in
and we can take it from there.

Just some thoughts...

Yours,
Linus Walleij
