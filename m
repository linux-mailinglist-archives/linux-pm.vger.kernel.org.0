Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 13062145326
	for <lists+linux-pm@lfdr.de>; Wed, 22 Jan 2020 11:54:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725911AbgAVKy4 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 22 Jan 2020 05:54:56 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:39188 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729047AbgAVKyz (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 22 Jan 2020 05:54:55 -0500
Received: by mail-wr1-f67.google.com with SMTP id y11so6739588wrt.6
        for <linux-pm@vger.kernel.org>; Wed, 22 Jan 2020 02:54:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=KOi83Vz/IN024s7DVWYDQDctQI81g6PXQrOU9tnlFxs=;
        b=dK/0VorlbokfuyvN977mKdROWxh0EfaEwy6sogsf/T37h7rFHG5BvVfXh7clBZTAM3
         9am6deUmqld6pmjbQofIJjfX6hYWDcRlMyd1HcyM9yrIBlbAQN10ocPhI2sPkXX55RLb
         CIMa5Y1PKrikQvkpPPAl9WdqOMqlomeCOnv104QloDXGWHRtqRY+FN3HoGg2OlNSr7HM
         Os7z9h8qsHulHt/280QPmk6SJIlKv6bOjKvCEpDaAEqFpBiPabP3PkCa5RkgbCvD4Snw
         L2+0QP5trDGC29CsZO8hnYGBDEJwny8j0aEWH/gIz8rWgoEXTLR1eYGkx91W6tbR+RG7
         L2YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=KOi83Vz/IN024s7DVWYDQDctQI81g6PXQrOU9tnlFxs=;
        b=lqG3XoQ4U1nIvd78u+6muXdqEIO7PxIDc5FPBqSRF1a4baeMqoMDp+Tw1xZCnvCjF7
         Hqk5cbM88YT2MGVNPmNyhr1U1QEd0/8Rv19+qXKb+YHMfORIus/m3NdgabYBBrwhhqSe
         cftPFI3srcAiSCQqPzRIq4CEqEQut3hNVzv9E/QHMfqSBEUo1WN9LaGziUo4Es5dvgwt
         xqsTo9xSyIMMNoNxH4tnmEbQrZGMOk6Q44Spn3ot2ziPXM+NHea4sCDGG7x6ooJ9Xc3Y
         FR89y9EhocD7VT1Ma52L/NI873fXxVyWdtM6HFasUduoKva1vnoVwwZw3wW5ucI6neyU
         NKQw==
X-Gm-Message-State: APjAAAVywM63Gt3cL6TRk5hOex8/06RGEB1ZJbHd7PXsU3sHZWH5mzLg
        4c+Gm4+2rBKb9yv91E5I80hzBZUt4sz+FKPR9Byw1g==
X-Google-Smtp-Source: APXvYqxV+uz5MznINcqswS/+nch8K/IP6dgYijD8acUcmXLstC5bm0/qQCOYR2m1e9PteQSNr6No4gZTYd2qr6yDDAw=
X-Received: by 2002:adf:e6cb:: with SMTP id y11mr10767702wrm.345.1579690493521;
 Wed, 22 Jan 2020 02:54:53 -0800 (PST)
MIME-Version: 1.0
References: <20200116110934.90531-1-glider@google.com> <CAJZ5v0gcKk1eNDy1MM+MjgkHOJ9hFL7O0N2iyNwf8jJcw50waw@mail.gmail.com>
In-Reply-To: <CAJZ5v0gcKk1eNDy1MM+MjgkHOJ9hFL7O0N2iyNwf8jJcw50waw@mail.gmail.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Wed, 22 Jan 2020 11:54:41 +0100
Message-ID: <CAG_fn=XHm_y1hp+KU=W1xEvt3_ijY6BN2XkxRcqfRA72AZ773w@mail.gmail.com>
Subject: Re: [PATCH] PM: hibernate: fix crashes with init_on_free=1
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Pavel Machek <pavel@ucw.cz>,
        Johannes Stezenbach <js@sig21.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Jan 16, 2020 at 11:56 PM Rafael J. Wysocki <rafael@kernel.org> wrot=
e:
>
> On Thu, Jan 16, 2020 at 12:10 PM <glider@google.com> wrote:
> >
> > Upon resuming from hibernation, free pages may contain stale data from
> > the kernel that initiated the resume. This breaks the invariant
> > inflicted by init_on_free=3D1 that freed pages must be zeroed.
> >
> > To deal with this problem, make clear_free_pages() also clear the free
> > pages when init_on_free is enabled.
> >
> > Reported-by: Johannes Stezenbach <js@sig21.net>
> > Signed-off-by: Alexander Potapenko <glider@google.com>
> > Fixes: 6471384af2a6 ("mm: security: introduce init_on_alloc=3D1 and ini=
t_on_free=3D1 boot options")
> > ---
> >  kernel/power/snapshot.c | 20 ++++++++++----------
> >  1 file changed, 10 insertions(+), 10 deletions(-)
> >
> > diff --git a/kernel/power/snapshot.c b/kernel/power/snapshot.c
> > index 26b9168321e7..d65f2d5ab694 100644
> > --- a/kernel/power/snapshot.c
> > +++ b/kernel/power/snapshot.c
> > @@ -1147,24 +1147,24 @@ void free_basic_memory_bitmaps(void)
> >
> >  void clear_free_pages(void)
> >  {
> > -#ifdef CONFIG_PAGE_POISONING_ZERO
> >         struct memory_bitmap *bm =3D free_pages_map;
> >         unsigned long pfn;
> >
> >         if (WARN_ON(!(free_pages_map)))
> >                 return;
> >
> > -       memory_bm_position_reset(bm);
> > -       pfn =3D memory_bm_next_pfn(bm);
> > -       while (pfn !=3D BM_END_OF_MAP) {
> > -               if (pfn_valid(pfn))
> > -                       clear_highpage(pfn_to_page(pfn));
> > -
> > +       if (IS_ENABLED(CONFIG_PAGE_POISONING_ZERO) || want_init_on_free=
()) {
> > +               memory_bm_position_reset(bm);
> >                 pfn =3D memory_bm_next_pfn(bm);
> > +               while (pfn !=3D BM_END_OF_MAP) {
> > +                       if (pfn_valid(pfn))
> > +                               clear_highpage(pfn_to_page(pfn));
> > +
> > +                       pfn =3D memory_bm_next_pfn(bm);
> > +               }
> > +               memory_bm_position_reset(bm);
> > +               pr_info("free pages cleared after restore\n");
> >         }
> > -       memory_bm_position_reset(bm);
> > -       pr_info("free pages cleared after restore\n");
> > -#endif /* PAGE_POISONING_ZERO */
> >  }
> >
> >  /**
> > --
>
> Queued up as a fix for 5.5-rc and "stable", thanks!

It's actually interesting that init_on_free=3D1 has introduced an
invariant that pages in page heap must be initialized with zeros.
Code in mm/page_alloc.c relies on this invariant when allocating with
__GFP_ZERO, so if there's a page that somehow ends up uninitialized,
we get all sorts of vulnerabilities.
We were lucky to see this firing in hibernate, and I've grepped the
code for other occurrences of CONFIG_PAGE_POISONING_ZERO, but I'm not
sure we are not missing any other ways to put an uninitialized page
into the page heap.


--=20
Alexander Potapenko
Software Engineer

Google Germany GmbH
Erika-Mann-Stra=C3=9Fe, 33
80636 M=C3=BCnchen

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
Registergericht und -nummer: Hamburg, HRB 86891
Sitz der Gesellschaft: Hamburg
