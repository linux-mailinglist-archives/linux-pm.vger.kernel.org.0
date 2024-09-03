Return-Path: <linux-pm+bounces-13471-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F55196AA81
	for <lists+linux-pm@lfdr.de>; Tue,  3 Sep 2024 23:43:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 68F13B2438D
	for <lists+linux-pm@lfdr.de>; Tue,  3 Sep 2024 21:43:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B63221922EE;
	Tue,  3 Sep 2024 21:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="lMfG8Gnb";
	dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="jEDRXUVV"
X-Original-To: linux-pm@vger.kernel.org
Received: from a7-42.smtp-out.eu-west-1.amazonses.com (a7-42.smtp-out.eu-west-1.amazonses.com [54.240.7.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 356C51EC013;
	Tue,  3 Sep 2024 21:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.240.7.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725399783; cv=none; b=L6XlEYuQfLa8TzGbbxZiwmvVUWl65+7RpYHcQb6fSb5YTXmziaiGWn2s0t0QPQNTo8IXATh/SkK7pUjPH61F7HbDRsji83czzX37uWp8nA/ux7i96i86Do8euZKbTdUaGnhK1QIy7Sr2upsveWGI+iOSClYl/lsT0mFDOmJbSbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725399783; c=relaxed/simple;
	bh=dLHUYW+anAec76+kbDUnumPoN0JI3zrYqb+KYi9Mfyk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KtubTEVLYpwC1gFx6rYAuuhbhnJP2M087IL083NGJQHraAdG9Xg6QNH50QT2UpHrak/mBOUakrMCOnvNFQyKdUyxs9J7DsmaAQuFvahF0KNuioGD6yLlQkIDG/4sT/Eg1HxMh66Y80aH2vxgmc1od1WefW2+6WaetBfwbDypPMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=amazonses.collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=lMfG8Gnb; dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b=jEDRXUVV; arc=none smtp.client-ip=54.240.7.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazonses.collabora.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=4232tfv5ebdrjdwkr5zzm7kytdkokgug; d=collabora.com; t=1725399779;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To;
	bh=dLHUYW+anAec76+kbDUnumPoN0JI3zrYqb+KYi9Mfyk=;
	b=lMfG8Gnb7WSgcjDHwbAjt8nliSctfd9FSccuFxJMzfxUmghwmi/ll023knExvIje
	T76OrzClxvGrS39/nnsoTHSUjTa9m3TRcDHsr5ZNtMycGg3gQBPTaPWYvqnZN5Em/RE
	2tXPSwAKsYx0PkVBm2mvXqW3jYMbOXn8SrBmyqJilQ5lBVlSbuQzKmVkHtJ+CpUbKGZ
	C+yNSBuaIz04hJ5vkRKmByZf+XcTg4fIqJdddmH0qErCUr6FREh4RM8/yLsnDH38+kG
	XsWREL9kyciv4zLzURqXEDXKAUX80FYS9dR6meK9tX39/LTpG/LG3UM90XQeaeRpZK4
	gNqKiGKoDg==
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=uku4taia5b5tsbglxyj6zym32efj7xqv; d=amazonses.com; t=1725399779;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Feedback-ID;
	bh=dLHUYW+anAec76+kbDUnumPoN0JI3zrYqb+KYi9Mfyk=;
	b=jEDRXUVVSNn2ElOUJtgpRiDI68S3FjpZ+u4qVyK5evcLahYcpeG91rjbix3BefHt
	K3npYXS6fF9pQMcBLk1lqbbqittI8Wc6G8ZKabQZfHJgnzmfzNEFfqBnGTxsttWnZYw
	wDxXv1QH48CvZ5pztV/p+2iX6lZnlrKhWjaaoyCQ=
Date: Tue, 3 Sep 2024 21:42:59 +0000
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Macpaul Lin <macpaul.lin@mediatek.com>
Cc: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, linux-leds@vger.kernel.org, 
	Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	Pavel Machek <pavel@ucw.cz>, Sean Wang <sean.wang@mediatek.com>, 
	Lee Jones <lee@kernel.org>, 
	Alexandre Mergnat <amergnat@baylibre.com>, 
	Flora Fu <flora.fu@mediatek.com>, Bear Wang <bear.wang@mediatek.com>, 
	Pablo Sun <pablo.sun@mediatek.com>, Macpaul Lin <macpaul@gmail.com>, 
	Sen Chu <sen.chu@mediatek.com>, 
	Chris-qj chen <chris-qj.chen@mediatek.com>, 
	MediaTek Chromebook Upstream <Project_Global_Chrome_Upstream_Group@mediatek.com>, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-mediatek@lists.infradead.org, linux-pm@vger.kernel.org, 
	linux-rtc@vger.kernel.org, linux-sound@vger.kernel.org, 
	devicetree@vger.kernel.org, Chen-Yu Tsai <wenst@chromium.org>
Subject: Re: [PATCH v2 6/7] dt-bindings: power: reset: mt6323: merge to MFD
 mediatek,mt6397 DT schema
Message-ID: <01020191b9d74883-4c4deeb2-1be0-4c45-9fff-c228767de23d-000000@eu-west-1.amazonses.com>
References: <20240830110732.30080-1-macpaul.lin@mediatek.com>
 <20240830110732.30080-6-macpaul.lin@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="faghrlhi2opkikcu"
Content-Disposition: inline
In-Reply-To: <20240830110732.30080-6-macpaul.lin@mediatek.com>
Feedback-ID: ::1.eu-west-1.YpP9ZbxnARFfy3Cb5pfsLd/pdsXBCNK0KEM7HforL4k=:AmazonSES
X-SES-Outgoing: 2024.09.03-54.240.7.42


--faghrlhi2opkikcu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Aug 30, 2024 at 07:07:31PM GMT, Macpaul Lin wrote:
> Convert mt6323-poweroff.txt to be compatible with DT schema.
> Since this is a power-controller device node, merge it into parent
> mediatek,mt6397.yaml. Subsequently, remove mt6323-poweroff.txt with a
> separate patch.
>=20
> Signed-off-by: Macpaul Lin <macpaul.lin@mediatek.com>
> ---

Please merge this into PATCH 2/7 in the next version of the patchset
(i.e. the patch creating the new YAML binding).

-- Sebastian

>  .../bindings/power/reset/mt6323-poweroff.txt  | 20 -------------------
>  1 file changed, 20 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/power/reset/mt6323-=
poweroff.txt
>=20
> Changes for v1 and v2:
>  - This is the first version of converting mt6323-poweroff.txt.
>    This is because converting mt6323-poweroff.txt together
>    with mfd/mediatek,mt6397.yaml, so we've create a patch set
>    instead of submitting single patch for each subdevice.
>  - This patch has been made base on linux-next/master git repo.
>=20
> diff --git a/Documentation/devicetree/bindings/power/reset/mt6323-powerof=
f.txt b/Documentation/devicetree/bindings/power/reset/mt6323-poweroff.txt
> deleted file mode 100644
> index 933f0c4..0000000
> --- a/Documentation/devicetree/bindings/power/reset/mt6323-poweroff.txt
> +++ /dev/null
> @@ -1,20 +0,0 @@
> -Device Tree Bindings for Power Controller on MediaTek PMIC
> -
> -The power controller which could be found on PMIC is responsible for ext=
ernally
> -powering off or on the remote MediaTek SoC through the circuit BBPU.
> -
> -Required properties:
> -- compatible: Should be one of follows
> -       "mediatek,mt6323-pwrc": for MT6323 PMIC
> -
> -Example:
> -
> -       pmic {
> -               compatible =3D "mediatek,mt6323";
> -
> -               ...
> -
> -               power-controller {
> -                       compatible =3D "mediatek,mt6323-pwrc";
> -               };
> -       }
> --=20
> 2.45.2
>=20
>=20

--faghrlhi2opkikcu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmbXgtwACgkQ2O7X88g7
+pq2Ug//XIP0j2lD0cd3LM44blAIjUl0UgZJriEZiG3wsjlv/FuOtluDjrcvM3mI
UByVatgwToo/El3VOtKZQuLw9KZwczJ41SINA+fhCAoEfgYq9kHd/iU3TMA2CW7m
O9OnSo68rcy7gl8hefaKoh+YE8K3rEO5D1brjEqNF7bV1WJjDOH1KZ05QHMDJLcy
FlZJbjJrtKOIOjAhcS6dOMXqKdGBdeC2JjRDPI3LkzpYY64aiC9Z/xzwOsPomsLo
7+tgWUToTVZYXB79Wefk6SPXupXKwLFPed47jEnUG9AwQdxniHs8P/d8KOGNdFdG
5KotyKni2BsLXQsUiRoa4W1xeOtgkHdYxdKXAK51Fu8O4cFpkly/7GddGH09WXQt
SO1nDh85su1X3NJSEU9cpiRgfInAHlaaLPAwbZSUe9GMDvJyqqkJcOJACmVCYKMb
3H4Oa22kXbgcTOiL5NwkH2Bw6o0dtbzRrE1d8liKlDAiuMwLdfxiiClMkFKGL2Ib
4z5kaGdTHETsgbJIiCGiQvuR2+ST4NOWIjbjUNMTeTn3ByOX5QGmmetgO/HgX2G1
c1/CAqKKvpvHI0CIYvQEX/MW27aLlTvzwJMW4inml2ZMwg6EubzrgGGqz0cXKgm3
87q67pasYQCR6GYLOLpSr6AL/qb4M3FpAkcKDTX1m5Y4lEIAZHw=
=L2y9
-----END PGP SIGNATURE-----

--faghrlhi2opkikcu--

