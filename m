Return-Path: <linux-pm+bounces-15151-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 944399904CD
	for <lists+linux-pm@lfdr.de>; Fri,  4 Oct 2024 15:49:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 55C55280E51
	for <lists+linux-pm@lfdr.de>; Fri,  4 Oct 2024 13:49:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67BFC2101A7;
	Fri,  4 Oct 2024 13:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u5phwJ06"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E3F5149DF4;
	Fri,  4 Oct 2024 13:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728049750; cv=none; b=qfh/EiKJXJI6DG7Q3ZFI1ZNi1UCkgK9sQZCpgX/+h8hzIZGSo0oeK4EeOp1qZp2Fu8GOzPjo/ZMlQDTo2mVqTbh5DGVuI5MowRrwFldF/HAiDYO0TbHc8lBdkxqlLabhkSnasj06tHRrfFwRtnGipQ6SAdadyelJx56FZ0JqLbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728049750; c=relaxed/simple;
	bh=Mr3oeiMAjXvQTt4cAET+sTKXfMt93PGKDJm+abtdEPQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BumUOaxkEz0dT0G6avcPPZDgx0VacJ9v52cLCXBVly2BmKByzqMlyneiibvRhCEuXmrEuHd8aQPoxIzjVvWNwkqhBm58VgdZhcrpLXcsC44SorB3ToW429Vz58GjB9K+ZodgG3v/ze+oXdiKKxF7MARKaKMsH3Al8HksBeKAWn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u5phwJ06; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD908C4AF0B;
	Fri,  4 Oct 2024 13:49:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728049749;
	bh=Mr3oeiMAjXvQTt4cAET+sTKXfMt93PGKDJm+abtdEPQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=u5phwJ06TxeYuSLTv1hHWc+6zyR/SPvQ7Vc6MDLgGE0nd0V4rJyteNi9ovKb3Opvj
	 ES/SvvFL/EJz8Wrwv5qpTy4tpLoAfKGu+MUC/q6a76ZETVpe+oav6lRgtpKgCHKPcL
	 IHHj+59+3Uz5T3aigJHknp4ivtApocyyCuWW+kw99ebLgU0E9tTD1pxsp9Prs8laC1
	 iUCBrWZVzluoI9FgI7lAz5j4igecrXpxs2YONkP8otUR742+huZ+vkNYJIalhXK3uc
	 /LaGd2X8rZ51x6vY6PmeqwingSUNWy4HZC/7MD3/ya3nRXO9MKqis95RkyNtvkWECu
	 SuFCwnwWjTmZw==
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-5e77a1c5ec6so1190724eaf.2;
        Fri, 04 Oct 2024 06:49:09 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVecCv9UYesZ6IgPhP9jLhzq4c/okCFRCZSO34xRy8MCfnmzPlmZg+0C506RYODt0fVhI70STde2Fc=@vger.kernel.org, AJvYcCX/1oDylgzojFOO9v/j+CVhtASffqj+9OfE3uxsf749Y6px3awv0t57wjbnNO8w8dLroCTQk/756PUyiL8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxle6VMN1qXQyBPIObS3Pe9NSdsTFuTtibJGoS7mth0k8D9mBie
	Y8PWRyrgu23QUnBeA4X18pNl3ZER8o0a6+Zc2llkvKMT262Z0S5Ra/3bOQQyadqZx8H2XOBE0/x
	8CSUJX9eywavKJxm/27t/OMPjec0=
X-Google-Smtp-Source: AGHT+IEFQ4j57FLFWTPVuRHlAsr8UoIRIxomft+0eJwFVDtC1aBwsk1V18rPTAzsPzyv+iGe8vaY5NkI1jriMrcEe9Q=
X-Received: by 2002:a05:6820:1b8d:b0:5e5:be43:1f26 with SMTP id
 006d021491bc7-5e7cbe68289mr1817183eaf.0.1728049749026; Fri, 04 Oct 2024
 06:49:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <12549318.O9o76ZdvQC@rjwysocki.net> <6112242.lOV4Wx5bFT@rjwysocki.net>
 <b2d949a2-2586-44ec-b0e7-0879fd3ac7cf@arm.com> <CAJZ5v0g494bUwLbFDF_WHwLSMbu1iTxiynNwDqKktv3-4049Sw@mail.gmail.com>
 <5222419a-2664-4bb5-b1d4-77a46677bb4d@arm.com> <CAJZ5v0jkbQG4A+saKDfCz6g2-A=rZ2y34k2v9jA9uhp9A17ZBw@mail.gmail.com>
In-Reply-To: <CAJZ5v0jkbQG4A+saKDfCz6g2-A=rZ2y34k2v9jA9uhp9A17ZBw@mail.gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 4 Oct 2024 15:48:56 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0iSb=RGiuXrBPq6V0ZObhPedznuv7CGgAyO1MMshCQrMg@mail.gmail.com>
Message-ID: <CAJZ5v0iSb=RGiuXrBPq6V0ZObhPedznuv7CGgAyO1MMshCQrMg@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] thermal: core: Reference count the zone in thermal_zone_get_by_id()
To: Lukasz Luba <lukasz.luba@arm.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, LKML <linux-kernel@vger.kernel.org>, 
	Linux PM <linux-pm@vger.kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, 
	Zhang Rui <rui.zhang@intel.com>, 
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 4, 2024 at 3:43=E2=80=AFPM Rafael J. Wysocki <rafael@kernel.org=
> wrote:
>
> On Fri, Oct 4, 2024 at 3:37=E2=80=AFPM Lukasz Luba <lukasz.luba@arm.com> =
wrote:
> >
> >
> >
> > On 10/4/24 14:25, Rafael J. Wysocki wrote:
> > > Hi =C5=81ukasz,
> > >
> > > On Fri, Oct 4, 2024 at 10:01=E2=80=AFAM Lukasz Luba <lukasz.luba@arm.=
com> wrote:
> > >>
> > >> Hi Rafael,
> > >>
> > >> On 10/3/24 13:25, Rafael J. Wysocki wrote:
> > >>> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > >>>
> > >>> There are places in the thermal netlink code where nothing prevents
> > >>> the thermal zone object from going away while being accessed after =
it
> > >>> has been returned by thermal_zone_get_by_id().
> > >>>
> > >>> To address this, make thermal_zone_get_by_id() get a reference on t=
he
> > >>> thermal zone device object to be returned with the help of get_devi=
ce(),
> > >>> under thermal_list_lock, and adjust all of its callers to this chan=
ge
> > >>> with the help of the cleanup.h infrastructure.
> > >>>
> > >>> Fixes: 1ce50e7d408e ("thermal: core: genetlink support for events/c=
md/sampling")
> > >>> Cc: 6.8+ <stable@vger.kernel.org> # 6.8+
> > >>> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > >>> ---
> > >>>
> > >>> v1 -> v2: Use the cleanup.h infrastructure to reduce the amount of =
code changes.
> > >>>
> > >>> ---
> > >>>    drivers/thermal/thermal_core.c    |    1 +
> > >>>    drivers/thermal/thermal_core.h    |    3 +++
> > >>>    drivers/thermal/thermal_netlink.c |    9 +++------
> > >>>    3 files changed, 7 insertions(+), 6 deletions(-)
> > >>>
> > >>> Index: linux-pm/drivers/thermal/thermal_core.c
> > >>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > >>> --- linux-pm.orig/drivers/thermal/thermal_core.c
> > >>> +++ linux-pm/drivers/thermal/thermal_core.c
> > >>> @@ -728,6 +728,7 @@ struct thermal_zone_device *thermal_zone
> > >>>        mutex_lock(&thermal_list_lock);
> > >>>        list_for_each_entry(tz, &thermal_tz_list, node) {
> > >>>                if (tz->id =3D=3D id) {
> > >>> +                     get_device(&tz->device);
> > >>>                        match =3D tz;
> > >>>                        break;
> > >>>                }
> > >>> Index: linux-pm/drivers/thermal/thermal_core.h
> > >>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > >>> --- linux-pm.orig/drivers/thermal/thermal_core.h
> > >>> +++ linux-pm/drivers/thermal/thermal_core.h
> > >>> @@ -194,6 +194,9 @@ int for_each_thermal_governor(int (*cb)(
> > >>>
> > >>>    struct thermal_zone_device *thermal_zone_get_by_id(int id);
> > >>>
> > >>> +DEFINE_CLASS(thermal_zone_get_by_id, struct thermal_zone_device *,
> > >>> +          if (_T) put_device(&_T->device), thermal_zone_get_by_id(=
id), int id)
> > >>> +
> > >>>    static inline bool cdev_is_power_actor(struct thermal_cooling_de=
vice *cdev)
> > >>>    {
> > >>>        return cdev->ops->get_requested_power && cdev->ops->state2po=
wer &&
> > >>> Index: linux-pm/drivers/thermal/thermal_netlink.c
> > >>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > >>> --- linux-pm.orig/drivers/thermal/thermal_netlink.c
> > >>> +++ linux-pm/drivers/thermal/thermal_netlink.c
> > >>> @@ -443,7 +443,6 @@ static int thermal_genl_cmd_tz_get_trip(
> > >>>    {
> > >>>        struct sk_buff *msg =3D p->msg;
> > >>>        const struct thermal_trip_desc *td;
> > >>> -     struct thermal_zone_device *tz;
> > >>>        struct nlattr *start_trip;
> > >>>        int id;
> > >>>
> > >>> @@ -452,7 +451,7 @@ static int thermal_genl_cmd_tz_get_trip(
> > >>>
> > >>>        id =3D nla_get_u32(p->attrs[THERMAL_GENL_ATTR_TZ_ID]);
> > >>>
> > >>> -     tz =3D thermal_zone_get_by_id(id);
> > >>> +     CLASS(thermal_zone_get_by_id, tz)(id);
> > >>>        if (!tz)
> > >>>                return -EINVAL;
> > >>>
> > >>> @@ -488,7 +487,6 @@ out_cancel_nest:
> > >>>    static int thermal_genl_cmd_tz_get_temp(struct param *p)
> > >>>    {
> > >>>        struct sk_buff *msg =3D p->msg;
> > >>> -     struct thermal_zone_device *tz;
> > >>>        int temp, ret, id;
> > >>>
> > >>>        if (!p->attrs[THERMAL_GENL_ATTR_TZ_ID])
> > >>> @@ -496,7 +494,7 @@ static int thermal_genl_cmd_tz_get_temp(
> > >>>
> > >>>        id =3D nla_get_u32(p->attrs[THERMAL_GENL_ATTR_TZ_ID]);
> > >>>
> > >>> -     tz =3D thermal_zone_get_by_id(id);
> > >>> +     CLASS(thermal_zone_get_by_id, tz)(id);
> > >>>        if (!tz)
> > >>>                return -EINVAL;
> > >>>
> > >>> @@ -514,7 +512,6 @@ static int thermal_genl_cmd_tz_get_temp(
> > >>>    static int thermal_genl_cmd_tz_get_gov(struct param *p)
> > >>>    {
> > >>>        struct sk_buff *msg =3D p->msg;
> > >>> -     struct thermal_zone_device *tz;
> > >>>        int id, ret =3D 0;
> > >>>
> > >>>        if (!p->attrs[THERMAL_GENL_ATTR_TZ_ID])
> > >>> @@ -522,7 +519,7 @@ static int thermal_genl_cmd_tz_get_gov(s
> > >>>
> > >>>        id =3D nla_get_u32(p->attrs[THERMAL_GENL_ATTR_TZ_ID]);
> > >>>
> > >>> -     tz =3D thermal_zone_get_by_id(id);
> > >>> +     CLASS(thermal_zone_get_by_id, tz)(id);
> > >>>        if (!tz)
> > >>>                return -EINVAL;
> > >>>
> > >>>
> > >>>
> > >>>
> > >>
> > >> I wasn't aware of that helpers in cleanup.h.
> > >>
> > >> Could you help me to understand when this this
> > >> 'if (_T) put_device((&_T->device)' will be called?
> > >
> > > When the pointer variable initialized via the CLASS() macro goes out
> > > of scope (that is, before freeing the memory occupied by the pointer
> > > itself).
> >
> >
> > OK, so do we still need the old code in
> > thermal_zone_device_unregister(), which calls
> > put_device(&tz->device) ?
>
> Yes, we do.
>
> > Maybe that code can go away?
>
> That particular one drops the reference acquired by device_register()
> and I don't see an alternative clean way to drop it.

The problem there is that local variable tz goes out of scope at the
end of the function (at least formally) and put_device(&tz->device)
needs to be called before the wait_for_completion(&tz->removal) which
definitely needs tz to be still around.

