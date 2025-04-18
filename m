Return-Path: <linux-pm+bounces-25679-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 45972A92EF1
	for <lists+linux-pm@lfdr.de>; Fri, 18 Apr 2025 02:51:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9FDA41896E92
	for <lists+linux-pm@lfdr.de>; Fri, 18 Apr 2025 00:51:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B02091E4A9;
	Fri, 18 Apr 2025 00:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="t/c1jUM6"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE78C8836
	for <linux-pm@vger.kernel.org>; Fri, 18 Apr 2025 00:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744937487; cv=none; b=iawD2OezUQrLWzugO9naN46BYdklh1kfNuYno2w2Sc0MORidPOXSu5MKzlBwHjC+apTvdNpzV52B2Y7BNx5ZnurIYn6RXHjaPv4sval26qCJsiJgKq0ldxIomw8XEP9wOAUtN7D0lVz3Y7YnWdQuDsxUnXEpOcYPO4B+jpRWoHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744937487; c=relaxed/simple;
	bh=pmfJz9HOSf1YHC9miy/q7VstUc493X2MClNIJeftUNc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eAF09jgrKJp4lMELyqHJGpYPzVkK7Skb8P/m+GiRie5gyU8c1pQGHap5yHQoE4OPC8e8TG/iDtk3ZdpoApEMjNojCxYpC/fUOocXQm3qrhMopEPWJuvr5EsNGvP5tucrS5etJnkdS0gwqypOdo3W3/JSZJcwjD9v3PpjsXpYmPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=t/c1jUM6; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-3105ef2a06cso13050461fa.2
        for <linux-pm@vger.kernel.org>; Thu, 17 Apr 2025 17:51:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1744937484; x=1745542284; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=espvvwCOUsOaiPeW4qBVlqsEGI9VvnOEfzXFD5TrphU=;
        b=t/c1jUM6bVMTHbMcmmsIMoOd76eAwN31S1nnOr+V4HrcusDb7UPRbA0BGP3dFttHX/
         D1/IL3/p5FzSG6rTdlUtzC6T9HnBqFBjDi3Zf6sgm5Fg8rpH8pEiBnoWD8w7mWhSX1/s
         7KYkA2Flf4PLTzn1wAwpA0Ef/bpXdSwdhxNt3lMkoo/elgwPMNVqgeYIRgOGFSz8meHF
         RegCVUfE7gk4kg9j8CO9+4Dg6iTXBDkBtX3VrYIXQBZSvOmW9P282oVPohZCn8+mcptL
         uWvartwdU/4J7xZXAOV3JFpt/jJEdpgaguW3vo6GjVOOeDoXzxsYu5jiQUN9PjkOYXbA
         LzaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744937484; x=1745542284;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=espvvwCOUsOaiPeW4qBVlqsEGI9VvnOEfzXFD5TrphU=;
        b=g0HDJ6BsnDd6Fdsq+PMbaSLV4VwkQdQsZpfChU8V1/lo7ishM1No7HtZ5mGvgQvN/k
         uoWdl+bE+aw7nOqWvS0Tz5HLrqLHVN+gJgijbbsIU5f5jPZmXZpgOSnfiQp758ahm56J
         H81r9wY6cS3qRz4v96mQJJpRwfP3gmJ/VxqCDFJRLiiBmvgeq951k+Er6Usg8NWw3zuM
         cKxAx2WbQ3HmZVn4EyRwHiEYIbPDVJjjTtWG9EP+zLfTSKKR7Wm5KSmJidMwGAL6CGKf
         GOmxPOHVX2DDMJQFVi6q2TBJvli6V8um5iE4HX3coAvRS4QWBc6E86sjHud5sIVWK0Bo
         nngg==
X-Forwarded-Encrypted: i=1; AJvYcCVZQY/mOP3eY1ty8t5RLHnyYRtP4f6t4pabMQk9CHl+G41nuwdWo0mLGxIZgog7GqX9S8JQcIeufQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwMezNfLWmbYDcoe77OTiuDF6tGwHx/+HkrWb2hgy7O65Qcbss/
	ZqJ7PMCh074NKyIdQPkqaUkuP+FnQViWz9VfcPPZpcYpSBFDnMkKRj1IxMiqVdTDvL4G1o1RKv8
	WHKQGWWEa7zQqjf/tYxLfNRICQYBn5zl6/HPD
X-Gm-Gg: ASbGnct06n/EH20EFRdMUZPULzMdnr20K5ago2K1740+rn4eI4D1QBnRYV3Ad8MOtKx
	fV2Qlru3y/bi2itY9j4Lv1kaB5pYyNAQfKJhLBeFriSbMgiBmiFEnRMFCwG0N0Aje+LNyfEE9lV
	5ojrjnZ05DaMh6DnM6lWGU0DQZRjv9Y6wck9IhWIjz4ER+Ll8=
X-Google-Smtp-Source: AGHT+IE/wqWU+kEJ+uNl1lu0U9l4Nd/hTZwOvDN4HtDxpaQCKOIhack1E/1QtP4XZ5jNQUL4f+oT4lDAZLRZaMBAPC4=
X-Received: by 2002:a2e:bc86:0:b0:30c:40d6:5cdb with SMTP id
 38308e7fff4ca-310904dba7cmr3095251fa.11.1744937483536; Thu, 17 Apr 2025
 17:51:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250417142513.312939-1-ulf.hansson@linaro.org> <20250417142513.312939-12-ulf.hansson@linaro.org>
In-Reply-To: <20250417142513.312939-12-ulf.hansson@linaro.org>
From: Saravana Kannan <saravanak@google.com>
Date: Thu, 17 Apr 2025 17:50:45 -0700
X-Gm-Features: ATxdqUG3nsZ8r4b4j3azqOjFpPct1ZcFhXbrqEnzX0WXjS0gXoFni5vfKcox8w4
Message-ID: <CAGETcx_hQRr1hRQD0vyAN9bhZRx+763zfHUG0oBi0sqFUi85pA@mail.gmail.com>
Subject: Re: [PATCH 11/11] pmdomain: core: Leave powered-on genpds on until ->sync_state()
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Stephen Boyd <sboyd@kernel.org>, linux-pm@vger.kernel.org, 
	"Rafael J . Wysocki" <rafael@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Michael Grzeschik <m.grzeschik@pengutronix.de>, Bjorn Andersson <andersson@kernel.org>, 
	Abel Vesa <abel.vesa@linaro.org>, Devarsh Thakkar <devarsht@lewv0571a.ent.ti.com>, 
	Peng Fan <peng.fan@oss.nxp.com>, Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>, 
	Johan Hovold <johan@kernel.org>, Maulik Shah <maulik.shah@oss.qualcomm.com>, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 17, 2025 at 7:25=E2=80=AFAM Ulf Hansson <ulf.hansson@linaro.org=
> wrote:
>
> Powering-off a genpd that was on during boot, before all of its consumer
> devices have been probed, is certainly prone to problems.
>
> Let's fix these problems by preventing these genpds from being powered-of=
f
> until ->sync_state(). Note that, this only works for OF based platform as
> ->sync_state() are relying on fw_devlink.

For non-OF platforms, this will still wait until late_initcall(). So,
there's at least SOME protection. We could potentially even move that
to happen after deferred probe timeout expires.

-Saravana

>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---
>  drivers/pmdomain/core.c   | 12 +++++++++++-
>  include/linux/pm_domain.h |  1 +
>  2 files changed, 12 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/pmdomain/core.c b/drivers/pmdomain/core.c
> index 695d7d9e5582..a8c56f7a7ba0 100644
> --- a/drivers/pmdomain/core.c
> +++ b/drivers/pmdomain/core.c
> @@ -212,6 +212,12 @@ static inline bool irq_safe_dev_in_sleep_domain(stru=
ct device *dev,
>         return ret;
>  }
>
> +#ifdef CONFIG_PM_GENERIC_DOMAINS_OF
> +static bool genpd_may_stay_on(bool on) { return on; }
> +#else
> +static bool genpd_may_stay_on(bool on) { return false; }
> +#endif
> +
>  static int genpd_runtime_suspend(struct device *dev);
>
>  /*
> @@ -933,11 +939,12 @@ static void genpd_power_off(struct generic_pm_domai=
n *genpd, bool one_dev_on,
>          * The domain is already in the "power off" state.
>          * System suspend is in progress.
>          * The domain is configured as always on.
> +        * The domain was on at boot and still need to stay on.
>          * The domain has a subdomain being powered on.
>          */
>         if (!genpd_status_on(genpd) || genpd->prepared_count > 0 ||
>             genpd_is_always_on(genpd) || genpd_is_rpm_always_on(genpd) ||
> -           atomic_read(&genpd->sd_count) > 0)
> +           genpd->stay_on || atomic_read(&genpd->sd_count) > 0)
>                 return;
>
>         /*
> @@ -2374,6 +2381,7 @@ int pm_genpd_init(struct generic_pm_domain *genpd,
>         INIT_WORK(&genpd->power_off_work, genpd_power_off_work_fn);
>         atomic_set(&genpd->sd_count, 0);
>         genpd->status =3D is_off ? GENPD_STATE_OFF : GENPD_STATE_ON;
> +       genpd->stay_on =3D genpd_may_stay_on(!is_off);
>         genpd->sync_state =3D GENPD_SYNC_STATE_OFF;
>         genpd->device_count =3D 0;
>         genpd->provider =3D NULL;
> @@ -2640,6 +2648,7 @@ void of_genpd_sync_state(struct device *dev)
>         list_for_each_entry(genpd, &gpd_list, gpd_list_node) {
>                 if (genpd->provider =3D=3D &np->fwnode) {
>                         genpd_lock(genpd);
> +                       genpd->stay_on =3D false;
>                         genpd_power_off(genpd, false, 0);
>                         genpd_unlock(genpd);
>                 }
> @@ -3486,6 +3495,7 @@ static void genpd_provider_sync_state(struct device=
 *dev)
>
>         case GENPD_SYNC_STATE_SIMPLE:
>                 genpd_lock(genpd);
> +               genpd->stay_on =3D false;
>                 genpd_power_off(genpd, false, 0);
>                 genpd_unlock(genpd);
>                 break;
> diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
> index 2185ee9e4f7c..c5358cccacad 100644
> --- a/include/linux/pm_domain.h
> +++ b/include/linux/pm_domain.h
> @@ -193,6 +193,7 @@ struct generic_pm_domain {
>         unsigned int performance_state; /* Aggregated max performance sta=
te */
>         cpumask_var_t cpus;             /* A cpumask of the attached CPUs=
 */
>         bool synced_poweroff;           /* A consumer needs a synced powe=
roff */
> +       bool stay_on;                   /* Stay powered-on during boot. *=
/
>         enum genpd_sync_state sync_state; /* How sync_state is managed. *=
/
>         int (*power_off)(struct generic_pm_domain *domain);
>         int (*power_on)(struct generic_pm_domain *domain);
> --
> 2.43.0
>

