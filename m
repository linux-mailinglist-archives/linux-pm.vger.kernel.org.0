Return-Path: <linux-pm+bounces-1966-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A7826827D76
	for <lists+linux-pm@lfdr.de>; Tue,  9 Jan 2024 04:46:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CEDD91C222DE
	for <lists+linux-pm@lfdr.de>; Tue,  9 Jan 2024 03:46:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68E3B4430;
	Tue,  9 Jan 2024 03:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="YUX6y1tG"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C69553FFF
	for <linux-pm@vger.kernel.org>; Tue,  9 Jan 2024 03:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2cc7b9281d1so32144021fa.1
        for <linux-pm@vger.kernel.org>; Mon, 08 Jan 2024 19:45:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1704771955; x=1705376755; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fd7/YRbFPwHwO9y5he5hBNzYN/gDqY/82MzLlZm9KnI=;
        b=YUX6y1tG7xv77dbnHj+tbsPeKpGIO+31YWU1RrmrxfEg41rO0kFYBwQjuYwEH6ApTD
         OXTteLB8dz+cu2W9Glu88ngzn7jSSIzj5/WQ5lQHBq41kHV0TOvh4rkcI4LqGR5PehIQ
         ivDfsmlmdHju4c5zpL+ZAlWdL+rkBn1cTL1n0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704771955; x=1705376755;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fd7/YRbFPwHwO9y5he5hBNzYN/gDqY/82MzLlZm9KnI=;
        b=PRbQEPSMRCfYd5f+03JTy0Xk3DPUdiuyAB4JtWDUD7rpKimieYbKurxPWpreHgN5EE
         oOZDZwTPJs0bliIxI/GiGhX1p4TQxQK7g1IqcxK0pl7LRuhYVtoMu4wLft06EhBdcVuN
         brl4RTlc1fB3uUaKr86os3UCSKU2wD02ogY2uqifhCqcP4z5VFLPLaVbJwXnh/xkpej+
         iwd/wyoHofczWV1PiGzSeuhM3B20FuPw0XRd0zm8XcL/VN/UhGqgCQP6aMeUy0CEYTrK
         5sBfRD4Au5ZwXrDuzieVeNYXtXL0Cvd03zRqdxcaylUVvCM3yYAxWwxUc57xJRm0Z6Fn
         LYNA==
X-Gm-Message-State: AOJu0Ywsf9Q/hdYqYXS701sJKktoMO9D4Q/AmMlSP/aHXaYmOM4odKD3
	gL18GSQpB+RXGHvlF+8+2kLXBNH3FZOl6dnfjTBOKx91GpiN
X-Google-Smtp-Source: AGHT+IEz8gHQeTkHleBOQVXUJi9TNmpfOEWm3/cRKrxK6wXP1Bm8y7NANfcHn1QPY9Df6/CM1zdVeVWY/y0P7EUByUg=
X-Received: by 2002:a2e:7003:0:b0:2cd:417d:195e with SMTP id
 l3-20020a2e7003000000b002cd417d195emr2052291ljc.49.1704771954850; Mon, 08 Jan
 2024 19:45:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231219082726.844508-1-wenst@chromium.org> <CAJZ5v0j2LTWt-vBLuDRk3aj0nK1Rmq5Np9QmzDe=_7RGq4rFiA@mail.gmail.com>
In-Reply-To: <CAJZ5v0j2LTWt-vBLuDRk3aj0nK1Rmq5Np9QmzDe=_7RGq4rFiA@mail.gmail.com>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Tue, 9 Jan 2024 11:45:43 +0800
Message-ID: <CAGXv+5GX=7-4NVLtGtihEuNGbaeV3E+AwK=3iWqOwF5-XTyCaA@mail.gmail.com>
Subject: Re: [PATCH] thermal/core: Correctly free tz->tzp in thermal zone
 registration error path
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, 
	Lukasz Luba <lukasz.luba@arm.com>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 19, 2023 at 11:28=E2=80=AFPM Rafael J. Wysocki <rafael@kernel.o=
rg> wrote:
>
> On Tue, Dec 19, 2023 at 9:27=E2=80=AFAM Chen-Yu Tsai <wenst@chromium.org>=
 wrote:
> >
> > After commit 3d439b1a2ad3 ("thermal/core: Alloc-copy-free the thermal
> > zone parameters structure"), the core now copies the thermal zone
> > parameters structure, and frees it if an error happens during thermal
> > zone device registration, or upon unregistration of the device.
> >
> > In the error path, if device_register() was called, then `tz` disappear=
s
> > before kfree(tz->tzp) happens, causing a NULL pointer deference crash.
> >
> > In my case, the error path was entered from the sbs power supply driver=
,
> > which through the power supply core registers a thermal zone *without
> > trip points* for the battery temperature sensor. This combined with
> > setting the default thermal governor to "power allocator", which
> > *requires* trip_max, causes the thermal zone registration to error out.
> >
> > The error path should handle the two cases, one where device_register
> > has not happened and the kobj hasn't been reference counted, and vice
> > versa where it has. The original commit tried to cover the first case,
> > but fails for the second. Fix this by adding kfree(tz->tzp) before
> > put_device() to cover the second case, and check if `tz` is still valid
> > before calling kfree(tz->tzp) to avoid crashing in the second case.
> >
> > Fixes: 3d439b1a2ad3 ("thermal/core: Alloc-copy-free the thermal zone pa=
rameters structure")
> > Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
> > ---
> > This includes the minimal changes to fix the crash. I suppose some othe=
r
> > things in the thermal core could be reworked:
> > - Don't use "power allocator" for thermal zones without trip points
> > - Move some of the thermal zone cleanup code into the release function
> >
> >  drivers/thermal/thermal_core.c | 6 +++++-
> >  1 file changed, 5 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_c=
ore.c
> > index 2415dc50c31d..e47826d82062 100644
> > --- a/drivers/thermal/thermal_core.c
> > +++ b/drivers/thermal/thermal_core.c
> > @@ -1392,12 +1392,16 @@ thermal_zone_device_register_with_trips(const c=
har *type, struct thermal_trip *t
> >  unregister:
> >         device_del(&tz->device);
> >  release_device:
> > +       /* Free tz->tzp before tz goes away. */
> > +       kfree(tz->tzp);
> >         put_device(&tz->device);
> >         tz =3D NULL;
> >  remove_id:
> >         ida_free(&thermal_tz_ida, id);
> >  free_tzp:
> > -       kfree(tz->tzp);
> > +       /* If we arrived here before device_register() was called. */
> > +       if (tz)
> > +               kfree(tz->tzp);
> >  free_tz:
> >         kfree(tz);
> >         return ERR_PTR(result);
> > --
>
> Can you please test linux-next from today?  The issue addressed by
> your patch should be fixed there.

Sorry for the very late reply. Yes it does. Thanks.

ChenYu

