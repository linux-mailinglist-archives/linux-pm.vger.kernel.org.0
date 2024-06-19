Return-Path: <linux-pm+bounces-9598-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FFE290F22E
	for <lists+linux-pm@lfdr.de>; Wed, 19 Jun 2024 17:30:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4EA3D1F2293B
	for <lists+linux-pm@lfdr.de>; Wed, 19 Jun 2024 15:30:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3003F22339;
	Wed, 19 Jun 2024 15:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="VL1wI4xs"
X-Original-To: linux-pm@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8864B111AA;
	Wed, 19 Jun 2024 15:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718811031; cv=none; b=gFqgsuBtJdQFUx2fIl4DrXw29tX2heQtZBDsLyuve9cYEofBLjj0SAbtJQmxbgRXWjA7crWccE2ppnst8dODjGPhB36QcGvkf2WYRYJvaSUgfvOSwHyI3EoPZa3xJxmq3RwCjg27Yg9Jw2k1EkWHQB+c8uw/dhc+aSD/LqFvTPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718811031; c=relaxed/simple;
	bh=GARrv2U5iUkXfAAtu6Bwo+f4v55ZM2Q8kooO87MBKXM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HerJ9BAppS24quWcpmnrLqmDjSYg09OB7kUlATrx1HPljpoPthxQREz82Zp/wEs/s54sQbmlULrQZ/v409Xg5U4P2+iLx9GzuYhuTFtKOZ87Kp4tvf1W8T7BTGqy9Nj20g1rIJtoyO/j6Gg5mga/p43JYdpMO2ZqQkzYWtHkcLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=VL1wI4xs; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1718811027;
	bh=GARrv2U5iUkXfAAtu6Bwo+f4v55ZM2Q8kooO87MBKXM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VL1wI4xsDUENj1gb3kp0V/4kNGoqhVM48VaxXmIFAtpmOijy8jybDffPNk9WWIypF
	 TzY7OSasMi9RdLmgCBNPUVUyo5uwaroFXXPqYc9zoU3sXQU54DGCeS2jheT+awFk+U
	 teKEKjoiPgR6qUrQMuGOfRTr0aDPRwiMoyZ6lMjvs5q9YLqZ31W/mslA8kbGYXdOv/
	 HllAnziAqVxRKcKyx06Rr4xoUg6HfJ3LPB7fro6a5IcpDyYTkPoY1FuJ0PNjtfv+wt
	 rueosvRdmIyB3UPstNcFzOZr8mEZptRpuyCl9+Umi29C1NevR2avn/rEAO7W0AHGdN
	 G4bqutHVYqzoA==
Received: from mercury (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: sre)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id C99A037821A9;
	Wed, 19 Jun 2024 15:30:27 +0000 (UTC)
Received: by mercury (Postfix, from userid 1000)
	id 72E721060B1F; Wed, 19 Jun 2024 17:30:27 +0200 (CEST)
Date: Wed, 19 Jun 2024 17:30:27 +0200
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Dimitri Fedrau <dima.fedrau@gmail.com>
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-pm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas@t-8ch.de>
Subject: Re: [PATCH v4 2/2] power: supply: add support for MAX1720x
 standalone fuel gauge
Message-ID: <nar5atcllxoulmzm247uhe5zwyn2tpyt65mdrlxshejx5wcjlh@55re3bsshcqe>
References: <20240617184504.304211-1-dima.fedrau@gmail.com>
 <20240617184504.304211-3-dima.fedrau@gmail.com>
 <dzrsh5dsraz62sc3mfhlmf5yolkzjet2agv2ochg3xg4ryfofs@bnmxbtsavv4o>
 <20240619061407.GA51605@debian>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="sqwi7evudkzl23te"
Content-Disposition: inline
In-Reply-To: <20240619061407.GA51605@debian>


--sqwi7evudkzl23te
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Jun 19, 2024 at 08:14:07AM GMT, Dimitri Fedrau wrote:
> Am Wed, Jun 19, 2024 at 01:19:32AM +0200 schrieb Sebastian Reichel:
> > On Mon, Jun 17, 2024 at 08:45:04PM GMT, Dimitri Fedrau wrote:
> > > The MAX17201 monitors a single cell pack. The MAX17205 monitors and
> > > balances a 2S or 3S pack or monitors a multiple-series cell pack. Both
> > > devices use a I2C interface.
> > >=20
> > > Signed-off-by: Dimitri Fedrau <dima.fedrau@gmail.com>
> > > ---
> >=20
> > [...]
> >=20
> > > +static int max1720x_read_word_data_nvmem(struct i2c_client *ancillar=
y, u8 addr)
> > > +{
> > > +	u8 rx[2];
> > > +	struct i2c_msg msgs[] =3D {
> > > +		{
> > > +			.addr =3D ancillary->addr,
> > > +			.flags =3D 0,
> > > +			.len =3D 1,
> > > +			.buf =3D &addr,
> > > +		},
> > > +		{
> > > +			.addr =3D ancillary->addr,
> > > +			.flags =3D I2C_M_RD,
> > > +			.len =3D 2,
> > > +			.buf =3D &rx[0],
> > > +		},
> > > +	};
> > > +	int ret;
> > > +
> > > +	ret =3D i2c_transfer(ancillary->adapter, msgs, ARRAY_SIZE(msgs));
> > > +	if (ret !=3D ARRAY_SIZE(msgs))
> > > +		return ret < 0 ? ret : -EIO;
> > > +
> > > +	return get_unaligned_le16(&rx[0]);
> > > +}
> >=20
> > Have you tried using i2c_smbus_read_word_data(ancillary, addr)
> > instead of the above?
> >
> Yes, I did and it worked. Used it in V3 and changed it due to review
> comments by Thomas which make sense to me. I don't have any preference on
> this. Should I change it back ?

Using the smbus function makes the driver work with a pure SMBus
adapter and keeps it working with I2C adapters through the SMBus
"emulation". By using the open coded version we have more code and
the driver does not work with pure SMBus adapters.

So I see no reason why the open coded version should be used. Note,
that regmap also uses i2c_smbus_read_word_data() internally for your
configuration of the non-ancillary device.

Greetings,

-- Sebastian

--sqwi7evudkzl23te
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmZy+Y4ACgkQ2O7X88g7
+poBeg//eGv9qcoLJV4TGWb/FKwLMhiFlVTwOEsAnS+hg1LwGkQOMQkXOASBix1m
ahsPJt8/LbUIy/5tYkqa4wavTlgjFbLVMJUr/2/WH9TvWCp8N4gCK8BWzwvWqGVk
z10ubS0xHCsV9eXUWZkuZgOhjS3OLpGwHG9DYnT3U8Zwxlo148Cn/+wkLzlpmdsn
xfEaenaQhx7Xj9HRoGTierof8yWJGMvBThY3hXxE/9tiW29FF6YzRnWtyKppUCNE
MS7l87CtFbrnuv/9aV5HnLHaZ4my3gzIfUd/6if5ScOx9wt1qY0/xhd+L0+GgiHA
zuZlZZ1WIwLeyO05Rt6u/9OU1MUkfdh79gq9AJ4ZLC2Zm/xLLbzPwmOx7QKZ4tGA
MaKGocz7UPIUnwMg9pLgx0XBxXDk68HHYxTJnq/hfw4uevO/klKqFm2dmamsnFPj
VgtBvfrCTDfzWdtZqkMiwRTZdHj2h9Nsw9nwHsGoX6vysP8gv8NhHjQv7ZwgzfZq
SGOvUe2W+j2sHzlT8NzjLh7TuQrI2rrB+6g+gX4NI+WT5Ly/3OZb5GKzTmCEtQF0
5zxWw22M2pa+vrOZTH894R/sHQc35IAHtlLuAt+G0eK09NFpXZhOWAjR9lF0Z1LJ
kxeyeG4WqWg3TOUchI3re94yd4AHZBs9y9SdOnckLb9tXB2EVs4=
=lti8
-----END PGP SIGNATURE-----

--sqwi7evudkzl23te--

