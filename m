Return-Path: <linux-pm+bounces-9938-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D0FC6916536
	for <lists+linux-pm@lfdr.de>; Tue, 25 Jun 2024 12:25:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5F367B23585
	for <lists+linux-pm@lfdr.de>; Tue, 25 Jun 2024 10:25:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10ED814A089;
	Tue, 25 Jun 2024 10:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sV06yI4F"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D79C6145FF4;
	Tue, 25 Jun 2024 10:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719311132; cv=none; b=LbNWYaQK04y2fJCCp3IADKolsNE4KeWFcfdLVUIJbOqa48wfB/jxhJq14Wo/wLDbamEkXxI0HzYmpkdO+MTtruNaQjjkrnJRwS4QUpTZK+UO9QzJNa9WJdi+RhyXe6UMZylkynBFEMoPvl+zadQB4DWQ8NjsLu5UynUUDKZIphY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719311132; c=relaxed/simple;
	bh=BtjWR+gEmc49VtSTIaCGRyr5H0C8Qccd3WQsIc/9xUo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jIzprul97qvN85gTVi+tqkVGo8Di2x2S/ZD5zy8Yl2AyyuM27t6e2Gtu78E2NsOd4LlqJJRoEoR4MqoTll/DRQrPnOhMb9/FKg6PZD28oDUXl5DMOQhSmCG+VRc3IijFKNeBW8ZK7ZmGsM48vpBazYVn8uulG0V4oF5zeU07f/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sV06yI4F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57878C32781;
	Tue, 25 Jun 2024 10:25:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719311131;
	bh=BtjWR+gEmc49VtSTIaCGRyr5H0C8Qccd3WQsIc/9xUo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sV06yI4F3RaAzDzqwrxh6gxUv8cK+xRlvTpZIbM/sOGaVNSuodtK/oe5ge9iVOteP
	 GTxxIAgW8EbUGv0gXDsw/J+Jonpt/WC2Gy+OqWpIoKUl6Ua8WKkhdiXz9hPLxVMu+o
	 cct/GUbgBihxs16kVJjebCJDMBRA8dUX2OAmhAgXmcNlhnvNci8GUmXJYcv0GDRPtg
	 IxmQy1ZTFXDXXrFkj6sX1D0/TDABypZQx3CEY2aswzvo7d4y3BA/TsNKNv+/z4hFcs
	 ILMG4ciMdK16vZWcBKjhQ/i865dSTNzInqL8/nap4BKNGfYmqhe3BqgQlozm5CZMLo
	 ACJKjip0Nr1BQ==
Date: Tue, 25 Jun 2024 11:25:24 +0100
From: Mark Brown <broonie@kernel.org>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: robh@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	matthias.bgg@gmail.com, lgirdwood@gmail.com, keescook@chromium.org,
	gustavoars@kernel.org, henryc.chen@mediatek.com,
	linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, kernel@collabora.com,
	wenst@chromium.org, amergnat@baylibre.com, djakov@kernel.org
Subject: Re: [PATCH v6 0/7] MediaTek DVFSRC Bus Bandwidth and Regulator knobs
Message-ID: <57cf8f9f-4320-4c55-a9f8-a4c1facabfe8@sirena.org.uk>
References: <20240610085735.147134-1-angelogioacchino.delregno@collabora.com>
 <f7b4cd98-1acf-4f6b-a7e0-57419abadba1@collabora.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="HtLS8F6gqzyPaPXW"
Content-Disposition: inline
In-Reply-To: <f7b4cd98-1acf-4f6b-a7e0-57419abadba1@collabora.com>
X-Cookie: Results vary by individual.


--HtLS8F6gqzyPaPXW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 25, 2024 at 10:32:30AM +0200, AngeloGioacchino Del Regno wrote:

> Mark, I assume that this series is ok from your perspective, since this h=
as got
> your acks and r-b -- but in order to pick the soc/mediatek stuff I need a=
ll of
> the dependent bindings to be in as well .. and this includes the regulato=
r one!
>=20
> The main issue here is that the main soc/mediatek dvfsrc binding
> dt-bindings: soc: mediatek: Add DVFSRC bindings for MT8183 and MT8195
> does use the others, so I can't pick this one without the others being pr=
esent
> or the validation obviously fails.
>=20
> So... gentle ping :-)

I can't tell what you want from me here.

--HtLS8F6gqzyPaPXW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmZ6mxMACgkQJNaLcl1U
h9BI1Af7BjpHZjz2dcjVv0813GPAdnKjHAGhVhRvlIhqpTpKTUhV9kb4NaCW3WA8
WcTOuGzqXUetqxmyeIWpMFtNVeqdieIIuUfdUlMGWpTFKs+B+TEDi62ErAUlWCNd
3xQZMy9y9glGhigclS7EAFIcMF8eRSp/rNX0B9UD8fi9IAJMMeqBqojRam0XfAII
UT4XL/p1HG9l16q8Oo3VMAaTCh3kkgVNp/uTWMkZzeccIGDAUS0paMDbGCWnCjiH
A5hI1uZsXMJx6TtJf2Fkoxry7a4PleBULaXS0HM92gWwpYdqINQsFr0bn9/Lw1oc
gPxF2FlxpRXTYEQn++SXScXX8tJVAw==
=emPb
-----END PGP SIGNATURE-----

--HtLS8F6gqzyPaPXW--

