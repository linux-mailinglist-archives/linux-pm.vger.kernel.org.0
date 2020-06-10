Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 041651F542D
	for <lists+linux-pm@lfdr.de>; Wed, 10 Jun 2020 14:04:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728848AbgFJMEz (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 10 Jun 2020 08:04:55 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:45322 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728710AbgFJMEz (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 10 Jun 2020 08:04:55 -0400
Received: by mail-oi1-f194.google.com with SMTP id p70so1769160oic.12;
        Wed, 10 Jun 2020 05:04:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=O7BeNgkKLcLbcVLklulyBgYtE1iQ9SVfL7iShdYrrQo=;
        b=Gt73c9Bktela1NnVKVT2Qu49Zpxn3XE3riaXymGos9+2h9i2lw8Eq6QkU+CAWJQT2m
         ypOwTX4U5l1Udziqu7JHuUd04odbPIgPwSxNboPDa+QNOqU94WAbBbiRpX3p/4BKwMh9
         gLf5oyWYYwE2KXbrGqUeQUFUbF9rN4ANhvPMDD40IAC2qzi71YU7AvBW5s3AD8ToLPuu
         06a9PsH6py2k7Qp/QJ/pcVSDH8GOF+7EKkpbMuuFyJK3bkQjBsZF/abiDaXEPZy1YnsN
         pQooyCp/zcyyrfUy0x3hGXzQZmbycc+bk5La3QyofULQrGQtPYckAg78fzHk/A5cJr7O
         qQ3g==
X-Gm-Message-State: AOAM531nMSSPyrCWf0r2BEff20GuUSF4UJAcMfaQ9kH60hqxU/17mwEs
        DTigkEI2j048woS6hcB2BTq4Il9NQ4ua1hFIoV+uEQ==
X-Google-Smtp-Source: ABdhPJwcGB5r/0OhMz6jywtbGWxtqqMbgefQqKusgCy7WCZrlM5yUdno3XELMKaGTom8DBjI6qKdz63W0Tg7xkSG3S0=
X-Received: by 2002:aca:4255:: with SMTP id p82mr2045026oia.153.1591790694088;
 Wed, 10 Jun 2020 05:04:54 -0700 (PDT)
MIME-Version: 1.0
References: <20200605024919.56177-1-navid.emamdoost@gmail.com> <CACRpkdbS7Vo+uV2LJTQNiqoPHWScDrgQiv=TakL1UFQ=ZGXxiQ@mail.gmail.com>
In-Reply-To: <CACRpkdbS7Vo+uV2LJTQNiqoPHWScDrgQiv=TakL1UFQ=ZGXxiQ@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 10 Jun 2020 14:04:42 +0200
Message-ID: <CAMuHMdW541J7y8fotLD4jYpzpqLGC=nfc52NV55jMVndXbR-AQ@mail.gmail.com>
Subject: Re: [PATCH] gpio: rcar: handle pm_runtime_get_sync failure case
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Navid Emamdoost <navid.emamdoost@gmail.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Navid Emamdoost <emamd001@umn.edu>,
        Qiushi Wu <wu000273@umn.edu>, Kangjie Lu <kjlu@umn.edu>,
        Stephen McCamant <smccaman@umn.edu>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Mark Brown <broonie@kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Linus,

On Wed, Jun 10, 2020 at 10:52 AM Linus Walleij <linus.walleij@linaro.org> wrote:
> On Fri, Jun 5, 2020 at 4:49 AM Navid Emamdoost
> <navid.emamdoost@gmail.com> wrote:
> > Calling pm_runtime_get_sync increments the counter even in case of
> > failure, causing incorrect ref count. Call pm_runtime_put if
> > pm_runtime_get_sync fails.
> >
> > Signed-off-by: Navid Emamdoost <navid.emamdoost@gmail.com>
> > ---
> >  drivers/gpio/gpio-rcar.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpio/gpio-rcar.c b/drivers/gpio/gpio-rcar.c
> > index 7284473c9fe3..eac1582c70da 100644
> > --- a/drivers/gpio/gpio-rcar.c
> > +++ b/drivers/gpio/gpio-rcar.c
> > @@ -250,8 +250,10 @@ static int gpio_rcar_request(struct gpio_chip *chip, unsigned offset)
> >         int error;
> >
> >         error = pm_runtime_get_sync(p->dev);
> > -       if (error < 0)
> > +       if (error < 0) {
> > +               pm_runtime_put(p->dev);
> >                 return error;
> > +       }
>
> I need Geert's review on this, he's usually on top of the Renesas stuff.

TBH, I don't know anymore _which_ is the right call to make...

"Re: [PATCH] spi: spi-ti-qspi: call pm_runtime_put on pm_runtime_get failure"
https://lore.kernel.org/linux-spi/20200602095411.GB5684@sirena.org.uk/

Gr{oetje,eeting}s,

                        Geert


--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
