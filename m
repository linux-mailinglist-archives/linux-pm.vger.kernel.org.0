Return-Path: <linux-pm+bounces-14044-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 15A23975A26
	for <lists+linux-pm@lfdr.de>; Wed, 11 Sep 2024 20:16:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD9541F25416
	for <lists+linux-pm@lfdr.de>; Wed, 11 Sep 2024 18:16:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A834B1A4F06;
	Wed, 11 Sep 2024 18:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N6kVKLTc"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D2102AE69;
	Wed, 11 Sep 2024 18:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726078613; cv=none; b=corI9hh6TKvkyIcYnmyyCiNhsg08x1uMEhARRaV3A7rpT77Dvrc2Dou/CDIMicX75DswAAZdoTt9YhRYd27S+8GfHbWgDHyrV+3XxWA9/lFNjG2BO5jQxqZtyoANFMkX/u+5Z65Tf6WtHN+FwyJuuwHmzkR/R2fHkfjBZ3XsbkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726078613; c=relaxed/simple;
	bh=2WLks7SvKZsD8qY0K5DGpgThg0QOUsVgaH+AVcSCuZ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CkEgXdpexVtJxJD+wWsPAqXAfc7dILZfd+z6OlVaPR5uhWM4rTCiHVBcUGPtPG7OPDZ7pbGqaHBJlcFSEJT6aKClM/hx1/OjWS62fXTEfLTlR4lVwAI6jFMExkOtd8fm4yHroyz50PVgBSKEDESjWZYLrKhmcGAf3cx8N7jUKfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N6kVKLTc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E10DC4CEC0;
	Wed, 11 Sep 2024 18:16:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726078612;
	bh=2WLks7SvKZsD8qY0K5DGpgThg0QOUsVgaH+AVcSCuZ4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=N6kVKLTcUyEhLq60+Bu71/FOPUgUnd/3uVU9+zg/KWFdg/XKHnqUtwAsQU+CZahvK
	 XeW4ZBFzF7i7DyLn6rnEq/N+nFUGew/Wr9JeZkbI1Hwifm9gCwACc2S39Z2o6T0oR8
	 o3BBv4qFju8ZaN5yDJ8SVL4cf3aAaAaj3L5SS2y1xVE2JiP4I1bjbomSGrF9zHtuxc
	 mvp78gwIjqU5K3tKzvLGN1UEVC+oAurbFu8msnbL7jtXmm6SHULzZ/dLs00Cvhr3P8
	 GYtLPF1osJV2R0vWYjMYD/UIuPJYE4x0Bq4Np41EJNpvwMgZ1v9bxa6Fq1dsIal+u0
	 hAOkwz4QHfE4w==
Date: Wed, 11 Sep 2024 19:16:46 +0100
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
Subject: Re: [PATCH 01/22] dt-bindings: arm: cpus: Add Apple A7-A11 CPU cores
Message-ID: <20240911-unsuited-pranker-60a7d0b6caf9@spud>
References: <20240911084353.28888-2-towinchenmi@gmail.com>
 <20240911084353.28888-3-towinchenmi@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="kRgKl5kbZDK9Drdm"
Content-Disposition: inline
In-Reply-To: <20240911084353.28888-3-towinchenmi@gmail.com>


--kRgKl5kbZDK9Drdm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 11, 2024 at 04:40:51PM +0800, Nick Chan wrote:
> Add the following CPU cores:
>=20
> - apple,cyclone: A7 cores
> - apple,typhoon: A8 cores
> - apple,twister: A9 cores
> - apple,hurricane-zephyr: A10 logical cores
> - apple,monsoon: A11 performance cores
> - apple,mistral: A11 efficiency cores
>=20
> In the Apple A10, there are physical performance-efficiency cores that
> forms logical cores to software depending on the current p-state, and
> only one type of core may be active at one time.
>=20
> Signed-off-by: Nick Chan <towinchenmi@gmail.com>
> ---
>  Documentation/devicetree/bindings/arm/cpus.yaml | 6 ++++++
>  1 file changed, 6 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/arm/cpus.yaml b/Documentat=
ion/devicetree/bindings/arm/cpus.yaml
> index f308ff6c3532..3959e022079f 100644
> --- a/Documentation/devicetree/bindings/arm/cpus.yaml
> +++ b/Documentation/devicetree/bindings/arm/cpus.yaml
> @@ -89,6 +89,12 @@ properties:
>        - apple,blizzard
>        - apple,icestorm
>        - apple,firestorm
> +      - apple,mistral
> +      - apple,monsoon
> +      - apple,hurricane-zephyr
> +      - apple,twister
> +      - apple,typhoon
> +      - apple,cyclone

Same on this one, can you add these in alphanumerical order, even if the
existing 3 devices are not in it? You could take the opportunity to
reshuffle icestorm and firestorm while you're at it.

Cheers,
Conor.

>        - arm,arm710t
>        - arm,arm720t
>        - arm,arm740t
> --=20
> 2.46.0
>=20

--kRgKl5kbZDK9Drdm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZuHejgAKCRB4tDGHoIJi
0qtrAP9mosjJDbC2I6BNOh+pl8pwNtuuAdaaLzRXYbWgpVbFTgEAksy/FkAHoBDo
CD9iyuKIeMmgB/bQPjosE8IoLjHCyw4=
=DTFO
-----END PGP SIGNATURE-----

--kRgKl5kbZDK9Drdm--

