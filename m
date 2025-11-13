Return-Path: <linux-pm+bounces-37931-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 126E3C56825
	for <lists+linux-pm@lfdr.de>; Thu, 13 Nov 2025 10:11:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 6E3AA355F16
	for <lists+linux-pm@lfdr.de>; Thu, 13 Nov 2025 09:01:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCC1633ADAB;
	Thu, 13 Nov 2025 08:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="i6HACEtl"
X-Original-To: linux-pm@vger.kernel.org
Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A15D03396F1;
	Thu, 13 Nov 2025 08:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763024184; cv=none; b=CEJzmg0k4HGouyHv4+PbvsVq9V2ih93pfdJM3yDQOTuPzfGa/u2CcCGu0lrTaJJAuSLYoeW1FfZDoF/yjMgOKQcn4xcXYqjMX5dWQ1GfcTEPGH0HtcQF/iVRUf/kJJe8H0/RbpQpuLYqJXtF0PsDLlxppbvp8v2FAURjIPqsaQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763024184; c=relaxed/simple;
	bh=zp6SlYcPA6p/E0ySGHx+QoEp05+2+wht8ejef48Qeh8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lEQMIF1yKg+8Un3p2HqPfsgsX2UgG35eM10BThDAWdcHofHl1YmCJDfkl2hdgDZtbd3nUDhWh2BHIG9qPBIUCh9zvbMBySGqJDGtEfVdM0J0zgxjHpljPMTzrrar9CbEQKf2x7bPGFl4KqIZ+QmUe5Ky+UsBpSPDWi04kIBoqcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=i6HACEtl; arc=none smtp.client-ip=95.215.58.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 13 Nov 2025 10:56:10 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1763024180; h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:in-reply-to:in-reply-to:  references:references;
	bh=nWP3To9chHe8h02n9M1ldMghujzaU64BefpJAj3Yhlc=;
	b=i6HACEtlEZRTsOq0Aw420IWJzeqnYlQlHrCGC44aRMpphV+QM19Nkd3SWxR/8Rh+VPI1Wx
	YGN+xA5JY7HUIRIu9XqP51yViYUBKG2vuOAvUwSFyWUYnIzCJwJ3Kut3n0/z4NiKcvFHsa
	ajjEH3CAha+UqO/Fa252aB6HqDN6iyw=
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
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
	linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org,
	linux-rtc@vger.kernel.org, Andreas Kemnade <andreas@kemnade.info>
Subject: [PATCH v4 16/16] MAINTAINERS: Add ROHM BD72720 PMIC
Message-ID: <3aa7088ba93e0faac1010897e5da2f0541022d9f.1763022807.git.mazziesaccount@gmail.com>
Reply-To: Matti Vaittinen <mazziesaccount@gmail.com>
References: <cover.1763022807.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="a9hT/oob02Yt7ImX"
Content-Disposition: inline
In-Reply-To: <cover.1763022807.git.mazziesaccount@gmail.com>
X-Migadu-Flow: FLOW_OUT


--a9hT/oob02Yt7ImX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

=46rom: Matti Vaittinen <mazziesaccount@gmail.com>

Add the ROHM BD72720 PMIC driver files to be maintained by undersigned.

Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>

---
Revision history:
 RFCv1 =3D>:
 - No changes
---
 MAINTAINERS | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index fe01aa31c58b..7e3c1eac7cda 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -22353,6 +22353,7 @@ S:	Supported
 F:	drivers/clk/clk-bd718x7.c
 F:	drivers/gpio/gpio-bd71815.c
 F:	drivers/gpio/gpio-bd71828.c
+F:	drivers/gpio/gpio-bd72720.c
 F:	drivers/mfd/rohm-bd71828.c
 F:	drivers/mfd/rohm-bd718x7.c
 F:	drivers/mfd/rohm-bd9576.c
@@ -22369,6 +22370,7 @@ F:	drivers/watchdog/bd96801_wdt.c
 F:	include/linux/mfd/rohm-bd71815.h
 F:	include/linux/mfd/rohm-bd71828.h
 F:	include/linux/mfd/rohm-bd718x7.h
+F:	include/linux/mfd/rohm-bd72720.h
 F:	include/linux/mfd/rohm-bd957x.h
 F:	include/linux/mfd/rohm-bd96801.h
 F:	include/linux/mfd/rohm-bd96802.h
--=20
2.51.1


--a9hT/oob02Yt7ImX
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEyBAEBCgAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmkVnSoACgkQeFA3/03a
ocUZKQf3RnWEJD5XEsjYHiqpfGbSkxCyq2y+9UDyXdp8Wuq1kAvLxy1AgMgYRhSQ
Kgsi/BaCI4HQt1RS6SxDioeYjAslQzVgcDRCRi3Uzw9wp8VUHx7F1QtZ7UY1oEur
jE+IMZO4jPa0DF5EZAaxwaIPXmls2Lk/O3GYxMkeOdE7FR1vrFnY1EgiRv50W7QV
Ai0RXIpR56RHaFZUPcdAse7o5xlRmNfttvhTEiKQ5jPjz1TmkOKJeoRNCSPwutS8
t1i5GYgJ2MpQtdnmIEomcGfUA+Ul0xZCDGXuX2luQeTy1ncCy2Bsc2qVg7UL1iYN
xGOLD658Bmn8KrOss590oC5IroDe
=n6lR
-----END PGP SIGNATURE-----

--a9hT/oob02Yt7ImX--

