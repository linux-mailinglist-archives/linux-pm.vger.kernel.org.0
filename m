Return-Path: <linux-pm+bounces-13500-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EED2B96AC18
	for <lists+linux-pm@lfdr.de>; Wed,  4 Sep 2024 00:22:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A808F28113B
	for <lists+linux-pm@lfdr.de>; Tue,  3 Sep 2024 22:22:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 040481C9DC9;
	Tue,  3 Sep 2024 22:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="hpDzFIUz";
	dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="FU6NhrU8"
X-Original-To: linux-pm@vger.kernel.org
Received: from a7-47.smtp-out.eu-west-1.amazonses.com (a7-47.smtp-out.eu-west-1.amazonses.com [54.240.7.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 325231865F0
	for <linux-pm@vger.kernel.org>; Tue,  3 Sep 2024 22:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.240.7.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725402137; cv=none; b=A9huYBmXRnWqVFjIwu+hAWF6w1uAvjx+uYI1AfKljkUs+C9gpkHTEvZvPHgH9KJ87nD5uiXdHiEudj+e7LccuDsb1T+0+4bJT2zcemRn4K9H3up9kwCkNgooYexUtlUGBZCm2svpy+zINkPimRtQvI9hp16OCIJia7X6EdU8DnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725402137; c=relaxed/simple;
	bh=2lTjQBWQ72TTYmchUNR1pf5Bnq1N8EiNdKi5v0LsQpE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XyFBg8vFjQEnfr5dS8Y28Y3l4JZSqQNwiQY39eU1RGYbhq2h5JPzwLECUKE5293mYaTH1ag7g5KVuBL+35a6BjU3a47Q+VoLD9hc5cxfGv5AVEdKUUHAnqwCnm7TdtWeizxKyfGGC7gvC6bM+3/xYNn4hccLe2GYlkq07Q6RZAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=amazonses.collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=hpDzFIUz; dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b=FU6NhrU8; arc=none smtp.client-ip=54.240.7.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazonses.collabora.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=4232tfv5ebdrjdwkr5zzm7kytdkokgug; d=collabora.com; t=1725402134;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To;
	bh=2lTjQBWQ72TTYmchUNR1pf5Bnq1N8EiNdKi5v0LsQpE=;
	b=hpDzFIUzZHcG8Mp8R41BLh4cyK1f0Yymvs20LRRI2u3qwVm8WIqSwmDAUW8gzscc
	+5lg+t0yqfLURWUu1J3A4s2jwuDYizqq/OGcQAwmpryQGXJDGasocFvIRuhkulmzSYv
	oT2KjK11H1wXIYjBRGJJsKTyu7A6K6nw8Sh/MDNtZfe2jwJlMYPurjSsIZSa1c7Ilg+
	G40kHkRj37AF2J62irxWvCWOOTS5DGolkSIdW+Pu1gHNemKIEtCk2RqWts70x0W2Y8s
	Pl0bGGXZpV+sn0nzK9gqbVek2vhhyDr0CV9cXUHMekfRrRm8ndoCelLPkMXFa7bVndu
	fgEF5ZpnjA==
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=uku4taia5b5tsbglxyj6zym32efj7xqv; d=amazonses.com; t=1725402134;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Feedback-ID;
	bh=2lTjQBWQ72TTYmchUNR1pf5Bnq1N8EiNdKi5v0LsQpE=;
	b=FU6NhrU8fKDilvxYU61tsYbMt/PLJrZ6esObEkdpN2ZwpcLr2FmdDwehPm0I/uGM
	nopygnsYspOZ0xHynAWEo+lwwK/1W53SYjXbXn3WnYy6wjDsb0eevhcVjN4qw2oRW5N
	8lBWfarrTXBfuQIyrDLIOEce7IZrVNvajnw94hcQ=
Date: Tue, 3 Sep 2024 22:22:14 +0000
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Hans de Goede <hdegoede@redhat.com>
Cc: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas@weissschuh.net>, 
	Linux PM <linux-pm@vger.kernel.org>, 
	Jelle van der Waa <jelle@vdwaa.nl>
Subject: Re: RFC: Extending charge_type power-supply property to show valid
 values
Message-ID: <01020191b9fb3843-0b2ebee5-c525-475c-83b4-92bf83f012ce-000000@eu-west-1.amazonses.com>
References: <49993a42-aa91-46bf-acef-4a089db4c2db@redhat.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="nh4nnpwi63s2srkv"
Content-Disposition: inline
In-Reply-To: <49993a42-aa91-46bf-acef-4a089db4c2db@redhat.com>
Feedback-ID: ::1.eu-west-1.YpP9ZbxnARFfy3Cb5pfsLd/pdsXBCNK0KEM7HforL4k=:AmazonSES
X-SES-Outgoing: 2024.09.03-54.240.7.47


--nh4nnpwi63s2srkv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Aug 26, 2024 at 02:05:54PM GMT, Hans de Goede wrote:
> <resend with Thomas who implemented the charge-behavior code added to the=
 Cc>
>=20
> Hi Sebastian,
>=20
> Jelle (in the Cc) is looking into adding a UI to GNOME to allow users to
> enable battery long-life mode. The initial plan was to use the charge
> start and stop thresholds but not all laptop models support these,
> some only have a single toggle to turn long-life mode on/off.
>=20
> At first look it seems that charge_type is the right userspace API to use
> for these single toggle only laptop models, offering "Standard" and
> "Long Life" as valid options.
>=20
> However we don't want userspace to have to write charge_type just to
> find out which values are supported.
>=20
> My proposal for this is to have a new POWER_SUPPLY_PROP_CHARGE_TYPES
> properties which behaves like USB_TYPE / CHARGE_BEHAVIOR, e.g. :
>=20
> [hans@x1 linux]$ cat /sys/class/power_supply/ucsi-source-psy-USBC000\:001=
/usb_type=20
> [C] PD PD_PPS
>=20
> The idea would be to copy the charge_behavior model and add
> a charge_types bitmask to struct power_supply_desc mirroring
> the u8 charge_behaviours; bitmask. This will also allow re-using
> power_supply_charge_behaviour_show() turning it into a generic
> show function for usb_type / charge_behavior style properties.
>=20
> Other then having the usb_type / charge_behavior style show()
> output the new charge_types which I'm suggesting would behave
> exactly the same as the old charge_type and drivers can use the
> same code paths to implement both. To get support for the new
> charge_types drivers just need to set a power_supply_desc.charge_types
> bitmap and add POWER_SUPPLY_PROP_CHARGE_TYPES to their list of
> supported properties.
>=20
> The idea is for charge_types to basically superseed charge_type
> offering the same functionality while advertising which values
> are valid for writing, while keeping charge_type around for
> backward compatibility.
>=20
> If this sounds good to you I can write a patch-set implementing
> the suggestion, + converting one or 2 drivers which already
> support writing charge_type atm.

Yes, this plan sounds good to me.

-- Sebastian

--nh4nnpwi63s2srkv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmbXjBIACgkQ2O7X88g7
+pq9Sw/8C0lwg0qCTyP8vu8dw89dzHg4HEGGJ3H99umOfcqg5ImFpE6jJeTpvopo
/Hnr3MLQaZm6rIzYZfcag1Qqh2cRrdVjmj081g9xiDF8QmkSzr4wCqBZCNFF6DKA
sg/KTsfZc706gIXBKFrabxU93YvrBtQPp63kFVnJ/KR/3am4R7HSPXxlIaZt7oG/
XrwQiEPngDD3xC/4G8JTWwOCkPhtixb60hLd+musjpoGjtm5HyT1jLFoXwXIzAQ4
Wy0Zm0WZ1EF2nOJV+oSDe1cHv/4Ga3skRTZvvO5OacLczOaKN9cTvYmDcCM0TSm3
OxouYiq9JOCTe2zSUcDxGj6EshsbKBh+BPeqzlGv2aY4XznmtCg5wfeJvBh0fk0U
V25A0KLseanE8G212+Kl4yAy736Wozqjrjwolh8cn3k1xP/E7HOr5P1f0wNn9Wew
OsFK7ucy5jcHq8KCWZw4CBnTYqWlkBj51YCdirtI1l8n3KHz2gCTCaeT33IBnZby
4cK46X3LayRyarKh809X/SATBGru/VJOHua1nDx5cW30i3eZODJAb6jetgsbE5WU
0yvAbdqkVZovZnzflyVG3/zzTzqOW/DGTvQn3ZyZSLaI8Gvy8+B+FfoNPr9O4JTQ
IicL/vxfDhmLKFnujx+UISrSarT/AX91v6cT43AW7QM8XFoJHiY=
=QRnG
-----END PGP SIGNATURE-----

--nh4nnpwi63s2srkv--

