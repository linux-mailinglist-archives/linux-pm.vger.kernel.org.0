Return-Path: <linux-pm+bounces-25677-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D21EAA92ED0
	for <lists+linux-pm@lfdr.de>; Fri, 18 Apr 2025 02:30:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5AD6C7B4FBE
	for <lists+linux-pm@lfdr.de>; Fri, 18 Apr 2025 00:29:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ACB12A1D7;
	Fri, 18 Apr 2025 00:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LCb1bS8t"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A93492033A
	for <linux-pm@vger.kernel.org>; Fri, 18 Apr 2025 00:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744936237; cv=none; b=NUhvauEcKi6O6SdGBJwyjtGVJsljL5+iduixaScNum0/k8HmLX9e0WZFCUzCE5YhYHb680ibCFFniDcnBQBlb2STNmAWKPB5LvNFYL9LmCt2ZtzS9yID2iEODFZwRtE6htmpZHCFfIZI9QPJKRJxu/NoJ2oQUkrt+KGaCCShdcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744936237; c=relaxed/simple;
	bh=teAQtIIgrsyG9gqv2XUIXLjFkPTTKS4DNvTftIjPFE4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IQlKd2u8Pi/8czHnHomP9IRTa/3Dw84JeLbvQQXwbCfctJ0hAkKmIh3vHLsIrvCQlcC0eqaSLf9kii6rzClf05Z0exfBFKLCKqda9NU/dEX2bmf7DbkuAZHUXDrEZ6NoGYdN7w5rYZ7Q0MlcZ8mZlpNKFcK+enChHBXs8IbjW7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LCb1bS8t; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-549b159c84cso1738432e87.3
        for <linux-pm@vger.kernel.org>; Thu, 17 Apr 2025 17:30:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1744936234; x=1745541034; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zRStZ+2egg7DY4RvB22DIQ8mwU20T0KsGY9/et/qm98=;
        b=LCb1bS8tgBiRvKAEryWHT4+J1Df2wI7B6AA2cCUbV8AZYWoZuF7yA8r2Yzt3igdn1O
         TGTdxWMoW1Dh17UjqNKT1AP0oizSDYfaJrKd1/eV7nbCiqRsp+kav98wEPSn0hlUmaI1
         tMAwUUzpj7uYtLluqyiSc9ZZSW7gDp4+bZCHifbibEnMFipYWtwyCH9PtnNZRydCfXes
         MhDqVozYNssC02JIZupz8wQux/b7YbQVa/B92pHJvO7bL8ji96qOHiphzXs6GthaMNyf
         xZvEkRVNot7hU4AfYl7OX00AxwSmQBe+8TIN3kKUkL5KDLVplEC1fX2UGLBriIluPqfe
         xcyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744936234; x=1745541034;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zRStZ+2egg7DY4RvB22DIQ8mwU20T0KsGY9/et/qm98=;
        b=AtnUj4WUHDWdYB9S0e8934t1AtrHxQfMgIpJs+94tuMz0oFiAhkCMWR0cOMhDDyn7d
         nmmtrrkzDybNkPN8C+llP+xOd48qaNChr0ruHvpZ3d5FFQ3NBXbnwIRoKSJrgGFvu6Bt
         a8gHJEfFUvUANJsCLTsiz+dLtpXZ2fkIPD5e0dUA4s4Z19Ax6Cj/7SHLBrsEtI/rd/FX
         j4RU9oQ+8zVxOp2q0i3F333t3zeMto1zVbJGuEGplqpFLwtn7w4WJFWKd67KNfH6Z4CY
         DDr1/NwO5kLg/oMakem/rnLrsQKOJSGnoECm7iAGYC6YWqT6KsSA+3vxMK7zRIBXNpri
         kIXA==
X-Forwarded-Encrypted: i=1; AJvYcCUuBU9FurkhTqd00FCR0rLS1imuQ+qYPcjCK+WH5aR1FEm8iMoFjXyCQ4i9diZ0hJf07VpSczqA/w==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywv8BnQmTiUlI2uTXAuM+31hU8CdSU03o5aexZgCJj21lVEooMS
	6melrNl/Fo5cbLSrXLhKmxHaD9jk3bXknfEMTanvt1yR1MpXtl9huUwm0Qjm7XcHwnBcd9E50Oz
	hfuf08XuwrS8JXTdSPggpPO2IZiAhhXVhNGKH
X-Gm-Gg: ASbGncu96xDqDd0d+2RbrSUfmsnOgPnQb4xw1a+bQaigx0kvbcR9hJ0ockQ1NtjzD6X
	MpReiUXSrWuB/XuZwlh55l6BThwow73eXd+xXDaVkzeGCN0qXAcyXnSiNgvgLUAAocOkVQ45Ll8
	PGwNFg4syLCERbkgk4Bf/XYcRwyQlUdwzD38vHnIyZ46TRAHY=
X-Google-Smtp-Source: AGHT+IG3XD/xd1L4getjSXyzKhJ/tUmw+zRdL3AduxLLVD1S7dldUsdPHIZT/6KW0n4GYVlVfvABqRfIZjoj9xcApZs=
X-Received: by 2002:a05:6512:4013:b0:54b:117c:1356 with SMTP id
 2adb3069b0e04-54d6e66896emr211762e87.56.1744936233589; Thu, 17 Apr 2025
 17:30:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250417142513.312939-1-ulf.hansson@linaro.org> <20250417142513.312939-11-ulf.hansson@linaro.org>
In-Reply-To: <20250417142513.312939-11-ulf.hansson@linaro.org>
From: Saravana Kannan <saravanak@google.com>
Date: Thu, 17 Apr 2025 17:29:56 -0700
X-Gm-Features: ATxdqUGpJJVZF3u7FnJNC0M4_7BmLxu5IpIq6-Gcvk5MBvzfHTZtM4vMnuDU8VE
Message-ID: <CAGETcx8jWtGAb9CyFyBmuXjNx6XPGHQLmyr6+6S2+vyMnA6j7A@mail.gmail.com>
Subject: Re: [PATCH 10/11] pmdomain: core: Default to use of_genpd_sync_state()
 for genpd providers
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
> Unless the typical platform driver that act as genpd provider, has its ow=
n
> ->sync_state() callback implemented let's default to use
> of_genpd_sync_state().
>
> More precisely, while adding a genpd OF provider let's assign the
> ->sync_state() callback, in case the fwnode has a device and its driver/b=
us
> doesn't have the ->sync_state() set already. In this way the typical
> platform driver doesn't need to assign ->sync_state(), unless it has some
> additional things to manage beyond genpds.
>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---
>  drivers/pmdomain/core.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/drivers/pmdomain/core.c b/drivers/pmdomain/core.c
> index 9c5a77bf59d2..695d7d9e5582 100644
> --- a/drivers/pmdomain/core.c
> +++ b/drivers/pmdomain/core.c
> @@ -2671,6 +2671,8 @@ int of_genpd_add_provider_simple(struct device_node=
 *np,
>
>         if (!dev)
>                 genpd->sync_state =3D GENPD_SYNC_STATE_SIMPLE;
> +       else if (!dev_has_sync_state(dev))
> +               dev_set_drv_sync_state(dev, of_genpd_sync_state);

Do you need the dev_has_sync_state() check? dev_set_drv_sync_state()
already check for everything under dev and drv. The only think it
doesn't check is "bus", but if the bus has a sync_state() it should
call the drv->sync_state() anyway.

-Saravana

>         device_set_node(&genpd->dev, fwnode);
>
> @@ -2740,6 +2742,8 @@ int of_genpd_add_provider_onecell(struct device_nod=
e *np,
>
>         if (!dev)
>                 sync_state =3D true;
> +       else if (!dev_has_sync_state(dev))
> +               dev_set_drv_sync_state(dev, of_genpd_sync_state);
>
>         for (i =3D 0; i < data->num_domains; i++) {
>                 genpd =3D data->domains[i];
> --
> 2.43.0
>

