Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15B98324CCE
	for <lists+linux-pm@lfdr.de>; Thu, 25 Feb 2021 10:28:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236317AbhBYJ02 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 25 Feb 2021 04:26:28 -0500
Received: from mail-ot1-f49.google.com ([209.85.210.49]:44920 "EHLO
        mail-ot1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236078AbhBYJ0Y (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 25 Feb 2021 04:26:24 -0500
Received: by mail-ot1-f49.google.com with SMTP id f33so5025014otf.11;
        Thu, 25 Feb 2021 01:26:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QNH/Pnwo76IsC74cdzsmkae3+sbZ+Nxsq1OpS1V4qzQ=;
        b=HTcPccF+pY+znsaYEafGqCxW4Fmx3pSfV6uHhwdythVyo33CgWjT7GTYnxsjKOIrI3
         vMWbAebUKxHsN3YPQXRUV85Q/k5t3GIHD93DgiHJm0qM5/gqsKm2JVeAkifpWaa1yobv
         n5iTJCGZt3ll7sx2ouFad7lc5TGgPk0hM0mNMqjUdDZN1hiQD4QvTyhZU/EiPQ7TJW2Q
         1FAtVVUdH/S7kl80e1svnZIzuUFBPFEZDgVFizdappStUAr/4Fz0j26qDr6TSJJEBXBP
         CYoYn6mRpYD65HK8jCKrJQyAZmhqGEPj0erB0YfacnLIT57Zkx63O4faMfbpb2+sph3V
         N5WA==
X-Gm-Message-State: AOAM530UyRok8ErvcQQwRrIMy2a8CUl6k5uQXUOjBY6U8sf0a5lX1Enc
        ieWmpBXtLLDQ7R8UVEW853quxAtc9wQQpQqquG8=
X-Google-Smtp-Source: ABdhPJwL0iocqMcNnn9x9/UmKzGdvdmJpIbOhlqSDDon7CKHVE8N6W2p5Bdi4Wxr0YPKcpwhUxSQVgksmoMyxAOl3W4=
X-Received: by 2002:a9d:6382:: with SMTP id w2mr1585913otk.145.1614245143500;
 Thu, 25 Feb 2021 01:25:43 -0800 (PST)
MIME-Version: 1.0
References: <20210215151405.2551143-1-geert+renesas@glider.be>
 <CAGETcx-c5P76JkB-upi8ArDqa=TrR3bJMnpDTO-59sh83opW8g@mail.gmail.com>
 <CAMuHMdVXCH+27cpC=-viQev1HeN_DkU0=7Dydp4G50z0bB2Ang@mail.gmail.com> <CAGETcx_B7r6DErnxzDngh_KW9a33f4+cHhvthzfEHX8pO0et8w@mail.gmail.com>
In-Reply-To: <CAGETcx_B7r6DErnxzDngh_KW9a33f4+cHhvthzfEHX8pO0et8w@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 25 Feb 2021 10:25:32 +0100
Message-ID: <CAMuHMdXr99COTVHyostPLfYC7hezwOf9GfBi_oPfBPQu9nLB9Q@mail.gmail.com>
Subject: Re: [PATCH] staging: board: Fix uninitialized spinlock when attaching genpd
To:     Saravana Kannan <saravanak@google.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Magnus Damm <magnus.damm@gmail.com>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Saravana,

On Mon, Feb 15, 2021 at 10:03 PM Saravana Kannan <saravanak@google.com> wrote:
> On Mon, Feb 15, 2021 at 11:10 AM Geert Uytterhoeven
> <geert@linux-m68k.org> wrote:
> > On Mon, Feb 15, 2021 at 7:37 PM Saravana Kannan <saravanak@google.com> wrote:
> > > On Mon, Feb 15, 2021 at 7:14 AM Geert Uytterhoeven
> > > > @@ -148,7 +149,11 @@ static int board_staging_add_dev_domain(struct platform_device *pdev,
> > > >         pd_args.np = np;
> > > >         pd_args.args_count = 0;
> > > >
> > > > -       return of_genpd_add_device(&pd_args, &pdev->dev);
> > > > +       /* Cfr. device_pm_init_common() */
> > >
> > > What's Cfr?
> >
> > "compare to" (from Latin "confer").
>
> Can you please change this to "refer to" or "similar to"? Also, not
> sure if this comment is even adding anything useful even if you switch
> the words.

I changed it to "Initialization similar to device_pm_init_common()"

> Also, device_pm_init_common() is used in two places outside of
> drivers/base/ with this change. Maybe better to move it to
> linux/device.h?

arch/sh/drivers/platform_early.c has a separate definition, and this
is intentional, cfr. commit 507fd01d53333387 ("drivers: move the early
platform device support to arch/sh"):

    In order not to export internal drivers/base functions to arch code for
    this temporary solution - copy the two needed routines for driver
    matching from drivers/base/platform.c to arch/sh/drivers/platform_early.c.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
