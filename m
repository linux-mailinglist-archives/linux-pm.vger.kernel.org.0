Return-Path: <linux-pm+bounces-18060-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A1C939D865C
	for <lists+linux-pm@lfdr.de>; Mon, 25 Nov 2024 14:26:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 32C2E162E8E
	for <lists+linux-pm@lfdr.de>; Mon, 25 Nov 2024 13:26:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F7C31AAE17;
	Mon, 25 Nov 2024 13:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CRui7MIR"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 658D81A9B5D;
	Mon, 25 Nov 2024 13:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732541180; cv=none; b=c7lbP1CtEajLf4sEb88SuThZoO879OzE0QkdPF6PqTcyflk3xG0uHkZXJ0nfgZbLNFKya6gEbY0KEQdgveghUbOCxboOjQjQTlHEjN4T//BeF1o8GVQl+lQI6qf7KtfjrkIdpv5DyXjiUTRb88JDQGYQN3+vDOhDLW+zoPNSAlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732541180; c=relaxed/simple;
	bh=W7sWR4CZeT+XNODA6xJjMPPzou16KzqTT27yF7wwjOw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fj1laoqGYVkXbWRzZku9jW9zgstaVDN1V0iKXPTB+ir0u/nFlZ3Kspty8jEBg8TTXXLRloXLFRVelWA7Frl6iYL2MVAa0Cnbdgw+5eha8GTKsPeoT+cbfSnOMvfmGb+EJD1KwPR0IeqtR+q9Z8P8MRwMpu4lxw1BW1++4+NGLJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CRui7MIR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 363C3C4CECE;
	Mon, 25 Nov 2024 13:26:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732541180;
	bh=W7sWR4CZeT+XNODA6xJjMPPzou16KzqTT27yF7wwjOw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=CRui7MIR/F4ITnhzNlawFgLECteHSEbwAZdoTmGdPUV6WxwkR2k5kT6l41HUW9boJ
	 vtT/Nm6qhy0jytVif689VHZrL2FCyu93bS1hiilmZD6TNepTwZTuNruHzM3KI5IZCe
	 h0Acr5YKYnbRZXl/eN3iD6R7IHdiPtkW0rll+jy7HskDF9IZ12sflBpb4r4DERP9g0
	 40oOsCdu0+XI+kMUxXaSAxri9hKHeQXwN/Mcg6RKa3dT4ut7+LchBxfg8wMHJ/B8Ft
	 sJAW++9Cs+Gzm6nMyQsmsIgAimyRu9ANVZ/oDKzLsus/qymibTuN4AknkjstxB9tiO
	 gdPHj3iDaO1Mw==
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-296bff3f5e8so2525682fac.2;
        Mon, 25 Nov 2024 05:26:20 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVjDx23ZPMm7Vj7Zu0b+UYEPhFa4JcCbVjcWBNB2wj8q3ageP5r8+Ta6rgukeV9YOfJLkF5EHqjgbZoLQM=@vger.kernel.org, AJvYcCXLuGXwve6kv6VcKk4xz6QD9UsV28r7Ct0rUcQBKZ73CEeg+goScAQGzntQ4ybJSEfPjzBLLXGYLbs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwoeqNKj+aNPC1DsALK9SFODMDa7Bb+dduFK1pG3oi2f4S+hDBv
	nDragzuXu0C9N+KL4/NFFNXFKVyD0Fw3Wb8a2UX7FzYjYOKFfT2AK3e0n6dHK0vteHPQj7wYG1k
	V3WNJRbLNVSyzxaDTOtUMtI2D/sg=
X-Google-Smtp-Source: AGHT+IETvuzLn1RaUojSLAlDhaAaH2OqRBdzFXfhokCVwNT0Pu4zVY2UsSbhAgCONeayksUr3QNOB8u9RauopJDBCag=
X-Received: by 2002:a05:6871:7bc4:b0:296:e159:2346 with SMTP id
 586e51a60fabf-29720e4ed5fmr9927060fac.37.1732541179533; Mon, 25 Nov 2024
 05:26:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241125132029.7241-1-patryk.wlazlyn@linux.intel.com> <20241125132029.7241-2-patryk.wlazlyn@linux.intel.com>
In-Reply-To: <20241125132029.7241-2-patryk.wlazlyn@linux.intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 25 Nov 2024 14:26:08 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0hG4gJEZW-53Ps+AUPdkZCubH2Px35BmN1_goRTMb9EeA@mail.gmail.com>
Message-ID: <CAJZ5v0hG4gJEZW-53Ps+AUPdkZCubH2Px35BmN1_goRTMb9EeA@mail.gmail.com>
Subject: Re: [RFC PATCH v4 1/8] cpuidle: Do not return from
 cpuidle_play_dead() on callback failures
To: Patryk Wlazlyn <patryk.wlazlyn@linux.intel.com>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
	rafael.j.wysocki@intel.com, len.brown@intel.com, 
	artem.bityutskiy@linux.intel.com, dave.hansen@linux.intel.com, 
	peterz@infradead.org, tglx@linutronix.de, gautham.shenoy@amd.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 25, 2024 at 2:20=E2=80=AFPM Patryk Wlazlyn
<patryk.wlazlyn@linux.intel.com> wrote:
>
> From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
>
> If the :enter_dead() idle state callback fails for a certain state,
> there may be still a shallower state for which it will work.
>
> Because the only caller of cpuidle_play_dead(), native_play_dead(),
> falls back to hlt_play_dead() if it returns an error, it should
> better try all of the idle states for which :enter_dead() is present
> before failing, so change it accordingly.
>
> Also notice that the :enter_dead() state callback is not expected
> to return on success (the CPU should be "dead" then), so make
> cpuidle_play_dead() ignore its return value.
>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
> Tested-by: Mario Limonciello <mario.limonciello@amd.com> # 6.12-rc7
> Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>

This one and the [2/2] are in the mainline as of today, no need to resend t=
hem.

> ---
>  drivers/cpuidle/cpuidle.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/cpuidle/cpuidle.c b/drivers/cpuidle/cpuidle.c
> index 06ace16f9e71..0835da449db8 100644
> --- a/drivers/cpuidle/cpuidle.c
> +++ b/drivers/cpuidle/cpuidle.c
> @@ -69,11 +69,15 @@ int cpuidle_play_dead(void)
>         if (!drv)
>                 return -ENODEV;
>
> -       /* Find lowest-power state that supports long-term idle */
> -       for (i =3D drv->state_count - 1; i >=3D 0; i--)
> +       for (i =3D drv->state_count - 1; i >=3D 0; i--) {
>                 if (drv->states[i].enter_dead)
> -                       return drv->states[i].enter_dead(dev, i);
> +                       drv->states[i].enter_dead(dev, i);
> +       }
>
> +       /*
> +        * If :enter_dead() is successful, it will never return, so reach=
ing
> +        * here means that all of them failed above or were not present.
> +        */
>         return -ENODEV;
>  }
>
> --
> 2.47.0
>
>

