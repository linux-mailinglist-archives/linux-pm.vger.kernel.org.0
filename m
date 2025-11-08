Return-Path: <linux-pm+bounces-37664-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ACABC42B92
	for <lists+linux-pm@lfdr.de>; Sat, 08 Nov 2025 12:03:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B5453AF990
	for <lists+linux-pm@lfdr.de>; Sat,  8 Nov 2025 11:02:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97AA124DD1F;
	Sat,  8 Nov 2025 11:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SqEJ++Zf"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6961C21638D
	for <linux-pm@vger.kernel.org>; Sat,  8 Nov 2025 11:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762599776; cv=none; b=H3SA6gGad1GnC27jCs10P4cPuGCQoTh3UHWcMGlveivZiPCNN1/kOlmXmNWIY5/VIcuWSsGri8qlrngoFKqQfQmN1/DgvrZuNtdCH8QYJPwwtCrw2/8chFhfyqSggNWoJ2yKGAZqPPqDAZnkqOPwQtIygHdz6Lt+rcpe+e+WOCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762599776; c=relaxed/simple;
	bh=zYPYh8WA5uL8fmVHSCfXExmStZaZT7S9RKpF53RW6TM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LheqByQxiLipUaw13p7qq9JZgWCcYqAp/DuNypyZw+9LMTN067u9SToWnnD69OnTYMdPJF5YHTtxs5C6pzjV1oBTtJT1q9QHuInPV36FYqH3p34PJYK1XnA1NnWBARB+pQTMnnxI3oVsCjjYIZQmDcpv5KYXrYljUtTDd0yiiDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SqEJ++Zf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45FC5C19422
	for <linux-pm@vger.kernel.org>; Sat,  8 Nov 2025 11:02:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762599776;
	bh=zYPYh8WA5uL8fmVHSCfXExmStZaZT7S9RKpF53RW6TM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=SqEJ++Zfz1mAEd/DllKaCsXU1oaVzWLvYmYkZSQOSOpf5z1XD/A4l0FjAnngPAdbI
	 BEsyviqF0DsC481nBMyquxPzPUy7HhFItyjSf1XDE4GcXsEwY9/IkvBNNX4gei46dI
	 B0Eo5LN75HRd7y8QOPxUzcqP5t20sxJFXrD5fJ6sWkyXPXx2Co05/W1Mo2w1dSMOiC
	 zpa7gIMmIwJ20wz5SgsKYtk0GVZLOUwV58TVrt3lvwdiJ5kzBapDuhDNo9BHIPbJYP
	 hX5QxMLFfBwwyD1XAfDT2rmtsnQlr3h+rF4DkUdeVfomi6ot6KCYjtt//swtiyyjl6
	 fGrNdh8SK4EPg==
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-450136c3e05so689118b6e.3
        for <linux-pm@vger.kernel.org>; Sat, 08 Nov 2025 03:02:56 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVBB9ZWWMYTf+unmqLUr0x57tm1wNNonC/LFmV1B2MGB0OesBMD9H7Mp7PoGjLdCbHK8A4bYI/x2w==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywa3pFUKJTPt9pf/Aj/a3DkTcvkw3rjjBg0qZZWcUpXwsONww8n
	/0f7NIAoGViR/pLGRwWA7ZWqafeHoaFPZUp6Bm/yFDSurT2iQsrZa3kRKIcZAO1/m+5+boAvbCq
	fZnYFBwD95Il86hREmti9E4c4nuUuaMM=
X-Google-Smtp-Source: AGHT+IF+EoDREQwVXfM7zBbmlXJRYF/yBlPfvkn+DRceaVMvBcCC6kOziEzXpD2MCBXHWenH3R2TsEXGEXPYQjTpxY0=
X-Received: by 2002:a05:6808:1b14:b0:43f:29ec:a210 with SMTP id
 5614622812f47-4502a3adc20mr1268046b6e.47.1762599775547; Sat, 08 Nov 2025
 03:02:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <12779486.O9o76ZdvQC@rafael.j.wysocki> <f1194b6840459447f36e5d387320ef295aa8166d.camel@linux.intel.com>
In-Reply-To: <f1194b6840459447f36e5d387320ef295aa8166d.camel@linux.intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Sat, 8 Nov 2025 12:02:42 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0hgjZdRTbDnTz7frt5+Grrt0Dft_TJgW0-t92XupCbzXw@mail.gmail.com>
X-Gm-Features: AWmQ_blnILV9eJ12Q0PZF461kxx7iOkGLUdA56YvoaY1OXXJEexfMaESrq9Xmeg
Message-ID: <CAJZ5v0hgjZdRTbDnTz7frt5+Grrt0Dft_TJgW0-t92XupCbzXw@mail.gmail.com>
Subject: Re: [PATCH v2] cpuidle: Add sanity check for exit latency and target residency
To: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Linux PM <linux-pm@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 8, 2025 at 9:49=E2=80=AFAM Artem Bityutskiy
<artem.bityutskiy@linux.intel.com> wrote:
>
> On Fri, 2025-11-07 at 20:07 +0100, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > Make __cpuidle_driver_init() fail if the exit latency of one of the
> > driver's idle states is less than its exit latency which would break
> > cpuidle assumptions.
> >
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> LGTM
>
> Reviewed-by: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
>
>
> By the way, I have a more paranoid validation patch, which validates
> latency and also more. Sure I can rebase it later on top of this
> patch.

That should be rather straightforward.

> I did not have time to polish it yet, but sharing just in case there is
> a quick feedback.
>
> From: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
> Subject: [PATCH] cpuidle: Add idle states validation
>
> Validate the idle states table provided by the underlying idle driver. Fo=
r
> example, validate that deeper idle states have greater latency and target
> residency compared to shallower states.
>
> Signed-off-by: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
> ---
>  drivers/cpuidle/driver.c | 58 ++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 56 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/cpuidle/driver.c b/drivers/cpuidle/driver.c
> index 9bbfa594c4425..6bcedad534dd9 100644
> --- a/drivers/cpuidle/driver.c
> +++ b/drivers/cpuidle/driver.c
> @@ -20,6 +20,10 @@
>
>  #include "cpuidle.h"
>
> +/* Maximum allowed latency and target residency values */
> +#define MAX_LATENCY 50000 /* 50 milliseconds */
> +#define MAX_RESIDENCY 1000000 /* 1 second */
> +
>  DEFINE_SPINLOCK(cpuidle_driver_lock);
>
>  #ifdef CONFIG_CPU_IDLE_MULTIPLE_DRIVERS
> @@ -148,11 +152,46 @@ static void cpuidle_setup_broadcast_timer(void *arg=
)
>                 tick_broadcast_disable();
>  }
>
> +/**
> + * validate_state - Validate an idle state.
> + * @state: The C-state to validate.
> + * @prev_state: The previous idle state or NULL.
> + *
> + * Return: 0 if the idle state is valid or -EINVAL otherwise.
> + */
> +static int validate_state(struct cpuidle_state *s, struct cpuidle_state =
*prev_s)
> +{
> +       if (s->exit_latency =3D=3D 0)
> +               return -EINVAL;

The change above will break the polling state AFAICS.

> +
> +       if (s->exit_latency > MAX_LATENCY)
> +               return -EINVAL;
> +
> +       if (s->target_residency > MAX_RESIDENCY)
> +               return -EINVAL;
> +
> +       if (s->target_residency < s->exit_latency)
> +               return -EINVAL;
> +
> +       if (!prev_s)
> +               return 0;
> +
> +       if (s->exit_latency <=3D prev_s->exit_latency)
> +               return -EINVAL;

Well, is this really necessary?  Nothing depends on this ordering AFAICS.

> +
> +       if (s->target_residency <=3D prev_s->target_residency)
> +               return -EINVAL;
> +
> +       return 0;
> +}
> +
>  /**
>   * __cpuidle_driver_init - initialize the driver's internal data
>   * @drv: a valid pointer to a struct cpuidle_driver
> + *
> + * Return: 0 on success, -EINVAL in case of invalid C-state data.
>   */
> -static void __cpuidle_driver_init(struct cpuidle_driver *drv)
> +static int __cpuidle_driver_init(struct cpuidle_driver *drv)
>  {
>         int i;
>
> @@ -166,6 +205,17 @@ static void __cpuidle_driver_init(struct cpuidle_dri=
ver *drv)
>
>         for (i =3D 0; i < drv->state_count; i++) {
>                 struct cpuidle_state *s =3D &drv->states[i];
> +               struct cpuidle_state *prev_s;
> +
> +               if (i > 0)
> +                       prev_s =3D &drv->states[i - 1];
> +               else
> +                       prev_s =3D NULL;
> +
> +               if (validate_state(s, prev_s)) {

I would use the ternary operator here:

              if (validate_state(s, i ? &drv->states[i - 1] : NULL)) {

or just pass drv and i to validate_state().

But this needs to be done when all of the values are known. ->

> +                       pr_err("Idle state '%s' validation failed\n", s->=
name);
> +                       return -EINVAL;
> +               }
>
>                 /*
>                  * Look for the timer stop flag in the different states a=
nd if
> @@ -194,6 +244,8 @@ static void __cpuidle_driver_init(struct cpuidle_driv=
er *drv)
>                 else
>                         s->exit_latency =3D div_u64(s->exit_latency_ns, N=
SEC_PER_USEC);

-> Which is here.

>         }
> +
> +       return 0;
>  }
>
>  /**
> @@ -223,7 +275,9 @@ static int __cpuidle_register_driver(struct cpuidle_d=
river *drv)
>         if (cpuidle_disabled())
>                 return -ENODEV;
>
> -       __cpuidle_driver_init(drv);
> +       ret =3D __cpuidle_driver_init(drv);
> +       if (ret)
> +               return ret;
>
>         ret =3D __cpuidle_set_driver(drv);
>         if (ret)
> --

