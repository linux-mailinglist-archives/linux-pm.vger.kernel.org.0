Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D2A37158FA4
	for <lists+linux-pm@lfdr.de>; Tue, 11 Feb 2020 14:15:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729039AbgBKNPf (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 11 Feb 2020 08:15:35 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:43631 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728963AbgBKNPf (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 11 Feb 2020 08:15:35 -0500
Received: by mail-lj1-f194.google.com with SMTP id a13so11495709ljm.10
        for <linux-pm@vger.kernel.org>; Tue, 11 Feb 2020 05:15:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nSixIdUnQ9pBhja9qbYq/tFzt40ONObf7sWhFe7afJM=;
        b=sYPXv5To1/77EKk44FsgiTY83c5KX2/Qqci5RGcC3LORWLJra8fI23I4AE9aTcwKvD
         raA5nntOuIC3NidaltTTXTjNep1XjXpAzJkZZ4Ar2iFcOi8ifdO8QKNh12HOZAOytQvg
         qHc4H6BCJ0n+udEDDSsj9I46W/FYDrmyu5mgWHyZoEqHiZMOUQBGVpgEIuS55P/ktSga
         +cKXEa50EBBG65iW0YgXki2WPghke0OooxqE4C/3KSrwZOTWtYe+bXvOJLtn7lZeKRET
         9S339gyjjMDujT/YG6pvirSz5X0McL+O7dGQXZkEDLiqHYYXntTHhRp9rZAFA3OeCh8F
         LThQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nSixIdUnQ9pBhja9qbYq/tFzt40ONObf7sWhFe7afJM=;
        b=GygWQzuWg07wZmXndrzfQlYtNcPxG1ltTO1YrRF5nGMpE/5WUYOMAh16Dt7MSJjbGG
         kr7H+OsgJW+k1m13PdrEZIGMxixCemZ1ab61r0VhtaX7cSnCrNk+OGOdqIdYb7yeh80m
         SJD2tdaWbWKyv3maH3UljLZZr/HUTJfwdlCUOduzKSvYP00yYt1a2GzROWQklP7znvsI
         YD/IRN1QdS9BKrmEjydwijoc4vfHWsAy7NJrJM/CnaBbJQL3aspVxnDPTQxrcYIs1PoO
         8j2dhJqvG+j3L1ffdYZrgERd3OpBPmDeAUU06/QvBJSDQLSAtgL5VPNb0IhN6FyXSP6t
         MM6g==
X-Gm-Message-State: APjAAAVDH4jFZpCMqNPI51Qm/drNoUIWk03lu+OSdvUG6SHWhNHfqAqM
        2lIzya/NGKlzevBOqid0SUDuGcyrt5Ge8HTjmD2fdg==
X-Google-Smtp-Source: APXvYqx1ZqmRjHhhId+NaZHK8pjA+MKf/sxviMRxelxEaPtGfVSliJSthau5DRnK1XLjm9tCBIGx3RQB9lGwIJIgTSE=
X-Received: by 2002:a2e:9013:: with SMTP id h19mr4360321ljg.223.1581426933526;
 Tue, 11 Feb 2020 05:15:33 -0800 (PST)
MIME-Version: 1.0
References: <20190125110600.GA29332@localhost.localdomain> <CACRpkdYTCgXo8FeitEfRujeWdshnsR3Kn57cKUZsA3CsZ5Cnrw@mail.gmail.com>
 <20190128135354.GA4156@localhost.localdomain> <CACRpkdZDOJJ6qSS8fkqQsgmchDWATfhTP=TZATwt6-Z_WQXpJQ@mail.gmail.com>
 <bf72c35353dc2442794ab5cf19c7074abaccea9d.camel@fi.rohmeurope.com>
 <CACRpkdaxJ-xM4Tak=C1Y_e9xy1KK21v93fhtUdh+TH=-Nx30zg@mail.gmail.com> <17e9b06aa05b81e22a37c198d59f76d362e288ea.camel@fi.rohmeurope.com>
In-Reply-To: <17e9b06aa05b81e22a37c198d59f76d362e288ea.camel@fi.rohmeurope.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 11 Feb 2020 14:15:22 +0100
Message-ID: <CACRpkdbr3HCeX4_0x2EHtT7skphHFwk=eP4zuQqArN4RNaaXVQ@mail.gmail.com>
Subject: Re: [RFC PATCH v2 09/10] power: supply: Initial support for ROHM
 BD70528 PMIC charger block
To:     "Vaittinen, Matti" <Matti.Vaittinen@fi.rohmeurope.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>
Cc:     "hdegoede@redhat.com" <hdegoede@redhat.com>,
        "sre@kernel.org" <sre@kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Feb 10, 2020 at 3:03 PM Vaittinen, Matti
<Matti.Vaittinen@fi.rohmeurope.com> wrote:
> On Mon, 2020-02-10 at 14:12 +0100, Linus Walleij wrote:

> > If different devices have different batteries then the boot loader
> > could ideally patch the DT with the right battery. This was the
> > solution
> > advocated for devices with different display panels, to a question
> > from Hans de Goede at one point IIRC.
>
> Hmm. This sounds simpler than adding bunch of charger drivers in boot
> loader. OTOH, if boot loader can detect the type of the battery, then I
> see why linux couldn't? And if type of battery can be hard-coded in
> boot, then I don't see why it couldn't be hard-coded in DT. But this
> all goes far beyond my area of expertice ;)

It's a gray area.

The boot loader, as well as the kernel, can detect the presence of
some specific battery and screen using e.g. probing with i2c
addresses or by reading GPIO lines or some other magic number
such as the serial number of the device.

The kernel does have similar code in some places. Also the
function where we enter is module is deceptively named "probe()".

So at some point it was common practice for the kernel to do this.

After the introduction of device tree, there has been some pushback
from boot architecture people (this is the name for people doing
thinking around DT, ACPI, UEFI and U-Boot) that this kind of funny
probing code should be done in the boot loader, then the boot loader
need to figure out how the device tree should actually look, construct
it and pass the result to the kernel. This works for anything that
detectable and not hot-plugged.

As we are in parallel, especially on the ARM architectures, pushing
a "single kernel image" concept this makes a lot of sense, so we
keep down the number of funny probing code in that single kernel
image.

Maybe we should actually write this up somewhere. (Or it is already?)
I only picked the above up from misc conversations.

Yours,
Linus Walleij
