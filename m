Return-Path: <linux-pm+bounces-9946-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A023191685C
	for <lists+linux-pm@lfdr.de>; Tue, 25 Jun 2024 14:50:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 55D7B1F23FC7
	for <lists+linux-pm@lfdr.de>; Tue, 25 Jun 2024 12:50:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D452215667D;
	Tue, 25 Jun 2024 12:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QcXmLz0F"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4DED149DF4;
	Tue, 25 Jun 2024 12:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719319824; cv=none; b=NHvUb4mvDeByxDz22lJPkETrClTjm6QZpr4cksBurKv2yDY1H+DTDKlYrOpfqBBYra5REM1XJrfmZ3Re79QcSD7GT0CJDAUSyAF/jgo8ulBY8YXv9sktWyRU05uIzWJw9Yg6Ad5zI1YIARo4kcbdK/C9mhPkXBn/6NHUprJFzB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719319824; c=relaxed/simple;
	bh=s/7FiJi0GYLkjQ80S4lqlm3cUD3LaT7XZxvXN7svSLM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EH/YESIL9BHJVhBAHyTBn3qvrA6VPLtIF1SF0bFdK3Uvz0utkMfX2mo+8xjaMs9sfmPpUGFrQKR8dfP7g0oU9EXUjYtorxfZW+og7NNXF96Jlxiqfc0mo1jykEYIqDloxy+ax40WWbavuM4A+cJUzhL8cxXts7LWB/Q+S1jY9iY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QcXmLz0F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86EB7C32786;
	Tue, 25 Jun 2024 12:50:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719319824;
	bh=s/7FiJi0GYLkjQ80S4lqlm3cUD3LaT7XZxvXN7svSLM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QcXmLz0F9HMBbpD9AlMywFuHfaXoGktzYxKA5zWvJfhikRVK4r5RSpODDuwq8Jqqd
	 s0ZYKfQ/d5Zwz5QPhc+wSZ8NVnoe5f2dFSJcLx+wiqTGZ3N8hkqOwkQIUqqV9NaE41
	 z53ioDhHQrjZTxcpBoYmlNeR7b+lMGdngquXFLn0zbFenVtlot61kstgtroVyfQWHW
	 b9s/NBtENC7InhSWB1lroKiu6mdgvQ8bryusPh0Rxuex8nc0mPRf7Yp3AvdEE3MpC2
	 rAki5Y/LiVngw9G/PXuQn4Ut6tQXZhKzo1Nb8UWXq9c/jfF77xhKb1IWO1sR4o8eKa
	 pFQTO7Pg8ggfA==
Date: Tue, 25 Jun 2024 13:50:17 +0100
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
Message-ID: <2e8a9cf2-2bc0-45d8-b6c1-e3a9441d5641@sirena.org.uk>
References: <20240610085735.147134-1-angelogioacchino.delregno@collabora.com>
 <f7b4cd98-1acf-4f6b-a7e0-57419abadba1@collabora.com>
 <57cf8f9f-4320-4c55-a9f8-a4c1facabfe8@sirena.org.uk>
 <39ed7b8c-b19a-40de-9b30-a731ac83ad20@collabora.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Ck+ggcwV/Ot1gS3W"
Content-Disposition: inline
In-Reply-To: <39ed7b8c-b19a-40de-9b30-a731ac83ad20@collabora.com>
X-Cookie: Results vary by individual.


--Ck+ggcwV/Ot1gS3W
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jun 25, 2024 at 01:58:57PM +0200, AngeloGioacchino Del Regno wrote:
> Il 25/06/24 12:25, Mark Brown ha scritto:
> > On Tue, Jun 25, 2024 at 10:32:30AM +0200, AngeloGioacchino Del Regno wrote:

> > > The main issue here is that the main soc/mediatek dvfsrc binding
> > > dt-bindings: soc: mediatek: Add DVFSRC bindings for MT8183 and MT8195
> > > does use the others, so I can't pick this one without the others being present
> > > or the validation obviously fails.

> > I can't tell what you want from me here.

> I'm asking you to pick the regulator patches :-)

>    dt-bindings: regulator: Add bindings for MediaTek DVFSRC Regulators
>    regulator: Remove mtk-dvfsrc-regulator.c
>    regulator: Add refactored mtk-dvfsrc-regulator driver

Is there no interdependency with the rest of the series?  There was in
some earlier version at least I think.  If I reviewed the patches it's
because I wasn't expecting to apply them.

--Ck+ggcwV/Ot1gS3W
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmZ6vQgACgkQJNaLcl1U
h9AbYgf/URHedtcxPh/nFTezG0aVe4h2eu4bJNpWaI0S7OfNW4LJT4EhtiuCuSPh
BdAb2NA7AisSvcgOgZrIjD3COYnanTj/6j3pDfiV/YC3lCJoz+mv1TptT2kQxujQ
nPJbzRAtsIl24RsI8sSC2B1MWsddf44E6RAfcYnlV8YDWQua9BxfLyCdEuG+gjmb
+y5YK9glKhbAzHsaUjMkzn+BjHE147scOlb7u00uD61WrN94O2Q83guy2+sybO0y
Km6bYffp60vo0ebFLyJCTIfYEqeUAEvWw4v13TAZU7uBlHgr231EptnRd2gXLMLg
+WFplgSdJIzqSEsoZostEfIqw0bfgA==
=t/8Q
-----END PGP SIGNATURE-----

--Ck+ggcwV/Ot1gS3W--

