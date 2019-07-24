Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 88C387236C
	for <lists+linux-pm@lfdr.de>; Wed, 24 Jul 2019 02:27:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727813AbfGXA1H (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 23 Jul 2019 20:27:07 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:38435 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727729AbfGXA1H (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 23 Jul 2019 20:27:07 -0400
Received: by mail-ot1-f65.google.com with SMTP id d17so46060984oth.5
        for <linux-pm@vger.kernel.org>; Tue, 23 Jul 2019 17:27:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QbJ/1aH4qmoVTHal9gpfV1OZmeGiXehd+erlFI4ek/0=;
        b=iRJ9Sn87zWuOpYEnizaW5JtalKaYxcMNWYJAjp/AR+/0Zc8vASOONpO8nK5rX3imuE
         BLaMby2VMeVjTU/7+VoD9jpZQGu6BKh+tmkMklrUkFqrQjeHrRwKucPSF8sliWDbFrct
         MEz2LMQd7QDaWwPREoKdqUOqEenHPvTmqsp/202cUlegS0CmAB3rCb/XQuvR560Is5/z
         i2kgg8iuHG9M4fgtBwMxqlT37zL1EsOOeeKSg804XVIbz9xS0lArhWd9c3FTb/J/zyoH
         mrl9fP3pH46wCjZxtS3Cl32+pLzZxZvobOtkBq8bJwIJARsX+udaITcxbi8OrDNvarWF
         isTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QbJ/1aH4qmoVTHal9gpfV1OZmeGiXehd+erlFI4ek/0=;
        b=nP//P/jG7/QxLCe3IctTxQkLMStA9SWRvbUKQr1T3N84IFS7Te+Mn6mLznVEh44xzV
         PoXOZ0EWsWK7MBciPgyG5EdUUILloELMn1CUN/T5yADUEamtQ33V1SzfIgxYT/kwRqah
         T7hkl/ERaZRVQK87tUh4yTLzr6bmxp0nGUYTH/6CvBhdkQY+p/iuNUl22MT0QcF2HImV
         q24Afq8huVTQG4wwCXxDpCWt4WNH6KvQZbTv+jtfpUS+djxm2vVz9134laUhBYpSj/TO
         DZOIoVHriFKVvVfKRJ5ItdOPulfZ6FENRYEzVKNEOksmkHJ5bdSIH4u+Fus/9rkpLe0W
         MhaA==
X-Gm-Message-State: APjAAAWt5JjObBzIPZRPdFN8B2o6qnw6cwTFHdYkQKAn+qzMBh0v7B4f
        jH5nLWFvX3cO+U82K1VxbdncS/8luRmFjA/Jeml3DQ==
X-Google-Smtp-Source: APXvYqz4vq055vl6/OkytYryvRoOr01Jisg/KjTWh/dZ6l5R62vOkPuzpv1JTdWNE0meEetcx6LiqYUaEpuqQfDZhAE=
X-Received: by 2002:a9d:6201:: with SMTP id g1mr59743749otj.195.1563928026489;
 Tue, 23 Jul 2019 17:27:06 -0700 (PDT)
MIME-Version: 1.0
References: <20190717222340.137578-1-saravanak@google.com> <20190717222340.137578-6-saravanak@google.com>
 <20190723100406.7zchvflrmoaipxek@vireshk-i7>
In-Reply-To: <20190723100406.7zchvflrmoaipxek@vireshk-i7>
From:   Saravana Kannan <saravanak@google.com>
Date:   Tue, 23 Jul 2019 17:26:30 -0700
Message-ID: <CAGETcx89X0Xra+3HK+jbuCHXMgRL7QCwSShyMy7DY2Bg1eVjDQ@mail.gmail.com>
Subject: Re: [PATCH v3 5/5] PM / devfreq: Add required OPPs support to passive governor
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Sibi Sankar <sibis@codeaurora.org>,
        Android Kernel Team <kernel-team@android.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Jul 23, 2019 at 3:04 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> On 17-07-19, 15:23, Saravana Kannan wrote:
> > Look at the required OPPs of the "parent" device to determine the OPP that
> > is required from the slave device managed by the passive governor. This
> > allows having mappings between a parent device and a slave device even when
> > they don't have the same number of OPPs.
> >
> > Signed-off-by: Saravana Kannan <saravanak@google.com>
> > Acked-by: MyungJoo Ham <myungjoo.ham@samsung.com>
> > Acked-by: Chanwoo Choi <cw00.choi@samsung.com>
> > ---
> >  drivers/devfreq/governor_passive.c | 20 +++++++++++++++-----
> >  1 file changed, 15 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/devfreq/governor_passive.c b/drivers/devfreq/governor_passive.c
> > index 58308948b863..24ce94c80f06 100644
> > --- a/drivers/devfreq/governor_passive.c
> > +++ b/drivers/devfreq/governor_passive.c
> > @@ -19,7 +19,7 @@ static int devfreq_passive_get_target_freq(struct devfreq *devfreq,
> >                       = (struct devfreq_passive_data *)devfreq->data;
> >       struct devfreq *parent_devfreq = (struct devfreq *)p_data->parent;
> >       unsigned long child_freq = ULONG_MAX;
> > -     struct dev_pm_opp *opp;
> > +     struct dev_pm_opp *opp = NULL, *p_opp = NULL;
>
> This won't be required if ...
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
> >       }
> >
> > -     dev_pm_opp_put(opp);
> > +     if (devfreq->opp_table && parent_devfreq->opp_table)
> > +             opp = dev_pm_opp_xlate_opp(parent_devfreq->opp_table,
> > +                                        devfreq->opp_table, p_opp);
>
> you put p_opp right here.
>
> Also shouldn't you try to get p_opp under the above if block only? As
> that is the only user of it ?

No, p_opp (used to be called opp) was used even before my changes. If
there's no required-opps mapping this falls back to assuming the slave
device OPP to pick should be the same index as the master device's
opp.

So I believe this patch is correct as-is.

-Saravana

>
> > +     if (opp) {
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
> > +             dev_pm_opp_put(p_opp);
> > +
> >       return ret;
> >  }
> >
> > --
> > 2.22.0.510.g264f2c817a-goog
>
> --
> viresh
