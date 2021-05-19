Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B20653887CD
	for <lists+linux-pm@lfdr.de>; Wed, 19 May 2021 08:52:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237325AbhESGxa (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 19 May 2021 02:53:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232039AbhESGxa (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 19 May 2021 02:53:30 -0400
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A78CBC06175F;
        Tue, 18 May 2021 23:52:10 -0700 (PDT)
Received: by mail-oi1-x22b.google.com with SMTP id b25so12289495oic.0;
        Tue, 18 May 2021 23:52:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=wVg5mM+Me216Go3llStXhM8TtXsnsknCXUKrzPYVYPU=;
        b=FQmWoa7oB6U7JK/MhykiQzMrGMHeM0FJ2cIC9UXQ0eYPnhq7CwSzAdbgHwaENs+mwh
         lToAMidsfa3VMJ+7SAiyxIyfNxTUYLG4GKcoo03W4n/0D4edkRcgCtOmLgPuh4FdQ7Fm
         PjQ+QWmghgIi3CV6xlm8PxDtpmrl5qrbpJN02hDjofhVJlovaefS2jcHBZgi1v5M5UVz
         G4xtd401uOKpT4aEVFiyqh67+YMC8IWVwBd7h8bWJ5728HNQNe7oIDzdMGfrYSUcw+j8
         QWH3/dCTXdEluT8LyP289CXATqYHQForSE4IuGUnONKOZazZa7BgCNCDCi2QVg7gL7E+
         tQcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=wVg5mM+Me216Go3llStXhM8TtXsnsknCXUKrzPYVYPU=;
        b=KCTYLJW57/8OjXoxDv/btDpmLX/N8xTpzMvmY8qORHGF7nR77vkznyX2hM08zGdDPy
         UKw5GB17YaPCun02kD1utjG074HDcGaDz/N6wQZ42cANRsUHLS7w/33/lED3KIeAKcPB
         Z+qDcw6sgIDDjnZ6xX4cCxwwwkPi0SS7MvgcsyWhIW9SjT9+6CTfHkPx1a7zcsfagUzR
         HBnOWuELQfVUfsfFKMEItI3DOO4FePxqaZiXFVc59ePdn+ncn3nnn6VaxZ+B038MntkC
         Fi/nqYaVSEkrZGTCrAO34tN21bfNLqPam5PSs41hkOtvsu1iBGIcZDSCeKGGMMIEqrlv
         rdbQ==
X-Gm-Message-State: AOAM5322JsoF0mlzl8Bf8idbdNMTb+QMwwiqJ/hkkYutUHgOViuLa2GM
        1VDHmWr/Mq4v/tGtH4UqG6OOew3cfoPVJlyRYM4=
X-Google-Smtp-Source: ABdhPJz7fRaKJ1ASPpvDPqOCRhFyQR+PvOuoTEy+7bx6n2fd+4LRncpfr1L7TlHXdip/ZY2DrTda0RZbk4i2FLvVC88=
X-Received: by 2002:a05:6808:7c1:: with SMTP id f1mr5558762oij.142.1621407130052;
 Tue, 18 May 2021 23:52:10 -0700 (PDT)
MIME-Version: 1.0
References: <1616484011-26702-1-git-send-email-aisheng.dong@nxp.com>
 <1616484011-26702-4-git-send-email-aisheng.dong@nxp.com> <3054611c-4f43-8432-bd14-1733ab82804b@gmail.com>
In-Reply-To: <3054611c-4f43-8432-bd14-1733ab82804b@gmail.com>
From:   Dong Aisheng <dongas86@gmail.com>
Date:   Wed, 19 May 2021 14:51:07 +0800
Message-ID: <CAA+hA=SX5PPcSto5sG7V0Digt0h719+Mx15bMr=5kKgTzyqEAA@mail.gmail.com>
Subject: Re: [PATCH V2 RESEND 3/4] PM / devfreq: bail out early if no freq
 changes in devfreq_set_target
To:     Chanwoo Choi <cwchoi00@gmail.com>
Cc:     Dong Aisheng <aisheng.dong@nxp.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        open list <linux-kernel@vger.kernel.org>,
        myungjoo.ham@samsung.com, kyungmin.park@samsung.com,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Abel Vesa <abel.vesa@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Mar 23, 2021 at 11:01 PM Chanwoo Choi <cwchoi00@gmail.com> wrote:
>
> On 21. 3. 23. =EC=98=A4=ED=9B=84 4:20, Dong Aisheng wrote:
> > It's unnecessary to set the same freq again and run notifier calls.
> >
> > Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
> > ---
> >   drivers/devfreq/devfreq.c | 9 ++++++---
> >   1 file changed, 6 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
> > index 85927bd7ee76..a6ee91dd17bd 100644
> > --- a/drivers/devfreq/devfreq.c
> > +++ b/drivers/devfreq/devfreq.c
> > @@ -352,13 +352,16 @@ static int devfreq_set_target(struct devfreq *dev=
freq, unsigned long new_freq,
> >   {
> >       struct devfreq_freqs freqs;
> >       unsigned long cur_freq;
> > -     int err =3D 0;
> > +     int err;
> >
> >       if (devfreq->profile->get_cur_freq)
> >               devfreq->profile->get_cur_freq(devfreq->dev.parent, &cur_=
freq);
> >       else
> >               cur_freq =3D devfreq->previous_freq;
> >
> > +     if (new_freq =3D=3D cur_freq)
> > +             return 0;
>
> cur_freq is one of the OPP frequencies. But, new_freq is calculated from
> governor algorithm. It means that new_freq is not one of the
> frequencies. Actually, it is not efficient.
>
> After devfreq->profile->target() which almost uses
> devfreq_recommended_opp(), new_freq is one of OPP frequencies.
>

Yes, but i feel at least when the desired new_freq is equal to cur_freq
which is the last successfully set rate,  it is sufficient to bail out earl=
y as
it's meaningless to re-set the same rate as the last one and notify the
an unchanged rate transition in HW.
Does that make sense?

Regards
Aisheng

> > +
> >       freqs.old =3D cur_freq;
> >       freqs.new =3D new_freq;
> >       devfreq_notify_transition(devfreq, &freqs, DEVFREQ_PRECHANGE);
> > @@ -375,7 +378,7 @@ static int devfreq_set_target(struct devfreq *devfr=
eq, unsigned long new_freq,
> >        * and DEVFREQ_POSTCHANGE because for showing the correct frequen=
cy
> >        * change order of between devfreq device and passive devfreq dev=
ice.
> >        */
> > -     if (trace_devfreq_frequency_enabled() && new_freq !=3D cur_freq)
> > +     if (trace_devfreq_frequency_enabled())
> >               trace_devfreq_frequency(devfreq, new_freq, cur_freq);
> >
> >       freqs.new =3D new_freq;
> > @@ -390,7 +393,7 @@ static int devfreq_set_target(struct devfreq *devfr=
eq, unsigned long new_freq,
> >       if (devfreq->suspend_freq)
> >               devfreq->resume_freq =3D new_freq;
> >
> > -     return err;
> > +     return 0;
> >   }
> >
> >   /**
> >
>
>
> --
> Best Regards,
> Samsung Electronics
> Chanwoo Choi
