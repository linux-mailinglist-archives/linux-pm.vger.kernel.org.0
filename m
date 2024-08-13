Return-Path: <linux-pm+bounces-12145-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ECFD795030E
	for <lists+linux-pm@lfdr.de>; Tue, 13 Aug 2024 12:57:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 188E6B24179
	for <lists+linux-pm@lfdr.de>; Tue, 13 Aug 2024 10:57:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9A7919D89E;
	Tue, 13 Aug 2024 10:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iBmX1UEk"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B7E419AD94;
	Tue, 13 Aug 2024 10:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723546500; cv=none; b=dJdfPewTvO4+J8osPtV+UhESgCoaX+u/zem9UikvnLDYGZoqasqoLzM3KhWbRuXwE/puiMInZX1/DYqNfNlptGZ/6UVPTQmeZNrFiqHpMxi0UcHfcr5yeVN36/Pkf8t+uL5grn9lA2Ehrw80bIznI+O9uZaxqjNsEtGP1wAchuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723546500; c=relaxed/simple;
	bh=IgePQwkuTUYdG2arpdESjJXbiRl+BVM8HulpiBO0gCo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bCOt9ozJDNQatGwIwPqZvwuu/788CMM9FJbhnAEuUCz0FmftDTedIb7S5sk3RSbJcA27amu7kguAhbedO6B7KBXIi31/ibeWf7/Mv0Zgld6EquhPTZN7l3GV+EzZKhFSta7gNnWUm+o6OKYOLjdtI2a3Rb1YxPlOX9d7PeuyE+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iBmX1UEk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F466C4AF11;
	Tue, 13 Aug 2024 10:54:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723546499;
	bh=IgePQwkuTUYdG2arpdESjJXbiRl+BVM8HulpiBO0gCo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=iBmX1UEkPVnuBWajZkt5bBejMS+d+H1qx7md0Min02BBZQKThGD18PjvnjVnbPuP6
	 D/BJF4HuzrRxtsSCwNcGNZeaiZvyq2AmH06Z1MfkH3UNE2udlD+Z0K8bXmw87KP4hV
	 wbFG3tbV5qBfND0Hxyb+1bqFzsuxLLo2NsqlsWd6l9EyUR2tnMTfDfeKqnsUTsd0W9
	 h1YenruMrWJLu7k0cYtNvLn4EScLd8AoO8RjQ4qaKSqU9ytEbG8BLbYI3WruSmjcKJ
	 JYauAoVTcOZkIX7aYp1yzLqK0vsOwnDPcGcmpaR0fhRTk+WZMlxBwNquzeO0jk8Roa
	 ETSwuFjBaT93w==
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-2611dcc3941so502851fac.3;
        Tue, 13 Aug 2024 03:54:59 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWfwrZal2vuoCySL3buVaS866xoxnG174DxweE6iePyGROjE22n0d9q21IYZBZnXEHDcIFsQ1YiZK6BI6VueMQernsolKlwxYorPH/R
X-Gm-Message-State: AOJu0Ywo/9Gi5zc897RYW1q4bRE5K+u0RTQi6u4WmMC3MCl50U8RLPzT
	QCqPA6j4cf9gUpx/EXHB0BdQmCiHuRczCqgdZKibocW76tu3yuPsaF2sQ1uo5tAOVTEvU+eGXzF
	4TvKUURzWAIALnTAcXzDUt7gltgM=
X-Google-Smtp-Source: AGHT+IGM9SaPME+aAxWFgSxATRGLzPEepbhd0gutOtgToNENQvg4PwJ9NF7LJRNsNyVA7mNPD7bigd2pctKRk+OvMHE=
X-Received: by 2002:a05:6871:70b:b0:260:ccfd:1efe with SMTP id
 586e51a60fabf-26fd1ad5aa0mr1232086fac.6.1723546498358; Tue, 13 Aug 2024
 03:54:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <114901234.nniJfEyVGO@rjwysocki.net> <2819322.BEx9A2HvPv@rjwysocki.net>
 <dd7ffe0d8a14bce8975ff66d84f013a249427a15.camel@intel.com>
In-Reply-To: <dd7ffe0d8a14bce8975ff66d84f013a249427a15.camel@intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 13 Aug 2024 12:54:47 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0gyc73QpMHPiYdm0nKMJtrGg25-C=8Ytamt91rSS=0ONQ@mail.gmail.com>
Message-ID: <CAJZ5v0gyc73QpMHPiYdm0nKMJtrGg25-C=8Ytamt91rSS=0ONQ@mail.gmail.com>
Subject: Re: [PATCH v2 04/17] thermal: core: Clean up cdev binding/unbinding functions
To: "Zhang, Rui" <rui.zhang@intel.com>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>, 
	"lukasz.luba@arm.com" <lukasz.luba@arm.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 13, 2024 at 9:39=E2=80=AFAM Zhang, Rui <rui.zhang@intel.com> wr=
ote:
>
> On Mon, 2024-08-12 at 15:56 +0200, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > Add a new label to thermal_bind_cdev_to_trip() and use it to
> > eliminate
> > two redundant !result check from that function, rename a label in
> > thermal_unbind_cdev_from_trip() to reflect its actual purpose and
> > adjust some white space in these functions.
> >
> > No intentional functional impact.
> >
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > ---
> >
> > v1 -> v2: No changes.
> >
> > ---
> >  drivers/thermal/thermal_core.c |   32 ++++++++++++++++++------------
> > --
> >  1 file changed, 18 insertions(+), 14 deletions(-)
> >
> > Index: linux-pm/drivers/thermal/thermal_core.c
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > --- linux-pm.orig/drivers/thermal/thermal_core.c
> > +++ linux-pm/drivers/thermal/thermal_core.c
> > @@ -806,6 +806,7 @@ int thermal_bind_cdev_to_trip(struct the
> >         dev =3D kzalloc(sizeof(*dev), GFP_KERNEL);
> >         if (!dev)
> >                 return -ENOMEM;
> > +
> >         dev->tz =3D tz;
> >         dev->cdev =3D cdev;
> >         dev->trip =3D trip;
> > @@ -821,8 +822,7 @@ int thermal_bind_cdev_to_trip(struct the
> >
> >         dev->id =3D result;
> >         sprintf(dev->name, "cdev%d", dev->id);
> > -       result =3D
> > -           sysfs_create_link(&tz->device.kobj, &cdev->device.kobj,
> > dev->name);
> > +       result =3D sysfs_create_link(&tz->device.kobj, &cdev-
> > >device.kobj, dev->name);
> >         if (result)
> >                 goto release_ida;
> >
> > @@ -849,24 +849,26 @@ int thermal_bind_cdev_to_trip(struct the
> >
> >         mutex_lock(&tz->lock);
> >         mutex_lock(&cdev->lock);
> > -       list_for_each_entry(pos, &tz->thermal_instances, tz_node)
> > +
> > +       list_for_each_entry(pos, &tz->thermal_instances, tz_node) {
> >                 if (pos->trip =3D=3D trip && pos->cdev =3D=3D cdev) {
> >                         result =3D -EEXIST;
> > -                       break;
> > +                       goto remove_weight_file;
>
> Need to unlock tz->lock and cdev->lock before quitting?

Yes, of course.

Nice catch, thank you!

I'll drop this patch as it's not worth salvaging IMO.

> >                 }
> > -       if (!result) {
> > -               list_add_tail(&dev->tz_node, &tz->thermal_instances);
> > -               list_add_tail(&dev->cdev_node, &cdev-
> > >thermal_instances);
> > -               atomic_set(&tz->need_update, 1);
> > -
> > -               thermal_governor_update_tz(tz, THERMAL_TZ_BIND_CDEV);
> >         }
> > +
> > +       list_add_tail(&dev->tz_node, &tz->thermal_instances);
> > +       list_add_tail(&dev->cdev_node, &cdev->thermal_instances);
> > +       atomic_set(&tz->need_update, 1);
> > +
> > +       thermal_governor_update_tz(tz, THERMAL_TZ_BIND_CDEV);
> > +
> >         mutex_unlock(&cdev->lock);
> >         mutex_unlock(&tz->lock);
> >
> > -       if (!result)
> > -               return 0;
> > +       return 0;
> >
> > +remove_weight_file:
> >         device_remove_file(&tz->device, &dev->weight_attr);
> >  remove_trip_file:
> >         device_remove_file(&tz->device, &dev->attr);
> > @@ -914,6 +916,7 @@ int thermal_unbind_cdev_from_trip(struct
> >
> >         mutex_lock(&tz->lock);
> >         mutex_lock(&cdev->lock);
> > +
> >         list_for_each_entry_safe(pos, next, &tz->thermal_instances,
> > tz_node) {
> >                 if (pos->trip =3D=3D trip && pos->cdev =3D=3D cdev) {
> >                         list_del(&pos->tz_node);
> > @@ -923,15 +926,16 @@ int thermal_unbind_cdev_from_trip(struct
> >
> >                         mutex_unlock(&cdev->lock);
> >                         mutex_unlock(&tz->lock);
> > -                       goto unbind;
> > +                       goto free;
> >                 }
> >         }
> > +
> >         mutex_unlock(&cdev->lock);
> >         mutex_unlock(&tz->lock);
> >
> >         return -ENODEV;
> >
> > -unbind:
> > +free:
> >         device_remove_file(&tz->device, &pos->weight_attr);
> >         device_remove_file(&tz->device, &pos->attr);
> >         sysfs_remove_link(&tz->device.kobj, pos->name);
> >
> >
> >
>

