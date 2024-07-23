Return-Path: <linux-pm+bounces-11319-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2E059398EA
	for <lists+linux-pm@lfdr.de>; Tue, 23 Jul 2024 06:36:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AED4A2825DB
	for <lists+linux-pm@lfdr.de>; Tue, 23 Jul 2024 04:36:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11BE613BAF1;
	Tue, 23 Jul 2024 04:36:28 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from spindle.queued.net (spindle.queued.net [45.33.49.30])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA892137748;
	Tue, 23 Jul 2024 04:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.33.49.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721709388; cv=none; b=aP1jvbM2qjpbXwM/p6VI+Zm0hZ8d4Ap0NZ/AxTlkcEWM4dEoXifMrJik3F0Y77wX/igDc7wdyOX1KfsRzmp3X1hJ36K258dRthRaMWQEXJrlHflH9OwdNNC8b6/sb61OsoPJ/DFIza5YXtKy5ylH+nnSFK3IWLv/22DwI5sh2iE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721709388; c=relaxed/simple;
	bh=EIMttMdOYaRuy+MsBjIIRcGpbufBUizrRmYLYev1yHk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZwUdECHH1/r3l6kcp8eGOTxITpSAViLMfDv8h419GSpBhG3W1orsYT4LTmuZVswkuk1Up8k4xQKpPD9QecJsaALVuaT/nJ9AF6LtXfuZhIfO7UUA2+/cxjzJ1BYh4Ov1xEpI7FRAcgZ6bWMmojVc6m74s/tjuDmrQIHpdrzl6Ps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=queued.net; spf=pass smtp.mailfrom=queued.net; arc=none smtp.client-ip=45.33.49.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=queued.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queued.net
Received: by spindle.queued.net (Postfix, from userid 1001)
	id 6CB3B10F687; Tue, 23 Jul 2024 00:36:19 -0400 (EDT)
Received: from 5400 (unknown [172.56.164.186])
	by spindle.queued.net (Postfix) with ESMTPSA id 1647E10F63A;
	Tue, 23 Jul 2024 00:36:14 -0400 (EDT)
Date: Tue, 23 Jul 2024 00:36:10 -0400
From: Andres Salomon <dilinger@queued.net>
To: Pali =?UTF-8?B?Um9ow6Fy?= <pali@kernel.org>
Cc: linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
 Matthew Garrett <mjg59@srcf.ucam.org>, Sebastian Reichel <sre@kernel.org>,
 Hans de Goede <hdegoede@redhat.com>, Ilpo =?UTF-8?B?SsOkcnZpbmVu?=
 <ilpo.jarvinen@linux.intel.com>, linux-pm@vger.kernel.org,
 Dell.Client.Kernel@dell.com, Mario Limonciello <mario.limonciello@amd.com>
Subject: Re: [PATCH] platform/x86:dell-laptop: Add knobs to change battery
 charge settings
Message-ID: <20240723003610.765d28e4@5400>
In-Reply-To: <20240722202504.jgz6tcc247mjxq4f@pali>
References: <20240720052419.73b1415a@5400>
	<20240720095507.uyaotkofkyasdgbd@pali>
	<20240720220606.1934df43@5400>
	<20240721090238.wrei5nu6y3awujws@pali>
	<20240721193716.3156050f@5400>
	<20240721234037.nxthfeqdjl3z74oc@pali>
	<20240721195851.76e2b220@5400>
	<20240722071845.w7v23ixu5wujrpol@pali>
	<20240722143432.35c356b1@5400>
	<20240722184132.l6nibqkpna2wkszo@pali>
	<20240722202504.jgz6tcc247mjxq4f@pali>
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

On Mon, 22 Jul 2024 22:25:04 +0200
Pali Roh=C3=A1r <pali@kernel.org> wrote:

> On Monday 22 July 2024 20:41:32 Pali Roh=C3=A1r wrote:
> > On Monday 22 July 2024 14:34:32 Andres Salomon wrote: =20
> > > On Mon, 22 Jul 2024 09:18:45 +0200
> > > Pali Roh=C3=A1r <pali@kernel.org> wrote:
> > >  =20
> > > > On Sunday 21 July 2024 19:58:51 Andres Salomon wrote: =20
> > > > > On Mon, 22 Jul 2024 01:40:37 +0200
> > > > > Pali Roh=C3=A1r <pali@kernel.org> wrote:
> > > > >    =20
> > > > > > On Sunday 21 July 2024 19:37:16 Andres Salomon wrote:   =20
> > > > > > > On Sun, 21 Jul 2024 11:02:38 +0200
> > > > > > > Pali Roh=C3=A1r <pali@kernel.org> wrote:
> > > > > > >      =20
> > > > > > > > On Saturday 20 July 2024 22:06:06 Andres Salomon wrote:    =
 =20
> > > > > > > > > On Sat, 20 Jul 2024 11:55:07 +0200
> > > > > > > > > Pali Roh=C3=A1r <pali@kernel.org> wrote:
> > > > > > > > >        =20
> > > > > > > > > > On Saturday 20 July 2024 05:24:19 Andres Salomon wrote:=
       =20
> > > > > > > > > > > Thanks for the quick feedback! Responses below.
> > > > > > > > > > >=20
> > > > > > > > > > > On Sat, 20 Jul 2024 10:40:19 +0200
> > > > > > > > > > > Pali Roh=C3=A1r <pali@kernel.org> wrote:
> > > > > > > > > > >          =20
> > > > > > >=20
> > > > > > > [...]
> > > > > > >      =20
> > > > > > > > > > > > > +
> > > > > > > > > > > > > +static void __init dell_battery_init(struct devi=
ce *dev)
> > > > > > > > > > > > > +{
> > > > > > > > > > > > > +	enum battery_charging_mode current_mode =3D DEL=
L_BAT_MODE_NONE;
> > > > > > > > > > > > > +
> > > > > > > > > > > > > +	dell_battery_read_req(BAT_CUSTOM_MODE_TOKEN, (i=
nt *) &current_mode);
> > > > > > > > > > > > > +	if (current_mode !=3D DELL_BAT_MODE_NONE) {    =
       =20
> > > > > > > > > > > >=20
> > > > > > > > > > > > I quite do not understand how is this code suppose =
to work.
> > > > > > > > > > > >=20
> > > > > > > > > > > > Why is there mix of custom kernel enum battery_char=
ging_mode and return
> > > > > > > > > > > > value from Dell's API?         =20
> > > > > > > > > > >=20
> > > > > > > > > > > This is from the original patch from Dell; tbh, I'm n=
ot sure. It does
> > > > > > > > > > > work, though. That is, current_mode ends up holding t=
he correct value
> > > > > > > > > > > based on what was previously set, even if the chargin=
g mode is set from
> > > > > > > > > > > the BIOS.
> > > > > > > > > > >=20
> > > > > > > > > > > I just scanned through the libsmbios code to see what=
 it's doing, and
> > > > > > > > > > > it appears to loop through every charging mode to che=
ck if its active.
> > > > > > > > > > > I'm not really sure that makes much more sense, so I'=
ll try some more
> > > > > > > > > > > tests.         =20
> > > > > > > > > >=20
> > > > > > > > > > Keyboard backlight code (kbd_get_first_active_token_bit=
) is doing also
> > > > > > > > > > this type scan. If I remember correctly, for every keyb=
oard backlight
> > > > > > > > > > token we just know the boolean value - if the token is =
set or not.
> > > > > > > > > >=20
> > > > > > > > > > It would really nice to see what (raw) value is returne=
d by the
> > > > > > > > > > dell_battery_read_req(token) function for every battery=
 token and for
> > > > > > > > > > every initial state.       =20
> > > > > > > > >=20
> > > > > > > > > I checked this. The BIOS sets the mode value in every rel=
ated token
> > > > > > > > > location. I'm still not really sure what libsmbios is doi=
ng, but the
> > > > > > > > > kernel code seems to arbitrarily choose one of the token =
locations
> > > > > > > > > to read from. This makes sense to me now.
> > > > > > > > >=20
> > > > > > > > > In the BIOS when I set the mode to "ExpressCharge",
> > > > > > > > > this what I pulled for each token location:
> > > > > > > > >=20
> > > > > > > > > [    5.704651] dell-laptop dell-laptop: BAT_CUSTOM_MODE_T=
OKEN value: 2
> > > > > > > > > [    5.707015] dell-laptop dell-laptop: BAT_PRI_AC_MODE_T=
OKEN value: 2
> > > > > > > > > [    5.709114] dell-laptop dell-laptop: BAT_ADAPTIVE_MODE=
_TOKEN value: 2
> > > > > > > > > [    5.711041] dell-laptop dell-laptop: BAT_STANDARD_MODE=
_TOKEN value: 2
> > > > > > > > > [    5.713705] dell-laptop dell-laptop: BAT_EXPRESS_MODE_=
TOKEN value: 2
> > > > > > > > >=20
> > > > > > > > > Similar story when I set it to Custom (all were '5'), or =
Standard ('1').
> > > > > > > > > When I set it from linux as well, it changed all location=
 values.       =20
> > > > > > > >=20
> > > > > > > > Interesting... Anyway, I still think that the API could be =
similar to
> > > > > > > > what is used in keyboard backlight.
> > > > > > > >=20
> > > > > > > > Could you please dump all information about each token? The=
y are in
> > > > > > > > struct calling_interface_token returned by dell_smbios_find=
_token.
> > > > > > > >=20
> > > > > > > > I'm interesting in tokenID, location and value.
> > > > > > > >=20
> > > > > > > > Ideally to compare what is in token->value and then in buff=
er.output[1]
> > > > > > > > (in case dell_send_request does not fail).     =20
> > > > > > >=20
> > > > > > >=20
> > > > > > > Alright, here's what I see:
> > > > > > >=20
> > > > > > > [    5.904775] dell_laptop: dell_battery_read_req: token requ=
ested: 0x343, tokenID=3D0x343, location=3D0x343, value=3D5
> > > > > > > [    5.908675] dell_laptop: dell_battery_read_req: buffer.out=
put[1]=3D3
> > > > > > > [    5.908680] dell_laptop: dell_battery_init: BAT_CUSTOM_MOD=
E_TOKEN value: 3
> > > > > > > [    5.908682] dell_laptop: dell_battery_read_req: token requ=
ested: 0x341, tokenID=3D0x341, location=3D0x341, value=3D3
> > > > > > > [    5.910922] dell_laptop: dell_battery_read_req: buffer.out=
put[1]=3D3
> > > > > > > [    5.910926] dell_laptop: dell_battery_init: BAT_PRI_AC_MOD=
E_TOKEN value: 3
> > > > > > > [    5.910928] dell_laptop: dell_battery_read_req: token requ=
ested: 0x342, tokenID=3D0x342, location=3D0x342, value=3D4
> > > > > > > [    5.913042] dell_laptop: dell_battery_read_req: buffer.out=
put[1]=3D3
> > > > > > > [    5.913046] dell_laptop: dell_battery_init: BAT_ADAPTIVE_M=
ODE_TOKEN value: 3
> > > > > > > [    5.913048] dell_laptop: dell_battery_read_req: token requ=
ested: 0x346, tokenID=3D0x346, location=3D0x346, value=3D1
> > > > > > > [    5.914996] dell_laptop: dell_battery_read_req: buffer.out=
put[1]=3D3
> > > > > > > [    5.914999] dell_laptop: dell_battery_init: BAT_STANDARD_M=
ODE_TOKEN value: 3
> > > > > > > [    5.915000] dell_laptop: dell_battery_read_req: token requ=
ested: 0x347, tokenID=3D0x347, location=3D0x347, value=3D2
> > > > > > > [    5.916723] dell_laptop: dell_battery_read_req: buffer.out=
put[1]=3D3
> > > > > > > [    5.916724] dell_laptop: dell_battery_init: BAT_EXPRESS_MO=
DE_TOKEN value: 3
> > > > > > > [    5.916725] dell_laptop: dell_battery_read_req: token requ=
ested: 0x349, tokenID=3D0x349, location=3D0x349, value=3D65535
> > > > > > > [    5.918727] dell_laptop: dell_battery_read_req: buffer.out=
put[1]=3D65
> > > > > > > [    5.918731] dell_laptop: dell_battery_init: BAT_CUSTOM_CHA=
RGE_START value: 65
> > > > > > > [    5.918734] dell_laptop: dell_battery_read_req: token requ=
ested: 0x34a, tokenID=3D0x34a, location=3D0x34a, value=3D65535
> > > > > > > [    5.920864] dell_laptop: dell_battery_read_req: buffer.out=
put[1]=3D85
> > > > > > > [    5.920867] dell_laptop: dell_battery_init: BAT_CUSTOM_CHA=
RGE_END value: 85     =20
> > > > > >=20
> > > > > > Perfect. And can you check dumps when the mode is set to some o=
ther than BAT_PRI_AC_MODE_TOKEN?   =20
> > > > >=20
> > > > > Here's Express:
> > > > >=20
> > > > > [    5.880090] dell_laptop: dell_battery_read_req: token requeste=
d: 0x343, tokenID=3D0x343, location=3D0x343, value=3D5
> > > > > [    5.882011] dell_laptop: dell_battery_read_req: buffer.output[=
1]=3D2
> > > > > [    5.882014] dell_laptop: dell_battery_init: BAT_CUSTOM_MODE_TO=
KEN value: 2
> > > > > [    5.882016] dell_laptop: dell_battery_read_req: token requeste=
d: 0x341, tokenID=3D0x341, location=3D0x341, value=3D3
> > > > > [    5.894513] dell_laptop: dell_battery_read_req: buffer.output[=
1]=3D2
> > > > > [    5.894518] dell_laptop: dell_battery_init: BAT_PRI_AC_MODE_TO=
KEN value: 2
> > > > > [    5.894520] dell_laptop: dell_battery_read_req: token requeste=
d: 0x342, tokenID=3D0x342, location=3D0x342, value=3D4
> > > > > [    5.913870] dell_laptop: dell_battery_read_req: buffer.output[=
1]=3D2
> > > > > [    5.913874] dell_laptop: dell_battery_init: BAT_ADAPTIVE_MODE_=
TOKEN value: 2
> > > > > [    5.913875] dell_laptop: dell_battery_read_req: token requeste=
d: 0x346, tokenID=3D0x346, location=3D0x346, value=3D1
> > > > > [    5.915622] dell_laptop: dell_battery_read_req: buffer.output[=
1]=3D2
> > > > > [    5.915625] dell_laptop: dell_battery_init: BAT_STANDARD_MODE_=
TOKEN value: 2
> > > > > [    5.915626] dell_laptop: dell_battery_read_req: token requeste=
d: 0x347, tokenID=3D0x347, location=3D0x347, value=3D2
> > > > > [    5.917349] dell_laptop: dell_battery_read_req: buffer.output[=
1]=3D2
> > > > > [    5.917351] dell_laptop: dell_battery_init: BAT_EXPRESS_MODE_T=
OKEN value: 2
> > > > > [    5.917352] dell_laptop: dell_battery_read_req: token requeste=
d: 0x349, tokenID=3D0x349, location=3D0x349, value=3D65535
> > > > > [    5.919068] dell_laptop: dell_battery_read_req: buffer.output[=
1]=3D65
> > > > > [    5.919070] dell_laptop: dell_battery_init: BAT_CUSTOM_CHARGE_=
START value: 65
> > > > > [    5.919071] dell_laptop: dell_battery_read_req: token requeste=
d: 0x34a, tokenID=3D0x34a, location=3D0x34a, value=3D65535
> > > > > [    5.920780] dell_laptop: dell_battery_read_req: buffer.output[=
1]=3D85
> > > > > [    5.920782] dell_laptop: dell_battery_init: BAT_CUSTOM_CHARGE_=
END value: 85
> > > > >=20
> > > > > And here's Adaptive:
> > > > >=20
> > > > > [    5.945319] dell_laptop: dell_battery_read_req: token requeste=
d: 0x343, tokenID=3D0x343, location=3D0x343, value=3D5
> > > > > [    5.973685] dell_laptop: dell_battery_read_req: buffer.output[=
1]=3D4
> > > > > [    5.973690] dell_laptop: dell_battery_init: BAT_CUSTOM_MODE_TO=
KEN value: 4
> > > > > [    5.973692] dell_laptop: dell_battery_read_req: token requeste=
d: 0x341, tokenID=3D0x341, location=3D0x341, value=3D3
> > > > > [    5.976533] dell_laptop: dell_battery_read_req: buffer.output[=
1]=3D4
> > > > > [    5.976538] dell_laptop: dell_battery_init: BAT_PRI_AC_MODE_TO=
KEN value: 4
> > > > > [    5.976540] dell_laptop: dell_battery_read_req: token requeste=
d: 0x342, tokenID=3D0x342, location=3D0x342, value=3D4
> > > > > [    5.981013] dell_laptop: dell_battery_read_req: buffer.output[=
1]=3D4
> > > > > [    5.981018] dell_laptop: dell_battery_init: BAT_ADAPTIVE_MODE_=
TOKEN value: 4
> > > > > [    5.981020] dell_laptop: dell_battery_read_req: token requeste=
d: 0x346, tokenID=3D0x346, location=3D0x346, value=3D1
> > > > > [    5.983474] dell_laptop: dell_battery_read_req: buffer.output[=
1]=3D4
> > > > > [    5.983479] dell_laptop: dell_battery_init: BAT_STANDARD_MODE_=
TOKEN value: 4
> > > > > [    5.983481] dell_laptop: dell_battery_read_req: token requeste=
d: 0x347, tokenID=3D0x347, location=3D0x347, value=3D2
> > > > > [    5.985881] dell_laptop: dell_battery_read_req: buffer.output[=
1]=3D4
> > > > > [    5.985885] dell_laptop: dell_battery_init: BAT_EXPRESS_MODE_T=
OKEN value: 4
> > > > > [    5.985887] dell_laptop: dell_battery_read_req: token requeste=
d: 0x349, tokenID=3D0x349, location=3D0x349, value=3D65535
> > > > > [    5.988332] dell_laptop: dell_battery_read_req: buffer.output[=
1]=3D65
> > > > > [    5.988337] dell_laptop: dell_battery_init: BAT_CUSTOM_CHARGE_=
START value: 65
> > > > > [    5.988339] dell_laptop: dell_battery_read_req: token requeste=
d: 0x34a, tokenID=3D0x34a, location=3D0x34a, value=3D65535
> > > > > [    5.990769] dell_laptop: dell_battery_read_req: buffer.output[=
1]=3D85
> > > > > [    5.990774] dell_laptop: dell_battery_init: BAT_CUSTOM_CHARGE_=
END value: 85
> > > > >=20
> > > > >=20
> > > > >=20
> > > > > --=20
> > > > > I'm available for contract & employment work, see:
> > > > > https://spindle.queued.net/~dilinger/resume-tech.pdf   =20
> > > >=20
> > > > Nice! So it is exactly same as API of keyboard backlight tokens. Th=
anks.
> > > >=20
> > > > In dell_battery_write_req function you can drop second "val" argume=
nt
> > > > and replace it by token->value. So the dell_fill_request call in th=
at
> > > > function would look like:
> > > >=20
> > > >     dell_fill_request(&buffer, token->location, token->value, 0, 0)=
; =20
> > >=20
> > >=20
> > > Well, except that we use dell_battery_write_req for writing the charge
> > > start/end values as well (in dell_battery_custom_set). Those can't be
> > > obtained from token->value.
> > >=20
> > > We could have two separate functions for that, or set 'val' to a
> > > sentinel value (0) that, if detected, we set val=3Dtoken->value. I'm
> > > still not really understanding the point, though. =20
> >=20
> > I think that two separate functions would be needed. One which set
> > battery mode (enum) and which set custom thresholds.
> >  =20
> > > >=20
> > > > And then you can mimic the usage as it is done in keyboard backlight
> > > > functions (kbd_get_first_active_token_bit).
> > > >=20
> > > > If you do not know what I mean then later (today or tomorrow) I can
> > > > write code example of the functionality. =20
> > >=20
> > > Sorry, I still don't understand what the goal is here. Is the goal to
> > > not pull from a random location to determine the current charging mod=
e?
> > > Is the goal to determine what charging modes are currently supported
> > > (and if so, I don't see how)? Is the goal to avoid having the kernel
> > > hardcode a list of enums that the BIOS might have different values
> > > for? Is the goal to merge the keyboard backlight and battery setting
> > > functions? =20
> >=20
> > Avoid having the kernel hardcoded values for enums which SMBIOS
> > provides. Future (or maybe also older) modes may have different enum
> > values. So we should use what SMBIOS provides to us.
> >=20
> > Also to determinate which charging modes are supported by the current HW
> > configuration. If BIOS does not support some mode or does not allow to
> > set some mode, kernel should not export this as supported option.
> >=20
> > If you do not see how to do it, please give me some time, I will send
> > you an example. Going to look at it right now.
> >=20
> > Merging keyboard backlight and battery code is bonus, not required.
> > But I thought that it would be easier to build a new code from common
> > blocks. =20
>=20
> Here is very quick & hacky example of what I mean (completely untested):
>=20
> --- dell-laptop.c
> +++ dell-laptop.c
> @@ -353,6 +353,105 @@ static const struct dmi_system_id dell_q
>  	{ }
>  };
> =20
> +static int dell_read_token_value(u16 tokenid, u32 *value)
> +{
> +	struct calling_interface_buffer buffer;
> +	struct calling_interface_token *token;
> +	int ret;
> +
> +	token =3D dell_smbios_find_token(tokenid);
> +	if (!token)
> +		return -ENODEV;
> +
> +	dell_fill_request(&buffer, token->location, 0, 0, 0);
> +	ret =3D dell_send_request(&buffer, CLASS_TOKEN_READ, SELECT_TOKEN_STD);
> +	if (ret)
> +		return ret;
> +
> +	*value =3D buffer.output[1];
> +	return 0;
> +}
> +
> +static int dell_write_token_value(u16 tokenid, u32 value)
> +{
> +	struct calling_interface_buffer buffer;
> +	struct calling_interface_token *token;
> +
> +	token =3D dell_smbios_find_token(type);
> +	if (!token)
> +		return -ENODEV;
> +
> +	dell_fill_request(&buffer, token->location, value, 0, 0);
> +	return dell_send_request(&buffer, CLASS_TOKEN_WRITE, SELECT_TOKEN_STD);
> +}
> +

I did things a bit differently here. I created a function
dell_send_request_by_token_loc() that is available to be reused by all
the code that sends packets to token->location. This is available for
kbd_{g,s}et_token_bit(), micmute_led_set(), and mute_led_set() to use,
but I'd rather do that in a separate patch.

+static int dell_send_request_by_token_loc(struct calling_interface_buffer =
*buffer,
+                                         u16 class, u16 select, int type,
+                                         int val)
+{
+       struct calling_interface_token *token;
+
+       token =3D dell_smbios_find_token(type);
+       if (!token)
+               return -ENODEV;
+
+       if (val <=3D 0)
+               val =3D token->value;
+
+       dell_fill_request(buffer, token->location, val, 0, 0);
+       return dell_send_request(buffer, class, select);
+}
+
+static int dell_battery_set_mode(const int type)
+{
+       struct calling_interface_buffer buffer;
+
+       /* 0 means use the value from the token */
+       return dell_send_request_by_token_loc(&buffer, CLASS_TOKEN_WRITE,
+                       SELECT_TOKEN_STD, type, 0);
+}
+
+static int dell_battery_read(const int type)
+{
+       struct calling_interface_buffer buffer;
+       int err;
+
+       err =3D dell_send_request_by_token_loc(&buffer, CLASS_TOKEN_READ,
+                       SELECT_TOKEN_STD, type, 0);
+       if (err)
+               return err;
+
+       return buffer.output[1];
+}



> +static int dell_is_enum_token_active(u16 tokenid)
> +{
> +	struct calling_interface_buffer buffer;
> +	struct calling_interface_token *token;
> +	int ret;
> +
> +	token =3D dell_smbios_find_token(tokenid);
> +	if (!token)
> +		return -EINVAL;
> +
> +	if (token->value =3D=3D (u16)-1)
> +		return -EINVAL;
> +
> +	dell_fill_request(&buffer, token->location, 0, 0, 0);
> +	ret =3D dell_send_request(&buffer, CLASS_TOKEN_READ, SELECT_TOKEN_STD);
> +	if (ret)
> +		return ret;
> +
> +	return (buffer.output[1] =3D=3D token->value);
> +}
> +

Okay, I incorporated this, but using the above helper functions:

+static bool dell_battery_mode_is_active(const int type)
+{
+       struct calling_interface_token *token;
+
+       token =3D dell_smbios_find_token(type);
+       if (!token)
+               return false;
+
+       return token->value =3D=3D dell_battery_read(type);
+}

It will look up the token twice, but this only happens once on it
(and I'm realizing now that it can be marked __init).


> +static int dell_activate_enum_token(u16 tokenid)
> +{
> +	struct calling_interface_buffer buffer;
> +	struct calling_interface_token *token;
> +	int ret;
> +
> +	token =3D dell_smbios_find_token(tokenid);
> +	if (!token)
> +		return -EINVAL;
> +
> +	if (token->value =3D=3D (u16)-1)
> +		return -EINVAL;
> +
> +	dell_fill_request(&buffer, token->location, token->value, 0, 0);
> +	return dell_send_request(&buffer, CLASS_TOKEN_WRITE, SELECT_TOKEN_STD);
> +}
> +
> +static u32 dell_get_supported_enum_tokens(const u16 *tokenids, u32 count)
> +{
> +	u32 supported_mask =3D 0;
> +	u32 i;
> +
> +	for (i =3D 0; i < count; i++) {
> +		if (dell_smbios_find_token(tokenids[i]))
> +			supported_mask |=3D BIT(i);
> +	}
> +
> +	return supported_mask;
> +}
> +
> +static int dell_get_active_enum_token(const u16 *tokenids, u32 count, u3=
2 supported_mask)
> +{
> +	int ret;
> +	u32 i;
> +
> +	for (i =3D 0; i < count; i++) {
> +		if (!(supported_mask & BIT(i)))
> +			continue;
> +		ret =3D dell_is_enum_token_active(tokenids[i]);
> +		if (ret =3D=3D 1)
> +			return i;
> +	}
> +
> +	return -EINVAL;
> +}


Thanks, I incorporated and tested this code; though it only runs once
during init, because I'm keeping the battery_cur_mode variable (see
next section).

+static u32 __init battery_get_supported_modes(void)
+{
+       u32 modes =3D 0;
+       int i;
+
+       for (i =3D 0; i < ARRAY_SIZE(battery_modes); i++) {
+               if (dell_smbios_find_token(battery_modes[i].token))
+                       modes |=3D BIT(i);
+       }
+
+       return modes;
+}
+
+static int __init dell_battery_find_charging_mode(void)
+{
+       int i;
+
+       battery_supported_modes =3D battery_get_supported_modes();
+       for (i =3D 0; i < ARRAY_SIZE(battery_modes); i++) {
+               if (!(battery_supported_modes & BIT(i)))
+                       continue;
+               if (dell_battery_mode_is_active(battery_modes[i].token))
+                       return battery_modes[i].token;
+       }
+
+       return 0;
+}



> +
>  /*
>   * Derived from information in smbios-wireless-ctl:
>   *
> @@ -2183,6 +2282,144 @@ static struct led_classdev mute_led_cdev
>  	.default_trigger =3D "audio-mute",
>  };
> =20
> +static const u16 battery_mode_tokens[] =3D {
> +	BAT_STANDARD_MODE_TOKEN,
> +	BAT_EXPRESS_MODE_TOKEN,
> +	BAT_PRI_AC_MODE_TOKEN,
> +	BAT_ADAPTIVE_MODE_TOKEN,
> +	BAT_CUSTOM_MODE_TOKEN,
> +};
> +
> +static const char * const battery_mode_names[] =3D {
> +	"standard",
> +	"express",
> +	"primarily_ac",
> +	"adaptive",
> +	"custom",
> +};
> +
> +static u32 battery_mode_token_mask;
> +

I merged the token and name lists. Also, is there any particular reason
you dropped the current mode, preferring to read it from SMBIOS every time
in the _show() callback?

+static const struct {
+       int token;
+       const char *label;
+} battery_modes[] =3D {
+       { BAT_STANDARD_MODE_TOKEN, "standard" },
+       { BAT_EXPRESS_MODE_TOKEN, "express" },
+       { BAT_PRI_AC_MODE_TOKEN, "primarily_ac" },
+       { BAT_ADAPTIVE_MODE_TOKEN, "adaptive" },
+       { BAT_CUSTOM_MODE_TOKEN, "custom" },
+};
+static u32 battery_supported_modes;
+static int battery_cur_mode;
+



> +static int dell_battery_read_custom_charge(u16 token)
> +{
> +	u32 value;
> +	int ret;
> +
> +	ret =3D dell_read_token_value(token, &value);
> +	if (ret)
> +		return ret;
> +	if (value > 100)
> +		return -EINVAL;
> +	return value;
> +}
> +
> +#define CHARGE_START_MIN	50
> +#define CHARGE_START_MAX	95
> +#define CHARGE_END_MIN		55
> +#define CHARGE_END_MAX		100
> +#define CHARGE_MIN_DIFF		5
> +
> +static int dell_battery_set_custom_charge_start(int val)
> +{
> +	int end;
> +
> +	if (val < CHARGE_START_MIN)
> +		val =3D CHARGE_START_MIN;
> +	else if (val > CHARGE_START_MAX)
> +		val =3D CHARGE_START_MAX;
> +
> +	end =3D dell_battery_get_custom_charge(BAT_CUSTOM_CHARGE_END);
> +	if (end < 0)
> +		return end;
> +
> +	if (end - val < CHARGE_MIN_DIFF)
> +		val =3D end - CHARGE_MIN_DIFF;
> +
> +	return dell_write_token_value(BAT_CUSTOM_CHARGE_START, val);
> +}
> +
> +static int dell_battery_set_custom_charge_end(int val)
> +{
> +	int start;
> +
> +	if (val < CHARGE_END_MIN)
> +		val =3D CHARGE_END_MIN;
> +	else if (val > CHARGE_END_MAX)
> +		val =3D CHARGE_END_MAX;
> +
> +	start =3D dell_battery_get_custom_charge(BAT_CUSTOM_CHARGE_START);
> +	if (start < 0)
> +		return start;
> +
> +	if (val - start < CHARGE_MIN_DIFF)
> +		val =3D start + CHARGE_MIN_DIFF;
> +
> +	return dell_write_token_value(BAT_CUSTOM_CHARGE_END, val);
> +}
> +


Good call, I split apart the start/end functions. It was originally
much smaller and grew over time.  :)


> +static ssize_t charge_type_show(struct device *dev,
> +				struct device_attribute *attr,
> +				char *buf)
> +{
> +	int active;
> +	ssize_t count;
> +
> +	active =3D dell_get_active_enum_token(battery_mode_tokens, ARRAY_SIZE(b=
attery_mode_tokens), battery_mode_token_mask);
> +	if (active < 0)
> +		return ret;
> +
> +	for (count =3D 0, i =3D 0; i < ARRAY_SIZE(battery_mode_names); i++) {
> +		if (!(BIT(i) & battery_mode_token_mask))
> +			continue;
> +		count +=3D sysfs_emit_at(buf, count, i =3D=3D active ? "[%s] " : "%s "=
, battery_mode_names[mode]);
> +	}
> +
> +	/* convert the last space to a newline */
> +	/* battery_mode_names is non-empty and battery_mode_token_mask is non-z=
ero, so count is also non-zero */
> +	count--;
> +	count +=3D sysfs_emit_at(buf, count, "\n");
> +
> +	return count;
> +}
> +

Again, I personally prefer keeping the currently active charging mode
around as a variable:


+static ssize_t charge_type_show(struct device *dev,
+               struct device_attribute *attr,
+               char *buf)
+{
+       ssize_t count =3D 0;
+       int i;
+
+       for (i =3D 0; i < ARRAY_SIZE(battery_modes); i++) {
+               if (!(battery_supported_modes & BIT(i)))
+                       continue;
+
+               count +=3D sysfs_emit_at(buf, count,
+                               battery_modes[i].token =3D=3D battery_cur_m=
ode ? "[%s] " : "%s ",
+                               battery_modes[i].label);
+       }
+
+       /* convert the last space to a newline */
+       if (count > 0)
+               count--;
+       count +=3D sysfs_emit_at(buf, count, "\n");
+
+       return count;
+}


> +static ssize_t charge_type_store(struct device *dev,
> +				struct device_attribute *attr,
> +				const char *buf, size_t size)
> +{
> +	size_t i;
> +	int ret;
> +
> +	for (i =3D 0; i < ARRAY_SIZE(battery_mode_names); i++) {
> +		if (sysfs_streq(battery_mode_names[i], buf))
> +			break;
> +	}
> +
> +	if (i >=3D ARRAY_SIZE(battery_mode_names))
> +		return -EINVAL;
> +
> +	if (!(BIT(i) & battery_mode_token_mask))
> +		return -EINVAL;
> +
> +	ret =3D dell_activate_enum_token(battery_mode_tokens[i]);
> +	if (ret)
> +		return ret;
> +
> +	return size;
> +}
> +
> +static void __init dell_battery_init(struct device *dev)
> +{
> +	battery_mode_token_mask =3D dell_get_supported_enum_tokens(battery_mode=
_tokens, ARRAY_SIZE(battery_mode_tokens));
> +	if (battery_mode_token_mask !=3D 0)
> +		battery_hook_register(&dell_battery_hook);
> +}
> +
> +static void __exit dell_battery_exit(void)
> +{
> +	if (battery_mode_token_mask !=3D 0)
> +		battery_hook_unregister(&dell_battery_hook);
> +}
> +
>  static int __init dell_init(void)
>  {
>  	struct calling_interface_token *token;


Let me know your thoughts, and I can send a V2 patch if you're okay
with the code snippets I sent.

--=20
I'm available for contract & employment work, see:
https://spindle.queued.net/~dilinger/resume-tech.pdf

