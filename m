Return-Path: <linux-pm+bounces-10332-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DDE56923B4E
	for <lists+linux-pm@lfdr.de>; Tue,  2 Jul 2024 12:22:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4715EB2384E
	for <lists+linux-pm@lfdr.de>; Tue,  2 Jul 2024 10:22:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BB6B1581E1;
	Tue,  2 Jul 2024 10:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Uv1i1zgx"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4381154449;
	Tue,  2 Jul 2024 10:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719915755; cv=none; b=hJpQSEE1Wr3lSnat2Uy/uh/KkHu/fPJV546b2vv7D/xgDj3KRZqCFt0hixElMvui54Orm4R6NYvVd/uxGt2mhvkXtO8pBh1qDJOU/h/9w3SaEAkXS8SKBp8nkEf49j9wtVMQU4tEyQX3O/rhRsJouWVcI0GwUnvc0Mqevb2IKNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719915755; c=relaxed/simple;
	bh=kY4G8fMsq8khcMLuhqrf4meSl1bGoGNhcq89AOmYvNM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YDm/CE3TFnbxvk00fBzsPObfV9bJHgowopGqPJPugb2xBfqwEJ/OINDdCJ2IoVahNUbqX6Skbt59nMSzGTri3CM+FzmG41WyEuhfyZPW77nZ+9uvhw5LaTGc1qxPh2Bnmrm3luYUaGo42h83l/rYsFaHfvXKQxFoR34m1WWtz4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Uv1i1zgx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78D82C2BD10;
	Tue,  2 Jul 2024 10:22:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719915754;
	bh=kY4G8fMsq8khcMLuhqrf4meSl1bGoGNhcq89AOmYvNM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Uv1i1zgxplcovoKaAKg8Al7SdLlBliFGlH6QADzU23B4+/gMwhJxlwsvdAgeTp0K7
	 C/yRQfziD5SlO960jXuWVnNKXxYqgfih11s6GmND/vp6R6AcqAYlx+kM+vy6saWFb+
	 mwTFRt8qoD7GUmhGgsQt9PLVeolv9BPHcU1LGVV7b9LxBOCJp52g/REI3wZgd2E0lz
	 mRw+byGWgnMu9dmNdnHLzConiM2I6pRf1xZH3+RlOSynSrJvDEeM0Bm0AaOMLWjBNN
	 46R1HcsL/qamPxak1tI/gwlI1jAK9gr9wuYkR4cUSpa5W0RpS0WfR3gshJvb/JyDKG
	 RBwsRXGMj2mcg==
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-25989f87e20so634210fac.1;
        Tue, 02 Jul 2024 03:22:34 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCX+1PH3cfnJuo6LROax011TVeCm4hQgGtjWW7ypkg5+lr2appCpk2IGH4JPpTHIMv22rdENpPcWM26rpuTfOuC+R1TxoZgvvi1zOwZKnAj5GkpQOETbVZA8/m5jvBA8abYwKT3+TucRNKElJdOmGNM2yUrazeO0h0HDWNVIG8YGqLCc
X-Gm-Message-State: AOJu0YxRIYbm41YM5nR4NnzJgPS305JXlkzB9P9Ayx3Rjjp/8E6Vd4NT
	N3SW1hWXDWylTBTJbJv3MI/IQj/rhMoWROpD50Dt4Wq/jsaaMyFlRwEzDsj0BDCjig2/K4yqjcN
	ZyIVN9bvexOJq8FEbKD+XiyN5PWc=
X-Google-Smtp-Source: AGHT+IFbRbQ1dnPFfa/Pou79KYJIVZYGg481Ky7EOqZfI1YrTD1TEX/rmJ+MnO5wW/kSmHfVk54vZJ1a7Gn7VW2rwqU=
X-Received: by 2002:a05:6870:3751:b0:254:affe:5a08 with SMTP id
 586e51a60fabf-25db340a2d2mr7990894fac.2.1719915753777; Tue, 02 Jul 2024
 03:22:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240627085451.3813989-1-daniel.lezcano@linaro.org>
 <20240701162600.GA4119789-robh@kernel.org> <98fe3146-07ae-4095-b372-6aed6e080d94@linaro.org>
In-Reply-To: <98fe3146-07ae-4095-b372-6aed6e080d94@linaro.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 2 Jul 2024 12:22:20 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0ix+RDtrR+r3jd=A_W7D5U7JodMiirJ519-wwLrHeBbSw@mail.gmail.com>
Message-ID: <CAJZ5v0ix+RDtrR+r3jd=A_W7D5U7JodMiirJ519-wwLrHeBbSw@mail.gmail.com>
Subject: Re: [PATCH] thermal/core: Introduce user trip points
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Rob Herring <robh@kernel.org>, rafael@kernel.org, linux-pm@vger.kernel.org, 
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 2, 2024 at 11:29=E2=80=AFAM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
>
> On 01/07/2024 18:26, Rob Herring wrote:
> > On Thu, Jun 27, 2024 at 10:54:50AM +0200, Daniel Lezcano wrote:
> >> Currently the thermal framework has 4 trip point types:
> >>
> >> - active : basically for fans (or anything requiring energy to cool
> >>    down)
> >>
> >> - passive : a performance limiter
> >>
> >> - hot : for a last action before reaching critical
> >>
> >> - critical : a without return threshold leading to a system shutdown
> >>
> >> A thermal zone monitors the temperature regarding these trip
> >> points. The old way to do that is actively polling the temperature
> >> which is very bad for embedded systems, especially mobile and it is
> >> even worse today as we can have more than fifty thermal zones. The
> >> modern way is to rely on the driver to send an interrupt when the trip
> >> points are crossed, so the system can sleep while the temperature
> >> monitoring is offloaded to a dedicated hardware.
> >>
> >> However, the thermal aspect is also managed from userspace to protect
> >> the user, especially tracking down the skin temperature sensor. The
> >> logic is more complex than what we found in the kernel because it
> >> needs multiple sources indicating the thermal situation of the entire
> >> system.
> >>
> >> For this reason it needs to setup trip points at different levels in
> >> order to get informed about what is going on with some thermal zones
> >> when running some specific application.
> >>
> >> For instance, the skin temperature must be limited to 43=C2=B0C on a l=
ong
> >> run but can go to 48=C2=B0C for 10 minutes, or 60=C2=B0C for 1 minute.
> >>
> >> The thermal engine must then rely on trip points to monitor those
> >> temperatures. Unfortunately, today there is only 'active' and
> >> 'passive' trip points which has a specific meaning for the kernel, not
> >> the userspace. That leads to hacks in different platforms for mobile
> >> and embedded systems where 'active' trip points are used to send
> >> notification to the userspace. This is obviously not right because
> >> these trip are handled by the kernel.
> >>
> >> This patch introduces the 'user' trip point type where its semantic is
> >> simple: do nothing at the kernel level, just send a notification to
> >> the user space.
> >
> > Sounds like OS behavior/policy though I guess the existing ones kind ar=
e
> > too. Maybe we should have defined *what* action to take and then the OS
> > could decide whether what actions to handle vs. pass it up a level.
>
> Right
>
> > Why can't userspace just ask to be notified at a trip point it
> > defines?
>
> Yes I think it is possible to create a netlink message to create a trip
> point which will return a trip id.
>
> Rafael what do you think ?

Trips cannot be created on the fly ATM.

What can be done is to create trips that are invalid to start with and
then set their temperature via sysfs.  This has been done already for
quite a while AFAICS.

> > If we keep this in DT, perhaps 'notice' would be a better name that
> > doesn't encode the OS architecture details.
>
> [ ... ]
>
> > BTW, can we decide what to do about 'trips' node being required or not?
> > That's nearly the only DT warning left for some platforms.
>
> A thermal zone is a combination of a sensor, a mitigation logic (user or
> kernel), hardware limits with trip points to activate the logic. Without
> trip points, this logic can not operate, consequently the thermal zone
> description is incomplete.

Well, there is a concept of a tripless thermal zone which simply
represents a sensor.

> I guess those thermal zones are set to have the sensor exported in
> /sys/class/thermal, so the userspace can access the temperature.

I think so.

> However, existing thermal zone description should have at least a 'hot'
> trip point and a 'critical' trip point.
>
> On the other hand, now that we are introducing the 'user' trip point,
> those thermal zone can exist without trip points because we can create
> them at any time from userspace.

No, they cannot be created at any time.

> So at the first glance, I would say we can drop the "required"
> constraint for the trip points in the thermal zone description.

That's correct, but for other reasons.

