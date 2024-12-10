Return-Path: <linux-pm+bounces-18947-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FD209EBACE
	for <lists+linux-pm@lfdr.de>; Tue, 10 Dec 2024 21:26:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9538A282CCF
	for <lists+linux-pm@lfdr.de>; Tue, 10 Dec 2024 20:26:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 309C1226876;
	Tue, 10 Dec 2024 20:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E9cPzPfu"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0786C23ED44;
	Tue, 10 Dec 2024 20:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733862389; cv=none; b=GC0d/sr2SHP7aP8tanvs/RFcugOmeGK5T8TQLO+mkkHraSm5KgsGtyORkLTjilgxKrv+RNRCGVFIxaCYGDL7feKfL8BRa1XPXGVzlQi0tpAnvGTnS7YM+YK7g/FLup378pOA5UnrcQ/DWT6LJjtyOV+qbSOmo38sBGV7u8u+Oug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733862389; c=relaxed/simple;
	bh=Mr8Qa/vYrrZI/ef3Lx4QEUCO5zvzeKXwDX87KYC582A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F9fvs5/vxRDAsBhnFLZ0StJ5Xo0wsthjQv+JHhU3G6Y76XW7GpRLJgAYDQK+r6sInzeg6IAshOEtKuHUSBOAgsn7WYOuwGdJTVF8mMmG4p2fHl9rVQssNOdEvZ/aANFOHTi8dXoxkFWWJyDgXpURUv/mfxV45gLUhfJaS8Z/xqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E9cPzPfu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78C29C4CEE3;
	Tue, 10 Dec 2024 20:26:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733862388;
	bh=Mr8Qa/vYrrZI/ef3Lx4QEUCO5zvzeKXwDX87KYC582A=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=E9cPzPfuL7RlWcx0zJBUDFUu09gSQvZUzF5qETBJw9yn5Ml+lIdMbVZcBXaLcW4tN
	 4zkiuH/7U3TSZ+4FyXEyH4eyULAGIGobEw0PWSgkGV31vm5o0zJsmyOJFGa9PCGsmI
	 qMC1AUO7/9IYVLvHoN614iOm9KrWPOn/TJZpIVhdtsKyNo/rIkr+z3HYzvuSJimSdk
	 +Lf1DRR/YMag/sgXHWLBM4y2XUKRed9vt16Zfhr88aCGvlEr34FAdJh8TZQvZvdx7B
	 OjuipqDB3VSylCELYBYDPbXUhqLjzv4cwo+yOZuz4MX2IrNhk8Oq/LjEv0jn3YffhT
	 6BYGvtt5RcvxA==
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-5ee645cf763so2645057eaf.2;
        Tue, 10 Dec 2024 12:26:28 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCW8pm1grYE20aA/O1N/mzXIappu5TsG4vWUl0PmOrbbGDF4IBFBGnFn2GnyB/k/Tt3ziS0rJBQZPXQ=@vger.kernel.org, AJvYcCWqHia60c0wNUm8qG86Ad0RYEeDPgmCeG6FTJWtznG93bMhMXg8wp7NHxhXyL+O872f2Wd6M1eemZkgyQo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxM7akv8d64+lFvdHhngw5LX9Jkc3W0eszq6rf8IrXGWvd+73zf
	Oun9jMKsUw0O4gXjj8ByTdFRmY9Ta/sUZ89NxOO7WIxqUJl+jPA+OY6ZprDjYdsY3ym4Ze8hZN7
	tW8N5z9kTJ2VWbXx920VRdWg0BJI=
X-Google-Smtp-Source: AGHT+IGAyRNiwYKTrTG0yZbrE3WcttNIKtNYMbg2SWTIT69NpV3P18Z9BP+LFfelVuGw/M81CP1lh6zjOKjDWKu5KO0=
X-Received: by 2002:a4a:ee98:0:b0:5f1:e293:e102 with SMTP id
 006d021491bc7-5f2da12c63amr160202eaf.8.1733862387732; Tue, 10 Dec 2024
 12:26:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241204140828.11699-1-patryk.wlazlyn@linux.intel.com> <20241204140828.11699-4-patryk.wlazlyn@linux.intel.com>
In-Reply-To: <20241204140828.11699-4-patryk.wlazlyn@linux.intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 10 Dec 2024 21:26:16 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0hL0QOT17DnsUKONHVy1+Yy84soPWU74gHAxjsozerPgg@mail.gmail.com>
Message-ID: <CAJZ5v0hL0QOT17DnsUKONHVy1+Yy84soPWU74gHAxjsozerPgg@mail.gmail.com>
Subject: Re: [PATCH v8 3/4] intel_idle: Provide the default enter_dead() handler
To: Patryk Wlazlyn <patryk.wlazlyn@linux.intel.com>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
	rafael.j.wysocki@intel.com, peterz@infradead.org, dave.hansen@linux.intel.com, 
	gautham.shenoy@amd.com, tglx@linutronix.de, len.brown@intel.com, 
	artem.bityutskiy@linux.intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 4, 2024 at 3:08=E2=80=AFPM Patryk Wlazlyn
<patryk.wlazlyn@linux.intel.com> wrote:
>
> Recent Intel platforms require idle driver to provide information about
> the MWAIT hint used to enter the deepest idle state in the play_dead
> code.
>
> Provide the default enter_dead() handler for all of the platforms and
> allow overwriting with a custom handler for each platform if needed.

My changelog for this patch:

"A subsequent change is going to make native_play_dead() rely on the
idle driver to put CPUs going offline into appropriate idle states.

For this reason, provide the default :enter_dead() handler for all of
the idle states on all platforms supported by intel_idle with an
option to override it with a custom handler if needed."

> Signed-off-by: Patryk Wlazlyn <patryk.wlazlyn@linux.intel.com>
> ---
>  drivers/idle/intel_idle.c | 18 ++++++++++++++++--
>  1 file changed, 16 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/idle/intel_idle.c b/drivers/idle/intel_idle.c
> index ac4d8faa3886..c6874a6dbe95 100644
> --- a/drivers/idle/intel_idle.c
> +++ b/drivers/idle/intel_idle.c
> @@ -56,6 +56,7 @@
>  #include <asm/mwait.h>
>  #include <asm/spec-ctrl.h>
>  #include <asm/fpu/api.h>
> +#include <asm/smp.h>
>
>  #define INTEL_IDLE_VERSION "0.5.1"
>
> @@ -227,6 +228,16 @@ static __cpuidle int intel_idle_s2idle(struct cpuidl=
e_device *dev,
>         return 0;
>  }
>
> +static __cpuidle void intel_idle_enter_dead(struct cpuidle_device *dev,
> +                                           int index)
> +{
> +       struct cpuidle_driver *drv =3D cpuidle_get_cpu_driver(dev);
> +       struct cpuidle_state *state =3D &drv->states[index];
> +       unsigned long eax =3D flg2MWAIT(state->flags);
> +
> +       mwait_play_dead(eax);
> +}
> +
>  /*
>   * States are indexed by the cstate number,
>   * which is also the index into the MWAIT hint array.
> @@ -1798,6 +1809,7 @@ static void __init intel_idle_init_cstates_acpi(str=
uct cpuidle_driver *drv)
>                         state->flags |=3D CPUIDLE_FLAG_TIMER_STOP;
>
>                 state->enter =3D intel_idle;
> +               state->enter_dead =3D intel_idle_enter_dead;
>                 state->enter_s2idle =3D intel_idle_s2idle;
>         }
>  }
> @@ -2143,10 +2155,12 @@ static void __init intel_idle_init_cstates_icpu(s=
truct cpuidle_driver *drv)
>                 if (intel_idle_max_cstate_reached(cstate))
>                         break;
>
> -               if (!cpuidle_state_table[cstate].enter &&
> -                   !cpuidle_state_table[cstate].enter_s2idle)
> +               if (!cpuidle_state_table[cstate].enter)

I don't think that the above change belongs to this patch.  If I'm
mistaken, it should be mentioned in the changelog and the reason for
making it should be explained.

>                         break;
>
> +               if (!cpuidle_state_table[cstate].enter_dead)
> +                       cpuidle_state_table[cstate].enter_dead =3D intel_=
idle_enter_dead;
> +
>                 /* If marked as unusable, skip this state. */
>                 if (cpuidle_state_table[cstate].flags & CPUIDLE_FLAG_UNUS=
ABLE) {
>                         pr_debug("state %s is disabled\n",
> --

