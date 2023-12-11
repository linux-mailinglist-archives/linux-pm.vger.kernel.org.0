Return-Path: <linux-pm+bounces-916-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D757680DBE6
	for <lists+linux-pm@lfdr.de>; Mon, 11 Dec 2023 21:44:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5C548B20EA4
	for <lists+linux-pm@lfdr.de>; Mon, 11 Dec 2023 20:44:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E43153E3F;
	Mon, 11 Dec 2023 20:44:21 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF66F9F;
	Mon, 11 Dec 2023 12:44:18 -0800 (PST)
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-5909156aea9so499990eaf.0;
        Mon, 11 Dec 2023 12:44:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702327458; x=1702932258;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BeREiPriPrWtwP3pdr3EegoOX+dWJ7MdihH217BBpnA=;
        b=b9iNlsraf8aigEB920qwohqWgv8wvRjwe7d9rSpBTdDwGr4Rwf/Jk5CCnshCfkpN+u
         ssCSQ/ItgyU2xjPVtC1oETavsyTRxrs4x2FEySKuJD9QuCnoK6VhMLqCWmRnPj41Qmzq
         mUgj7ETfJKJ6kmfJSlBMLIOvCyzsU4XMkJMs3vXoffubuyxNf0gfGLRStAwqBsF+6lRo
         UQuawhmMxNg/62p5gml194emBjVPetaQRofKTgE0xaRCgHDxesk6QflJzphEbXdoan/3
         8zTYBNx+P8lgcTmCZMSJcpR9/MO04utvcYPk3UQIsaFU03ET/kEKuRCX9nYnGSKHjYje
         c0Zw==
X-Gm-Message-State: AOJu0Yxg3NOHo6RAURMMPEDnugds5rvQ+iNJCsXhkss0363RE+o3dp3y
	vw10ICAv7GzuVWkD9cmAdjODjBB0hXicVPW7jGQx5SHA
X-Google-Smtp-Source: AGHT+IF5nokFz42vvJTKNIHrAyvCr/vwnBehgSnRxhxX21ubnv0QG3aPj7gGukFBEADGhEhz6+xoJSL369lTIU4AoSU=
X-Received: by 2002:a4a:a7c4:0:b0:590:6585:5c41 with SMTP id
 n4-20020a4aa7c4000000b0059065855c41mr8414919oom.0.1702327457990; Mon, 11 Dec
 2023 12:44:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231127151931.47055-1-ulf.hansson@linaro.org>
In-Reply-To: <20231127151931.47055-1-ulf.hansson@linaro.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 11 Dec 2023 21:44:07 +0100
Message-ID: <CAJZ5v0jXRNDV7AhZPkrDvMtrk6cYeMJ+HuUs0kJ=kjbQ-YiyVA@mail.gmail.com>
Subject: Re: [PATCH] PM: domains: Drop the unused pm_genpd_opp_to_performance_state()
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org, 
	Kevin Hilman <khilman@kernel.org>, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 27, 2023 at 4:19=E2=80=AFPM Ulf Hansson <ulf.hansson@linaro.org=
> wrote:
>
> Since commit 7c41cdcd3bbe ("OPP: Simplify the over-designed pstate <->
> level dance"), there is no longer any users of the
> pm_genpd_opp_to_performance_state() API. Let's therefore drop it and its
> corresponding ->opp_to_performance_state() callback, which also no longer
> has any users.
>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

I can take this in principle, but I'm wondering if you'd prefer to
apply patches modifying domain.c yourself?  They are definitely
related to the pmdomain tree.

> ---
>  drivers/base/power/domain.c | 32 --------------------------------
>  include/linux/pm_domain.h   | 12 ------------
>  2 files changed, 44 deletions(-)
>
> diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
> index da1777e39eaa..cf65b5a9783c 100644
> --- a/drivers/base/power/domain.c
> +++ b/drivers/base/power/domain.c
> @@ -3042,38 +3042,6 @@ int of_genpd_parse_idle_states(struct device_node =
*dn,
>  }
>  EXPORT_SYMBOL_GPL(of_genpd_parse_idle_states);
>
> -/**
> - * pm_genpd_opp_to_performance_state - Gets performance state of the gen=
pd from its OPP node.
> - *
> - * @genpd_dev: Genpd's device for which the performance-state needs to b=
e found.
> - * @opp: struct dev_pm_opp of the OPP for which we need to find performa=
nce
> - *     state.
> - *
> - * Returns performance state encoded in the OPP of the genpd. This calls
> - * platform specific genpd->opp_to_performance_state() callback to trans=
late
> - * power domain OPP to performance state.
> - *
> - * Returns performance state on success and 0 on failure.
> - */
> -unsigned int pm_genpd_opp_to_performance_state(struct device *genpd_dev,
> -                                              struct dev_pm_opp *opp)
> -{
> -       struct generic_pm_domain *genpd =3D NULL;
> -       int state;
> -
> -       genpd =3D container_of(genpd_dev, struct generic_pm_domain, dev);
> -
> -       if (unlikely(!genpd->opp_to_performance_state))
> -               return 0;
> -
> -       genpd_lock(genpd);
> -       state =3D genpd->opp_to_performance_state(genpd, opp);
> -       genpd_unlock(genpd);
> -
> -       return state;
> -}
> -EXPORT_SYMBOL_GPL(pm_genpd_opp_to_performance_state);
> -
>  static int __init genpd_bus_init(void)
>  {
>         return bus_register(&genpd_bus_type);
> diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
> index 34663d0d5c55..b97c5e9820f9 100644
> --- a/include/linux/pm_domain.h
> +++ b/include/linux/pm_domain.h
> @@ -118,7 +118,6 @@ struct genpd_power_state {
>  };
>
>  struct genpd_lock_ops;
> -struct dev_pm_opp;
>  struct opp_table;
>
>  struct generic_pm_domain {
> @@ -146,8 +145,6 @@ struct generic_pm_domain {
>         int (*power_on)(struct generic_pm_domain *domain);
>         struct raw_notifier_head power_notifiers; /* Power on/off notifie=
rs */
>         struct opp_table *opp_table;    /* OPP table of the genpd */
> -       unsigned int (*opp_to_performance_state)(struct generic_pm_domain=
 *genpd,
> -                                                struct dev_pm_opp *opp);
>         int (*set_performance_state)(struct generic_pm_domain *genpd,
>                                      unsigned int state);
>         struct gpd_dev_ops dev_ops;
> @@ -348,8 +345,6 @@ int of_genpd_remove_subdomain(struct of_phandle_args =
*parent_spec,
>  struct generic_pm_domain *of_genpd_remove_last(struct device_node *np);
>  int of_genpd_parse_idle_states(struct device_node *dn,
>                                struct genpd_power_state **states, int *n)=
;
> -unsigned int pm_genpd_opp_to_performance_state(struct device *genpd_dev,
> -                                              struct dev_pm_opp *opp);
>
>  int genpd_dev_pm_attach(struct device *dev);
>  struct device *genpd_dev_pm_attach_by_id(struct device *dev,
> @@ -395,13 +390,6 @@ static inline int of_genpd_parse_idle_states(struct =
device_node *dn,
>         return -ENODEV;
>  }
>
> -static inline unsigned int
> -pm_genpd_opp_to_performance_state(struct device *genpd_dev,
> -                                 struct dev_pm_opp *opp)
> -{
> -       return 0;
> -}
> -
>  static inline int genpd_dev_pm_attach(struct device *dev)
>  {
>         return 0;
> --
> 2.34.1
>

