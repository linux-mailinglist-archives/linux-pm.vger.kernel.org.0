Return-Path: <linux-pm+bounces-8507-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B33F78D78F1
	for <lists+linux-pm@lfdr.de>; Mon,  3 Jun 2024 00:59:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 696D11F2123D
	for <lists+linux-pm@lfdr.de>; Sun,  2 Jun 2024 22:59:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE79355880;
	Sun,  2 Jun 2024 22:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="Xt5lKAa2"
X-Original-To: linux-pm@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29005364A0;
	Sun,  2 Jun 2024 22:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717369182; cv=none; b=uMlj60pGs3vHEOtccBClahwSUzsu6qpgiLLKIVvrhKftKQy/IWCE7i44pqLpEeVmgk20JVk+pAFEQnQXHUs403L7cFNlxH3NEPjeR54TkNwUMqDiMy4SPoe6mB3audwTWEqg9YBZfE0TXAuhDaKquogkLr0945GnYqkVY/5W8GU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717369182; c=relaxed/simple;
	bh=yZcI6Fr8DY8YGyk+xlFWtHSX7RVfsv9IYwtg1aNm3Dk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RES2nGOW5ZRGBMfrxmThWVhD9YD98GmveiRoroPSSW6kHyiwK+o6dYLhRYPNBETff4NfU8NjFD1nUyrtKDj+WNfHFmqkeWdyEFhsHBpJZj1MWSCpiP9g00LXwhjwH//Y6Nm6LWdo1hQxETiayaQly8saacAzZnEWiW6HkkBR7mM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=Xt5lKAa2; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1717369179;
	bh=yZcI6Fr8DY8YGyk+xlFWtHSX7RVfsv9IYwtg1aNm3Dk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Xt5lKAa2N3tMMEZAl/UW+f8Y9W7VPr9vSsAoFdDCvYdq7/7ONk+5XwqPQQZPY0ot6
	 5JRK43JEAp+dK+V8rndrKJk+I+TZp51YC4b0XStY+NlFZNQSMHsilaapsMrc3HTn4N
	 kJoiaCyqWwwkqVeR8koopAbzsC+KCq8pSecRJpdMRezPtF6j6pPiLEsMK9pkV04rMY
	 TSw0Sv82U+xAPsfe64NT84roQmjr8zEloSbBU92/+ciGrQLEmCQFst39g1blURMM/S
	 uC250+2l0nJg0QgYl9UgqsR9pnXHVWBlRhuoqJ1TN798kf2Nbi2t2NfWSth3ST03tY
	 akWNdkKgI/NuA==
Received: from mercury (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: sre)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 517FE3781116;
	Sun,  2 Jun 2024 22:59:39 +0000 (UTC)
Received: by mercury (Postfix, from userid 1000)
	id BA19B10611D2; Mon, 03 Jun 2024 00:59:38 +0200 (CEST)
Date: Mon, 3 Jun 2024 00:59:38 +0200
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org, 
	linux-pm@vger.kernel.org
Subject: Re: [PATCH 2/2] power: supply: samsung-sdi-battery: Constify struct
 power_supply_maintenance_charge_table
Message-ID: <dgkqcnvnrw3sxzojjsteqpudf4sfjhsd6ifvwzn7murxeajs4w@2qededvny4vy>
References: <cover.1717253900.git.christophe.jaillet@wanadoo.fr>
 <02c6ad69a3ace192c9d609b7336a681a8fc7ba94.1717253900.git.christophe.jaillet@wanadoo.fr>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="3s5fgqs6cwwgl5ak"
Content-Disposition: inline
In-Reply-To: <02c6ad69a3ace192c9d609b7336a681a8fc7ba94.1717253900.git.christophe.jaillet@wanadoo.fr>


--3s5fgqs6cwwgl5ak
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Sat, Jun 01, 2024 at 05:00:29PM +0200, Christophe JAILLET wrote:
> 'struct power_supply_maintenance_charge_table' is not modified in this
> driver.
>=20
> Constifying this structure moves some data to a read-only section, so
> increase overall security.
>=20
> In order to do it, some code also needs to be adjusted to this new const
> qualifier.
>=20
> On a x86_64, with allmodconfig:
> Before:
> =3D=3D=3D=3D=3D=3D
> $ size drivers/power/supply/samsung-sdi-battery.o
>    text	   data	    bss	    dec	    hex	filename
>    4055	   4584	      0	   8639	   21bf	drivers/power/supply/samsung-sdi-=
battery.o
>=20
> After:
> =3D=3D=3D=3D=3D
> $ size drivers/power/supply/samsung-sdi-battery.o
>    text	   data	    bss	    dec	    hex	filename
>    4087	   4552	      0	   8639	   21bf	drivers/power/supply/samsung-sdi-=
battery.o
>=20
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
> Compile tested-only
> ---

Looks like that compile testing did not include ab8500_chargalg :)
Fixing the error reported by the Intel bot should be trivial (i.e.
add another const). When you send a new version, please also Cc
Linus Walleij <linus.walleij@linaro.org>.

Thanks for your patches and greetings,

-- Sebastian

--3s5fgqs6cwwgl5ak
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmZc+VMACgkQ2O7X88g7
+pqjYhAAhWSnuCwUT8O+ov/tnAB82dz8t+GhKdxleL0ha+zqLdnA5j21cbUVOULS
TRbokpnIOF5CHcoOYxsWCrKwM3vZvQ9ptLNCtCxe4+c7S13gfahv5UDYNzCyL2dF
Z+9Ta5Lf2okzv/qsw+FO4uAcVhrUz2PpZ72BDsWBYWqWlHjd/vCGrTZ5kjwknHIz
tbC2ql/YVQPcPau9ZAM5aOjeiDQqc+QL8e9D8aGAGokoWwx1LqW1AO7H+xUEb8XX
NM7v+pOercZXQdC4hoMHwFdkyotJYRAZQ4TdRtfMC9Itt83dPzERoMKirQWtDsIG
FuXfuQN4fAQH6S2vix1gkoaQjL3pHiVmay/ujUcLYA/iYVvC2u3nCwqcig/KDHFT
3zaLdrs7L3WVeLlMVVYxuJ9JPzR2HEk+cBQrkn3ijf82VI+JzpdnABpAN2eydEuH
uzOTZZXHDRoRL6rqLHEa+rFWY8Do3PiaHGWZSiWyCt1BahgDGd0jT3ElJ2IAJr8T
7YXNxqGB6UujJGiO6CEiY96u0cQMeAuDx4mtxSgihIiAOyiHD3nwk3jDCeXIqfsT
bHKdnCJg0IjgQE8l3F7ew69iZPT7vHp9vxeED4boWcCeqkCD4ARZF1jiNsLT7p8Q
KNhOHFVm93cOmENyRPKoRDFwThz+ZA5G9v4EECP9Bo0ayvcyPvA=
=z3Sd
-----END PGP SIGNATURE-----

--3s5fgqs6cwwgl5ak--

