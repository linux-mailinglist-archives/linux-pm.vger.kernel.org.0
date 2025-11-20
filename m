Return-Path: <linux-pm+bounces-38277-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id EBF8FC72D0B
	for <lists+linux-pm@lfdr.de>; Thu, 20 Nov 2025 09:26:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D2C734EB5A9
	for <lists+linux-pm@lfdr.de>; Thu, 20 Nov 2025 08:24:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0466730CDB5;
	Thu, 20 Nov 2025 08:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="o3Xmgs1s"
X-Original-To: linux-pm@vger.kernel.org
Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C904430CDB8;
	Thu, 20 Nov 2025 08:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763626870; cv=none; b=ZQmLFyXZAv16U8ex26y/eiNYI0qcHZTMBtcyJwjsrBHkR5D/mgo8ogUOQwo7fDh5ChXKDEpF140PjRfmkWcDjIMfhzEosJpFL0V2A0CCA41ZUIn6C7VcHCEz38EzbTpklA5+bBpfbmjNsBX7ktwNko/OENItieTo2W/7WGq2Keg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763626870; c=relaxed/simple;
	bh=SAIK4onV8NTmzjrV3+g9HnR/iW2xGpENY9MfzhjMtXk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oPRoHey1Y5eoSWLlkVk7suqlrIPTmJoCs5QUXHE9YrAVpYN/PpMM0M+0V7zBbFHZI3ke4JtgZtP/5bsYAqFOLndoAnt7T9sd+ePJmraqtpHCJibOqd+kml+6YFqWwIt4seZOYCa6mVHvaL1p2I9H1lgj0mNlUfbUAlabK8aqqNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=o3Xmgs1s; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 20 Nov 2025 10:20:59 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1763626866; h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:in-reply-to:in-reply-to:  references:references;
	bh=DY0I0MLM0BsoV116nrWGTYdPME77o4JzIUFhcQ+5Hkg=;
	b=o3Xmgs1s/Sd0VMTm3+aAMhVtDAQ77vtBRDlFm7a3Rl10hwTIAUPfvErSa6ySnlJEWxD+IM
	ASZEshI7XOmBk5TLw7EhaYPFiVNm/ZX4GsrHB5wIIDdNesfEILJk4PkX+AS5gRBSB6ZQt8
	pYU3egu0ETJbQFagEqVhCpxh+9apjqE=
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
Subject: [PATCH v5 06/16] dt-bindings: leds: bd72720: Add BD72720
Message-ID: <b12e7484fe4682caf08e6ffbd3f9f16ee091ef60.1763625920.git.mazziesaccount@gmail.com>
Reply-To: Matti Vaittinen <mazziesaccount@gmail.com>
References: <cover.1763625920.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="9Y07DckTc/eWPOBV"
Content-Disposition: inline
In-Reply-To: <cover.1763625920.git.mazziesaccount@gmail.com>
X-Migadu-Flow: FLOW_OUT


--9Y07DckTc/eWPOBV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

=46rom: Matti Vaittinen <mazziesaccount@gmail.com>

Add the ROHM BD72720 documentation to the binding documents.

Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
Revision history:
 RFCv1 =3D>:
 - No changes

NOTE: The Linux LED driver does currently have: values
bd72720-grnled and bd72720-ambled for the rohm,led-compatible. These are
handled identically to the existing bd71828-grnled and bd71828-ambled
and should be removed from the driver. Thus they are not documented in
the binding document.

Furthermore, the BD72720 Linux driver does not use the compatible property
=66rom the LED node. The Linux driver is load and probed based on the PMIC
compatible in the MFD node. Thus no compatible string for the BD72720
LED node is added.
---
 .../devicetree/bindings/leds/rohm,bd71828-leds.yaml        | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/leds/rohm,bd71828-leds.yaml =
b/Documentation/devicetree/bindings/leds/rohm,bd71828-leds.yaml
index b7a3ef76cbf4..64cc40523e3d 100644
--- a/Documentation/devicetree/bindings/leds/rohm,bd71828-leds.yaml
+++ b/Documentation/devicetree/bindings/leds/rohm,bd71828-leds.yaml
@@ -10,11 +10,12 @@ maintainers:
   - Matti Vaittinen <mazziesaccount@gmail.com>
=20
 description: |
-  This module is part of the ROHM BD71828 MFD device. For more details
-  see Documentation/devicetree/bindings/mfd/rohm,bd71828-pmic.yaml.
+  This module is part of the ROHM BD71828 and BD72720 MFD device. For more
+  details see Documentation/devicetree/bindings/mfd/rohm,bd71828-pmic.yaml
+  and Documentation/devicetree/bindings/mfd/rohm,bd72720-pmic.yaml
=20
   The LED controller is represented as a sub-node of the PMIC node on the =
device
-  tree.
+  tree. This should be located under "leds" - node in PMIC node.
=20
   The device has two LED outputs referred as GRNLED and AMBLED in data-she=
et.
=20
--=20
2.51.1


--9Y07DckTc/eWPOBV
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmkez2sACgkQeFA3/03a
ocXrfwf+P2Fo0gYFUOjXb9C8VFRw2zP6flH5bVrzPvgz7XxG1EZDNNNeVYzPDw6b
fjnOCsGMl/ePMuKA0ZGVMvIFDm+cb7aVc5U6mLNngz1DfJgLMvHcoRTXd+NVmKc9
aFL0odEexLnKLKOy+YFkm6O6tf8FRoYwQApQo0axbES20d9EUTz1GHB4jX4RGKHu
BxexDo+AQOHtDEC+evH5p5HgEUASikE9mJwE3uJwhnonS0rYhu2PU49wZbTp7ZkH
082OGtZRPkjP3jrD1kEvhUZRfmlEgXYbyr5d7aW3ceCaojvikZdcdODNEldPPiX6
p2dkICQ2o2lATCZ3UJWXTvjC3oeOow==
=PQ0n
-----END PGP SIGNATURE-----

--9Y07DckTc/eWPOBV--

