Return-Path: <linux-pm+bounces-37026-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A459DC1A8BB
	for <lists+linux-pm@lfdr.de>; Wed, 29 Oct 2025 14:11:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 80BCE567597
	for <lists+linux-pm@lfdr.de>; Wed, 29 Oct 2025 13:00:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49477359F91;
	Wed, 29 Oct 2025 12:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XFBsqcdD"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2405234D4F4
	for <linux-pm@vger.kernel.org>; Wed, 29 Oct 2025 12:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761741642; cv=none; b=Qx0BMInZ/pojg4z/138ocgaU+9/mA7fh2mREJ0J85iSV7qxNC+0MaVynYUOQIAwxDE7wkayGRAk4srB6TieIu2p+7FROqMS7FGrF0iWlBs89oc/MgbVaW5iTVGS127IiLh0sGpJp7f2UqNishtgERgchUA+nIvVgin5KGYLQeRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761741642; c=relaxed/simple;
	bh=HLyHzsIaMwJmvkk7chpxGJkKDCM2GZFPnaxVFoPfG2w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SHb63Xe972lBk7AaMvASp5a6FqlTpJciz34jTIhMbWp3wH/fJoHf9c6j5fOwhoe1GSTe997UXV+tUKma+s8DHWCeZrX9Yx2HUtm4qrVoCY9mOxIYlo2x+4EEyw+cWvvmmUL8NFsTNZIIZitl5L4/mmjT3cHbV8oOBkkNHZKIwpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XFBsqcdD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1031C16AAE
	for <linux-pm@vger.kernel.org>; Wed, 29 Oct 2025 12:40:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761741641;
	bh=HLyHzsIaMwJmvkk7chpxGJkKDCM2GZFPnaxVFoPfG2w=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=XFBsqcdD446gGo2qwB9AHKHR60Jqc6qQ4Hzh98+WpBeieeEqlHG7PRVTXPleazCm9
	 E1MRUiI5JZ9djk/L6Pz54PTGH3rA0ZQ8LojBjn4stJm3KwKjiW4Bw3/v72PdZ47lmj
	 e4e1sZ7COVAAeJJ/dNZSqynpVXs32rQTYwVfdNOTqn7IeK2ybJAUwUzxFffTZ17uNc
	 rqTnZqvhASn0m594tTjSbHN39u4jhdsXjTgRBRANZ++GYIC3xlv/Da7iqqj8dYjqwe
	 n4OWldBPasDQnx9tw7o9nc9PCl1oUA/4JHIuRnrH8316NNsCKOWM3DIGMKVyID1ga7
	 5Xf0u41Uv536Q==
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-443a58904efso2864589b6e.0
        for <linux-pm@vger.kernel.org>; Wed, 29 Oct 2025 05:40:41 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVDkrgAJ0F5Cue0AcCRrirW0b7Yz/+Fc9xk6crk7cKpe0bDXYtOQRagwhgf9Q3mvFJb6LFQqBRtKg==@vger.kernel.org
X-Gm-Message-State: AOJu0YybRCEoS4h9C51l/eU/aj8Eq02yaSrByyy2mrsQja4XL+5y1lvN
	n1K+V/RAoJBUNtR+RiUjarJ9zRIpI+zIjCdWZ/X0fVT2wuFg6Ww0FUX6+DaOmebjg5zcaTj4jN9
	pV8VJvTQxmxKl3mk0tSiPDpFcyBZiCRk=
X-Google-Smtp-Source: AGHT+IFLVKnwIIB4XqhE3o7qLBAL4OIdeCzcw/6i3Psjve4CcWWNJZTgMBA+WmTTq+UkAbwEf6DwDvPURJ99rfKYc2U=
X-Received: by 2002:a05:6808:218c:b0:44d:a5ff:dfc5 with SMTP id
 5614622812f47-44f7a54f9efmr1226879b6e.47.1761741641032; Wed, 29 Oct 2025
 05:40:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251028-fix-energy-v1-1-ab854fd6a97c@nxp.com> <40c2f7d9-23cf-4536-a1b1-0a55a0707830@arm.com>
In-Reply-To: <40c2f7d9-23cf-4536-a1b1-0a55a0707830@arm.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 29 Oct 2025 13:40:29 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0hMSNfEVg-PUrzvPLO2oMFRJypgn26w7B8XqsD1_9KT4A@mail.gmail.com>
X-Gm-Features: AWmQ_bkLCpdDmvZP6qSfrPZvMq_s6DscBj09Lsu1HyP9BjEkEcmTkBf7tEIC-I8
Message-ID: <CAJZ5v0hMSNfEVg-PUrzvPLO2oMFRJypgn26w7B8XqsD1_9KT4A@mail.gmail.com>
Subject: Re: [PATCH RFC] PM: EM: Add to em_pd_list only when no failure
To: Lukasz Luba <lukasz.luba@arm.com>, Peng Fan <peng.fan@nxp.com>
Cc: arm-scmi@vger.kernel.org, Sudeep Holla <sudeep.holla@arm.com>, 
	Pavel Machek <pavel@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, 
	Cristian Marussi <cristian.marussi@arm.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Len Brown <lenb@kernel.org>, Changwoo Min <changwoo@igalia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 29, 2025 at 10:00=E2=80=AFAM Lukasz Luba <lukasz.luba@arm.com> =
wrote:
>
>
>
> On 10/28/25 14:23, Peng Fan wrote:
> > When em_create_perf_table() returns failure, pd is freed, there dev->em=
_pd
> > is not valid. Then accessing dev->em_pd->node will trigger kernel panic
> > in em_dev_register_pd_no_update(). So return early if 'ret' is non-zero=
.
> >
> > Kernel dump:
> > cpu cpu0: EM: invalid power: 0
> > Unable to handle kernel NULL pointer dereference at virtual address
> > 0000000000000008
> > Mem abort info:
> > pc : em_dev_register_pd_no_update+0xb4/0x79c
> > lr : em_dev_register_pd_no_update+0x9c/0x79c
> > Call trace:
> >   em_dev_register_pd_no_update+0xb4/0x79c (P)
> >   em_dev_register_perf_domain+0x18/0x58
> >   scmi_cpufreq_register_em+0x84/0xb8
> >   cpufreq_online+0x48c/0xb74
> >   cpufreq_add_dev+0x80/0x98
> >   subsys_interface_register+0x100/0x11c
> >   cpufreq_register_driver+0x158/0x278
> >   scmi_cpufreq_probe+0x1f8/0x2e0
> >   scmi_dev_probe+0x28/0x3c
> >   really_probe+0xbc/0x29c
> >   __driver_probe_device+0x78/0x12c
> >   driver_probe_device+0x3c/0x15c
> >   __device_attach_driver+0xb8/0x134
> >   bus_for_each_drv+0x84/0xe4
> >
> > Fixes: cbe5aeedecc7 ("PM: EM: Assign a unique ID when creating a perfor=
mance domain")
> > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> > ---
> >   kernel/power/energy_model.c | 5 ++++-
> >   1 file changed, 4 insertions(+), 1 deletion(-)
> >
> > diff --git a/kernel/power/energy_model.c b/kernel/power/energy_model.c
> > index e669d5057fca6da9612575a1c626474e60e7f7c4..11af9f64aa8276e47e0a5b2=
d615b227368af5480 100644
> > --- a/kernel/power/energy_model.c
> > +++ b/kernel/power/energy_model.c
> > @@ -693,13 +693,16 @@ int em_dev_register_pd_no_update(struct device *d=
ev, unsigned int nr_states,
> >
> >   unlock:
> >       mutex_unlock(&em_pd_mutex);
> > +     if (ret)
> > +             return ret;
> >
> >       mutex_lock(&em_pd_list_mutex);
> >       list_add_tail(&dev->em_pd->node, &em_pd_list);
> >       mutex_unlock(&em_pd_list_mutex);
> >
> >       em_notify_pd_created(dev->em_pd);
> > -     return ret;
> > +
> > +     return 0;
> >   }
> >   EXPORT_SYMBOL_GPL(em_dev_register_pd_no_update);
> >
> >
> > ---
> > base-commit: f7d2388eeec24966fc4d5cf32d706f0514f29ac5
> > change-id: 20251028-fix-energy-6b63b72ae9c6
> >
> > Best regards,
>
>
> Thank you for the patch!
>
> Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>

Applied, thanks!

