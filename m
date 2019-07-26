Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6588E7708B
	for <lists+linux-pm@lfdr.de>; Fri, 26 Jul 2019 19:46:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387922AbfGZRqm (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 26 Jul 2019 13:46:42 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:39439 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387623AbfGZRqm (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 26 Jul 2019 13:46:42 -0400
Received: by mail-oi1-f193.google.com with SMTP id m202so40834561oig.6;
        Fri, 26 Jul 2019 10:46:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WGpliEWlMJR86QQHjNkvOVmi637qgDODhWz90T/enDA=;
        b=emd7eY/+yhDi/ewbbEtWfJNyj0igS+6kMhiTEYmlNrYCJsXnVBa432o4xJCP4AdQ7b
         QU+I82y3ekntbHJ7+tw/kXOR4MmaQkSpnQHtfoE7IcNVW7HzDLv6usYXes2madoC7Dfn
         ZFrhgwcHz6Ch88sThBKbpF80ZOsR/yZuXere6sgxRlTlhoA6obhereqdgR/DBjersHmi
         WzZqg+H3QfPOjn0d/iLGPiwT8E9Y8OCbm0jBiVt7reLrH4Qq8vHhZe2v7nYiLbCJSduJ
         wmQPnwRIrkxReKFi6UtlaQ1j13/kerXnTXbSCK7hkdbnsbMABiRBREbmnoHf/zyg4Sza
         mEiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WGpliEWlMJR86QQHjNkvOVmi637qgDODhWz90T/enDA=;
        b=aGJjICrIr7cMmwapIUqthuQO7w0JHAfp1qU0so6Eguaj/ppsrMr0KiUjtZf7CZ9Kx9
         vdAMSW/vQBJBY72CsIV9rscsF48JLz6qDg0Sf/JLbO+TOwybfFPeC4LWzlXnLYhh7P5K
         URlYYpuOWILVSebv8CIi7f45OMkpvIBoCGk1cKmsDcT9Jbx0q3RMCHP5/HMH9zzOLJ5n
         rcobge/ypMxHULoj2y74yFYvmwaBeYENaRrPryIhHHqK26DtIZR9K1LKqqIicSNtIkz5
         YcwFyHN4e0wYfZ+R/uXK4jiTjPBoSoEvDD6HIB72z5vkKiwOolUweQtNZXioT9Vm4dST
         T5kA==
X-Gm-Message-State: APjAAAVA8ivEjSumf3uk58BrwkfdJIi/DQxNvb6U59BmS8rHlVaLKvW9
        gN7loo5UOgGpeFlstL5WG0rlMNQEmTEASIidmrU=
X-Google-Smtp-Source: APXvYqwBT4rAcuQeOHJxjAVo+7f4dDVhPgouvyax7CqptIx3vwCxyANHomTDgsG9t3gu6Db+jTmJTNDy7Wqr/XjIUWk=
X-Received: by 2002:a54:4813:: with SMTP id j19mr21421854oij.34.1564163200442;
 Fri, 26 Jul 2019 10:46:40 -0700 (PDT)
MIME-Version: 1.0
References: <20190623164206.7467-1-tiny.windzz@gmail.com> <CA+E=qVfhDEQER2UTj65hR9erzej9Ey2FrUa9GV=iCFYsWZ2ztw@mail.gmail.com>
 <CA+E=qVdAUFJM27cNL6WRkk5moX=mEk7WUs6UBoX58Y7ove40oQ@mail.gmail.com>
In-Reply-To: <CA+E=qVdAUFJM27cNL6WRkk5moX=mEk7WUs6UBoX58Y7ove40oQ@mail.gmail.com>
From:   Vasily Khoruzhick <anarsoul@gmail.com>
Date:   Fri, 26 Jul 2019 10:46:35 -0700
Message-ID: <CA+E=qVdw+DG7Bj4xg5-wjatyHMH76q2usanZ7Ty6pGHuaA_=5Q@mail.gmail.com>
Subject: Re: [PATCH v4 00/11] add thermal driver for h6
To:     Yangtao Li <tiny.windzz@gmail.com>
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
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hey Yangtao,

Are you planning to send v5 anytime soon?

On Sat, Jul 13, 2019 at 11:01 AM Vasily Khoruzhick <anarsoul@gmail.com> wrote:
>
> On Wed, Jul 10, 2019 at 4:09 PM Vasily Khoruzhick <anarsoul@gmail.com> wrote:
> >
> > On Sun, Jun 23, 2019 at 9:42 AM Yangtao Li <tiny.windzz@gmail.com> wrote:
> > >
> > > This patchset add support for H3 and H6 thermal sensor.
> > >
> > > BTY, do a cleanup in thermal makfile.
> > >
> > > Yangtao Li (11):
> > >   thermal: sun8i: add thermal driver for h6
> > >   dt-bindings: thermal: add binding document for h6 thermal controller
> > >   thermal: fix indentation in makefile
> > >   thermal: sun8i: get ths sensor number from device compatible
> > >   thermal: sun8i: rework for sun8i_ths_get_temp()
> > >   thermal: sun8i: get ths init func from device compatible
> > >   thermal: sun8i: rework for ths irq handler func
> > >   thermal: sun8i: support ahb clocks
> > >   thermal: sun8i: rework for ths calibrate func
> > >   dt-bindings: thermal: add binding document for h3 thermal controller
> > >   thermal: sun8i: add thermal driver for h3
> >
> > It would be nice to add dts changes to this series. It's unlikely that
> > you'll get any "Tested-by" otherwise.
>
> I added A64 support on top of this series, see
> https://github.com/anarsoul/linux-2.6/tree/v5.2-thermal
>
> Branch also contains patches to enable DVFS on A64, feel free to
> cherry pick only those related to thermal driver if you want to
> include A64 support into v5 series.
>
> >
> > >  .../bindings/thermal/sun8i-thermal.yaml       |  94 +++
> > >  MAINTAINERS                                   |   7 +
> > >  drivers/thermal/Kconfig                       |  14 +
> > >  drivers/thermal/Makefile                      |   9 +-
> > >  drivers/thermal/sun8i_thermal.c               | 534 ++++++++++++++++++
> > >  5 files changed, 654 insertions(+), 4 deletions(-)
> > >  create mode 100644 Documentation/devicetree/bindings/thermal/sun8i-thermal.yaml
> > >  create mode 100644 drivers/thermal/sun8i_thermal.c
> > >
> > > ---
> > > v4:
> > > -add h3 support
> > > -fix yaml file
> > > ---
> > > 2.17.1
> > >
> > >
> > > _______________________________________________
> > > linux-arm-kernel mailing list
> > > linux-arm-kernel@lists.infradead.org
> > > http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
