Return-Path: <linux-pm+bounces-22522-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4237A3CD76
	for <lists+linux-pm@lfdr.de>; Thu, 20 Feb 2025 00:26:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 72D523AD85F
	for <lists+linux-pm@lfdr.de>; Wed, 19 Feb 2025 23:26:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73A8625D556;
	Wed, 19 Feb 2025 23:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b="EdgABP4q"
X-Original-To: linux-pm@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBE031D7E30;
	Wed, 19 Feb 2025 23:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740007606; cv=pass; b=Zs4aTzleGU2kCZSZjJ+wxIwJev4/Coz97D7gLOKPHIRpnCy/qcx/qUZ/gChGkBwdbzUkAyFBrXzx/ibW2nRaxzaikGjvqopTDIAOtStbcR5Re6uGItZhRkOpXHLTXoDtznVIHzupw4TfRDy85DVU8pWGp1FC1QbVebD1jIQHhDg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740007606; c=relaxed/simple;
	bh=t149zXGny9MUh9rTomjedstsAjZSGm+Ucs4XSCkChpk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oK1umofJHsLwYulLM0/6Df0y2ZNwoLiRVddnnvuSkumG8olwlTRALOtLAaSJV553peVeumMd9B48aYnwzjWq/DIGhln+nRpIa/lk9fu/sV0Iu13a7Iw/eHay2fn35XoQsYp986LDpUTfjJ0cj450KX8P/JbKJBcoubYY9uId5TA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b=EdgABP4q; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1740007587; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=aAGb5oMoeByvJDd94EMGXJMsYAMF6FyEThe3Aws0h4ka9BXzwDnNEN+N2AbesjfoxSJzeLcn85kPSzWH1nIwJ35Oc4QkSfkDSD9D4xE0kDForixyVJzfbt+ymGQeubYStqf9JPRmwbwbmuYQT704QLhJYaO/zQBwGXLri625/SI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1740007587; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=PXGNFT4r8OhyB7bcA09sStUpxj8AlqUe/lnXSeaoIB0=; 
	b=OeVRzEe93uh8XyL+XrD3dNGxe8ROsZiaVHiB5/m4AhLTupgYZUwzlp3429DGYDH4eyNDCZF3pwpHxMltj/IyAwibJXVEqEWijLqniLqYNYUW0zlLsd4Ea+uF40WH+HYMK/3J3FvG0qGZvhNUKCnqflQv805F4HTHR3NsD6Xp/Kc=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=sebastian.reichel@collabora.com;
	dmarc=pass header.from=<sebastian.reichel@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1740007587;
	s=zohomail; d=collabora.com; i=sebastian.reichel@collabora.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
	bh=PXGNFT4r8OhyB7bcA09sStUpxj8AlqUe/lnXSeaoIB0=;
	b=EdgABP4q2U2yfUOmmbB3kJzXjA8qpSxqJdvnA8KxIDCzR+YfncsUq2kwLcmtdSBc
	ox1TdeoO/KZFfAnaOhjsqv3b2OPoHyWX3CePbhByayUzGqK47xJ22tHAVcepxohmwH7
	Q4WlBq9bFCjBlttJ2TaN/k/4GUBBT8icRKaWhCXo=
Received: by mx.zohomail.com with SMTPS id 1740007586726930.4692958102619;
	Wed, 19 Feb 2025 15:26:26 -0800 (PST)
Received: by venus (Postfix, from userid 1000)
	id BB60118093B; Thu, 20 Feb 2025 00:26:22 +0100 (CET)
Date: Thu, 20 Feb 2025 00:26:22 +0100
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Lee Jones <lee@kernel.org>
Cc: linux-sunxi@lists.linux.dev, Chris Morgan <macroalpha82@gmail.com>, 
	devicetree@vger.kernel.org, linux-pm@vger.kernel.org, samuel@sholland.org, 
	jernej.skrabec@gmail.com, wens@csie.org, conor+dt@kernel.org, krzk+dt@kernel.org, 
	robh@kernel.org, Chris Morgan <macromorgan@hotmail.com>
Subject: Re: (subset) [PATCH V2 2/4] mfd: axp20x: AXP717: Add
 AXP717_TS_PIN_CFG to writeable regs
Message-ID: <rfn57iwagexbshg5akmo54l7un5ypcl6h655ahieyl3iz2oelg@oxv2wc4jcy5d>
References: <20250204155835.161973-1-macroalpha82@gmail.com>
 <20250204155835.161973-3-macroalpha82@gmail.com>
 <173928137017.2164349.13619464947851022064.b4-ty@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ktwyyp6o2yejuhcx"
Content-Disposition: inline
In-Reply-To: <173928137017.2164349.13619464947851022064.b4-ty@kernel.org>
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-1.4.2/239.939.29
X-ZohoMailClient: External


--ktwyyp6o2yejuhcx
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: (subset) [PATCH V2 2/4] mfd: axp20x: AXP717: Add
 AXP717_TS_PIN_CFG to writeable regs
MIME-Version: 1.0

Hello Lee,

On Tue, Feb 11, 2025 at 01:42:50PM +0000, Lee Jones wrote:
> On Tue, 04 Feb 2025 09:58:32 -0600, Chris Morgan wrote:
> > Add AXP717_TS_PIN_CFG (register 0x50) to the table of writeable
> > registers so that the temperature sensor can be configured by the
> > battery driver.
> >=20
> >=20
>=20
> Applied, thanks!
>=20
> [2/4] mfd: axp20x: AXP717: Add AXP717_TS_PIN_CFG to writeable regs
>       commit: ab797d7faf4c28328d2e45b09991f47a9b8e08aa

Patch 3/4 has a dependency on this one. As you probably haven't done
an immutable branch for this one, please also pick up 1/4 and 3/4. I
just provided Acked-by to them.

Greetings,

-- Sebastian

--ktwyyp6o2yejuhcx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAme2aJ4ACgkQ2O7X88g7
+pqiGA//apsm7wetM6jM32dOHwCLK5R4Va7msusAzv+RNpZM1idOpdrhIDmvcCzK
/07fRl4dXLKR6S7lG29vF4e3drh7k3kxKQOjj7NVGuE65nhIa49dgrTyWK2dRPiX
6JiCkk5X6VF2zLwSLA58zwd+1OgCQHFxSFt8vWnPh2VPTrVkx1ktOltR96vsshxe
uvYX/4JupUL/qzXnj+EmqvnSdP5xHbtv0RNrzzOhrnVV0fuDIHvB97oocJ4l+xi+
ssmsrL1CRiR5s395NOCb29mBBA6zaRbdnvI9Qmhf5cJ/tn2Y7VVHDFuQqHk79u25
2B7dGuiJFFmlkF7u4FouO3hAd6pNhjNXXjefHwK/B7dbNeP+OxU6U3et49ck161x
RFxh7LqcmBcRXkHyU/wyidAiIWZbnVWrLv6Nc93B/DuKsR19k6r0iduai8lIDjlM
fbOfFwBevEKP60H+W/RH/Mt4Dd2m90Ft4A3Vb9P0UeZLk2Xs4+nKhOlLg7RSv6rA
JAKUO0GFhXVUfpE/vRCiuWXGHDR+OgS20sQ9y3PZr1iZxdBC/8xXPkI1XZxCqpfo
od6kHyq/jxxV4NLg/NVcm/NgRe8HPhSVxy/MhPmVXNj+ss+dj7FOzHfdGJlATQZE
9VbvEh+2/h1WzZn41HoyXxxf69d3R4+1gswDJR5rv0vjQQc1oeU=
=f4Hj
-----END PGP SIGNATURE-----

--ktwyyp6o2yejuhcx--

