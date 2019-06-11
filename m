Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CA41A3C0A4
	for <lists+linux-pm@lfdr.de>; Tue, 11 Jun 2019 02:34:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728651AbfFKAeJ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 10 Jun 2019 20:34:09 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:33260 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728645AbfFKAeJ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 10 Jun 2019 20:34:09 -0400
Received: by mail-oi1-f196.google.com with SMTP id q186so7663587oia.0;
        Mon, 10 Jun 2019 17:34:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=MvpxPDcZzjh7n/INm53wNH78am0tG0fs5CB4HRWG80I=;
        b=CJGdFVZsnqw8uG8xiS/KagP650Y7VbvBNpLTQU7b3jR2sSiNEzuKbAX3w1m28GZ0Wl
         EZObvX18VD15GsGJ2BPIU9tzVqmK0HS6oSnKPVLxPFzD43cXmkqd5vSn1/tsIbK99ee8
         U5j8PWzMGKubRwd1VV7PvGMFcTYqtIOTXdhdmFUDqBX8PzKflaYjevR+kZPzwKdZ1V9J
         UdcAy5GXlnEAeom2TovLkD0GlTG0jv1yXxd3gOpt5Yz7i5YXPUuzrMguL/aZISUyqV7p
         sszJ21phJbDLayZ/cSoHicyiMffURBtAQLxylGxqyXVRY26uaKz0hJgRx4aYXoh1fAXE
         ZvAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=MvpxPDcZzjh7n/INm53wNH78am0tG0fs5CB4HRWG80I=;
        b=lABsaJM6ihSoBv3Q9gOgvUycCMDNT1RCTnsSJHUvdDNeMr+06ATr6RFAH1ozCN7pji
         BrWjd2Wrf0NESuCRpu15YGLaM3Abb197rK9fef1twtuZ/NuQgjE4SMQ26BFBenwZO85N
         Yf7X2rM7/PHGDTUTLeXyP8GhVqjLuRknHSQIuHQyL1MQQ5gVNN0WDOgew4f3L7R3+QSI
         hv3mKPvs3fZ9qowEDg+zI5/aDq6CoLOx0H5lHxwSjNuqfQ6ErFNqL2rwGjkD5d85+AOU
         kWilaS0VRtAoUiTZtZuyfE+TfAmxnxFFRrjZnGWSCSrjXwyaV0RKqBmbiCNNraF5U98t
         J2tQ==
X-Gm-Message-State: APjAAAV/BFV0LpIEJAHpsvvTQokhpLwb+TG0FDi6R/JSJ5wPKEvBm0e8
        KbhA2Y4NTWPUvexZroP5w5qVHQuTtbHSB3ZucX4=
X-Google-Smtp-Source: APXvYqygQv0AkiaXaGjDiShSOiPL2Eb2sZ3ZOcJsNfhp/8djMj7zJtztfRTSl9AUjYgpefVvY3ky/7qm8w/heknsDsA=
X-Received: by 2002:aca:f552:: with SMTP id t79mr13230037oih.145.1560213248234;
 Mon, 10 Jun 2019 17:34:08 -0700 (PDT)
MIME-Version: 1.0
References: <20190525181329.18657-1-tiny.windzz@gmail.com> <20190525181329.18657-2-tiny.windzz@gmail.com>
 <CA+E=qVdh1E8Y7dZO0JSS4DJE2bo=98MuSKRt7nmeFg-td7Ua9Q@mail.gmail.com> <CAEExFWtjNridLsMXOnBe2mJOPhUOYJ6G3wGF3gx=0oQoQROOGg@mail.gmail.com>
In-Reply-To: <CAEExFWtjNridLsMXOnBe2mJOPhUOYJ6G3wGF3gx=0oQoQROOGg@mail.gmail.com>
From:   Vasily Khoruzhick <anarsoul@gmail.com>
Date:   Mon, 10 Jun 2019 17:34:57 -0700
Message-ID: <CA+E=qVeOSw=_z4OiQ4++z8g-KN29UYVXGicNd3PtHobg4xaG+w@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] thermal: sun8i: add thermal driver for h6
To:     Frank Lee <tiny.windzz@gmail.com>
Cc:     rui.zhang@intel.com, Eduardo Valentin <edubezval@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        "David S. Miller" <davem@davemloft.net>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        paulmck@linux.ibm.com, devicetree <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        arm-linux <linux-arm-kernel@lists.infradead.org>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Jun 10, 2019 at 5:31 PM Frank Lee <tiny.windzz@gmail.com> wrote:
>
> On Tue, Jun 11, 2019 at 7:29 AM Vasily Khoruzhick <anarsoul@gmail.com> wr=
ote:
> >
> > On Sat, May 25, 2019 at 11:17 AM Yangtao Li <tiny.windzz@gmail.com> wro=
te:
> > >
> > > This patch adds the support for allwinner thermal sensor, within
> > > allwinner SoC. It will register sensors for thermal framework
> > > and use device tree to bind cooling device.
> >
> > Hi Yangtao,
> >
> > Any plans on v4 of this series?
> >
>
> I am waiting for comment from Maxime.
>
> I=E2=80=99ll support both h3 and h6 in v4.

If you have a git tree I'll be happy to contribute A64 support. IIRC
it was quite similar to H3.

> Yangtao
