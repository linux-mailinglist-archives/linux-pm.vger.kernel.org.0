Return-Path: <linux-pm+bounces-12627-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CE85959A0F
	for <lists+linux-pm@lfdr.de>; Wed, 21 Aug 2024 13:34:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E98F51F2063D
	for <lists+linux-pm@lfdr.de>; Wed, 21 Aug 2024 11:34:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 541551A7ACB;
	Wed, 21 Aug 2024 10:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qNSlEC3P"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 278D015749E;
	Wed, 21 Aug 2024 10:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724237528; cv=none; b=NfdDbQI7vAfXdrcPlgxM/ryyp5SK1rW9O3Z/rIlQlVR0SQUT9G7nnpopsEyK3iAh+kCqdP1Q9XGNX6g8ylUC2WVPQvbLcTIe147Z/69ptd459A1saJNYfMVu6JUchur5nZh4uj+uofFwgaLmeZ5Phcr9txCRPUEZ5tmNenkT6/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724237528; c=relaxed/simple;
	bh=n4B+SZYXC2xcVlFpEnYM3VLy8B1hwverkyPBPRW4b+I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ddh9VCiRMHXVynt37FXQZZtx9gvCgnJy1S7LjHaUcI7Yk5S9/x24R/av46WGyIU3vEGWTmIT6u1TFSPJjiid3E9AKlzFviumUVePuwTJHpQaJoVtyzTlVRjC0i1YdLiZJo8ttGxiB8OVVWxkLKEE1HGwbS043+HRdaX79V7fuF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qNSlEC3P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4AC4C4AF13;
	Wed, 21 Aug 2024 10:52:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724237527;
	bh=n4B+SZYXC2xcVlFpEnYM3VLy8B1hwverkyPBPRW4b+I=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=qNSlEC3PFsHGra3VAaxEGdtFcky7sYKMVLzdwdnruuaLqgBJ/CVffLvhGwpLwqDMe
	 EforwAWKuR8fE+Rijbjduwx58Nv5ThlJY+GRZcrQhsiCb9qFD57pTrLQX6iyLVGHK/
	 f8AagZCHWY8nClpr3RRLiwBzoTEyFgB2O6H2C4vIXRJWEgQ/iD8DnkW12yQW3MtO2+
	 /idV+TZhd3F9k8rx44VWRuMgCjurEGElS3QQnOOOTrhW/ekiLO8ec0cP2ZaHiz7Iuk
	 V9HszqRB8MzAr9PkN+EgBSIzJPz5WV6HiPxdbTgv15qGnmJkDMleqsUB0fljoVIJS0
	 1GF0+LMXZM+ZQ==
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-2702ed1054fso2185646fac.3;
        Wed, 21 Aug 2024 03:52:07 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUaXMyY9ZdB78c5aZjD3UsuGEj8ROVsKZqhpP88+74DEfIoqvR+Ewlw8O+U5wc2/RKcxeNj9zjSuZw=@vger.kernel.org, AJvYcCWmYlivK9NijNk1M0Ol29TLdZOLDrEBKE8Sdp7oACPwBvEBSjQ3Zx0qvN3CVI9aIJobXvflTHJV8NVVk+8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUJV/qx6ge+ckfK8vag5OgmyMs+fU9HglRYg5V/YC83NF02Ra7
	jacXjQGiyauWZ61796AqMzsj3InenwTHECaOAkJwdcsJgkaS+Dny2Q13NtYSDhkDIjy4xkaMNne
	CQ7OC9woseXW19DP/WJKUImy/6uw=
X-Google-Smtp-Source: AGHT+IFmqMYW4qgPgpnpka2H3aCBK+JHRVw0+wuo168U4bCgyxkesXILtlhQVDtMnsbC/E1YRXdwMLi0bnXn1nUrYTk=
X-Received: by 2002:a05:6870:b246:b0:260:fdd5:4147 with SMTP id
 586e51a60fabf-2737ef0804amr2026458fac.15.1724237526967; Wed, 21 Aug 2024
 03:52:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2205737.irdbgypaU6@rjwysocki.net> <3324214.44csPzL39Z@rjwysocki.net>
 <68ed6185-a602-c0fc-721e-b5d68fea83f8@huawei.com>
In-Reply-To: <68ed6185-a602-c0fc-721e-b5d68fea83f8@huawei.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 21 Aug 2024 12:51:55 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0jwkc2PB+osSkkYF9vJ1Vpp3MFE=cGQmQ2Xzjb3yjVfJg@mail.gmail.com>
Message-ID: <CAJZ5v0jwkc2PB+osSkkYF9vJ1Vpp3MFE=cGQmQ2Xzjb3yjVfJg@mail.gmail.com>
Subject: Re: [PATCH v3 02/14] thermal: core: Rearrange checks in thermal_bind_cdev_to_trip()
To: "lihuisong (C)" <lihuisong@huawei.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, 
	Lukasz Luba <lukasz.luba@arm.com>, Zhang Rui <rui.zhang@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 21, 2024 at 12:43=E2=80=AFPM lihuisong (C) <lihuisong@huawei.co=
m> wrote:
>
>
> =E5=9C=A8 2024/8/19 23:51, Rafael J. Wysocki =E5=86=99=E9=81=93:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > It is not necessary to look up the thermal zone and the cooling device
> > in the respective global lists to check whether or not they are
> > registered.  It is sufficient to check whether or not their respective
> > list nodes are empty for this purpose.
> >
> > Use the above observation to simplify thermal_bind_cdev_to_trip().  In
> > addition, eliminate an unnecessary ternary operator from it.
> >
> > Moreover, add lockdep_assert_held() for thermal_list_lock to it because
> > that lock must be held by its callers when it is running.
> >
> > No intentional functional impact.
> >
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > ---
> >
> > v1 -> v3: No changes
> >
> > ---
> >   drivers/thermal/thermal_core.c |   16 ++++------------
> >   1 file changed, 4 insertions(+), 12 deletions(-)
> >
> > Index: linux-pm/drivers/thermal/thermal_core.c
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > --- linux-pm.orig/drivers/thermal/thermal_core.c
> > +++ linux-pm/drivers/thermal/thermal_core.c
> > @@ -781,25 +781,17 @@ int thermal_bind_cdev_to_trip(struct the
> >   {
> >       struct thermal_instance *dev;
> >       struct thermal_instance *pos;
> > -     struct thermal_zone_device *pos1;
> > -     struct thermal_cooling_device *pos2;
> >       bool upper_no_limit;
> >       int result;
> >
> > -     list_for_each_entry(pos1, &thermal_tz_list, node) {
> > -             if (pos1 =3D=3D tz)
> > -                     break;
> > -     }
> > -     list_for_each_entry(pos2, &thermal_cdev_list, node) {
> > -             if (pos2 =3D=3D cdev)
> > -                     break;
> > -     }
> > +     lockdep_assert_held(&thermal_list_lock);
> >
> > -     if (tz !=3D pos1 || cdev !=3D pos2)
> > +     if (list_empty(&tz->node) || list_empty(&cdev->node))
> The old verification is ensure that tz and cdev already add to
> thermal_tz_list and thermal_cdev_list=EF=BC=8Crespectively.
> Namely, tz and cdev are definitely registered and intialized.
> The check is ok for all untizalized thermal_zone_device and cooling devic=
e.
> But the new verification doesn't seem to do that.

It doesn't need to do it and after this series it is only called from
thermal_zone_device_register_with_trips() and
__thermal_cooling_device_register() via thermal_zone_cdev_binding()
after both the cdev and the tz have been added to the list, under
thermal_list_lock.

I guess I can send a patch to remove the check altogether now.

