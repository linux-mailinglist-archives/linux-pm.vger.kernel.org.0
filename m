Return-Path: <linux-pm+bounces-38741-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 48073C8B809
	for <lists+linux-pm@lfdr.de>; Wed, 26 Nov 2025 19:59:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E27CF3457FB
	for <lists+linux-pm@lfdr.de>; Wed, 26 Nov 2025 18:58:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3F2633DECA;
	Wed, 26 Nov 2025 18:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UsP3kyz8"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8152433D6C3;
	Wed, 26 Nov 2025 18:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764183512; cv=none; b=Sxo5PP5Z7GBvCudB4SI1urKNX/pyAITped11/GH/Xpz+S3oXhzZx/rS07bloxISokypgTeYp7mqPls5DJkgRfr+W4C3S9zG3nbfyGpjrm4armDHYvkNKx9vUHIn0FcUVmWqV5JqMfmhpFPd51NV2RwH202t3lFIqNglrDjZ0wKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764183512; c=relaxed/simple;
	bh=fNHZoi3mx99Wn7G7/rAvgQsYmGktpdWgfjY59sxmr8Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XzhjJoH+l36FUzIuv5qXegvfLXV4WN9K6AhhDgpfGWdu+fI700I7qagvUnjPp220EzT7sJFu6cHKFtRBFCfilVQqVBv4d2PN5SOXqKQpHv1HsjAW7LeWUS8yj45AtG5lsgM0/GubMvhR0fHIRmIFrRdS0prw9wMZSO1E/qX7WvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UsP3kyz8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D6E8C4CEF7;
	Wed, 26 Nov 2025 18:58:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764183512;
	bh=fNHZoi3mx99Wn7G7/rAvgQsYmGktpdWgfjY59sxmr8Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UsP3kyz87mvZsG4sYztZM8Tz3wq4UGTQoz4pVkH4s+7810XALSScJ16GAIHXc0mNj
	 16DJbmwRdE0sqgYiO5+cHtBwx5HGi73F01QfgOrmURsMySmM9oppxjzhTDtKxf/MZ8
	 9gB26BjYmzsvk4x/umgXoHlte/yt9BRG89AHpEA4Ki9g0yUnYCCZa43B9z9AndS5tE
	 /JyKPSAMA9EPkZep/1x2WoQGRELdkUONvc/yUq3ov5BC6Ve9ys/tnPcrAXpjZKLX6k
	 qkyqPOG1Bj8AUVY6E9c+Ujkt4rjpwOOi+ra2MRYFkrjYP96LO3VZWXWSxmUHFGD0nN
	 1wz54ZS9muJwg==
Date: Wed, 26 Nov 2025 18:58:25 +0000
From: Conor Dooley <conor@kernel.org>
To: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
Cc: John Madieu <john.madieu.xa@bp.renesas.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>,
	Philipp Zabel <p.zabel@pengutronix.de>, linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v3 4/9] dt-bindings: thermal: r9a09g047-tsu: document
 RZ/T2H and RZ/N2H
Message-ID: <20251126-acutely-unluckily-41b716fc91d1@spud>
References: <20251126130356.2768625-1-cosmin-gabriel.tanislav.xa@renesas.com>
 <20251126130356.2768625-5-cosmin-gabriel.tanislav.xa@renesas.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="iG1c6wjSk6CPN4Bw"
Content-Disposition: inline
In-Reply-To: <20251126130356.2768625-5-cosmin-gabriel.tanislav.xa@renesas.com>


--iG1c6wjSk6CPN4Bw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 26, 2025 at 03:03:51PM +0200, Cosmin Tanislav wrote:
> The Renesas RZ/T2H (R9A09G077) and RZ/N2H (R9A09G087) SoCs include a
> Temperature Sensor Unit (TSU). The device provides real-time temperature
> measurements for thermal management, utilizing a single dedicated
> channel for temperature sensing.
>=20
> Compared to the previously supported RZ/G3E, the RZ/T2H and RZ/N2H SoCs
> do not have a reset for the TSU peripheral, and the OTP data is exposed
> via ARM SMC, as opposed to a system register.
>=20
> Signed-off-by: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>
pw-bot: not-applicable

--iG1c6wjSk6CPN4Bw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaSdN0QAKCRB4tDGHoIJi
0n4cAQDJ90TY5p/PjkuhtUGt8KJWFDyblhezANv6slZ5ktZePgEAuEprRr31E0eW
gHcKdaUz/JSHEe2kMpE5njMf5zgBfQk=
=9Kbd
-----END PGP SIGNATURE-----

--iG1c6wjSk6CPN4Bw--

