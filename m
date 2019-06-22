Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2658F4F854
	for <lists+linux-pm@lfdr.de>; Sat, 22 Jun 2019 23:46:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726290AbfFVVqV (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 22 Jun 2019 17:46:21 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:45221 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725844AbfFVVqV (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 22 Jun 2019 17:46:21 -0400
Received: by mail-oi1-f193.google.com with SMTP id m206so7057662oib.12
        for <linux-pm@vger.kernel.org>; Sat, 22 Jun 2019 14:46:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=IQxmn+d/vzJxXJMTpbS06OU2+1PIYH2ZEA34BMxwa+Q=;
        b=tPBKUG8jMZNVyHZC7oXhpXNwk7HJ/pUQe+sGcVz33ooGXgD6vJ74JcnldSdcftvZKZ
         ZeKGN1i46kiJQSZE+wawRulzaOc4pM5bPYUgP95aiK0oZtGye/LMFu8RwdSW8E9ZlTBv
         c4lw5QFlEVvulmyluOemgxrYe+AjuqduiuM7LJrSn1QdV1ER+PzpM2u9M0DTBqPpHTkQ
         knxSGvU/JCs9bRuWQN7JirguWN1boQMcxZFRVBo1fsnBEJF/KC0Xpwcxzvh2ZeERCzur
         was3YkohPrSTvzW+HCpulz41hRMYfPopBILIdb8tRMUa5b/3h/a82eWQIi1V5rOD3A/2
         fwMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=IQxmn+d/vzJxXJMTpbS06OU2+1PIYH2ZEA34BMxwa+Q=;
        b=e5SL+Fw/w9B0Zfwu0gumr5LygNWcNj18+yvczsCZ3U1E7LDsLXKBjsuS/IN4AhQTeJ
         fHBYaZ0TF/A0XBlYwv15J4YR1Bp+jYdqdxUZimAA1quiI0MLXmsXivt3szIxs6GiKaL/
         Vxxlv5gcDHcOd05n7stuGoXd7X7F9m/uj8F2MzwOZ6RzXQqWZTIZg1kl9o5cFvtrM/A/
         GFxeUrO4A23HC39WYlrnPxnXqGfNDIXfTQ4qHdvqfTirwXmdqRjzkQAqvccgHWW5mOke
         ucMG/e4BCJMsxdv97d+uNdP/z6LU3dq/i7HdQIk8jjRwFS6hONF4nvWzvw+gr4Vxomv3
         Am0A==
X-Gm-Message-State: APjAAAVcuCK8q8NH4sKQiy9a4+1KPvE+74YmNmeI/ZW0Wp+V2IYfWeF1
        pjVx+N/O0AkhIFhBVM2WsRbYqccAkjPSJpoJDW9ckA==
X-Google-Smtp-Source: APXvYqzkDDd7UskURLH6vHR59mauMZIEIHiF1rywaf7LmTtrrmqMh+fNNf+0CzPkX+9w1zD/J01B+JpoE0Ak5QYDuLI=
X-Received: by 2002:a05:6808:6c7:: with SMTP id m7mr6421578oih.43.1561239979958;
 Sat, 22 Jun 2019 14:46:19 -0700 (PDT)
MIME-Version: 1.0
References: <20190622003449.33707-1-saravanak@google.com> <20190622003449.33707-4-saravanak@google.com>
 <CAGTfZH1COWzhDBr63S18md44ypKixstHHsX7cm5LnAhXXbfecA@mail.gmail.com>
In-Reply-To: <CAGTfZH1COWzhDBr63S18md44ypKixstHHsX7cm5LnAhXXbfecA@mail.gmail.com>
From:   Saravana Kannan <saravanak@google.com>
Date:   Sat, 22 Jun 2019 14:45:44 -0700
Message-ID: <CAGETcx8QcAw937Q5kW7BOKFfB+=obB9pXj25pAuQUAXNMOwkjQ@mail.gmail.com>
Subject: Re: [PATCH v1 3/3] PM / devfreq: Add required OPPs support to passive governor
To:     cwchoi00@gmail.com
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Android Kernel Team <kernel-team@android.com>,
        Linux PM list <linux-pm@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sat, Jun 22, 2019 at 5:01 AM Chanwoo Choi <cwchoi00@gmail.com> wrote:
>
> Hi,
>
> Absolutely, I agree this approach.

Thanks!

> But, I add some comments on below. please check them.
>
> 2019=EB=85=84 6=EC=9B=94 22=EC=9D=BC (=ED=86=A0) =EC=98=A4=EC=A0=84 9:36,=
 Saravana Kannan <saravanak@google.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=
=B1:
> >
> > Look at the required OPPs of the "parent" device to determine the OPP t=
hat
> > is required from the slave device managed by the passive governor. This
> > allows having mappings between a parent device and a slave device even =
when
> > they don't have the same number of OPPs.
> >
> > Signed-off-by: Saravana Kannan <saravanak@google.com>
> > ---
> >  drivers/devfreq/governor_passive.c | 25 +++++++++++++++++++++++--
> >  1 file changed, 23 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/devfreq/governor_passive.c b/drivers/devfreq/gover=
nor_passive.c
> > index 3bc29acbd54e..bd4a98bb15b1 100644
> > --- a/drivers/devfreq/governor_passive.c
> > +++ b/drivers/devfreq/governor_passive.c
> > @@ -21,8 +21,9 @@ static int devfreq_passive_get_target_freq(struct dev=
freq *devfreq,
> >         struct devfreq_passive_data *p_data
> >                         =3D (struct devfreq_passive_data *)devfreq->dat=
a;
> >         struct devfreq *parent_devfreq =3D (struct devfreq *)p_data->pa=
rent;
> > +       struct opp_table *opp_table =3D NULL, *c_opp_table =3D NULL;
>
> In this function, the base device is passive devfreq device.
> So, I think that better to define the 'parent_opp_table' instead of 'opp_=
table'
> indicating the OPP table of parent devfreq device. And better to define
> just 'opp_table' instead of 'c_opp_table' indicating the passive devfreq =
device.
> - opp_table -> parent_opp_table
> - c_opp_table -> opp_table

Sounds good. I did it that way at first, but I wanted to keep the diff
simple in my first patch series. So renamed it. I can do the rename
that you suggested. Makes sense to me.

> >         unsigned long child_freq =3D ULONG_MAX;
> > -       struct dev_pm_opp *opp;
> > +       struct dev_pm_opp *opp =3D NULL, *c_opp =3D NULL;
>
> Ditto. I think that better to define the variables as following:
> - opp -> parent_opp
> - c_cpp -> opp

Will do.

>
> >         int i, count, ret =3D 0;
> >
> >         /*
> > @@ -65,7 +66,20 @@ static int devfreq_passive_get_target_freq(struct de=
vfreq *devfreq,
> >                 goto out;
> >         }
> >
> > -       dev_pm_opp_put(opp);
> > +       opp_table =3D dev_pm_opp_get_opp_table(parent_devfreq->dev.pare=
nt);
>
> devfreq_passive_get_target_freq() is called frequently for DVFS support.
> I think that you have to add 'struct opp_table *opp_table' instance to
> 'struct devfreq'
> and then get 'opp_table' instance in the devfreq_add_device().

Sounds good. I had wanted to do that anyway, but didn't think it was
part of this series. But I can add that change to this series.

> devfreq_add_device() already get the OPP information by using
> dev_pm_opp_get_suspend_opp_freq().
> You can add following code nearby dev_pm_opp_get_suspend_opp_freq() in
> devfreq_add_device().
> - devfreq->opp_table =3D dev_pm_opp_get_opp_table(dev);

Will do something like that.

I'll send out an updated patch series on Monday or Tuesday. Hopefully
Viresh would have replied by then to give his opinion on whether this
is okay by him.

Thanks,
Saravana
