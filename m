Return-Path: <linux-pm+bounces-10335-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0661B923C01
	for <lists+linux-pm@lfdr.de>; Tue,  2 Jul 2024 13:03:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BA2D7B22A73
	for <lists+linux-pm@lfdr.de>; Tue,  2 Jul 2024 11:03:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 963B8157A59;
	Tue,  2 Jul 2024 11:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nloQ00Fr"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 651C04CDF9;
	Tue,  2 Jul 2024 11:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719918195; cv=none; b=PZZ5RMdrBG06EiUsiMOIK4JtutDG0OdRbbihKULbMPDB7ckO7jnuhoBJsuI+emanvycIZyXH2V2UgPvWTA2eZiuUCarAopx0FUL+9cW7KTdBsK8Y7b/AIIbpE3dTd/90B/ZU9cu2qtTcpDuR9r5B3rfeCxxioRwIZntT/Nb+LKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719918195; c=relaxed/simple;
	bh=AWJ7xszLeoqDT15imOWh8jL48v86HGoe71kVesSev2Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bKYOribQNDAXfUQQPNKZVdhsOHzcDLC3QsFOIot9LQpGXb54rzhNSkMs1vi5DtH9v5MWni+pD8dKKpWn2jL7lHCwXUC5IjIopVtsqFIcR/Yrfc5V4YKkY6TLyBmz6T8LhGnQmAuI8TuIxIU6gCIrG9HiJegM1dkhzaDmgw1DeyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nloQ00Fr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0577AC4AF0D;
	Tue,  2 Jul 2024 11:03:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719918195;
	bh=AWJ7xszLeoqDT15imOWh8jL48v86HGoe71kVesSev2Y=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=nloQ00FrGs5yRp2htAVMQ5wlXulDQ+GQGpKbi+II5pGjQglZNoLIfWALa+inG9oAP
	 9JJVUCsuD0PRjh04heiPsE3GC3bl4NN0iRIyi349Hx3Jc37TxFoVWvzQbY+7v9jBlO
	 MaZF9rdrMt0xMrDFPbKaqU1xdHHPL25/kphUSXqd204VvWPnWc8TCKUw3ojhODjOgL
	 adeR4wfKfIakQmeQCcLQi1Vm5pdouWaIevyIRsrmlhn7H7Ti2VlA/4CtGfUsHPZlFF
	 z/fLutm+fsgRXXgMX1mqciYoVXok8+XlhMCyMi+SVUg8E4Vj3mEsIC3RSv6G5XMS4E
	 MFy66D/y41wfA==
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-25cc44857a1so452902fac.3;
        Tue, 02 Jul 2024 04:03:14 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWsvtypddUiwi7mw/hQvMq9fQRhagStiQfmOPHDNBc8OnIhoja9flww8mM7nWdaLtl80fGEV9SHhG8d6njzv1vBXQIgDnN/Z+xJDPu+b5sb9mSN81q0JsLaIfa6PfyTB12K5l5dhCZdnsy1lyKpF6IUBG6VDllb2b9gK2koO2eclkJa
X-Gm-Message-State: AOJu0YyxY6OZZce0D8E+mc4wNqFVCWIpz2pO6hbLMwB57VnBQFDthiBd
	OUIm7GxwpzAz//51Kp9VFikb9kYEofXEdpeuL465hGP0i1UBz758LFbmWeFMod9HQgr54mVOvJw
	mX8E1azDVyoFK6Sr50Gjd+7PhzpM=
X-Google-Smtp-Source: AGHT+IFJRX03/JEbSVJzCZO+bUHjteNIdrZcxkJ8NOnrcNwVXlurM2vSMm1Uv6MUqN+OCYR90OciaoR2UF5Ey8zCLCI=
X-Received: by 2002:a05:6870:b155:b0:254:d417:351f with SMTP id
 586e51a60fabf-25db338f8f9mr8955572fac.1.1719918194273; Tue, 02 Jul 2024
 04:03:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240627085451.3813989-1-daniel.lezcano@linaro.org>
 <20240701162600.GA4119789-robh@kernel.org> <98fe3146-07ae-4095-b372-6aed6e080d94@linaro.org>
 <CAJZ5v0ix+RDtrR+r3jd=A_W7D5U7JodMiirJ519-wwLrHeBbSw@mail.gmail.com> <1eb7eb88-4230-4803-83fe-415ce0745951@linaro.org>
In-Reply-To: <1eb7eb88-4230-4803-83fe-415ce0745951@linaro.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 2 Jul 2024 13:03:03 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0jV+0bWqpCR1Q2rYLJvx0J6hgExzRks6YDPL9gX_HK0rA@mail.gmail.com>
Message-ID: <CAJZ5v0jV+0bWqpCR1Q2rYLJvx0J6hgExzRks6YDPL9gX_HK0rA@mail.gmail.com>
Subject: Re: [PATCH] thermal/core: Introduce user trip points
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Rob Herring <robh@kernel.org>, linux-pm@vger.kernel.org, 
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 2, 2024 at 12:56=E2=80=AFPM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
>
> On 02/07/2024 12:22, Rafael J. Wysocki wrote:
> > On Tue, Jul 2, 2024 at 11:29=E2=80=AFAM Daniel Lezcano
> > <daniel.lezcano@linaro.org> wrote:
> >>
> >> On 01/07/2024 18:26, Rob Herring wrote:
> >>> On Thu, Jun 27, 2024 at 10:54:50AM +0200, Daniel Lezcano wrote:
> >>>> Currently the thermal framework has 4 trip point types:
> >>>>
> >>>> - active : basically for fans (or anything requiring energy to cool
> >>>>     down)
> >>>>
> >>>> - passive : a performance limiter
> >>>>
> >>>> - hot : for a last action before reaching critical
> >>>>
> >>>> - critical : a without return threshold leading to a system shutdown
> >>>>
> >>>> A thermal zone monitors the temperature regarding these trip
> >>>> points. The old way to do that is actively polling the temperature
> >>>> which is very bad for embedded systems, especially mobile and it is
> >>>> even worse today as we can have more than fifty thermal zones. The
> >>>> modern way is to rely on the driver to send an interrupt when the tr=
ip
> >>>> points are crossed, so the system can sleep while the temperature
> >>>> monitoring is offloaded to a dedicated hardware.
> >>>>
> >>>> However, the thermal aspect is also managed from userspace to protec=
t
> >>>> the user, especially tracking down the skin temperature sensor. The
> >>>> logic is more complex than what we found in the kernel because it
> >>>> needs multiple sources indicating the thermal situation of the entir=
e
> >>>> system.
> >>>>
> >>>> For this reason it needs to setup trip points at different levels in
> >>>> order to get informed about what is going on with some thermal zones
> >>>> when running some specific application.
> >>>>
> >>>> For instance, the skin temperature must be limited to 43=C2=B0C on a=
 long
> >>>> run but can go to 48=C2=B0C for 10 minutes, or 60=C2=B0C for 1 minut=
e.
> >>>>
> >>>> The thermal engine must then rely on trip points to monitor those
> >>>> temperatures. Unfortunately, today there is only 'active' and
> >>>> 'passive' trip points which has a specific meaning for the kernel, n=
ot
> >>>> the userspace. That leads to hacks in different platforms for mobile
> >>>> and embedded systems where 'active' trip points are used to send
> >>>> notification to the userspace. This is obviously not right because
> >>>> these trip are handled by the kernel.
> >>>>
> >>>> This patch introduces the 'user' trip point type where its semantic =
is
> >>>> simple: do nothing at the kernel level, just send a notification to
> >>>> the user space.
> >>>
> >>> Sounds like OS behavior/policy though I guess the existing ones kind =
are
> >>> too. Maybe we should have defined *what* action to take and then the =
OS
> >>> could decide whether what actions to handle vs. pass it up a level.
> >>
> >> Right
> >>
> >>> Why can't userspace just ask to be notified at a trip point it
> >>> defines?
> >>
> >> Yes I think it is possible to create a netlink message to create a tri=
p
> >> point which will return a trip id.
> >>
> >> Rafael what do you think ?
> >
> > Trips cannot be created on the fly ATM.
> >
> > What can be done is to create trips that are invalid to start with and
> > then set their temperature via sysfs.  This has been done already for
> > quite a while AFAICS.
>
> Yes, I remember that.
>
> I would like to avoid introducing more weirdness in the thermal
> framework which deserve a clear ABI.
>
> What is missing to create new trip points on the fly ?

A different data structure to store them (essentially, a list instead
of an array).

I doubt it's worth the hassle.

What's wrong with the current approach mentioned above?  It will need
to be supported going forward anyway.

