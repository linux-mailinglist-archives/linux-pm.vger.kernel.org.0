Return-Path: <linux-pm+bounces-27358-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BBA92ABC44A
	for <lists+linux-pm@lfdr.de>; Mon, 19 May 2025 18:20:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CEC977B282A
	for <lists+linux-pm@lfdr.de>; Mon, 19 May 2025 16:15:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4BA828A722;
	Mon, 19 May 2025 16:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EFm9Y2BM"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8A7528A71F;
	Mon, 19 May 2025 16:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747671206; cv=none; b=YrTp6gQyNgRDW5x+rMOCohmZKV+DhtWJaIohtTeeur2x4PGx5+4trH1wKDv+BXJsCP8nELuuivhGbAYm9/qUnIqHO8SDH4oLtTc+Egc3IFJax91tLFr0AD9MLxQqkmPqh9dl4SMfZ7xHCHNwYOjmi64JBfFGYOC2dABVrzG0m2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747671206; c=relaxed/simple;
	bh=Y8QH/9LVe3MmbHWlOj063nhwVhTp3uZCqQntnbYL1uY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VvasFlVRjh84UYv4Mm1ldT65jHF5XUzxBpEckAXY8jTSnnPsZQdt6fu6f/njeDTngrifqMBxxD7d+ukXvNdLfUmRcd6TBBX2HviLTLmIsBKaWmmNimAwZ3E1KHqTxOpCV3c/G2EnK58pdqz9HgBqNhDvYifm3ZeqzGxL4VL9Tjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EFm9Y2BM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D255C4CEEF;
	Mon, 19 May 2025 16:13:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747671206;
	bh=Y8QH/9LVe3MmbHWlOj063nhwVhTp3uZCqQntnbYL1uY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EFm9Y2BMK0pI8ND6m4ateyB1xw/cY4e6wk1fsrwURzShlnB96HUOA/CJfZwPJHk/h
	 SFdv1zaTZH/QPv1ukEJDR/mh1GpqTLmqCUSK0EhituJdfZ7Q+17XUG8t4toMOoa2ch
	 fnI9O2VrbgMiDHTpQFwn8VQ3ucskEBA0x/W1jdACyYmLSbj4VvZrbjteRmkzuDa7Y4
	 JqTXRhHe0fm6KYy2c/uR7kccbZiPTMFdsNvmsgkiHIMch1qZ4uoK9oWSQnGDzXCcSG
	 og3A2EMnsNSLX15ldhXtpwypx6caxq8/oLoGWcUF/e9Ob+YAyGKBiMBJQuB2zkT9hc
	 3f0oKHkRmkMyQ==
Date: Mon, 19 May 2025 17:13:21 +0100
From: Conor Dooley <conor@kernel.org>
To: Jonas Karlman <jonas@kwiboo.se>
Cc: Heiko Stuebner <heiko@sntech.de>, Ulf Hansson <ulf.hansson@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Elaine Zhang <zhangqing@rock-chips.com>, Yao Zi <ziyao@disroot.org>,
	Chukun Pan <amadeus@jmu.edu.cn>, linux-rockchip@lists.infradead.org,
	linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/9] dt-bindings: power: rockchip: Add support for RK3528
Message-ID: <20250519-outmost-carving-54f2a03fbf4f@spud>
References: <20250518220707.669515-1-jonas@kwiboo.se>
 <20250518220707.669515-2-jonas@kwiboo.se>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="g+A+7+z+9ImO7h3U"
Content-Disposition: inline
In-Reply-To: <20250518220707.669515-2-jonas@kwiboo.se>


--g+A+7+z+9ImO7h3U
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, May 18, 2025 at 10:06:48PM +0000, Jonas Karlman wrote:
> Add the compatible string and power domains for RK3528 SoC.
>=20
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

--g+A+7+z+9ImO7h3U
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaCtYoQAKCRB4tDGHoIJi
0uOOAP0Xv7AajQHtPvRmMN/HO2YRdDgNFtBlbcgkBdB3XHiCJwD/c9JjYp9l9fGH
eMrCbnVSV5zQIFlnmFNCL0CBXf2x6QE=
=+jD7
-----END PGP SIGNATURE-----

--g+A+7+z+9ImO7h3U--

