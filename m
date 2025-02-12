Return-Path: <linux-pm+bounces-21955-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EBEB2A32497
	for <lists+linux-pm@lfdr.de>; Wed, 12 Feb 2025 12:15:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1003F3A9276
	for <lists+linux-pm@lfdr.de>; Wed, 12 Feb 2025 11:14:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F21EB20A5CC;
	Wed, 12 Feb 2025 11:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sI8z74Gt"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C75DF209F58;
	Wed, 12 Feb 2025 11:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739358882; cv=none; b=Jyyv+OxB2Tjg+pJu6FhFY6iK24Aw2B9xkTIlkz2Yc2W2oztMl1fp9OqxsbtOp3ZX0fD1/pzLgJXUJG7kwCwk9JqA1r1fBhwpdp32fZzYZ/q4yNnZlblJQOvuRIVCFr39GvF9yNq7NXMtMVJrSi9A6WzgGVhZRlGQgJzUckX9R2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739358882; c=relaxed/simple;
	bh=ElFOyPp5k6YAWw4PxIEAueha3V2bu2dMbp+yyR1nDGQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aYfkX0mQ8C+P9Tqaic7yRjaliY5pKwCyN2H2y3O6qJIeZxQvqDUAyeyRoeD23Cq5IRvPSOVE4jDmDtfbFmnOOjw8s1N94Vytvay9ZutJ1oAHSexP81R+pDJV/kYmFvCfe1HLOumtUWeMCHk2oKgLx1MIY7018XMs6RchjOraNA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sI8z74Gt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 469A0C4CEE7;
	Wed, 12 Feb 2025 11:14:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739358881;
	bh=ElFOyPp5k6YAWw4PxIEAueha3V2bu2dMbp+yyR1nDGQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=sI8z74Gt9ttDJJar58Snerx+M8hB3Bsf5fiS7ZsYevmCiMDEAzWw76SE3qojUQ5dd
	 JQBnp0VUQk4mlewH2aswVYjLHFnApRKiBGK9uiHhDavId6M66GsLl0Ls8f/tZxNgo0
	 VYQkKP1fRJ9r2l3N2LJY4Gfls3ZA8je/iKFPeOo2+bAM/DHv6QKIxtQkmRvDEzd3Hw
	 UQd7dkUjBvF6W3vrcqOoHvWTBFwyPTE5B/JWtyC0lCx1sHPe1o0J+2EzoQMAHO5qIS
	 A2H2wzKTlXTnoKYngDEBQp7pCnJaNtwJQfeEWT8NWYalEHaIJDM4HnEKrXrCeJKQoH
	 vHUdmNIvvlO6w==
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-5fc7ff13fb8so1073196eaf.3;
        Wed, 12 Feb 2025 03:14:41 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWoECSJMSekCZZqeyPxq/bIFiQEWRsrAotQLg2wBpsxXeceZCIKKQXC3IsIA/pAQP78m5Z3/mQncQOamhY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzxi2pZDUKuq1kNh0o+yZea8+TePtLLrKOkklcfdLfaS4uCMIXP
	dv0evany7aaCssnHFTzsICAxGCFFSIe95tx9oicO5B3otI8fyd5ZTxNquMw2DvHfhPNr3OZX22/
	x3egGfdfINONyKw27wPN5jBZ+E/s=
X-Google-Smtp-Source: AGHT+IFMD1m6fioybSqUNwNdum8Rd0YCRKt7+QHVCKPkl2Cd7Y9Y7YGsVOHouQvD1XFPP/iIIiry843NZvUpjkFi+cg=
X-Received: by 2002:a05:6870:46a9:b0:296:aef8:fe9a with SMTP id
 586e51a60fabf-2b8d643d386mr1780134fac.7.1739358880488; Wed, 12 Feb 2025
 03:14:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2314745.iZASKD2KPV@rjwysocki.net> <2511990.jE0xQCEvom@rjwysocki.net>
In-Reply-To: <2511990.jE0xQCEvom@rjwysocki.net>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 12 Feb 2025 12:14:29 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0jwkwawYHRe893Fj7EuQLGCVzNSgq2YQN08Ycf0bqrhOQ@mail.gmail.com>
X-Gm-Features: AWEUYZmT7mRoSQtvrHUGOVP1IcZ2kFak6kouIIRiqjLSUhqnWQUlGBxXI-VoOrE
Message-ID: <CAJZ5v0jwkwawYHRe893Fj7EuQLGCVzNSgq2YQN08Ycf0bqrhOQ@mail.gmail.com>
Subject: Re: [PATCH v1 10/10] PM: runtime: Discover the lack of runtime PM support
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Alan Stern <stern@rowland.harvard.edu>, Ulf Hansson <ulf.hansson@linaro.org>, 
	Johan Hovold <johan@kernel.org>, Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
	Jon Hunter <jonathanh@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 11, 2025 at 10:25=E2=80=AFPM Rafael J. Wysocki <rjw@rjwysocki.n=
et> wrote:
>
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> Previous changes have updated the PM core to special-case devices that
> have never had runtime PM enabled in some places, but what if a device
> had had runtime PM enabled at one point, but then it was permanently
> disabled?  Arguably, there is not much of a difference between such
> devices and the devices that have never had runtime PM enabled as far
> as system-wide suspend and resume is concerned, so they should be
> handled in the same way.
>
> For this reason, add a mechanism for discovering "lost" runtime PM
> support in devices with the help of the power.last_status field used
> for saving the last runtime PM status of the device known at the time
> when runtime PM was disabled for it.
>
> That field is set to RPM_INVALID initially and whenever runtime PM is
> enabled for a device (that is, when its power.disable_depth counter
> drops down to zero) and it is set to the current runtime PM status of
> the device when runtime PM is disabled (that is, the power.disable_depth
> counter becomes nonzero).  Therefore, if power.last_status is equal to
> RPM_INVALID for a device with runtime PM disabled, it means that
> runtime PM has never been enabled for that device.
>
> The PM core will now change the power.last_status value to RPM_UNKNOWN
> for devices having runtime PM disabled and power.last_status different
> from RPM_INVALID during the "prepare" phase of system suspend.  Then,
> __pm_runtime_disable() called subsequently on the device will set
> power.last_status to RPM_INVALID unless it changes from RPM_UNKNOWN
> to some other value in the meantime which requires enabling runtime PM
> for the device.  When power.last_status becomes RPM_INVALID and runtime
> PM is still disabled, the device will be handled as a "no runtime PM
> support" one from that point on until runtime PM is enabled for it
> again.

So the interim RPM_UNKNOWN value of last_status isn't really
necessary, it may as well be changed directly to RPM_INVALID in
device_prepare().

Scratch this one and I'll replace it with a different patch.

> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  drivers/base/power/main.c    |    6 ++++++
>  drivers/base/power/runtime.c |   25 +++++++++++++++++++++++++
>  include/linux/pm.h           |    1 +
>  include/linux/pm_runtime.h   |    2 ++
>  4 files changed, 34 insertions(+)
>
> --- a/drivers/base/power/main.c
> +++ b/drivers/base/power/main.c
> @@ -1817,6 +1817,12 @@
>          * it again during the complete phase.
>          */
>         pm_runtime_get_noresume(dev);
> +       /*
> +        * Devices that have had runtime PM disabled recently may need to=
 be
> +        * handled as though they have never supported it, so arrange for
> +        * detecting that situation.
> +        */
> +       pm_runtime_kick_last_status(dev);
>
>         if (dev->power.syscore)
>                 return 0;
> --- a/drivers/base/power/runtime.c
> +++ b/drivers/base/power/runtime.c
> @@ -1480,6 +1480,9 @@
>
>         if (dev->power.disable_depth > 0) {
>                 dev->power.disable_depth++;
> +               if (dev->power.last_status =3D=3D RPM_UNKNOWN)
> +                       dev->power.last_status =3D RPM_INVALID;
> +
>                 goto out;
>         }
>
> @@ -1568,6 +1571,28 @@
>  EXPORT_SYMBOL_GPL(devm_pm_runtime_enable);
>
>  /**
> + * pm_runtime_kick_last_status - Start runtime PM support verification.
> + * @dev: Target device.
> + *
> + * If runtime PM is currently disabled for @dev, but it has been enabled=
 at one
> + * point, change power.last_status for it to RPM_UNKNOWN, and if it is s=
till
> + * RPM_UNKNOWN when __pm_runtime_disabled() is called for @dev next time=
, it
> + * will be changed to RPM_INVALID indicating no runtime PM support going
> + * forward until pm_runtime_enable() is called for @dev.
> + *
> + * This function is used by the PM core.
> + */
> +void pm_runtime_kick_last_status(struct device *dev)
> +{
> +       spin_lock_irq(&dev->power.lock);
> +
> +       if (dev->power.disable_depth && dev->power.last_status !=3D RPM_I=
NVALID)
> +               dev->power.last_status =3D RPM_UNKNOWN;
> +
> +       spin_unlock_irq(&dev->power.lock);
> +}
> +
> +/**
>   * pm_runtime_forbid - Block runtime PM of a device.
>   * @dev: Device to handle.
>   *
> --- a/include/linux/pm.h
> +++ b/include/linux/pm.h
> @@ -597,6 +597,7 @@
>         RPM_RESUMING,
>         RPM_SUSPENDED,
>         RPM_SUSPENDING,
> +       RPM_UNKNOWN,
>  };
>
>  /*
> --- a/include/linux/pm_runtime.h
> +++ b/include/linux/pm_runtime.h
> @@ -80,6 +80,7 @@
>  extern int pm_runtime_barrier(struct device *dev);
>  extern void pm_runtime_enable(struct device *dev);
>  extern void __pm_runtime_disable(struct device *dev, bool check_resume);
> +extern void pm_runtime_kick_last_status(struct device *dev);
>  extern void pm_runtime_allow(struct device *dev);
>  extern void pm_runtime_forbid(struct device *dev);
>  extern void pm_runtime_no_callbacks(struct device *dev);
> @@ -288,6 +289,7 @@
>  static inline int pm_runtime_barrier(struct device *dev) { return 0; }
>  static inline void pm_runtime_enable(struct device *dev) {}
>  static inline void __pm_runtime_disable(struct device *dev, bool c) {}
> +static inline void pm_runtime_kick_last_status(struct device *dev) {}
>  static inline void pm_runtime_allow(struct device *dev) {}
>  static inline void pm_runtime_forbid(struct device *dev) {}
>
>
>
>
>

