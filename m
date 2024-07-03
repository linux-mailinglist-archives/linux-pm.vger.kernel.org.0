Return-Path: <linux-pm+bounces-10560-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 91701926976
	for <lists+linux-pm@lfdr.de>; Wed,  3 Jul 2024 22:21:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B8C31F219A4
	for <lists+linux-pm@lfdr.de>; Wed,  3 Jul 2024 20:21:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 033551850A8;
	Wed,  3 Jul 2024 20:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rnACx6JV"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDD22130A7C;
	Wed,  3 Jul 2024 20:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720038064; cv=none; b=r34E4m6frZB23x9ov3NN99SHxwIRTsf43dTn80u+04Q1x5FGslS5GOXSPHI9S5aJK7J+8Th5koQpw5F5E8tgmZxOHMMQvMwvBSk4VvgVMMqb1EW6phJNYYT/V6WTnAkfCHLBRqWju2mg8DmIPwGMb+PU8AyWphrgw9BSjiJIgYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720038064; c=relaxed/simple;
	bh=+YVbne63B3Ojv7G4YC3B73DUyIP921gl3Am3ty/VfXE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OXmmf4XMTUujI3Kml2BGRGj+o4YqkyTUQUym0ZhNEBGQIyjZjB+m1XB+s8u2e+w69j1RcIiiL2JUpyW87ZNS4OlccYDWsvyznwONoj9/CB8rsABALbfh/f8zBTxpyBPCmtBQQLUhyW0+fsOTRZiDwr2HrpkmBjqBaytYOWHTPl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rnACx6JV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A739EC4AF07;
	Wed,  3 Jul 2024 20:21:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720038064;
	bh=+YVbne63B3Ojv7G4YC3B73DUyIP921gl3Am3ty/VfXE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=rnACx6JVh3IOa2V5pWbNDEuRU9O7sOgYK2XHiYUhkrj+lQG2h5uElFPaHbuK5Z95Z
	 hndbeTKazsC3HLy5Oh+kJSaYIXB3ChoYxEvjk5Q2AgIrDYYYUgAICv5iF+p/F8r9ow
	 krushYb/FxyqAWUHXfXzZADwC5+WV/KMuv+izqSaVI9TN8TfYxZGC8xqe6Vx3tEx9+
	 Ms10wScIKuTPDlahKwGxM32baj+ik+/zz1lvKRohF8FXCFO/rI2Rqxu/n1k6iKwP7S
	 N/uBxQ27XrC/nhsKBjnmvVdSMw6SP/B9gKNZEZXlTjPZoh+ez+0HQWWIkUnR728bRk
	 dTKfFlNG3Yjeg==
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-5c47282edfdso23111eaf.1;
        Wed, 03 Jul 2024 13:21:04 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXWXUKLwlLmIKX08B3hWrU09pu2DgXTbCmre0PAWClzZmvM/bmBTBvdbDH0Rab1iELl2H+vba12RWr660XgTRUypM7cYT2no8khcBL3nL+4ix7eUua2E8yw0ftKnjAPzWEbiXNGhZQ=
X-Gm-Message-State: AOJu0YzWXJ/Dz2IVijef0joa9aRm4gqsRVQdOVQscfMXbEj6XDnhXmOL
	q9a8jdDY8Ji8r9kIySKYqXjlZwTbuQrtTHCuKGqms2sGiP8cs7FCaJu7iCEpRnmqVzxlyq6Kx3L
	GAwaOcva+Sbq074bvc+pDfflPcbI=
X-Google-Smtp-Source: AGHT+IG4+4miXEL5h2jhi5yeBJF0jxUhmlh9XbF3dAZynNpqgT25mhwR8vZWa7advZfvenAXl1JtUzocdtKGEUCRO34=
X-Received: by 2002:a4a:ba84:0:b0:5c4:24e0:26cd with SMTP id
 006d021491bc7-5c43902eff0mr12566330eaf.1.1720038063912; Wed, 03 Jul 2024
 13:21:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240702-power-allocator-null-trip-max-v1-1-47a60dc55414@collabora.com>
 <18b1724c-9bab-4501-b956-278896324e55@collabora.com>
In-Reply-To: <18b1724c-9bab-4501-b956-278896324e55@collabora.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 3 Jul 2024 22:20:52 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0jvsCCFFLPd7Rnrssf+WccKMjHX3NJEW5hdbLTriD6Rgg@mail.gmail.com>
Message-ID: <CAJZ5v0jvsCCFFLPd7Rnrssf+WccKMjHX3NJEW5hdbLTriD6Rgg@mail.gmail.com>
Subject: Re: [PATCH] thermal: gov_power_allocator: Return early in manage if
 trip_max is null
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= <nfraprado@collabora.com>, 
	Lukasz Luba <lukasz.luba@arm.com>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, 
	Nikita Travkin <nikita@trvn.ru>, kernel@collabora.com, 
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 3, 2024 at 11:03=E2=80=AFAM AngeloGioacchino Del Regno
<angelogioacchino.delregno@collabora.com> wrote:
>
> Il 02/07/24 23:24, N=C3=ADcolas F. R. A. Prado ha scritto:
> > Commit da781936e7c3 ("thermal: gov_power_allocator: Allow binding
> > without trip points") allowed the governor to bind even when trip_max
> > is null. This allows a null pointer dereference to happen in the manage
> > callback. Add an early return to prevent it, since the governor is
> > expected to not do anything in this case.
> >
> > Fixes: da781936e7c3 ("thermal: gov_power_allocator: Allow binding witho=
ut trip points")
> > Signed-off-by: N=C3=ADcolas F. R. A. Prado <nfraprado@collabora.com>
> > ---
> > This issue was noticed by KernelCI during a boot test on the
> > mt8195-cherry-tomato-r2 platform with the config in [1]. The stack trac=
e
> > is attached below.
> >
> > [1] http://0x0.st/XaON.txt
> >
> > [    4.015786] Unable to handle kernel NULL pointer dereference at virt=
ual address 0000000000000000
> > [    4.015791] Mem abort info:
> > [    4.015793]   ESR =3D 0x0000000096000004
> > [    4.015796]   EC =3D 0x25: DABT (current EL), IL =3D 32 bits
> > [    4.015799]   SET =3D 0, FnV =3D 0
> > [    4.015802]   EA =3D 0, S1PTW =3D 0
> > [    4.015804]   FSC =3D 0x04: level 0 translation fault
> > [    4.015807] Data abort info:
> > [    4.015809]   ISV =3D 0, ISS =3D 0x00000004, ISS2 =3D 0x00000000
> > [    4.015811]   CM =3D 0, WnR =3D 0, TnD =3D 0, TagAccess =3D 0
> > [    4.015814]   GCS =3D 0, Overlay =3D 0, DirtyBit =3D 0, Xs =3D 0
> > [    4.015818] user pgtable: 4k pages, 48-bit VAs, pgdp=3D0000000109809=
000
> > [    4.015821] [0000000000000000] pgd=3D0000000000000000, p4d=3D0000000=
000000000
> > [    4.015835] Modules linked in: mt8195_mt6359(+) mt6577_auxadc snd_so=
c_mt8195_afe mtk_scp_ipi snd_sof_utils mtk_wdt(+)
> > [    4.015852] CPU: 2 PID: 13 Comm: kworker/u32:1 Not tainted 6.10.0-rc=
6 #1 c5d519ae8e7fec6bbe67cb8c50bfebcb89dfa54e
> > [    4.015859] Hardware name: Acer Tomato (rev2) board (DT)
> > [    4.015862] Workqueue: events_unbound deferred_probe_work_func
> > [    4.015875] pstate: 60400009 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BT=
YPE=3D--)
> > [    4.015880] pc : power_allocator_manage+0x110/0x6a0
> > [    4.015888] lr : __thermal_zone_device_update+0x1dc/0x400
> > [    4.015893] sp : ffff8000800eb800
> > [    4.015895] x29: ffff8000800eb810 x28: 0000000000000001 x27: 0000000=
000000001
> > [    4.015903] x26: aaaaaaaaaaaaaaab x25: ffff07a0461c15a0 x24: ffffb58=
530ca67c0
> > [    4.015911] x23: 0000000000000000 x22: ffff07a04098fcc0 x21: ffffb58=
532eec848
> > [    4.015918] x20: ffff8000800eb920 x19: ffff07a0461c1000 x18: 0000000=
000000b4b
> > [    4.015926] x17: 5359534255530031 x16: ffffb585310352e4 x15: 0000000=
000000020
> > [    4.015933] x14: 0000000000000000 x13: ffffffff00000000 x12: 0000000=
000000040
> > [    4.015940] x11: 0101010101010101 x10: ffffffffffffffff x9 : ffffb58=
530ca8d78
> > [    4.015948] x8 : 0101010101010101 x7 : 7f7f7f7f7f7f7f7f x6 : 0000000=
000001388
> > [    4.015955] x5 : 0000000000000000 x4 : 0000000000000384 x3 : 0000000=
000000000
> > [    4.015962] x2 : 0000000000000000 x1 : 0000000000000000 x0 : 0000000=
000000000
> > [    4.015970] Call trace:
> > [    4.015972]  power_allocator_manage+0x110/0x6a0
> > [    4.015978]  __thermal_zone_device_update+0x1dc/0x400
> > [    4.015983]  thermal_zone_device_set_mode+0x7c/0xa0
> > [    4.015987]  thermal_zone_device_enable+0x1c/0x28
> > [    4.015991]  thermal_of_zone_register+0x43c/0x498
> > [    4.015996]  devm_thermal_of_zone_register+0x6c/0xb8
> > [    4.016001]  gadc_thermal_probe+0x140/0x214
> > [    4.016007]  platform_probe+0x70/0xc4
> > [    4.016012]  really_probe+0x140/0x270
> > [    4.016018]  __driver_probe_device+0xfc/0x114
> > [    4.016024]  driver_probe_device+0x44/0x100
> > [    4.016029]  __device_attach_driver+0x64/0xdc
> > [    4.016035]  bus_for_each_drv+0xb4/0xdc
> > [    4.016041]  __device_attach+0xdc/0x16c
> > [    4.016046]  device_initial_probe+0x1c/0x28
> > [    4.016052]  bus_probe_device+0x44/0xac
> > [    4.016057]  deferred_probe_work_func+0xb0/0xc4
> > [    4.016063]  process_scheduled_works+0x114/0x330
> > [    4.016070]  worker_thread+0x1c0/0x20c
> > [    4.016076]  kthread+0xf8/0x108
> > [    4.016081]  ret_from_fork+0x10/0x20
> > [    4.016090] Code: d1030294 17ffffdd f94012c0 f9401ed7 (b9400000)
> > [    4.016095] ---[ end trace 0000000000000000 ]---
> > ---
> >   drivers/thermal/gov_power_allocator.c | 3 +++
> >   1 file changed, 3 insertions(+)
> >
> > diff --git a/drivers/thermal/gov_power_allocator.c b/drivers/thermal/go=
v_power_allocator.c
> > index 45f04a25255a..1b2345a697c5 100644
> > --- a/drivers/thermal/gov_power_allocator.c
> > +++ b/drivers/thermal/gov_power_allocator.c
> > @@ -759,6 +759,9 @@ static void power_allocator_manage(struct thermal_z=
one_device *tz)
> >               return;
> >       }
> >
> > +     if (!params->trip_max)
> > +             return;
> > +
>
> I'm not sure that this is the right thing to do.
>
> If you do that, allocate_power() will never be called, so the entire algo=
 doesn't
> work, making binding this completely useless (as it's going to be a noop.=
.!).
>
> Check what get_governor_trips() says in the documentation:
>
>   * If there is only one trip point, then that's considered to be the
>   * "maximum desired temperature" trip point and the governor is always
>   * on.  If there are no passive or active trip points, then the
>   * governor won't do anything.  In fact, its throttle function
>   * won't be called at all.
>
> ....and it looks like you're aware of that, as you said that in the commi=
t
> description as well.

IIUC, the problematic commit allowed the power allocator governor to
bind to a tripless thermal zone in order to prevent failing the entire
thermal zone registration.

Yes, it will be a noop in this case because in the absence of any
trips there will be nothing to do for it.  Still, user space can check
the zone temperature via sysfs.

Adding a NULL pointer check before the place where the pointer in
question is dereferenced is not a bad idea at all.

