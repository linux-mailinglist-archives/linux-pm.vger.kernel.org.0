Return-Path: <linux-pm+bounces-11274-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F9459386AA
	for <lists+linux-pm@lfdr.de>; Mon, 22 Jul 2024 01:37:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CCBC7B20B7D
	for <lists+linux-pm@lfdr.de>; Sun, 21 Jul 2024 23:37:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83C261078F;
	Sun, 21 Jul 2024 23:37:31 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from spindle.queued.net (spindle.queued.net [45.33.49.30])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3A8F322E;
	Sun, 21 Jul 2024 23:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.33.49.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721605051; cv=none; b=txnIP89QQHH1GiTwZDG2KkqNf48h+B4o3Sauxr9Z+JW+ZsXXHuBzPQE6jTJ7vusWU0p/Ltg8pOOAcFgLoRWB7wzlUTI/xd9/+u6cDgvXkbWK//2/T2hKU/PN9iyI7A0R0rbOkOEy5ZxoKr6gXRUUPJ6dRInFo8gKvu3ELzlauSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721605051; c=relaxed/simple;
	bh=CMQ+mtQW+Jw4g9rHQuLzw/kLhPmQkkJdm/XnPLTIWR8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UtB8J3MaqgoeD+mqC3lBV0FzMk21wytoa+mYaEtH6Ou2zZW1kbvq++HUEJfjhBCP+aP9nr3U5Ml8Q11GHsHdBCbw85JBB8StGj+X422y2kbfBlB6PWSvZC5fmIZdxRQzutKMAsfbhl0vCDj1u6kAXSZMhDVrRr88R0k1TScuIaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=queued.net; spf=pass smtp.mailfrom=queued.net; arc=none smtp.client-ip=45.33.49.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=queued.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queued.net
Received: by spindle.queued.net (Postfix, from userid 1001)
	id 3FE2811595F; Sun, 21 Jul 2024 19:37:23 -0400 (EDT)
Received: from 5400 (unknown [172.56.164.186])
	by spindle.queued.net (Postfix) with ESMTPSA id 75C9611593D;
	Sun, 21 Jul 2024 19:37:21 -0400 (EDT)
Date: Sun, 21 Jul 2024 19:37:16 -0400
From: Andres Salomon <dilinger@queued.net>
To: Pali =?UTF-8?B?Um9ow6Fy?= <pali@kernel.org>
Cc: linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
 Matthew Garrett <mjg59@srcf.ucam.org>, Sebastian Reichel <sre@kernel.org>,
 Hans de Goede <hdegoede@redhat.com>, Ilpo =?UTF-8?B?SsOkcnZpbmVu?=
 <ilpo.jarvinen@linux.intel.com>, linux-pm@vger.kernel.org,
 Dell.Client.Kernel@dell.com, Mario Limonciello <mario.limonciello@amd.com>
Subject: Re: [PATCH] platform/x86:dell-laptop: Add knobs to change battery
 charge settings
Message-ID: <20240721193716.3156050f@5400>
In-Reply-To: <20240721090238.wrei5nu6y3awujws@pali>
References: <20240720012220.26d62a54@5400>
	<20240720084019.hrnd4wgt4muorydp@pali>
	<20240720052419.73b1415a@5400>
	<20240720095507.uyaotkofkyasdgbd@pali>
	<20240720220606.1934df43@5400>
	<20240721090238.wrei5nu6y3awujws@pali>
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

On Sun, 21 Jul 2024 11:02:38 +0200
Pali Roh=C3=A1r <pali@kernel.org> wrote:

> On Saturday 20 July 2024 22:06:06 Andres Salomon wrote:
> > On Sat, 20 Jul 2024 11:55:07 +0200
> > Pali Roh=C3=A1r <pali@kernel.org> wrote:
> >  =20
> > > On Saturday 20 July 2024 05:24:19 Andres Salomon wrote: =20
> > > > Thanks for the quick feedback! Responses below.
> > > >=20
> > > > On Sat, 20 Jul 2024 10:40:19 +0200
> > > > Pali Roh=C3=A1r <pali@kernel.org> wrote:
> > > >    =20

[...]

> > > > > > +
> > > > > > +static void __init dell_battery_init(struct device *dev)
> > > > > > +{
> > > > > > +	enum battery_charging_mode current_mode =3D DELL_BAT_MODE_NON=
E;
> > > > > > +
> > > > > > +	dell_battery_read_req(BAT_CUSTOM_MODE_TOKEN, (int *) &current=
_mode);
> > > > > > +	if (current_mode !=3D DELL_BAT_MODE_NONE) {     =20
> > > > >=20
> > > > > I quite do not understand how is this code suppose to work.
> > > > >=20
> > > > > Why is there mix of custom kernel enum battery_charging_mode and =
return
> > > > > value from Dell's API?   =20
> > > >=20
> > > > This is from the original patch from Dell; tbh, I'm not sure. It do=
es
> > > > work, though. That is, current_mode ends up holding the correct val=
ue
> > > > based on what was previously set, even if the charging mode is set =
from
> > > > the BIOS.
> > > >=20
> > > > I just scanned through the libsmbios code to see what it's doing, a=
nd
> > > > it appears to loop through every charging mode to check if its acti=
ve.
> > > > I'm not really sure that makes much more sense, so I'll try some mo=
re
> > > > tests.   =20
> > >=20
> > > Keyboard backlight code (kbd_get_first_active_token_bit) is doing also
> > > this type scan. If I remember correctly, for every keyboard backlight
> > > token we just know the boolean value - if the token is set or not.
> > >=20
> > > It would really nice to see what (raw) value is returned by the
> > > dell_battery_read_req(token) function for every battery token and for
> > > every initial state. =20
> >=20
> > I checked this. The BIOS sets the mode value in every related token
> > location. I'm still not really sure what libsmbios is doing, but the
> > kernel code seems to arbitrarily choose one of the token locations
> > to read from. This makes sense to me now.
> >=20
> > In the BIOS when I set the mode to "ExpressCharge",
> > this what I pulled for each token location:
> >=20
> > [    5.704651] dell-laptop dell-laptop: BAT_CUSTOM_MODE_TOKEN value: 2
> > [    5.707015] dell-laptop dell-laptop: BAT_PRI_AC_MODE_TOKEN value: 2
> > [    5.709114] dell-laptop dell-laptop: BAT_ADAPTIVE_MODE_TOKEN value: 2
> > [    5.711041] dell-laptop dell-laptop: BAT_STANDARD_MODE_TOKEN value: 2
> > [    5.713705] dell-laptop dell-laptop: BAT_EXPRESS_MODE_TOKEN value: 2
> >=20
> > Similar story when I set it to Custom (all were '5'), or Standard ('1').
> > When I set it from linux as well, it changed all location values. =20
>=20
> Interesting... Anyway, I still think that the API could be similar to
> what is used in keyboard backlight.
>=20
> Could you please dump all information about each token? They are in
> struct calling_interface_token returned by dell_smbios_find_token.
>=20
> I'm interesting in tokenID, location and value.
>=20
> Ideally to compare what is in token->value and then in buffer.output[1]
> (in case dell_send_request does not fail).


Alright, here's what I see:

[    5.904775] dell_laptop: dell_battery_read_req: token requested: 0x343, =
tokenID=3D0x343, location=3D0x343, value=3D5
[    5.908675] dell_laptop: dell_battery_read_req: buffer.output[1]=3D3
[    5.908680] dell_laptop: dell_battery_init: BAT_CUSTOM_MODE_TOKEN value:=
 3
[    5.908682] dell_laptop: dell_battery_read_req: token requested: 0x341, =
tokenID=3D0x341, location=3D0x341, value=3D3
[    5.910922] dell_laptop: dell_battery_read_req: buffer.output[1]=3D3
[    5.910926] dell_laptop: dell_battery_init: BAT_PRI_AC_MODE_TOKEN value:=
 3
[    5.910928] dell_laptop: dell_battery_read_req: token requested: 0x342, =
tokenID=3D0x342, location=3D0x342, value=3D4
[    5.913042] dell_laptop: dell_battery_read_req: buffer.output[1]=3D3
[    5.913046] dell_laptop: dell_battery_init: BAT_ADAPTIVE_MODE_TOKEN valu=
e: 3
[    5.913048] dell_laptop: dell_battery_read_req: token requested: 0x346, =
tokenID=3D0x346, location=3D0x346, value=3D1
[    5.914996] dell_laptop: dell_battery_read_req: buffer.output[1]=3D3
[    5.914999] dell_laptop: dell_battery_init: BAT_STANDARD_MODE_TOKEN valu=
e: 3
[    5.915000] dell_laptop: dell_battery_read_req: token requested: 0x347, =
tokenID=3D0x347, location=3D0x347, value=3D2
[    5.916723] dell_laptop: dell_battery_read_req: buffer.output[1]=3D3
[    5.916724] dell_laptop: dell_battery_init: BAT_EXPRESS_MODE_TOKEN value=
: 3
[    5.916725] dell_laptop: dell_battery_read_req: token requested: 0x349, =
tokenID=3D0x349, location=3D0x349, value=3D65535
[    5.918727] dell_laptop: dell_battery_read_req: buffer.output[1]=3D65
[    5.918731] dell_laptop: dell_battery_init: BAT_CUSTOM_CHARGE_START valu=
e: 65
[    5.918734] dell_laptop: dell_battery_read_req: token requested: 0x34a, =
tokenID=3D0x34a, location=3D0x34a, value=3D65535
[    5.920864] dell_laptop: dell_battery_read_req: buffer.output[1]=3D85
[    5.920867] dell_laptop: dell_battery_init: BAT_CUSTOM_CHARGE_END value:=
 85



>=20
> > >=20
> > > Because it is really suspicious if dell_battery_read_req() would retu=
rn
> > > value of the enum battery_charging_mode (as this is kernel enum).
> > >=20
> > >=20
> > > Also another important thing. In past it was possible to buy from Dell
> > > special batteries with long warranty (3+ years). I'm not sure if these
> > > batteries are still available for end-user customers. With this type =
of
> > > battery, it was not possible to change charging mode to ExpressCharge
> > > (bios option was fade-out). I do not have such battery anymore, but I
> > > would expect that the firmware disabled BAT_EXPRESS_MODE_TOKEN as mark
> > > it as unavailable.
> > >=20
> > > I think that we should scan list of available tokens, like it is done
> > > for keyboard backlight in kbd_init_tokens(). And export via sysfs only
> > > those battery modes for which there is available token. =20
> >=20
> > I agree, but I'm not seeing a way to do that right now given how the
> > BIOS sets the mode. Maybe libsmbios has some clues... =20
>=20
> Try to get those dumps and I will try to do something with it.
>=20
> >=20
> >=20
> >=20
> >=20
> > --=20
> > I'm available for contract & employment work, see:
> > https://spindle.queued.net/~dilinger/resume-tech.pdf =20



--=20
I'm available for contract & employment work, see:
https://spindle.queued.net/~dilinger/resume-tech.pdf

