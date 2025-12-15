Return-Path: <linux-pm+bounces-39565-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D9546CBE157
	for <lists+linux-pm@lfdr.de>; Mon, 15 Dec 2025 14:33:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CDC9B305F0C5
	for <lists+linux-pm@lfdr.de>; Mon, 15 Dec 2025 13:25:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D788D2E8B9B;
	Mon, 15 Dec 2025 13:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="vvPAt/+j"
X-Original-To: linux-pm@vger.kernel.org
Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FC822D7D2E;
	Mon, 15 Dec 2025 13:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765804771; cv=none; b=DQOtlUVT6fzE8eKUItibkFM00HQ4zCfQqJ6OrGFybkR8jU+3zl/HYYStqpU39nVThOHN2Dgjn+0/yNGk+tQ23VMSImJdUqzu3rVLSQbjs+vuR4EMbTC6zXWnOS08k9FLi1vG8NATg3An05BXNP0QHHy9m4NEqnIZDJBfZK1G/vc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765804771; c=relaxed/simple;
	bh=RRQ+ojII8a3bdZhbASSmv70AEPy81yClPHvkI2I1Tl4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E+XySx7x3VyRpmXpfCLu7rwrr2Fx7xXcFcm5TzedqpyysU4q/+/cPr3XVhGeRaMc6JfGZX4lYzJzluy5f0V+MFOQjeul9s905aYHgMVYtlpztZVO+i/i1tgPqUmCFF00S5Pxw2pNeYkCE0SyVGu5V3f9S25O9v9HCN+p6IVcWTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=vvPAt/+j; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Mon, 15 Dec 2025 15:19:20 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1765804768; h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:in-reply-to:in-reply-to:  references:references;
	bh=RRQ+ojII8a3bdZhbASSmv70AEPy81yClPHvkI2I1Tl4=;
	b=vvPAt/+jqlNF6i2v28KE11HdCMDdi3BdbVSdMaYW84DjIgPyAAPdu4PYsnUcn/MYeRkvkX
	Zem0fMu9pL/GjyJD0YpGpxF9Gtlus9ySWjUZVXhKj6rrnPpROBsGWQDkU6nYdRUtXioA+m
	zYfgVOHjsC23LzNn9mTOPvJTKVzq5/c=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Matti Vaittinen <matti.vaittinen@linux.dev>
To: Matti Vaittinen <mazziesaccount@gmail.com>,
	Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc: Lee Jones <lee@kernel.org>, Pavel Machek <pavel@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Sebastian Reichel <sre@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
	linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org,
	linux-rtc@vger.kernel.org, Andreas Kemnade <andreas@kemnade.info>
Subject: [PATCH RESEND v6 08/17] mfd: rohm-bd71828: Use standard file header
 format
Message-ID: <3cc6176eee16a7edc75c94d967a1de67be400e97.1765804226.git.mazziesaccount@gmail.com>
Reply-To: Matti Vaittinen <mazziesaccount@gmail.com>
References: <cover.1765804226.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="KmAfR54qXSoF6+jK"
Content-Disposition: inline
In-Reply-To: <cover.1765804226.git.mazziesaccount@gmail.com>
X-Migadu-Flow: FLOW_OUT


--KmAfR54qXSoF6+jK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

=46rom: Matti Vaittinen <mazziesaccount@gmail.com>

The MFD subsystem uses C-style comments also in the 'file header'
section. Switch to this for the sake of the consistency. The header
content is not changed.

Suggested-by: Lee Jones <lee@kernel.org>
Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>

---
Revision history:
 v6 =3D> :
 - No changes

 v5 =3D> v6
 - New patch
---
 drivers/mfd/rohm-bd71828.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/mfd/rohm-bd71828.c b/drivers/mfd/rohm-bd71828.c
index 2a43005b67ee..218945a8ec94 100644
--- a/drivers/mfd/rohm-bd71828.c
+++ b/drivers/mfd/rohm-bd71828.c
@@ -1,8 +1,9 @@
 // SPDX-License-Identifier: GPL-2.0-only
-//
-// Copyright (C) 2019 ROHM Semiconductors
-//
-// ROHM BD71828/BD71815 PMIC driver
+/*
+ * Copyright (C) 2019 ROHM Semiconductors
+ *
+ * ROHM BD71828/BD71815 PMIC driver
+ */
=20
 #include <linux/gpio_keys.h>
 #include <linux/i2c.h>
--=20
2.52.0


--KmAfR54qXSoF6+jK
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmlACtgACgkQeFA3/03a
ocWCNAf/Qa3FTgFXMWA3z0gtRvQtx0NmWC1aKzyJvXpOAdiuKvcFfLKbjWujsJ/5
zNShtDyjeWYOjgU6nOhmmBH3rS8KHOW2fPQwV1+ENh8+w08HIyrfDs2BsRUzr3c/
YjT5g+m9w9mBse656P7S/M3PrEHR4xza/0e3qNHQ92tiscWi9uaI3/iFhQn+ZB52
kBxtZB0z9kB6meCKfhO/2bv7w8cWxa1reT+vqUzyj2AqNZgeXxNHOEuNN217NQXY
Uoa15nMMah6+tpzH/NUqHC56HXDlDYs0dBycPmS0dNeX1VVRFV9TFveJnGV67hjq
01K2zb+nlER7OrbiMK70UAgurUtEtQ==
=6mO/
-----END PGP SIGNATURE-----

--KmAfR54qXSoF6+jK--

