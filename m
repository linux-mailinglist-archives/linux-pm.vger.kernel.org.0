Return-Path: <linux-pm+bounces-22705-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 379A8A4037B
	for <lists+linux-pm@lfdr.de>; Sat, 22 Feb 2025 00:32:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 13E8A17C855
	for <lists+linux-pm@lfdr.de>; Fri, 21 Feb 2025 23:32:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF39220458A;
	Fri, 21 Feb 2025 23:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="LA3GGhoR"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E07CC1E282D
	for <linux-pm@vger.kernel.org>; Fri, 21 Feb 2025 23:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740180727; cv=none; b=iSLvVJj4PgVsns3t0VAnMACA9zKds+/TTtd0hLnmK8orSH1/+axO8drC9BmNwIDk8n8aDuh6Xa8uueVLKaCTa4ls8nSUQlCU818HuXm8veSyOzhy7q22m58/Ibs2XESeHPSFeLQElpgR3tmGd/HCPyNbsZKhnOMpVbKaDPRTG6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740180727; c=relaxed/simple;
	bh=1P0022Uib6N7KsqjyjxXZFnDcKjlPnpt8V66JSYrJVc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=no+NE8SaOsL8lxPXvQERxcjTbxg3hC5P45VDxFdezyqVrIRSBvG6AWoXLnSV9Aj9fMLv5fKDRIKNnJFdv+o6sAg3mjhfeywTtBEHvFCvCqU6kfdqsrG5jG8JuAsWfM/wvivcwq9XXNpDFxCqnkcWxfPz8jT8Hiu4JOwuQGb1/qk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=LA3GGhoR; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-aaec61d0f65so522659266b.1
        for <linux-pm@vger.kernel.org>; Fri, 21 Feb 2025 15:32:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1740180724; x=1740785524; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GiGCeg3ug6tpTo5Sf+ahfEJjPIEucvUSopnPD8u/sh8=;
        b=LA3GGhoRjA0m0oX8cLlDgegRcLsdc+0jf+Uero7Na8hGdr0A3mFBPvEvWBVSuHvAaf
         fK9+BZjA5XaAGKx3J/B39ZdDePin6UjEDwWTBpxLcWUu/IZ2EdQ04zCCuLkFpVYkPC9C
         QX7PQd1F8JRyBX9d7+DH4iJaG2DGxAFrGg6/U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740180724; x=1740785524;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GiGCeg3ug6tpTo5Sf+ahfEJjPIEucvUSopnPD8u/sh8=;
        b=DLHSsn6qQjmuJcxQ7UZ99LYa/Ak6Lkl7sDi3YwqA+u7yaz3HIr1CI5S85NFpsJwse7
         jNvyYP7dBQPHUTOFMPMNLCOWhMNF2Nw6b+mUsKNHM2DJXKIIqmvt94GGESZV/QShoIIo
         suMjDIZ9FaCHDaicjV7vMzT9P6k+6N7r7YpGT5ZpipiZZTe++pv2mIhtnanTkvENyM4u
         r9ez/l4Nkp09K7PSfglt6gcNWp9FBSyzjl4QL73BSTyk3zLo2YZlYARaZ693aGwf2H8M
         3gmV0tdEv3NfAeKHbG/KPrDVoSD4x7GI+Lrs7iJ75DJMDD5zW6NOcX0BEaw+KCTdtKLJ
         ov8A==
X-Forwarded-Encrypted: i=1; AJvYcCW5/OQy3F0vNct6BXfYjQ/GUPreJ228/s/3X7A9QnwzmEA1SdVs9u+so8PU2RcOBu+mOEnPiuh5hw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzocuM8oAXQ5BSrsCmEbvXZVqeL2gUxkOGEF8hYwNXILgtJUwrK
	IQ2UL5QVyZDXmbpbOwAfkAjJ0MdKt6vkXzDvv46pvkrLT8yHU+tOJfWY9fyjSk20IuYRbbdg71o
	m/h0z
X-Gm-Gg: ASbGnctBlGNphh4sPjEb5iTzIq9SZwQ9ivhpc0IZMUXy9WON4Tmy2hFbuLwBNU4JzxZ
	jYtHU3/8c5A7nn/ofi4vFWp2tLQFLQDEYHOqEvfSFA1SvOP5WqOVOhqGysYbWAucjG+hRIup0AC
	6l9FXXDVfBXZf0Fu27Sb/42PdsEOKkPWdveLefGOQvwxssDM90960Ig+Eme1npBxyKGJ3j/8l+S
	gKdgURQw2mlHPnxmotV9Me6blQGgGv1xsHsZRU2keXbznM0kl5mOIpLjB0a4vW2eWLS3ssp9rbc
	ddIVSF7HWSziunToC/durZpeF+K/wfwpa11Ap2ddLq/bX+pcshU37Tq+35PWpA==
X-Google-Smtp-Source: AGHT+IFq2tNpQK0+b4UYsmd7Nv9U/dB4hIlopFfB7u3ynjaLXcF6IpSDwKim3KGO7U6SWxMPsykMBw==
X-Received: by 2002:a17:907:7806:b0:abb:b209:aba6 with SMTP id a640c23a62f3a-abc099c6fcbmr508044366b.3.1740180723930;
        Fri, 21 Feb 2025 15:32:03 -0800 (PST)
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com. [209.85.128.48])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abbe0d39f9csm543848266b.69.2025.02.21.15.32.03
        for <linux-pm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Feb 2025 15:32:03 -0800 (PST)
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-43995b907cfso16688745e9.3
        for <linux-pm@vger.kernel.org>; Fri, 21 Feb 2025 15:32:03 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXN6dv3Qkgkxk2VYVZYBFyZSc58nzWWgwM2/UJxCLInY0v2Rjcmhh1aPccrREuIp9EK6QKOkb2Jwg==@vger.kernel.org
X-Received: by 2002:a05:600c:4f91:b0:439:955d:c4e2 with SMTP id
 5b1f17b1804b1-439ae1f15b6mr40645305e9.13.1740180723180; Fri, 21 Feb 2025
 15:32:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250219-fix-power-allocator-weight-v1-1-79b1a99e94eb@chromium.org>
 <CAJZ5v0h8MyqEgC8Hf1_s4=kCj2W3Y0TWdVnbhwAiVLqED7WPow@mail.gmail.com> <32fe0e71-e8d9-4404-8b48-a8b8e9ec71e7@arm.com>
In-Reply-To: <32fe0e71-e8d9-4404-8b48-a8b8e9ec71e7@arm.com>
From: Yu-Che Cheng <giver@chromium.org>
Date: Sat, 22 Feb 2025 07:31:27 +0800
X-Gmail-Original-Message-ID: <CAKchOA3u9a2UK-xGONcEBbzrGMCGFVFDnNXuLHG+umDT2JA5gA@mail.gmail.com>
X-Gm-Features: AWEUYZlT7fvH-JMdmx4NAh1H-2g0fyV5eADSnCK8gOOETth1WegVG1e_pyJ_b4g
Message-ID: <CAKchOA3u9a2UK-xGONcEBbzrGMCGFVFDnNXuLHG+umDT2JA5gA@mail.gmail.com>
Subject: Re: [PATCH] thermal: gov_power_allocator: Update total_weight on bind
 and cdev updates
To: Lukasz Luba <lukasz.luba@arm.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Yu-Che Cheng <giver@chromium.org>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, 
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Chen-Yu Tsai <wenst@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> This is basically fine, but I would add a new function, say
> power_allocator_update_weight(), for updating the weight.
>
> >         case THERMAL_INSTANCE_WEIGHT_CHANGED:
>
> And I'd call it from here and from power_allocator_bind() below.
>
> >                 params->total_weight =3D 0;
> >                 list_for_each_entry(instance, &td->thermal_instances, t=
rip_node)
> > @@ -731,6 +730,8 @@ static int power_allocator_bind(struct thermal_zone=
_device *tz)
> >
> >         tz->governor_data =3D params;
> >
> > +       power_allocator_update_tz(tz, THERMAL_INSTANCE_WEIGHT_CHANGED);
>
> Because this is kind of confusing (although it will work AFAICS).

Thanks for the suggestion. Will apply in v2.

On Fri, Feb 21, 2025 at 6:43=E2=80=AFPM Lukasz Luba <lukasz.luba@arm.com> w=
rote:
>
>
>
> On 2/20/25 19:40, Rafael J. Wysocki wrote:
> > On Wed, Feb 19, 2025 at 8:07=E2=80=AFAM Yu-Che Cheng <giver@chromium.or=
g> wrote:
> >>
> >> params->total_weight is not initialized during bind and not updated wh=
en
> >> the bound cdev changes. The cooling device weight will not be used due
> >> to the uninitialized total_weight, until we trigger an update via sysf=
s.
> >>
> >> The bound cdev update will be triggered during thermal zone registrati=
on,
> >> where each cooling device will be bound to the thermal zone one by one=
.
> >>
> >> The power_allocator_bind can be called without additional cdev update
> >> when manually changing the policy of a thermal zone via sysfs.
>
> Thanks Yu-Che for catching this.
>
> >>
> >> Update total_weight when bind and cdev updates to ensure total_weight =
is
> >> correct.
> >>
> >> Fixes: a3cd6db4cc2e ("thermal: gov_power_allocator: Support new update=
 callback of weights")
> >> Signed-off-by: Yu-Che Cheng <giver@chromium.org>
> >> ---
> >>   drivers/thermal/gov_power_allocator.c | 9 +++++----
> >>   1 file changed, 5 insertions(+), 4 deletions(-)
> >>
> >> diff --git a/drivers/thermal/gov_power_allocator.c b/drivers/thermal/g=
ov_power_allocator.c
> >> index 3b644de3292e..600cb0e367c3 100644
> >> --- a/drivers/thermal/gov_power_allocator.c
> >> +++ b/drivers/thermal/gov_power_allocator.c
> >> @@ -656,11 +656,10 @@ static void power_allocator_update_tz(struct the=
rmal_zone_device *tz,
> >>                          if (power_actor_is_valid(instance))
> >>                                  num_actors++;
> >>
> >> -               if (num_actors =3D=3D params->num_actors)
> >> -                       return;
> >> +               if (num_actors !=3D params->num_actors)
> >> +                       allocate_actors_buffer(params, num_actors);
> >>
> >> -               allocate_actors_buffer(params, num_actors);
> >> -               break;
> >> +               fallthrough;
> >
> > This is basically fine, but I would add a new function, say
> > power_allocator_update_weight(), for updating the weight.
> >
> >>          case THERMAL_INSTANCE_WEIGHT_CHANGED:
> >
> > And I'd call it from here and from power_allocator_bind() below.
> >
> >>                  params->total_weight =3D 0;
> >>                  list_for_each_entry(instance, &td->thermal_instances,=
 trip_node)
> >> @@ -731,6 +730,8 @@ static int power_allocator_bind(struct thermal_zon=
e_device *tz)
> >>
> >>          tz->governor_data =3D params;
> >>
> >> +       power_allocator_update_tz(tz, THERMAL_INSTANCE_WEIGHT_CHANGED)=
;
> >
> > Because this is kind of confusing (although it will work AFAICS).
> >
>
> Thanks Rafael, I agree with suggestions. It would look cleaner.

