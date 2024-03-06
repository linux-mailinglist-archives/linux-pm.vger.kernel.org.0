Return-Path: <linux-pm+bounces-4748-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76602873E4C
	for <lists+linux-pm@lfdr.de>; Wed,  6 Mar 2024 19:14:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3156F280CD1
	for <lists+linux-pm@lfdr.de>; Wed,  6 Mar 2024 18:14:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E5DB13E7F5;
	Wed,  6 Mar 2024 18:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U7y99w7c"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 525A513D309;
	Wed,  6 Mar 2024 18:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709748779; cv=none; b=u8itYV7IK3SwwP63/hS8EIEe8DAOohLMlzN/0CyN/zHvwVt4SYslUrTe238NasNwwebavRc8Lq7LbIM8fDd8gIIW4NG+rbtNgJk5Z6Kc3CaXDBusmZh4u7GP0+HtFa99QVqY5B8XZpwh+6TIf68nopXY5pmoyqXEgcgQMyfDPeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709748779; c=relaxed/simple;
	bh=oDl9i8wVopENg8HbcqfcwU5Qsqz8CfV8yBnuXQyY7cU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=djjFT8AYhRwJkXvAm8p/R2vyF/zyyZie6W5GcY0TxqaXFvPhrRVW/RvKyNS71FbbjsbygTyzbvRwl5mH3AbtBq1JQOYL8EbnDTJ5DyVrkPnE/xxLFYKd7vR4H449ylopwGpCFVeXAXL67Lq8JqwCCJzB8ZR8jeicPPKXcRm6UX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U7y99w7c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39FADC433C7;
	Wed,  6 Mar 2024 18:12:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709748778;
	bh=oDl9i8wVopENg8HbcqfcwU5Qsqz8CfV8yBnuXQyY7cU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=U7y99w7cc7rbC2VCe02xdhPhernanjr5yhjHnseoyF/dhziSp3uG1eyhZL+qr0dKd
	 M5/BiuOIqv5fgRssDLurOQQLyr0aZjUAFof6Wn1tRf4mHb6+uISC4N9TAFQn0JtkMv
	 UP4CqsMBDvJYkU7jHkaY5A+leEqisiCqwbrpG1A1n4CrYmFRkl358dAu9/KWxb4was
	 VJyodc8l/xwSA2qw4kBIplFevpjYoE0270EEhodtqLVvcogVEwnOKaCPrDFmZvbuYB
	 CXE5LFgD/vPqR6Uk+2Hj9Ho9MB+VwMSKP82xDzfEX0/eaMeaVQneJfKFgb1imeV1Iv
	 GNMfkgW3FXViQ==
Date: Wed, 6 Mar 2024 18:12:53 +0000
From: Conor Dooley <conor@kernel.org>
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Niklas =?iso-8859-1?Q?S=F6derlund?= <niklas.soderlund@ragnatech.se>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-renesas-soc@vger.kernel.org, linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org, Duy Nguyen <duy.nguyen.rh@renesas.com>
Subject: Re: [PATCH 1/2] dt-bindings: thermal: rcar-gen3-thermal: Add
 r8a779h0 support
Message-ID: <20240306-discover-outshoot-2e0716d5d3ce@spud>
References: <cover.1709722342.git.geert+renesas@glider.be>
 <b3d135f8b63b9fe2d0f0aa2e48c8a2211b2e947e.1709722342.git.geert+renesas@glider.be>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="42iu+UqCSUQQDnvJ"
Content-Disposition: inline
In-Reply-To: <b3d135f8b63b9fe2d0f0aa2e48c8a2211b2e947e.1709722342.git.geert+renesas@glider.be>


--42iu+UqCSUQQDnvJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 06, 2024 at 11:56:02AM +0100, Geert Uytterhoeven wrote:
> From: Duy Nguyen <duy.nguyen.rh@renesas.com>
>=20
> Document support for the Thermal Sensor/Chip Internal Voltage
> Monitor/Core Voltage Monitor (THS/CIVM/CVM) on the Renesas R-Car V4M
> (R8A779H0) SoC.
>=20
> Just like on other R-Car Gen4 SoCs, interrupts are not routed to the
> INTC-AP (GIC) but to the Error Control Module (ECM).
>=20
> Signed-off-by: Duy Nguyen <duy.nguyen.rh@renesas.com>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Acked-by: Conor Dooley <conor.dooley@microchip.com>


--42iu+UqCSUQQDnvJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZeiyJQAKCRB4tDGHoIJi
0pBaAP4jB17YQumW0L2miIINAAmjpdyZcV+hNwFRGq9Tj2fZrwEA0yoGS1zRmMgA
Nh50LHjtU4c/tX4ZJ8fJKLAiFa9PNAA=
=AuLQ
-----END PGP SIGNATURE-----

--42iu+UqCSUQQDnvJ--

