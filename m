Return-Path: <linux-pm+bounces-12648-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FF3D95A2B4
	for <lists+linux-pm@lfdr.de>; Wed, 21 Aug 2024 18:21:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4221C1C214F1
	for <lists+linux-pm@lfdr.de>; Wed, 21 Aug 2024 16:21:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B4FA14F9C5;
	Wed, 21 Aug 2024 16:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BYS8+k14"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64D0D14EC40;
	Wed, 21 Aug 2024 16:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724257292; cv=none; b=UpjaYazLXZjdBb9JYcR7fY2aSFwRw6FJyZIR/bdojmVmhp5llsZTnpx9KiBKPky00V0aaa8lruuIG9RYTxBq1M7x0CySYPFMzjRgHEepV0u45MOKUTXg/9chkFmszCuzZ+FTBgwFb1lhi1+8BV6zze9FRYHv/F7UDyLmGCdiPKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724257292; c=relaxed/simple;
	bh=6EzKrh9xTJAqw1p4LarRmhy2aDvY433YcuIp31GWd8w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DxAPw48T5Hi64W+JmGW4NQLDyvyBBRYOnYZUjGyeBmuKkvWYvDUxDk0pxKy63DVIf01bd6bXp3m7VmvQe8gRnAnOg6d24V3N88fwH+Bdkr8hqjJXlWWVzFLzuHx76zwLg9D9qHG21zGhFNiJPWzhOzmsfgXfTlbSYXWxv+njvjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BYS8+k14; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E79AFC4AF11;
	Wed, 21 Aug 2024 16:21:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724257289;
	bh=6EzKrh9xTJAqw1p4LarRmhy2aDvY433YcuIp31GWd8w=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=BYS8+k14eiSKhb0BXa0NnT5arowAi6qLXrStKXzLxSuSRoPWGBE57omq1w27+pmf2
	 fJNO+mXc7glfkWXNA2el1+o/JN1MxrF506Ld5sv5Ou4RRErrKezSgDPibRN/nHcksv
	 FYgEEX7P9zaTU2sQwb96xmW+FBLJzQxsAJHPMuGhO2+PmKi9QMHTsm0BEeVbf75brV
	 /tF5NK0UUNBBXL+N03Ix76D91AzpVz2J+ktUUHGLOvNoOKooYmDFFJMF9xAsQtc8S0
	 JJSPcTQ4SKkoVpy6KvQmPC0GHPGPdbtzpNABqdV0psoYxzUYJN0g18w6IeXd6k++VB
	 I7DXaWVf2L5nA==
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-7092ea69218so484513a34.1;
        Wed, 21 Aug 2024 09:21:29 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCW+5XneMSbohutpo5csaAYDz9y2+PYzorK2tbAKJ+xx3gT/3maLf5/tNbIURqUyj4yB+a6w3aWh+V2xx9g=@vger.kernel.org, AJvYcCXc6BmdDIoTDFm52h18JfntmpWMxvXLEiV2UQlNNF1mNndof9SmG0dfkntQ3N+dTiczihc3zizM1ik=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGDQacYPM8PGTUA9hu4pE6tV2OqAaIc3LyeRgiexPvNkMYLZDK
	IzK9CCw02+kyfNSpoV/1JrsAdOEnbNjqa/2Pme/2E+IXa61Eqoivg32Qu8MraDTGMSOOSVffFyl
	PYWB37FO6zB81TtnobvzJrPtROVo=
X-Google-Smtp-Source: AGHT+IHEPSJUrDi7NXBKzTprX86klVkgctzvPM1bepinLD2ox6jfWp1dhWfRyX97UPsFz+l0m7PZcfjs7CW6If6MDFs=
X-Received: by 2002:a05:6808:13c5:b0:3dc:1afd:6688 with SMTP id
 5614622812f47-3de20f9b180mr54871b6e.20.1724257289222; Wed, 21 Aug 2024
 09:21:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2205737.irdbgypaU6@rjwysocki.net> <1831773.TLkxdtWsSY@rjwysocki.net>
 <ae0bec37-f800-4824-914c-34bf41d2a775@linaro.org>
In-Reply-To: <ae0bec37-f800-4824-914c-34bf41d2a775@linaro.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 21 Aug 2024 18:21:18 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0guBixLgaATkUwznf4UmjFomu_b-i_NxGDV-4-g9D4YSQ@mail.gmail.com>
Message-ID: <CAJZ5v0guBixLgaATkUwznf4UmjFomu_b-i_NxGDV-4-g9D4YSQ@mail.gmail.com>
Subject: Re: [PATCH v3 14/14] thermal: core: Clean up trip bind/unbind functions
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, Lukasz Luba <lukasz.luba@arm.com>, 
	Zhang Rui <rui.zhang@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 21, 2024 at 4:29=E2=80=AFPM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
>
> On 19/08/2024 18:33, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > Make thermal_bind_cdev_to_trip() take a struct cooling_spec pointer
> > to reduce the number of its arguments, change the return type of
> > thermal_unbind_cdev_from_trip() to void and rearrange the code in
> > thermal_zone_cdev_binding() to reduce the indentation level.
> >
> > No intentional functional impact.
> >
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > ---
> >
> > v2 -> v3: Subject fix
> >
> > v1-> v2: No changes
> >
> > ---
> >   drivers/thermal/thermal_core.c |   54 +++++++++++++++----------------=
----------
> >   1 file changed, 21 insertions(+), 33 deletions(-)
> >
> > Index: linux-pm/drivers/thermal/thermal_core.c
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > --- linux-pm.orig/drivers/thermal/thermal_core.c
> > +++ linux-pm/drivers/thermal/thermal_core.c
> > @@ -757,15 +757,7 @@ struct thermal_zone_device *thermal_zone
> >    * @tz:             pointer to struct thermal_zone_device
> >    * @trip:   trip point the cooling devices is associated with in this=
 zone.
> >    * @cdev:   pointer to struct thermal_cooling_device
> > - * @upper:   the Maximum cooling state for this trip point.
> > - *           THERMAL_NO_LIMIT means no upper limit,
> > - *           and the cooling device can be in max_state.
> > - * @lower:   the Minimum cooling state can be used for this trip point=
.
> > - *           THERMAL_NO_LIMIT means no lower limit,
> > - *           and the cooling device can be in cooling state 0.
> > - * @weight:  The weight of the cooling device to be bound to the
> > - *           thermal zone. Use THERMAL_WEIGHT_DEFAULT for the
> > - *           default value
> > + * @c:               cooling specification for @trip and @cdev
>
> s/c/cspec/ at least :)

I have settled on cool_spec here.

> Other than that
>
> Reviewed-by: Daniel Lezcano <daniel.lezcano@linaro.org>

Thank you for all of the reviews!

