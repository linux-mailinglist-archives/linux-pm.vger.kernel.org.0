Return-Path: <linux-pm+bounces-26928-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 864B8AB13AB
	for <lists+linux-pm@lfdr.de>; Fri,  9 May 2025 14:43:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 861483BFDFB
	for <lists+linux-pm@lfdr.de>; Fri,  9 May 2025 12:43:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D896290BCB;
	Fri,  9 May 2025 12:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IYDWnQWM"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 085BC2900B7
	for <linux-pm@vger.kernel.org>; Fri,  9 May 2025 12:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746794618; cv=none; b=ZPGsFnoGdbkWrxD1K17vJNEdvoOqgizVEsRsFjiJHtKzfBGH/3Y2oBgksY0bPI651Mbud8ag5fr7+1QpIII7L6CvcPVadoAVirRniuSHKohXIanFvPRm5iR1OaTZUo5fgbEYfPCSQ5bePFkXRE7OYtRGZZEWvSHU29Ya8AIDuso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746794618; c=relaxed/simple;
	bh=Vbz7G42PirpbKBD77o5ENfHxbXLMEorCXEdJM/isWt8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sKDBwWGhG3gQjnXkiSjZ9JAtDqQmFwewM7L2g6LgaUZp/poKNehKLVcNdZHK+kpX5l29bzUQdrqiK97dhpSL2qRMGiC76uef1SLGT0nVY9N14W4tvJsNVp5fTjymD5D97eA8xt6FoBqTKfqJBnBv/uhSdTshbjOFjCBVe9lcopc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IYDWnQWM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75E96C4AF0B
	for <linux-pm@vger.kernel.org>; Fri,  9 May 2025 12:43:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746794617;
	bh=Vbz7G42PirpbKBD77o5ENfHxbXLMEorCXEdJM/isWt8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=IYDWnQWMI3158jM+Z1AK67kgYFUk2and3/O6hegYyFzeblFFUeZbO7x+I8BvyRpMR
	 gSGdSBxh6q+n+se+U0WWOuM2eCtnRC9QdpqX49cGdBURyaGqsmnGPIIDHJU9htzb/s
	 0WousJLIQvWuoYEWh8TprMXgpnc0SqXezqOkTzCjmQUS3Fgbx124GbW4qiInnCdVz/
	 +8fYjOaU+oLMyeyFVGH9CGyZI2/dyI+/KIEyGNzjqJmA7W1ocqoS8mSDZ8GPJ0Wa88
	 ZZr8JIeYyCvQGjnM7JKq0Rk2gGWQRHZDuprSMlPbHVTu6LfBXg3EXDnqp8IShuhuIh
	 2EVyssQw2QwIw==
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-2d0920ce388so1137592fac.0
        for <linux-pm@vger.kernel.org>; Fri, 09 May 2025 05:43:37 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVvlzdVKwj9N7bhJ9Y/VkHUbZtlMuURFgdOwvGzEe0sTtDn95+/C5Y50Mql/HRzFCTV37O3PfRZ5A==@vger.kernel.org
X-Gm-Message-State: AOJu0YzsTuhX3DZMIKCeasrGF/UxonN4YOBgyqnM2OOThu2BMMSRK5fC
	h7YmXY22Nq05ovBnAlsehMaCJwIJjLvWaWMFQBkM1HuSPA30sGX3o3XAgKwokzlI0507T70Afs/
	TtW8y9zvsCuRhv6ibYhqRYzcgrHA=
X-Google-Smtp-Source: AGHT+IF+IbGQMc4CsTbZ/CT8sCjC8oVH+fQBWY/V3OyWVbM+8gC1zoDl34U1OW0RddwsglJ/2x6Pt+pD8gBgsfs8QTQ=
X-Received: by 2002:a05:6870:e2cf:b0:2bc:7007:5145 with SMTP id
 586e51a60fabf-2dba42a0a61mr1980034fac.9.1746794616731; Fri, 09 May 2025
 05:43:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250508211822.2698678-1-superm1@kernel.org>
In-Reply-To: <20250508211822.2698678-1-superm1@kernel.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 9 May 2025 14:43:25 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0iYDeukd+=c0hEwZZSB4sUtLi+XrSjqxDPnrZNR+jvMnw@mail.gmail.com>
X-Gm-Features: ATxdqUGYh9-y71S0sk77YG8b3FzeZLFxGyxSB3Zz--hpA_Q7OBrD9zapu5PeBio
Message-ID: <CAJZ5v0iYDeukd+=c0hEwZZSB4sUtLi+XrSjqxDPnrZNR+jvMnw@mail.gmail.com>
Subject: Re: [PATCH v2] PM: hibernate: Explicitly set `PM_SUSPEND_MAX` at
 hibernate entry
To: Mario Limonciello <superm1@kernel.org>
Cc: mario.limonciello@amd.com, rafael@kernel.org, pavel@kernel.org, 
	len.brown@intel.com, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 8, 2025 at 11:18=E2=80=AFPM Mario Limonciello <superm1@kernel.o=
rg> wrote:
>
> From: Mario Limonciello <mario.limonciello@amd.com>
>
> `pm_debug_messages` only works at suspend time, not hibernate. This is
> because during hibernate the `pm_suspend_target_state` is not set.
>
> Explicitly set pm_suspend_target_state at hibernate time. Since the symbo=
l
> is only enabled under `CONFIG_SUSPEND`, adjust symbol location and allow =
it
> under `CONFIG_HIBERNATION` too.

No, this is not the right fix.

Apart from the build issue introduced by it as reported by 0-day,
pm_suspend_target_state is suspend-only and setting it during
hibernation is almost guaranteed to confuse things somewhere.

Hibernation  needs to be covered in a different way.

I'll post my fix shortly (along with some other changes on top of it).

> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
> v2:
>  * Fix for lkp robot failure where no CONFIG_SUSPEND
> ---
>  include/linux/suspend.h  | 9 ++++++---
>  kernel/power/hibernate.c | 2 ++
>  kernel/power/main.c      | 3 +++
>  kernel/power/suspend.c   | 2 --
>  4 files changed, 11 insertions(+), 5 deletions(-)
>
> diff --git a/include/linux/suspend.h b/include/linux/suspend.h
> index da6ebca3ff774..b66be47ef5282 100644
> --- a/include/linux/suspend.h
> +++ b/include/linux/suspend.h
> @@ -142,8 +142,13 @@ struct platform_s2idle_ops {
>         void (*end)(void);
>  };
>
> -#ifdef CONFIG_SUSPEND
> +#if defined(CONFIG_SUSPEND) || defined(CONFIG_HIBERNATION)
>  extern suspend_state_t pm_suspend_target_state;
> +#else
> +#define pm_suspend_target_state        (PM_SUSPEND_ON)
> +#endif
> +
> +#ifdef CONFIG_SUSPEND
>  extern suspend_state_t mem_sleep_current;
>  extern suspend_state_t mem_sleep_default;
>
> @@ -279,8 +284,6 @@ extern bool sync_on_suspend_enabled;
>  #else /* !CONFIG_SUSPEND */
>  #define suspend_valid_only_mem NULL
>
> -#define pm_suspend_target_state        (PM_SUSPEND_ON)
> -
>  static inline void pm_suspend_clear_flags(void) {}
>  static inline void pm_set_suspend_via_firmware(void) {}
>  static inline void pm_set_resume_via_firmware(void) {}
> diff --git a/kernel/power/hibernate.c b/kernel/power/hibernate.c
> index f0db9d1896e80..8fb82a62b85f1 100644
> --- a/kernel/power/hibernate.c
> +++ b/kernel/power/hibernate.c
> @@ -772,6 +772,7 @@ int hibernate(void)
>         }
>
>         pr_info("hibernation entry\n");
> +       pm_suspend_target_state =3D PM_SUSPEND_MAX;
>         pm_prepare_console();
>         error =3D pm_notifier_call_chain_robust(PM_HIBERNATION_PREPARE, P=
M_POST_HIBERNATION);
>         if (error)
> @@ -852,6 +853,7 @@ int hibernate(void)
>         hibernate_release();
>   Unlock:
>         unlock_system_sleep(sleep_flags);
> +       pm_suspend_target_state =3D PM_SUSPEND_ON;
>         pr_info("hibernation exit\n");
>
>         return error;
> diff --git a/kernel/power/main.c b/kernel/power/main.c
> index 97746f08b762b..0440644695c76 100644
> --- a/kernel/power/main.c
> +++ b/kernel/power/main.c
> @@ -20,6 +20,9 @@
>
>  #include "power.h"
>
> +suspend_state_t pm_suspend_target_state;
> +EXPORT_SYMBOL_GPL(pm_suspend_target_state);
> +
>  #ifdef CONFIG_PM_SLEEP
>  /*
>   * The following functions are used by the suspend/hibernate code to tem=
porarily
> diff --git a/kernel/power/suspend.c b/kernel/power/suspend.c
> index 8eaec4ab121d4..08cb71991795d 100644
> --- a/kernel/power/suspend.c
> +++ b/kernel/power/suspend.c
> @@ -48,8 +48,6 @@ const char *mem_sleep_states[PM_SUSPEND_MAX];
>
>  suspend_state_t mem_sleep_current =3D PM_SUSPEND_TO_IDLE;
>  suspend_state_t mem_sleep_default =3D PM_SUSPEND_MAX;
> -suspend_state_t pm_suspend_target_state;
> -EXPORT_SYMBOL_GPL(pm_suspend_target_state);
>
>  unsigned int pm_suspend_global_flags;
>  EXPORT_SYMBOL_GPL(pm_suspend_global_flags);
> --
> 2.43.0
>

