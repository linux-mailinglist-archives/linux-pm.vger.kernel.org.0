Return-Path: <linux-pm+bounces-37666-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BA5CC42C40
	for <lists+linux-pm@lfdr.de>; Sat, 08 Nov 2025 12:48:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 178864E29CE
	for <lists+linux-pm@lfdr.de>; Sat,  8 Nov 2025 11:48:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7789826F2B8;
	Sat,  8 Nov 2025 11:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nw5WzWb0"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5344E1D5CC7
	for <linux-pm@vger.kernel.org>; Sat,  8 Nov 2025 11:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762602516; cv=none; b=clZqolbOCBg8H6CHNbA7mn0DOUaGhCSTm9ISJc79SeYTH3+CmGGjKcD4LeCVt75nFAnVvtjkgJkSj9LQfaguSW9cKG/odBb7hnnXrSqww3PVYdfSNJtrS6qL3QznhdUOZiaRCnsh+jrkQEEZOhmoADzvPo/RLbFy8hT4oSFbf68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762602516; c=relaxed/simple;
	bh=HEwjnCb7mPWNGlgkOGSaF9j4GZo2L78ZrbzbN3lFzV8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XaFXiSwcZJzfYTAg+v3TOXkF0p6UmiRyxjxgJuOVfaisCgoUJqjJ17jfiOULdxYLJ6Mfv7nRHY9jXunrMA1EPj56q5UPeFZdh45uMt6Gk2ywUO8DwyqXu/vsKENOT3Av+wDQiG3CuokBk0l4WTEHQ+HaCKUslLMC6o+cbgEtqis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nw5WzWb0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3C79C16AAE
	for <linux-pm@vger.kernel.org>; Sat,  8 Nov 2025 11:48:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762602516;
	bh=HEwjnCb7mPWNGlgkOGSaF9j4GZo2L78ZrbzbN3lFzV8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=nw5WzWb0o4Sgeop9lhRFvHXu+Apwnpy+K0iRk2+Ud5eu6ZJ88SyNvlKFnsnRgBKcW
	 70ZWD0ccZ5JXkCmI1x2SEQqRZZEJwadVA7bHGjA8Df0vQz4zpfrbylDoulLgsmSiQ5
	 SoDi6RMb6MqW8q2usdJBk8LGgZzsJ4jnoLcwcE8mEuI+8fESKZyOfLYp2+7jp2bSS7
	 sEp7L9GbitxfdLGDbX5Cdc9TjktxVwssGeopkqsSmC1X0v8hDdjTmgNYKGJ7dhy97r
	 YCm//EoSqacMTNpXU/Xygy1RQOsdD+iUt6FNPyty0Fi93e2WUI79bXg4FHYk1KBe+h
	 tOkYod/sq7ECg==
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-7c6d699610cso500651a34.0
        for <linux-pm@vger.kernel.org>; Sat, 08 Nov 2025 03:48:35 -0800 (PST)
X-Gm-Message-State: AOJu0Yz6keJtrW76dUxzd3qaGiAYzmB/THYJEoExiDhEKwTMUFLUAnNQ
	UfbYPDoyx2m9wZmMfX+c3AquZTDaT4DhzZfe3eo+ONrpaMe0mEHKrIfkH8CIBPfClGrOmHU0Pnw
	kSDWboBA2qFVqHIuCNeDS8zGQs3PX0pc=
X-Google-Smtp-Source: AGHT+IEATu6J1yUk0vKUeco1gZt1faILYR/teQcgig6QXlxFQ4drh+62nwnVW447JHlujCAGUMmakoLsM+27Tq3mwMw=
X-Received: by 2002:a05:6808:4f21:b0:44d:a885:8a02 with SMTP id
 5614622812f47-4502a3ba7f9mr1465648b6e.47.1762602515259; Sat, 08 Nov 2025
 03:48:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <12779486.O9o76ZdvQC@rafael.j.wysocki> <f1194b6840459447f36e5d387320ef295aa8166d.camel@linux.intel.com>
 <CAJZ5v0hgjZdRTbDnTz7frt5+Grrt0Dft_TJgW0-t92XupCbzXw@mail.gmail.com>
In-Reply-To: <CAJZ5v0hgjZdRTbDnTz7frt5+Grrt0Dft_TJgW0-t92XupCbzXw@mail.gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Sat, 8 Nov 2025 12:48:22 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0i9DkZR=ZnJ-+VDm-2wk-ab2X=RM69uiSTgwuhGnf8zVg@mail.gmail.com>
X-Gm-Features: AWmQ_bkMH2wr1QSTBVk-nzXRjpFzF3E52H-9PPIfuVuY0eIz-Q5apLox5j7SZ6M
Message-ID: <CAJZ5v0i9DkZR=ZnJ-+VDm-2wk-ab2X=RM69uiSTgwuhGnf8zVg@mail.gmail.com>
Subject: Re: [PATCH v2] cpuidle: Add sanity check for exit latency and target residency
To: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
Cc: Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 8, 2025 at 12:02=E2=80=AFPM Rafael J. Wysocki <rafael@kernel.or=
g> wrote:
>
> On Sat, Nov 8, 2025 at 9:49=E2=80=AFAM Artem Bityutskiy
> <artem.bityutskiy@linux.intel.com> wrote:
> >
> > On Fri, 2025-11-07 at 20:07 +0100, Rafael J. Wysocki wrote:
> > > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > >
> > > Make __cpuidle_driver_init() fail if the exit latency of one of the
> > > driver's idle states is less than its exit latency which would break
> > > cpuidle assumptions.
> > >
> > > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > LGTM
> >
> > Reviewed-by: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
> >
> >
> > By the way, I have a more paranoid validation patch, which validates
> > latency and also more. Sure I can rebase it later on top of this
> > patch.
>
> That should be rather straightforward.
>
> > I did not have time to polish it yet, but sharing just in case there is
> > a quick feedback.
> >
> > From: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
> > Subject: [PATCH] cpuidle: Add idle states validation
> >
> > Validate the idle states table provided by the underlying idle driver. =
For
> > example, validate that deeper idle states have greater latency and targ=
et
> > residency compared to shallower states.
> >
> > Signed-off-by: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
> > ---
> >  drivers/cpuidle/driver.c | 58 ++++++++++++++++++++++++++++++++++++++--
> >  1 file changed, 56 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/cpuidle/driver.c b/drivers/cpuidle/driver.c
> > index 9bbfa594c4425..6bcedad534dd9 100644
> > --- a/drivers/cpuidle/driver.c
> > +++ b/drivers/cpuidle/driver.c
> > @@ -20,6 +20,10 @@
> >
> >  #include "cpuidle.h"
> >
> > +/* Maximum allowed latency and target residency values */
> > +#define MAX_LATENCY 50000 /* 50 milliseconds */
> > +#define MAX_RESIDENCY 1000000 /* 1 second */
> > +
> >  DEFINE_SPINLOCK(cpuidle_driver_lock);
> >
> >  #ifdef CONFIG_CPU_IDLE_MULTIPLE_DRIVERS
> > @@ -148,11 +152,46 @@ static void cpuidle_setup_broadcast_timer(void *a=
rg)
> >                 tick_broadcast_disable();
> >  }
> >
> > +/**
> > + * validate_state - Validate an idle state.
> > + * @state: The C-state to validate.
> > + * @prev_state: The previous idle state or NULL.
> > + *
> > + * Return: 0 if the idle state is valid or -EINVAL otherwise.
> > + */
> > +static int validate_state(struct cpuidle_state *s, struct cpuidle_stat=
e *prev_s)
> > +{
> > +       if (s->exit_latency =3D=3D 0)
> > +               return -EINVAL;
>
> The change above will break the polling state AFAICS.
>
> > +
> > +       if (s->exit_latency > MAX_LATENCY)
> > +               return -EINVAL;
> > +
> > +       if (s->target_residency > MAX_RESIDENCY)
> > +               return -EINVAL;
> > +
> > +       if (s->target_residency < s->exit_latency)
> > +               return -EINVAL;
> > +
> > +       if (!prev_s)
> > +               return 0;
> > +
> > +       if (s->exit_latency <=3D prev_s->exit_latency)
> > +               return -EINVAL;
>
> Well, is this really necessary?  Nothing depends on this ordering AFAICS.

Yes, it is, there are assumptions in the governors regarding this.
Sorry for the noise.

