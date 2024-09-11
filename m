Return-Path: <linux-pm+bounces-14041-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D6AB975A11
	for <lists+linux-pm@lfdr.de>; Wed, 11 Sep 2024 20:10:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A0706B21BA3
	for <lists+linux-pm@lfdr.de>; Wed, 11 Sep 2024 18:10:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86B6E1B150F;
	Wed, 11 Sep 2024 18:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PQianliv"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DECD2CCAA;
	Wed, 11 Sep 2024 18:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726078245; cv=none; b=e1dJ49b759h/fOZh4adqex+Jz7J4wTpPs9Y4XHf59ru03Lm2D82gF/eDC0r9T+66FRKIcQrN0SvAMsl2ecz43nMWuNEtlz9UX3kNjwCPpjWBHXxafxaaME+71fllk8JtcnlrBLzRHpaJCtyVuY6Ck97uX3dsvqr/K0jIlcuzzYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726078245; c=relaxed/simple;
	bh=R8TDDE5JNXK8OC+GW4QHvppH3MOK1tDMKuVK8Q3Th8U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TH+Juxa5kpBVhT3MF7blYkCtdzKQssRrAsnwkE0cQHB6xLPG1LEkaM4ZBoHe+fkrugci6F/sT8bLybVjghcafg5wV2hX6uq8/v7hPjMCOpY6tQFWfxif4QZ5+v9io8yCIMNsEgEr3dCuKNseBMd0dDx1A+B+r1m4Ofh2M9y9VF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PQianliv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54593C4CEC0;
	Wed, 11 Sep 2024 18:10:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726078244;
	bh=R8TDDE5JNXK8OC+GW4QHvppH3MOK1tDMKuVK8Q3Th8U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PQianlivyLxNU8resVBv3Z/zEvOCWopMq7HYhRwv29K1xM6tMLBDgh993nz2/oIbi
	 o+Jndg5VkeSWrTPgUJ3viMJP3gM7ohovSMVdtALEo1ysr5eWxjYV2ciBScRsOZ+rYh
	 x1KaMeYQlOaXeH59KJnjbwZekxUkPyNfj5Iyb97+/YCqQQPtrORt2G0iZjPVmcR0ir
	 hydM/v6DdJwwXytRfz3WR5OplTLLbGS/93YGBUpfxzES2nFZQ4uN7jmfj278o/rCS0
	 o/Pxf5byK0k1yup7jFYPvKccbggNI/6eS0nMyqazSi3f2WZ3dxbqPWnh4/p+A4PYuR
	 j+w/qhg3UrBpw==
Date: Wed, 11 Sep 2024 19:10:38 +0100
From: Conor Dooley <conor@kernel.org>
To: Nick Chan <towinchenmi@gmail.com>
Cc: Hector Martin <marcan@marcan.st>, Sven Peter <sven@svenpeter.dev>,
	Alyssa Rosenzweig <alyssa@rosenzweig.io>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Mark Kettenis <kettenis@openbsd.org>, asahi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
	linux-gpio@vger.kernel.org, linux-watchdog@vger.kernel.org,
	Konrad Dybcio <konradybcio@kernel.org>,
	Ivaylo Ivanov <ivo.ivanov.ivanov1@gmail.com>
Subject: Re: [PATCH 03/22] dt-bindings: cpufreq: apple,cluster-cpufreq: Add
 A10 compatible
Message-ID: <20240911-armless-waving-4aa6d754f68f@spud>
References: <20240911084353.28888-2-towinchenmi@gmail.com>
 <20240911084353.28888-5-towinchenmi@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="UP0hu8KK5KxLZHX0"
Content-Disposition: inline
In-Reply-To: <20240911084353.28888-5-towinchenmi@gmail.com>


--UP0hu8KK5KxLZHX0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 11, 2024 at 04:40:53PM +0800, Nick Chan wrote:
> The block found on the Apple A10 SoC is compatible with the
> existing driver so just add its per-SoC compatible.
>=20
> Signed-off-by: Nick Chan <towinchenmi@gmail.com>
> ---
>  .../devicetree/bindings/cpufreq/apple,cluster-cpufreq.yaml    | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>=20
> diff --git a/Documentation/devicetree/bindings/cpufreq/apple,cluster-cpuf=
req.yaml b/Documentation/devicetree/bindings/cpufreq/apple,cluster-cpufreq.=
yaml
> index 76cb9726660e..e0d1a9813696 100644
> --- a/Documentation/devicetree/bindings/cpufreq/apple,cluster-cpufreq.yaml
> +++ b/Documentation/devicetree/bindings/cpufreq/apple,cluster-cpufreq.yaml
> @@ -24,7 +24,9 @@ properties:
>                - apple,t8112-cluster-cpufreq
>            - const: apple,cluster-cpufreq
>        - items:
> -          - const: apple,t6000-cluster-cpufreq
> +          - enum:
> +              - apple,t8010-cluster-cpufreq
> +              - apple,t6000-cluster-cpufreq

Alphanumerical order please, if/when you're resending.
Acked-by: Conor Dooley <conor.dooley@microchip.com>

>            - const: apple,t8103-cluster-cpufreq
>            - const: apple,cluster-cpufreq
> =20
> --=20
> 2.46.0
>=20

--UP0hu8KK5KxLZHX0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZuHdHgAKCRB4tDGHoIJi
0skcAQDtQ82Bn9KiflukV0Y0rWGpCmsNimvhc7fKKTMqqrPeSQD/VNWhWNXMSzOY
guQoHBGfymqS99Rchv4YjvXioOxe3gI=
=3+QK
-----END PGP SIGNATURE-----

--UP0hu8KK5KxLZHX0--

