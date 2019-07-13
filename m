Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1F6CE67B98
	for <lists+linux-pm@lfdr.de>; Sat, 13 Jul 2019 20:02:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727834AbfGMSC0 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 13 Jul 2019 14:02:26 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:41166 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727766AbfGMSC0 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 13 Jul 2019 14:02:26 -0400
Received: by mail-ot1-f67.google.com with SMTP id o101so12680989ota.8;
        Sat, 13 Jul 2019 11:02:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6ZP/voUQ+Ch7jvDhff/3yc73Q7YGKXw7YDhL153Ao2E=;
        b=b8/xfNKHuNqMcqJ4EyGHcHDYmM+zN6nVT7x//oevUF4FbXx91wi9j00N6ceIa8Rl/b
         EWTldZb8VXxoLMGdQ/jX9GhU9FkvuZVvXYMStADoUM56a6Ao8VljLH9YGj4om4qyZlHK
         guTTMvmbnMRk8fXgVct4OjpXOGLeqKYUwdzSwAWLaJyJkOj5qUUBWPo/w3tPJUJ6nDNN
         QyCrKo0KX9LlpnLy3HJMroREcBHtTpd/1FRymXULMs0ImnZYirfGH8QSwhLGK2VZpODY
         0oH0K3X6QcMqg9JS7+QwoIzt5VGsca4BUNCU45R/r+xmzf8tVoXlupCWcfN8h88MaV/o
         WjHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6ZP/voUQ+Ch7jvDhff/3yc73Q7YGKXw7YDhL153Ao2E=;
        b=WH1W97UGFUNmdh9IF+COeZ12btnJdLX4fl+9Iw0bym01rvhahdKpWKcGlIeANA7oXe
         gxy/L6jpP9QrLct1To5E4aq31PlmpGfwydIZR0QhtNhYSI1e91q98E8Jz3JDfu2Dr2V6
         WvLVJBjHJXwSJfz2rjN3VK7aosA/86n6mY8nd8w5mjRdidHU8vCC+opGcNfq+pjwkcPE
         aoSWhwPmIyHyH31zXzBysq+a8swRjqQOhyCvzxIoLIglLyupKw9c20WOLAsQw+AVJlBo
         KULyn4xCjkKfkWQTe1J8WaAF9kmnV5qDKDIc+2Q3h5tCbHs8E3mIefaVFmoHOfiShUZe
         E7Ng==
X-Gm-Message-State: APjAAAWZ9ifugcXc7rPrlYOo/aKrCyDXc7kSlxZxx5EOe0RuRJzDBgJA
        bXmqiSrxgYVwV5u/YMaZTWsKVi9Dg8xzc+H78fE=
X-Google-Smtp-Source: APXvYqzRubs7sRxl+oVCUfIW4EL3ndy9n7fDLykWAxtEagG7ww8vQ2yqiVZLk0pBacfN9B23mEk41XjLSvO9HJUoEFY=
X-Received: by 2002:a9d:6742:: with SMTP id w2mr4128114otm.371.1563040944838;
 Sat, 13 Jul 2019 11:02:24 -0700 (PDT)
MIME-Version: 1.0
References: <20190623164206.7467-1-tiny.windzz@gmail.com> <CA+E=qVfhDEQER2UTj65hR9erzej9Ey2FrUa9GV=iCFYsWZ2ztw@mail.gmail.com>
In-Reply-To: <CA+E=qVfhDEQER2UTj65hR9erzej9Ey2FrUa9GV=iCFYsWZ2ztw@mail.gmail.com>
From:   Vasily Khoruzhick <anarsoul@gmail.com>
Date:   Sat, 13 Jul 2019 11:01:58 -0700
Message-ID: <CA+E=qVdAUFJM27cNL6WRkk5moX=mEk7WUs6UBoX58Y7ove40oQ@mail.gmail.com>
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

On Wed, Jul 10, 2019 at 4:09 PM Vasily Khoruzhick <anarsoul@gmail.com> wrote:
>
> On Sun, Jun 23, 2019 at 9:42 AM Yangtao Li <tiny.windzz@gmail.com> wrote:
> >
> > This patchset add support for H3 and H6 thermal sensor.
> >
> > BTY, do a cleanup in thermal makfile.
> >
> > Yangtao Li (11):
> >   thermal: sun8i: add thermal driver for h6
> >   dt-bindings: thermal: add binding document for h6 thermal controller
> >   thermal: fix indentation in makefile
> >   thermal: sun8i: get ths sensor number from device compatible
> >   thermal: sun8i: rework for sun8i_ths_get_temp()
> >   thermal: sun8i: get ths init func from device compatible
> >   thermal: sun8i: rework for ths irq handler func
> >   thermal: sun8i: support ahb clocks
> >   thermal: sun8i: rework for ths calibrate func
> >   dt-bindings: thermal: add binding document for h3 thermal controller
> >   thermal: sun8i: add thermal driver for h3
>
> It would be nice to add dts changes to this series. It's unlikely that
> you'll get any "Tested-by" otherwise.

I added A64 support on top of this series, see
https://github.com/anarsoul/linux-2.6/tree/v5.2-thermal

Branch also contains patches to enable DVFS on A64, feel free to
cherry pick only those related to thermal driver if you want to
include A64 support into v5 series.

>
> >  .../bindings/thermal/sun8i-thermal.yaml       |  94 +++
> >  MAINTAINERS                                   |   7 +
> >  drivers/thermal/Kconfig                       |  14 +
> >  drivers/thermal/Makefile                      |   9 +-
> >  drivers/thermal/sun8i_thermal.c               | 534 ++++++++++++++++++
> >  5 files changed, 654 insertions(+), 4 deletions(-)
> >  create mode 100644 Documentation/devicetree/bindings/thermal/sun8i-thermal.yaml
> >  create mode 100644 drivers/thermal/sun8i_thermal.c
> >
> > ---
> > v4:
> > -add h3 support
> > -fix yaml file
> > ---
> > 2.17.1
> >
> >
> > _______________________________________________
> > linux-arm-kernel mailing list
> > linux-arm-kernel@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
