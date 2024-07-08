Return-Path: <linux-pm+bounces-10771-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B062292A3C3
	for <lists+linux-pm@lfdr.de>; Mon,  8 Jul 2024 15:38:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E22341C214FC
	for <lists+linux-pm@lfdr.de>; Mon,  8 Jul 2024 13:38:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08152137923;
	Mon,  8 Jul 2024 13:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eswCSAla"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4EE97CF3A;
	Mon,  8 Jul 2024 13:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720445899; cv=none; b=txOH93xcaDVXLw8NkUkltkthVLdrTaCu2ryYL/95mojxTFg5r2g7IT7mN4WLOZ/R7he35srmD5Rui/IPuCVQRSAGxP91N9jCrAqouOUGbRkhEMZ9hoBuwN+7MCgr+vBfs8yQEfR7/7JBAdBD63xXc3VtHmYGO9YTDVhVvRNKN3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720445899; c=relaxed/simple;
	bh=BIjZ/Q/rNq6WVjfjZF4oPBh7N8vXtzm3u6cUD8VASMM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=by/RGv5oVThba/f9hBBg9Nn78S+pq5Cf68SeUyMKNXg08UAy53ayMYCO0SV5w4QZxtNvcDBZpNHcYzcbsn8Z7g1ZDav30nLVUTIM0CSR2c5DsRNB8QlAyax0L3Q1X30SV2zPy1wHoLgOciCYK3TNN2jBvCDj3+3pBkPOqcVKqXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eswCSAla; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BFC3C4AF0C;
	Mon,  8 Jul 2024 13:38:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720445899;
	bh=BIjZ/Q/rNq6WVjfjZF4oPBh7N8vXtzm3u6cUD8VASMM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=eswCSAlaM65qts60lonI5GLmgMkbe40KF2V6kLATyxpS/gViFqZutFwh7/FaPuwOQ
	 pvx44U7+AufJkue/iQ930/g5x5t6MDHGuUl9Tkv1wknegzxPLvS8GaZWuXyNLq3Can
	 mF0I6fLoO49PGcuHLq3VGj80EpoQ2QbqOgZaxjQp4HleE8fr/4CmRIjf3UvoQNHeeP
	 bBQXMxjP4CQCenpiDqrsi9wDiyx48QjvToWclyg22/hq49PZGMnp3tliBJnDnKIJA4
	 Vh37JCuUF4bguUaMy85CZj/MsVqgzrNNA/VKGLUeocrE4kH77c5g8vDJH/8Sw9itKg
	 BX+2qnGu9iuCw==
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-5c6780d13afso27449eaf.2;
        Mon, 08 Jul 2024 06:38:19 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXdQfnSRDWWKjXIclry0mwHuXHdkEc8fFuxTj47BRPF0IGWM1SRxVmXScuFqPvVWdwTKoVEPZwL8U6VMc6UrwGrwBM+vp+HRPpYivojXbwnFR3S2BSwv47ZCjxbdYxd9PeA9/e1teE=
X-Gm-Message-State: AOJu0YzilrQ3YQpbJ5WivSeE1AlAh7mMQttU+LWk7vbhoOeyJ/ERmGff
	6U0K/vI7GeC0MJhbYo/2rw+fnOhEMawswP8AR4oL+6mWRCjSbGEj339pofJw3wcHCT9fog+4Ulj
	q7H3qY7iK6p8Hvt5LianElsbceWE=
X-Google-Smtp-Source: AGHT+IEbB8eIB9JsuUUbx3IAYLs+olnVxVzaZTOQA37htD5fMkqZfxqKkPm8ZGK0PNpmnE9euG9vWejD6Uur9ptQ8/k=
X-Received: by 2002:a05:6820:b90:b0:5c6:65fb:d734 with SMTP id
 006d021491bc7-5c665fbd78cmr5526042eaf.1.1720445898719; Mon, 08 Jul 2024
 06:38:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2746673.mvXUDI8C0e@rjwysocki.net> <4940808.31r3eYUQgx@rjwysocki.net>
 <402ede79-5eda-48fc-8eb8-5d89ffe6bd41@linaro.org>
In-Reply-To: <402ede79-5eda-48fc-8eb8-5d89ffe6bd41@linaro.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 8 Jul 2024 15:38:07 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0jgTN+6WC9nPGCidMnMjSsYMcMe+m=8Ge7Hr--utefM2Q@mail.gmail.com>
Message-ID: <CAJZ5v0jgTN+6WC9nPGCidMnMjSsYMcMe+m=8Ge7Hr--utefM2Q@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] thermal: core: Add sanity check for polling_delay
 and passive_delay
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, Lukasz Luba <lukasz.luba@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 8, 2024 at 2:12=E2=80=AFPM Daniel Lezcano <daniel.lezcano@linar=
o.org> wrote:
>
> On 05/07/2024 21:46, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > If polling_delay is nonzero and passive_delay is 0, the thermal zone
> > will use polling except when tz->passive is nonzero, which does not mak=
e
> > sense.
> >
> > Also if polling_delay is nonzero and passive_delay is greater than
> > polling_delay, the thermal zone temperature will be updated less often
> > when tz->passive is nonzero.  This does not make sense either.
> >
> > Ensure that none of the above will happen.
> >
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > ---
> >
> > v1 -> v2: The patch actually matches the changelog
> >
> > ---
> >   drivers/thermal/thermal_core.c |    3 +++
> >   1 file changed, 3 insertions(+)
> >
> > Index: linux-pm/drivers/thermal/thermal_core.c
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > --- linux-pm.orig/drivers/thermal/thermal_core.c
> > +++ linux-pm/drivers/thermal/thermal_core.c
> > @@ -1440,6 +1440,9 @@ thermal_zone_device_register_with_trips(
> >               td->threshold =3D INT_MAX;
> >       }
> >
> > +     if (polling_delay && (passive_delay > polling_delay || !passive_d=
elay))
> > +             passive_delay =3D polling_delay;
>
> Given this is a system misconfiguration, it would make more sense to
> bail out with -EINVAL. Assigning a default value in the back of the
> caller will never raise its attention and can make a bad configuration
> staying for a long time.

This works except for the case mentioned below.

I think that passive_delay > polling_delay can trigger a -EINVAL, but
(polling_delay && !passive_delay) cannot do it because it is regarded
as a valid case as per the below.

> That said, there are configurations with a passive delay set to zero but
> with a non zero polling delay. For instance, a thermal zone mitigated
> with a fan, so active trip points are set. Another example is when there
> is only critical trip points for a thermal zone.
>
> Actually there are multiple combinations with delays value which may
> look invalid but which are actually valid.
>
> For example, a setup with polling_delay > 0, passive_delay =3D 0, active
> trip points, cooling map to this active trips, passive trip points
> without cooling map.
>
> IMHO, it is better to do the configuration the system is asking for,
> even if it sounds weird

Except that it doesn't work as expected because if passive_delay =3D 0,
polling is paused when tz->passive is set.

Thanks!

