Return-Path: <linux-pm+bounces-37318-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D5ACC2DF1D
	for <lists+linux-pm@lfdr.de>; Mon, 03 Nov 2025 20:51:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EACCE1883453
	for <lists+linux-pm@lfdr.de>; Mon,  3 Nov 2025 19:51:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8589B29BDB6;
	Mon,  3 Nov 2025 19:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d7zlPIMi"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54A5D26E714
	for <linux-pm@vger.kernel.org>; Mon,  3 Nov 2025 19:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762199468; cv=none; b=jM6l6h2bqWL+/Gb7a1e0kZPyysLi8G/6uMwNrGunoC671+fufug8HZJ2nXyn2DOL4DHZndkcXSJIFsByTBZrzNwAXtUiI+GB1L9IVzNY2oT04QMe71B3VMmgeXdDTXcIt507Sj1edMJobNqE2IUmfMISAr/S1nuYpAhl5c9u4o8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762199468; c=relaxed/simple;
	bh=iLNXnuI5kIudj20gm1Ls8O8eUA3l854hod+2cRfnDrw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Gj/6f4pJhvkvwKCRpayAk05FBFqt0O3Twrs7uBpS2FMVNjbOnAADOiJvRZx50e3hBiQKn234O1BzQ/nJR1PUg0U0FYljA31hUQPXnFXhueRyk9PxyF/lUsigO0necsmXNe6EWBRcqNA6Zxhbl0R4swCx4TPs6vB2WU5TQpLEf0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d7zlPIMi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBF55C113D0
	for <linux-pm@vger.kernel.org>; Mon,  3 Nov 2025 19:51:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762199467;
	bh=iLNXnuI5kIudj20gm1Ls8O8eUA3l854hod+2cRfnDrw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=d7zlPIMic8lKPgklW5z54qKirw/p9i51tZ4r12nXxU+g+J3UbwkmHXe3H4R+Lv4f0
	 SR74Wr7NItNNySTwQjD01GdMz52DOEmSZuM4FHsL4qKd2Wyr51uzzIuGYmFNJMsZQm
	 31GwbIZwl72Yw1qbuG9smYboukEzC/iX/cF20jlesjLzbrkY2EL4273ygf8w2ll1RF
	 iUTaWoJ0FXQ2ZZRDBEZYjNGDKa0vMdHKz6n90kgMlpnLvF2yVWZNfdNK8kNKX4yzJ4
	 IxTB/qy7SZRBtJXgoAvd6wf4aLk0pUsOOUUWyHPzpLG4I0S06QPdzfKc780Fy/T/to
	 nK85cYHBJ/fQg==
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-65043e595a8so2341144eaf.0
        for <linux-pm@vger.kernel.org>; Mon, 03 Nov 2025 11:51:07 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXtMp5XfVYsWlmrxK9euC/KDBxXEytwLLr1XxHFtCEIwZYfY2Eeh9U01TbvIhU1GhbRC0rbFC4+0A==@vger.kernel.org
X-Gm-Message-State: AOJu0YwYtCiULsA+vnijnO0PoPIljIRJxWiIixnN84vJO0quYiayQ+sS
	K2lZ7CuzPsjrwbBdp8InXkxOic6jBsXDYzyrQvOGBFwsmK4TBP9wUN5MTJohqGzeyOtPdSfPhJ5
	eq9yEwCFlKot+vll50tPKRWUfiIaDpys=
X-Google-Smtp-Source: AGHT+IGRTx64siy8pnvTaL2/UdZ2I+Vm3JpwOpG2g2JlvdUwqlH5iQdDpNIFzl5U2pS7A4EpsbcB96nR2vCWf9OTF6w=
X-Received: by 2002:a05:6820:290f:b0:656:77b8:9e3d with SMTP id
 006d021491bc7-6568a654c73mr5658401eaf.1.1762199467225; Mon, 03 Nov 2025
 11:51:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251025010058.2417352-1-superm1@kernel.org> <20251025010058.2417352-2-superm1@kernel.org>
In-Reply-To: <20251025010058.2417352-2-superm1@kernel.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 3 Nov 2025 20:50:56 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0icgrXW0ErPMqOnxKHXZ6cH4gd9274SkJfba981Z=s0fw@mail.gmail.com>
X-Gm-Features: AWmQ_bmeoZppxxPuzkge62CIm2aJBoPVHPVi54EuljCXLC5C_PLHLpQ9i_ArbRk
Message-ID: <CAJZ5v0icgrXW0ErPMqOnxKHXZ6cH4gd9274SkJfba981Z=s0fw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] PM: Allow device drivers to manage the frozen
 state of a device
To: "Mario Limonciello (AMD)" <superm1@kernel.org>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>, Alex Deucher <alexander.deucher@amd.com>, 
	"open list:HIBERNATION (aka Software Suspend, aka swsusp)" <linux-pm@vger.kernel.org>, 
	"open list:RADEON and AMDGPU DRM DRIVERS" <amd-gfx@lists.freedesktop.org>, 
	Muhammad Usama Anjum <usama.anjum@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 25, 2025 at 3:01=E2=80=AFAM Mario Limonciello (AMD)
<superm1@kernel.org> wrote:
>
> During a normal successful hibernate sequence devices will go through
> the freeze() callbacks create an image, go through the thaw() callbacks,
> and poweroff() callbacks.
>
> During a successful hibernate sequence some device drivers may want to
> skip the thaw() callbacks.  This confuses the PM core though because it
> thinks the device is no longer suspended.

The problem only really occurs if hibernation is aborted before or
during the final "poweroff" transition.

What happens is that if a driver decides to leave the device in the
"frozen" state during its "thaw" callback and its "poweroff" callback
is not invoked because hibernation is aborted earlier, the device will
be left in the "frozen" state going forward.

The goal of the change should be to make the core detect that
situation and "thaw" the device.

> To accommodate drivers that want to do this, introduce a new is_frozen
> bit that the driver can set and manage.  From the driver perspective
> any thaw() or restore() callbacks that are being skipped should set
> is_frozen and return an error code.

"Restore" has nothing to do with this, it is just about "freeze".

> The PM core will then put the device back into the list of devices to res=
ume for any aborted hibernate.

That's not what the patch does, though (see below).

All of this is mainly about what the core should do when it sees the
"is_frozen" flag set, so a few observations to that end:

1. That flag is only relevant when hibernation is aborted before
invoking the given driver's "poweroff" callback (because that callback
must be prepared to deal with a "frozen" device).

2. If the final "poweroff" transition is aborted during its "prepare"
phase, the "frozen" device may need to be "thawed" even if its
driver's "prepare" callback is not invoked.

3. There is a possibility, not taken into account so far, that
hibernation is aborted because of a failure to save the image.  Then,
"frozen" devices will need to be "thawed" before starting the final
"poweroff" transition.

Moreover, I'm not sure if it really makes sense to invoke "complete"
callbacks during the "thaw" transition for the devices left in the
"frozen" state.

All of the above means that the approach needs to be rethought and my
advice is to revert the commit causing the AMD driver to leave its
device in the "frozen" for 6.18 (and previous kernels).

> Tested-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
> Signed-off-by: Mario Limonciello (AMD) <superm1@kernel.org>
> ---
> v2:
>  * add tag
>  * fix lkp robot issue
>  * rebase on linux-pm/bleeding-edge
> ---
>  Documentation/driver-api/pm/devices.rst | 8 ++++++++
>  drivers/base/power/main.c               | 7 +++++++
>  include/linux/pm.h                      | 3 +++
>  3 files changed, 18 insertions(+)
>
> diff --git a/Documentation/driver-api/pm/devices.rst b/Documentation/driv=
er-api/pm/devices.rst
> index 36d5c9c9fd113..55c6337271086 100644
> --- a/Documentation/driver-api/pm/devices.rst
> +++ b/Documentation/driver-api/pm/devices.rst
> @@ -578,6 +578,14 @@ should already have been stored during the ``freeze`=
`, ``freeze_late`` or
>  the entire system, so it is not necessary for the callback to put the de=
vice in
>  a low-power state.
>
> +Skipping thaw phase
> +-------------------
> +In some rare situations, it may be desirable to skip the thaw phases
> +(``thaw_noirq``, ``thaw_early``, ``thaw``) of a device entirely.  This c=
an be
> +achieved by a device driver returning an error code from any of it's tha=
w
> +callbacks but also setting dev->power.is_frozen to true.

Returning an error code should not be necessary.

Also this needs to be done in "thaw_noirq" or maybe even in
"freeze_noirq" because "thaw_noirq" may involve some bus type actions
changing the state of the device before the driver gets to it.

So the driver would opt in for leaving the device in the "frozen"
state at the "noirq" stage of the preceding "freeze" transition.  That
can be achieved by setting a "leave_in_freeze" flag, so no callbacks
would be run for any devices with that flag set during the subsequent
"thaw" transition.

If hibernation is aborted before the final "poweroff" transition
begins, the "thaw*" and "complete" callbacks will have to be run for
all of those devices (I'm wondering if any ordering issues may arise
at that point; presumably, devices that depend on the "frozen" ones
would also need to be "frozen"?).

During the final "poweroff" transition, since "complete" has not been
called for any of the "frozen" devices, it should not be necessary to
call "prepare" for any of them, so that one can be skipped.

Again, if hibernation is aborted at this point, all of the "thaw*" and
complete callbacks need to be run for all of the "frozen" devices.

Now, "poweroff", "poweroff" and "poweroff_noirq" callbacks for the
"frozen" devices need to be prepared to deal with them, but the exact
rules there will need some consideration.  They kind of need to assume
that "freeze" may be changed into "poweroff" transparently without a
"thaw" in between and that generally depends on the bus type/PM domain
involved.

> This indicates to the
> +PM core that the device is still in the frozen state.  The PM core will =
consider
> +this when resuming the device in later phases such as `restore` or `powe=
roff`.
>
>  Leaving Hibernation
>  -------------------
> diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
> index 7a8807ec9a5d0..c5a192fc04344 100644
> --- a/drivers/base/power/main.c
> +++ b/drivers/base/power/main.c
> @@ -1110,6 +1110,13 @@ static void device_resume(struct device *dev, pm_m=
essage_t state, bool async)
>
>   End:
>         error =3D dpm_run_callback(callback, dev, state, info);
> +#ifdef CONFIG_HIBERNATE_CALLBACKS

CONFIG_HIBERNATION should be sufficient.

> +       /* device manages frozen state */
> +       if (error && dev->power.is_frozen) {
> +               dev->power.is_suspended =3D true;
> +               error =3D 0;
> +       }

This assumes that the callback will run, but what if hibernation is
aborted before running it?  Isn't that really the problem at hand?

> +#endif
>
>         device_unlock(dev);
>         dpm_watchdog_clear(&wd);
> diff --git a/include/linux/pm.h b/include/linux/pm.h
> index a72e42eec1303..852902fc72158 100644
> --- a/include/linux/pm.h
> +++ b/include/linux/pm.h
> @@ -689,6 +689,9 @@ struct dev_pm_info {
>  #else
>         bool                    should_wakeup:1;
>  #endif
> +#ifdef CONFIG_HIBERNATE_CALLBACKS
> +       bool                    is_frozen:1;    /* Owned by the driver */
> +#endif
>  #ifdef CONFIG_PM
>         struct hrtimer          suspend_timer;
>         u64                     timer_expires;
> --

