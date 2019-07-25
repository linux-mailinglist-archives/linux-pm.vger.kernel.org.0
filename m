Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 965B37442B
	for <lists+linux-pm@lfdr.de>; Thu, 25 Jul 2019 05:59:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390185AbfGYD7M (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 24 Jul 2019 23:59:12 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:34224 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390180AbfGYD7L (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 24 Jul 2019 23:59:11 -0400
Received: by mail-ot1-f68.google.com with SMTP id n5so50260162otk.1
        for <linux-pm@vger.kernel.org>; Wed, 24 Jul 2019 20:59:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LRGlx92bpWtLeBvquF1LUYpvq1tNqGHaDGUio5tA0mo=;
        b=bgnhfItcojaHLZxH7HxI1thzfwiCyqNQurpzmd/6WbSuuZVZt4gkrivXlHwXpPZE7D
         R0fsL0AG3G2jt2u6AZdhn8id9aFbi+28AdOfmk/TGupLB9wH9e5NcvOU6O1pW5aVBWhY
         kFRDQYxCswSwU2pUUgsSXgu3EDxjOWVnB+F2OyXNjeqa0BrLYj8mw4ES6PerKuD877BX
         ksc7e/9s2lGxSMwwWuVnmQfXKJJ+IpNUj/qOuSAdEWbfwC6MkYyCR+H4omewB/Tz1j97
         dqcC33kX6zxF1cjupa9m71cpTEykiTUqsCD6vAmwCm3lDIAomPJMFB6aCFx4ZvQ9idTR
         H9gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LRGlx92bpWtLeBvquF1LUYpvq1tNqGHaDGUio5tA0mo=;
        b=gk+G8waRG12Qek0ZvfQiNSF9TZZWp6WHj6jEcwJCP1vTyApWDzzrsqSWE9XUl+56eC
         RG6tlk3CJFhxh+ELhtbgacDcmXzsYnKdxKXUnrWLVO4HrLgk2SYkxMTJaSLJFj8k0JOB
         MB23PqOkKusd5kMdIvlXsZVfPcyQTGIBPNhLo1ELIrVcyxrzQTqiBstRVCEUFGx04QsW
         C+Ni8PP+Ykgek4NGn86ZFOI8dGMoqsQbEY0yDymmJDZcZTJmmijkU9h/b1xylrwacQ9d
         NaySMf3mf3uzUtde3W6JlszuKABUBTORZybdLNZNxuNSrrusThNKK8VzGRJD9l3J/54w
         OMSA==
X-Gm-Message-State: APjAAAXMzVFwGvy0jdxOGYLMEm1SSg3JUAaauwDjFIvkWWHWcez5+jnj
        g/qLwVzjJkLH0y7YDvPHgFzw9xrAVHCsUqvDZ+OPPg==
X-Google-Smtp-Source: APXvYqwoE0K31LXMkZeawb0RjKZurAc85IFZM3xo7VZr7efw9t8djhPWa5CNHoNeJIS0Ji/qUc11lLo5ud6I02AW/rs=
X-Received: by 2002:a9d:6d06:: with SMTP id o6mr12979042otp.225.1564027150345;
 Wed, 24 Jul 2019 20:59:10 -0700 (PDT)
MIME-Version: 1.0
References: <20190717222340.137578-1-saravanak@google.com> <20190717222340.137578-6-saravanak@google.com>
 <20190723100406.7zchvflrmoaipxek@vireshk-i7> <CAGETcx89X0Xra+3HK+jbuCHXMgRL7QCwSShyMy7DY2Bg1eVjDQ@mail.gmail.com>
 <20190725030137.uz22iwvdv37fsw56@vireshk-i7>
In-Reply-To: <20190725030137.uz22iwvdv37fsw56@vireshk-i7>
From:   Saravana Kannan <saravanak@google.com>
Date:   Wed, 24 Jul 2019 20:58:34 -0700
Message-ID: <CAGETcx_b96teeKoYpJoi8=jhMVrNCKCw9Ef10AU8=mVXGXVPHg@mail.gmail.com>
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

On Wed, Jul 24, 2019 at 8:01 PM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> On 23-07-19, 17:26, Saravana Kannan wrote:
> > On Tue, Jul 23, 2019 at 3:04 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> > > On 17-07-19, 15:23, Saravana Kannan wrote:
> > > >       /*
> > > > @@ -56,13 +56,20 @@ static int devfreq_passive_get_target_freq(struct devfreq *devfreq,
> > > >        * list of parent device. Because in this case, *freq is temporary
> > > >        * value which is decided by ondemand governor.
> > > >        */
> > > > -     opp = devfreq_recommended_opp(parent_devfreq->dev.parent, freq, 0);
> > > > -     if (IS_ERR(opp)) {
> > > > -             ret = PTR_ERR(opp);
> > > > +     p_opp = devfreq_recommended_opp(parent_devfreq->dev.parent, freq, 0);
> > > > +     if (IS_ERR(p_opp)) {
> > > > +             ret = PTR_ERR(p_opp);
> > > >               goto out;
> > > >       }
> > > >
> > > > -     dev_pm_opp_put(opp);
> > > > +     if (devfreq->opp_table && parent_devfreq->opp_table)
> > > > +             opp = dev_pm_opp_xlate_opp(parent_devfreq->opp_table,
> > > > +                                        devfreq->opp_table, p_opp);
> > >
> > > you put p_opp right here.
>
> What about this comment ?

Sorry, mixed this up with the other comment. Good point. Fixed. This
unintentionally fixed a copy-pasta bug I had in the "out" path.

-Saravana

>
> > >
> > > Also shouldn't you try to get p_opp under the above if block only? As
> > > that is the only user of it ?
> >
> > No, p_opp (used to be called opp) was used even before my changes. If
> > there's no required-opps mapping this falls back to assuming the slave
> > device OPP to pick should be the same index as the master device's
> > opp.
> >
> > So I believe this patch is correct as-is.
>
> Right.
>
> --
> viresh
