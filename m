Return-Path: <linux-pm+bounces-7704-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DD03F8C1FE0
	for <lists+linux-pm@lfdr.de>; Fri, 10 May 2024 10:38:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6ADED1F21F38
	for <lists+linux-pm@lfdr.de>; Fri, 10 May 2024 08:38:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAE3D15FD03;
	Fri, 10 May 2024 08:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VYESdqjU"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA8C97711A
	for <linux-pm@vger.kernel.org>; Fri, 10 May 2024 08:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715330279; cv=none; b=cAtrZ5QAX/2D0sDpTwjaUP0DT8vmVsda5/kVCSyr+jp0iav4aYNl3aLhKJLECeRXBQK0qF7gg/1Twso/Sc/Zv9xZ6u7IQAS+wuTLeRlEK1hFmJLdW6j/5ViteYNI8/wvUFJFLArHTNOQoXJ0+qEKNo2CzIibYa0Gw0Cs+jdOsHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715330279; c=relaxed/simple;
	bh=D6MqpekUEL0sSXzIVwtxlgQvE9xvL+OOtP7S3xFSxbk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PtiW/E4cvoelOxPJxy1KNTdDfzzbi9j6I3wC5uuzdFC8lGqKTs+1f7CRNMJ75FpA029tuxvECzWFregog2uK8mh3VpVowoU8M/PtJWlrDLrt7S6P6CmwaIDroYVF/TucSdQVH/CUssQBaLIyy2jbJq9feAua5sZP70QnZLHeQpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=VYESdqjU; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-de61424f478so1743812276.0
        for <linux-pm@vger.kernel.org>; Fri, 10 May 2024 01:37:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1715330276; x=1715935076; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/tC+GCN44EEZRchaMTsHP5n1JMgFOgSzdTOREHbqQhI=;
        b=VYESdqjUJUgOO0LbiyXqPq3vMYlePD8NISdDey7Qc8tF2QGT2qqrahItHq6fMfwUOS
         Ste0JixeVNrNFceML3Q0RL47IffgTIlyONJL3/uir0KObGk2Q817++n+O6TSehIHoQNG
         kvS5ab57bLFIjOwvk23n+a9Ut/FotS51cSpPG5NjnA1ZvOnSWmrj9sIOSjkv5ssF5rNr
         iRWglxQyheqErB6Hq5Rxmy+wt4FYOMhG3f6ixn6uCQu6kK2NC8dxI1lsjYrfMZa2DBjS
         QBxwarmM7A4G8aM/RcFbrUx34/Ka9TSY5Abd3HcYDKA7dNFcbVRQ1BiEP5pcFt3BYta1
         7DrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715330276; x=1715935076;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/tC+GCN44EEZRchaMTsHP5n1JMgFOgSzdTOREHbqQhI=;
        b=dzUIZlkdGZyyhBngy154iIhSUJ3x0Y6o5EFOmqBerU1US8CChW4XlUD44wYry5AzbP
         xoE+fuPLI9IGWPL5uJaSGF1XduiAztVjrwYRSsJVOh1D5PXgftCxaWe4B9BJavWyLLVG
         QE4wmg66k5FeHuVhXv76nqXvQ38me8vn2gtnuZzfqvIYG5k+Cw0fvJSFp05C1tXBDY30
         iOasxhQcW6ymHek/iykmxBEm6uX6JKoDgyLXqfGzUb7c7GFAZBYXzGhY98+VA6KqENRF
         8Mz1wTg03RQQk+YEFbrKmHv7VFI+C1iczEfDrxlUA0h2nM4AtejQ0DThpnfAGfkQLa0r
         CrOg==
X-Forwarded-Encrypted: i=1; AJvYcCVB8ttQb8NM1wSQP7FVMf50w9+8cSLAUIAQI6JqJQoUHSKBQC8Uf8eQR2HJXskLd1BS6kOUZSxnJ8UspApR24vo1nJponDsEqI=
X-Gm-Message-State: AOJu0YwYZ78Zegz7KOmNgnHJc4/VWkFMuj5vZv+woPCwSG54MLB7Dgdt
	m0UFOT5GXExmUJYK3LvunPFivYeFq3u/n/APGUMJZJyaBJ2GiWLK3JlUMdUlXAC518pbQ6mbtMM
	8edyYNWN6gMnjaQp7X7MlhH/6TI1KgZLPcyeNTA==
X-Google-Smtp-Source: AGHT+IET5/u7vcEkHgwhA2M2F4hEEgTYB63BmDSsSAmJF8lejgW48Dvwqv/0BRckb7KXT+yc1pHf+StnjzTyAKBQdK0=
X-Received: by 2002:a25:c583:0:b0:de7:61db:9fa0 with SMTP id
 3f1490d57ef6-dee4f2e35b4mr2224213276.22.1715330275768; Fri, 10 May 2024
 01:37:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2eb72832e852c80e5c11cd69e7d2f14cefd8b1cb.1712903998.git.viresh.kumar@linaro.org>
 <e6fc06eb-fe52-4cb3-b412-a602369ee875@leemhuis.info>
In-Reply-To: <e6fc06eb-fe52-4cb3-b412-a602369ee875@leemhuis.info>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Fri, 10 May 2024 10:37:18 +0200
Message-ID: <CAPDyKFoHoKK-RZsGwnZhbW9_ZRQtL1MFZBuVVLMx-MxL2cQQbw@mail.gmail.com>
Subject: Re: [PATCH V2] OPP: Fix required_opp_tables for multiple genpds using
 same table
To: Thorsten Leemhuis <regressions@leemhuis.info>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, Viresh Kumar <vireshk@kernel.org>, 
	Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, 
	Vladimir Lypak <vladimir.lypak@gmail.com>, linux-kernel@vger.kernel.org, 
	Linux kernel regressions list <regressions@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"

On Thu, 9 May 2024 at 14:35, Thorsten Leemhuis
<regressions@leemhuis.info> wrote:
>
>
>
> On 12.04.24 08:41, Viresh Kumar wrote:
> > The required_opp_tables parsing is not perfect, as the OPP core does the
> > parsing solely based on the DT node pointers.
> >
> > The core sets the required_opp_tables entry to the first OPP table in
> > the "opp_tables" list, that matches with the node pointer.
> >
> > If the target DT OPP table is used by multiple devices and they all
> > create separate instances of 'struct opp_table' from it, then it is
> > possible that the required_opp_tables entry may be set to the incorrect
> > sibling device.
> >
> > Unfortunately, there is no clear way to initialize the right values
> > during the initial parsing and we need to do this at a later point of
> > time.
> >
> > Cross check the OPP table again while the genpds are attached and fix
> > them if required.
> >
> > Also add a new API for the genpd core to fetch the device pointer for
> > the genpd.
> >
> > Cc: Thorsten Leemhuis <regressions@leemhuis.info>
> > Reported-by: Vladimir Lypak <vladimir.lypak@gmail.com>
> > Closes: https://bugzilla.kernel.org/show_bug.cgi?id=218682
>
> Did this fall through the cracks? Just wondering, as from here it looks
> like for about four weeks now nothing happened to fix the regression
> linked above. But I might have missed something. Or is everybody waiting
> for a test from the reporter?
>
> Ciao, Thorsten

Hi Thorsten,

I have chatted a bit with Viresh about this problem offlist, while
both me and him are/have been on vacations. Sorry for the delay and
confusion.

The latest update from my side is that I am working on a solution,
that aim to remove the entire dev|devm_pm_opp_detach_genpd() API.
Instead, the plan is to move consumer drivers to use
dev_pm_domain_attach_list() to attach multiple PM domains per device.
When it comes to hooking up the required-opps-tables/devs, I think
genpd should be able to manage this during the device attach process.
In this way, consumer drivers shouldn't need to care about this at
all.

That said, I am hoping that $subject patch should not be needed.
Although, I need a bit more time before I am ready to post a patchset
for the above.

What do you think?

Kind regards
Uffe

>
>
> > Co-developed-by: Vladimir Lypak <vladimir.lypak@gmail.com>
> > Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> > ---
> > V2:
> > - Fix an `if` condition.
> > - s/Bugzilla/Closes/ and change ordering.
> >
> >  drivers/opp/core.c        | 31 ++++++++++++++++++++++++++++++-
> >  drivers/pmdomain/core.c   | 10 ++++++++++
> >  include/linux/pm_domain.h |  6 ++++++
> >  3 files changed, 46 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/opp/core.c b/drivers/opp/core.c
> > index e233734b7220..cb4611fe1b5b 100644
> > --- a/drivers/opp/core.c
> > +++ b/drivers/opp/core.c
> > @@ -2394,7 +2394,8 @@ static void _opp_detach_genpd(struct opp_table *opp_table)
> >  static int _opp_attach_genpd(struct opp_table *opp_table, struct device *dev,
> >                       const char * const *names, struct device ***virt_devs)
> >  {
> > -     struct device *virt_dev;
> > +     struct device *virt_dev, *gdev;
> > +     struct opp_table *genpd_table;
> >       int index = 0, ret = -EINVAL;
> >       const char * const *name = names;
> >
> > @@ -2427,6 +2428,34 @@ static int _opp_attach_genpd(struct opp_table *opp_table, struct device *dev,
> >                       goto err;
> >               }
> >
> > +             /*
> > +              * The required_opp_tables parsing is not perfect, as the OPP
> > +              * core does the parsing solely based on the DT node pointers.
> > +              * The core sets the required_opp_tables entry to the first OPP
> > +              * table in the "opp_tables" list, that matches with the node
> > +              * pointer.
> > +              *
> > +              * If the target DT OPP table is used by multiple devices and
> > +              * they all create separate instances of 'struct opp_table' from
> > +              * it, then it is possible that the required_opp_tables entry
> > +              * may be set to the incorrect sibling device.
> > +              *
> > +              * Cross check it again and fix if required.
> > +              */
> > +             gdev = dev_to_genpd_dev(virt_dev);
> > +             if (IS_ERR(gdev))
> > +                     return PTR_ERR(gdev);
> > +
> > +             genpd_table = _find_opp_table(gdev);
> > +             if (!IS_ERR(genpd_table)) {
> > +                     if (genpd_table != opp_table->required_opp_tables[index]) {
> > +                             dev_pm_opp_put_opp_table(opp_table->required_opp_tables[index]);
> > +                             opp_table->required_opp_tables[index] = genpd_table;
> > +                     } else {
> > +                             dev_pm_opp_put_opp_table(genpd_table);
> > +                     }
> > +             }
> > +
> >               /*
> >                * Add the virtual genpd device as a user of the OPP table, so
> >                * we can call dev_pm_opp_set_opp() on it directly.
> > diff --git a/drivers/pmdomain/core.c b/drivers/pmdomain/core.c
> > index 4215ffd9b11c..c40eda92a85a 100644
> > --- a/drivers/pmdomain/core.c
> > +++ b/drivers/pmdomain/core.c
> > @@ -184,6 +184,16 @@ static struct generic_pm_domain *dev_to_genpd(struct device *dev)
> >       return pd_to_genpd(dev->pm_domain);
> >  }
> >
> > +struct device *dev_to_genpd_dev(struct device *dev)
> > +{
> > +     struct generic_pm_domain *genpd = dev_to_genpd(dev);
> > +
> > +     if (IS_ERR(genpd))
> > +             return ERR_CAST(genpd);
> > +
> > +     return &genpd->dev;
> > +}
> > +
> >  static int genpd_stop_dev(const struct generic_pm_domain *genpd,
> >                         struct device *dev)
> >  {
> > diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
> > index 772d3280d35f..f24546a3d3db 100644
> > --- a/include/linux/pm_domain.h
> > +++ b/include/linux/pm_domain.h
> > @@ -260,6 +260,7 @@ int pm_genpd_remove_subdomain(struct generic_pm_domain *genpd,
> >  int pm_genpd_init(struct generic_pm_domain *genpd,
> >                 struct dev_power_governor *gov, bool is_off);
> >  int pm_genpd_remove(struct generic_pm_domain *genpd);
> > +struct device *dev_to_genpd_dev(struct device *dev);
> >  int dev_pm_genpd_set_performance_state(struct device *dev, unsigned int state);
> >  int dev_pm_genpd_add_notifier(struct device *dev, struct notifier_block *nb);
> >  int dev_pm_genpd_remove_notifier(struct device *dev);
> > @@ -307,6 +308,11 @@ static inline int pm_genpd_remove(struct generic_pm_domain *genpd)
> >       return -EOPNOTSUPP;
> >  }
> >
> > +static inline struct device *dev_to_genpd_dev(struct device *dev)
> > +{
> > +     return ERR_PTR(-EOPNOTSUPP);
> > +}
> > +
> >  static inline int dev_pm_genpd_set_performance_state(struct device *dev,
> >                                                    unsigned int state)
> >  {

