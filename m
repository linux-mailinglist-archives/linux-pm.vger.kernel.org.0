Return-Path: <linux-pm+bounces-7714-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D12BC8C2260
	for <lists+linux-pm@lfdr.de>; Fri, 10 May 2024 12:44:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 849D2281EFB
	for <lists+linux-pm@lfdr.de>; Fri, 10 May 2024 10:44:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 639F5168AEF;
	Fri, 10 May 2024 10:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="E32pxLO0"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9825914F137
	for <linux-pm@vger.kernel.org>; Fri, 10 May 2024 10:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715337845; cv=none; b=AY3IJuJDtZVzJ6dVFwrzv1lHvuc3l29Q2TboWZVX9OSAmRUPPjYasLPL3R3VTKFOFQAm/6VMlgo3RRoH6Sf7HdRaTAQo9Gec5yU1tcokKFdz22+3KtH6rWojRR39gLASVUbp1uDJRywB0hO84KwBvw5P89+G8hQcw3OfA5rojXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715337845; c=relaxed/simple;
	bh=i3iJDF0NWxCzPjjHIcKEVQFJMAJAK0g33+1KtcRzxbk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TIErYziLZJPLuwoHAWnUjaeYr8Nx2IFLVhZB35qWG3cYaKxwjFk1PgJIEn4DTt+Io2fN9tiHSg0uVYv2FqA7UOKw0VutfBRLUpKEz/3DaiYhikJ82YPp2JhOxRp6laGLFFCgzk49zlmklBd0eqNEb0tSDKUNRf3WUeFkJtfcAQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=E32pxLO0; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-dc6cbe1ac75so1383225276.1
        for <linux-pm@vger.kernel.org>; Fri, 10 May 2024 03:44:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1715337842; x=1715942642; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=1ogNqw3uEWxZLRhr+XjfNFFQFaORnUkcs+lj7HFycVM=;
        b=E32pxLO0gLhD+zW6tagdCjBVHmdzv/TlxW0ZTW0vXsCufSgTddMCnX6jm4bxD0dN7X
         8ns2G38DXtDWiKNJTdszfQUyIL34wxHKBPbjqfZmKNK4Z5wqJlNoZ4d6NINlA7KasiSv
         7SKgTJm2deIwW5wUCDnkItNq/pbCYI206agPexPCAWnIATxcrgV+YUXKxOlNdYGdQ1qm
         73iolMC5Q+ptJNylqGJHA6GOU72jeyZg0SeIdrTnu7ktYbvAz569Mhidjgs8pus4DBOa
         lW6r+lxnj5se5a6s0gX777wu6ZxlxVAeTOw7lwZprzz9vi5PQYVSKcO6ZzBjySe21R7G
         f9/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715337842; x=1715942642;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1ogNqw3uEWxZLRhr+XjfNFFQFaORnUkcs+lj7HFycVM=;
        b=ikmUz3pcFhPgu/tbmieKjKUQFab/QVtzEW6pjAD3iY2Ub0QzwS3oGIFPnlZKNwa9Or
         VuwhvWZBMkiJucsRQqPWtTrioCYMoaSaOgY5uGlkrdQaswTF9YoQLX8SlD4g1HUDbRrX
         2x63DiDGYvlQu/qrA2nmzM3c8Uhhy6zqbKRW7/RdxmKB4ojCSvNQnhTHHlE0zBqxqQp6
         lrNzhrXILMbzFALvqfrYqn/d97yinGiuMyDEmjjxi7XRORU/dMy4ZTjjT+uhYETy08L8
         u3/bwTp2xqsucyWOuLufsTruD8Y750ECajc46WPZSHosLL/0qiF9iIRIOVMJ+yV/lP8q
         cTkQ==
X-Forwarded-Encrypted: i=1; AJvYcCVKJ8ln+NWSO5PrqP/IHWuxYfLclb/odQmC93COtMt34L7xkGqRDG3oz/zWgIu22BCbAHuBbdAjAUy5iJ3uwKmdrsXrQdbiD2I=
X-Gm-Message-State: AOJu0YyN5mFaMBnAjFvWUCQeug2Fc/ljoqkQuvmNwPloXEL4HXpQ7NVv
	lJPpCIV8SP2GeCoejA5ro6DQnrjkJfnFSzUOKNt8XHUsSAjrVYiwMQZFzUxyihBIN6Kl+aZF0ro
	DK1ahdfy/h9srdYdVa7I0h03HDy18xDB67WcEwA==
X-Google-Smtp-Source: AGHT+IEj3mCKu7tL9GBcUKYmQuqjEI54qVi7amjAMzPkme0Zr24WvWUgplD6ZcAyk7jpG/q60xs32s3eP8FdtY4Mifw=
X-Received: by 2002:a25:d009:0:b0:dc6:d1a9:d858 with SMTP id
 3f1490d57ef6-dee4e4a641cmr1871935276.8.1715337841207; Fri, 10 May 2024
 03:44:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2eb72832e852c80e5c11cd69e7d2f14cefd8b1cb.1712903998.git.viresh.kumar@linaro.org>
 <e6fc06eb-fe52-4cb3-b412-a602369ee875@leemhuis.info> <CAPDyKFoHoKK-RZsGwnZhbW9_ZRQtL1MFZBuVVLMx-MxL2cQQbw@mail.gmail.com>
 <7c6df194-fce1-401a-98c5-c903d78627c4@leemhuis.info>
In-Reply-To: <7c6df194-fce1-401a-98c5-c903d78627c4@leemhuis.info>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Fri, 10 May 2024 12:43:25 +0200
Message-ID: <CAPDyKFqKRy6zJdBpK3bNTvkvAjty691-Vi_HV3E5CeqgRAWGmA@mail.gmail.com>
Subject: Re: [PATCH V2] OPP: Fix required_opp_tables for multiple genpds using
 same table
To: Linux regressions mailing list <regressions@lists.linux.dev>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org, 
	Vincent Guittot <vincent.guittot@linaro.org>, Vladimir Lypak <vladimir.lypak@gmail.com>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 10 May 2024 at 10:54, Linux regression tracking (Thorsten
Leemhuis) <regressions@leemhuis.info> wrote:
>
> On 10.05.24 10:37, Ulf Hansson wrote:
> > On Thu, 9 May 2024 at 14:35, Thorsten Leemhuis
> > <regressions@leemhuis.info> wrote:
> >> On 12.04.24 08:41, Viresh Kumar wrote:
> >>> The required_opp_tables parsing is not perfect, as the OPP core does the
> >>> parsing solely based on the DT node pointers.
> >>>
> >>> The core sets the required_opp_tables entry to the first OPP table in
> >>> the "opp_tables" list, that matches with the node pointer.
> >>>
> >>> If the target DT OPP table is used by multiple devices and they all
> >>> create separate instances of 'struct opp_table' from it, then it is
> >>> possible that the required_opp_tables entry may be set to the incorrect
> >>> sibling device.
> >>>
> >>> Unfortunately, there is no clear way to initialize the right values
> >>> during the initial parsing and we need to do this at a later point of
> >>> time.
> >>>
> >>> Cross check the OPP table again while the genpds are attached and fix
> >>> them if required.
> >>>
> >>> Also add a new API for the genpd core to fetch the device pointer for
> >>> the genpd.
> >>>
> >>> Cc: Thorsten Leemhuis <regressions@leemhuis.info>
> >>> Reported-by: Vladimir Lypak <vladimir.lypak@gmail.com>
> >>> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=218682
> >>
> >> Did this fall through the cracks? Just wondering, as from here it looks
> >> like for about four weeks now nothing happened to fix the regression
> >> linked above. But I might have missed something. Or is everybody waiting
> >> for a test from the reporter?
> >
> > I have chatted a bit with Viresh about this problem offlist, while
> > both me and him are/have been on vacations. Sorry for the delay and
> > confusion.
> >
> > The latest update from my side is that I am working on a solution,
> > that aim to remove the entire dev|devm_pm_opp_detach_genpd() API.
>
> That sounds like something that would have to wait for a merge window;
> so given the timing I assume this would mean that the earliest point in
> time to merge this would be for 6.11-rc1, which is ~2 months away --
> plus another 9 or 10 weeks until the fix would reach users.

Right.

>
> > Instead, the plan is to move consumer drivers to use
> > dev_pm_domain_attach_list() to attach multiple PM domains per device.
> > When it comes to hooking up the required-opps-tables/devs, I think
> > genpd should be able to manage this during the device attach process.
> > In this way, consumer drivers shouldn't need to care about this at
> > all.
> >
> > That said, I am hoping that $subject patch should not be needed.
> > Although, I need a bit more time before I am ready to post a patchset
> > for the above.
> >
> > What do you think?
>
> Given that the report is already more than a month old now and what I
> assumed above (which might be wrong), this makes me wonder: is there a
> downside if we apply this patch now, and simply revert this later when
> your proper solution is merged? I would assume that is what Linus want
> in this case to honor the "no regressions" rule.

Sure, I am certainly okay with this approach too!

>
> Might be something different if this is something like a really odd
> corner case we assume nobody (or nearly nobody) will run into in
> practice. But as somebody noticed this, I assume that is not the case.

I wasn't sure of the level of urgency in this case, as I don't think
we have that many DTSes upstream that could hit this case.

But nevermind, it should be easy to revert/replace the change when we
have something better to take over. Viresh, feel pick this up - or let
me know if you prefer me to pick it.

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Uffe


>
> Ciao, Thorsten
>
> >>> Co-developed-by: Vladimir Lypak <vladimir.lypak@gmail.com>
> >>> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> >>> ---
> >>> V2:
> >>> - Fix an `if` condition.
> >>> - s/Bugzilla/Closes/ and change ordering.
> >>>
> >>>  drivers/opp/core.c        | 31 ++++++++++++++++++++++++++++++-
> >>>  drivers/pmdomain/core.c   | 10 ++++++++++
> >>>  include/linux/pm_domain.h |  6 ++++++
> >>>  3 files changed, 46 insertions(+), 1 deletion(-)
> >>>
> >>> diff --git a/drivers/opp/core.c b/drivers/opp/core.c
> >>> index e233734b7220..cb4611fe1b5b 100644
> >>> --- a/drivers/opp/core.c
> >>> +++ b/drivers/opp/core.c
> >>> @@ -2394,7 +2394,8 @@ static void _opp_detach_genpd(struct opp_table *opp_table)
> >>>  static int _opp_attach_genpd(struct opp_table *opp_table, struct device *dev,
> >>>                       const char * const *names, struct device ***virt_devs)
> >>>  {
> >>> -     struct device *virt_dev;
> >>> +     struct device *virt_dev, *gdev;
> >>> +     struct opp_table *genpd_table;
> >>>       int index = 0, ret = -EINVAL;
> >>>       const char * const *name = names;
> >>>
> >>> @@ -2427,6 +2428,34 @@ static int _opp_attach_genpd(struct opp_table *opp_table, struct device *dev,
> >>>                       goto err;
> >>>               }
> >>>
> >>> +             /*
> >>> +              * The required_opp_tables parsing is not perfect, as the OPP
> >>> +              * core does the parsing solely based on the DT node pointers.
> >>> +              * The core sets the required_opp_tables entry to the first OPP
> >>> +              * table in the "opp_tables" list, that matches with the node
> >>> +              * pointer.
> >>> +              *
> >>> +              * If the target DT OPP table is used by multiple devices and
> >>> +              * they all create separate instances of 'struct opp_table' from
> >>> +              * it, then it is possible that the required_opp_tables entry
> >>> +              * may be set to the incorrect sibling device.
> >>> +              *
> >>> +              * Cross check it again and fix if required.
> >>> +              */
> >>> +             gdev = dev_to_genpd_dev(virt_dev);
> >>> +             if (IS_ERR(gdev))
> >>> +                     return PTR_ERR(gdev);
> >>> +
> >>> +             genpd_table = _find_opp_table(gdev);
> >>> +             if (!IS_ERR(genpd_table)) {
> >>> +                     if (genpd_table != opp_table->required_opp_tables[index]) {
> >>> +                             dev_pm_opp_put_opp_table(opp_table->required_opp_tables[index]);
> >>> +                             opp_table->required_opp_tables[index] = genpd_table;
> >>> +                     } else {
> >>> +                             dev_pm_opp_put_opp_table(genpd_table);
> >>> +                     }
> >>> +             }
> >>> +
> >>>               /*
> >>>                * Add the virtual genpd device as a user of the OPP table, so
> >>>                * we can call dev_pm_opp_set_opp() on it directly.
> >>> diff --git a/drivers/pmdomain/core.c b/drivers/pmdomain/core.c
> >>> index 4215ffd9b11c..c40eda92a85a 100644
> >>> --- a/drivers/pmdomain/core.c
> >>> +++ b/drivers/pmdomain/core.c
> >>> @@ -184,6 +184,16 @@ static struct generic_pm_domain *dev_to_genpd(struct device *dev)
> >>>       return pd_to_genpd(dev->pm_domain);
> >>>  }
> >>>
> >>> +struct device *dev_to_genpd_dev(struct device *dev)
> >>> +{
> >>> +     struct generic_pm_domain *genpd = dev_to_genpd(dev);
> >>> +
> >>> +     if (IS_ERR(genpd))
> >>> +             return ERR_CAST(genpd);
> >>> +
> >>> +     return &genpd->dev;
> >>> +}
> >>> +
> >>>  static int genpd_stop_dev(const struct generic_pm_domain *genpd,
> >>>                         struct device *dev)
> >>>  {
> >>> diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
> >>> index 772d3280d35f..f24546a3d3db 100644
> >>> --- a/include/linux/pm_domain.h
> >>> +++ b/include/linux/pm_domain.h
> >>> @@ -260,6 +260,7 @@ int pm_genpd_remove_subdomain(struct generic_pm_domain *genpd,
> >>>  int pm_genpd_init(struct generic_pm_domain *genpd,
> >>>                 struct dev_power_governor *gov, bool is_off);
> >>>  int pm_genpd_remove(struct generic_pm_domain *genpd);
> >>> +struct device *dev_to_genpd_dev(struct device *dev);
> >>>  int dev_pm_genpd_set_performance_state(struct device *dev, unsigned int state);
> >>>  int dev_pm_genpd_add_notifier(struct device *dev, struct notifier_block *nb);
> >>>  int dev_pm_genpd_remove_notifier(struct device *dev);
> >>> @@ -307,6 +308,11 @@ static inline int pm_genpd_remove(struct generic_pm_domain *genpd)
> >>>       return -EOPNOTSUPP;
> >>>  }
> >>>
> >>> +static inline struct device *dev_to_genpd_dev(struct device *dev)
> >>> +{
> >>> +     return ERR_PTR(-EOPNOTSUPP);
> >>> +}
> >>> +
> >>>  static inline int dev_pm_genpd_set_performance_state(struct device *dev,
> >>>                                                    unsigned int state)
> >>>  {
> >
> >

