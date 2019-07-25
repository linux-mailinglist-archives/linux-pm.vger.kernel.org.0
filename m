Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4AB7574F5A
	for <lists+linux-pm@lfdr.de>; Thu, 25 Jul 2019 15:27:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726432AbfGYN10 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 25 Jul 2019 09:27:26 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:36224 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725851AbfGYN10 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 25 Jul 2019 09:27:26 -0400
Received: by mail-lf1-f68.google.com with SMTP id q26so34570026lfc.3;
        Thu, 25 Jul 2019 06:27:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=WXiBayTqTdkKTq09rjY6tipJqJtsUSTf9qvOhgtptXE=;
        b=l61Pt9f2xC+aDtypRt0x2wON8TQwif0kEQaB9wG4yMNYHVMH1B56FKjgcRsrZ0faFe
         3GPlEaprv7OncIBA5s1Q6ImyRuZk3GXPShB9sE1juXK0z8yUwR8pPeC5l1WP9dWUPafi
         Ed/34bGH+qMk1dUj3ViF+UCHnhe6jLJ/mA5UOdxt4r+fMOWRXX6s8EhNBRJBisWWy3j0
         +pbOkjPCzOqgohgd3/NWnJ7UluS8cZQ0/Vkrz6RUUz4YOgdztrfBgkGGz91I6PW/0o1d
         DIuFSkZ2HBg61DLk/SG1shV9emIytsU40xnOcaY8vMyvbw+tB6Cy97HfuGXZRpvtsz5T
         BZLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=WXiBayTqTdkKTq09rjY6tipJqJtsUSTf9qvOhgtptXE=;
        b=sXMbfjpwSr+TrNmHbAdSa6NqU5I1QHwYP9cA7FojopfxGpogvlPlD06yRgGWwb7x0x
         i0+vE87qgXvUKlsXvlkE58AhH/TKjnD+fbau/3YVSdxrM0nUnrBDp0likQXP7HcxkMhM
         qLsf2J3MK5BbG1NW0c2HmMgBrQN2SSoaWgZxcYiNEtoLKm7mEqeNUACZHDHmNKiS43an
         O4tLUa+uak1hKFTzlqBePYjjXZXJt6LjRrw6AS2DogxNteVwDzcwWaX5FEhYt/QY6/6d
         lxJXkIOhP4gTogtYu8/zk9eWUqAuMTEqhb/s3uH2ry/xzL0QcQo/WnpXYF5h8hp9i3E7
         JyVw==
X-Gm-Message-State: APjAAAWKmaRl6FgK7Vp/9xEcZw1LQoa6+2NXsIFKk0lxhyXeJIYXp2ib
        PX0dDW3qnJeG93NAcLmxCA8htcVmO4yRA4CK6r0u+5tFWW4=
X-Google-Smtp-Source: APXvYqw4Ed1+h8H7qf66p3bgbVK3gmUySWTmYzoU/O47r6Wa7RjMhhccNUNPE6lXOnU4XDyXX1GQMhICP//rsdR1lZc=
X-Received: by 2002:ac2:47e8:: with SMTP id b8mr25974255lfp.84.1564059772302;
 Thu, 25 Jul 2019 06:02:52 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20190723122024eucas1p1ff060d072132bfbc8a8a1d10fa1f90f8@eucas1p1.samsung.com>
 <20190723122016.30279-1-a.swigon@partner.samsung.com> <20190723122016.30279-4-a.swigon@partner.samsung.com>
 <CAGTfZH09n9UOLMwNrCvcdeRCHYFO4TiB-YG2rMVuxA4bxuLCVw@mail.gmail.com>
In-Reply-To: <CAGTfZH09n9UOLMwNrCvcdeRCHYFO4TiB-YG2rMVuxA4bxuLCVw@mail.gmail.com>
Reply-To: cwchoi00@gmail.com
From:   Chanwoo Choi <cwchoi00@gmail.com>
Date:   Thu, 25 Jul 2019 22:02:14 +0900
Message-ID: <CAGTfZH2pPh5VVQuHV1d_8Wj1N3TPAh6w4KUkQtssBhEdPgQiuA@mail.gmail.com>
Subject: Re: [RFC PATCH 03/11] devfreq: exynos-bus: Change goto-based logic to
 if-else logic
To:     =?UTF-8?B?QXJ0dXIgxZp3aWdvxYQ=?= <a.swigon@partner.samsung.com>
Cc:     devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-samsung-soc <linux-samsung-soc@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>, inki.dae@samsung.com,
        Seung-Woo Kim <sw0312.kim@samsung.com>,
        georgi.djakov@linaro.org,
        Marek Szyprowski <m.szyprowski@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

2019=EB=85=84 7=EC=9B=94 25=EC=9D=BC (=EB=AA=A9) =EC=98=A4=ED=9B=84 9:56, C=
hanwoo Choi <cwchoi00@gmail.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> 2019=EB=85=84 7=EC=9B=94 24=EC=9D=BC (=EC=88=98) =EC=98=A4=EC=A0=84 8:08,=
 Artur =C5=9Awigo=C5=84 <a.swigon@partner.samsung.com>=EB=8B=98=EC=9D=B4 =
=EC=9E=91=EC=84=B1:
> >
> > This patch improves code readability by changing the following construc=
t:
> >
> > >    if (cond)
> > >        goto passive;
> > >    foo();
> > >    goto out;
> > >passive:
> > >    bar();
> > >out:
> >
> > into this:
> >
> > >    if (cond)
> > >        bar();
> > >    else
> > >        foo();
> >
> > Signed-off-by: Artur =C5=9Awigo=C5=84 <a.swigon@partner.samsung.com>
> > ---
> >  drivers/devfreq/exynos-bus.c | 24 +++++++++---------------
> >  1 file changed, 9 insertions(+), 15 deletions(-)
> >
> > diff --git a/drivers/devfreq/exynos-bus.c b/drivers/devfreq/exynos-bus.=
c
> > index cf6f6cbd0f55..4bb83b945bf7 100644
> > --- a/drivers/devfreq/exynos-bus.c
> > +++ b/drivers/devfreq/exynos-bus.c
> > @@ -505,25 +505,19 @@ static int exynos_bus_probe(struct platform_devic=
e *pdev)
> >         node =3D of_parse_phandle(dev->of_node, "devfreq", 0);
> >         if (node) {
> >                 of_node_put(node);
> > -               goto passive;
> > +               ret =3D exynos_bus_profile_init_passive(bus, profile);
> > +               if (ret < 0)
> > +                       goto err;
> >         } else {
> >                 ret =3D exynos_bus_parent_parse_of(np, bus);
> > +               if (ret < 0)
> > +                       goto err;
> > +
> > +               ret =3D exynos_bus_profile_init(bus, profile);
> > +               if (ret < 0)
> > +                       goto err;
> >         }
> >
> > -       if (ret < 0)
> > -               goto err;
> > -
> > -       ret =3D exynos_bus_profile_init(bus, profile);
> > -       if (ret < 0)
> > -               goto err;
> > -
> > -       goto out;
> > -passive:
> > -       ret =3D exynos_bus_profile_init_passive(bus, profile);
> > -       if (ret < 0)
> > -               goto err;
> > -
> > -out:
> >         max_state =3D bus->devfreq->profile->max_state;
> >         min_freq =3D (bus->devfreq->profile->freq_table[0] / 1000);
> >         max_freq =3D (bus->devfreq->profile->freq_table[max_state - 1] =
/ 1000);
> > --
> > 2.17.1
> >
>
> It seems more simple than before.
> Instead, please merge patch1/2/3 to one patch. and drop the patch4.

But, I think that you better to drop the cleanup patch from this series
because the series[1] touch the exynos-bus.c driver for coupled regulator.
[1] https://www.spinics.net/lists/arm-kernel/msg741971.html

I recommend that you send the cleanup patch with my comment
either after reviewing the Kamil's patch[1] or rebase this series base
on patch[1].

>
> --
> Best Regards,
> Chanwoo Choi



--=20
Best Regards,
Chanwoo Choi
