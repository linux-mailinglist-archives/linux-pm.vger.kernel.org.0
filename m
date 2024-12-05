Return-Path: <linux-pm+bounces-18614-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96C169E5349
	for <lists+linux-pm@lfdr.de>; Thu,  5 Dec 2024 12:02:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 518AF285BF9
	for <lists+linux-pm@lfdr.de>; Thu,  5 Dec 2024 11:02:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C2A61DB929;
	Thu,  5 Dec 2024 11:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b="Hh39nOqM"
X-Original-To: linux-pm@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F7961D9A51;
	Thu,  5 Dec 2024 11:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733396574; cv=pass; b=XC8FwsSSPK88Adtm2xERs3qdR4yfFrHTqeh7GLzRtRMyBZqzsUn2PzVnK5xjdi2V3Cltistmhf1D6jtW+wL9xu2kBidNqQKCOsA/qP3wLR0yknTf0KP4UPxVBz2YwAUfuCjRpYyIbn9jkdO903UjEJ4w9IGE8PfRGlY1siRHvBo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733396574; c=relaxed/simple;
	bh=7jOdjk5AIjteaCflwTTiB9sSejvoDSEWvYSJOC4h3Kk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r4i9TKH/MoH6my2t47Dh5iV727Ze18b8/VeCTfs/MlZkzu4ZRDnx/AbvNRtu99D9kZS5uSqATDwV7NsQKCO+KQ5xwVw5bdM3M4Nc8ssD1fS6ylPq/+KCLiYhAF56WCBSida+m1tp1QtrSSdS0BX5ItYpIwZIUiLZTH9TMP3aE3w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b=Hh39nOqM; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1733396563; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=B8mRSGVj1QIN5OFnAzDjL6G8MXZpc0vfS1Lim/1XTZGvIR6LMBszzSXImGIDDbY7RNvAOO493zTBptxAzl8I0bbZ2ZGtmo3YWlXbZ9kKboh/uky/zrMaOB2LAUytK0STImimZozhBNG+tIrtHHpCf7IRowGlVjtPj1YR6Jdg79U=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1733396563; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=7YOmMEjcyEsKjQRg27TD/YTMqANnZ8CQ+jz3iSNzJNE=; 
	b=PzmN59+t+EvhrCf5DL4fEqQetiHyjK6WWlX7KEKh48/OrVI+rVdCrfsROZJz1ZnMbqJt0cIWOfXm5WvlE4AwKKVwYKq2cDkYRQT7pJv0c6VAllXP7TePZ5JnEWEBRyyEMYQVme65RTO/Rhp473u9TnGz2vJuex6fctUmOQdJTEE=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=sebastian.reichel@collabora.com;
	dmarc=pass header.from=<sebastian.reichel@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1733396563;
	s=zohomail; d=collabora.com; i=sebastian.reichel@collabora.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
	bh=7YOmMEjcyEsKjQRg27TD/YTMqANnZ8CQ+jz3iSNzJNE=;
	b=Hh39nOqMUettfnnmh6ghOLhlB/jyDY4A20RDyLfEeCyxnc8rTVyU1+JAKnAZ6y1P
	men3mLi9+XE7SbCDILnX7Qn/KYsdX0sOAvpgG7VY/AST/2V+Gxb2M12Mtz1KHNYXI0d
	/LyhbOV0giYBIRFK4PFUZAvYMjGe4tIaZMhNoaFA=
Received: by mx.zohomail.com with SMTPS id 1733396561579836.2568710415927;
	Thu, 5 Dec 2024 03:02:41 -0800 (PST)
Received: by mercury (Postfix, from userid 1000)
	id BE54C10604B0; Thu, 05 Dec 2024 12:02:38 +0100 (CET)
Date: Thu, 5 Dec 2024 12:02:38 +0100
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	=?utf-8?B?Q3PDs2vDoXMs?= Bence <csokas.bence@prolan.hu>
Cc: Samuel Holland <samuel@sholland.org>
Subject: Re: (subset) [PATCH v5 1/8] power: ip5xxx_power: Use regmap_field API
Message-ID: <w466jkw43c3s6pu6gmwaqnittvg64gcrqkvd5gsosd5mo6hlf6@qscay7rn4ipt>
References: <20241119180741.2237692-1-csokas.bence@prolan.hu>
 <173336261259.1429662.11543418848764178684.b4-ty@collabora.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="64wzqe5lzy3dtngq"
Content-Disposition: inline
In-Reply-To: <173336261259.1429662.11543418848764178684.b4-ty@collabora.com>
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-1.3.1/233.365.87
X-ZohoMailClient: External


--64wzqe5lzy3dtngq
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: (subset) [PATCH v5 1/8] power: ip5xxx_power: Use regmap_field API
MIME-Version: 1.0

Hi,

On Thu, Dec 05, 2024 at 02:36:52AM +0100, Sebastian Reichel wrote:
> On Tue, 19 Nov 2024 19:07:33 +0100, Cs=F3k=E1s, Bence wrote:
> > The IP53xx series [1] has a much different register
> > layout than the 51xx/52xx [2] currently supported
> > by this driver. To accommodate supporting the former,
> > refactor the code to use the flexible regmap_field API.
> >=20
> > [1] https://sharvielectronics.com/wp-content/uploads/2021/07/IP5306-I2C=
-registers.pdf
> > [2] https://www.windworkshop.cn/wp-content/uploads/2022/04/IP5209-IP510=
9-IP5207-IP5108-I2C-registers.pdf
> >=20
> > [...]
>=20
> Applied, thanks!
>=20
> [8/8] power: ip5xxx_power: Add support for IP5306
>       commit: 39f3bd9c9a27d526858da153090376decdf7bfea

b4 got a bit confused. I have applied the whole series with some
minor changes, which I just mentioned as replies to the single
patches.

Greetings,

-- Sebastian

--64wzqe5lzy3dtngq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmdRiE4ACgkQ2O7X88g7
+pqMMg//RCbybuyt6As28QMPhBXX8WesgtS7RxR+RcWR4ZsPp/Qj4J/qsklW/zVS
X3MkY78PoCaJuwQvs42f0PYht5edeEwtETiJ4g4m2H3+pm61E0kard2YuYOtLTw2
g1jI0WYTHtX4OZBLgPAPc1G7+lmty/jive55DieD3NKzosogWLSHP0UCiNNP0YQE
QzLy5GFONy7J3Aw2a3yn9awgAbnMbK+FoKyVMe1944ePywnHzbQRlcOlTqEfmPjN
UL353YfPxJ8PMUf7pzln++gTYgMm8XMRvyRu5j8tQGYF7/wgeDqsU9x0urhCl84i
pEbf+yFIraH0C70JZuAkrOl2Ql0LVq6mXEqf9ke5x2RwYBIT5Lj9ok8KtoBgRY4C
nOEWlvVrXuVDVnx6ADTYRIBAW5ewLTBxexYylgG6PRIR1c8C6ez+5yuO2rqfO8la
a2B4mEA8uVWxN+r2PrqzmgDU8Rn9IJzzl+hoHKHWVUENs3DP3OVTZi1MGZ+2JT58
RZtskpq+R8T8JjX+/v/a3py1CQv5QFF3BCQQzRTmxw7rFB0Ue/9aq0oyZBzaWmiX
5wXH9C94Csp+5efuJeXdi544qE5jzyiJqTwTVcKydxJIadlBGL0Y98z+GgJx7MG5
+UI4/Zbud5xYxVVfRn81fCBAJl+TmZib3/9bvBMjp6EgJr4xkNE=
=C6vP
-----END PGP SIGNATURE-----

--64wzqe5lzy3dtngq--

