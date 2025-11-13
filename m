Return-Path: <linux-pm+bounces-37927-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A7B7C567AC
	for <lists+linux-pm@lfdr.de>; Thu, 13 Nov 2025 10:06:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id F02DF4E769F
	for <lists+linux-pm@lfdr.de>; Thu, 13 Nov 2025 08:59:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DE83340295;
	Thu, 13 Nov 2025 08:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="So2O3v+L"
X-Original-To: linux-pm@vger.kernel.org
Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77945333757
	for <linux-pm@vger.kernel.org>; Thu, 13 Nov 2025 08:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763024116; cv=none; b=lZK5v5reA6OPHRcwVJtgF8StQ9eioUm8uXK+Gv/ftLgcD/Hnrhe6RVckmxDVxP3KMoCeE/577mHSzGOJxOgxop1yoDY+x7ZykOeMWjzpdQi4ZllfnrPrKOlHfrUwIdDf8ne/9n2K5gb+RZKSY2ciVTC096W0ASUIERUc/Rb+hok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763024116; c=relaxed/simple;
	bh=aYAFBOmIDFUMQV6gG3t1EytSgPZy68GCCSwjeK6BuKU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jfv5ecDch44h6QdWG4WhbzkUyION79khJYxK0XuNGfIDh0bSPp2YMpZq7mgAte3veNQ/IY6QID/QOen6NLQh4bZKhJ23dX212d2SiR8MW0Nkt9/y/TiBq5qBYy65pItWYAwGVdzzs3VtwRTgYR+TZn9nFOgp4B8UHgyeGcrMNjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=So2O3v+L; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 13 Nov 2025 10:55:05 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1763024112; h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:in-reply-to:in-reply-to:  references:references;
	bh=p9urlC6OYIR48/xBlBNJmUBEIXy9CGBQiYwyq3/Edqo=;
	b=So2O3v+LVwFK2S64xBJiUtIme4zYkKv9HwajY0uINWOLndzvvhXgmd5jcUA2hSgMPXgRIL
	DLOjLJ314sosEuxAl8XJg76FufAJrhTX8Ro8sypWmk7hq+fhmNh5JgEkQVRp4x95nV4h1u
	KOGxjt0jhE5VuVZB+SMiTv0Worn8tyU=
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
Subject: [PATCH v4 12/16] clk: clk-bd718x7: Support BD72720 clk gate
Message-ID: <16c92cc14da67ec6354ee0ac4e1faef4af4d0994.1763022807.git.mazziesaccount@gmail.com>
Reply-To: Matti Vaittinen <mazziesaccount@gmail.com>
References: <cover.1763022807.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="eEHz2p03zw8+XRiI"
Content-Disposition: inline
In-Reply-To: <cover.1763022807.git.mazziesaccount@gmail.com>
X-Migadu-Flow: FLOW_OUT


--eEHz2p03zw8+XRiI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

=46rom: Matti Vaittinen <mazziesaccount@gmail.com>

The BD72720 has similar simple clk gate as a few other ROHM PMICs.

Add support for BD72720 clk gate.

Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>

---
Revision history:
 RFCv1 =3D>:
 - No changes
---
 drivers/clk/Kconfig       |  4 ++--
 drivers/clk/clk-bd718x7.c | 10 ++++++++--
 2 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
index 3a1611008e48..619bd63a3c77 100644
--- a/drivers/clk/Kconfig
+++ b/drivers/clk/Kconfig
@@ -475,8 +475,8 @@ config COMMON_CLK_BD718XX
 	tristate "Clock driver for 32K clk gates on ROHM PMICs"
 	depends on MFD_ROHM_BD718XX || MFD_ROHM_BD71828
 	help
-	  This driver supports ROHM BD71837, BD71847, BD71850, BD71815
-	  and BD71828 PMICs clock gates.
+	  This driver supports ROHM BD71837, BD71847, BD71850, BD71815,
+	  BD71828, and BD72720 PMICs clock gates.
=20
 config COMMON_CLK_FIXED_MMIO
 	bool "Clock driver for Memory Mapped Fixed values"
diff --git a/drivers/clk/clk-bd718x7.c b/drivers/clk/clk-bd718x7.c
index ac40b669d60b..1cae974e6d1d 100644
--- a/drivers/clk/clk-bd718x7.c
+++ b/drivers/clk/clk-bd718x7.c
@@ -19,7 +19,8 @@
 #define BD71828_REG_OUT32K	0x4B
 /* BD71837 and BD71847 */
 #define BD718XX_REG_OUT32K	0x2E
-
+/* BD72720 */
+#define BD72720_REG_OUT32K	0x9a
 /*
  * BD71837, BD71847, and BD71828 all use bit [0] to clk output control
  */
@@ -118,6 +119,10 @@ static int bd71837_clk_probe(struct platform_device *p=
dev)
 		c->reg =3D BD71815_REG_OUT32K;
 		c->mask =3D CLK_OUT_EN_MASK;
 		break;
+	case ROHM_CHIP_TYPE_BD72720:
+		c->reg =3D BD72720_REG_OUT32K;
+		c->mask =3D CLK_OUT_EN_MASK;
+		break;
 	default:
 		dev_err(&pdev->dev, "Unknown clk chip\n");
 		return -EINVAL;
@@ -146,6 +151,7 @@ static const struct platform_device_id bd718x7_clk_id[]=
 =3D {
 	{ "bd71847-clk", ROHM_CHIP_TYPE_BD71847 },
 	{ "bd71828-clk", ROHM_CHIP_TYPE_BD71828 },
 	{ "bd71815-clk", ROHM_CHIP_TYPE_BD71815 },
+	{ "bd72720-clk", ROHM_CHIP_TYPE_BD72720 },
 	{ },
 };
 MODULE_DEVICE_TABLE(platform, bd718x7_clk_id);
@@ -161,6 +167,6 @@ static struct platform_driver bd71837_clk =3D {
 module_platform_driver(bd71837_clk);
=20
 MODULE_AUTHOR("Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>");
-MODULE_DESCRIPTION("BD718(15/18/28/37/47/50) and chip clk driver");
+MODULE_DESCRIPTION("BD718(15/18/28/37/47/50) and BD72720 chip clk driver");
 MODULE_LICENSE("GPL");
 MODULE_ALIAS("platform:bd718xx-clk");
--=20
2.51.1


--eEHz2p03zw8+XRiI
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmkVnOkACgkQeFA3/03a
ocXIFAf/dTWebPRaTV3vBZaxLueuxBYLcF0xQHPRMDwXJHLta80As4drk1FI7DLm
rvrHJmBiO5Bo4wqweiPnvetGUYOUj3qHK22oFs+VLaAmwESHd1AWYKDwYyJsgUCU
RnL6d5OrrCI+wpcg+/E3rq95ObjRHE8p4ioEPgaxfzFyypgTRZ/lcxWnNXVucNK3
690umWyZS90F9IsGcg1qEbT1KfXHt4aXVvdq7+/R5Kx4FolUZAJRtESfNvwkN7SZ
pNkmdVd3ofCLQUxDAu2vea0UKc8aleMUIsyc5dy3X/85y/zoz9zxCIA+NWvxPRme
d2a8ndI059XouOBozwmEqhRMvP9zcg==
=g766
-----END PGP SIGNATURE-----

--eEHz2p03zw8+XRiI--

