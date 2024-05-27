Return-Path: <linux-pm+bounces-8194-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E98C8D0EC1
	for <lists+linux-pm@lfdr.de>; Mon, 27 May 2024 22:45:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 601F41C20FDC
	for <lists+linux-pm@lfdr.de>; Mon, 27 May 2024 20:45:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37948161310;
	Mon, 27 May 2024 20:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="dPhC7dwj"
X-Original-To: linux-pm@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABA1B17E8FC
	for <linux-pm@vger.kernel.org>; Mon, 27 May 2024 20:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716842701; cv=none; b=Bv8rDWUug4xZhXABsiVpkBbnwwyh3e8ZPtQoRFj9E1OHdZZDfEh6wd/zMgUieleL/mf3mv+evaIdQlSJ2fVPmP8duow1Y+V6HXVcsYcoJQ0gWHG51T+kZuRPG/V/PPZoXUFg4RmD6qNEQj5V2NhBJiQWnZc4C9T+F1715Jyo+Qk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716842701; c=relaxed/simple;
	bh=EbJXjXLgtAqajCl9QciWrE0s/GaHpwlYatkQ9jIbBaI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=He6d9GNrDJtDxvrKjAA8S9HWKmzuROgkaomvj5dfoBX1EhRpvpiuJTkRtKwyrVl+nhY8VcPS3D/QJJlkLOw2+IupjkEjb9hjwGzrqRrpb/CeBORb1BJDxlnAhafsX0TsXNZI5jmAQQRmEc5GSq4CRiXePuLGPwdgCQK+zeuJ0fc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=dPhC7dwj; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1716842697;
	bh=EbJXjXLgtAqajCl9QciWrE0s/GaHpwlYatkQ9jIbBaI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dPhC7dwjOMSEyKjmTIso15BLCdhMsoOgMEVo+eUwirUwuI/zZkXLoBdIvN0OaHjDd
	 8OoK98b4YdLkiFfhXggawV0HhDdffvmRjy3UixYViczlWGoYjF6TqyA9aq9Eeszgek
	 GSQFtrfEQdgMW/p68ZtxxHzRo4JJl74g8LuRoizD3BFg+3DSEV7sG9CtgK1eVmvBWM
	 GeswAc+yepQMFI0I3bl2QqP/cZWrymHvZKfd7aNnGVmQ5vtqMt+2J8dxs/kJclklz2
	 5CJdQiqGJXiw/jJBvOtB1aAbpBSg2Fw5RSreOdc6pa93LvSztp8OSQcwqueO4fPZQp
	 63JahbP6wsP5Q==
Received: from mercury (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: sre)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id D425E3781116;
	Mon, 27 May 2024 20:44:57 +0000 (UTC)
Received: by mercury (Postfix, from userid 1000)
	id 562C810612B3; Mon, 27 May 2024 22:44:57 +0200 (CEST)
Date: Mon, 27 May 2024 22:44:57 +0200
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Dzmitry Sankouski <dsankouski@gmail.com>
Cc: linux-pm@vger.kernel.org
Subject: Re: Should I add INPUT_CURRENT_NOW attribute in power_supply.h?
Message-ID: <uzx7cfmjqttwrkzwhb5ptvpaetu3bbnhs2wsj6rh2edxlb4rar@27dr6ewobale>
References: <CABTCjFCPRkd80DOWozhWAZa6UrEcbf1ZgTLXqsMjC5G_BEnAjA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="d6ba7tvy5ugyztnp"
Content-Disposition: inline
In-Reply-To: <CABTCjFCPRkd80DOWozhWAZa6UrEcbf1ZgTLXqsMjC5G_BEnAjA@mail.gmail.com>


--d6ba7tvy5ugyztnp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Apr 16, 2024 at 05:02:26PM +0300, Dzmitry Sankouski wrote:
> Charge ICs typically can measure actual input current.
> For example, bq25710 has ADCIINCMPIN register,
> which holds input current measurement.
> power_supply.h has INPUT_CURRENT_LIMIT attribute, but
> it's said to be for `current limit programmed by charger`, i.e. not measu=
red.
>=20
> So should I add a new attribute for input current measurement?
> If not, what's the correct way to provide actual charger input current
> to userspace?

See "current_now" for "USB" in

https://www.kernel.org/doc/Documentation/ABI/testing/sysfs-class-power

Note, that IBUS is the USB bus current, which is the input side of a
USB based battery charger.

-- Sebastian

--d6ba7tvy5ugyztnp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmZU8MkACgkQ2O7X88g7
+pqSBg/+LrB1xEeh0DY8xW7HewH3BKwstNIuiTl+6WjIKApagp29chS7/q3v3SsR
t+7Sv3fVvglYF4rr0FBAp/XVO+qV2/fwYVM7dxibPIBD5RVfhyDiyNUDb7/dzSM+
h3eiO0fqZGMI1/8saaMNWdAEVbOVlvXvxwfYR7Jvg8CFdfydrjCLIe72pLJrfndX
7hO629xAgeTuB+Nrz9Wr/qwQ6JktLh3qkqChNrb/LrxOljZLRpDu3zD8rhOzUP0f
hgGeFNdyvxGK7ZUBBCCc+KeD2orWzR3gH+slgVyc+AP3kVa9j0U7hylJkHmIaSQX
nUgtjo3Rg2+pMg9VfvmpCVB5j7iaDxsOq6eCsh+EmAantzXVGDLFcI+FGJ/981hi
SBCtC1842Y5288KUaAw9qc1iBYBUpL/Ygyfc5TMkUwvNyUkpOHCeV5Xl6V1ZFGdq
ScN8JBPw4ajfnh89A/PJ/JQpmkOThUkTYwqJ0Wd3ZKbUvwBY6oTXN3ji2TF50viF
8tHCl/XayC4ZzohdMaqR3SW01sHyw18O2sx1qvUEs779oZDLQ+e9uQfOKT/rUq1V
uz+qeIz9T8ei8H0pzXkmdqi9r1PE0FuLsgdQ3Z1yPNPZeYof5X+AdBFdR9pk1klq
/iXcnJIvC+8pLUxTpp3YCEawemsv1aGcd99iakfNWyk8arlBMjY=
=nIAL
-----END PGP SIGNATURE-----

--d6ba7tvy5ugyztnp--

