Return-Path: <linux-pm+bounces-40400-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8852ECFFF9F
	for <lists+linux-pm@lfdr.de>; Wed, 07 Jan 2026 21:19:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 44A493041A7F
	for <lists+linux-pm@lfdr.de>; Wed,  7 Jan 2026 20:14:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7C5F2C0261;
	Wed,  7 Jan 2026 20:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kJ1H2EL6"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D45F1DDC07
	for <linux-pm@vger.kernel.org>; Wed,  7 Jan 2026 20:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767816873; cv=none; b=epqEMdx2rMHgkuMTZ2O0b2CLnz5O4b8F2EAzbLCEnYocVNBtkLCNd1hZ28k9XWnEql41SdcVuur1Iz0drh4kKBIMgHZNf8nuxmz1r1fSaCuMAkC9XYGEm9v93SCWkBgyl4yUgMOsMomE6u1zE6vzwnG3yC8himDR9leIld5pii8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767816873; c=relaxed/simple;
	bh=616YS/zYzQmMQO1Mv+8l/p3n7zTTr5cG2YIPfptK/H0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WBINjSzOZEx/pcPBzavonS1DQL5oIuXlMnt1TyOP7YGs7rxVXsTt7ePjqcaUYyGczFcRTsTpQ3vx/RrEMpjBfCsSj1xrbcl51NuFxiNir2TJEI+WVVdnp3p5FkFnnNU8fDB681HUY850CD454wOQU8bxNluOt9AkxiLX6MhFGdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kJ1H2EL6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F324C4CEF1
	for <linux-pm@vger.kernel.org>; Wed,  7 Jan 2026 20:14:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767816872;
	bh=616YS/zYzQmMQO1Mv+8l/p3n7zTTr5cG2YIPfptK/H0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=kJ1H2EL6VBs08eyulXWdeCQWo28y+IoDZt9lSIjQjTomiLsR7QdlNUMWucrgP6UrJ
	 LYfW60BRQKwcSQ1khV5ItpxuY1E0kbbawyeoRGGAzK9RAMidcciG01dRyMHWjKxEJT
	 2CwUgkqZ8HXTtCOtQv8zPMqAKR97I/IdE5mnVnWkHi4FIYDJeRxtXfSTFw+Ga8i2cE
	 NX8J0lL0BEyOHt+NXuavM32q+pO8sRR7jNcgNqofaLjyGY7U/Fon+TRYg38pSZInZR
	 KjUTlciIk5DLojvM2XsQtaXe28VjFHtC99KJ4LttWNM07cCQiwKqGekP6lGaD7am+W
	 HfrzadByrDjZA==
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-3f11ad6e76fso2002690fac.1
        for <linux-pm@vger.kernel.org>; Wed, 07 Jan 2026 12:14:32 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWCFaUU0edt96pgHt1C52Y69hQWX/EnHQ68kGl+MbLyjiUgUPhswmKbH8whQWbzm9L9L9vb9590Sg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwW/nCMnijH0OyHAhdP5k812h81xTPuEFqdoN2c4BGdDdoMBYBp
	sxQYPWENPRgCG+0XVBPpO3DzjuhwxA+tbPfOuTQudm0QAkdQDT7tTeZBBApa7i7mZ1/MsryfPPO
	yGBqbxgsYCM6eO47LOCh/beNUEg0dNTQ=
X-Google-Smtp-Source: AGHT+IH7MkROqrDl/hjAwI5bmcMJN9rhSeR7gWG0w2LS2bh7Uo7uvHfa1A75Igf2G/Mpvfjlv0NpTwLplDJ1ex9spnw=
X-Received: by 2002:a05:6820:1501:b0:659:9a49:907d with SMTP id
 006d021491bc7-65f550799afmr1500400eaf.72.1767816871563; Wed, 07 Jan 2026
 12:14:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251215111300.132803-1-dedekind1@gmail.com>
In-Reply-To: <20251215111300.132803-1-dedekind1@gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 7 Jan 2026 21:14:20 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0h68VCkpY5654UGGK899zH38CeFV-Ji9JqMpuC-hq8qoQ@mail.gmail.com>
X-Gm-Features: AQt7F2rubCpcrMwv-bl0RNxByHGkXCWgJSlbchUDxqZ9P9zaUMh7en0zKN_MPZ0
Message-ID: <CAJZ5v0h68VCkpY5654UGGK899zH38CeFV-Ji9JqMpuC-hq8qoQ@mail.gmail.com>
Subject: Re: [PATCH resend 1] intel_idle: Remove the 'preferred_cstates' parameter
To: Artem Bityutskiy <dedekind1@gmail.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Linux PM Mailing List <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 15, 2025 at 12:13=E2=80=AFPM Artem Bityutskiy <dedekind1@gmail.=
com> wrote:
>
> From: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
>
> Remove the 'preferred_cstates' module parameter as it is not really usefu=
l.
>
> The parameter currently only affects Alder Lake, where it controls C1/C1E
> preference, with C1E being the default. The parameter does not support an=
y
> other platform. For example, Meteor Lake has a similar C1/C1E limitation,
> but the parameter does not support Meteor Lake. This indicates that the
> parameter is not very useful.
>
> Generally, independent C1 and C1E are important for server platforms wher=
e
> low latency is key. However, they are not as important for client platfor=
ms,
> like Alder Lake, where C1E providing better energy savings is generally
> preferred.
>
> The parameter was originally introduced for Sapphire Rapids Xeon:
> da0e58c038e6 intel_idle: add 'preferred_cstates' module argument
>
> Later it was added to Alder Lake:
> d1cf8bbfed1ed ("intel_idle: Add AlderLake support")
>
> But it was removed from Sapphire Rapids when firmware fixed the C1/C1E
> limitation:
> 1548fac47a114 ("intel_idle: make SPR C1 and C1E be independent")
>
> So Alder Lake is the only platform left where this parameter has any effe=
ct.
> Remove this parameter to simplify the driver and reduce maintenance burde=
n.
>
> Signed-off-by: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
> ---
>  drivers/idle/intel_idle.c | 36 ------------------------------------
>  1 file changed, 36 deletions(-)
>
> Re-sending, for some reason the first submission did not arrive to the li=
nux-pm
> mailing list, I cannot find it in the archives.
>
> diff --git a/drivers/idle/intel_idle.c b/drivers/idle/intel_idle.c
> index aa44b3c2cb2c4..2d67a091ed3f0 100644
> --- a/drivers/idle/intel_idle.c
> +++ b/drivers/idle/intel_idle.c
> @@ -70,7 +70,6 @@ static struct cpuidle_driver intel_idle_driver =3D {
>  /* intel_idle.max_cstate=3D0 disables driver */
>  static int max_cstate =3D CPUIDLE_STATE_MAX - 1;
>  static unsigned int disabled_states_mask __read_mostly;
> -static unsigned int preferred_states_mask __read_mostly;
>  static bool force_irq_on __read_mostly;
>  static bool ibrs_off __read_mostly;
>
> @@ -2049,25 +2048,6 @@ static void __init skx_idle_state_table_update(voi=
d)
>         }
>  }
>
> -/**
> - * adl_idle_state_table_update - Adjust AlderLake idle states table.
> - */
> -static void __init adl_idle_state_table_update(void)
> -{
> -       /* Check if user prefers C1 over C1E. */
> -       if (preferred_states_mask & BIT(1) && !(preferred_states_mask & B=
IT(2))) {
> -               cpuidle_state_table[0].flags &=3D ~CPUIDLE_FLAG_UNUSABLE;
> -               cpuidle_state_table[1].flags |=3D CPUIDLE_FLAG_UNUSABLE;
> -
> -               /* Disable C1E by clearing the "C1E promotion" bit. */
> -               c1e_promotion =3D C1E_PROMOTION_DISABLE;
> -               return;
> -       }
> -
> -       /* Make sure C1E is enabled by default */
> -       c1e_promotion =3D C1E_PROMOTION_ENABLE;
> -}
> -
>  /**
>   * spr_idle_state_table_update - Adjust Sapphire Rapids idle states tabl=
e.
>   */
> @@ -2174,11 +2154,6 @@ static void __init intel_idle_init_cstates_icpu(st=
ruct cpuidle_driver *drv)
>         case INTEL_EMERALDRAPIDS_X:
>                 spr_idle_state_table_update();
>                 break;
> -       case INTEL_ALDERLAKE:
> -       case INTEL_ALDERLAKE_L:
> -       case INTEL_ATOM_GRACEMONT:
> -               adl_idle_state_table_update();
> -               break;
>         case INTEL_ATOM_SILVERMONT:
>         case INTEL_ATOM_AIRMONT:
>                 byt_cht_auto_demotion_disable();
> @@ -2532,17 +2507,6 @@ module_param(max_cstate, int, 0444);
>   */
>  module_param_named(states_off, disabled_states_mask, uint, 0444);
>  MODULE_PARM_DESC(states_off, "Mask of disabled idle states");
> -/*
> - * Some platforms come with mutually exclusive C-states, so that if one =
is
> - * enabled, the other C-states must not be used. Example: C1 and C1E on
> - * Sapphire Rapids platform. This parameter allows for selecting the
> - * preferred C-states among the groups of mutually exclusive C-states - =
the
> - * selected C-states will be registered, the other C-states from the mut=
ually
> - * exclusive group won't be registered. If the platform has no mutually
> - * exclusive C-states, this parameter has no effect.
> - */
> -module_param_named(preferred_cstates, preferred_states_mask, uint, 0444)=
;
> -MODULE_PARM_DESC(preferred_cstates, "Mask of preferred idle states");
>  /*
>   * Debugging option that forces the driver to enter all C-states with
>   * interrupts enabled. Does not apply to C-states with
> --

Applied as 6.20 material, thanks!

