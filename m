Return-Path: <linux-pm+bounces-10336-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F36E923C3C
	for <lists+linux-pm@lfdr.de>; Tue,  2 Jul 2024 13:18:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 11D8F280AC4
	for <lists+linux-pm@lfdr.de>; Tue,  2 Jul 2024 11:18:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEAC915B0F1;
	Tue,  2 Jul 2024 11:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UWX4TTDZ"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F240157469;
	Tue,  2 Jul 2024 11:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719919086; cv=none; b=t3sLIKuMP1HUHh0lg3tReT9YbqMN6r1+3hxf7hCJ55R/ODvYQl84Up6NmaqONbgkZWmJSHxju90gZ+H+OIDgSo7YkXAcCsdJxfU/5yOvZ4EUBKjzER6JfVB4223x6zHjRpWuTNzmwjtdrjPvOBeV3Ozychogq6Szm/9L3bM/ZAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719919086; c=relaxed/simple;
	bh=FoMJEf11Lf66dhLhMVRO8nkinE1cWndTb/sbrx0+H3w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ntzxp2+wTnITQIczwyYO3wpo/0wuzLW6TI4I1Od5Wj+Ni2IwQ6hGqg9jS4YXkvLLxv1dhDVZl+JFWnQ8XorCCDaojSYWKhO/geD9gX052iSG9hU6/VK1CF/SLHtGNXBqls7kCX8F0KMt9NlGVloHxYUmYjvhehDN2LZQEjIZB3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UWX4TTDZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10F70C4AF0E;
	Tue,  2 Jul 2024 11:18:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719919086;
	bh=FoMJEf11Lf66dhLhMVRO8nkinE1cWndTb/sbrx0+H3w=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=UWX4TTDZflWPasT7VEjcnWzmqTvL4hpDJewnnk61hH3mx54u63K8u68IQ7ql8SDJW
	 rGIFs9GI5vI3b7bwRjDx0gcQckkRa2ILsnZHAGQgwkiw5/PAwHDWJQftEE7BLo+Mna
	 ZjeDDOJBY1NnZPcIjrrWRFU2dAiaYalAxRjcb0iM6aPPp0zRhoNYf1r+uGU+fYF5DJ
	 hCPzLF9mSyeoAnb7wTb9qwtqVmBQAiGGWMUqfZ7yOG+0g3x1HfJbTy5vxgKoLK50RG
	 Mb0oXqlHiS1ibslI8br81uJFi1zb5lRuskH+0NbJLMIwoGJkXMDlit71RUf918+Hl8
	 DOZ4OdiqCCI/Q==
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-25d0f8d79ebso609417fac.0;
        Tue, 02 Jul 2024 04:18:06 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXBBOKJkPSi1RPt3L/6lfqT7kAV97l65Q3lLKlEAEpKnVtiyLWWnwcTatCIqvTzb/9k95Tjpx+zK2+Lo0sxsTfPbJ1Bg8sVVZcYV+i9PGnCIda8Rv5Vg8O5lHlBICpeDYvxKxGGlDDUF0fWuhnKVx5hFDlnTVbG6bwlRotFfXUoIxN0
X-Gm-Message-State: AOJu0YyDEGUfXeskovj9dhBS7ap0UwmfBA7T/Y523g2zDGUTbqG3l5ZJ
	Pm0HW6swn0p53XZWkR/9gdP/UfVl2rFJY/WBXEEBAuqNwn8kaS1Du8uJEpVBKw0t7H/rsb6GQg1
	JGmeckI4Y3Uv9hnuWxpBIaoJ5TO0=
X-Google-Smtp-Source: AGHT+IFSROubL/WzUl2sx2objLG8DvmvKWe6cA/P6eX8rr89hODSqXxMCvpxDjHg0YZehdNgAgdbkFSnDnT5+aJSjD0=
X-Received: by 2002:a05:6870:2892:b0:255:1fea:340d with SMTP id
 586e51a60fabf-25db3049d93mr8496774fac.0.1719919085156; Tue, 02 Jul 2024
 04:18:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240627085451.3813989-1-daniel.lezcano@linaro.org>
 <20240701162600.GA4119789-robh@kernel.org> <98fe3146-07ae-4095-b372-6aed6e080d94@linaro.org>
 <CAJZ5v0ix+RDtrR+r3jd=A_W7D5U7JodMiirJ519-wwLrHeBbSw@mail.gmail.com>
 <1eb7eb88-4230-4803-83fe-415ce0745951@linaro.org> <CAJZ5v0jV+0bWqpCR1Q2rYLJvx0J6hgExzRks6YDPL9gX_HK0rA@mail.gmail.com>
In-Reply-To: <CAJZ5v0jV+0bWqpCR1Q2rYLJvx0J6hgExzRks6YDPL9gX_HK0rA@mail.gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 2 Jul 2024 13:17:54 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0iFR8v=Kwj=aW84NTfqZGvTbXrL=dsLsaMt=okFTAftDQ@mail.gmail.com>
Message-ID: <CAJZ5v0iFR8v=Kwj=aW84NTfqZGvTbXrL=dsLsaMt=okFTAftDQ@mail.gmail.com>
Subject: Re: [PATCH] thermal/core: Introduce user trip points
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Rob Herring <robh@kernel.org>, linux-pm@vger.kernel.org, 
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 2, 2024 at 1:03=E2=80=AFPM Rafael J. Wysocki <rafael@kernel.org=
> wrote:
>
> On Tue, Jul 2, 2024 at 12:56=E2=80=AFPM Daniel Lezcano
> <daniel.lezcano@linaro.org> wrote:
> >
> > On 02/07/2024 12:22, Rafael J. Wysocki wrote:
> > > On Tue, Jul 2, 2024 at 11:29=E2=80=AFAM Daniel Lezcano
> > > <daniel.lezcano@linaro.org> wrote:
> > >>
> > >> On 01/07/2024 18:26, Rob Herring wrote:
> > >>> On Thu, Jun 27, 2024 at 10:54:50AM +0200, Daniel Lezcano wrote:
> > >>>> Currently the thermal framework has 4 trip point types:
> > >>>>
> > >>>> - active : basically for fans (or anything requiring energy to coo=
l
> > >>>>     down)
> > >>>>
> > >>>> - passive : a performance limiter
> > >>>>
> > >>>> - hot : for a last action before reaching critical
> > >>>>
> > >>>> - critical : a without return threshold leading to a system shutdo=
wn
> > >>>>
> > >>>> A thermal zone monitors the temperature regarding these trip
> > >>>> points. The old way to do that is actively polling the temperature
> > >>>> which is very bad for embedded systems, especially mobile and it i=
s
> > >>>> even worse today as we can have more than fifty thermal zones. The
> > >>>> modern way is to rely on the driver to send an interrupt when the =
trip
> > >>>> points are crossed, so the system can sleep while the temperature
> > >>>> monitoring is offloaded to a dedicated hardware.
> > >>>>
> > >>>> However, the thermal aspect is also managed from userspace to prot=
ect
> > >>>> the user, especially tracking down the skin temperature sensor. Th=
e
> > >>>> logic is more complex than what we found in the kernel because it
> > >>>> needs multiple sources indicating the thermal situation of the ent=
ire
> > >>>> system.
> > >>>>
> > >>>> For this reason it needs to setup trip points at different levels =
in
> > >>>> order to get informed about what is going on with some thermal zon=
es
> > >>>> when running some specific application.
> > >>>>
> > >>>> For instance, the skin temperature must be limited to 43=C2=B0C on=
 a long
> > >>>> run but can go to 48=C2=B0C for 10 minutes, or 60=C2=B0C for 1 min=
ute.
> > >>>>
> > >>>> The thermal engine must then rely on trip points to monitor those
> > >>>> temperatures. Unfortunately, today there is only 'active' and
> > >>>> 'passive' trip points which has a specific meaning for the kernel,=
 not
> > >>>> the userspace. That leads to hacks in different platforms for mobi=
le
> > >>>> and embedded systems where 'active' trip points are used to send
> > >>>> notification to the userspace. This is obviously not right because
> > >>>> these trip are handled by the kernel.
> > >>>>
> > >>>> This patch introduces the 'user' trip point type where its semanti=
c is
> > >>>> simple: do nothing at the kernel level, just send a notification t=
o
> > >>>> the user space.
> > >>>
> > >>> Sounds like OS behavior/policy though I guess the existing ones kin=
d are
> > >>> too. Maybe we should have defined *what* action to take and then th=
e OS
> > >>> could decide whether what actions to handle vs. pass it up a level.
> > >>
> > >> Right
> > >>
> > >>> Why can't userspace just ask to be notified at a trip point it
> > >>> defines?
> > >>
> > >> Yes I think it is possible to create a netlink message to create a t=
rip
> > >> point which will return a trip id.
> > >>
> > >> Rafael what do you think ?
> > >
> > > Trips cannot be created on the fly ATM.
> > >
> > > What can be done is to create trips that are invalid to start with an=
d
> > > then set their temperature via sysfs.  This has been done already for
> > > quite a while AFAICS.
> >
> > Yes, I remember that.
> >
> > I would like to avoid introducing more weirdness in the thermal
> > framework which deserve a clear ABI.
> >
> > What is missing to create new trip points on the fly ?
>
> A different data structure to store them (essentially, a list instead
> of an array).
>
> I doubt it's worth the hassle.
>
> What's wrong with the current approach mentioned above?  It will need
> to be supported going forward anyway.

BTW, there are two different concepts that seem to be mixed here.

One of them is a "trigger" that will cause a netlink message to be
sent to user space when a given temperature level is crossed (either
way) and nothing more.  This in principle can be added to any thermal
zone (even tripless) and should be possible to implement as a separate
mechanism independent of trip points.

The other one is a pair of trip points that can be set "around" the
current zone temperature so that the .set_trips() callback uses them
to program interrupts to trigger when one of them is crossed.  This at
least requires the thermal zone to provide a .set_trips() callback, so
it depends on the driver registering the thermal zone.  Arguably, the
driver in question can reserve a pair of "trip slots" in the trip
table passed to the zone registration function.

