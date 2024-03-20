Return-Path: <linux-pm+bounces-5152-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 767AA881259
	for <lists+linux-pm@lfdr.de>; Wed, 20 Mar 2024 14:31:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D082DB223FC
	for <lists+linux-pm@lfdr.de>; Wed, 20 Mar 2024 13:31:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B99063F9D2;
	Wed, 20 Mar 2024 13:31:49 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25E141DFD9;
	Wed, 20 Mar 2024 13:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710941509; cv=none; b=HFxZLMYL5TuvKeF+HgHnO4AsdL1cR3PGIYz88m+ND4lae9KD/1xTB2BvUv3jDpB/nWn0amfqdcitgZbOp4sPLwF9XklrzQppcpHymw+i6vZ9rJX7soqjP9JvW0jGQOlGuoRlA7Hl2Vgk8yeRthy4JqPjcoAwoqju60hBijEMEzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710941509; c=relaxed/simple;
	bh=qFJThp01RypSw3XQVJHNFZhSQJ4Tvp1MkomRWNkc1y0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZhVAgH6zWylld/g8yblFmnVLrcZuAph2EGOmgiAjul6EcNYIm84zY74nGFuji7qtZlnGOAdLDNmu0E1xGulJ/vyWi5cdTtGZdOZsvUT35znv4g4BHX4hi2TnITY7r7/O9J8USLgtuW8Q5BAmmZ7fXKwNPoGQFRIWc74LQuuecGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-609f1f97864so73114687b3.0;
        Wed, 20 Mar 2024 06:31:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710941505; x=1711546305;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IOUCfnZkUvn6fmaLAV3Oli1pBSwDSsopQHrDloBL3Rg=;
        b=Xv69jmrxojXRnvGiJwDTf8uE0ImuvfkRc1hNm033fIfyffxDYBIoTisW2px3Jet+Se
         0z1m++uq4O2FBpEWaLVUTTLIoAZGdpg9zukdJyC5Xd0X+VaasOC+6uryXjp99SWKzepS
         /tRQe5Sdlmv+mkcTmUUBPSB6QlI7jPkMUOfc+9hm2Y5VkuqTH4UHNS+nYQ3ummEsZoUX
         ePRt59eAYXBQbPaxTgwIj59dWlXvQhuK7/wDpyssPXKvHr5EpYE09kHaUc+ihGqYAWWg
         apdnWQw4uVxNqEh4MdmZolaKpL2y28yyb4Akk7tfQ4GDuq1qHGyJzCNmJMQ38arVWuDK
         BG1w==
X-Forwarded-Encrypted: i=1; AJvYcCX5NnoDL65cZvdOXTjyDZ/lmBQnqS/RcWnUUUKJ8qOI7nuTYJsbeW0HjXZ9WPWWF4fLctJa/lew5cIajmAGerqH0ZvLDZeRWk249EBKslSXMYEkobpZZMyzlo4nT7qVI7tcyUIQ3M4pbX20vw==
X-Gm-Message-State: AOJu0YyLc8Mi5fuCbb54shy55XoTZ1ru6aAdSzWF29YbRvyn6H8keq+p
	zUs+Gc5+S+XOpc0zsjtb8QBMB/DaWU0iSJjBA0t9lNLlBK58T6hA903ncCskqpk=
X-Google-Smtp-Source: AGHT+IE7sB62G+Ioq5uvT+cI8sI6UFXG1KDCpHjPbLEmXTzj7x7TDKF5RfqkKz4qt5inl37V4GmDXQ==
X-Received: by 2002:a81:6d56:0:b0:60c:a4b7:139e with SMTP id i83-20020a816d56000000b0060ca4b7139emr5806795ywc.16.1710941504488;
        Wed, 20 Mar 2024 06:31:44 -0700 (PDT)
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com. [209.85.219.178])
        by smtp.gmail.com with ESMTPSA id k1-20020a81ed01000000b00610e012961bsm790877ywm.3.2024.03.20.06.31.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Mar 2024 06:31:44 -0700 (PDT)
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-db3a09e96daso5931812276.3;
        Wed, 20 Mar 2024 06:31:43 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUkItu0jsEvruiGarjwpGBNg5+F/HMEEzjhnS/Ftuj68mdXDPWuBq9gy5FsWcBPxoxh2e7s7ir7+28HxQRBbUDc2cvKXMmz/lnwWb2oSi1vrWY1ZdBO86Al2uvb8LaiHCU7ZqfzoM7PiVaR5Q==
X-Received: by 2002:a25:6b11:0:b0:dc6:aed5:718a with SMTP id
 g17-20020a256b11000000b00dc6aed5718amr4857089ybc.26.1710941503544; Wed, 20
 Mar 2024 06:31:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240307110216.2962918-1-niklas.soderlund+renesas@ragnatech.se>
 <20240307110216.2962918-3-niklas.soderlund+renesas@ragnatech.se> <CAMuHMdU1RxN1iEnok8Hp6ZMWY1QVuu71PuG4OwWcKgPSv-kFiA@mail.gmail.com>
In-Reply-To: <CAMuHMdU1RxN1iEnok8Hp6ZMWY1QVuu71PuG4OwWcKgPSv-kFiA@mail.gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 20 Mar 2024 14:31:30 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWPkuPxuaxjUEBWRyMSnbaX2s056p2_yzkOvyZr8a8ojg@mail.gmail.com>
Message-ID: <CAMuHMdWPkuPxuaxjUEBWRyMSnbaX2s056p2_yzkOvyZr8a8ojg@mail.gmail.com>
Subject: Re: [PATCH 2/3] thermal: rcar_gen3: Update temperature approximation calculation
To: =?UTF-8?Q?Niklas_S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, 
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>, linux-pm@vger.kernel.org, 
	Geert Uytterhoeven <geert+renesas@glider.be>, linux-renesas-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Niklas,

On Wed, Mar 20, 2024 at 2:22=E2=80=AFPM Geert Uytterhoeven <geert@linux-m68=
k.org> wrote:
> On Thu, Mar 7, 2024 at 12:03=E2=80=AFPM Niklas S=C3=B6derlund
> <niklas.soderlund+renesas@ragnatech.se> wrote:
> > The initial driver used a formula to approximation the temperature and
> > register value reversed engineered form an out-of-tree BSP driver. This
> > was needed as the datasheet at the time did not contain any information
> > on how to do this. Later Gen3 (Rev 2.30) and Gen4 (all) now contains
> > this information.
> >
> > Update the approximation formula to use the datasheets information
> > instead of the reversed engineered one.
>
> > On an idle M3-N without fused calibration values for PTAT and THCODE th=
e
> > old formula reports,
> >
> >     zone0: 52000
> >     zone1: 53000
> >     zone2: 52500
> >
> > While the new formula under the same circumstances reports,
> >
> >     zone0: 52500
> >     zone1: 54000
> >     zone2: 54000
> >
> > Signed-off-by: Niklas S=C3=B6derlund <niklas.soderlund+renesas@ragnatec=
h.se>
>
> > --- a/drivers/thermal/rcar_gen3_thermal.c
> > +++ b/drivers/thermal/rcar_gen3_thermal.c
> > @@ -172,19 +165,29 @@ static int rcar_gen3_thermal_round(int temp)
> >  static int rcar_gen3_thermal_get_temp(struct thermal_zone_device *tz, =
int *temp)
> >  {
> >         struct rcar_gen3_thermal_tsc *tsc =3D thermal_zone_device_priv(=
tz);
> > -       int mcelsius, val;
> > -       int reg;
> > +       struct rcar_gen3_thermal_priv *priv =3D tsc->priv;
> > +       const struct equation_set_coef *coef;
> > +       int adj, mcelsius, reg, thcode;
> >
> >         /* Read register and convert to mili Celsius */
> >         reg =3D rcar_gen3_thermal_read(tsc, REG_GEN3_TEMP) & CTEMP_MASK=
;
> >
> > -       if (reg <=3D tsc->thcode[1])
> > -               val =3D FIXPT_DIV(FIXPT_INT(reg) - tsc->coef.b1,
> > -                               tsc->coef.a1);
> > -       else
> > -               val =3D FIXPT_DIV(FIXPT_INT(reg) - tsc->coef.b2,
> > -                               tsc->coef.a2);
> > -       mcelsius =3D FIXPT_TO_MCELSIUS(val);
> > +       if (reg < tsc->thcode[1]) {
> > +               adj =3D priv->info->adj_below;
> > +               coef =3D &tsc->coef.below;
> > +               thcode =3D tsc->thcode[2];
> > +       } else {
> > +               adj =3D priv->info->adj_above;
> > +               coef =3D &tsc->coef.above;
> > +               thcode =3D tsc->thcode[0];
> > +       }
> > +
> > +       /*
> > +        * The dividend can't be grown as it might overflow, instead sh=
orten the
> > +        * divisor to convert to millidegree Celsius. If we convert aft=
er the
> > +        * division precision is lost to a full degree Celsius.
> > +        */
> > +       mcelsius =3D DIV_ROUND_CLOSEST(coef->a * (thcode - reg), coef->=
b / 1000) + adj * 1000;
>
> Don't you lose a lot of precision by pre-dividing b by 1000?

After reading PATCH 3/3: instead of calculating millidegree Celsius,
and rounding to a granularity of 0.1 degree Celsius later, perhaps it
makes more sense to calculate decidegree Celsius first (still avoiding
overflow?), and multiply by 100 later?
Then rcar_gen3_thermal_round() can be removed.

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds

