Return-Path: <linux-pm+bounces-937-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9215780E93A
	for <lists+linux-pm@lfdr.de>; Tue, 12 Dec 2023 11:37:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A8041F214E1
	for <lists+linux-pm@lfdr.de>; Tue, 12 Dec 2023 10:37:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE2D853815;
	Tue, 12 Dec 2023 10:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Qaqx+BXx"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CA4A9F
	for <linux-pm@vger.kernel.org>; Tue, 12 Dec 2023 02:37:12 -0800 (PST)
Received: by mail-yb1-xb36.google.com with SMTP id 3f1490d57ef6-dbcb0f0212aso1130858276.3
        for <linux-pm@vger.kernel.org>; Tue, 12 Dec 2023 02:37:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702377432; x=1702982232; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xHJ0C2+1JsqJ9WUI0/7K7zDOEYnEO3NJcXuLCAkUQ4E=;
        b=Qaqx+BXxqoDem1gXpeigTr+v4szRYONMcnhN+w8caOMBkvw+U17rVtsGyxdsU2LUCn
         mA7ZpITlFl9DaUiM7kRp15uMJ0rs1JzCzAidrFol9RTYa1+DVBs4oe7Evtm97M+Sm1x8
         /ZzFwPasNxUvmzGsR0gyQwYrPek93mksuXLC1HLP/KG5FNKjjNDnjhsdEYobtBkoJV70
         5k2KSv1FMkPlW0Sw1PGXcOkjKOTB6ZujeXY/ik67DP5CeoQiN4DidfdAo5BQndxQaahI
         97UAS8lSzHshhB3mcp8h+VFpD7AMsS5cAt+6SmFnrUvA3RHjJxoK2K/9P+qJ/wQTC6m/
         7OUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702377432; x=1702982232;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xHJ0C2+1JsqJ9WUI0/7K7zDOEYnEO3NJcXuLCAkUQ4E=;
        b=GmIZHmO4fTwp2XzVBdxY3Rr5/pwOcK1mmhQLHCK+QkmagVnqddcF1C0ng0XseWneOK
         9BF/buI0cyE4TBIILdW6jU6uEPy/aOnr5E8nFeXsOsjOrOu4bJZSZTsCtZj8mDtDeIvo
         M70rR46pLkfclU7PaIMfF/s6wykyFuhzNiegKJ+RfoSNabImTot35FfIlhg3yK0JUvpf
         nH79uo5h0eUuuaSQDb4OptCxLKSFdlDXLRi97BkJsn9oBtazW/0f+M0f+AknaeoWoh7M
         YxJKQUR8bXDeXcv1/8vEqwAbxfUGJ5XIGNoCDo1gqNvzAV0/Q3Cdz4nVQEd1729zQn3v
         OuPA==
X-Gm-Message-State: AOJu0YyXyrpIGazrRpA8iXwYDgKm5SFbnzRum8Vap1K5zqhK2d6hV31W
	ZOt5CvdKiBegH7+UAvIZKA+JhadPSeJwDdlKcnE/SQ==
X-Google-Smtp-Source: AGHT+IEvkgw6LJm/mcYkLc1VsiOkIYJX6Kxea82T6eA2OXkXZChHmTV16Xmy0fF3GWvVp8T+vKSNvWBCFlC5Xss1wBQ=
X-Received: by 2002:a25:25cc:0:b0:dbc:bf29:318b with SMTP id
 l195-20020a2525cc000000b00dbcbf29318bmr127534ybl.77.1702377431706; Tue, 12
 Dec 2023 02:37:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231127151931.47055-1-ulf.hansson@linaro.org> <CAJZ5v0jXRNDV7AhZPkrDvMtrk6cYeMJ+HuUs0kJ=kjbQ-YiyVA@mail.gmail.com>
In-Reply-To: <CAJZ5v0jXRNDV7AhZPkrDvMtrk6cYeMJ+HuUs0kJ=kjbQ-YiyVA@mail.gmail.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 12 Dec 2023 11:36:35 +0100
Message-ID: <CAPDyKFpJ6_+nF8q3L4Tg1E9St3stgJ06se0t=FLHkx4_36OJNA@mail.gmail.com>
Subject: Re: [PATCH] PM: domains: Drop the unused pm_genpd_opp_to_performance_state()
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: linux-pm@vger.kernel.org, Kevin Hilman <khilman@kernel.org>, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 11 Dec 2023 at 21:44, Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Mon, Nov 27, 2023 at 4:19=E2=80=AFPM Ulf Hansson <ulf.hansson@linaro.o=
rg> wrote:
> >
> > Since commit 7c41cdcd3bbe ("OPP: Simplify the over-designed pstate <->
> > level dance"), there is no longer any users of the
> > pm_genpd_opp_to_performance_state() API. Let's therefore drop it and it=
s
> > corresponding ->opp_to_performance_state() callback, which also no long=
er
> > has any users.
> >
> > Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
>
> I can take this in principle, but I'm wondering if you'd prefer to
> apply patches modifying domain.c yourself?  They are definitely
> related to the pmdomain tree.

Yes, it makes sense for me to pick the genpd core patches through the
pmdomain tree. In some cases there may be overlapping patches that are
more generic and not only limited to genpd, but I guess we can decide
on a case by case basis for those ones.

I can add the pmdomain tree to the GENERIC PM DOMAINS section in the
MAINTAINERS file to reflect this, if you think this is a good idea?

Kind regards
Uffe







>
> > ---
> >  drivers/base/power/domain.c | 32 --------------------------------
> >  include/linux/pm_domain.h   | 12 ------------
> >  2 files changed, 44 deletions(-)
> >
> > diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
> > index da1777e39eaa..cf65b5a9783c 100644
> > --- a/drivers/base/power/domain.c
> > +++ b/drivers/base/power/domain.c
> > @@ -3042,38 +3042,6 @@ int of_genpd_parse_idle_states(struct device_nod=
e *dn,
> >  }
> >  EXPORT_SYMBOL_GPL(of_genpd_parse_idle_states);
> >
> > -/**
> > - * pm_genpd_opp_to_performance_state - Gets performance state of the g=
enpd from its OPP node.
> > - *
> > - * @genpd_dev: Genpd's device for which the performance-state needs to=
 be found.
> > - * @opp: struct dev_pm_opp of the OPP for which we need to find perfor=
mance
> > - *     state.
> > - *
> > - * Returns performance state encoded in the OPP of the genpd. This cal=
ls
> > - * platform specific genpd->opp_to_performance_state() callback to tra=
nslate
> > - * power domain OPP to performance state.
> > - *
> > - * Returns performance state on success and 0 on failure.
> > - */
> > -unsigned int pm_genpd_opp_to_performance_state(struct device *genpd_de=
v,
> > -                                              struct dev_pm_opp *opp)
> > -{
> > -       struct generic_pm_domain *genpd =3D NULL;
> > -       int state;
> > -
> > -       genpd =3D container_of(genpd_dev, struct generic_pm_domain, dev=
);
> > -
> > -       if (unlikely(!genpd->opp_to_performance_state))
> > -               return 0;
> > -
> > -       genpd_lock(genpd);
> > -       state =3D genpd->opp_to_performance_state(genpd, opp);
> > -       genpd_unlock(genpd);
> > -
> > -       return state;
> > -}
> > -EXPORT_SYMBOL_GPL(pm_genpd_opp_to_performance_state);
> > -
> >  static int __init genpd_bus_init(void)
> >  {
> >         return bus_register(&genpd_bus_type);
> > diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
> > index 34663d0d5c55..b97c5e9820f9 100644
> > --- a/include/linux/pm_domain.h
> > +++ b/include/linux/pm_domain.h
> > @@ -118,7 +118,6 @@ struct genpd_power_state {
> >  };
> >
> >  struct genpd_lock_ops;
> > -struct dev_pm_opp;
> >  struct opp_table;
> >
> >  struct generic_pm_domain {
> > @@ -146,8 +145,6 @@ struct generic_pm_domain {
> >         int (*power_on)(struct generic_pm_domain *domain);
> >         struct raw_notifier_head power_notifiers; /* Power on/off notif=
iers */
> >         struct opp_table *opp_table;    /* OPP table of the genpd */
> > -       unsigned int (*opp_to_performance_state)(struct generic_pm_doma=
in *genpd,
> > -                                                struct dev_pm_opp *opp=
);
> >         int (*set_performance_state)(struct generic_pm_domain *genpd,
> >                                      unsigned int state);
> >         struct gpd_dev_ops dev_ops;
> > @@ -348,8 +345,6 @@ int of_genpd_remove_subdomain(struct of_phandle_arg=
s *parent_spec,
> >  struct generic_pm_domain *of_genpd_remove_last(struct device_node *np)=
;
> >  int of_genpd_parse_idle_states(struct device_node *dn,
> >                                struct genpd_power_state **states, int *=
n);
> > -unsigned int pm_genpd_opp_to_performance_state(struct device *genpd_de=
v,
> > -                                              struct dev_pm_opp *opp);
> >
> >  int genpd_dev_pm_attach(struct device *dev);
> >  struct device *genpd_dev_pm_attach_by_id(struct device *dev,
> > @@ -395,13 +390,6 @@ static inline int of_genpd_parse_idle_states(struc=
t device_node *dn,
> >         return -ENODEV;
> >  }
> >
> > -static inline unsigned int
> > -pm_genpd_opp_to_performance_state(struct device *genpd_dev,
> > -                                 struct dev_pm_opp *opp)
> > -{
> > -       return 0;
> > -}
> > -
> >  static inline int genpd_dev_pm_attach(struct device *dev)
> >  {
> >         return 0;
> > --
> > 2.34.1
> >

