Return-Path: <linux-pm+bounces-36899-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02B12C0D4AC
	for <lists+linux-pm@lfdr.de>; Mon, 27 Oct 2025 12:52:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ECD7A3A80C8
	for <lists+linux-pm@lfdr.de>; Mon, 27 Oct 2025 11:47:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B39E2FF152;
	Mon, 27 Oct 2025 11:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gN1iBm/a"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 775CF2FDC35
	for <linux-pm@vger.kernel.org>; Mon, 27 Oct 2025 11:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761565628; cv=none; b=GvK/VPyDJyiZ4r1DKDK/TAzhPI6+UHRiSVhnYvAoIoiwoxKszvxx7B46KWeVS9QadBAV67KMKMUT6TuloX6HZNpkIjFKfLQL3zDEhWmRX8fyR744ToQgXFndLkBLMpfLFKTLtt/06mfXw7l4KogbrAa7FpyRzfH/Kl+1qm0M9HA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761565628; c=relaxed/simple;
	bh=KbZYIBikwWSI+GVCWKg5+OPGcA2UgrEFkQgweLtQ6xk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FsA0tTIO/WqNo6gnHRoTctCw8UJMUMB6eYiPlTH2W/V25TP7SvPh3+7eeYRJaTLbQTMJ6wdHKh8QUEMcCKiaoc5AZe541i/fGauMYoM+wEswfWlTNJH3ST+qtAE7BzgFTBgck+DXG6mw0Yb4i5ntAV4Hey+ql6kxR7mDpZwU378=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gN1iBm/a; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-3761e5287c9so54035501fa.2
        for <linux-pm@vger.kernel.org>; Mon, 27 Oct 2025 04:47:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761565623; x=1762170423; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yPhjrYnraGxNN/VaL/O/6qvA4/L6CwleXg/ScEIiVlQ=;
        b=gN1iBm/aT27avoIk/DrZG8G1WrMT7FSaFrGJsRmY3xXQJT/zDpvPTVBzfxjqF+J6En
         pkykq5+eBwgsQR5ujS48JaFusMQrESuHebjrPDO+JfwJ7yBSZFBs0M7v9HbadRgyZtyr
         tvjGzNgcSQcIPURCK7YcjQ1vkbtu5y5XHqiOxqJ4ZRbZj4Pe3TeimAI1uwwWHy8O6uYl
         uQWSizZNparIpxig4ziJ/WAV24OnbnRVRe7MvhUAJ/g4X9uZtZE2pFdagi1G1QLXKxwy
         lFLvFi9PTchxpXLlGuPgwBA4EC0ZUezbxAdVmV7DBl8FjNaLAjEOk+3asKKYAgznwowM
         Tekg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761565623; x=1762170423;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yPhjrYnraGxNN/VaL/O/6qvA4/L6CwleXg/ScEIiVlQ=;
        b=eEyBNlEw6s8Fq+AZm9EeqNrma6Y6XwqRjEosMAx3bKE+8j9Oe5pmGCj+P8JRaaE8kO
         NWRyHHsfsc66/sVAUpPTZHhgw/EeyKTpHw2QdLWx6yHClpY0LaKcMhFgxX6aqZzYqOHo
         kAotSd1pKC3iicsfBGTX4nQrdun4LPF+5XCef2fD0XFL1oQ/SxxMH/OOWAEmtYDsaSSQ
         0PLjskC0JGEzXOdkcJJptB8Spo6mfTqJcnK35Ub1KUB2VudgrvGOouQw+4jcaEPqLvEE
         EKHGchJrRX9kP2OVM+FUKDSfas50GV4mVzQUL3hLM/2lWb7WHzrHxaQSgpnbSrm57YI8
         CiIg==
X-Forwarded-Encrypted: i=1; AJvYcCWS1qjZTCkSW0zayTnJa3be6B2rY+AXgjDshtEOsarsn6rvFe5cKqJAKZ00N4I10q9neM/B2OLJVA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwtDfaX7mUTE2ZNVnUkvMLKHnGD2nCb2xzvnunuYP6g3SWu+jzI
	fCAyzu4bO7spud2lVDIxGgmx7h3HMiVtvJlXy6A5/82/LUO2AaovzE27
X-Gm-Gg: ASbGncvqacqf8S6TflJVsbbWue0zLhZPEbh2RohxAYKkiP6N9RHew9vogP5RAWDcx6g
	bkqm8Z+kfjpK8vFFC4nQgvzVuwscjBzSx4Bz2O77AOmTe98+koBIXTP89ltwwe5CisBcqHeKWbz
	VOiU0CwuGSd8Div4b/7chJgKDGkB+A0jPe5Q3ibmAF9Wn8zWKKsllxgNTYmL7aQYUZ/FoGnAAqT
	m6HZq6aw2+A4CulY2xBW1r+mXNs2OGdr+nR5s+Ia2boXFLeRrv7BYV/DIqjT+8JrmzVzHlGBdnZ
	ottL0yRmi3n/Kb+vGvwyO8hX+cjjWzRiao9ZXYw5puPRelm7HLrtQciH6DgzUqJ0EcP3U2nbCZw
	ZfXps6V6rovviVt+cip142HW78Gym1ZOQJDRbAJepoRG0nBLHTj+6Qxtyvgue3tGyKrZFbQqQFY
	UrBbNsjG0mG1R7VRxw0A==
X-Google-Smtp-Source: AGHT+IFGTBYWCW3ld91Gaf4BxcDyit2xahwuUUbRDChRLg+8atXmQtWwSm/UbdG2xVg1KoE+9y6aEg==
X-Received: by 2002:a05:651c:221f:b0:337:e151:9ec with SMTP id 38308e7fff4ca-377978aeff0mr114706621fa.16.1761565622062;
        Mon, 27 Oct 2025 04:47:02 -0700 (PDT)
Received: from mva-rohm ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-378ee0d3712sm20091881fa.36.2025.10.27.04.47.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Oct 2025 04:47:01 -0700 (PDT)
Date: Mon, 27 Oct 2025 13:46:57 +0200
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
Subject: [PATCH v2 08/15] regulator: bd71828: rename IC specific entities
Message-ID: <aa2b31267e6cc93bad4c823ef1ba07ba43efd572.1761564043.git.mazziesaccount@gmail.com>
References: <cover.1761564043.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="hHlLATUC+NJoLwSU"
Content-Disposition: inline
In-Reply-To: <cover.1761564043.git.mazziesaccount@gmail.com>


--hHlLATUC+NJoLwSU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The new ROHM BD72720 PMIC has similarities with the BD71828. It makes
sense to support the regulator control for both PMICs using the same
driver. It is often more clear to have the IC specific functions and
globals named starting with the chip-name. So, as a preparatory step,
prefix the BD71828 specific functions and globals with the bd71828.

It would be tempting to try also removing the chip ID from those
functions which will be common for both PMICs. I have bad experiences on
this as it tends to lead to problems when yet another IC is being
supported with the same driver, and we will have some functions used for
all, some for two of the three, and some for just one. At this point
I used to start inventing wildcards like BD718XX or BD7272X. This
approach is pretty much always failing as we tend to eventually have
something like BD73900 - where all the wildcard stuff will break down.

So, my approach these days is to:
 - keep the original chip-id prefix for anything that had it already
   (and avoid the churn).
 - use same prefix for all things that are used by multiple ICs -
   typically the chip-ID of the first chip. This typically matches also
   the driver and file names.
 - use specific chip-ID as a prefix for anything which is specific to
   just one chip.

As a preparatory step to adding the BD72720, add bd71828 prefix to all
commonly usable functions and globals.

Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>

---
Revision history:
 RFCv1 =3D>:
 - No changes
No functional changes intended.
---
 drivers/regulator/bd71828-regulator.c | 32 +++++++++++++--------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/drivers/regulator/bd71828-regulator.c b/drivers/regulator/bd71=
828-regulator.c
index dd871ffe979c..3d18dbfdb84e 100644
--- a/drivers/regulator/bd71828-regulator.c
+++ b/drivers/regulator/bd71828-regulator.c
@@ -28,7 +28,7 @@ struct bd71828_regulator_data {
 	int reg_init_amnt;
 };
=20
-static const struct reg_init buck1_inits[] =3D {
+static const struct reg_init bd71828_buck1_inits[] =3D {
 	/*
 	 * DVS Buck voltages can be changed by register values or via GPIO.
 	 * Use register accesses by default.
@@ -40,7 +40,7 @@ static const struct reg_init buck1_inits[] =3D {
 	},
 };
=20
-static const struct reg_init buck2_inits[] =3D {
+static const struct reg_init bd71828_buck2_inits[] =3D {
 	{
 		.reg =3D BD71828_REG_PS_CTRL_1,
 		.mask =3D BD71828_MASK_DVS_BUCK2_CTRL,
@@ -48,7 +48,7 @@ static const struct reg_init buck2_inits[] =3D {
 	},
 };
=20
-static const struct reg_init buck6_inits[] =3D {
+static const struct reg_init bd71828_buck6_inits[] =3D {
 	{
 		.reg =3D BD71828_REG_PS_CTRL_1,
 		.mask =3D BD71828_MASK_DVS_BUCK6_CTRL,
@@ -56,7 +56,7 @@ static const struct reg_init buck6_inits[] =3D {
 	},
 };
=20
-static const struct reg_init buck7_inits[] =3D {
+static const struct reg_init bd71828_buck7_inits[] =3D {
 	{
 		.reg =3D BD71828_REG_PS_CTRL_1,
 		.mask =3D BD71828_MASK_DVS_BUCK7_CTRL,
@@ -102,9 +102,9 @@ static int buck_set_hw_dvs_levels(struct device_node *n=
p,
 	return rohm_regulator_set_dvs_levels(&data->dvs, np, desc, cfg->regmap);
 }
=20
-static int ldo6_parse_dt(struct device_node *np,
-			 const struct regulator_desc *desc,
-			 struct regulator_config *cfg)
+static int bd71828_ldo6_parse_dt(struct device_node *np,
+				 const struct regulator_desc *desc,
+				 struct regulator_config *cfg)
 {
 	int ret, i;
 	uint32_t uv =3D 0;
@@ -212,8 +212,8 @@ static const struct bd71828_regulator_data bd71828_rdat=
a[] =3D {
 			 */
 			.lpsr_on_mask =3D BD71828_MASK_LPSR_EN,
 		},
-		.reg_inits =3D buck1_inits,
-		.reg_init_amnt =3D ARRAY_SIZE(buck1_inits),
+		.reg_inits =3D bd71828_buck1_inits,
+		.reg_init_amnt =3D ARRAY_SIZE(bd71828_buck1_inits),
 	},
 	{
 		.desc =3D {
@@ -253,8 +253,8 @@ static const struct bd71828_regulator_data bd71828_rdat=
a[] =3D {
 			.lpsr_reg =3D BD71828_REG_BUCK2_SUSP_VOLT,
 			.lpsr_mask =3D BD71828_MASK_BUCK1267_VOLT,
 		},
-		.reg_inits =3D buck2_inits,
-		.reg_init_amnt =3D ARRAY_SIZE(buck2_inits),
+		.reg_inits =3D bd71828_buck2_inits,
+		.reg_init_amnt =3D ARRAY_SIZE(bd71828_buck2_inits),
 	},
 	{
 		.desc =3D {
@@ -399,8 +399,8 @@ static const struct bd71828_regulator_data bd71828_rdat=
a[] =3D {
 			.lpsr_reg =3D BD71828_REG_BUCK6_SUSP_VOLT,
 			.lpsr_mask =3D BD71828_MASK_BUCK1267_VOLT,
 		},
-		.reg_inits =3D buck6_inits,
-		.reg_init_amnt =3D ARRAY_SIZE(buck6_inits),
+		.reg_inits =3D bd71828_buck6_inits,
+		.reg_init_amnt =3D ARRAY_SIZE(bd71828_buck6_inits),
 	},
 	{
 		.desc =3D {
@@ -440,8 +440,8 @@ static const struct bd71828_regulator_data bd71828_rdat=
a[] =3D {
 			.lpsr_reg =3D BD71828_REG_BUCK7_SUSP_VOLT,
 			.lpsr_mask =3D BD71828_MASK_BUCK1267_VOLT,
 		},
-		.reg_inits =3D buck7_inits,
-		.reg_init_amnt =3D ARRAY_SIZE(buck7_inits),
+		.reg_inits =3D bd71828_buck7_inits,
+		.reg_init_amnt =3D ARRAY_SIZE(bd71828_buck7_inits),
 	},
 	{
 		.desc =3D {
@@ -633,7 +633,7 @@ static const struct bd71828_regulator_data bd71828_rdat=
a[] =3D {
 			 * LDO6 only supports enable/disable for all states.
 			 * Voltage for LDO6 is fixed.
 			 */
-			.of_parse_cb =3D ldo6_parse_dt,
+			.of_parse_cb =3D bd71828_ldo6_parse_dt,
 		},
 	}, {
 		.desc =3D {
--=20
2.51.0


--hHlLATUC+NJoLwSU
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmj/W7EACgkQeFA3/03a
ocXFRAf/X2TvPapTD+az8EHYbCCnjJcIvHuUfnEQlERv5ijnP0Gl1KSmtaVPlpvl
VEVmc5eK8QfVVA8akUmsAFtEQ17BUXteFoPdjVb37GJGuyW+tH+R4GpNKRXbpsPT
kxqHs/o5fxk7ESJZhWCSErb1jZyKhuluMo8331A00dHZW9zGIielOf/2Cs8eoxMf
tF4+VUmvy/nfAGhfOyfvPy7WLouZFhQdgUI/u7KhsibBAlIBjVrWz2pcXsCAx2qu
dtxESaLBV3H3wleVqN84Hxhiok+cPhW8tz85MtBhBxHT7tNbM+QjUe/jHxk2GnOM
5t6EpGBTVdq0zs4EwAkPzUE5uFCr2Q==
=9ybE
-----END PGP SIGNATURE-----

--hHlLATUC+NJoLwSU--

