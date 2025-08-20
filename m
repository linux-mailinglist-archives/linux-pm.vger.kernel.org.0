Return-Path: <linux-pm+bounces-32738-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B117B2E5D6
	for <lists+linux-pm@lfdr.de>; Wed, 20 Aug 2025 21:48:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0FAF11C8878F
	for <lists+linux-pm@lfdr.de>; Wed, 20 Aug 2025 19:49:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2037826E6F8;
	Wed, 20 Aug 2025 19:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uVa9a26W"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E583326A09F;
	Wed, 20 Aug 2025 19:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755719310; cv=none; b=LQi5UXs56Eka+OeILuH8sgE4ji1qijgV13NHYC7wW4pzKDcvWlJ6FGy++KlcWj9I/mKa4m8U31WOqWeebe9PGs9Zna5Zug9LbXSfUCri6OCnxwNQKGgXuaZAV+4qdN4l5cOKeM681v7L7+hNE/xy2QaczLU1Tbu/o2yOPVkp+wU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755719310; c=relaxed/simple;
	bh=ZAdsCPJer5cp70aNhszFdULfEcYeJDeg4An1kUlxQno=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XFt0Hqu+tRzQFUco7paNqJ1ve0V65eQCW/+2XUNwW7L3Et6am5ssuvUhQKYf5/bvktNBfdDJ6OdsvgF7JOgbWHJhelqQVDkROkzJJ92Yc4W3SDk78mWbTM2X1se/xv17RZrwmGW/Dg9GrV/268JTsSonW9hXWgf214XcRX7xM1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uVa9a26W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1396CC4CEE7;
	Wed, 20 Aug 2025 19:48:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755719309;
	bh=ZAdsCPJer5cp70aNhszFdULfEcYeJDeg4An1kUlxQno=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uVa9a26WlpOd2lExJFNhW8+6lwgSbRgExkhkldbI0j4xzDmMulzGbeeGY6QqW1fkc
	 5I+GOYGIT80lsYnM86pUsgDPyrDe8Wxqbm65JRjPrDfaIncSDwgtY/Y6TC1DROvb2F
	 hmIyFjb6NKBu+6fJBmPjZSQVj9R1J5LCEogNn1DGtGIAAt+SIKqG1oqlnddN5O6EJ4
	 //ea56WkFOEwm2khUhByKpGg2AVMm7Q5zTuymgE4qk+O9GZV5QpTICjhzLU6cwD299
	 nvQaVGRCkzZrMwnHZDEOTyBjTFkVd4ACMTQs4P+rbb4dtD+KsqB1r0PUXfJcslaDcP
	 P3ADJFHe9jCDQ==
Date: Wed, 20 Aug 2025 20:48:23 +0100
From: Conor Dooley <conor@kernel.org>
To: Sebastian Reichel <sebastian.reichel@collabora.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
	Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Diederik de Haas <didi.debian@cknow.org>, linux-pm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, kernel@collabora.com
Subject: Re: [PATCH v2 3/3] dt-bindings: thermal: rockchip: tighten grf
 requirements
Message-ID: <20250820-await-chomp-9812902c0f74@spud>
References: <20250820-thermal-rockchip-grf-warning-v2-0-c7e2d35017b8@kernel.org>
 <20250820-thermal-rockchip-grf-warning-v2-3-c7e2d35017b8@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Q0FCgrQS2OQS+FoE"
Content-Disposition: inline
In-Reply-To: <20250820-thermal-rockchip-grf-warning-v2-3-c7e2d35017b8@kernel.org>


--Q0FCgrQS2OQS+FoE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 20, 2025 at 07:40:49PM +0200, Sebastian Reichel wrote:
> Instead of having an optional rockchip,grf property, forbid using it on
> platforms without registers in a GRF being needed for thermal monitoring
> and make it mandatory on the platforms actually needing it.

I am assuming that "needing it" means that it was actually mandatory but
the binding was just missing the required required entry. If so
Acked-by: Conor Dooley <conor.dooley@microchip.com>

>=20
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> ---
>  .../devicetree/bindings/thermal/rockchip-thermal.yaml     | 15 +++++++++=
++++++
>  1 file changed, 15 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/thermal/rockchip-thermal.y=
aml b/Documentation/devicetree/bindings/thermal/rockchip-thermal.yaml
> index 573f447cc26ed7100638277598b0e745d436fd01..9fa5c4c49d76e3a689f317978=
75124e7fb30d3df 100644
> --- a/Documentation/devicetree/bindings/thermal/rockchip-thermal.yaml
> +++ b/Documentation/devicetree/bindings/thermal/rockchip-thermal.yaml
> @@ -119,6 +119,21 @@ required:
>    - resets
> =20
>  allOf:
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - rockchip,px30-tsadc
> +              - rockchip,rk3366-tsadc
> +              - rockchip,rk3399-tsadc
> +              - rockchip,rk3568-tsadc
> +    then:
> +      required:
> +        - rockchip,grf
> +    else:
> +      properties:
> +        rockchip,grf: false
>    - if:
>        not:
>          properties:
>=20
> --=20
> 2.50.1
>=20

--Q0FCgrQS2OQS+FoE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaKYmhwAKCRB4tDGHoIJi
0lk7AP9pdXnawAo7vHzgRoCDQLvEYOnbJv5NOJbb8mHXjbf0lAEAsFcbnQidHn69
nDsAJTevUWIbM9hHfimNJ3pk9is+lg8=
=v71N
-----END PGP SIGNATURE-----

--Q0FCgrQS2OQS+FoE--

