Return-Path: <linux-pm+bounces-11660-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EC0094101F
	for <lists+linux-pm@lfdr.de>; Tue, 30 Jul 2024 13:01:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 426B41C20C1D
	for <lists+linux-pm@lfdr.de>; Tue, 30 Jul 2024 11:01:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1710118D4C1;
	Tue, 30 Jul 2024 11:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jcpHCZkr"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E688913DDAE
	for <linux-pm@vger.kernel.org>; Tue, 30 Jul 2024 11:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722337269; cv=none; b=rf/MqwdkF7WGstu6GosRgm3ZF5BIhR8nw65c9IQ+RtVsdCty/ntNMDsHhA7ueHUcj5KZeadwqJOXL+L3MbLQSVdlLMMEtqOgiwEYmjPYxlQN1eaFFevtMWHut8nGWLUrWiuO351ac6v7bpLbwLlvMTS8Kzf+xWDAkiLp921c/zE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722337269; c=relaxed/simple;
	bh=lch+rYg8fn6kHxBwqliEEiadOO4fUYdmO5ukKGE9hDM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ntT4CIHyVHytQ7ximbyN6wS0zjZ30pTm30nhtGFMMbSsf0OTxYFKnTHuE55eQqGfx4QaAtCSp9S4mjegBjsO+SOw8lghSU9zmtDtzfDTzk0pLLGaQkli+dnJWOpwHgh5dHhWNqc5OALyWe9SygbSHXfrRzCnXI/2FHyt4IQOxLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jcpHCZkr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC14EC4AF0B
	for <linux-pm@vger.kernel.org>; Tue, 30 Jul 2024 11:01:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722337268;
	bh=lch+rYg8fn6kHxBwqliEEiadOO4fUYdmO5ukKGE9hDM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=jcpHCZkrpF4MwKlgBO2WTb642S3VGXzYXG3S7Qpe/rUQj4np9dfGRckpGLrhAYAN/
	 B5b6UpwnWEqtm6PzZ4T5TvBDu040ZxWMdEQxKMrfMdhCdTtn+zjlqSMaCeEwkfzrkE
	 5WpnJOhJhDKS9Xh2KEEKSxyTO1SQUlngn7bPGDKXvjWx/e/fnqLhKKrm1KUJmD3U0W
	 F8R0ZqfXYWRzg5KUd06uHGvMUL2wFVMvuGgqUlsxYRUFc5V6kmhj8HIBXv5sRrx+gN
	 lYkJJ/wQZn1zv99rL9/wSQOwUXttfTRXKE4Kn6+t3FmWqQ7gi+KlcWwLnFJ8VX6zEr
	 HQ2BIkwMlKmGA==
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-2635abdc742so686994fac.2
        for <linux-pm@vger.kernel.org>; Tue, 30 Jul 2024 04:01:08 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV7SMyZAe04bS6jEhdVj5P2InlHF22NaiCBpiezUB7rJ8ekr/vRr+bbBsKB51Jos/CA096dSrcNig==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzpa6fL0iu3shygI6xlyRN8yyEtblkvrOib6dMDhzWOSCXPVZey
	UiVoX5SRFs+kDbLrmOm5cv2VwUNb+ddgXPGBBXiQ37UMLFnqanDZrrMWif6rlMup5N5bqzC9ITP
	T8zcznzdYusBCr6E8c/urNbsZLos=
X-Google-Smtp-Source: AGHT+IHYgJEFuOBaAnHkK7yUmnHV+AHzewRyiPsQkpx0EHbSxNof5BR0LZVEp+k/Bs58zfBbSGrkBQon5yH/sCek+A8=
X-Received: by 2002:a4a:e3d7:0:b0:5c6:e7c6:711 with SMTP id
 006d021491bc7-5d5b153c324mr10077475eaf.1.1722337267953; Tue, 30 Jul 2024
 04:01:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240729150259.1089814-1-daniel.lezcano@linaro.org>
 <20240729150259.1089814-2-daniel.lezcano@linaro.org> <12507467.O9o76ZdvQC@rjwysocki.net>
 <97ece7c5-d317-452b-9045-c12940567781@linaro.org>
In-Reply-To: <97ece7c5-d317-452b-9045-c12940567781@linaro.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 30 Jul 2024 13:00:55 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hU6kytESds30u3Z=voppCWCcAbbDsof9mmFXaVCe8YyQ@mail.gmail.com>
Message-ID: <CAJZ5v0hU6kytESds30u3Z=voppCWCcAbbDsof9mmFXaVCe8YyQ@mail.gmail.com>
Subject: Re: [PATCH v1 1/7] thermal/core: Encapsulate more handle_thermal_trip
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, rafael@kernel.org, linux-pm@vger.kernel.org, 
	lukasz.luba@arm.com, quic_manafm@quicinc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Daniel,

On Tue, Jul 30, 2024 at 11:40=E2=80=AFAM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
>
>
> Hi Rafael,
>
> On 29/07/2024 18:57, Rafael J. Wysocki wrote:
> > On Monday, July 29, 2024 5:02:50 PM CEST Daniel Lezcano wrote:
> >> In order to set the scene for the thresholds support which have to
> >> manipulate the low and high temperature boundaries for the interrupt
> >> support, we must pass the low and high value the incoming thresholds
> >> routine.
> >>
> >> Instead of looping in the trip descriptors in
> >> thermal_zone_device_update(), we move the loop in the
> >> handle_thermal_trip() function and use it to set the low and high
> >> values.
> >>
> >> As these variables can be set directly in the handle_thermal_trip(),
> >> we can get rid of a descriptors loop found in the thermal_set_trips()
> >> function as low and high are set in handle_thermal_trip().
> >>
> >> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> >> ---
>
> [ ... ]
>
> >> -    for_each_trip_desc(tz, td)
> >> -            handle_thermal_trip(tz, td, &way_up_list, &way_down_list)=
;
> >> +    handle_thermal_trip(tz, &way_up_list, &way_down_list, &low, &high=
);
> >>
>
> [ ... ]
>
> > Well, why not do the (untested) change below instead, which is way simp=
ler?
>
> Right, I did your proposed changed initially.

OK

> The patch looks very
> complicated but it is just the result of the difference between the
> change above and below. It is code reorg, without functional changes
> (except two loops =3D> one loop).
>
> It looked to me more consistent to move the for_each_trip_desc() inside
> handle_thermal_trip() in order to:
>   - encapsulate the trip code more and have one line call

I don't agree with this.

The purpose is questionable and the code becomes more complex overall.
And I'm totally not a fan of passing values through pointers if that
is avoidable.

>   - be consistent with the thermal_threshold_handle() which is also one
> line call

That is a somewhat different story.

> If you prefer, I can split the changes, but it is extra work for little
> benefit. I pushed the changes in the git tree, the resulting code from
> these changes are:
>
> https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git/tree/dr=
ivers/thermal/thermal_core.c?h=3Dthermal/threshold-patchset#n427
>
> and
>
> https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git/tree/dr=
ivers/thermal/thermal_core.c?h=3Dthermal/threshold-patchset#n600
>
> Let me know if you prefer to do a smaller change or go forward in the
> code encapsulation

I'd prefer to make a smaller change (obviously).

> > The thermal_zone_set_trips() kerneldoc needs to be either updated or dr=
opped
> > because it is not applicable any more after this and I think it's bette=
r to
> > just drop it.
>
> Sure

BTW, there is a problem in thermal_zone_set_trips() now if the zone
temperature is exactly equal to one of the trip's thresholds because
it will then skip that trip.

Say there are three trips, A, B, C sorted in ascending temperature
order with no hysteresis.  Say the zone temperature is exactly equal
to the temperature of B.  thermal_zone_set_trips() will set the
boundaries to A and C, so the crossing of B will not be caught.

IMV, both comparisons with the zone temperature in
thermal_zone_set_trips() need to be made not strict, that is

        if (td->threshold <=3D tz->temperature && td->threshold > low)
            low =3D td->threshold;

        if (td->threshold =3D> tz->temperature && td->threshold < high)
            high =3D td->threshold;

in order to catch all of the trip crossing events.

Of course, in the example above, this will cause
thermal_zone_set_trips() to set both the boundaries to B, but that's
OK because it will trigger an interrupt when the zone temperature
becomes different from the B threshold regardless of which way it goes
and that will allow a new interval to be set (aither {A, B} if it goes
down or {B, C} if it goes up).

IMV this change needs to be made in -stable, so I'll send a patch for
it to be applied before any other changes in thermal_zone_set_trips().

