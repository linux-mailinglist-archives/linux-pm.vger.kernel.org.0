Return-Path: <linux-pm+bounces-11303-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0432793939B
	for <lists+linux-pm@lfdr.de>; Mon, 22 Jul 2024 20:34:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF538280FAE
	for <lists+linux-pm@lfdr.de>; Mon, 22 Jul 2024 18:34:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E92D516EBF9;
	Mon, 22 Jul 2024 18:34:41 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from spindle.queued.net (spindle.queued.net [45.33.49.30])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15B2A1CF83;
	Mon, 22 Jul 2024 18:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.33.49.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721673281; cv=none; b=XmIFmIbzXxvhF4UlMlEENzzo/gi0iwrnn0KzCiYF7iZfTpoFC3TG/z1LhUHjnxEVDWO0laGNGua4z8V3rGRDwbMXRgyzdHmHvy0l0iDALoxtroxaGMiZ4+uHOhU5RcH41PCPRf+mjtPFNYc/1h/09yJjRhv2zhGorSECUniBr28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721673281; c=relaxed/simple;
	bh=Da5ZdMzu3RBj1uNW563195I6iH5TXO9tZLuGAIFAfFE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oe6eOINngHUR4lj2eQADw/GV5t8V+Cs5OhRYFPaArqZHONx3KwOhdFqXcAzBen6qW7g8hOGN1SJnreWt8K6yYbBnqSXvkjk8m3/gqVeHRvQrLJPICiwAdlHgYCMswcPfeE64FK5XN1AF16q8sf9XB2Q8q21c8pVY6EozYqdScYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=queued.net; spf=pass smtp.mailfrom=queued.net; arc=none smtp.client-ip=45.33.49.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=queued.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queued.net
Received: by spindle.queued.net (Postfix, from userid 1001)
	id 7C17711597D; Mon, 22 Jul 2024 14:34:39 -0400 (EDT)
Received: from 5400 (unknown [172.56.164.186])
	by spindle.queued.net (Postfix) with ESMTPSA id 641D8115977;
	Mon, 22 Jul 2024 14:34:37 -0400 (EDT)
Date: Mon, 22 Jul 2024 14:34:32 -0400
From: Andres Salomon <dilinger@queued.net>
To: Pali =?UTF-8?B?Um9ow6Fy?= <pali@kernel.org>
Cc: linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
 Matthew Garrett <mjg59@srcf.ucam.org>, Sebastian Reichel <sre@kernel.org>,
 Hans de Goede <hdegoede@redhat.com>, Ilpo =?UTF-8?B?SsOkcnZpbmVu?=
 <ilpo.jarvinen@linux.intel.com>, linux-pm@vger.kernel.org,
 Dell.Client.Kernel@dell.com, Mario Limonciello <mario.limonciello@amd.com>
Subject: Re: [PATCH] platform/x86:dell-laptop: Add knobs to change battery
 charge settings
Message-ID: <20240722143432.35c356b1@5400>
In-Reply-To: <20240722071845.w7v23ixu5wujrpol@pali>
References: <20240720012220.26d62a54@5400>
	<20240720084019.hrnd4wgt4muorydp@pali>
	<20240720052419.73b1415a@5400>
	<20240720095507.uyaotkofkyasdgbd@pali>
	<20240720220606.1934df43@5400>
	<20240721090238.wrei5nu6y3awujws@pali>
	<20240721193716.3156050f@5400>
	<20240721234037.nxthfeqdjl3z74oc@pali>
	<20240721195851.76e2b220@5400>
	<20240722071845.w7v23ixu5wujrpol@pali>
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

On Mon, 22 Jul 2024 09:18:45 +0200
Pali Roh=C3=A1r <pali@kernel.org> wrote:

> On Sunday 21 July 2024 19:58:51 Andres Salomon wrote:
> > On Mon, 22 Jul 2024 01:40:37 +0200
> > Pali Roh=C3=A1r <pali@kernel.org> wrote:
> >  =20
> > > On Sunday 21 July 2024 19:37:16 Andres Salomon wrote: =20
> > > > On Sun, 21 Jul 2024 11:02:38 +0200
> > > > Pali Roh=C3=A1r <pali@kernel.org> wrote:
> > > >    =20
> > > > > On Saturday 20 July 2024 22:06:06 Andres Salomon wrote:   =20
> > > > > > On Sat, 20 Jul 2024 11:55:07 +0200
> > > > > > Pali Roh=C3=A1r <pali@kernel.org> wrote:
> > > > > >      =20
> > > > > > > On Saturday 20 July 2024 05:24:19 Andres Salomon wrote:     =
=20
> > > > > > > > Thanks for the quick feedback! Responses below.
> > > > > > > >=20
> > > > > > > > On Sat, 20 Jul 2024 10:40:19 +0200
> > > > > > > > Pali Roh=C3=A1r <pali@kernel.org> wrote:
> > > > > > > >        =20
> > > >=20
> > > > [...]
> > > >    =20
> > > > > > > > > > +
> > > > > > > > > > +static void __init dell_battery_init(struct device *de=
v)
> > > > > > > > > > +{
> > > > > > > > > > +	enum battery_charging_mode current_mode =3D DELL_BAT_=
MODE_NONE;
> > > > > > > > > > +
> > > > > > > > > > +	dell_battery_read_req(BAT_CUSTOM_MODE_TOKEN, (int *) =
&current_mode);
> > > > > > > > > > +	if (current_mode !=3D DELL_BAT_MODE_NONE) {         =
=20
> > > > > > > > >=20
> > > > > > > > > I quite do not understand how is this code suppose to wor=
k.
> > > > > > > > >=20
> > > > > > > > > Why is there mix of custom kernel enum battery_charging_m=
ode and return
> > > > > > > > > value from Dell's API?       =20
> > > > > > > >=20
> > > > > > > > This is from the original patch from Dell; tbh, I'm not sur=
e. It does
> > > > > > > > work, though. That is, current_mode ends up holding the cor=
rect value
> > > > > > > > based on what was previously set, even if the charging mode=
 is set from
> > > > > > > > the BIOS.
> > > > > > > >=20
> > > > > > > > I just scanned through the libsmbios code to see what it's =
doing, and
> > > > > > > > it appears to loop through every charging mode to check if =
its active.
> > > > > > > > I'm not really sure that makes much more sense, so I'll try=
 some more
> > > > > > > > tests.       =20
> > > > > > >=20
> > > > > > > Keyboard backlight code (kbd_get_first_active_token_bit) is d=
oing also
> > > > > > > this type scan. If I remember correctly, for every keyboard b=
acklight
> > > > > > > token we just know the boolean value - if the token is set or=
 not.
> > > > > > >=20
> > > > > > > It would really nice to see what (raw) value is returned by t=
he
> > > > > > > dell_battery_read_req(token) function for every battery token=
 and for
> > > > > > > every initial state.     =20
> > > > > >=20
> > > > > > I checked this. The BIOS sets the mode value in every related t=
oken
> > > > > > location. I'm still not really sure what libsmbios is doing, bu=
t the
> > > > > > kernel code seems to arbitrarily choose one of the token locati=
ons
> > > > > > to read from. This makes sense to me now.
> > > > > >=20
> > > > > > In the BIOS when I set the mode to "ExpressCharge",
> > > > > > this what I pulled for each token location:
> > > > > >=20
> > > > > > [    5.704651] dell-laptop dell-laptop: BAT_CUSTOM_MODE_TOKEN v=
alue: 2
> > > > > > [    5.707015] dell-laptop dell-laptop: BAT_PRI_AC_MODE_TOKEN v=
alue: 2
> > > > > > [    5.709114] dell-laptop dell-laptop: BAT_ADAPTIVE_MODE_TOKEN=
 value: 2
> > > > > > [    5.711041] dell-laptop dell-laptop: BAT_STANDARD_MODE_TOKEN=
 value: 2
> > > > > > [    5.713705] dell-laptop dell-laptop: BAT_EXPRESS_MODE_TOKEN =
value: 2
> > > > > >=20
> > > > > > Similar story when I set it to Custom (all were '5'), or Standa=
rd ('1').
> > > > > > When I set it from linux as well, it changed all location value=
s.     =20
> > > > >=20
> > > > > Interesting... Anyway, I still think that the API could be simila=
r to
> > > > > what is used in keyboard backlight.
> > > > >=20
> > > > > Could you please dump all information about each token? They are =
in
> > > > > struct calling_interface_token returned by dell_smbios_find_token.
> > > > >=20
> > > > > I'm interesting in tokenID, location and value.
> > > > >=20
> > > > > Ideally to compare what is in token->value and then in buffer.out=
put[1]
> > > > > (in case dell_send_request does not fail).   =20
> > > >=20
> > > >=20
> > > > Alright, here's what I see:
> > > >=20
> > > > [    5.904775] dell_laptop: dell_battery_read_req: token requested:=
 0x343, tokenID=3D0x343, location=3D0x343, value=3D5
> > > > [    5.908675] dell_laptop: dell_battery_read_req: buffer.output[1]=
=3D3
> > > > [    5.908680] dell_laptop: dell_battery_init: BAT_CUSTOM_MODE_TOKE=
N value: 3
> > > > [    5.908682] dell_laptop: dell_battery_read_req: token requested:=
 0x341, tokenID=3D0x341, location=3D0x341, value=3D3
> > > > [    5.910922] dell_laptop: dell_battery_read_req: buffer.output[1]=
=3D3
> > > > [    5.910926] dell_laptop: dell_battery_init: BAT_PRI_AC_MODE_TOKE=
N value: 3
> > > > [    5.910928] dell_laptop: dell_battery_read_req: token requested:=
 0x342, tokenID=3D0x342, location=3D0x342, value=3D4
> > > > [    5.913042] dell_laptop: dell_battery_read_req: buffer.output[1]=
=3D3
> > > > [    5.913046] dell_laptop: dell_battery_init: BAT_ADAPTIVE_MODE_TO=
KEN value: 3
> > > > [    5.913048] dell_laptop: dell_battery_read_req: token requested:=
 0x346, tokenID=3D0x346, location=3D0x346, value=3D1
> > > > [    5.914996] dell_laptop: dell_battery_read_req: buffer.output[1]=
=3D3
> > > > [    5.914999] dell_laptop: dell_battery_init: BAT_STANDARD_MODE_TO=
KEN value: 3
> > > > [    5.915000] dell_laptop: dell_battery_read_req: token requested:=
 0x347, tokenID=3D0x347, location=3D0x347, value=3D2
> > > > [    5.916723] dell_laptop: dell_battery_read_req: buffer.output[1]=
=3D3
> > > > [    5.916724] dell_laptop: dell_battery_init: BAT_EXPRESS_MODE_TOK=
EN value: 3
> > > > [    5.916725] dell_laptop: dell_battery_read_req: token requested:=
 0x349, tokenID=3D0x349, location=3D0x349, value=3D65535
> > > > [    5.918727] dell_laptop: dell_battery_read_req: buffer.output[1]=
=3D65
> > > > [    5.918731] dell_laptop: dell_battery_init: BAT_CUSTOM_CHARGE_ST=
ART value: 65
> > > > [    5.918734] dell_laptop: dell_battery_read_req: token requested:=
 0x34a, tokenID=3D0x34a, location=3D0x34a, value=3D65535
> > > > [    5.920864] dell_laptop: dell_battery_read_req: buffer.output[1]=
=3D85
> > > > [    5.920867] dell_laptop: dell_battery_init: BAT_CUSTOM_CHARGE_EN=
D value: 85   =20
> > >=20
> > > Perfect. And can you check dumps when the mode is set to some other t=
han BAT_PRI_AC_MODE_TOKEN? =20
> >=20
> > Here's Express:
> >=20
> > [    5.880090] dell_laptop: dell_battery_read_req: token requested: 0x3=
43, tokenID=3D0x343, location=3D0x343, value=3D5
> > [    5.882011] dell_laptop: dell_battery_read_req: buffer.output[1]=3D2
> > [    5.882014] dell_laptop: dell_battery_init: BAT_CUSTOM_MODE_TOKEN va=
lue: 2
> > [    5.882016] dell_laptop: dell_battery_read_req: token requested: 0x3=
41, tokenID=3D0x341, location=3D0x341, value=3D3
> > [    5.894513] dell_laptop: dell_battery_read_req: buffer.output[1]=3D2
> > [    5.894518] dell_laptop: dell_battery_init: BAT_PRI_AC_MODE_TOKEN va=
lue: 2
> > [    5.894520] dell_laptop: dell_battery_read_req: token requested: 0x3=
42, tokenID=3D0x342, location=3D0x342, value=3D4
> > [    5.913870] dell_laptop: dell_battery_read_req: buffer.output[1]=3D2
> > [    5.913874] dell_laptop: dell_battery_init: BAT_ADAPTIVE_MODE_TOKEN =
value: 2
> > [    5.913875] dell_laptop: dell_battery_read_req: token requested: 0x3=
46, tokenID=3D0x346, location=3D0x346, value=3D1
> > [    5.915622] dell_laptop: dell_battery_read_req: buffer.output[1]=3D2
> > [    5.915625] dell_laptop: dell_battery_init: BAT_STANDARD_MODE_TOKEN =
value: 2
> > [    5.915626] dell_laptop: dell_battery_read_req: token requested: 0x3=
47, tokenID=3D0x347, location=3D0x347, value=3D2
> > [    5.917349] dell_laptop: dell_battery_read_req: buffer.output[1]=3D2
> > [    5.917351] dell_laptop: dell_battery_init: BAT_EXPRESS_MODE_TOKEN v=
alue: 2
> > [    5.917352] dell_laptop: dell_battery_read_req: token requested: 0x3=
49, tokenID=3D0x349, location=3D0x349, value=3D65535
> > [    5.919068] dell_laptop: dell_battery_read_req: buffer.output[1]=3D65
> > [    5.919070] dell_laptop: dell_battery_init: BAT_CUSTOM_CHARGE_START =
value: 65
> > [    5.919071] dell_laptop: dell_battery_read_req: token requested: 0x3=
4a, tokenID=3D0x34a, location=3D0x34a, value=3D65535
> > [    5.920780] dell_laptop: dell_battery_read_req: buffer.output[1]=3D85
> > [    5.920782] dell_laptop: dell_battery_init: BAT_CUSTOM_CHARGE_END va=
lue: 85
> >=20
> > And here's Adaptive:
> >=20
> > [    5.945319] dell_laptop: dell_battery_read_req: token requested: 0x3=
43, tokenID=3D0x343, location=3D0x343, value=3D5
> > [    5.973685] dell_laptop: dell_battery_read_req: buffer.output[1]=3D4
> > [    5.973690] dell_laptop: dell_battery_init: BAT_CUSTOM_MODE_TOKEN va=
lue: 4
> > [    5.973692] dell_laptop: dell_battery_read_req: token requested: 0x3=
41, tokenID=3D0x341, location=3D0x341, value=3D3
> > [    5.976533] dell_laptop: dell_battery_read_req: buffer.output[1]=3D4
> > [    5.976538] dell_laptop: dell_battery_init: BAT_PRI_AC_MODE_TOKEN va=
lue: 4
> > [    5.976540] dell_laptop: dell_battery_read_req: token requested: 0x3=
42, tokenID=3D0x342, location=3D0x342, value=3D4
> > [    5.981013] dell_laptop: dell_battery_read_req: buffer.output[1]=3D4
> > [    5.981018] dell_laptop: dell_battery_init: BAT_ADAPTIVE_MODE_TOKEN =
value: 4
> > [    5.981020] dell_laptop: dell_battery_read_req: token requested: 0x3=
46, tokenID=3D0x346, location=3D0x346, value=3D1
> > [    5.983474] dell_laptop: dell_battery_read_req: buffer.output[1]=3D4
> > [    5.983479] dell_laptop: dell_battery_init: BAT_STANDARD_MODE_TOKEN =
value: 4
> > [    5.983481] dell_laptop: dell_battery_read_req: token requested: 0x3=
47, tokenID=3D0x347, location=3D0x347, value=3D2
> > [    5.985881] dell_laptop: dell_battery_read_req: buffer.output[1]=3D4
> > [    5.985885] dell_laptop: dell_battery_init: BAT_EXPRESS_MODE_TOKEN v=
alue: 4
> > [    5.985887] dell_laptop: dell_battery_read_req: token requested: 0x3=
49, tokenID=3D0x349, location=3D0x349, value=3D65535
> > [    5.988332] dell_laptop: dell_battery_read_req: buffer.output[1]=3D65
> > [    5.988337] dell_laptop: dell_battery_init: BAT_CUSTOM_CHARGE_START =
value: 65
> > [    5.988339] dell_laptop: dell_battery_read_req: token requested: 0x3=
4a, tokenID=3D0x34a, location=3D0x34a, value=3D65535
> > [    5.990769] dell_laptop: dell_battery_read_req: buffer.output[1]=3D85
> > [    5.990774] dell_laptop: dell_battery_init: BAT_CUSTOM_CHARGE_END va=
lue: 85
> >=20
> >=20
> >=20
> > --=20
> > I'm available for contract & employment work, see:
> > https://spindle.queued.net/~dilinger/resume-tech.pdf =20
>=20
> Nice! So it is exactly same as API of keyboard backlight tokens. Thanks.
>=20
> In dell_battery_write_req function you can drop second "val" argument
> and replace it by token->value. So the dell_fill_request call in that
> function would look like:
>=20
>     dell_fill_request(&buffer, token->location, token->value, 0, 0);


Well, except that we use dell_battery_write_req for writing the charge
start/end values as well (in dell_battery_custom_set). Those can't be
obtained from token->value.

We could have two separate functions for that, or set 'val' to a
sentinel value (0) that, if detected, we set val=3Dtoken->value. I'm
still not really understanding the point, though.

>=20
> And then you can mimic the usage as it is done in keyboard backlight
> functions (kbd_get_first_active_token_bit).
>=20
> If you do not know what I mean then later (today or tomorrow) I can
> write code example of the functionality.

Sorry, I still don't understand what the goal is here. Is the goal to
not pull from a random location to determine the current charging mode?
Is the goal to determine what charging modes are currently supported
(and if so, I don't see how)? Is the goal to avoid having the kernel
hardcode a list of enums that the BIOS might have different values
for? Is the goal to merge the keyboard backlight and battery setting
functions?


--=20
I'm available for contract & employment work, see:
https://spindle.queued.net/~dilinger/resume-tech.pdf

