Return-Path: <linux-pm+bounces-37409-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E2EDDC34488
	for <lists+linux-pm@lfdr.de>; Wed, 05 Nov 2025 08:40:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 68B5718C7A64
	for <lists+linux-pm@lfdr.de>; Wed,  5 Nov 2025 07:38:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C96A12D640A;
	Wed,  5 Nov 2025 07:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="MPNt23By"
X-Original-To: linux-pm@vger.kernel.org
Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E74162D5951;
	Wed,  5 Nov 2025 07:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762328255; cv=none; b=EYZQetshSR6Wx/Zp8ljqZdAuai+craA0552eAI96weLU8HHboceCKHTUvW93j1q5adpP6I1pbNybb0qnBwV3syR74eAoIhbQbdT9BiRedCLuXNn+4qKp9LHcV+XVlmP5VOP5SS2xZ32TaBQ+w7hGlicDn3expnOS90HsKsierO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762328255; c=relaxed/simple;
	bh=2SNBbl4uqAo+ET205eFZkYDH2ha3w6x3P3D8TBf10WU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pQixbhAzbH848+axX5SHymcSi5bVv6+rtPKHL1soe09rWreF4z9G3ZBY9l4nNrs0H75mt0ZRe4Zzh+GQzxvLWhMtcaoNGL5zwROVYfoE7H5zk3rWFJ8eXBQr+xJ/x/j+8fj4F0/loY0A+9ooZo1YM0BUx0odOfxZl7fJDHoyBs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=MPNt23By; arc=none smtp.client-ip=95.215.58.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 5 Nov 2025 09:37:24 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1762328251; h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:in-reply-to:in-reply-to:  references:references;
	bh=6DcjZe/wKz0qadogO2dEDdbu0gnUgU4igGSav5nTTps=;
	b=MPNt23ByNPEufFcHNkGVJOmIsKRa4K5e9Ur7QOiNPwBhBFgf/amBCpQ3rzEi8B575h11vk
	udPIXKEIaraa8rJ4Y38ayomYYRaMD1Us5MQ3pcGHgnwB7i1TLtk+HqZB+TaOLOEe6LRyN3
	wZAY2O/AYtWN+IAJFesqkvpKL02iZwI=
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
Subject: [PATCH v3 06/16] dt-bindings: leds: bd72720: Add BD72720
Message-ID: <4515f6af55781b7036424186fe49d20ad8344cf5.1762327887.git.mazziesaccount@gmail.com>
Reply-To: Matti Vaittinen <mazziesaccount@gmail.com>
References: <cover.1762327887.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="frj4p5+2nMyBVptR"
Content-Disposition: inline
In-Reply-To: <cover.1762327887.git.mazziesaccount@gmail.com>
X-Migadu-Flow: FLOW_OUT


--frj4p5+2nMyBVptR
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
2.51.0


--frj4p5+2nMyBVptR
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmkK/rQACgkQeFA3/03a
ocU+ewgAjy5YvDhS0teEaJMH/HT4WwsxoXVHboi68WHpjbB/t/rtYl7eOtghni2N
AzoZT1uKzlFFhR0WkEgODlmaqdlaq0N/f+zvCQt+/+GW8V/XDYYUUjWZ0rQod4Sf
5t0dTqFM7jXgEhQAUkRgPUPsXp2h5DzBgw7fFeJXzfv3vwYQ+3Lht7lheb20rB0t
k5RHh3JI1q6DBAsqBqJ3sJ7u4kMwWVWm1r5Azm3xA/L95aR1eEv57DdPP0+xbT8c
KflIJITSVMR/cAaA5xFvbVXalq1QsSx+PXHfBqwDT+03htXMKz7rd49HZO9ebU/m
L2IWedyOrz5AyEv3RVSerOJe8sgG3w==
=+leS
-----END PGP SIGNATURE-----

--frj4p5+2nMyBVptR--

