Return-Path: <linux-pm+bounces-36755-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C289CC0300C
	for <lists+linux-pm@lfdr.de>; Thu, 23 Oct 2025 20:34:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3587C19A0230
	for <lists+linux-pm@lfdr.de>; Thu, 23 Oct 2025 18:34:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FFD029BDB5;
	Thu, 23 Oct 2025 18:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="umJTBkhf"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44B0B2989A2;
	Thu, 23 Oct 2025 18:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761244334; cv=none; b=VpSuUbSYiGQtc+7uGUrnNS0w0jP45HcMYxAkk+QFV5A2MbuT78rOaC8UVEX/niN5MnCA63D2hd5K//DCsxW6F2brmuIT7wJvjE980l9G1My4Qo3OMkdVzmjEpQHiDSdB2txyNUZTkcY6PMhIEvV7MSJnmMCs8BgEmTJcAKB3lI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761244334; c=relaxed/simple;
	bh=s4NJy+OqNopQqO6UBGDQC+oxU9CM2iay6ZEpBQJXZ5s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lOzkF/JGWrEbIf0lEQA2oCRS0P5uypZPYqSoJ/TyraJNMztXVPlNjlIl9sZM0WDKWQInvwA8xzVpDC6a9WhAS8Ernpkf0Fxub+rjLRIPXkC8J9rTxKZV8EG/tdEA4p5UCHruydgIYe9541TufAo4vjGrQeIi8UVZ40r/MgXf3NQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=umJTBkhf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55D1DC4CEE7;
	Thu, 23 Oct 2025 18:32:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761244334;
	bh=s4NJy+OqNopQqO6UBGDQC+oxU9CM2iay6ZEpBQJXZ5s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=umJTBkhfPkbYkFecVLNAIaXszgopk+yQHW5y3DGFngwXYeypYdR1eEiL3PeVmjlH3
	 udY5wAZzm3Ksaj+TR3F24EaShe6GjOUTSZQxdNwudzXsdh0g66CJvDEoZShTOi8Kw9
	 FoTsnF0+ePdDNVwxBTp7APL/hkgvFnNghw+tTqN4g933lmXBgRz30cgrHbBuT8DWRp
	 j1GnPenFHralMGEsQaMSc4mTANP+YEnAloeyI3MrScxoP57Ds9gTlUIVBv9ptP7yEX
	 e+C41sj4wAoQs98gMctdgOdHXRg7MthU+HvIPa5d3cmi7gkuBnTzFtBnCaVlJn9wsc
	 /B9cEFIdjeVMQ==
Date: Thu, 23 Oct 2025 19:32:10 +0100
From: Conor Dooley <conor@kernel.org>
To: dimitri.fedrau@liebherr.com
Cc: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Dimitri Fedrau <dima.fedrau@gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: power: supply: gpio-charger: add
 support for fast-charge timer
Message-ID: <20251023-nurture-extrovert-8a82296131d6@spud>
References: <20251022-gpio-charger-timer-v1-0-b557409400f2@liebherr.com>
 <20251022-gpio-charger-timer-v1-1-b557409400f2@liebherr.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="6vsFR8pEpU/FcfKy"
Content-Disposition: inline
In-Reply-To: <20251022-gpio-charger-timer-v1-1-b557409400f2@liebherr.com>


--6vsFR8pEpU/FcfKy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 22, 2025 at 09:47:47PM +0200, Dimitri Fedrau via B4 Relay wrote:
> From: Dimitri Fedrau <dimitri.fedrau@liebherr.com>
>=20
> On some devices like TIs BQ24081 battery charger it is possible to activa=
te
> or deactivate a fast-charge timer that provides a backup safety for charge
> termination via GPIO. In case of the BQ24081 it is a fixed 7-hour timer.
>=20
> Signed-off-by: Dimitri Fedrau <dimitri.fedrau@liebherr.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>
pw-bot: not-applicable

--6vsFR8pEpU/FcfKy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaPp0qgAKCRB4tDGHoIJi
0pSnAQD8jTNqwT16SuF7P/cvfoKoXqTlTZWaL9gSixXaBGTcoQEAwN8PQ6DA040T
TPnEzJZbJqpIxC41t2GWf7le1DMjzwk=
=vWa1
-----END PGP SIGNATURE-----

--6vsFR8pEpU/FcfKy--

