Return-Path: <linux-pm+bounces-35772-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id DF4C6BC0AF3
	for <lists+linux-pm@lfdr.de>; Tue, 07 Oct 2025 10:37:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C02044F4569
	for <lists+linux-pm@lfdr.de>; Tue,  7 Oct 2025 08:37:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ABCD2D7802;
	Tue,  7 Oct 2025 08:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GvtEzi7L"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BD982D781F
	for <linux-pm@vger.kernel.org>; Tue,  7 Oct 2025 08:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759826031; cv=none; b=YRnJK+/qFXcA9+WZl5S+ULKXuTchy15o/oXmO1WVCdatl/ICQtM0HxwOW4/0Xwmzdnt9nDA/NSD2UWh1cAxbzL5GhkuPO8v9Mq8at3o+ELg5wwTDmItdLlLTMs+gEeLM9NnOSEnKm6cXJ+7XemDt3jGpLOuszCWm6JSfcBu7504=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759826031; c=relaxed/simple;
	bh=1iY8dgK/r7VYOZvJEas2P75fHwdABfTnDJv6B71gZwo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o5ywlCcLKy5gfjdoF9Ei2Vw56cC3kaku91byGIIrYX5oDpkAehf1CL91p8QPjvG0t+MLin2lSGxVhxSGxknHAcgD61ZHjzd6YEJl7v9Ly2o05G3cXDO6o24VJVnvfpwQtXjVREdelPNSiazhQHQkBTROX3Y4LRDgEFdxbA3cAzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GvtEzi7L; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-57bd04f2e84so6732889e87.1
        for <linux-pm@vger.kernel.org>; Tue, 07 Oct 2025 01:33:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759826027; x=1760430827; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=56U4cHXm/XO+yZsN8UYLacC0NRz5ruIRpTT3AQstYVU=;
        b=GvtEzi7LO++FCpXY5Pwj6ebSKH/tNsC43rHTbEjrKqP9pbyRAfftAvC/UXWEtYd2br
         tnTvfmfAhtXi6sbjedf+dxL3BW3VDl29qv1VzlLq59hYB6TtF+QD6ovw/exd621bMXir
         EZ3rJwkIMKpK0cbzuZv9VAlxXybRJ6iGTSs3qj5GofZ7aAqEsAAl0twjRFz8Z6hvHpoI
         ElJuWOHKQ6wgPA76saqaP066ZYmuFx5JOVN7xn1zahPLdvBhuKiKacQz64LF4d/UQYqf
         e2V3rJo3Z5jHjwLaYEUMOUfhGcqboT1Outv1Pl1NDP+bp/IsD6kNOZcTnjPZWXGjoLfz
         Xwig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759826027; x=1760430827;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=56U4cHXm/XO+yZsN8UYLacC0NRz5ruIRpTT3AQstYVU=;
        b=VWaYt8/ZjFn+hCNmdFwbKUpYdV0zCj0XVKbSUQ2ARY66876vk1E95pOz2GOQkF6JrM
         DdKXxmPA+M+ZE+X0C9GUhpXbMRwuwcnmRkxWXBFf0rh8dW4TALdzk0euvDtCP/1uTcDU
         etpZvNjzR82NjN2J3Z5ERu28cg6CUHbD0HmdekfUPntZmW0D3t6q9x4A6ak0kupO+b1G
         DTvVeoSykE/MZnJjuwjPifGhhdqb6ygljs58Rh1oAwIy0UCazRvcUoG0Lo2Kp6niezag
         8nrwpKcH+GOguy8jxsdHsHZyRrK+yOzNUcsrJpk9I86dV3o6CdD5Y9O55FmJPQSKFwoW
         0YLg==
X-Forwarded-Encrypted: i=1; AJvYcCXT0gQm/KT7rzzapptD0LqnpOyEWB1UDAwYurgaCtiwLqQXMA8+IL8e+2cZ6LWCMgvm3MHqo1WqSA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+JT+SJo97BqElMSQVjak9DcTm0mbMczjx9IfejrPSM9NixR9r
	9vb/u/HYhE/rqiBDJm8gbvmqsow70v9lD/H97ei6cuN3lnUUoNd36KeE
X-Gm-Gg: ASbGnctZku8zhMMU93SJMHQEInq2kYEzpd55EpE/5VpP22ncWIuqe1OuzPNNxbVwEDw
	DShQ7TlrjMxZ4Ke1YXwDT4/jAqzlEpxrmY3S3OGBrXz26tCBvWgoM36LCZ1qDygl8AKjcF+3S0J
	BC1PUw6Rqe5IkEdreDRQlc/xPy8HlGW87r5HoKXekSiHO8uJuTfZ79B8FgGe9AViwL4qAlULOji
	zSKeOmvh5WwLVN2dlz6guiSp+CdutMVttXvU3VLbwoc2udbve6aFT+utgXLrGwn0KCyZ41zi6eq
	1L0sj5yeibTqwTZc5PebP32k/KhsMF6x4h3BycfCeez9cXFEw6VxZlXQl/wjYuewkj11OegDF3c
	lh2krzmWFtsKgtCOn3Qxs6Xiz3oH0gNK2uFArttFkhRrzyGueqOCPHA==
X-Google-Smtp-Source: AGHT+IFPlR5J0y/lc2XUcE6O1X+JtlZJeu/GYYDJksj4es7AGQByzJg+EaWCHdJkoi6q7phUr464xA==
X-Received: by 2002:a05:6512:39d4:b0:57e:7040:9c77 with SMTP id 2adb3069b0e04-58cbba0232bmr5051448e87.38.1759826027136;
        Tue, 07 Oct 2025 01:33:47 -0700 (PDT)
Received: from mva-rohm ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-58b0112480fsm5865665e87.21.2025.10.07.01.33.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Oct 2025 01:33:45 -0700 (PDT)
Date: Tue, 7 Oct 2025 11:33:42 +0300
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
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	Andreas Kemnade <andreas@kemnade.info>, linux-leds@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org, linux-gpio@vger.kernel.org
Subject: [RFC PATCH 05/13] dt-bindings: leds: bd72720: Add BD72720
Message-ID: <52a4df1a12f6b480150187d956d0fcd57fe626d1.1759824376.git.mazziesaccount@gmail.com>
References: <cover.1759824376.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Hl5GOwGd5SzFL3hD"
Content-Disposition: inline
In-Reply-To: <cover.1759824376.git.mazziesaccount@gmail.com>


--Hl5GOwGd5SzFL3hD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Add the ROHM BD72720 documentation to the binding documents.

Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
---

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


--Hl5GOwGd5SzFL3hD
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmjk0GYACgkQeFA3/03a
ocWo9ggAj4GBq9go42smGGQBwidPKeFC80081lry80AjjqdeBzWn8ydINnkvdFVU
OboKgpob0WwNIuyoripCr55U0emX7Pdg/SN9pMPanh2oWvN1A3dZLfPW07smIpfC
jv0WPOIeBqCOfjNRbriaGHx3mGlfjcYEJrt4TMb8JlHJpvYRMDjNzDoGI3oUGEgR
lqnXCPRgb76A+OT1Gnx9zDwm8p2PpVpOnutdlxQ3JtLKpH2XjKUqQM9RhOqJ7hme
ElMvS16kznuAMzBGKD5ByXcYOlFaQlg2d8IMcnUM7W9PmkVKEzoeqfE4XHZN8ljy
RW+XE1gvB9Lc2j88vgeXM9rMxGO0jw==
=CW2a
-----END PGP SIGNATURE-----

--Hl5GOwGd5SzFL3hD--

