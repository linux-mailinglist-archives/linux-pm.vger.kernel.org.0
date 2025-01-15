Return-Path: <linux-pm+bounces-20505-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F70AA12CCE
	for <lists+linux-pm@lfdr.de>; Wed, 15 Jan 2025 21:40:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9AE293A6A67
	for <lists+linux-pm@lfdr.de>; Wed, 15 Jan 2025 20:40:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D5941DA0FE;
	Wed, 15 Jan 2025 20:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b="QMM4xiIf"
X-Original-To: linux-pm@vger.kernel.org
Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D1C81D959E;
	Wed, 15 Jan 2025 20:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736973619; cv=pass; b=YBP4T2iGhZ0iIDGM0CM6DAuGuE9n4ok3+DeeKjaBI8/p8q9ap5hzt3JNYBgk/3WorrGgX++4c1iJzc8S81cqGaBmr6rpjP4Q0V67HrmYChavgUzVIkEgcSpoBp//jJvRBW+mneHNFq+IdZm0Xm2LxKsT6zLC5L6km7JaaGM7h3s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736973619; c=relaxed/simple;
	bh=KK3D6/ev0g3+jSY1Un35og8hRL85uPEwzJsB805aKDM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lvU5mTMx9rGcTy9JNwyX8y5Z6y7DLEdXa2HOujlWQwJwRdMvhDHUF+MYTe+yfCdKOrzYu5ovCZlB57LkWtbI6IN6cuQTGMHqOiO25o7gLUYksj2PqickI7DoszrL/me0leOkH9Je8tkxxHz49CmX6Vf3GJQcVw0CJB42Ei0A4ug=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b=QMM4xiIf; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1736973614; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=mXCANXVit/++a0R0h7CCN6aJ1oI020o6vMl7Ns9Yg1QvLxsWdVrNmdEliBmJorn8Y8zutxfvYRC1uvYsWsyQTxNE6xvqzrMTf9RqSuhuTh780Jx2ZMturuc+SdR4HVWs3DFxWrYJHAZtSgZE9dfuJrlvHES1vU8ipCRMhVRaMnA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1736973614; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=THRoQMzxdxo9NpPuNVvk4yLl3K7Tkk1M9BqjpVxRDaE=; 
	b=ZhlRphGGfQuvPYAhlgz9JaCgVFJ7WQtGjK4L5YcaWiHbqacz3wh79PnGlFcbhxvPLn3Hax0xflVq+JnDsU+PrdxVfMtedpSyjG44gfjlRjGc+f842eW+Jbhfd+BwpRgRp2Ychu8+StH9LUQgu93KtgbXaN/mhUdEw71SricFxFs=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=sebastian.reichel@collabora.com;
	dmarc=pass header.from=<sebastian.reichel@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1736973614;
	s=zohomail; d=collabora.com; i=sebastian.reichel@collabora.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
	bh=THRoQMzxdxo9NpPuNVvk4yLl3K7Tkk1M9BqjpVxRDaE=;
	b=QMM4xiIfQ66tAL5ZjuyDkZg0XimoMhRUXJp5x0yw6FZmhprFUHUAeGDrtBxXNwQV
	9tNK2EWy8PrdG9SdCgbWmPvpAN/7QfF2iwG9mpuBaUDOtnKhlUcSKdjkvPR+G86Ybvo
	6UEbkzco9EAs66Y9Qt9YCxp5p0WVktljNznnLUrQ=
Received: by mx.zohomail.com with SMTPS id 173697361116682.3158629872787;
	Wed, 15 Jan 2025 12:40:11 -0800 (PST)
Received: by mercury (Postfix, from userid 1000)
	id 135761060346; Wed, 15 Jan 2025 21:40:08 +0100 (CET)
Date: Wed, 15 Jan 2025 21:40:07 +0100
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Kim Seer Paller <kimseer.paller@analog.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] power: supply: ltc4162l: Use GENMASK macro in bitmask
 operation
Message-ID: <ie2ihfyhsjkaqzhp7mht2dpskwxwcrdx4cajhp7wq2euiya4t4@tmwzn2aqpvcy>
References: <20250114011318.5784-1-kimseer.paller@analog.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="6su4vqgcwzz2uupr"
Content-Disposition: inline
In-Reply-To: <20250114011318.5784-1-kimseer.paller@analog.com>
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-1.4.1/234.845.73
X-ZohoMailClient: External


--6su4vqgcwzz2uupr
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] power: supply: ltc4162l: Use GENMASK macro in bitmask
 operation
MIME-Version: 1.0

Hi,

On Tue, Jan 14, 2025 at 09:13:18AM +0800, Kim Seer Paller wrote:
> Replace the bitmask operation BIT(6) - 1 with GENMASK(5, 0) to
> make the code clearer and readable.
>=20
> Signed-off-by: Kim Seer Paller <kimseer.paller@analog.com>
> ---

Please also get rid of the comments. I expect somebody reading the
code to understand what GENMASK does and the comment makes things
actually worse by sometimes speaking about lower 5 bits and
sometimes about "only 6 bits" :)

Greetings,

-- Sebastian

>  drivers/power/supply/ltc4162-l-charger.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/power/supply/ltc4162-l-charger.c b/drivers/power/sup=
ply/ltc4162-l-charger.c
> index 24b62f000..db1a75c9b 100644
> --- a/drivers/power/supply/ltc4162-l-charger.c
> +++ b/drivers/power/supply/ltc4162-l-charger.c
> @@ -410,7 +410,7 @@ static int ltc4162l_get_icharge(struct ltc4162l_info =
*info,
>  	if (ret)
>  		return ret;
> =20
> -	regval &=3D BIT(6) - 1; /* Only the lower 5 bits */
> +	regval &=3D GENMASK(5, 0); /* Only the lower 5 bits */
> =20
>  	/* The charge current servo level: (icharge_dac + 1) =C3=97 1mV/RSNSB */
>  	++regval;
> @@ -449,7 +449,7 @@ static int ltc4162l_get_vcharge(struct ltc4162l_info =
*info,
>  	if (ret)
>  		return ret;
> =20
> -	regval &=3D BIT(6) - 1; /* Only the lower 5 bits */
> +	regval &=3D GENMASK(5, 0); /* Only the lower 5 bits */
> =20
>  	/*
>  	 * charge voltage setting can be computed from
> @@ -500,7 +500,7 @@ static int ltc4015_get_vcharge(struct ltc4162l_info *=
info,
>  	if (ret)
>  		return ret;
> =20
> -	regval &=3D BIT(6) - 1; /* Only the lower 5 bits */
> +	regval &=3D GENMASK(5, 0); /* Only the lower 5 bits */
> =20
>  	/*
>  	 * charge voltage setting can be computed from:
> @@ -636,7 +636,7 @@ static int ltc4162l_get_iin_limit_dac(struct ltc4162l=
_info *info,
>  	if (ret)
>  		return ret;
> =20
> -	regval &=3D BIT(6) - 1; /* Only 6 bits */
> +	regval &=3D GENMASK(5, 0); /* Only 6 bits */
> =20
>  	/* (iin_limit_dac + 1) =C3=97 500=CE=BCV / RSNSI */
>  	++regval;
>=20
> base-commit: a3a8799165ff83bb764fd800c6559c3cba0ddac3
> --=20
> 2.34.1
>=20

--6su4vqgcwzz2uupr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmeIHSQACgkQ2O7X88g7
+pqtERAApH0qxdJiSGydO+bwqHELD/d0jBFWe0Z/dTEjEIehZNdoBMG9ppoTDyzX
AaWxoI919uLXAo2nqzYhKBhPveqUVnBBXcMFewaZcCkz6FJa2wmMdt5Jw1w5b/Ky
gZCWdmZN4x0R9UVbeTZQNS2Ads378tOpAOtukteAZZharShMYFnK352rtOe2x4Ws
SJ4u431ZLy20Fq/guvZ7FQLATazN7UWFiSSI+TS3UXECR9xV8d5Z/pzYii6FOWI8
H5GZlJMptROD0XFLbHq67IvGa767O29WCRXC+tlZkSlnxZGZlO2lR3RhNwN9O4+J
oBJJ+t/l637B0VE8TZzZI2OEbn0T30zkar7Sz2ELPMpfFQFY77RkVwC0p51bLz8L
bOwdMlpspktr6CIgRuMqNcKoWwjzNeQ7iN615ZqLLYlZ1p6wYzA93uHvSxqlUWro
J6MXGaANQUP1pwxQtSHq+NldLLPU1fTc4OcDFWhcLnhxIwfUhDcmCPX/lyr5RxiD
A5YSFt9D/Ty3TWe3ji0K/jNc0xbUHcEJkImiFbHQ4bQMeAzXgNOWBT9QUsj+XYrb
Ma0Ypsuto+0XzosVUZ6iXNgRUAPMXfVkY4Xz3K/2EOUtKYi+9ybM8IMvgT0u7F2g
KYSmG9wFzj41AHngmnegXGJvWBudDd7kyCClXHM+Kkrl5YSJJZ4=
=eWvp
-----END PGP SIGNATURE-----

--6su4vqgcwzz2uupr--

