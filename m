Return-Path: <linux-pm+bounces-8955-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 80E1A903F62
	for <lists+linux-pm@lfdr.de>; Tue, 11 Jun 2024 16:59:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 31AF62840E9
	for <lists+linux-pm@lfdr.de>; Tue, 11 Jun 2024 14:59:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE70A12B89;
	Tue, 11 Jun 2024 14:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dlFpnu2r"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0F7E20335;
	Tue, 11 Jun 2024 14:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718117982; cv=none; b=Wc5eAqo8bCg3ztQLvmuNufnF0Sw3fyZe57PX3xUiVV0s7ZfXkiE4rJS7q0pR6OhkiCWgI7C1fCJxGESB8NKhudpvMmLizFUlILw4AhhsXS4P+huKUGgWKc2bta7TDPxfR+DvD0FYbBAAwhnSXkqzo6IJMkq4l0uIMXtnJd/2aI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718117982; c=relaxed/simple;
	bh=m0NwVcSBhPgY7nu5tONSPwoAExBx8ebvDHOrS84nijE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R4uVc5UUkLRj1fADLI3mDB3PCULqAq+S487CZLprE+LI6aWwyf3TjZVTYcHqq3REM1i5fwm7myzRPRQBpkJEsn7Z2rTCVvyA3zXVeDvjbhZAYKLAEpJ1KJnZNKrJ1zBR5WksE1oi9nikKffpsKNvL/dEssMxht6W7LDp5NG0QfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dlFpnu2r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B931C2BD10;
	Tue, 11 Jun 2024 14:59:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718117982;
	bh=m0NwVcSBhPgY7nu5tONSPwoAExBx8ebvDHOrS84nijE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dlFpnu2rYajLt2Ck8YFhygKxfdNGquAdAH78BbAIqEMS4SQT0fUEbZtR8dUY56Mji
	 jzBXqMS8bmlXR8pELKQb5DUa7FUEBY+cp/xSc9RmRLFJVcPVlTVbBJMFewmmJPjcvF
	 wfadvSt3GWQVLcuMU+PyKe9ZwNKoxCgZH1xS8FQJGky/i5HFtoQS1bLnUXzL5Ef5ef
	 M+V1sAHAJDJC3bRy8oRQffzAXVfNMSiwX7r5mr8OlGYcBTqfQ7imL6JG+c7W7VY8Fk
	 1GKD77XRbgXMCRp3JC18Te9U/6rjX+A/WGeFl9EePtVI+Q4SgveBbZKeQKmZqc/ouD
	 fn9kBe6GiyP8Q==
Date: Tue, 11 Jun 2024 15:59:38 +0100
From: Mark Brown <broonie@kernel.org>
To: Biju Das <biju.das.jz@bp.renesas.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
	linux-pm@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Biju Das <biju.das.au@gmail.com>, devicetree@vger.kernel.org,
	linux-phy@lists.infradead.org, linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v3 3/6] regulator: core: Add helper for allow access to
 enable register
Message-ID: <ZmhmWrvyQiCzzeYi@finisterre.sirena.org.uk>
References: <20240611110402.58104-1-biju.das.jz@bp.renesas.com>
 <20240611110402.58104-4-biju.das.jz@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="g6UtxWQIHkSaqfBe"
Content-Disposition: inline
In-Reply-To: <20240611110402.58104-4-biju.das.jz@bp.renesas.com>
X-Cookie: Your love life will be... interesting.


--g6UtxWQIHkSaqfBe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jun 11, 2024 at 12:03:59PM +0100, Biju Das wrote:
> Add a helper function that allow regulator consumers to allow low-level
> enable register access, in order to enable/disable regulator in atomic
> context.

> +To access the hardware register for enabling/disabling the regulator, use::
> +
> +	int regulator_set_hardware_enable_register(struct regulator *regulator,
> +						   bool enable);

So, it'll doubtless not be a surprise that I'm not thrilled with this -
it's basically just punching a hole straight through all the locking and
reference counting in a way that's just begging for abuse.  At the very
least we should have a check for exclusive access in there.

Also it's not sure about that name, if we were doing this it should be
more describing the effect on the regulator rather than this happening
to be done via a register write (this should also work for GPIOs...).

--g6UtxWQIHkSaqfBe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmZoZloACgkQJNaLcl1U
h9AqeAf/dfRZPoWwkY3VTRIlWmJTu1FCIotm556t2q1U7O9RKVVE8Rqr2vbiAgiJ
L54w7no2cgj2rn/8O9eZeRJ7w7TbadF8YiguXjHhwF4tQfhrxUbtUyxzPxD2gHEU
aXPyVcY8vbUO+XWNkJzYfHGNx1HBBpEp686nTfldsLUTlp9y565Eknwb5/h1G7Re
5dznt8rOmJVjlMEjDt1Q42bHM4Fs6QQrMGyHWQne4fqBGmddNHD1Kyy3ic1MfMgb
CmrD5vZ6KVU0Ihd3IwRfu9yrY3Een2l9W6jor2sMcmZqq0yrx8yVgdnT/V0adlnm
Oe+gmNFp2sMfV0FotVRuPzVhNgXOoQ==
=Xoc0
-----END PGP SIGNATURE-----

--g6UtxWQIHkSaqfBe--

