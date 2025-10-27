Return-Path: <linux-pm+bounces-36908-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 68F75C0D71C
	for <lists+linux-pm@lfdr.de>; Mon, 27 Oct 2025 13:14:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 96AD6189D3A8
	for <lists+linux-pm@lfdr.de>; Mon, 27 Oct 2025 12:15:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0E003009C8;
	Mon, 27 Oct 2025 12:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LVFbo6i0"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DDB2EEAB;
	Mon, 27 Oct 2025 12:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761567268; cv=none; b=gtlsnLAihHoYdm5mnZg7jm7wdBdfXuQiSdfcR7A4jgXD4lnpM2HUudWsf+dv1LsAtVk60sgZM/f03rULUAlLsCvHi94tNdaAQspuQvS6oDjqfU/ikjFEjMR0b3QSx857frudb5boCiss3V4HYlwT48BudepLRnE+oqQeCfAeLw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761567268; c=relaxed/simple;
	bh=rWHdHSJPVLgMn3etblo03n9fmEXg8Q3LI4UBHrXAqeU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ljx86qHU0TtHlw2dxbCM6bVb9wQEIdzWFRe1LPN5Xv/abCQpgnavuX8k9PQyxjDlm6nhUkuUov8jXE8Xh3dOhmHMu6BynzKLloSC6U8ygODoGSfNuw1Evn3bGh64yb/1hNvelukuqGDXO5cBEj4m9llxzhaXzsn+tb4gUcq5Dbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LVFbo6i0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DF80C4CEF1;
	Mon, 27 Oct 2025 12:14:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761567268;
	bh=rWHdHSJPVLgMn3etblo03n9fmEXg8Q3LI4UBHrXAqeU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LVFbo6i0j8oUWrOC68//sH6s67P3CS8SShwRk1eyPZOI7fZ8dKHEN+el+eCGZH426
	 /SvlLPhf48fwtfjRMFPs3tsBVc6ES6/P7rckdD/WvDk9+G9dz35Db+G6031yEmjUy5
	 EqHHJvE5nAnM24ht3FoM+X+sfmwZtHu0l48tdWvefHMndQMNwoMKH+MVXdGccnAruQ
	 MvPhWh/8oxl7KP9n4xbWYYagRxRBtBJVVomhkI0qtbfZ85Tb/W+ndI0wRWSACsmIv3
	 XAiSeyclFV6nDNr0XcTKDFETTGsEWbOlYAlG9kpG/JEeVCZ+UUSntUrBNiZlA2h7hv
	 6b2naZCEO9G3w==
Date: Mon, 27 Oct 2025 12:14:18 +0000
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
Subject: Re: [PATCH v2 08/15] regulator: bd71828: rename IC specific entities
Message-ID: <c4bdf649-0623-4529-b8e9-43d6701f0111@sirena.org.uk>
References: <cover.1761564043.git.mazziesaccount@gmail.com>
 <aa2b31267e6cc93bad4c823ef1ba07ba43efd572.1761564043.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="IGal/9MH6MaJjMWW"
Content-Disposition: inline
In-Reply-To: <aa2b31267e6cc93bad4c823ef1ba07ba43efd572.1761564043.git.mazziesaccount@gmail.com>
X-Cookie: How do I get HOME?


--IGal/9MH6MaJjMWW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Oct 27, 2025 at 01:46:57PM +0200, Matti Vaittinen wrote:
> The new ROHM BD72720 PMIC has similarities with the BD71828. It makes
> sense to support the regulator control for both PMICs using the same
> driver. It is often more clear to have the IC specific functions and
> globals named starting with the chip-name. So, as a preparatory step,
> prefix the BD71828 specific functions and globals with the bd71828.

Acked-by: Mark Brown <broonie@kernel.org>

--IGal/9MH6MaJjMWW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmj/YhkACgkQJNaLcl1U
h9Af5Af6Ax86Rk1w2Lm8l+WtM+HeqNG9SJTaC/xDAlF9R/wpX008syrILJMQXVEF
BaXHf+QKJMvTFJeM3pSzKKdQ5NJmoPKlUtKiXSNBhceZGLet2eXw/MuqNR4nRmFC
2iVksMbfY+P3YPg8ebdn6Zf1icxTngM1raSOPPQMeVAMDt+6MLxdKYbg0I+DMhG1
Xp9Nz99ObSw5UinFmo7l2ZLaXsNnkQ8jRV4rS2C5uTV0vszr0Op+ym/9KAyLs+N/
TVnbQ7H+84sRYeLEg/4JIzYyW7tDlg7EerOaP75F9MstIULAFDDZaHRVtVlAKxPV
BSxxGZyJlVVu6loQH4yvZQimzgUWBQ==
=lhBS
-----END PGP SIGNATURE-----

--IGal/9MH6MaJjMWW--

