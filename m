Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BCDAC8AB89
	for <lists+linux-pm@lfdr.de>; Tue, 13 Aug 2019 01:54:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726600AbfHLXyh (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 12 Aug 2019 19:54:37 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:46892 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726578AbfHLXyh (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 12 Aug 2019 19:54:37 -0400
Received: by mail-ot1-f67.google.com with SMTP id z17so47325350otk.13;
        Mon, 12 Aug 2019 16:54:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=w2kdR+7b7KvFC+HWFUinAh+s80F0DWNtdCahrnarn44=;
        b=MURQZflgt53gZwpL/adUQPWglHlq+Vte6KXRI0z/ItnHLIbuIWVx+AHjTIX3e2/2XJ
         AgQauFkwH8PiW27qaftBzb8SjEZ22PQqEWa+nCPvevt0Be+071pvDuvfrffhPLtBRpdA
         LBIdY9YYHhtIhRwH3KeCIhyxenjmm3/uupxNakiv2kKJarsmfSyGbsbA9DFnwaS0ukVe
         W1bFdGY9LnSQmBVakQlpzuluvXvyRyG+GjF+BMnQ3AsRKnDVSirB6IyXN29SEnjYM10Q
         Kg+r75M1tzmCtWw+PxSZkLBjos7xfe2rDFrJIyNyazO4H6GArHp+JAU+pZqjWawZp4oF
         m2ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=w2kdR+7b7KvFC+HWFUinAh+s80F0DWNtdCahrnarn44=;
        b=V9s9vJUc2ceaccAPpSEc85odBC0MXUNSVC7Y4m6nL8EsmlzVI69PnHsPK1oawq8Dcy
         tadoWeuWmIjF4Id7G8mKWnQTk0E131wfZ0sytTC8YZZPfbM240OReedPywq/8+ruEM+L
         nS8GjYFjrJ8kA3qt4q+SYey8TMBQ+lOwIuvPI4RqiH98t8LviB/JYqxQ6T9OR2/+xnem
         LktKRuwXUKpYRiaGiNYnH86+TkMc7zj+HFD/28YfROYZB4CSP9Xhl5z5+b3xbIfQnmUz
         o6ur5QC3VTQZ4Xc0k28QjI2orut7QjAtsMGPZyn3MgWqiUf04rC13P0LqSwybm8VVY0Y
         j9kg==
X-Gm-Message-State: APjAAAUlFqjsrnlMsd8bS5hT+xo5eUXNU26lIUY+V8SNHLO3icvuggbN
        Ic8cC6txMZu5vadJs3QZf649/DDN1uFhdrzni7w=
X-Google-Smtp-Source: APXvYqz72zUtIykO8D1IdH6U+dE5fed0U7T2C3hqJGnZx13Lu2B8gFOyDxVqs3R/+r4Eq6F8rMwsnza3cbCy+u/sHjs=
X-Received: by 2002:a05:6830:1f0b:: with SMTP id u11mr23846230otg.263.1565654075918;
 Mon, 12 Aug 2019 16:54:35 -0700 (PDT)
MIME-Version: 1.0
References: <20190810052829.6032-1-tiny.windzz@gmail.com> <20190810052829.6032-9-tiny.windzz@gmail.com>
 <CA+E=qVfp-rProxOwX__J6jM-pZ9g_SmeuOCOgvC_5DJVQw4OGw@mail.gmail.com> <CAEExFWubLqtPZ=ZKJTCb6x2-PeYebXb3sr-t-XvtrLJTRiUU1A@mail.gmail.com>
In-Reply-To: <CAEExFWubLqtPZ=ZKJTCb6x2-PeYebXb3sr-t-XvtrLJTRiUU1A@mail.gmail.com>
From:   Vasily Khoruzhick <anarsoul@gmail.com>
Date:   Mon, 12 Aug 2019 16:54:15 -0700
Message-ID: <CA+E=qVf9V9iTvCfXXyjqKeviCJOvYpKUO8qw6cQsKqoaRmdKYQ@mail.gmail.com>
Subject: Re: [PATCH v5 08/18] thermal: sun8i: support mod clocks
To:     Frank Lee <tiny.windzz@gmail.com>
Cc:     rui.zhang@intel.com, Eduardo Valentin <edubezval@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan.Cameron@huawei.com,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        devicetree <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        arm-linux <linux-arm-kernel@lists.infradead.org>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Aug 12, 2019 at 4:46 PM Frank Lee <tiny.windzz@gmail.com> wrote:
>
> HI Vasily,
>
> On Sat, Aug 10, 2019 at 2:17 PM Vasily Khoruzhick <anarsoul@gmail.com> wrote:
> >
> > On Fri, Aug 9, 2019 at 10:31 PM Yangtao Li <tiny.windzz@gmail.com> wrote:
> > >
> > > H3 has extra clock, so introduce something in ths_thermal_chip/ths_device
> > > and adds the process of the clock.
> > >
> > > This is pre-work for supprt it.
> > >
> > > Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
> > > ---
> > >  drivers/thermal/sun8i_thermal.c | 17 ++++++++++++++++-
> > >  1 file changed, 16 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/thermal/sun8i_thermal.c b/drivers/thermal/sun8i_thermal.c
> > > index b934bc81eba7..6f4294c2aba7 100644
> > > --- a/drivers/thermal/sun8i_thermal.c
> > > +++ b/drivers/thermal/sun8i_thermal.c
> > > @@ -54,6 +54,7 @@ struct tsensor {
> > >  };
> > >
> > >  struct ths_thermal_chip {
> > > +       bool            has_mod_clk;
> > >         int             sensor_num;
> > >         int             offset;
> > >         int             scale;
> > > @@ -69,6 +70,7 @@ struct ths_device {
> > >         struct regmap                           *regmap;
> > >         struct reset_control                    *reset;
> > >         struct clk                              *bus_clk;
> > > +       struct clk                              *mod_clk;
> > >         struct tsensor                          sensor[MAX_SENSOR_NUM];
> > >  };
> > >
> > > @@ -274,6 +276,12 @@ static int sun8i_ths_resource_init(struct ths_device *tmdev)
> > >         if (IS_ERR(tmdev->bus_clk))
> > >                 return PTR_ERR(tmdev->bus_clk);
> > >
> > > +       if (tmdev->chip->has_mod_clk) {
> > > +               tmdev->mod_clk = devm_clk_get(&pdev->dev, "mod");
> > > +               if (IS_ERR(tmdev->mod_clk))
> > > +                       return PTR_ERR(tmdev->mod_clk);
> > > +       }
> > > +
> > >         ret = reset_control_deassert(tmdev->reset);
> > >         if (ret)
> > >                 return ret;
> > > @@ -282,12 +290,18 @@ static int sun8i_ths_resource_init(struct ths_device *tmdev)
> > >         if (ret)
> > >                 goto assert_reset;
> > >
> > > -       ret = sun50i_ths_calibrate(tmdev);
> > > +       ret = clk_prepare_enable(tmdev->mod_clk);
> >
> > You have to set rate of modclk before enabling it since you can't rely
> > on whatever bootloader left for you.
> >
> > Also I found that parameters you're using for PC_TEMP_PERIOD, ACQ0 and
> > ACQ1 are too aggressive and may result in high interrupt rate to the
> > point when it may stall RCU. I changed driver a bit to use params from
> > Philipp Rossak's work (modclk set to 4MHz, PC_TEMP_PERIOD is 7, ACQ0
> > is 255, ACQ1 is 63) and it fixed RCU stalls for me, see [1] for
> > details.
>
> Why is the RCU stall happening, is it caused by a deadlock?
> Can you provide log information and your configuration?
> I am a bit curious.

It's not deadlock, I believe it just can't handle that many interrupts
when running at lowest CPU frequency. Even with Philipp's settings
there's ~20 interrupts a second from ths. I don't remember how many
interrupts were there with your settings.

Unfortunately there's nothing interesting in backtraces, I'm using
Pine64-LTS board.

> Thx,
> Yangtao
>
> >
> > [1] https://github.com/anarsoul/linux-2.6/commit/46b8bb0fe2ccd1cd88fa9181a2ecbf79e8d513b2
> >
> >
> > >         if (ret)
> > >                 goto bus_disable;
> > >
> > > +       ret = sun50i_ths_calibrate(tmdev);
> > > +       if (ret)
> > > +               goto mod_disable;
> > > +
> > >         return 0;
> > >
> > > +mod_disable:
> > > +       clk_disable_unprepare(tmdev->mod_clk);
> > >  bus_disable:
> > >         clk_disable_unprepare(tmdev->bus_clk);
> > >  assert_reset:
> > > @@ -395,6 +409,7 @@ static int sun8i_ths_remove(struct platform_device *pdev)
> > >  {
> > >         struct ths_device *tmdev = platform_get_drvdata(pdev);
> > >
> > > +       clk_disable_unprepare(tmdev->mod_clk);
> > >         clk_disable_unprepare(tmdev->bus_clk);
> > >         reset_control_assert(tmdev->reset);
> > >
> > > --
> > > 2.17.1
> > >
> > >
> > > _______________________________________________
> > > linux-arm-kernel mailing list
> > > linux-arm-kernel@lists.infradead.org
> > > http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
