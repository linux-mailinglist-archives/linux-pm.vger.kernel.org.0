Return-Path: <linux-pm+bounces-21583-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39C1CA2D5C8
	for <lists+linux-pm@lfdr.de>; Sat,  8 Feb 2025 12:25:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C0CBB7A4A1F
	for <lists+linux-pm@lfdr.de>; Sat,  8 Feb 2025 11:24:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A01CC2451DC;
	Sat,  8 Feb 2025 11:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qDq71QIB"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78DEF1B3929;
	Sat,  8 Feb 2025 11:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739013898; cv=none; b=SC/QHARKlxqmw6usMrEQpgiI/0gw3ASGQn7F8+4W1dtldiWF1W1lQb1MMKLTpG3Ffx6gaTOaUL/Bg5+q8fV3bUP0jGrmcN0BNEQLiuOuF6Y3CIqRgNxC6YhI3TM6tuxsiGUH1qj5b6riTOYcDMkOJATcLB/evMf/RMAO0fyFEJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739013898; c=relaxed/simple;
	bh=v0kY2q5RP2GhNxjivPWegKlE87r10bfakOnRz0kN0k8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G8+YBUCoGLk8xfLvQHfd5fY1Q1Tghyk+Z3UcU8VrSAEOiS0DD797oOmAXEeicbrnuV80yw13Vtp/98NunetmfrgVLuINSSAO0tfVNGghmuC8YtoKGXHIZzgtV0CRpjvNJUE1kLTkV8uv+K4XX7HNFpSBJA2tr8OV6hhWNPjsgDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qDq71QIB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8D2CC4CED6;
	Sat,  8 Feb 2025 11:24:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739013897;
	bh=v0kY2q5RP2GhNxjivPWegKlE87r10bfakOnRz0kN0k8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=qDq71QIB9p5nG6bJipYxnoLHZGDJSFhFhyWjQXe+dGoo5hB85aQvZzlPtWG/lggI9
	 Ig2YduyYbxFcLbd4TJDU2wRVO792mw2sFE+XLgKXuf6XzMg6f+OnxDH0Ez5sC+aDIB
	 pB+iD7xBiFfyusFKsvF9qqqqhYFcBnC8kukedvPd4N+sAibiT7b64TnJUwczW22Tyl
	 ail48RAJ41N2Sx4fQT9dPc6jRk76zhrMIX8xMLsFYRejmeNjoQ0DzHNaUDEwEoGNc0
	 Q9gZFp4z0fgusja7krrBHb8lP/HdVQo21T93NcJGxJJ4a5AgPISIWbMQdz+cZdnTKA
	 nRTaYsNocszbQ==
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-5f2e31139d9so1503796eaf.0;
        Sat, 08 Feb 2025 03:24:57 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUwwYBCyHN/OxyPUU4rBl5ws/w+t8cTyGjaA2oOqcTXgSH+UMgGfmRbdFKYUYoNlj6rgG+Daz0o2bO5b9Q=@vger.kernel.org, AJvYcCVZ5SpoiWHonY1WgnLXWYUc0uZjfiykCmn41hbce8d57GWyBUqmjeot7FMdRwMayysXBnQr5kEiO+k=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHaT3of5POfNPM2Oy6fkN25Kb8OUa0QxAbCi5FRBMAgFs2F3Bs
	vnay31P2biA45ZNmbVjEo+01MSxi0RLtxGDYwXGZ//LUfMV1ziwiQ65VVDLXBNifwXL030XGJDP
	OQCHMS7ALjp0wtAKde+QPPe+hpKQ=
X-Google-Smtp-Source: AGHT+IGUtyAYBfOlhtXoZxL94yJwaOt4l//XmIev+fbw3I9vvksmNXaU42SX8RaOvXevlk06GW7ZOujF+PpnWBqCdQI=
X-Received: by 2002:a05:6820:827:b0:5fa:73ed:de8 with SMTP id
 006d021491bc7-5fc5e71b079mr4214415eaf.6.1739013897093; Sat, 08 Feb 2025
 03:24:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <12630185.O9o76ZdvQC@rjwysocki.net> <009d01db79b9$aecd1c70$0c675550$@telus.net>
In-Reply-To: <009d01db79b9$aecd1c70$0c675550$@telus.net>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Sat, 8 Feb 2025 12:24:45 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0jELEw3yAoRFLPgEcfBRoUyd6tKSNHO2Q1O6_CoeR1Bng@mail.gmail.com>
X-Gm-Features: AWEUYZm-gRCi0A1sn3TIJUROeDBBRYieqfiS8FTKYRJKUHGfsYCZFVE-q2W_HYs
Message-ID: <CAJZ5v0jELEw3yAoRFLPgEcfBRoUyd6tKSNHO2Q1O6_CoeR1Bng@mail.gmail.com>
Subject: Re: [RFT][PATCH v1] cpuidle: teo: Avoid selecting deepest idle state over-eagerly
To: Doug Smythies <dsmythies@telus.net>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, LKML <linux-kernel@vger.kernel.org>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>, Christian Loehle <christian.loehle@arm.com>, 
	Artem Bityutskiy <artem.bityutskiy@linux.intel.com>, 
	Aboorva Devarajan <aboorvad@linux.ibm.com>, Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Doug,

On Sat, Feb 8, 2025 at 12:40=E2=80=AFAM Doug Smythies <dsmythies@telus.net>=
 wrote:
>
> Hi Rafael,
>
> On 2025.02.04 12:58 Rafael J. Wysocki wrote:
> >
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > It has been observed that the recent teo governor update which conclude=
d
> > with commit 16c8d7586c19 ("cpuidle: teo: Skip sleep length computation
> > for low latency constraints") caused the max-jOPS score of the SPECjbb
> > 2015 benchmark [1] on Intel Granite Rapids to decrease by around 1.4%.
> > While it may be argued that this is not a significant increase, the
> > previous score can be restored by tweaking the inequality used by teo
> > to decide whether or not to preselect the deepest enabled idle state.
> > That change also causes the critical-jOPS score of SPECjbb to increase
> > by around 2%.
> >
> > Namely, the likelihood of selecting the deepest enabled idle state in
> > teo on the platform in question has increased after commit 13ed5c4a6d9c
> > ("cpuidle: teo: Skip getting the sleep length if wakeups are very
> > frequent") because some timer wakeups were previously counted as non-
> > timer ones and they were effectively added to the left-hand side of the
> > inequality deciding whether or not to preselect the deepest idle state.
> >
> > Many of them are now (accurately) counted as timer wakeups, so the left=
-
> > hand side of that inequality is now effectively smaller in some cases,
> > especially when timer wakeups often occur in the range below the target
> > residency of the deepest enabled idle state and idle states with target
> > residencies below CPUIDLE_FLAG_POLLING are often selected, but the
> > majority of recent idle intervals are still above that value most of
> > the time.  As a result, the deepest enabled idle state may be selected
> > more often than it used to be selected in some cases.
> >
> > To counter that effect, add the sum of the hits metric for all of the
> > idle states below the candidate one (which is the deepest enabled idle
> > state at that point) to the left-hand side of the inequality mentioned
> > above.  This will cause it to be more balanced because, in principle,
> > putting both timer and non-timer wakeups on both sides of it is more
> > consistent than only taking into account the timer wakeups in the range
> > above the target residency of the deepest enabled idle state.
> >
> > Link: https://www.spec.org/jbb2015/
> > Tested-by: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > ---
> >  drivers/cpuidle/governors/teo.c |    6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> >
> > --- a/drivers/cpuidle/governors/teo.c
> > +++ b/drivers/cpuidle/governors/teo.c
> > @@ -349,13 +349,13 @@
> >         }
> >
> >         /*
> > -        * If the sum of the intercepts metric for all of the idle stat=
es
> > -        * shallower than the current candidate one (idx) is greater th=
an the
> > +        * If the sum of the intercepts and hits metric for all of the =
idle
> > +        * states below the current candidate one (idx) is greater than=
 the
> >          * sum of the intercepts and hits metrics for the candidate sta=
te and
> >          * all of the deeper states, a shallower idle state is likely t=
o be a
> >          * better choice.
> >          */
> > -       if (2 * idx_intercept_sum > cpu_data->total - idx_hit_sum) {
> > +       if (2 * (idx_intercept_sum + idx_hit_sum) > cpu_data->total) {
> >                 int first_suitable_idx =3D idx;
> >
> >                 /*
>
> I have only just started testing the recent idle governor changes,
> and have not gotten very far yet.
>
> There is a significant increase in processor package power during idle
> with this patch, about 5 times increase (400%).

Thanks for this data point!

The restoration of the 1.4% benchmark score is not worth this cost IMV.

> My processor: Intel(R) Core(TM) i5-10600K CPU @ 4.10GHz
> Distro: Ubuntu 24.04.1, server, no desktop GUI.
> CPU frequency scaling driver: intel_pstate
> HWP: disabled.
> CPU frequency scaling governor: performance
>
> Idle states:
> $ grep . /sys/devices/system/cpu/cpu0/cpuidle/state*/name
> /sys/devices/system/cpu/cpu0/cpuidle/state0/name:POLL
> /sys/devices/system/cpu/cpu0/cpuidle/state1/name:C1_ACPI
> /sys/devices/system/cpu/cpu0/cpuidle/state2/name:C2_ACPI
> /sys/devices/system/cpu/cpu0/cpuidle/state3/name:C3_ACPI
>
> Test durations were >=3D 45 minutes each.
>
> Kernel 6.14-rc1: Includes cpuidle: teo: Cleanups and very frequent wakeup=
s handling update
> Average Idle Power: teo governor: 2.199 watts (+25.51%)
> Average Idle power: menu governor: 1.873 watts (+6.91%)

menu hasn't changed in 6.14-rc1, so this would be variation between
runs I suppose.

> Kernel 6.14-rc1-p: Added this patch for teo and "cpuidle: menu: Avoid dis=
carding useful information when processing recent idle intervals" for menu
> Average Idle Power: teo governor: 9.401 watts (+436.6%)
> Only 69.61% idle is in the deepest idle state. More typically it would be=
 98% to 99%.

Ah, not good.

OK, this clearly doesn't go in the right direction.

> 28.6531% idle time is in state 1. More typically it would be 0.03%
> Average Idle Power: menu governor: 1.820 watts (+3.9%)
>
> Kernel 6.13: before "cpuidle: teo: Cleanups and very frequent wakeups han=
dling update"
> Average Idle Power: teo governor: 1.752 watts (reference: 0.0%)
> Average Idle power: menu governor: 1.909 watts (+9.0%)

Thanks, I'm just going to drop this patch then.

If you don't mind, I'll have a couple more teo updates for testing.

