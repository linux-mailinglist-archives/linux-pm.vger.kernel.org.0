Return-Path: <linux-pm+bounces-9437-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EDE190D122
	for <lists+linux-pm@lfdr.de>; Tue, 18 Jun 2024 15:39:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2CA83287E2B
	for <lists+linux-pm@lfdr.de>; Tue, 18 Jun 2024 13:39:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 894D519E7D6;
	Tue, 18 Jun 2024 13:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="As6fjM6w"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FD4119E7CE;
	Tue, 18 Jun 2024 13:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718715988; cv=none; b=s3uh+LXHTB9G6wCr3G5OJLkXYmfPiNuQPPmBJcbR2szQxxPi9ZkruGB2iop5tKyakuutF+hmDcqDQgSMGE90BjXGKthU8MG778AYGpXdjnoVllvHqCo6yxtobVVEmkR12dsLudpl4rqhIv7nFBZCXXQ5mezeO4Rct7GpmRBzf5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718715988; c=relaxed/simple;
	bh=rPJPpkZkaxqw98GQ+C6ISYQGaCLzgfRkMZxyiI9GM8Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gueVbIGB+/QqCtzP6rX8X0Eh89j+uwIQVwdMJAUHEKFE1TqvJNVDViVprXEWbtx/19l1XqKCizTe1GyPYaaPN/nvDoLxxgRguJfdI1apsNlcjKZKUVTgGq5AtTtTk5z6R9ZuX1NQzpJWEjSkv5VANdMFfvqBU5B+DkkXVNmer+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=As6fjM6w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AECAC3277B;
	Tue, 18 Jun 2024 13:06:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718715988;
	bh=rPJPpkZkaxqw98GQ+C6ISYQGaCLzgfRkMZxyiI9GM8Q=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=As6fjM6wLd4CmP97aqR2nJxzQdIgBUPQTRjqchbDHGqey68/UZSIR17v8zVkykIsk
	 Sr6tETHMvvuxon7kw2WawlvpT3fOQgREiju9N+mwMjxIp5ermgHZ4qp2+tYaMp3M0J
	 Wfp5xPwRP4qfmVqvADEYMc+VbsAE3RHkxWNUNh2BFs/qXM0E+KfRM9HWcnqGtJGGN6
	 bc2C+cpcAT9glQI8/EKlopqo8F85D9+YMdtJZfKnWBiHlLHS//Vq9zlXZsemmQT7ax
	 fQd3roT05m7/8cajvzmmXTyXhUruW6u5EPNZI6THyJVZLv0W3/8++r5YTb67EU1jM/
	 kWpwKTlKkOPvw==
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-5baf76164fbso264111eaf.1;
        Tue, 18 Jun 2024 06:06:28 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUh96uwdYTb1iInZEFNUvwTbSUnMPaaLaCEQMFOjYVjbvvTPl4Dc6ZFkVCqtZRhE0cwIlXpIVg+Vm85vt1P0CaxX80gCpFLpbr1hmWuGdlh6NpI2m8d514oUlR5UqtdoR96I6dylQo=
X-Gm-Message-State: AOJu0YzP4GnUmdXiXjUjEeGJbGVI9wrAcSvGg5vB+3CBhL5jTMQDvtUU
	dpwnBuuiUkQ1m7mH3pKRAInyOIBeG1WmBHooQmy9V6esCXcKbqw4v18xBHUDQPjph7mgCpQ99tz
	QNVnWsu15ZMRIQ2ASjfafD3kq1tQ=
X-Google-Smtp-Source: AGHT+IGeWGVit1KK947UdGQyWn7z2tLgQXWDKb4MRfU12vK3X+xJJ3d98ko/WrnTUi5SREX1Rf3Yv+cI9VUdj8J/CoY=
X-Received: by 2002:a4a:d6cd:0:b0:5bd:af39:c9d9 with SMTP id
 006d021491bc7-5bdaf39caa2mr12337275eaf.0.1718715987415; Tue, 18 Jun 2024
 06:06:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <8409966.T7Z3S40VBb@kreacher> <2148114.bB369e8A3T@kreacher> <e54a7a9b-3fc7-457f-9f30-d6ab3a58c2b0@socionext.com>
In-Reply-To: <e54a7a9b-3fc7-457f-9f30-d6ab3a58c2b0@socionext.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 18 Jun 2024 15:06:14 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hX8Bfu=RNbErbrLTBrQhi8dHqS15HX6NoPZD-h5TR_2w@mail.gmail.com>
Message-ID: <CAJZ5v0hX8Bfu=RNbErbrLTBrQhi8dHqS15HX6NoPZD-h5TR_2w@mail.gmail.com>
Subject: Re: [PATCH v1 12/14] thermal: uniphier: Use thermal_zone_for_each_trip()
 for walking trip points
To: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Lukasz Luba <lukasz.luba@arm.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Jun 18, 2024 at 6:05=E2=80=AFAM Kunihiko Hayashi
<hayashi.kunihiko@socionext.com> wrote:
>
> Hi Rafael,
>
> On 2024/06/18 3:07, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > It is generally inefficient to iterate over trip indices and call
> > thermal_zone_get_trip() every time to get the struct thermal_trip
> > corresponding to the given trip index, so modify the uniphier thermal
> > driver to use thermal_zone_for_each_trip() for walking trips.
> >
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > ---
> >   drivers/thermal/uniphier_thermal.c |   37
> > +++++++++++++++++++++++--------------
> >   1 file changed, 23 insertions(+), 14 deletions(-)
> >
> > Index: linux-pm/drivers/thermal/uniphier_thermal.c
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > --- linux-pm.orig/drivers/thermal/uniphier_thermal.c
> > +++ linux-pm/drivers/thermal/uniphier_thermal.c
> > @@ -239,13 +239,32 @@ static irqreturn_t uniphier_tm_alarm_irq
> >       return IRQ_HANDLED;
> >   }
> >
> > +struct trip_walk_data {
> > +     struct uniphier_tm_dev *tdev;
> > +     int crit_temp;
> > +     int index;
> > +};
> > +
> > +static int uniphier_tm_trip_walk_cb(struct thermal_trip *trip, void *a=
rg)
> > +{
> > +     struct trip_walk_data *twd =3D arg;
> > +
> > +     if (trip->type =3D=3D THERMAL_TRIP_CRITICAL &&
> > +         trip->temperature < twd->crit_temp)
> > +             twd->crit_temp =3D trip->temperature;
> > +
> > +     uniphier_tm_set_alert(twd->tdev, twd->index, trip->temperature);
> > +     twd->tdev->alert_en[twd->index++] =3D true;
> > +}
> > +
> >   static int uniphier_tm_probe(struct platform_device *pdev)
> >   {
> > +     struct trip_walk_data twd =3D { .crit_temp =3D INT_MAX, .index =
=3D 0 };
> >       struct device *dev =3D &pdev->dev;
> >       struct regmap *regmap;
> >       struct device_node *parent;
> >       struct uniphier_tm_dev *tdev;
> > -     int i, ret, irq, crit_temp =3D INT_MAX;
> > +     int i, ret, irq;
> >
> >       tdev =3D devm_kzalloc(dev, sizeof(*tdev), GFP_KERNEL);
> >       if (!tdev)
> > @@ -293,20 +312,10 @@ static int uniphier_tm_probe(struct plat
> >       }
> >
> >       /* set alert temperatures */
> > -     for (i =3D 0; i < thermal_zone_get_num_trips(tdev->tz_dev); i++) =
{
> > -             struct thermal_trip trip;
> > +     twd.tdev =3D tdev;
> > +     thermal_zone_for_each_trip(tdev->tz_dev, uniphier_tm_trip_walk_cb=
, &twd);
> >
> > -             ret =3D thermal_zone_get_trip(tdev->tz_dev, i, &trip);
> > -             if (ret)
> > -                     return ret;
> > -
> > -             if (trip.type =3D=3D THERMAL_TRIP_CRITICAL &&
> > -                 trip.temperature < crit_temp)
> > -                     crit_temp =3D trip.temperature;
> > -             uniphier_tm_set_alert(tdev, i, trip.temperature);
> > -             tdev->alert_en[i] =3D true;
> > -     }
> > -     if (crit_temp > CRITICAL_TEMP_LIMIT) {
> > +     if (twd.crit_temp > CRITICAL_TEMP_LIMIT) {
> >               dev_err(dev, "critical trip is over limit(>%d), or not se=
t\n",
> >                       CRITICAL_TEMP_LIMIT);
> >               return -EINVAL;
>
> I confirmed the updated code using the helper function is equivalent
> to the original.
>
> Reviewed-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>

Thank you!

