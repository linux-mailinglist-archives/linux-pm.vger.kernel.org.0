Return-Path: <linux-pm+bounces-34741-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C77A5B59EBD
	for <lists+linux-pm@lfdr.de>; Tue, 16 Sep 2025 19:04:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0878A582CE9
	for <lists+linux-pm@lfdr.de>; Tue, 16 Sep 2025 17:01:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4B452F5A17;
	Tue, 16 Sep 2025 16:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b="FhD3smbx"
X-Original-To: linux-pm@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00FA132D5D7;
	Tue, 16 Sep 2025 16:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758041964; cv=pass; b=Sj9GaDTgj7YBlw80rIXGsn/6HfNcDlMSU0W10jaC91cm2pUUdUWJwcwIpj683616TYhQmjzDBi/66oBlt10dJwmD6kIg0b6B7W9/UJBat13Ysy9pz6yBTRSwFJOZ3FNXRKVzXRopdX9Bt4AzcGOS+Wkur0377QlRsgwcQhRUUiM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758041964; c=relaxed/simple;
	bh=BFapEZR7pLvRKQtMme0T8FJgGqNk+b5ibCXvTJHCk0A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aswJgm77YI3Mt/M0QoStn5RexrtoQaiJtuV4SX9z0ZQ7ROMBg7O9aRjmWDIS+4yj42xDsh7GlAWTUkRQE0Jj6JuJ52xxU9O5gT6JQfZOehVVkSRbZClUgX/wc9hG4bG//+JME3ioDIt4gCkYqImIefuXzuQHwHaUexxhG6UxJrU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b=FhD3smbx; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1758041956; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=ZZ0SjVIzPYCJPUMIv0mkGc/PdOQwwgsBzvVNKyAWwP2a/W3w6duOmRvspsiY/KjAVEGK3LBhKiBvRqeC81esltXLBS0uNUyIXq5xR7+a+YXN0eFJuzJnOLEw9I8EmIEX0NTXTu0Aa0md7lK7WFtcEaAD7a2GPPQKMlESMdgOfRQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1758041956; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=YMjpeCVb969PSdBMAhTwISsWBnqQEgSO6YXUyj0ox1o=; 
	b=L1vobNcpcri3sP68MsM8hr/gd6CAFb/9KDgSd9MEWHIFekiPFOuXsJihYZZoJxzElnfncfDmS+4jsG/qZzLLCitMqRJMj72SSc2+JtR98CFXXACkeoIQI2S76w9N4JCcZ6OG/Nf8jLOYNoH5Ch3BKPeelzafmkc7qI/BHdm6Zvc=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=sebastian.reichel@collabora.com;
	dmarc=pass header.from=<sebastian.reichel@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1758041956;
	s=zohomail; d=collabora.com; i=sebastian.reichel@collabora.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
	bh=YMjpeCVb969PSdBMAhTwISsWBnqQEgSO6YXUyj0ox1o=;
	b=FhD3smbxZTuRE7Qlf5AApxW9DtW5dB9wEib1P7UfXeiY4hcom9+jah3cyQESNXGM
	k37QU4j9PiW6/AgMRpoZIXi0Ehp0Lngvm20Sk/C4GumX78WcDA/ibZJtwyNWBHvRQi6
	m7gOvNkm87OKnmv9BF334t3y7hyC6vL8B1V253T8=
Received: by mx.zohomail.com with SMTPS id 1758041954603314.0056103351336;
	Tue, 16 Sep 2025 09:59:14 -0700 (PDT)
Received: by venus (Postfix, from userid 1000)
	id 98B7E180733; Tue, 16 Sep 2025 18:59:03 +0200 (CEST)
Date: Tue, 16 Sep 2025 18:59:03 +0200
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-pm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 0/1] dt-bindings: power: supply: bq24190: document
 charge enable pin
Message-ID: <km7thoeguhkdp23gatn3w4kibgazzxi7s3cbkhueuokychqcbq@nabzlmfg3dmi>
References: <20250912065146.28059-1-clamor95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="jsjxjam7qlnfhjfv"
Content-Disposition: inline
In-Reply-To: <20250912065146.28059-1-clamor95@gmail.com>
X-Zoho-Virus-Status: 1
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-1.4.3/258.4.7
X-ZohoMailClient: External


--jsjxjam7qlnfhjfv
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v1 0/1] dt-bindings: power: supply: bq24190: document
 charge enable pin
MIME-Version: 1.0

Hi,

On Fri, Sep 12, 2025 at 09:51:45AM +0300, Svyatoslav Ryhel wrote:
> Document active low Charge Enable pin. Battery charging is enabled when
> REG01[5:4] =3D 01 and CE pin =3D Low. CE pin must be pulled high or low.
>=20
> Svyatoslav Ryhel (1):
>   dt-bindings: power: supply: bq24190: document charge enable pin
>=20
>  Documentation/devicetree/bindings/power/supply/bq24190.yaml | 6 ++++++
>  1 file changed, 6 insertions(+)

No driver change?

Greetings,

-- Sebastian

--jsjxjam7qlnfhjfv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmjJl1cACgkQ2O7X88g7
+pqzGA//XxqUyw5jYxT0uD4bpHiIMEA6rqkwQfHGBsEHgX0htoOkYGbbAAB2Sj/I
CasgAwv0mLdvdcxrXINxP7dtimKHGgO+HWClgvhAcreDED2EznPevkXIBea7QDoU
Cjgd2TCNdRfdNL4d46DXsPjWb/4MJJ+fYQsoYk8nl8n+Oza5BNfNGL6HteB1QnrJ
LgAujfff+WO2RwpqPESCP+wRwH0p/IcYxv0/A26WrvYDd1H94enTuKMAPQ5jlrtj
/6/InNeO8wsXyXDEgMMvtttxU96064NoETPicB2ylkMWf3ZjsNlKvrLsmTQcaxPV
7OUmpe6OhdzP37rpoMeHjCpYyJYCcK/mGyJAtZ4WvZ4AD03joM/FqcxO0xVUk7mU
Ikdl6+yDgnZs7mf2plq9eOKfZHRbVjlt6pS1hD+S3/TGBKhlzB3wlahhZVm30TVD
NIhVlwzmDUMEj2DRjh00GCb+7uNfsZiJlNqwbzWx9bsMw/ATLIqWmVwkGj9Awbgt
fjzC/aOvVXXANVT47Vyg/xyrBN7p5swLUg2p5Zn8m9/zDzciBor9jCE9bQ6E26HF
ShrTaNFNbz9+p/GGU2yrXsDSPpPdhJXBqUXQ9PzXFhPbZ7JnnkCeAbOtBYhh4p8l
UcPhET+6014FhEx+gXn6ZA8VZ7EkMbXsUghW0wYo/GAQcg8ujCA=
=oJ1Z
-----END PGP SIGNATURE-----

--jsjxjam7qlnfhjfv--

