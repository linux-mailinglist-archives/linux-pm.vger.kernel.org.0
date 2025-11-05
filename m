Return-Path: <linux-pm+bounces-37416-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B00E8C344CD
	for <lists+linux-pm@lfdr.de>; Wed, 05 Nov 2025 08:41:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 834714F5EE5
	for <lists+linux-pm@lfdr.de>; Wed,  5 Nov 2025 07:40:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 214DD2DAFA5;
	Wed,  5 Nov 2025 07:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="TDkYgLTG"
X-Original-To: linux-pm@vger.kernel.org
Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B05D12D8371
	for <linux-pm@vger.kernel.org>; Wed,  5 Nov 2025 07:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762328373; cv=none; b=EOgHu9ZrswixX5r5rdEtIO+Nj/K/04+00+vdZloeZjTK9RL5DuZm/LRiRfdzFrKK3Xi/6wJEG9yFilqt3VDrpTmut0BZ12XQn8TPShOTAOdCMYdTXIhNGvjiDpgsNsUjhlY2KRzx1ONEoIF2H83tYUzB+zi3Lx3sII7qvbLxByU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762328373; c=relaxed/simple;
	bh=u0VVf8ZqHrJjYoFxcL413lScx3zM7KnGyo1FXINg9SM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fm/eB9x+sbnqoIhh+43ICNdYSu69oQVEIoqn7RpSOc9kg7GD0iS8dy5pUMscxFEDWC8e3cCUBq1GsH/jMGlsw/3JW54grB+zNgSpXXXkLhSkrSKBbB4N+Jy5KJuTt6R2jmu5pZlCpAhVLaInCLVPKVO8W+3cuSAwnIdZzM3L5ls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=TDkYgLTG; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 5 Nov 2025 09:39:21 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1762328369; h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:in-reply-to:in-reply-to:  references:references;
	bh=r86unFiu3koO7rhAE3NN9XZ/veKkNxb1YaySIAa69BA=;
	b=TDkYgLTGzJZ9mm/Iwt0wL4UKO2QS+Ki1P3Z72OHQxUDxU/IDy0iLudsg0PR9bO64ZCm4aW
	n+49sT2VfC8+NkTCADDnzjqYQc+JdIFq20pEoKdxrmCd9bE81sqtMRE7QVHd197gzWCfrx
	1fbmVe4lj47jpCtBnjyNCK4Z3L03HAg=
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
Subject: [PATCH v3 13/16] rtc: bd70528: Support BD72720 rtc
Message-ID: <f4007a3572111bc522f91f1a455a22094cdc5392.1762327887.git.mazziesaccount@gmail.com>
Reply-To: Matti Vaittinen <mazziesaccount@gmail.com>
References: <cover.1762327887.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="NgQJ7vh4x8uZ5ndB"
Content-Disposition: inline
In-Reply-To: <cover.1762327887.git.mazziesaccount@gmail.com>
X-Migadu-Flow: FLOW_OUT


--NgQJ7vh4x8uZ5ndB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

=46rom: Matti Vaittinen <mazziesaccount@gmail.com>

The BD72720 has similar RTC block as a few other ROHM PMICs.

Add support for BD72720 RTC.

Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
Acked-by: Alexandre Belloni <alexandre.belloni@bootlin.com>

---
Revision history:
 RFCv1 =3D>:
 - No changes
---
 drivers/rtc/Kconfig       |  3 ++-
 drivers/rtc/rtc-bd70528.c | 21 ++++++++++++++-------
 2 files changed, 16 insertions(+), 8 deletions(-)

diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
index 2933c41c77c8..418f6c28847a 100644
--- a/drivers/rtc/Kconfig
+++ b/drivers/rtc/Kconfig
@@ -561,7 +561,8 @@ config RTC_DRV_BD70528
 	depends on MFD_ROHM_BD71828
 	help
 	  If you say Y here you will get support for the RTC
-	  block on ROHM BD71815 and BD71828 Power Management IC.
+	  block on ROHM BD71815, BD71828 and BD72720 Power
+	  Management ICs.
=20
 	  This driver can also be built as a module. If so, the module
 	  will be called rtc-bd70528.
diff --git a/drivers/rtc/rtc-bd70528.c b/drivers/rtc/rtc-bd70528.c
index 954ac4ef53e8..4c8599761b2e 100644
--- a/drivers/rtc/rtc-bd70528.c
+++ b/drivers/rtc/rtc-bd70528.c
@@ -7,6 +7,7 @@
 #include <linux/bcd.h>
 #include <linux/mfd/rohm-bd71815.h>
 #include <linux/mfd/rohm-bd71828.h>
+#include <linux/mfd/rohm-bd72720.h>
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/platform_device.h>
@@ -262,13 +263,13 @@ static int bd70528_probe(struct platform_device *pdev)
=20
 		/*
 		 * See also BD718XX_ALM_EN_OFFSET:
-		 * This works for BD71828 and BD71815 as they have same offset
-		 * between ALM0 start and ALM0_MASK. If new ICs are to be
-		 * added this requires proper check as ALM0_MASK is not located
-		 * at the end of ALM0 block - but after all ALM blocks so if
-		 * amount of ALMs differ the offset to enable/disable is likely
-		 * to be incorrect and enable/disable must be given as own
-		 * reg address here.
+		 * This works for BD71828, BD71815, and BD72720 as they all
+		 * have same offset between the ALM0 start and the ALM0_MASK.
+		 * If new ICs are to be added this requires proper check as
+		 * the  ALM0_MASK is not located at the end of ALM0 block -
+		 * but after all ALM blocks. If amount of ALMs differ, the
+		 * offset to enable/disable is likely to be incorrect and
+		 * enable/disable must be given as own reg address here.
 		 */
 		bd_rtc->bd718xx_alm_block_start =3D BD71815_REG_RTC_ALM_START;
 		hour_reg =3D BD71815_REG_HOUR;
@@ -278,6 +279,11 @@ static int bd70528_probe(struct platform_device *pdev)
 		bd_rtc->bd718xx_alm_block_start =3D BD71828_REG_RTC_ALM_START;
 		hour_reg =3D BD71828_REG_RTC_HOUR;
 		break;
+	case ROHM_CHIP_TYPE_BD72720:
+		bd_rtc->reg_time_start =3D BD72720_REG_RTC_START;
+		bd_rtc->bd718xx_alm_block_start =3D BD72720_REG_RTC_ALM_START;
+		hour_reg =3D BD72720_REG_RTC_HOUR;
+		break;
 	default:
 		dev_err(&pdev->dev, "Unknown chip\n");
 		return -ENOENT;
@@ -337,6 +343,7 @@ static int bd70528_probe(struct platform_device *pdev)
 static const struct platform_device_id bd718x7_rtc_id[] =3D {
 	{ "bd71828-rtc", ROHM_CHIP_TYPE_BD71828 },
 	{ "bd71815-rtc", ROHM_CHIP_TYPE_BD71815 },
+	{ "bd72720-rtc", ROHM_CHIP_TYPE_BD72720 },
 	{ },
 };
 MODULE_DEVICE_TABLE(platform, bd718x7_rtc_id);
--=20
2.51.0


--NgQJ7vh4x8uZ5ndB
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmkK/ykACgkQeFA3/03a
ocWImwf/WY7gh5m0da4TXxuA8PLGZu7hGciU2Vker6Re6XPjElNRNwfGRbHy3z+C
Kduzpa2NCahG8bLWTxAalMpC8lyahmC7TWO73z075gQ4HG0TWWR6jrdyaJrc5FGK
FEQ1faPVBnLz/KFiXkr3lIrGIqZfX7DG1EGXZAVFuefl2M8/GDO3mp0Nbi7z62nL
sWxwCJImr/mvxXPYC8OENsEgExRx7HLrNIW/FkYc3a4C2uO2sW3uAEVCWKD3+MYf
5+v5Vn64gVSy9ND4xbmEGeOFvFqCt12zYQFE7wyztZVKiSY8c9k1KNFqVGKwvcbB
HAoDjZ+P5IXuc34pNhCShrw2onkeEg==
=aPaT
-----END PGP SIGNATURE-----

--NgQJ7vh4x8uZ5ndB--

