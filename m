Return-Path: <linux-pm+bounces-22344-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86C99A3A831
	for <lists+linux-pm@lfdr.de>; Tue, 18 Feb 2025 20:57:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B8671668BB
	for <lists+linux-pm@lfdr.de>; Tue, 18 Feb 2025 19:57:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EF0B1EB5F1;
	Tue, 18 Feb 2025 19:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PYBBKsxT"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43F891EB5CA;
	Tue, 18 Feb 2025 19:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739908672; cv=none; b=q/6Z4vxGtvTVrL9LxoxJRwTiKp1zBoeGgwIUhZwEEwgm6SMoLTP08/UkyjFiJk1lSUgMiyHaQHqZkcLCWTwjKBMLIWb/l04hq2Fso5YRXvj5G0V9xAVvZmjhzaVDvwqgTqvtDtltO8B4FsgCR+XSmWo6YJCX0ETZqRjhLyHSNec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739908672; c=relaxed/simple;
	bh=NdOg0UvtyHWKWW084SqAvljhOyOWRFlP2AMh8KCGNoQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hTAqjHoSKFeZlcwoPGNspwNrkU9VmBVDUd/8HlzT8tXNxtO0SqWjrhXgHExQykVnt0l4JW38XU3K9I0I1/z103iGtZwsupUwbGk7s0KCpy2SG88fuR0DsnXYbqwZ69SoQYKC6FKDxBNSzo7M1wHQt69G4HO01VygbKnfGcvYEVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PYBBKsxT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFFA7C4CEE8;
	Tue, 18 Feb 2025 19:57:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739908671;
	bh=NdOg0UvtyHWKWW084SqAvljhOyOWRFlP2AMh8KCGNoQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=PYBBKsxTn04vfOuRBwwdNeTfYiKdx5HHotfiprRS/CAgz/anhk5cQrAhSfpEHPP8A
	 P+5Xn/8r9oUSYb+ZfEjuucsVZD9QVMvaL1R/y48CruxXvzhZkX+dRJ2VHMEIvTSh9f
	 u8l8Mvy+j+WVWeFdgEDcuc8JDmD17YNWy4gLQVZmj0aJhniWEcNpKnt73PHYt/HnHc
	 lHDBDvCbIYjAtFC5ELdHasMjVmBPMH1cta/xdzbF1lzYuGLctwCZM2/qDlrrUSm6fy
	 PexSJuARuHlSSw33KuvS95vA+zUIVeC1UvikbgQrgUtb33Th4e73vNe/WzqXedaaBX
	 xfi+S1EoWlg/A==
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-71e10e6a1ceso1768532a34.0;
        Tue, 18 Feb 2025 11:57:51 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUjysqafsG5f+P6ifFecBtBXspr8fKdMgi9A5yTu59w1HLcaHUZ6N2/VdqmhRFvO+8uRLhTH30H4L4=@vger.kernel.org, AJvYcCVwH0MizjJ6ihsRUhi/D4qq3IXQgzR/2BlQB7FxkARPDY+B4V4LdZwmthRpEAsF85mSZW73tN5pIMGzPMN5@vger.kernel.org
X-Gm-Message-State: AOJu0YzK0fyvQk5MuqU8bGpA7WSYUjKqy2JBl+mzk0B5fahpw5c3O8v/
	tvuS9Jiwcs1aJLIpiYV6Z7otGHoPwCAGfvYs0BY+f78epFWMd1Et/HWJQHOlkOcaIp5ueDKIc5P
	nQJqbfETKlH7qWFDMN0lHKGEm7RQ=
X-Google-Smtp-Source: AGHT+IGehTfwfgWTGlTqYmZ+2Zqn21Ck9f4vM9tehLAR4CXgcbyAmFYF8Ptk/fKaY/fx8HLNFpj4hS1T6r1FNiDq9+o=
X-Received: by 2002:a05:6808:1a25:b0:3f4:756:52cf with SMTP id
 5614622812f47-3f4075653f4mr4199404b6e.10.1739908671118; Tue, 18 Feb 2025
 11:57:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250128141139.2033088-1-darcari@redhat.com> <20250213160741.445351-1-darcari@redhat.com>
In-Reply-To: <20250213160741.445351-1-darcari@redhat.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 18 Feb 2025 20:57:38 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0g27Sutp_Ww7zGe0xB95kxFh-pzjd5-PpjR==h7-s8MLA@mail.gmail.com>
X-Gm-Features: AWEUYZlpai7SpXsNA6Zx29eRhmjHn54ScnowNhZR7EUXOxXW2VU5HrPEd_C27oA
Message-ID: <CAJZ5v0g27Sutp_Ww7zGe0xB95kxFh-pzjd5-PpjR==h7-s8MLA@mail.gmail.com>
Subject: Re: [PATCH v4] intel_idle: introduce 'no_native' module parameter
To: David Arcari <darcari@redhat.com>, Artem Bityutskiy <dedekind1@gmail.com>
Cc: linux-pm@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, 
	Jacob Pan <jacob.jun.pan@linux.intel.com>, Len Brown <lenb@kernel.org>, 
	Prarit Bhargava <prarit@redhat.com>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
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

Artem, have all of your comments been addressed in this version?

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
>         if (icpu) {
>                 if (icpu->state_table)
>                         cpuidle_state_table =3D icpu->state_table;
> --
> 2.48.1
>
>

