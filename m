Return-Path: <linux-pm+bounces-14521-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 93AA397D679
	for <lists+linux-pm@lfdr.de>; Fri, 20 Sep 2024 15:52:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 22F791F24C33
	for <lists+linux-pm@lfdr.de>; Fri, 20 Sep 2024 13:52:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55D6D17A5BD;
	Fri, 20 Sep 2024 13:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b="OWfJ4z/U"
X-Original-To: linux-pm@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61DA13BBC1
	for <linux-pm@vger.kernel.org>; Fri, 20 Sep 2024 13:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726840347; cv=pass; b=r2EWaOycJAIdCWNnw5xPBABAo0kwGge267aTuXt8txvdipKaDDPoe/iNV9Ruw872lx8QOeaxayBjq0MDQWfmaF9l5lWFNmAtvzm4uWJd7z1gPbQQ8VNkoid9TlqLVXst4rxmy8taltNj20SsnGGkQm9UkQS5f3CTIVobfzmyjcg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726840347; c=relaxed/simple;
	bh=s6ZI+avVES4YD+mDeJZ5QDjLY+xepmpnQ+Y5+MOal2A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gBXfPtb/zkTAr30YyPBJWBayo7aZXzu6dwhzEGWz2gdauXIsRVdvAOfxvNySMjYPrksj/yiQaTHSEFnD0bSdCRd+kMYOmgXLqzWR4zE++gJgZhdPk9AYK6eIbhJQqEu4NvPRqR85AcZu/NYix2fgctwl6hKavu887Uq3sWhfy04=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b=OWfJ4z/U; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1726840334; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=VjnFxnpNzpkatDR9zfvHrrak1dAY0z0UAsT1kpXq/oG+4k8rpoxSVMDihIBwVSv0f10GOqQ5HiNDgQVNT9kMpHFvjVwbJLrIfDP+/SCuZQsjkC1keECBjXbU9s+qJLPI8yyt9BlLQHanf/AC8HbtOV/C78LX0NTXulaPX3RVvPo=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1726840334; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=tH0aMlNiUOBaZz4XLHfwBCQake7EPA6WK+8oNzEdDtY=; 
	b=O0foJI5jj1sy4NueWUEH9QjlmBCKHbBTGCvC4e1L/St0c6HIQrfXDhC1E0HUwJN/Pr7phYKUVl65OwkDwpqEFdyk3+50SPt/LAbLOeEn+FQxYONLRqjdzMPWs307UEOnr0eDYmr3XYV3uWFsdqz6/E85vMTfx4dKKdqYtFUusks=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=sebastian.reichel@collabora.com;
	dmarc=pass header.from=<sebastian.reichel@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1726840334;
	s=zohomail; d=collabora.com; i=sebastian.reichel@collabora.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
	bh=tH0aMlNiUOBaZz4XLHfwBCQake7EPA6WK+8oNzEdDtY=;
	b=OWfJ4z/UacR3OhnLlKnF3vWfRRoazcUtT6Q0UBezF/3HL7zLuY+ch+ryWfG1yGmb
	RXI2Mk8LFVaEXAjYz12UzokIo09ftP7MDDnRjCHnvh5r/Ypmfqj4Wrsouep7OYB1ZvY
	JEL0PF/cdcU7Axgh9eguhqagGFQKPeHG0Csse3jQ=
Received: by mx.zohomail.com with SMTPS id 1726840331228670.6849714262859;
	Fri, 20 Sep 2024 06:52:11 -0700 (PDT)
Received: by mercury (Postfix, from userid 1000)
	id AD6CC106033A; Fri, 20 Sep 2024 15:52:06 +0200 (CEST)
Date: Fri, 20 Sep 2024 15:52:06 +0200
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Hans de Goede <hdegoede@redhat.com>
Cc: Jelle van der Waa <jelle@vdwaa.nl>, 
	Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>, linux-pm@vger.kernel.org
Subject: Re: [PATCH 1/4] power: supply: sysfs: Make
 power_supply_show_enum_with_available() deal with labels with a space
Message-ID: <z3it2whilcvdrzv56ignyn2h6i4l5rl6cy7ah7elwxahij2fpe@6pj6foq3vz3q>
References: <20240908192303.151562-1-hdegoede@redhat.com>
 <20240908192303.151562-2-hdegoede@redhat.com>
 <2crw2apbxixaqq6vibtlewe47nvqeo2cnwo2okdiqtaelvtjce@g6mhr4iproiz>
 <599b59f6-6cd4-463d-aafb-699fcb387f7e@redhat.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="vx45ocrvkvcato73"
Content-Disposition: inline
In-Reply-To: <599b59f6-6cd4-463d-aafb-699fcb387f7e@redhat.com>
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-1.3.1/223.982.64
X-ZohoMailClient: External


--vx45ocrvkvcato73
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Sep 17, 2024 at 11:06:42AM GMT, Hans de Goede wrote:
> Hi Sebastian,
>=20
> On 9/17/24 9:38 AM, Sebastian Reichel wrote:
> > Hello Hans,
> >=20
> > On Sun, Sep 08, 2024 at 09:23:00PM GMT, Hans de Goede wrote:
> >> Some enum style power-supply properties have text-values / labels for =
some
> >> of the enum values containing a space, e.g. "Long Life" for
> >> POWER_SUPPLY_CHARGE_TYPE_LONGLIFE.
> >>
> >> Make power_supply_show_enum_with_available() surround these label with=
 ""
> >> when the label is not for the active enum value to make it clear that =
this
> >> is a single label and not 2 different labels for 2 different enum valu=
es.
> >>
> >> After this the output for a battery which support "Long Life" will be =
e.g.:
> >>
> >> Fast [Standard] "Long Life"
> >>
> >> or:
> >>
> >> Fast Standard [Long Life]
> >>
> >> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> >> ---
> >=20
> > This looks annoying from parsing point of view. Maybe we can just
> > replace " " with "_" and guarantee that space is a value separator
> > at the cost of the values not being exactly the same as the existing
> > charge_type sysfs file?
>=20
> My thinking here was that if a parser wants to see if a certain option
> is available it can just do a strstr() and parsing for the active
> value does not change. But yes a parser which wants to tokenize
> the string to get all possible values as separate tokens will
> become harder to write with this.
>=20
> I did consider moving to using a "_" one problem there is that
> this means that echo-ing "Long_Life" to set the value should then
> work. Which would require special handling in the generic store()
> function. I guess we could makle=20
>=20
> I guess an easy solution here would be to define a second set
> of POWER_SUPPLY_CHARGE_TYPE_TEXT[] strings aptly named
> POWER_SUPPLY_CHARGE_TYPES_TEXT[] (with the extra s).
>=20
> This can then simply contain Long_Life instead of Long Life,
> downside of this would be that writing "Long Life" will then
> not work. So charge_type then takes "Long Life" and charge_types
> "Long_Life" which is less then ideal.

Also having two lists sounds error prone regarding going out of
sync.

> The best I can come up with is to replace " " with _ when showing
> and in power_supply_store_property() add some special handling for
> charge_types like this:
>=20
> 	/* Accept "Long_Life" as alt for "Long Life" for "charge_types" */
> 	if (dev_attr_psp(attr) =3D=3D POWER_SUPPLY_PROP_CHARGE_TYPES &&
> 	    sysfs_streq(buf, "Long_Life"))
> 		buf =3D "Long Life";
>=20
> 	ret =3D -EINVAL;
>         if (ps_attr->text_values_len > 0) {
>                 ret =3D __sysfs_match_string(ps_attr->text_values,
>                                            ps_attr->text_values_len, buf);
>         }

That's ugly, but better than maintaining a second list IMHO.

> This isn't pretty, but this way we don't need to define a second set of
> POWER_SUPPLY_CHARGE_TYPES_TEXT[] values, duplicating those (and needing
> to manually keep them in sync), while accepting both "Long Life" and
> "Long_Life".
>=20
> Note that a generic replacing of _ with space or the other way around
> in store() will not work because we already allow/use "Not Charging"
> but also "PD_DRP" so replacing either _ or space with the other will
> break one of those.

We only replace " " with "_" on the output side for the code doing
multi-value printing. I think on the write side accepting "Not_Charging"
in addition to "Not Charging" is probably fine as long as we document
that?

> > Do you know if there is prior examples for this in the kernel by
> > chance?
>=20
> I'm not aware of any examples where a sysfs attr show() uses the show
> all available values with the active one surrounding by [ ] where
> one of the values has a space in it. It is quite easy to avoid the
> values having spaces if this format is used from the start.

Then let's please avoid that :)

P.S.: Last message before my 3 week vacation on this patchset.
Thomas Wei=DFschuh said, that he might have some ideas and will sync
with you next week.

Greetings,

-- Sebastian

--vx45ocrvkvcato73
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmbtfgAACgkQ2O7X88g7
+prYcg//S4krJuoYnX9opi4v4D+pkdCrSbCjCHi4a71YwjE1oI/ffmiqixa9O101
ngq/RMydJBWTwRxSWNqOcgxXnJPRvfW6ZUkL7zVaJlkqT0mwq0ve33JjgUlaP9uq
U5guXVZN3zMTXetCOfGBn3YpwUt3OzbQx0WJ01Ojzq43CuuZcxBka4u9Sovqa5r2
xuNriPbczlepKYzJoeVx14IvgU6lmPaU4gS5nBERpChHQ2GR4Vvc7R7G9+abjX8R
py8at/ODfjQsAu+nLlKD6Nq27MtGm0U5AHKz/dZyUCXcbxFx3rRZBWXpvLOzLt2E
N6CKxtnW/lIeueHlIzk8sHRSNZM9mia3tLy1reD8uh6b7iWWBCl/pzA18gE9kbzp
ILbqTEugQZ+cZl1epDc+XkMi6kcaVk29YiyCcDxx0wwWHPWqLtiDP8Z8vd/s3hQV
bdZ6lWl2k6oXLXAQUUkAGLJrse+GKH8K+Ro679PC0+CFxgivFy/YWhtc/L41ojMy
J/aoVB4pnsjmC5FcvmYC55aPbEyOQ0+dnBAZZ/5y2fYhqXSps9Npr4H+4NyClHrZ
3kj2OfwNOarI//KdPlJ9lR4Z6EUQep/VPksl06g1opFQ55iI853wVeoMyV4tPLM0
hGKZdQ3GT6XZTWk8ehznB7X4NZGH91uu7UQFcOQqIt+VW847kXY=
=xtrN
-----END PGP SIGNATURE-----

--vx45ocrvkvcato73--

