Return-Path: <linux-pm+bounces-1052-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 50E6E810E80
	for <lists+linux-pm@lfdr.de>; Wed, 13 Dec 2023 11:34:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 820D51C20930
	for <lists+linux-pm@lfdr.de>; Wed, 13 Dec 2023 10:34:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EF26224FE;
	Wed, 13 Dec 2023 10:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Al5DynLs"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F635AF
	for <linux-pm@vger.kernel.org>; Wed, 13 Dec 2023 02:34:20 -0800 (PST)
Received: by mail-yb1-xb2e.google.com with SMTP id 3f1490d57ef6-dbcd4637b05so217314276.1
        for <linux-pm@vger.kernel.org>; Wed, 13 Dec 2023 02:34:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702463659; x=1703068459; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=MiCuJGdqU3JpN4sR605F4gpjnmDDPjE+WkJpEGI+07w=;
        b=Al5DynLsK6MMCjJWHslSzhx12RKhrjNpAUjEmg7JHVtivmWyGFFvHz+26d4Gg7ZPHq
         b8zTTDneMkAgxCaYVQAsG6zFctO1tHB3gXkDnOPC+yn/iEXIuSRtsTej9pQtwn8y3DZU
         TfwBS+XbOPskq8SkH1UhjmhHpZbCAqp6aQaHZTBUn2RhNVFi1RVPAEHal/ZHKuMyl+KD
         7TMieGoAXcirKaDllxlkDSoi11gD8S+qJ7Cj/x6RjQSUZ9lpVU5yjU8CMdBYQknzlOjc
         7l+Xy+gg1YKyGHAyWvun9eEWAFx0awHSGmWTdQfdoO8x4gS9xpjeGcbTCIAy5ML4EP1h
         7G8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702463659; x=1703068459;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MiCuJGdqU3JpN4sR605F4gpjnmDDPjE+WkJpEGI+07w=;
        b=BCq4n7+rmsEPO3RnJKXfVnvd3+VBAyPjbGSFxcODUy0IXoIbtjFGDgMgkFcBDHofmL
         vLX7MyoCcy7+9GgCVnx4w9LQVEehbYT6qKNStD2/p1mBkpr74zeQPqc9QTEaAHMVHw7q
         H59eq5pCI5iyKdGQB+ojILZIRZa/HT/usz2Wk/hUIjnIJZHWYcFSgwjEHNzPKF6RJdOJ
         WBP5ba7jliECzIztMjQ3zy1AKPU/l+d3wLUiqoUQmT3g8v1eljByocpwk7KRIU0n5kfB
         MIdfW4Q42oZPS3AcfEELWxrUJEZMn22FGo0kKQy4BDd6X/coIT36kd6dl2NsYMAUs8WH
         LqAA==
X-Gm-Message-State: AOJu0YyemxQrpQrvYW7flTEUjXfoPmDxFsj7nrmTBUqqDxwBMh+UHC7X
	qnoxPZ/xjJiE/oMBpNAA/s8cuaphkyUotvmuUEdAjA==
X-Google-Smtp-Source: AGHT+IFgD1jVe3bhFgxKF39rvDQ+ntKZdf/plcoM/+rcHzXjRXeTMPPO0CRFY6Bnj0jPZjnuV1UQVLT74ShuhRh7MPg=
X-Received: by 2002:a25:bec3:0:b0:db5:49d8:bcd1 with SMTP id
 k3-20020a25bec3000000b00db549d8bcd1mr4676061ybm.55.1702463659338; Wed, 13 Dec
 2023 02:34:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231127151931.47055-1-ulf.hansson@linaro.org>
In-Reply-To: <20231127151931.47055-1-ulf.hansson@linaro.org>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Wed, 13 Dec 2023 11:33:43 +0100
Message-ID: <CAPDyKFofR7AHDctZErs3QG_mXdnhY+yjqNYungim+yeLpx1gBQ@mail.gmail.com>
Subject: Re: [PATCH] PM: domains: Drop the unused pm_genpd_opp_to_performance_state()
To: "Rafael J . Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org
Cc: Kevin Hilman <khilman@kernel.org>, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 27 Nov 2023 at 16:19, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> Since commit 7c41cdcd3bbe ("OPP: Simplify the over-designed pstate <->
> level dance"), there is no longer any users of the
> pm_genpd_opp_to_performance_state() API. Let's therefore drop it and its
> corresponding ->opp_to_performance_state() callback, which also no longer
> has any users.
>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

So, I have applied this for next and by adding your ack.

Kind regards
Uffe


> ---
>  drivers/base/power/domain.c | 32 --------------------------------
>  include/linux/pm_domain.h   | 12 ------------
>  2 files changed, 44 deletions(-)
>
> diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
> index da1777e39eaa..cf65b5a9783c 100644
> --- a/drivers/base/power/domain.c
> +++ b/drivers/base/power/domain.c
> @@ -3042,38 +3042,6 @@ int of_genpd_parse_idle_states(struct device_node *dn,
>  }
>  EXPORT_SYMBOL_GPL(of_genpd_parse_idle_states);
>
> -/**
> - * pm_genpd_opp_to_performance_state - Gets performance state of the genpd from its OPP node.
> - *
> - * @genpd_dev: Genpd's device for which the performance-state needs to be found.
> - * @opp: struct dev_pm_opp of the OPP for which we need to find performance
> - *     state.
> - *
> - * Returns performance state encoded in the OPP of the genpd. This calls
> - * platform specific genpd->opp_to_performance_state() callback to translate
> - * power domain OPP to performance state.
> - *
> - * Returns performance state on success and 0 on failure.
> - */
> -unsigned int pm_genpd_opp_to_performance_state(struct device *genpd_dev,
> -                                              struct dev_pm_opp *opp)
> -{
> -       struct generic_pm_domain *genpd = NULL;
> -       int state;
> -
> -       genpd = container_of(genpd_dev, struct generic_pm_domain, dev);
> -
> -       if (unlikely(!genpd->opp_to_performance_state))
> -               return 0;
> -
> -       genpd_lock(genpd);
> -       state = genpd->opp_to_performance_state(genpd, opp);
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
>         struct raw_notifier_head power_notifiers; /* Power on/off notifiers */
>         struct opp_table *opp_table;    /* OPP table of the genpd */
> -       unsigned int (*opp_to_performance_state)(struct generic_pm_domain *genpd,
> -                                                struct dev_pm_opp *opp);
>         int (*set_performance_state)(struct generic_pm_domain *genpd,
>                                      unsigned int state);
>         struct gpd_dev_ops dev_ops;
> @@ -348,8 +345,6 @@ int of_genpd_remove_subdomain(struct of_phandle_args *parent_spec,
>  struct generic_pm_domain *of_genpd_remove_last(struct device_node *np);
>  int of_genpd_parse_idle_states(struct device_node *dn,
>                                struct genpd_power_state **states, int *n);
> -unsigned int pm_genpd_opp_to_performance_state(struct device *genpd_dev,
> -                                              struct dev_pm_opp *opp);
>
>  int genpd_dev_pm_attach(struct device *dev);
>  struct device *genpd_dev_pm_attach_by_id(struct device *dev,
> @@ -395,13 +390,6 @@ static inline int of_genpd_parse_idle_states(struct device_node *dn,
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

