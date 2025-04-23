Return-Path: <linux-pm+bounces-26011-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B5703A9817E
	for <lists+linux-pm@lfdr.de>; Wed, 23 Apr 2025 09:47:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D1DC0189A267
	for <lists+linux-pm@lfdr.de>; Wed, 23 Apr 2025 07:47:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81B10267383;
	Wed, 23 Apr 2025 07:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XEiwK0Dq"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA74518D63A
	for <linux-pm@vger.kernel.org>; Wed, 23 Apr 2025 07:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745394435; cv=none; b=rOYeOr7HyDJR8LOiR39gNtFHFwsHtM77kBJYHIr7O01UGnMfFAC7LN00dxqTLgDnJeU8AnRNOt4oEzyOsodsSUxEfI2aYtPo6QhSiz9Q9+diV8Cses2zulXYMAU0LAidp2FQK5jzkFNvrgfiecNn4EnVvjci0gzh73rEMOogBAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745394435; c=relaxed/simple;
	bh=idezHrxL8iT6WyB59666TSLYbxBALAVQXAu+2zp6U6o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AD4bKOQg9ZzyHUKxDOZgT43Bi8RIewVBD73+gBFl2kPQ6RDmDRzTxrGyeUKVc5ejnO084iHAqeY7XkhJJmJLruP+ywiQjcuJX7IqHK9hNsgSbJZtRr5H1oKJBqZ21PVR9V1ADUgvAePfDC92IdZrzrsolfSWJCE8UBNMDWsOk+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=XEiwK0Dq; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-6ff07872097so57567267b3.3
        for <linux-pm@vger.kernel.org>; Wed, 23 Apr 2025 00:47:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1745394432; x=1745999232; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JHGMFL0fUvT51G5doXrMDZ4P+H09IeAYckYXE5kSZCE=;
        b=XEiwK0DqyfSy44ha50y1L7JQg/OoyLf7p+9YWPSZEBMlXXurVmAT3uKlWnyIvVthwm
         3wwoIpIuralyGl4mjEgCNsNg7+VKowcHE5gb69IKLNEsAdBH/+YIUx41nXM1Oh5paKhl
         G70igNy6YkY58/4p51uCw4xz9hI+lMn59OIbdH5zi4KJGBzyVDFJ0C/ECKrjhf+56Nni
         AL6DaURcTUeOEq6MbCUvgM+L7kTN5zNznlP9pQufyz55k4I6uLjswoGhaVi/m3feaZh/
         l2IVs2cHowof9qKI+Bjsmh0owpqwmbTSLQltS8QoPdRn2IVwMH+zYOnd04JzGfvhDxHZ
         Wrjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745394432; x=1745999232;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JHGMFL0fUvT51G5doXrMDZ4P+H09IeAYckYXE5kSZCE=;
        b=vbEAyQBVQEvYxhWxzbcLR4fcuBKQ8X0vI0UjZeddzDd0oaCS8uNyOj0RlhzONkFqVx
         a2TEa7g1WGt8dehf9dpV3IYGi5quzQQjsGc39tCYA1s6qUMHcUD++b4bDitE42Jr07dt
         PQoCilxSFsejB9Mz0nz1kK3a0XBFVzhV7eTE/kuA2iENQvGu5StF7+8oewbV+8jEufSQ
         sOdc+Qc0GqKtERl++6WihfxtLeww39g5u71fVfjloUn/2mPDikKGb6f9S3ADYO2xteXP
         tJ2VxWeYE6a14oLe/rBwraj0e7kxPXvKjz3aZXWAH4bXuRelsPE9SoL9stzrAduspUA4
         dcyw==
X-Forwarded-Encrypted: i=1; AJvYcCW2+FlFB/IoXrVez+7Ye9cR6NAzS+FqS9Mrg0bYsbdzI6YkN6LZbebGxb19S82FBNg+rbkl+LN+eA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxFMLOpWa3jafHcyoFTMnCh8C4CA3Mo2H8GR2YD0FPZwDTJ9dv7
	uYT7K7dUbKVWepXZdPvGnsNiPG1+wIifQgndsqC19fhQl8VsuGML8C4LncG2lAevS/FB6g82j8f
	WXvgVCUxWUK0aKnswaN+Oi56B7o0n6xw1nkoBiA==
X-Gm-Gg: ASbGncuWQeU0hJIh0F6D5ZJQBwpucXGK2RNQc55RTtnDz3knpzTgIGTFWdnui5GhujT
	h9H/Vxe/DvW05gzAOeYIIDwIOkOQYSiibsqcvn+73kRgeuOctvwNoyA2HIEA7xxK2MnKWUgsZSi
	66epOnrqxUP+O64PIozjn4NQ==
X-Google-Smtp-Source: AGHT+IEIsuGeT70VcTTtBNp0FoTy4Z2BzN/eP/3me52qwbQRMCmDjAmuOo6CONr2SdNAR783FwZ/SpPV+be9CTnuF48=
X-Received: by 2002:a05:690c:7344:b0:6fb:2c34:8ee4 with SMTP id
 00721157ae682-706ccce4bc4mr266811177b3.13.1745394432562; Wed, 23 Apr 2025
 00:47:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250417142513.312939-1-ulf.hansson@linaro.org>
 <20250417142513.312939-12-ulf.hansson@linaro.org> <CAGETcx_hQRr1hRQD0vyAN9bhZRx+763zfHUG0oBi0sqFUi85pA@mail.gmail.com>
In-Reply-To: <CAGETcx_hQRr1hRQD0vyAN9bhZRx+763zfHUG0oBi0sqFUi85pA@mail.gmail.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Wed, 23 Apr 2025 09:46:36 +0200
X-Gm-Features: ATxdqUFpGCWv8eNSiRWf2Ei2Irds9OMqUnTlzN0BIWYYRzIieJAOU8hDoreYi_s
Message-ID: <CAPDyKFqS-rOv6cMDUWwJS=B4uMdpOK2FvE23z+jsU4V1zXNG7w@mail.gmail.com>
Subject: Re: [PATCH 11/11] pmdomain: core: Leave powered-on genpds on until ->sync_state()
To: Saravana Kannan <saravanak@google.com>
Cc: Stephen Boyd <sboyd@kernel.org>, linux-pm@vger.kernel.org, 
	"Rafael J . Wysocki" <rafael@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Michael Grzeschik <m.grzeschik@pengutronix.de>, Bjorn Andersson <andersson@kernel.org>, 
	Abel Vesa <abel.vesa@linaro.org>, Devarsh Thakkar <devarsht@lewv0571a.ent.ti.com>, 
	Peng Fan <peng.fan@oss.nxp.com>, Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>, 
	Johan Hovold <johan@kernel.org>, Maulik Shah <maulik.shah@oss.qualcomm.com>, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 18 Apr 2025 at 02:51, Saravana Kannan <saravanak@google.com> wrote:
>
> On Thu, Apr 17, 2025 at 7:25=E2=80=AFAM Ulf Hansson <ulf.hansson@linaro.o=
rg> wrote:
> >
> > Powering-off a genpd that was on during boot, before all of its consume=
r
> > devices have been probed, is certainly prone to problems.
> >
> > Let's fix these problems by preventing these genpds from being powered-=
off
> > until ->sync_state(). Note that, this only works for OF based platform =
as
> > ->sync_state() are relying on fw_devlink.
>
> For non-OF platforms, this will still wait until late_initcall(). So,
> there's at least SOME protection. We could potentially even move that
> to happen after deferred probe timeout expires.

If I understand correctly, you are suggesting that we could update
genpd_power_off_unused() (late_initcall_sync) to clear genpd->stay_on
for the non-OF case? That should work I think.

>
> -Saravana

Kind regards
Uffe

>
> >
> > Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> > ---
> >  drivers/pmdomain/core.c   | 12 +++++++++++-
> >  include/linux/pm_domain.h |  1 +
> >  2 files changed, 12 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/pmdomain/core.c b/drivers/pmdomain/core.c
> > index 695d7d9e5582..a8c56f7a7ba0 100644
> > --- a/drivers/pmdomain/core.c
> > +++ b/drivers/pmdomain/core.c
> > @@ -212,6 +212,12 @@ static inline bool irq_safe_dev_in_sleep_domain(st=
ruct device *dev,
> >         return ret;
> >  }
> >
> > +#ifdef CONFIG_PM_GENERIC_DOMAINS_OF
> > +static bool genpd_may_stay_on(bool on) { return on; }
> > +#else
> > +static bool genpd_may_stay_on(bool on) { return false; }
> > +#endif
> > +
> >  static int genpd_runtime_suspend(struct device *dev);
> >
> >  /*
> > @@ -933,11 +939,12 @@ static void genpd_power_off(struct generic_pm_dom=
ain *genpd, bool one_dev_on,
> >          * The domain is already in the "power off" state.
> >          * System suspend is in progress.
> >          * The domain is configured as always on.
> > +        * The domain was on at boot and still need to stay on.
> >          * The domain has a subdomain being powered on.
> >          */
> >         if (!genpd_status_on(genpd) || genpd->prepared_count > 0 ||
> >             genpd_is_always_on(genpd) || genpd_is_rpm_always_on(genpd) =
||
> > -           atomic_read(&genpd->sd_count) > 0)
> > +           genpd->stay_on || atomic_read(&genpd->sd_count) > 0)
> >                 return;
> >
> >         /*
> > @@ -2374,6 +2381,7 @@ int pm_genpd_init(struct generic_pm_domain *genpd=
,
> >         INIT_WORK(&genpd->power_off_work, genpd_power_off_work_fn);
> >         atomic_set(&genpd->sd_count, 0);
> >         genpd->status =3D is_off ? GENPD_STATE_OFF : GENPD_STATE_ON;
> > +       genpd->stay_on =3D genpd_may_stay_on(!is_off);
> >         genpd->sync_state =3D GENPD_SYNC_STATE_OFF;
> >         genpd->device_count =3D 0;
> >         genpd->provider =3D NULL;
> > @@ -2640,6 +2648,7 @@ void of_genpd_sync_state(struct device *dev)
> >         list_for_each_entry(genpd, &gpd_list, gpd_list_node) {
> >                 if (genpd->provider =3D=3D &np->fwnode) {
> >                         genpd_lock(genpd);
> > +                       genpd->stay_on =3D false;
> >                         genpd_power_off(genpd, false, 0);
> >                         genpd_unlock(genpd);
> >                 }
> > @@ -3486,6 +3495,7 @@ static void genpd_provider_sync_state(struct devi=
ce *dev)
> >
> >         case GENPD_SYNC_STATE_SIMPLE:
> >                 genpd_lock(genpd);
> > +               genpd->stay_on =3D false;
> >                 genpd_power_off(genpd, false, 0);
> >                 genpd_unlock(genpd);
> >                 break;
> > diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
> > index 2185ee9e4f7c..c5358cccacad 100644
> > --- a/include/linux/pm_domain.h
> > +++ b/include/linux/pm_domain.h
> > @@ -193,6 +193,7 @@ struct generic_pm_domain {
> >         unsigned int performance_state; /* Aggregated max performance s=
tate */
> >         cpumask_var_t cpus;             /* A cpumask of the attached CP=
Us */
> >         bool synced_poweroff;           /* A consumer needs a synced po=
weroff */
> > +       bool stay_on;                   /* Stay powered-on during boot.=
 */
> >         enum genpd_sync_state sync_state; /* How sync_state is managed.=
 */
> >         int (*power_off)(struct generic_pm_domain *domain);
> >         int (*power_on)(struct generic_pm_domain *domain);
> > --
> > 2.43.0
> >

