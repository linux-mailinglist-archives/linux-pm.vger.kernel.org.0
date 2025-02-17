Return-Path: <linux-pm+bounces-22202-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C64F3A3827B
	for <lists+linux-pm@lfdr.de>; Mon, 17 Feb 2025 12:57:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 69F421687E3
	for <lists+linux-pm@lfdr.de>; Mon, 17 Feb 2025 11:57:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C44D21A436;
	Mon, 17 Feb 2025 11:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cfv+iQDr"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E95721A421;
	Mon, 17 Feb 2025 11:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739793440; cv=none; b=QKOd2/1ZQfKD4WFEcIgBMrYhvDzQCJzi8Gh7jdbmZPgfZ39Qk7ckZVO26ylfuqR+arrFOxj/DbgndQnacBfTSMiWFtMbi9fIb3n8YGtgSrI10T0LHBvIiiCt5Xh+MxMwZZaDedlFKscS0Xs7p1YSFzi9oXmlx2biT1aPqK6Sbg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739793440; c=relaxed/simple;
	bh=Y/TN2bh9LSXg3FW05NB+yXIAvd1FTqOs+ZHW/w1bA90=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ldE920u7rUvtBn74wARon0x7osZdJW8ypqENRvJz9n8rJIbzQuBcLZQZiU32bcSOMXJWo5zA9w7HvuH69H4f3ck7NHrkFqYYtwmVT/cLZOU2uZr4psI101hG5lqNN0Pk5ip6j0RWTqsxAgFbUiSZrNasftkh/981yGItzSrHUkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cfv+iQDr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9842FC4CEEE;
	Mon, 17 Feb 2025 11:57:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739793439;
	bh=Y/TN2bh9LSXg3FW05NB+yXIAvd1FTqOs+ZHW/w1bA90=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=cfv+iQDrdlvQhTaqmTSjjFAW0FI5sUTOl67HXFXxgts+jSAGVIuTfp5jpzwcsBtZ6
	 GJuA92555UBfHT+pKctv0gc9wkFh4gzmvZfuOkS5fwDHJDqeEcKzVUliWqFC6WW6m+
	 00aKxI2H65TKhey8O+fp0FK4qH7FvSOD5Am80Wh6yg81CPerUtNIRwpa6foYMyh3Ff
	 v7EkH2Xx91D0lrJ9i6ZIXFH/gS9tPGpr7Itq9FPswe8EL4262ExHLItgWYKDwfaUQQ
	 t40pWxGJcGDIgJIEbPIBfyj06/E8Jw/MHG9KLdxFrSe7dLaMJeQBz+Qfv19nbNKJtL
	 /eKinNhoEyzdw==
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-3f3deb037cfso1750335b6e.3;
        Mon, 17 Feb 2025 03:57:19 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVgmMmH2jLLpI2ELQ5HJfsTV2OYXw99c/SlPOULVuntUA8ixEbO59OaMFMgGgPwVTGbrUQ3A3LyMo6cHkeQo5wYPcV5@vger.kernel.org, AJvYcCWgYbIFZN0YBOLY3k9tNsFIqG+k7H1R/0CySa3iLw2rCrPim0MFzaD90hzJv4QDaUl+L1qoOY+hmw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzjxOUn/UAvFkKu955hHWfA/HeEiBLtBQh8NLe4yBy4WotO6sPP
	rXwVHv3K6EwkaAmnznsdeiD8hJLywSMKDnB4HR/xi+uk0K0XhRfYgOGyo1A7GqCcRXPfQGmPqY7
	2IEBSZdXkefF4Jy0NwxVg2j39ayY=
X-Google-Smtp-Source: AGHT+IGgk9wjF7NwnX8et0jzER6LayQU2MY0yj2pfOSKSlhSiBlMxG4HuFD/YSGpYLbiMFfjiKIXrDujz+RjTFY3bqo=
X-Received: by 2002:a05:6808:13c2:b0:3f3:e1c3:39d8 with SMTP id
 5614622812f47-3f3eb088af9mr6680370b6e.7.1739793438923; Mon, 17 Feb 2025
 03:57:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250210055828.1875372-1-keyz@google.com>
In-Reply-To: <20250210055828.1875372-1-keyz@google.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 17 Feb 2025 12:57:07 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0hWNYB69ydM4--GNtLBgG3WS4MT+S10w46883kHnFMMEQ@mail.gmail.com>
X-Gm-Features: AWEUYZlerGW8CaScCPlNU0kV18tmC8lLU10SucLC1QEGtyvEZia5QSOw4UT49-U
Message-ID: <CAJZ5v0hWNYB69ydM4--GNtLBgG3WS4MT+S10w46883kHnFMMEQ@mail.gmail.com>
Subject: Re: [PATCH v5 RESEND] cpuidle: psci: Add trace for PSCI domain idle
To: Keita Morisaki <keyz@google.com>, Ulf Hansson <ulf.hansson@linaro.org>, lpieralisi@kernel.org, 
	sudeep.holla@arm.com
Cc: linux-kernel@vger.kernel.org, rafael@kernel.org, daniel.lezcano@linaro.org, 
	linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	rostedt@goodmis.org, mhiramat@kernel.org, mathieu.desnoyers@efficios.com, 
	linux-trace-kernel@vger.kernel.org, aarontian@google.com, 
	yimingtseng@google.com, Dhruva Gole <d-gole@ti.com>, Kevin Hilman <khilman@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

+Ulf

On Mon, Feb 10, 2025 at 6:58=E2=80=AFAM Keita Morisaki <keyz@google.com> wr=
ote:
>
> The trace event cpu_idle provides insufficient information for debugging
> PSCI requests due to lacking access to determined PSCI domain idle
> states. The cpu_idle usually only shows -1, 0, or 1 regardless how many
> idle states the power domain has.
>
> Add new trace events namely psci_domain_idle_enter and
> psci_domain_idle_exit to trace enter and exit events with a determined
> idle state.
>
> These new trace events will help developers debug CPUidle issues on ARM
> systems using PSCI by providing more detailed information about the
> requested idle states.
>
> Signed-off-by: Keita Morisaki <keyz@google.com>
> Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> Reviewed-by: Dhruva Gole <d-gole@ti.com>
> Tested-by: Kevin Hilman <khilman@baylibre.com>
> ---
> v1->v2: Split the ftrace event into two (psci_domain_idle_(enter|exit))
>         and rephrase the commit message accordingly. Rebased onto the lat=
est.
> v2->v3: Add "Reviewed-by: Steven Rostedt"
> v3->v4: Add the Tested-by label
> v4->v5: Add "Reviewed-by: Dhruva Gole"
>
> Hopefully this patch gets attention from maintainers of
> drivers/cpuidle/cpuidle-psci.c too.

Lorenzo, Sudeep, Ulf, any comments?

>  drivers/cpuidle/cpuidle-psci.c |  3 +++
>  include/trace/events/power.h   | 37 ++++++++++++++++++++++++++++++++++
>  2 files changed, 40 insertions(+)
>
> diff --git a/drivers/cpuidle/cpuidle-psci.c b/drivers/cpuidle/cpuidle-psc=
i.c
> index 2562dc001fc1..dd8d776d6e39 100644
> --- a/drivers/cpuidle/cpuidle-psci.c
> +++ b/drivers/cpuidle/cpuidle-psci.c
> @@ -25,6 +25,7 @@
>  #include <linux/syscore_ops.h>
>
>  #include <asm/cpuidle.h>
> +#include <trace/events/power.h>
>
>  #include "cpuidle-psci.h"
>  #include "dt_idle_states.h"
> @@ -74,7 +75,9 @@ static __cpuidle int __psci_enter_domain_idle_state(str=
uct cpuidle_device *dev,
>         if (!state)
>                 state =3D states[idx];
>
> +       trace_psci_domain_idle_enter(dev->cpu, state, s2idle);
>         ret =3D psci_cpu_suspend_enter(state) ? -1 : idx;
> +       trace_psci_domain_idle_exit(dev->cpu, state, s2idle);
>
>         if (s2idle)
>                 dev_pm_genpd_resume(pd_dev);
> diff --git a/include/trace/events/power.h b/include/trace/events/power.h
> index d2349b6b531a..9253e83b9bb4 100644
> --- a/include/trace/events/power.h
> +++ b/include/trace/events/power.h
> @@ -62,6 +62,43 @@ TRACE_EVENT(cpu_idle_miss,
>                 (unsigned long)__entry->state, (__entry->below)?"below":"=
above")
>  );
>
> +DECLARE_EVENT_CLASS(psci_domain_idle,
> +
> +       TP_PROTO(unsigned int cpu_id, unsigned int state, bool s2idle),
> +
> +       TP_ARGS(cpu_id, state, s2idle),
> +
> +       TP_STRUCT__entry(
> +               __field(u32,            cpu_id)
> +               __field(u32,            state)
> +               __field(bool,           s2idle)
> +       ),
> +
> +       TP_fast_assign(
> +               __entry->cpu_id =3D cpu_id;
> +               __entry->state =3D state;
> +               __entry->s2idle =3D s2idle;
> +       ),
> +
> +       TP_printk("cpu_id=3D%lu state=3D0x%lx is_s2idle=3D%s",
> +                 (unsigned long)__entry->cpu_id, (unsigned long)__entry-=
>state,
> +                 (__entry->s2idle)?"yes":"no")
> +);
> +
> +DEFINE_EVENT(psci_domain_idle, psci_domain_idle_enter,
> +
> +       TP_PROTO(unsigned int cpu_id, unsigned int state, bool s2idle),
> +
> +       TP_ARGS(cpu_id, state, s2idle)
> +);
> +
> +DEFINE_EVENT(psci_domain_idle, psci_domain_idle_exit,
> +
> +       TP_PROTO(unsigned int cpu_id, unsigned int state, bool s2idle),
> +
> +       TP_ARGS(cpu_id, state, s2idle)
> +);
> +
>  TRACE_EVENT(powernv_throttle,
>
>         TP_PROTO(int chip_id, const char *reason, int pmax),
>
> base-commit: ffd294d346d185b70e28b1a28abe367bbfe53c04
> --
> 2.48.1.362.g079036d154-goog

