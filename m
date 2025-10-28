Return-Path: <linux-pm+bounces-36989-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DB27C16962
	for <lists+linux-pm@lfdr.de>; Tue, 28 Oct 2025 20:19:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8D6B84E4A9B
	for <lists+linux-pm@lfdr.de>; Tue, 28 Oct 2025 19:19:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DEDA3321A7;
	Tue, 28 Oct 2025 19:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hNWf1Qx1"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 299F11E1DFC;
	Tue, 28 Oct 2025 19:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761679149; cv=none; b=o3/RpHGjy40DU8eIeqS6ymq3OTzI+n2IH5CmDgZmqRbdsMIfw8zh579IakVp6mAZqKFkcvnkWVv0DMa0BBtogSlomoz40h0johx1GUKBXXvF+sbhfcdAj/SY+GR+cbE5RwWd27YMZ5zPLvBSpEdN1xKq2831QdLr+Edb4uMnmyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761679149; c=relaxed/simple;
	bh=FMpWfoQMGNbES7MsEv6x8iHIVTiJl8LhNCphqpADnPA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b5Ka0XFH1l/U61FqOgQbyaDbGmcvhDs2zZbWFbAOK3CEsp+eoGo+oX+2jkJHGoDMhSbV8/5l0XAdZDIFrk4W393VYOKSM/oHlsm9/1xJrEEVEUBtQ57pyOKMRfYXjEKDJz2QMLR4CRpz1kHyVnxGQXzc/3xe1d7dE9wegtcBc+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hNWf1Qx1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2DFEC4CEE7;
	Tue, 28 Oct 2025 19:19:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761679148;
	bh=FMpWfoQMGNbES7MsEv6x8iHIVTiJl8LhNCphqpADnPA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hNWf1Qx1rj7OKg3Z3ZSy4L7rv1hxhESDkwn18qfczoS1iZgwTXOC4yQMENkyul4n3
	 DhgdXfyeiaai2lDSPZwHdH0o7cJIk4An8gry5q3R8Xu3XiBdvOU2yGHyI0d30Mxj2B
	 UPjKE6fugEIXFU92aZjxPk2sExmQbKB3mFjT1CItq7v9t0M/hE+Mc2H29bfdkUAda0
	 oIQMq+ygHvL1tSCVzWUW8TuaqoZGZ9yLsXFBgKUuQEEZa5vNujZkU1rmJQx9wMyjbH
	 lVXRDngThljHtwsmCnRe3E/0qm8/gozBXA+REHm8xdZCzeUaHJ015S8urZtBdyNcoD
	 JqyeZFBNIgy7g==
Date: Tue, 28 Oct 2025 19:19:03 +0000
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
Subject: Re: [PATCH v2 4/9] dt-bindings: thermal: r9a09g047-tsu: document
 RZ/T2H and RZ/N2H
Message-ID: <20251028-spur-amicably-0f7a7af3ba0d@spud>
References: <20251028132519.1472676-1-cosmin-gabriel.tanislav.xa@renesas.com>
 <20251028132519.1472676-5-cosmin-gabriel.tanislav.xa@renesas.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="qCBnPgZpL8J4boEu"
Content-Disposition: inline
In-Reply-To: <20251028132519.1472676-5-cosmin-gabriel.tanislav.xa@renesas.com>


--qCBnPgZpL8J4boEu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 28, 2025 at 03:25:12PM +0200, Cosmin Tanislav wrote:
> The Renesas RZ/T2H (R9A09G077) and RZ/N2H (R9A09G087) SoCs include a
> Temperature Sensor Unit (TSU). The device provides real-time temperature
> measurements for thermal management, utilizing a single dedicated
> channel for temperature sensing.
>=20
> Signed-off-by: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>
pw-bot: not-applicable

--qCBnPgZpL8J4boEu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaQEXJwAKCRB4tDGHoIJi
0g59AQCt0GoOim07++WRc+d0IypSC6GTrqPCGHFFvoFdnAMOMAEA7H42TNgZVs2e
GWPfENlwQkVuEjFeUY4qdrGnJ82TqgI=
=fPs9
-----END PGP SIGNATURE-----

--qCBnPgZpL8J4boEu--

