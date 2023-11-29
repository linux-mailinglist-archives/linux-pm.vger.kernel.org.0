Return-Path: <linux-pm+bounces-466-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D5B97FD66C
	for <lists+linux-pm@lfdr.de>; Wed, 29 Nov 2023 13:17:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 046A8B21067
	for <lists+linux-pm@lfdr.de>; Wed, 29 Nov 2023 12:17:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D73B1DA24;
	Wed, 29 Nov 2023 12:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D821C1;
	Wed, 29 Nov 2023 04:17:04 -0800 (PST)
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-6d8572850d3so2502a34.0;
        Wed, 29 Nov 2023 04:17:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701260224; x=1701865024;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pvwOohdASXCmhvC8e8r/93X0bNZ1/T9LRttQJCmrblQ=;
        b=X5q/4OdQrRRowSA/Mh5F3OIWqZmhOdNq0eKTixv4lJM6ezZ9euWHy+kBwHaIr5O5D3
         nL3PhcDYctxSbzZq0PqeMELKeMfGKNPfvncjwbcoS+oBHVQLWxbck+K9pYolr969VVxJ
         dDnW7JeqLveYxGo3XPS6iyLUJ6Wnxzl0ibmjg0fpT9xRYDQcIbybmFlXqPkDcF7FRkKZ
         BkXTmbOiEIYJ1FLqFv0GSPHvojzO6TXJU14XO5qzG45TWPopa/paCNZ/5Ib/bvin4do/
         LJBUKFNgH9aWmKZ7mCOBdtaj4YO+7IEDa4hLRbmJxTbbthu8puWWVEIr29Mcaky/nDcQ
         Cr2g==
X-Gm-Message-State: AOJu0Yw0LiXBaQfOT757GergN3QDQ8mljih37E+rMuhBJ+vkxuonpSkK
	8QCYX78JqUBRXCcSODRs0glQEF0L2/yERvUM4ehGfWOR
X-Google-Smtp-Source: AGHT+IFXKMyZBEsXyUWSkYuOoPOl0vkkFqEafy8hA9amO+Nz/XXKE0MoF9CRKwYKHWwdOiHgkkgTR3yY65eUlzLMgL8=
X-Received: by 2002:a4a:e89b:0:b0:58d:8879:7005 with SMTP id
 g27-20020a4ae89b000000b0058d88797005mr9041459ooe.0.1701260223539; Wed, 29 Nov
 2023 04:17:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <6010559.lOV4Wx5bFT@kreacher> <1887866.tdWV9SEqCh@kreacher> <8524d5f3-6204-44a2-aded-694769dfadd2@arm.com>
In-Reply-To: <8524d5f3-6204-44a2-aded-694769dfadd2@arm.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 29 Nov 2023 13:16:51 +0100
Message-ID: <CAJZ5v0i4d8vu9FGfzqKOLnLn6YvFmEbSVEk9AxXDAcqBM+yRbA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] thermal: trip: Rework thermal_zone_set_trip() and
 its callers
To: Lukasz Luba <lukasz.luba@arm.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, LKML <linux-kernel@vger.kernel.org>, 
	Linux PM <linux-pm@vger.kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, 
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Zhang Rui <rui.zhang@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 28, 2023 at 10:42=E2=80=AFPM Lukasz Luba <lukasz.luba@arm.com> =
wrote:
>
>
>
> On 11/28/23 13:58, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > Both trip_point_temp_store() and trip_point_hyst_store() use
> > thermal_zone_set_trip() to update a given trip point, but none of them
> > actually needs to change more than one field in struct thermal_trip
> > representing it.  However, each of them effectively calls
> > __thermal_zone_get_trip() twice in a row for the same trip index value,
> > once directly and once via thermal_zone_set_trip(), which is not
> > particularly efficient, and the way in which thermal_zone_set_trip()
> > carries out the update is not particularly straightforward.
> >
> > Moreover, some checks done by them both need not go under the thermal
> > zone lock and code duplication between them can be reduced quite a bit
> > by moving the majority of logic into thermal_zone_set_trip().
> >
> > Rework all of the above functions to address the above.
> >
> > No intentional functional impact.
> >
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > ---
> >
> > v1 -> v2:
> >     * Fix 2 typos in the changelog (Lukasz).
> >     * Split one change into the [1/2].
> >
> > ---
> >   drivers/thermal/thermal_core.h  |    9 ++++++
> >   drivers/thermal/thermal_sysfs.c |   52 ++++++++----------------------=
----
> >   drivers/thermal/thermal_trip.c  |   60 +++++++++++++++++++++++++++---=
----------
> >   include/linux/thermal.h         |    3 --
> >   4 files changed, 62 insertions(+), 62 deletions(-)
> >
>
> [snip]
>
> > Index: linux-pm/drivers/thermal/thermal_trip.c
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > --- linux-pm.orig/drivers/thermal/thermal_trip.c
> > +++ linux-pm/drivers/thermal/thermal_trip.c
> > @@ -148,39 +148,61 @@ int thermal_zone_get_trip(struct thermal
> >   EXPORT_SYMBOL_GPL(thermal_zone_get_trip);
> >
> >   int thermal_zone_set_trip(struct thermal_zone_device *tz, int trip_id=
,
> > -                       const struct thermal_trip *trip)
> > +                       enum thermal_set_trip_target what, const char *=
buf)
> >   {
> > -     struct thermal_trip t;
> > -     int ret;
> > +     struct thermal_trip *trip;
> > +     int val, ret =3D 0;
> >
> > -     ret =3D __thermal_zone_get_trip(tz, trip_id, &t);
> > +     if (trip_id < 0 || trip_id >=3D tz->num_trips)
> > +             ret =3D -EINVAL;
>
> That shouldn't progress forward IMO, but simply 'return -EINVAL;'...

Good catch, thank you!

> > +
> > +     ret =3D kstrtoint(buf, 10, &val);
> >       if (ret)
> >               return ret;
> >
> > -     if (t.type !=3D trip->type)
> > -             return -EINVAL;
> > +     mutex_lock(&tz->lock);
> >
> > -     if (t.temperature !=3D trip->temperature && tz->ops->set_trip_tem=
p) {
> > -             ret =3D tz->ops->set_trip_temp(tz, trip_id, trip->tempera=
ture);
> > -             if (ret)
> > -                     return ret;
> > -     }
> > +     trip =3D &tz->trips[trip_id];
>
> ... because here we might get an issue.

Right.

