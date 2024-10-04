Return-Path: <linux-pm+bounces-15149-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D31B99047E
	for <lists+linux-pm@lfdr.de>; Fri,  4 Oct 2024 15:33:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 14F5FB250F0
	for <lists+linux-pm@lfdr.de>; Fri,  4 Oct 2024 13:33:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71B0A1D6DB0;
	Fri,  4 Oct 2024 13:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bw+8oSt5"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4909A38DE4;
	Fri,  4 Oct 2024 13:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728048798; cv=none; b=Zng4dEyYkathWOkgAEYLYWtrWaMf+n0KLTTdcSHZjtlP0QI3uBCrjwilDZ2g3xAryYgPxS6lp78gRDDPt8Rq0zPL+XIFa+4Ih3YFq2aL3GmhgDujT9N6bMV5gWIoRReFWGMGShVUmxOhqzpwgIJpyu3wiTLMp0gwdrwB0SFrvfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728048798; c=relaxed/simple;
	bh=dgZA1LoXnbk5XhHAi3lEKF7enutGF7QyNuzEcV1fjpA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jIoMfjH9Ru4Et1mv6jWGqn9TCfUcxxdyghv5KU0gZiPxoVh2gIXP+Rc8sF5ouRNlrYclLy3cEwisUb1VcJyndBxHuoQjkD5HPyPQFqGtkUPi1nvKLWLhDs2N+aJydIvdpvrIrHwB5UJL5KV3Inp/0x9otxzk1hCKEmLqsXARB60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bw+8oSt5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5BF5C55DF0;
	Fri,  4 Oct 2024 13:33:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728048796;
	bh=dgZA1LoXnbk5XhHAi3lEKF7enutGF7QyNuzEcV1fjpA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Bw+8oSt5byjQeR+qSGSZGlhi+IXR7Hs+euvWevvQRd6PqvJxzbcCJx8klwx6BnLgx
	 JXeOSX966UM4v+OKhU5ms6PEgeImJKS2NBCPyPkh3Wnrgb3l5KJEkIw7adPQgt7f1e
	 SAnNzmDORX1Tf7Hz95HNzalU0rDoPyKFRZS8yDTZaTe4oi47Gs21M+zVdu6qsj50C6
	 FeLnmKjUqo6mQ2R6S2occidjc0LvJ0w0lyz4oLkNTpQYScP89E4yu2irSMqr2HTp7t
	 JCZ5b6/6Tn0I3a7E8vt5/WYf5gIfmNAK7WKk4ZdqeY1TxcdLgPoxrfmiU6ed67exJn
	 pfuPknr0Iz2Vg==
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-710e1a47b40so782022a34.2;
        Fri, 04 Oct 2024 06:33:16 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCW31JMg83E3cIMJ2R5MehfpPKS1rmmJJDQ07C5Fk+OhN4pd7NygZzk2b9xJHw0yVkBIYKfschNDY6c=@vger.kernel.org, AJvYcCWJfWaiyUIAQ40nZMqQw7p2T3u/vk1VliTDaOEtoNzFw4aEWHW4jGdGbeAuvn7HtgZKQXNHBZkVadcZpY0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz85Zqpuw0Wgr9Y1ThIB8B/oxYOhqmurTVe/upLyBd98fq2oRBe
	dYOkV5oSGS4lCrhhAYU3CIJI821c0D/0LXh5Th+PgHUpxjk0l2sC+BuW2FhW7OZhL7RTVZVBqsH
	5ilh0kEuuRuYxlszJlKLxvtAvln0=
X-Google-Smtp-Source: AGHT+IFPjMLbasGdpSiZg2kmHDQxVTLhVQRhRDJeuXGQDWgS6cPfssW2+lK+bvVpXbGyx4D9ldfzEDvaEXFPUnhw1yI=
X-Received: by 2002:a05:6830:d16:b0:710:f72e:3a46 with SMTP id
 46e09a7af769-7154e97a90amr1783277a34.24.1728048796002; Fri, 04 Oct 2024
 06:33:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <12549318.O9o76ZdvQC@rjwysocki.net> <6112242.lOV4Wx5bFT@rjwysocki.net>
 <b2d949a2-2586-44ec-b0e7-0879fd3ac7cf@arm.com> <CAJZ5v0g494bUwLbFDF_WHwLSMbu1iTxiynNwDqKktv3-4049Sw@mail.gmail.com>
In-Reply-To: <CAJZ5v0g494bUwLbFDF_WHwLSMbu1iTxiynNwDqKktv3-4049Sw@mail.gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 4 Oct 2024 15:33:03 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0imz7+bL+5GV5DT5eee0jPB6kQ2EQK8DL3s10muhf-=uQ@mail.gmail.com>
Message-ID: <CAJZ5v0imz7+bL+5GV5DT5eee0jPB6kQ2EQK8DL3s10muhf-=uQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] thermal: core: Reference count the zone in thermal_zone_get_by_id()
To: Lukasz Luba <lukasz.luba@arm.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, LKML <linux-kernel@vger.kernel.org>, 
	Linux PM <linux-pm@vger.kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, 
	Zhang Rui <rui.zhang@intel.com>, 
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 4, 2024 at 3:25=E2=80=AFPM Rafael J. Wysocki <rafael@kernel.org=
> wrote:
>
> Hi =C5=81ukasz,
>
> On Fri, Oct 4, 2024 at 10:01=E2=80=AFAM Lukasz Luba <lukasz.luba@arm.com>=
 wrote:
> >
> > Hi Rafael,
> >
> > On 10/3/24 13:25, Rafael J. Wysocki wrote:
> > > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > >
> > > There are places in the thermal netlink code where nothing prevents
> > > the thermal zone object from going away while being accessed after it
> > > has been returned by thermal_zone_get_by_id().
> > >
> > > To address this, make thermal_zone_get_by_id() get a reference on the
> > > thermal zone device object to be returned with the help of get_device=
(),
> > > under thermal_list_lock, and adjust all of its callers to this change
> > > with the help of the cleanup.h infrastructure.
> > >
> > > Fixes: 1ce50e7d408e ("thermal: core: genetlink support for events/cmd=
/sampling")
> > > Cc: 6.8+ <stable@vger.kernel.org> # 6.8+
> > > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > > ---
> > >
> > > v1 -> v2: Use the cleanup.h infrastructure to reduce the amount of co=
de changes.
> > >
> > > ---
> > >   drivers/thermal/thermal_core.c    |    1 +
> > >   drivers/thermal/thermal_core.h    |    3 +++
> > >   drivers/thermal/thermal_netlink.c |    9 +++------
> > >   3 files changed, 7 insertions(+), 6 deletions(-)
> > >
> > > Index: linux-pm/drivers/thermal/thermal_core.c
> > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > --- linux-pm.orig/drivers/thermal/thermal_core.c
> > > +++ linux-pm/drivers/thermal/thermal_core.c
> > > @@ -728,6 +728,7 @@ struct thermal_zone_device *thermal_zone
> > >       mutex_lock(&thermal_list_lock);
> > >       list_for_each_entry(tz, &thermal_tz_list, node) {
> > >               if (tz->id =3D=3D id) {
> > > +                     get_device(&tz->device);
> > >                       match =3D tz;
> > >                       break;
> > >               }
> > > Index: linux-pm/drivers/thermal/thermal_core.h
> > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > --- linux-pm.orig/drivers/thermal/thermal_core.h
> > > +++ linux-pm/drivers/thermal/thermal_core.h
> > > @@ -194,6 +194,9 @@ int for_each_thermal_governor(int (*cb)(
> > >
> > >   struct thermal_zone_device *thermal_zone_get_by_id(int id);
> > >
> > > +DEFINE_CLASS(thermal_zone_get_by_id, struct thermal_zone_device *,
> > > +          if (_T) put_device(&_T->device), thermal_zone_get_by_id(id=
), int id)
> > > +
> > >   static inline bool cdev_is_power_actor(struct thermal_cooling_devic=
e *cdev)
> > >   {
> > >       return cdev->ops->get_requested_power && cdev->ops->state2power=
 &&
> > > Index: linux-pm/drivers/thermal/thermal_netlink.c
> > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > --- linux-pm.orig/drivers/thermal/thermal_netlink.c
> > > +++ linux-pm/drivers/thermal/thermal_netlink.c
> > > @@ -443,7 +443,6 @@ static int thermal_genl_cmd_tz_get_trip(
> > >   {
> > >       struct sk_buff *msg =3D p->msg;
> > >       const struct thermal_trip_desc *td;
> > > -     struct thermal_zone_device *tz;
> > >       struct nlattr *start_trip;
> > >       int id;
> > >
> > > @@ -452,7 +451,7 @@ static int thermal_genl_cmd_tz_get_trip(
> > >
> > >       id =3D nla_get_u32(p->attrs[THERMAL_GENL_ATTR_TZ_ID]);
> > >
> > > -     tz =3D thermal_zone_get_by_id(id);
> > > +     CLASS(thermal_zone_get_by_id, tz)(id);
> > >       if (!tz)
> > >               return -EINVAL;
> > >
> > > @@ -488,7 +487,6 @@ out_cancel_nest:
> > >   static int thermal_genl_cmd_tz_get_temp(struct param *p)
> > >   {
> > >       struct sk_buff *msg =3D p->msg;
> > > -     struct thermal_zone_device *tz;
> > >       int temp, ret, id;
> > >
> > >       if (!p->attrs[THERMAL_GENL_ATTR_TZ_ID])
> > > @@ -496,7 +494,7 @@ static int thermal_genl_cmd_tz_get_temp(
> > >
> > >       id =3D nla_get_u32(p->attrs[THERMAL_GENL_ATTR_TZ_ID]);
> > >
> > > -     tz =3D thermal_zone_get_by_id(id);
> > > +     CLASS(thermal_zone_get_by_id, tz)(id);
> > >       if (!tz)
> > >               return -EINVAL;
> > >
> > > @@ -514,7 +512,6 @@ static int thermal_genl_cmd_tz_get_temp(
> > >   static int thermal_genl_cmd_tz_get_gov(struct param *p)
> > >   {
> > >       struct sk_buff *msg =3D p->msg;
> > > -     struct thermal_zone_device *tz;
> > >       int id, ret =3D 0;
> > >
> > >       if (!p->attrs[THERMAL_GENL_ATTR_TZ_ID])
> > > @@ -522,7 +519,7 @@ static int thermal_genl_cmd_tz_get_gov(s
> > >
> > >       id =3D nla_get_u32(p->attrs[THERMAL_GENL_ATTR_TZ_ID]);
> > >
> > > -     tz =3D thermal_zone_get_by_id(id);
> > > +     CLASS(thermal_zone_get_by_id, tz)(id);
> > >       if (!tz)
> > >               return -EINVAL;
> > >
> > >
> > >
> > >
> >
> > I wasn't aware of that helpers in cleanup.h.
> >
> > Could you help me to understand when this this
> > 'if (_T) put_device((&_T->device)' will be called?
>
> When the pointer variable initialized via the CLASS() macro goes out
> of scope (that is, before freeing the memory occupied by the pointer
> itself).

Note that DEFINE_GUARD() is based on DEFINE_CLASS() and the guard()
macro is based on the CLASS() one, so it's basically the same
mechanism.

