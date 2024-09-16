Return-Path: <linux-pm+bounces-14334-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C89C979FD6
	for <lists+linux-pm@lfdr.de>; Mon, 16 Sep 2024 12:58:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 680D3B21E53
	for <lists+linux-pm@lfdr.de>; Mon, 16 Sep 2024 10:58:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFC63154C04;
	Mon, 16 Sep 2024 10:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b="kx+W2F39"
X-Original-To: linux-pm@vger.kernel.org
Received: from sender4-op-o14.zoho.com (sender4-op-o14.zoho.com [136.143.188.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E4501547EF;
	Mon, 16 Sep 2024 10:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726484308; cv=pass; b=Xr8ED+ICbu2czRzSB5yWxSEPZ8+vyA37x6NzAjFFQhlAadVAfCSi1RhF2or0uBjMcJ6GHwemDWKOBkmNjLSmMnjlazTSUWKC4kZjvgdNLTcfLn4V/l8Pke/jiO22FAvujfEcm8sKBpXPA+JlmWmY/zoXod9zbBkCLXfVE2mEHzM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726484308; c=relaxed/simple;
	bh=LYUTwPBlmZsCDST03H72So93SbD5WGKATLzVpoH5ft8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DU2Zs9tnNnE3OPoiilyqMcxyu9AF7kG0fPN/kTS6ClPIwaYF334bQfX6XdiU2IOcQ1D8Nl6eZlW5153vOKw03aLoHbVsq0GbAUHU1qvPypoNsAFRn98JydOGjxB7pIPIUJqIthADb1d2QsCHRgiQcUkLwUveSi8hss9E2IQEblw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b=kx+W2F39; arc=pass smtp.client-ip=136.143.188.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1726484300; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=eKBxxiaN1tKnYP548CnZxA83DVKP9Kqzc5mhOzq6ZwIoeZYfNbbR4s8hOndNM/n43yqMGTazxLjOsl1VCBGf/uKtQvNyOFFih3F1feW+kJ3KnU+8eAh5UH070yqSKj46URr8tD8WUS9LNq8LZ3lz3IrFX00B0VIYHqcZbx887FE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1726484300; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=LYUTwPBlmZsCDST03H72So93SbD5WGKATLzVpoH5ft8=; 
	b=fZl6wwabYN5u6DR25aBi0Ng39Ngz8wawBnid+obgKaRcmEqVdUC+N2mGk/OZkDhyKMcDc1BNkX9lMDcUzDZwHJMOcNhtdtXNyw4MiT74xOBeawWHjhnX/VeC32IZbPZTDoXXqXxBoP6f9cRgXoxibb2Y4R1QV1HTBfqXvO9ep9A=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=sebastian.reichel@collabora.com;
	dmarc=pass header.from=<sebastian.reichel@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1726484300;
	s=zohomail; d=collabora.com; i=sebastian.reichel@collabora.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
	bh=LYUTwPBlmZsCDST03H72So93SbD5WGKATLzVpoH5ft8=;
	b=kx+W2F39Hq8ZFVdMuenrbgmY/YARIr9EktXsax9ZRAmLJyPEeo0/vF/VCCE001so
	adNGEmJ+fHrjlTrVOicSU/0SVy2OYkvjOIlwDniPN2XuZsTKmgf2d11ytfDyZ0K4+1h
	qofeBSb/v8od6hI7fW6jij5uKm+ogW9gtDboVHxQ=
Received: by mx.zohomail.com with SMTPS id 172648429823147.676038453817796;
	Mon, 16 Sep 2024 03:58:18 -0700 (PDT)
Received: by mercury (Postfix, from userid 1000)
	id E6496106045D; Mon, 16 Sep 2024 12:58:13 +0200 (CEST)
Date: Mon, 16 Sep 2024 12:58:13 +0200
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc: Armin Wolf <W_Armin@gmx.de>, Hans de Goede <hdegoede@redhat.com>, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC v3 6/9] power: supply: core: implement extension API
Message-ID: <mts2assktel77gycqoynz42fwimdufyzskgcpfm4dyng7yqesd@cqxussdgn2dg>
References: <20240904-power-supply-extensions-v3-0-62efeb93f8ec@weissschuh.net>
 <20240904-power-supply-extensions-v3-6-62efeb93f8ec@weissschuh.net>
 <vq7r2udbmqfp5v7o2occtnoziwrnpidht2wgkofvfyfic2o67m@3wtnxxvtdgye>
 <64b5235f-cdcf-4793-9bef-472c638dcd2f@t-8ch.de>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="xevxuzfadajrfbdt"
Content-Disposition: inline
In-Reply-To: <64b5235f-cdcf-4793-9bef-472c638dcd2f@t-8ch.de>
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-1.3.1/223.982.64
X-ZohoMailClient: External


--xevxuzfadajrfbdt
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sat, Sep 14, 2024 at 04:25:25PM GMT, Thomas Wei=DFschuh wrote:
> On 2024-09-14 12:50:57+0000, Sebastian Reichel wrote:
> > On Wed, Sep 04, 2024 at 09:25:39PM GMT, Thomas Wei=DFschuh wrote:
> > > Signed-off-by: Thomas Wei=DFschuh <linux@weissschuh.net>
> > > ---
> >=20
> > missing long description :)
>=20
> I'll paste the cover letter here for the next one :-)
>=20
> > In general I like the concept. It looks like a good candidate to
> > clean up the mess with the custom registration of properties done
> > by the x86 platform code.
> >=20
> > Apart from ACPI with custom battery extensions mess, there is
> > something similar in the embedded world: Many charger chips have
> > rudimentary fuel-gauge support. Some drivers register a charger/usb
> > and a battery device. That results in two battery devices when the
> > machine also has a proper fuel gauge. Having two battery devices
> > exposed is bad, since that means the machine has two batteries
> > (like some Thinkpads). Not exposing the battery from the charger
> > device is possibly loosing information (depending on fuel gauge
> > features).
> >=20
> > I think it should be possible to register the charger's rudimentary
> > battery device as a power_supply_ext, if it detects a proper fuel
> > gauge being available (e.g. via the DT "power-supplies" property).
> > But then the charger's properties are the preferred ones. I think
> > they should be fallback properties instead. A machine only gets its
> > own fuel-gauge, when that provides better values than the data
> > available from the charger :)
> >=20
> > So the question is which property getter/setter should be used
> > when the same property is exposed multiple times. Your examples
> > only add new properties and does not run into this. The intuitive
> > thing would be for properties from extensions to be preferred,
> > but do we actually have a use case for that?
>=20
> Currently duplicate properties are straight up rejected.
> With multiple extensions any order-based resolution of duplicates seems
> to be prone for confusion in case the registration order changes.

Ah, I missed the part about rejecting duplicates.

> The x86 platform and embedded usecases seem quite disjunct to me.
> If we can keep them separate that would be easier to implement.

I wouldn't say they are disjunct. The embedded use case is basically
a superset of the x86 variant.

> x86:
>=20
> Don't allow any overriding, like the code currently does.
>=20
> embedded:
>=20
> Add different extension priorities. When registering a new one,
> unregister all lower priority ones; do nothing if a higher priority is
> already registered.
> This makes the result predictable even if the order changes.
> A fallback extension would need quite some bespoke logic I think.

Adding priorities seems sensible, but also requires assigning
priorities to the base device. I need to think more about this, but
it can wait until the basic version for x86 has landed

> Note:
> I noticed that the locking for power_supply_set_property() is currently
> broken. In case you are wondering about that.

ok.

-- Sebastian

--xevxuzfadajrfbdt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmboD0UACgkQ2O7X88g7
+prgdA/8DRJKtsV5G6ACLKlXXqUOhTmd1kkvr/isjWDjWPignlmPemHj0OPfrzJ0
rhSv7R2wU2nPoQvWTRBL5mDHjH+mylnAL3lDBwR1g26+wD8V6H+oKtzdyhmJ4ErL
mftocc0KxvCcUg0ejO16UGglWN4DUoqWPQUWEltXmyVznHA6ir6TUP04bRcc7xJ8
9AXeRkp4Namk+AXJvq8vO6pGS/cLuu3sShhc6kgdNzoqMH/yfDvMxiEg84P+SmNr
0P4PKB/xHY3mqbYSzMlMfAO7a6M3Lm12VT/a3jxiO4w+0PBg8zDJBq4w3mmBuAy2
ew66jfBovNxpAKQcgmJhDKULvytWW/097krRycFG0izWqoEx0OBAGngzBtf89afB
JPGGVkxWndGSo0AWc/r6CX54LUQ3bFVjpdcGa0h+sG1ahrsLcKt1V3yulVVAFfQ/
6pedyN46eqTNzLqr0UjclJmSh5Q3ATZiD7XQo5Hn65Z6j9MZ1GpSMAcgk0vEZJ7B
zuRMfhtEkuFIa09JAuOM+8l5WczPFEqpjPjCZILJsLcOuCNL7266lsRVfaIkGx5a
jyezFfqaSw7LKU0dQ4ueCk/nPAAzX9nOO9qi1hP1+/NA6k2FIBneqLp8ChTmPdtU
v8ZGMmG5uXMvmzaTHQ4+cFOIySmDCOfT8waQT8ZVKWx9/U6tfjU=
=iMu4
-----END PGP SIGNATURE-----

--xevxuzfadajrfbdt--

