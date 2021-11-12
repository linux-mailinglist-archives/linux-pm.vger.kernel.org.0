Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 106FD44EF24
	for <lists+linux-pm@lfdr.de>; Fri, 12 Nov 2021 23:18:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233308AbhKLWVa (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 12 Nov 2021 17:21:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:47612 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229634AbhKLWVa (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 12 Nov 2021 17:21:30 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5C68B60F39;
        Fri, 12 Nov 2021 22:18:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636755519;
        bh=DhXFMT1KLqTcH5COtcfvHWf9FguzMhzDabtIeMXMVNs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=u20aUoNk2od58CZROFvj9Am63JQ5jdMduWwVbcOcIbDW+5wZMT9NJ1XnlnSpwPvjl
         fYzOPmWPjXYbDk4ydE/9pFhFyjVafONbeiq4Z3essGgokLBTK13lz1yXSue+hR0GDq
         C8UjLRZK86BlP75hFqqjtVGWQtQDHM69CAUz3Li9ZzhZRN5tSXJN6Rp9/vovBTCuvo
         wezorsKyZxeyxK0rRNIFvvGNtWnyIfzwq8xG+w8TxdCJG3yg1DQOeJfoHFzuaIXAG3
         q+nqkbE/jWC0F3HiDM+C4KvkEpTPa5BPLQt83+BCvFOjhAq04WVrgA/Ps7cEkl6j+d
         vx2ycasqma5Sw==
Received: by mail-ed1-f51.google.com with SMTP id x15so43366483edv.1;
        Fri, 12 Nov 2021 14:18:39 -0800 (PST)
X-Gm-Message-State: AOAM530WmMLa6D+48P7ndfYjb+ams23DU7Egxgy9Ad1ddiwfiGbsp4Ha
        viZiunrTZnTK0iRu2UUBSnPrpv7mATxMD70cpA==
X-Google-Smtp-Source: ABdhPJwc7BH160DIpy5hpg4hp+ZHtrvQLVvSoB4NYT6QsrnMiQPj3pcMD++daWdjqam+ouDNZ/vGB/yp2r6zHETFW+A=
X-Received: by 2002:a17:906:9941:: with SMTP id zm1mr23712816ejb.466.1636755517770;
 Fri, 12 Nov 2021 14:18:37 -0800 (PST)
MIME-Version: 1.0
References: <20211102152207.11891-1-zajec5@gmail.com>
In-Reply-To: <20211102152207.11891-1-zajec5@gmail.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Fri, 12 Nov 2021 16:18:25 -0600
X-Gmail-Original-Message-ID: <CAL_JsqL5qJZz8K7330cOhV8x86097LUE7oFNx5Qu3M4XLL+gMg@mail.gmail.com>
Message-ID: <CAL_JsqL5qJZz8K7330cOhV8x86097LUE7oFNx5Qu3M4XLL+gMg@mail.gmail.com>
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

On Tue, Nov 2, 2021 at 10:22 AM Rafa=C5=82 Mi=C5=82ecki <zajec5@gmail.com> =
wrote:
>
> From: Rafa=C5=82 Mi=C5=82ecki <rafal@milecki.pl>
>
> During my work on MFD binding for Broadcom's TWD block I received
> comment from Rob saying that "syscon-reboot" should use "reg" property.
> I'm not sure if my understanding & implementation are correct so I'm
> sending this RFC.
>
> What bothers me is non-standard "reg" property usage. Treating it as a
> simple (unsigned) integer number means different logic when it comes to
> ranges.

It shouldn't be. The idea is that 'reg' works like normal. See below.

> Consider this example:
>
> timer@400 {
>         compatible =3D "simple-mfd", "syscon";
>         reg =3D <0x400 0x3c>;
>         ranges;

ranges =3D <0 0x400 0x100>; // Just guessing for size

>
>         #address-cells =3D <1>;
>         #size-cells =3D <1>;
>
>         reboot@434 {

reboot@34

Just reading 'reg' is fine, but really, Linux should be either getting
the translated address or have a function to get the offset from the
parent base. IOW, it should also work if you just changed 'reg' to
'<0x434 0x4>'.

>                 compatible =3D "syscon-reboot";
>                 reg =3D <0x34 0x4>;
>                 mask =3D <0x1>;
>         };
> };
>
> I've reboot@434 node with reg 0x34. Also 0x4 is ignored but must be
> present because of of MFD addressing.
>
> Please review this idea / binding / implementation.
>
> Rafa=C5=82 Mi=C5=82ecki (3):
>   dt-bindings: power: reset: syscon-reboot: use non-deprecated example
>   dt-bindings: power: reset: syscon-reboot: add "reg" property
>   power: reset: syscon-reboot: support "reg" property
>
>  .../bindings/power/reset/syscon-reboot.yaml   | 28 +++++++++++++------
>  drivers/power/reset/syscon-reboot.c           |  9 ++++--
>  2 files changed, 26 insertions(+), 11 deletions(-)
>
> --
> 2.31.1
>
