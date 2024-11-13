Return-Path: <linux-pm+bounces-17518-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D1099C7C18
	for <lists+linux-pm@lfdr.de>; Wed, 13 Nov 2024 20:23:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A15C1F23604
	for <lists+linux-pm@lfdr.de>; Wed, 13 Nov 2024 19:23:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F738203712;
	Wed, 13 Nov 2024 19:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qNgG3jZP"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF023202F66
	for <linux-pm@vger.kernel.org>; Wed, 13 Nov 2024 19:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731525816; cv=none; b=jHD5vEgOLD7L2tcH1CjkxqMYH+gwIvRmu7hM0e4m+iry3PWxM4VjqoiWdhRnlwvaqSWt+ZXnmO5FaCV8DEAym0/evPzdgidNZn14LE4Qzg4rMfu6KxCQ3SMOvSB+Y09jJi4GJiGdUFORVP+V1/ij+VEMYQDwZiTIwpyGCu2j1VY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731525816; c=relaxed/simple;
	bh=7k7aORf62/3YSYFCw04e/4vDIhM/3DlLGpu48A5E0vk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FTtwXsoAKCrc5KT30BsPTE9R8NPqZi0uDRL0CeCC2dFwTFWKxJ9ZnkSqf06jTiUfEQ/XAto57y9aKWgI0n5GgoQfwO1k+Sx0VA3c+jnvdbhb+/pFmVIwF2jjdd3pModU8fMNTQYDZjRAATfFhoUBbthpyCalSxyVf0NBXuF4LbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qNgG3jZP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BBB3C4CEC3
	for <linux-pm@vger.kernel.org>; Wed, 13 Nov 2024 19:23:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731525815;
	bh=7k7aORf62/3YSYFCw04e/4vDIhM/3DlLGpu48A5E0vk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=qNgG3jZPZ7URzli52QeftJ2FU1iLvbblKVLVvfbMzLgB20aJKG1mZmX2c3155wgaN
	 pCe3qoaP4tgM3x2IqpL7fQrJt71xmlXab8etgjhIiT6Ogz/AEKzOzE2znf63Yc4+Lz
	 6V582ILUlU9/4grRCmGumxJ9fZBQUfsCJepFbg99+s/2pGOWELIQRa/mfsvcywWa0Q
	 XrgtUVExCv+JO5NRFGNIgmPQmij3L6tqXygNgwoS7fglAUUMywQaOEvurP5H+C8jnP
	 JB3V5eEahO98ARUUESxvkNdr0otVoYZltwVSEVZeqP/8JZHcgRr10B6XAqsMStbbES
	 i0Hx0Qk+Sk16g==
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-3e602994635so4772841b6e.0
        for <linux-pm@vger.kernel.org>; Wed, 13 Nov 2024 11:23:35 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUCNgItgJeVgbqNb6COcJI+he9zlzW8BfG7h/anKZCEjsVKgSmb3vTTwk+Q10+TzYvDDX+RzorV9A==@vger.kernel.org
X-Gm-Message-State: AOJu0YxC2Iejl1N8//VGuFeZgq1sKDaF85Om5dS9EycDnj9iYOEgg03i
	jRbV4QkZjovC1NndfcLrilxGN2IK/hd0jJUSq1AQ7nu2okXMKF42aIgnf9z+gBvhN1TlQhSGoSU
	IRR5QpJF+9atpWn0KC0sH5jT+/Ek=
X-Google-Smtp-Source: AGHT+IHAaPw+Bw4FMlLx7q44B+dqbMETSs84aly9R2rIKqE2jwU1uHv1OKVTmcDBwrGiHnZjdQWtXBTysI7yCxor7TU=
X-Received: by 2002:a05:6808:2117:b0:3e6:2471:4d10 with SMTP id
 5614622812f47-3e7b0a7df68mr3901524b6e.11.1731525814673; Wed, 13 Nov 2024
 11:23:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <7e3092234617e8479d3020e5fed7ff47ac750014.1731522552.git.len.brown@intel.com>
In-Reply-To: <7e3092234617e8479d3020e5fed7ff47ac750014.1731522552.git.len.brown@intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 13 Nov 2024 20:23:23 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0gTPoH3hwR2yyi2uLdX_-ykwaEyyRSAxz2omG34PzGQEA@mail.gmail.com>
Message-ID: <CAJZ5v0gTPoH3hwR2yyi2uLdX_-ykwaEyyRSAxz2omG34PzGQEA@mail.gmail.com>
Subject: Re: [RFC/RFT PATCH] PM: sleep: Ignore device driver suspend()
 callback return values
To: Len Brown <lenb@kernel.org>
Cc: rafael@kernel.org, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 13, 2024 at 7:35=E2=80=AFPM Len Brown <lenb@kernel.org> wrote:
>
> From: Len Brown <len.brown@intel.com>
>
> Drivers commonly return non-zero values from their suspend()
> callbacks due to transient errors, not realizing that doing so
> aborts system-wide suspend.
>
> Ignore those return values.
>
> Both before and after this patch, the correct method for a
> device driver to abort system-wide suspend is to invoke
> pm_system_wakeup() during the suspend flow.
>
> Legacy behaviour can be restored by adding this line to your .config:
> CONFIG_PM_SLEEP_LEGACY_CALLBACK_ABORT=3Dy
>
> Signed-off-by: Len Brown <len.brown@intel.com>
> ---
>  drivers/base/power/main.c |  4 ++++
>  kernel/power/Kconfig      | 14 ++++++++++++++
>  2 files changed, 18 insertions(+)
>
> diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
> index 4a67e83300e1..56b7c9c752b4 100644
> --- a/drivers/base/power/main.c
> +++ b/drivers/base/power/main.c
> @@ -1678,7 +1678,11 @@ static int device_suspend(struct device *dev, pm_m=
essage_t state, bool async)
>                 callback =3D pm_op(dev->driver->pm, state);
>         }
>
> +#if CONFIG_PM_SLEEP_LEGACY_CALLBACK_ABORT
>         error =3D dpm_run_callback(callback, dev, state, info);
> +#else
> +       dpm_run_callback(callback, dev, state, info);
> +#endif
>
>   End:
>         if (!error) {

I would prefer something like:

    error =3D dpm_run_callback(callback, dev, state, info);

 End:
    if (!IS_ENABLED(PM_SLEEP_LEGACY_CALLBACK_ABORT)
            error =3D 0;

    if (!error ) {
        dev->power.is_suspended =3D true;
        if (device_may_wakeup(dev))
            dev->power.wakeup_path =3D true;

        dpm_propagate_wakeup_to_parent(dev);
        dpm_clear_superiors_direct_complete(dev);
    }

and analogously in _noirq() and _late().

> diff --git a/kernel/power/Kconfig b/kernel/power/Kconfig
> index afce8130d8b9..51b5d6c9bf1a 100644
> --- a/kernel/power/Kconfig
> +++ b/kernel/power/Kconfig
> @@ -141,6 +141,20 @@ config PM_SLEEP
>         depends on SUSPEND || HIBERNATE_CALLBACKS
>         select PM
>
> +config PM_SLEEP_LEGACY_CALLBACK_ABORT
> +       def_bool n

This isn't needed.

> +       depends on PM_SLEEP
> +       help
> +       This option enables the legacy API for device .suspend() callback=
s.
> +       That API empowered any driver to abort system-wide suspend
> +       by returning any non-zero value from its .suspend() callback.
> +       In practice, these aborts are almost always spurious and unwanted=
.
> +
> +       Disabling this option (default) ignores .suspend() callback retur=
n values.
> +
> +       In both cases, any driver can abort system wide suspend by invoki=
ng
> +       pm_system_wakeup() during the suspend flow.
> +
>  config PM_SLEEP_SMP
>         def_bool y
>         depends on SMP
> --

It would be good to update the PM documentation too to take this new
option into account.

