Return-Path: <linux-pm+bounces-36909-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E38C6C0D798
	for <lists+linux-pm@lfdr.de>; Mon, 27 Oct 2025 13:21:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D4F6C4013E1
	for <lists+linux-pm@lfdr.de>; Mon, 27 Oct 2025 12:16:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76781288C26;
	Mon, 27 Oct 2025 12:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="goJwogGi"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34E1234CDD;
	Mon, 27 Oct 2025 12:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761567350; cv=none; b=BzY0pB5tu7rYIWl3gwegr20amwB5idy1cOjzmYXfWfNQMwEZQdgpBQXpCLuScH8DgiJosLaJ9iFPPjApdbgBKZKlj09NpkDppFrzuef2fLDo7p10m6OuzzCH+wuCGnQZUr3WFmAlYcxo02wsXiQMOl9WmClkK/qkJ6JOvJqSwco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761567350; c=relaxed/simple;
	bh=tXiVqGv2VriRVuycYbx30w53ZLM4GSUJn3DkQxYaGUQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aSk7B+2GZg4j1fsyj1mwmuJpCsty+m78bktyqggOPwbNliejCtIHYROu4mhdAsBrVOQ+dxqin98Zu1gtWDVi3hb8n+PM9tU7Ivl5na1T9tnXv7MoNSYhnC5MDbGeQqseruxBL4vL9ILiBsWEEY5Au18fDLi+XKocUh/KpPIaCrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=goJwogGi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DE44C4CEF1;
	Mon, 27 Oct 2025 12:15:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761567347;
	bh=tXiVqGv2VriRVuycYbx30w53ZLM4GSUJn3DkQxYaGUQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=goJwogGi1VkxLLiMt8s6kdmYmRaFSAe1PqnPeXpUSbMNlbiXaDUwt6zl/EdysDaYj
	 sDeIVAvM7r8FHEXh7709edushUMiu/+QExY2ivd6DB3o35JBHOjfSB4FCeEwdM6iYS
	 puOoo1U6tr+G0qoUyl/OjZgLpkQ23M/Rm/JXzoIY1lYA+iquVbM0tTvj2oDFHwOm7h
	 jDHeARI9Y4JNWXklQE/75tezRB5wjw75ho5m3dZgY7hxdDqmqdg8BjdmCdw5k28GIY
	 SFM+Z96eIHI0KNZKym7El9yro4bBhi+lY0OusIyhjUaADTYPYz+PMIMQEnxMCRBZOU
	 lKUpCSDcyWICw==
Date: Mon, 27 Oct 2025 12:15:37 +0000
From: Mark Brown <broonie@kernel.org>
To: Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
	Lee Jones <lee@kernel.org>, Pavel Machek <pavel@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Sebastian Reichel <sre@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Andreas Kemnade <andreas@kemnade.info>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
	linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org,
	linux-rtc@vger.kernel.org
Subject: Re: [PATCH v2 09/15] regulator: bd71828: Support ROHM BD72720
Message-ID: <ad7357b6-8f9a-42c1-b287-201059e86e33@sirena.org.uk>
References: <cover.1761564043.git.mazziesaccount@gmail.com>
 <28f888c9784058b2d727a4b6185ac49874552847.1761564043.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="RalfM7p0fJtqcro2"
Content-Disposition: inline
In-Reply-To: <28f888c9784058b2d727a4b6185ac49874552847.1761564043.git.mazziesaccount@gmail.com>
X-Cookie: How do I get HOME?


--RalfM7p0fJtqcro2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Oct 27, 2025 at 01:47:10PM +0200, Matti Vaittinen wrote:
> ROHM BD72720 is a power management IC which integrates 10 buck and 11 LDO
> regulators. This PMIC has plenty of commonalities with the BD71828 and
> BD71879.

Reviewed-by: Mark Brown <broonie@kernel.org>

--RalfM7p0fJtqcro2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmj/YmgACgkQJNaLcl1U
h9B5dAf/cu/765SnwjfbjyK4dMHR/rt+cksNZQ9fRPOg08y6Xlu3+MASYltjYY7J
yuZesa4qBrBafg4I9uRwOuEKJYY8AqDsCLQRZDAnEtCNeuxwgMG7dKumgzfFL/zJ
kPXRf+2b70A4hFCgfFzXH4Y9yfEARoTlD4saNAKu9PIv+AzEhcBZly5clyS0sKDZ
D/3c5woMxUiBGFJn3wWrWidDWMJ0D4gfxE5A2NBJ/LFLjqU8oWBd/+zKk4JOLmGA
lJYxz9LP1Qvl5wVZNX+xodzZ5fkWkgDoZJwik64DSaZq7X3AEKw2LzpmDPouSD0k
e9TQpuiElAnRZoU+EqqQ9A9QBRTceQ==
=IHgl
-----END PGP SIGNATURE-----

--RalfM7p0fJtqcro2--

