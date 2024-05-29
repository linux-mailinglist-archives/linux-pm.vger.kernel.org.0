Return-Path: <linux-pm+bounces-8393-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 196B28D3C9E
	for <lists+linux-pm@lfdr.de>; Wed, 29 May 2024 18:34:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A2531C24C7A
	for <lists+linux-pm@lfdr.de>; Wed, 29 May 2024 16:34:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C974618412C;
	Wed, 29 May 2024 16:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZGPXSqFb"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 981921836DA;
	Wed, 29 May 2024 16:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717000233; cv=none; b=gK4U7afGuW4D58qkkSaCZ19wjwJ9tMbRigQd152pTRP0oygDh+YAhSMAFprbFyWS/owfjHMU9Aat1Y9XY+kPOkGiadRlGSHp/jUjrvAiVZIV9uPPwAVsLYK/f5ZeLrXwLcNZ0q26W74xXLbNyHL/loi/5M/zj3wBuWLvaMuH6uE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717000233; c=relaxed/simple;
	bh=Co2qg+TJJwG1cdw7waSP5z0AV55HwS75OlD+VmDcEE4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DeBi7RlTFO28izqk5bvb5YWXa5YBiqNVv4G12i3bdyNHFihJ+K84F9CDb09Yb4VVOp1TCSRAqvypw4qVvXOeNj91pHI0adVhF7tvlLg06u/o4eSjKeChcqwCw6sGT9SK7avUuXbhGMuPoBjsAGYMjqt73gKC/YGhPtOAwqnSSPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZGPXSqFb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4675C32782;
	Wed, 29 May 2024 16:30:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717000233;
	bh=Co2qg+TJJwG1cdw7waSP5z0AV55HwS75OlD+VmDcEE4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZGPXSqFbjYUCcjbFL5GWTiK7Vm/SwPwOVtfBCFoRAkvuj+pLlv3SGFdyP34Rzlh9E
	 leuoNBwKYvcJO2ssAOejaWPwmIztoVOq7IN/ME402JYUkjNaiY6wfqIBY//9Ia0bTG
	 4MuyTRJVVp1GxutBVQyr9DamSmHkgkfhEHHurNcS/JVzlm5Y5apfpXGJx8NnVxYjEn
	 IwGmowN9PMxFE2NkXM0wmJCNrxd6A1oKH1V5GyrwTEuJbETMghSwkxpvfWmVYiYnno
	 m0hqbk6e/G2ZUeoMs+raMHZf8SDj7FTBM2Rg1a7F/z/LNRyaBY2s9q/7JgC5i88rJ6
	 AhrRgAp+a/pog==
Date: Wed, 29 May 2024 17:30:27 +0100
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
Subject: Re: [PATCH v6 2/6] dt-bindings: thermal: mediatek: Fix thermal zone
 definitions for MT8188
Message-ID: <20240529-decline-dispose-317d2424dd79@spud>
References: <20240529-mtk-thermal-mt818x-dtsi-v6-0-0c71478a9c37@baylibre.com>
 <20240529-mtk-thermal-mt818x-dtsi-v6-2-0c71478a9c37@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Wbng8XqgGFHQpAGV"
Content-Disposition: inline
In-Reply-To: <20240529-mtk-thermal-mt818x-dtsi-v6-2-0c71478a9c37@baylibre.com>


--Wbng8XqgGFHQpAGV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 29, 2024 at 07:57:57AM +0200, Julien Panis wrote:
> Fix thermal zone names for consistency with the other SoCs:
> - GPU0 must be used as the first GPU item.
> - SOCx deal with audio DSP, video, and infra subsystems.
>=20
> The naming must be fixed "atomically" so compilation does not break.
> As a result, the change is made in the dt-bindings and in the LVTS
> driver within a single commit, despite the checkpatch warning.
>=20
> The definitions can be modified safely here because they are used only
> in the LVTS driver

"and have not yet made it into a released kernel"

If they had, use by only one driver would not be relevant.

>, which is modified accordingly.
>=20
> Fixes: 78c88534e5e1 ("dt-bindings: thermal: mediatek: Add LVTS thermal co=
ntroller definition for MT8188")
> Signed-off-by: Julien Panis <jpanis@baylibre.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

--Wbng8XqgGFHQpAGV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZldYIwAKCRB4tDGHoIJi
0qGzAQDZhJyCgPNEJHIJ7mXbbcYVHRlMNBgAb4Tq2p+X+qWTmgEA3nONB2IL0yxf
RuC6BgPITxiOsShcvlqhbRuUc4kzmAc=
=sTBt
-----END PGP SIGNATURE-----

--Wbng8XqgGFHQpAGV--

