Return-Path: <linux-pm+bounces-28961-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 34A47ADED13
	for <lists+linux-pm@lfdr.de>; Wed, 18 Jun 2025 14:57:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B27B816BF26
	for <lists+linux-pm@lfdr.de>; Wed, 18 Jun 2025 12:57:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AA542E54A5;
	Wed, 18 Jun 2025 12:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aNhu4IIY"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1D512E3B10
	for <linux-pm@vger.kernel.org>; Wed, 18 Jun 2025 12:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750251425; cv=none; b=VWpdb+1dulINAMw2xr5/E+8PD42U7mrr34PoYFAXiLZd801cRyk/a+iHI0ZwJLHhf8AjUPwdYboDq0Aaz/Xu48UrmczmQ+znQu7AjGOTTnsUxxLv3oKxOj/PR6m/2b4QstoEorssZBnj7nXAddqGgcU2t3ijleJB6eC0cfOnHsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750251425; c=relaxed/simple;
	bh=NjVYGChQDbdYIHe4Sr86or+FiSbuf0vYfumtIy7G6CA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ix2NIhjmw8sB2ZTPZ84Mwz/qiyPpUkezUgsZ+IPCpyhssNjoNl5FvdJ1vRR4HEq3IUDC0adjpoA9uF/Eg1kuDYM56Ii7DMtgHGuuEaoEeo3dx7cZPsleCBWs99omKXcMQCscFaVPp4dXdkCGeAVY7q/t5uQRomxcxh6enX4Me8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=aNhu4IIY; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-e8273504c67so1857851276.0
        for <linux-pm@vger.kernel.org>; Wed, 18 Jun 2025 05:57:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1750251422; x=1750856222; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/0yNglyrMOZ78JyNR9Sp0rHahct09b8RGeUMHfCfYXs=;
        b=aNhu4IIYC7J5516GOhCztiHgcRHX0bX4gsr6bSisGGewTaf0t2244FyScdcooFgn4M
         yEP8LTseQP1F2TOCwgbbURqCs/X6o3tWIA6EP1eaUtk93uUOQ6y1sRRj/4Ca6VkLTTto
         J/enl7/Eo/Oco9/SHDmPE6cUmXre/76Z6v7xk6swpd2MUNZiaUptTHogR34khVeO2iWY
         4pXv9eRRqCmZcmJDpeQaxLUqvRnCrPRt1iWdvo6pHobbj/q8AeAq2oT20C6UL0AvEyoq
         SCJ/Y7QGj3teUNiIHFid2sZMLC2ipmFrVPqALShDw//pWfMTeUPwC5vhm84KVbWBa2Za
         9lmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750251422; x=1750856222;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/0yNglyrMOZ78JyNR9Sp0rHahct09b8RGeUMHfCfYXs=;
        b=MJ3hrxXyiPnRLLD2VeSqSJkv3lbvqNJ+iAXHnnprThNPK4OmS1guZu/gjaRyvZPpoQ
         fWhA4QqHmb/NrhDOYAc3Us5bWmGGEQvyxKvfDhNHNnvyjW53gkGvqybvxBlfYOdyxJjU
         vEJU2mC0fYVWhTTqnzaZerlNbBi+khPDhZGWrjiDIWS8RGyf1DQ2Ck4I+Sj3OpCWtbaj
         hU9U0DGwyshkFaEvgIJXWkdiFp0WkGiPdaHGsiVzsweFoWyOV1QtHGWhvmZTm7Ws0DHg
         TSv4UznIq+XgqdngIjtf7OzCJk/6aN4hyIdTNK3d1htw6Mf+PBZUMK0GFFdTOoTKUxIN
         GKCA==
X-Forwarded-Encrypted: i=1; AJvYcCX5q87rC2Q9LYyTlnR8rywCl67EnisDMLUfAeRqfoPEkfziv9LQGPYLmRTDDY6QQ1pLeBdh4Oyjig==@vger.kernel.org
X-Gm-Message-State: AOJu0YyYcGJZ6J0VcQG1iJHNrz5JHdhT/zxHQq1XZAlaIQ5JDlOm1f39
	uzAGN27TSk8/oEEo3L241MHuqb87+/AzkY/4/bc7W8wkj5ft/UyHkkUFfF0pUsfjmzdIzFnYwtY
	x2qzejbhxPQ0zdMO+g067z2iU1qP/eK26MueOST6NDg==
X-Gm-Gg: ASbGncvoH4d3KStg3CYiCtm8ab302sfQLQ+GFGvvd59aGRAw23KvIF5lrsbwWFPugvU
	GH5qPSDwxzAG38DDlZAVB1FHUzn1UeGVCfjLOaOlJ23Cq6/MOITepsEV9ZAHpkdHBEeojTZV4uv
	nL46xL+GJ8rBPhIzdHcccRZqJvfLRrk4UpNGfOArJ2Lys=
X-Google-Smtp-Source: AGHT+IGKJ/9nezM0CjL8LTlmXkuqqs1XvYRULfznlZkJ00Zas9fy/8SeNVFH78QNFQr9m4QBfV7T9IMSOGKFGfTViCA=
X-Received: by 2002:a05:6902:100d:b0:e81:9aa9:88cd with SMTP id
 3f1490d57ef6-e822abe0669mr22502028276.8.1750251421799; Wed, 18 Jun 2025
 05:57:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <m3ldr69lsw.fsf@t19.piap.pl>
In-Reply-To: <m3ldr69lsw.fsf@t19.piap.pl>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Wed, 18 Jun 2025 14:56:26 +0200
X-Gm-Features: AX0GCFt2trdH5lvp26KlouAeiTYZ2alEevH8lFXOfNjGnwSoGAScAqPAkE83GxQ
Message-ID: <CAPDyKFo_oTWWX-PNNA_Dpq0fjbmhzoLCgd77NfDO=Q_JZ8hZ-g@mail.gmail.com>
Subject: Re: [PATCH] imx8m-blk-ctrl: set ISI panic write hurry level
To: =?UTF-8?Q?Krzysztof_Ha=C5=82asa?= <khalasa@piap.pl>
Cc: Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, Peng Fan <peng.fan@nxp.com>, 
	linux-pm@vger.kernel.org, imx@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 9 May 2025 at 11:26, Krzysztof Ha=C5=82asa <khalasa@piap.pl> wrote:
>
> Apparently, ISI needs cache settings similar to LCDIF.
> Otherwise we get artefacts in the image.
> Tested on i.MX8MP.
>
> Signed-off-by: Krzysztof Ha=C5=82asa <khalasa@piap.pl>

Applied for next, thanks!

Kind regards
Uffe


>
> diff --git a/drivers/pmdomain/imx/imx8m-blk-ctrl.c b/drivers/pmdomain/imx=
/imx8m-blk-ctrl.c
> index 912802b5215b..5c83e5599f1e 100644
> --- a/drivers/pmdomain/imx/imx8m-blk-ctrl.c
> +++ b/drivers/pmdomain/imx/imx8m-blk-ctrl.c
> @@ -665,6 +665,11 @@ static const struct imx8m_blk_ctrl_data imx8mn_disp_=
blk_ctl_dev_data =3D {
>  #define  LCDIF_1_RD_HURRY      GENMASK(15, 13)
>  #define  LCDIF_0_RD_HURRY      GENMASK(12, 10)
>
> +#define ISI_CACHE_CTRL         0x50
> +#define  ISI_V_WR_HURRY                GENMASK(28, 26)
> +#define  ISI_U_WR_HURRY                GENMASK(25, 23)
> +#define  ISI_Y_WR_HURRY                GENMASK(22, 20)
> +
>  static int imx8mp_media_power_notifier(struct notifier_block *nb,
>                                 unsigned long action, void *data)
>  {
> @@ -694,6 +699,11 @@ static int imx8mp_media_power_notifier(struct notifi=
er_block *nb,
>                 regmap_set_bits(bc->regmap, LCDIF_ARCACHE_CTRL,
>                                 FIELD_PREP(LCDIF_1_RD_HURRY, 7) |
>                                 FIELD_PREP(LCDIF_0_RD_HURRY, 7));
> +               /* Same here for ISI */
> +               regmap_set_bits(bc->regmap, ISI_CACHE_CTRL,
> +                               FIELD_PREP(ISI_V_WR_HURRY, 7) |
> +                               FIELD_PREP(ISI_U_WR_HURRY, 7) |
> +                               FIELD_PREP(ISI_Y_WR_HURRY, 7));
>         }
>
>         return NOTIFY_OK;
>
> --
> Krzysztof "Chris" Ha=C5=82asa
>
> Sie=C4=87 Badawcza =C5=81ukasiewicz
> Przemys=C5=82owy Instytut Automatyki i Pomiar=C3=B3w PIAP
> Al. Jerozolimskie 202, 02-486 Warszawa

