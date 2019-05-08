Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 352F317CD1
	for <lists+linux-pm@lfdr.de>; Wed,  8 May 2019 17:07:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727070AbfEHPHM (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 8 May 2019 11:07:12 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:32874 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726543AbfEHPHM (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 8 May 2019 11:07:12 -0400
Received: by mail-pf1-f193.google.com with SMTP id z28so10659316pfk.0;
        Wed, 08 May 2019 08:07:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SHlIzBvrn1yo9BLKEbjmJ4UVWcnyU7bGk9ScB32d6UA=;
        b=IlWUnqm83Nd+nW9AUKiHnWecZrQ5WTsAba8/r1ENvUblSpniWblSSj3Maq7totA2pS
         CVPUn/5ZwkAopx4BwMQ8bXieIR1XAnK2by8MmRL7zkrVV8BBDbGVc327tkTX1NzqqvAc
         aodzD1oVh26FTKVCnv5V12loKz0HPP4QwazbopTn82tv+J3gdF7jg5DzI8XahFI90s2l
         sS9IeH3DhWBgeeWDVQWXRdHW06EjhxtS4PN5oWQwWZRxEPEKHsiKAlNWFXb+HGgThjn2
         Ae10QJYnz3tQgaCqoMxTppxHKQ109+en4tS/SnNHNl7pMv3nYmy0Su1v2R9GG2y7XVta
         R4hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SHlIzBvrn1yo9BLKEbjmJ4UVWcnyU7bGk9ScB32d6UA=;
        b=DGk5Hi5mVninikmIYazN8oGGEkbJ5U9C8tQBCtv7l0d3AMgrgSuJS6CD6+SbtEBfFI
         C+l91x7MXmbyeS4Ca9KDKhbYJfetaK/HQ9ZAXr55M/JNMg9xUFqY1hVfbV3M2lN8wBn1
         3o0OoYL7NH8dxv8dds2Fo7C9QAVe9GYdfTqatX985bJN9QDxOQPtRUdB3WpfGj4K6D76
         ohnEUTrZahGDAUF0fK9i+Hy800ZOZ1zeciiUkzR3svqBAVufJEo3GgezulFvO6OwJq7j
         QjlusUSBVhUIvj+7P0Elp+27Oj7H5B+qtoli/MtZsWZ9f6DH1wQsxeTL/XCpbPmlvvne
         cCfw==
X-Gm-Message-State: APjAAAUBwMzqy9DldgtrbfSq/iFj6bltAwHeMTyTLSEk1OEZI6ZJgivj
        dOn1kcy+lpEqWlj8LWZhgy9oCCAwqR8casPdSyo=
X-Google-Smtp-Source: APXvYqyBnJAAaZoQr7mjA6Rci38Tb5R+Ui9Z2FL4qbH/DorDBX3soly8Q59Kwk0caJ573dJTMkMYDJ8KFqUXNRvzzP8=
X-Received: by 2002:a63:8e4b:: with SMTP id k72mr15890436pge.428.1557328031130;
 Wed, 08 May 2019 08:07:11 -0700 (PDT)
MIME-Version: 1.0
References: <20190424074353.458446-1-lkundrak@v3.sk>
In-Reply-To: <20190424074353.458446-1-lkundrak@v3.sk>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 8 May 2019 18:07:00 +0300
Message-ID: <CAHp75VcXteqg200aB6w_6ngR7=cj3S7HQOELOTV4rYUmCe+dLw@mail.gmail.com>
Subject: Re: [PATCH v6 0/10] Add support for OLPC XO 1.75 Embedded Controller
To:     Lubomir Rintel <lkundrak@v3.sk>
Cc:     Andy Shevchenko <andy@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        Rob Herring <robh+dt@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Mark Rutland <mark.rutland@arm.com>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Sebastian Reichel <sebastian.reichel@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Apr 24, 2019 at 10:44 AM Lubomir Rintel <lkundrak@v3.sk> wrote:
>
> Hello!
>
> This is a sixth spin of the patch set that adds support for the Embedded
> Controller on an OLPC XO 1.75 machine.
>
> Compared to the previous version there are only some trivial-ish changes to
> [06/10] and addition of Reviewd-by tags; as indicated in changelogs of
> individual patches.
>
> In my opinion the first seven patches are ready for merge as they are:
>
>   [01/10] dt-bindings: olpc,xo1.75-ec: Add OLPC XO-1.75 EC
>   [02/10] Platform: OLPC: Remove an unused include
>   [03/10] Platform: OLPC: Move EC-specific functionality out from
>   [04/10] Platform: OLPC: Avoid a warning if the EC didn't
>   [05/10] Platform: OLPC: Use BIT() and GENMASK() for event masks
>   [06/10] Platform: OLPC: Add XO-1.75 EC driver
>   [07/10] Platform: OLPC: Add a regulator for the DCON
>
> The patch [08/10] relies on changes to the OLPC battery driver that have
> recently landed in the power-supply tree (without them enabling
> CONFIG_BATTERY_OLPC on ARM would break build):
>
>   [08/10] power: supply: olpc_battery: Allow building the driver
>
> Sebastian Reichel provided an signed tag of an immutable branch that has
> the necessary bits and was merged into the power-supply tree for 5.2:
>
>   git pull git://git.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-supply.git psy-olpc-1.75-battery-signed
>
> The patch [10/10] was split of from the rest because Russell King found the
> patch [09/10] it depends on possibly objectionable. They should not be
> applied without further input from Russell:
>
>   [09/10] ARM: export arm_pm_restart
>   [10/10] Platform: OLPC: Add restart support to XO-1.75 EC
>
> Tested to work on an OLPC XO 1.75 and also tested not to break x86
> support with an OLPC XO 1 machine. I don't have a XO 1.5, but it's
> unlikely this breaks it when XO 1 works.

Pushed first 8 to my review and testing queue, thanks!

-- 
With Best Regards,
Andy Shevchenko
