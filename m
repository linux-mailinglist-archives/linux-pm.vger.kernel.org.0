Return-Path: <linux-pm+bounces-18946-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57EB99EBAB5
	for <lists+linux-pm@lfdr.de>; Tue, 10 Dec 2024 21:15:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 512021667F1
	for <lists+linux-pm@lfdr.de>; Tue, 10 Dec 2024 20:15:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7712D1D0488;
	Tue, 10 Dec 2024 20:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KgXr5RX1"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46AB486326;
	Tue, 10 Dec 2024 20:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733861750; cv=none; b=WBE0RcW4QWspopstXSjwfWPjyy17aNfGJS/LOe1W9hx1B5Bded9vjUnjtqMCnE7Ob0IDRfTXDSOGWpbeD0JMmNa2w0BqsjGMEbXuvTpui6IdQKIZBj0z1a6OJBDi1f//A0D9eLGhEeD6kkhE/NHIM8NMtE26u5tIp9O0/LYglTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733861750; c=relaxed/simple;
	bh=UwJrLxFq7Mt1V48jlV/l4c4DoKjlt2xFKIVO3zDu1Z8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nv9cxuF95bmdF+zIOddq3bot2BQkMrdNsRN88bYU5bJetGdDutZtsxbqpGcFApU7yLpYrLxhwiR+3esirT6swaMseAHfNPyWTOxylJYy1aZbrdx2O+PX8xzcTl3vr3tVv7N9mGl4kSjUayfrEqSZLfhrpngCMqraz2iu383PAj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KgXr5RX1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C896AC4AF09;
	Tue, 10 Dec 2024 20:15:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733861749;
	bh=UwJrLxFq7Mt1V48jlV/l4c4DoKjlt2xFKIVO3zDu1Z8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=KgXr5RX1bzVrMQBU+8gFhuOzn/wc3xtTISTvMJTFTuUSROdJYFfQO6ZZ38iNsBuyQ
	 qp6dzPKBWngnoGw4CqrQzRebOWjWRToZz3fLXtMcKbrINecYdvuR/vUx1Q1HMt0Eih
	 lw5dY4ISv1pNUhv6nb2INBcv7PXVJS5b7S02sPn7INr7e+plEclO3gKP5EyzWlUg6e
	 eU9B4o4RMKSoQOsuDzZ/uDF2FdVROTKocdcvbcMqsj08tCz/YneF6ojCUTJUMMsZO3
	 rvflGJEM71Y9l4FvVX59D2tn6X1uErrLZNldngW3LX31H6LGiETGlQcVdRaHDx92N2
	 HsQjrGY5fb4LA==
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-71e163493efso145028a34.3;
        Tue, 10 Dec 2024 12:15:49 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUXgrMzWBQECyIQgWG9zJtez5S5AWbmO95SoFhKlkpReNmyBSKLWnzIvgdsg4TUPC6QGOnx2dflWSzKgQQ=@vger.kernel.org, AJvYcCX7OO5LgTmbcKBie38Ob1esieS1kjv+9JQVOO+fng6LlGxJq3bcNeaHMUUZpvDgrLHG034dDXhs44c=@vger.kernel.org
X-Gm-Message-State: AOJu0YwY6aVZsJ5PcAKVyULfiTKa3sReYtDptwLjRA7DLl1FRPHY5p9I
	5ECPgBMsxA3NzgZYCSqLv6uCklFC1SZTTMEcDhXxs72y/3mTEw/wt+IuUglRmIeJdogYzqOwlhP
	eBpOTpcVQVUGMOmkbxfXjpxDOBr0=
X-Google-Smtp-Source: AGHT+IESQMRzxaS2hDTGJu7cvr41zVnRv0x8hAelCqrQ2r5fJ760G0pVrQFTtmA02BoK/QkmZ0qmi6y+vBdJ+zZrh+Q=
X-Received: by 2002:a05:6830:411b:b0:71e:17f2:26d8 with SMTP id
 46e09a7af769-71e19b2fca5mr84019a34.22.1733861748986; Tue, 10 Dec 2024
 12:15:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241129182232.14987-1-patryk.wlazlyn@linux.intel.com> <20241129182232.14987-3-patryk.wlazlyn@linux.intel.com>
In-Reply-To: <20241129182232.14987-3-patryk.wlazlyn@linux.intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 10 Dec 2024 21:15:37 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0jkWv3=XXDXOkrBiYowkdkH8NM29K=zjRz5fZETCb-GRQ@mail.gmail.com>
Message-ID: <CAJZ5v0jkWv3=XXDXOkrBiYowkdkH8NM29K=zjRz5fZETCb-GRQ@mail.gmail.com>
Subject: Re: [PATCH v7 2/4] ACPI: processor_idle: Add FFH state handling
To: Patryk Wlazlyn <patryk.wlazlyn@linux.intel.com>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
	rafael.j.wysocki@intel.com, peterz@infradead.org, dave.hansen@linux.intel.com, 
	gautham.shenoy@amd.com, tglx@linutronix.de, len.brown@intel.com, 
	artem.bityutskiy@linux.intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 29, 2024 at 7:22=E2=80=AFPM Patryk Wlazlyn
<patryk.wlazlyn@linux.intel.com> wrote:
>
> Recent Intel platforms will depend on the idle driver to pass the
> correct hint for playing dead via mwait_play_dead_with_hint(). Expand
> the existing enter_dead interface with handling for FFH states and pass
> the MWAIT hint to the mwait_play_dead code.

First, the changelog doesn't match the code changes because you've
decided to use mwait_play_dead() without changing its name.

Second, "recent" is something that has happened already, so I would
say "new" or "upcoming" instead.

Overall, my changelog for this patch would be something like this:

"The ACPI processor_idle driver's implementation of the :enter_dead()
callback, acpi_idle_play_dead(), is missing the handling of FFH (Fixed
Functional Hardware) idle states that on x86 platforms are entered by
executing the MWAIT instruction.  If such idle states are listed by
_CST for the given CPU, the idle driver should be able to use the
MWAIT hints corresponding to them in order to put the CPU into an
appropriate idle state when it is going offline, so update
acpi_idle_play_dead() to take the FFH idle states into account.

Going forward this will be depended on by Intel platforms if the
(otherwise default) intel_idle driver is disabled."

The code changes look good to me.

> Signed-off-by: Patryk Wlazlyn <patryk.wlazlyn@linux.intel.com>
> Suggested-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
> ---
>  arch/x86/kernel/acpi/cstate.c | 10 ++++++++++
>  drivers/acpi/processor_idle.c |  2 ++
>  include/acpi/processor.h      |  5 +++++
>  3 files changed, 17 insertions(+)
>
> diff --git a/arch/x86/kernel/acpi/cstate.c b/arch/x86/kernel/acpi/cstate.=
c
> index f3ffd0a3a012..8d7b8b02ddb9 100644
> --- a/arch/x86/kernel/acpi/cstate.c
> +++ b/arch/x86/kernel/acpi/cstate.c
> @@ -15,6 +15,7 @@
>  #include <acpi/processor.h>
>  #include <asm/mwait.h>
>  #include <asm/special_insns.h>
> +#include <asm/smp.h>
>
>  /*
>   * Initialize bm_flags based on the CPU cache properties
> @@ -204,6 +205,15 @@ int acpi_processor_ffh_cstate_probe(unsigned int cpu=
,
>  }
>  EXPORT_SYMBOL_GPL(acpi_processor_ffh_cstate_probe);
>
> +void acpi_processor_ffh_play_dead(struct acpi_processor_cx *cx)
> +{
> +       unsigned int cpu =3D smp_processor_id();
> +       struct cstate_entry *percpu_entry;
> +
> +       percpu_entry =3D per_cpu_ptr(cpu_cstate_entry, cpu);
> +       mwait_play_dead(percpu_entry->states[cx->index].eax);
> +}
> +
>  void __cpuidle acpi_processor_ffh_cstate_enter(struct acpi_processor_cx =
*cx)
>  {
>         unsigned int cpu =3D smp_processor_id();
> diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.=
c
> index ce728cf7e301..83213fa47c1b 100644
> --- a/drivers/acpi/processor_idle.c
> +++ b/drivers/acpi/processor_idle.c
> @@ -590,6 +590,8 @@ static void acpi_idle_play_dead(struct cpuidle_device=
 *dev, int index)
>                         raw_safe_halt();
>                 else if (cx->entry_method =3D=3D ACPI_CSTATE_SYSTEMIO) {
>                         io_idle(cx->address);
> +               } else if (cx->entry_method =3D=3D ACPI_CSTATE_FFH) {
> +                       acpi_processor_ffh_play_dead(cx);
>                 } else
>                         return;
>         }
> diff --git a/include/acpi/processor.h b/include/acpi/processor.h
> index a17e97e634a6..63a37e72b721 100644
> --- a/include/acpi/processor.h
> +++ b/include/acpi/processor.h
> @@ -280,6 +280,7 @@ int acpi_processor_ffh_cstate_probe(unsigned int cpu,
>                                     struct acpi_processor_cx *cx,
>                                     struct acpi_power_register *reg);
>  void acpi_processor_ffh_cstate_enter(struct acpi_processor_cx *cstate);
> +void acpi_processor_ffh_play_dead(struct acpi_processor_cx *cx);
>  #else
>  static inline void acpi_processor_power_init_bm_check(struct
>                                                       acpi_processor_flag=
s
> @@ -300,6 +301,10 @@ static inline void acpi_processor_ffh_cstate_enter(s=
truct acpi_processor_cx
>  {
>         return;
>  }
> +static inline void acpi_processor_ffh_play_dead(struct acpi_processor_cx=
 *cx)
> +{
> +       return;
> +}
>  #endif
>
>  static inline int call_on_cpu(int cpu, long (*fn)(void *), void *arg,
> --

