Return-Path: <linux-pm+bounces-9517-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EF1790DFCF
	for <lists+linux-pm@lfdr.de>; Wed, 19 Jun 2024 01:22:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B4291C22861
	for <lists+linux-pm@lfdr.de>; Tue, 18 Jun 2024 23:22:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAC5717B50E;
	Tue, 18 Jun 2024 23:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="ziU9lAFi"
X-Original-To: linux-pm@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21D9B13A418;
	Tue, 18 Jun 2024 23:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718752956; cv=none; b=qVt1IByPTtiIY6XtVlzImT8h1JO3Xb9pwAnmJ15QPPmbY1JAOWg6iEIeQoVMFE4UPUbYaU5VUnC+lwIRSyergyJYd3goDxhrh/h2NM4o/YNv5JaB0pP9iiJXh7k12U1ekJU0RfP/AXsezJSueFjQy/ERfxdxzru4AYlLJdii25w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718752956; c=relaxed/simple;
	bh=X4yMpUdMzBFev3VY4iGlHCnTkRh+3TxWwpIYKaEqOLQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OzxJ+bK6EQgNyhyqo/qgCb1SsIUBE3b5WQTiyUay76h/aoFnJCs0523qCUu2sDw3iOiTSrMb5Xc3IEws3AFhguFhmPJ1IjDG4Tvyz39rynwWZwepcbRCpqXzm2d/otvA2N9zw80iQ7ZfFwB7EjqJa5L9M73UD0Hj23qSXVGuzIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=ziU9lAFi; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1718752953;
	bh=X4yMpUdMzBFev3VY4iGlHCnTkRh+3TxWwpIYKaEqOLQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ziU9lAFibxHtQwDI6T0Y5r96Cp0CSFc8qnYVcjeb5y52K8HJqootH3RBVujabtrwO
	 n5Bw0JgnYeCihcIOq9G9UtsAEafIWMfNz9NsqXrqiRdpO9jycFOOR/AbrCZ9buLzMg
	 OMXvuMeNiSQ78R9x1jylFQDDEjSwvZTwiuT48qZbLxJITaPoeRhbF2XpqJdApV2KgY
	 HAJhtpLmXR0Ys0KB9xbp4Mh84Vxa/hG0PXS4K1nmOk/dB/8hspD9EAmMPv5H5XQYiN
	 qd53vrXrc2lygtuUus9NbaX4QdYCBYrneVlOdyKBF+9O2WFOJZ58un31pewVOZjIXy
	 Lg2YZ76gi5Bag==
Received: from mercury (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: sre)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 4A560378205D;
	Tue, 18 Jun 2024 23:22:33 +0000 (UTC)
Received: by mercury (Postfix, from userid 1000)
	id C844D1060B1F; Wed, 19 Jun 2024 01:22:32 +0200 (CEST)
Date: Wed, 19 Jun 2024 01:22:32 +0200
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Dimitri Fedrau <dima.fedrau@gmail.com>
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-pm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas@t-8ch.de>
Subject: Re: [PATCH v4 1/2] dt-bindings: power: supply: add support for
 MAX17201/MAX17205 fuel gauge
Message-ID: <pap4shmyg3uwqcncgil2rfxzjxjtyr673wnpsgcyhzmb5igems@ybtcz5afq6x3>
References: <20240617184504.304211-1-dima.fedrau@gmail.com>
 <20240617184504.304211-2-dima.fedrau@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="zcxjyhnll7ot3i53"
Content-Disposition: inline
In-Reply-To: <20240617184504.304211-2-dima.fedrau@gmail.com>


--zcxjyhnll7ot3i53
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Jun 17, 2024 at 08:45:03PM GMT, Dimitri Fedrau wrote:
> Adding documentation for MAXIMs MAX17201/MAX17205 fuel gauge.
>=20
> Signed-off-by: Dimitri Fedrau <dima.fedrau@gmail.com>
> ---
>  .../bindings/power/supply/maxim,max1720x.yaml | 55 +++++++++++++++++++
>  1 file changed, 55 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/power/supply/maxim,=
max1720x.yaml
>=20
> diff --git a/Documentation/devicetree/bindings/power/supply/maxim,max1720=
x.yaml b/Documentation/devicetree/bindings/power/supply/maxim,max1720x.yaml
> new file mode 100644
> index 000000000000..52467af5388a
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/power/supply/maxim,max1720x.yaml
> @@ -0,0 +1,55 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/power/supply/maxim,max1720x.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Maxim MAX1720x fuel gauge
> +
> +maintainers:
> +  - Dimitri Fedrau <dima.fedrau@gmail.com>
> +
> +allOf:
> +  - $ref: power-supply.yaml#

[...]

> +additionalProperties: false

this needs to be "unevaluatedProperties: false", otherwise the
properties from power-supply.yaml won't be allowed.

Greetings,

-- Sebastian

--zcxjyhnll7ot3i53
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmZyFrcACgkQ2O7X88g7
+ppTZw/+OXeFYmj1m5ITmDMWwq0EU/cD7YpE7ELZ52xAd6Up92k10ChITP0vWCUH
AZ2b4SYcMTpcaRhS2L8ZimFkGRWg7OFe26O23L+PB4RYtIU1A1vuMBXmGVPqA96R
4ymE00gCQD+C8St29df34wvpIeNEW/XYSwZcmNpIEUz2wyA+Md4nrlscSLx8t6gi
K5M/tfTHpcOgfLQkAZZ/lQvNOVYTF2GHbam4g/xoUzTmvRtbc0sVbA01lHW2a6yl
dg+otNejLKrVvrLpzd6JvgOlJP+z36zWgYOiy0chna6aubbXcKOo/AbrlmrWvLNm
OqSD95ZahntcHM4MhUw2oOJchzPpDhVx51VReSaCVwVK9BvFUbV8gd7wpFfhNAa+
cz+SiNrRGMcgxNjgmMmqCl7y/Z52/coJqfW2Azj98Au/Bj6zpr/XfyQLpZteHWCQ
ytbSUMu8WrHwutNlRtxP0sHOIiPPn1vcoO8fYt0tLK3vPA3bx5S4uguinRscc5iP
avgQ+MSaXJSn22iFkDu6lr6KMgu40z0nHVzwqjvHkm+dQ2cMTqqgYMe1D8L12zT/
qBRQeLzc4uYoRGg6GvvSZfriFQOf7MsI2rR53XpuS46mz/g5v8GRbB3julP8ac7c
C/bUa91mnxZz6ISNhyJH7rip+wGJeDbZSsbGZlluv+ReKf94Nvs=
=yMvy
-----END PGP SIGNATURE-----

--zcxjyhnll7ot3i53--

