Return-Path: <linux-pm+bounces-14047-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 18B75975A60
	for <lists+linux-pm@lfdr.de>; Wed, 11 Sep 2024 20:27:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B70AA1F27965
	for <lists+linux-pm@lfdr.de>; Wed, 11 Sep 2024 18:27:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30A431B81D5;
	Wed, 11 Sep 2024 18:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FzeOR0wt"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E948E1B791B;
	Wed, 11 Sep 2024 18:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726079259; cv=none; b=se7AEGq8Urkob6z49s1qh9TgX7CbRg1L3rGlnSFtuUGcMxtM5B/7RWmuLAQrJY2QseBXZc6UaR9J4bK8gKTmzDzFwOHjAakxz3F/TTT0yYBJnuzgJ6NPZ1eucEh47PT7qHQv1GZJfAx5CcrMml+rGaR16rVLHKwbhLu5VeMz2W4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726079259; c=relaxed/simple;
	bh=bTzP8Pl9KjbaZjN4kFCpfYUk8wbwvQOyYHjiL9IH6EM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X3tCpCIA44l9HYijU2iEguEZ1IoFCa+rx2nvBKLqcuwBPTqfjrAF1wA2vPYI75xIJYuT7dlboruv961QRsK/DxHJa1hVCbz6j2aLgtdGkHiystqVxMIuyOZ+UevF11u44ULY6PG8PU0B9KsOOeLHaWse9lw+fvN+SK5Yb6cdFSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FzeOR0wt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB029C4CECC;
	Wed, 11 Sep 2024 18:27:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726079258;
	bh=bTzP8Pl9KjbaZjN4kFCpfYUk8wbwvQOyYHjiL9IH6EM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FzeOR0wtqHzLl70v7uwtl/0Cdnly0ifghGuAeqARu2YfBACVdLr3MLdW4K1OZtABX
	 8Y/gUjidRVNu9RY65ydjvKVt4cL/dMEWn+QDUP7IaOOg0ni6hj7hADAdjc1FQ/LH26
	 MSWNJyL2wIW+LljEPr9Qdylwd1S/hXDxQl4gkrteV7Pyb57yvTxrjTZ0V5iRzVcivy
	 2vDgJghE6eteZksXiMemtgmCzZGpB8xbjgDY2WgfsBIxO/CUPEfhDsZwBxOExHycKu
	 22kdXKDDUCE+HcFNbBQmsEpxWGdiZVO4k39Dobpz2fzgsEK/B40qDw07DrIYLcPp81
	 iof14PHuEcy/A==
Date: Wed, 11 Sep 2024 19:27:31 +0100
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
Message-ID: <20240911-surprise-sprinkler-1ca697744a95@spud>
References: <20240911084353.28888-2-towinchenmi@gmail.com>
 <20240911084353.28888-7-towinchenmi@gmail.com>
 <20240911-similarly-paragraph-0ca7a1d566c3@spud>
 <fae6aad7-de6a-49ba-acf4-e1aa93baad2e@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="fssrPeIGZR/fKecO"
Content-Disposition: inline
In-Reply-To: <fae6aad7-de6a-49ba-acf4-e1aa93baad2e@gmail.com>


--fssrPeIGZR/fKecO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 12, 2024 at 02:24:22AM +0800, Nick Chan wrote:
>=20
>=20
> On 12/9/2024 02:13, Conor Dooley wrote:
> > On Wed, Sep 11, 2024 at 04:40:55PM +0800, Nick Chan wrote:
> >> This adds the following apple,s5l8960x platforms:
> >>
> >> - iPhone 5s
> >> - iPad Air (1)
> >> - iPad Mini 2
> >> - iPad Mini 3
> >>
> >> Signed-off-by: Nick Chan <towinchenmi@gmail.com>
> >> ---
> >>  .../devicetree/bindings/arm/apple.yaml        | 26 ++++++++++++++++++-
> >>  1 file changed, 25 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/Documentation/devicetree/bindings/arm/apple.yaml b/Docume=
ntation/devicetree/bindings/arm/apple.yaml
> >> index 883fd67e3752..3c81008f0e96 100644
> >> --- a/Documentation/devicetree/bindings/arm/apple.yaml
> >> +++ b/Documentation/devicetree/bindings/arm/apple.yaml
> >> @@ -12,7 +12,14 @@ maintainers:
> >>  description: |
> >>    ARM platforms using SoCs designed by Apple Inc., branded "Apple Sil=
icon".
> >> =20
> >> -  This currently includes devices based on the "M1" SoC:
> >> +  This currently includes devices based on the "A7" SoC:
> >> +
> >> +  - iPhone 5s
> >> +  - iPad Air (1)
> >> +  - iPad Mini 2
> >> +  - iPad Mini 3
> >> +
> >> +  Devices based on the "M1" SoC:
> >> =20
> >>    - Mac mini (M1, 2020)
> >>    - MacBook Pro (13-inch, M1, 2020)
> >> @@ -65,6 +72,23 @@ properties:
> >>      const: "/"
> >>    compatible:
> >>      oneOf:
> >> +      - description: Apple A7 SoC based platforms
> >> +        items:
> >> +          - enum:
> >> +              - apple,j71  # iPad Air (Wi-Fi)
> >> +              - apple,j72  # iPad Air (Cellular)
> >> +              - apple,j73  # iPad Air (Cellular, China)
> >> +              - apple,j85  # iPad mini 2 (Wi-Fi)
> >> +              - apple,j85m # iPad mini 3 (Wi-Fi)
> >> +              - apple,j86  # iPad mini 2 (Cellular)
> >> +              - apple,j86m # iPad mini 3 (Cellular)
> >> +              - apple,j87  # Apple iPad Mini 2 (Cellular, China)
> >> +              - apple,j87m # Apple iPad Mini 3 (Cellular, China)
> >> +              - apple,n51  # iPhone 5s (GSM)
> >> +              - apple,n53  # iPhone 5s (LTE)
> >> +          - const: apple,s5l8960x
> >=20
> > Is the "x" here a wildcard?
> No. This is part of the SoC ID. This is the legacy naming from when Apple
> used Samsung SoCs for iPhones and iPods, and every SoC would have an ID
> beginning with "s5l", and ending with a "x". Apple A7 is last SoC to use
> this legacy naming scheme.

Okay, thanks for explaining.
Acked-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.


--fssrPeIGZR/fKecO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZuHhEwAKCRB4tDGHoIJi
0uHRAQDju3CGVnd1h/VgQ6q1bnaeUl2MEZWsbtj39yL2DPKNqAEAxPIcA750h/vf
rL1jXHUk3HhjbijhRsauVjU6Io/Q8wg=
=DWI0
-----END PGP SIGNATURE-----

--fssrPeIGZR/fKecO--

