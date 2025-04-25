Return-Path: <linux-pm+bounces-26158-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E402A9BEC9
	for <lists+linux-pm@lfdr.de>; Fri, 25 Apr 2025 08:42:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2434A7B2194
	for <lists+linux-pm@lfdr.de>; Fri, 25 Apr 2025 06:41:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 058B122D4C9;
	Fri, 25 Apr 2025 06:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ucw.cz header.i=@ucw.cz header.b="QDREfgKU"
X-Original-To: linux-pm@vger.kernel.org
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B6221DFDAB
	for <linux-pm@vger.kernel.org>; Fri, 25 Apr 2025 06:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.255.230.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745563331; cv=none; b=M2YwBxCCkkLsjuU3lY7qweu/6N9TW6TP9uAhY52GQ7ZkUAkL15VJl+flmtqqTkYlrqcOmbbICqfHkBQNUgP6FtRrCfcVH5bxL4DP6SgwAX1cdqwdw5y8TQ+y+W0gPG2sRV3OMMDrEnLz5VSSxiEZn9u4Pm/NVh5eTKYNGm/nAto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745563331; c=relaxed/simple;
	bh=u07ziQB0gOCe472oHZlBgh95PrUNFKjWbzfllEGvL+Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E5eneHHC5BKnCwz7bxCx8+I/qlbGmDdiR4pxJc5BK/qVIvR42ANugSDj0uUI+z0SMKv+F+raX2VCK33K/IcLtJ34abvMoK2zXs5Ttj9We+9MMQvRkJPJhnbk0g307wGjNg2p37t3Zlh+MP4fnNKcZUbO2bgT1wYgP2a2OglhnYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ucw.cz; spf=pass smtp.mailfrom=ucw.cz; dkim=pass (1024-bit key) header.d=ucw.cz header.i=@ucw.cz header.b=QDREfgKU; arc=none smtp.client-ip=46.255.230.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ucw.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ucw.cz
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 186361C00B2; Fri, 25 Apr 2025 08:42:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucw.cz; s=gen1;
	t=1745563320;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kxw88W7D8gcMONyJHC/eFWx3XrqRyneoB0C+zC1qabM=;
	b=QDREfgKUJr75yKlQk92ZjtozdKOf9XVykGV6ZWOCLhZmcKgles0ockRi/rWgNAgE0kV7/S
	PhXEsQL01FXF3P3WcgXtgJ+zW4/mSoEmCLSwQCSLWpzvVjxLi+NQc3H5pTpIY14iunO1hk
	xBpnpp6XzooNe/RJbGxISK82YbA67vs=
Date: Fri, 25 Apr 2025 08:41:59 +0200
From: Pavel Machek <pavel@ucw.cz>
To: lijun <lijun01@kylinos.cn>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, len.brown@intel.com,
	linux-pm@vger.kernel.org
Subject: Re: [PATCH] hibernate: add minimum image size in hibernation
Message-ID: <aAsutyDMqqmuwURS@duo.ucw.cz>
References: <5aac0c93-2723-2ca1-cbfa-98f88b0c900c@kylinos.cn>
 <CAJZ5v0iDeC-ieFEzzHP=Dpet5T5ssGRHqW-SvRUoSU4PCLR2Fw@mail.gmail.com>
 <a55a3417634ae3ab546121d77af083cbf4fcdc3f.camel@kylinos.cn>
 <CAJZ5v0how8gMN_mhqosNH4kB9uki2drA8RpdCPJVQVp+Kh70Bg@mail.gmail.com>
 <d2e914982a06fc4886c5f5056291772ec4b73588.camel@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="YOY+Bx5mCjS1Tf8U"
Content-Disposition: inline
In-Reply-To: <d2e914982a06fc4886c5f5056291772ec4b73588.camel@kylinos.cn>


--YOY+Bx5mCjS1Tf8U
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> >From 73ea74f11c4e188b9642eae5ef2e47a9310e97bb Mon Sep 17 00:00:00 2001
> From: Li Jun <lijun01@kylinos.cn>
> Date: Fri, 25 Apr 2025 13:44:23 +0800
> Subject: [PATCH] hibernate: add minimum image size in hibernation
>=20
> When I want to complete S4 in a shorter amount of time,
> so,add this config,and set the config to n,
> the image_size =3D 2/5 * totalram_pages,in hibernate_image_size_init
> PM: Allocated 2908160 kbytes in 0.10 seconds
> PM: Wrote 3000464 kbytes in 4.13 seconds
> PM: Read 3000464 kbytes in 5.67 seconds
>=20
> and set the config to y:
> the image_size =3D 0,in hibernate_image_size_init,
> PM: Allocated 817872 kbytes in 1.76 seconds,
> PM: Wrote 908368 kbytes in 1.16 seconds,
> PM: Read 908368 kbytes in 1.82 seconds,
>=20
> 0.10 + 4.13 + 5.76 =3D 9.99
> 1.76 + 1.16 + 1.82 =3D 4.74
>=20
> Reduced time by 53%, the test is in 8G mem,if the mem is 16G or more,
> this config can reduce more time.
>=20
> the image_size =3D0, just shrink more NR_SLAB_RECLAIMABLE,NR_ACTIVE_ANON,
> NR_INACTIVE_ANON,NR_ACTIVE_FILE,NR_INACTIVE_FILE pages,S4 is still
> normal,so add a shorter time option.

Patch is whitespace damaged.

Plus, this should be runtime option, not Kconfig.

BR,
								Pavel

> Signed-off-by: Li Jun <lijun01@kylinos.cn>
> ---
>  kernel/power/Kconfig | 10 ++++++++++
>  kernel/power/snapshot.c | 6 +++++-
>  2 files changed, 15 insertions(+), 1 deletion(-)
>=20
> diff --git a/kernel/power/Kconfig b/kernel/power/Kconfig
> index 54a623680019..fef014fc31b1 100644
> --- a/kernel/power/Kconfig
> +++ b/kernel/power/Kconfig
> @@ -80,6 +80,16 @@ config HIBERNATION
>  For more information take a look at
> <file:Documentation/power/swsusp.rst>.
> +config MINIMUM_HIBERNATION_IMAGE_SIZE
> + bool "Minimum Hibernation Image Size"
> + depends on HIBERNATION
> + default n
> + help
> + Enable create the smallest image in Hibernation
> + Set image_size =3D 0
> + shrink more temp memory
> + That may can reduces the s4 time.
> +
>  config HIBERNATION_SNAPSHOT_DEV
>  bool "Userspace snapshot device"
>  depends on HIBERNATION
> diff --git a/kernel/power/snapshot.c b/kernel/power/snapshot.c
> index 4e6e24e8b854..dffd5645b875 100644
> --- a/kernel/power/snapshot.c
> +++ b/kernel/power/snapshot.c
> @@ -138,7 +138,11 @@ unsigned long image_size;
>  void __init hibernate_image_size_init(void)
>  {
> - image_size =3D ((totalram_pages() * 2) / 5) * PAGE_SIZE;
> + #ifdef CONFIG_MINIMUM_HIBERNATION_IMAGE_SIZE
> + image_size =3D 0;
> + #else
> + image_size =3D ((totalram_pages() * 2) / 5) * PAGE_SIZE;
> + #endif
>  }
>  /*
> --
> 2.34.1
>=20
>=20

--=20
I don't work for Nazis and criminals, and neither should you.
Boycott Putin, Trump, and Musk!

--YOY+Bx5mCjS1Tf8U
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaAsutwAKCRAw5/Bqldv6
8kgOAKCR4Mgs13BTxLlMyQV6ViCyma0aewCfYvgKbBnSJEH6cUblyQaeQoXIlZ4=
=61F5
-----END PGP SIGNATURE-----

--YOY+Bx5mCjS1Tf8U--

