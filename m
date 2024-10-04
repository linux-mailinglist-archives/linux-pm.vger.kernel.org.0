Return-Path: <linux-pm+bounces-15147-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C467B990442
	for <lists+linux-pm@lfdr.de>; Fri,  4 Oct 2024 15:28:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 883BE28283F
	for <lists+linux-pm@lfdr.de>; Fri,  4 Oct 2024 13:28:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 451CA217908;
	Fri,  4 Oct 2024 13:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R+58fu4i"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 193ED215F4A;
	Fri,  4 Oct 2024 13:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728048334; cv=none; b=Ho9hksiFZe81AstNVDTbQaNIYTeNqW04ohrqhi2gHc6ciNeLWyTiwc2HhWbvwSbMwjxW2SXxsRLvll4YtEIKSPSFa/gumsM32AyMds7d26TtlViGeZN+pVrbGgWsDghFRcC2DGwBTQfYPXfGQ1d4qte7gHjNa9migh1hhEPTEfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728048334; c=relaxed/simple;
	bh=WBVZ7UKdnyypyGouTe2l8Jx14RrNbmDRtVhGvKKQBEg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AC8dbOsoL/eDU8cZd6nodt9LWwDhYVwNs60G0m7sa7ZlhVmtPe75aHeQCDBjafutYpMWiAFt9g/NtoUdsDTRlBu0sI3tZOTCQWGwytyorJMrE6eXt41NGsPNYEOQ3t+5DXQQ0Pq44D1UiYpQC9MK/lSW35QQo2Ebiwm+8k9z878=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R+58fu4i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F58DC4AF09;
	Fri,  4 Oct 2024 13:25:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728048333;
	bh=WBVZ7UKdnyypyGouTe2l8Jx14RrNbmDRtVhGvKKQBEg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=R+58fu4i/A2SM0RBrwwJrF/ZFXbnW9WmekQfVIi0hABJrnrQ/xBsiCZUDvK8RjuiT
	 pO38dWZpfvwxp+RUzc7U8vFaeYm+hqm+RGvb9TixZOserYzRfvvo1EB+Cq/n9/hQW8
	 II3cPi5InTEu0BHBuU9aNv1gGuC/yjVkVXDsPZ5UE9M47EgPNqlfNbg4vU3rd+t++c
	 /RKpQ8X66G2wDT4Py/57EWn14m0mkBp6fEsEf05Itq28OBdHkb0YE8zrVN4xNLEgfa
	 Hh7hSrlgSl8WRhkymQUhlngx4KyTz28Nz3WjuzZKELokPY+ys+j5dpSjnwm33GjLep
	 BoxzA/zteLQiA==
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-710f0415ac8so1051112a34.1;
        Fri, 04 Oct 2024 06:25:33 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUv2CTDt8A7EHriq1YCo5/ZCgEq1AF/CiNK4Vay+HM6O4cGpyoSIzCDIV8Pgc+2Hxe+P5/L2Hmv/nZ5u0Y=@vger.kernel.org, AJvYcCXjweE0SfQ6OYTZX+jBcPZyC5UAOdR0Nn+mPE/DHlGsOkFXTbAFGZw6vXQ9dkIP8Xk79op5SVokBHg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5Nlfg7+Q5V2oh+ILOWUMItfOUiX34JilX1ppkYnUOyOJ5exc1
	ozztK77+UvvbHQG3v/J5hSkNiQ5aetDhLUOEExVR7cYXpqNR9AzCRgUP4Xk3QUJadp4/dJ7oUXG
	3IHglwgdvbuCIxGIgIu6x/vfHcV4=
X-Google-Smtp-Source: AGHT+IE3llxHH4/WG5H8D0b2lj61mTLUhoMrDZBMZA53ph5hFQUF2xSwzfr+BFaZiVnbISGxKKMiyvQBUh1yi2UBW9w=
X-Received: by 2002:a05:6830:6a95:b0:715:3817:71cd with SMTP id
 46e09a7af769-7154e83a611mr2350961a34.19.1728048332891; Fri, 04 Oct 2024
 06:25:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <12549318.O9o76ZdvQC@rjwysocki.net> <6112242.lOV4Wx5bFT@rjwysocki.net>
 <b2d949a2-2586-44ec-b0e7-0879fd3ac7cf@arm.com>
In-Reply-To: <b2d949a2-2586-44ec-b0e7-0879fd3ac7cf@arm.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 4 Oct 2024 15:25:19 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0g494bUwLbFDF_WHwLSMbu1iTxiynNwDqKktv3-4049Sw@mail.gmail.com>
Message-ID: <CAJZ5v0g494bUwLbFDF_WHwLSMbu1iTxiynNwDqKktv3-4049Sw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] thermal: core: Reference count the zone in thermal_zone_get_by_id()
To: Lukasz Luba <lukasz.luba@arm.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, LKML <linux-kernel@vger.kernel.org>, 
	Linux PM <linux-pm@vger.kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, 
	Zhang Rui <rui.zhang@intel.com>, 
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi =C5=81ukasz,

On Fri, Oct 4, 2024 at 10:01=E2=80=AFAM Lukasz Luba <lukasz.luba@arm.com> w=
rote:
>
> Hi Rafael,
>
> On 10/3/24 13:25, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > There are places in the thermal netlink code where nothing prevents
> > the thermal zone object from going away while being accessed after it
> > has been returned by thermal_zone_get_by_id().
> >
> > To address this, make thermal_zone_get_by_id() get a reference on the
> > thermal zone device object to be returned with the help of get_device()=
,
> > under thermal_list_lock, and adjust all of its callers to this change
> > with the help of the cleanup.h infrastructure.
> >
> > Fixes: 1ce50e7d408e ("thermal: core: genetlink support for events/cmd/s=
ampling")
> > Cc: 6.8+ <stable@vger.kernel.org> # 6.8+
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > ---
> >
> > v1 -> v2: Use the cleanup.h infrastructure to reduce the amount of code=
 changes.
> >
> > ---
> >   drivers/thermal/thermal_core.c    |    1 +
> >   drivers/thermal/thermal_core.h    |    3 +++
> >   drivers/thermal/thermal_netlink.c |    9 +++------
> >   3 files changed, 7 insertions(+), 6 deletions(-)
> >
> > Index: linux-pm/drivers/thermal/thermal_core.c
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > --- linux-pm.orig/drivers/thermal/thermal_core.c
> > +++ linux-pm/drivers/thermal/thermal_core.c
> > @@ -728,6 +728,7 @@ struct thermal_zone_device *thermal_zone
> >       mutex_lock(&thermal_list_lock);
> >       list_for_each_entry(tz, &thermal_tz_list, node) {
> >               if (tz->id =3D=3D id) {
> > +                     get_device(&tz->device);
> >                       match =3D tz;
> >                       break;
> >               }
> > Index: linux-pm/drivers/thermal/thermal_core.h
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > --- linux-pm.orig/drivers/thermal/thermal_core.h
> > +++ linux-pm/drivers/thermal/thermal_core.h
> > @@ -194,6 +194,9 @@ int for_each_thermal_governor(int (*cb)(
> >
> >   struct thermal_zone_device *thermal_zone_get_by_id(int id);
> >
> > +DEFINE_CLASS(thermal_zone_get_by_id, struct thermal_zone_device *,
> > +          if (_T) put_device(&_T->device), thermal_zone_get_by_id(id),=
 int id)
> > +
> >   static inline bool cdev_is_power_actor(struct thermal_cooling_device =
*cdev)
> >   {
> >       return cdev->ops->get_requested_power && cdev->ops->state2power &=
&
> > Index: linux-pm/drivers/thermal/thermal_netlink.c
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > --- linux-pm.orig/drivers/thermal/thermal_netlink.c
> > +++ linux-pm/drivers/thermal/thermal_netlink.c
> > @@ -443,7 +443,6 @@ static int thermal_genl_cmd_tz_get_trip(
> >   {
> >       struct sk_buff *msg =3D p->msg;
> >       const struct thermal_trip_desc *td;
> > -     struct thermal_zone_device *tz;
> >       struct nlattr *start_trip;
> >       int id;
> >
> > @@ -452,7 +451,7 @@ static int thermal_genl_cmd_tz_get_trip(
> >
> >       id =3D nla_get_u32(p->attrs[THERMAL_GENL_ATTR_TZ_ID]);
> >
> > -     tz =3D thermal_zone_get_by_id(id);
> > +     CLASS(thermal_zone_get_by_id, tz)(id);
> >       if (!tz)
> >               return -EINVAL;
> >
> > @@ -488,7 +487,6 @@ out_cancel_nest:
> >   static int thermal_genl_cmd_tz_get_temp(struct param *p)
> >   {
> >       struct sk_buff *msg =3D p->msg;
> > -     struct thermal_zone_device *tz;
> >       int temp, ret, id;
> >
> >       if (!p->attrs[THERMAL_GENL_ATTR_TZ_ID])
> > @@ -496,7 +494,7 @@ static int thermal_genl_cmd_tz_get_temp(
> >
> >       id =3D nla_get_u32(p->attrs[THERMAL_GENL_ATTR_TZ_ID]);
> >
> > -     tz =3D thermal_zone_get_by_id(id);
> > +     CLASS(thermal_zone_get_by_id, tz)(id);
> >       if (!tz)
> >               return -EINVAL;
> >
> > @@ -514,7 +512,6 @@ static int thermal_genl_cmd_tz_get_temp(
> >   static int thermal_genl_cmd_tz_get_gov(struct param *p)
> >   {
> >       struct sk_buff *msg =3D p->msg;
> > -     struct thermal_zone_device *tz;
> >       int id, ret =3D 0;
> >
> >       if (!p->attrs[THERMAL_GENL_ATTR_TZ_ID])
> > @@ -522,7 +519,7 @@ static int thermal_genl_cmd_tz_get_gov(s
> >
> >       id =3D nla_get_u32(p->attrs[THERMAL_GENL_ATTR_TZ_ID]);
> >
> > -     tz =3D thermal_zone_get_by_id(id);
> > +     CLASS(thermal_zone_get_by_id, tz)(id);
> >       if (!tz)
> >               return -EINVAL;
> >
> >
> >
> >
>
> I wasn't aware of that helpers in cleanup.h.
>
> Could you help me to understand when this this
> 'if (_T) put_device((&_T->device)' will be called?

When the pointer variable initialized via the CLASS() macro goes out
of scope (that is, before freeing the memory occupied by the pointer
itself).

