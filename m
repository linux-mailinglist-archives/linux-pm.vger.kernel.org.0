Return-Path: <linux-pm+bounces-14042-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F156D975A14
	for <lists+linux-pm@lfdr.de>; Wed, 11 Sep 2024 20:11:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A2F21F21044
	for <lists+linux-pm@lfdr.de>; Wed, 11 Sep 2024 18:11:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0DEA1B532B;
	Wed, 11 Sep 2024 18:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rf4GkJcJ"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 896822CCAA;
	Wed, 11 Sep 2024 18:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726078265; cv=none; b=BI9Ik3xPksKlagvJdRIOy5Z5fG+neJZFkUQH727oy1ROIXa1Kc/3gHSQJI37vKUvVShIGtPdq1Cr0lSGzHQR8x3OgScbpHOCwJi1cKCjACdiO4wVpONVkqF6kItrDaCsn/F+3u33k3EzYYHtKyOCTJd6KeD9wOyUxADcR4XJt6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726078265; c=relaxed/simple;
	bh=P86GHLbfOSrujNh/8UxUILXleCd4X5OE/x8QF0pgbEQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n4TSBrKWbhsI1sW5k4cVKl3XBaV/Ty05mTJ0hjPoNGSVxGO1WLye4oWI9xKorgBscpk/EOTCZ8Gl5tcK91g6Sj97pVKU+phvwOY6x3knpiOl74cGo8ck4Six26a1jaL1P1q3s2AwSbNfVYevyEMqauIr9n3rh/QAqwu+n4tYkmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rf4GkJcJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66939C4CEC0;
	Wed, 11 Sep 2024 18:11:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726078265;
	bh=P86GHLbfOSrujNh/8UxUILXleCd4X5OE/x8QF0pgbEQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rf4GkJcJWHTjLNRpciGlTXcOJxfQrEXulvQiHEMXqKYV0kH7YYhvVF0O6mzljiwwz
	 vNSiRxn7bGRD7/OaID8cyFRzqMC6k8wU6nkkLxtC31zXmbkHQBHyFZK/7eFEXJtsUt
	 an1u25dYNUYiLD7EEIAyGb9kwdzWDOjpYJhKlAe6VvlthsDJcXIpU4I4JrNFbzOdLv
	 dUGwHv6cFOtOidouOr52C8j4iV9/SMQhIQDOG4FRsP2vo1ahtxC7Q24xRhKw53s+VY
	 4kIlKpnTp7S0x/LqVLbROTjnJtJbNT0a73DKvgsTjUQPQnTkz8xsJFS6b3C5xaeKGT
	 I7yEq1TbikTGw==
Date: Wed, 11 Sep 2024 19:10:58 +0100
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
Subject: Re: [PATCH 04/22] dt-bindings: pinctrl: apple,pinctrl: Add A7-A11
 compatibles
Message-ID: <20240911-grievance-lunchroom-a1c6a5d19b6a@spud>
References: <20240911084353.28888-2-towinchenmi@gmail.com>
 <20240911084353.28888-6-towinchenmi@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Ge5S4j+4Y2t/oaKv"
Content-Disposition: inline
In-Reply-To: <20240911084353.28888-6-towinchenmi@gmail.com>


--Ge5S4j+4Y2t/oaKv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 11, 2024 at 04:40:54PM +0800, Nick Chan wrote:
> The block found on Apple's A7-A11 SoCs are compatible with the
> existing driver so add their per-SoC compatibles.
>=20
> Signed-off-by: Nick Chan <towinchenmi@gmail.com>
> ---
>  Documentation/devicetree/bindings/pinctrl/apple,pinctrl.yaml | 5 +++++
>  1 file changed, 5 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/pinctrl/apple,pinctrl.yaml=
 b/Documentation/devicetree/bindings/pinctrl/apple,pinctrl.yaml
> index 9c07935919ea..63737d858944 100644
> --- a/Documentation/devicetree/bindings/pinctrl/apple,pinctrl.yaml
> +++ b/Documentation/devicetree/bindings/pinctrl/apple,pinctrl.yaml
> @@ -18,6 +18,11 @@ properties:
>    compatible:
>      items:
>        - enum:
> +          - apple,s5l8960x-pinctrl
> +          - apple,t7000-pinctrl
> +          - apple,s8000-pinctrl
> +          - apple,t8010-pinctrl
> +          - apple,t8015-pinctrl

Same here.

>            - apple,t8103-pinctrl
>            - apple,t8112-pinctrl
>            - apple,t6000-pinctrl
> --=20
> 2.46.0
>=20

--Ge5S4j+4Y2t/oaKv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZuHdMgAKCRB4tDGHoIJi
0iVdAP9rhpBbyiSuLC++4seWrUilKCxfsCmheL26bfkZ2ZFbBAD6A09IXFP5QkE0
xz87BFAbRsumftdhrlPYwTZuldQM5AE=
=8Dgp
-----END PGP SIGNATURE-----

--Ge5S4j+4Y2t/oaKv--

