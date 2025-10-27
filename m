Return-Path: <linux-pm+bounces-36902-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A5371C0D542
	for <lists+linux-pm@lfdr.de>; Mon, 27 Oct 2025 12:55:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC745407A9E
	for <lists+linux-pm@lfdr.de>; Mon, 27 Oct 2025 11:48:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C77763002CE;
	Mon, 27 Oct 2025 11:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fu084Giv"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66E353002B6
	for <linux-pm@vger.kernel.org>; Mon, 27 Oct 2025 11:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761565666; cv=none; b=cRVklFDOTIXRGuzRMUUGXa1J2EPgTa3NHaR87+PA3tIqyHeneqMgBtQZg8ytCLdjZ/NxfVlaNHu4A/o/+IihKgLuEyf4XD+ojDFVg2bxDL/ttOnWbawf9t5zUngPjFHLcLqWlty++869Fd0ucx42U9FCL99KQwjIgjsYwvpUgog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761565666; c=relaxed/simple;
	bh=p17Kucrh7jwU9Xcz2WTV3RzKYOXVG4AExxJcAYner1Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Dl+Y5Ky3kUmA07lAZKm05/UxM4yx10iurh3UbhQjOduDBw34QB7d+49sFGKZLIjcArE415SNBpInzYd2Xoq+FpXWRuDjy6CEnEfbqGmsgie/Z4DzNp2R4jUDn/IC5vwANrR/EQlaeuC1HpuD2UJoa/sbqbIpmmdTpWhWJRk3xBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fu084Giv; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-592f3d2d068so5994833e87.3
        for <linux-pm@vger.kernel.org>; Mon, 27 Oct 2025 04:47:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761565663; x=1762170463; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XupAAXUKcZY4Ejq1lkE3J1vYR4j7xS27b1Ky2ExCNtQ=;
        b=fu084Giv9JZYfwslxWcShsu/ggSh1uh6g3u2ppw9DNg5JJbJBBdLE28d65kQ6aV2oa
         NEA3LdVeg1h7o7NtvJmf8uv2eUKulFZDBT1wnYmwHdoESJpgWtOKXJWWh7y6zfUIHal4
         fzE6atRS3LCspctIRapDzU9I8s0Gznv8LGVmFli4dgq/SJhmZouC8YN4UbwyRMn08gPW
         /rFB5YlFbLBhPPr70Jo3LEN0NHXRJ5M4csnm1WlRgrhMZvoAl0B4fvkH/cIo+pQMyyhT
         hOkpPQ+zeyZVltutyGtS0zkHz3QyvHe3TESIDrEpwBUgJVbnVNKD5WNX5BZqLpcadjBn
         XD2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761565663; x=1762170463;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XupAAXUKcZY4Ejq1lkE3J1vYR4j7xS27b1Ky2ExCNtQ=;
        b=gwuSnnGy+KfZc1aq+w7HF6YrAFb0XUZHFHg3GTWlolhaWp4unTMp1iiQcb54ElFgWw
         S9OG4Y3lRQhWQFXHsOs086N9siIHjchML+tB3FpDpWgNIrKYBKxGjiNCeBV7mjentUQ1
         kj5bt89/uHZxFwIUgQQKPp0a8tEL/grySmNz+M90WriOfghs7tJDs+ugtN14aH2rEgxm
         XZtWvabBj+M/ZGML+DQWeCCgEHF5bPeGNFqNFvZrV/p1BjvxKWh1pkCXMYXEmPJAN/Mi
         Y+GkARZJ+v8qX/jb221u6PDyGgjH/203TqMEctocdxbdVxbrKyWsEdoBzoYeGfjE7o5+
         f/7w==
X-Forwarded-Encrypted: i=1; AJvYcCWfmyKLexP25g2n2pirCeVquyRrkSkPwjgcJ5DxSYDDGn0T0bHWEh46lpiLSoiJrOCUY8Ru2Mut/w==@vger.kernel.org
X-Gm-Message-State: AOJu0YyhRlJSDJOoMQi5yP2l9XyRSH48DbtJQQUPKvaLdJAru2pFPt1E
	UtqLdL77j/VQLPds46CCPP1brExwql9CqmKYsvihbpzCN6qiyhCOPHJX
X-Gm-Gg: ASbGncuGN1A7oxfyz3Pkgjupv1PxlG0G8rwuegsCsFrJU2C8JrOfoRcutAwWvO1yV6G
	jTIFpoRqAxuN4aE6O6+zlTLhkGrvR/wc0ltzqo0Hth+SP7iLUY78RuNroVg7x2PQ4oGQk1i0fn/
	Jt2EySVcK3CisqFoX2q9yZs5br8UmY4DhZJevMc/sCK1t6uLTVv2oAlvJqKEJsWFS/ZAuHAPF7B
	z7iF3t8QAvsVvKJuP4s48iGJLHqgLjDVzniO+9QqYYw1MP8edwxNw70uSGEwKkUm1qG/RZ3z/65
	iQHsvxwPoj7OaZh+k6FGizYUMEG0a88Nb4UqEIe/dHutvntiKcKqpPGPv4ArI1XnsRbu2GSw5u4
	a7vkTPri6eUsMDHtDwhjxcVqAgjxShkEdn3Wja5iHPkc8WF3LMz8b8kuJc/Bk3cqfNr0IAI1OaT
	kU52iNRx0RIAK5kaYY69KhHMZENJv4
X-Google-Smtp-Source: AGHT+IF0uiGlpM6kk7ZEwBzbXbjrIni0QP5Pb+tj9gEs20ZTWYomYLWJR4y14n6ZYim0NyIT01Bxng==
X-Received: by 2002:a05:6512:3c9e:b0:592:f48e:c725 with SMTP id 2adb3069b0e04-592f48ec7c2mr4210260e87.34.1761565662305;
        Mon, 27 Oct 2025 04:47:42 -0700 (PDT)
Received: from mva-rohm ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59301f41ce8sm2331591e87.6.2025.10.27.04.47.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Oct 2025 04:47:41 -0700 (PDT)
Date: Mon, 27 Oct 2025 13:47:38 +0200
From: Matti Vaittinen <mazziesaccount@gmail.com>
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
	Andreas Kemnade <andreas@kemnade.info>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
	linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org,
	linux-rtc@vger.kernel.org
Subject: [PATCH v2 11/15] clk: clk-bd718x7: Support BD72720 clk gate
Message-ID: <f1fbfba7750e151d4b0cb1435433ba079fc4e0af.1761564043.git.mazziesaccount@gmail.com>
References: <cover.1761564043.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="3UxHLcOOARS3Jvq5"
Content-Disposition: inline
In-Reply-To: <cover.1761564043.git.mazziesaccount@gmail.com>


--3UxHLcOOARS3Jvq5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

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
2.51.0


--3UxHLcOOARS3Jvq5
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmj/W9oACgkQeFA3/03a
ocVksgf9FF1OVGzGvP2oM+r+3A6ONb1oRaQM6ReJDB5ubjWlruqoZFYZRhoQoHjd
Rddg3OJCWDRoqDBaWT14glMzHhcZcSSp7vQLnuzhA+1hSk3vWo4iGrSXqaiyHJ8t
zP5bxyqdva4ZsQriXCj4NjOQQYJ4GgmZyzbpS/Is5iyaqJcuQhWpEZeqp1TiYg/h
ykucXcWJsuOry62COifxEvxO7rB15gaFRE3wFDz/DaQo2swBwxbnFPwIiWd0XlI5
hdl6W6WU7mexwHCaI1unre/LIMe+ldjYJbx0o2MGM5j/7Pv/sa5x5MaN4Vg9JXZZ
IdNhK6cw41ZdyLMvLprHtNQ0qB58Cw==
=ZYO/
-----END PGP SIGNATURE-----

--3UxHLcOOARS3Jvq5--

