Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 419FC77F61
	for <lists+linux-pm@lfdr.de>; Sun, 28 Jul 2019 14:11:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725994AbfG1MLi (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 28 Jul 2019 08:11:38 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:44791 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725983AbfG1MLi (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 28 Jul 2019 08:11:38 -0400
Received: by mail-io1-f67.google.com with SMTP id s7so114039753iob.11;
        Sun, 28 Jul 2019 05:11:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=o8O9KAxzmVM0BrX/bXbNzEeKG4RYTTsXUCROZXRKIPs=;
        b=DKLddTl0Ubsuhb1y9AdP2vx2S5qIlO/qY5kf0m1lLc6Ep9c3CAohxTzAgU9K6LvhMy
         AMeCY5bKM0YGvGxzLLouaHCV+vd7Sk6JQd0hPeuXLqX7yVfHVhQ7rv3HRH3nvl7XtXEd
         tafXjCxauDCJNn+NTxFOa/i82DwP435DE+KL0VbZ6D159c4ORblD7vZBmrl4TR2YidAb
         ShsBMiG95oH6tWFIQj/qxXujTgQVu/YwnPIhSMqq0WLHyl8cH2QGM5YwVhnvdiJ/FI23
         gZYOHSR8kbwtmsvI/sJpt8bQuftlVAOb5tUJJ0hy7td4u7KWEUcY6Hz3TfNcLuvLpoSK
         ovlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=o8O9KAxzmVM0BrX/bXbNzEeKG4RYTTsXUCROZXRKIPs=;
        b=fZM2B4TpYXsQFMfFsRHgDjGAsEjE8lDVdCO/JZjSfG0n4utEgMS+/3e9qN/NHXFAhg
         wnryohDP1CBq6+Dc0dDZ0M+7WmGu0oZ8JYoIZDfrdsq5F954zWny0GuF0L7KPtyxR9sw
         vcveLMvB35HTHEa80MkeCgCgI4GrtV0zqKuHKrlnqPUsrvWBbrUgtTBPC8R4VR57rqGm
         ISGja6eY1rdCFb+qyGJZ/pktiLQc6UhF+mnQBiyIpZ+IjWMEXAWqgFCaYmMuSJZwN5M/
         9977fzXwX3nIHmf3pcT5BW6a0VnymmeIyBSNRGWI6NpESJfXRGClispsiQD/YnCmosS/
         NjHQ==
X-Gm-Message-State: APjAAAUdBaNXuAPTGOimFIwwL9boM0KhBuFtCkik60aDxQlNhjxGr9rQ
        +znL+s5g14ZST5wMcqUH3/SPeZZzNi1Oj2mhkYw=
X-Google-Smtp-Source: APXvYqzEXVVQr+yEjzGumnkJQQ+h79xROdJi30P9BPu7P1IxBEoj9A1yKVecXdyKDF6kc4QihNgv2OEyr8efRwzmhYE=
X-Received: by 2002:a5d:9416:: with SMTP id v22mr27344509ion.4.1564315897025;
 Sun, 28 Jul 2019 05:11:37 -0700 (PDT)
MIME-Version: 1.0
References: <20190623164206.7467-1-tiny.windzz@gmail.com> <CA+E=qVfhDEQER2UTj65hR9erzej9Ey2FrUa9GV=iCFYsWZ2ztw@mail.gmail.com>
 <CA+E=qVdAUFJM27cNL6WRkk5moX=mEk7WUs6UBoX58Y7ove40oQ@mail.gmail.com> <CA+E=qVdw+DG7Bj4xg5-wjatyHMH76q2usanZ7Ty6pGHuaA_=5Q@mail.gmail.com>
In-Reply-To: <CA+E=qVdw+DG7Bj4xg5-wjatyHMH76q2usanZ7Ty6pGHuaA_=5Q@mail.gmail.com>
From:   Frank Lee <tiny.windzz@gmail.com>
Date:   Sun, 28 Jul 2019 20:11:25 +0800
Message-ID: <CAEExFWsCKWdwciC2x4jNpF4+Gk4ezCS+7RHvk1t3fU_xk90jMQ@mail.gmail.com>
Subject: Re: [PATCH v4 00/11] add thermal driver for h6
To:     Vasily Khoruzhick <anarsoul@gmail.com>
Cc:     rui.zhang@intel.com, Eduardo Valentin <edubezval@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
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

HI Vasily,

On Sat, Jul 27, 2019 at 1:46 AM Vasily Khoruzhick <anarsoul@gmail.com> wrot=
e:
>
> Hey Yangtao,
>
> Are you planning to send v5 anytime soon?

Yeah, Thank you for your contribution.

This month is a bit busy, I will probably start the V5 version soon.
The next version will add your A64 support, and possibly H5 support
from icenowy.

Yours=EF=BC=8C
Yangtao

>
> On Sat, Jul 13, 2019 at 11:01 AM Vasily Khoruzhick <anarsoul@gmail.com> w=
rote:
> >
> > On Wed, Jul 10, 2019 at 4:09 PM Vasily Khoruzhick <anarsoul@gmail.com> =
wrote:
> > >
> > > On Sun, Jun 23, 2019 at 9:42 AM Yangtao Li <tiny.windzz@gmail.com> wr=
ote:
> > > >
> > > > This patchset add support for H3 and H6 thermal sensor.
> > > >
> > > > BTY, do a cleanup in thermal makfile.
> > > >
> > > > Yangtao Li (11):
> > > >   thermal: sun8i: add thermal driver for h6
> > > >   dt-bindings: thermal: add binding document for h6 thermal control=
ler
> > > >   thermal: fix indentation in makefile
> > > >   thermal: sun8i: get ths sensor number from device compatible
> > > >   thermal: sun8i: rework for sun8i_ths_get_temp()
> > > >   thermal: sun8i: get ths init func from device compatible
> > > >   thermal: sun8i: rework for ths irq handler func
> > > >   thermal: sun8i: support ahb clocks
> > > >   thermal: sun8i: rework for ths calibrate func
> > > >   dt-bindings: thermal: add binding document for h3 thermal control=
ler
> > > >   thermal: sun8i: add thermal driver for h3
> > >
> > > It would be nice to add dts changes to this series. It's unlikely tha=
t
> > > you'll get any "Tested-by" otherwise.
> >
> > I added A64 support on top of this series, see
> > https://github.com/anarsoul/linux-2.6/tree/v5.2-thermal
> >
> > Branch also contains patches to enable DVFS on A64, feel free to
> > cherry pick only those related to thermal driver if you want to
> > include A64 support into v5 series.
> >
> > >
> > > >  .../bindings/thermal/sun8i-thermal.yaml       |  94 +++
> > > >  MAINTAINERS                                   |   7 +
> > > >  drivers/thermal/Kconfig                       |  14 +
> > > >  drivers/thermal/Makefile                      |   9 +-
> > > >  drivers/thermal/sun8i_thermal.c               | 534 ++++++++++++++=
++++
> > > >  5 files changed, 654 insertions(+), 4 deletions(-)
> > > >  create mode 100644 Documentation/devicetree/bindings/thermal/sun8i=
-thermal.yaml
> > > >  create mode 100644 drivers/thermal/sun8i_thermal.c
> > > >
> > > > ---
> > > > v4:
> > > > -add h3 support
> > > > -fix yaml file
> > > > ---
> > > > 2.17.1
> > > >
> > > >
> > > > _______________________________________________
> > > > linux-arm-kernel mailing list
> > > > linux-arm-kernel@lists.infradead.org
> > > > http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
