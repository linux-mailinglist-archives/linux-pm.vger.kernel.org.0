Return-Path: <linux-pm+bounces-1033-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED9E0810B48
	for <lists+linux-pm@lfdr.de>; Wed, 13 Dec 2023 08:16:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A90ED2811C9
	for <lists+linux-pm@lfdr.de>; Wed, 13 Dec 2023 07:16:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48D4A18053;
	Wed, 13 Dec 2023 07:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XkJyYqUq"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1288C17742;
	Wed, 13 Dec 2023 07:16:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 022A2C433C8;
	Wed, 13 Dec 2023 07:16:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702451767;
	bh=rjW4FqNS7dqFf2D6s0wEqUZechtIxjdG/6g1Uueb+xU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XkJyYqUqmsv8rO254rdUW4eXIFC+gLoifUFXtE7qCu7DsCIBON/xSS0U0wc21QazB
	 rJK8Lq60VmOKEcAS3bIh5/xesPMvfpwujc4U7mejCJcNShGXQXY+2tvEMdgA2cSOzV
	 zMUrYTcAi4ytjc2q1YjCXcUYEjp5b4r4MbsUbSVpzz5/TRYnrhPrdHCwssy6siBKVA
	 4g3d+lWT/ZEApSO5LSYHOKo3uawaCfiDJtwvdfr33JCmtluqt6RM8Rdz6/tufvqvOr
	 tMV3BKbcKQwe5paAnsZTd+kTQI40qefYumD/PkP7gptEep5V/lYPBjk/RJk2g6gFGl
	 mQbcT5pj2oZFw==
Date: Wed, 13 Dec 2023 08:16:04 +0100
From: Maxime Ripard <mripard@kernel.org>
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Michael Turquette <mturquette@baylibre.com>, 
	Stephen Boyd <sboyd@kernel.org>, Russell King <linux@armlinux.org.uk>, linux-clk@vger.kernel.org, 
	MyungJoo Ham <myungjoo.ham@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, 
	Chanwoo Choi <cw00.choi@samsung.com>, Chen-Yu Tsai <wens@csie.org>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>, linux-pm@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev, 
	Neil Armstrong <neil.armstrong@linaro.org>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
	Daniel Vetter <daniel@ffwll.ch>, Kevin Hilman <khilman@baylibre.com>, 
	Jerome Brunet <jbrunet@baylibre.com>, Martin Blumenstingl <martin.blumenstingl@googlemail.com>, 
	dri-devel@lists.freedesktop.org, linux-amlogic@lists.infradead.org, 
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Thierry Reding <thierry.reding@gmail.com>, 
	Jonathan Hunter <jonathanh@nvidia.com>, Rob Herring <robh@kernel.org>, linux-tegra@vger.kernel.org, 
	Johan Hovold <johan+linaro@kernel.org>, Georgi Djakov <djakov@kernel.org>, kernel@pengutronix.de
Subject: Re: [PATCH 0/5] clk: Make clk_rate_exclusive_get() return void
Message-ID: <ki5n3rz5n4oxj2hhc3rj6xpn3e2tdi7fcp2q7exjbzilrlqflp@przautvhuy4g>
References: <cover.1702400947.git.u.kleine-koenig@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="m7hyngpcks2t5pei"
Content-Disposition: inline
In-Reply-To: <cover.1702400947.git.u.kleine-koenig@pengutronix.de>


--m7hyngpcks2t5pei
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Dec 12, 2023 at 06:26:37PM +0100, Uwe Kleine-K=F6nig wrote:
> Hello,
>=20
> clk_rate_exclusive_get() returns zero unconditionally. Most users "know"
> that and don't check the return value. This series fixes the four users
> that do error checking on the returned value and then makes function
> return void.
>=20
> Given that the changes to the drivers are simple and so merge conflicts
> (if any) should be easy to handle, I suggest to merge this complete
> series via the clk tree.

I don't think it's the right way to go about it.

clk_rate_exclusive_get() should be expected to fail. For example if
there's another user getting an exclusive rate on the same clock.

If we're not checking for it right now, then it should probably be
fixed, but the callers checking for the error are right to do so if they
rely on an exclusive rate. It's the ones that don't that should be
modified.

Maxime

--m7hyngpcks2t5pei
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCZXlaNAAKCRDj7w1vZxhR
xdMoAP0SfIOFl6Fc7FcIbVyoWZh/iWhJLszL7a709z02B76E0QEApMmexIdN3NIS
P/kaPqH5SfyvBxS6tWkFW1spZ1vSVQE=
=f1uM
-----END PGP SIGNATURE-----

--m7hyngpcks2t5pei--

