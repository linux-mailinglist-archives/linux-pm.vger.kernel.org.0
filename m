Return-Path: <linux-pm+bounces-38287-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A4FDDC72E56
	for <lists+linux-pm@lfdr.de>; Thu, 20 Nov 2025 09:34:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3846C4F0042
	for <lists+linux-pm@lfdr.de>; Thu, 20 Nov 2025 08:28:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 082FB30CDA8;
	Thu, 20 Nov 2025 08:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="KGHCJoB/"
X-Original-To: linux-pm@vger.kernel.org
Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B8A12868A7
	for <linux-pm@vger.kernel.org>; Thu, 20 Nov 2025 08:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763627101; cv=none; b=cl8B7P/OYYyqHSj2s/Vs3LM+I6J5Qi6X+vKiTVfW19qPaZ8LHaYr/csyOFaJouwctPRcB4FKDSMFSgujCNz+wvoKEHOKW28nOtHC5e6rGousSrPPVB+JYYuQa3hGWNbrP/Se4SCtnTzKiBur9q6jB1LtXAv2XlPwNtQyDInWWSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763627101; c=relaxed/simple;
	bh=/URspMwi0aVSS/ick5FKIA5TYBjSK/fshGcFbCh4ZPw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pxWyMCWOAApPtNrhL5Wl13/+8quJn145fF4ihgmPUxYdax9wPmQh9tZM+wfKauTvaQ4QUNo8D1qSdlNMpAqr5VUT/Kpafy2sLf5xYkjDQuqYWpF/wUOf8WADjd7T2tRmZ/jlrNqCLq9wYu1xtW9+V1R0k6Faqof1TJ76wVWQ+SI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=KGHCJoB/; arc=none smtp.client-ip=95.215.58.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 20 Nov 2025 10:24:51 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1763627098; h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:in-reply-to:in-reply-to:  references:references;
	bh=p88VulGk2JaMA32I5QN5fsfeIzryjPyEAU1nuOgbfrk=;
	b=KGHCJoB/O1q3zzMrwBX/UA+vj3Rj7LsRzQBYeySMo0DFZe2UsPYIA8rwEQkhh/pP9KFeFW
	X8uv+4qPJMP8ON8DYzYK8r0QKj/9Id98DaeRQLHCLg5w8Vx4eYFQi7qKBqRtRk3AX9RK5C
	OpH5WtoCUociuHcZDZCbohn7Mf8MsuI=
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
Subject: [PATCH v5 16/16] MAINTAINERS: Add ROHM BD72720 PMIC
Message-ID: <aa88aaef1053637c92151b650dace008a8c944bd.1763625920.git.mazziesaccount@gmail.com>
Reply-To: Matti Vaittinen <mazziesaccount@gmail.com>
References: <cover.1763625920.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="K6KL7elxn70W0mtV"
Content-Disposition: inline
In-Reply-To: <cover.1763625920.git.mazziesaccount@gmail.com>
X-Migadu-Flow: FLOW_OUT


--K6KL7elxn70W0mtV
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


--K6KL7elxn70W0mtV
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmke0FMACgkQeFA3/03a
ocXQxAf9FkdZwqcS/RV2VhZP9i3bTHFdlhOsiiOpfF96DmTjsesFMRhEaRwSwpzN
g9mDGunpYRAlRAnPbObBZe8XP1xttT04AUBcYk5MlulNqE/oycmF0gmRiwzGyzNg
lAjsB3u0FyVqdJkAoMSHFC/PMlAugRqO1jVuLDizfkX4dkHmYJA6l87N4llR9L7Y
IBxKI4a1mj86W/CqQD9k4V/rykw+ZtdFfHHEclwrsAZb52AVXAeOc82RJ6IU/oTz
8Zlg7LsDOC2/eLxNi8GP/MjXUvxTOABNxVwH29G2yWezshE3RBGoAn5wE5ddGOPY
kBfwjpUhZdRw8jUwJyU77TNWdx8Qag==
=Q492
-----END PGP SIGNATURE-----

--K6KL7elxn70W0mtV--

