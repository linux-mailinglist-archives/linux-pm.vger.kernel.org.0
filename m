Return-Path: <linux-pm+bounces-8864-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 03483902060
	for <lists+linux-pm@lfdr.de>; Mon, 10 Jun 2024 13:29:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C3651C20866
	for <lists+linux-pm@lfdr.de>; Mon, 10 Jun 2024 11:29:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 034777BB17;
	Mon, 10 Jun 2024 11:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mZEhh/4X"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE28FFC01;
	Mon, 10 Jun 2024 11:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718018979; cv=none; b=Cmi6iZSKdvLF3x5h1QNnW3bSnJ/rd29JcFboZc3vSTQpyTDjXl23X6LJBU/w4C11M4x4emzfLyLvsbutWN44PVWAHLv6oqNdP+4MpHErCSXtaDU7TgPxUNQjoCQOVc576Cw1Uvc53smvKxlLOx5kBPK2QCESc9NiFbMeckLSyRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718018979; c=relaxed/simple;
	bh=jk8n/cQIyOtPlDlv0It//nz2b1lfoB7isGVlvjgPBQc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JQdZhhTe0RcvmjjyIlK2iY4YGOT17Gz78KnMamqiR08jL10LPtuNHR6sEfZ9fE/zCSfHkNAx/PMaSIjYKlvX3AgtzBEd5L2ZcC5qvkcz/aZ+cQ2pJ4xb48qItvL8tdueLb5wQ02JKfIM/g/bhiF9K1onwamFZZNTRe8KwIqkRUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mZEhh/4X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A587CC2BBFC;
	Mon, 10 Jun 2024 11:29:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718018979;
	bh=jk8n/cQIyOtPlDlv0It//nz2b1lfoB7isGVlvjgPBQc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=mZEhh/4XtnFBVFQ+oCfOitN6iUToxytSUyLnvo4esaZcNIIUJ6I+RZAZINgWnP3VC
	 DTF8VTzBszwrY96qvSc1Hl8qrMRsqbZiykPkHLXBkUUSMHWux9bpJcgvsJazlclDka
	 O20JdMbK6w3xfHmwugI+Ub+k43TJy7AvRun0Cs4VPGOh91snypGWVL3niUKlC7p9BU
	 9iJq9lEs7QhW9obK+QAXlVwfLYtSxcZ/+dEbcHR/u7BcCmN4wF4De38dq10LiamcgL
	 Qh04fxO+5nij/q8MFE9tW5ihuXJ4jvqoWgtjYrnR7a+FT8OE7AII37M0JE/bJl444E
	 GpW57aaixxVRg==
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-5bad97708efso85687eaf.1;
        Mon, 10 Jun 2024 04:29:39 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCW2owVxxHv4rXo6Uqz5MTZFg1bS0Bq3Kdb63ymDCImNNBULFEVh4SLhA2ErY1Q7B1xcqV9a5UAyyykEjGORvxgcyAI5y/ZMX+OkW/ZHGzgUG70KmpjR78Mcm0p+SFF2qvC3kz03WYA=
X-Gm-Message-State: AOJu0Ywx/GXZQlnaBlzbG4l9T4vN1YzjILkZL5kJmfZvqewRTMaKeUuT
	lzRjHZquZE00MZYw+VFsLqY6MSU2TY0si3tXqQbJ1ZFd6loxDUA0b4Oiml+kpQWqMw+PC8YxYWU
	sjqVRSGVFSHqWKspfKd/x5HJ5ShQ=
X-Google-Smtp-Source: AGHT+IFulN2unXwc1L7agr2DsGYMhygNQU3qwwquX/cTjQrJdCFtBWg0onO2jdkYVE83IVb5MArYJMaQ4hcIXwtGoHg=
X-Received: by 2002:a4a:a788:0:b0:5ba:ca8a:6598 with SMTP id
 006d021491bc7-5baca8a70b5mr7692336eaf.0.1718018978887; Mon, 10 Jun 2024
 04:29:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <5794974.DvuYhMxLoT@kreacher> <2337425.ElGaqSPkdT@kreacher> <dd446bf6-05ca-4861-b3b1-f113c3528f13@linaro.org>
In-Reply-To: <dd446bf6-05ca-4861-b3b1-f113c3528f13@linaro.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 10 Jun 2024 13:29:27 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0jku1tptD3O=x-rptgUWGQFOQT-U3rsxk9k4XXsyeq3Kw@mail.gmail.com>
Message-ID: <CAJZ5v0jku1tptD3O=x-rptgUWGQFOQT-U3rsxk9k4XXsyeq3Kw@mail.gmail.com>
Subject: Re: [PATCH v2 2/8] thermal/debugfs: Do not extend mitigation episodes
 beyond system resume
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Lukasz Luba <lukasz.luba@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 10, 2024 at 10:28=E2=80=AFAM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
>
> On 28/05/2024 16:53, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > Because thermal zone handling by the thermal core is started from
> > scratch during resume from system-wide suspend, prevent the debug
> > code from extending mitigation episodes beyond that point by ending
> > the mitigation episode currently in progress, if any, for each thermal
> > zone.
>
> Why it is done at resume time and not at suspend time ?

Because it is related to thermal_zone_device_init() which also runs at
the resume time, so IMV it's better to keep these two pieces together.

Why would it be better to run this during suspend?

> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > ---
> >
> > v1 -> v2: Rebase.
> >
> > ---
> >   drivers/thermal/thermal_core.c    |    1 +
> >   drivers/thermal/thermal_debugfs.c |   36 ++++++++++++++++++++++++++++=
++++++++
> >   drivers/thermal/thermal_debugfs.h |    2 ++
> >   3 files changed, 39 insertions(+)
> >
> > Index: linux-pm/drivers/thermal/thermal_core.c
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > --- linux-pm.orig/drivers/thermal/thermal_core.c
> > +++ linux-pm/drivers/thermal/thermal_core.c
> > @@ -1641,6 +1641,7 @@ static void thermal_zone_device_resume(s
> >
> >       tz->suspended =3D false;
> >
> > +     thermal_debug_tz_resume(tz);
> >       thermal_zone_device_init(tz);
> >       __thermal_zone_device_update(tz, THERMAL_EVENT_UNSPECIFIED);
> >
> > Index: linux-pm/drivers/thermal/thermal_debugfs.c
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > --- linux-pm.orig/drivers/thermal/thermal_debugfs.c
> > +++ linux-pm/drivers/thermal/thermal_debugfs.c
> > @@ -926,3 +926,39 @@ void thermal_debug_tz_remove(struct ther
> >       thermal_debugfs_remove_id(thermal_dbg);
> >       kfree(trips_crossed);
> >   }
> > +
> > +void thermal_debug_tz_resume(struct thermal_zone_device *tz)
> > +{
> > +     struct thermal_debugfs *thermal_dbg =3D tz->debugfs;
> > +     ktime_t now =3D ktime_get();
> > +     struct tz_debugfs *tz_dbg;
> > +     struct tz_episode *tze;
> > +     int i;
> > +
> > +     if (!thermal_dbg)
> > +             return;
> > +
> > +     mutex_lock(&thermal_dbg->lock);
> > +
> > +     tz_dbg =3D &thermal_dbg->tz_dbg;
> > +
> > +     if (!tz_dbg->nr_trips)
> > +             goto out;
> > +
> > +     /*
> > +      * A mitigation episode was in progress before the preceding syst=
em
> > +      * suspend transition, so close it because the zone handling is s=
tarting
> > +      * over from scratch.
> > +      */
> > +     tze =3D list_first_entry(&tz_dbg->tz_episodes, struct tz_episode,=
 node);
> > +
> > +     for (i =3D 0; i < tz_dbg->nr_trips; i++)
> > +             tz_episode_close_trip(tze, tz_dbg->trips_crossed[i], now)=
;
> > +
> > +     tze->duration =3D ktime_sub(now, tze->timestamp);
> > +
> > +     tz_dbg->nr_trips =3D 0;
> > +
> > +out:
> > +     mutex_unlock(&thermal_dbg->lock);
> > +}
> > Index: linux-pm/drivers/thermal/thermal_debugfs.h
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > --- linux-pm.orig/drivers/thermal/thermal_debugfs.h
> > +++ linux-pm/drivers/thermal/thermal_debugfs.h
> > @@ -7,6 +7,7 @@ void thermal_debug_cdev_remove(struct th
> >   void thermal_debug_cdev_state_update(const struct thermal_cooling_dev=
ice *cdev, int state);
> >   void thermal_debug_tz_add(struct thermal_zone_device *tz);
> >   void thermal_debug_tz_remove(struct thermal_zone_device *tz);
> > +void thermal_debug_tz_resume(struct thermal_zone_device *tz);
> >   void thermal_debug_tz_trip_up(struct thermal_zone_device *tz,
> >                             const struct thermal_trip *trip);
> >   void thermal_debug_tz_trip_down(struct thermal_zone_device *tz,
> > @@ -20,6 +21,7 @@ static inline void thermal_debug_cdev_st
> >                                                  int state) {}
> >   static inline void thermal_debug_tz_add(struct thermal_zone_device *t=
z) {}
> >   static inline void thermal_debug_tz_remove(struct thermal_zone_device=
 *tz) {}
> > +static inline void thermal_debug_tz_resume(struct thermal_zone_device =
*tz) {}
> >   static inline void thermal_debug_tz_trip_up(struct thermal_zone_devic=
e *tz,
> >                                           const struct thermal_trip *tr=
ip) {};
> >   static inline void thermal_debug_tz_trip_down(struct thermal_zone_dev=
ice *tz,
> >
> >
> >
>
> --
> <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software for AR=
M SoCs
>
> Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
> <http://twitter.com/#!/linaroorg> Twitter |
> <http://www.linaro.org/linaro-blog/> Blog
>

