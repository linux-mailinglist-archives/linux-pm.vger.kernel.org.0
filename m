Return-Path: <linux-pm+bounces-26014-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D9C5BA9823E
	for <lists+linux-pm@lfdr.de>; Wed, 23 Apr 2025 10:07:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E7C1B441449
	for <lists+linux-pm@lfdr.de>; Wed, 23 Apr 2025 08:07:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1734D270575;
	Wed, 23 Apr 2025 07:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rl8Ymkaf"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D0C526B966
	for <linux-pm@vger.kernel.org>; Wed, 23 Apr 2025 07:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745395127; cv=none; b=UIelLW+VKM121vMTcZlwzJ50eyLy4mUCe5Sg/9Bgg96qq0A8UvTEuacLAp3bvpRjPgpuO3RNSvOnDgIcwhgi09Kl8XeHmiAiJDfRBISUxZLBIcwckQQVrr15ZEbBkUesoMEmjWlYty0ANCfMjhs37pK1uxQGDNIYf2BNhUgVdp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745395127; c=relaxed/simple;
	bh=X+aUROIJbDq0/WVAsN/aL3+kk/RTavZCUl3H6Q6PUsI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qHRVHXVV2X4I31gjIIgWG5CpYbszyktS69UeMZh6YOqhidYWN/Y9jNQlmMKeKvMP2k0sX/zIfJX3uRTk+dbGDl6shB7b7WzTGxOvtCoyKgD5AGwxfpNn783YftIqL8vWbZvkUY2uv+p1hEZ22vQoUrDsz8FnjfxVxKix4H1epRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=rl8Ymkaf; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-6ff37565232so51143107b3.3
        for <linux-pm@vger.kernel.org>; Wed, 23 Apr 2025 00:58:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1745395124; x=1745999924; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=98OKaYF4tpZApGWukE9uaoalFuC45/rEeEJt/zz+1to=;
        b=rl8Ymkaf2QJ1lpB1Y4CEiiBHzPc7ZAu3PwB/+KD69X81DPnswVFjtZlk8QdU/93+P9
         PtPfCq49madHiOFb7BJsQSyUi4cvg2u4I+wC+ydfQZ+U7neKUPVcdNpHvlQZcRvoZTWC
         GAnkZHN6UuLAyqhcg/3iMxTkc60F4K//EwdlWyj6y9ObC+fmQkphoSuPc5xdPcRAH8E8
         wq3SFIIamFYp7h80RGwdgZ0+MuxJ/YXFBSjfmb71ahNHG4xz/VHZG33GSrPpH56BJ33i
         dKZIGDl79SP3jUDe2Fi3bNOZVpFQHRKl9ZboyBDq4kUiTWh17ZC2wJzrIxBduNGic240
         mQyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745395124; x=1745999924;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=98OKaYF4tpZApGWukE9uaoalFuC45/rEeEJt/zz+1to=;
        b=QyhX7vRjCw6BacGTbUNp42zkBjIe13WdsEKLDB+xMLqhqCBd+E5fezG8wPM/3s5mk9
         SqxN1zLyhVWvPUEIKVJgwQMXHwSLHwcQKDspXiM/UafDvvGD29O9ockNWtAS0J4i5GDm
         rjU2pCipQDoJ1yjDzR5qzLOizXJe4OcObtTLHDIaNazvKaXrkFryCPUpgBlumPYcvK++
         m/R+ox2Q1QYd36ErxDFnW2pCU2fKjm8u80dL/NX4S8LFmIsldixTRWEZyNQsUPRv9r+k
         3i0+HoUxhW1jY0VlR5Yr0bnMDuCDQy/8QWI2gNMo/+uPP4qzWeW1qxfSXgRvMhFyUzNI
         +x1g==
X-Forwarded-Encrypted: i=1; AJvYcCWjWy/jO0IyU3A/vkVj7JuDLSztbSnz+dMh8PTH/DmpIlTJTbt/qB43tOgZh7KM57TykjECMKn+8g==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywm2/lb6qcsQI11yLo9POkvFMH4StTVbc5JNpJZpbcJR1FCGFHJ
	y3XBxqO8/mwPdLv89tXwRRSKPcV4nXeDKFwQKmW6FrIEalSHaYDIuRBwNjlK5isElKt7ksXz6Dz
	a69Ag8ASzTU+s9r8aSkgMAs1ljWYwcNRIOBsbag==
X-Gm-Gg: ASbGncuLhB2cdpYy/BiztXNIJOTxXNhBT0EKVWJ8U1ufBdaVJfi4n1R/Ris4THVEOBq
	MX44Tb6xTHZfJbv+WNiMoEgPyKaLSy0TgqyALj3nfPiDK4cJOdzqah/qwFWHhouAfH5b/ETfD2y
	6znFabswza+mllaNzYl6G5Jg==
X-Google-Smtp-Source: AGHT+IEid6abI3qyjvwJVFhFo6K8MH5FI0X29/TyKFu7qItzM19P/8jYPPedtCkMFzrRPgTlj3DcfgKz+l+YCjA6mJo=
X-Received: by 2002:a05:690c:d07:b0:6f7:5605:c62b with SMTP id
 00721157ae682-706ccdc6cf9mr271103927b3.27.1745395123911; Wed, 23 Apr 2025
 00:58:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250417142513.312939-1-ulf.hansson@linaro.org>
 <20250417142513.312939-9-ulf.hansson@linaro.org> <CAGETcx9rvTWPbDCnTLb+ToVk8BMipTa1Y14vpn=bPBkM=CjoZg@mail.gmail.com>
In-Reply-To: <CAGETcx9rvTWPbDCnTLb+ToVk8BMipTa1Y14vpn=bPBkM=CjoZg@mail.gmail.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Wed, 23 Apr 2025 09:58:08 +0200
X-Gm-Features: ATxdqUF5401xpyLBZD02333wpwgBQly_TMiuPAqVbNXp07uH7DpC68Wtyaxt4dM
Message-ID: <CAPDyKFoxggSnRZxQ7QBbF2-akoj8TTMGawxeH_0ZnPQ7CBCnUA@mail.gmail.com>
Subject: Re: [PATCH 08/11] pmdomain: core: Add internal ->sync_state() support
 for genpd providers
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

On Fri, 18 Apr 2025 at 02:24, Saravana Kannan <saravanak@google.com> wrote:
>
> On Thu, Apr 17, 2025 at 7:25=E2=80=AFAM Ulf Hansson <ulf.hansson@linaro.o=
rg> wrote:
> >
> > If the genpd provider's fwnode doesn't have an associated struct device
> > with it, we can make use of the generic genpd->dev and it corresponding
> > driver internally in genpd to manage ->sync_state().
> >
> > More precisely, while adding a genpd OF provider let's check if the fwn=
ode
> > has a device and if not, make the preparation to handle ->sync_state()
> > internally through the genpd_provider_driver and the genpd_provider_bus=
.
> >
> > Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> > ---
> >  drivers/pmdomain/core.c   | 36 ++++++++++++++++++++++++++++++++++++
> >  include/linux/pm_domain.h |  7 +++++++
> >  2 files changed, 43 insertions(+)
> >
> > diff --git a/drivers/pmdomain/core.c b/drivers/pmdomain/core.c
> > index 512f89e6d302..9c5a77bf59d2 100644
> > --- a/drivers/pmdomain/core.c
> > +++ b/drivers/pmdomain/core.c
> > @@ -2374,6 +2374,7 @@ int pm_genpd_init(struct generic_pm_domain *genpd=
,
> >         INIT_WORK(&genpd->power_off_work, genpd_power_off_work_fn);
> >         atomic_set(&genpd->sd_count, 0);
> >         genpd->status =3D is_off ? GENPD_STATE_OFF : GENPD_STATE_ON;
> > +       genpd->sync_state =3D GENPD_SYNC_STATE_OFF;
> >         genpd->device_count =3D 0;
> >         genpd->provider =3D NULL;
> >         genpd->device_id =3D -ENXIO;
> > @@ -2656,6 +2657,7 @@ int of_genpd_add_provider_simple(struct device_no=
de *np,
> >                                  struct generic_pm_domain *genpd)
> >  {
> >         struct fwnode_handle *fwnode;
> > +       struct device *dev;
> >         int ret;
> >
> >         if (!np || !genpd)
> > @@ -2665,6 +2667,10 @@ int of_genpd_add_provider_simple(struct device_n=
ode *np,
> >                 return -EINVAL;
> >
> >         fwnode =3D &np->fwnode;
> > +       dev =3D fwnode->dev;
> > +
> > +       if (!dev)
> > +               genpd->sync_state =3D GENPD_SYNC_STATE_SIMPLE;
>
> I don't want people directly poking into fwnode.

There are already other subsystems doing it like this. Like
drivers/gpio/gpiolib.c for example. I didn't think it was a big deal,
my bad!

>
> Use get_device_from_fwnode() that's in drivers/base/core.c? Might need
> to move it to a header. Make sure to put_device() it back.

Sure, I can certainly do that!

>
> Or ideally, figure it out using some other means like looking for
> #power-domain-cells number? (if that'll always give the right answer).
> Point being, the framework should know which type it's registering
> even if there was no fwnode/fw_devlink.

When adding the genpd-of-provider we are only passing a device node.
Looking for "#power-domain-cells" can't tell us whether the node will
have a device or not.

>
> >
> >         device_set_node(&genpd->dev, fwnode);
> >
> > @@ -2718,8 +2724,10 @@ int of_genpd_add_provider_onecell(struct device_=
node *np,
> >  {
> >         struct generic_pm_domain *genpd;
> >         struct fwnode_handle *fwnode;
> > +       struct device *dev;
> >         unsigned int i;
> >         int ret =3D -EINVAL;
> > +       bool sync_state =3D false;
> >
> >         if (!np || !data)
> >                 return -EINVAL;
> > @@ -2728,6 +2736,10 @@ int of_genpd_add_provider_onecell(struct device_=
node *np,
> >                 data->xlate =3D genpd_xlate_onecell;
> >
> >         fwnode =3D &np->fwnode;
> > +       dev =3D fwnode->dev;
>
> Can you do this some other way please? I really don't like this look up.

Okay, I will use get_device_from_fwnode().

Thanks again for reviewing!

[...]

Kind regards
Uffe

