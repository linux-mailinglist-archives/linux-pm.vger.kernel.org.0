Return-Path: <linux-pm+bounces-35403-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 95FE8BA0F08
	for <lists+linux-pm@lfdr.de>; Thu, 25 Sep 2025 19:48:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E04427A47E3
	for <lists+linux-pm@lfdr.de>; Thu, 25 Sep 2025 17:46:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEFCE30F528;
	Thu, 25 Sep 2025 17:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V/7GrYYb"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C781027510B
	for <linux-pm@vger.kernel.org>; Thu, 25 Sep 2025 17:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758822482; cv=none; b=Cm1kmdjHdMe/w9u/PzAp/L/kOmy3wmzyN2rasN8i2mHZ3sTve9ByeHokUD7kslAJ9bqxQdT7bPOqXx2ugOhXHFrt+iQfJ3GTNLqTttW4TP3bFiUmUmpBPzhEQA5PbnEJoEraTpXPpupEt23oAhyji+/YeEIp9vo4LwaAJAf65XI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758822482; c=relaxed/simple;
	bh=mA6PkKtltuAiGHc5QXkbQgm+Jc9JdGxHMRsx2t5JAa8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r+9Xv5wz3g/cqB1p5zwxNeKX6ztHBYBkfyJjI5n7SgAZR9wn5zUXLVl1+MrZWEgzP5TL4nx4RC8H6V8Xp3s2EhJRoU/bXu1leQGC3NC3U0qIdNnU6vFji+EXnUijsNHjNqlLtgF/6aVmyukZzbWdJOxbr28UGotaJd5scgLs0hA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V/7GrYYb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 566E6C113D0
	for <linux-pm@vger.kernel.org>; Thu, 25 Sep 2025 17:48:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758822480;
	bh=mA6PkKtltuAiGHc5QXkbQgm+Jc9JdGxHMRsx2t5JAa8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=V/7GrYYbG90wPN9IeN6OMZ83mlNDE3igM4dkz3fdMWzvJe7mU2VRzgxQhz00aVQyg
	 Iv/4bn57iSmYnRmaTj0t3smavt1pcT9Uh8BwilmtDX5GLiMVAbSA3836Uj0zIHtI20
	 JBBnsiCd+wfimv2MFVuQ6ZHxvvRmnq6RFOmwI5sstoMB+i5d4Wqx7FhHqF2kuguNYl
	 avsQc72YNA97LUz4XHSFRZ4Vw/MGqiQBTKf6ZzvGp62QbPCpOPi+cd30DOky2bh5li
	 UgbdClnQN2KKqHUO7PHoB078kI/W63pafrn/bBay33D+GnhkJvLLT5TdK2elH1aJ6w
	 I5ounCoEoyKxQ==
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-63a1f3c0820so844375eaf.2
        for <linux-pm@vger.kernel.org>; Thu, 25 Sep 2025 10:48:00 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVztjSU9GIqkllDWq1BhtcYAvJeqReCTJAyWfN/deEs09+YdlDTgcDl0PvGtJcT5z1jSoAZKUKQgA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwwdkD1imHejriG8UU2ZCCCiTMceOg6p5uWMtgvVUVlLMHBOLnT
	Bd+QToABmV4GBHN76vpAJz6xM6SSlO+HSwQWIHok2t2vs8bJbiKc/MgsEugIG2qmW4y8Yv2ZoCU
	YW4v3vj+sCzz5MwRQV9vAIk6kmTQBAXI=
X-Google-Smtp-Source: AGHT+IGlc2LORVQXnI7VA1514vSo/kHP6Wqb6lBZqoQ96Nmevq5N74ZhgngOLd9Sro1/zeQCUINxqFTmTUK3pRtHRx8=
X-Received: by 2002:a05:6820:22a6:b0:621:76b6:b3c with SMTP id
 006d021491bc7-63a3659aacdmr1802623eaf.4.1758822479378; Thu, 25 Sep 2025
 10:47:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250925155918.2725474-1-superm1@kernel.org> <20250925155918.2725474-2-superm1@kernel.org>
In-Reply-To: <20250925155918.2725474-2-superm1@kernel.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 25 Sep 2025 19:47:47 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0g1rm3w=93mWBRJaFiX9qMOkDMzEsU=_ScLBHSL-2i15A@mail.gmail.com>
X-Gm-Features: AS18NWClcr_8M-xeE1slFLHmD5kELB__HFAlr-1gHiqIRjQCMegR0T57WHvk7A4
Message-ID: <CAJZ5v0g1rm3w=93mWBRJaFiX9qMOkDMzEsU=_ScLBHSL-2i15A@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] PM: hibernate: Fix hybrid-sleep
To: "Mario Limonciello (AMD)" <superm1@kernel.org>
Cc: Alex Deucher <alexander.deucher@amd.com>, "Rafael J . Wysocki" <rafael@kernel.org>, 
	Samuel Zhang <guoqing.zhang@amd.com>, 
	"open list:RADEON and AMDGPU DRM DRIVERS" <amd-gfx@lists.freedesktop.org>, 
	"open list:HIBERNATION (aka Software Suspend, aka swsusp)" <linux-pm@vger.kernel.org>, Ionut Nechita <ionut_n2001@yahoo.com>, 
	Kenneth Crudup <kenny@panix.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 25, 2025 at 5:59=E2=80=AFPM Mario Limonciello (AMD)
<superm1@kernel.org> wrote:
>
> Hybrid sleep will hibernate the system followed by running through
> the suspend routine.  Since both the hibernate and the suspend routine
> will call pm_restrict_gfp_mask(), pm_restore_gfp_mask() must be called
> before starting the suspend sequence.
>
> Add an explicit call to pm_restore_gfp_mask() to power_down() before
> the suspend sequence starts. Don't call pm_restore_gfp_mask() when
> exiting suspend sequence it is already called:
>
> ```
> power_down()
> ->suspend_devices_and_enter()
> -->dpm_resume_end()
> ```
>
> Reported-by: Ionut Nechita <ionut_n2001@yahoo.com>
> Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/4573
> Tested-by: Ionut Nechita <ionut_n2001@yahoo.com>
> Fixes: 12ffc3b1513eb ("PM: Restrict swap use to later in the suspend sequ=
ence")
> Tested-by: Kenneth Crudup <kenny@panix.com>
> Acked-by: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Mario Limonciello (AMD) <superm1@kernel.org>
> ---
> v2:
>  * Move under CONFIG_SUSPEND scope (LKP robot)
>  * Add tags
> ---
>  kernel/power/hibernate.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
>
> diff --git a/kernel/power/hibernate.c b/kernel/power/hibernate.c
> index 2f66ab4538231..52c1818749724 100644
> --- a/kernel/power/hibernate.c
> +++ b/kernel/power/hibernate.c
> @@ -695,6 +695,7 @@ static void power_down(void)
>
>  #ifdef CONFIG_SUSPEND
>         if (hibernation_mode =3D=3D HIBERNATION_SUSPEND) {
> +               pm_restore_gfp_mask();
>                 error =3D suspend_devices_and_enter(mem_sleep_current);
>                 if (error) {
>                         hibernation_mode =3D hibernation_ops ?
> @@ -862,7 +863,15 @@ int hibernate(void)
>                                 power_down();
>                 }
>                 in_suspend =3D 0;
> -               pm_restore_gfp_mask();
> +               switch (hibernation_mode) {
> +#ifdef CONFIG_SUSPEND
> +               case HIBERNATION_SUSPEND:
> +                       break;
> +#endif
> +               default:
> +                       pm_restore_gfp_mask();
> +                       break;
> +               }

You're breaking HIBERNATION_TEST_RESUME here AFAICS and power_down()
doesn't return.

>         } else {
>                 pm_pr_dbg("Hibernation image restored successfully.\n");
>         }
> --

