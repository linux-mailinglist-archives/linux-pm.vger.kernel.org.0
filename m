Return-Path: <linux-pm+bounces-30689-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D412B01E2F
	for <lists+linux-pm@lfdr.de>; Fri, 11 Jul 2025 15:47:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 24AA4B46072
	for <lists+linux-pm@lfdr.de>; Fri, 11 Jul 2025 13:37:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AAAB2D3EEF;
	Fri, 11 Jul 2025 13:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Aosvcl0j"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51F362D23A8;
	Fri, 11 Jul 2025 13:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752241119; cv=none; b=gf0IjxWpvaGLWlHaHyqn9FygAKiK0U68ohmLxg5M6CVsgMwbJULp8XRYqHZLam44xgYm1xPD/VrVzQUdZEjpD8JXLF4BzudZ+vcfs7tJ+qiMn160h9TmqlOnBC11LjC2mvthk20jZIrX+jzUHDUvYL38JDPCcBk6fq+QXiiJvoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752241119; c=relaxed/simple;
	bh=qg3xY2/HgJscQ2VM1YpaZCUjLcftxHsmQRggYQz9qU8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jcMCNtVoCmwUt1k5HtZxa/YVbfB+U1wAyBg+KB+f7+lFFdf5Gadj8h2aMAUGu2ZoIYmVyuU5dn+uurBcif4FupIgPb6olbgIDgprvd3Sm8CSw2qWsedxbWmW9lGaOASm2qfiZ2ZlTo1dzCelopv/+ThZz2Pk6YgqtilzEeVsV6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Aosvcl0j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3060C4CEF7;
	Fri, 11 Jul 2025 13:38:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752241118;
	bh=qg3xY2/HgJscQ2VM1YpaZCUjLcftxHsmQRggYQz9qU8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Aosvcl0jaIfFEbC50RoKVUnYkUgRc23lHWm6uohyyDKh/nV6hJypqcRuas3Y5FcK2
	 W6WG4x16hbp6KlRnc2Ms0BVYLF7iQ8Jlp7PPNFpUBev9CM8oLZBoEjnatPVdlDQxUB
	 7PBGH49fTvLXRBSvVrAQB9B9V+zpP1sZfd0ttXS+HxpwBRirNLyamv+IOPkiRxPuav
	 xeSxoL45SBc/y/gx4XQB37P7U2yJkEsWCZ5VudjBTzuCHoOMNqbtcvpfnX4pT7B8pB
	 2YP+Da6Rzic2TZl3oyw2KZOCRM/OJLxLCvkxKUj20Nc0jfNm1b2+/2kUqSC5pgi37t
	 QRBnIBf4QtMhQ==
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-60d6303a11eso1065787eaf.0;
        Fri, 11 Jul 2025 06:38:38 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUrWX/JiU+EfP+UcTiGtnymPLz1XBPzM+e0BfiUrb6zTKIW6LY+0wE84+rObGL9np4M3M3jzwgTT+g=@vger.kernel.org, AJvYcCXwAwmGKlPBSsPSmxxCOKC2T6fkkQt1LLhEyJskdilBhzAsHHLRa46PQ1krA7MfVtj5bRa99GTmgNibPPI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxwGkWxh/dfvVPECj56f4vjO15986Fj3HJJuyul5M1XzHOiLHkZ
	U4qTrLwMecDG4mBvv226l5CXSryqnwQplE2oBfds0qls1oicLxoR450JoUdWWBsAnxwaOtCfxCE
	hcU8cz9XIEPqjh6O71kofO8k/s2kdZeI=
X-Google-Smtp-Source: AGHT+IG4SzIger8lmdH/2c2jOiMFelyYhZ0Pagn3uEV9mk26bhbHjQA8BYWtneEv/bF9FIzgjeImMmaO8qfafWAlGI8=
X-Received: by 2002:a05:6820:4b89:b0:611:aabf:2b7d with SMTP id
 006d021491bc7-613e7b790b5mr1838085eaf.7.1752241117864; Fri, 11 Jul 2025
 06:38:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <10629535.nUPlyArG6x@rjwysocki.net> <22630663.EfDdHjke4D@rjwysocki.net>
 <e13740a0-88f3-4a6f-920f-15805071a7d6@linaro.org>
In-Reply-To: <e13740a0-88f3-4a6f-920f-15805071a7d6@linaro.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 11 Jul 2025 15:38:26 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hpPOHNYCSTM1bb+p-wyAZkpg+k-huf9f5df9_S8MfvEg@mail.gmail.com>
X-Gm-Features: Ac12FXyyiiCbv0PGVuH30NxD7-s09TXpTTgt8RRmqmHoWunsj6wg5WVj3m0Xs_I
Message-ID: <CAJZ5v0hpPOHNYCSTM1bb+p-wyAZkpg+k-huf9f5df9_S8MfvEg@mail.gmail.com>
Subject: Re: [PATCH v3 1/5] PM: sleep: Resume children after resuming the parent
To: Tudor Ambarus <tudor.ambarus@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, Alan Stern <stern@rowland.harvard.edu>, 
	Ulf Hansson <ulf.hansson@linaro.org>, Johan Hovold <johan@kernel.org>, 
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, Jon Hunter <jonathanh@nvidia.com>, 
	Saravana Kannan <saravanak@google.com>, William McVicker <willmcvicker@google.com>, 
	Peter Griffin <peter.griffin@linaro.org>, =?UTF-8?Q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 11, 2025 at 3:08=E2=80=AFPM Tudor Ambarus <tudor.ambarus@linaro=
.org> wrote:
>
>
> Hi, Rafael,
>
> On 3/14/25 12:50 PM, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > According to [1], the handling of device suspend and resume, and
> > particularly the latter, involves unnecessary overhead related to
> > starting new async work items for devices that cannot make progress
> > right away because they have to wait for other devices.
> >
> > To reduce this problem in the resume path, use the observation that
> > starting the async resume of the children of a device after resuming
> > the parent is likely to produce less scheduling and memory management
> > noise than starting it upfront while at the same time it should not
> > increase the resume duration substantially.
> >
> > Accordingly, modify the code to start the async resume of the device's
> > children when the processing of the parent has been completed in each
> > stage of device resume and only start async resume upfront for devices
> > without parents.
> >
> > Also make it check if a given device can be resumed asynchronously
> > before starting the synchronous resume of it in case it will have to
> > wait for another that is already resuming asynchronously.
> >
> > In addition to making the async resume of devices more friendly to
> > systems with relatively less computing resources, this change is also
> > preliminary for analogous changes in the suspend path.
> >
> > On the systems where it has been tested, this change by itself does
> > not affect the overall system resume duration in a measurable way.
> >
> > Link: https://lore.kernel.org/linux-pm/20241114220921.2529905-1-saravan=
ak@google.com/ [1]
> > Suggested-by: Saravana Kannan <saravanak@google.com>
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> I'd like to let you know of a suspend crash that I'm dealing with
> when using the OOT pixel6 drivers on top of v6.16-rc4.

Well, thanks, but there's not much I can do about it.

It is also better to start a new thread in such cases than to reply to
a patch submission.

> Similar to what Jon reported, everything gets back to normal if
> I disable pm_async or if I revert the following patches:
> 443046d1ad66 PM: sleep: Make suspend of devices more asynchronous
> aa7a9275ab81 PM: sleep: Suspend async parents after suspending children
> 0cbef962ce1f PM: sleep: Resume children after resuming the parent
>
> I also reverted their fixes when testing:
> 8887abccf8aa PM: sleep: Add locking to dpm_async_resume_children()
> d46c4c839c20 PM: sleep: Fix power.is_suspended cleanup for direct-complet=
e devices
> 079e8889ad13 PM: sleep: Fix list splicing in device suspend error paths
>
> It seems that the hang happens in dpm_suspend() at
> async_synchronize_full() time after a driver fails to suspend.
> The phone then naturally resets with an APC watchdog.
>
> [  519.142279][ T7917] lwis lwis-eeprom-m24c64x: Can't suspend because ee=
prom-m24c64x is in use!
> [  519.143556][ T7917] lwis-i2c eeprom@2: PM: dpm_run_callback(): platfor=
m_pm_suspend returns -16
> [  519.143872][ T7917] lwis-i2c eeprom@2: PM: platform_pm_suspend returne=
d -16 after 1596 usecs
> [  519.144197][ T7917] lwis-i2c eeprom@2: PM: failed to suspend: error -1=
6
> [  519.144448][ T7917] PM: tudor: dpm_suspend: after while loop, list_emp=
ty(&dpm_prepared_list)? 1
> [  519.144779][ T7917] PM: tudor: dpm_suspend: before async_synchronize_f=
ull
>
> The extra prints are because of:
> diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
> index d9d4fc58bc5a..3efe538c2ec2 100644
> --- a/drivers/base/power/main.c
> +++ b/drivers/base/power/main.c
> @@ -1967,10 +1967,15 @@ int dpm_suspend(pm_message_t state)
>                         break;
>                 }
>         }
> +       pr_err("tudor: %s: after while loop, list_empty(&dpm_prepared_lis=
t)? %d\n",
> +              __func__, list_empty(&dpm_prepared_list));
>
>         mutex_unlock(&dpm_list_mtx);
>
> +       pr_err("tudor: %s: before async_synchronize_full\n", __func__);
>         async_synchronize_full();
> +       pr_err("tudor: %s: after async_synchronize_full();\n", __func__);
> +
>         if (!error)
>                 error =3D async_error;
>
> The synchronous suspend works because its strict, one-by-one ordering
> ensures that device dependencies are met and that no device is suspended
> while another is still using it. The asynchronous suspend fails because
> it creates a race condition where the lwis-eeprom-m24c64x is called for
> suspension before the process using it has been suspended, leading to a
> fatal "device busy" error. Should the failure of a device suspend be
> fatal?

It shouldn't in principle, but it depends on what exactly is involved and h=
ow.

It looks like something is blocking on power.completion somewhere.
I'll check the code, maybe a complete() is missing in an error path or
similar.

Thanks!

