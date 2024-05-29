Return-Path: <linux-pm+bounces-8394-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8B208D3CE4
	for <lists+linux-pm@lfdr.de>; Wed, 29 May 2024 18:38:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C86028934A
	for <lists+linux-pm@lfdr.de>; Wed, 29 May 2024 16:38:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A283194C91;
	Wed, 29 May 2024 16:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oarz3zGY"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BCDE194C7F;
	Wed, 29 May 2024 16:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717000285; cv=none; b=px1wEnqvBrRA+CsiyusbLXFY56XUlrfLrX/vxQU+KEBIvg7RCY0w4xrnJuV282I0DzwBJhstMmtBaO4tWqvCCoVpqHmTHAWtmC5xEczKIjLsqhgrvimY8xWzwfjFqaAMxhS58kxwN8ylyrUhGtyhI+ijTKMwHVDgWbf6ZK71zrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717000285; c=relaxed/simple;
	bh=DYdkjdSXyiR/ZuFtGlShz00ja3BWPAVDGFZYZYgXGZM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tiv6LrfrtxT4pYGRtZsHAmsmIPgpjs2mbdTYWLvp3WuNXeVBVV+ImiGy+LKHaqI8IOaoS1u6gFe2NdYSqCY8pG8Eaf3tttdfuEbC/VnL8nN7UH9NEiNQjFilTMAf2/F7zjDoNen4p6ppzT5dmaVQr/4UyeMM8itsJLG8nzLVAh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oarz3zGY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 952BAC113CC;
	Wed, 29 May 2024 16:31:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717000284;
	bh=DYdkjdSXyiR/ZuFtGlShz00ja3BWPAVDGFZYZYgXGZM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oarz3zGYrcFhmGFxAxtWHp33tjXeN69LQudYBG60n+rh1l2pkYbgtEK+xYHBimFlV
	 y7Muq0Dh41NXlZVlNBAWLtia9YcQYxv9U6e/8tZ2LT0vBeJfalZrBy4LIG5m7v0faD
	 yVEqH3qQcrlOM5BoYDXmCuhOGUVoYhsF+VPINk+x544p8Z3zrnT9YLwpo6p5cMD76Z
	 VlyoavgBcESVxi2WjFegdLdd1LcNwBB6mSOH5rLgdopYH79EGYv47Tv5HYXxB2Ooe2
	 UOjRbkznRC3uq/Gt3+h6luVjIytft7UrpQiWAzS+LyuhOw2M4Z1k4hJ3npQHq+ZhhE
	 +L43CgUqCGqBQ==
Date: Wed, 29 May 2024 17:31:19 +0100
From: Conor Dooley <conor@kernel.org>
To: Julien Panis <jpanis@baylibre.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Nicolas Pitre <npitre@baylibre.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, linux-pm@vger.kernel.org,
	Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH v6 1/6] dt-bindings: thermal: mediatek: Fix thermal zone
 definition for MT8186
Message-ID: <20240529-projector-murkiness-43cdc28ef8db@spud>
References: <20240529-mtk-thermal-mt818x-dtsi-v6-0-0c71478a9c37@baylibre.com>
 <20240529-mtk-thermal-mt818x-dtsi-v6-1-0c71478a9c37@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="FB5kYnsTwm49RHjJ"
Content-Disposition: inline
In-Reply-To: <20240529-mtk-thermal-mt818x-dtsi-v6-1-0c71478a9c37@baylibre.com>


--FB5kYnsTwm49RHjJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 29, 2024 at 07:57:56AM +0200, Julien Panis wrote:
> Fix a thermal zone name for consistency with the other SoCs:
> MFG contains GPU, the latter is more specific and must be used here.
>=20
> The naming must be fixed "atomically" so compilation does not break.
> As a result, the change is made in the dt-bindings and in the LVTS
> driver within a single commit, despite the checkpatch warning.
>=20
> The definition can be modified safely here because it is used only
> in the LVTS driver, which is modified accordingly.
>=20
> Fixes: a2ca202350f9 ("dt-bindings: thermal: mediatek: Add LVTS thermal co=
ntroller definition for MT8186")
> Signed-off-by: Julien Panis <jpanis@baylibre.com>

Same comment on the commit message here. Otherwise,
Acked-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

--FB5kYnsTwm49RHjJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZldYVwAKCRB4tDGHoIJi
0jNgAP9t834oweQiI/O+4bJjB1Kzupjg2kkDDNhblETX3ni5LAEAktvJnAzd9hrE
qQYWhY0/mj24Z48k98MFMTttMrJ3SQI=
=b+YI
-----END PGP SIGNATURE-----

--FB5kYnsTwm49RHjJ--

