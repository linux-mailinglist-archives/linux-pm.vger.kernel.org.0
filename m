Return-Path: <linux-pm+bounces-25444-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A786AA89737
	for <lists+linux-pm@lfdr.de>; Tue, 15 Apr 2025 10:55:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 251D91897AF4
	for <lists+linux-pm@lfdr.de>; Tue, 15 Apr 2025 08:55:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7C7C27A913;
	Tue, 15 Apr 2025 08:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gl2fmgtD"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8712824169D;
	Tue, 15 Apr 2025 08:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744707310; cv=none; b=awuMwmb4Afq3G4k7zY2NI/B3BwTaKjTXyxfZF6hLRcQ86AyJs8HsP0sVWFa7J5W4ni96AT7QSrIWE6b1Q85tk2dnBiCavEFOa/WsgoxXaO38B7bYPJ871PqiOx1NNFtW9KUPq3QV6W1+/h6ozV6cZcvav3aVY16am4KeCzuEkFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744707310; c=relaxed/simple;
	bh=vGvpKawwe3gI5yvFnpIT7nHbouJvN4MFyvJyYAkbBsA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u9pUyG+JDBoyFIsvrLV7zaXkxvvNcyShSoDQC+AM8SUb3QdBZsonjl00tVKl7WcvBZQ4yvbtOY3C6HmFvTcK60/0eQQQ+ZjO0wDwhGsTJNXjbjHrIwdMmbR+RhD46zzmRVzX/K81/gIXHHxrWL781PGuieNK3gko/dcQ0RFAwiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gl2fmgtD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A690C4CEDD;
	Tue, 15 Apr 2025 08:55:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744707310;
	bh=vGvpKawwe3gI5yvFnpIT7nHbouJvN4MFyvJyYAkbBsA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Gl2fmgtD+ZSCoo67x4oHR2ZYoD3QcZhpyCGP8Scecgr+Fp/lHASgEDumO10W8Dv7O
	 035vsmJvbj5Vg0UD6MiI5xbxLNRWG+0xtq95m2U5Nyb5W6WaMbcwSgaftRmdcwOeW6
	 EhbsZt3RYI3vrz4Q95FvtyS6Z/t1USGZrynKrZCnjbs7pM5TXTPMgDNKOncboH6VfA
	 JLRWFKbZVKfARUb+bFqM652yrz+KDihgB9912fHs0nR8W7kFQ6dOygjGDcnX/YPilC
	 ZHfvb6jjjgjsVCqqN13FHowyIaqHtc5C2UU7fs+U1STPxyOfF626j8WooeXh1jJ/KT
	 /d7UI6axfZbHQ==
Date: Tue, 15 Apr 2025 10:55:07 +0200
From: Maxime Ripard <mripard@kernel.org>
To: Michal Wilczynski <m.wilczynski@samsung.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, Pavel Machek <pavel@kernel.org>, Drew Fustini <drew@pdp7.com>, 
	Guo Ren <guoren@kernel.org>, Fu Wei <wefu@redhat.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Ulf Hansson <ulf.hansson@linaro.org>, Philipp Zabel <p.zabel@pengutronix.de>, 
	Frank Binns <frank.binns@imgtec.com>, Matt Coster <matt.coster@imgtec.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, m.szyprowski@samsung.com, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux-riscv@lists.infradead.org, 
	devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v2 4/4] drm/imagination: Skip clocks if platform PM
 manages resources
Message-ID: <20250415-poetic-magenta-cicada-9d1ee7@houat>
References: <20250414-apr_14_for_sending-v2-0-70c5af2af96c@samsung.com>
 <CGME20250414185317eucas1p139284a38dc4418ac90bd081c2825142a@eucas1p1.samsung.com>
 <20250414-apr_14_for_sending-v2-4-70c5af2af96c@samsung.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="dpgfk2bi35c7deux"
Content-Disposition: inline
In-Reply-To: <20250414-apr_14_for_sending-v2-4-70c5af2af96c@samsung.com>


--dpgfk2bi35c7deux
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2 4/4] drm/imagination: Skip clocks if platform PM
 manages resources
MIME-Version: 1.0

On Mon, Apr 14, 2025 at 08:52:58PM +0200, Michal Wilczynski wrote:
> Update the Imagination PVR driver to skip clock management during
> initialization if the platform PM has indicated that it manages platform
> resources.
>=20
> This is necessary for platforms like the T-HEAD TH1520, where the GPU's
> clocks and resets are managed via a PM domain, and should not be
> manipulated directly by the GPU driver.
>=20
> Signed-off-by: Michal Wilczynski <m.wilczynski@samsung.com>
> ---
>  drivers/gpu/drm/imagination/pvr_device.c | 14 ++++++++++----
>  1 file changed, 10 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/imagination/pvr_device.c b/drivers/gpu/drm/i=
magination/pvr_device.c
> index 1704c0268589bdeb65fa6535f9ec63182b0a3e94..f40468b99cf14da418aeecde0=
86f009695ff877c 100644
> --- a/drivers/gpu/drm/imagination/pvr_device.c
> +++ b/drivers/gpu/drm/imagination/pvr_device.c
> @@ -504,10 +504,16 @@ pvr_device_init(struct pvr_device *pvr_dev)
>  	if (err)
>  		return err;
> =20
> -	/* Enable and initialize clocks required for the device to operate. */
> -	err =3D pvr_device_clk_init(pvr_dev);
> -	if (err)
> -		return err;
> +	/*
> +	 * Only initialize clocks if they are not managed by the platform's
> +	 * PM domain.
> +	 */
> +	if (!device_platform_resources_pm_managed(dev)) {
> +		/* Enable and initialize clocks required for the device to operate. */
> +		err =3D pvr_device_clk_init(pvr_dev);
> +		if (err)
> +			return err;
> +	}

So, how does that work for devfreq? I can understand the rationale for
resets and the sys clock, but the core clock at least should really be
handled by the driver.

Maxime

--dpgfk2bi35c7deux
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCZ/4e6gAKCRDj7w1vZxhR
xeTeAQDBOrkzTJtdQ3A1rnkjHNj0lVxM4Ty8cZ/N6If/1qYvgAD/S8+uTDIzPSNF
nUiSeauW8K+11TmEGBs2o10AHNMK4wY=
=lBeR
-----END PGP SIGNATURE-----

--dpgfk2bi35c7deux--

