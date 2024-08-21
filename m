Return-Path: <linux-pm+bounces-12625-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FF159599D9
	for <lists+linux-pm@lfdr.de>; Wed, 21 Aug 2024 13:29:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D6CBA282FAC
	for <lists+linux-pm@lfdr.de>; Wed, 21 Aug 2024 11:29:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 072F615F41F;
	Wed, 21 Aug 2024 10:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QkOiizMr"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3AC7535DC;
	Wed, 21 Aug 2024 10:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724236231; cv=none; b=nESuOByVcODGhA61MP26rXr+NbOux1s/rWb0yi188745JhkbsKKTejjl94kx4Aoqdv2gYJ1PCBSB5ZA9LrXwBRwppJuXVcZQg9q9a6tqyRxe0KKlKs0M2vcIbT3GwG8db9KURuHw6wvZ3LLZ0JDyjytNQCFpbGaMZGD3adnXMVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724236231; c=relaxed/simple;
	bh=aL0Eh20Xzp2QPe0IEwgA0/CCHweLpWex7gFVHvzwQO8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aE9ANjVop2q1Xf+z34eMkcM+mH62tdnFpfRDfcZJ7UUaXEJRO4HrPWL8jnS9o8M5vU8Azz+ZJVRwIVp9xCGMW90unD7XHP8WDuEEqLITPAMGJtu1B4dhhS4wE5Jel8uVBOl9yg0dysSm4AcQp7mpXxhRcR4UcbfUpzpxYoIIKjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QkOiizMr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3CADC4AF09;
	Wed, 21 Aug 2024 10:30:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724236229;
	bh=aL0Eh20Xzp2QPe0IEwgA0/CCHweLpWex7gFVHvzwQO8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=QkOiizMrpwzBVKekRYr7Ef0xozT9PuhiXjiLIjFec1k5mU2ap1q44u9CZuh/gK56b
	 He3Uc2NX6yw59vb7g/PNiT5I9XDMpnAMPNQa9xltQSp3lElR6kUDXxgiOQv8VunqIN
	 +ldmRpe/MM8ZbEQHTufiLLkeK5MfDfXd0XUj9vopbywyW8CNrI6GOe8Lk+m0GzBtui
	 yc8mnXAZnQwC2/HxqzUz/xLaBy0gDyiNxBPZ79RmgsE52ZtUB7aw0gdnnP0ggbetD3
	 0OXR6mJy0Mjv7Acb5ccShCbm5nO2Pmf7jYcORU69EDnoqle8nwtgYmARd8CvhRvAHh
	 P3H7B0DYg2Lnw==
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-2705d31a35cso2112673fac.0;
        Wed, 21 Aug 2024 03:30:29 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWNGjrLh9yUljy5guhrNNOv8P1xFfHZNi70A4cvrTUMlfLKxKnCeBqYXx+x9nL+L32dLtu8R33WHHbjEK0=@vger.kernel.org, AJvYcCXYxkHWPzu1WUorLgZlMieDy+XFSBZ2mrjA0reOfQK64Pk3GxuWkOkUdWVGiQFED58drXgZuzuEVy4=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywg+lCDgRHFgWjWT6gan4MoBmlFcQJVhnDw8C3t5LJxeFtispsS
	Dma0pWQKGBCDzN990Wuh/jbUh5uyp/Ec+fZtveWNIGT5IUr0wqwFyOZ6Pz7TowhciGM1mIJuspf
	f9MR2JsSaAoOS6OspfB7PuwD9AN4=
X-Google-Smtp-Source: AGHT+IHpxOkGB6dF/CC7IbZmNrRcs63/sVfqx6uESXYOsPs7jyyBFx6RdsLcVv5dedNwcWx84i+QFkVdVDlxTsGnBqc=
X-Received: by 2002:a05:6870:9a14:b0:261:ab8:3de4 with SMTP id
 586e51a60fabf-2737ef23c97mr1790106fac.15.1724236228974; Wed, 21 Aug 2024
 03:30:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2205737.irdbgypaU6@rjwysocki.net> <3837835.kQq0lBPeGt@rjwysocki.net>
 <6bf771b0-d57d-5a8c-ec36-6f8a041695d9@huawei.com> <CAJZ5v0i_Z43bLWsa9gg_SZFBURi1XrZn4Cnxurm8KCawAWqtUA@mail.gmail.com>
 <93639d68-e396-a782-410c-f7827dbd54f5@huawei.com>
In-Reply-To: <93639d68-e396-a782-410c-f7827dbd54f5@huawei.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 21 Aug 2024 12:30:17 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0gci_a23e=siMWRQGHAUiiHDUtPgZtWWfNW066ENdv5tw@mail.gmail.com>
Message-ID: <CAJZ5v0gci_a23e=siMWRQGHAUiiHDUtPgZtWWfNW066ENdv5tw@mail.gmail.com>
Subject: Re: [PATCH v3 05/14] thermal: core: Move thermal zone locking out of
 bind/unbind functions
To: "lihuisong (C)" <lihuisong@huawei.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, 
	Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>, Lukasz Luba <lukasz.luba@arm.com>, 
	Zhang Rui <rui.zhang@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 21, 2024 at 11:02=E2=80=AFAM lihuisong (C) <lihuisong@huawei.co=
m> wrote:
>
>
> =E5=9C=A8 2024/8/20 18:27, Rafael J. Wysocki =E5=86=99=E9=81=93:
> > On Tue, Aug 20, 2024 at 10:27=E2=80=AFAM lihuisong (C) <lihuisong@huawe=
i.com> wrote:
> >>
> >> =E5=9C=A8 2024/8/19 23:58, Rafael J. Wysocki =E5=86=99=E9=81=93:
> >>> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >>>
> >>> Since thermal_bind_cdev_to_trip() and thermal_unbind_cdev_from_trip()
> >>> acquire the thermal zone lock, the locking rules for their callers ge=
t
> >>> complicated.  In particular, the thermal zone lock cannot be acquired
> >>> in any code path leading to one of these functions even though it mig=
ht
> >>> be useful to do so.
> >>>
> >>> To address this, remove the thermal zone locking from both these
> >>> functions, add lockdep assertions for the thermal zone lock to both
> >>> of them and make their callers acquire the thermal zone lock instead.
> >>>
> >>> No intentional functional impact.
> >>>
> >>> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >>> ---
> >>>
> >>> v2 -> v3: Rebase after dropping patches [04-05/17] from the series
> >>>
> >>> v1 -> v2: No changes
> >>>
> >>> ---
> >>>    drivers/acpi/thermal.c         |    2 +-
> >>>    drivers/thermal/thermal_core.c |   30 ++++++++++++++++++++++------=
--
> >>>    2 files changed, 23 insertions(+), 9 deletions(-)
> >>>
> >>> Index: linux-pm/drivers/thermal/thermal_core.c
> >>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >>> --- linux-pm.orig/drivers/thermal/thermal_core.c
> >>> +++ linux-pm/drivers/thermal/thermal_core.c
> >>> @@ -785,6 +785,7 @@ int thermal_bind_cdev_to_trip(struct the
> >>>        int result;
> >>>
> >> <snip>
> >>> Index: linux-pm/drivers/acpi/thermal.c
> >>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >>> --- linux-pm.orig/drivers/acpi/thermal.c
> >>> +++ linux-pm/drivers/acpi/thermal.c
> >>> @@ -609,7 +609,7 @@ static int acpi_thermal_bind_unbind_cdev
> >>>                .thermal =3D thermal, .cdev =3D cdev, .bind =3D bind
> >>>        };
> >>>
> >>> -     return for_each_thermal_trip(thermal, bind_unbind_cdev_cb, &bd)=
;
> >>> +     return thermal_zone_for_each_trip(thermal, bind_unbind_cdev_cb,=
 &bd);
> >> If so, it seems that the for_each_thermal_trip() can be removed or no
> >> need to export.
> > I beg to differ:
> >
> > $ git grep for_each_thermal_trip | head -1
> > drivers/net/wireless/intel/iwlwifi/mvm/tt.c:
> > for_each_thermal_trip(mvm->tz_device.tzone, iwl_trip_temp_cb, &twd);
> Can we modify it for tt.c?

Not really.

tt.c invokes this under the thermal zone lock, so it cannot use the
"locked" variant.

> It doesn't seem to keep two interfaces. I'm a little confused for that.

The difference between for_each_thermal_trip() and
thermal_zone_for_each_trip() is "unlocked" vs "locked", respectively.
It may just be a question of naming ...

