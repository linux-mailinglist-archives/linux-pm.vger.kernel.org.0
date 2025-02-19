Return-Path: <linux-pm+bounces-22511-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A2231A3CB70
	for <lists+linux-pm@lfdr.de>; Wed, 19 Feb 2025 22:28:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 497227A5F1D
	for <lists+linux-pm@lfdr.de>; Wed, 19 Feb 2025 21:27:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5D4A257431;
	Wed, 19 Feb 2025 21:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U79KcDWr"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA8AE22E019;
	Wed, 19 Feb 2025 21:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740000478; cv=none; b=Qxv0D8493t7l7FxKx0Jqz2uog2udIS/EDBsSh0tBUAFyWHg9LDp9efCQPdAOlU0beIp47mqnhplVAQ9VtMAojkw8Zckpez/IrmO1mD8QDEcEIcCYxkq9HqFI7woNu4f+LPouu+BUBMV7dc9UMdoFjS4LWRK2cjfIM8hR80zYk1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740000478; c=relaxed/simple;
	bh=+SRVUUI/CLPjYoSRlwt+S9lIzhKegLOApCCjBNCkOp4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uxkGjdfpFQa6VgQk+P3yAE9kffUp6FG+fKVQ90Mjm2FyxAHtWWuve4/1N83FtZhNUoPsHzFrI43FIf9M4i6hxuNrR62swci2UJsDL67tHAMESALmtlB32Ge8atHhRZ2xmQ/yv3o5GjORlTXDtkpawv/Nvxljfa/yCtqCEhUVs2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U79KcDWr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EC91C4CEE0;
	Wed, 19 Feb 2025 21:27:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740000478;
	bh=+SRVUUI/CLPjYoSRlwt+S9lIzhKegLOApCCjBNCkOp4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=U79KcDWr1JlJzM2GIzr9cqRKknlocqgtkz3OWB83pxgliJufWQ+1+jA28gKPUXfAI
	 YB7tg32tzDhc3tGrib7jH0EbXDhDLDgCFvAnHBrxjekWQSSaHPiTkl1uH60ygX2kFK
	 wCz5RjB8qJXlPKTBLQTv8DoUN3+uL8Bd9X/q08bw2LhfemPTmGInxxqFU+hI7B5sNP
	 MLu+EjBVyXbrrzqO/pbyU0lwPQRx1XCRzaeHLHBA07ZBnKIXWO4twXl3us7xNUrije
	 Cd2D9TW1PsM6hGLmOngQO7kZUr939KkuSRUP8WMaE/Oo92CbHN9MzqbMIIOPRHl94K
	 d+p4+7nRnloVQ==
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-3f410c67037so180459b6e.0;
        Wed, 19 Feb 2025 13:27:58 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUdDcz5yTm1tVUa5HMEamybVLQ0Uq1Azzx/7bV7b00nOqzaYv6F460fOt8iRiCJN7w4TNXwGRiSBHk=@vger.kernel.org, AJvYcCX/tMqFILusuKB3MOm6nfe75+5zb2L3dKOYfnzjqBnCIPWwPXB406fE27CYa1bpWeFNRwldCntFmvCF41zl@vger.kernel.org
X-Gm-Message-State: AOJu0YzQ6OgcHdTk3T26xVcMjhL6hgCr+wbpCWbPVwkZuBaLO6hf6/2b
	ooE8y9P9Yq5xbww+ovBNIpsj0Pn2vpSeP57b5XJrnXj2KgST1LtVQ2L8lO59QnfKi/5BvIkYFQ0
	aB0sS9+O3iETVKS72Rop7qqezB9w=
X-Google-Smtp-Source: AGHT+IG6cr0hEWjXUQhqAK1qz5c7apM9oCnTnsKn/H5xMI3lWq47QIxtmlT516PEoKzSiePVRD9dBx5dno1gQC8rvc0=
X-Received: by 2002:a05:6808:358a:b0:3f3:fc36:25b7 with SMTP id
 5614622812f47-3f419f896e7mr499390b6e.19.1740000477482; Wed, 19 Feb 2025
 13:27:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250128141139.2033088-1-darcari@redhat.com> <20250213160741.445351-1-darcari@redhat.com>
In-Reply-To: <20250213160741.445351-1-darcari@redhat.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 19 Feb 2025 22:27:46 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0gUfp+ueLMr1arwgK0r3WAQmfbb7YB54oZP-ySkD0q6YQ@mail.gmail.com>
X-Gm-Features: AWEUYZlsh_nh2T1mVOcQQwWbniiICYszafnHJEmUZbHWeCh7PAz-uqb-W87C0vs
Message-ID: <CAJZ5v0gUfp+ueLMr1arwgK0r3WAQmfbb7YB54oZP-ySkD0q6YQ@mail.gmail.com>
Subject: Re: [PATCH v4] intel_idle: introduce 'no_native' module parameter
To: David Arcari <darcari@redhat.com>
Cc: linux-pm@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, Len Brown <lenb@kernel.org>, 
	Artem Bityutskiy <dedekind1@gmail.com>, Prarit Bhargava <prarit@redhat.com>, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 13, 2025 at 5:07=E2=80=AFPM David Arcari <darcari@redhat.com> w=
rote:
>
> Since commit 18734958e9bf ("intel_idle: Use ACPI _CST for processor model=
s
> without C-state tables") the intel_idle driver has had the ability to use
> the ACPI _CST to populate C-states when the processor model is not
> recognized. However, even when the processor model is recognized (native
> mode) there are cases where it is useful to make the driver ignore the pe=
r
> cpu idle states in lieu of ACPI C-states (such as specific application
> performance). Add the 'no_native' module parameter to provide this
> functionality.
>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
> Cc: Len Brown <lenb@kernel.org>
> Cc: David Arcari <darcari@redhat.com>
> Cc: Artem Bityutskiy <dedekind1@gmail.com>
> Cc: Prarit Bhargava <prarit@redhat.com>
> Cc: linux-doc@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: David Arcari <darcari@redhat.com>
> ---
> v4: fix !CONFIG_ACPI_PROCESSOR_CSTATE compilation issue
> v3: more documentation cleanup
> v2: renamed parameter, cleaned up documentation
>
> Documentation/admin-guide/pm/intel_idle.rst | 18 +++++++++++++-----
>  drivers/idle/intel_idle.c                   | 16 ++++++++++++++++
>  2 files changed, 29 insertions(+), 5 deletions(-)
>
> diff --git a/Documentation/admin-guide/pm/intel_idle.rst b/Documentation/=
admin-guide/pm/intel_idle.rst
> index 39bd6ecce7de..5940528146eb 100644
> --- a/Documentation/admin-guide/pm/intel_idle.rst
> +++ b/Documentation/admin-guide/pm/intel_idle.rst
> @@ -192,11 +192,19 @@ even if they have been enumerated (see :ref:`cpu-pm=
-qos` in
>  Documentation/admin-guide/pm/cpuidle.rst).
>  Setting ``max_cstate`` to 0 causes the ``intel_idle`` initialization to =
fail.
>
> -The ``no_acpi`` and ``use_acpi`` module parameters (recognized by ``inte=
l_idle``
> -if the kernel has been configured with ACPI support) can be set to make =
the
> -driver ignore the system's ACPI tables entirely or use them for all of t=
he
> -recognized processor models, respectively (they both are unset by defaul=
t and
> -``use_acpi`` has no effect if ``no_acpi`` is set).
> +The ``no_acpi``, ``use_acpi`` and ``no_native`` module parameters are
> +recognized by ``intel_idle`` if the kernel has been configured with ACPI
> +support.  In the case that ACPI is not configured these flags have no im=
pact
> +on functionality.
> +
> +``no_acpi`` - Do not use ACPI at all.  Only native mode is available, no
> +ACPI mode.
> +
> +``use_acpi`` - No-op in ACPI mode, the driver will consult ACPI tables f=
or
> +C-states on/off status in native mode.
> +
> +``no_native`` - Work only in ACPI mode, no native mode available (ignore
> +all custom tables).
>
>  The value of the ``states_off`` module parameter (0 by default) represen=
ts a
>  list of idle states to be disabled by default in the form of a bitmask.
> diff --git a/drivers/idle/intel_idle.c b/drivers/idle/intel_idle.c
> index 118fe1d37c22..b0be5ef43ffc 100644
> --- a/drivers/idle/intel_idle.c
> +++ b/drivers/idle/intel_idle.c
> @@ -1695,6 +1695,10 @@ static bool force_use_acpi __read_mostly; /* No ef=
fect if no_acpi is set. */
>  module_param_named(use_acpi, force_use_acpi, bool, 0444);
>  MODULE_PARM_DESC(use_acpi, "Use ACPI _CST for building the idle states l=
ist");
>
> +static bool no_native __read_mostly; /* No effect if no_acpi is set. */
> +module_param_named(no_native, no_native, bool, 0444);
> +MODULE_PARM_DESC(no_native, "Ignore cpu specific (native) idle states in=
 lieu of ACPI idle states");
> +
>  static struct acpi_processor_power acpi_state_table __initdata;
>
>  /**
> @@ -1834,6 +1838,11 @@ static bool __init intel_idle_off_by_default(unsig=
ned int flags, u32 mwait_hint)
>         }
>         return true;
>  }
> +
> +static inline bool ignore_native(void)
> +{
> +       return no_native & !no_acpi;
> +}
>  #else /* !CONFIG_ACPI_PROCESSOR_CSTATE */
>  #define force_use_acpi (false)
>
> @@ -1843,6 +1852,7 @@ static inline bool intel_idle_off_by_default(unsign=
ed int flags, u32 mwait_hint)
>  {
>         return false;
>  }
> +static inline bool ignore_native(void) { return false; }
>  #endif /* !CONFIG_ACPI_PROCESSOR_CSTATE */
>
>  /**
> @@ -2328,6 +2338,12 @@ static int __init intel_idle_init(void)
>         pr_debug("MWAIT substates: 0x%x\n", mwait_substates);
>
>         icpu =3D (const struct idle_cpu *)id->driver_data;
> +       if (ignore_native()) {
> +               if (icpu) {
> +                       pr_debug("ignoring native cpu idle states\n");
> +                       icpu =3D NULL;
> +               }
> +       }

Why not

+       if (icpu && ignore_native()) {
+              pr_debug("disregarding built-in CPU idle states table\n");
+              icpu =3D NULL;
+       }

>         if (icpu) {
>                 if (icpu->state_table)
>                         cpuidle_state_table =3D icpu->state_table;
> --

