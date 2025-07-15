Return-Path: <linux-pm+bounces-30874-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2AF0B063E1
	for <lists+linux-pm@lfdr.de>; Tue, 15 Jul 2025 18:05:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9CC7C582238
	for <lists+linux-pm@lfdr.de>; Tue, 15 Jul 2025 16:04:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C212246BB8;
	Tue, 15 Jul 2025 16:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZOu4fKSf"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8430E26281
	for <linux-pm@vger.kernel.org>; Tue, 15 Jul 2025 16:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752595463; cv=none; b=N2wUhFvxSUMCHWT9T5SMqQBgn8vujR6tPWDqGYN0ji0qcVQRwiKcr0ZyfGpb9VTyCKjhh7rrVwWTH/br1/wGkBwLmdvhywzAZfW2b7x0zQ7GXcdD0Nt8vKAetl7VYsJdE3pFcE9+rPBnm9DSYIGqrMBqKGrVQeHs2AhsknJac40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752595463; c=relaxed/simple;
	bh=TYSZRoXAo9rhsq/upQkr8hoyxLo7w7gQasAAjXS3CA0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=s+J5X0VuzaS22RcoByy6YvgLs6hTDzXh26NKfAJgDMcLe/nqL/5+l0Wk2TJ+RInaBsRZVwp+Jq3c/R3wWXbo5RSE6pR9zY1ZD09LpWIfv+MFt4hoIx0VCeJ/+Krx/xc5tR7SF5gOBOtN8F7ZFURHnynvuszp11YjOscpo6LbK6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ZOu4fKSf; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-e8bc13221eeso14141276.3
        for <linux-pm@vger.kernel.org>; Tue, 15 Jul 2025 09:04:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1752595460; x=1753200260; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=G9+Gf6mbowZuZalonETpZ6jadnzxH+LjmxECpwT8Dno=;
        b=ZOu4fKSf1b9EUAz/jw1AnEVimNDG22Vf5UOvpoRPKC6CPfzH8xkj3WGdUvZhkrnA4y
         AK7ggAehRSnupuab6cqVCZezCcnbC8A8KSJVASQqjIFEgxQkQO+31ZBKkIjNtwdR+QdJ
         vA83dkcXfzaehqRlnNUvhpcrkPuRri7u/aKkG+Bqyolpw5rtVqTCzBI53+mugC/EMKlk
         GL7XUZD4ay9+TNmbTcthlpKFsIlQ16KCOirOf8HqBpG9xLV14svk4MN9/pWsfMsHJnm3
         SV+oIo4euASsdKkHU15z2I0qEffIBZj8XxX1T+qaR/Y72BUnoDkr+c/AslLyvUb1jOyf
         uOkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752595460; x=1753200260;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=G9+Gf6mbowZuZalonETpZ6jadnzxH+LjmxECpwT8Dno=;
        b=SmPvJE57wLgRHILk4eWUsSjfoMcX9gnxDe2CQvp2U7djnW6jK3uNL6XwtQSJC/GMsq
         0IkEIu62wHhpXacILaTBj0qyEjhbSKvShVD3OvUtwrMJ34YgSYh7Ls9ncp+RW91fscMo
         wDl2tRxEUuq9qgqa9IK6HwalJ31dLR8llL9yJ6xYgnFENIwDRk09xmiUQ73QGJ434yFg
         6TNWF2sJyuw0V+o4hIWxeTa1GrX4TviH5uhUiOognqfUASMlcheVGWFH+5n6EQHDN78+
         wDv0fz9VOZHSxPynFHGPgkGytfip575cFkgiU+doQveY1TyUuBbcRuwMO8KghnXmtmUm
         UM7g==
X-Forwarded-Encrypted: i=1; AJvYcCXAoRZhzK1ohVLEuS6Qqj2687F5NXWC0/xPBtKjpEJSk9isSWY9xQEhgsMk1RmKOJ6Gkk25eo/dTQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx64i2HVADs9vVVA0u999UEbX4oZypUXhqiRMT5duQT9G0HaiLm
	oZG7Vw0/3pHhpshKP8IF0PGYcPshbeIKXmjFCAy2CeES9yecr9DMKO6r4HVFxvkDgWiB2HBtFkw
	GcSGTH2JkP0F8e61Zmc89bDPIU8FQvFdje2OIGROUxQ==
X-Gm-Gg: ASbGncs1LpJiRoqTdITa2sLCb0tZl8ooKNPMPT08Egc0wm1DRSIgQP+d61zsuJYQf2I
	oZq/BdFBwPm6b4eSCAXHkS2QaxihcRsrwzzVirkO7QkeKDJowwUmTYmOVzHm6n1YBEYa4OpA37E
	3E6qF47BTqas0mM9JCBWaOj/iEVBidmSBNGvXuHHNS+S+DxPXs8t8/VdTjsuNABQzc7W8ifL3r8
	XT2rOxM
X-Google-Smtp-Source: AGHT+IFBCmctpYQ4hpqmpVFpQIoEcYogmxduh959NmT/NLJBG7pellcNPOyp5tqRpcLBqr3/eauADU/Eyz78hUd2K6M=
X-Received: by 2002:a05:690c:628a:b0:70e:7ff6:9ff3 with SMTP id
 00721157ae682-717d5f3d391mr277841457b3.35.1752595460223; Tue, 15 Jul 2025
 09:04:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250629172512.14857-1-hiagofranco@gmail.com> <20250629172512.14857-4-hiagofranco@gmail.com>
 <aHZ0nK4ZZShAr6Xz@p14s>
In-Reply-To: <aHZ0nK4ZZShAr6Xz@p14s>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 15 Jul 2025 18:03:44 +0200
X-Gm-Features: Ac12FXwY6h_tcywiVOBNLJxHQ4w9f0nkEbd-hKtDCoysqSLCUbGs7tyoy-l-SHk
Message-ID: <CAPDyKFrWng0CY-ayKoEbnS_yanghSqogxfuizxEVbVogJ4DT=g@mail.gmail.com>
Subject: Re: [PATCH v7 3/3] remoteproc: imx_rproc: detect and attach to
 pre-booted remote cores
To: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Hiago De Franco <hiagofranco@gmail.com>, linux-pm@vger.kernel.org, 
	linux-remoteproc@vger.kernel.org, Shawn Guo <shawnguo@kernel.org>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Bjorn Andersson <andersson@kernel.org>, 
	Hiago De Franco <hiago.franco@toradex.com>, imx@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Peng Fan <peng.fan@oss.nxp.com>, daniel.baluta@nxp.com, iuliana.prodan@oss.nxp.com, 
	"Rafael J . Wysocki" <rafael@kernel.org>, Peng Fan <peng.fan@nxp.com>
Content-Type: text/plain; charset="UTF-8"

On Tue, 15 Jul 2025 at 17:32, Mathieu Poirier
<mathieu.poirier@linaro.org> wrote:
>
> On Sun, Jun 29, 2025 at 02:25:12PM -0300, Hiago De Franco wrote:
> > From: Hiago De Franco <hiago.franco@toradex.com>
> >
> > When the Cortex-M remote core is started and already running before
> > Linux boots (typically by the Cortex-A bootloader using a command like
> > bootaux), the current driver is unable to attach to it. This is because
> > the driver only checks for remote cores running in different SCFW
> > partitions. However in this case, the M-core is in the same partition as
> > Linux and is already powered up and running by the bootloader.
> >
> > This patch adds a check using dev_pm_genpd_is_on() to verify whether the
> > M-core's power domains are already on. If all power domain devices are
> > on, the driver assumes the M-core is running and proceed to attach to
> > it.
> >
> > To accomplish this, we need to avoid passing any attach_data or flags to
> > dev_pm_domain_attach_list(), allowing the platform device become a
> > consumer of the power domain provider without changing its current
> > state.
> >
> > During probe, also enable and sync the device runtime PM to make sure
> > the power domains are correctly managed when the core is controlled by
> > the kernel.
> >
> > Suggested-by: Ulf Hansson <ulf.hansson@linaro.org>
> > Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
> > Reviewed-by: Peng Fan <peng.fan@nxp.com>
> > Signed-off-by: Hiago De Franco <hiago.franco@toradex.com>
> > ---
> > v6 -> v7:
> >  - Added Peng reviewed-by.
> > v5 -> v6:
> >  - Commit description improved, as suggested. Added Ulf Hansson reviewed
> >    by. Comment on imx-rproc.c improved.
> > v4 -> v5:
> >  - pm_runtime_get_sync() removed in favor of
> >    pm_runtime_resume_and_get(). Now it also checks the return value of
> >    this function.
> >  - Added pm_runtime_disable() and pm_runtime_put() to imx_rproc_remove()
> >    function.
> > v3 -> v4:
> >  - Changed to use the new dev_pm_genpd_is_on() function instead, as
> >    suggested by Ulf. This will now get the power status of the two
> >    remote cores power domains to decided if imx_rpoc needs to attach or
> >    not. In order to do that, pm_runtime_enable() and
> >    pm_runtime_get_sync() were introduced and pd_data was removed.
> > v2 -> v3:
> >  - Unchanged.
> > v1 -> v2:
> >  - Dropped unecessary include. Removed the imx_rproc_is_on function, as
> >    suggested.
> > ---
> >  drivers/remoteproc/imx_rproc.c | 37 +++++++++++++++++++++++++++++-----
> >  1 file changed, 32 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/remoteproc/imx_rproc.c b/drivers/remoteproc/imx_rproc.c
> > index 627e57a88db2..24597b60c5b0 100644
> > --- a/drivers/remoteproc/imx_rproc.c
> > +++ b/drivers/remoteproc/imx_rproc.c
> > @@ -18,6 +18,7 @@
> >  #include <linux/of_reserved_mem.h>
> >  #include <linux/platform_device.h>
> >  #include <linux/pm_domain.h>
> > +#include <linux/pm_runtime.h>
> >  #include <linux/reboot.h>
> >  #include <linux/regmap.h>
> >  #include <linux/remoteproc.h>
> > @@ -890,10 +891,8 @@ static int imx_rproc_partition_notify(struct notifier_block *nb,
> >  static int imx_rproc_attach_pd(struct imx_rproc *priv)
> >  {
> >       struct device *dev = priv->dev;
> > -     int ret;
> > -     struct dev_pm_domain_attach_data pd_data = {
> > -             .pd_flags = PD_FLAG_DEV_LINK_ON,
> > -     };
> > +     int ret, i;
> > +     bool detached = true;
> >
> >       /*
> >        * If there is only one power-domain entry, the platform driver framework
> > @@ -902,7 +901,22 @@ static int imx_rproc_attach_pd(struct imx_rproc *priv)
> >       if (dev->pm_domain)
> >               return 0;
> >
> > -     ret = dev_pm_domain_attach_list(dev, &pd_data, &priv->pd_list);
> > +     ret = dev_pm_domain_attach_list(dev, NULL, &priv->pd_list);
> > +     /*
> > +      * If all the power domain devices are already turned on, the remote
> > +      * core is already powered up and running when the kernel booted (e.g.,
> > +      * started by U-Boot's bootaux command). In this case attach to it.
> > +      */
> > +     for (i = 0; i < ret; i++) {
> > +             if (!dev_pm_genpd_is_on(priv->pd_list->pd_devs[i])) {
> > +                     detached = false;
> > +                     break;
> > +             }
> > +     }
>
> I was doing one final review of this work when I noticed the return code for
> dev_pm_domain_attach_list() is never checked for error.

The for loop covers the error condition correctly, I think. It's only
when ret >=1 when the loop should be started - and ret is propagated
to the caller a few lines below.

>
> Thanks,
> Mathieu
>

Kind regards
Uffe

> > +
> > +     if (detached)
> > +             priv->rproc->state = RPROC_DETACHED;
> > +
> >       return ret < 0 ? ret : 0;
> >  }
> >
> > @@ -1146,6 +1160,15 @@ static int imx_rproc_probe(struct platform_device *pdev)
> >               }
> >       }
> >
> > +     if (dcfg->method == IMX_RPROC_SCU_API) {
> > +             pm_runtime_enable(dev);
> > +             ret = pm_runtime_resume_and_get(dev);
> > +             if (ret) {
> > +                     dev_err(dev, "pm_runtime get failed: %d\n", ret);
> > +                     goto err_put_clk;
> > +             }
> > +     }
> > +
> >       ret = rproc_add(rproc);
> >       if (ret) {
> >               dev_err(dev, "rproc_add failed\n");
> > @@ -1171,6 +1194,10 @@ static void imx_rproc_remove(struct platform_device *pdev)
> >       struct rproc *rproc = platform_get_drvdata(pdev);
> >       struct imx_rproc *priv = rproc->priv;
> >
> > +     if (priv->dcfg->method == IMX_RPROC_SCU_API) {
> > +             pm_runtime_disable(priv->dev);
> > +             pm_runtime_put(priv->dev);
> > +     }
> >       clk_disable_unprepare(priv->clk);
> >       rproc_del(rproc);
> >       imx_rproc_put_scu(rproc);
> > --
> > 2.39.5
> >

