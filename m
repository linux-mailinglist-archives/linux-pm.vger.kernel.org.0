Return-Path: <linux-pm+bounces-11410-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D8FB993C981
	for <lists+linux-pm@lfdr.de>; Thu, 25 Jul 2024 22:25:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5AB381F21975
	for <lists+linux-pm@lfdr.de>; Thu, 25 Jul 2024 20:25:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADA39770E9;
	Thu, 25 Jul 2024 20:25:06 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from spindle.queued.net (spindle.queued.net [45.33.49.30])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA9C23CF5E;
	Thu, 25 Jul 2024 20:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.33.49.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721939106; cv=none; b=NMuQYTEdo7F7z35E04eOp/SG0c5zo+PXgOCNfZqvhIesex9fsX+uuOe0xgwyZR9C1bZcHpPZmRpCW+D0jZzIPRHIQ6ak36PMo/IUD5pvlDty1Iz+RHWHLOddUjunbRYzrn852oKr2FY5Z4nTZkyMtr//PQgzkHMvwGBNPkyhTa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721939106; c=relaxed/simple;
	bh=CsMSOoY5CeaYFZIWIypZ0J4l0j0+d8TAueyx+piSDXQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CgdPlVxNVrfrUor3Wmv0BmlQT1BKQDnWZ4XYulRJ1v4mBBlUuHUY4gRKP90IF6HSHOWCySYOy8ZaTMZ5qEOW2olzfMfC16IlRBOu9c6mzguX9xfAhkzmVNB7OR6cGm9X2XXu+JcHX87ASPrXmjkS7OtCh6OAFQ1QDS0QAAOfzGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=queued.net; spf=pass smtp.mailfrom=queued.net; arc=none smtp.client-ip=45.33.49.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=queued.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queued.net
Received: by spindle.queued.net (Postfix, from userid 1001)
	id 4FC1D115A5B; Thu, 25 Jul 2024 16:25:04 -0400 (EDT)
Received: from 5400 (unknown [172.56.164.186])
	by spindle.queued.net (Postfix) with ESMTPSA id 77431115A4F;
	Thu, 25 Jul 2024 16:25:02 -0400 (EDT)
Date: Thu, 25 Jul 2024 16:24:57 -0400
From: Andres Salomon <dilinger@queued.net>
To: Pali =?UTF-8?B?Um9ow6Fy?= <pali@kernel.org>
Cc: linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
 Matthew Garrett <mjg59@srcf.ucam.org>, Sebastian Reichel <sre@kernel.org>,
 Hans de Goede <hdegoede@redhat.com>, Ilpo =?UTF-8?B?SsOkcnZpbmVu?=
 <ilpo.jarvinen@linux.intel.com>, linux-pm@vger.kernel.org,
 Dell.Client.Kernel@dell.com
Subject: Re: [PATCH v2 1/2] platform/x86:dell-laptop: Add knobs to change
 battery charge settings
Message-ID: <20240725162457.34b480e1@5400>
In-Reply-To: <20240724230158.nsmxdgagfpanjtzi@pali>
References: <20240723220502.77cb0401@5400>
	<20240724203403.zcrx2lshbla3o2gp@pali>
	<20240724204523.xb6rp7ba6yqi5klt@pali>
	<20240724182318.66578a48@5400>
	<20240724230158.nsmxdgagfpanjtzi@pali>
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

On Thu, 25 Jul 2024 01:01:58 +0200
Pali Roh=C3=A1r <pali@kernel.org> wrote:

> On Wednesday 24 July 2024 18:23:18 Andres Salomon wrote:
> > On Wed, 24 Jul 2024 22:45:23 +0200
> > Pali Roh=C3=A1r <pali@kernel.org> wrote:
> >  =20
> > > On Wednesday 24 July 2024 22:34:03 Pali Roh=C3=A1r wrote: =20
> > > > Hello, the driver change looks good. I have just few minor comments=
 for
> > > > this change below.
> > > >=20
> > > > Anyway, if there is somebody on the list with Dell laptop with 2 or=
 3
> > > > batteries, see below, it would be nice to check how such laptop wou=
ld
> > > > behave with this patch. It does not seem that patch should cause
> > > > regression but always it is better to do testing if it is possible.
> > > >=20
> > > > On Tuesday 23 July 2024 22:05:02 Andres Salomon wrote:   =20
> > [...] =20
> > > And because CLASS_TOKEN_WRITE is being repeated, what about defining
> > > something like this?
> > >=20
> > >     static inline int dell_set_token_value(struct calling_interface_b=
uffer *buffer, u16 class, u16 tokenid, u32 value)
> > >     {
> > >         dell_send_request_for_tokenid(buffer, class, CLASS_TOKEN_WRIT=
E, tokenid, value);
> > >     }
> > >=20
> > > Just an idea. Do you think that it could be useful in second patch?
> > >  =20
> >=20
> > Let me implement the other changes first and then take a look. =20
>=20
> Ok.
>=20

For the helper function, I noticed that all of the CLASS_TOKEN_WRITEs
also have SELECT_TOKEN_STD except for one (dell_send_intensity). So I
think it makes sense to have the helper function also do that as well.
Eg,

static inline int dell_set_std_token_value(struct calling_interface_buffer =
*buffer, u16 tokenid, u32 value)
{
	dell_send_request_for_tokenid(buffer, SELECT_TOKEN_STD, CLASS_TOKEN_WRITE,=
 tokenid, value);
}

I agree with your renaming to dell_send_request_for_tokenid, btw.


> > > > > +static int dell_battery_read(const int type)
> > > > > +{
> > > > > +	struct calling_interface_buffer buffer;
> > > > > +	int err;
> > > > > +
> > > > > +	err =3D dell_send_request_by_token_loc(&buffer, CLASS_TOKEN_REA=
D,
> > > > > +			SELECT_TOKEN_STD, type, 0);
> > > > > +	if (err)
> > > > > +		return err;
> > > > > +
> > > > > +	return buffer.output[1]; =20
> > > >
> > > > buffer.output[1] is of type u32. So theoretically it can contain va=
lue
> > > > above 2^31. For safety it would be better to check if the output[1]
> > > > value fits into INT_MAX and if not then return something like -ERAN=
GE
> > > > (or some other better errno code).


I ended up returning -EIO here, with the logic that if we're getting
some nonsense value from SMBIOS, it could either be junk in the stored
values or communication corruption.

Likewise, I used -EIO for the checks in charge_control_start_threshold_show
and charge_control_end_threshold_show when SMBIOS returns values > 100%.



>=20
> >  =20
> > > >    =20
> > > > > +	if (end < 0)
> > > > > +		end =3D CHARGE_END_MAX;
> > > > > +	if ((end - start) < CHARGE_MIN_DIFF)   =20
> > > >=20
> > > > nit: I'm not sure what is the correct coding style for kernel drive=
rs
> > > > but I thought that parenthesis around (end - start) are not being
> > > > written.
> > > >    =20

I think it makes the comparison much easier to read. I'd prefer to
keep it, unless the coding style specifically forbids it.




> > > > > +
> > > > > +static u32 __init battery_get_supported_modes(void)
> > > > > +{
> > > > > +	u32 modes =3D 0;
> > > > > +	int i;
> > > > > +
> > > > > +	for (i =3D 0; i < ARRAY_SIZE(battery_modes); i++) {
> > > > > +		if (dell_smbios_find_token(battery_modes[i].token))
> > > > > +			modes |=3D BIT(i);
> > > > > +	}
> > > > > +
> > > > > +	return modes;
> > > > > +}
> > > > > +
> > > > > +static void __init dell_battery_init(struct device *dev)
> > > > > +{
> > > > > +	battery_supported_modes =3D battery_get_supported_modes();
> > > > > +
> > > > > +	if (battery_supported_modes !=3D 0)
> > > > > +		battery_hook_register(&dell_battery_hook);   =20
> > > >=20
> > > > Anyway, how is this battery_hook_register() suppose to work on syst=
ems
> > > > with multiple batteries? The provided API is only for the primary
> > > > battery, but on older Dell laptop it was possible to connect up to
> > > > 3 batteries. Would not this case some issues? =20
> >=20
> > This interface is _only_ for controlling charging of the primary batter=
y.
> > In theory, it should hopefully ignore any other batteries, which would
> > need to have their settings changed in the BIOS or with a special tool =
or
> > whatever. =20
>=20
> That is OK. But where it is specified that the hook is being registered
> only for the primary battery? Because from the usage it looks like that
> the hook is applied either for all batteries present in the system or
> for some one arbitrary chosen battery.
>=20
> > However, I'm basing that assumption on the SMBIOS interface. These toke=
ns
> > are marked "Primary Battery". There are separate tokens marked "Battery
> > Slice", which from my understanding was an older type of battery that =
=20
>=20
> From SMBIOS perspective it is clear, each battery seems to have its own
> tokens.
>=20
> The issue here is: how to tell kernel that the particular
> dell_battery_hook has to be bound with the primary battery?
>=20

So from userspace, we've got the expectation that multiple batteries
would show up as /sys/class/power_supply/BAT0, /sys/class/power_supply/BAT1,
and so on.

The current BAT0 entry shows things like 'capacity' even without this
patch, and we're just piggybacking off of that to add charge_type and
other entries. So there shouldn't be any confusion there, agreed?

In the kernel, we're registering the acpi_battery_hook as "Dell Primary
Battery Extension". The functions set up by that acpi_battery_hook are
the only ones using battery_support_modes. We could make it more explicit
by:
1) renaming it to primary_battery_modes, along with
dell_primary_battery_{init,exit} and/or
2) allocating the mode mask and strings dynamically, and storing that
inside of the dev kobject.

However, #2 seems overly complicated for what we're doing. In the
circumstances that we want to add support for secondary batteries,
we're going to need to query separate tokens, add another
acpi_battery_hook, and also add a second mask. Whether that's a global
variable or kept inside pdev seems like more of a style issue than
anything else.

#1 is easy enough to change, if you think that's necessary.





--=20
I'm available for contract & employment work, see:
https://spindle.queued.net/~dilinger/resume-tech.pdf

