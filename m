Return-Path: <linux-pm+bounces-14040-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5194E9759C8
	for <lists+linux-pm@lfdr.de>; Wed, 11 Sep 2024 19:53:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF43C1F2382A
	for <lists+linux-pm@lfdr.de>; Wed, 11 Sep 2024 17:53:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F94E1B5ECC;
	Wed, 11 Sep 2024 17:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ksZUs4N3"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 182CD192D74;
	Wed, 11 Sep 2024 17:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726077146; cv=none; b=R+n5cY5uUS919z/F0u2tNCDsj6/+va28nK1SbbLIFo+E3eXWkPdxxH4/7untY7qpz9NVP6soucomXVZYw4mC5R0+lnrrPivme/4Yn5imqkbWBG2sryIaW+Yhkppl1Z3pt+Zs6Pzi5OTt0p1VAxlzXZ29YgqJhgGgdvwqh8vh49U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726077146; c=relaxed/simple;
	bh=Zd6WplPm4FdAwcsrLGkFduGLP4308+2slC70Hs9tLg0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZYpAFwx1TRAyoksglIoeq/HDwD83b/v9HCSxt+KrRyqAtro6YVidXNyqZ1U9gP/y5yk5pBDGzFtk8DtqgiTvFHYFKuZISm2jVvadMDu0/lrxUTyY9gXqToGP3z3zj14cm6YQkhfoo95X7UEEmVH5y0Z11JlbTwhdUQqtlzlmkdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ksZUs4N3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3ECAFC4CEC0;
	Wed, 11 Sep 2024 17:52:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726077145;
	bh=Zd6WplPm4FdAwcsrLGkFduGLP4308+2slC70Hs9tLg0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ksZUs4N3xj+8zFHMoJFOBd7dVLSIU2EXO7cxO8YDdt08Tt6hvWEPqDNDy1aNntc+N
	 R7hNC93oiiFigHPxurbx1Sl5K678I9bnxaDr55bA9ANLCGUu1ARx5O53BWVlxN3rzv
	 Y/4OCiu9XBwl3kVPyfThQ6vcd1qFLOLyNIC9iKSkfPdi0FOfYtVLk/WYwMLuZsxhg1
	 l1p1QXxnSJAHAF2mB8ppukhxX/g1TWGVSemCmuayt+Tc8tPbzi+ADRoMkBxqwN18lF
	 kPbgD1QvjSxlAjLi8qI+y97T+ztu8+zfOnMjW7Pqb1mnJeI8uKHQ/xrPFb8Spr+QcL
	 eM6B4qDV6Rfrg==
Date: Wed, 11 Sep 2024 18:52:19 +0100
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
Subject: Re: [PATCH 02/22] dt-bindings: watchdog: apple,wdt: Add A7-A11
 compatibles
Message-ID: <20240911-chaplain-cargo-29a12b6257cf@spud>
References: <20240911084353.28888-2-towinchenmi@gmail.com>
 <20240911084353.28888-4-towinchenmi@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="UtKeLkBPSdSPElNM"
Content-Disposition: inline
In-Reply-To: <20240911084353.28888-4-towinchenmi@gmail.com>


--UtKeLkBPSdSPElNM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 11, 2024 at 04:40:52PM +0800, Nick Chan wrote:
> The blocks on A7-A11 SoCs are compatible with the existing driver so
> add their per-SoC compatibles.
>=20
> Signed-off-by: Nick Chan <towinchenmi@gmail.com>
> ---
>  Documentation/devicetree/bindings/watchdog/apple,wdt.yaml | 5 +++++
>  1 file changed, 5 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/watchdog/apple,wdt.yaml b/=
Documentation/devicetree/bindings/watchdog/apple,wdt.yaml
> index 21872e15916c..310832fa8c28 100644
> --- a/Documentation/devicetree/bindings/watchdog/apple,wdt.yaml
> +++ b/Documentation/devicetree/bindings/watchdog/apple,wdt.yaml
> @@ -16,6 +16,11 @@ properties:
>    compatible:
>      items:
>        - enum:
> +          - apple,s5l8960x-wdt
> +          - apple,t7000-wdt
> +          - apple,s8000-wdt
> +          - apple,t8010-wdt
> +          - apple,t8015-wdt

Can you sort these alphanumerically please?

>            - apple,t8103-wdt
>            - apple,t8112-wdt
>            - apple,t6000-wdt
> --=20
> 2.46.0
>=20

--UtKeLkBPSdSPElNM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZuHY0wAKCRB4tDGHoIJi
0oB7AP4nPUdE2hLxQvPrgfSUTa+W6kRQafRVnC9Sscs8KWngrgD/dkTUKW+0h9Sr
m4X7I3w4VfdUTNfdPFzUo60kkgCNCQg=
=IbZW
-----END PGP SIGNATURE-----

--UtKeLkBPSdSPElNM--

