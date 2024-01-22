Return-Path: <linux-pm+bounces-2486-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C899836BB0
	for <lists+linux-pm@lfdr.de>; Mon, 22 Jan 2024 17:50:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D0375283528
	for <lists+linux-pm@lfdr.de>; Mon, 22 Jan 2024 16:50:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E44F85B1F7;
	Mon, 22 Jan 2024 15:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eOR4EKb/"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5100E5A7B7
	for <linux-pm@vger.kernel.org>; Mon, 22 Jan 2024 15:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705936953; cv=none; b=eJ2f9qdwtS1dNYmPQ2dA719ZlzRkLsijV++IbujdH1hqLNgJ4PEa8acIJowYp+kjtJq0OGW90Yb6IXxWt4bMd9mQfCd37cAmNJwbQ8A3WHz0gKPQYYVGUyQaTl6joF2QvTtb8xUuOcXlZ+d2kse2Vku76bO525XDfB0VGpa0T8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705936953; c=relaxed/simple;
	bh=1QMs2R1lPS7PjHgEumokw5vU7OhOt7nlYZyj6BYRuRc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iH/KbgcHebhzX2QFhrKJcgHS1VFTokXRIjvK1gzaZug74oTo8lhzwRMdv8tj5Ry1nWzKLKWIvCaib9ecDgD2ayBtakXu+ZahCF9tpL21GvAkVvDCwsH1tfognXF92UkpRw85UIuvuFfQbWTRL0pEFNZXQUY6Kjyu7cwVGUw9K58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=eOR4EKb/; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-5ff7dd8d7ceso27066497b3.0
        for <linux-pm@vger.kernel.org>; Mon, 22 Jan 2024 07:22:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1705936951; x=1706541751; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9YdPalmHpgSBQug94a4NMY3RvyZbHc/DC1dN+IiXam8=;
        b=eOR4EKb/g3Bp+YW0MXLOUYVkXiTRocguU5C960hLb8kvUQe0O4rllXKCMdAIYqDIep
         u6K0fQlq9d8cqXGhr0ee4DawpaWUwRpo4IyjtT4zAvF0dZ1+HFO7yeHbbdLKWkj7Y1fx
         rkrO0snh0/Emg3R3bIB8tOx08qmo1zK/cF0ICGmL1TBxUsa867md0IosjR5J6/OgzQvZ
         S33LKCuOcUB5Xtu8QNR0gtTnvWa8cms3kU3uRsz74uEkjIQpukOKOyez3B8aA5no+0hc
         Zsk7f25wJOJ0xcULYKOXa6+FzWYUzvm3M8z/9Qo+TZs1ZTUQfx8DGWrWR8WJqjKWbV/q
         5YzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705936951; x=1706541751;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9YdPalmHpgSBQug94a4NMY3RvyZbHc/DC1dN+IiXam8=;
        b=d3kwdGMSHtMa2FBXIgEwFXgEgSQOaiP08nPEfs8cwwQk1NDiBxWeiscKsWR8euI6Sk
         jujPgqnNT7bRhHWKUIkP+p89pAkGBD18iXxBxVwj9pp09QPbPh9F+3nIZqDFbVQLsN71
         AUrUllv6w4XBmqIl0L0jbX+CbkEHmpKQvvuJhCWuWvczCU0nrY3PHpFZY+9dYl+GBB+G
         a4JoxZs9CA8LRiPSnvgRxCb1dxtY5DHibM4u+Sw2LsK3sEAkUCqQRrDK93AG//e2NVti
         Zzk23AYxL067UFQ+bEIN0OdpsDhb4rR3+O/UNxi67h0FCkP/RmhTQJ+WDUQqHW1P2bjV
         a35A==
X-Gm-Message-State: AOJu0YzG8cgbUzNYP+WqqOXs2ia8mGsfmMIaE1y+rMEsw7bRxbv8rG/u
	cW6lm38FBNz+eQDkXBTrvyKqiQ0gnjM0kMu4AI4u0K79Iks1yeaZfYayEDhAQrZB5W0t4Amut84
	kWf/bhDaEoJPbMmszwWv3HagziVxlxuoebNnNVg==
X-Google-Smtp-Source: AGHT+IGHTs3Z3wnH1KXtBUSvX3smc5AOVnQtxoF1kI8pfYzjNSHyscW3NDgO8wD4LA72xrvcQM8Tzf6V2eC6UnIbTGQ=
X-Received: by 2002:a0d:cccb:0:b0:5ff:9451:c11f with SMTP id
 o194-20020a0dcccb000000b005ff9451c11fmr3376104ywd.87.1705936951350; Mon, 22
 Jan 2024 07:22:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240119014807.268694-1-marex@denx.de>
In-Reply-To: <20240119014807.268694-1-marex@denx.de>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Mon, 22 Jan 2024 16:21:55 +0100
Message-ID: <CAPDyKFrs9hMuqj4YS==fT4tXqtCPqTSRMG46OrDitzM-B1Dtgg@mail.gmail.com>
Subject: Re: [PATCH v2] pmdomain: imx8m-blk-ctrl: imx8mp-blk-ctrl: Error out
 if domains are missing in DT
To: Marek Vasut <marex@denx.de>
Cc: linux-pm@vger.kernel.org, 
	=?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, 
	Fabio Estevam <festevam@gmail.com>, Jindong Yue <jindong.yue@nxp.com>, 
	Lucas Stach <l.stach@pengutronix.de>, Marco Felsch <m.felsch@pengutronix.de>, 
	NXP Linux Team <linux-imx@nxp.com>, Peng Fan <peng.fan@nxp.com>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Shawn Guo <shawnguo@kernel.org>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 19 Jan 2024 at 02:48, Marek Vasut <marex@denx.de> wrote:
>
> This driver assumes that domain->power_dev is non-NULL in its suspend/res=
ume
> path. The assumption is valid, since all the devices that are being looke=
d up
> here should be described in DT. In case they are not described in DT, bea=
use
> the DT is faulty, suspend/resume attempt would trigger NULL pointer deref=
erence.
> To avoid this failure, check whether the power_dev assignment is not NULL=
 right
> away in probe callback and fail early if it is.
>
> Signed-off-by: Marek Vasut <marex@denx.de>

Applied for next, thanks!

Kind regards
Uffe


> ---
> Cc: "Uwe Kleine-K=C3=B6nig" <u.kleine-koenig@pengutronix.de>
> Cc: Fabio Estevam <festevam@gmail.com>
> Cc: Jindong Yue <jindong.yue@nxp.com>
> Cc: Lucas Stach <l.stach@pengutronix.de>
> Cc: Marco Felsch <m.felsch@pengutronix.de>
> Cc: NXP Linux Team <linux-imx@nxp.com>
> Cc: Peng Fan <peng.fan@nxp.com>
> Cc: Pengutronix Kernel Team <kernel@pengutronix.de>
> Cc: Sascha Hauer <s.hauer@pengutronix.de>
> Cc: Shawn Guo <shawnguo@kernel.org>
> Cc: Ulf Hansson <ulf.hansson@linaro.org>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-pm@vger.kernel.org
> ---
> V2: Add extra check for domain being NULL (thanks Peng)
> ---
>  drivers/pmdomain/imx/imx8m-blk-ctrl.c  | 9 ++++++---
>  drivers/pmdomain/imx/imx8mp-blk-ctrl.c | 9 ++++++---
>  2 files changed, 12 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/pmdomain/imx/imx8m-blk-ctrl.c b/drivers/pmdomain/imx=
/imx8m-blk-ctrl.c
> index 1341a707f61bc..ca942d7929c2b 100644
> --- a/drivers/pmdomain/imx/imx8m-blk-ctrl.c
> +++ b/drivers/pmdomain/imx/imx8m-blk-ctrl.c
> @@ -258,11 +258,14 @@ static int imx8m_blk_ctrl_probe(struct platform_dev=
ice *pdev)
>
>                 domain->power_dev =3D
>                         dev_pm_domain_attach_by_name(dev, data->gpc_name)=
;
> -               if (IS_ERR(domain->power_dev)) {
> -                       dev_err_probe(dev, PTR_ERR(domain->power_dev),
> +               if (IS_ERR_OR_NULL(domain->power_dev)) {
> +                       if (!domain->power_dev)
> +                               ret =3D -ENODEV;
> +                       else
> +                               ret =3D PTR_ERR(domain->power_dev);
> +                       dev_err_probe(dev, ret,
>                                       "failed to attach power domain \"%s=
\"\n",
>                                       data->gpc_name);
> -                       ret =3D PTR_ERR(domain->power_dev);
>                         goto cleanup_pds;
>                 }
>
> diff --git a/drivers/pmdomain/imx/imx8mp-blk-ctrl.c b/drivers/pmdomain/im=
x/imx8mp-blk-ctrl.c
> index e3203eb6a0229..e488cf79b8007 100644
> --- a/drivers/pmdomain/imx/imx8mp-blk-ctrl.c
> +++ b/drivers/pmdomain/imx/imx8mp-blk-ctrl.c
> @@ -687,11 +687,14 @@ static int imx8mp_blk_ctrl_probe(struct platform_de=
vice *pdev)
>
>                 domain->power_dev =3D
>                         dev_pm_domain_attach_by_name(dev, data->gpc_name)=
;
> -               if (IS_ERR(domain->power_dev)) {
> -                       dev_err_probe(dev, PTR_ERR(domain->power_dev),
> +               if (IS_ERR_OR_NULL(domain->power_dev)) {
> +                       if (!domain->power_dev)
> +                               ret =3D -ENODEV;
> +                       else
> +                               ret =3D PTR_ERR(domain->power_dev);
> +                       dev_err_probe(dev, ret,
>                                       "failed to attach power domain %s\n=
",
>                                       data->gpc_name);
> -                       ret =3D PTR_ERR(domain->power_dev);
>                         goto cleanup_pds;
>                 }
>
> --
> 2.43.0
>

