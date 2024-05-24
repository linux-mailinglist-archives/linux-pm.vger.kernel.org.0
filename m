Return-Path: <linux-pm+bounces-8114-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1326B8CE971
	for <lists+linux-pm@lfdr.de>; Fri, 24 May 2024 20:24:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 960CD282E34
	for <lists+linux-pm@lfdr.de>; Fri, 24 May 2024 18:24:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FB923BBF4;
	Fri, 24 May 2024 18:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RODCe2Rf"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA1403FB81;
	Fri, 24 May 2024 18:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716575093; cv=none; b=JbmhcUcPVe2/oGPjewxEls7OqhZki96pVrZGr4CFAJ9mE7ZdM795cQJVq1YXl3VGsriR8wLAZTcdVl+2hIqhyFnXutrKOXnSJypPFb9GTakR7KQug+lzhLilNygdqyYOs4oAuiYmYA1uXSwqIOm6A/wvAeIQTWm1r2YHRSxQvVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716575093; c=relaxed/simple;
	bh=dQAvYzPorRE89EfGzh8i8K3dM861qHxxGaH5yINN8yM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p/DQYLAjzsPXNjHBxKZ+r3lcKBqGRW9df5Lkhm2S8fZI8btoEeUkJBrylZNa4pl5TNMmMv/QqJcj3XEyLp1QfKuhIYs7ctXkG8U336hbAoAIAI01GW1eU2JFkzAKno8Y8HW3Sjp3gG/LeiIyRUb/VZ93sziwoqKQz/l2Pf8M7CM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RODCe2Rf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73617C2BBFC;
	Fri, 24 May 2024 18:24:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716575092;
	bh=dQAvYzPorRE89EfGzh8i8K3dM861qHxxGaH5yINN8yM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RODCe2RfnalsYZlh1raT+J+hlOnLKlOLEFrU7ogy/+lfPkotL0bgKTRXyLc2FoP3r
	 KCJc47bVnKinr+kCpFO8Mtxpgq/dfHFHQGW16zuKMfWb8sbwrp0g4wq0lG0PpdBDiQ
	 K4coGuPcmP6wvWvTBwI+r40PcDOSAlPp9ypel1extK4lbio6uzHn+rs2hjY2TYsaOv
	 HrrfQczEa9KWhAf8JDDCSIYucYKGdawj5OM0BBE82WFtta3pCGxkRJkBQLKYTURsAe
	 MzaloccbeQboBAUqo3q8PkfLkwrikEf/qgyYa2QhAOADreidlipc1uTLUGJHDnpTF1
	 yqGpHAB2pOwbQ==
Date: Fri, 24 May 2024 19:24:47 +0100
From: Conor Dooley <conor@kernel.org>
To: Julien Panis <jpanis@baylibre.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Nicolas Pitre <npitre@baylibre.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v5 1/6] dt-bindings: thermal: mediatek: Rename thermal
 zone definitions for MT8186 and MT8188
Message-ID: <20240524-concerned-fritter-262f5e16293e@spud>
References: <20240524-mtk-thermal-mt818x-dtsi-v5-0-56f8579820e7@baylibre.com>
 <20240524-mtk-thermal-mt818x-dtsi-v5-1-56f8579820e7@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="nUnx8yrvH8DVkbj0"
Content-Disposition: inline
In-Reply-To: <20240524-mtk-thermal-mt818x-dtsi-v5-1-56f8579820e7@baylibre.com>


--nUnx8yrvH8DVkbj0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 24, 2024 at 11:04:34AM +0200, Julien Panis wrote:
> Use thermal zone names that make more sense.
>=20
> Signed-off-by: Julien Panis <jpanis@baylibre.com>

Removing the defines is an ABI break. If these are all the same devices,
but with more accurate naming, then keep the old defines and add new
ones. However, the GPU1 define changes in the course of this patch which
is more problematic.

Why do these names even make more sense? Where did the old names come
=66rom and where do the new?

Thanks,
Conor.

> ---
>  include/dt-bindings/thermal/mediatek,lvts-thermal.h | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>=20
> diff --git a/include/dt-bindings/thermal/mediatek,lvts-thermal.h b/includ=
e/dt-bindings/thermal/mediatek,lvts-thermal.h
> index bf95309d2525..ddc7302a510a 100644
> --- a/include/dt-bindings/thermal/mediatek,lvts-thermal.h
> +++ b/include/dt-bindings/thermal/mediatek,lvts-thermal.h
> @@ -24,7 +24,7 @@
>  #define MT8186_BIG_CPU1	5
>  #define MT8186_NNA		6
>  #define MT8186_ADSP		7
> -#define MT8186_MFG		8
> +#define MT8186_GPU		8
> =20
>  #define MT8188_MCU_LITTLE_CPU0	0
>  #define MT8188_MCU_LITTLE_CPU1	1
> @@ -34,11 +34,11 @@
>  #define MT8188_MCU_BIG_CPU1	5
> =20
>  #define MT8188_AP_APU		0
> -#define MT8188_AP_GPU1		1
> -#define MT8188_AP_GPU2		2
> -#define MT8188_AP_SOC1		3
> -#define MT8188_AP_SOC2		4
> -#define MT8188_AP_SOC3		5
> +#define MT8188_AP_GPU0		1
> +#define MT8188_AP_GPU1		2
> +#define MT8188_AP_ADSP		3
> +#define MT8188_AP_VDO		4
> +#define MT8188_AP_INFRA		5
>  #define MT8188_AP_CAM1		6
>  #define MT8188_AP_CAM2		7
> =20
>=20
> --=20
> 2.37.3
>=20

--nUnx8yrvH8DVkbj0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZlDbbwAKCRB4tDGHoIJi
0pUoAP0dmBcOmsdDvQ5P4PIIeZXUssG4s57m1H3nSypoY8IHtwEA2+8PySEExvRJ
l+6ydH0nKFhDmkLEJ9IJUVAyimv5tAU=
=ozOf
-----END PGP SIGNATURE-----

--nUnx8yrvH8DVkbj0--

