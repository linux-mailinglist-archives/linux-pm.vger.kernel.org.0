Return-Path: <linux-pm+bounces-39570-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 47A3ECBE12A
	for <lists+linux-pm@lfdr.de>; Mon, 15 Dec 2025 14:31:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0800E300D652
	for <lists+linux-pm@lfdr.de>; Mon, 15 Dec 2025 13:31:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C945C32A3FD;
	Mon, 15 Dec 2025 13:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="FguL3AOj"
X-Original-To: linux-pm@vger.kernel.org
Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB8E632862E
	for <linux-pm@vger.kernel.org>; Mon, 15 Dec 2025 13:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765804846; cv=none; b=kkHFzESZTORJwWYQcN2PkFU/1+vhayn/tq0S3m2fatIz6h4J2MtcxCEeEHmcMEJiX+y2hM/Hsyt/89jSr53rmbU3psfIOfk8K1vkPkdQzxEcNZIKzp+Zpl8XdkWKGLM+NWu9UaDVwWroBF6EWTymWMuTx5EX1TSSVf2GT0qv4Tc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765804846; c=relaxed/simple;
	bh=tWXTuMmd9qNBh/tJZlkP5bQal1tFpPdbSS1MVywLD2E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KIsPo1RObrziGtG5HZ05+k1+1dpr60jFhU+mysOMUQZXdUO6zopxTjn2gIM57UbMfFyHAkdBGthe5E0U0DLgzzE4oR/Xlocw+Dcl25ga1PwfhvI4p0azti2Bt0IYtcov3n8qZHFYuyxC+NbAKEiApbAaQOCzNWxxPUxsTc1DuSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=FguL3AOj; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Mon, 15 Dec 2025 15:20:37 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1765804843; h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:in-reply-to:in-reply-to:  references:references;
	bh=BXTNPYAia8/vYsrVtwHiHHcngiJkCzd4DGfT+o6VYYs=;
	b=FguL3AOjQiCpsXoNu8JaOM51ZK1o+b97lbcvpN3fiZYUEAc62If2tbHgOg0Uk2wdnsRaJr
	yj8VcSP9Z5mSShPP+e7BD16NKRpo7MOsADdfUx/LibjdZls21welzZiqXk2/AEub3ySywc
	wN/I4LbMJfti2mnczqBq1LjGpf4JfY4=
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
Subject: [PATCH RESEND v6 13/17] clk: clk-bd718x7: Support BD72720 clk gate
Message-ID: <742e76cd0b87e726818d4fddc534a29298697b6b.1765804226.git.mazziesaccount@gmail.com>
Reply-To: Matti Vaittinen <mazziesaccount@gmail.com>
References: <cover.1765804226.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="9MjrILCrb8+eJPvM"
Content-Disposition: inline
In-Reply-To: <cover.1765804226.git.mazziesaccount@gmail.com>
X-Migadu-Flow: FLOW_OUT


--9MjrILCrb8+eJPvM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

=46rom: Matti Vaittinen <mazziesaccount@gmail.com>

The BD72720 has similar simple clk gate as a few other ROHM PMICs.

Add support for BD72720 clk gate.

Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
Acked-by: Stephen Boyd <sboyd@kernel.org>

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
2.52.0


--9MjrILCrb8+eJPvM
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmlACyUACgkQeFA3/03a
ocVm2gf/TptgAgvYLweha8P2crX/2iypH76u3lOEfT0HkfVjEVhJzR+a/osAuBZH
jeYkvUBUuQc5RFOLIGMzi8ue5vUpV6jOfyhV5mBSzkI6IpHPNxnUop6SLJImKp26
LEq6lG0nR9pKSavaxK+pa9nhfOIAwKsA06J+flm95Ysc5vTUEZKB60wqjh7KbD9q
e68dhs1XDSVp7daqZj/OcgEfabRMjahlbdtrtYR7Goof96wmmoCKO5YQYa2cD9YC
MJZgKB1TYRcSZLDl0YIbWPLAweFLWs0ZmvMxUo/AhutCpZjtybAlHJJxeqhec7BN
5iKKchwvud+JQFrI1ipoclbso+K5lg==
=yT4F
-----END PGP SIGNATURE-----

--9MjrILCrb8+eJPvM--

