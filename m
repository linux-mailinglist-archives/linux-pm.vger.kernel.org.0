Return-Path: <linux-pm+bounces-22579-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 77A32A3E584
	for <lists+linux-pm@lfdr.de>; Thu, 20 Feb 2025 21:03:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D5571899955
	for <lists+linux-pm@lfdr.de>; Thu, 20 Feb 2025 20:03:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BAF6264602;
	Thu, 20 Feb 2025 20:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Edi3n9/F"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C93E264606;
	Thu, 20 Feb 2025 20:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740081762; cv=none; b=TdDrJfJMU62q2IrClhOuct8GS6ErvKiPBsVv6M1oNqj0KQGvJFxv97LuMeIdsm5Zgnxw5zSZuBJNbaFt2aNq/PWxyCWyt29n6MFGTyipePQTpEHaBfFRmcT5yEcdkZFhY6EIP1sAk4w2rBogwuVY4rPA7V0/zBtgRN4RGiyZetI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740081762; c=relaxed/simple;
	bh=MEtRL1Z7JIGfjc9N5PY4VR2QlXBUQPig7OqiInxSM14=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lfsLiWzV2PbfJbE2bm5pGDY95EiLTUfiSbgLGDMbA7MtZ9ij33TsS0eAP0V+/E89eyjlJXNUPQuL2bsYkQ6j/8wxy1H8D061WpTZpqyzsxeUi7V1lP+hVUDctHgEUHwAxQpbc5hVaaqy3fOOLPo6Ynf372RiUEOeWFt5TWayRmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Edi3n9/F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7ABFC4CEE4;
	Thu, 20 Feb 2025 20:02:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740081761;
	bh=MEtRL1Z7JIGfjc9N5PY4VR2QlXBUQPig7OqiInxSM14=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Edi3n9/F5Sqmer9A9JH5DnvCNDuFrfmbH/avLGcrUT3bS/m2dGYhL2lokuu7tRX/9
	 R5p/w/g4NujlW6gR9iYkNjB4dmSc66LFQ1kS8FAyZj2CasEr4pwlccRHWHy/uWBfQb
	 d1PUN+bvOtDwZPbVMkBHUNT0evMAKDX1go7pJKZ+6M7uO1O0t31toSmoBRKlJVuJmS
	 rlDWIPt2OysYsTClolKBTWuIFb6yNUm3Vx879ACNHLXb71oqD2wQ7oOcfbiPOZL4Db
	 X28hOzgQ1Hd3+GmYBjxTTw5VE5oykgjruoXVOWROHtGaPU4yuZWxwoJ6fQNBeZNZk9
	 jZUfAn8XaLnWA==
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-3f3edbef7d2so412837b6e.2;
        Thu, 20 Feb 2025 12:02:41 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUgN5/tzukbfehzOlE8dVkYdX/Eu299HdgsZSpzyIKggeVxRpa4MJxyA3lgDIH7r+5qzhX9zsJYbn7y5hJ/@vger.kernel.org, AJvYcCXgzOIH6iQ6JH1Gos2xnyz2pi+H1E+AGr/9LA9qS0vPgIUJ6e9kzO32YXldm1uhC5tqlhWGzxe9aqk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWKJoDxKd0bjf+9Q2GJjl9JI/FkskbP9BMtzFKcQD7iL8wMeue
	cyLYC0tiB7AzNaZB1haD9QpidmN1KjWLFgzAOyI+3ygZekaS1E4An7cih2GmOsWnRnp4zlKNbPz
	ralSvjAfaQblYtFUf25lOb8b5atQ=
X-Google-Smtp-Source: AGHT+IFd4ofgG10nIb4ge4yUIS0Xn3TLKVX9zmKZXE2NDkUTJnyKOJOVT28x87WH+SooSDrKqsftlDw5K0GunUHcBzg=
X-Received: by 2002:a05:6808:229e:b0:3f3:ff78:e5e4 with SMTP id
 5614622812f47-3f4247c1ed5mr561834b6e.38.1740081761081; Thu, 20 Feb 2025
 12:02:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250128141139.2033088-1-darcari@redhat.com> <20250220151120.1131122-1-darcari@redhat.com>
In-Reply-To: <20250220151120.1131122-1-darcari@redhat.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 20 Feb 2025 21:02:28 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0jjoZq+cm=jHOJ4hPhXKK5iSRCrpCYh80-6FhdSjYPMUA@mail.gmail.com>
X-Gm-Features: AWEUYZlnhgw-RkABbxhcGjKUkKJcNFucHCdfxJqeWCJjzmq85_pPtsemizOpRz4
Message-ID: <CAJZ5v0jjoZq+cm=jHOJ4hPhXKK5iSRCrpCYh80-6FhdSjYPMUA@mail.gmail.com>
Subject: Re: [PATCH v5] intel_idle: introduce 'no_native' module parameter
To: David Arcari <darcari@redhat.com>
Cc: linux-pm@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, 
	Jacob Pan <jacob.jun.pan@linux.intel.com>, Len Brown <lenb@kernel.org>, 
	Artem Bityutskiy <dedekind1@gmail.com>, Prarit Bhargava <prarit@redhat.com>, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 20, 2025 at 4:11=E2=80=AFPM David Arcari <darcari@redhat.com> w=
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
> v5: if statement simplication, also add missing '&' to ignore_native()
> v4: fix !CONFIG_ACPI_PROCESSOR_CSTATE compilation issue
> v3: more documentation cleanup
> v2: renamed parameter, cleaned up documentation
>
>  Documentation/admin-guide/pm/intel_idle.rst | 18 +++++++++++++-----
>  drivers/idle/intel_idle.c                   | 14 ++++++++++++++
>  2 files changed, 27 insertions(+), 5 deletions(-)
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
> index 118fe1d37c22..d0b23ea03e6f 100644
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
> +       return no_native && !no_acpi;
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
> @@ -2328,6 +2338,10 @@ static int __init intel_idle_init(void)
>         pr_debug("MWAIT substates: 0x%x\n", mwait_substates);
>
>         icpu =3D (const struct idle_cpu *)id->driver_data;
> +       if (icpu && ignore_native()) {
> +               pr_debug("ignoring native cpu idle states\n");
> +               icpu =3D NULL;
> +       }
>         if (icpu) {
>                 if (icpu->state_table)
>                         cpuidle_state_table =3D icpu->state_table;
> --

Applied as 6.15 material, thanks!

