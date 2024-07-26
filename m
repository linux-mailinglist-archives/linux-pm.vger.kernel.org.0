Return-Path: <linux-pm+bounces-11414-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D898393CD2D
	for <lists+linux-pm@lfdr.de>; Fri, 26 Jul 2024 06:26:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 378FEB21977
	for <lists+linux-pm@lfdr.de>; Fri, 26 Jul 2024 04:26:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9B1322612;
	Fri, 26 Jul 2024 04:25:57 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from spindle.queued.net (spindle.queued.net [45.33.49.30])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13BFC7F8;
	Fri, 26 Jul 2024 04:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.33.49.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721967957; cv=none; b=piCK9HPNhk0WaN2aptMgRo6RWKBDoZcOnJ73U4YNB/gFELeDpWQ/rD5bl2BhQeIwqc2kU81BhuHgtotAs1jFS9CSlYa9i9mehQ/sCL28HXU13KOIC5w+XxnAIBWg2nfktq4tpFYtuvhLacegAo5ywDLqC2TlCQ1N1dkMub955nI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721967957; c=relaxed/simple;
	bh=Agl7eeWAoV0CJCGZNa9ZfT/v4yRIB+wwnC9BE8+TvM0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=U/JSDS+X5AOJzjwsFCIXGcYc8IScUilCqlEVhWUE1su48ByHOCNP0baaq1S09vROhabXexPfVfNO3/H+cEt3kwdkvVnk7+ce5wRxU/lyG4f2cM5B0X0wMZWqWiCo3lgosRam1lOMF3gkz+xoO89esJevDDArcisSAS1yoQix05A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=queued.net; spf=pass smtp.mailfrom=queued.net; arc=none smtp.client-ip=45.33.49.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=queued.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queued.net
Received: by spindle.queued.net (Postfix, from userid 1001)
	id D23D3107930; Fri, 26 Jul 2024 00:25:49 -0400 (EDT)
Received: from 5400 (unknown [172.56.161.71])
	by spindle.queued.net (Postfix) with ESMTPSA id 0FBBE10117A;
	Fri, 26 Jul 2024 00:25:47 -0400 (EDT)
Date: Fri, 26 Jul 2024 00:25:38 -0400
From: Andres Salomon <dilinger@queued.net>
To: Pali =?UTF-8?B?Um9ow6Fy?= <pali@kernel.org>
Cc: Armin Wolf <W_Armin@gmx.de>, linux-kernel@vger.kernel.org,
 platform-driver-x86@vger.kernel.org, Matthew Garrett <mjg59@srcf.ucam.org>,
 Sebastian Reichel <sre@kernel.org>, Hans de Goede <hdegoede@redhat.com>,
 Ilpo =?UTF-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
 linux-pm@vger.kernel.org, Dell.Client.Kernel@dell.com
Subject: Re: [PATCH v2 1/2] platform/x86:dell-laptop: Add knobs to change
 battery charge settings
Message-ID: <20240726002538.558a4a97@5400>
In-Reply-To: <20240726000409.ejnvqkzco664q3zb@pali>
References: <20240723220502.77cb0401@5400>
	<20240724203403.zcrx2lshbla3o2gp@pali>
	<20240724204523.xb6rp7ba6yqi5klt@pali>
	<20240724182318.66578a48@5400>
	<20240724230158.nsmxdgagfpanjtzi@pali>
	<20240725162457.34b480e1@5400>
	<20240725221511.mqb4tlam2r7yheoi@pali>
	<45c7c4c3-2f99-4ca0-9c85-a96a03ccfae8@gmx.de>
	<20240726000409.ejnvqkzco664q3zb@pali>
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

On Fri, 26 Jul 2024 02:04:09 +0200
Pali Roh=C3=A1r <pali@kernel.org> wrote:

> On Friday 26 July 2024 01:48:50 Armin Wolf wrote:
> > Am 26.07.24 um 00:15 schrieb Pali Roh=C3=A1r:
> >  =20
> > > On Thursday 25 July 2024 16:24:57 Andres Salomon wrote: =20
> > > > On Thu, 25 Jul 2024 01:01:58 +0200
> > > > Pali Roh=C3=A1r <pali@kernel.org> wrote:
> > > >  =20
> > > > > On Wednesday 24 July 2024 18:23:18 Andres Salomon wrote: =20
[...]
> > > > >=20
> > > > > The issue here is: how to tell kernel that the particular
> > > > > dell_battery_hook has to be bound with the primary battery?
> > > > >  =20
> > > > So from userspace, we've got the expectation that multiple batteries
> > > > would show up as /sys/class/power_supply/BAT0, /sys/class/power_sup=
ply/BAT1,
> > > > and so on. =20
> > > Yes, I hope so.
> > >  =20
> > > > The current BAT0 entry shows things like 'capacity' even without th=
is
> > > > patch, and we're just piggybacking off of that to add charge_type a=
nd
> > > > other entries. So there shouldn't be any confusion there, agreed? =
=20
> > > I have not looked at the battery_hook_register() code yet (seems that=
 I
> > > would have to properly read it and understand it). But does it mean t=
hat
> > > battery_hook_register() is adding hook just for "BAT0"?
> > >=20
> > > What I mean: cannot that hook be registered to "BAT1" too? Because if
> > > yes then we should prevent it. Otherwise this hook which is for "Dell
> > > Primary Battery" could be registered also for secondary battery "BAT1=
".
> > > (I hope that now it is more clear what I mean). =20
> >=20
> > Hi,
> >=20
> > the battery hook is being registered to all ACPI batteries present on a=
 given system,
> > so you need to do some manual filtering when .add_battery() is called. =
=20
>=20
> Ok. So it means that the filtering based on the primary battery in
> add_battery callback is needed.
>=20

Thanks for the explanations. Seems simple enough to fix that, as some of
the other drivers are checking battery->desc->name for "BAT0".


One thing that I keep coming back to, and was reinforced as I looked at
include/linux/power_supply.h; the generic power supply charge_type has
values that are very close to Dells, but with different names. I could
shoehorn them in, though, with the following mappings:

POWER_SUPPLY_CHARGE_TYPE_FAST,         =3D> "express" (aka ExpressCharge)
POWER_SUPPLY_CHARGE_TYPE_STANDARD,     =3D> "standard"
POWER_SUPPLY_CHARGE_TYPE_ADAPTIVE,     =3D> "adaptive"
POWER_SUPPLY_CHARGE_TYPE_CUSTOM,       =3D> "custom"
POWER_SUPPLY_CHARGE_TYPE_LONGLIFE,     =3D> "primarily_ac"

The main difference is that Primarily AC is described and documented as
slightly different than Long Life, but I suspect the result is roughly
the same thing. And the naming "Fast" and "Long Life" wouldn't match the
BIOS naming of "ExpressCharge" and "Primarily AC".

Until now I've opted to match the BIOS naming, but I'm curious what others
think before I send V3 of the patches.


--=20
I'm available for contract & employment work, see:
https://spindle.queued.net/~dilinger/resume-tech.pdf

