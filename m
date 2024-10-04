Return-Path: <linux-pm+bounces-15150-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 335089904AF
	for <lists+linux-pm@lfdr.de>; Fri,  4 Oct 2024 15:44:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF48C1F227BD
	for <lists+linux-pm@lfdr.de>; Fri,  4 Oct 2024 13:44:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00AA02101A8;
	Fri,  4 Oct 2024 13:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LXSOhBM+"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB0651D5ACD;
	Fri,  4 Oct 2024 13:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728049447; cv=none; b=sqG8S3OBh2zx3NMHI0y7nJHOGNicBz/xDnYyeKbzEuHqFUbpt8BK93TPGbC+ut+XNLwZsFQbkBKPZ44NB+zV1X0I1zDzOyd+9FXRc091xw6VOK5ZiPKrD07vSU8EgFNtQfp1wre797MKWylHlg81WA+JE4spZthUIJhvX+7CdV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728049447; c=relaxed/simple;
	bh=RrqnnHTmVlpBTR0Wk5wZRzfLv/WzqnZOpecusM+9niU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Jz5cSDil98FIFH+KxqtsE7QZxsB3D8AkamKWP74OsqwZZ58VNbUin/h2py7lP0Xhj/G1PoUlOjGEnZP8AFjoDIl1GKN77s0nE3XIj+Ai7B55VhgCDL49t0e2Q8lICegm6Mpoxo81c/Z1jjz+6lcTR+zsM2lTrZy0ZJNPSG29jYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LXSOhBM+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 538C0C4CEC7;
	Fri,  4 Oct 2024 13:44:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728049447;
	bh=RrqnnHTmVlpBTR0Wk5wZRzfLv/WzqnZOpecusM+9niU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=LXSOhBM+5sgRvVBSLn+cwYGqImDNiKzEZePKybD+rlJgPTuiMvhqs7LbNkA1Px5gh
	 sE6qB/555c35hF7VhDFMzBFDxa05ZappqzU6wFj916d8Kf0c/oaEPjXOcafXooGGPl
	 9byI3Gii7DvAO/+MPUD0JKTKdtCghr2kuA3T0aZViSPGZeqxE/S1TtLWR7+AIV2Rda
	 dJyWFr3VpDCIluXHssZudsa/IV+Wb7axS36ULNAASLpXizlxDZujO2WIW7ams8qsWf
	 m6Qy2r3x9i+Cb7yL3ZFCfc9IVm3jH6GFOXAdcYQTZb9euTtGyCFUnLi9tvRF124EZx
	 wUSnv/7QBMU7w==
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-3e037a7d2c3so1113697b6e.0;
        Fri, 04 Oct 2024 06:44:07 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXTjl86XkliSEn2qwua1NMWVEnB2eb5YlVlpz75OZFnTdSfOCxmft2PQQ4wAxpcRqBAqovNU5evfO4=@vger.kernel.org, AJvYcCXbfdNS3iC5WYWTGTpS071EcXFabbOk9O5cBBBluazvP0Z9YSMPiadRR6shOocCZIB1+DmQwww2Gs9s+k8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzD1kQfSt2/bwAMI5c840UIKfXYHBZ/28Bj9mMiCbHJ6gJolh43
	0J6dkReVoofRmAyvvzbhWGAgW20tHIXE7V9EOIvvrZdT7XSknES2s7SMsk+lpug/I8QT25Z4ZMy
	twxb7VctmJfHSYcdGnFZWgXIOu7k=
X-Google-Smtp-Source: AGHT+IHYl8DR1H8oDT1L95/5m1qMbdEI0WSWMGChPuk+kDTQMBgn9uk1RxChheBcw/YJm5ghLDCeL1MwLahuA6Ig8h8=
X-Received: by 2002:a05:6808:16a2:b0:3d5:188d:46cf with SMTP id
 5614622812f47-3e3ba1adb8emr3567355b6e.10.1728049446549; Fri, 04 Oct 2024
 06:44:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <12549318.O9o76ZdvQC@rjwysocki.net> <6112242.lOV4Wx5bFT@rjwysocki.net>
 <b2d949a2-2586-44ec-b0e7-0879fd3ac7cf@arm.com> <CAJZ5v0g494bUwLbFDF_WHwLSMbu1iTxiynNwDqKktv3-4049Sw@mail.gmail.com>
 <5222419a-2664-4bb5-b1d4-77a46677bb4d@arm.com>
In-Reply-To: <5222419a-2664-4bb5-b1d4-77a46677bb4d@arm.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 4 Oct 2024 15:43:53 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0jkbQG4A+saKDfCz6g2-A=rZ2y34k2v9jA9uhp9A17ZBw@mail.gmail.com>
Message-ID: <CAJZ5v0jkbQG4A+saKDfCz6g2-A=rZ2y34k2v9jA9uhp9A17ZBw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] thermal: core: Reference count the zone in thermal_zone_get_by_id()
To: Lukasz Luba <lukasz.luba@arm.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, 
	LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, 
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 4, 2024 at 3:37=E2=80=AFPM Lukasz Luba <lukasz.luba@arm.com> wr=
ote:
>
>
>
> On 10/4/24 14:25, Rafael J. Wysocki wrote:
> > Hi =C5=81ukasz,
> >
> > On Fri, Oct 4, 2024 at 10:01=E2=80=AFAM Lukasz Luba <lukasz.luba@arm.co=
m> wrote:
> >>
> >> Hi Rafael,
> >>
> >> On 10/3/24 13:25, Rafael J. Wysocki wrote:
> >>> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >>>
> >>> There are places in the thermal netlink code where nothing prevents
> >>> the thermal zone object from going away while being accessed after it
> >>> has been returned by thermal_zone_get_by_id().
> >>>
> >>> To address this, make thermal_zone_get_by_id() get a reference on the
> >>> thermal zone device object to be returned with the help of get_device=
(),
> >>> under thermal_list_lock, and adjust all of its callers to this change
> >>> with the help of the cleanup.h infrastructure.
> >>>
> >>> Fixes: 1ce50e7d408e ("thermal: core: genetlink support for events/cmd=
/sampling")
> >>> Cc: 6.8+ <stable@vger.kernel.org> # 6.8+
> >>> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >>> ---
> >>>
> >>> v1 -> v2: Use the cleanup.h infrastructure to reduce the amount of co=
de changes.
> >>>
> >>> ---
> >>>    drivers/thermal/thermal_core.c    |    1 +
> >>>    drivers/thermal/thermal_core.h    |    3 +++
> >>>    drivers/thermal/thermal_netlink.c |    9 +++------
> >>>    3 files changed, 7 insertions(+), 6 deletions(-)
> >>>
> >>> Index: linux-pm/drivers/thermal/thermal_core.c
> >>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >>> --- linux-pm.orig/drivers/thermal/thermal_core.c
> >>> +++ linux-pm/drivers/thermal/thermal_core.c
> >>> @@ -728,6 +728,7 @@ struct thermal_zone_device *thermal_zone
> >>>        mutex_lock(&thermal_list_lock);
> >>>        list_for_each_entry(tz, &thermal_tz_list, node) {
> >>>                if (tz->id =3D=3D id) {
> >>> +                     get_device(&tz->device);
> >>>                        match =3D tz;
> >>>                        break;
> >>>                }
> >>> Index: linux-pm/drivers/thermal/thermal_core.h
> >>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >>> --- linux-pm.orig/drivers/thermal/thermal_core.h
> >>> +++ linux-pm/drivers/thermal/thermal_core.h
> >>> @@ -194,6 +194,9 @@ int for_each_thermal_governor(int (*cb)(
> >>>
> >>>    struct thermal_zone_device *thermal_zone_get_by_id(int id);
> >>>
> >>> +DEFINE_CLASS(thermal_zone_get_by_id, struct thermal_zone_device *,
> >>> +          if (_T) put_device(&_T->device), thermal_zone_get_by_id(id=
), int id)
> >>> +
> >>>    static inline bool cdev_is_power_actor(struct thermal_cooling_devi=
ce *cdev)
> >>>    {
> >>>        return cdev->ops->get_requested_power && cdev->ops->state2powe=
r &&
> >>> Index: linux-pm/drivers/thermal/thermal_netlink.c
> >>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >>> --- linux-pm.orig/drivers/thermal/thermal_netlink.c
> >>> +++ linux-pm/drivers/thermal/thermal_netlink.c
> >>> @@ -443,7 +443,6 @@ static int thermal_genl_cmd_tz_get_trip(
> >>>    {
> >>>        struct sk_buff *msg =3D p->msg;
> >>>        const struct thermal_trip_desc *td;
> >>> -     struct thermal_zone_device *tz;
> >>>        struct nlattr *start_trip;
> >>>        int id;
> >>>
> >>> @@ -452,7 +451,7 @@ static int thermal_genl_cmd_tz_get_trip(
> >>>
> >>>        id =3D nla_get_u32(p->attrs[THERMAL_GENL_ATTR_TZ_ID]);
> >>>
> >>> -     tz =3D thermal_zone_get_by_id(id);
> >>> +     CLASS(thermal_zone_get_by_id, tz)(id);
> >>>        if (!tz)
> >>>                return -EINVAL;
> >>>
> >>> @@ -488,7 +487,6 @@ out_cancel_nest:
> >>>    static int thermal_genl_cmd_tz_get_temp(struct param *p)
> >>>    {
> >>>        struct sk_buff *msg =3D p->msg;
> >>> -     struct thermal_zone_device *tz;
> >>>        int temp, ret, id;
> >>>
> >>>        if (!p->attrs[THERMAL_GENL_ATTR_TZ_ID])
> >>> @@ -496,7 +494,7 @@ static int thermal_genl_cmd_tz_get_temp(
> >>>
> >>>        id =3D nla_get_u32(p->attrs[THERMAL_GENL_ATTR_TZ_ID]);
> >>>
> >>> -     tz =3D thermal_zone_get_by_id(id);
> >>> +     CLASS(thermal_zone_get_by_id, tz)(id);
> >>>        if (!tz)
> >>>                return -EINVAL;
> >>>
> >>> @@ -514,7 +512,6 @@ static int thermal_genl_cmd_tz_get_temp(
> >>>    static int thermal_genl_cmd_tz_get_gov(struct param *p)
> >>>    {
> >>>        struct sk_buff *msg =3D p->msg;
> >>> -     struct thermal_zone_device *tz;
> >>>        int id, ret =3D 0;
> >>>
> >>>        if (!p->attrs[THERMAL_GENL_ATTR_TZ_ID])
> >>> @@ -522,7 +519,7 @@ static int thermal_genl_cmd_tz_get_gov(s
> >>>
> >>>        id =3D nla_get_u32(p->attrs[THERMAL_GENL_ATTR_TZ_ID]);
> >>>
> >>> -     tz =3D thermal_zone_get_by_id(id);
> >>> +     CLASS(thermal_zone_get_by_id, tz)(id);
> >>>        if (!tz)
> >>>                return -EINVAL;
> >>>
> >>>
> >>>
> >>>
> >>
> >> I wasn't aware of that helpers in cleanup.h.
> >>
> >> Could you help me to understand when this this
> >> 'if (_T) put_device((&_T->device)' will be called?
> >
> > When the pointer variable initialized via the CLASS() macro goes out
> > of scope (that is, before freeing the memory occupied by the pointer
> > itself).
>
>
> OK, so do we still need the old code in
> thermal_zone_device_unregister(), which calls
> put_device(&tz->device) ?

Yes, we do.

> Maybe that code can go away?

That particular one drops the reference acquired by device_register()
and I don't see an alternative clean way to drop it.

