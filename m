Return-Path: <linux-pm+bounces-23370-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B4816A4E196
	for <lists+linux-pm@lfdr.de>; Tue,  4 Mar 2025 15:47:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D70C3A8C29
	for <lists+linux-pm@lfdr.de>; Tue,  4 Mar 2025 14:33:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3E232627F5;
	Tue,  4 Mar 2025 14:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b="ULFskclw"
X-Original-To: linux-pm@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDA7F26157F;
	Tue,  4 Mar 2025 14:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741098719; cv=pass; b=PAwJ5mYA9xNN/GQkPy0wYgaTK8+LTaVAvnpSODSlFv/YbLY8W8DzackewrwwfNx8PC/GirbGk0OWpFqWQBssNMonsg94kZUEK/746WiNlq/rxInsnuvwMzScBNd4tlqsnlA6cdgwalI/6Cw8VPOrFeWStqfBSZEQEPykt4DXivQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741098719; c=relaxed/simple;
	bh=C5fdCffFI+4OEo9H68+Ik5QYXGMpqzIZq8TCvbL02Zw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MlKBrTEz3u8zGV9YHCB1JcyHQRQgSQNQIQT5BIShW3CS5adydZGQMOlVcPM5O0FHk5cXsQmJMtfGy5TDSllmogbDcmbNp1M7ImXCTNVJtSMnhe7QwlRDcmFHeI8v6cFaxLeV2yA2H/XqCQU76P5OoY69u146J987MSXZfMWgS1g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b=ULFskclw; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1741098703; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=mAce3bRInugDhWPhCQM6C2uCziq19ilL7/e+dDW2/FGcV1jAnkWk4bEkVhEqALuAwIKUQaz283m1L6+GjNg7wGKM/uLr6E+GmAow3mmPtDa0ZgSRfN9ymqKS30YZ8AGCmJr2RuWWgd8wjvsHdhmBFyY0T91/QvIe3g8dYbJP4AQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1741098703; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=tTAodclUAdCBU382l20ItnjkDcvqqEPMOb0qAu5ypcA=; 
	b=Ihw5XlebV4G1xS/82TskIdALZ4f96MvsX6Qv1UmpB9tv/KyoKguhA+XkF/1QMufniyDdE93wgk/eIuvDnjR6D1YtiiCnJ42kddUTNNAhMHmMaLA94SRyyGqz/S2hLW6XmBsdXKQqLxDW9PmgC5xtmKV/QlfvUFVP7YaqrubOHcE=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=sebastian.reichel@collabora.com;
	dmarc=pass header.from=<sebastian.reichel@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1741098703;
	s=zohomail; d=collabora.com; i=sebastian.reichel@collabora.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
	bh=tTAodclUAdCBU382l20ItnjkDcvqqEPMOb0qAu5ypcA=;
	b=ULFskclwdgD84orDTDoYs2GbQMrFcN9IYWZlXv6GhiNxCMwrTweCDIby6f9Pw5PJ
	Sc7NsYDgv8wk0GOQRn40+TOKILmhGITxhPaBgTLDybhMyj2+NFPkeXOVi1rUcGnUNB0
	sF1qb5Z03fHMYAxI+Ugu1YrvPgvCd/7yX4yiFB0U=
Received: by mx.zohomail.com with SMTPS id 1741098701479811.0457773113028;
	Tue, 4 Mar 2025 06:31:41 -0800 (PST)
Received: by venus (Postfix, from userid 1000)
	id EB4EE180C9F; Tue, 04 Mar 2025 15:31:37 +0100 (CET)
Date: Tue, 4 Mar 2025 15:31:37 +0100
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Arnd Bergmann <arnd@kernel.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Heiko Stuebner <heiko@sntech.de>, 
	Arnd Bergmann <arnd@arndb.de>, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pmdomain: rockchip: add regulator dependency
Message-ID: <2g5p6ucwp55zuisupqx6dglikmbm5rqy3yl34mqobs3giucfqe@um6uhmglxhex>
References: <20250304142803.689201-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="6ftr5rqzgjozmvlj"
Content-Disposition: inline
In-Reply-To: <20250304142803.689201-1-arnd@kernel.org>
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-1.4.2/241.78.79
X-ZohoMailClient: External


--6ftr5rqzgjozmvlj
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] pmdomain: rockchip: add regulator dependency
MIME-Version: 1.0

Hi,

On Tue, Mar 04, 2025 at 03:27:59PM +0100, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
>=20
> When CONFIG_REGULATOR is disabled, this pmdomain driver fails to build:
>=20
> drivers/pmdomain/rockchip/pm-domains.c:653:30: error: implicit declaratio=
n of function 'devm_of_regulator_get'; did you mean 'devm_regulator_get'? [=
-Wimplicit-function-declaration]
>   653 |                 pd->supply =3D devm_of_regulator_get(pmu->dev, pd=
->node, "domain");
>       |                              ^~~~~~~~~~~~~~~~~~~~~
>       |                              devm_regulator_get
> drivers/pmdomain/rockchip/pm-domains.c:653:28: error: assignment to 'stru=
ct regulator *' from 'int' makes pointer from integer without a cast [-Wint=
-conversion]
>   653 |                 pd->supply =3D devm_of_regulator_get(pmu->dev, pd=
->node, "domain");
>       |                            ^
>=20
> Add a Kconfig dependency.
>=20
> Fixes: db6df2e3fc16 ("pmdomain: rockchip: add regulator support")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---

Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.com>

-- Sebastian

>  drivers/pmdomain/rockchip/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/drivers/pmdomain/rockchip/Kconfig b/drivers/pmdomain/rockchi=
p/Kconfig
> index 7e4f9b628f0b..218d43186e5b 100644
> --- a/drivers/pmdomain/rockchip/Kconfig
> +++ b/drivers/pmdomain/rockchip/Kconfig
> @@ -5,6 +5,7 @@ config ROCKCHIP_PM_DOMAINS
>  	bool "Rockchip generic power domain"
>  	depends on PM
>  	depends on HAVE_ARM_SMCCC_DISCOVERY
> +	depends on REGULATOR
>  	select PM_GENERIC_DOMAINS
>  	help
>  	  Say y here to enable power domain support.
> --=20
> 2.39.5
>=20

--6ftr5rqzgjozmvlj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmfHDsEACgkQ2O7X88g7
+pp00g//aFcPbqAlUT+9ssFVmS1DZnzPVKvIpP2qpRgf3ZLhdIUUE/9ljAKaBhsB
ibrwuSsht4nUebBiL/Ge9191zcdE/kG+oBIaOeUpRfUI1fVI5V501LzHoJAX9QJM
nezzvh8SUWeoerVK2faqPrap0HJ/u/vkhoOpiUBoSBOOaD438GhSPbgAGV7SBH5L
8dtv0H9PbRg0bjMWaSrUptVZKH1aOgew/ik30jvwDzXRJYGx/86Zzh4h8ryCh4LO
lfwPZ72cq5QbpagWvO2rCznJrntpdWITqzCJ0Tg+OEjRhhcpDfSpI16krVIfFK37
lFDhuK9/4VnA8PRmt92pDU2AfNMpUa8O1narQGFGsFTvG8ad9/h5xwxLVq9DMB5F
r5D8Ild2hkvI1mkm1zj5Ur0aSN9p8kX91gbN5+cblCFw3GQPSRVBCe9iYQMWKOYI
fJm46Nw4D6pbfMGAl4N4gxBwZsCUbFzVU60cqnUSDyVYVET+5sennBGpX9k/AKfk
DBoG2efxxd0x34sq6orYAjL0+E0FLw+T/bfgcVwF6XOv6jJfYPPB7YVWREGR7EzQ
t2ybqCXnUQIpyHe/cYSjJzcgYmfn4I5VlWhjsK5Zw4F6hSPAaDPiskS8PMqTDBGx
GwR5n9e77eX49YHCd6frUZTZycygRe8J+vB77/bkFd1LcUNlcZI=
=86c8
-----END PGP SIGNATURE-----

--6ftr5rqzgjozmvlj--

