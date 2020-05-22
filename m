Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4568A1DEF5E
	for <lists+linux-pm@lfdr.de>; Fri, 22 May 2020 20:39:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730832AbgEVSjv (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 22 May 2020 14:39:51 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:37923 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730808AbgEVSjv (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 22 May 2020 14:39:51 -0400
Received: by mail-oi1-f193.google.com with SMTP id j145so10155933oib.5;
        Fri, 22 May 2020 11:39:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=p3zMsrxZhwgrwcGduQr/UXxqaWPWrG8kkAgCM3744ZY=;
        b=T0p/cKQQznyxbTBGqE5w1LwgAcfC46Dh81Uvyw+fzAQA7y5KY/kRfEfDI9sIPwICqf
         86fS2VcfU9iMs04Wm/tdShWzsOATRbmJKmJPbxxvE05KLAi62QZe4GJsjmxRqlbajdMG
         p8DHzojZS93h5I64vHrgEGfzLXWNba7A77knVOhUnvJSzUizcsvRs3c9oFZ827shj7gr
         6YIMOJ1tGXqlAi7LavtSh+dyHghEdVZ1kh/M33QfrYFuQLEeUxVLE6MJTFLc8RkwEtnB
         csfYPBzdc1Fls+7kteHMFAAJECQeV3ks3vq3BnWVdjVTEI1eiOqVrlefwftoJ75g4tc9
         5guQ==
X-Gm-Message-State: AOAM530kvfJaFszB4aUuMBZR1ea9JMN3B4okhUKcQcZf5GsPLYrmjI/R
        LCLiqZoJ1wLs+1uhsRcCXABHZ3IU0D4wRdi4GuC59w==
X-Google-Smtp-Source: ABdhPJxoroDqeqr3j7wCXa+CsZgqdEHTM3n9LOOmheqmijPNjdNwTP4gtYEdF8mAtu1GHPY1ledYlhC3DRr3jjqXTm8=
X-Received: by 2002:a05:6808:486:: with SMTP id z6mr3689687oid.103.1590172790038;
 Fri, 22 May 2020 11:39:50 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20200521170817eucas1p13d9477a0a5d13d2df876134cf41131d8@eucas1p1.samsung.com>
 <5127441.yGvM1JjtLk@kreacher> <e9130ce8-fd22-c871-c089-585585c7133f@samsung.com>
In-Reply-To: <e9130ce8-fd22-c871-c089-585585c7133f@samsung.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 22 May 2020 20:39:38 +0200
Message-ID: <CAJZ5v0j+bsHaQcxK41yph8eRpMZ3DoerqA7uwS2B8De41Jwi7Q@mail.gmail.com>
Subject: Re: [PATCH] PM: runtime: clk: Fix clk_pm_runtime_get() error path
To:     Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, May 22, 2020 at 7:19 AM Marek Szyprowski
<m.szyprowski@samsung.com> wrote:
>
> Hi Rafael,
>
> On 21.05.2020 19:08, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > clk_pm_runtime_get() assumes that the PM-runtime usage counter will
> > be dropped by pm_runtime_get_sync() on errors, which is not the case,
> > so PM-runtime references to devices acquired by the former are leaked
> > on errors returned by the latter.
> >
> > Fix this by modifying clk_pm_runtime_get() to drop the reference if
> > pm_runtime_get_sync() returns an error.
> >
> > Fixes: 9a34b45397e5 clk: Add support for runtime PM
> > Cc: 4.15+ <stable@vger.kernel.org> # 4.15+
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> Frankly, I would rather fix the runtime_get_sync() instead of fixing the
> return path everywhere in the kernel. The current behavior of the
> pm_runtime_get_sync() is completely counter-intuitive then. I bet that
> in the 99% of the places where it is being called assume that no special
> fixup is needed in case of failure. This is one of the most common
> runtime PM related function and it is really a common pattern in the
> drivers to call:
>
> pm_runtime_get_sync()
>
> do something with the hardware
>
> pm_runtime_put()
>
> Do you really want to fix the error paths of the all such calls?

No, I don't, and that's why I'm proposing this patch.

The caller that does what you said above is OK now and if the behavior
of pm_runtime_get_sync() changed, that caller would need to be
updated.

OTOH, a caller that fails to drop the reference on an error returned
by pm_runtime_get_sync() is buggy (and has ever been so).

I'd rather update the buggy callers than the ones that are OK.

Thanks!

>
>
> > ---
> >   drivers/clk/clk.c |    6 +++++-
> >   1 file changed, 5 insertions(+), 1 deletion(-)
> >
> > Index: linux-pm/drivers/clk/clk.c
> > ===================================================================
> > --- linux-pm.orig/drivers/clk/clk.c
> > +++ linux-pm/drivers/clk/clk.c
> > @@ -114,7 +114,11 @@ static int clk_pm_runtime_get(struct clk
> >               return 0;
> >
> >       ret = pm_runtime_get_sync(core->dev);
> > -     return ret < 0 ? ret : 0;
> > +     if (ret < 0) {
> > +             pm_runtime_put_noidle(core->dev);
> > +             return ret;
> > +     }
> > +     return 0;
> >   }
> >
> >   static void clk_pm_runtime_put(struct clk_core *core)
> >
> >
> >
> >
> Best regards
> --
> Marek Szyprowski, PhD
> Samsung R&D Institute Poland
>
