Return-Path: <linux-pm+bounces-22343-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 42AB5A3A829
	for <lists+linux-pm@lfdr.de>; Tue, 18 Feb 2025 20:56:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CDE3E3A2781
	for <lists+linux-pm@lfdr.de>; Tue, 18 Feb 2025 19:54:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26C0C1EB5C9;
	Tue, 18 Feb 2025 19:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DfDsVdID"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01C8D1E51F8
	for <linux-pm@vger.kernel.org>; Tue, 18 Feb 2025 19:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739908496; cv=none; b=LVqQXTZFlUSdfvUsfwovE/FYywVYIaVHWTyaIEHqA1CnV7sKJAnktURch1I1SitL/KyHDdVQmSwNebhSi2FiuorILWWZyFNnm6nYUYsyjnUQENxhwO1uk9S3bulQWZ8fI9Wzdtxyl0RaLrhLFGA5x71XHfa0veRvdoPF2Yz+6tc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739908496; c=relaxed/simple;
	bh=R1uIKJMZsiPQAfVHz7gqJLehbdFcr9jSQBjyzDikQ3E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hxCPIwupicpQEWyjiaXygWD5X3C6XRUsOO8NGevXhNtwpmP5OrKQXbeeuEX9NihzKzPmgg+Tz0UHwPFFj1yb62Tor99GQYwaXLzPuHUkZ+uJfH9yYmQrt0s8od+W631R89ZJ9Kv1gB/ktMM/3PZnUgHDwMeVJvkkYlUzFnb4n2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DfDsVdID; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73605C4CEE4
	for <linux-pm@vger.kernel.org>; Tue, 18 Feb 2025 19:54:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739908495;
	bh=R1uIKJMZsiPQAfVHz7gqJLehbdFcr9jSQBjyzDikQ3E=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=DfDsVdID6S6/NIuj7k/7g4l2V4Cb2evD6gSXzy4XzQpTUbycceVlWHSUowLS3XRpa
	 mrhw3NvRTKJQbrorwBLswbEZj92McjckWOw7nq9JWq571FcIqeyGtwL1ptYDEIuYos
	 /wcXXY2lsFLnKAlNgphJ38LgaTBNb0cvMxWPApUOo1YQkM7Hp6g/i5tpe1aGPuqsU0
	 U4GLAoXcGlq84RajNLuVOszsTkEB9fuKh3DqCs7GA3zKWV7f2IysHDgZ5aVkkYKOqb
	 z+IC3GGjrQt0B4x3Nz25R6ChW2kJNmlbrScdg5SFkzCWubWgg/7+lA1bYzsR4OFAd2
	 uP2APAixXlE/A==
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-2bc52407b78so2377928fac.0
        for <linux-pm@vger.kernel.org>; Tue, 18 Feb 2025 11:54:55 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUu2tk+AdT9rEq8eYDAefXdVci8L0TcvFoX9FK0c7MhnQ5RjDPmhy0N+QOCiPb+7YvzRmS+Js8IQg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzbvPvt8YlLp9CPEH3D5tFhHVdS8TTBp7MZ4W25hPVxbFntrJg1
	SIXXa8pzC9Q4AzNYw8jyNVLBKcEnRWyIGN98ow/bQCImRQ5i+2YCUS0qnZM+O7usK54teIx/lW9
	MRX6x8gVjpE28EecHQqU1EVVhsO4=
X-Google-Smtp-Source: AGHT+IGOKPMkAHXxyKnXA5n7IHzSwoLkF6LFXcLLbqUZyOaVjYIgiZ4qGP/2KP4xQMAI+3VJwimmCkmpgf+NCbHC9SU=
X-Received: by 2002:a05:6870:9a12:b0:29e:4bc4:97ca with SMTP id
 586e51a60fabf-2bc99b57ba3mr9627928fac.21.1739908494778; Tue, 18 Feb 2025
 11:54:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250210071253.2991030-1-dedekind1@gmail.com>
In-Reply-To: <20250210071253.2991030-1-dedekind1@gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 18 Feb 2025 20:54:43 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0hKQgqMbMKEMXSZFYo-y3k-7hBXqQftbMcY--H9VZaBtw@mail.gmail.com>
X-Gm-Features: AWEUYZmZNUhVFt-s4Knc0bV4MY3zJ8H2mS98Btue3QbuEE6sD50eIK6Q1acUrJc
Message-ID: <CAJZ5v0hKQgqMbMKEMXSZFYo-y3k-7hBXqQftbMcY--H9VZaBtw@mail.gmail.com>
Subject: Re: [PATCH] intel_idle: cleanup BYT/CHT auto demotion disable
To: Artem Bityutskiy <dedekind1@gmail.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Linux PM Mailing List <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 10, 2025 at 8:12=E2=80=AFAM Artem Bityutskiy <dedekind1@gmail.c=
om> wrote:
>
> From: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
>
> Bay Trail (BYT) and Cherry Trail (CHT) platforms have a very specific way
> of disabling auto-demotion via specific MSR bits. Clean up the code so th=
at
> BYT/CHT-specifics do not show up in the common 'struct idle_cpu' data
> structure.
>
> Remove the 'byt_auto_demotion_disable_flag' flag from 'struct idle_cpu',
> because a better coding pattern is to avoid very case-specific fields lik=
e
> 'bool byt_auto_demotion_disable_flag' in a common data structure, which i=
s
> used for all platforms, not only BYT/CHT. The code is just more readable
> when common data structures contain only commonly used fields.
>
> Instead, match BYT/CHT in the 'intel_idle_init_cstates_icpu()' function,
> and introduce a small helper to take care of BYT/CHT auto-demotion. This
> is consistent with how platform-specific things are done for other
> platforms.
>
> No intended functional changes, compile-tested only.
>
> Signed-off-by: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
> ---
>  drivers/idle/intel_idle.c | 21 +++++++++++++--------
>  1 file changed, 13 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/idle/intel_idle.c b/drivers/idle/intel_idle.c
> index 118fe1d37c22..324814dc34fa 100644
> --- a/drivers/idle/intel_idle.c
> +++ b/drivers/idle/intel_idle.c
> @@ -89,7 +89,6 @@ struct idle_cpu {
>          * Indicate which enable bits to clear here.
>          */
>         unsigned long auto_demotion_disable_flags;
> -       bool byt_auto_demotion_disable_flag;
>         bool disable_promotion_to_c1e;
>         bool use_acpi;
>  };
> @@ -1463,13 +1462,11 @@ static const struct idle_cpu idle_cpu_snx __initc=
onst =3D {
>  static const struct idle_cpu idle_cpu_byt __initconst =3D {
>         .state_table =3D byt_cstates,
>         .disable_promotion_to_c1e =3D true,
> -       .byt_auto_demotion_disable_flag =3D true,
>  };
>
>  static const struct idle_cpu idle_cpu_cht __initconst =3D {
>         .state_table =3D cht_cstates,
>         .disable_promotion_to_c1e =3D true,
> -       .byt_auto_demotion_disable_flag =3D true,
>  };
>
>  static const struct idle_cpu idle_cpu_ivb __initconst =3D {
> @@ -2055,6 +2052,15 @@ static void __init spr_idle_state_table_update(voi=
d)
>         }
>  }
>
> +/**
> + * byt_cht_auto_demotion_disable - Disable Bay/Cherry Trail auto-demotio=
n.
> + */
> +static void __init byt_cht_auto_demotion_disable(void)
> +{
> +       wrmsrl(MSR_CC6_DEMOTION_POLICY_CONFIG, 0);
> +       wrmsrl(MSR_MC6_DEMOTION_POLICY_CONFIG, 0);
> +}
> +
>  static bool __init intel_idle_verify_cstate(unsigned int mwait_hint)
>  {
>         unsigned int mwait_cstate =3D (MWAIT_HINT2CSTATE(mwait_hint) + 1)=
 &
> @@ -2136,6 +2142,10 @@ static void __init intel_idle_init_cstates_icpu(st=
ruct cpuidle_driver *drv)
>         case INTEL_ATOM_GRACEMONT:
>                 adl_idle_state_table_update();
>                 break;
> +       case INTEL_ATOM_SILVERMONT:
> +       case INTEL_ATOM_AIRMONT:
> +               byt_cht_auto_demotion_disable();
> +               break;
>         }
>
>         for (cstate =3D 0; cstate < CPUIDLE_STATE_MAX; ++cstate) {
> @@ -2178,11 +2188,6 @@ static void __init intel_idle_init_cstates_icpu(st=
ruct cpuidle_driver *drv)
>
>                 drv->state_count++;
>         }
> -
> -       if (icpu->byt_auto_demotion_disable_flag) {
> -               wrmsrl(MSR_CC6_DEMOTION_POLICY_CONFIG, 0);
> -               wrmsrl(MSR_MC6_DEMOTION_POLICY_CONFIG, 0);
> -       }
>  }
>
>  /**
> --

Applied as 6.15 material, thanks!

