Return-Path: <linux-pm+bounces-11978-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C9D794B23D
	for <lists+linux-pm@lfdr.de>; Wed,  7 Aug 2024 23:35:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EDED0B235F2
	for <lists+linux-pm@lfdr.de>; Wed,  7 Aug 2024 21:35:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A244A1487E3;
	Wed,  7 Aug 2024 21:35:41 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from spindle.queued.net (spindle.queued.net [45.33.49.30])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECCB412C53B;
	Wed,  7 Aug 2024 21:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.33.49.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723066541; cv=none; b=jIWjo/+AIIqlJaHREFTQXM9j4iYgOiLQ7R4aqLofhIT4FE9soeC/hNXMW8eqfDN2Eb63hg9suoS+mpGe8sD0aSOF6D5jR9W74yt3IkLC/wi9fDehUvKqimJWkCgONPn542CqqcRbCDQgk7rvxcGZbTm/n2ENklGElXYG0ux50gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723066541; c=relaxed/simple;
	bh=UJC9323VtPxuiRvjZrtK5nomYm2uVs4GWA1F7lVLzhA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FBtBFWYXFEgxLalu9KwP9E8NO2oT0+uzUZiD7lcssozEwK0Xo7+MEaL+vIL3FNPUN0nF2NcB/6WsEWidwjb/EF31+671D4n5Q3DdA3wlLQn2KmcNmgv814LwzD9DJJczgwIc1XnI6UyfXI0HpqIgNYEgFpUFG2+3RGqfPM8obLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=queued.net; spf=pass smtp.mailfrom=queued.net; arc=none smtp.client-ip=45.33.49.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=queued.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queued.net
Received: by spindle.queued.net (Postfix, from userid 1001)
	id 682DC115D13; Wed,  7 Aug 2024 17:28:37 -0400 (EDT)
Received: from 5400 (unknown [172.56.34.244])
	by spindle.queued.net (Postfix) with ESMTPSA id 7AE4E115D0E;
	Wed,  7 Aug 2024 17:28:34 -0400 (EDT)
Date: Wed, 7 Aug 2024 17:28:32 -0400
From: Andres Salomon <dilinger@queued.net>
To: Armin Wolf <W_Armin@gmx.de>
Cc: Pali =?UTF-8?B?Um9ow6Fy?= <pali@kernel.org>,
 linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org, Matthew
 Garrett <mjg59@srcf.ucam.org>, Sebastian Reichel <sre@kernel.org>, Hans de
 Goede <hdegoede@redhat.com>, Ilpo =?UTF-8?B?SsOkcnZpbmVu?=
 <ilpo.jarvinen@linux.intel.com>, linux-pm@vger.kernel.org,
 Dell.Client.Kernel@dell.com
Subject: Re: [PATCH v2 1/2] platform/x86:dell-laptop: Add knobs to change
 battery charge settings
Message-ID: <20240807172832.09040123@5400>
In-Reply-To: <5cfe4c42-a003-4668-8c3a-f18fb6b7fba6@gmx.de>
References: <20240723220502.77cb0401@5400>
	<20240724203403.zcrx2lshbla3o2gp@pali>
	<20240724204523.xb6rp7ba6yqi5klt@pali>
	<20240724182318.66578a48@5400>
	<20240724230158.nsmxdgagfpanjtzi@pali>
	<20240725162457.34b480e1@5400>
	<20240725221511.mqb4tlam2r7yheoi@pali>
	<45c7c4c3-2f99-4ca0-9c85-a96a03ccfae8@gmx.de>
	<20240726000409.ejnvqkzco664q3zb@pali>
	<20240726002538.558a4a97@5400>
	<8fde7bae-b4e3-458e-8edc-22199f8bc7e2@gmx.de>
	<5cfe4c42-a003-4668-8c3a-f18fb6b7fba6@gmx.de>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Bogosity: Ham, tests=bogofilter, spamicity=0.000000, version=1.2.5

On Fri, 26 Jul 2024 20:46:22 +0200
Armin Wolf <W_Armin@gmx.de> wrote:

> Am 26.07.24 um 20:42 schrieb Armin Wolf:
>=20
> > Am 26.07.24 um 06:25 schrieb Andres Salomon:
> > =20
> >> On Fri, 26 Jul 2024 02:04:09 +0200
> >> Pali Roh=C3=A1r <pali@kernel.org> wrote:
> >> =20
> >>> On Friday 26 July 2024 01:48:50 Armin Wolf wrote: =20
> >>>> Am 26.07.24 um 00:15 schrieb Pali Roh=C3=A1r:
> >>>> =20
> >>>>> On Thursday 25 July 2024 16:24:57 Andres Salomon wrote: =20
> >>>>>> On Thu, 25 Jul 2024 01:01:58 +0200
> >>>>>> Pali Roh=C3=A1r <pali@kernel.org> wrote:
> >>>>>> =20
> >>>>>>> On Wednesday 24 July 2024 18:23:18 Andres Salomon wrote: =20
> >> [...] =20
> >>>>>>> The issue here is: how to tell kernel that the particular
> >>>>>>> dell_battery_hook has to be bound with the primary battery?
> >>>>>>> =20
> >>>>>> So from userspace, we've got the expectation that multiple batteri=
es
> >>>>>> would show up as /sys/class/power_supply/BAT0,
> >>>>>> /sys/class/power_supply/BAT1,
> >>>>>> and so on. =20
> >>>>> Yes, I hope so.
> >>>>> =20
> >>>>>> The current BAT0 entry shows things like 'capacity' even without
> >>>>>> this
> >>>>>> patch, and we're just piggybacking off of that to add charge_type
> >>>>>> and
> >>>>>> other entries. So there shouldn't be any confusion there, agreed? =
=20
> >>>>> I have not looked at the battery_hook_register() code yet (seems
> >>>>> that I
> >>>>> would have to properly read it and understand it). But does it
> >>>>> mean that
> >>>>> battery_hook_register() is adding hook just for "BAT0"?
> >>>>>
> >>>>> What I mean: cannot that hook be registered to "BAT1" too? Because =
if
> >>>>> yes then we should prevent it. Otherwise this hook which is for "De=
ll
> >>>>> Primary Battery" could be registered also for secondary battery
> >>>>> "BAT1".
> >>>>> (I hope that now it is more clear what I mean). =20
> >>>> Hi,
> >>>>
> >>>> the battery hook is being registered to all ACPI batteries present
> >>>> on a given system,
> >>>> so you need to do some manual filtering when .add_battery() is calle=
d. =20
> >>> Ok. So it means that the filtering based on the primary battery in
> >>> add_battery callback is needed.
> >>> =20
> >> Thanks for the explanations. Seems simple enough to fix that, as some =
of
> >> the other drivers are checking battery->desc->name for "BAT0".
> >>
> >>
> >> One thing that I keep coming back to, and was reinforced as I looked at
> >> include/linux/power_supply.h; the generic power supply charge_type has
> >> values that are very close to Dells, but with different names. I could
> >> shoehorn them in, though, with the following mappings:
> >>
> >> POWER_SUPPLY_CHARGE_TYPE_FAST,=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 =3D> "express" (aka ExpressCharge)
> >> POWER_SUPPLY_CHARGE_TYPE_STANDARD,=C2=A0=C2=A0=C2=A0=C2=A0 =3D> "stand=
ard"
> >> POWER_SUPPLY_CHARGE_TYPE_ADAPTIVE,=C2=A0=C2=A0=C2=A0=C2=A0 =3D> "adapt=
ive"
> >> POWER_SUPPLY_CHARGE_TYPE_CUSTOM,=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
=3D> "custom"
> >> POWER_SUPPLY_CHARGE_TYPE_LONGLIFE,=C2=A0=C2=A0=C2=A0=C2=A0 =3D> "prima=
rily_ac"
> >>
> >> The main difference is that Primarily AC is described and documented as
> >> slightly different than Long Life, but I suspect the result is roughly
> >> the same thing. And the naming "Fast" and "Long Life" wouldn't match t=
he
> >> BIOS naming of "ExpressCharge" and "Primarily AC".
> >>
> >> Until now I've opted to match the BIOS naming, but I'm curious what
> >> others
> >> think before I send V3 of the patches. =20
> >
> > I agree that POWER_SUPPLY_CHARGE_TYPE_FAST should be mapped the
> > ExpressCharge,
> > but i think that "primarily_ac" should become a official power supply
> > charging mode.
> >
> > The reason is that for example the wilco-charger driver also supports
> > such a charging mode
> > (currently reported as POWER_SUPPLY_CHARGE_TYPE_TRICKLE) and the
> > charging mode seems to be
> > both sufficiently different from
> > POWER_SUPPLY_CHARGE_TYPE_LONGLIFE/POWER_SUPPLY_CHARGE_TYPE_TRICKLE
> > and sufficiently generic to be supported by a wide array of devices.
> >
> > Thanks,
> > Armin Wolf
> > =20
> I just read the documentation regarding the charge_type sysfs attribute a=
nd it states that:
>=20
> Trickle:
> 	Extends battery lifespan, intended for users who
> 	primarily use their Chromebook while connected to AC.
>=20
> So i think that "primarily_ac" should be mapped to POWER_SUPPLY_CHARGE_TY=
PE_TRICKLE.

Do you think it's worth keeping around the sysfs-class-power-dell
file? At this point it's basically just documenting the slight naming
differences:


                Standard:
                        Fully charge the battery at a moderate rate.
                Fast:
                        Quickly charge the battery using fast-charge
                        technology. This is harder on the battery than
                        standard charging and may lower its lifespan.
                        The Dell BIOS calls this ExpressCharge=E2=84=A2.
                Trickle:
                        Users who primarily operate the system while
                        plugged into an external power source can extend
                        battery life with this mode. The Dell BIOS calls
                        this "Primarily AC Use".
                Adaptive:
                        Automatically optimize battery charge rate based
                        on typical usage pattern.
                Custom:
                        Use the charge_control_* properties to determine
                        when to start and stop charging. Advanced users
                        can use this to drastically extend battery life.

                Access: Read, Write
                Valid values:
                              "Standard", "Fast", "Trickle",
                              "Adaptive", "Custom"





--=20
I'm available for contract & employment work, please contact me if
interested.

