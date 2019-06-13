Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0706643C75
	for <lists+linux-pm@lfdr.de>; Thu, 13 Jun 2019 17:36:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726993AbfFMPgF (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 13 Jun 2019 11:36:05 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:34691 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731971AbfFMPf2 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 13 Jun 2019 11:35:28 -0400
Received: by mail-io1-f68.google.com with SMTP id k8so17886380iot.1;
        Thu, 13 Jun 2019 08:35:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aF7WfJBqic6Edz88lRv/0CL+oI9ZSIdnX+8VgBOn3LM=;
        b=YFFG03ILxrBxA6EZc7HJyHTcZQG8lYtS0piFG6RoKFTL9WaRyzxFvfEfAYIJhj/ftv
         9ExuTCWv50qCckQUHlJWT2UsUYTEATiFrwqXse8mop93NQaSCaMjFPtYLHL53CS1iBdu
         FSSVPGtnBTxP4GW8ocS4dqqaF8GUvpBrzW2/4wt80dCCxcvClhxqJh5SbP92pc3pYdQl
         jlJmooBJcmedVvhBjo+Q5iscUzsWXs4DECS3/+7zXE3IHqrut20IQRp4C0HcFKIYAcT7
         4RLMs3kfUprhpOWBGSDxx6PuB5IH+dkxMni5cJQm3aX/POi0LH+cq45V7JYf6aWa4T1L
         TnxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aF7WfJBqic6Edz88lRv/0CL+oI9ZSIdnX+8VgBOn3LM=;
        b=cwC3Bk0V8cUVTlb5qC7wk5kq7I3t9CVr4PqsCr8WSUiLGBZ/8WL/kMB4qdyIKVzRdH
         buJk1mKOFiQE6rRZFCCqpaPDj3OvnID4rpzBnr8aQ/WhlTk7rAouXapnq0psqZVA3dI6
         s69WzM4VGxKNAnjXKZBOrI3R1QjfFFdzhCc0zyFVrci/GhM0kWzCgai47baHISfAB5hu
         C2MoXb5GmagXRFwL7t9WkcwxMrVuUFpv5UQmEHS+clEkEOVNTy8fgcl9Hr2EMdKeUR4p
         F243oO+9HFJzBpmgeIBaowsoc8vsm5TIJb9+YfhiwuEWyw6dqtOsUOTHz4hRwnQ5icaL
         sNNw==
X-Gm-Message-State: APjAAAVljhOXp1qUwGhi/DMT7gFGRuHPtw4DlJ+98KZ/RWtwyTPuT8mk
        6uLnARmf8hUPjByjS0T7cC9rr6wVLiMAECQhkNs=
X-Google-Smtp-Source: APXvYqzEXd8Sr1aUseL+zTWDc5Ak4NVxezALw+LIg0QIm0xSXFjXqsm8USdWkhi9CiqHsaqRen64MfMyW8gnwFYF5X4=
X-Received: by 2002:a5d:9047:: with SMTP id v7mr36860549ioq.18.1560440127125;
 Thu, 13 Jun 2019 08:35:27 -0700 (PDT)
MIME-Version: 1.0
References: <20190525181329.18657-1-tiny.windzz@gmail.com> <20190525181329.18657-2-tiny.windzz@gmail.com>
 <20190527122752.uc7q6zkjti3zag4q@flea> <CAEExFWtxEB67Pv-8x4ry=tZcJjOD6Kxydq_YB73Gox25VmQn7A@mail.gmail.com>
 <20190612154325.m6z7xsxlpdq4wkxv@flea>
In-Reply-To: <20190612154325.m6z7xsxlpdq4wkxv@flea>
From:   Frank Lee <tiny.windzz@gmail.com>
Date:   Thu, 13 Jun 2019 23:35:15 +0800
Message-ID: <CAEExFWskAsNquULKBLtBFUOosNpks8L6aUhw-+cF=oZ0aghAtQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] thermal: sun8i: add thermal driver for h6
To:     Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     rui.zhang@intel.com, Eduardo Valentin <edubezval@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Chen-Yu Tsai <wens@csie.org>,
        David Miller <davem@davemloft.net>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        paulmck@linux.ibm.com, Linux PM <linux-pm@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Jun 13, 2019 at 9:26 PM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
>
> On Fri, Jun 07, 2019 at 09:34:44PM +0800, Frank Lee wrote:
> > On Mon, May 27, 2019 at 8:27 PM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
> > > > +     ret = devm_request_threaded_irq(dev, irq, NULL,
> > > > +                                     tmdev->chip->irq_thread,
> > > > +                                     IRQF_ONESHOT, "ths", tmdev);
> > > > +     if (ret)
> > > > +             return ret;
> > >
> > > Is there any particular reason to use a threaded interrupt?
> >
> > Just to improve real-time.
>
> What do you mean by real-time here? If anything, that will increase
> the latency of the interrupts here.
>
> And in preempt-rt, regular top-half interrupts will be forced into a
> threaded interrupt anyway.
>
> > > > +static int sun8i_ths_remove(struct platform_device *pdev)
> > > > +{
> > > > +     struct ths_device *tmdev = platform_get_drvdata(pdev);
> > > > +
> > > > +     clk_disable_unprepare(tmdev->bus_clk);
> > >
> > > I know that we discussed that already, but I'm not sure why you switch
> > > back to a regular call to regmap_init_mmio, while regmap_init_mmio_clk
> > > will take care of enabling and disabling the bus clock for you?
> >
> > It seems that regmap_init_mmio_clk just get clk and prepare clk
> > but no enable.
>
> At init time, yes. But it will enable it only when you access the
> registers, which is what you want anyway.

But after accessing the register, it turns the clock off, which
affects the ad conversion and the occurrence of the interrupt.

In addition, when resuming from suspend, we need to enable
the clock, so I think it is necessary to have a clock pointer.

Yangtao

>
> Maxime
>
> --
> Maxime Ripard, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com
