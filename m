Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 970AEBE0C
	for <lists+linux-pm@lfdr.de>; Mon, 29 Apr 2019 00:24:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726443AbfD1WYw (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 28 Apr 2019 18:24:52 -0400
Received: from mail-it1-f193.google.com ([209.85.166.193]:54104 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726435AbfD1WYw (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 28 Apr 2019 18:24:52 -0400
Received: by mail-it1-f193.google.com with SMTP id z4so13698420itc.3;
        Sun, 28 Apr 2019 15:24:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PsYKT4l3qXsvxezqVuSqOBS05ZPcktVxP71GgglT564=;
        b=KAKwceNBAN65v4vL8LdqXGBKFRkGSLkEgbqi5gMWq2gFfnVQwArAa/A6NccdjYpHu8
         GYPmSrHjRE3UH5/qNX5Cr9wvjeTOrRRI0pH5XXS9vi2Fefw0l0S3Ewm+nBtJL2M0mTp3
         BhZxHhQyQXXs9da1SwOPWXfNsCov/IHO4BzraDFe9UqbIfGYdnZFiwXbi3l3EAaeUllA
         u4Lk85BFAkCtHUEwvTmHmGgPlZvgWtwr37sFSjqS6KBUVmZurnaDOMBkU0q3NHcNeHcZ
         oR8D0vbi8qRUMyLIg0l9OBpkoLC+tZFFfww6cPOpIv2KzFsxEV6qYp1jSy729wrDYPNE
         MTaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PsYKT4l3qXsvxezqVuSqOBS05ZPcktVxP71GgglT564=;
        b=RWevWpeNdod0lTzTMzNC8s+IgU+PUiy9PpGifIlJ+tqR6gOkxkVENy5SVmwCqYf/Z8
         yUvD/WuO/cIE4jsU0hAA+NtgIKv0/RAhIsy4XN3M1Ny81aJ2nQo9vdnHgrnRL6kslLIB
         ijXJVLRr3WGrrFhK1GUnGOOqjdwWOIMxcafb0hqAqoAoHCf/MPLUc1F6QgwiZ57slXMY
         dERsdRSb621PhrELdQTG24WdE3+QSf/oBYSPAwe9kGeGubjF0a+i6UQDAYkVZIOqu6UO
         hmEEGWpjVKCUpF45RlXgBgqiChdUKy/rMeDYT2AJ0nTUnx/bMsyAu233ZsIMRz6epbtw
         KlCg==
X-Gm-Message-State: APjAAAWaiyvm9TmfDaDis727+lvVlmwzHzJgmAZMDA0bxJoiwizaksee
        PLXx4T0hfc/MMIZkAG2Mkz0PXoW5gfOqlLddZvE=
X-Google-Smtp-Source: APXvYqyxepoTE6TMA1567F5Qpc0t3HWJAfWtCoSDMuxx3McFEjb8s02THLO25vYloopP1QSJjLl7RdiW/sicZy/OZqM=
X-Received: by 2002:a05:660c:2c5:: with SMTP id j5mr17508459itd.154.1556490291635;
 Sun, 28 Apr 2019 15:24:51 -0700 (PDT)
MIME-Version: 1.0
References: <20190417084457.28747-1-andrew.smirnov@gmail.com>
 <20190417084457.28747-3-andrew.smirnov@gmail.com> <1556289824.2584.36.camel@pengutronix.de>
In-Reply-To: <1556289824.2584.36.camel@pengutronix.de>
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
Date:   Sun, 28 Apr 2019 15:24:39 -0700
Message-ID: <CAHQ1cqExxTYtkmHyL7cCQMjnX+6B0jC7VmtX4w+8tZNShDGj2g@mail.gmail.com>
Subject: Re: [PATCH 2/3] power: supply: Add driver for Microchip UCS1002
To:     Lucas Stach <l.stach@pengutronix.de>
Cc:     Linux PM list <linux-pm@vger.kernel.org>,
        Chris Health <cphealy@gmail.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Sebastian Reichel <sre@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Apr 26, 2019 at 7:43 AM Lucas Stach <l.stach@pengutronix.de> wrote:
>
> Hi Andrey,
>
> Am Mittwoch, den 17.04.2019, 01:44 -0700 schrieb Andrey Smirnov:
> > Add driver for Microchip UCS1002 Programmable USB Port Power
> > Controller with Charger Emulation. The driver exposed a power supply
> > device to control/monitor various parameter of the device as well as a
> > regulator to allow controlling VBUS line.
> >
> > > Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
> > > Cc: Chris Health <cphealy@gmail.com>
> > > Cc: Lucas Stach <l.stach@pengutronix.de>
> > > Cc: Fabio Estevam <fabio.estevam@nxp.com>
> > > Cc: Guenter Roeck <linux@roeck-us.net>
> > > Cc: Sebastian Reichel <sre@kernel.org>
> > Cc: linux-kernel@vger.kernel.org
> > Cc: linux-pm@vger.kernel.org
> > ---
> [...]
> > +     if (irq_a_det > 0) {
> > > +           ret = devm_request_threaded_irq(dev, irq_a_det, NULL,
> > > +                                           ucs1002_charger_irq,
> > > +                                           IRQF_TRIGGER_FALLING |
> > > +                                           IRQF_TRIGGER_RISING |
> > > +                                           IRQF_ONESHOT,
> > > +                                           "ucs1002-a_det", info);
> > > +           if (ret) {
> > > +                   dev_err(dev, "failed to request A_DET threaded irq\n");
> > > +                   return ret;
> > > +           }
> > > +   }
> > +
> > > +   if (irq_alert > 0) {
> > > +           ret = devm_request_threaded_irq(dev, irq_alert, NULL,
> > > +                                           ucs1002_alert_irq,
> > > +                                           IRQF_TRIGGER_FALLING |
> > > +                                           IRQF_TRIGGER_RISING |
> > > +                                           IRQF_ONESHOT,
> > > +                                           "ucs1002-alert", info);
> > > +           if (ret) {
> > > +                   dev_err(dev, "failed to request ALERT threaded irq\n");
> > > +                   return ret;
> > > +           }
> > > +   }
>
> Any reason to explicitly set the IRQ trigger type here? Normally I
> would expect this to be set via the DT interrupt specifier.
>

Don't have a particular reason. I'll move it to DT.

Thanks,
Andrey Smirnov
