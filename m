Return-Path: <linux-pm+bounces-33432-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 66DFCB3C336
	for <lists+linux-pm@lfdr.de>; Fri, 29 Aug 2025 21:40:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BDAFA5A1E6B
	for <lists+linux-pm@lfdr.de>; Fri, 29 Aug 2025 19:40:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73E6424A066;
	Fri, 29 Aug 2025 19:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lzRu9aCt"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BA852417F2;
	Fri, 29 Aug 2025 19:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756496270; cv=none; b=aH3eSWJk/20yfhxlkQHVqtEkxtndNivf5xeuqeCHvdl/aEJFNkbCY7kH8pH14CspTvcw2CkzlUiWmVZ+90nchbN2JEXthL0ma5+9dEYT+LspTdERqOPmdyFvkF3hiTLC0VB3KCCCny4z0/0BCHzzYrpLYhoJ2z98Y13AC/D3q/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756496270; c=relaxed/simple;
	bh=i20Sz1T7m8zUz/Av2KIJ4kNJkooG1BmO238nmGbVDV0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hJUxepkG+EpNa305r8T1Jr3p+hi1fJx7T+uL081IZ77GvBARylAIOCvkcSQLPRkSNU5NMzcR3HVlH3qJFbSLFPhAdq3PMkeIlPOPnU+UqelgTYtgEQZqIrjcwNh8iFuV9ULqSdQg6iua98p0TcE+vy584TTczvTDsSMXbHIFdKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lzRu9aCt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C77D9C4CEF1;
	Fri, 29 Aug 2025 19:37:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756496269;
	bh=i20Sz1T7m8zUz/Av2KIJ4kNJkooG1BmO238nmGbVDV0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=lzRu9aCt11e1mGeUItKjCu4jPlv5ycErl5Yxlo11Zlu7UnVdpv0G+BILkjSpfYasg
	 M2DnvZF4EYUwuXMtWEVbJIQcQolkRubCAhhx346tLs1zLEcfuCgZP2sxgulhPhPviO
	 LMBZHZmXyNs0rDPGOMnQkd7CLHlnhzc0KIKeEQz5l1z1cYYADQmqb8vx+IBzNOAKr1
	 Un5LWGxEnrEsbaPQjVARSnMH1uZcF0/FTiDIak/bP+wuaNkc4MTKp1GffhZFMEGfzl
	 Oww4a3LP05vaexJPumHNexiGnqY2DCF4Bx+RUBzuIW9xMmx8FnovR1HwzqsE9lcqjF
	 YI9d12v9kPPTQ==
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-7454a992f7dso1581013a34.3;
        Fri, 29 Aug 2025 12:37:49 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUJqVY3VsHa/hZs/1DrotGb3RM9NDZqpQlYo9Sd7vok2wGfD2RlvpGnoaztiXheHiHzhCzgYcP5AYBlFeU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxI0sI6TR9VGyQvgwzKXa+LHRM7UJaoM+yT+nAefiAsHPjrgzl
	IIZOysq3KzpicGsuwJEgboPGc9PgH7ERyqgr1RCpfJiW9XWl0XNknwSDw8LwpmcAa7jt3pwiRpB
	269nkwfzNCkkL2RuQ6fFjcDkXfhfE+/w=
X-Google-Smtp-Source: AGHT+IFm6Mu2WJ3hz5epv6PCQ9V0hqYFrlCod+fDORZtkCza47try1kmAdneoMpzt4KEtCqbIGwgZxOKfnWY6jc4ys8=
X-Received: by 2002:a05:6830:6994:b0:744:f113:fef8 with SMTP id
 46e09a7af769-74500b95c22mr14413217a34.35.1756496269112; Fri, 29 Aug 2025
 12:37:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2804546.mvXUDI8C0e@rafael.j.wysocki> <5939372.DvuYhMxLoT@rafael.j.wysocki>
In-Reply-To: <5939372.DvuYhMxLoT@rafael.j.wysocki>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 29 Aug 2025 21:37:37 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0gniATfcckSwfJBmLf9O345Ersw-TUMVFWTSWxTN5K+0A@mail.gmail.com>
X-Gm-Features: Ac12FXykCuo6Gn7nzj5lYOQKbp9wSTKor5RmWoXoEPf2lGx_F_QbcDlanOhf7vw
Message-ID: <CAJZ5v0gniATfcckSwfJBmLf9O345Ersw-TUMVFWTSWxTN5K+0A@mail.gmail.com>
Subject: Re: [PATCH v1] cpuidle: governors: teo: Special-case nohz_full CPUs
To: Linux PM <linux-pm@vger.kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Christian Loehle <christian.loehle@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 28, 2025 at 10:16=E2=80=AFPM Rafael J. Wysocki <rafael@kernel.o=
rg> wrote:
>
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> This change follows an analogous modification of the menu governor [1].
>
> Namely, when the governor runs on a nohz_full CPU and there are no user
> space timers in the workload on that CPU, it ends up selecting idle
> states with target residency values above TICK_NSEC, or the deepest
> enabled idle state in the absence of any of those, all the time due to
> a tick_nohz_tick_stopped() check designed for running on CPUs where the
> tick is not permanently disabled.  In that case, the fact that the tick
> has been stopped means that the CPU was expected to be idle sufficiently
> long previously, so it is not unreasonable to expect it to be idle
> sufficiently long again, but this inference does not apply to nohz_full
> CPUs.
>
> In some cases, latency in the workload grows undesirably as a result of
> selecting overly deep idle states, and the workload may also consume
> more energy than necessary if the CPU does not spend enough time in the
> selected deep idle state.
>
> Address this by amending the tick_nohz_tick_stopped() check in question
> with a tick_nohz_full_cpu() one to avoid effectively ignoring all
> shallow idle states on nohz_full CPUs.  While doing so introduces a risk
> of getting stuck in a shallow idle state for a long time, that only
> affects energy efficiently, but the current behavior potentially hurts
> both energy efficiency and performance that is arguably the priority for
> nohz_full CPUs.

This change is likely to break the use case in which CPU isolation is
used for power management reasons, to prevent CPUs from running any
code and so to save energy.

In that case, going into the deepest state every time on nohz_full
CPUs is a feature, so it can't be changed unconditionally.

For this reason, I'm not going to apply this patch and I'm going to
drop the menu governor one below.

The only way to allow everyone to do what they want/need I can see
would be to add a control knob for adjusting the behavior of cpuidle
governors regarding the handling of nohz_full CPUs.

> While at it, add a comment explaining the logic in teo_state_ok().
>
> Link: https://lore.kernel.org/linux-pm/2244365.irdbgypaU6@rafael.j.wysock=
i/ [1]
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  drivers/cpuidle/governors/teo.c |   18 +++++++++++++-----
>  1 file changed, 13 insertions(+), 5 deletions(-)
>
> --- a/drivers/cpuidle/governors/teo.c
> +++ b/drivers/cpuidle/governors/teo.c
> @@ -227,9 +227,17 @@
>         cpu_data->total +=3D PULSE;
>  }
>
> -static bool teo_state_ok(int i, struct cpuidle_driver *drv)
> +static bool teo_state_ok(int i, struct cpuidle_driver *drv, struct cpuid=
le_device *dev)
>  {
> -       return !tick_nohz_tick_stopped() ||
> +       /*
> +        * If the scheduler tick has been stopped already, avoid selectin=
g idle
> +        * states with target residency below the tick period length unde=
r the
> +        * assumption that the CPU is likely to be idle sufficiently long=
 for
> +        * the tick to be stopped again (or the tick would not have been
> +        * stopped previously in the first place).  However, do not do th=
at on
> +        * nohz_full CPUs where the above assumption does not hold.
> +        */
> +       return !tick_nohz_tick_stopped() || tick_nohz_full_cpu(dev->cpu) =
||
>                 drv->states[i].target_residency_ns >=3D TICK_NSEC;
>  }
>
> @@ -379,7 +387,7 @@
>                                  * shallow or disabled, in which case tak=
e the
>                                  * first enabled state that is deep enoug=
h.
>                                  */
> -                               if (teo_state_ok(i, drv) &&
> +                               if (teo_state_ok(i, drv, dev) &&
>                                     !dev->states_usage[i].disable) {
>                                         idx =3D i;
>                                         break;
> @@ -391,7 +399,7 @@
>                         if (dev->states_usage[i].disable)
>                                 continue;
>
> -                       if (teo_state_ok(i, drv)) {
> +                       if (teo_state_ok(i, drv, dev)) {
>                                 /*
>                                  * The current state is deep enough, but =
still
>                                  * there may be a better one.
> @@ -460,7 +468,7 @@
>          */
>         if (drv->states[idx].target_residency_ns > duration_ns) {
>                 i =3D teo_find_shallower_state(drv, dev, idx, duration_ns=
, false);
> -               if (teo_state_ok(i, drv))
> +               if (teo_state_ok(i, drv, dev))
>                         idx =3D i;
>         }
>
>
>
>
>

