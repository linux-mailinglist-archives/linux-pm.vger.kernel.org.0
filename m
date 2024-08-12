Return-Path: <linux-pm+bounces-12065-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A012794E5DE
	for <lists+linux-pm@lfdr.de>; Mon, 12 Aug 2024 06:46:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B0BE281FCB
	for <lists+linux-pm@lfdr.de>; Mon, 12 Aug 2024 04:46:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E19CE14A60D;
	Mon, 12 Aug 2024 04:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="JJ9uorjU"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D79A9136E3F
	for <linux-pm@vger.kernel.org>; Mon, 12 Aug 2024 04:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723438011; cv=none; b=VL4PSBxdXnY6jjEhJalYqRKNMDSlH2lhJqlzCRblaDgB+E4hxmhEhIkpLsjPaa2/srmYAB66ItsMOS1SiSaTEZOt+wIy1KnL4cwGNrbbbWYlDkVJm1IXIUjhuiHl/8dRHisCNH6k7mU/OIwy6DVq31g4gdI4olPPGpHPp62mOQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723438011; c=relaxed/simple;
	bh=481+Pg0NjVOwdB22afF6DwGUpypwRm3R85Uhe9wI2xY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FhgIZ6k3+wbhOd6l44jmgrt0R/CYwnrADehcVzP1Kb8qcmAe+BKx3i9B5RV5vj9Fx5fw6fDAbr+Hw3ar/yS+FTcsTOC0Jd+eZiGUtZwDmR8yiVy+1xLKAf3rhSoE664wd+Y+JAGLbhDSfqEIy1+WjF220zcviS4Yex0hpiJ2Fpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=JJ9uorjU; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-52f04b3cb33so7812683e87.0
        for <linux-pm@vger.kernel.org>; Sun, 11 Aug 2024 21:46:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1723438007; x=1724042807; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3G+OVT+hP++ys+x3EBjqw7D7jl0ngZBCPSiqjU8F9Uk=;
        b=JJ9uorjURxIwnIH5sNhVE0ia4rdyb+7aDHd3qlQv1D55lq/7N7zmrJpYG4PE16RfOt
         2jLNv4739k0iH1qCuUxgxvIAkYt/cQ3btH5F1ykm+BG98LY1N3+s5XwBWjeKE49yWHWO
         V0kRU60teHe34KWTNEe5ReHjrjTE/LwUotj9M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723438007; x=1724042807;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3G+OVT+hP++ys+x3EBjqw7D7jl0ngZBCPSiqjU8F9Uk=;
        b=KRnjD6IhJsqtGk0PVX+cqchzww1Z0FKv2VrRTsrCcPeCwnGXwA6V2MrzebJ1N6bCQj
         HBafukk0mVTOh9y5IZ6dZarbNqpfgdsW66IZiJVwOPH6tNNvIQbN9pXI/WkOqFdr4eZt
         5z8DgykA9p6qvIZjNfnuXEkzIRE61JZuUdZWUF8/N0YXYPMoySf9mSxt677znccEU/jl
         zLN5p9+NvVCM014nH31FcnWLRFDGLeOxfdIK3TTSeXiJFcn28+RUE6fyzKMnAe7RZDLE
         z92sVqeu3/glePyjLxYgx9RCTurTWUX+UOsPctjFO2fBGsKFqaOnw/uw+0/mjdyzVfsI
         fTsQ==
X-Forwarded-Encrypted: i=1; AJvYcCVYeTUb9sh2hGt33On+GqcDf1i5ZA1bjAdNPGj2u27665SfScxpI230+8/n1i270etlhzO8/AymaA==@vger.kernel.org
X-Gm-Message-State: AOJu0YySvdegtDRcigJzm0taBKLliKUpxzXjzJl7pP5LnCNH0Tq96+d7
	CTZ2cuxQxKTGEqcMYFgJpXZU9vly08CbBdFslUOmN833uQGOwp9M4tA/KasYtMqSCBRq6NzYiJy
	jyk9qNxt0DMu3AMGOPLCP6+E16mLH+HpsWEhr
X-Google-Smtp-Source: AGHT+IFnVSMXIzgUCR1aKIEo7IibT84nijwPU1DhYfZ4h5IkgDw15sl0S/evUMey6uGzCvBZZi5Hhqwz6o3olaA2hhM=
X-Received: by 2002:a05:6512:124d:b0:52e:933f:f1fa with SMTP id
 2adb3069b0e04-530eea2a4cbmr6484083e87.61.1723438006644; Sun, 11 Aug 2024
 21:46:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240809070822.2835371-1-wenst@chromium.org> <b00273d65dfc4b48cca474784184c62b@manjaro.org>
In-Reply-To: <b00273d65dfc4b48cca474784184c62b@manjaro.org>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Mon, 12 Aug 2024 12:46:35 +0800
Message-ID: <CAGXv+5ERoH=jQGzo=mo2K-r3Meh2-5Kgvjf9Eh7bfNgcQYfWoA@mail.gmail.com>
Subject: Re: [PATCH v2] thermal/of: support thermal zones w/o trips subnode
To: Dragan Simic <dsimic@manjaro.org>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>, Amit Kucheria <amitk@kernel.org>, 
	Zhang Rui <rui.zhang@intel.com>, Icenowy Zheng <uwu@icenowy.me>, Mark Brown <broonie@kernel.org>, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev, 
	=?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= <nfraprado@collabora.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Matthias Brugger <matthias.bgg@gmail.com>, linux-mediatek@lists.infradead.org, 
	Hsin-Te Yuan <yuanhsinte@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 12, 2024 at 9:22=E2=80=AFAM Dragan Simic <dsimic@manjaro.org> w=
rote:
>
> Hello Chen-Yu,
>
> Thanks for the patch.  Please see one comment below.
>
> On 2024-08-09 09:08, Chen-Yu Tsai wrote:
> > From: Icenowy Zheng <uwu@icenowy.me>
> >
> > Although the current device tree binding of thermal zones require the
> > trips subnode, the binding in kernel v5.15 does not require it, and
> > many
> > device trees shipped with the kernel, for example,
> > allwinner/sun50i-a64.dtsi and mediatek/mt8183-kukui.dtsi in ARM64,
> > still
> > comply to the old binding and contain no trips subnode.
> >
> > Allow the code to successfully register thermal zones w/o trips subnode
> > for DT binding compatibility now.
> >
> > Furtherly, the inconsistency between DTs and bindings should be
> > resolved
> > by either adding empty trips subnode or dropping the trips subnode
> > requirement.
> >
> > Fixes: d0c75fa2c17f ("thermal/of: Initialize trip points separately")
> > Signed-off-by: Icenowy Zheng <uwu@icenowy.me>
> > Reviewed-by: Mark Brown <broonie@kernel.org>
> > Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
> > ---
> > Resurrecting this patch specifically for MediaTek MT8183 Kukui devices.
> >
> > Changes since v1:
> > - set *ntrips at beginning of thermal_of_trips_init()
> > - Keep goto out_of_node_put in of_get_child_count(trips) =3D=3D 0 branc=
h
> > - Check return value of thermal_of_trips_init(), if it is -ENXIO, print
> >   warning and clear |trips| pointer
> > - Drop |mask| change, as the variable was removed
> >
> > I kept Mark's reviewed-by since the changes are more stylish than
> > functional.
> > ---
> >  drivers/thermal/thermal_of.c | 19 ++++++++++++-------
> >  1 file changed, 12 insertions(+), 7 deletions(-)
> >
> > diff --git a/drivers/thermal/thermal_of.c
> > b/drivers/thermal/thermal_of.c
> > index aa34b6e82e26..f237e74c92fc 100644
> > --- a/drivers/thermal/thermal_of.c
> > +++ b/drivers/thermal/thermal_of.c
> > @@ -128,16 +128,17 @@ static struct thermal_trip
> > *thermal_of_trips_init(struct device_node *np, int *n
> >       struct device_node *trips, *trip;
> >       int ret, count;
> >
> > +     *ntrips =3D 0;
> >       trips =3D of_get_child_by_name(np, "trips");
> >       if (!trips) {
> > -             pr_err("Failed to find 'trips' node\n");
> > -             return ERR_PTR(-EINVAL);
> > +             pr_debug("Failed to find 'trips' node\n");
> > +             return ERR_PTR(-ENXIO);
> >       }
> >
> >       count =3D of_get_child_count(trips);
> >       if (!count) {
> > -             pr_err("No trip point defined\n");
> > -             ret =3D -EINVAL;
> > +             pr_debug("No trip point defined\n");
> > +             ret =3D -ENXIO;
> >               goto out_of_node_put;
> >       }
> >
> > @@ -162,7 +163,6 @@ static struct thermal_trip
> > *thermal_of_trips_init(struct device_node *np, int *n
> >
> >  out_kfree:
> >       kfree(tt);
> > -     *ntrips =3D 0;
> >  out_of_node_put:
> >       of_node_put(trips);
>
> It might be a bit cleaner to keep the "*ntrips =3D 0" assignment
> in the error handling path(s) only, with the positions of the goto
> labels adjusted a bit, and then assign -ENXIO to "ret" and jump
> to the right label when of_get_child_by_name(np, "trips") fails,
> instead of returning from there.
>
> If it's unclear what I'm talking about, please let me know and
> I'll send back the proposed hunk.

I think I understand: move "*ntrips =3D 0" to after of_node_put() in the
error path, and have the "!trips" branch jump to "out_of_node_put" as
well. That works since of_node_put() checks the pointer first.

I'll wait a bit and see if there are any more comments.

ChenYu

> > @@ -490,8 +490,13 @@ static struct thermal_zone_device
> > *thermal_of_zone_register(struct device_node *
> >
> >       trips =3D thermal_of_trips_init(np, &ntrips);
> >       if (IS_ERR(trips)) {
> > -             pr_err("Failed to find trip points for %pOFn id=3D%d\n", =
sensor, id);
> > -             return ERR_CAST(trips);
> > +             if (PTR_ERR(trips) !=3D -ENXIO) {
> > +                     pr_err("Failed to find trip points for %pOFn id=
=3D%d\n", sensor, id);
> > +                     return ERR_CAST(trips);
> > +             }
> > +
> > +             pr_warn("Failed to find trip points for %pOFn id=3D%d\n",=
 sensor, id);
> > +             trips =3D NULL;
> >       }
> >
> >       ret =3D thermal_of_monitor_init(np, &delay, &pdelay);

