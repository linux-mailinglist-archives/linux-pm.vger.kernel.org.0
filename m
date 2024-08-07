Return-Path: <linux-pm+bounces-11980-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BDC794B2AC
	for <lists+linux-pm@lfdr.de>; Thu,  8 Aug 2024 00:05:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C0FA61F21C8C
	for <lists+linux-pm@lfdr.de>; Wed,  7 Aug 2024 22:05:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01D4F14A0B7;
	Wed,  7 Aug 2024 22:05:17 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from spindle.queued.net (spindle.queued.net [45.33.49.30])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B828146599;
	Wed,  7 Aug 2024 22:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.33.49.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723068316; cv=none; b=a2YhbZpy8CVSmfcF54s6ROx+eqhb6WbuCbgh0nYsjxSoJ3bV45KRk4ER7zyHsqGI9mZ0RpQNJCIaNpux22cB4JI4AvO8jnLanWBZOqwtZksZzR24MTbDIyzYiYHGi29idAm7F/I1uJEV2FZ9Y0OIZVe8YTuWCKWuYhSbLXrKNco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723068316; c=relaxed/simple;
	bh=/4oxLI0YVIoUMEaUDNST3JFDcbtvCjjHiKizjxd/pFY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EtYMo1nuEVtn2piYWYROR4qdib2gTAZhEYoDQYMto4nf/88ujXfv14XkD8BOW/sh5QQ/VDyqtRzSTdtij1nENrhWZ5H1szaoC/BFy0F/02mwBQMy1b3sHl0SsZkWqvI8BnZQWcB1wBO5sbkaLoefGhjMVyZ9FC4Ilq6HDV828ys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=queued.net; spf=pass smtp.mailfrom=queued.net; arc=none smtp.client-ip=45.33.49.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=queued.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queued.net
Received: by spindle.queued.net (Postfix, from userid 1001)
	id 9AC62115D23; Wed,  7 Aug 2024 18:05:14 -0400 (EDT)
Received: from 5400 (unknown [172.56.34.244])
	by spindle.queued.net (Postfix) with ESMTPSA id 5B143115D1B;
	Wed,  7 Aug 2024 18:05:13 -0400 (EDT)
Date: Wed, 7 Aug 2024 18:05:11 -0400
From: Andres Salomon <dilinger@queued.net>
To: Pali =?UTF-8?B?Um9ow6Fy?= <pali@kernel.org>
Cc: Armin Wolf <W_Armin@gmx.de>, linux-kernel@vger.kernel.org,
 platform-driver-x86@vger.kernel.org, Matthew Garrett <mjg59@srcf.ucam.org>,
 Sebastian Reichel <sre@kernel.org>, Hans de Goede <hdegoede@redhat.com>,
 Ilpo =?UTF-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
 linux-pm@vger.kernel.org, Dell.Client.Kernel@dell.com
Subject: Re: [PATCH v2 1/2] platform/x86:dell-laptop: Add knobs to change
 battery charge settings
Message-ID: <20240807180511.436bc1af@5400>
In-Reply-To: <20240807214413.emwpxferfbcp7vlp@pali>
References: <20240724182318.66578a48@5400>
	<20240724230158.nsmxdgagfpanjtzi@pali>
	<20240725162457.34b480e1@5400>
	<20240725221511.mqb4tlam2r7yheoi@pali>
	<45c7c4c3-2f99-4ca0-9c85-a96a03ccfae8@gmx.de>
	<20240726000409.ejnvqkzco664q3zb@pali>
	<20240726002538.558a4a97@5400>
	<8fde7bae-b4e3-458e-8edc-22199f8bc7e2@gmx.de>
	<5cfe4c42-a003-4668-8c3a-f18fb6b7fba6@gmx.de>
	<20240807172832.09040123@5400>
	<20240807214413.emwpxferfbcp7vlp@pali>
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

On Wed, 7 Aug 2024 23:44:13 +0200
Pali Roh=C3=A1r <pali@kernel.org> wrote:

> On Wednesday 07 August 2024 17:28:32 Andres Salomon wrote:
> > On Fri, 26 Jul 2024 20:46:22 +0200
> > Armin Wolf <W_Armin@gmx.de> wrote:
> >  =20
> > > Am 26.07.24 um 20:42 schrieb Armin Wolf:
> > >  =20
> > > > Am 26.07.24 um 06:25 schrieb Andres Salomon:
> > > >   =20
> > > >> On Fri, 26 Jul 2024 02:04:09 +0200
> > > >> Pali Roh=C3=A1r <pali@kernel.org> wrote:
> > > >>   =20
> > > >>> On Friday 26 July 2024 01:48:50 Armin Wolf wrote:   =20
> > > >>>> Am 26.07.24 um 00:15 schrieb Pali Roh=C3=A1r:
> > > >>>>   =20
> > > >>>>> On Thursday 25 July 2024 16:24:57 Andres Salomon wrote:   =20
> > > >>>>>> On Thu, 25 Jul 2024 01:01:58 +0200
> > > >>>>>> Pali Roh=C3=A1r <pali@kernel.org> wrote:
> > > >>>>>>   =20
> > > >>>>>>> On Wednesday 24 July 2024 18:23:18 Andres Salomon wrote:   =20
> > > >> [...]   =20
> > > >>>>>>> The issue here is: how to tell kernel that the particular
> > > >>>>>>> dell_battery_hook has to be bound with the primary battery?
> > > >>>>>>>   =20
> > > >>>>>> So from userspace, we've got the expectation that multiple bat=
teries
> > > >>>>>> would show up as /sys/class/power_supply/BAT0,
> > > >>>>>> /sys/class/power_supply/BAT1,
> > > >>>>>> and so on.   =20
> > > >>>>> Yes, I hope so.
> > > >>>>>   =20
> > > >>>>>> The current BAT0 entry shows things like 'capacity' even witho=
ut
> > > >>>>>> this
> > > >>>>>> patch, and we're just piggybacking off of that to add charge_t=
ype
> > > >>>>>> and
> > > >>>>>> other entries. So there shouldn't be any confusion there, agre=
ed?   =20
> > > >>>>> I have not looked at the battery_hook_register() code yet (seems
> > > >>>>> that I
> > > >>>>> would have to properly read it and understand it). But does it
> > > >>>>> mean that
> > > >>>>> battery_hook_register() is adding hook just for "BAT0"?
> > > >>>>>
> > > >>>>> What I mean: cannot that hook be registered to "BAT1" too? Beca=
use if
> > > >>>>> yes then we should prevent it. Otherwise this hook which is for=
 "Dell
> > > >>>>> Primary Battery" could be registered also for secondary battery
> > > >>>>> "BAT1".
> > > >>>>> (I hope that now it is more clear what I mean).   =20
> > > >>>> Hi,
> > > >>>>
> > > >>>> the battery hook is being registered to all ACPI batteries prese=
nt
> > > >>>> on a given system,
> > > >>>> so you need to do some manual filtering when .add_battery() is c=
alled.   =20
> > > >>> Ok. So it means that the filtering based on the primary battery in
> > > >>> add_battery callback is needed.
> > > >>>   =20
> > > >> Thanks for the explanations. Seems simple enough to fix that, as s=
ome of
> > > >> the other drivers are checking battery->desc->name for "BAT0".
> > > >>
> > > >>
> > > >> One thing that I keep coming back to, and was reinforced as I look=
ed at
> > > >> include/linux/power_supply.h; the generic power supply charge_type=
 has
> > > >> values that are very close to Dells, but with different names. I c=
ould
> > > >> shoehorn them in, though, with the following mappings:
> > > >>
> > > >> POWER_SUPPLY_CHARGE_TYPE_FAST,=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 =3D> "express" (aka ExpressCharge)
> > > >> POWER_SUPPLY_CHARGE_TYPE_STANDARD,=C2=A0=C2=A0=C2=A0=C2=A0 =3D> "s=
tandard"
> > > >> POWER_SUPPLY_CHARGE_TYPE_ADAPTIVE,=C2=A0=C2=A0=C2=A0=C2=A0 =3D> "a=
daptive"
> > > >> POWER_SUPPLY_CHARGE_TYPE_CUSTOM,=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 =3D> "custom"
> > > >> POWER_SUPPLY_CHARGE_TYPE_LONGLIFE,=C2=A0=C2=A0=C2=A0=C2=A0 =3D> "p=
rimarily_ac"
> > > >>
> > > >> The main difference is that Primarily AC is described and document=
ed as
> > > >> slightly different than Long Life, but I suspect the result is rou=
ghly
> > > >> the same thing. And the naming "Fast" and "Long Life" wouldn't mat=
ch the
> > > >> BIOS naming of "ExpressCharge" and "Primarily AC".
> > > >>
> > > >> Until now I've opted to match the BIOS naming, but I'm curious what
> > > >> others
> > > >> think before I send V3 of the patches.   =20
> > > >
> > > > I agree that POWER_SUPPLY_CHARGE_TYPE_FAST should be mapped the
> > > > ExpressCharge,
> > > > but i think that "primarily_ac" should become a official power supp=
ly
> > > > charging mode.
> > > >
> > > > The reason is that for example the wilco-charger driver also suppor=
ts
> > > > such a charging mode
> > > > (currently reported as POWER_SUPPLY_CHARGE_TYPE_TRICKLE) and the
> > > > charging mode seems to be
> > > > both sufficiently different from
> > > > POWER_SUPPLY_CHARGE_TYPE_LONGLIFE/POWER_SUPPLY_CHARGE_TYPE_TRICKLE
> > > > and sufficiently generic to be supported by a wide array of devices.
> > > >
> > > > Thanks,
> > > > Armin Wolf
> > > >   =20
> > > I just read the documentation regarding the charge_type sysfs attribu=
te and it states that:
> > >=20
> > > Trickle:
> > > 	Extends battery lifespan, intended for users who
> > > 	primarily use their Chromebook while connected to AC.
> > >=20
> > > So i think that "primarily_ac" should be mapped to POWER_SUPPLY_CHARG=
E_TYPE_TRICKLE. =20
> >=20
> > Do you think it's worth keeping around the sysfs-class-power-dell
> > file? At this point it's basically just documenting the slight naming
> > differences:
> >=20
> >=20
> >                 Standard:
> >                         Fully charge the battery at a moderate rate.
> >                 Fast:
> >                         Quickly charge the battery using fast-charge
> >                         technology. This is harder on the battery than
> >                         standard charging and may lower its lifespan.
> >                         The Dell BIOS calls this ExpressCharge=E2=84=A2.
> >                 Trickle:
> >                         Users who primarily operate the system while
> >                         plugged into an external power source can extend
> >                         battery life with this mode. The Dell BIOS calls
> >                         this "Primarily AC Use".
> >                 Adaptive:
> >                         Automatically optimize battery charge rate based
> >                         on typical usage pattern.
> >                 Custom:
> >                         Use the charge_control_* properties to determine
> >                         when to start and stop charging. Advanced users
> >                         can use this to drastically extend battery life.
> >=20
> >                 Access: Read, Write
> >                 Valid values:
> >                               "Standard", "Fast", "Trickle",
> >                               "Adaptive", "Custom" =20
>=20
> Another option could be to extend the description in sysfs-class-power
> file that "Trickle" covers "Dell's Primarily AC Use" and "Fast" covers
> "Dell's ExpressCharge".
>=20
> So if somebody is going to implement charge_type for some other Laptop
> vendor then this information can help.

How's this?

@@ -378,8 +378,10 @@ Date:              July 2009
 Contact:       linux-pm@vger.kernel.org
 Description:
                Represents the type of charging currently being applied to =
the
-               battery. "Trickle", "Fast", and "Standard" all mean differe=
nt
-               charging speeds. "Adaptive" means that the charger uses some
+               battery. "Fast" and "Standard" mean different charging spee=
ds.
+               "Trickle" means a slow charging speed, or (depending on the
+               hardware) charging optimized for being mostly plugged into
+               wall power. "Adaptive" means that the charger uses some
                algorithm to adjust the charge rate dynamically, without
                any user configuration required. "Custom" means that the ch=
arger


--=20
I'm available for contract & employment work, please contact me if
interested.

