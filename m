Return-Path: <linux-pm+bounces-20411-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FB55A1084A
	for <lists+linux-pm@lfdr.de>; Tue, 14 Jan 2025 15:01:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 70E931881C47
	for <lists+linux-pm@lfdr.de>; Tue, 14 Jan 2025 14:01:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50D513594A;
	Tue, 14 Jan 2025 14:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AuBD6f3T"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26635382;
	Tue, 14 Jan 2025 14:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736863298; cv=none; b=Olbf41JsOC2sNEkjZGrqLTkkfALpEWGHV477OLHsvBTfUrue5O/ipPcXctTqCpzwAhqVOkydUU8pZjbIEsd2kcBRYmQlDzIBnKbIoqstaYMjqA2dtZHj35iiYakKpr2arncXz4WR3PYzwir4XPYdxlELZA9NCGdrGQN2Oind6gE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736863298; c=relaxed/simple;
	bh=BvCVREdTDGCMsp3aRYxOfsRjh3UiHKyeoK5cGdoulAU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pvvk6Wpp47tucZSzlOLO0xqOydvUVQqxWJvS1DK5czNlNIAGE6NsK5zxKps1Yg7plK8HWzWpqW+l0G/OTkPxcLG0BSvrfqPyGlFN/u61gTcjweJ8P/NWiH7Gn2HEZA9WfKP28v53IyP/sUdKU9BxrNi8YPKqjOIn1yKJE+P7Cr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AuBD6f3T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B00C2C4CEE1;
	Tue, 14 Jan 2025 14:01:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736863297;
	bh=BvCVREdTDGCMsp3aRYxOfsRjh3UiHKyeoK5cGdoulAU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=AuBD6f3TFFoG6gOlDPnGVyOWR+ANVddWjvpF03QpdEe0+B47TYChEPMfVE3yZ1gKS
	 YZCWA8MmRMinLjLgpXvXUe8hgji+SObWuKmXpb8ndgYKlmAfMP8B96WSUvouK/cRWm
	 0pnFBRWQlCjaMRCwxMYzWLSRVMref+/iio2AP6XSXhrARP0i/9sd5+m1FV+iQGCNls
	 WhP6rRHg86xf7Igt7EKI4lYw7ovgorW6VYlx9Fv/2z5elIl53udg7myIg4CYMjEFW5
	 i1nXgNmYwbaN1TRTI9Mp3nPOvYlwUAWmIfiwpsv3lEQ6lzycRgncZnkoositaPfC8U
	 IBk7cZjHFlLVw==
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-3eba5848ee4so1419345b6e.3;
        Tue, 14 Jan 2025 06:01:37 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVsxHeKwnkx/0bEH96Wn/LZnfIalxQbSldjQWI4oqS9/ae8SDezlvcBYmE33eW18B2qRmEqPeJuIg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwINf0i9Q8L/gBaR73FpdfVSqqxNvciYuVBtgO1qzymho1TWVzO
	XrHfc9iu0DAqxCBoprdVxog9VQsZL0Lllb4gnTaNbETh7Juq0R9jnxauQ541L67r1hTKskrSRZw
	hoLSSZ95WZiT7qRKxH5woBgeG0C0=
X-Google-Smtp-Source: AGHT+IFenHe2Dyii6b5QgJJVIcyLVp/WviFK0I9RmrYosavNpGkAp+CTDmEZSuplekrO/hZWPqbadAE6Uybx1421hHQ=
X-Received: by 2002:a05:6808:14c3:b0:3eb:4137:53bb with SMTP id
 5614622812f47-3ef2ed64538mr17419951b6e.31.1736863297039; Tue, 14 Jan 2025
 06:01:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250102150201.21639-1-frederic@kernel.org> <20250102150201.21639-3-frederic@kernel.org>
In-Reply-To: <20250102150201.21639-3-frederic@kernel.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 14 Jan 2025 15:01:26 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0gEhGJCkfMn6jhF2D_4BYKJZev_Eyq5AhkTeT02_cHcXQ@mail.gmail.com>
X-Gm-Features: AbW1kvaevySiHr2zFkI5jc3HBojCRP1XnEfzDTvYSRT0ahuYQ_ZSu6VIovWEIQ8
Message-ID: <CAJZ5v0gEhGJCkfMn6jhF2D_4BYKJZev_Eyq5AhkTeT02_cHcXQ@mail.gmail.com>
Subject: Re: [PATCH 2/6] cpuidle: Introduce CPUIDLE_FLAG_MWAIT
To: Frederic Weisbecker <frederic@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	"Rafael J . Wysocki" <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, linux-pm@vger.kernel.org, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Jacob Pan <jacob.jun.pan@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 2, 2025 at 4:02=E2=80=AFPM Frederic Weisbecker <frederic@kernel=
.org> wrote:
>
> From: Peter Zijlstra <peterz@infradead.org>
>
> Provide a way to tell the cpuidle core about states monitoring
> TIF_NEED_RESCHED on the hardware level, monitor/mwait users being the
> only examples in use.
>
> This will allow cpuidle core to manage TIF_NR_POLLING on behalf of all
> kinds of TIF_NEED_RESCHED watching states while keeping a necessary
> distinction for the governors between software loops polling on
> TIF_NEED_RESCHED and hardware monitored writes to thread flags.
>
> [fweisbec: _ Initialize flag from acpi_processor_setup_cstates() instead
>              of acpi_processor_setup_lpi_states(), as the latter seem to
>              be about arm64...
>            _ Rename CPUIDLE_FLAG_NO_IPI to CPUIDLE_FLAG_MWAIT]
>
> Signed-off-by: Peter Zijlstra <peterz@infradead.org>
> Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> ---
>  drivers/acpi/processor_idle.c | 3 +++
>  drivers/idle/intel_idle.c     | 5 ++++-
>  include/linux/cpuidle.h       | 1 +
>  3 files changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.=
c
> index 698897b29de2..66cb5536d91e 100644
> --- a/drivers/acpi/processor_idle.c
> +++ b/drivers/acpi/processor_idle.c
> @@ -806,6 +806,9 @@ static int acpi_processor_setup_cstates(struct acpi_p=
rocessor *pr)
>                 if (cx->type =3D=3D ACPI_STATE_C1 || cx->type =3D=3D ACPI=
_STATE_C2)
>                         drv->safe_state_index =3D count;
>
> +               if (cx->entry_method =3D=3D ACPI_CSTATE_FFH)
> +                       state->flags |=3D CPUIDLE_FLAG_MWAIT;

FFH need not mean MWAIT in principle.

FFH in _CST means MWAIT in practice because _CST is used on x86 which
implements FFH through MWAIT, but it would be good at least to put a
comment here to explain that this code is only expected to run on x86.

Or better still, add something like acpi_arch_idle_state_flags(u8
entry_method) that will return CPUIDLE_FLAG_MWAIT for ACPI_CSTATE_FFH
and 0 otherwise and then do

    state->flags |=3D acpi_arch_idle_state_flags(cx->entry_method);

> +
>                 /*
>                  * Halt-induced C1 is not good for ->enter_s2idle, becaus=
e it
>                  * re-enables interrupts on exit.  Moreover, C1 is genera=
lly not
> diff --git a/drivers/idle/intel_idle.c b/drivers/idle/intel_idle.c
> index ac4d8faa3886..d52723fbeb04 100644
> --- a/drivers/idle/intel_idle.c
> +++ b/drivers/idle/intel_idle.c
> @@ -1787,7 +1787,8 @@ static void __init intel_idle_init_cstates_acpi(str=
uct cpuidle_driver *drv)
>                 if (cx->type > ACPI_STATE_C1)
>                         state->target_residency *=3D 3;
>
> -               state->flags =3D MWAIT2flg(cx->address);
> +               state->flags =3D MWAIT2flg(cx->address) | CPUIDLE_FLAG_MW=
AIT;
> +
>                 if (cx->type > ACPI_STATE_C2)
>                         state->flags |=3D CPUIDLE_FLAG_TLB_FLUSHED;
>
> @@ -2072,6 +2073,8 @@ static bool __init intel_idle_verify_cstate(unsigne=
d int mwait_hint)
>
>  static void state_update_enter_method(struct cpuidle_state *state, int c=
state)
>  {
> +       state->flags |=3D CPUIDLE_FLAG_MWAIT;
> +
>         if (state->flags & CPUIDLE_FLAG_INIT_XSTATE) {
>                 /*
>                  * Combining with XSTATE with IBRS or IRQ_ENABLE flags
> diff --git a/include/linux/cpuidle.h b/include/linux/cpuidle.h
> index a9ee4fe55dcf..b8084617aa27 100644
> --- a/include/linux/cpuidle.h
> +++ b/include/linux/cpuidle.h
> @@ -85,6 +85,7 @@ struct cpuidle_state {
>  #define CPUIDLE_FLAG_OFF               BIT(4) /* disable this state by d=
efault */
>  #define CPUIDLE_FLAG_TLB_FLUSHED       BIT(5) /* idle-state flushes TLBs=
 */
>  #define CPUIDLE_FLAG_RCU_IDLE          BIT(6) /* idle-state takes care o=
f RCU */
> +#define CPUIDLE_FLAG_MWAIT             BIT(7) /* hardware need_resched()=
 monitoring */
>
>  struct cpuidle_device_kobj;
>  struct cpuidle_state_kobj;
> --

