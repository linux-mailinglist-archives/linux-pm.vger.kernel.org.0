Return-Path: <linux-pm+bounces-11308-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F17F1939478
	for <lists+linux-pm@lfdr.de>; Mon, 22 Jul 2024 21:52:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7BF751F21F27
	for <lists+linux-pm@lfdr.de>; Mon, 22 Jul 2024 19:52:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A062E171094;
	Mon, 22 Jul 2024 19:52:40 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from spindle.queued.net (spindle.queued.net [45.33.49.30])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1B2C170836;
	Mon, 22 Jul 2024 19:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.33.49.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721677960; cv=none; b=dsyQt+A/rS0y8k9pWnPYeSXGnETCEqcnv+nw7gm/zXwDtAHDB9AyApLMLYzHfB54bnjuD1hLOWVmusJmw3uWafbpFQMOql9wby9ufQhdxZ+hwLHfFJOX2vJrNthBs9HWpR7ICQf4Jn894OKyk0wNTGj2waKX8DEuem9wgQwuxMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721677960; c=relaxed/simple;
	bh=XzY+irjDSwO7pO+39P01OVr25Dhi1/GkC5tLK/q7RYA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mf5IWbT3Fm7wVH59kmyds/lRPnD5cD4Dd8A3HQCHNAZsynRapdwt/djEvqhwbEZh4TSvqnMb78QDj3yw7h4TQe3lXs655H/PL1kyW0cQH40c5O5HRABjbPBrCz7Cb+0TD0UKxcIbc6kLfYljedpLJNgaePSNFuTcF64FWL+3b/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=queued.net; spf=pass smtp.mailfrom=queued.net; arc=none smtp.client-ip=45.33.49.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=queued.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queued.net
Received: by spindle.queued.net (Postfix, from userid 1001)
	id 14611115986; Mon, 22 Jul 2024 15:52:38 -0400 (EDT)
Received: from 5400 (unknown [172.56.164.186])
	by spindle.queued.net (Postfix) with ESMTPSA id BDCF8112CCD;
	Mon, 22 Jul 2024 15:52:36 -0400 (EDT)
Date: Mon, 22 Jul 2024 15:52:32 -0400
From: Andres Salomon <dilinger@queued.net>
To: Pali =?UTF-8?B?Um9ow6Fy?= <pali@kernel.org>
Cc: linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
 Matthew Garrett <mjg59@srcf.ucam.org>, Sebastian Reichel <sre@kernel.org>,
 Hans de Goede <hdegoede@redhat.com>, Ilpo =?UTF-8?B?SsOkcnZpbmVu?=
 <ilpo.jarvinen@linux.intel.com>, linux-pm@vger.kernel.org,
 Dell.Client.Kernel@dell.com, Mario Limonciello <mario.limonciello@amd.com>
Subject: Re: [PATCH] platform/x86:dell-laptop: Add knobs to change battery
 charge settings
Message-ID: <20240722155232.4dea956b@5400>
In-Reply-To: <20240722184132.l6nibqkpna2wkszo@pali>
References: <20240720084019.hrnd4wgt4muorydp@pali>
	<20240720052419.73b1415a@5400>
	<20240720095507.uyaotkofkyasdgbd@pali>
	<20240720220606.1934df43@5400>
	<20240721090238.wrei5nu6y3awujws@pali>
	<20240721193716.3156050f@5400>
	<20240721234037.nxthfeqdjl3z74oc@pali>
	<20240721195851.76e2b220@5400>
	<20240722071845.w7v23ixu5wujrpol@pali>
	<20240722143432.35c356b1@5400>
	<20240722184132.l6nibqkpna2wkszo@pali>
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

On Mon, 22 Jul 2024 20:41:32 +0200
Pali Roh=C3=A1r <pali@kernel.org> wrote:

> On Monday 22 July 2024 14:34:32 Andres Salomon wrote:
> > On Mon, 22 Jul 2024 09:18:45 +0200
> > Pali Roh=C3=A1r <pali@kernel.org> wrote:
> >  =20
> > > On Sunday 21 July 2024 19:58:51 Andres Salomon wrote: =20
> > > > On Mon, 22 Jul 2024 01:40:37 +0200
> > > > Pali Roh=C3=A1r <pali@kernel.org> wrote:
> > > >    =20
> > > > > On Sunday 21 July 2024 19:37:16 Andres Salomon wrote:   =20
> > > > > > On Sun, 21 Jul 2024 11:02:38 +0200
> > > > > > Pali Roh=C3=A1r <pali@kernel.org> wrote:
> > > > > >      =20
> > > > > > > On Saturday 20 July 2024 22:06:06 Andres Salomon wrote:     =
=20
> > > > > > > > On Sat, 20 Jul 2024 11:55:07 +0200
> > > > > > > > Pali Roh=C3=A1r <pali@kernel.org> wrote:
> > > > > > > >        =20
> > > > > > > > > On Saturday 20 July 2024 05:24:19 Andres Salomon wrote:  =
     =20
> > > > > > > > > > Thanks for the quick feedback! Responses below.
> > > > > > > > > >=20
> > > > > > > > > > On Sat, 20 Jul 2024 10:40:19 +0200
> > > > > > > > > > Pali Roh=C3=A1r <pali@kernel.org> wrote:
> > > > > > > > > >          =20
> > > > > >=20
> > > > > > [...]
> > > > > >      =20
> > > > > > > > > > > > +
> > > > > > > > > > > > +static void __init dell_battery_init(struct device=
 *dev)
> > > > > > > > > > > > +{
> > > > > > > > > > > > +	enum battery_charging_mode current_mode =3D DELL_=
BAT_MODE_NONE;
> > > > > > > > > > > > +
> > > > > > > > > > > > +	dell_battery_read_req(BAT_CUSTOM_MODE_TOKEN, (int=
 *) &current_mode);
> > > > > > > > > > > > +	if (current_mode !=3D DELL_BAT_MODE_NONE) {      =
     =20
> > > > > > > > > > >=20
> > > > > > > > > > > I quite do not understand how is this code suppose to=
 work.
> > > > > > > > > > >=20
> > > > > > > > > > > Why is there mix of custom kernel enum battery_chargi=
ng_mode and return
> > > > > > > > > > > value from Dell's API?         =20
> > > > > > > > > >=20
> > > > > > > > > > This is from the original patch from Dell; tbh, I'm not=
 sure. It does
> > > > > > > > > > work, though. That is, current_mode ends up holding the=
 correct value
> > > > > > > > > > based on what was previously set, even if the charging =
mode is set from
> > > > > > > > > > the BIOS.
> > > > > > > > > >=20
> > > > > > > > > > I just scanned through the libsmbios code to see what i=
t's doing, and
> > > > > > > > > > it appears to loop through every charging mode to check=
 if its active.
> > > > > > > > > > I'm not really sure that makes much more sense, so I'll=
 try some more
> > > > > > > > > > tests.         =20
> > > > > > > > >=20
> > > > > > > > > Keyboard backlight code (kbd_get_first_active_token_bit) =
is doing also
> > > > > > > > > this type scan. If I remember correctly, for every keyboa=
rd backlight
> > > > > > > > > token we just know the boolean value - if the token is se=
t or not.
> > > > > > > > >=20
> > > > > > > > > It would really nice to see what (raw) value is returned =
by the
> > > > > > > > > dell_battery_read_req(token) function for every battery t=
oken and for
> > > > > > > > > every initial state.       =20
> > > > > > > >=20
> > > > > > > > I checked this. The BIOS sets the mode value in every relat=
ed token
> > > > > > > > location. I'm still not really sure what libsmbios is doing=
, but the
> > > > > > > > kernel code seems to arbitrarily choose one of the token lo=
cations
> > > > > > > > to read from. This makes sense to me now.
> > > > > > > >=20
> > > > > > > > In the BIOS when I set the mode to "ExpressCharge",
> > > > > > > > this what I pulled for each token location:
> > > > > > > >=20
> > > > > > > > [    5.704651] dell-laptop dell-laptop: BAT_CUSTOM_MODE_TOK=
EN value: 2
> > > > > > > > [    5.707015] dell-laptop dell-laptop: BAT_PRI_AC_MODE_TOK=
EN value: 2
> > > > > > > > [    5.709114] dell-laptop dell-laptop: BAT_ADAPTIVE_MODE_T=
OKEN value: 2
> > > > > > > > [    5.711041] dell-laptop dell-laptop: BAT_STANDARD_MODE_T=
OKEN value: 2
> > > > > > > > [    5.713705] dell-laptop dell-laptop: BAT_EXPRESS_MODE_TO=
KEN value: 2
> > > > > > > >=20
> > > > > > > > Similar story when I set it to Custom (all were '5'), or St=
andard ('1').
> > > > > > > > When I set it from linux as well, it changed all location v=
alues.       =20
> > > > > > >=20
> > > > > > > Interesting... Anyway, I still think that the API could be si=
milar to
> > > > > > > what is used in keyboard backlight.
> > > > > > >=20
> > > > > > > Could you please dump all information about each token? They =
are in
> > > > > > > struct calling_interface_token returned by dell_smbios_find_t=
oken.
> > > > > > >=20
> > > > > > > I'm interesting in tokenID, location and value.
> > > > > > >=20
> > > > > > > Ideally to compare what is in token->value and then in buffer=
.output[1]
> > > > > > > (in case dell_send_request does not fail).     =20
> > > > > >=20
> > > > > >=20
> > > > > > Alright, here's what I see:
> > > > > >=20
> > > > > > [    5.904775] dell_laptop: dell_battery_read_req: token reques=
ted: 0x343, tokenID=3D0x343, location=3D0x343, value=3D5
> > > > > > [    5.908675] dell_laptop: dell_battery_read_req: buffer.outpu=
t[1]=3D3
> > > > > > [    5.908680] dell_laptop: dell_battery_init: BAT_CUSTOM_MODE_=
TOKEN value: 3
> > > > > > [    5.908682] dell_laptop: dell_battery_read_req: token reques=
ted: 0x341, tokenID=3D0x341, location=3D0x341, value=3D3
> > > > > > [    5.910922] dell_laptop: dell_battery_read_req: buffer.outpu=
t[1]=3D3
> > > > > > [    5.910926] dell_laptop: dell_battery_init: BAT_PRI_AC_MODE_=
TOKEN value: 3
> > > > > > [    5.910928] dell_laptop: dell_battery_read_req: token reques=
ted: 0x342, tokenID=3D0x342, location=3D0x342, value=3D4
> > > > > > [    5.913042] dell_laptop: dell_battery_read_req: buffer.outpu=
t[1]=3D3
> > > > > > [    5.913046] dell_laptop: dell_battery_init: BAT_ADAPTIVE_MOD=
E_TOKEN value: 3
> > > > > > [    5.913048] dell_laptop: dell_battery_read_req: token reques=
ted: 0x346, tokenID=3D0x346, location=3D0x346, value=3D1
> > > > > > [    5.914996] dell_laptop: dell_battery_read_req: buffer.outpu=
t[1]=3D3
> > > > > > [    5.914999] dell_laptop: dell_battery_init: BAT_STANDARD_MOD=
E_TOKEN value: 3
> > > > > > [    5.915000] dell_laptop: dell_battery_read_req: token reques=
ted: 0x347, tokenID=3D0x347, location=3D0x347, value=3D2
> > > > > > [    5.916723] dell_laptop: dell_battery_read_req: buffer.outpu=
t[1]=3D3
> > > > > > [    5.916724] dell_laptop: dell_battery_init: BAT_EXPRESS_MODE=
_TOKEN value: 3
> > > > > > [    5.916725] dell_laptop: dell_battery_read_req: token reques=
ted: 0x349, tokenID=3D0x349, location=3D0x349, value=3D65535
> > > > > > [    5.918727] dell_laptop: dell_battery_read_req: buffer.outpu=
t[1]=3D65
> > > > > > [    5.918731] dell_laptop: dell_battery_init: BAT_CUSTOM_CHARG=
E_START value: 65
> > > > > > [    5.918734] dell_laptop: dell_battery_read_req: token reques=
ted: 0x34a, tokenID=3D0x34a, location=3D0x34a, value=3D65535
> > > > > > [    5.920864] dell_laptop: dell_battery_read_req: buffer.outpu=
t[1]=3D85
> > > > > > [    5.920867] dell_laptop: dell_battery_init: BAT_CUSTOM_CHARG=
E_END value: 85     =20
> > > > >=20
> > > > > Perfect. And can you check dumps when the mode is set to some oth=
er than BAT_PRI_AC_MODE_TOKEN?   =20
> > > >=20
> > > > Here's Express:
> > > >=20
> > > > [    5.880090] dell_laptop: dell_battery_read_req: token requested:=
 0x343, tokenID=3D0x343, location=3D0x343, value=3D5
> > > > [    5.882011] dell_laptop: dell_battery_read_req: buffer.output[1]=
=3D2
> > > > [    5.882014] dell_laptop: dell_battery_init: BAT_CUSTOM_MODE_TOKE=
N value: 2
> > > > [    5.882016] dell_laptop: dell_battery_read_req: token requested:=
 0x341, tokenID=3D0x341, location=3D0x341, value=3D3
> > > > [    5.894513] dell_laptop: dell_battery_read_req: buffer.output[1]=
=3D2
> > > > [    5.894518] dell_laptop: dell_battery_init: BAT_PRI_AC_MODE_TOKE=
N value: 2
> > > > [    5.894520] dell_laptop: dell_battery_read_req: token requested:=
 0x342, tokenID=3D0x342, location=3D0x342, value=3D4
> > > > [    5.913870] dell_laptop: dell_battery_read_req: buffer.output[1]=
=3D2
> > > > [    5.913874] dell_laptop: dell_battery_init: BAT_ADAPTIVE_MODE_TO=
KEN value: 2
> > > > [    5.913875] dell_laptop: dell_battery_read_req: token requested:=
 0x346, tokenID=3D0x346, location=3D0x346, value=3D1
> > > > [    5.915622] dell_laptop: dell_battery_read_req: buffer.output[1]=
=3D2
> > > > [    5.915625] dell_laptop: dell_battery_init: BAT_STANDARD_MODE_TO=
KEN value: 2
> > > > [    5.915626] dell_laptop: dell_battery_read_req: token requested:=
 0x347, tokenID=3D0x347, location=3D0x347, value=3D2
> > > > [    5.917349] dell_laptop: dell_battery_read_req: buffer.output[1]=
=3D2
> > > > [    5.917351] dell_laptop: dell_battery_init: BAT_EXPRESS_MODE_TOK=
EN value: 2
> > > > [    5.917352] dell_laptop: dell_battery_read_req: token requested:=
 0x349, tokenID=3D0x349, location=3D0x349, value=3D65535
> > > > [    5.919068] dell_laptop: dell_battery_read_req: buffer.output[1]=
=3D65
> > > > [    5.919070] dell_laptop: dell_battery_init: BAT_CUSTOM_CHARGE_ST=
ART value: 65
> > > > [    5.919071] dell_laptop: dell_battery_read_req: token requested:=
 0x34a, tokenID=3D0x34a, location=3D0x34a, value=3D65535
> > > > [    5.920780] dell_laptop: dell_battery_read_req: buffer.output[1]=
=3D85
> > > > [    5.920782] dell_laptop: dell_battery_init: BAT_CUSTOM_CHARGE_EN=
D value: 85
> > > >=20
> > > > And here's Adaptive:
> > > >=20
> > > > [    5.945319] dell_laptop: dell_battery_read_req: token requested:=
 0x343, tokenID=3D0x343, location=3D0x343, value=3D5
> > > > [    5.973685] dell_laptop: dell_battery_read_req: buffer.output[1]=
=3D4
> > > > [    5.973690] dell_laptop: dell_battery_init: BAT_CUSTOM_MODE_TOKE=
N value: 4
> > > > [    5.973692] dell_laptop: dell_battery_read_req: token requested:=
 0x341, tokenID=3D0x341, location=3D0x341, value=3D3
> > > > [    5.976533] dell_laptop: dell_battery_read_req: buffer.output[1]=
=3D4
> > > > [    5.976538] dell_laptop: dell_battery_init: BAT_PRI_AC_MODE_TOKE=
N value: 4
> > > > [    5.976540] dell_laptop: dell_battery_read_req: token requested:=
 0x342, tokenID=3D0x342, location=3D0x342, value=3D4
> > > > [    5.981013] dell_laptop: dell_battery_read_req: buffer.output[1]=
=3D4
> > > > [    5.981018] dell_laptop: dell_battery_init: BAT_ADAPTIVE_MODE_TO=
KEN value: 4
> > > > [    5.981020] dell_laptop: dell_battery_read_req: token requested:=
 0x346, tokenID=3D0x346, location=3D0x346, value=3D1
> > > > [    5.983474] dell_laptop: dell_battery_read_req: buffer.output[1]=
=3D4
> > > > [    5.983479] dell_laptop: dell_battery_init: BAT_STANDARD_MODE_TO=
KEN value: 4
> > > > [    5.983481] dell_laptop: dell_battery_read_req: token requested:=
 0x347, tokenID=3D0x347, location=3D0x347, value=3D2
> > > > [    5.985881] dell_laptop: dell_battery_read_req: buffer.output[1]=
=3D4
> > > > [    5.985885] dell_laptop: dell_battery_init: BAT_EXPRESS_MODE_TOK=
EN value: 4
> > > > [    5.985887] dell_laptop: dell_battery_read_req: token requested:=
 0x349, tokenID=3D0x349, location=3D0x349, value=3D65535
> > > > [    5.988332] dell_laptop: dell_battery_read_req: buffer.output[1]=
=3D65
> > > > [    5.988337] dell_laptop: dell_battery_init: BAT_CUSTOM_CHARGE_ST=
ART value: 65
> > > > [    5.988339] dell_laptop: dell_battery_read_req: token requested:=
 0x34a, tokenID=3D0x34a, location=3D0x34a, value=3D65535
> > > > [    5.990769] dell_laptop: dell_battery_read_req: buffer.output[1]=
=3D85
> > > > [    5.990774] dell_laptop: dell_battery_init: BAT_CUSTOM_CHARGE_EN=
D value: 85
> > > >=20
> > > >=20
> > > >=20
> > > > --=20
> > > > I'm available for contract & employment work, see:
> > > > https://spindle.queued.net/~dilinger/resume-tech.pdf   =20
> > >=20
> > > Nice! So it is exactly same as API of keyboard backlight tokens. Than=
ks.
> > >=20
> > > In dell_battery_write_req function you can drop second "val" argument
> > > and replace it by token->value. So the dell_fill_request call in that
> > > function would look like:
> > >=20
> > >     dell_fill_request(&buffer, token->location, token->value, 0, 0); =
=20
> >=20
> >=20
> > Well, except that we use dell_battery_write_req for writing the charge
> > start/end values as well (in dell_battery_custom_set). Those can't be
> > obtained from token->value.
> >=20
> > We could have two separate functions for that, or set 'val' to a
> > sentinel value (0) that, if detected, we set val=3Dtoken->value. I'm
> > still not really understanding the point, though. =20
>=20
> I think that two separate functions would be needed. One which set
> battery mode (enum) and which set custom thresholds.
>=20
> > >=20
> > > And then you can mimic the usage as it is done in keyboard backlight
> > > functions (kbd_get_first_active_token_bit).
> > >=20
> > > If you do not know what I mean then later (today or tomorrow) I can
> > > write code example of the functionality. =20
> >=20
> > Sorry, I still don't understand what the goal is here. Is the goal to
> > not pull from a random location to determine the current charging mode?
> > Is the goal to determine what charging modes are currently supported
> > (and if so, I don't see how)? Is the goal to avoid having the kernel
> > hardcode a list of enums that the BIOS might have different values
> > for? Is the goal to merge the keyboard backlight and battery setting
> > functions? =20
>=20
> Avoid having the kernel hardcoded values for enums which SMBIOS
> provides. Future (or maybe also older) modes may have different enum
> values. So we should use what SMBIOS provides to us.
>=20

*nod*, that makes sense.


> Also to determinate which charging modes are supported by the current HW
> configuration. If BIOS does not support some mode or does not allow to
> set some mode, kernel should not export this as supported option.


Alright, I'll see what I can do about this.

Unfortunately, with no real way to test it, it's very theoretical for me.
For what it's worth, I've checked on 6 separate laptops (all Latitudes,
ranging from an e7240 to a 5310), and they all have the exact same
(primary) battery charging options in the BIOS; nothing greyed out. That
includes a newer one that's missing a (non-removable) battery, and the
e7240 with removable battery. Even without batteries, the BIOS settings
didn't change. The only real change was the BIOS in the e7240, which had
a separate section for slice batteries. I don't doubt that the long life
batteries have a way to grey out the ExpressCharge option, but it's
unclear if querying ExpressCharge when a long life battery is installed
actually returns an error, or has an empty value in its SMBIOS token
value, or returns empty output (like kbd_get_token_bit checks for), or
what. And for the older removable batteries, the BIOS probably had
to be smart enough to handle the case where you have a normal battery
installed, set the BIOS to ExpressCharge, and then swap in a long life
battery. I would suspect the BIOS can handle it, but probably still keeps
the current value set to ExpressCharge and just quietly does a Standard
charge?

The only way to grey out any of the primary battery options is to select
"Enable Advanced Battery Charge Mode", which is a separate thing that
allows setting ExpressCharge during workdays and then automatically
disabling it at night. When that option is set and the primary battery
charge options are greyed out, the dump from the kernel driver looks the
same.

>=20
> If you do not see how to do it, please give me some time, I will send
> you an example. Going to look at it right now.
>=20
> Merging keyboard backlight and battery code is bonus, not required.
> But I thought that it would be easier to build a new code from common
> blocks.



--=20
I'm available for contract & employment work, see:
https://spindle.queued.net/~dilinger/resume-tech.pdf

