Return-Path: <linux-pm+bounces-35270-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 320CFB9974B
	for <lists+linux-pm@lfdr.de>; Wed, 24 Sep 2025 12:40:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DBFCF3BA61E
	for <lists+linux-pm@lfdr.de>; Wed, 24 Sep 2025 10:40:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A72B2DFF33;
	Wed, 24 Sep 2025 10:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j5MyWP4X"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 461DF2DFA5A
	for <linux-pm@vger.kernel.org>; Wed, 24 Sep 2025 10:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758710427; cv=none; b=AK78HIr5IwlyZMpWnrpeocGyIKkTtRG5FwmpbKVRXjc/NNKlz8hWO5oU6+06xnicyuEMZPTjhp8/xMWOozTdC8bSNQ4Srq+0V7G8S25MrAkndPmxlD75KdHYtKEsBDNLIIgHufR2c6QMrVArT3qsI/bFsum/CkEDKUpZFnsNp3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758710427; c=relaxed/simple;
	bh=q87c/lH5CUMQTHGed3HhLRajBsxA7h0kFcKQs4MPIp0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nznXwDowS7f5ns6J3+OoKioOPOJ30MvEZCSN08AftcWvWmz/N+YHKCmmTjlZq98cY7rf5MLFDLDybnNai+0lk0MGraHRdcAnbbTWbrljb/YzBA9YZyxMO2CBz2BZ4Fs87Mj2NFqFKUF87JvPpbz6ROXj0tXvUAEf6cCSviQNS6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j5MyWP4X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF9CCC19423
	for <linux-pm@vger.kernel.org>; Wed, 24 Sep 2025 10:40:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758710427;
	bh=q87c/lH5CUMQTHGed3HhLRajBsxA7h0kFcKQs4MPIp0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=j5MyWP4XZTT/qb5Pa4ncWy6+3YeUtmttM/8d7v2EWnemmaNtf3ijOpn9XSHny8eAe
	 jtxKqpqHrzIajF1jvv+ImYIUlQsdlziGJKhXlG8X5dV9UHNxog9QJVr9CBVXcF1MWd
	 gaNkO83J7cJzJ6/3Ryl45xGYAPyxAmWih0933nbbIs7z8tbM5VPoPgsXgkI9xbKAb8
	 TPjFfb/XH1Vxtu3GNdxWqQ+3+eK+hHa+0y36V6vSgbhlam8T+s92TmeM4EVxYlI/21
	 eyPCB7arpUdrLqYWMIfch+N8OHrQJp0CqIdr8K5FZzYzopRq9urocJnm1rvceNHw11
	 028kLDaVw/Pkw==
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-6219257cb0fso919513eaf.2
        for <linux-pm@vger.kernel.org>; Wed, 24 Sep 2025 03:40:26 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCW/1tJBBTQCT64aixfLAs2Oq4X+HyBNMVMfyeHrjSFDgU/F0v8N6SdIiy/6xl6S0zJbIj4O7Eg34w==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9R1G8Ge0S/jc/CnKxcCjCgZY6G2++n2R7ir8djTWuPDx41yLV
	x/w9jEbswO32r9gyYUG/wbD2cLnhzDt0CGqU2ZuQo48FKgSF5mdK13kWT30fPNCur2eBUN+ozxX
	x5Oo22+0QahR5uS2hSv6iXzOWoEgXrqk=
X-Google-Smtp-Source: AGHT+IHKm4dDl7MhU8SYfK1f4AfRfLq2zO+oX8dUQ5EHv63cT03ommMhEQvx/CKxDzJFNgUJlVlKmAvtqpHdKtJN7z0=
X-Received: by 2002:a05:6820:611:b0:61e:77ca:2a56 with SMTP id
 006d021491bc7-632fe58834bmr3456285eaf.0.1758710426219; Wed, 24 Sep 2025
 03:40:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <5944379.DvuYhMxLoT@rafael.j.wysocki> <20250923223831.1308685-1-luogf2025@163.com>
In-Reply-To: <20250923223831.1308685-1-luogf2025@163.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 24 Sep 2025 12:40:13 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0htRTTj1QEEmhxBDxYA8oXkg_KP5YrfwyngELDY+Ns1EQ@mail.gmail.com>
X-Gm-Features: AS18NWB1mApL7_DLRGOuTW_lHH7VZ-jo032YvlPSozVsTKP9KexboosMfXG9sYo
Message-ID: <CAJZ5v0htRTTj1QEEmhxBDxYA8oXkg_KP5YrfwyngELDY+Ns1EQ@mail.gmail.com>
Subject: Re: [PATCH v6] ACPI: battery: prevent sysfs_add_battery re-entry on
 rapid events
To: GuangFei Luo <luogf2025@163.com>
Cc: rafael@kernel.org, dan.carpenter@linaro.org, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 24, 2025 at 12:38=E2=80=AFAM GuangFei Luo <luogf2025@163.com> w=
rote:
>
> > On Tuesday, September 23, 2025 7:12:03 PM CEST Rafael J. Wysocki wrote:
> > > On Tue, Sep 23, 2025 at 6:14=E2=80=AFPM GuangFei Luo <luogf2025@163.c=
om> wrote:
> > > >
> > > > The functions battery_hook_add_battery(), battery_hook_remove_batte=
ry(),
> > > > and sysfs_remove_battery() already acquire locks, so their internal
> > > > accesses are safe.
> > >
> > > In fact, there are two locks in use, battery->sysfs_lock and
> > > hook_mutex.  The latter is used for managing hooks and the former is
> > > only used by sysfs_remove_battery(), so it only prevents that functio=
n
> > > from racing with another instance of itself.
> > >
> > > I would suggest using battery->sysfs_lock for protecting battery->bat
> > > in general.
> > >
> > > > acpi_battery_refresh() does check battery->bat, but its child
> > > > functions (sysfs_add_battery() and sysfs_remove_battery()) already
> > > > handle locking.
> > >
> > > What locking?  Before the $subject patch, sysfs_add_battery() doesn't
> > > do any locking at all AFAICS.
> > >
> > > > In acpi_battery_notify(), battery->bat has no lock. However, the
> > > > check of battery->bat is at the very end of the function. During
> > > > earlier calls, battery->bat has already been protected by locks, so
> > > > re-entry will not cause issues.
> > >
> > > All of the battery->bat checks and the code depending on them need to
> > > go under the same lock.  I'd use battery->sysfs_lock for this as
> > > already mentioned above.
> >
> > So my (untested) version of this fix is appended.
> >
> > Note that it explicitly prevents acpi_battery_notify() from racing with
> > addition/removal, PM notifications, and resume.
> >
> > ---
> >  drivers/acpi/battery.c |   36 +++++++++++++++++++++++-------------
> >  1 file changed, 23 insertions(+), 13 deletions(-)
> >
> > --- a/drivers/acpi/battery.c
> > +++ b/drivers/acpi/battery.c
> > @@ -92,7 +92,7 @@ enum {
> >
> >  struct acpi_battery {
> >       struct mutex lock;
> > -     struct mutex sysfs_lock;
> > +     struct mutex update_lock;
> >       struct power_supply *bat;
> >       struct power_supply_desc bat_desc;
> >       struct acpi_device *device;
> > @@ -904,15 +904,12 @@ static int sysfs_add_battery(struct acpi
> >
> >  static void sysfs_remove_battery(struct acpi_battery *battery)
> >  {
> > -     mutex_lock(&battery->sysfs_lock);
> > -     if (!battery->bat) {
> > -             mutex_unlock(&battery->sysfs_lock);
> > +     if (!battery->bat)
> >               return;
> > -     }
> > +
> >       battery_hook_remove_battery(battery);
> >       power_supply_unregister(battery->bat);
> >       battery->bat =3D NULL;
> > -     mutex_unlock(&battery->sysfs_lock);
> >  }
> >
> >  static void find_battery(const struct dmi_header *dm, void *private)
> > @@ -1072,6 +1069,9 @@ static void acpi_battery_notify(acpi_han
> >
> >       if (!battery)
> >               return;
> > +
> > +     guard(mutex)(&battery->update_lock);
> > +
> >       old =3D battery->bat;
> >       /*
> >        * On Acer Aspire V5-573G notifications are sometimes triggered t=
oo
> > @@ -1094,21 +1094,22 @@ static void acpi_battery_notify(acpi_han
> >  }
> >
> >  static int battery_notify(struct notifier_block *nb,
> > -                            unsigned long mode, void *_unused)
> > +                       unsigned long mode, void *_unused)
> >  {
> >       struct acpi_battery *battery =3D container_of(nb, struct acpi_bat=
tery,
> >                                                   pm_nb);
> > -     int result;
> >
> > -     switch (mode) {
> > -     case PM_POST_HIBERNATION:
> > -     case PM_POST_SUSPEND:
> > +     if (mode =3D=3D PM_POST_SUSPEND || mode =3D=3D PM_POST_HIBERNATIO=
N) {
> > +             guard(mutex)(&battery->update_lock);
> > +
> >               if (!acpi_battery_present(battery))
> >                       return 0;
> >
> >               if (battery->bat) {
> >                       acpi_battery_refresh(battery);
> >               } else {
> > +                     int result;
> > +
> >                       result =3D acpi_battery_get_info(battery);
> >                       if (result)
> >                               return result;
> > @@ -1120,7 +1121,6 @@ static int battery_notify(struct notifie
> >
> >               acpi_battery_init_alarm(battery);
> >               acpi_battery_get_state(battery);
> > -             break;
> >       }
> >
> >       return 0;
> > @@ -1198,6 +1198,8 @@ static int acpi_battery_update_retry(str
> >  {
> >       int retry, ret;
> >
> > +     guard(mutex)(&battery->update_lock);
> > +
> >       for (retry =3D 5; retry; retry--) {
> >               ret =3D acpi_battery_update(battery, false);
> >               if (!ret)
> > @@ -1230,7 +1232,7 @@ static int acpi_battery_add(struct acpi_
> >       if (result)
> >               return result;
> >
> > -     result =3D devm_mutex_init(&device->dev, &battery->sysfs_lock);
> > +     result =3D devm_mutex_init(&device->dev, &battery->update_lock);
> >       if (result)
> >               return result;
> >
> > @@ -1262,6 +1264,8 @@ fail_pm:
> >       device_init_wakeup(&device->dev, 0);
> >       unregister_pm_notifier(&battery->pm_nb);
> >  fail:
> > +     guard(mutex)(&battery->update_lock);
> > +
> >       sysfs_remove_battery(battery);
> >
> >       return result;
> > @@ -1281,6 +1285,9 @@ static void acpi_battery_remove(struct a
> >
> >       device_init_wakeup(&device->dev, 0);
> >       unregister_pm_notifier(&battery->pm_nb);
> > +
> > +     guard(mutex)(&battery->update_lock);
> > +
> >       sysfs_remove_battery(battery);
> >  }
> >
> > @@ -1297,6 +1304,9 @@ static int acpi_battery_resume(struct de
> >               return -EINVAL;
> >
> >       battery->update_time =3D 0;
> > +
> > +     guard(mutex)(&battery->update_lock);
> > +
> >       acpi_battery_update(battery, true);
> >       return 0;
> >  }
>
> Thanks for the detailed explanation and the updated version of the fix.
>
> I will test your suggested changes on my platform.
> After verification, I will send a v7 based on your suggestion.

Please just verify and I'll add a changelog and subject to the patch
and submit it.

Thanks!

