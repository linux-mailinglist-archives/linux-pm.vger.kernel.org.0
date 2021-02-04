Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9651E30ECFC
	for <lists+linux-pm@lfdr.de>; Thu,  4 Feb 2021 08:11:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234076AbhBDHI3 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 4 Feb 2021 02:08:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232941AbhBDHI2 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 4 Feb 2021 02:08:28 -0500
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33964C0613D6
        for <linux-pm@vger.kernel.org>; Wed,  3 Feb 2021 23:07:48 -0800 (PST)
Received: by mail-io1-xd2d.google.com with SMTP id f8so2165342ion.4
        for <linux-pm@vger.kernel.org>; Wed, 03 Feb 2021 23:07:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gwShMW7VakppNtamo5qslqRnez5wOdtbVlLT+hSRpfg=;
        b=S9ub4QTW0HD0Cdk+VbWFIuLHzN8ySxxEzYql7gewsK1tSSIfZdRkSkghx9nojf63Uv
         10boAezBQxLoLEt3Ui4ja2OJD+4t/2ixQgnn6Mdzp70ODxILjpcISAdpllmdQb1ZaIiX
         mcu39on4BQlCGCS6G+41hJBq0Rqm4NQezEEr8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gwShMW7VakppNtamo5qslqRnez5wOdtbVlLT+hSRpfg=;
        b=tkZ7omq1zqmGSxS2S9+NlbO8BN6b5jYe3OSbP5nXd9QUyeZtEWGwvIAVtZss4iVV7e
         MbOpV+wmClWv9Zbc4L7WkwrSWWE49IHuABy3hjoute5QPrAal9Ge/c6CKK9buUJPspqi
         01zaX+pFlpHfQm2dYa5ewnGR8stAmUPpXlaP6MFIZ1TSNWQ9hzAnlx4Vt+xochvD+gcS
         8yVFf8vfMsCt15HS9igFVXEQp+vh6mskByUu1IfTrf026bw52+JSGCIkvm5ThCIhhD04
         TIPgAXzHC7BiYwtPlnctKz+XJ4eMtFn6ZJlkGUptWeVCbX0RPWluUhoqEnJVHJaq8Fg+
         K3qw==
X-Gm-Message-State: AOAM5304zLFAtTREhw/knnWb1NMCGZWQCu9AyDtzuI7vdz0nGvIOkDGM
        EfcusLyaR9ayNlfHupMZDgqYXwdDd4o4hQqV2xQQVA==
X-Google-Smtp-Source: ABdhPJyaBwO5cx5qL0Jinl0WSZXLwj+DqPa0HN0Zc+exdYGqMx/QERfvdvzqT0+dx7TSBowbGvlKTX7vAoUudFMpCgc=
X-Received: by 2002:a5e:a911:: with SMTP id c17mr5247460iod.20.1612422467611;
 Wed, 03 Feb 2021 23:07:47 -0800 (PST)
MIME-Version: 1.0
References: <20210203092400.1791884-1-hsinyi@chromium.org> <20210203092400.1791884-4-hsinyi@chromium.org>
 <20210204024925.teamzh3d6aq6qfln@vireshk-i7>
In-Reply-To: <20210204024925.teamzh3d6aq6qfln@vireshk-i7>
From:   Hsin-Yi Wang <hsinyi@chromium.org>
Date:   Thu, 4 Feb 2021 15:07:21 +0800
Message-ID: <CAJMQK-hc76N5tbS6Gy2Po0j-2vY4t=D0S52LL5v_AitvaJOOrw@mail.gmail.com>
Subject: Re: [PATCH v5 3/3] PM / devfreq: Add required OPPs support to passive governor
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Viresh Kumar <vireshk@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        lkml <linux-kernel@vger.kernel.org>,
        "MyungJoo Ham )" <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Saravana Kannan <saravanak@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Feb 4, 2021 at 10:49 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> On 03-02-21, 17:24, Hsin-Yi Wang wrote:
> > From: Saravana Kannan <saravanak@google.com>
> >
> > Look at the required OPPs of the "parent" device to determine the OPP that
> > is required from the slave device managed by the passive governor. This
> > allows having mappings between a parent device and a slave device even when
> > they don't have the same number of OPPs.
> >
> > Signed-off-by: Saravana Kannan <saravanak@google.com>
> > Acked-by: MyungJoo Ham <myungjoo.ham@samsung.com>
> > Acked-by: Chanwoo Choi <cw00.choi@samsung.com>
> > Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
> > ---
> >  drivers/devfreq/governor_passive.c | 20 +++++++++++++++-----
> >  1 file changed, 15 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/devfreq/governor_passive.c b/drivers/devfreq/governor_passive.c
> > index 63332e4a65ae8..8d92b1964f9c3 100644
> > --- a/drivers/devfreq/governor_passive.c
> > +++ b/drivers/devfreq/governor_passive.c
> > @@ -19,7 +19,7 @@ static int devfreq_passive_get_target_freq(struct devfreq *devfreq,
> >                       = (struct devfreq_passive_data *)devfreq->data;
> >       struct devfreq *parent_devfreq = (struct devfreq *)p_data->parent;
> >       unsigned long child_freq = ULONG_MAX;
> > -     struct dev_pm_opp *opp;
> > +     struct dev_pm_opp *opp = NULL, *p_opp = NULL;
>
> I would initialize p_opp to ERR_PTR(-ENODEV) to avoid using
> IS_ERR_OR_NULL. There is no need to initialize opp as well.
>
> >       int i, count, ret = 0;
> >
> >       /*
> > @@ -56,13 +56,20 @@ static int devfreq_passive_get_target_freq(struct devfreq *devfreq,
> >        * list of parent device. Because in this case, *freq is temporary
> >        * value which is decided by ondemand governor.
> >        */
> > -     opp = devfreq_recommended_opp(parent_devfreq->dev.parent, freq, 0);
> > -     if (IS_ERR(opp)) {
> > -             ret = PTR_ERR(opp);
> > +     p_opp = devfreq_recommended_opp(parent_devfreq->dev.parent, freq, 0);
> > +     if (IS_ERR(p_opp)) {
> > +             ret = PTR_ERR(p_opp);
> >               goto out;
>
> Perhaps just return from here, the goto is useless here.
>
> >       }
> >
> > -     dev_pm_opp_put(opp);
> > +     if (devfreq->opp_table && parent_devfreq->opp_table)
> > +             opp = dev_pm_opp_xlate_required_opp(parent_devfreq->opp_table,
> > +                                                 devfreq->opp_table, p_opp);
> > +     if (opp) {
>
> This needs to be part of the above if block itself, else the opp will
> always be NULL, isn't it ?
>
> > +             *freq = dev_pm_opp_get_freq(opp);
> > +             dev_pm_opp_put(opp);
> > +             goto out;
> > +     }
> >
> >       /*
> >        * Get the OPP table's index of decided freqeuncy by governor
> > @@ -89,6 +96,9 @@ static int devfreq_passive_get_target_freq(struct devfreq *devfreq,
> >       *freq = child_freq;
> >
> >  out:
> > +     if (!IS_ERR_OR_NULL(opp))
>
> you should be checking for p_opp here, isn't it ? And perhaps we don't
> need this check as well as p_opp can't be invalid here.
>
> > +             dev_pm_opp_put(p_opp);
> > +
> >       return ret;
> >  }
> >
> > --
> > 2.30.0.365.g02bc693789-goog
>
Thanks for the review. I'll fix them and send next version

> --
> viresh
