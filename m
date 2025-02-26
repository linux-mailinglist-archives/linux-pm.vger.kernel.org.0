Return-Path: <linux-pm+bounces-23034-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9836BA46ED0
	for <lists+linux-pm@lfdr.de>; Wed, 26 Feb 2025 23:55:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A99116DCCB
	for <lists+linux-pm@lfdr.de>; Wed, 26 Feb 2025 22:55:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C8CB25E836;
	Wed, 26 Feb 2025 22:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UE4RPiIm"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BFE825E82D;
	Wed, 26 Feb 2025 22:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740610518; cv=none; b=HoXE9lFT83GW/nf5SySzNqKZqMAgtXfnJRbi9vdOrmlxNmndwV3g2eL3Uu3QVq/O6WNHVU2gO9oOmQ6gWU3LNBuFfdSVICKRXRsDJjJmF+h7e+koUVoprLuj+wezpC177INNOUOHnPutIG/m1VX4lgzAhsTIckVWjAVScmxvaGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740610518; c=relaxed/simple;
	bh=3rualdVsZ0rnSLUknJnwEmuB93Nt/mrluRr78WdEdIM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UYpBLJJGHXb1qobUzcTlmwpWucUnzt4MSjdIxUDDv+NDOr38r3Fa/JKaQRE5xgHeQQYfOjKVpxRPsdjUXmyFnwENPjIkA/c8bsveLo9FAvYr2q0t+O2fQBC6J5yiepbp0osAJfEexhIBEFFSaYzvy3LzJqlgu6GbEYRdyrFoxBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UE4RPiIm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CAF4C4CED6;
	Wed, 26 Feb 2025 22:55:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740610517;
	bh=3rualdVsZ0rnSLUknJnwEmuB93Nt/mrluRr78WdEdIM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UE4RPiImGNejxCgGvcmt+qoRUzr6PSyoLUkPypdhGaXcKaVH67Z+ogZJ1cvqtZ17H
	 q4O2UtzyGkJA25bOgFBPVWd9MEuva8LWVqRqiYqMlB9nyXGSvdhypCElfmOqt1FgFS
	 yZwQD+OFIRr0PdLIL8DrumvaZ5fc2lLIvqufKydh9zHcW2f8QaT1Davb+8b7erL5K+
	 q14iwyqgXnwdb6Pf8SukIe6AJJ2ISWRUyKFYjbYZvTiPRLeGe+GhQAiOemBEUBr6Xz
	 XTOeRc8fWokBq1l++rJElbPNZw93bc78zvhxOBuOgAml3aBHxj50A6Fv0Np67VfAJt
	 GohZrtUQ8jvFQ==
Date: Wed, 26 Feb 2025 22:55:10 +0000
From: Mark Brown <broonie@kernel.org>
To: Ahmad Fatoum <a.fatoum@pengutronix.de>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Fabio Estevam <festevam@denx.de>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
	Jonathan Corbet <corbet@lwn.net>, Serge Hallyn <serge@hallyn.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	Benson Leung <bleung@chromium.org>,
	Tzung-Bi Shih <tzungbi@kernel.org>,
	Guenter Roeck <groeck@chromium.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	chrome-platform@lists.linux.dev, devicetree@vger.kernel.org,
	kernel@pengutronix.de
Subject: Re: [PATCH v3 08/12] regulator: allow user configuration of hardware
 protection action
Message-ID: <f3a1ae24-6ee0-43d7-8648-cf25ac139960@sirena.org.uk>
References: <20250217-hw_protection-reboot-v3-0-e1c09b090c0c@pengutronix.de>
 <20250217-hw_protection-reboot-v3-8-e1c09b090c0c@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="69+QFFE4FM9qynJX"
Content-Disposition: inline
In-Reply-To: <20250217-hw_protection-reboot-v3-8-e1c09b090c0c@pengutronix.de>
X-Cookie: I've been there.


--69+QFFE4FM9qynJX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Feb 17, 2025 at 09:39:48PM +0100, Ahmad Fatoum wrote:
> When the core detects permanent regulator hardware failure or imminent
> power failure of a critical supply, it will call hw_protection_shutdown
> in an attempt to do a limited orderly shutdown followed by powering off
> the system.

Not that it matters at this point but

Reviewed-by: Mark Brown <broonie@kernel.org>

--69+QFFE4FM9qynJX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAme/m80ACgkQJNaLcl1U
h9BMTQf9EPlgFM5IHJeDldbatcC7CEidjNZXpHX8EVgKK1b4TRFL1eAxjG0TbxD2
uMRhc02ghjwIGueCDC/fq7Ziivq6rpmWNQc3RBZMXP499VIVnBvSEFYCryeohXkj
kKdWMjGH468A5J4qa6IiCdzpRJB/lyhyiU0Rjup9YKdpC+LFhjvWR7N4oqAUmzss
k16nd/Nw3lEs23Kd3FoJ+TfQImtUm3QQ2doQyWcFgbpoO2uOI4X40LXVb6RKLq39
RtuDh+WWEFjQeByjIrHjQ9HHn4aTpYKE4aqVKRGpwHlWr5pQqfIcyg2NDjUfrBGT
bdyJw53DkC0StS3yRxrJo3Yp5iQqhg==
=zpJM
-----END PGP SIGNATURE-----

--69+QFFE4FM9qynJX--

