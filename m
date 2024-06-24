Return-Path: <linux-pm+bounces-9914-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64D6991569A
	for <lists+linux-pm@lfdr.de>; Mon, 24 Jun 2024 20:44:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 89E891C224B5
	for <lists+linux-pm@lfdr.de>; Mon, 24 Jun 2024 18:44:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D81B81A00FA;
	Mon, 24 Jun 2024 18:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FP87Ue1g"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1D6919EEDC;
	Mon, 24 Jun 2024 18:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719254639; cv=none; b=mpBC5emXFuY1gYeRHBEINJWXZuJ1sXyv1AIwuVUzXLgThPhiZK9EEk8dzW7l+rZCJ4topvC5E/QUkw+FVGhRGM0gHDuzPz83sWbfZozQHsp5U3A/EdSNvaqDbDFNUnsxvRA6hplYcw4BA0+gFpivQJkUeXbnRc2tbVxiLKeROVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719254639; c=relaxed/simple;
	bh=y09e6y3PeUQTPhabq8qHYrMiOnKZ9HBKHtMmPq9jIFI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fThiI7W7KPvib8Yz/k81dEjpLjYa7V3ao6pbrXcLIOT76zdAiI3Hk8p2xj91XdDAiQUDVr/AonOObrRKO60/Ub/EQYfP7uWhBx/wN7AnDAL22CxJlIP9ZmMrY5F1KwT6qn6XeoOpGpGIYRjbii0UMZX0+8y6HsI2ZBIuHeWDMls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FP87Ue1g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81D6BC32789;
	Mon, 24 Jun 2024 18:43:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719254639;
	bh=y09e6y3PeUQTPhabq8qHYrMiOnKZ9HBKHtMmPq9jIFI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=FP87Ue1g18Vqn8BDTPayHDVW/bKrfs54ZpNc/1IdN6pHQMD1Kmd5jMs6yqkayRtsE
	 oslOGn83lqLU40CTB/7bi7+Yhjs7FOSS5GnCtJMSlZZAEt6RvgrPqc0A6twzo9bUz/
	 b3jgkGdf7j7FpXD9E/mQVNCHt+8m1xSiH3/nADHKgMFa0NRjRnvDrqBCXE1P5ypo56
	 GSrhTo+B9e3XGaktMmpFk21vVFRa5q2g6ICL4xLQEsFTefUC4jyAapCPr25uYvkca8
	 c7wUKvnO6Gt8gMeI+25lMDhxmG04lu1qbMaqZaHByBzL0wkj2uiDhgcd4i+1YjtrSB
	 TZtlYyK7AhCGQ==
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-25ce35c52e7so414154fac.2;
        Mon, 24 Jun 2024 11:43:59 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUzsWOhlW61fVeEJ5c8Gt/eRJmEM8/4yW6OpWUZcNMhStmjCuHC3xJ5NVbQ0jAFGsOI1O9eR0JK6hjzbB2CeGcJW8DnwvDEdJjxaopw
X-Gm-Message-State: AOJu0YxsJ8ygXQEaYMnT8YRMwaMrhcngpEEN6zsiqZJFkDOISYtwlVM7
	rK15q4qNkZ5X1MAblRrF+N4sCfRBstEzUZsCocRJbX2Kz5evroJJU0aVrQEqQFtqKu2ZKlZMOIN
	P15Pahvd+5PsXlAYMQIx1jLGoX3o=
X-Google-Smtp-Source: AGHT+IGTXjnfYP8viplDaPFq7kk2cs7jdpgsKnxMHLUQJseBZC6rbfldcwceT98hEEwqh9gl2GiZAfqQcpHTyfNr5hY=
X-Received: by 2002:a4a:d24a:0:b0:5bb:815d:e2ab with SMTP id
 006d021491bc7-5c1e5ef0b32mr6931402eaf.1.1719254638638; Mon, 24 Jun 2024
 11:43:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <12464461.O9o76ZdvQC@rjwysocki.net>
In-Reply-To: <12464461.O9o76ZdvQC@rjwysocki.net>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 24 Jun 2024 20:43:43 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hYw1xj7a4eGvm=m6xbP9ptSWLEPN7Da4-bxZ3-00GP4A@mail.gmail.com>
Message-ID: <CAJZ5v0hYw1xj7a4eGvm=m6xbP9ptSWLEPN7Da4-bxZ3-00GP4A@mail.gmail.com>
Subject: Re: [PATCH v1] thermal: gov_step_wise: Go straight to instance->lower
 when mitigation is over
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>, Lukasz Luba <lukasz.luba@arm.com>, 
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Zhang Rui <rui.zhang@intel.com>, 
	Jens Glathe <jens.glathe@oldschoolsolutions.biz>, Steev Klimaszewski <steev@kali.org>, 
	Johan Hovold <johan+linaro@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 22, 2024 at 2:28=E2=80=AFPM Rafael J. Wysocki <rjw@rjwysocki.ne=
t> wrote:
>
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> Commit b6846826982b ("thermal: gov_step_wise: Restore passive polling
> management") attempted to fix a Step-Wise thermal governor issue
> introduced by commit 042a3d80f118 ("thermal: core: Move passive polling
> management to the core"), which caused the governor to leave cooling
> devices in high states, by partially revering that commit.
>
> However, this turns out to be insufficient on some systems due to
> interactions between the governor code restored by commit b6846826982b
> and the passive polling management in the thermal core.
>
> For this reason, revert commit b6846826982b and make the governor set
> the target cooling device state to the "lower" one as soon as the zone
> temperature falls below the threshold of the trip point corresponding
> to the given thermal instance, which means that thermal mitigation is
> not necessary any more.
>
> Before this change the "lower" cooling device state would be reached in
> steps through the passive polling mechanism which was questionable for
> three reasons: (1) cooling device were kept in high states when that was
> not necessary (and it could adversely impact performance), (2) it only
> worked for thermal zones with nonzero passive_delay_jiffies value, and
> (3) passive polling belongs to the core and should not be hijacked by
> governors for their internal purposes.
>
> Fixes: b6846826982b ("thermal: gov_step_wise: Restore passive polling man=
agement")
> Closes: https://lore.kernel.org/linux-pm/6759ce9f-281d-4fcd-bb4c-b784a1cc=
5f6e@oldschoolsolutions.biz
> Reported-by: Jens Glathe <jens.glathe@oldschoolsolutions.biz>
> Tested-by: Jens Glathe <jens.glathe@oldschoolsolutions.biz>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  drivers/thermal/gov_step_wise.c |   23 +++++------------------
>  1 file changed, 5 insertions(+), 18 deletions(-)
>
> Index: linux-pm/drivers/thermal/gov_step_wise.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-pm.orig/drivers/thermal/gov_step_wise.c
> +++ linux-pm/drivers/thermal/gov_step_wise.c
> @@ -55,7 +55,11 @@ static unsigned long get_target_state(st
>                 if (cur_state <=3D instance->lower)
>                         return THERMAL_NO_TARGET;
>
> -               return clamp(cur_state - 1, instance->lower, instance->up=
per);
> +               /*
> +                * If 'throttle' is false, no mitigation is necessary, so
> +                * request the lower state for this instance.
> +                */
> +               return instance->lower;
>         }
>
>         return instance->target;
> @@ -93,23 +97,6 @@ static void thermal_zone_trip_update(str
>                 if (instance->initialized && old_target =3D=3D instance->=
target)
>                         continue;
>
> -               if (trip->type =3D=3D THERMAL_TRIP_PASSIVE) {
> -                       /*
> -                        * If the target state for this thermal instance
> -                        * changes from THERMAL_NO_TARGET to something el=
se,
> -                        * ensure that the zone temperature will be updat=
ed
> -                        * (assuming enabled passive cooling) until it be=
comes
> -                        * THERMAL_NO_TARGET again, or the cooling device=
 may
> -                        * not be reset to its initial state.
> -                        */
> -                       if (old_target =3D=3D THERMAL_NO_TARGET &&
> -                           instance->target !=3D THERMAL_NO_TARGET)
> -                               tz->passive++;
> -                       else if (old_target !=3D THERMAL_NO_TARGET &&
> -                                instance->target =3D=3D THERMAL_NO_TARGE=
T)
> -                               tz->passive--;
> -               }
> -
>                 instance->initialized =3D true;
>
>                 mutex_lock(&instance->cdev->lock);
>

If there is no feedback, I'm going to assume that this is fine with everybo=
dy.

Thanks!

