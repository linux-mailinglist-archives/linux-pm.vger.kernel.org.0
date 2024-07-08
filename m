Return-Path: <linux-pm+bounces-10775-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B937E92A445
	for <lists+linux-pm@lfdr.de>; Mon,  8 Jul 2024 16:03:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C8A2280FBC
	for <lists+linux-pm@lfdr.de>; Mon,  8 Jul 2024 14:03:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA8725381B;
	Mon,  8 Jul 2024 14:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oIaYTtGT"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1823365;
	Mon,  8 Jul 2024 14:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720447425; cv=none; b=g8gcqm62GWMm19F3QrM4rDQrSsnrYpidT3E48c4jiskIghoJWCAn9gjNFsw5qcWyj/K+f/2rJjPME/9GQcLuhlpc81wwh0WnJv6ArxVyF5pHGfvgLgypzvzZovpoKINS3FKGR+RA99UVymERWhPQc2gLMvzdgia8DozneKXI8mY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720447425; c=relaxed/simple;
	bh=A/3ZjjFes8GuhpOGOj2FY+YGzFu892sLxdZ3QKkwKlE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aCytS9Iyg5cprOsf6Jp9c47vKpCyALDkcfPP36jRBn8mFq5cgXEH7NO3mauz3fKZGGleAy//6fLi/AI78iqWoDZlFTqeDGLOEMoKi1RPMyRycTYuiqDzpGihi4b0qCrLVsoRoqu7vkDDxoeIBwlMaeA6ZIjYeNXxdEdHJYidKr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oIaYTtGT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FB2AC116B1;
	Mon,  8 Jul 2024 14:03:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720447425;
	bh=A/3ZjjFes8GuhpOGOj2FY+YGzFu892sLxdZ3QKkwKlE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=oIaYTtGTt8v4gWfDBR1je0+oi32IadA86dWZjrRR1cCG86MprUjOIkDVARhKj+2a6
	 SWHLAesXxqy6Gy1LW1iJCYJ6lpeqGg7/CAeqFdDThMSq4AuXjlBi6yXrM+j6+dWuV6
	 gb3tkO5LwSV3uLZACz1spIIQvJKSsDnk1jWPc98rK5jXdGgGbSzyhS1qLuBqaCAGc6
	 Wp3jI6GOQVh88wIyZy2Yv3L9VKC7YKZrwpUNa5dtecnj7sWrrqRwd73EcmXgsH8gIR
	 fDdU/BXZNf2HA5AoSDEGBP3UZc/XFXGNGr1ZBdidkRIe/czFH8POWNap2jhwUGPbDd
	 FuN5EIl1ew/vg==
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-5c665d8345dso66930eaf.2;
        Mon, 08 Jul 2024 07:03:45 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV6Mx1JzFn+cr32asgrBg1Jy/tfiz/wtJQMUlXDtJus7gNSyQQsd39qxZouYfgf0tOomuLHFCx5hJvkIILd/lWDZkocXAmgQWmJWF3OmOOtf8w8Q1IIR47X8/8iBs4VhBzdhxwWjD8=
X-Gm-Message-State: AOJu0Yzerpxh0zHUypHcS1w+onLMf17rFv60m0L9tIPToN3klaxVRAhW
	xFhs0ETUr5Mrw+rjwNRO7HBe5ezXpDfcNQ+YWosikBvyCw9gbe1aWm25uZIM1sSKIMBhpvEFcVm
	ApeSDdgQNK0LtFVkDSnRYT2RN3sM=
X-Google-Smtp-Source: AGHT+IEl2JwqTjYTZp4XOuoPpIdEzHVejZ87NwADjNwIkEh8f7/pazmJMZpUo3rvQZMxCvkCsxQ3auk+d5/qRxUPulo=
X-Received: by 2002:a05:6820:1011:b0:5c6:67b7:41dd with SMTP id
 006d021491bc7-5c667b74e38mr5176178eaf.0.1720447424404; Mon, 08 Jul 2024
 07:03:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2746673.mvXUDI8C0e@rjwysocki.net> <4940808.31r3eYUQgx@rjwysocki.net>
 <402ede79-5eda-48fc-8eb8-5d89ffe6bd41@linaro.org> <CAJZ5v0jgTN+6WC9nPGCidMnMjSsYMcMe+m=8Ge7Hr--utefM2Q@mail.gmail.com>
 <a5188c05-cd06-4678-8fb4-1f0b55c18b04@linaro.org>
In-Reply-To: <a5188c05-cd06-4678-8fb4-1f0b55c18b04@linaro.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 8 Jul 2024 16:03:32 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0i89BJD8AayxqJR912rkg+P8m9qq=GubCXJxmdPuj7DmQ@mail.gmail.com>
Message-ID: <CAJZ5v0i89BJD8AayxqJR912rkg+P8m9qq=GubCXJxmdPuj7DmQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] thermal: core: Add sanity check for polling_delay
 and passive_delay
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, 
	Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Lukasz Luba <lukasz.luba@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 8, 2024 at 3:58=E2=80=AFPM Daniel Lezcano <daniel.lezcano@linar=
o.org> wrote:
>
> On 08/07/2024 15:38, Rafael J. Wysocki wrote:
> > On Mon, Jul 8, 2024 at 2:12=E2=80=AFPM Daniel Lezcano <daniel.lezcano@l=
inaro.org> wrote:
> >>
> >> On 05/07/2024 21:46, Rafael J. Wysocki wrote:
> >>> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >>>
> >>> If polling_delay is nonzero and passive_delay is 0, the thermal zone
> >>> will use polling except when tz->passive is nonzero, which does not m=
ake
> >>> sense.
> >>>
> >>> Also if polling_delay is nonzero and passive_delay is greater than
> >>> polling_delay, the thermal zone temperature will be updated less ofte=
n
> >>> when tz->passive is nonzero.  This does not make sense either.
> >>>
> >>> Ensure that none of the above will happen.
> >>>
> >>> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >>> ---
> >>>
> >>> v1 -> v2: The patch actually matches the changelog
> >>>
> >>> ---
> >>>    drivers/thermal/thermal_core.c |    3 +++
> >>>    1 file changed, 3 insertions(+)
> >>>
> >>> Index: linux-pm/drivers/thermal/thermal_core.c
> >>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >>> --- linux-pm.orig/drivers/thermal/thermal_core.c
> >>> +++ linux-pm/drivers/thermal/thermal_core.c
> >>> @@ -1440,6 +1440,9 @@ thermal_zone_device_register_with_trips(
> >>>                td->threshold =3D INT_MAX;
> >>>        }
> >>>
> >>> +     if (polling_delay && (passive_delay > polling_delay || !passive=
_delay))
> >>> +             passive_delay =3D polling_delay;
> >>
> >> Given this is a system misconfiguration, it would make more sense to
> >> bail out with -EINVAL. Assigning a default value in the back of the
> >> caller will never raise its attention and can make a bad configuration
> >> staying for a long time.
> >
> > This works except for the case mentioned below.
> >
> > I think that passive_delay > polling_delay can trigger a -EINVAL, but
> > (polling_delay && !passive_delay) cannot do it because it is regarded
> > as a valid case as per the below.
>
> Right I can see ATM only this as an illogic combination:
>
>         polling_delay && passive_delay &&
>         (polling_delay < passive_delay)
>
> >> That said, there are configurations with a passive delay set to zero b=
ut
> >> with a non zero polling delay. For instance, a thermal zone mitigated
> >> with a fan, so active trip points are set. Another example is when the=
re
> >> is only critical trip points for a thermal zone.
> >>
> >> Actually there are multiple combinations with delays value which may
> >> look invalid but which are actually valid.
> >>
> >> For example, a setup with polling_delay > 0, passive_delay =3D 0, acti=
ve
> >> trip points, cooling map to this active trips, passive trip points
> >> without cooling map.
> >>
> >> IMHO, it is better to do the configuration the system is asking for,
> >> even if it sounds weird
> >
> > Except that it doesn't work as expected because if passive_delay =3D 0,
> > polling is paused when tz->passive is set.
>
> Yes, but as there is no cooling map, there is no governor action, thus
> tz->passive is never set.

In current linux-next, it is set when a passive trip is crossed on the way =
up.

> So we can have a passive polling equal to zero
> without being illegal as no passive mitigation will happen.
>
> The passive delay is really there only if there is a passive cooling
> device mapped to a passive trip point.

Well, shouldn't user space get notified more often when passive
cooling is under way?

> The polling delay is in charge of mitigating the active cooling device
> like a fan. So it is possible to mix an active trip point to mitigate
> with a fan and then put at a higher temperature a passive trip point
> with a higher sampling resolution.

But it is not correct to pause polling when tz->passive is set.

