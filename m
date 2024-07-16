Return-Path: <linux-pm+bounces-11171-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B387932E76
	for <lists+linux-pm@lfdr.de>; Tue, 16 Jul 2024 18:38:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C56E1F239D3
	for <lists+linux-pm@lfdr.de>; Tue, 16 Jul 2024 16:38:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C9BE19E822;
	Tue, 16 Jul 2024 16:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=natalenko.name header.i=@natalenko.name header.b="khRQU3Ny"
X-Original-To: linux-pm@vger.kernel.org
Received: from prime.voidband.net (prime.voidband.net [199.247.17.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EE3B1DFF0;
	Tue, 16 Jul 2024 16:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.247.17.104
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721147879; cv=none; b=PtfIKX0E0Nr9DJ+8YWAHpci6btEAGx/GOPUx+P3osJ/ne8WeAzU400hgItb0wtm1cybFBZY3V3M64PpI36nSQW+CenJXOg7goT2G4A/2W2jZN9iYLSMYim7r//vpu+kTxIdXQjhgXBu3FU89bEe4kaQTfiX/87JU6FRxSMmNxE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721147879; c=relaxed/simple;
	bh=1eAQm+0eHdRcliRJMlnZYWIN502qcG2eMpfTDewy/ks=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=l+kzl+rBrXojNniLBbtHa9//FvWd6GNY3/yXLvkTavoFvNi0zPbkWIVPxUmLRgvPsEDY4ApFUqbPJPHyYnchyg0KPXfiqFZVMU2uWAoIV0uAn3GwfGvdU4g/wMorSX0YhOmL+bVgwdffJle7aKyouYVy0nC8ZLFzJ0rG5QnS+u0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=natalenko.name; spf=pass smtp.mailfrom=natalenko.name; dkim=pass (1024-bit key) header.d=natalenko.name header.i=@natalenko.name header.b=khRQU3Ny; arc=none smtp.client-ip=199.247.17.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=natalenko.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=natalenko.name
Received: from spock.localnet (unknown [212.20.115.26])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by prime.voidband.net (Postfix) with ESMTPSA id 514DD62DD1A9;
	Tue, 16 Jul 2024 18:37:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=natalenko.name;
	s=dkim-20170712; t=1721147867;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gbHbW0Vj8SJ7TmfouW/0B1H8GEcznuy9AtDQQuKhDoE=;
	b=khRQU3Nyhakhw7mk6w6dF//Ii8GmLuD+1boCKnhrN/AsiRZp1mLlYLj/W0nQb317BngDch
	HJUYekXwW6rD3uvZ6AgEbQhklkc/1M4U1rOrE8D+njvMsJaTsPyNnXn+vIwbI/s5R7flnT
	bczzX73re+Yfr05BSgmA0WlOE8uy4As=
From: Oleksandr Natalenko <oleksandr@natalenko.name>
To: Stefan Lippers-Hollmann <s.l-h@gmx.de>,
 "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Eric Biggers <ebiggers@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 Lukasz Luba <lukasz.luba@arm.com>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 Zhang Rui <rui.zhang@intel.com>, Neil Armstrong <neil.armstrong@linaro.org>
Subject:
 Re: [PATCH v3] thermal: core: Call monitor_thermal_zone() if zone temperature
 is invalid
Date: Tue, 16 Jul 2024 18:37:30 +0200
Message-ID: <12474042.O9o76ZdvQC@natalenko.name>
In-Reply-To:
 <CAJZ5v0gZ5611KXqfjSZOdjRi7v8num3P-vO82c7LGuS1Ak1=FQ@mail.gmail.com>
References:
 <6064157.lOV4Wx5bFT@rjwysocki.net> <20240716152025.7f935fb0@mir>
 <CAJZ5v0gZ5611KXqfjSZOdjRi7v8num3P-vO82c7LGuS1Ak1=FQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart5797067.DvuYhMxLoT";
 micalg="pgp-sha256"; protocol="application/pgp-signature"

--nextPart5797067.DvuYhMxLoT
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"; protected-headers="v1"
From: Oleksandr Natalenko <oleksandr@natalenko.name>
Date: Tue, 16 Jul 2024 18:37:30 +0200
Message-ID: <12474042.O9o76ZdvQC@natalenko.name>
MIME-Version: 1.0

Hello.

On =C3=BAter=C3=BD 16. =C4=8Dervence 2024 16:04:16, SEL=C4=8C Rafael J. Wys=
ocki wrote:
> On Tue, Jul 16, 2024 at 3:20=E2=80=AFPM Stefan Lippers-Hollmann <s.l-h@gm=
x.de> wrote:
> >
> > Hi
> >
> > On 2024-07-16, Rafael J. Wysocki wrote:
> > > On Tue, Jul 16, 2024 at 1:36=E2=80=AFPM Rafael J. Wysocki <rafael@ker=
nel.org> wrote:
> > > > On Tue, Jul 16, 2024 at 1:15=E2=80=AFPM Stefan Lippers-Hollmann <s.=
l-h@gmx.de> wrote:
> > > > > On 2024-07-16, Stefan Lippers-Hollmann wrote:
> > > > > > On 2024-07-16, Rafael J. Wysocki wrote:
> > > > > > > On Tue, Jul 16, 2024 at 1:48=E2=80=AFAM Stefan Lippers-Hollma=
nn <s.l-h@gmx.de> wrote:
> > > > > > > > On 2024-07-15, Rafael J. Wysocki wrote:
> > > > > > > > > On Mon, Jul 15, 2024 at 2:54=E2=80=AFPM Stefan Lippers-Ho=
llmann <s.l-h@gmx.de> wrote:
> > > > > > > > > > On 2024-07-15, Rafael J. Wysocki wrote:
> > > > > > > > > > > On Mon, Jul 15, 2024 at 11:09=E2=80=AFAM Daniel Lezca=
no
> > > > > > > > > > > <daniel.lezcano@linaro.org> wrote:
> > > > > > > > > > > > On 15/07/2024 06:45, Eric Biggers wrote:
> > > > > > > > > > > > > On Thu, Jul 04, 2024 at 01:46:26PM +0200, Rafael =
J. Wysocki wrote:
> > > > > > > > > > > > >> From: Rafael J. Wysocki <rafael.j.wysocki@intel.=
com>
> > > > > > > > [...]
> > > > > > > > > > Silencing the warnings is already a big improvement - a=
nd that patch
> > > > > > > > > > works to this extent for me with an ax200, thanks.
> > > > > > > > >
> > > > > > > > > So attached is a patch that should avoid enabling the the=
rmal zone
> > > > > > > > > when it is not ready for use in the first place, so it sh=
ould address
> > > > > > > > > both the message and the useless polling.
> > > > > > > > >
> > > > > > > > > I would appreciate giving it a go (please note that it ha=
sn't received
> > > > > > > > > much testing so far, though).
> > > > > > > >
> > > > > > > > Sadly this patch doesn't seem to help:
> > > > > > >
> > > > > > > This is likely because it is missing checks for firmware imag=
e type.
> > > > > > > I've added them to the attached new version.  Please try it.
> > > > > > >
> > > > > > > I've also added two pr_info() messages to get a better idea o=
f what's
> > > > > > > going on, so please grep dmesg for "Thermal zone not ready" a=
nd
> > > > > > > "Enabling thermal zone".
> > > > > >
> > > > > > This is the output with the patch applied:
> > > > >
> > > > > The ax200 wlan interface is currently not up/ configured (system
> > > > > using its wired ethernet cards instead), the thermal_zone1 stops
> > > > > if I manually enable the interface (ip link set dev wlp4s0 up)
> > > > > after booting up:
> > > >
> > > > This explains it, thanks!
> > > >
> > > > The enabling of the thermal zone in iwl_mvm_load_ucode_wait_alive()=
 is
> > > > premature or it should get disabled in the other two places that cl=
ear
> > > > the IWL_MVM_STATUS_FIRMWARE_RUNNING bit.
> > > >
> > > > I'm not sure why the thermal zone depends on whether or not this bit
> > > > is set, though. Is it really a good idea to return errors from it if
> > > > the interface is not up?
> > [...]
> > > > > [   22.033468] thermal thermal_zone1: failed to read out thermal =
zone (-61)
> > > > > [   22.213120] thermal thermal_zone1: Enabling thermal zone
> > > > > [   22.283954] iwlwifi 0000:04:00.0: Registered PHC clock: iwlwif=
i-PTP, with index: 0
> > > >
> > > > Thanks for this data point!
> > > >
> > > > AFAICS the thermal zone in iwlwifi is always enabled, but only valid
> > > > if the interface is up.  It looks to me like the thermal core needs=
 a
> > > > special "don't poll me" error code to be returned in such cases.
> > >
> > > Attached is a thermal core patch with an iwlwifi piece along the lines
> > > above (tested lightly).  It adds a way for a driver to indicate that
> > > temperature cannot be provided at the moment, but that's OK and the
> > > core need not worry about that.
> > >
> > > Please give it a go.
> >
> > This seems to fail to build on top of v6.10, should I test Linus' HEAD
> > or some staging tree instead?
>=20
> No, it's missing one hunk, sorry about that.
>=20
> > [ I will be offline for the next few hours now, but will test it as soon
> >   as possible, probably in ~9-10 hours ]
>=20
> No worries and thanks for your persistence!
>=20
> >   CC      drivers/thermal/thermal_core.o
> > drivers/thermal/thermal_core.c: In function 'handle_thermal_trip':
> > drivers/thermal/thermal_core.c:383:37: error: 'THERMAL_TEMP_INIT' undec=
lared (first use in this function); did you mean 'THERMAL_TEMP_INVALID'?
> >   383 |             tz->last_temperature !=3D THERMAL_TEMP_INIT) {
> >       |                                     ^~~~~~~~~~~~~~~~~
> >       |                                     THERMAL_TEMP_INVALID
> > drivers/thermal/thermal_core.c:383:37: note: each undeclared identifier=
 is reported only once for each function it appears in
> > drivers/thermal/thermal_core.c: In function 'thermal_zone_device_init':
> > drivers/thermal/thermal_core.c:432:27: error: 'THERMAL_TEMP_INIT' undec=
lared (first use in this function); did you mean 'THERMAL_TEMP_INVALID'?
> >   432 |         tz->temperature =3D THERMAL_TEMP_INIT;
> >       |                           ^~~~~~~~~~~~~~~~~
> >       |                           THERMAL_TEMP_INVALID
> >
>=20
> Attached is a new version that builds for me on top of plain 6.10.
>=20

This builds and runs fine for me, no dmesg spamming any more. In `sensors` =
I get this:

```
iwlwifi_1-virtual-0
Adapter: Virtual device
temp1:       -274.0=C2=B0C
```

(very beneficial during the heat wave)

There are no "thermal" messages in dmesg whatsoever, any other info you'd l=
ike me to provide?

Also, feel free to add:

Tested-by: Oleksandr Natalenko <oleksandr@natalenko.name>

Thank you.

=2D-=20
Oleksandr Natalenko (post-factum)
--nextPart5797067.DvuYhMxLoT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEZUOOw5ESFLHZZtOKil/iNcg8M0sFAmaWocoACgkQil/iNcg8
M0tMNQ/+Me1Tmrsk8H3eLYu+vrI4V6c9GbYMK3QkG05KbRAplXh4dxIx787CH+gG
Gs9BmBGcrt3M7qwBFTZ0/4AlHMO+hxESxwY9A5b3AizXZB/lYRW7F2Xq7YlSkoHV
50mpAo8n3qkRAe4cWZt3xS/VeydfHPI1VZTxLhruy6QtyPxnEQHYwZNX5CXksWmk
LwXKr6tIxrZtGIXN7MKcQl6HGfCnBYkkj/dZGf756cz+RgHsHzDmXW9TgobqTISZ
NfAkRNyaBg3t0M0BuJHmV/Kt0QNFadaCaDQfwW2qp4/NzqgnbTBysK07+kuLK0LR
CqCG03Fd55wiTfm5E1jagC3nGutoJE3TltNFOQXuLppB4jQLrka/Lp94Mxtih6Wl
dXRGsl7ekE4iR5rbeby5h9dYdYqb7MjswQR5pzlrVJh63P3mXehY1tcZptGHqLgl
6S18eC/veSztY4k7p08y0ANzpw7DmTtp4nwCj7A32bClDjbVU8gDoq0VqNM/4bMk
GqNI0mhJoOU6SeeQAWojhpmwIL47nRbhV+y2zKEQzVwYJFz9gy0mcjDet6aXiQFt
OEfn0cI+gy1L/8xrTyCdtIqO7w6pUSK523/L9Z7gMFBnwfZlfXXrPIsZhoSFl5Jr
fC5/uKtkAxtwE7bDhzirUDFjJdr4wzwSQfxMMbijvpmm4Lnkm4g=
=CUGE
-----END PGP SIGNATURE-----

--nextPart5797067.DvuYhMxLoT--




