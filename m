Return-Path: <linux-pm+bounces-10779-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CBFEE92A567
	for <lists+linux-pm@lfdr.de>; Mon,  8 Jul 2024 17:11:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 80CD228109C
	for <lists+linux-pm@lfdr.de>; Mon,  8 Jul 2024 15:11:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 357451422C8;
	Mon,  8 Jul 2024 15:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cKH0f+kM"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B06B13EFF3;
	Mon,  8 Jul 2024 15:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720451494; cv=none; b=mQAEOVriOY8wGByZl2onOBaOqndP2f99eLfuuiXwRR80l6pxFkGJj0W2aG7N6WEo/KZMU6j516nj9HgyCuCANGuMXUyc83hGzQeOELU2bHUKt7sIWpu7oPwDelsnaix1drJjSPSm56eWtHQAXOfEayHQaFstZepctdWi/0PIiMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720451494; c=relaxed/simple;
	bh=HY1B5gDZ1B+3w+pQBL9URGoslG1Sq2Spw3a9sUsSZuI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u+P5m3etpjdCWHvk0kd47YiAGSielZZMxuSvYY6eEmFemeag2xHFMk/eQxvppwnVXh/W53m9hnvN8UrSsjBcacG2YfTjIgG0ldgYfYD0ofp+o47tP7hqmW3Y76w/Cb4k5OUW8v2XsVFJUEZPebn6Z11329ZJO2PAnIjmnU6po8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cKH0f+kM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3F11C4AF0C;
	Mon,  8 Jul 2024 15:11:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720451493;
	bh=HY1B5gDZ1B+3w+pQBL9URGoslG1Sq2Spw3a9sUsSZuI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=cKH0f+kMaqJcbUg8h3Bg9MXN/inKyUNN6Q/6cKTW1Z0aPeQPuWLt0YpPZsRk4PcoH
	 FsFFLAqlptZEy0M+NyKvRK3ugrqucGIq5b8uYHYH8MFxXsKMxrLOx2+7PqSrJSmR4u
	 ncMzMSIjyJtVlohrt7YfVCXH+kbTae69W54BMkx7J0txuwdxS73rYBKOsDB+9/Uu+d
	 VRUb/nzSv5FXrgaTdqBa98Iw2opK9x4AqNTkLy8DfZL7BPspyLO9si2us1tw5nT/mP
	 kBjKeenqfT0LzPco+Oo1mn8LB+Ewopq8+ElpYNkyfzwin32F5e3BLsAlk1S0hl1l2y
	 n9R2SXWkKSF9g==
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-25e80d68776so192213fac.1;
        Mon, 08 Jul 2024 08:11:33 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXpTTT1aQDX+GATuaFl6GjO3mIJMYmt1ojo4hMQhUf1lmbeNX0AZwBEZoDqSiC1sU9eLN5BA78FU/OGiw4czhSQ8e8nX1xWl+SlG3o9HcWeW1u4MSdmUPBu0JlpmaySTJcrNx/ci5A=
X-Gm-Message-State: AOJu0YzXGQ1OuJnJOG4J806Vm+IqaQsvYBMgrVoTOxMBL2Es8JBqspzX
	IpK63pCCYIO0R/OP2sPXCbnDu6v7JJDLXKTPvRQTvjSEv98hpSGPYG3LlKF/HGvOqCurve8MuGm
	kfC2LrSELAdyBGrSZPUPzhdiJKHY=
X-Google-Smtp-Source: AGHT+IHX1Wc170FCbddRY989Bhft9DN1TkSuthlvkZXkH/qTMMDKfhl2p57pI5rIzUmQJgE1GP7zx/vSmywAj7aZXJ4=
X-Received: by 2002:a05:6870:a1a0:b0:254:7e18:7e1a with SMTP id
 586e51a60fabf-25e2bff9792mr12086430fac.5.1720451492903; Mon, 08 Jul 2024
 08:11:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2746673.mvXUDI8C0e@rjwysocki.net> <4940808.31r3eYUQgx@rjwysocki.net>
 <402ede79-5eda-48fc-8eb8-5d89ffe6bd41@linaro.org> <CAJZ5v0jgTN+6WC9nPGCidMnMjSsYMcMe+m=8Ge7Hr--utefM2Q@mail.gmail.com>
 <a5188c05-cd06-4678-8fb4-1f0b55c18b04@linaro.org> <CAJZ5v0i89BJD8AayxqJR912rkg+P8m9qq=GubCXJxmdPuj7DmQ@mail.gmail.com>
 <02ed646e-b344-4802-a4ef-806a1e0cac67@linaro.org>
In-Reply-To: <02ed646e-b344-4802-a4ef-806a1e0cac67@linaro.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 8 Jul 2024 17:11:21 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hSf4cmNmmNpYn-EAy9PG19bxjW2189dNj3nt-82Zk7MA@mail.gmail.com>
Message-ID: <CAJZ5v0hSf4cmNmmNpYn-EAy9PG19bxjW2189dNj3nt-82Zk7MA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] thermal: core: Add sanity check for polling_delay
 and passive_delay
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, 
	Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Lukasz Luba <lukasz.luba@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 8, 2024 at 4:32=E2=80=AFPM Daniel Lezcano <daniel.lezcano@linar=
o.org> wrote:
>
> On 08/07/2024 16:03, Rafael J. Wysocki wrote:
> > On Mon, Jul 8, 2024 at 3:58=E2=80=AFPM Daniel Lezcano <daniel.lezcano@l=
inaro.org> wrote:
> >>
> >> On 08/07/2024 15:38, Rafael J. Wysocki wrote:
> >>> On Mon, Jul 8, 2024 at 2:12=E2=80=AFPM Daniel Lezcano <daniel.lezcano=
@linaro.org> wrote:
> >>>>
> >>>> On 05/07/2024 21:46, Rafael J. Wysocki wrote:
> >>>>> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >>>>>
> >>>>> If polling_delay is nonzero and passive_delay is 0, the thermal zon=
e
> >>>>> will use polling except when tz->passive is nonzero, which does not=
 make
> >>>>> sense.
> >>>>>
> >>>>> Also if polling_delay is nonzero and passive_delay is greater than
> >>>>> polling_delay, the thermal zone temperature will be updated less of=
ten
> >>>>> when tz->passive is nonzero.  This does not make sense either.
> >>>>>
> >>>>> Ensure that none of the above will happen.
> >>>>>
> >>>>> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >>>>> ---
> >>>>>
> >>>>> v1 -> v2: The patch actually matches the changelog
> >>>>>
> >>>>> ---
> >>>>>     drivers/thermal/thermal_core.c |    3 +++
> >>>>>     1 file changed, 3 insertions(+)
> >>>>>
> >>>>> Index: linux-pm/drivers/thermal/thermal_core.c
> >>>>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >>>>> --- linux-pm.orig/drivers/thermal/thermal_core.c
> >>>>> +++ linux-pm/drivers/thermal/thermal_core.c
> >>>>> @@ -1440,6 +1440,9 @@ thermal_zone_device_register_with_trips(
> >>>>>                 td->threshold =3D INT_MAX;
> >>>>>         }
> >>>>>
> >>>>> +     if (polling_delay && (passive_delay > polling_delay || !passi=
ve_delay))
> >>>>> +             passive_delay =3D polling_delay;
> >>>>
> >>>> Given this is a system misconfiguration, it would make more sense to
> >>>> bail out with -EINVAL. Assigning a default value in the back of the
> >>>> caller will never raise its attention and can make a bad configurati=
on
> >>>> staying for a long time.
> >>>
> >>> This works except for the case mentioned below.
> >>>
> >>> I think that passive_delay > polling_delay can trigger a -EINVAL, but
> >>> (polling_delay && !passive_delay) cannot do it because it is regarded
> >>> as a valid case as per the below.
> >>
> >> Right I can see ATM only this as an illogic combination:
> >>
> >>          polling_delay && passive_delay &&
> >>          (polling_delay < passive_delay)
> >>
> >>>> That said, there are configurations with a passive delay set to zero=
 but
> >>>> with a non zero polling delay. For instance, a thermal zone mitigate=
d
> >>>> with a fan, so active trip points are set. Another example is when t=
here
> >>>> is only critical trip points for a thermal zone.
> >>>>
> >>>> Actually there are multiple combinations with delays value which may
> >>>> look invalid but which are actually valid.
> >>>>
> >>>> For example, a setup with polling_delay > 0, passive_delay =3D 0, ac=
tive
> >>>> trip points, cooling map to this active trips, passive trip points
> >>>> without cooling map.
> >>>>
> >>>> IMHO, it is better to do the configuration the system is asking for,
> >>>> even if it sounds weird
> >>>
> >>> Except that it doesn't work as expected because if passive_delay =3D =
0,
> >>> polling is paused when tz->passive is set.
> >>
> >> Yes, but as there is no cooling map, there is no governor action, thus
> >> tz->passive is never set.
> >
> > In current linux-next, it is set when a passive trip is crossed on the =
way up.
>
> Ah, I see. AFAIR that was the gov_step_wise which was changing this
> value but based on the thermal instance.
>
> >> So we can have a passive polling equal to zero
> >> without being illegal as no passive mitigation will happen.
> >>
> >> The passive delay is really there only if there is a passive cooling
> >> device mapped to a passive trip point.
> >
> > Well, shouldn't user space get notified more often when passive
> > cooling is under way?
>
> (Assuming you meant "user space get notified when a passive trip point
> is crossed")
>
> Mmh, yes. I see the point.
>
>
> >> The polling delay is in charge of mitigating the active cooling device
> >> like a fan. So it is possible to mix an active trip point to mitigate
> >> with a fan and then put at a higher temperature a passive trip point
> >> with a higher sampling resolution.
> >
> > But it is not correct to pause polling when tz->passive is set.
>
> I'm not sure to get the comment.
>
> Just to clarify:
>
> trip A is active with a multi speed fan, polling every 1s
>
> trip B is passive with a cpufreq cooling device, polling every 100ms
>
> temp(tripA) < temp(tripB)
>
> When the trip A is crossed, the mitigation happens at <polling> rate.
> Assuming it fails to cool down, the fan continues to increase its speed
> until it reaches its max state.
>
> The temperature continues to increase and crosses the passive trip
> point. The fan speed stays at its maximum and the polling switches to
> the passive polling delay.

Yes, but if the passive polling delay happens to be zero, it will stop
the polling entirely until tz->passive becomes zero again.

I don't believe that this is correct.

