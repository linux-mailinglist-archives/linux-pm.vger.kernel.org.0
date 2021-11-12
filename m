Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6AE544EF48
	for <lists+linux-pm@lfdr.de>; Fri, 12 Nov 2021 23:33:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235209AbhKLWfx (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 12 Nov 2021 17:35:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:49276 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232001AbhKLWfx (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 12 Nov 2021 17:35:53 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id DCF2E60C40;
        Fri, 12 Nov 2021 22:33:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636756381;
        bh=OX37xBMLDPG8GvoVjgJ4HrQGg53P8Am7nW55ykoyfK4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=HiE+kx/Vgayxg3TNfMtjmrCjNnuK7GqZS6BfXW1t2ZPjuloip2uFCc8+BDeUylYqs
         JdVsGYbyVghFAbIqe1AQAX3txZVnIBfuYAhBGhZSd8H89IU4b/Ohhq2wwU5TjKyT6v
         FJolDaNn/MiX1a98JWWCSRLXX9rAIO/lpY3R8vYIiI0f24CDsmLdK/fP5Nzmd0DF4h
         EmptrxcUq8BV5pIu5M+1W+xn0cDCh7MSmEzPUzlAASdv4KQrdpl/fNHLwZXrCM4TpX
         rQ6IEWRpq6qEouyDnvBITfBPLJu1GYXvc+ZNF1F1Vw9n04tApNe3B+m2GQ+q90Nwqz
         JecL+gfguypvg==
Received: by mail-ed1-f52.google.com with SMTP id z21so43389421edb.5;
        Fri, 12 Nov 2021 14:33:01 -0800 (PST)
X-Gm-Message-State: AOAM531vn5qNSioGVTSx0W0iOANkM+0ec7hIS8rz6WC4k6KTowVu9BF2
        yBAix1qhfORlhwkUuFJjnpMr3eYXauHzhMMKYw==
X-Google-Smtp-Source: ABdhPJzYtFgbgVcfR/gubaTS3HjlLwGDbw/fwwNn3/rDqET7xynxk0C8qtNQYMPpdSGKsaU35/nKQ0EBHb3wDkORNLY=
X-Received: by 2002:a17:907:7f25:: with SMTP id qf37mr23908790ejc.147.1636756380319;
 Fri, 12 Nov 2021 14:33:00 -0800 (PST)
MIME-Version: 1.0
References: <20211102152207.11891-1-zajec5@gmail.com> <CAL_JsqL5qJZz8K7330cOhV8x86097LUE7oFNx5Qu3M4XLL+gMg@mail.gmail.com>
 <8f02af47-d9dc-a29d-b839-e10969a448d0@gmail.com>
In-Reply-To: <8f02af47-d9dc-a29d-b839-e10969a448d0@gmail.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Fri, 12 Nov 2021 16:32:48 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJB+KneifCaybF7ng0KuwbLgtYk3UMKjkFNOL5Bj8U2pg@mail.gmail.com>
Message-ID: <CAL_JsqJB+KneifCaybF7ng0KuwbLgtYk3UMKjkFNOL5Bj8U2pg@mail.gmail.com>
Subject: Re: [PATCH RFC 0/3] reset: syscon-reboot: add "reg" property support
To:     =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Cc:     Sebastian Reichel <sre@kernel.org>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        devicetree@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "maintainer:BROADCOM BCM7XXX ARM ARCHITECTURE" 
        <bcm-kernel-feedback-list@broadcom.com>,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Nov 12, 2021 at 4:23 PM Rafa=C5=82 Mi=C5=82ecki <zajec5@gmail.com> =
wrote:
>
> On 12.11.2021 23:18, Rob Herring wrote:
> > On Tue, Nov 2, 2021 at 10:22 AM Rafa=C5=82 Mi=C5=82ecki <zajec5@gmail.c=
om> wrote:
> >>
> >> From: Rafa=C5=82 Mi=C5=82ecki <rafal@milecki.pl>
> >>
> >> During my work on MFD binding for Broadcom's TWD block I received
> >> comment from Rob saying that "syscon-reboot" should use "reg" property=
.
> >> I'm not sure if my understanding & implementation are correct so I'm
> >> sending this RFC.
> >>
> >> What bothers me is non-standard "reg" property usage. Treating it as a
> >> simple (unsigned) integer number means different logic when it comes t=
o
> >> ranges.
> >
> > It shouldn't be. The idea is that 'reg' works like normal. See below.
> >
> >> Consider this example:
> >>
> >> timer@400 {
> >>          compatible =3D "simple-mfd", "syscon";
> >>          reg =3D <0x400 0x3c>;
> >>          ranges;
> >
> > ranges =3D <0 0x400 0x100>; // Just guessing for size
> >
> >>
> >>          #address-cells =3D <1>;
> >>          #size-cells =3D <1>;
> >>
> >>          reboot@434 {
> >
> > reboot@34
> >
> > Just reading 'reg' is fine, but really, Linux should be either getting
> > the translated address or have a function to get the offset from the
> > parent base. IOW, it should also work if you just changed 'reg' to
> > '<0x434 0x4>'.
>
> Are you aware of anyone working on support for getting translated
> address? Do you recall any efforts on implementing such a helper?

All the DT address functions give you translated addresses. It's the
latter that doesn't exist that I'm aware of offhand. It's just
of_address_to_resource() on the child and parent nodes and then
calculate the offset.

Rob
