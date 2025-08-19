Return-Path: <linux-pm+bounces-32650-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 57C73B2C8C5
	for <lists+linux-pm@lfdr.de>; Tue, 19 Aug 2025 17:52:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1E6677B31E9
	for <lists+linux-pm@lfdr.de>; Tue, 19 Aug 2025 15:51:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26D96287247;
	Tue, 19 Aug 2025 15:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YcF5YZUc"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F349326E707;
	Tue, 19 Aug 2025 15:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755618750; cv=none; b=LDF4un55lcvStQJnq0u+kT1MEwzBacx9TAvpIh4xfkDFPqAmvYhn2WVN4h3cU80Z4wRG8QsxogJBJFaOipkKWOpjExLFYOZJIk32bV6wCA2Z4jBB8THSeKplI57blI9qbpsXZWW5QksAn4ODv1I7v2NA00RVowCqpO8ifhLq9Ys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755618750; c=relaxed/simple;
	bh=nWqXp6oa3FLvahScFL6QJegYp1I3PkobBsHWH7UZ4kk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U6nHECJWrVWsaheMkZDDsFxiVSoJlxGcTYfUCyEo+JWtdyR73IBDnY11PJJxqsgL/x82nlizIAuUcbY9Pea1u8mHf/HiIueeHEWwZ2dICt3sEi999y8KPwruvpMXo/jeNPNHM5vGsNaDef9gwzNBR4SV0vlm3W3kt30lE4lu3lk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YcF5YZUc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21106C4CEF1;
	Tue, 19 Aug 2025 15:52:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755618749;
	bh=nWqXp6oa3FLvahScFL6QJegYp1I3PkobBsHWH7UZ4kk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YcF5YZUc9+IwR/H3j5Dzp5wvNPbunFWNkKo1wT3ClzD7Ha6J7oqHPRU9JykGgVZWK
	 /rUH+RJqYatnbQc9TcT5fO7+fUK/8nKJOFnSLJ34NnVjw+IMqsW4uYCEdaj3PMsV5c
	 0HOGyoZdniWDaDSACOQz3tinYdEQcUi432vCOmfzj+6dtnigiEFCEbuXKjiraycTzc
	 Nk8UBEAWHz5sycCacN012hL0cM31QXfZr4XusS7PNLZX8cLc9rcFG6Vb3jA7W64rDK
	 z3h2O3fkIuG3yCkqBikFCgeFup4BZsNaSb9pnFlTAV+lV0bg9fhGtD/ZOCW3Rarp2T
	 Rys0Et4Oq0pxg==
Date: Tue, 19 Aug 2025 16:52:25 +0100
From: Mark Brown <broonie@kernel.org>
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>, Pavel Machek <pavel@kernel.org>,
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH] regulator: consumer.rst: document bulk operations
Message-ID: <dc1107f3-098d-4952-8133-9bd6068d1100@sirena.org.uk>
References: <20250819-reg_consumer_doc-v1-1-b631fc0d35a3@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="kRgJzFxM/46Kf58w"
Content-Disposition: inline
In-Reply-To: <20250819-reg_consumer_doc-v1-1-b631fc0d35a3@gmail.com>
X-Cookie: One Bell System - it works.


--kRgJzFxM/46Kf58w
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 19, 2025 at 12:25:43PM +0800, Javier Carrasco wrote:
> The current consumer documentation does not include bulk operations,
> providing an example of how to acquire multiple regulators by calling
> regulator_get() multiple times. That solution is valid and slightly
> simpler for a small amount of regulators, but it does not scale well.
>=20
> Document the bulk operations to get, enable and disable regulators.
>=20
> ---
> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
> ---

You need to put the signoff before the ---, anything after the --- will
get deleted when applying.

--kRgJzFxM/46Kf58w
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmiknbgACgkQJNaLcl1U
h9DxLAf/dCH36jJZSJVXTkcqbwdf/AfKiFuFyvwS80Zvztai69HQAIjw3HKXaG3c
mpD58johHUz+KRFoGHjuyBosAyNKIqrtNTbFFdG6d3fJcFKJamTCHW7wh1KI2lfw
Msz7r4XaP790RjA86FykNOIz3ay9DB8WtsD0S+UuALGlDsiR5sMRWk2I+ijr4Q1V
MpgzupPbJGvVCgVay7UTjeFevBr+yu/8X8cSJ6LCqjROo09yC7ypr5b2YnL2DGY7
Ynl1PF0KGXIooU8PO0Y02pBnMFgt9Inx7pRZT2bhl7wk2qg8lYGdhOzhPYA4THwS
UFKhrNB3DLJgcKRn56xZFeo/JVx2hQ==
=Jqhz
-----END PGP SIGNATURE-----

--kRgJzFxM/46Kf58w--

