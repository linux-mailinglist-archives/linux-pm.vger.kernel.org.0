Return-Path: <linux-pm+bounces-14043-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BAF4975A21
	for <lists+linux-pm@lfdr.de>; Wed, 11 Sep 2024 20:13:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 323702817C9
	for <lists+linux-pm@lfdr.de>; Wed, 11 Sep 2024 18:13:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B52781B5339;
	Wed, 11 Sep 2024 18:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J6MCQsxx"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7903E1917E5;
	Wed, 11 Sep 2024 18:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726078424; cv=none; b=GF6mGH/wmwR0+QXEwISnpLcYxbn8k+rtH7fDJDTyNFEDqS2eEFdo3XPcWj/tU5xYfSwNqgo/d3bhiDH3FicSuP0mi0JiRRF/NGcaSixrL5+6GawEYAVIPkE0xfAhmqGPtZO1ZQacDau14k0gMGKv3UtP5vT1fVdcD2hmnNxV2rs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726078424; c=relaxed/simple;
	bh=10D6rQRJ9irIK22KYrX1n/hyeGXYJqUw64boavPr7VE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TV1RaTdAFiS2nLL0CvZq+Uo0tRwvi0vmi0d4ZlR8kwHfQtUyGWgRU8504ggkoMcrP5hO4Njx0/u5j1s1qMmYdLZ5fBJDy1CMsulfRCuevMj95aIygMm0+DIrJ0CFhup70Mzb3T9pXpF4TcGLDLQppKiTW/UvyukVDblSnCbTilk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J6MCQsxx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AB6EC4CEC0;
	Wed, 11 Sep 2024 18:13:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726078424;
	bh=10D6rQRJ9irIK22KYrX1n/hyeGXYJqUw64boavPr7VE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=J6MCQsxxEQDKWqV2rWa8D1ngLHxtw5pjctV1iCx62Ux3ChCoaOXCLW9FhR6vD4ktp
	 qKjOX81jKLsWKN6vIexG04rcpM8zdscr4Z2fKdMn3kb2Mm2Cm/wWC9s247/lA7wdhb
	 gmvfHS5tacUWnCy/Xn7YMT9pw9R8CM2QXfoMHG88Gt7Fujpl58QUfsm+KgwrZsfQQV
	 wkSHHceO9VZK/tQ5Ai9rXO4HvzeOLOo/CHyAJY6bE3zNV0DKdiBDp+fSGYzPzTRl5J
	 XzESm/7G/S7b4kUdlJGontFBAkgAhtUHJhPjsH3NWhelLnPNzzjHmuBVDhb5ySXmC4
	 JxUxkFVhqwkbA==
Date: Wed, 11 Sep 2024 19:13:37 +0100
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
Subject: Re: [PATCH 05/22] dt-bindings: arm: apple: Add A7 devices
Message-ID: <20240911-similarly-paragraph-0ca7a1d566c3@spud>
References: <20240911084353.28888-2-towinchenmi@gmail.com>
 <20240911084353.28888-7-towinchenmi@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="brCfXi/UFn+oONUW"
Content-Disposition: inline
In-Reply-To: <20240911084353.28888-7-towinchenmi@gmail.com>


--brCfXi/UFn+oONUW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 11, 2024 at 04:40:55PM +0800, Nick Chan wrote:
> This adds the following apple,s5l8960x platforms:
>=20
> - iPhone 5s
> - iPad Air (1)
> - iPad Mini 2
> - iPad Mini 3
>=20
> Signed-off-by: Nick Chan <towinchenmi@gmail.com>
> ---
>  .../devicetree/bindings/arm/apple.yaml        | 26 ++++++++++++++++++-
>  1 file changed, 25 insertions(+), 1 deletion(-)
>=20
> diff --git a/Documentation/devicetree/bindings/arm/apple.yaml b/Documenta=
tion/devicetree/bindings/arm/apple.yaml
> index 883fd67e3752..3c81008f0e96 100644
> --- a/Documentation/devicetree/bindings/arm/apple.yaml
> +++ b/Documentation/devicetree/bindings/arm/apple.yaml
> @@ -12,7 +12,14 @@ maintainers:
>  description: |
>    ARM platforms using SoCs designed by Apple Inc., branded "Apple Silico=
n".
> =20
> -  This currently includes devices based on the "M1" SoC:
> +  This currently includes devices based on the "A7" SoC:
> +
> +  - iPhone 5s
> +  - iPad Air (1)
> +  - iPad Mini 2
> +  - iPad Mini 3
> +
> +  Devices based on the "M1" SoC:
> =20
>    - Mac mini (M1, 2020)
>    - MacBook Pro (13-inch, M1, 2020)
> @@ -65,6 +72,23 @@ properties:
>      const: "/"
>    compatible:
>      oneOf:
> +      - description: Apple A7 SoC based platforms
> +        items:
> +          - enum:
> +              - apple,j71  # iPad Air (Wi-Fi)
> +              - apple,j72  # iPad Air (Cellular)
> +              - apple,j73  # iPad Air (Cellular, China)
> +              - apple,j85  # iPad mini 2 (Wi-Fi)
> +              - apple,j85m # iPad mini 3 (Wi-Fi)
> +              - apple,j86  # iPad mini 2 (Cellular)
> +              - apple,j86m # iPad mini 3 (Cellular)
> +              - apple,j87  # Apple iPad Mini 2 (Cellular, China)
> +              - apple,j87m # Apple iPad Mini 3 (Cellular, China)
> +              - apple,n51  # iPhone 5s (GSM)
> +              - apple,n53  # iPhone 5s (LTE)
> +          - const: apple,s5l8960x

Is the "x" here a wildcard?

> +          - const: apple,arm-platform
> +
>        - description: Apple M1 SoC based platforms
>          items:
>            - enum:
> --=20
> 2.46.0
>=20

--brCfXi/UFn+oONUW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZuHd0QAKCRB4tDGHoIJi
0kpsAP9D4iyi2ECtN/LLLqFE3D/it7pq5aVERx1miaK0UtMt8AD7B3P09l9kRNhi
VUBmDR39z5/Xm1p9eRhnRNOFkkyzJQw=
=FBa3
-----END PGP SIGNATURE-----

--brCfXi/UFn+oONUW--

