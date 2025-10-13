Return-Path: <linux-pm+bounces-35986-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D1B1BD59EE
	for <lists+linux-pm@lfdr.de>; Mon, 13 Oct 2025 19:58:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2B72C4E4055
	for <lists+linux-pm@lfdr.de>; Mon, 13 Oct 2025 17:58:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB2CC2C21D6;
	Mon, 13 Oct 2025 17:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z+h24AI3"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96D182C15B8
	for <linux-pm@vger.kernel.org>; Mon, 13 Oct 2025 17:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760378327; cv=none; b=PX2b8CEQyRGJcfsCamk2c17+WUz1tFO+0OI1TpXKFlu18ZUlRFG6JHXVNLP5JXTzgp//MilzwzTIkt81ZPwEjFCx7olIbnJBH7c6m6dUxunGOKZ6co2Xvj3g5sG1usB4KQ0l2d25sKadjZ5fEjIrV3IxeaECQ2fLYYGDklaqinE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760378327; c=relaxed/simple;
	bh=aG01wiT09yJPj6CFynmVBe9UW2Xxkvjj/sdmA1JN2pU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Uo1xYpQqT/uUZiZMQa0VsY7ZdxitEQSuH45xw5gJ6UuFUQ2gPtyuBwxC9qq+qyjKJJTyG5PXowMSOVR4AcIFe1EpvdIbNoNDzyociuPrg5dqAsCZSUVBHQnhbDQ2mEEOXoVeXgHU7V/wok0t7eTsYlUmkE7rOjF3v/KsSTRYqM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z+h24AI3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 206BBC4CEE7
	for <linux-pm@vger.kernel.org>; Mon, 13 Oct 2025 17:58:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760378327;
	bh=aG01wiT09yJPj6CFynmVBe9UW2Xxkvjj/sdmA1JN2pU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Z+h24AI3l/ONm1HulZZFly1Gpj1OcGcZ37YhWxl0OHd4N7MkuH7mAJ5tsLEXgY0Hh
	 m4XilcvJNumef6NaHDUd97wOEtQnH3/pC1n94dvGjQgHkdwqKsv6AoZzWq66lGMSpF
	 vgmZlblGXvsMq14drfG1kqzmRsMQ72mcmKNNgHClgr6flUfH+WCybH3HKLGvUM21FL
	 dBlVsimjHOeFZ6EoSG/OrcIEJx3uv8IICcYzfnzZmu5eEvrm5GX+/vKqBFmojrFTbQ
	 J/ZS0Od+2TxEtIQjkDwj0zHKwXyCnw4AGgsK/wug+MD6kwbH+w5f71ERZ7kud/2vOy
	 e7PBC7dyaHRqA==
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-65033a46f05so456024eaf.0
        for <linux-pm@vger.kernel.org>; Mon, 13 Oct 2025 10:58:47 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUVxChsW/0+dDpvuDRb7ya/KxaBOSCtyNNYJqpkdrd+iTL70C+FiZiA6EhGWoSwVp4Xuz1xsMeS0A==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz54Q7OJUm+Bi5bN/s7hyQJvRXgH3vrBZRH9wwDpYCQWKZ7ji66
	8vFgToilj1CRjwnoqLEbMLh2u85rK+aUVBFegEiV7eHq+d0yAExWWaOd1xE6jTOPvEP8iQpYeCv
	8rSFJwTOf8rsI8SNeigosk23Pdu9I4eE=
X-Google-Smtp-Source: AGHT+IEynNHHTpJPmKSFYHMy2PMRkXPOr2eqd2WUbNoaH67iuh5dKRXgRjCqZxoBlc66XFt/Fz4k+Vj3WXJ7uVBWhQ0=
X-Received: by 2002:a05:6808:1527:b0:441:8f74:fbd with SMTP id
 5614622812f47-4418f7420e0mr8480039b6e.58.1760378326313; Mon, 13 Oct 2025
 10:58:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251013174729.1101186-1-superm1@kernel.org> <20251013174729.1101186-2-superm1@kernel.org>
In-Reply-To: <20251013174729.1101186-2-superm1@kernel.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 13 Oct 2025 19:58:35 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0jC9BBniDkODH-RnfvPNP8yYZd2QyYSAOiANfO-jCeyPw@mail.gmail.com>
X-Gm-Features: AS18NWAt8GNlmxH_RQQptsjdD2xFu1WC6QLsI13KgULPzB9ZVQqwCK6NHrsULS4
Message-ID: <CAJZ5v0jC9BBniDkODH-RnfvPNP8yYZd2QyYSAOiANfO-jCeyPw@mail.gmail.com>
Subject: Re: [RFC PATCH 1/3] PM: hibernate: Nominally skip thaw sequence for
 all devices
To: "Mario Limonciello (AMD)" <superm1@kernel.org>
Cc: mario.limonciello@amd.com, airlied@gmail.com, alexander.deucher@amd.com, 
	christian.koenig@amd.com, dakr@kernel.org, gregkh@linuxfoundation.org, 
	lenb@kernel.org, pavel@kernel.org, rafael@kernel.org, simona@ffwll.ch, 
	amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
	linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 13, 2025 at 7:48=E2=80=AFPM Mario Limonciello (AMD)
<superm1@kernel.org> wrote:
>
> From: Mario Limonciello <mario.limonciello@amd.com>
>
> After the hibernation snapshot is created all devices will have
> their thaw() callback called before the next stage.  For the most
> common scenarios of hibernation this is not necessary because the
> device will be powered off anyway.

And how exactly is the image going to be saved?

It is only in memory when the "thaw" callbacks are invoked.

> If the hibernation snapshot was successfully created skip thawing
> devices until it's needed for userspace created hibernation image
> or hybrid sleep. To accomplish this use PMSG_INVALID in
> hibernation_snapshot() and set the dpm functions to skip running.
>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>  drivers/base/power/main.c |  6 ++++++
>  kernel/power/hibernate.c  | 13 ++++++++++---
>  kernel/power/user.c       |  3 +++
>  3 files changed, 19 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
> index 8179fd53171dc..58f5270a173e8 100644
> --- a/drivers/base/power/main.c
> +++ b/drivers/base/power/main.c
> @@ -1143,6 +1143,9 @@ void dpm_resume(pm_message_t state)
>         struct device *dev;
>         ktime_t starttime =3D ktime_get();
>
> +       if (state.event =3D=3D PM_EVENT_INVALID)
> +               return;
> +
>         trace_suspend_resume(TPS("dpm_resume"), state.event, true);
>
>         pm_transition =3D state;
> @@ -1245,6 +1248,9 @@ void dpm_complete(pm_message_t state)
>  {
>         struct list_head list;
>
> +       if (state.event =3D=3D PM_EVENT_INVALID)
> +               return;
> +
>         trace_suspend_resume(TPS("dpm_complete"), state.event, true);
>
>         INIT_LIST_HEAD(&list);
> diff --git a/kernel/power/hibernate.c b/kernel/power/hibernate.c
> index aadf82f57e868..7af2e392c574a 100644
> --- a/kernel/power/hibernate.c
> +++ b/kernel/power/hibernate.c
> @@ -480,13 +480,14 @@ int hibernation_snapshot(int platform_mode)
>         if (error || !in_suspend)
>                 swsusp_free();
>
> -       msg =3D in_suspend ? (error ? PMSG_RECOVER : PMSG_THAW) : PMSG_RE=
STORE;
> +       msg =3D in_suspend ? (error ? PMSG_RECOVER : PMSG_INVALID) : PMSG=
_RESTORE;
>         dpm_resume(msg);
>
> -       if (error || !in_suspend)
> +       if (error || !in_suspend) {
>                 pm_restore_gfp_mask();
> +               console_resume_all();
> +       }
>
> -       console_resume_all();
>         dpm_complete(msg);
>
>   Close:
> @@ -707,7 +708,13 @@ static void power_down(void)
>
>  #ifdef CONFIG_SUSPEND
>         if (hibernation_mode =3D=3D HIBERNATION_SUSPEND) {
> +               /* recover from hibernation_snapshot() */
> +               dpm_resume(PMSG_THAW);
> +               console_resume_all();
> +               dpm_complete(PMSG_THAW);
>                 pm_restore_gfp_mask();
> +
> +               /* run suspend sequence */
>                 error =3D suspend_devices_and_enter(mem_sleep_current);
>                 if (!error)
>                         goto exit;
> diff --git a/kernel/power/user.c b/kernel/power/user.c
> index 3f9e3efb9f6e7..d70c963b1ba88 100644
> --- a/kernel/power/user.c
> +++ b/kernel/power/user.c
> @@ -310,6 +310,9 @@ static long snapshot_ioctl(struct file *filp, unsigne=
d int cmd,
>                 pm_restore_gfp_mask();
>                 error =3D hibernation_snapshot(data->platform_support);
>                 if (!error) {
> +                       dpm_resume(PMSG_THAW);
> +                       console_resume_all();
> +                       dpm_complete(PMSG_THAW);
>                         error =3D put_user(in_suspend, (int __user *)arg)=
;
>                         data->ready =3D !freezer_test_done && !error;
>                         freezer_test_done =3D false;
> --
> 2.43.0
>

